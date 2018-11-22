Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C090C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6DE206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7vMjAkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6DE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395159AbeKVXSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:18:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40714 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388442AbeKVXSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:18:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so9227233pls.7;
        Thu, 22 Nov 2018 04:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4lYKsHhdk2yXI2fDKR6CiPUJ03DRVvFgdek/hwGbk84=;
        b=m7vMjAktWP2CaUhRLiceCe7jmov0OrTpRvgOjh4Y1YVC/O/TOKsk7DLExhU6InnhTi
         f8tGxfClxJeNOgUwa7e2f/Q/gAsyfhDaeEG3LcoGWkP8O9i6LjjGJRL+MvhH5wwrrYAP
         z69oTFSq5pyb61hYjjt6y3js+sXiAJ3mLvUOFCL/d7g4pkBzc+N5sxLeELDsnX5R7Ehe
         W6ExyeuuvMalskHmArBA2jMYGWcL0rRwXo5R64h4c2cAmtnsUXJISNFzF+9Bi1VtLsj8
         /fwI+FzPuH7kqCbic4JYXycx5uYGXEvfO3TZK6VS8055WFyWsR48ZPlCjR923M6pYHIc
         CqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4lYKsHhdk2yXI2fDKR6CiPUJ03DRVvFgdek/hwGbk84=;
        b=t5tzDOpYv1E6voU7lrTkHgUo/RfsqLGiwWY0KekhKFXqdyJBa1tiLRZNRdQn6mIb8T
         e7rZUVEyR+/hUZ3PH7BVEXUvjBq4T5oM7F+iJYak4XtDs4XluTYyhvxYVUhrFSAT6OE7
         982qSfXDfZoikCD0n1XSnhGiJKqFAa8Xzne7CQ1kvqbYgM7hj+LHA/RSQp48Z42vJ5Xq
         TtAaXrgNkMcx7HDiDobSm83EMExUf9Z1QC38eR4uiQ8YFzdxMgsxS+epO8pbTiT/NQVA
         e3p8JVj0FVPcttSBkAVI8nqeSB9doymzsP6Lgq4wOoFWdkKBBQk38L/4JSx+ZrTXq1dG
         qHqQ==
X-Gm-Message-State: AA+aEWaP7OV/HdzOxXjkS8gdgJBanUCFErgtLYrjBrDoSbsrzO692L5N
        wIyC4+hslITlEn64v5RE9Mg=
X-Google-Smtp-Source: AFSGD/U9Rc14sdni6boSdZIb6zSf4OnEladPBV4WbjHkx0zEg5L/WjnBP0xzHNpckflPLDIO6EwAcg==
X-Received: by 2002:a17:902:7d89:: with SMTP id a9mr11163019plm.242.1542890367164;
        Thu, 22 Nov 2018 04:39:27 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l5sm6155203pgp.82.2018.11.22.04.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 04:39:26 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     sergei.shtylyov@cogentembedded.com, b.zolnierkie@samsung.com,
        axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] ata: pata_macio: add of_node_put()
Date:   Thu, 22 Nov 2018 07:39:24 -0500
Message-Id: <20181122123924.24438-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-update changelog
---
 drivers/ata/pata_macio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9588e685d994..8cc9c429ad95 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -483,6 +483,8 @@ static int pata_macio_cable_detect(struct ata_port *ap)
 		struct device_node *root = of_find_node_by_path("/");
 		const char *model = of_get_property(root, "model", NULL);
 
+		of_node_put(root);
+
 		if (cable && !strncmp(cable, "80-", 3)) {
 			/* Some drives fail to detect 80c cable in PowerBook
 			 * These machine use proprietary short IDE cable
-- 
2.17.0

