Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0509218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDVIlylH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfBKUcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:32:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33083 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKUco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:32:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so122848pfb.0;
        Mon, 11 Feb 2019 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LYEtQ0huIgRqRN72HKrMf6/t6SbOdkntokaFuVtRuwA=;
        b=jDVIlylHgLecqgbUr9f9MSgPipvsjbdmdR5Ccr2YQlrg8Dl3zqXWhKCYsO4R+DrurX
         7hYnNc7fJOMhgnQXkTxvObqSsJdhA/mCfjYLko+GOmny8Nx+Oqul4Zl47Vws1RT5rvb2
         VkSxW3G7r66YWNusKQi1YYB1tqYKEStyT1xd7ee/68a8W21/5rfFlIkYQitSNbAgpiQN
         r2JetYqDze242ZhQyJy8JJrrOhQXIaJXFOMdOTCgTNJTzdrHXaO010kBDmABT040pMGM
         ub8BvmNjymWv1dZyTxhLNANe9rda/SV4OTHtRTTKcxnrIgvLnJvd7w4IETjI0SKnVdpj
         uuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LYEtQ0huIgRqRN72HKrMf6/t6SbOdkntokaFuVtRuwA=;
        b=O3TP0IegOWTaCGiPMa5cwPXHwGFV+NThe2n64VDqJUjzrMVgsu1EnWuLtC7HRRaT6V
         NySWN+ePxbZm9LGhDiIvntr7OZi6nwKhjhRao2owKySB2HJ+0Mk8CaVdw6NJKzWflf8S
         1yb22ov6ZixJ4dSYUMgsPJFTjUnfcSdurWU2/7NOYf+1YvUauUtkoeg4FEXgB/hRPGZU
         LJb9lWjagz6iyYnMsA2VE5w7E8V5yQFV8K6efr4PP8ZbZE0aHlyNQO9L9usC74u0gFhs
         7MAdlLsN+RBKFo87g+vN2oyP0xPDwXTzRs+ahVfydk/oGTLUmFhkBTqyexDeE90hYPk5
         dWkw==
X-Gm-Message-State: AHQUAubNqd4kFq0kStGE1GR8AfTDllh1zoYdAagM/oQka5t9yyzLq7l2
        eqDXEDSsVudUmcnNn0ralD8=
X-Google-Smtp-Source: AHgI3IY/t2t2yc8abbgd4X3ggvCGVF2OGRCQro2+hmH3yq84NbHtsVFoO6+n44jfzy8/G4hRQTyUTw==
X-Received: by 2002:a65:6684:: with SMTP id b4mr64478pgw.55.1549917163761;
        Mon, 11 Feb 2019 12:32:43 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id c23sm12753759pgh.73.2019.02.11.12.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 12:32:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 10/20] x86: avoid W^X being broken during modules
 loading
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190211194251.GS19618@zn.tnic>
Date:   Mon, 11 Feb 2019 12:32:41 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A55214F3-CDC0-44C4-AFB6-7E8E23CC6F85@gmail.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-11-rick.p.edgecombe@intel.com>
 <20190211182956.GN19618@zn.tnic>
 <1533F2BB-2284-499B-9912-6D74D0B87BC1@gmail.com>
 <20190211190108.GP19618@zn.tnic>
 <A671F14F-3E03-4A97-9F54-426533077E0C@gmail.com>
 <20190211191059.GR19618@zn.tnic>
 <3996E3F9-92D2-4561-84E9-68B43AC60F43@gmail.com>
 <20190211194251.GS19618@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 11, 2019, at 11:42 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Mon, Feb 11, 2019 at 11:27:03AM -0800, Nadav Amit wrote:
>> Is there any comment over static_cpu_has()? ;-)
>=20
> Almost:
>=20
> /*
> * Static testing of CPU features.  Used the same as boot_cpu_has().
> * These will statically patch the target code for additional
> * performance.
> */
> static __always_inline __pure bool _static_cpu_has(u16 bit)

Oh, I missed this comment.

BTW: the =E2=80=9C__pure=E2=80=9D attribute is useless when =
=E2=80=9C__always_inline=E2=80=9D is used.
Unless it is intended to be some sort of comment, of course.

