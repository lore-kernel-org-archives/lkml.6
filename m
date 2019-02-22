Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBA420823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjfjDlet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfBVIXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:23:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47034 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:23:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so741587pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVzojLvyJg8CcO1+5mzWEKYitIoofAkDltlfNCBnwRI=;
        b=KjfjDletYe2Gtz8dr94Kle7Id+AdDFAyRuqtC1gVPe2D+yRqWa5Mp7QaMT7TdxW380
         gbyuZhHjXcVxhcKWGjGvlVS/34VShvvl5tUyfFciiLIR7IgI1IASoxuRxWiDvjvRijUR
         k2Zeh2pj3ZZ44oZ+fRoJxZFaUjBrdB2M/vMa3HF88jMxOswoaVlgCWSGsi+9MJM6oApn
         TlRpSyxbIRr8xdLdjLjy6YZUUNxTIS7oong30k9mQ6Icmtnu2zWZrZ2VBYl88+SoM2gJ
         d7OE2cRo1TL0bSCUm5nJ6h4M9TDVdkd474mi0zYsD6fvJ4wPs99XtNDOKmJNhxsUbgPs
         nQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVzojLvyJg8CcO1+5mzWEKYitIoofAkDltlfNCBnwRI=;
        b=nsbX874cGofnbEHtvLHxYVVL3O1KFdm8L7v3KZGJiJ0wfBLFm1rIjNBz4g+KWhMgyO
         Wt8u/+dW+dt2EObWAuWuXo0P1VSomYHI54RqEX3QaX/AvN4by+7HaidR3kyEX52NOjlF
         Dru6/LpnBXDAH0CF3RFYNiOtQq2Iz056YT8oERlLBPQLGeE3mxKeidLNwUUchuT9GflF
         IsL6DHw+i/MeJMXRvI5fhCz9OkgRAlIlumeSIF1XWbR3r8JBzE6ZwUWUrvCPGDShUsA3
         XmA/ZFIGcVZu544UbVHpRhDTv16OM5NLw5J+o9J1b4jme7OzT+EbfgrX1KHOJ0DsP5ON
         grjg==
X-Gm-Message-State: AHQUAuaI9RhQypHNudqvL1xY9rEhVHsumZjDwO3FycsuNBxuK5Gxsx8n
        TL6wbBxwaYM4ANvdsoLPesep8w==
X-Google-Smtp-Source: AHgI3IZ55XtbrNFbkQrDgrsmr7mdr4l6vEwAO7J8uZuW5jEBEg9XUvtG8XtenIsY3FNaYjdMyX7w4w==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr2927069plr.97.1550823828410;
        Fri, 22 Feb 2019 00:23:48 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com. [45.79.96.158])
        by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 00:23:47 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on kvm_vgic_inject_irq
Date:   Fri, 22 Feb 2019 16:23:24 +0800
Message-Id: <20190222082327.3312-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222082327.3312-1-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function kvm_vgic_inject_irq() is not only used by PPIs but also can
be used to inject interrupt for SPIs; this patch improves comment for
argument @cpuid to reflect support SPIs as well.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 7cfdfbc910e0..79fe64c15051 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -394,7 +394,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 /**
  * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
  * @kvm:     The VM structure pointer
- * @cpuid:   The CPU for PPIs
+ * @cpuid:   The CPU for PPIs and SPIs
  * @intid:   The INTID to inject a new state to.
  * @level:   Edge-triggered:  true:  to trigger the interrupt
  *			      false: to ignore the call
-- 
2.17.1

