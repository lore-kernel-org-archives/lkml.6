Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeBZMkt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:40:49 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37807 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbeBZMkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:40:45 -0500
X-Google-Smtp-Source: AH8x227GxLDloUj4r0snGXVnqMqfULbpeAFAnVbjDwXQ/X/x5d7XUaZrIGAaz3FeGQV9PEVsEY0GGw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: dmatlack@google.com
Subject: [PATCH 0/2] KVM: nVMX: expose VMX capabilities as MSR features
Date: Mon, 26 Feb 2018 13:40:07 +0100
Message-Id: <1519648809-16694-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add the VMX capability MSRs to the /dev/kvm ioctls
KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS, so that userspace
can easily probe which VMX features are actually supported by KVM.

This will help the implementation of nested hypervisor migration,
even for heterogeneous clusters.

Patch 1 is just refactoring, while patch 2 implements the feature.

Thanks,

Paolo

Paolo Bonzini (2):
  KVM: nVMX: introduce struct nested_vmx_msrs
  KVM: nVMX: expose VMX capabilities for nested hypervisors to userspace

 arch/x86/kvm/vmx.c | 367 ++++++++++++++++++++++++++++-------------------------
 arch/x86/kvm/x86.c |  19 +++
 2 files changed, 210 insertions(+), 176 deletions(-)

-- 
1.8.3.1
