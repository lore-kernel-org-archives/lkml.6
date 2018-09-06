Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD9AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEB02083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILAfUmFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEB02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIFHJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:09:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41285 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFHJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:09:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so4455941pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7Y3+norEz7TJZRyCOKdtGp3Ym7ll6SRnpl6liy9gM8=;
        b=ILAfUmFRcRa19Y//2JYSQIU1tkoBnpNSES/iPv6OrGRhB82SWuIYm7ElTyoopQaqLA
         3+utBlOw8TQfriULyUFtZLPKZC/5GKCBi185trSWRF301MINA1dbbu7mzzDdoddWCefK
         OJntm9xoj6cdsn5pRolrocw5OKjnQcQkd9tr+uMIiwZMYDnp3L7UMrFqhzIb1UN7puUj
         MCp7mwHw6Pae6wjBF4D0OvUO147uDUEfF97FTpelv+QMHHSHv3jk/qrk/RJgrbAYJHQ1
         qzdfbcdSDwtoztld6AEaqcDZEhs+hppK/4uVt/KTKK5MFahAgDFDKt9GefONwfgkNLAb
         q6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7Y3+norEz7TJZRyCOKdtGp3Ym7ll6SRnpl6liy9gM8=;
        b=P2DCrj1Yzvw9o9YYbEyj3PL4YxkCqoWe3Asaj2Mp2Cm23m5UhPjBJAjdwLWFFf3aEF
         IgJrE9G20wZekLYN8RN1HCbBAqqXt6siQKpKjRA829YM1NXSGhsgBirYIcP8N7LtMzLr
         k0ckK65CfBb7n7x78KvjE9tmAxlh6i80Vz+5XbYFTf6W7C/alOdcLVOIHxsyXNPwQWyz
         swX7dSHnly8u+phfgRiTh4KMSpRAs3rXOg3xzthV33uunmkVXL1qJq6fxRR6VZR0zaH6
         bG3+8KXbR7MTGsxJ8WcumwNBeGf2oI1+DxpkWUAIpeleVa6vb9u1ezrEk7PdzNsgcZGc
         Yo1A==
X-Gm-Message-State: APzg51AfvOQrQ9t5Vo5LKTFXbRWmm8efODG77GKce3kmTDTFj+5AF7bw
        QdMTRrMFHd2nhWsSCN4/6A0CBDE=
X-Google-Smtp-Source: ANB0VdaCHClv30ZQZZu3pNC6bYhEKIeYJWPNIkc0zlaQvaGf7zI2lbZR9On7BOYeWqdrSPdGHEB2RA==
X-Received: by 2002:a63:7107:: with SMTP id m7-v6mr607531pgc.73.1536201413502;
        Wed, 05 Sep 2018 19:36:53 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r17-v6sm8780990pff.50.2018.09.05.19.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 19:36:52 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, x86@kernel.org
Subject: [PATCH 1/3] x86/boot/KASLR: change the prototypes of process_efi_entries/process_e820_entries
Date:   Thu,  6 Sep 2018 10:36:20 +0800
Message-Id: <1536201382-13133-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
References: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the prototypes of process_efi_entries/process_e820_entries in
order to reuse the mem entries' iteration (used in patch 3/3).

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com> (authored:1/16=6%)
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/kaslr.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d1e19f3..5185267 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -573,6 +573,10 @@ static unsigned long slots_fetch_random(void)
 	return 0;
 }
 
+typedef void (*handles_mem_region)(struct mem_vector *entry,
+			       unsigned long minimum,
+			       unsigned long image_size);
+
 static void process_mem_region(struct mem_vector *entry,
 			       unsigned long minimum,
 			       unsigned long image_size)
@@ -658,7 +662,8 @@ static void process_mem_region(struct mem_vector *entry,
  * for slots adding)
  */
 static bool
-process_efi_entries(unsigned long minimum, unsigned long image_size)
+process_efi_entries(unsigned long minimum, unsigned long image_size,
+	handles_mem_region handle)
 {
 	struct efi_info *e = &boot_params->efi_info;
 	bool efi_mirror_found = false;
@@ -717,7 +722,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 
 		region.start = md->phys_addr;
 		region.size = md->num_pages << EFI_PAGE_SHIFT;
-		process_mem_region(&region, minimum, image_size);
+		(*handle)(&region, minimum, image_size);
 		if (slot_area_index == MAX_SLOT_AREA) {
 			debug_putstr("Aborted EFI scan (slot_areas full)!\n");
 			break;
@@ -727,14 +732,15 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 }
 #else
 static inline bool
-process_efi_entries(unsigned long minimum, unsigned long image_size)
+process_efi_entries(unsigned long minimum, unsigned long image_size,
+	handles_mem_region handle)
 {
 	return false;
 }
 #endif
 
 static void process_e820_entries(unsigned long minimum,
-				 unsigned long image_size)
+	unsigned long image_size, handles_mem_region handle)
 {
 	int i;
 	struct mem_vector region;
@@ -748,7 +754,7 @@ static void process_e820_entries(unsigned long minimum,
 			continue;
 		region.start = entry->addr;
 		region.size = entry->size;
-		process_mem_region(&region, minimum, image_size);
+		(*handle)(&region, minimum, image_size);
 		if (slot_area_index == MAX_SLOT_AREA) {
 			debug_putstr("Aborted e820 scan (slot_areas full)!\n");
 			break;
@@ -768,10 +774,10 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 	/* Make sure minimum is aligned. */
 	minimum = ALIGN(minimum, CONFIG_PHYSICAL_ALIGN);
 
-	if (process_efi_entries(minimum, image_size))
+	if (process_efi_entries(minimum, image_size, process_mem_region))
 		return slots_fetch_random();
 
-	process_e820_entries(minimum, image_size);
+	process_e820_entries(minimum, image_size, process_mem_region);
 	return slots_fetch_random();
 }
 
-- 
2.7.4

