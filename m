Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeDSRGg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:06:36 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:53090 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeDSRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:06:33 -0400
X-Google-Smtp-Source: AIpwx4/GAfJ6w2WGUDacHaey7ahvfi1T2DhsZojyX6jH4ViyP+jY0TP2UHvMalK/QV3WdPE4ypzcTsy3HpwBVCgQrXE=
MIME-Version: 1.0
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 19 Apr 2018 19:06:31 +0200
Message-ID: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
Subject: Clang arm64 build is broken
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc!

Your recent commit [1] broke clang build on arm64. The issue is that
clang doesn't know about the "S" asm constraint. I reported this to
clang [2], and hopefully this will get fixed. In the meantime, would
it possible to work around using the "S" constraint in the kernel?

While we're here, regarding the other issue with kvm [3], I didn't
receive any comments as to whether it makes sense to send the fix that
adds -fno-jump-tables flag when building kvm with clang.

Thanks!

[1] https://github.com/torvalds/linux/commit/44a497abd621a71c645f06d3d545ae2f46448830

[2] https://github.com/ClangBuiltLinux/linux/issues/13

[3] https://lkml.org/lkml/2018/3/16/476
