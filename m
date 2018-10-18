Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D01FC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1152098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LFEgt4kW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1152098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeJSGBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:01:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35284 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:01:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so3632913pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SsYQRzp9Y9EowT8w7pXhhEuLE3rv1uvmE5mK6UjAHX4=;
        b=LFEgt4kWmUU8PY5PsG9zKbLqmOuqBHag/W6JD4WhjNvwLCVRbSWNV9vrEun7ECJmuH
         Z1cP7+cmjCSXoWYadbRcaCQJX5sUOoqoXKsbqYSpdSiDMVqTJzakVNBa9jOXfuaBpB8H
         3kKIjFn1k8cZ83r94YsUkvz95mnXamfQ2qZRwbu97c6loX6OkoTd+zL6ctoT1BF9q91Z
         ZLJoW/SHI7G7brvUq+ZTvUzvcxjHul+pDe7TuZOjVZEJJLgeO8rO9eILZ7o4onILigbF
         CKerPs1ZMvUU8txQzP/1T55FtOoZH+9/PWZR5kYvFRrBHhSXyZwFoVWXlldb++m24tDw
         wHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SsYQRzp9Y9EowT8w7pXhhEuLE3rv1uvmE5mK6UjAHX4=;
        b=JaoFMsOM5vXlFFesDgEZYKKizcBq8VDlH2F0ZNIhbvC2+HeRQa9iNFS5txrWXI5VJE
         AiMSFwz8PgKeoN6dgJYaohxuVfiimFSX3Qw9RWC+fo55Ish5CTpYR6OEmJfnUZ6c9a4r
         usH9YRTwujgTyCaTMK/KqwUcsg5p4fE18gAY/nXZFTDkpxN7arQiAo6OTGjcdhxV/Nn1
         zN1SjYtb6rV0/NDTVNx9akyKIsQxwxHxct74srQq559rVmbFUEOkMtrakaxU7NZUF5w1
         gntRggNucZBzksZ4OBiTr4SEO7qOxtQYcCCYUyaM7sHY6LpXS16rX1i4tfkvAYRq5O+X
         xHlA==
X-Gm-Message-State: ABuFfoiuR3Bv2Fx/6eNWvelbljzbdQJ8wPP7gaEM6S3I2Wv0VPr6wdde
        NJuL+3H7PQY8dzAtT2OoAewh2w==
X-Google-Smtp-Source: ACcGV62TW2+Il+9/RT1R3OuJSCD+h+MIImONiMgB2iis2GimU61wPkmi36TeeRkxrvDCox94WYGpHw==
X-Received: by 2002:a63:5c1f:: with SMTP id q31-v6mr30199432pgb.452.1539899898835;
        Thu, 18 Oct 2018 14:58:18 -0700 (PDT)
Received: from ?IPv6:2600:1010:b055:c039:8d1c:3674:f40d:d2a1? ([2600:1010:b055:c039:8d1c:3674:f40d:d2a1])
        by smtp.gmail.com with ESMTPSA id s13-v6sm45568514pgs.76.2018.10.18.14.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 14:58:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181018212421.ndjtawc34cqdycyy@linutronix.de>
Date:   Thu, 18 Oct 2018 14:58:16 -0700
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6DB636D-0021-48A4-98C5-7F4B3DFC98D2@amacapital.net>
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-6-bigeasy@linutronix.de> <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com> <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com> <20181018162644.qqjkzoqn2fleyi2b@linutronix.de> <CC7B46F7-7A6E-4CAF-A1EB-91271CC7B092@amacapital.net> <20181018182538.vgotfpsdy7qxl2tg@linutronix.de> <CALCETrVjEOkNhdyAF10PaYi_rnFUWKRqPhLRCq3ZV=gxQFETxg@mail.gmail.com> <aedef390-2fb1-8c09-3a69-53d3fd0505da@linux.intel.com> <20181018212421.ndjtawc34cqdycyy@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2018, at 2:24 PM, Sebastian Andrzej Siewior <bigeasy@linutronix=
.de> wrote:
>=20
> On 2018-10-18 13:56:24 [-0700], Dave Hansen wrote:
>>> But this is not the only loophole: There is ptrace interface which is
>>> used by gdb (just checked) and also bypasses PKRU. So=E2=80=A6
>>=20
>> Bypassing protection keys is not a big deal IMNHO.  In places where a
>> sane one is not readily available, I'm totally fine with just
>> effectively disabling it (PKRU=3D0) for the length of time it isn't avail=
able.
>=20
> Okay, this makes things easier. Let document that for kernel threads we
> use PKRU=3D0. This should be happening in my try right now. I double check=

> tomorrow just in case=E2=80=A6
>=20
>=20

If you document that, please at least document that it=E2=80=99s a bug and n=
ot intended behavior.=
