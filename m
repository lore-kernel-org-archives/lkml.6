Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AAEC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E0F20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pybt0gX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E0F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440192AbeKXBpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:45:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45376 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbeKXBpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:45:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so3465689pfd.12;
        Fri, 23 Nov 2018 07:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jgnGcEVugVWlSuF1lHTPMLtj0j/NwsMZfX+9+cdul3c=;
        b=Pybt0gX6W7dywEDsog/lXmUB6Knhp6fDLmS1xg3elgN0e7sb7fK1oazGmR5/lrFIp1
         r7J7OLQmCeua0GoPo9iH7+m5atYALovtMfqYuc5MHZfnTom42WXIEn68asXsOczCafkQ
         NnecLvJNFvJ4S0twUm1GfWx2xl/gNYE1D1zprSX+kgE0OX2eikbDzZiFGphRSN610MB/
         K+/xILMiPpSjHuvkLn2QQgRhk3pFiS9ZWMrOvIFom9PZqZ3QKSCYCy9SvSM/hievTr30
         yXFI92lI3WVUfnsF8MkjiJ1fNgKiDP4mNWBxO4z3wn1s15J6YXEiWvd3t6DqMg0U6me2
         AhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jgnGcEVugVWlSuF1lHTPMLtj0j/NwsMZfX+9+cdul3c=;
        b=HZSV8cuoAqpiBcaPDTf1ILcWUOcyDjswrLvvzBPBDldK/oyL3Ma4/khzrOpIdMZA87
         jeayQ/Izh9mNNdDip58gR5mFLxIOndrJjyyvSGRcpy7ovclHfMSQdAsh/cCxTGQ+cXx8
         qN2IR34xX/W/ZSPeYW2qchFpHuAEdeeKpunNXbU5Wp1CKowSa7bs644Dhz14cL9sbOen
         aTxB3BjfVXFUyHULG0sE7hjDEN7T/qlMGqmZGI0QIbkaDhNrKcqHOoRYDXcnvy4JYDJM
         aHvQcUfMyRIYxZSPQQxlBQrgWYpyKWUiqUpo9W0ES6EHl7//6p90O3FOVRTIj2uCYgqx
         BLaA==
X-Gm-Message-State: AGRZ1gIVRRXe9Qyp/OIs4v2SG0Mn1wio9nxF6d1yVvaOr7uGslRsMoS9
        1Dja7dPgqZlXWIi/wMP0/fn7xGBXpds=
X-Google-Smtp-Source: AJdET5dNSbuIWBKxOuotf2QjQW0YRhRvgd05qJ6QxgloBCriXxP3ZSnJhUp/jnODVEwXft+QWKyHSg==
X-Received: by 2002:a62:4c6:: with SMTP id 189-v6mr16715324pfe.110.1542985268069;
        Fri, 23 Nov 2018 07:01:08 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d80sm131763253pfm.146.2018.11.23.07.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 07:01:07 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 23 Nov 2018 10:01:04 -0500
Message-Id: <20181123150104.27336-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/tegra/clk-dfll.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index ebb0e1b6bf01..609e363dabf8 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -1184,17 +1184,7 @@ static int attr_registers_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int attr_registers_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, attr_registers_show, inode->i_private);
-}
-
-static const struct file_operations attr_registers_fops = {
-	.open		= attr_registers_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(attr_registers);
 
 static void dfll_debug_init(struct tegra_dfll *td)
 {
-- 
2.17.0

