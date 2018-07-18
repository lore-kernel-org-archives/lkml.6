Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4919ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B22820852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx9jDsHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B22820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeGRKpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:45:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37255 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeGRKpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:45:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id a19-v6so2239909wmb.2;
        Wed, 18 Jul 2018 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKZFwRKHnGrDvQJM1KoedSu5AWdJUG+8lhBLL9DzQUA=;
        b=Yx9jDsHE5t5a0OP5bLVv1pZe0zEv4FFPv30Qv+Thf4+JAW9Y5VefxDBwBW0ZGsRMTg
         +5ic8rqCSa/C6aiCTiuo3o3rEJZvqr1kKVb0i4kIFe4LiwyLTR+dbH5Wyysr/0q/13qv
         p2xDBR76t1ziSD7Tmo8437pMXnBczHi71rkBCRT0FnF7qU0UWVS3+5njmW9O4PcUhCaD
         hAmR/vtAjzOWeVFxo4lfeqkb5YSLX9D5OYf2I5wGBRTtkM5GzGL2/ue3b2+V3H7CI7Yb
         XwZ0qbXSCZuqE0fuLXpjuZMUZEG6WKu4LOwvlPMkdk4n6hN3mCSxOvj7m6Jb82h693rt
         dSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QKZFwRKHnGrDvQJM1KoedSu5AWdJUG+8lhBLL9DzQUA=;
        b=PKuTjUSHpAIILVlde0e5L8MAaMkbMwwiZ+RtlipVrD5g4l0aWtFcjCduaf4eK1J2mU
         DwZGXpSTdgRet657IOt4FvT2mp95kF/gJQEAbboDk/cpwCh1BI4NHKgo79oq5A5kTbLk
         TYcPOxbiBSCloCXdYJbF19Kz9Caj93qU59RQnwi2LBrX32PXg6PHHxALOoGzJJn8vr2A
         57FB7L6fTAu5wU28NS/GKrzu/K2bM1Zu4LZQ9+TGWcv9JCc69/n4ISQrur8Pw3IYqWpC
         IqaZCRbev9UrUmrhFp6Ql4rwiMgiTsmthMpvIdd4PRURMkdcaaeTui6P3/3/svRuPGpT
         yoiQ==
X-Gm-Message-State: AOUpUlGMqNXoMxA6It6Y3dwkMZXgOSABo8lIq8IZ4gC4TEgA9APDJbSe
        2ntsXDteCoZenlkK76KGzmzjMNyE
X-Google-Smtp-Source: AAOMgpfP9vNnKzaMr0uQcTIJTzk5FE1onWWDugE15Uto87dnonjgDycQPlxrO0zCaYXGJcZ5yTAHrg==
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr1140112wmx.75.1531908491710;
        Wed, 18 Jul 2018 03:08:11 -0700 (PDT)
Received: from 640k.localdomain.com (dynamic-adsl-78-12-156-57.clienti.tiscali.it. [78.12.156.57])
        by smtp.gmail.com with ESMTPSA id r125-v6sm3595477wmb.27.2018.07.18.03.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:08:11 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.18-rc6
Date:   Wed, 18 Jul 2018 12:08:06 +0200
Message-Id: <1531908486-20665-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 786b71f5b754273ccef6d9462e52062b3e1f9877:

  Merge tag 'nds32-for-linus-4.17-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux (2018-05-28 05:25:57 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 3a9706d9e077e4a264a5cf4045da04200b93228f:

  kvmclock: fix nested guest always in tsc_early clocksource (2018-07-18 11:31:29 +0200)

----------------------------------------------------------------
Miscellaneous bugfixes, plus a small patchlet related to Spectre v2.

----------------------------------------------------------------
Janakarajan Natarajan (1):
      x86/kvm/Kconfig: Ensure CRYPTO_DEV_CCP_DD state at minimum matches KVM_AMD

Jim Mattson (1):
      kvm: nVMX: Restore exit qual for VM-entry failure due to MSR loading

Lan Tianyu (1):
      KVM/Eventfd: Avoid crash when assign and deassign specific eventfd in parallel.

Liran Alon (1):
      KVM: VMX: Mark VMXArea with revision_id of physical CPU even when eVMCS enabled

Paolo Bonzini (2):
      KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR
      KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consumer

Peng Hao (1):
      kvmclock: fix nested guest always in tsc_early clocksource

Radim Krčmář (1):
      x86/kvmclock: set pvti_cpu0_va after enabling kvmclock

Vitaly Kuznetsov (1):
      x86/kvm/vmx: don't read current->thread.{fs,gs}base of legacy tasks

 arch/x86/kernel/kvmclock.c | 12 ++++-----
 arch/x86/kvm/Kconfig       |  2 +-
 arch/x86/kvm/vmx.c         | 61 +++++++++++++++++++++++++++++++---------------
 arch/x86/kvm/x86.c         |  4 ++-
 virt/kvm/eventfd.c         | 17 ++++++++-----
 5 files changed, 63 insertions(+), 33 deletions(-)
