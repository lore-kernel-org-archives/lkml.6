Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA42C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2FD2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EsAtrZ//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfBSCUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:20:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46266 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfBSCUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:20:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so9315726pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9dEGfOdaZR9UmprPukicFRnBioLR7q9r/00bep9K4pw=;
        b=EsAtrZ//e/1T7N4Bghm7Uoy58cCNQKqgsTCgI+fuvA7ypKSXAYBPbMzqOwxjmEy588
         cyt9/BeL2f6s69J11qZt0bLU4qvlryNr8phBSpmsBl3PQ9fhMnk5S9femWlqb942IeqR
         KtluLfsQTYLwkyGQpZuf3HDdMETmQ1sHjtEDlIF9ZruD3bhe/XbBtGh4z801pPqpfYvL
         v807Sa/Ycj1rl/N9bqZ6znibwyBJ+D+FjdezmKXCxwFut1pHwZN15yUiAfDjZoxcAEd3
         Qno5sa1LJdVc6NtAXHEPsySHQA8qb1+HfrKXSUsd627+Zlc9IzKjG/sF7LUEKPovdvJB
         HOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9dEGfOdaZR9UmprPukicFRnBioLR7q9r/00bep9K4pw=;
        b=Il52M8RgxKNkt/DWxCoDZ693ksZjO2vdGiChGAZGx3UHWL51dIES35UwTBMgWyRa/t
         E3lRzjgCW7YlzgKC72whlpF3Vh3F2SW5wqwbIGRvUt18ODKuhAPsdaoM8pM9fVpTqdmB
         hkq9dGmG+SJCcYAVMokFIxfPZ+p4jshggw/DYNTMcZWUnfeszmo5Wrzv5zOBomPHljrr
         BAUhvMKZIikJe4NS7WHKl8t4Fb0OAqFQy5H+boFhrkABqEPfXN3OUfm1Ml/H4ily0IID
         s42FKNRdVFUya1i0sARrA10csMb3mNORLybpzNteMQMEvW4zfkqiObRqzXsGxZ4Yl7fW
         QaXA==
X-Gm-Message-State: AHQUAub6TQlHO3gNE8M+SriVMvzLJdxyy1MGXgnSZOtynufTc5cDk8v4
        s8rnHn+D+prAMc+tXX0GMajdAw==
X-Google-Smtp-Source: AHgI3IZrR9G/yTFJgm9MA9PQNptFapkxMSRL3GofSv38CE9+MatSTVBTiHMPBQ8q98QIezLXHj3u8Q==
X-Received: by 2002:a65:500c:: with SMTP id f12mr21322119pgo.226.1550542809497;
        Mon, 18 Feb 2019 18:20:09 -0800 (PST)
Received: from ?IPv6:2600:1010:b009:23ae:dc4e:d4db:1aa:7738? ([2600:1010:b009:23ae:dc4e:d4db:1aa:7738])
        by smtp.gmail.com with ESMTPSA id l12sm6222094pgn.83.2019.02.18.18.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 18:20:08 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
Date:   Mon, 18 Feb 2019 18:20:07 -0800
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <573ACC45-4537-46D0-93D9-4091D7CB6090@amacapital.net>
References: <20190213140025.GB6346@brain-police> <20190213142524.GW32494@hirez.programming.kicks-ass.net> <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net> <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net> <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net> <20190214101429.GD32494@hirez.programming.kicks-ass.net> <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com> <20190216103044.GR32494@hirez.programming.kicks-ass.net> <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com> <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 18, 2019, at 4:24 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Mon, Feb 18, 2019 at 2:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>=20
>> The question is what "fix it" means. I'm really concerned about AC escape=
s,
>> and everyone else should be, too.
>=20
> I do think that it might be the right thing to do to add some kind of
> WARN_ON_ONCE() for AC being set in various can-reschedule situations.
>=20
> We'd just have to abstract it sanely. I'm sure arm64 has the exact
> same issue with PAN - maybe it saves properly, but the same "we
> wouldn't want to go through the scheduler with PAN clear".
>=20
> On x86, we might as well check DF at the same time as AC.
>=20
>=20

hpa is right, though =E2=80=94 calling into tracing code with AC set is not r=
eally so good.  And calling schedule() (via preempt_enable() or whatever) is=
 also bad because it runs all the scheduler code with AC on.  Admittedly, th=
e scheduler is not *that* interesting of an attack surface.=
