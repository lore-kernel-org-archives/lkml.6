Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeDML1q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:27:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52083 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754348AbeDMLXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:23:35 -0400
X-Google-Smtp-Source: AIpwx4/B9ueAIsNHXnUrE5K9HacGM/M1M1cgiwjwka+5KupHhW5QUZn44pLIdRuM7wyKZbTKpORMpw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: karahmed@amazon.de, jmattson@google.com, rkrcmar@redhat.com
Subject: [PATCH 0/2] MSR_IA32_TSC fixes for nested
Date: Fri, 13 Apr 2018 13:23:25 +0200
Message-Id: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the final version of Karim's patch including a test for
MSR_IA32_TSC_ADJUST, SVM support, and a small subsequent cleanup.
I'm not sure about committing the test, since it seems easier to
do it in kvm-unit-tests (in fact, I'll shortly send the SVM version
of the test, for kvm-unit-tests) but I'm sending it anyway for
everyone's use and to post the linux.git-ized version of Google's
nested virt test framework.

Thanks,

Paolo

KarimAllah Ahmed (1):
  X86/KVM: Properly update 'tsc_offset' to represent the running guest

Paolo Bonzini (2):
  kvm: x86: move MSR_IA32_TSC handling to x86.c
  kvm: selftests: add vmx_tsc_adjust_test

 arch/x86/include/asm/kvm_host.h                   |   1 +
 arch/x86/kvm/svm.c                                |  26 +-
 arch/x86/kvm/vmx.c                                |  37 +-
 arch/x86/kvm/x86.c                                |  12 +-
 tools/testing/selftests/kvm/Makefile              |   3 +-
 tools/testing/selftests/kvm/include/kvm_util.h    |  15 +-
 tools/testing/selftests/kvm/include/vmx.h         | 680 ++++++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c        |  18 +-
 tools/testing/selftests/kvm/lib/vmx.c             |  54 ++
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c | 222 +++++++
 10 files changed, 1022 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/vmx.h
 create mode 100644 tools/testing/selftests/kvm/lib/vmx.c
 create mode 100644 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c

-- 
1.8.3.1
