Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CBEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4781A2148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCy0wl4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4781A2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJQGsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:48:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38080 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJQGsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:48:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so27441282wrt.5;
        Tue, 16 Oct 2018 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=WEuovPHMi2rHnMRq9NI/DlHQ1fPItAQ88ffmtIZfQHE=;
        b=vCy0wl4HRmUTIjmrYXCmiWFTwRiLw4TU2PUu/ODk91avvisDMIP6GujRMO2K3wx3xV
         7hoH9OCBb/JvNa51+P5mCzPoG6j3z70vce4zZS7ILjcGYMeEl4mYtzAp6IiqVEy5wHUC
         HZGbxyl4UMv27R7p0BdfBv8nXEBgBppFB74Iv96gKtrV9FBWqh7k6ITR5Aectl7B2Rya
         /TIPSxOzYrx7FPE3OtCOnrlK12agAoL/2xDTz2XT9bcnERila4WOPitXw6ZQu6gkretV
         ynq5iMdNLGB1cIraXnBiJ7eQkRw1fR7Q6ohLTnwtqekD5IsMa9G+w5Riyc+NQwHh42hw
         s4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=WEuovPHMi2rHnMRq9NI/DlHQ1fPItAQ88ffmtIZfQHE=;
        b=EWYKRti+Vagp+eW+WoHiZ1+cQxSIohm3XIJtlEVBpMmn2HPsXKKqX3g6GR8NNsQ9vp
         hubyLwOnDwUKpymCp/YANob4hhbEAeju/gZG9hy0uXMZF8gd3WnC63edku5Go5ZqARw5
         xnftPYFQeG+dLcfXctjGsJIr7jh/p+GrT+m0nHRg2vYvJKmbgwLUJeBGA/t8mpTx32PJ
         qPCnTmFvl5ppmZ9uoJ0hwT4z10PsXdRzkWb7i0s+QJXw5aDz4kf3zwbVDWLj38n4TcZP
         pdmWBh6Wvm7wfg6AlAGrI34S/jWOVQ/SAttIgibCuNhO+ZqUQMthyv8Rbet1Ni/4NoYY
         2vIw==
X-Gm-Message-State: ABuFfoj0oeqBj2ztllBjRxeNjhsCEZKWyG2ovwHS/r81U/TtBYwY4PGi
        u6yLLSwBcrr8fkh7ADlTtER/20tV
X-Google-Smtp-Source: ACcGV62IJu/sEwBAbIGvruibP/PalfopGNanWJAiAqN1leOXzP/DDCgj50qZwBBkbq2iJSRst2fKEQ==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15-v6mr19238563wrw.261.1539730525013;
        Tue, 16 Oct 2018 15:55:25 -0700 (PDT)
Received: from donizetti.redhat.com (94-36-192-45.adsl-ull.clienti.tiscali.it. [94.36.192.45])
        by smtp.gmail.com with ESMTPSA id a5-v6sm144887wmh.8.2018.10.16.15.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 15:55:24 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     liran.alon@oracle.com, jmattson@google.com
Subject: [PATCH] KVM: VMX: enable nested virtualization by default
Date:   Wed, 17 Oct 2018 00:55:22 +0200
Message-Id: <20181016225522.13077-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With live migration support and finally a good solution for CR2/DR6
exception payloads, nested VMX should finally be ready for having a stable
userspace ABI.  The results of syzkaller fuzzing are not perfect but not
horrible either (and might be partially due to running on GCE, so that
effectively we're testing three-level nesting on a fork of upstream KVM!).
Enabling it by default seems like a nice way to conclude the 4.20
pull request. :)

Unfortunately, enabling nested SVM in 2009 was a bit premature.  However,
until live migration support is in place we can reasonably expect that
it does not offer much in terms of ABI guarantees.  Therefore we are
still in time to break things and conform as much as possible to the
interface used for VMX.

Suggested-by: Jim Mattson <jmattson@google.com>
Suggested-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e665aa7167cf..89fc2a744d7f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -107,7 +107,7 @@ module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
  * VMX and be a hypervisor for its own guests. If nested=0, guests may not
  * use VMX instructions.
  */
-static bool __read_mostly nested = 0;
+static bool __read_mostly nested = 1;
 module_param(nested, bool, S_IRUGO);
 
 static u64 __read_mostly host_xss;
-- 
2.17.1

