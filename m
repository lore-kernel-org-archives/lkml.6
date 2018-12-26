Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52707C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EAB217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ZBZwDsjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLZGbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:31:49 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57134 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLZGbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:31:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 05A3F98D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 06:31:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RLgZ5dXduG9o for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 00:31:46 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id CBAC397C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 00:31:46 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id t133so18399543iof.20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=re0tf74/KJt9sPQ9wQiDVEBYZecLXEvvx3cz4HAF+gc=;
        b=ZBZwDsjSOvKqQffQyKyFcuwWTg5X9CqHX24OAZVUo9PFhBBOqCYZCEFuchKt2mHgSm
         f/QgVcTvI70HH4IWFCN7n7/fnSh+EaccQkkxw3z7iOZwNOQRjRLqj/59wTAM4PRfo902
         O3zOufynqxzZstZ8lPReUHe4NITOvarNNRoZOBlLiaWjYZn3mOXNgBwkbCUa/+HSdXC8
         EILKsDBdQlgTeF1Ertiogbv/msKZGYH4liEcFDc2gLz+Fcrw3x8UlHo7xs7D1oSA9EC8
         GIsYm9th+OXN5IV/m34rbNqbWjPhXhuarx3kdMOoBHxCyKs66/52tl6nLnWH1DhRlNdC
         bPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=re0tf74/KJt9sPQ9wQiDVEBYZecLXEvvx3cz4HAF+gc=;
        b=YVtLOSSob2BIKxKjAofFNMJWAxyZNsDqkQKZ1v+XQi4984pgfSxPHtnSycnmQaQ/Gh
         mgXjpDFl0WikvMyCpqQggSgXtX8dcOrZ76R8wA+ZAFN7ZVHYW+T8mrFmFYDeSQ79MeBm
         ImJTJzu/3MEdwEic3/qd7+HF1TtnOesgn93OU+OjgUgFpt0gjW490SfaXL4DDAeJXMqe
         qoGejver8b2jP123xSImZOfyKfJQyJH7y/CiK6he9Ld9fAiB+IrHBD6au/A2aKfXKt0m
         1rZ2oBL7TAdDz+RXohpZyM0bPTdHgqmVhTkY+OacWLbLLmV72X8U5QXoTGcfsXDODyoe
         8/Dg==
X-Gm-Message-State: AA+aEWZTwFBuIiuY7UsDICafKyIoE/18XGE1gRVl9a+BTcF53n9AweKK
        tyXCwxQnqXNDrPQFllHIjDKxsqcRDSWxqo6ZZcUCKuIUFcVBULhJbSPDX6VFz2/jZ5gCB6lZqBq
        T+1X9AR2TcdbIdHXqQYV0zsyeu0Yz
X-Received: by 2002:a24:7284:: with SMTP id x126mr13016623itc.96.1545805905301;
        Tue, 25 Dec 2018 22:31:45 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6HR413Pt4MgNhdARUvqJ2bYjyIcQd1EOSnpJxS5RvxBAyGp/TapnKrtq77Gy5XZnH0lQZumw==
X-Received: by 2002:a24:7284:: with SMTP id x126mr13016612itc.96.1545805905058;
        Tue, 25 Dec 2018 22:31:45 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id y23sm13958647ita.1.2018.12.25.22.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 22:31:44 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: marvell: fix a missing check of acpi_match_device
Date:   Wed, 26 Dec 2018 00:31:08 -0600
Message-Id: <20181226063117.75646-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acpi_match_device fails, its return value is NULL. Directly using
the return value without a check may result in a NULL-pointer
dereference. The fix checks if acpi_match_device fails, and if so,
returns -EINVAL.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f1dab0b55769..c9444346475b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5255,6 +5255,8 @@ static int mvpp2_probe(struct platform_device *pdev)
 	if (has_acpi_companion(&pdev->dev)) {
 		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
+		if (!acpi_id)
+			return -EINVAL;
 		priv->hw_version = (unsigned long)acpi_id->driver_data;
 	} else {
 		priv->hw_version =
-- 
2.17.2 (Apple Git-113)

