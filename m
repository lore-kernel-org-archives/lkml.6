Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A8DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC1206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="p0fcLBY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbeLOPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:30:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44397 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbeLOPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:30:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so4059828pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LekYaE/58L2xHM4hYvdu7Np/S95B9oGIPJYTQan+ul4=;
        b=p0fcLBY0DtTuO4eaDRoA8CVzRnJBYfiVM1zS2v9DoqGX9YGrnEagmSO/dhc//ts0Kr
         BS/KVGhfaXJ/d438RapXcYELA9ID2pcJTdGL6mRfub6hBbe4uOYykWyQddfg5WJ9fh/N
         hkZb7kTWvk7+2AT1fgvmENLrih0dcA8pYG0C1YMvRCwXalmAEEXHmtlG2PjtjtNedFyF
         /WwGLUjNRQOPE3G0GIMOOZ8guh88QO4fphJM5HV47Lvsv+ouhnk6dq+bJ/SscgJ5ibie
         xhYUCK4eNJaCmgV53v1uE9HlHkkiojq404dqeH3hfQsZyMRKyphQSs5Pz0VQAXA3xwwI
         lz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LekYaE/58L2xHM4hYvdu7Np/S95B9oGIPJYTQan+ul4=;
        b=ulVFPA9ro839NQm88QZloWcxE3+X6BV0KmpK7QJ1RAv4GwbtROjcv6VN18Ef6Jxns7
         VBArzgT5PETNrGPI7M6LOyMJm3FWxtIj6sAJtpQJtWKl5VxfdycqZ6j41rO5ZX8q+N5b
         UQ3wEMo49hpUgP72UzMK5eH+KGWN0YEOn+nB0SsrfJ1JbBo2Pq3Bhn4UJhvLDpiVJJ3m
         r9DpGsm9ueEAQzBHHVUTMz3YPHvZNwRbUUB54z2qC+VCIewd9jKKCL1Pl7zNt0kjpzzR
         SZHy2ELUxnehliVwp9aMlmUz+LUoS0Qo23y8vYIZ+dz1HzvCudAUHiEH2bkYHFy+AsT2
         napg==
X-Gm-Message-State: AA+aEWalG9C6GT5sdwzlKGrtwiiWyLdCMr4V5YEuSn1qNAA6JIKn9NOO
        6neQtibZQ6fppjEtcMZS1lFduQ==
X-Google-Smtp-Source: AFSGD/U60fQ3WwEda4337qcu71KDLI4KKeiHhDc9IdBX67EsswMmk48MYrJm0+uouUEeNVgD4jFGEg==
X-Received: by 2002:a62:9419:: with SMTP id m25mr7123046pfe.147.1544887845374;
        Sat, 15 Dec 2018 07:30:45 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:94ff:ef5b:31fd:e23d? ([2601:646:c200:7429:94ff:ef5b:31fd:e23d])
        by smtp.gmail.com with ESMTPSA id d21sm12798370pgv.37.2018.12.15.07.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 07:30:44 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Can we drop upstream Linux x32 support?
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <54449048-a057-5005-1b50-b884628643eb@schoebel-theuer.de>
Date:   Sat, 15 Dec 2018 07:30:43 -0800
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB9A08ED-7D37-44C1-86D1-25E3711E3837@amacapital.net>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com> <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de> <CALCETrV0fVLZKG6JrOvzvOzP06UxhZW=LbHpPXbonoeFdPJB1A@mail.gmail.com> <35905587-2d7b-c0ab-e081-2b938d60e881@schoebel-theuer.de> <54449048-a057-5005-1b50-b884628643eb@schoebel-theuer.de>
To:     Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 14, 2018, at 11:41 PM, Thomas Schoebel-Theuer <tst@schoebel-theuer.=
de> wrote:
>=20
>> On 12/14/18 22:41, Thomas Sch=C3=B6bel-Theuer wrote:
>>> On 12/14/18 22:24, Andy Lutomirski wrote:
>>>=20
>>> I'm talking about x32, which is a different beast.
>>>=20
>>=20
>> So from my viewpoint the mentioned roadmap / timing requirements will rem=
ain the same, whatever you are dropping.
>>=20
>> Enterprise-critical use cases will probably need to be migrated to KVM/qe=
mu together with their old kernel versions, anyway (because the original har=
dware will be no longer available in a few decades).
>>=20
>=20
> Here is a systematic approach to the problem.
>=20

This is way off topic. Let=E2=80=99s not discuss it on this thread, please.
