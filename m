Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7530CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1A620831
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnuy5daA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1A620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeJZX43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:56:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeJZX42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:56:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so1749900wrv.6;
        Fri, 26 Oct 2018 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yE/YW6fK24VOhbIjt3XPpOViKqn92I+EGRJYSjO4hqg=;
        b=Fnuy5daA47mKSFuxswUk3qDfHCTbtlSFXMbP+RMdhCukppkmlS6mj6bPnfdMuwJino
         A+sa3lfvkb7o4LfPFDPLx+8RfgqBOHspU/V7bPT4HtLjHEGp+DGHOV2JfGToIgaKfsgc
         Z8km+ee4mx1nNKn/YUfYGKPshTEoy1meXXpUnqANqFj2JaKiGW63HjY+pa/BVKhJKxpQ
         gHN3HtO0w4qvsZFlzVKLqrb/5Tx0wvoRu2NrSrCNAoOZADtsKjH/s3fttM1uE7YRx+He
         5Cw/mNPGz/gbGFnQblq5ULZzafdKWTEGhCwHnXkHs+Iqi3ei9B9iQb/yFbqJNcu2bcbE
         1RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yE/YW6fK24VOhbIjt3XPpOViKqn92I+EGRJYSjO4hqg=;
        b=AWswBPl7hJlcbQlLFEgDu2Y0JJcoYWX/FIHMzJiPOyiGS3xeaKHeJNaJlSSr3e2CGx
         lGmZ9cVGW4ODVFa0JbX1OtaZrtNYayrZCx51U6CBNSTZn+syf9GRaz9pkym99YDNcu4a
         tB3CAFwXTjym6am1RkTw8Z3TmbpU/LoDBMcECHegGkeA0IisxmSVZSYzyrsRLSHzjtXs
         TnWBKZkesSWF9VbTS3RCe4Qb4zMpsPEJ69iCnp4ZXvHbnL9I3z/TkMyhMuQ5NVg6/IJi
         4q3WxXU1vHmDlDoPqUWphAj2lgCuEEu4FjIxi9VbzUctEgZVoCj+e/z3xbwFs+GCuLn3
         QcZg==
X-Gm-Message-State: AGRZ1gJTfxViIDzjHsvveZ4hjiZin5eQvxnAS2jQ9bcsWvBmxcac5Fzv
        xOjx/2JlzwbDImaUizHEGng=
X-Google-Smtp-Source: AJdET5fwUQRKfoSaQ3JHCKlrr+Y/fJUhljyg+itVp3J3K2iw/l+QS43s1w5/Wgsi/DImjb4FUa0dHQ==
X-Received: by 2002:adf:db8e:: with SMTP id u14-v6mr6251764wri.217.1540567139748;
        Fri, 26 Oct 2018 08:18:59 -0700 (PDT)
Received: from localhost.localdomain ([156.213.138.111])
        by smtp.gmail.com with ESMTPSA id p7-v6sm10127257wrt.10.2018.10.26.08.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 08:18:59 -0700 (PDT)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: [PATCH V5 5/5] KVM: Small Refactoring to kvm_free_memslot
Date:   Fri, 26 Oct 2018 17:12:23 +0200
Message-Id: <20181026151223.16810-6-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
References: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
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
index 2d3011e8490e..79c98db03c84 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -550,11 +550,11 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
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
@@ -564,10 +564,9 @@ static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			kvfree(pos);
 		}
 		kvfree(free->prot_list);
-	}
 #endif
-	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
 		kvm_destroy_dirty_bitmap(free);
+	}
 
 	kvm_arch_free_memslot(kvm, free, dont);
 
@@ -582,7 +581,7 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 		return;
 
 	kvm_for_each_memslot(memslot, slots)
-		kvm_free_memslot(kvm, memslot, NULL);
+		kvm_free_memslot(kvm, memslot, NULL, KVM_MR_DELETE);
 
 	kvfree(slots);
 }
@@ -1100,14 +1099,14 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
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

