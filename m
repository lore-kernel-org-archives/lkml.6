Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FD12087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="c43DKEGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfBYPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:44:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34419 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfBYPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:44:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so10489639wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJQpovYpYRbsFnvx1dAg4PkTk45HQ4Ul9jQiHG64c50=;
        b=c43DKEGCylJL46UktKQRNoH6z6yH5V0QWaFCNjdm0RKCQ5y4y1TbvGfhzozgKp1fKn
         y+05ZBZGThNkIC+o3wBZWNB/H1LDCsJA/5KL9tQKKNYeiwf6pFGZQ+VLeL8EztVDfAzp
         xul+sKPXurtXE68AP2noLHiH7YMo5i7F6pdlY7G8Ye8uws2h5e7xUlgexg4MWcx81ZVc
         f4kBsbG7iaeOyPjfjlpaGvNqmV5zaqw0unnaYqOQPhkhm75vz5Px5bXk5EzCvvW5CtNG
         xxhwpXFpLhBHUR27KPZhnXogXtPwYvEH79P1QDvuzg8NmMdnq5sTEGFi4J+TmBuMM3j4
         jffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJQpovYpYRbsFnvx1dAg4PkTk45HQ4Ul9jQiHG64c50=;
        b=jf5VfTTDfZwlxTjD0ho90MiDTqS+OBZzbC/VfZ2Y1iy7a6iCYULXLNru0LxYSaZ4bQ
         sDXOr6Zdm1hyC8OyGXaLYMZJZrq8c8K4Khdbr22IkCNpYutn3yzVMUUN+THSL4uv6JhO
         UI74oyO+X8oxCfwAb3duxKJUxQyEBSL2LVqCd0ZYkwzRSMAWadXtvCHE4KLhnQGPySnp
         ejtb2zyN/pdnoo/50L8gRzRvvjlaZ4WaMPkCU3VP2baldRxuMggtU6guOos7tPEmN9xs
         Obysuq8vzml5r3Aim63+VxZ9+3VLXmSdlMFtHfLv99/SR1cIgbOR0QI1KzCidyUUrXD4
         +Ngg==
X-Gm-Message-State: AHQUAuaH9LjgkMvC1D4UfDWm7C7wA14Q0CWr6Iw6oW/b+2BgdeDLAnu5
        Z1I5OM7NRmMtom/beDySfTjtuEBAKW1unJXvWN8XhA==
X-Google-Smtp-Source: AHgI3IaYAgKVp2gjOBvgx17rXkX+ii1Md0DHGv51yanXCSYX3kIAhKFgPTRbNhYhek1//ZENpl+3cpsHR1Ns/tD4HNY=
X-Received: by 2002:adf:e58f:: with SMTP id l15mr11932590wrm.309.1551109445605;
 Mon, 25 Feb 2019 07:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125231.845656645@infradead.org>
In-Reply-To: <20190225125231.845656645@infradead.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 25 Feb 2019 07:43:53 -0800
Message-ID: <CALCETrWQpG2aOxxeoNXUPD-A7h3j4NSTqoN+vN9Nr2E_Fo19zg@mail.gmail.com>
Subject: Re: [PATCH 1/6] x86/uaccess: Dont evaluate argument inside AC region
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 4:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> AC regions are special, make sure we don't do possibly complex
> evaluations there.
>
> Probably-Signed-off-by: Andy Lutomirski <luto@kernel.org>

I put a slightly fancier version here last night so that the 0day bot
could chew on it:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=b294da548d92320f194172272dda1f734e51013d

want to snarf it up?  It's the same thing except that I added Linus'
suggested change, found the offending patch that broke it (hi Linus!)
and added a bit more changelog :)
