Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7051EECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFF320843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuuLsqJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFF320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJ1Tah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 15:30:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51147 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1Tag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 15:30:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2-v6so1577094wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UZocNA0W1lwVA2VrxqydNsGfF47KcPt9wv+pk0KpSAg=;
        b=nuuLsqJjKwj36Zwrtdw+/eyY4mAgVZtSlhtspffzvjku6EduY2jJymRdnNWTQpA4xT
         YEmduA0F544ZqLOJ4KZnjMnqWLkBkNaYAosE7eWvWaZUymXcTfnx8Kd3LeZBDj/JlUYB
         esY3bnnViAiJd9gv3aj0vpEGBdCMfxJAClA8EmcRTbRc1XgFCGMtLWGvKBq3F7pgLJ6v
         GneiAIoSuJ+FdFLPBwodaCy1jiKtiyNftU5Tt+Cep66/M/NXk0cOPH9hDocO7LgOfpIE
         1kOLdqLZhMZ9EOvZb0jhH4sWt7xF/RVsMaYPkHwedBgLsglgkrDJ0goCS+zI/w8Nq8l0
         nv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UZocNA0W1lwVA2VrxqydNsGfF47KcPt9wv+pk0KpSAg=;
        b=qQ713uGgg3PEKsa1HY3tuJeXfX0jwEuXNmdVS5rFHQzob2OU/Lc+L5LTTHOnxGU271
         xj56YJ+OsUiG9/MtRvK9OgSQ0tgl940yqSdksRvFejtMuQXFbT0/kOkI9VWNaMXNcnzq
         uA6z/oZl7qXrtYlziEq/HyjMambZhH+YiyG9g/iyVmzq9/rDF7N0dSysxGpHfwWHGSJZ
         Xb6psGn9J086KMjtuzzdKl7N6RrqA3SxBW0MwcyvKwLv0jVJ6Zb1CoWYFFbyRw1kzbBo
         0V3cz3mpestzM93eTXyAfR1oNuN/R4L52BMPW3RGTpuJ8z2tfAqwrGNfoYUAtRLIuxlt
         hv1Q==
X-Gm-Message-State: AGRZ1gK5o5hMY4BrxW9fmoaQ1EgXtqGfzywsRCYylDEcdKH3dSG6fEzJ
        qMlpPNis9FijOnvx352dIcc=
X-Google-Smtp-Source: AJdET5dad32kE5JdS+9+ZVnvNOlJr6aMS6PAWU/kavAS73ML49209YgF74m1ccbJ/9gBfHYZP1dDMA==
X-Received: by 2002:a1c:1804:: with SMTP id 4-v6mr10247319wmy.29.1540723578163;
        Sun, 28 Oct 2018 03:46:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p19-v6sm6381006wmc.46.2018.10.28.03.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 03:46:17 -0700 (PDT)
Date:   Sun, 28 Oct 2018 11:46:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jordan Borgner <mail@jordan-borgner.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH] arch/x86/boot/memory.c: Touched up coding-style issues
Message-ID: <20181028104614.GA98913@gmail.com>
References: <20181027223231.pyigrae7mhl2xil2@JordanDesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027223231.pyigrae7mhl2xil2@JordanDesktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jordan Borgner <mail@jordan-borgner.de> wrote:

> Added missing parentheses to sizeof() function in detect_memory_e820().
> 
> Removed unnecessary braces in detect_memory_e801().
> 
> Replaced three if-statements with a ternary if-statement and 
> removed an unnecessary integer variable in detect_memory().
> 
> This is my first patch I hope it is okay.
> 
> Signed-off-by: Jordan Borgner <mail@jordan-borgner.de>
> ---
>  linux-4.19/arch/x86/boot/memory.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/linux-4.19/arch/x86/boot/memory.c b/linux-4.19/arch/x86/boot/memory.c
> index d9c28c8..a6124af 100644
> --- a/linux-4.19/arch/x86/boot/memory.c
> +++ b/linux-4.19/arch/x86/boot/memory.c
> @@ -26,7 +26,7 @@ static int detect_memory_e820(void)
>  
>  	initregs(&ireg);
>  	ireg.ax  = 0xe820;
> -	ireg.cx  = sizeof buf;
> +	ireg.cx  = sizeof(buf);
>  	ireg.edx = SMAP;
>  	ireg.di  = (size_t)&buf;

That's legit - could you do a single patch that only changes all the 
'sizeof x' patterns in arch/x86/ to 'sizeof(x)']?

>  
> @@ -88,11 +88,11 @@ static int detect_memory_e801(void)
>  		oreg.bx = oreg.dx;
>  	}
>  
> -	if (oreg.ax > 15*1024) {
> +	if (oreg.ax > 15*1024)
>  		return -1;	/* Bogus! */
> -	} else if (oreg.ax == 15*1024) {
> +	else if (oreg.ax == 15*1024)
>  		boot_params.alt_mem_k = (oreg.bx << 6) + oreg.ax;
> -	} else {
> +	else
>  		/*
>  		 * This ignores memory above 16MB if we have a memory
>  		 * hole there.  If someone actually finds a machine
> @@ -101,7 +101,6 @@ static int detect_memory_e801(void)
>  		 * map.
>  		 */
>  		boot_params.alt_mem_k = oreg.ax;
> -	}

The original code was better - multi-screen-line statements require curly 
braces in general.

>  
>  	return 0;
>  }
> @@ -121,16 +120,7 @@ static int detect_memory_88(void)
>  
>  int detect_memory(void)
>  {
> -	int err = -1;
> -
> -	if (detect_memory_e820() > 0)
> -		err = 0;
> -
> -	if (!detect_memory_e801())
> -		err = 0;
> -
> -	if (!detect_memory_88())
> -		err = 0;
> -
> -	return err;
> +	return (detect_memory_e820() > 0 ||
> +		!detect_memory_e801()    ||
> +		!detect_memory_88()) ? 0 : -1;

Here too I think the original flow of logic was easier to read - more 
compact is not always better.

Also, please investigate whether the return value is actually *used*, and 
if not then please send a separate patch that simplifies the code.

Thanks,

	Ingo
