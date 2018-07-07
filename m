Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DEAC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EF22172D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRrzGfuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EF22172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbeGGLMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:12:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35629 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbeGGLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:12:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id v3-v6so12939401wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kdg4a+WsVPAtqFCPEukRpYFeGHjPlr8YWjCZLrKI2BE=;
        b=HRrzGfuzuSgU60/RfyblRHO3zcuLDlGsQVoYG4V+sM6zAP4rfTinFYlfqW3bfH8ebt
         PHHnQdF+A5L0A+AkZ7wyBHret5QWaIjFYKYGDmWZklLU25LEgJu2flncfHML+5kJwHTA
         ELLtTyHlXV+HyfWBuqsfMC8JBFxqi/rv+sU+GbrZ2jA1HBEXVAfPrGSlBP/U+eEazpAM
         YdTpZAlU8WhzQmKbZr4ehZLx6i+Qn9Se0eEdOPMxE+mq5iyrph9GUSmdY5qeRlYTRmA4
         jc0pNi//Ect811LtBJJfiS0hNAj6cGttDtgRgIEkUOvj32K9uX2T1HYyQNxLFV01U8fY
         ySkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kdg4a+WsVPAtqFCPEukRpYFeGHjPlr8YWjCZLrKI2BE=;
        b=jwHcvJh2L0ZLOz3z8TwqRFZPXXGmJAcrWzHplt7l5uFXC7QwuIMeX9zRC6WuIzr3W1
         O4UMjNXsRVevLvXR0k5LlV5FQsaj9wD6TTa3+We3XQAqA//iJNdM4zYqzJ70kINcc6YS
         WP6lMeseTqzXsdqnBpUVzKg4zaPeKJ9KsazJZGJ+MX2xfkj72ztiXaKz4RQdove/ad1X
         vklutV2ZQBSSucpjohcAx+gHlZCfTrKYr7+6wEmyOOcbhEUb4k/ve5/kNSzHCNkOGRq1
         kqSz0D898whpQGRqWzbQiul0u6JqdXc8xXZrQy3WLD5lYAx8KeaXd80Hzc1O+miRhhY/
         8VQg==
X-Gm-Message-State: APt69E3jUTzA8NNOcb/vIdan7pjjHVIagaXXSohAjwuYXELLl49MZ26g
        KynbXInrlLl6G8nqiO3Oq98=
X-Google-Smtp-Source: AAOMgpfomedHG4KazDb+8mfJXWcZDPHPFsLBc9JbwdNH79UIh2acCr+pDDaKBjO9kBXc8+/0UI4YDg==
X-Received: by 2002:a1c:228b:: with SMTP id i133-v6mr8923033wmi.69.1530961932864;
        Sat, 07 Jul 2018 04:12:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 14-v6sm18254481wmo.37.2018.07.07.04.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 04:12:11 -0700 (PDT)
Date:   Sat, 7 Jul 2018 13:12:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
Message-ID: <20180707111209.GA27768@gmail.com>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> From: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
> 
> Since syzbot is confused by concurrent printk() messages [1],
> this patch changes show_opcodes() to use snprintf().
> 
> When we start adding prefix to each line of printk() output,
> we will be able to handle concurrent printk() messages.
> 
> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> ---
>  arch/x86/kernel/dumpstack.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 666a284..bb47426 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -97,22 +97,24 @@ void show_opcodes(u8 *rip, const char *loglvl)
>  	u8 opcodes[OPCODE_BUFSIZE];
>  	u8 *ip;
>  	int i;
> -
> -	printk("%sCode: ", loglvl);
> +	int pos = 0;
> +	char buf[(3 * OPCODE_BUFSIZE + 2) + 1];
>  
>  	ip = (u8 *)rip - code_prologue;
>  	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
> -		pr_cont("Bad RIP value.\n");
> +		printk("%sCode: Bad RIP value.\n", loglvl);
>  		return;
>  	}
>  
>  	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
>  		if (ip == rip)
> -			pr_cont("<%02x> ", opcodes[i]);
> +			pos += snprintf(buf + pos, sizeof(buf) - pos,
> +					"<%02x> ", opcodes[i]);
>  		else
> -			pr_cont("%02x ", opcodes[i]);
> +			pos += snprintf(buf + pos, sizeof(buf) - pos,
> +					"%02x ", opcodes[i]);
>  	}
> -	pr_cont("\n");
> +	printk("%sCode: %s\n", loglvl, buf);

Does this change the output?

- If yes, could you show the before/after output in the changelog,

- If not (i.e. if only the number of printk calls is changed, the output is the 
  same), could you say so in the changelog?

Also, 3*OPCODE_BUFSIZE+2+1 is 195 bytes - isn't that a bit too much on-stack 
footprint?

Thanks,

	Ingo
