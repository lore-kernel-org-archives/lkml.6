Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE97C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62528205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb2bWoK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62528205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeJMWcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38239 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeJMWcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so7604853pff.5;
        Sat, 13 Oct 2018 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nxRqhHh/R4eocFIDtZHepU4uQVZQG1Lz/6BjqudaHXE=;
        b=Mb2bWoK5kSh5dmDNPo/Xp9Iy+GtRr+aHMcDJiyKl6wW6SHEwiGMqho/Sg8i6ff6Ut8
         kpfRFdIkIegcOS0UignucA5rWkNdjMN2s2MkGzVj+/cYEPiYHlE0dQfUfudFmoYMgioG
         XzNu+kB2+jBOliU0HqO64QSC9gaG+0Xr00cW6znarwnIC095/Xd2enBudxKa6NqG5UVD
         XKTRjxef6LWXXf+GpDs69CD6nPl7AZ3Iy6HW8UfKpX3xY8KX9wq9tPqotTVS/uUk0OFy
         WCnizhcAxRZk15SXwNbdr/gRJsTdl3IUv1nretV+0/7IG0rT8UGMh8Jnpylh8lRs3jCA
         X84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nxRqhHh/R4eocFIDtZHepU4uQVZQG1Lz/6BjqudaHXE=;
        b=D/cXdH1TxMVAw7I4foW+KhXvOY8TvYIOvbZOkLAlFfcfDo7L9/T0In8as7jxPsNU7j
         j29QZTL7k6dtuG53FVJ95ylHZHHlva0mueId+0H2RkxRA4Z8V/eYGSBa0zFYD8B4P08h
         evIFpkR5wHlAgyo/FKc6oh0+e63mzmrcqnlLI10KSx3NA71em7sdNQ8CpcaM8LtIuWJN
         Ry+/swylcu7uo+ZhIcpWn06AIRiLFqtqAvbGRvWrafcVzblZoL6IuWCnUjmp5mIc42iJ
         oloNJ4b/13Nk1bjIJeyidI4DO/rau5T75FFxzcOXcB4JTUYGeJYhjcMdHMQ4UqoG0mEg
         iHbQ==
X-Gm-Message-State: ABuFfog9TLGl2trglnpCFq/20H2k3bNlGFrMpgHs6glqW/H8a2u+wvWO
        1XVm0xyt2Z7MaA66LcgYJtw=
X-Google-Smtp-Source: ACcGV62ODMfI/skopQRC4vHH5MMF/M0ebIjFgPf4goi5NsRFYVyxcdjdqfPDRp84QQbOT5EVCngPdg==
X-Received: by 2002:a63:4a0e:: with SMTP id x14-v6mr9391338pga.34.1539442516968;
        Sat, 13 Oct 2018 07:55:16 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:16 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 9/15] KVM: Add flush_link and parent_pte in the struct kvm_mmu_page
Date:   Sat, 13 Oct 2018 22:54:00 +0800
Message-Id: <20181013145406.4911-10-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

PV EPT tlb flush function will accept a list of flush ranges and
use struct kvm_mmu_page as the list entry.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 19985c602ed6..8279235285f8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -316,6 +316,7 @@ struct kvm_rmap_head {
 
 struct kvm_mmu_page {
 	struct list_head link;
+	struct list_head flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
 
-- 
2.14.4

