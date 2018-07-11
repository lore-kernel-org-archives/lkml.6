Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BD120873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BD120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbeGKToE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:44:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37818 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbeGKToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:44:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so3707455wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QncmxcK0h9Ic3Wjndb53CNcZ8nzkYlvVd1EwPligSSM=;
        b=HUJvlu/JcmkUas77zhxFoZX77M6JUVpRN/P/gw/EtIl3vEhQRjiGmqfRj+usZweQan
         hV0LJJM9Wn696y6KhodxCq8mxI00cIbW6CxHeK5dPUDSTWxI2jTEzufFcBdcGnqUFEDZ
         ebNcHvRFb6+qCyzLwAhCydIOrferZt5BqmW+CoVkUOkfmt474Vlb2+lc5qDGiISv+8Sr
         nRDOCXY+hSHiFFPq+aDJQ93cwOypqfPjoGA8R03qFHkgkqimt/f49KpbuPeGr4yuVch+
         vNBDM5G+uXAOLvUUhbZDOSWdvV5hQ7qODiooeXLR1LkB5vbWlMYArJWg1UCV1j9LCitD
         iJwA==
X-Gm-Message-State: APt69E1NHa3FVKmoBqgSHY8QqO0gY2q1/EBO3wIwaqE0ualoVmJ0ueXB
        veBr8+ykvAMdv4dhwU/JNi7gaQ==
X-Google-Smtp-Source: AAOMgpeDy4fPBPewhM4cIqEJspcCtvRybA0dWs1RXeMXX3OtvRJNCngM75mTy8pmF/3jiJhpj1RRPA==
X-Received: by 2002:a1c:b788:: with SMTP id h130-v6mr19546425wmf.27.1531337894494;
        Wed, 11 Jul 2018 12:38:14 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l127-v6sm947467wma.41.2018.07.11.12.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:38:13 -0700 (PDT)
Subject: Re: [PATCH] console: Replace #if 1 with a bool to ignore
 WARN_CONSOLE_UNLOCKED()
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180711151755.613eba3c@gandalf.local.home>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <46a85cd5-944c-138d-2c73-dae5b9851e24@redhat.com>
Date:   Wed, 11 Jul 2018 21:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711151755.613eba3c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-07-18 21:17, Steven Rostedt wrote:
> 
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> There's been discussion on the fb list about the addition of
> WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
> the fb module is loaded with lockless_register_fb the console lock is
> not taken for debugging reasons. With the addition of
> WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
> fill up with warnings when trying to debug the fb driver.
> 
> There's also a #if 1 that enables the warning which was added before
> git history, and we look down on constant #if's in the kernel nowadays
> anyway.
> 
> Remove the #if 1 and add a ignore_console_lock_warning boolean that can
> be set by drivers to ignore the warning in order to do debugging.
> 
> Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Based on the fbdev discussion this seems a good idea to me
and codewise this looks good to:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> diff --git a/include/linux/console.h b/include/linux/console.h
> index dfd6b0e97855..9d4a6b985154 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -200,11 +200,9 @@ void vcs_make_sysfs(int index);
>   void vcs_remove_sysfs(int index);
>   
>   /* Some debug stub to catch some of the obvious races in the VT code */
> -#if 1
> -#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
> -#else
> -#define WARN_CONSOLE_UNLOCKED()
> -#endif
> +extern bool ignore_console_lock_warning;
> +#define WARN_CONSOLE_UNLOCKED()						\
> +	WARN_ON(!ignore_console_lock_warning && !is_console_locked() && !oops_in_progress)
>   
>   /* VESA Blanking Levels */
>   #define VESA_NO_BLANKING        0
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 247808333ba4..d9056efc3739 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -66,6 +66,9 @@ int console_printk[4] = {
>   	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
>   };
>   
> +bool ignore_console_lock_warning __read_mostly;
> +EXPORT_SYMBOL(ignore_console_lock_warning);
> +
>   /*
>    * Low level drivers may need that to know if they can schedule in
>    * their unblank() callback or not. So let's export it.
> 
