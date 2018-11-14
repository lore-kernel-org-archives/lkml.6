Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950A42145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ef8CFGTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950A42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeKOIx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:53:28 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50463 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeKOIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:53:28 -0500
Received: by mail-qk1-f201.google.com with SMTP id x125so23569886qka.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xkTfZ5o1GNAQFrsBpd9b1qpDiRwW7hTYlCyvxR2DUV4=;
        b=ef8CFGTaYqRT3qssdlIdyUqI6URrez8hYU2ly3uwI3tjP5B6BLKMvRGvCRurmwHxgV
         Dtg2mq6qMjU7LiQmjhC6E4W1HaDfq1V+9cLaiIVCWAd6X/3lOtgzHnw0OpeKY3d2nbPo
         4i1MQtPNWqYmVPGasoP5r0rr754/NZIAG7L1niE6xC4TN2kBWD/c3dsNn7G65D+2LSVj
         GUQ9uPURBiITXtQHjOhue7vCq+xs4e69c3b3daG/+TBFUN1OgW6Vmt2mQigFXhfW9EeD
         8hOJPdyNt8Pnz5x2EaE1V1VvQm1TWZ5fGbg/at6VmyNmNOy2ePI+/C52wsLVki/hkh5s
         H8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xkTfZ5o1GNAQFrsBpd9b1qpDiRwW7hTYlCyvxR2DUV4=;
        b=GaH/R6miBF0qc+gzpcueF9VjnoyK2DEvdpu/lA6ZFqZK0iemQmvJ1Jr1U2hIRTbPgd
         +qpQdtqhFhr2Y3ITzxVVNLbT03qVNYHM0iw790vXiB+tMxL+hHX4lRFbPR0ZYWRCKIrU
         x5kNgtx6IpYdlBw1+W0/6xrPoxDNt0aZ5E+B5bL1DFFGD3+Npp6YGGy4jLa2CvSrmWwk
         up2aVm+7CX6g5glB1mJfUCzaEF6+lFVqdGFoPFjmq3nlHYnXTKIk8sSJfr4O2L80EZjw
         GZy9WAfvTEF0zEryEbJ81T+GkSpX/XKT3QKokxJdpw88AnEGquOiCtIU9+fmwPgNoUzf
         JPoQ==
X-Gm-Message-State: AGRZ1gJ192CiEyJIzN6CH6UayitgaZsKuYpuRvS9iv/8bTq3b/6M0dlL
        sN58vYPNe8Uqfp41/Y89iIWfOG00
X-Google-Smtp-Source: AJdET5et7OS4cK0VcjAi1DVwiLAQGhgKIb+1zjKidUpbuzrEHxdvqzDUDUCGJ9oLndVxVc54dVUKfgg+
X-Received: by 2002:a0c:b7a8:: with SMTP id l40mr2581731qve.4.1542232379110;
 Wed, 14 Nov 2018 13:52:59 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:51:52 -0500
In-Reply-To: <20181109203921.178363-1-brho@google.com>
Message-Id: <20181114215155.259978-1-brho@google.com>
Mime-Version: 1.0
References: <20181109203921.178363-1-brho@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v2 0/3] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series depends on dax pages not being PageReserved.  Once
that is in place, these changes will let KVM use huge pages with
dax-backed files.  Without the PageReserved change, KVM and DAX still
work with these patches, simply without huge pages - which is the
current situation.

RFC/discussion thread:
https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/

v1 -> v2:
https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/

- Updated Acks/Reviewed-by
- Minor touchups
- Added patch to remove redundant PageReserved() check
- Rebased onto linux-next


Barret Rhoden (3):
  mm: make dev_pagemap_mapping_shift() externally visible
  kvm: Use huge pages for DAX-backed files
  kvm: remove redundant PageReserved() check

 arch/x86/kvm/mmu.c  | 33 +++++++++++++++++++++++++++++++--
 include/linux/mm.h  |  3 +++
 mm/memory-failure.c | 38 +++-----------------------------------
 mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c |  8 ++------
 5 files changed, 73 insertions(+), 43 deletions(-)

-- 
2.19.1.1215.g8438c0b245-goog

