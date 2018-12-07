Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C335C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5115020892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjNvKDTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5115020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLGGay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:30:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37131 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeLGGax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:30:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so1270458pge.4;
        Thu, 06 Dec 2018 22:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IBqTyM54Tq10KxOqmHTX1iqosn8Fy5yMO6MBzN5sdao=;
        b=TjNvKDTg+yWV/bjny9Uceh9Tdqa/IH3OIyk2Nd65/VYhKJsojNbxVbmHnBk5P7s4Iw
         eVmVHZ/UIpQTJonA7NN1NVlmVCD3DidWgaLmA5lQXm+masoXl6Xe52mNjQTqqt5j5SgN
         SQQYzs0ibshmVutjm4LCHCCYIwhmtGlHxPr/1Voz5eaqPqFI/gJ8jXKDOckZE9P1IeYp
         FNB3tQiYIubfTD1q08PkdEhXfD9sfoJyARufL061XgbIBT8oASTm+3c0lm8VNSWu3il/
         sCdzaG0Vb7N1lfj/PQZ+UOTkQ6bYi4mxtF70RZLiaFnvOFRvZiCM/eeVB0BkrKz3gUA9
         6e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IBqTyM54Tq10KxOqmHTX1iqosn8Fy5yMO6MBzN5sdao=;
        b=stWTezFUQpnWxQY995nWl60/EJ9cqDr7oJ059s9rfjlEMWhtkEc/hVA6cggcRmTU9H
         3cob5sWpsdbHfK3mU2q4Wq5WTeirPKDmfh/gNszFNBvXduenS1TLbT82leGvGVf6Vjsf
         trUnGFwNo+5NVoa6Rn2j/GYR/uF2Lob/9ChkuuNJreOvFx0nIXUghRsrmdk/CqGpubNZ
         ufAIkqEHtPzIazWZnUlXp+uM9m8UvzIhDRiGEfCmQmxdIum+XTaspDs1BBNuOiCycOsy
         T6Ui2QdMd95D0uCVu6/essDmyRKQXwSaOAHsm5onXmBR4qtT0p4KxBwgExelcG10Fpwi
         4g5A==
X-Gm-Message-State: AA+aEWZgAFfqxhVnkdmssxHyDxbIYhDKj4Hh7o9ptm+5uANaFGI3N3q7
        cU4CyFW4WgTtcfUdJMFuIor3WmEDWCQ=
X-Google-Smtp-Source: AFSGD/Ue5biVt5LzEzmCoSVjd5s1EGMP9I0OnyrAA45V6TEdzlGsgqqifBRtU7yl/Grm1nlV8lYecw==
X-Received: by 2002:a63:7f4f:: with SMTP id p15mr909226pgn.296.1544164252017;
        Thu, 06 Dec 2018 22:30:52 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o7sm2982928pfb.34.2018.12.06.22.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 22:30:51 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Eric Paris <eparis@redhat.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCHv2 net 1/3] flex_array: make FLEX_ARRAY_BASE_SIZE the same value of FLEX_ARRAY_PART_SIZE
Date:   Fri,  7 Dec 2018 14:30:33 +0800
Message-Id: <a4474a5886807d13146dc67e2d214b7ba3029d32.1544163962.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1544163962.git.lucien.xin@gmail.com>
References: <cover.1544163962.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1544163962.git.lucien.xin@gmail.com>
References: <cover.1544163962.git.lucien.xin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to separate the base data memory from struct flex_array and
save it into a page. With this change, total_nr_elements of a flex_array
can grow or shrink without having the old element's memory changed when
the new size of the flex_arry crosses FLEX_ARRAY_BASE_SIZE, which will
be added in the next patch.

Suggested-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
---
 include/linux/flex_array.h | 29 +++++++++--------------------
 lib/flex_array.c           | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/include/linux/flex_array.h b/include/linux/flex_array.h
index b94fa61..29ad65f 100644
--- a/include/linux/flex_array.h
+++ b/include/linux/flex_array.h
@@ -7,9 +7,10 @@
 #include <asm/page.h>
 
 #define FLEX_ARRAY_PART_SIZE PAGE_SIZE
-#define FLEX_ARRAY_BASE_SIZE PAGE_SIZE
+#define FLEX_ARRAY_BASE_SIZE FLEX_ARRAY_PART_SIZE
 
 struct flex_array_part;
+struct flex_array_part_p;
 
 /*
  * This is meant to replace cases where an array-like
@@ -19,29 +20,17 @@ struct flex_array_part;
  */
 
 struct flex_array {
-	union {
-		struct {
-			int element_size;
-			int total_nr_elements;
-			int elems_per_part;
-			struct reciprocal_value reciprocal_elems;
-			struct flex_array_part *parts[];
-		};
-		/*
-		 * This little trick makes sure that
-		 * sizeof(flex_array) == PAGE_SIZE
-		 */
-		char padding[FLEX_ARRAY_BASE_SIZE];
-	};
+	int element_size;
+	int total_nr_elements;
+	int elems_per_part;
+	struct reciprocal_value reciprocal_elems;
+	struct flex_array_part_p *part_p;
+#define parts part_p->p_part
 };
 
-/* Number of bytes left in base struct flex_array, excluding metadata */
-#define FLEX_ARRAY_BASE_BYTES_LEFT					\
-	(FLEX_ARRAY_BASE_SIZE - offsetof(struct flex_array, parts))
-
 /* Number of pointers in base to struct flex_array_part pages */
 #define FLEX_ARRAY_NR_BASE_PTRS						\
-	(FLEX_ARRAY_BASE_BYTES_LEFT / sizeof(struct flex_array_part *))
+	(FLEX_ARRAY_BASE_SIZE / sizeof(struct flex_array_part *))
 
 /* Number of elements of size that fit in struct flex_array_part */
 #define FLEX_ARRAY_ELEMENTS_PER_PART(size)				\
diff --git a/lib/flex_array.c b/lib/flex_array.c
index 2eed22f..8c0b9b6 100644
--- a/lib/flex_array.c
+++ b/lib/flex_array.c
@@ -30,6 +30,10 @@ struct flex_array_part {
 	char elements[FLEX_ARRAY_PART_SIZE];
 };
 
+struct flex_array_part_p {
+	struct flex_array_part *p_part[FLEX_ARRAY_NR_BASE_PTRS];
+};
+
 /*
  * If a user requests an allocation which is small
  * enough, we may simply use the space in the
@@ -39,7 +43,7 @@ struct flex_array_part {
 static inline int elements_fit_in_base(struct flex_array *fa)
 {
 	int data_size = fa->element_size * fa->total_nr_elements;
-	if (data_size <= FLEX_ARRAY_BASE_BYTES_LEFT)
+	if (data_size <= FLEX_ARRAY_BASE_SIZE)
 		return 1;
 	return 0;
 }
@@ -105,13 +109,17 @@ struct flex_array *flex_array_alloc(int element_size, unsigned int total,
 	ret = kzalloc(sizeof(struct flex_array), flags);
 	if (!ret)
 		return NULL;
+	ret->part_p = kzalloc(sizeof(struct flex_array_part_p), flags);
+	if (!ret->part_p) {
+		kfree(ret);
+		return NULL;
+	}
 	ret->element_size = element_size;
 	ret->total_nr_elements = total;
 	ret->elems_per_part = elems_per_part;
 	ret->reciprocal_elems = reciprocal_elems;
 	if (elements_fit_in_base(ret) && !(flags & __GFP_ZERO))
-		memset(&ret->parts[0], FLEX_ARRAY_FREE,
-						FLEX_ARRAY_BASE_BYTES_LEFT);
+		memset(&ret->parts[0], FLEX_ARRAY_FREE, FLEX_ARRAY_BASE_SIZE);
 	return ret;
 }
 EXPORT_SYMBOL(flex_array_alloc);
@@ -148,6 +156,7 @@ EXPORT_SYMBOL(flex_array_free_parts);
 void flex_array_free(struct flex_array *fa)
 {
 	flex_array_free_parts(fa);
+	kfree(fa->part_p);
 	kfree(fa);
 }
 EXPORT_SYMBOL(flex_array_free);
-- 
2.1.0

