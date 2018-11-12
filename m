Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2C5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E706208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaYohkx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E706208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeKLNiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:38:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53650 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:38:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id f10-v6so6998197wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 19:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qCBeWAVPl6/xvWokQkbKevMdjTmKaDmHisaEPKfKjBw=;
        b=GaYohkx49u016XwGD4AYcG+oknPuSSa+XdnTDGkGtuAj7oyIiWBHJXlJAJAqlJ4AUp
         GnA1E2h9sJbgWZhtSjXujA5u/iJb9LF48kU/t9H3iwflZZEuR/l3pIbZLtcCEt8J1wOc
         uiRZSeqRxEa71m+X32cTcp6q7i4CNJYNvUgKWEUzS2RxQlr8OV/5Xp1+LN+AVYcOG2rL
         NhgsRAqexo2MC60t7mQLXl1WOIMcCPqh15MQY08OFd3gzpxlUa4x0VQwirZKNaNmad4i
         blDyavxayDQT6osVyZVHk7072Ks7WIKtdDSEjhDgKI5/LGZ1eGhdp2uS0XW1mPx4lqCv
         fpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qCBeWAVPl6/xvWokQkbKevMdjTmKaDmHisaEPKfKjBw=;
        b=PIvy3vA3ViI8rpmOjcVXMCytwjUFxX9jCjUdVwRtaCAkh8KrG7jyDJz2+0VGsG9reZ
         QmRYnefbjZU+cDYf35l41ctlswimzsFRhoR6/XtgppkE7dT9/40d7uubOjUdvmBjLTeM
         Tmc/jlOPHvdPgq3I907AhPK2ucRNOrDMygA3d2tPQj76HSBO1hifURbhjXeWyLzPlVtp
         elB2Vu1L05angU4CQyJpa7KaHaYGWpitF+23ZzSERkOZp4naGyj9BzbuWO+XWZLQudgl
         8TFzY67DgEaLSTvBMWkdTHilLq7tF+ExKpPVty3NtHD0WfcrNqZY08yeUJpvXAxb9KDv
         7Rhw==
X-Gm-Message-State: AGRZ1gLkioDXPNCoeL9DFll0coATw5s9MR4Vule5FS+b7jom1H64VwvJ
        WaxhilUUiC+goj2k/+iy9NI=
X-Google-Smtp-Source: AJdET5cWmXsILRJRNXPUy3cUznxMZLNPaJAnEBGjApWwuOaX6/u9DPotHdCgATPaPJKPHWNfbj5dTw==
X-Received: by 2002:a1c:730b:: with SMTP id d11-v6mr6199542wmb.107.1541994410032;
        Sun, 11 Nov 2018 19:46:50 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l42-v6sm11475238wre.37.2018.11.11.19.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 19:46:49 -0800 (PST)
Date:   Mon, 12 Nov 2018 04:46:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Message-ID: <20181112034646.GA88919@gmail.com>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com>
 <20181111145936.GA3021@worktop>
 <43C8C690-F079-4513-82CD-46A62DBA5A3B@vmware.com>
 <20181111235220.GB3056@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181111235220.GB3056@worktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Nov 11, 2018 at 08:53:07PM +0000, Nadav Amit wrote:
> 
> > >> +	/*
> > >> +	 * The lock is not really needed, but this allows to avoid open-coding.
> > >> +	 */
> > >> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> > >> +
> > >> +	/*
> > >> +	 * If we failed to allocate a PTE, fail. This should *never* happen,
> > >> +	 * since we preallocate the PTE.
> > >> +	 */
> > >> +	if (WARN_ON_ONCE(!ptep))
> > >> +		goto out;
> > > 
> > > Since we hard rely on init getting that right; can't we simply get rid
> > > of this?
> > 
> > This is a repeated complaint of yours, which I do not feel comfortable with.
> > One day someone will run some static analysis tool and start finding that
> > all these checks are missing.
> > 
> > The question is why do you care about them.
> 
> Mostly because they should not be happening, ever.

Since get_locked_pte() might in principle return NULL, it's an entirely 
routine pattern to check the return for NULL. This will save reviewer 
time in the future.

> [...] And if they happen, there really isn't anything sensible we can 
> do about it.

Warning about it is 'something', even if we cash afterwards, isn't it?

> > If it is because they affect the
> > generated code and make it less efficient, I can fully understand and perhaps
> > we should have something like PARANOID_WARN_ON_ONCE() which compiles into nothing
> > unless a certain debug option is set.
> > 
> > If it is about the way the source code looks - I guess it doesn’t sore my
> > eyes as hard as some other stuff, and I cannot do much about it (other than
> > removing it as you asked).
> 
> And yes on the above two points. It adds both runtime overhead (albeit
> trivially small) and code complexity.

It's trivially small cycle level overhead in something that will be 
burdened by two TLB flushes anyway is is utterly slow.

> > >> +out:
> > >> +	if (memcmp(addr, opcode, len))
> > >> +		r = -EFAULT;
> > > 
> > > How could this ever fail? And how can we reliably recover from that?
> > 
> > This code has been there before (with slightly uglier code). Before this
> > patch, a BUG_ON() was used here. However, I noticed that kgdb actually
> > checks that text_poke() succeeded after calling it and gracefully fail.
> > However, this was useless, since text_poke() would panic before kgdb gets
> > the chance to do anything (see patch 7).
> 
> Yes, I know it was there before, and I did see kgdb do it too. But aside
> from that out-label case, which we also should never hit, how can we
> realistically ever fail that memcmp()?
> 
> If we fail here, something is _seriously_ buggered.

So wouldn't it be better to just document and verify our assumptions of 
this non-trivial code by using return values intelligently?

I mean, being worried about overhead would be legitimate in the syscall 
entry code. In code patching code, which is essentially a slow path, we 
should be much more worried about *robustness*.

Thanks,

	Ingo
