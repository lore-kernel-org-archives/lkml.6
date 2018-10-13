Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14084C71126
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D019621470
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDU/R59U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D019621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJMMa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:30:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33372 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJMMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:30:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id 78-v6so4778233pfq.0;
        Fri, 12 Oct 2018 21:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7GuCPMc1W5/wwPeXRUqL1/hLo5USFMzrx8T5Pgg4dsU=;
        b=vDU/R59UxNgBUQdVIijhDfniVNLzjvH2HotEL1fSH5I9SWYnqEjIKe8VQWgSTQqCMa
         PNzB7hXsbj++52zYAxk6zYD0la1P/BJ/YF97yreSV8ZMo20FOi87nzlfXFvZd6PI0OuZ
         tK41qaQoS20V4oUOgrtFSSuRNndG/Mko4b7lXmrsNvp5VTFMsSmajRCg2brt5O6Q+aBp
         HX4K5MzZyY5bodEdhpbleIIZekaGjGSXR+HiXwA+aTP2kvASdT/DdeIoLT9Bsfz8Deaz
         57XIvE//A8p+UcfvNNZAOEkY7tI6Jft+dugaGawBeLJPyVwp6KR7FWh7DuFUBoBn7Qcw
         YqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7GuCPMc1W5/wwPeXRUqL1/hLo5USFMzrx8T5Pgg4dsU=;
        b=DviZZC65fAw46M/H+rCvyWOVAzJLpsxn1nMTqfUZgqZ5xWmGKIkJjaiT7cOHCRGpYC
         wRxxTCb9e24mYFCmqyK5fggpE/7vytur1hMK9Q3bZIOp8xGyUeed76lsPFgIu0u8xjYW
         fQZxPaACAVKpgQpboTmPCTWfaEmLNQomvt/0cLYaZKHJMwpNx8G1cQlNIsALsU7Yt4Fr
         0+5a8mj2SImGMZ+UkJoPrCJYepQllkNMhJZSSrv1XafXpGGIXP8J+UHzQxE7gaIazYay
         PXnSp7GF5/WPU4NqhSumLbLJJv0hPQP3PPBWYUuC+em+W9Otfjo6To9Gg4+h1ELt2IJs
         aSug==
X-Gm-Message-State: ABuFfohOhODO5P5PePo+xKhIJqCIh7h4XD5GJJEwjKTTFoK6OjQsVWgd
        QMH+fL0ZSG+whGqcIvPxJZU=
X-Google-Smtp-Source: ACcGV62e03u9mIGxo9oTdxgRAgKIkA1RNREpFbyKgtmdMK14KbbsHddvmHYnNeN1VuPjGTsPm7c0Tg==
X-Received: by 2002:a63:4a0e:: with SMTP id x14-v6mr7986852pga.34.1539406517331;
        Fri, 12 Oct 2018 21:55:17 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:16 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 10/18] of: overlay: make all pr_debug() and pr_err() messages unique
Date:   Fri, 12 Oct 2018 21:53:30 -0700
Message-Id: <1539406418-18162-11-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

