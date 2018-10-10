Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74098214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4xPY822"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74098214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJJNUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:20:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45371 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJNUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:20:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so4191050wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 23:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0ei3z+HaQ2EeWgvfLqreu8QKtH07HrSF6Y+tHrJENQ=;
        b=g4xPY822Tel5Ch0wPlZaIbCTKXNRdEDlun18XWzl7+QNdO3Mk1mHk7JG9pfb9+smpY
         81+3nm9cjwHWMiZG4F3TDbUFIGyiY5VE04Vs3/+QMdeHuJ954SWKDjqpDnpYgywxDOw0
         r1Kq0irHJOMaJA+LBfxZKwLMwIogw6yhxO3KeKNPl2ryztkqSj7tkQKfqE323fjIO0Hc
         V+3K6qEODmzNOqmx7Z/XXkHaX6FCgxhl9sgQaFI0yasMNneKPQ/h+N8smPMERIf7y5v8
         3OBo9GjrsI27b/i8/ckBWvQ5ZNjULJecopDP9ckVsA8ZBRTW9vcgjkh3YpZpKgPCGUZv
         PcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0ei3z+HaQ2EeWgvfLqreu8QKtH07HrSF6Y+tHrJENQ=;
        b=ioJrnVG2Wh28HfK5ltmmf87JuGUOtm77l4e17xoJ9lgLIgLT6M5jRXGckMCEBu/v9y
         xY2povgsuW1+z14wW7CwRNG+aLgMUMEh4uKAzD+q2C6C7i182BOqY3sRMomowrs9vYD8
         vjX9tFVUm1BHISUy4aPua9sk5Kk3gs4CVYSZBGND3qvA6qyAHfCfwvNeuL/sL841BnVK
         oLseQcfbV0CAfxkhruOYEhNOBNoSqny+EksL/n++SPVscE5JtfInDNwdb9s6Z2xSYRDo
         +ltUNOmEpCqoHBQjfDSltAKq0sbC4+g/fbHA5Du+tH7Z35JMD2Uv8Eek4EQBPflHfs8Y
         5Y9w==
X-Gm-Message-State: ABuFfoggarr/OXE1KGBCUZVe3ydEeOjfH9EZpR7A26jvbFAr7mnzFNBt
        9p59HVz9XgU//o/SHEOKV8M=
X-Google-Smtp-Source: ACcGV60HEY/w1DX8wLH1dpuP4qszvm9Q6kN3+cowGampy3IyXBzd80LjOQSKcFZGZK5DujAhrDTVWA==
X-Received: by 2002:a5d:438e:: with SMTP id i14-v6mr23980768wrq.156.1539151205516;
        Tue, 09 Oct 2018 23:00:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u76-v6sm30370943wmd.10.2018.10.09.23.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 23:00:04 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:00:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org
Subject: Re: [RFC PATCH] kernel/panic: Filter out a potential trailing newline
Message-ID: <20181010060001.GA36987@gmail.com>
References: <20181009205019.2786-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009205019.2786-1-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> If a call to panic() terminates the string with a \n, the result puts
> the closing brace ']---' on a newline because panic() itself adds \n
> too.
> 
> Now, if one goes and removes the newline chars from all panic()
> invocations - and the stats right now look like this:
> 
> ~300 calls with an \n
> ~500 calls without a \n
> 
> one is destined to a neverending game of whack-a-mole because the usual
> thing to do is add a newline at the end of a string a function is
> supposed to print.
> 
> Therefore, simply zap any \n at the end of the panic string to avoid
> touching so many places in the kernel.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: x86@kernel.org
> ---
>  kernel/panic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 8b2e002d52eb..5776d2879650 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -136,7 +136,7 @@ void panic(const char *fmt, ...)
>  {
>  	static char buf[1024];
>  	va_list args;
> -	long i, i_next = 0;
> +	long i, i_next = 0, len;
>  	int state = 0;
>  	int old_cpu, this_cpu;
>  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
> @@ -173,8 +173,12 @@ void panic(const char *fmt, ...)
>  	console_verbose();
>  	bust_spinlocks(1);
>  	va_start(args, fmt);
> -	vsnprintf(buf, sizeof(buf), fmt, args);
> +	len = vscnprintf(buf, sizeof(buf), fmt, args);
>  	va_end(args);
> +
> +	if (len && buf[len - 1] == '\n')
> +		buf[len - 1] = '\0';

Nice, this patch saves a couple of hundred trivial upstream commits in the next 20 years:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
