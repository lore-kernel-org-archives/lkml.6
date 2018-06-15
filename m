Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052C0C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3323208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LvgO4zrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3323208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756502AbeFOUw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:52:29 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:40044 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756337AbeFOUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:52:28 -0400
Received: by mail-pl0-f45.google.com with SMTP id t12-v6so5920110plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GQOfyOBP4BLZRNnR0h2nyzfHrJobDZh+lT/NQfeAsC8=;
        b=LvgO4zrsap6mwLW1o4uQiVKcTaUuWbVlq1YQQ8zNRfT9j00ulG9ofzXPcLNE+G6ZCH
         hPFbgQZcYNhXqtywqBRZbyEtzEF8u+SRPzC8R9++lr41iG58euPfvx8QyfVpSQL3CEiG
         wX9LYXNWNrLbruEDulhTK0msyssy1Kyl1FdDwq4gZdUNZhAdkkjC3J8TD+FhJShKipVV
         NkuVYWoVl7norFewpzPDep6WhqFD907K6u9kihaYovjO11dHZ4JWhHARPqMcrM6WigmN
         bPdUg9pB/UP8o+vLzcjFTFNETPjtDqw4jIlmJGzg9TP0TQvnob8L8WUUmqbM/7NJg5VO
         zJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GQOfyOBP4BLZRNnR0h2nyzfHrJobDZh+lT/NQfeAsC8=;
        b=ZG6Of7+WG18HvxK+kLbVikdQhuWdBGO5Oow/vtvZb7V+eIbj/TbSkux4I5BOk238zf
         n7cZJ+1UQcIM2em5h0++hiyJtXaipeInpFS5a0lrBfs8rHEb/RBqhVd0EuhcUPwW7Djr
         oZgJLrduUFo7B40pVLrADgE3pTzPF29SO2Fc3H+ab7n6uKKBnLFFgtJgBuy4nhQO2VRR
         IdGlZcvH9PBcEkJiBY5dPpQS3gpW5k3/W/ue1v5oUZ2ysEOxIUVWcjdKbbe+m1r8Svgm
         Joy31ParbWqJD0evx9Jaugj3lTheK91kTiqu7QEAMJiW1/JbKt5gDbciFn+2zA1AIi9n
         X36w==
X-Gm-Message-State: APt69E1i5i64FbkjlpwkaVCBf2I7E0t+O4nI9Vn89c0DTi0bDDbplMKL
        0McOJdxVVNBilR277wJ6M25K/w==
X-Google-Smtp-Source: ADUXVKKUISOLRSd4HJg9Pe8DEq57THuHQlAlOKyjUkk/oWdc4QE65nohH4X4D97HFxTy1Nm93sKoAg==
X-Received: by 2002:a17:902:8d86:: with SMTP id v6-v6mr324500plo.325.1529095948161;
        Fri, 15 Jun 2018 13:52:28 -0700 (PDT)
Received: from ?IPv6:2600:1010:b063:8990:3528:189a:5bff:5f2f? ([2600:1010:b063:8990:3528:189a:5bff:5f2f])
        by smtp.gmail.com with ESMTPSA id y81-v6sm14014028pfd.178.2018.06.15.13.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 13:52:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <7e415c4d-415b-0ff6-5488-1681e522d2dc@linux.intel.com>
Date:   Fri, 15 Jun 2018 13:52:25 -0700
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Lutomirski <luto@kernel.org>, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63A4C722-A37E-49A8-96AC-57BFD0B2DAAB@amacapital.net>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com> <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com> <CAHmME9qhmSVNBq_GnkYrGU-PPEX9Fk0yiGktsCeEXo+LTB9KPg@mail.gmail.com> <7e415c4d-415b-0ff6-5488-1681e522d2dc@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 15, 2018, at 1:42 PM, Dave Hansen <dave.hansen@linux.intel.com> wro=
te:
>=20
>> On 06/15/2018 01:33 PM, Jason A. Donenfeld wrote:
>>> On Fri, Jun 15, 2018 at 8:32 PM Andy Lutomirski <luto@kernel.org> wrote:=

>>> quite in the form you imagined.  The idea that we've tossed around is
>>> to restore FPU state on return to user mode.  Roughly, we'd introduce
>>> a new thread flag TIF_FPU_UNLOADED (name TBD).
>>> prepare_exit_to_usermode() would notice this flag, copy the fpstate to
>>> fpregs, and clear the flag.  (Or maybe exit_to_usermode_loop() -- No
>>> one has quite thought it through, but I think it should be outside the
>>> loop.)  We'd update all the FPU accessors to understand the flag.
>> Yes! This is exactly what I was thinking. Then those calls to begin()
>> and end() could be placed as close to the actual FPU usage as
>> possible.
>=20
> Andy, what was the specific concern about PKRU?  That we might do:
>=20
>    kernel_fpu_begin(); <- Saves the first time
>    something()
>    kernel_fpu_end(); <- Does not XRSTOR
>=20
>    copy_from_user(); <- Sees old PKRU, does the wrong thing
>=20
>    prepare_exit_to_usermode(); <- Does the XRSTOR
>    // only now does PKRU have the right value
>    SYSRET/IRET
>=20
> ?
>=20
> Does that *matter* unless something() modified PKRU?  We could just make
> the rule that nobody is supposed to mess with it and that it's not
> covered by kernel_fpu_begin/end() semantics.  We could even
> theoretically enforce that in a debug environment if we watch its value.

Indeed, this case seems highly unlikely. I was imagining we have two tasks. T=
ask A enters the kernel and sleeps. Task B runs and gets its PKRU loaded. Th=
en it enters the kernel and we switch back to A. Now we have A=E2=80=99s FPU=
 state in memory and B=E2=80=99s PKRU in the register. If A does copy_to_use=
r, we lose.=
