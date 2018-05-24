Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032608AbeEXSYo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:24:44 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35784 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030470AbeEXSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:24:40 -0400
X-Google-Smtp-Source: AB8JxZoNIOBoGy4wcLYupArquEPWLGpZDr5+Zhu0ANIBusPSWZ/7Dp/zQThEZlE9Vh9CSObvONyHYFovJnf8CYRoefs=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <57C635C3-716C-4FC3-90C7-E394AA7242BA@zytor.com>
In-Reply-To: <57C635C3-716C-4FC3-90C7-E394AA7242BA@zytor.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 24 May 2018 11:24:28 -0700
Message-ID: <CAKwvOdndRL6gs29eQQrL+bVNBt1fjrXS=mBgF4CRshz+J5LY-Q@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:20 AM <hpa@zytor.com> wrote:
> A stack canary on an *inlined* function? That's bound to break things
elsewhere too sooner or later.

But it's *not* inlined by GCC or Clang.

While the function is marked `static inline`, it's not in
arch/x86/kernel/paravirt.o due to:
arch/x86/kernel/paravirt.c:326

325 __visible struct pv_irq_ops pv_irq_ops = {

326         .save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),

see comparison of disassembly  attached in:
https://bugs.llvm.org/attachment.cgi?id=20338
-- 
Thanks,
~Nick Desaulniers
