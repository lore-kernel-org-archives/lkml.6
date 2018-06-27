Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E34C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F17124336
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nevxtr2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F17124336
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965351AbeF0OU6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:20:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37056 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965209AbeF0OU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:20:56 -0400
Received: by mail-pg0-f67.google.com with SMTP id o11-v6so990717pgv.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ESUSYi8ZtnKAb4t2407Qvuw8NiIBJluqwBWh6vlN2HI=;
        b=Nevxtr2iyaMQ9crpXgQAvPurVGikgKH5J7ou2cws8CH2zus30PUU35/uyy7spmJiOd
         ojqT9jYW/j0O5bIiJPd5vWJOx8JRIij1QMRD2pmHWPiS1X7GA+sPXeXu04JlNzCpUx3p
         4v0XHK+4ey8VbdhW4TuGFH6Z2YZzdJEeevVTBkDhv74/KAuuEszvRwWB43rqsaY6lV1v
         nu5EB9s3Vx3lAP2MnTGb2YdLRsv4D0q1BiV8cz/8Fu1hcRYBHbuAPmwLU6Gh0xbKWIQa
         ZFGmKrRJTS0D7vzN//FSClq6aCGFMjhWMVI57B4BY2TfdvPQ20pgWBoC1/lFUmFnqccy
         ruIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ESUSYi8ZtnKAb4t2407Qvuw8NiIBJluqwBWh6vlN2HI=;
        b=V9ZMnFzjr/l0wEXk7ZIOGXkk77qOs23jNwMbUk9Ylw89V1m4Yubw9XyUELVcqfqZxc
         oG3iADnbLQRgi4WUoyQi/WOYPpWIhHpropGMLAo8BWkZdCbYYxJM/L7McdTfVJkR77ha
         V8PW+Q0vzYJyhYhmsAgpuRdZXfCYq6N963zlSb3G25yye/jIDKnels1x+AzKIMtj8U//
         lT1FyAp4pQaQwgZ2MyviNK01CwDUwGQZu38GHWcu/tq/KH4/DID4xTCT1AFOph0LhiyU
         EDZxsOSN33dn4y5QQQLFlW+FEQnZ5GR/9PUTvyK4dorLSIjG4DRfbFflSSoSn0cGyDA8
         G8bw==
X-Gm-Message-State: APt69E0OhAfir29OTvLRubpmxOLq2nS9MoXNTuKIGQrWj6dfswsc5Ys4
        7mp0eJx2jLbnYeDPOqLIpEU=
X-Google-Smtp-Source: AAOMgpfto6FQ26E2oaeLCfO1qyfm27C8imDHn2vf60geVrIrFjwa5YAfbYlp0CQkgnLVJZzuZz77Ng==
X-Received: by 2002:a63:790b:: with SMTP id u11-v6mr3242985pgc.111.1530109256140;
        Wed, 27 Jun 2018 07:20:56 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n6-v6sm13789021pfk.36.2018.06.27.07.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 07:20:55 -0700 (PDT)
Date:   Wed, 27 Jun 2018 23:20:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v9 4/6] init: allow initcall tables to be emitted using
 relative references
Message-ID: <20180627142053.GB477@tigerII.localdomain>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180626182802.19932-5-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626182802.19932-5-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/26/18 20:27), Ard Biesheuvel wrote:
>  /*
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 247808333ba4..688a27b0888c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2772,7 +2772,8 @@ EXPORT_SYMBOL(unregister_console);
>  void __init console_init(void)
>  {
>  	int ret;
> -	initcall_t *call;
> +	initcall_t call;
> +	initcall_entry_t *ce;
>  
>  	/* Setup the default TTY line discipline. */
>  	n_tty_init();
> @@ -2781,13 +2782,14 @@ void __init console_init(void)
>  	 * set up the console device so that later boot sequences can
>  	 * inform about problems etc..
>  	 */
> -	call = __con_initcall_start;
> +	ce = __con_initcall_start;
>  	trace_initcall_level("console");
> -	while (call < __con_initcall_end) {
> -		trace_initcall_start((*call));
> -		ret = (*call)();
> -		trace_initcall_finish((*call), ret);
> -		call++;
> +	while (ce < __con_initcall_end) {
> +		call = initcall_from_entry(ce);
> +		trace_initcall_start(call);
> +		ret = call();
> +		trace_initcall_finish(call, ret);
> +		ce++;
>  	}
>  }

printk bits look OK to me.
The patch set works fine on my x86_64 and does reduce the size of vmlinux.

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
