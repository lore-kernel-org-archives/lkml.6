Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A1B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9Sf5y0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A1B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbeGXIrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:47:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44655 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbeGXIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:47:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so3049903wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C5XQR5yi/V43L3Z+E3qu3TY7O9gDv0WECaBA0yppJjY=;
        b=Q9Sf5y0yBPCaEjtzmVNE2YIVYPcdi7ep2cCjkw8AANiCd5vreVL5qSyt/YLPvTsxo8
         NkliRJjy/GDHvjNheHDOCEd3CbopadeNCsfWKybnL3HlYn8y3Sm9NWvHxsSTxNSr2hlH
         wpfflrkIPufe/tUo4kqNaV0V58KtZqgivuqjAtFZ88PzUS98QUWlbpW8rzlL9xq7n5eG
         HfwNlhqDCmNXcw2vofybKBKf8ZItei5zOlqK9qBhlV6X64b1WISwOzszDZxqdpw+Kqo6
         WQxV3/Kt5H0ogjher2kdvFAWyF/CCAle2DZiEcupuL1EOc3KfMZa371WWJQ2h3Z35qmu
         9Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C5XQR5yi/V43L3Z+E3qu3TY7O9gDv0WECaBA0yppJjY=;
        b=m4wB5nvDL19Gp96kyulLpEiPERX7rDwdqTvkJRjydewkVqoHZVFOL5X7XfsdIq9nhD
         GGz2AAAvyaN7mSMleXmZjtNStdcaDvHRC9aO76QuUZKIhKazpROdseQ/rXBJXQ3WButK
         Sy/SHyqxpUJXYFXMRfVnFY4yQ1L8dXXavWmcPVRNRKIBU7QcxNschsUsGD/XGlkxEFOv
         5I4l2WIKtClZOpuZHPknnQYvRM+CmJBQwP7bMY4OyySs9BeiAzyt3/2/lYVzcW44FGYe
         5h9eh6XR/y53CnjEC96nYiU5unJWwt0WFWuOK8bskF7RIKmF1ab9iwGStFEdOLseghAQ
         w6Kw==
X-Gm-Message-State: AOUpUlEd+mKp7wP2z/729DbwhJible5tCX/CjAlfzG9ZzYt+32G/yrBr
        NoKMA/6DBpLZNlWdmICPWaM=
X-Google-Smtp-Source: AAOMgpd46jGU7osVEo+XncRvjz54oG7yv7VQqjneEtbG92tltolcR+gJrCnMPnqXfNhNxqlyo2tv6Q==
X-Received: by 2002:adf:f585:: with SMTP id f5-v6mr10313782wro.59.1532418132742;
        Tue, 24 Jul 2018 00:42:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g18-v6sm897547wmh.21.2018.07.24.00.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 00:42:12 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:42:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, joe@perches.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5] x86: Avoid pr_cont() in show_opcodes().
Message-ID: <20180724074209.GA18523@gmail.com>
References: <1531907643-3367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180718115753.GA25388@gmail.com>
 <ed59bf3b-705f-8433-f498-0acc2f09ef97@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed59bf3b-705f-8433-f498-0acc2f09ef97@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> On 2018/07/18 20:57, Ingo Molnar wrote:
> > 
> > * Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> > 
> >> Since syzbot is confused by concurrent printk() messages [1],
> >> this patch changes show_opcodes() to use %ph format string.
> >>
> >> When we start adding prefix to each line of printk() output,
> >> we will be able to handle concurrent printk() messages.
> >>
> >> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > 
> > Wasn't that variant of the patch written by Rasmus?
> 
> Rasmus Villemoes taught me that we can use "%*ph" format string and pass
> length as arguments for "*" part. Then, since Joe Perches suggested me to
> use #define for length variable, I updated to use "#define length immediate"
> and replaced "%*ph" with "%" __strigify(length) "ph" and removed length from
> arguments. That is v5 patch.
> 
> > 
> > If so then the changelog should start with:
> > 
> >  From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> OK. I posted v6 patch with From: line updated.

Please do that only if it was mainly written by him - otherwise just tell me that 
it's yours and I'll apply it as such.

Thanks,

	Ingo
