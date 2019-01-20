Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB49C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAE720861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="oQMSxgeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfAUIqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:46:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35690 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfAUIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:46:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so22293550wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vs+bNFu0yF1CxUiI9KZwr438wTX73TGD5F830H4iAIA=;
        b=oQMSxgeWwvX3fxnLAJIhrPzeISSSa757Vq1K2z2xXFfbGMJNm+mNFmdOPlzRygbHlM
         5zGbjPbW/hSEvWy7F/KCTZPeDnl5hL7P+Eii3cu15r4wxdMTY/0ArkUF1lrhPq5GTHH5
         41MAsV9b64OSoAX8RNfLkmyk8/yZ/7splCiI41pnzF41mDlZ23BPaAhUKQYcLqO5RvrO
         liU9DxfBLkv4OPAlj3EIOvJxvWAiT60VeLXoQLD+nF5QpktvP0XtDD2hWckJMVWt8cYH
         W9VbmZW81UdFbBnNEYvZOG3QTqFEgACaCl4c0Xu8L/9eZnihyWQvBa2cjjWc3oeG0thY
         CXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vs+bNFu0yF1CxUiI9KZwr438wTX73TGD5F830H4iAIA=;
        b=QP7jUQTI9PimykZJ00XFB6OUAsKYXIoqj6Q8+s7mDKRtvoXl2FdYQRH15wAfQsfetj
         tMuprrvzJrX93l3nR6Q+HfnBcSIBfL2wKdPF/h+SRjEpiRt1t11uZL1XOqPsWF4h4sbP
         BZs5dhTeba2tBO218rsHJMQm57Vnw/4XyrTJaEHH4s2UbxUu9cnn5G2ktq1UCNDPDr6h
         uJF3AK2UENA+HXpotMNTLYxfk3GbAAfk2bi2dvra37CCZwHMlisQMIX7jp4TWap5hDCf
         aj8wK7RBji2OTbqBlc+wrX1imzOiWiFhSSWtr5ZrqMCmqBRx0Z1+ouxn/Ljg85tWErBP
         7IWA==
X-Gm-Message-State: AJcUukchKlIawVyrxdSM/H+xZ8pqIjVYdAIFF8lKuiKl3yy7TAM5SkIG
        FkA8Ozb3vQhMM5B8n6BbCNRRfqYeh0M=
X-Google-Smtp-Source: ALg8bN5FZlmXzIT2hTz+cxotHPasI5Ywv/1TMW+F1EmUBuKhIt3uhvjkzNB2etOELjfHhmG1GUQ/rQ==
X-Received: by 2002:adf:f605:: with SMTP id t5mr24033912wrp.229.1548027665620;
        Sun, 20 Jan 2019 15:41:05 -0800 (PST)
Received: from localhost.localdomain ([156.212.82.83])
        by smtp.gmail.com with ESMTPSA id e9sm76576753wro.16.2019.01.20.15.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 15:41:05 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [RESEND PATCH V8 01/11] KVM: State whether memory should be freed in kvm_free_memslot
Date:   Mon, 21 Jan 2019 01:39:30 +0200
Message-Id: <20190120233940.15282-2-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190120233940.15282-1-ahmedsoliman@mena.vt.edu>
References: <20190120233940.15282-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditions upon which kvm_free_memslot are kind of ad-hock,
it will be hard to extend memslot with allocatable data that needs to be
freed, so I replaced the current mechanism by clear flag that states if
the memory slot should be freed.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 virt/kvm/kvm_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1f888a103f..2f37b4b6a2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -548,9 +548,10 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
  * Free any memory in @free but not in @dont.
  */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
-			      struct kvm_memory_slot *dont)
+			      struct kvm_memory_slot *dont,
+			      enum kvm_mr_change change)
 {
-	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
+	if (change == KVM_MR_DELETE)
 		kvm_destroy_dirty_bitmap(free);
 
 	kvm_arch_free_memslot(kvm, free, dont);
@@ -566,7 +567,7 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 		return;
 
 	kvm_for_each_memslot(memslot, slots)
-		kvm_free_memslot(kvm, memslot, NULL);
+		kvm_free_memslot(kvm, memslot, NULL, KVM_MR_DELETE);
 
 	kvfree(slots);
 }
@@ -1061,14 +1062,14 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
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
2.19.2

