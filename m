Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3D02178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7+Yz9IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3D02178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbeHCWWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:22:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35114 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeHCWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:22:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so2992122wru.2;
        Fri, 03 Aug 2018 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=RpKiCm9T9h3Ls2tLc0PARefwiT1F3zsbm/wpgUmRGmw=;
        b=p7+Yz9IN8i3B0RHigGKO4yiD0ph2UJmxaBrToJHBkdxb7deTMdx9Ej2X+xht1gBvFm
         /Ovi79NG0HzbjbICBIVpDIy94wDZIS5GlPhyhN3mA+HxEyNM/BNfPKSN1v14ljdfXa77
         kuRb8F/Qsi+hkKLwIqy9hf5OyY78XUn1N6mw+wXuLDYIJV1JDHTm9IUPxwSTeTzD8Ep0
         twlU7YH04PdKb4DDIaXkJx3MBn8Wo38jMf5mG/9/ZD//mIrkARpw4TunBROFPdgGE2Zq
         pByH8IxdedTGNIxqnrcY+HiX2MxWderWvMNK1/AEp4vLWDM7BU+1yw8i/FQxGf/iWHO7
         Zpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=RpKiCm9T9h3Ls2tLc0PARefwiT1F3zsbm/wpgUmRGmw=;
        b=udeVvkICLWe2VzpWm+ydZdpgG3Kz/A/nrB8sP7fXbf1Lm9lHQAI7As7AhjS8bvpxG1
         hoUfdkrVUHgr50MMElYM8yUOdJn5P6bOMMLWyBN95hRCJCyLG1gPAw5iCIIOgS64NEzY
         EMd9ay9e3nqUKxQBtxlqe0uAR4HM1jFgOqueDumfA0TS69tcQDWyVJmU+00Wkhx4LiwD
         eLmq3d+IMi4nKtHISBIOukTUkxfVl6cJbxzpwHionpOvQwnpyoIDYh1FJRPRHpnE7j3k
         YPJk1eg26+tqHopr4EQ5OOm81HzIzdDgqjbWy5Myzd9qXvD4FiBF3YK6JuN2wnOgjct8
         /O8A==
X-Gm-Message-State: AOUpUlFSIAmrvU7LPb8NsWysPpztk8CHe0K081FEM1wHVN2xwazA3Dko
        SJaq+cBhyOknGdmz9MD8ZeM=
X-Google-Smtp-Source: AAOMgpfUCWgrc9Qyg97rXU1wQ1X/f1Vtg+/pWX/NgzSu00bwxI44IABBJCQDdLK/a4GD1zbD91AMtA==
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr3650044wrs.89.1533327863130;
        Fri, 03 Aug 2018 13:24:23 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-235-128.clienti.tiscali.it. [78.12.235.128])
        by smtp.gmail.com with ESMTPSA id e141-v6sm528006wmd.32.2018.08.03.13.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 13:24:22 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] Final KVM changes for 4.18
Date:   Fri,  3 Aug 2018 22:24:20 +0200
Message-Id: <1533327860-11642-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 28c20cc73b9cc4288c86c2a3fc62af4087de4b19:

  Merge tag 'drm-fixes-2018-07-20' of git://anongit.freedesktop.org/drm/drm (2018-07-19 20:17:47 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 63aff65573d73eb8dda4732ad4ef222dd35e4862:

  kvm: x86: vmx: fix vpid leak (2018-07-20 18:07:22 +0200)

----------------------------------------------------------------
Two bugfixes.

----------------------------------------------------------------
Roman Kagan (1):
      kvm: x86: vmx: fix vpid leak

Sean Christopherson (1):
      KVM: vmx: use local variable for current_vmptr when emulating VMPTRST

 arch/x86/kvm/vmx.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)
