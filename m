Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F88C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F16020651
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 08:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lskEfy2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfBXIXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 03:23:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36272 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfBXIXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 03:23:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so6634255wrw.3;
        Sun, 24 Feb 2019 00:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=jsXIz0E0/SFnSm4B3dHmZ+iPyKy9etpCDjExoubPj3M=;
        b=lskEfy2bIJHMxhKqs6zXIe6tZ4iH8NEX2lx2CfeaeeQb4k9eWp2oWQblHEDcWceyD8
         Vkba2GyaplehjaBVJPK97di4QpSOjiQUF0XmRYDLjfNkLxkMDBqk3k7ze+z6TGm+j5Kz
         MEGIUURkixQmczoySNsVU0pt51wM+DURCiWgny73E1TshKRIfT/f0kZ+0vFQZQJWyQqn
         wC9DVGvoe7OwvKA9dyqrBQaPqBNRK+brmU5EV4G0Mi0ouwWK777SPr3aXdNIqoAVbCbv
         221GwPtfhNqSSHLAM+Ze4Q5M2yivwvhnSi4dzbJYdcuJdEcESwQLzMrseZAyB0VOhBoP
         XNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=jsXIz0E0/SFnSm4B3dHmZ+iPyKy9etpCDjExoubPj3M=;
        b=PcT67DMxnLetU2T4vBURzjhhaQaOw7C0P8X3oyRo4wjgKN3eR8gRVhUaUhI5rnNp0L
         D41tp6ywcwJTzXT5t9orPBap3g9/IGjYrkiiwTbXoZl+zRF3Hq0msT4bdDONE43+rt5e
         r9FX/F07SPYZ4g2SVZEXn1QBUQWYbxxIBlibBC73Z9iA+SKssIGERg54ROYMyonMbE8o
         oKrOJME/D7daynRlWWemKaPEW/kSL6zok7iF3c+mL2kSEGCMeAoRo+x0O9tt4D0zdiqh
         9lRESczVw1pfuOzC9uW9Vq5E6zwKRBwRZDNgCZJEv/yx9lAvj5I8H+OY3F8tvSn7vW7m
         9Lhg==
X-Gm-Message-State: AHQUAuYPQvhgNp/ZeNpWhTnWM6slKYSVGplud4Nnbrkr44Awp2CXWsbG
        IkbbT9DcZSvbTXnlxqoS37dgrVd1
X-Google-Smtp-Source: AHgI3IYpRSdAeGdu98AA/w9KEGSKn0vYDbqJJMc1xkbP84LNZ7yczhjQaZPVG1Kmz/tOzktx3WYn0g==
X-Received: by 2002:adf:9f48:: with SMTP id f8mr8923461wrg.151.1550996617931;
        Sun, 24 Feb 2019 00:23:37 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id o12sm4121122wrw.70.2019.02.24.00.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 00:23:37 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for 5.0-rc8 or final
Date:   Sun, 24 Feb 2019 09:23:33 +0100
Message-Id: <1550996613-8729-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to de3ccd26fafc707b09792d9b633c8b5b48865315:

  KVM: MMU: record maximum physical address width in kvm_mmu_extended_role (2019-02-22 19:25:10 +0100)

----------------------------------------------------------------
Bug fixes.

----------------------------------------------------------------
Paolo Bonzini (1):
      Merge tag 'kvm-s390-master-5.0' of git://git.kernel.org/.../kvms390/linux into kvm-master

Pierre Morel (1):
      s390: vsie: Use effective CRYCBD.31 to check CRYCBD validity

Vitaly Kuznetsov (1):
      x86/kvm/mmu: fix switch between root and guest MMUs

Yu Zhang (2):
      kvm: x86: Return LA57 feature based on hardware capability
      KVM: MMU: record maximum physical address width in kvm_mmu_extended_role

 arch/s390/kvm/vsie.c            |  2 +-
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/cpuid.c            |  4 ++++
 arch/x86/kvm/mmu.c              | 18 ++++++++++++++----
 4 files changed, 21 insertions(+), 5 deletions(-)
