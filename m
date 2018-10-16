Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12BC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B510A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmbiegdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B510A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeJPK20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:28:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPK12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id f78-v6so4887818pfe.1;
        Mon, 15 Oct 2018 19:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8rdAtrhgVyi6Idogrfim0+bEai+yITDjSwhFdlBmD7Y=;
        b=YmbiegdYLklN5/9bAGuguRxu5eclad8PvHFzU3iKCosGLQnfrylAQcPRdl7Zlxztp/
         4czZTm666ZKcb12zkutShKMOiqvMYkjqFJZfohVxQ8EviuE2IOuzB6PYug2HiyCusjc3
         umfzBawMGXrnFOTrazt9LVhxY4RkOCOJDPAMwRN1w6U3FnNczBRZrJdZDExA7pPnV1V9
         UcqNAcHDEX7MCnCrZ7jSe7iflFp+6lwZQD25mEmWgymIJcV704vrLi7vtnoVuOgIUuXH
         95yqz5hzfZJ4Y9C4Ozq4s/Qtnb7at21eNbA+6G+YcsIu50z8bOkAhlU/UpVBmxEj74ZP
         jZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8rdAtrhgVyi6Idogrfim0+bEai+yITDjSwhFdlBmD7Y=;
        b=OnYWS/fYco1QExGj66cOd5RxDC/QW8o/6IjfJ86up/L2Cw1nTcLjMb2WnyyTuH/vGO
         Igy4kihAEKcWiU23cYAozJlBBtXBilVk4/ABGQb6g9t1vgHzfcNM6aJgd6A4tjS3eEht
         Fq7otTXdRVz/hopznuPlbemZ7O+UDuxSQgaiDmaG5kV1DgArGDyyiLV4QU8OhpZgcJMD
         lXYvSG2aztaw7Zxsrmj7N0ZBap5QGQ76LCZ5GYCIrgiSTBcQ5nuumTRcx3RjE+2xmUTk
         yRm3nEKr6RVq0ML5Iik+ie226Z3Vo7hJwXnT6wk0gmKqRd+xlMX38LD3EvbG/WZhzdrW
         cCzg==
X-Gm-Message-State: ABuFfohTTGiS+GWYE0yLlEpI0CN544Bi+xRJnge13wpLc2syiUCDfH+P
        qSGGFOfX9Ln9jAgb+2n02hU=
X-Google-Smtp-Source: ACcGV60JdzVhetJ75MQECTdqsHhSnWMs4quVhWGlUDPXWXLRlPpjgzd66tpbWDDtKnmCykGAQHJrHQ==
X-Received: by 2002:a62:384c:: with SMTP id f73-v6mr20171193pfa.242.1539657563837;
        Mon, 15 Oct 2018 19:39:23 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:23 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 10/18] of: overlay: make all pr_debug() and pr_err() messages unique
Date:   Mon, 15 Oct 2018 19:37:30 -0700
Message-Id: <1539657458-24401-11-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Make overlay.c debug and error messages unique so that they can be
unambiguously found by grep.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 3e1e519c12f0..34396d6db1b3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -517,7 +517,7 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	for_each_property_of_node(overlay_symbols_node, prop) {
 		ret = add_changeset_property(ovcs, target, prop, 1);
 		if (ret) {
-			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
+			pr_debug("Failed to apply symbols prop @%pOF/%s, err=%d\n",
 				 target->np, prop->name, ret);
 			return ret;
 		}
@@ -561,7 +561,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_next_level(ovcs, &target,
 						 fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -574,7 +575,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_symbols_node(ovcs, &target,
 						   fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("symbols fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -883,7 +885,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay apply changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
@@ -1142,7 +1144,7 @@ int of_overlay_remove(int *ovcs_id)
 
 	ret = __of_changeset_revert_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay remove changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	*ovcs_id = 0;
-- 
Frank Rowand <frank.rowand@sony.com>

