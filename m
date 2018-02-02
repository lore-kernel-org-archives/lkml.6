Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeBBHML (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:12:11 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39894 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeBBHMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:12:03 -0500
X-Google-Smtp-Source: AH8x225LyTYbInf0IWNkNyI/y2jb50eGi62gjirt0jWh+6Ih4k+iI8BIOKq0gXCI8qgHVThpTffuhw==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 0/2] KVM: X86: Add dedicated pCPU hint and per-VM non-HLT-exiting capability
Date: Thu,  1 Feb 2018 23:11:11 -0800
Message-Id: <1517555473-8313-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long mentioned that:

 Generally speaking, unfair lock performs well for VMs with a small
 number of vCPUs. Native qspinlock may perform better than pvqspinlock
 if there is vCPU pinning and there is no vCPU over-commitment.

This patchset adds a PV_DEDICATED performance hint to allow hypervisor 
admin to choose the qspinlock to be used when a dedicated pCPU is 
available.

In addition, according to the original hlt in VMX non-root mode discussion, 
https://www.spinics.net/lists/kvm/msg152397.html This patchset also 
adds the per-VM non-HLT-exiting capability to further improve performance 
under the dedicated pCPU scenarios.

Wanpeng Li (2):
  KVM: X86: Add dedicated pCPU hint PV_DEDICATED
  KVM: X86: Add per-VM no-HLT-exiting capability

 Documentation/virtual/kvm/api.txt    | 11 +++++++++++
 Documentation/virtual/kvm/cpuid.txt  |  6 ++++++
 arch/x86/include/asm/kvm_host.h      |  2 ++
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c                |  6 ++++++
 arch/x86/kvm/vmx.c                   | 21 +++++++++++++++++++++
 arch/x86/kvm/x86.c                   |  5 +++++
 arch/x86/kvm/x86.h                   |  5 +++++
 include/uapi/linux/kvm.h             |  1 +
 9 files changed, 58 insertions(+)

-- 
2.7.4
