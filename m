Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1D0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED072152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="f3qo0Vsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED072152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeIZWiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:38:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46143 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbeIZWiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:38:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id v19-v6so2524339ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UDwQP7CFTfD9UqfKiVP8V6knc0Dzcq6m5bKereoNnDE=;
        b=f3qo0VszZZxOLT4Z0cb0JdAdaLxZzJw3nBvOcktegne1iauNG5VxAMSSH/BELgs1li
         L3FCI0cH3imlcYLbw8z5O+cuCCWxZxZeqvn9+n4vQhH4ZGYspmCdPHQvb2m4aYBYFv6v
         CfEZcAwj9z57iEauACavO19MxoQlkhYZ17aRgkN/xkCUvpT1XXOJ/D/0lyP0+bruADZD
         z4CWiQt2flOI7WD9Nu84xfxarschk3nkRiUY6awHLwwDg2xh57G1tNTL/qsKM+O5oL1h
         ufiH5q4WwSZEsIhJHlrjZTal5bQCLqgz4svl/3/bMxlI0O+2StyrQyhtHXi0VUG6PxC3
         flsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UDwQP7CFTfD9UqfKiVP8V6knc0Dzcq6m5bKereoNnDE=;
        b=U13YNfputDnt+jPzUVrTVdPaooCgoFdJD55bT1SyWlqZ9B8w653BXVwigGCDjg3s0w
         A3eTqIivqseZnkFUlxQIwzoX/YPOnnd3xYVP45elS1/1EB8I1n6HIqE4ODNgyRSzMPE5
         wZsYMGt2E1ySQkDymaEHSJAbXKCjhhock0pyDIomN4aahMlreoERv7Sz8ERwI83vi22y
         DLvH3PEoi2KJjwAXAQqWE5QavtdA5cyC3N2Hk/AZqEO9kemBhvDaNcNH4Shnmvnahu4y
         qr4MZyKi/8YgHNDXjkuZfKTMV6lWLbILHpcHtfIjU/grUFkuBG4ucdyTOf9X/4yj4siX
         YWbA==
X-Gm-Message-State: ABuFfogtW6k/6+FsO3OzVKRpn8kPzR9frH5Q5Zg8af6s//il/f2XnX49
        dAfJDK8eiOXmMLTlU2mDlo687A==
X-Google-Smtp-Source: ACcGV61x4JPdVUY5WKkd6Vrw6eFPB1FRtGsMx160Kg0Pgx99xsbzytaC4OlGTisOf4rVmUleYy3EIA==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr6884647plg.108.1537979080606;
        Wed, 26 Sep 2018 09:24:40 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:f021:f41a:9790:a132? ([2601:646:c200:7429:f021:f41a:9790:a132])
        by smtp.gmail.com with ESMTPSA id b18-v6sm11149765pgk.15.2018.09.26.09.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 09:24:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to userspace
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20180926153229.n5rwlfhuqu42ds6v@linutronix.de>
Date:   Wed, 26 Sep 2018 09:24:38 -0700
Cc:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Denys Vlasenko <dvlasenk@redhat.com>, Ong@linutronix.de,
        Boon Leong <boon.leong.ong@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <176B4B39-6471-401C-A1E1-4B6B3FF157C3@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de> <20180912133353.20595-11-bigeasy@linutronix.de> <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net> <20180919170515.ptqmmpsxrdjsi64j@linutronix.de> <D5D1FB08-9CE8-498B-9636-C0390153814A@amacapital.net> <A5B266A3-1EF7-44A4-9AAF-1AA1858CEFCF@amacapital.net> <20180926111222.hihueuagmb4qfmtz@linutronix.de> <59E2EBC5-C483-4788-B490-4A3770DBB993@amacapital.net> <20180926153229.n5rwlfhuqu42ds6v@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2018, at 8:32 AM, Sebastian Andrzej Siewior <bigeasy@linutronix=
.de> wrote:
>=20
> On 2018-09-26 07:34:09 [-0700], Andy Lutomirski wrote:
>>> So I *think* nobody relies on FPU-emulation anymore. I would suggest to
>>> get this patch set into shape and then getting rid of
>>> CONFIG_MATH_EMULATION?
>=20
> Bryan, Denys, does anyone of you rely on CONFIG_MATH_EMULATION?
> The manual for Quark claims that the CPU has no FPU and yet the current
> kernel (or the yocto v3.14) does not select this option.
> Denys added support for some opcodes in 2015 but I didn't figure out
> *why* or which CPU in particular requires this.

Certainly the early Quark CPUs were, um, crappy. They had so many terrifying=
 errata that I=E2=80=99m surprised anyone is willing to use them.

I would *hope* that all supported Quark CPUs support FPU instructions even i=
f they=E2=80=99re microcoded and run extremely slowly.
