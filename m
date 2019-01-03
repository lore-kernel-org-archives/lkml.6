Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C31DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181FE21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0iRHIoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfACWwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:52:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46842 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfACWwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:52:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so16492045ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 14:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3d//Prr5Cn7YegEGjpCafJY7IIpz0YYtLCGIAoZq/Fw=;
        b=u0iRHIoDDinkm+F/7eTdNQXogkfzpUrIW0HBjvUC/3yJRMWk/yg6wBi1nw7qTs086d
         ixpa+34ApQBekSVsY4HMX2cNlyt2QSbZ4t7T+7uPyvBWghkTPcLOaOZY+Z0vkayhkWfh
         Vw+lotD2WNEK7bTYdi4AkoiJrykZknbgPM3De7IPUZdLloFJga3Ea6Fy80o1AaIrc7bs
         Qb2HlrOkAKiDOV//7B++39COfC1/O6/NQwejtW5xgJ+f+bbnJwMgjOhrb7FnZLIy6W1H
         MhBNcos7BNBcoqe1gPTd5aXXoVlCpUOtx2ha2a+kck+jDgoSMxBC59JSZbmK7lbjjrIp
         tiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3d//Prr5Cn7YegEGjpCafJY7IIpz0YYtLCGIAoZq/Fw=;
        b=IG1gMfXJnUahpmQUwSMIn8KVSM4cAeEsrjFFI+aWD0RPFdhxgL8ucUtuwCHCmDDyLb
         AfPm02ldjFM8GL5DP/RgNufJcBIVpXDujRpCO5XQWSTa8dH/mdKvyK/j80dm+aON0i0I
         NfdSYhWhjifUFxhaPtVMv+nE0VA1AACDFmUoidK4EZKl2YBR7yDcvoFqkMuPzbQhAymJ
         vsPeXN4lo4uYpMfQnUQE+ISFiIH5E8ac+nyDFoOyeiIKxm6jBTrk0SV8SB7bUev1LXbz
         PPVLpajJGsW+jZ2Tl27Xre2qecnSjyZc3hrXR/EXiGr3AoMWE1Uq2PapxmIgw92Iz1EM
         xtAg==
X-Gm-Message-State: AJcUukfhPHXzeDxQjG+ymxAX8FPsdGEIIAbYExvkkc0JbCIXhW77Qaqo
        3aQ878pYMLYd/gzQLZjEabY=
X-Google-Smtp-Source: ALg8bN661vLQYe638WeGBCt/lc2B/oZxRvKshWHRwkeJfQs+cIJDQC8mh+AbjlpbW4pe5KmdxoAioQ==
X-Received: by 2002:a17:902:9045:: with SMTP id w5mr46671574plz.32.1546555965853;
        Thu, 03 Jan 2019 14:52:45 -0800 (PST)
Received: from [10.2.13.140] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id u8sm83154209pfl.16.2019.01.03.14.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 14:52:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC v2 1/6] x86: introduce kernel restartable sequence
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190103224835.GG6118@tassilo.jf.intel.com>
Date:   Thu, 3 Jan 2019 14:52:43 -0800
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <28F28C02-1817-4A0A-B488-216FDF22169A@gmail.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <20181231072112.21051-2-namit@vmware.com> <87va35e61a.fsf@linux.intel.com>
 <263A441C-F062-491F-9E95-F00FA2092A99@gmail.com>
 <20190103224835.GG6118@tassilo.jf.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 3, 2019, at 2:48 PM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
>> Ok=E2=80=A6 I=E2=80=99ll try to think about another solution. Just =
note that this is just
>> used as a hint to avoid unnecessary lookups. (IOW, nothing will break =
if the
>> prefix is used.)
>=20
> Are you sure actually?=20
>=20
> The empty prefix could mean 8bit register accesses.
>=20
>>> You're doing the equivalent of patching a private system call
>>> into your own kernel without working with upstream, don't do that.
>>=20
>> I don=E2=80=99t understand this comment though. Can you please =
explain?
>=20
> Instruction encoding =3D system call ABI
> Upstream =3D CPU vendors
>=20
> Early in Linux's history, naive Linux distribution vendors patched in =
their own
> private system calls without waiting for upstream to define an ABI, =
which caused
> endless compatibility problems. These days this is very frowned upon.
>=20
>>> Better to find some other solution to do the restart.
>>> How about simply using a per cpu variable? That should be cheaper
>>> anyways.
>>=20
>> The problem is that the per-cpu variable needs to be updated after =
the call
>> is executed, when we are already not in the context of the =
=E2=80=9Cinjected=E2=80=9D code.
>> I can increase it before the call, and decrease it after return - but =
this
>> can create (in theory) long periods in which the code is =
=E2=80=9Cunpatchable=E2=80=9D,
>> increase the code size and slow performance.
>>=20
>> Anyhow, I=E2=80=99ll give more thought. Ideas are welcomed.
>=20
> Write the address of the instruction into the per cpu variable.

Thanks for the explanations. I don=E2=80=99t think it would work (e.g., =
IRQs). I can
avoid generalizing and just detect the "magic sequence=E2=80=9D of the =
code, but let
me give it some more thought.

