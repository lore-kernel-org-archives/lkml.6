Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0325C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E419208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBZrUi3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E419208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbeG0STa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:19:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35910 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbeG0ST3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:19:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so5724381wro.3;
        Fri, 27 Jul 2018 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zzGTrQy/l+HcCYm6ELnPpwdLxLB3q39BELBPsRJFhT0=;
        b=DBZrUi3BAHIU1xJmCRhF2KSGeeGNuu3t8vkzC1hjO6BOao7Jz67t66pFL4mPshmNes
         QSIRfcndhrtHcV0SAXOmfcOWq7Y9BT/c0SIvTOvPgOXoGt9TPYzsW0GmJ80aiPlpTl+l
         zDKTT56Eekjn+hSK9I+tEEZ7GjasJ0ieVAoQtlUTk2bQUgwaqkgqT1slIH2cLyRwB7kt
         gsZF7bnYooIhGU61dp9wOVko4ceX2TRVTirMrB3SD6ccC/+lZTa0RD5XG9srZeDn80/4
         ZtM1c0gnhUi2j3O9yIfYsNL8eEO4MQi1/AAWv3/Owj2c5pRtJky7a9U95Ckprk7o07Q1
         p52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zzGTrQy/l+HcCYm6ELnPpwdLxLB3q39BELBPsRJFhT0=;
        b=B5DW0eqAp/71ZqGvePoURVme/n9kNPAkKaImMtb5V95awlSxnY/EjiW/bkn1m43hN0
         4qvw3u1Hf9WZEtPWHR3+FkaVJd+l60HKwixBKKftXf8k4JIz2d/gXn19AVywN6DPAneB
         75w6m07XBI893oqF0c8s8R7m/5FbNmfpm09j65ImW67hfYPkDIE9WfeNN3pH4Mohrm3V
         W0W/PBpha8eXj9qWvMzWzMaaskj6E96GC4E0jfBLWp1D32T/JdGGyA7cHBC6INq+1Gud
         kRNtt8Gvm1x/Pnf7lHyYa2hl3vtIYjEyAMLZdMJdeTSLVlvSSzNl+1mrfAV7gVrrKdtE
         N/Dg==
X-Gm-Message-State: AOUpUlEHmVzPZA6o5dLD+KLghGRp8Yq3LJf7QUzhw91WBj/3rlc97u6C
        m6MqbNdGL4aM/bKvfS4TLeCD5UI3
X-Google-Smtp-Source: AAOMgpfS58/33Qd6ZwpdWPXfTIa1yOLCum9pI/uYUpveXZbhssPhf8bDvUTVPSPlU0RoxZBi8e3gZw==
X-Received: by 2002:adf:b69c:: with SMTP id j28-v6mr5679641wre.200.1532710603484;
        Fri, 27 Jul 2018 09:56:43 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id u185-v6sm5528184wmg.25.2018.07.27.09.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:56:42 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com
Subject: [PATCH rebase/RFC 0/4] x86/kvm/nVMX: optimize MMU switch between L1 and L2
Date:   Fri, 27 Jul 2018 18:56:37 +0200
Message-Id: <1532710601-45449-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebased version of Vitaly's RFC series.  This isn't
quite ready for application as I haven't yet thought through
the interactions between the root_mmu/guest_mmu split and
the multi-root caching.

Speaking of the multi-root caching, it is a bit of a duplicate work
with Vitaly's last three patches that avoided reinitialization if
the parameters and CR3 matched, so the series got smaller too.

The scalability improvement on the nested CPUID benchamrk is sensible:

                  -smp 1      -smp 16      -smp 48
  4.18            18k         86k
  kvm/queue       18k         68k  
  +gup_fast       18k         42k  
  +guest_mmu      18k         26k          42k

The slowdown between -smp 16 and -smp 48 is partly due to SMT,
because the machine has 28 cores.

Paolo

Vitaly Kuznetsov (4):
  x86/kvm/mmu: make vcpu->mmu a pointer to the current MMU
  x86/kvm/mmu.c: set get_pdptr hook in kvm_init_shadow_ept_mmu()
  x86/kvm/mmu.c: add kvm_mmu parameter to kvm_mmu_free_roots()
  x86/kvm/mmu: introduce guest_mmu

 arch/x86/include/asm/kvm_host.h |  11 ++-
 arch/x86/kvm/mmu.c              | 183 +++++++++++++++++++++-------------------
 arch/x86/kvm/mmu.h              |   8 +-
 arch/x86/kvm/mmu_audit.c        |  12 +--
 arch/x86/kvm/paging_tmpl.h      |  15 ++--
 arch/x86/kvm/svm.c              |  14 +--
 arch/x86/kvm/vmx.c              |  43 ++++++----
 arch/x86/kvm/x86.c              |  20 ++---
 8 files changed, 168 insertions(+), 138 deletions(-)

-- 
1.8.3.1

