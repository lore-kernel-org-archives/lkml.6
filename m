Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29ADC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AAD2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfALMa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:30:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfALMa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:30:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09FE7C057F34;
        Sat, 12 Jan 2019 12:30:56 +0000 (UTC)
Received: from flask (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5012C173C5;
        Sat, 12 Jan 2019 12:30:42 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Sat, 12 Jan 2019 13:30:38 +0100
Date:   Sat, 12 Jan 2019 13:30:38 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 5.0-rc2
Message-ID: <20190112123031.GA2992@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 12 Jan 2019 12:30:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

for you to fetch changes up to 826c1362e79abcd36f99092acd083b5a2d576676:

  x86/kvm/nVMX: don't skip emulated instruction twice when vmptr address is not backed (2019-01-11 18:41:53 +0100)

----------------------------------------------------------------
KVM fixes for 5.0-rc2

Minor fixes for new code, corner cases, and documentation.
Patches are isolated and sufficiently described by the shortlog.

----------------------------------------------------------------
Christophe de Dinechin (1):
      Documentation/virtual/kvm: Update URL for AMD SEV API specification

David Rientjes (1):
      kvm: sev: Fail KVM_SEV_INIT if already initialized

Gustavo A. R. Silva (1):
      KVM: x86: Fix bit shifting in update_intel_pt_cfg

Lan Tianyu (1):
      KVM/VMX: Avoid return error when flush tlb successfully in the hv_remote_flush_tlb_with_range()

Tomas Bortoli (1):
      KVM: validate userspace input in kvm_clear_dirty_log_protect()

Vitaly Kuznetsov (1):
      x86/kvm/nVMX: don't skip emulated instruction twice when vmptr address is not backed

 Documentation/virtual/kvm/amd-memory-encryption.rst | 2 +-
 arch/x86/kvm/svm.c                                  | 3 +++
 arch/x86/kvm/vmx/nested.c                           | 3 +--
 arch/x86/kvm/vmx/vmx.c                              | 4 ++--
 virt/kvm/kvm_main.c                                 | 9 +++++++--
 5 files changed, 14 insertions(+), 7 deletions(-)
