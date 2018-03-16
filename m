Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeCPNtD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:49:03 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36957 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPNtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:49:02 -0400
X-Google-Smtp-Source: AG47ELvgUedjUiS7SkAORr1eT1RbGkWxUZV5wOFemgNDoAne3GXU1IHjXgFR317hu9q3wSxIs2J69sLiAqwe+2p+AHE=
MIME-Version: 1.0
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 16 Mar 2018 14:49:00 +0100
Message-ID: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
Subject: arm64 kvm built with clang doesn't boot
To: Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Hines <srhines@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: kernel-dynamic-tools <kernel-dynamic-tools@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've recently tried to boot clang built kernel on real hardware
(Odroid C2 board) instead of using a VM. The issue that I stumbled
upon is that arm64 kvm built with clang doesn't boot.

Adding -fno-jump-tables compiler flag to arch/arm64/kvm/* helps. There
was a patch some time ago that did exactly that
(https://patchwork.kernel.org/patch/10060381/), but it wasn't accepted
AFAICT (see the discussion on that thread).

What would be the best way to get this fixed?

I've also had to disable CONFIG_JUMP_LABEL to get the kernel boot
(even without kvm enabled), but that might be a different (though
related) issue.

Thanks!
