Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeD3P7s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:59:48 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37004 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeD3P7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:59:47 -0400
X-Google-Smtp-Source: AB8JxZq+vaag6LZ5GdR7+EK6P+oZbZ5nxrt2o0Ju0i6rNOkA2sBSjJmPk2XutsLTq4ZyXMTpRHgnPGUmXgnymrZs2XY=
MIME-Version: 1.0
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date: Mon, 30 Apr 2018 17:59:46 +0200
Message-ID: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com>
Subject: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2 mitigation.
To: kirill.shutemov@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3UFxt9W001995

Hi,

In v4.16 I already had support for BPB, IBRS_FW for spectre_v2 mitigation.
But this went away in v17-rcx.

With 4.16 I have:
jojo@fichte:~$ cd /sys/devices/system/cpu/vulnerabilities; grep ".*" *
meltdown:Mitigation: PTI
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Mitigation: Full generic retpoline, IBPB, IBRS_FW

With 4.17-rcx I have:
meltdown:Mitigation: PTI
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Mitigation: Full generic retpoline

Processor is
vendor_id       : GenuineIntel
cpu family      : 6
model           : 60
model name      : Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
stepping        : 3
microcode       : 0x24


The problem goes away if I revert:
d94a155 x86/cpu: Prevent cpuinfo_x86::x86_phys_bits adjustment corruption

Thanks, Jörg
