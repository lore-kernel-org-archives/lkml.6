Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804F020836
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qaKlVpIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfBOS2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:28:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46010 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389396AbfBOS2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:28:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so5166159pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PiEKiV7OXlo1L7Z9MWkQ2TibsoGawYs0+jN/HTFtj5g=;
        b=qaKlVpIbVNWs/vA9F9I4fH6Hr1NEm+3INn6ksJif61pT0zQ0pU5TQPcm7RMEQM9qZu
         tPFzbJO1pZgS+7nsx9rA00Cxijuceef3F7/xySpBGtEKB/cT6+O3yh23jrtXXLAD1OXU
         nhpBI3JtB9Nze2OFJum33/piv/V7VUxKQ4ejCiqhwzt5cnkHJOioWjjFSFhNNor30r9m
         FAV8g9C1Q/QHIJPRU/gJ7Qbl2SlUCR6/Hbrf89ZdW2usDyjH9/3f28fxiAFNEjJ386n7
         ClYVpeoDQy2UIBEQm1z6tUwRG1eRZa0ao5QeMyQZPBBmQ9GWU42ms4iFAU1CmBFar2Ad
         /H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PiEKiV7OXlo1L7Z9MWkQ2TibsoGawYs0+jN/HTFtj5g=;
        b=Fo0HxmzNkvig3gBaXfoPb6y5V5FfxiIaiqMq/G4DRO65azNzeOcdeeLpqudF6ckwS1
         OpWM5wVHLArp+kUjPrX9rFJUNh8mYnt1C1CrSrRUSEaEOGoHb9pDODOodZy0TB/HIZmq
         9pag1wzEHlLQSVgDV/laUyNYTF2gL56lDMmp1AGB+8yOXMc4SCJTh3Fk1AM6YkkJhqF2
         /uXMWTyyBmdy3Mv54xLSgEwIZO+g3Zbn0Nm+9tUT4099tjE/pmcxQw8noqM4QBAY32xc
         kMDTG0apcA01+D42bhNbV+ASVFXyOvFOsVzINHlXQz6WuEb0q9+yGLGpJT7wV1V5I3UR
         RdUA==
X-Gm-Message-State: AHQUAuYcA6kG1yeT9+4IcaXFD9eIifZ5MW/XJliDiBapw695IDqzW+Sd
        4F+MwO4bSX0KslHMXKFl/M1qog==
X-Google-Smtp-Source: AHgI3Ia2Z3R+N5mt4FE+M8YXa5LIzT6YNo9F12DKe6DrcZhgqErjZRM4MX6JlppsHvz7KywcQprfyQ==
X-Received: by 2002:a65:4c01:: with SMTP id u1mr6691952pgq.116.1550255290295;
        Fri, 15 Feb 2019 10:28:10 -0800 (PST)
Received: from ?IPv6:2601:642:c400:7877:8ce1:4e59:b8f:be36? ([2601:642:c400:7877:8ce1:4e59:b8f:be36])
        by smtp.gmail.com with ESMTPSA id v75sm10743292pfa.164.2019.02.15.10.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 10:28:09 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190215174034.GP32494@hirez.programming.kicks-ass.net>
Date:   Fri, 15 Feb 2019 10:28:08 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, valentin.schneider@arm.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD23FA3D-DAF5-43C9-8888-09B4C2509460@amacapital.net>
References: <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net> <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net> <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net> <20190214101429.GD32494@hirez.programming.kicks-ass.net> <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com> <20190214193432.GR32477@hirez.programming.kicks-ass.net> <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com> <20190215174034.GP32494@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 9:40 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Feb 15, 2019 at 09:18:00AM -0800, Linus Torvalds wrote:
>>> On Thu, Feb 14, 2019 at 11:34 AM Peter Zijlstra <peterz@infradead.org> w=
rote:
>>>=20
>>> Something like the below, right?
>>>=20
>>> +       frame->flags =3D 0;
>>> +       frame->flags =3D 0;
>>=20
>> Those are not valid flag values.
>>=20
>> Can you popf them? Yes.
>>=20
>> Do they make sense? No.
>>=20
>> It has the IF flag clear, for example. Is that intentional? If it is,
>=20
> Uhmm. yeah, that's bonkers. We should have interrupts disabled here.
> I'll go read up on the eflags and figure out what they _should_ be right
> about there.

And probably add a comment near the POPF explaining that it will keep IRQs o=
ff :)=
