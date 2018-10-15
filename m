Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C1FC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F2020876
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVujcNsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F2020876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeJOIJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:09:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36247 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeJOIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:09:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so8308992pgv.3;
        Sun, 14 Oct 2018 17:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7GuCPMc1W5/wwPeXRUqL1/hLo5USFMzrx8T5Pgg4dsU=;
        b=CVujcNsMF1oqGxEW1W1tfddklDnHVfzOi38qrQ3lUc5o3ttgoO9iNa2L7imWUWNycv
         1isqsO/ojbuG70hnPatC/o+JeHQ9U4Y42vKuGZ/LXdFnyjPyfpG+hUS5CiTzxHF+hoFq
         fz1TZ0y+TGXMANkhae02ElLmKKNKNDVN/LHtq4dg8tfpHUssBD8eULAVbIxoR2yqhRcI
         AiA4mC8WmDVSt9srxnfHnr7LPjlHeGdHRFErKSiobJs4G84O9Y4PH6TCx2ACPoLK3Tzd
         aE3olzk7wjLgkkEQqryGLJW8Uhcf48UCEUe7Hp97AHHQUxJE7+qc4ASNOHe8l+aYmH2r
         i8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7GuCPMc1W5/wwPeXRUqL1/hLo5USFMzrx8T5Pgg4dsU=;
        b=bvqhmHZvOZs0DQK9sDa51RAFpSw/vGvxA+ksBwIr1iyRovg7JERmImv0l2UjyiGa8y
         dWq9rHbtNRC5F0UC4vvpZukZnThQDIMoCLRTqrf20KZGOUK4BQ0XcMaxBnZt10wNMZs4
         Sjp9akeUhuyM2GF4+f1dRO97H0YmNy1JhOrWV5GaK2EJ7sM+tCXx3n7+hyIJdSvlzhrX
         LFVxECxpShsd9cR9oBpWOjSBfm1t+/hSSLC2L/QHZq4lS1UU/wACArxWowpGkKZ/u25F
         /F5upIjCq1hONQwuim2s1mnDm72wrux4aNES/i2XSMa/wBy5H0yAF65+tkOsxRjUFa7l
         Dadw==
X-Gm-Message-State: ABuFfoh4ZiAdT0TitUymEOq3VMqf3ibozlMNhfAURmDvqpAe/xtivLpL
        QZG0LAWJR3irKiH/m5eGIDo=
X-Google-Smtp-Source: ACcGV63ssYWjlCFHwaaVc/eCX8YJpLLwgSEzwk0hms7zkMjTKVEzZMXoD/HSgCRvYE9InqS2HNOYng==
X-Received: by 2002:a62:7885:: with SMTP id t127-v6mr15196324pfc.259.1539563172417;
        Sun, 14 Oct 2018 17:26:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:11 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 10/18] of: overlay: make all pr_debug() and pr_err() messages unique
Date:   Sun, 14 Oct 2018 17:24:22 -0700
Message-Id: <1539563070-12969-11-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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
index ee66651db553..a3990c20e210 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -513,7 +513,7 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	for_each_property_of_node(overlay_symbols_node, prop) {
 		ret = add_changeset_property(ovcs, target, prop, 1);
 		if (ret) {
-			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
+			pr_debug("Failed to apply symbols prop @%pOF/%s, err=%d\n",
 				 target->np, prop->name, ret);
 			return ret;
 		}
@@ -557,7 +557,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_next_level(ovcs, &target,
 						 fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -570,7 +571,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_symbols_node(ovcs, &target,
 						   fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("symbols fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -879,7 +881,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay apply changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
@@ -1138,7 +1140,7 @@ int of_overlay_remove(int *ovcs_id)
 
 	ret = __of_changeset_revert_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay remove changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	*ovcs_id = 0;
-- 
Frank Rowand <frank.rowand@sony.com>

