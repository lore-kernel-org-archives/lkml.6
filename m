Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9138F21746
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+tu/bKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9138F21746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJUGfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:35:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45226 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeJUGfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:35:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id f17-v6so9191209wrs.12;
        Sat, 20 Oct 2018 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=2RYRBcvxGrFKD/6dlykR+YG9oy1kUHkBBuwGADsyTj4=;
        b=A+tu/bKx7vAfhQ5tXcFPWSfghHl9ghA2XBIfNj23pmFtXJr+PJc4ig1lgqEKvk8+Z8
         A8V/qV/shaBfPqCNkdkhTjmB5UAZxhuvcjsv2MF+84CQoXHyZwxH1UCjfUbhULXabLOr
         obPZgx4IR+tvE9V6LAmTt6ZIhwY0Sb5oPJ1mDLrpl6qrwQ5/ZV4LbrZAhpMbRYlvtoml
         1svNbNacnW9kfDex5ZZTaJS3q0rHhUWTX2Ut+8WeTtwcqMMPvK96MXnkgIYtcXT18KhI
         cxjxm71DYHEEcQiyly2ZlDusHavlNuXFMQzl7utWi+rZmvVYBWF3E8LGSy79G0bTqy5x
         VmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=2RYRBcvxGrFKD/6dlykR+YG9oy1kUHkBBuwGADsyTj4=;
        b=ZBwSeX53cJWALBoQflIG3DEMTes7tdPio62F7F1mmb2ktllax2nGfPtjAVoE2Pe49p
         0YT7wbSLKRs8bia158jMSXE614tWyXy08R8lkoNE1CuJFWH5s/AVtq1ZVAgNbJHBx3J/
         TwW/bYZAZtNyOcGtmBMOkj8DmFw8w8ZvHaF7A1OYVPU4X0Tj4m+y9SsNU9KPJkjr38pU
         ibdX/tsHQylyWnlg47L0aQWYu1YNeJ8Ukk6nQZQTRqNHhb3Qg/zgWmGy25/ZXA/847To
         85eXmY+tWNjDbfwQPeOBFcmrnBfTzOoXoJUuiAYEJHOlbMFGktooQAtX4OuZO2TM8Pxb
         zYDQ==
X-Gm-Message-State: ABuFfohmU0PqRhpqrHENr7M6+wnLY2oxpS2YJCgE2TxLu6vPcM3vqq03
        oLIBva/UnAu1AOGDzMcKJJo=
X-Google-Smtp-Source: ACcGV62jnzBOxHD9qHTvVAzL0r8x5JBVha2dIj9SgrnspF6+7UX2Y/FVrxLS6vEW7WYohcNNJXAE3g==
X-Received: by 2002:a5d:400d:: with SMTP id n13-v6mr13339265wrp.185.1540074194870;
        Sat, 20 Oct 2018 15:23:14 -0700 (PDT)
Received: from localhost.localdomain ([156.213.155.51])
        by smtp.gmail.com with ESMTPSA id o81-v6sm5013746wmo.38.2018.10.20.15.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 15:23:14 -0700 (PDT)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, Ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: [PATCH V4 5/5] KVM: Small Refactoring to kvm_free_memslot
Date:   Sun, 21 Oct 2018 00:21:27 +0200
Message-Id: <20181020222127.6368-6-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
References: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be a little bit more readable and prone to memory leaks

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 virt/kvm/kvm_main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d4f36faacd29..75b5b2c987e9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -552,11 +552,11 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
  * Free any memory in @free but not in @dont.
  */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
-			      struct kvm_memory_slot *dont)
+			      struct kvm_memory_slot *dont,
+			      enum kvm_mr_change change)
 {
+	if (change == KVM_MR_DELETE) {
 #ifdef CONFIG_KVM_ROE
-	if (!dont) {
-		//TODO still this might leak
 		struct protected_chunk *pos, *n;
 		struct list_head *head = free->prot_list;
 		kvfree(free->roe_bitmap);
@@ -566,10 +566,9 @@ static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			kvfree(pos);
 		}
 		kvfree(free->prot_list);
-	}
 #endif
-	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
 		kvm_destroy_dirty_bitmap(free);
+	}
 
 	kvm_arch_free_memslot(kvm, free, dont);
 
@@ -584,7 +583,7 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 		return;
 
 	kvm_for_each_memslot(memslot, slots)
-		kvm_free_memslot(kvm, memslot, NULL);
+		kvm_free_memslot(kvm, memslot, NULL, KVM_MR_DELETE);
 
 	kvfree(slots);
 }
@@ -1097,14 +1096,14 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	kvm_arch_commit_memory_region(kvm, mem, &old, &new, change);
 
-	kvm_free_memslot(kvm, &old, &new);
+	kvm_free_memslot(kvm, &old, &new, change);
 	kvfree(old_memslots);
 	return 0;
 
 out_slots:
 	kvfree(slots);
 out_free:
-	kvm_free_memslot(kvm, &new, &old);
+	kvm_free_memslot(kvm, &new, &old, change);
 out:
 	return r;
 }
-- 
2.18.1

