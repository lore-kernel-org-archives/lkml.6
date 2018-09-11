Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E46C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EDE20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AMaOdGZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EDE20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIKQvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:51:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36988 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:51:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so12144504pgo.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k/wQ1DXgB2jr/G8LKBVLaVt0iL5Ml/Net+R0AvrLGmg=;
        b=AMaOdGZ8iegnQs8pHJwemQ4T692pImMFEeh8Z+Tn/YhKIhmddP/KqEb/ELd8i5hcD+
         t/EnKCEYTjs5A6eqeGeJj8SYIZ/rspB/GSlIi0PmWSuLAC8gCPdU6G5MRZt/27u9xfNO
         B2kAkS1tYsNsPCVx1EaV3khJbw+Cy3yt3vOd+NeyWjNDS3qitB68L0GABaecfHJTBThP
         /C+CD9xvfZ/SoMw4hLU8Tj+G9lu0x+BWaThacDRA0x7KqR/GZ2m10loNWtTkI+lCN5+n
         ilnRqw6A9aNFNeEMriTD35knz8Yg05+roOoVBF4eDzoyNmLvOC+rXadi7ShbQp2/KgZk
         6EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k/wQ1DXgB2jr/G8LKBVLaVt0iL5Ml/Net+R0AvrLGmg=;
        b=G5srhuxPk4uk7f16S8eHqrmvsoxBy7ePe2iuICwRtAxkW4U/E/g0W++OlJQobE2qMD
         HfMMp7R3L7cwgQIBjBoNYGDeInjYjf9VoUJuRpQgysrIKNgoM6zCfqZi+iM5tgSgYY1p
         ITWs+t86G4I3oR2Nq6MVjf6OM5nlaLTG3BTedSrlQIf0FTSB3QsR571CuRb88uqwxYWr
         5eDXWcZzVHOu9Qymel0FPyDiSvuh3mKj5z3ZO3BH00gNhs5xZD+18FXEcKWgfniquFFe
         Z9+Q/erV6Q6E0Dc7jtAUJHmwL9Mgdi0M0Qks0s5103JnufApUlspiVoQyw1Lse17pC5/
         1Row==
X-Gm-Message-State: APzg51ArupCVl/giSaS0d+GtVmrAFtrZn56n2hdf8G9H2AArMaWZYlw0
        ZaQ/s/j7uLygAFpDa+ShiTaOXw==
X-Google-Smtp-Source: ANB0VdZfhS/sS7Z2nCd+ZFCgDeVgLqLGbjSQUiJ3Yg2ou4WVKhKalWZswrriLEp2RECmA9TYEONeFg==
X-Received: by 2002:a62:68c3:: with SMTP id d186-v6mr29001747pfc.70.1536666725552;
        Tue, 11 Sep 2018 04:52:05 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:6c19:77f6:df55:1bb5? ([2601:646:c200:7429:6c19:77f6:df55:1bb5])
        by smtp.gmail.com with ESMTPSA id t14-v6sm20766140pgu.0.2018.09.11.04.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 04:52:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Random crashes with i386 and efi boots
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180910215659.GA17966@roeck-us.net>
Date:   Tue, 11 Sep 2018 04:52:02 -0700
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-efi@vger.kernel.org,
        x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net>
References: <20180910215659.GA17966@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 10, 2018, at 2:56 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> Hi folks,
>=20
> even after commit eeb89e2bb1ac ("x86/efi: Load fixmap GDT in
> efi_call_phys_epilog()"), my i386/efi qemu boot tests still crash randomly=

> (roughly 5-10% of the time). As before, I don't see much useful output in
> the qemu log (this time it doesn't even complain about a triple fault).=20=

>=20
> Debugging shows that the crash happens in efi_call_phys_epilog().
> A sample log from a crashed test run is attached below. It appears that
> the crash happens if there is an interrupt at a critical section of the
> code.
>=20
> While playing with the code, I found a possible fix.
>=20
> diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32=
.c
> index 05ca14222463..9959657127f4 100644
> --- a/arch/x86/platform/efi/efi_32.c
> +++ b/arch/x86/platform/efi/efi_32.c
> @@ -85,10 +85,9 @@ pgd_t * __init efi_call_phys_prolog(void)
>=20
> void __init efi_call_phys_epilog(pgd_t *save_pgd)
> {
> +    load_fixmap_gdt(0);
>    load_cr3(save_pgd);
>    __flush_tlb_all();
> -
> -    load_fixmap_gdt(0);
> }

We have IRQs on here?  It seems plausible that we=E2=80=99re in a window whe=
re the EFI pgd doesn=E2=80=99t have cpu_entry_area mapped. Also, the hard co=
ded CPU 0 is suspicious.

Maybe try instrumenting the code to check whether the clone_pgd_range calls i=
n setup_percpu.c have happened yet?

Your patch may well be correct, but, if we have IRQs on, we should really ha=
ve cpu_entry_area mapped in both pgds.

Or we could turn off IRQs. Why on Earth are IRQs on in a context where the f=
ixmap gdt is unusable?
