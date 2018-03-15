Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3162421-1521081218-2-12114296797917560439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521081217; b=f99KVgTGjj69XNPSV5X5ZX7rKOIfJ3KysCtalrdNbWOAPTr
    DOKguRdq49ifReWOZrO7GpjLTyYVYzsbquX+vhXSdcPqNXfA4Drxq3Lx4uc9HpXg
    shw6V5TbQZC7cM3Mz33fZYwt55Ik2LRqKHhNbjRsaqUsik934T+ba3+kSYl6Bksx
    hkPPRq/rjewhrWbCeycEcfm4JKY2lxwLFpuTC+Q5TtNSYesoK3hTzXVrlkf/6g9Z
    +8EFFzqGxwGWw/Z3OcKC87dL29q2zU4jJhic+qBApix3MOIiusSo1qAxY8abeuZs
    Wh1mUWOrdETRETg3uIRtBpwZcH6mezlJmALDwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521081217; bh=WfnIfUgICW0g3XfIWLR3xp3dPW1+Y3++bOetOKh5NMg=; b=r
    KOaz9A1RDbPjJUCC4pvhBhtXGQYBlRIrZhKKZAh1oxEtbbZtx7iFLY2/LbpjsNUu
    g3cRN4PW/ySgF80AccYpO4+IqV7onP3xO/zeTWP9F4ZeitrK7CyMBocK3mkTidjM
    SI4lvydm6ZEgb23dhuTEWldEkdpIraEnD5rvH/0EaQONIjMs67UwX3g7b2aYg4eU
    +WD0oui9O9DFypp3xqhqZz1BW1mlPqOqfjV2r4HWXH1GVv4rthbAuJ/wpWtkPdhR
    GzzVxaby/P6yzHzMJvJr7y+TeUodKuEUcJ1Nu1b+MnSJ+/yNRWTEb/dcJlEz6WHk
    CPrkENyr6Kd4IKMsZL6kA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=WfBeJ//H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=WfBeJ//H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeCOCdg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 22:33:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45344 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeCOCde (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 22:33:34 -0400
Subject: Re: [PATCH v2] earlycon: Fix __earlycon_table stride... again
To: Daniel Kurtz <djkurtz@chromium.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>
Cc: adurbin@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES"
        <linux-arch@vger.kernel.org>
References: <20180315014817.142930-1-djkurtz@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <398eebd9-9ec9-50ef-88ea-c3d5ae9f5d90@infradead.org>
Date: Wed, 14 Mar 2018 19:33:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315014817.142930-1-djkurtz@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/14/2018 06:48 PM, Daniel Kurtz wrote:
> Commit 470ca0de69fe ("serial: earlycon: Enable earlycon without command
> line param") added EARLYCON_TABLE().
> 
> Commit 99492c39f39f ("earlycon: Fix __earlycon_table stride") referenced
> commit 07fca0e57fca92 ("tracing: Properly align linker defined symbols")
> and tried to fix EARLYCON_TABLE() using __aligned(32).
> 
> However, the fix copied just works around compiler behavior.  In fact, it
> was subsequently re-implemented for tracing using a table of pointers in
> commit 3d56e331b653 ("tracing: Replace syscall_meta_data struct array with
> pointer array"), commit 654986462939 ("tracepoints: Fix section alignment
> using pointer array") and commit e4a9ea5ee7c8 ("tracing: Replace
> trace_event struct array with pointer array").
> 
> Let's do the same "array of pointers to structs" approach for
> EARLYCON_TABLE.

Please describe what the problem is instead of just what the fix is.
Thanks.

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> Changes since v1:
>  * Change __earlycon_table to an array of pointers.
> 
> Note: I do not have a convenient system to test the of/fdt.c part of this
> patch, so would apreciate help verifying it.  Thanks!
> 
>  drivers/of/fdt.c                  |  7 +++++--
>  drivers/tty/serial/earlycon.c     |  6 ++++--
>  include/asm-generic/vmlinux.lds.h |  2 +-
>  include/linux/serial_core.h       | 21 ++++++++++++++-------
>  4 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 84aa9d676375..6da20b9688f7 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -942,7 +942,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
>  	int offset;
>  	const char *p, *q, *options = NULL;
>  	int l;
> -	const struct earlycon_id *match;
> +	const struct earlycon_id **p_match;
>  	const void *fdt = initial_boot_params;
>  
>  	offset = fdt_path_offset(fdt, "/chosen");
> @@ -969,7 +969,10 @@ int __init early_init_dt_scan_chosen_stdout(void)
>  		return 0;
>  	}
>  
> -	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
> +	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
> +	     p_match++) {
> +		const struct earlycon_id *match = *p_match;
> +
>  		if (!match->compatible[0])
>  			continue;
>  
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a24278380fec..22683393a0f2 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -169,7 +169,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
>   */
>  int __init setup_earlycon(char *buf)
>  {
> -	const struct earlycon_id *match;
> +	const struct earlycon_id **p_match;
>  
>  	if (!buf || !buf[0])
>  		return -EINVAL;
> @@ -177,7 +177,9 @@ int __init setup_earlycon(char *buf)
>  	if (early_con.flags & CON_ENABLED)
>  		return -EALREADY;
>  
> -	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
> +	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
> +	     p_match++) {
> +		const struct earlycon_id *match = *p_match;
>  		size_t len = strlen(match->name);
>  
>  		if (strncmp(buf, match->name, len))
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1ab0e520d6fc..e17de55c2542 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -179,7 +179,7 @@
>  #endif
>  
>  #ifdef CONFIG_SERIAL_EARLYCON
> -#define EARLYCON_TABLE() STRUCT_ALIGN();			\
> +#define EARLYCON_TABLE() . = ALIGN(8);				\
>  			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
>  			 KEEP(*(__earlycon_table))		\
>  			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b32df49a3bd5..93b7add47087 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -351,10 +351,10 @@ struct earlycon_id {
>  	char	name[16];
>  	char	compatible[128];
>  	int	(*setup)(struct earlycon_device *, const char *options);
> -} __aligned(32);
> +};
>  
> -extern const struct earlycon_id __earlycon_table[];
> -extern const struct earlycon_id __earlycon_table_end[];
> +extern const struct earlycon_id *__earlycon_table[];
> +extern const struct earlycon_id *__earlycon_table_end[];
>  
>  #if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
>  #define EARLYCON_USED_OR_UNUSED	__used
> @@ -362,12 +362,19 @@ extern const struct earlycon_id __earlycon_table_end[];
>  #define EARLYCON_USED_OR_UNUSED	__maybe_unused
>  #endif
>  
> -#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
> -	static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name)	\
> -	     EARLYCON_USED_OR_UNUSED __section(__earlycon_table)	\
> +#define _OF_EARLYCON_DECLARE(_name, compat, fn, unique_id)		\
> +	static const struct earlycon_id unique_id			\
> +	     EARLYCON_USED_OR_UNUSED __initdata				\
>  		= { .name = __stringify(_name),				\
>  		    .compatible = compat,				\
> -		    .setup = fn  }
> +		    .setup = fn  };					\
> +	static const struct earlycon_id EARLYCON_USED_OR_UNUSED		\
> +		__section(__earlycon_table)				\
> +		* const __PASTE(__p, unique_id) = &unique_id
> +
> +#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
> +	_OF_EARLYCON_DECLARE(_name, compat, fn,				\
> +			     __UNIQUE_ID(__earlycon_##_name))
>  
>  #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
>  
> 


-- 
~Randy
