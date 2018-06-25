Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F05AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2477925D0F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="elLp9Z2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2477925D0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeFYPkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbeFYPkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:40:52 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D0A25D13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529941251;
        bh=FMs8kLQkXW7qK74p1r0XR2juYvDJ+pFMaTUj4zPd2tY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=elLp9Z2pKxcsbuir7acWfAJH9UNpAvoQxaXuI+1t62LZ99kxyk0j58u2mB1moqxLU
         dtGEAK58q79tgYNPhJ0/WWkw+glNGkBPEWBVs19ouCsdnoti2Pe91Yx40PtHMC4kKb
         nrzOgkI3ZKuhO0pqByvX7UNMcxYW8szQd6UX03HA=
Received: by mail-wm0-f45.google.com with SMTP id w137-v6so4491025wmw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:40:51 -0700 (PDT)
X-Gm-Message-State: APt69E07jgf1O4kHM+JQkd4f9RBCCTbNSg9ovN+Rpwyjdet1mfr2yjZw
        EgejBJ4Cfl82iwg4zGghQlnDpHNOEWD2vEaTqSJr2g==
X-Google-Smtp-Source: AAOMgpfIMYKJd9/d1tc8yBXfJT9aqEKRp1/S7Rp6B63YhMmSmKAJgFgbT58j++n+clrg7I+CYREoVm5x15dNFcZNCMg=
X-Received: by 2002:a1c:6c14:: with SMTP id h20-v6mr1355175wmc.144.1529941249709;
 Mon, 25 Jun 2018 08:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <0d78b5b4-710e-1b41-46e1-74003ca1381e@intel.com>
In-Reply-To: <0d78b5b4-710e-1b41-46e1-74003ca1381e@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Jun 2018 08:40:37 -0700
X-Gmail-Original-Message-ID: <CALCETrVLRmySnqpG+o-S9VGkx7uKFfLGeawyM7UDCRj_g7vs1g@mail.gmail.com>
Message-ID: <CALCETrVLRmySnqpG+o-S9VGkx7uKFfLGeawyM7UDCRj_g7vs1g@mail.gmail.com>
Subject: Re: test_syscall_vdso_32 [FAIL]
To:     zhijianx.li@intel.com
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:41 AM Li Zhijian <zhijianx.li@intel.com> wrote:
>
> Hi
>
> Intel 0Day noticed that test_syscall_vdso_32 failed since 8bb2610bc4967f1=
9672444a7b0407367f1540028(x86/entry/64/compat: Preserve r8-r11 in int $0x80=
)
>
> 2018-06-25 14:23:00 make run_tests -C x86
> make: Entering directory '/usr/src/linux-selftests-x86_64-rhel-7.2-8bb261=
0bc4967f19672444a7b0407367f1540028/tools/testing/selftests/x86'
> gcc -m32 -o /usr/src/linux-selftests-x86_64-rhel-7.2-8bb2610bc4967f196724=
44a7b0407367f1540028/tools/testing/selftests/x86/test_syscall_vdso_32 -O2 -=
g -std=3Dgnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_sy=
scall_vdso.c thunks_32.S -lrt -ldl -lm
> TAP version 13
> selftests: test_syscall_vdso_32
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [RUN]   Executing 6-argument 32-bit syscall via VDSO
> [WARN]  Flags before=3D0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
> [WARN]  Flags  after=3D0000000000200606 id 0 00 d i 0 0 p 1
> [WARN]  Flags change=3D00000000000008d1 0 00 o s z 0 a 0 0 c
> [OK]    Arguments are preserved across syscall
> [NOTE]  R11 has changed:0000000000200606 - assuming clobbered by SYSRET i=
nsn
> [OK]    R8..R15 did not leak kernel data
> [RUN]   Executing 6-argument 32-bit syscall via INT 80
> [OK]    Arguments are preserved across syscall
> [FAIL]  R8 has changed:0000000000000000
> [FAIL]  R9 has changed:0000000000000000
> [FAIL]  R10 has changed:0000000000000000
> [FAIL]  R11 has changed:0000000000000000
> [RUN]   Executing 6-argument 32-bit syscall via VDSO
> [WARN]  Flags before=3D0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
> [WARN]  Flags  after=3D0000000000200606 id 0 00 d i 0 0 p 1
> [WARN]  Flags change=3D00000000000008d1 0 00 o s z 0 a 0 0 c
> [OK]    Arguments are preserved across syscall
> [NOTE]  R11 has changed:0000000000200606 - assuming clobbered by SYSRET i=
nsn
> [OK]    R8..R15 did not leak kernel data
> [RUN]   Executing 6-argument 32-bit syscall via INT 80
> [OK]    Arguments are preserved across syscall
> [FAIL]  R8 has changed:0000000000000000
> [FAIL]  R9 has changed:0000000000000000
> [FAIL]  R10 has changed:0000000000000000
> [FAIL]  R11 has changed:0000000000000000
> [RUN]   Running tests under ptrace
> not ok 1..1 selftests:  test_syscall_vdso_32 [FAIL]
> make: Leaving directory '/usr/src/linux-selftests-x86_64-rhel-7.2-8bb2610=
bc4967f19672444a7b0407367f1540028/tools/testing/selftests/x86'
>
> This commit changed the testcase expected behavior, but looks it doesn't =
work as expected.
> so want to consult whether 0Day missed something(special configurations) =
to this case ?
>
> if more details are needed, please let me know.

Can you double-check that you're running the tests on an updated
kernel?  The error you're getting makes it look like you've applied
the patch to selftests but not to the kernel.
