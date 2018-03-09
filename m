Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932664AbeCIVf0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:35:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751278AbeCIVfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:35:25 -0500
Date: Fri, 9 Mar 2018 22:34:43 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.16-rc5
Message-ID: <20180309213443.GB21100@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

for you to fetch changes up to 45e3b4759d230b057832fa751af9a853495a17bd:

  Merge tag 'kvm-s390-master-4.16-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux (2018-03-06 17:42:28 +0100)

----------------------------------------------------------------
KVM fixes for v4.16-rc5

PPC:
 - Fix guest time accounting in the host
 - Fix large-page backing for radix guests on POWER9
 - Fix HPT guests on POWER9 backed by 2M or 1G pages
 - Compile fixes for some configs and gcc versions

s390:
 - Fix random memory corruption when running as guest2 (e.g. KVM in
   LPAR) and starting guest3 (e.g. nested KVM) with many CPUs
 - Export forgotten io interrupt delivery statistics counter

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: provide io interrupt kvm_stat

David Hildenbrand (1):
      KVM: s390: fix memory overwrites when not using SCA entries

Laurent Vivier (1):
      KVM: PPC: Book3S HV: Fix guest time accounting with VIRT_CPU_ACCOUNTING_GEN

Paul Mackerras (4):
      KVM: PPC: Fix compile error that occurs when CONFIG_ALTIVEC=n
      KVM: PPC: Book3S: Fix compile error that occurs with some gcc versions
      KVM: PPC: Book3S HV: Fix handling of large pages in radix page fault handler
      KVM: PPC: Book3S HV: Fix VRMA initialization with 2MB or 1GB memory backing

Radim Krčmář (2):
      Merge tag 'kvm-ppc-fixes-4.16-1' of git://git.kernel.org/.../paulus/powerpc
      Merge tag 'kvm-s390-master-4.16-3' of git://git.kernel.org/.../kvms390/linux

 arch/powerpc/kvm/book3s_64_mmu_radix.c | 69 +++++++++++++++++++++-------------
 arch/powerpc/kvm/book3s_hv.c           | 17 +++++----
 arch/powerpc/kvm/powerpc.c             |  4 +-
 arch/s390/kvm/kvm-s390.c               |  2 +
 4 files changed, 57 insertions(+), 35 deletions(-)
