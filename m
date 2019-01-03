Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E457BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD93821871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQKO+rbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfACW3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:29:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44745 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfACW3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:29:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so16479836plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 14:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8g45Lc608M9zq172pNSs7s584pqeIrrRrUw6vSURTIY=;
        b=ZQKO+rbUGwMr4e9B07O3gfx6bI3sI5hsY105L/bN5rKwb0fGyOzxtTRBnKABulM1hS
         OBvENTJ6EQ9tC5Q+/cX0k62ESHjIu05ah1QYwprsNmpdejqK2weEap1vYzKt2HoRlGVP
         D6lrURYQkAUek8cg+q9W8kVIF7uPnFznCkMkiDXu1tNTTGNQxe+S3jBMgQGKSNkH43tA
         +t3VuGMp2BfKeIDCgAlvYkAD/7Ag7LSCe/mDmff68GCfolO5mLj+UFZOLBT+09bEnS+y
         8KFXyDybtFVDA0Z5NKkFsD1m5WR3DW2R0BGpFudg5mHMPXj6nzf9/mo2u8gSlpIWaF9l
         0XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8g45Lc608M9zq172pNSs7s584pqeIrrRrUw6vSURTIY=;
        b=n7J2XWqmQVxH62hWTuoWXv8GMAoFBtfQL4T2vGf0VROTBmzaaaPhkW2kHxaKR6FbuF
         1KXBbYjbz5gsEjZlGIEcbIJTJP6Gi92cyqS1dCtvVdIOp+dEKiNJ1jzNeO636y8DkTTO
         afaM0915B95XwzIv14h7jgos4830SiVf9mjCI79pVay+iajLrl0PZIkGP9CCugnsmc5u
         Aaq7rNVsH/TooEJoZ8aDEPZ04qqaCmvxpx5L0cIfp5IsZhjkRjjzH343SuRSXS6wNF3h
         sZxGQvE21JqtP9nldZwEIDW8c++xTgbdTPLAlWI4769OLt7bM1CQX4ZHpzmHHxzGC8UL
         sRoA==
X-Gm-Message-State: AJcUukfvb7grnrDu4mJDNVd3jEJWra0EH0zcLAw1Q3lNTZmMgAzZOzpO
        zUDB9f6S4yUl/sOzWeWgK6g=
X-Google-Smtp-Source: ALg8bN7C8xyP+PRYkoJK7WGxKfn9jTNGspaBXs1vhQE9fmsXewIXugWIpq8lG5sHvdKHGzEkW1sZiA==
X-Received: by 2002:a17:902:780c:: with SMTP id p12mr47485187pll.197.1546554578771;
        Thu, 03 Jan 2019 14:29:38 -0800 (PST)
Received: from [10.2.13.140] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id m65sm98838734pfg.180.2019.01.03.14.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 14:29:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC v2 1/6] x86: introduce kernel restartable sequence
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <87va35e61a.fsf@linux.intel.com>
Date:   Thu, 3 Jan 2019 14:29:36 -0800
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <263A441C-F062-491F-9E95-F00FA2092A99@gmail.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <20181231072112.21051-2-namit@vmware.com> <87va35e61a.fsf@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 3, 2019, at 2:21 PM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
> Nadav Amit <namit@vmware.com> writes:
>=20
> I see another poor man's attempt to reinvent TSX.
>=20
>> It is sometimes beneficial to have a restartable sequence - very few
>> instructions which if they are preempted jump to a predefined point.
>>=20
>> To provide such functionality on x86-64, we use an empty REX-prefix
>> (opcode 0x40) as an indication for instruction in such a sequence. =
Before
>> calling the schedule IRQ routine, if the "magic" prefix is found, we
>> call a routine to adjust the instruction pointer.  It is expected =
that
>> this opcode is not in common use.
>=20
> You cannot just assume something like that. x86 is a constantly
> evolving architecture. The prefix might well have meaning at
> some point.
>=20
> Before doing something like that you would need to ask the CPU
> vendors to reserve the sequence you're using for software use.

Ok=E2=80=A6 I=E2=80=99ll try to think about another solution. Just note =
that this is just
used as a hint to avoid unnecessary lookups. (IOW, nothing will break if =
the
prefix is used.)

> You're doing the equivalent of patching a private system call
> into your own kernel without working with upstream, don't do that.

I don=E2=80=99t understand this comment though. Can you please explain?

> Better to find some other solution to do the restart.
> How about simply using a per cpu variable? That should be cheaper
> anyways.

The problem is that the per-cpu variable needs to be updated after the =
call
is executed, when we are already not in the context of the =
=E2=80=9Cinjected=E2=80=9D code.
I can increase it before the call, and decrease it after return - but =
this
can create (in theory) long periods in which the code is =
=E2=80=9Cunpatchable=E2=80=9D,
increase the code size and slow performance.

Anyhow, I=E2=80=99ll give more thought. Ideas are welcomed.

