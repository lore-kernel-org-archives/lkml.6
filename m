Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8AEECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCABF206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDKnY8Ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCABF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbeGRMfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:35:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45335 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeGRMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:35:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id c4-v6so4381584wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JnE32RBNUnCE9UrQz26ScvX1CN4woIRF9ldrRnArX0Q=;
        b=qDKnY8Ug6hPdMZN7oTRfG3gmA3+hiySufkmmAYv4HMgdTQWybdLtbNxYXvbgjpm8QG
         PjIIx7hCIS77+x3CSyQQyBwjdKbWSyd0FW9n3GNUIb+x5TqN3DNHNHmhZyGg9xPpqEAY
         jgeJtd2kI3W0fF8t5evP3Y89V7sdUru1vwIlUWov8F2qSfcx72Yqvl0ir+7vVb4wIiGa
         MPrS9bXpB0kJUGlm2FTgWUnOsMJv5q4XYVZaSe+9dQlYRuQeSL+IUy/VdYTrMx/aK6oo
         IGbTl3N/zku1O8BHfTgZIVGUTvWIS5PFY7wlb4lpnVaTX15WVxkX9JULitKI5q2HSpQ/
         msEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JnE32RBNUnCE9UrQz26ScvX1CN4woIRF9ldrRnArX0Q=;
        b=hBGMJ9rdBpnpEQ5HO2VZOmoYmHTA0l3QQkGqK1cYU1aixMMYF1Ya3NWWwjsTTp4iS0
         hY6eR6E2sa45kfka/m6EvI2r0WsJ4Jeyx5ZVclec4Umc8hkAPkBzNf4/gYaDV2LWCcM9
         JPM5/X/zxptdT7noYxB74dwmOhKiPdrlxrDUWkGUFCW0BId+nrhaVkaOlPPM85hST0bA
         fwzryG/pfUNk0Vofah39pvlUJn9I1p/zd9oidd1ZYYJCmpnzKOQUUn8Qic5tkHWzwmDr
         FBR5ubAxO+ByKkDz6EeCeHbxr74j8IQWd393QNO89xhcb6Kdh6bNcyU4ZhurWjpczgkY
         L/Pw==
X-Gm-Message-State: AOUpUlF7HbG8CiyJbU42R16KgB0FebOF8h2Vg3fpfAbtcfyyCTZhdk9S
        4wlsmdDgqDXOa5ZnMV7AeZM=
X-Google-Smtp-Source: AAOMgpcON7QCLIzc7OVs963b8/WTOX4FnQy3vJVV/Buu12VCvOAORRKD+5qCTIIdfMNLndAQUvq4Cw==
X-Received: by 2002:adf:bbd4:: with SMTP id z20-v6mr4352554wrg.183.1531915076760;
        Wed, 18 Jul 2018 04:57:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b198-v6sm2022389wme.11.2018.07.18.04.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 04:57:56 -0700 (PDT)
Date:   Wed, 18 Jul 2018 13:57:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, joe@perches.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5] x86: Avoid pr_cont() in show_opcodes().
Message-ID: <20180718115753.GA25388@gmail.com>
References: <1531907643-3367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531907643-3367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Since syzbot is confused by concurrent printk() messages [1],
> this patch changes show_opcodes() to use %ph format string.
> 
> When we start adding prefix to each line of printk() output,
> we will be able to handle concurrent printk() messages.
> 
> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Wasn't that variant of the patch written by Rasmus?

If so then the changelog should start with:

 From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks,

	Ingo
