Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507C6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8C320842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AZsbhN2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8C320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeIZUr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:47:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37760 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeIZUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:47:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so7043238pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/BA/K+VMJhLc0jr7nZx57Z/qcdo1hrexFMHyPm9Fxa4=;
        b=AZsbhN2SZBy0O7C4smx0J/L9/tl+KRa1RdyadCXsRyYwjDJWt3SIaJHQ+kv9WTVuKc
         rDJ6vVAyCAc9s6qtO8BmfQJSRRwG/oWk9nojkhTtZ6AsUxnqu6WIXyEbW8hIc6aqGkXD
         Rkcv7cg9J8o1H88oZeVCXCTcv4GVCV7AGaf5JOOe6msgVoRCfq07dPSgtpLvTrR9t1HX
         72i//FTSAMPCTMwNRzZgFSEDAPuyx/bWDa5D+13Yt4mKf5Idqb3vYHENQLdF7HqVbNWh
         Zdnbf8IuVlMj7qfRaaeaq1zhCk+oLHlPhVPIQKshKJ2cle2QyLSqyqblszAaiIN5u7pp
         sr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/BA/K+VMJhLc0jr7nZx57Z/qcdo1hrexFMHyPm9Fxa4=;
        b=s4bpcAZcX3x+TQ5KvQFeSfiSG+9otb0ohZiLWNP4ug/a+xVMikSSSjCART1IgwIG6f
         4L0oE2al9jIClBImwKDmuc0G5m5CThpGsfK+6KOT2gY7Yr/bXLeIv7NnG8+G3J5v6A8f
         WWV0W+AbmrmODPdsAE7jJ1HUnEsSlviMW7hnI652MArisXyRhSDZSeLg8jTv+D/d2LfR
         tLsaTiJITaXd2x8AhmPrcvWqkm2ywAEZSMUIu2DvaeW9zvNyFtJNcNBECFuAvQotyFG5
         gKc66n2ZVLn3BTvZbn4qzFBYVJ5YzARXYH4tuObS6/hJ4bIXduwC9/LJszq89Ci/4zFF
         rg3g==
X-Gm-Message-State: ABuFfoi6KiuF3HRABIWd9prRT2HBNiT260sw/dBIsBpSzFg0ZQTOGTbO
        neXSSL9zSHqJZdKNLZaqPdRR8g==
X-Google-Smtp-Source: ACcGV63YJF1R7Dd1leu2EGKKEvFi03b32PpuMXo4m3ylvt6uUEsVth67GWD3t69RrG1c0sg7N2xaiA==
X-Received: by 2002:a62:9645:: with SMTP id c66-v6mr6760486pfe.56.1537972452613;
        Wed, 26 Sep 2018 07:34:12 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:90c8:a104:75cb:5034? ([2601:646:c200:7429:90c8:a104:75cb:5034])
        by smtp.gmail.com with ESMTPSA id t21-v6sm8647304pfi.73.2018.09.26.07.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:34:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to userspace
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20180926111222.hihueuagmb4qfmtz@linutronix.de>
Date:   Wed, 26 Sep 2018 07:34:09 -0700
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <59E2EBC5-C483-4788-B490-4A3770DBB993@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de> <20180912133353.20595-11-bigeasy@linutronix.de> <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net> <20180919170515.ptqmmpsxrdjsi64j@linutronix.de> <D5D1FB08-9CE8-498B-9636-C0390153814A@amacapital.net> <A5B266A3-1EF7-44A4-9AAF-1AA1858CEFCF@amacapital.net> <20180926111222.hihueuagmb4qfmtz@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2018, at 4:12 AM, Sebastian Andrzej Siewior <bigeasy@linutronix=
.de> wrote:
>=20
> On 2018-09-20 21:15:35 [-0700], Andy Lutomirski wrote:
>>> I mean the fpu.initialized variable entirely. AFAIK, its only use is for=
 kernel threads =E2=80=94 setting it to false lets us switch to a kernel thr=
ead and back without saving and restoring. But TIF_LOAD_FPU should be able t=
o replace it: when we have FPU regs loaded and we switch to *any* thread, ke=
rnel or otherwise, we can set TIF_LOAD_FPU and leave the old regs loaded.  S=
o we don=E2=80=99t need the special case for kernel threads.
>>>=20
>>> Which reminds me: if you haven=E2=80=99t already done so, can you add a h=
elper to sanity check the current context?  It should check that the combina=
tion of owner_ctx, last_cpu, and TIF_LOAD_FPU is sane. For example, if owner=
_ctx or last_cpu is says the cpu regs are invalid for current but TIF_LOAD_FP=
U is clear, it should warn.  I think that at least switch_fpu_finish should c=
all it.  Arguably switch_fpu_prepare should too, at the beginning.
>>=20
>> Looking some more, the =E2=80=9Cpreload=E2=80=9D variable needs to go awa=
y or be renamed. It hasn=E2=80=99t had anything to do with preloading for so=
me time.
> okay.
>=20
>> Also, the interaction between TIF_LOAD_FPU and FPU emulation needs to be d=
ocumented somewhere.  Probably FPU-less systems should never have TIF_LOAD_FP=
U set.
> Yes, they should not.
>=20
>> Or we could decide that no one uses FPU emulation any more.
>=20
> Oh. Removing unused code? I'm all yours.
> There is this Intel Quark thingy which comes to mind can still be
> bought. Its data sheet[0] has this:
> | 13.1 Features:
> | Note: The processor does not provide an x87 Floating Point Unit (FPU) an=
d does
> | not support x87 FPU instructions
>=20
> so not only it does not support the lock prefix, no, it also relies on
> soft-FPU.
> The latest bsp release notes quotes a package named
>    quark_linux_v3.14+v1.2.1.1.tar.gz
>=20
> so they still use v3.14 (which is not a supported kernel anymore).
> And then I took a look into their Yocto-BSP and found this:
> | $ fgrep -R MATH_EMULATION .
> | ./meta-intel-quark/recipes-kernel/linux/files/quark_3.14.cfg:# CONFIG_MA=
TH_EMULATION is not set
>=20
> so they don't set this option. This is small SoC and does not run on any
> Distro due to the missing lock prefix. So if they use yocto to recompile
> everything, they can rebuild their toolchain with soft-fpu support which
> is more efficient than calling into the kernel for every opcode.
>=20
> So I *think* nobody relies on FPU-emulation anymore. I would suggest to
> get this patch set into shape and then getting rid of
> CONFIG_MATH_EMULATION?

I don=E2=80=99t think you can boot a kernel without math emulation on a no-FP=
U CPU. So maybe we should table this particular idea.  I didn=E2=80=99t real=
ize there were Quark CPUs without FPU.

