Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532ED2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnO0sNMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532ED2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbeKFArT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36403 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbeKFArT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id j22-v6so4601123pfh.3;
        Mon, 05 Nov 2018 07:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K0G5ldEhUnAa9Adg3Ykauulu7tP5kKPiQXQBmq8Ci54=;
        b=QnO0sNMNfQWByfFvkHTPidfaRvkv8dDJdvnRjZpImed+D4G0hDBjs393WvQo/WMhuX
         At2hJTiaHeQB8f/Q+hqaGk1xHkuTnU1NH2HTc+9elBAwU942o0C2yCZPy48pnX6U1qec
         NH5QCnfFnpcwYN+/gDgH1/ZhMgQuJHpczQwI5zYtlUh06Ug3iTueJ+6U1GfqW7svGpp8
         ho5FQcC+V4jnJDPtGNVCqhB+lmFQ4/L0PNyqHg0IkEgX714kfEsOtXyeGf5SRNDmme5p
         y8PHw2xLNY8yh2CpqoGqZtivqccUZA9TFyZKsec0PeuHmh0dRLvowUYayF5LM3cokoW1
         h44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K0G5ldEhUnAa9Adg3Ykauulu7tP5kKPiQXQBmq8Ci54=;
        b=SMJ1ez06i3/Tf6z+Q7ND0qAPZlZ746Dv718cxj+N+3fcjwHAghJ+FLx7VHtHPurtf0
         yiPDpQ9oo4EKEHKcoffRtK/jOhSDh6e4hncuNm/SZesu+JCPfwwE2PVKynpshujergmO
         UIDmJChSGHNtU97h+XJUus9OefBl2QFcXa/tmPlQoISK/k50T1YWIbJ6TG1MA/G5w0lT
         x8x8AMpVWhdEf5qQ5d4Wmll4PzaNC4qZeGy9t43l87tHVEQV75oHh2/WHJBsg/iT28g/
         iYm2Wp2+d9ZLzhdm5ogQA6qSiUU+eU0QbRDq5KdAKD8/P5AIVF9cLyE7Z+BMCqCHJw0u
         ztlQ==
X-Gm-Message-State: AGRZ1gKTr42c/tfbBOUcaGYWYjrsIq00EL4ljtZYW33gQOUiiu0z41Xo
        m1Wo5Wbnxx3YOR8QddI+N2w=
X-Google-Smtp-Source: AJdET5d6ZnMQExhvIz3wgIZJzcnDfSSbXIJMIJs52Ai73X7SJ4K3cxZHkP+8+ZJUoG+By8eWzb1p/A==
X-Received: by 2002:a63:8742:: with SMTP id i63mr18406014pge.298.1541431626030;
        Mon, 05 Nov 2018 07:27:06 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:27:04 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 10/18] of: overlay: make all pr_debug() and pr_err() messages unique
Date:   Mon,  5 Nov 2018 07:25:07 -0800
Message-Id: <1541431515-25197-11-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Make overlay.c debug and error messages unique so that they can be
unambiguously found by grep.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 72bf00adb9c8..c8f88b0836a3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -507,7 +507,7 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	for_each_property_of_node(overlay_symbols_node, prop) {
 		ret = add_changeset_property(ovcs, target, prop, 1);
 		if (ret) {
-			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
+			pr_debug("Failed to apply symbols prop @%pOF/%s, err=%d\n",
 				 target->np, prop->name, ret);
 			return ret;
 		}
@@ -551,7 +551,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_next_level(ovcs, &target,
 						 fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -564,7 +565,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_symbols_node(ovcs, &target,
 						   fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("symbols fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -873,7 +875,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay apply changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
@@ -1132,7 +1134,7 @@ int of_overlay_remove(int *ovcs_id)
 
 	ret = __of_changeset_revert_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay remove changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	*ovcs_id = 0;
-- 
Frank Rowand <frank.rowand@sony.com>

