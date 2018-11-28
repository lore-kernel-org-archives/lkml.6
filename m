Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF3EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE329206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE329206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeK2IIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:08:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46646 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2IIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:08:46 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B60D8207BD; Wed, 28 Nov 2018 22:05:47 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8298A206FF;
        Wed, 28 Nov 2018 22:05:47 +0100 (CET)
Date:   Wed, 28 Nov 2018 22:05:47 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 01/21] nvmem: Mark nvmem_type_str array with
 __maybe_unused
Message-ID: <20181128210547.GI8952@piout.net>
References: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com>
 <20181128190537.14074-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181128190537.14074-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2018 21:05:17+0200, Andy Shevchenko wrote:
> Since we put static variable to a header file it's copied to each module
> that includes the header. But not all of them are actually using it.
> 
> Mark nvmem_type_str array with __maybe_unused to make a compiler happy:
> 
> In file included from include/linux/rtc.h:18,
>                  from drivers/rtc/rtc-proc.c:15:
> include/linux/nvmem-provider.h:29:27: warning: ‘nvmem_type_str’ defined but not used [-Wunused-const-variable=]
>  static const char * const nvmem_type_str[] = {
>                            ^~~~~~~~~~~~~~
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/nvmem-provider.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 00ff92571683..e33919ddb026 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -26,7 +26,7 @@ enum nvmem_type {
>  	NVMEM_TYPE_BATTERY_BACKED,
>  };
>  
> -static const char * const nvmem_type_str[] = {
> +static const __maybe_unused char * const nvmem_type_str[] = {

Hum, it is probably better to move the array to nvmem/core.c. I should
have done that from the beginning.

>  	[NVMEM_TYPE_UNKNOWN] = "Unknown",
>  	[NVMEM_TYPE_EEPROM] = "EEPROM",
>  	[NVMEM_TYPE_OTP] = "OTP",
> -- 
> 2.19.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
