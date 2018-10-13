Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99466C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E3320835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InrWz1A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E3320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJMRTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:19:37 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35531 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeJMRTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:19:37 -0400
Received: by mail-wr1-f49.google.com with SMTP id w5-v6so15882454wrt.2;
        Sat, 13 Oct 2018 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lOyO62DtNSSlgrRuhX5ekoALbxmnIPI6+wxdTCEr2go=;
        b=InrWz1A+0bWwVrjGqvFHScitGVDMnVk2DX8HstWRAnHcDhxkqCv5g57itYGNSWPzYa
         KZYwdgY0EGSBwW+k0kEjqICs6hK6ccXY5M02+08nS40kXwWwRRMcoqLzeKvVbiw1VrLp
         PMblxZNbjRNWlsRVNvvMyqJlP/AD/ja6R9TuYXhJtjcSsOzYUBBE+mdd1Y8eCW/eMPw7
         rqzcABHDMvYQvDaBXXEnf4DNm7/YZEcMYzFIfZbikGaqnlwUqn9iKXoJtsXkbuyu64Z6
         vQXJsaERMzoClJbxaAbP4sP6z+Q9LWoqO9m3ZeJJHkHjUxUL61MkfP4mc3P64RdbPx30
         RB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lOyO62DtNSSlgrRuhX5ekoALbxmnIPI6+wxdTCEr2go=;
        b=S8Z/QOmhgn6GuT9cekuW8UtzurCdc0bjDk4zL+wxCduJF7nTCIbbdIhMoUeXuY1SDX
         un5JaXm1smUj0E3iuVhTeasOGK0FbstOihL01G4End6GFJJSuDBjL0TT8Pj5XQxXWfoh
         1dQIJZSdv9HvvrlcnL/yAcALsxW2hGAN8aTFEpnQJ9AkabkwxoR7DQlrQAMWLhvO0Nlc
         0kcXNLqdKFKt8gPaC32Y5iaPbEjvodPSXxbdABJhrdmXexGiuH4hCGv4vT9iBSZxrSFu
         jcTJkheTTKW+GASOTOYKwEDp2KPOcJcRvv6JyyT8QXMw2tAdSUZsOsywf5q20YFk7KkK
         lJ0A==
X-Gm-Message-State: ABuFfoi+X5hO3M//GIpjNWnVUhEPcW5pfCC3Ptg3Yp0eayMykqOmbr3R
        XQSvOOViQJIgAdlLQVTjppgcUBqA
X-Google-Smtp-Source: ACcGV60nm9/epbZmRo+AXLhk2lpHzjEv8hU+GZiEGZ2//7dgVzMLEV12+BRWtqnaSkANWRg38vtaRw==
X-Received: by 2002:adf:a201:: with SMTP id p1-v6mr7923846wra.89.1539423787369;
        Sat, 13 Oct 2018 02:43:07 -0700 (PDT)
Received: from 640k.localdomain.com (dynamic-adsl-78-12-228-118.clienti.tiscali.it. [78.12.228.118])
        by smtp.gmail.com with ESMTPSA id t3-v6sm3677389wru.47.2018.10.13.02.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 02:43:05 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for 4.19-rc8
Date:   Sat, 13 Oct 2018 11:43:02 +0200
Message-Id: <1539423782-57079-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

The following changes since commit cc906f07d7d569a30bb6f0baf8f80b2968353dc9:

  Merge tag 'kvm-ppc-fixes-4.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into kvm-master (2018-10-05 09:39:53 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 5f8bb004bca43f7b5043c02b4aa5b9b43e15fe50:

  KVM: vmx: hyper-v: don't pass EPT configuration info to vmx_hv_remote_flush_tlb() (2018-10-13 11:38:54 +0200)

(The last patch shows as committed a few minutes ago because I had
unqueued it and now requeued it; I had tested it before unqueuing it.
Just telling you because I know that Linus checks this stuff...).

----------------------------------------------------------------
Leftover bugfixes.

----------------------------------------------------------------
Marc Zyngier (1):
      ARM: KVM: Correctly order SGI register entries in the cp15 array

Paolo Bonzini (2):
      KVM: x86: support CONFIG_KVM_AMD=y with CONFIG_CRYPTO_DEV_CCP_DD=m
      Merge tag 'kvmarm-fixes-for-4.19-2' of git://git.kernel.org/.../kvmarm/kvmarm into kvm-master

Vitaly Kuznetsov (1):
      KVM: vmx: hyper-v: don't pass EPT configuration info to vmx_hv_remote_flush_tlb()

 arch/arm/kvm/coproc.c | 8 ++++----
 arch/x86/kvm/svm.c    | 6 +++++-
 arch/x86/kvm/vmx.c    | 6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)
