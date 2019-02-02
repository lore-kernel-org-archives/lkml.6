Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B5C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20692075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcua337T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfBBBjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:39:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44364 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfBBBjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:39:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so3741955pgr.11;
        Fri, 01 Feb 2019 17:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mzJwBxC9uXB//tA5PSpVVWly8ERu6+h2503MPrKjGcg=;
        b=Qcua337T8myRK46Z4hgHoGruUwG/fSBmBnSudxXeOK8Fr05S1ddajw6sNis92exhPt
         91bfxvoG8/bj38NRAvNU0VbnuCvp1IA4d3IBZPg2VR1jcdjTbhnH5tw2+33fXRCQwfQQ
         PaDqBTFs1gd7oq8qgZfqsi2SbuGsCOYckgitb24/j+YFida+o8CNJlvt7C9YK+XTKiwv
         WYBig8UHSHrJymgn0spCgGoXWwY5pEG92CWOozExwelAWAsFbnHnTJ/FSOAY5PSKSzsU
         aYlGJgXbwgix947+4Tlt8Xx3oCLgEiw9P0s3gscqbJo7fHZNSqzBDJlv6JwINZfn2oDM
         6skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mzJwBxC9uXB//tA5PSpVVWly8ERu6+h2503MPrKjGcg=;
        b=BRKdsn1znE4gapyLXC4j6r06vNDn5u4OxkHjEofH/6V94yv+7oVkRFzZ/6li4d+KU3
         cmnzy0e7fbkbXWQuDvQ7MhWDKlGZeMuo8Po4Xdsc0lcsN4Z/lirSkwB3vldgG8bi+t6S
         +hkXhwf9z+B6QKwpVoIXSrLduS5hHMzBbAzONwTkQZ6oE51wpQwkxAUtdqoFmPmqyNHL
         mr16xAVvW6GMjAOBGk02L84VWTFWvabNz8auTR9QVa09F8biXudlHWF9ddQX1ApwxD6H
         wDeSP9np4u4v7zKy8UvbHTX5/sY/o1qC/np0vjbAYJs14U0NzX/V8gks6wenffHCCAlT
         mFzA==
X-Gm-Message-State: AHQUAuZWySOtQfOjEtMlY75so04mLJf15U9U+ctq+Ub6ZqovLD4FUJT0
        jwOl+ooU/mWXE8ORI/xgeMY=
X-Google-Smtp-Source: AHgI3IYabhaPzvhFuMYVtOsFddmUk5xY+xDep8I/zRTsc2nUVkd3NGA16u1jhZqEAaNh3r6MH4P4EQ==
X-Received: by 2002:a65:560e:: with SMTP id l14mr4576873pgs.168.1549071580503;
        Fri, 01 Feb 2019 17:39:40 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:39:39 -0800 (PST)
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
Subject: [PATCH V2 7/10] KVM: Add kvm_get_memslot() to get memslot via slot id
Date:   Sat,  2 Feb 2019 09:38:23 +0800
Message-Id: <20190202013825.51261-8-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add kvm_get_memslot() to get struct kvm_memory_slot
via slot it and remove redundant codes. The function will also be used
in the following changes.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 45 +++++++++++++++++++--------------------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e73..aaa2b57eeb19 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -758,6 +758,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			      struct kvm_dirty_log *log, bool *flush);
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush);
+struct kvm_memory_slot *kvm_get_memslot(struct kvm *kvm, u32 slot);
 
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7ebe36a13045..b2097fa4b618 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1095,22 +1095,30 @@ static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
 	return kvm_set_memory_region(kvm, mem);
 }
 
+struct kvm_memory_slot *kvm_get_memslot(struct kvm *kvm, u32 slot)
+{
+	struct kvm_memslots *slots;
+	int as_id, id;
+
+	as_id = slot >> 16;
+	id = (u16)slot;
+	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
+		return NULL;
+
+	slots = __kvm_memslots(kvm, as_id);
+	return id_to_memslot(slots, id);
+}
+
 int kvm_get_dirty_log(struct kvm *kvm,
 			struct kvm_dirty_log *log, int *is_dirty)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int i, as_id, id;
 	unsigned long n;
 	unsigned long any = 0;
+	int i;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
+	memslot = kvm_get_memslot(kvm, log->slot);
 
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
 	if (!memslot->dirty_bitmap)
 		return -ENOENT;
 
@@ -1154,20 +1162,13 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
 int kvm_get_dirty_log_protect(struct kvm *kvm,
 			struct kvm_dirty_log *log, bool *flush)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int i, as_id, id;
 	unsigned long n;
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
+	int i;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
-
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
+	memslot = kvm_get_memslot(kvm, log->slot);
 
 	dirty_bitmap = memslot->dirty_bitmap;
 	if (!dirty_bitmap)
@@ -1225,24 +1226,16 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int as_id, id;
 	gfn_t offset;
 	unsigned long i, n;
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
-
 	if ((log->first_page & 63) || (log->num_pages & 63))
 		return -EINVAL;
 
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
+	memslot = kvm_get_memslot(kvm, log->slot);
 
 	dirty_bitmap = memslot->dirty_bitmap;
 	if (!dirty_bitmap)
-- 
2.14.4

