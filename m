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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4636EC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D2720838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXGgMFcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D2720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLGGbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:31:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35348 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:31:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so1450211pfi.2;
        Thu, 06 Dec 2018 22:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7MfUEQQkpsvuhuLJsGgSUDCmSQkbYrqMmWgv/EsP3fo=;
        b=PXGgMFcUw1JOXrkayVkXHCuO5iRRzyw6IyZ5NZvlfVGIUhWArFEagsY7lLgmpfta/F
         PbanvNRZaiOJN7FbpXO4afRzVLGob3YO6WUiIjvNEBNnv2O0NQs7NQF4DpK6OwWz6EmT
         BuF35RIvowKq23f5S9XXJJdavt+Qu/jMdS776xMpKqrtMX4zX135xDPaHP5oQ1TiP/wA
         sIu4LQqCC8UQYobTW7iqoz8Iwa89AJlIeyj0/miAP9EAdviYVH/s5syGE2cvW3sC+G7v
         tF9bZ5ZZn/SQYtwk4INh2IsYjKaryZ1975yfSNKwUQaWpXgl/a3a0cqr2qIyWmoAjqgp
         2stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7MfUEQQkpsvuhuLJsGgSUDCmSQkbYrqMmWgv/EsP3fo=;
        b=W81O2ouly4/J1Q5/rYF34bW1wVS9E8oUTWkQ0Wjf0qsxfUT25rKJ9YK61IWE7/h9lf
         plLfP21qB2VI0vCQSGYkWbvrrI6ZKH6TLPYIXsbVe+Eu4RN/Uv3wcmCi2uK6nBixtWIu
         hP0d6JBGkhUdsXk5Dam7Dxby7/Ob4AQrY9D+/orTp7T0B4OujKl1EfJkM21FzmeitECf
         1o777QSRGRJyt2JAg9UJdOgChv6aKjYUfMoXA0xJTu7NsaaaXvuq42O1PWmoCgN9YDkG
         IswlU1G+eP5GuSnDCEwXFgjscI1tcxN5AHrB8QSWXB9WHTZHgEsEeIUIYS/oI13xAJgN
         uBug==
X-Gm-Message-State: AA+aEWZ2PgmRirStVdq9ybXx2D/P/xDmX5TedtVMvUg54Dd5qE5LwdVo
        VysyNoqLgAuhuRsZ4MlaPE2vaQG4eEk=
X-Google-Smtp-Source: AFSGD/XSCMCNgLFp+tsuuzvWlt+tYiPsiEQ5MeKt9KqQ/bJeo23CCsN7K9d9ZYfpJEfqekLrlTzMVQ==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr1054017pfg.98.1544164259934;
        Thu, 06 Dec 2018 22:30:59 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 84sm4719553pfk.134.2018.12.06.22.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 22:30:59 -0800 (PST)
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
Subject: [PATCHv2 net 2/3] flex_array: support flex_array_resize
Date:   Fri,  7 Dec 2018 14:30:34 +0800
Message-Id: <9122685dd16d04613de02594325acf79b2d04a3d.1544163962.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <a4474a5886807d13146dc67e2d214b7ba3029d32.1544163962.git.lucien.xin@gmail.com>
References: <cover.1544163962.git.lucien.xin@gmail.com>
 <a4474a5886807d13146dc67e2d214b7ba3029d32.1544163962.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1544163962.git.lucien.xin@gmail.com>
References: <cover.1544163962.git.lucien.xin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function can dynamically change total_nr_elements of a flex_array,
and keep the old elements of the same memory. Returns 0 if it succeeds.

Note that it won't do any memory allocation or shrinking for elements,
which should be only done by flex_array_prealloc and flex_array_shrink.

Suggested-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
---
 include/linux/flex_array.h | 11 +++++++++
 lib/flex_array.c           | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/flex_array.h b/include/linux/flex_array.h
index 29ad65f..19ff58d 100644
--- a/include/linux/flex_array.h
+++ b/include/linux/flex_array.h
@@ -130,6 +130,17 @@ void *flex_array_get(struct flex_array *fa, unsigned int element_nr);
  */
 int flex_array_shrink(struct flex_array *fa);
 
+/**
+ * flex_array_resize() - Resize without the old elements memory changed
+ * @fa:		array to resize
+ * @total:	total number of elements that this would change to
+ * @flags:	page allocation flags to use for base array
+ *
+ * Return:	Returns 0 if it succeeds.
+ *
+ */
+int flex_array_resize(struct flex_array *fa, unsigned int total, gfp_t flags);
+
 #define flex_array_put_ptr(fa, nr, src, gfp) \
 	flex_array_put(fa, nr, (void *)&(src), gfp)
 
diff --git a/lib/flex_array.c b/lib/flex_array.c
index 8c0b9b6..2f913e7 100644
--- a/lib/flex_array.c
+++ b/lib/flex_array.c
@@ -405,3 +405,61 @@ int flex_array_shrink(struct flex_array *fa)
 	return ret;
 }
 EXPORT_SYMBOL(flex_array_shrink);
+
+/**
+ * flex_array_resize - resize without the old elements memory changed
+ * @fa:		the flex array to resize
+ * @total:	total number of elements that this would change to
+ * @flags:	page allocation flags to use for base array
+ *
+ * This function can dynamically change total_nr_elements of a flex_array,
+ * and keep the old elements of the same memory. Returns 0 if it succeeds.
+ * Note that it won't do any memory allocation or shrinking for elements,
+ * which should be only done by flex_array_prealloc and flex_array_shrink.
+ *
+ * Locking must be provided by the caller.
+ */
+int flex_array_resize(struct flex_array *fa, unsigned int total, gfp_t flags)
+{
+	int nr;
+
+	if (total > FLEX_ARRAY_NR_BASE_PTRS * fa->elems_per_part)
+		return -EINVAL;
+
+	if (elements_fit_in_base(fa)) {
+		struct flex_array_part_p *part_p;
+
+		nr = fa->total_nr_elements;
+		fa->total_nr_elements = total;
+		if (elements_fit_in_base(fa))
+			return 0;
+
+		part_p = kzalloc(sizeof(*part_p), flags);
+		if (!part_p) {
+			fa->total_nr_elements = nr;
+			return -ENOMEM;
+		}
+
+		part_p->p_part[0] = (struct flex_array_part *)&fa->parts[0];
+		fa->part_p = part_p;
+	} else {
+		struct flex_array_part *part;
+
+		fa->total_nr_elements = total;
+		if (!elements_fit_in_base(fa))
+			return 0;
+
+		for (nr = 1; nr < FLEX_ARRAY_NR_BASE_PTRS; nr++) {
+			part = fa->parts[nr];
+			if (part) {
+				fa->parts[nr] = NULL;
+				kfree(part);
+			}
+		}
+
+		fa->part_p = (struct flex_array_part_p *)fa->parts[0];
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(flex_array_resize);
-- 
2.1.0

