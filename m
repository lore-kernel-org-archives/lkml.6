Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34C3C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE05A25C18
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYWo+oeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE05A25C18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeF1CZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:25:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42103 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeF1CZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:25:11 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so1754127pgu.9;
        Wed, 27 Jun 2018 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=acuftZPRvy+pcq1GVozvJhjlZNel7dLuOjLO6dRYPtg=;
        b=dYWo+oeANVPtIqOkq9aoqBsw/T2uREhdVT+kTmdRpmw0qHYlJMEUcaSlbiMTebP2ff
         eQDGhcMnMW1VWcUAdm6dELJ5I7NLqBbyXkovkO1+0zJdASOixqjK+VorzEo60xJvalSb
         5h4jRMITszqKHS+kcYTMJgW6ISFXTEfa3CiYmeBNiySLbOYFibnT5PbjHEy+VvX1C0ZU
         G8UriCnk4j9zNuQdyou47PEVx4THkMlxV6XA0bqxyWGiA/YWhMlF7jIpFoDz7oOp6NGD
         QCuj4K6fJqg5BUNVHoCEqKpTGPzBmJ8ldGydZLSFMH2jgYqwff6K/1BXy3pbd89wzWsS
         0lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=acuftZPRvy+pcq1GVozvJhjlZNel7dLuOjLO6dRYPtg=;
        b=dCkc02vIRVeN0ttj1aNOgg3cC651sAf8uet82xDqCuyWYS5zymmgEUtJueZoqJz9Qr
         47SrECpdf22WX7dI41SCbW7qA9fKm48H8jRKucqF0zRFhUlTFpADhDl2xb1EINsVe0qf
         QZ11x/GYJvcgUYsVCu9nU43vT7PdtS3KBFstkQEdLfNgfWNhTsCG3AB9pXQ24rLjsWmu
         xXH5CER0OoBg1j2CB6BeWfzJ6Y75+pST5Plv66Tscj7ZEV+5Aj8zmvfvaAOpzRWqS1af
         LAkLBd5d9FVxYbHmV+UxdhMfCfKXJDDROSliLjQdCSaAY8MQ00dVyiBbyFZcstErZw9Y
         vWow==
X-Gm-Message-State: APt69E0DC6IWZLKUZEDzRVd0d4XsG1k6c5izEOeMeiu5hpviGZfRD0jJ
        RhBw9Tb+sOZ0ha2sk7xT9hI=
X-Google-Smtp-Source: ADUXVKJaAc4ys9TFx7vEPZiJMVRL5HU/ylrzwirtkr97+BA6NBAXiexUydI61VJd7Ulv8NcMTEos2g==
X-Received: by 2002:a65:418b:: with SMTP id a11-v6mr7244517pgq.118.1530152711280;
        Wed, 27 Jun 2018 19:25:11 -0700 (PDT)
Received: from localhost ([110.70.27.221])
        by smtp.gmail.com with ESMTPSA id v26-v6sm7906431pfe.13.2018.06.27.19.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 19:25:09 -0700 (PDT)
Date:   Thu, 28 Jun 2018 11:25:07 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] printk/nmi: Prevent deadlock when accessing the
 main log buffer in NMI
Message-ID: <20180628022507.GD481@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627142028.11259-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627142028.11259-1-pmladek@suse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/27/18 16:20), Petr Mladek wrote:
> +/*
> + * Marks a code that might produce many messages in NMI context
> + * and the risk of losing them is more critical than eventual
> + * reordering.
> + *
> + * It has effect only when called in NMI context. Then printk()
> + * will try to store the messages into the main logbuf directly
> + * and use the per-CPU buffers only as a fallback when the lock
> + * is not available.
> + */
> +void printk_nmi_direct_enter(void)
> +{
> +	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
> +		this_cpu_or(printk_context, PRINTK_NMI_DIRECT_CONTEXT_MASK);
> +}

A side note: This nesting also handles recursive printk-s for us.

NMI:
	printk_nmi_enter
	ftrace_dump
	 printk_nmi_direct_enter
	  vprintk_func
	   spin_lock(logbuf_lock)
	    vprintk_store
	     vsprintf
	      WARN_ON
	       vprintk_func
	        vprintk_nmi

>  __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  {
> +	/*
> +	 * Try to use the main logbuf even in NMI. But avoid calling console
> +	 * drivers that might have their own locks.
> +	 */
> +	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
> +	    raw_spin_trylock(&logbuf_lock)) {
> +		int len;
> +
> +		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
> +		raw_spin_unlock(&logbuf_lock);
> +		defer_console();
> +		return len;
> +	}

So, maybe, something a bit better than defer_console().

Otherwise,
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
