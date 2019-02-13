Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C552C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696B8218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="kGoDZyDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391723AbfBMWtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:49:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46403 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfBMWtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:49:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so1881298pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZHYGGSpla4tBLzpH0Y4QcBdq3Osj4l3L8zG3EvPTVMc=;
        b=kGoDZyDJyazs+QIzo5XzszueRAdEwVjqm8boq63Evusu8ziGfHe7RjyBKiGE7HGIqB
         H5q4+8NLjc1RdvEFvfxx6cl7VjMPZcD4SPhxGyi1UbUohzdHA0BDKWSjPM3GnF+mxQzB
         UETATjKBHqULZCD8M7SxjyzbqOX7GnMNWD10UgBvIXerWf2PyFMu9Q4pcyWqS00zbf4o
         mSRip3p0dFKZL2vTH8ysV+WrRFchxYqAVMEq0Cpciclv0u1n/CzGImDoGR0b7NmpfQoz
         u7luQXfTEqmdRdbvd5QBPI4Lzccy0ZrQbkHWBxqF0Ok7ex6/cSY/UmKDvmItE8wMK1/V
         ajwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZHYGGSpla4tBLzpH0Y4QcBdq3Osj4l3L8zG3EvPTVMc=;
        b=q1hcAREwUljdxi3bPUpVrLKRB/FNL5X+EM8hfm0NifzpRaJel3yoUDpkh50K4sOKcr
         X4wv+Iegrg63BKivITTNVebSvIgjugKjfAb24W0vbFB8ov3ov/nax/aKInAF6wM65+W1
         gP6Zq2LheZwuW9nhIv5aKb8Sfi5LQDmx1D+pMsB6TyBmaqR21kX5NU/HZYvhmYzsxjoc
         6YDYOudcPQ+UO5wvdfbJcXLLPJOsoli9aQ43rW1hInQxGNQeEJzef7jq8VpE14Wfa2GJ
         zmNiWuv5Zt7ACtXwS9AGWK25/Y4G3Buzdhba05mEqjA/5AqEUsrioogzP/J/XoWld6Du
         Vcgg==
X-Gm-Message-State: AHQUAuaPjMIZdooWA2gR3mYn8hkj8pMfNPGXV9hRNqh9mRV55H/eDcT/
        TtYtpa6kx2I9VAjKPMiAqzHGRg==
X-Google-Smtp-Source: AHgI3IbR2LTfvgiGExkXUXTo8hYv78YRUa5KtFBV+Qe/YlkmN7Y84BZu9fVDh5e59DEiq5iPSGICzQ==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr562853pfn.91.1550098190715;
        Wed, 13 Feb 2019 14:49:50 -0800 (PST)
Received: from ?IPv6:2600:1010:b069:6503:80f2:745d:51b7:a174? ([2600:1010:b069:6503:80f2:745d:51b7:a174])
        by smtp.gmail.com with ESMTPSA id g6sm433348pgq.18.2019.02.13.14.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:49:49 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called in unsafe region
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190213222146.GC32494@hirez.programming.kicks-ass.net>
Date:   Wed, 13 Feb 2019 14:49:47 -0800
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
References: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com> <20190213103553.GO32494@hirez.programming.kicks-ass.net> <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com> <20190213131720.GU32494@hirez.programming.kicks-ass.net> <20190213140025.GB6346@brain-police> <20190213142524.GW32494@hirez.programming.kicks-ass.net> <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net> <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net> <20190213222146.GC32494@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 13, 2019, at 2:21 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Feb 13, 2019 at 10:51:24AM -0800, Andy Lutomirski wrote:
>>> On Feb 13, 2019, at 7:45 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
>>> Which I suppose means that GCC generates the PUSHF/POPF to preserve the
>>> EFLAGS, since we mark those explicitly clobbered.
>>>=20
>>=20
>> Not quite.  A flags clobber doesn=E2=80=99t save the control bits like AC=

>> except on certain rather buggy llvm compilers. The change you=E2=80=99re
>> looking for is:
>>=20
>> http://git.kernel.org/tip/2c7577a7583747c9b71f26dced7f696b739da745
>=20
> Indeed, failed to find that.
>=20
>>> For a little bit of context; it turns out that user_access_begin() /
>>> user_access_end() sets EFLAGS.AC and scheduling in between there wrecks
>>> that because we're apparently not saving that anymore.
>>=20
>> But only explicit scheduling =E2=80=94 preemption and sleepy page faults a=
re
>> fine because the interrupt frame saves flags.
>=20
> No, like pointed out elsewhere in this thread, anything that does
> preempt_disable() is utterly broken with this.
>=20
> Because at that point the IRQ return path doesn't reschedule but
> preempt_enable() will, and that doesn't preserve EFLAGS again.
>=20
>>> Now, I'm tempted to add the PUSHF / POPF right back because of this, but=

>>> first I suppose we need to figure out if that change was on purpose and
>>> why that went missing from the Changelog.
>>=20
>> That=E2=80=99s certainly the easy solution. Or we could teach the might_s=
leep
>> checks about this, but that could be a mess.
>=20
> That's not enough, we'd have to teach preempt_disable(), but worse,
> preempt_disable_notrace().
>=20
> Anything that lands in ftrace, which _will_ use
> preempt_disable_notrace(), will screw this thing up.

Ugh.  Consider your patch acked.  Do we need to backport this thing?  The pr=
oblem can=E2=80=99t be too widespread or we would have heard of it before.=
