Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59AAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E32A27AC7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="N/PFBDbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E32A27AC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936383AbeF2BI3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 21:08:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40836 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935756AbeF2BIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 21:08:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so3395434pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x08qc6Gpfl36CZkjNZGTU9skkGLRcSwyuws3UIhyuVA=;
        b=N/PFBDbl7bVWWiyXPeiSiMRiaPVN+0b8lTrRvmZ+xJcqmlVQOhK7ZYZrZjAjSrji+U
         1pB5kcwdMPI2vUyGB5glzplPfmXKisOfNB6ibkpSLadxzpzgcON9H50H/s6F47IeHJJJ
         YOowkEipfgkcLROPk2v6fds7cuYMMw2uZnBrb8MOemFGzQU+BM6ZDqeNtPDE0OPSqgXA
         /2OVROiFwRfwREysV41J0x4y7dXGzR/C0SMg5kKCTPanAOePGcfUMr3r7RYnWhsq0piA
         bVAOgChJNHffrhQXekpWDqQrnoxvfXBUlqe4+lMgEn9yF2fDtkWq4PTt7UZNAFh5+Y06
         i2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x08qc6Gpfl36CZkjNZGTU9skkGLRcSwyuws3UIhyuVA=;
        b=A3ekDSes29wqv8+eFhPe1JWu0ONoIczBML7Ty0s7CRReJFfDm/YjnN1AJvi99rv9M+
         0trfCihv0j1CRtN5k7WWEAxeE1R+4zwdXmuXqEt3twxFhoGNrGF34UNi3mqDrzQmh3ju
         iZTy7h100BgtNZ+CGIZJbM7gkWtYwYq7zW4tIDggytx9V05mOXdj547GzkDcDfdWQmO/
         7G+d9m56sN7XrBKEQLFJI1XT9o3xndi2Y/Cd1q+Es/RDRIOmr8PpONyzv2You+Hsc01h
         Dv7dZ074wO5HBeH2o9qex6Em/Cr46Z6u7QwpJ99w1KAD6ghv2ntYHB7c+k8MqWaZVJSS
         yNpw==
X-Gm-Message-State: APt69E2m09XZ02IYIs4E9tVu2hnvYeOZHRwFv/a/7YUYj5LyFcDfkPh3
        pH4dFpsjCR7nMmKEN5FBcKlCig==
X-Google-Smtp-Source: AAOMgpdnykXa1qkb5N+yJKL0ctkn4TERueiIXktQk5BOl89QjiHK4rkoRILUiAYziJEmYtLl1Vh5Hw==
X-Received: by 2002:a62:9945:: with SMTP id d66-v6mr12269602pfe.192.1530234503135;
        Thu, 28 Jun 2018 18:08:23 -0700 (PDT)
Received: from ?IPv6:2600:1010:b067:208c:c51e:d6f0:926d:cddf? ([2600:1010:b067:208c:c51e:d6f0:926d:cddf])
        by smtp.gmail.com with ESMTPSA id i9-v6sm3544360pgt.47.2018.06.28.18.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 18:08:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com>
Date:   Thu, 28 Jun 2018 18:08:20 -0700
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, joelaf@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com> <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com> <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com> <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 28, 2018, at 5:18 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Thu, Jun 28, 2018 at 4:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> The idea is that, if someone screws up and sticks a number like
>> 0xbaadf00d00045678 into their rseq abort_ip in a 32-bit x86 program
>> (when they actually mean 0x00045678), we want to something consistent.
>=20
> I think the "something consistent" is perfectly fine with just "it won't w=
ork".
>=20
> Make it do
>=20
>        if (rseq_cs->abort_ip !=3D (unsigned long)rseq_cs->abort_ip)
>                return -EINVAL;
>=20
> at abort time.

You sure?  Because, unless I remember wrong, a 32-bit user program on a 64-b=
it kernel will actually work at least most of the time even if high bits are=
 set. I=E2=80=99m okay with straight-up promising =E2=80=9Cwill always work=E2=
=80=9D or =E2=80=9Cwill never work=E2=80=9D, but =E2=80=9Csometimes=E2=80=9D=
 is bad.

>=20
> Done.
>=20
> If it's a 32-bit kernel, the above will reject the thing, and if it's
> a 64-bit kernel, it will be a no-op, but the abort won't work in a
> 32-bit caller.
>=20
> Problem solved.
>=20
>             Linus
