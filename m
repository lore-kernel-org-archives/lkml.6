Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFE2206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW2Ji7XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfADIzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:55:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47018 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfADIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:54:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so17983777pfe.13;
        Fri, 04 Jan 2019 00:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lVVdEslgom8hND2ea3FWWDCI/x9Q6uJ8jZfIIsF2DSM=;
        b=OW2Ji7XBSYB1+gGPVjstYoLKPTzQ1AmfMKSKOstz5QdPudY86VQ380UUUsnf/zGmVM
         xn6Mh0pYG3xrcy20WnDqchjHf0s2vor5WP0jYSxpDbJWJjbYB3QmqZJ0fwIHRl8AAQNK
         lxbecV+o95hItU6JP7PaPD8X3TJPHKx2mAM6ZTHdq6sV5V9Krp4xs8TdoVqrAT8V0Xt9
         X9+ykYR1/2wD4+G1Z4KIV0Ml1JTrhu5uudJqftY/TkXmydDiAMUHPf4qFOrUwiy9y1Gm
         C8XClO7UzUvFQDxjE0HxdBZXHppJjVWt0tiZIPFJ3583Ah2FqOq6EH1oP+MPBMLn9PvU
         zBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lVVdEslgom8hND2ea3FWWDCI/x9Q6uJ8jZfIIsF2DSM=;
        b=k/T8JVAFcEXglAw6jKUATiwLoAihZxR4lBSCwzJd64FqlQlvVpDj3JCMys4KeVBGRm
         +1DoMghawheMAIgBmNk5vT8bx+bhOGShLq6/kiZryWVtWeAOm7OBNNkc4FhBP7KDGxK8
         krAxP9HA2H5wCdI/kijSsapgEKxkDz07640qU7FzEEBxrcAxy4yAUrxYXeAK1thlIDoW
         r4Fgt8xS0oqzZkSmBedpx56UDOH/rKzHYL390+r5QBO6DBQjYjtUdFcG8qppsCFzndup
         EbbbKeA7C4rEIfEJ0NUooxwAJJHbzNJiwQLcdqc938qkzYvX75vIr7OQocSuPYZnj3BA
         di2g==
X-Gm-Message-State: AA+aEWaADgN1mD+xBfdtoZj+MDjNnJeR/Se6doaH9UiCx/Of6odBlAH7
        nh9TXl8WIP2ZJ7z0tPCjH4AJ8qi/Ln24wg==
X-Google-Smtp-Source: ALg8bN6Kuw2ITWSZOeeG0JAVP4GO5UzPiaRW5tnwjEiTZXlCq7w6q2DQ3Tfsj+QkVgS7pj1Cmr9+qg==
X-Received: by 2002:a62:56c7:: with SMTP id h68mr53695204pfj.134.1546592097417;
        Fri, 04 Jan 2019 00:54:57 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:54:56 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH 5/11] KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
Date:   Fri,  4 Jan 2019 16:53:59 +0800
Message-Id: <20190104085405.40356-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d3272c5066ea..6d4f7dfeaa57 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1715,6 +1715,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
 	}
 
+	if (write_protected && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		write_protected = false;
+	}
+
 	return write_protected;
 }
 
-- 
2.14.4

