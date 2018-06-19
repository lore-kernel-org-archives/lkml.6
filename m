Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174ABC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AFA204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AFA204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937623AbeFSNbf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:31:35 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:42572 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753145AbeFSNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:31:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C7D935B21;
        Tue, 19 Jun 2018 13:31:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: event66_d2269e4a862b
X-Filterd-Recvd-Size: 9592
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 13:31:30 +0000 (UTC)
Message-ID: <53ed025e7f188c931b99f83066457b2266e69cd6.camel@perches.com>
Subject: Re: [PATCH 2/6] device: Add #define dev_fmt similar to #define
 pr_fmt
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jun 2018 06:31:28 -0700
In-Reply-To: <3f213f4f9ee604c1797af67360d8da1836b34271.1525878372.git.joe@perches.com>
References: <cover.1525878372.git.joe@perches.com>
         <3f213f4f9ee604c1797af67360d8da1836b34271.1525878372.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg?  Ping?

The patches to impi have hit -next and the impi code
works differently without this patch.


On Wed, 2018-05-09 at 08:15 -0700, Joe Perches wrote:
> Add a prefixing macro to dev_<level> uses similar to the pr_fmt
> prefixing macro used in pr_<level> calls.
> 
> This can help avoid some string duplication in dev_<level> uses.
> 
> The default, like pr_fmt, is an empty #define dev_fmt(fmt) fmt
> 
> Rename the existing dev_<level> functions to _dev_<level> and
> introduce #define dev_<level> _dev_<level> macros that use the
> new #define dev_fmt
> 
> Miscellanea:
> 
> o Consistently use #defines with fmt, ... and ##__VA_ARGS__
> o Remove unnecessary externs
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/base/core.c    |  12 +++---
>  include/linux/device.h | 103 ++++++++++++++++++++++++++++---------------------
>  2 files changed, 64 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ad7b50897bcc..9c87a41cef82 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2985,12 +2985,12 @@ void func(const struct device *dev, const char *fmt, ...)	\
>  }								\
>  EXPORT_SYMBOL(func);
>  
> -define_dev_printk_level(dev_emerg, KERN_EMERG);
> -define_dev_printk_level(dev_alert, KERN_ALERT);
> -define_dev_printk_level(dev_crit, KERN_CRIT);
> -define_dev_printk_level(dev_err, KERN_ERR);
> -define_dev_printk_level(dev_warn, KERN_WARNING);
> -define_dev_printk_level(dev_notice, KERN_NOTICE);
> +define_dev_printk_level(_dev_emerg, KERN_EMERG);
> +define_dev_printk_level(_dev_alert, KERN_ALERT);
> +define_dev_printk_level(_dev_crit, KERN_CRIT);
> +define_dev_printk_level(_dev_err, KERN_ERR);
> +define_dev_printk_level(_dev_warn, KERN_WARNING);
> +define_dev_printk_level(_dev_notice, KERN_NOTICE);
>  define_dev_printk_level(_dev_info, KERN_INFO);
>  
>  #endif
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 563077d1cdc1..49c6b5d6a9f8 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1306,30 +1306,34 @@ struct device_link *device_link_add(struct device *consumer,
>  				    struct device *supplier, u32 flags);
>  void device_link_del(struct device_link *link);
>  
> +#ifndef dev_fmt
> +#define dev_fmt(fmt) fmt
> +#endif
> +
>  #ifdef CONFIG_PRINTK
>  
> -extern __printf(3, 0)
> +__printf(3, 0)
>  int dev_vprintk_emit(int level, const struct device *dev,
>  		     const char *fmt, va_list args);
> -extern __printf(3, 4)
> +__printf(3, 4)
>  int dev_printk_emit(int level, const struct device *dev, const char *fmt, ...);
>  
> -extern __printf(3, 4)
> +__printf(3, 4)
>  void dev_printk(const char *level, const struct device *dev,
>  		const char *fmt, ...);
> -extern __printf(2, 3)
> -void dev_emerg(const struct device *dev, const char *fmt, ...);
> -extern __printf(2, 3)
> -void dev_alert(const struct device *dev, const char *fmt, ...);
> -extern __printf(2, 3)
> -void dev_crit(const struct device *dev, const char *fmt, ...);
> -extern __printf(2, 3)
> -void dev_err(const struct device *dev, const char *fmt, ...);
> -extern __printf(2, 3)
> -void dev_warn(const struct device *dev, const char *fmt, ...);
> -extern __printf(2, 3)
> -void dev_notice(const struct device *dev, const char *fmt, ...);
> -extern __printf(2, 3)
> +__printf(2, 3)
> +void _dev_emerg(const struct device *dev, const char *fmt, ...);
> +__printf(2, 3)
> +void _dev_alert(const struct device *dev, const char *fmt, ...);
> +__printf(2, 3)
> +void _dev_crit(const struct device *dev, const char *fmt, ...);
> +__printf(2, 3)
> +void _dev_err(const struct device *dev, const char *fmt, ...);
> +__printf(2, 3)
> +void _dev_warn(const struct device *dev, const char *fmt, ...);
> +__printf(2, 3)
> +void _dev_notice(const struct device *dev, const char *fmt, ...);
> +__printf(2, 3)
>  void _dev_info(const struct device *dev, const char *fmt, ...);
>  
>  #else
> @@ -1347,26 +1351,26 @@ static inline void __dev_printk(const char *level, const struct device *dev,
>  {}
>  static inline __printf(3, 4)
>  void dev_printk(const char *level, const struct device *dev,
> -		const char *fmt, ...)
> +		 const char *fmt, ...)
>  {}
>  
>  static inline __printf(2, 3)
> -void dev_emerg(const struct device *dev, const char *fmt, ...)
> +void _dev_emerg(const struct device *dev, const char *fmt, ...)
>  {}
>  static inline __printf(2, 3)
> -void dev_crit(const struct device *dev, const char *fmt, ...)
> +void _dev_crit(const struct device *dev, const char *fmt, ...)
>  {}
>  static inline __printf(2, 3)
> -void dev_alert(const struct device *dev, const char *fmt, ...)
> +void _dev_alert(const struct device *dev, const char *fmt, ...)
>  {}
>  static inline __printf(2, 3)
> -void dev_err(const struct device *dev, const char *fmt, ...)
> +void _dev_err(const struct device *dev, const char *fmt, ...)
>  {}
>  static inline __printf(2, 3)
> -void dev_warn(const struct device *dev, const char *fmt, ...)
> +void _dev_warn(const struct device *dev, const char *fmt, ...)
>  {}
>  static inline __printf(2, 3)
> -void dev_notice(const struct device *dev, const char *fmt, ...)
> +void _dev_notice(const struct device *dev, const char *fmt, ...)
>  {}
>  static inline __printf(2, 3)
>  void _dev_info(const struct device *dev, const char *fmt, ...)
> @@ -1375,27 +1379,36 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
>  #endif
>  
>  /*
> - * Stupid hackaround for existing uses of non-printk uses dev_info
> - *
> - * Note that the definition of dev_info below is actually _dev_info
> - * and a macro is used to avoid redefining dev_info
> + * #defines for all the dev_<level> macros to prefix with whatever
> + * possible use of #define dev_fmt(fmt) ...
>   */
>  
> -#define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
> +#define dev_emerg(dev, fmt, ...)					\
> +	_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> +#define dev_crit(dev, fmt, ...)						\
> +	_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__)
> +#define dev_alert(dev, fmt, ...)					\
> +	_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__)
> +#define dev_err(dev, fmt, ...)						\
> +	_dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
> +#define dev_warn(dev, fmt, ...)						\
> +	_dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
> +#define dev_notice(dev, fmt, ...)					\
> +	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
> +#define dev_info(dev, fmt, ...)						\
> +	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
>  
>  #if defined(CONFIG_DYNAMIC_DEBUG)
> -#define dev_dbg(dev, format, ...)		     \
> -do {						     \
> -	dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
> -} while (0)
> +#define dev_dbg(dev, fmt, ...)						\
> +	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>  #elif defined(DEBUG)
> -#define dev_dbg(dev, format, arg...)		\
> -	dev_printk(KERN_DEBUG, dev, format, ##arg)
> +#define dev_dbg(dev, fmt, ...)						\
> +	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
>  #else
> -#define dev_dbg(dev, format, arg...)				\
> -({								\
> -	if (0)							\
> -		dev_printk(KERN_DEBUG, dev, format, ##arg);	\
> +#define dev_dbg(dev, fmt, ...)						\
> +({									\
> +	if (0)								\
> +		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>  })
>  #endif
>  
> @@ -1467,7 +1480,7 @@ do {									\
>  	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
>  	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
>  	    __ratelimit(&_rs))						\
> -		__dynamic_dev_dbg(&descriptor, dev, fmt,		\
> +		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
>  				  ##__VA_ARGS__);			\
>  } while (0)
>  #elif defined(DEBUG)
> @@ -1477,23 +1490,23 @@ do {									\
>  				      DEFAULT_RATELIMIT_INTERVAL,	\
>  				      DEFAULT_RATELIMIT_BURST);		\
>  	if (__ratelimit(&_rs))						\
> -		dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__);	\
> +		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>  } while (0)
>  #else
>  #define dev_dbg_ratelimited(dev, fmt, ...)				\
>  do {									\
>  	if (0)								\
> -		dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__);	\
> +		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>  } while (0)
>  #endif
>  
>  #ifdef VERBOSE_DEBUG
>  #define dev_vdbg	dev_dbg
>  #else
> -#define dev_vdbg(dev, format, arg...)				\
> -({								\
> -	if (0)							\
> -		dev_printk(KERN_DEBUG, dev, format, ##arg);	\
> +#define dev_vdbg(dev, fmt, ...)						\
> +({									\
> +	if (0)								\
> +		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>  })
>  #endif
>  
