Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01FFC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8042C20830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="Wo5h6zjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfAFTZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:25:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41495 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfAFTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:25:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so29264324edc.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vs+bNFu0yF1CxUiI9KZwr438wTX73TGD5F830H4iAIA=;
        b=Wo5h6zjvycB8zOxoh15YyWO9D/VU+c2H5+SKQHj5GUO+LOeXkkB3fwUheyny3S9nPy
         zJxDbPprk1o11616tJoUP5qpiCqdKEG6SWPS0ItQx/BFvUytSytsYYEnGdnjxjPnuC0p
         K82M0pXAKU1vPdSYoIkZvs0K+n9i3HIIgUdZFzIDY32Ko7aLNKoNJcpCwnXHWseqGHJq
         XFsc7Y9kkDo9OcGLf5alQCxW80GW40vo9FUHYTtIt+yE5A+b9bjOXVi0F1C0/q86Go4C
         njXy8NR5VspfiZo4pi+usTZ1xYvpYdKkoyjDWsaFUhln07pK7hhvA8UZmBVxUzOqtB+a
         QIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vs+bNFu0yF1CxUiI9KZwr438wTX73TGD5F830H4iAIA=;
        b=EwSLBdINgmfCJR0sfHACptG3nH8RpcbytqYpNs+o/lBJJqcZ6ZW27pT/MijqjvQO/1
         eXGkKLjEN0Uv4qrzTNw9CLXOZYCdsGrXrgDXMfwF/FbUTewj29bWZaBSA5R7zrV9IDf8
         DW24BIvYa6E5OzTvetADStQwasdlMFaL7BvVkJDuNiz4YVdiOg3gyKIBvUCcsxs0o7eF
         Gxuutz72LkZ8NshoTN8DL6B09SzOvoczK2L8u3zGkS45oOKD21nc2XNeeQZ5tLBGue15
         HhgiOvvioUif3G3AgJiR6UimExVwbmCii9E2ZTyV2A4eWUXs0xwyaa/OR6xX8BX5RAIS
         vjfQ==
X-Gm-Message-State: AA+aEWbyKZwIFDfsEZlvJKUFJLF1QljXMeFsxjZ4ddW3472uLUzvmBKy
        01ciebXTmvh4AFW0XsDVJ9YDZA==
X-Google-Smtp-Source: AFSGD/V2HOGzNw9EglnSRXwlKhwoja1ooRczmbI7hSqUdESJLQKq8KwHufaIjPgSXaKanXnkJTPD0w==
X-Received: by 2002:a50:b7d6:: with SMTP id i22mr52061815ede.27.1546802699386;
        Sun, 06 Jan 2019 11:24:59 -0800 (PST)
Received: from localhost.localdomain ([156.212.65.252])
        by smtp.gmail.com with ESMTPSA id b46sm29994035edd.94.2019.01.06.11.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:24:58 -0800 (PST)
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
Subject: [PATCH V8 01/11] KVM: State whether memory should be freed in kvm_free_memslot
Date:   Sun,  6 Jan 2019 21:23:35 +0200
Message-Id: <20190106192345.13578-2-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
References: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
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

