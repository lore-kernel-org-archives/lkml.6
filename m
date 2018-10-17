Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF246214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdQja/j1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF246214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJQIYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:24:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44823 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbeJQIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:24:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so11624990pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K8381H5xv4tlKpvESL8AJu4O2kzizMA4J+fj5HowhzM=;
        b=YdQja/j1vZMbmxt4/5Q5GUeLtOIp0NUMaqg34dlf2ePYrKkJnM+NpUXyNBYmyMWbYy
         AyzuvwTLBvK6hXOATYQcXB7ueuL0v6i4oqyetJygiO+bcToW24CDDQiXNwn1shfDof4+
         3GQMIUF9pSfOD1kEksOHscszTLibggXnV4P6xGi2YaMcXsUz903u36cDp5DayVuMkLiI
         Wec7O4xL9r2JZN0lJRLKZDuC/9voNgIcqz9cSberPIKc3u/5dYoD45PxnqVCeH0A3Uif
         XRARETcMZm/ZKHmXv5qunMRzmGD7Y3NrcVEwEtZnVs1VHadJk9x1uetYcbnaLxpPxBEt
         A+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K8381H5xv4tlKpvESL8AJu4O2kzizMA4J+fj5HowhzM=;
        b=C5tdxSJ6soe+L8hS0k/dmjLrAeWKIAa46X0GYjXHL+XijFM7vHuXpKg3ko7x1VWz+f
         XLD3ZRl2HrJmry2rh1Ua/hgsodPkbJ2U5aQ4OCZwq4BFq62cv5Oxzl90fA89jPv/pbT5
         /0Kyd7uiOXj8L8bHNPw0AxWEL2MnqKjDC0SoiVcRIjklfOLsXpHt8leCCldJpm7xm6/V
         Kwdl0aNTin2ccPgNPVneoQ8/05NS5F2rF2z+9t5dXq/cHcF/CLiNIdtyCW78L0H//B56
         uQw4zSPgE9/MYH+oiWqGLmmsJ6a+Oft9ckFO70Ojr6pMqehx9SHoVmG5yD0jFERHBaQn
         7JCQ==
X-Gm-Message-State: ABuFfoh97cz4NU4uvyGrOrMiBNcf2JE4RU/r6NpVjkLnGCyWLdOJHqmM
        QJEzPAVtQ+0yZasPSgDzv2w=
X-Google-Smtp-Source: ACcGV6081ZNUsWz7eqdtHHSeRzKIKvrMSkLevOD3MIv/BTYGg+7RryAxK6EcEbJrPRsO0vwHJLKMdg==
X-Received: by 2002:a62:454d:: with SMTP id s74-v6mr25034589pfa.136.1539736307864;
        Tue, 16 Oct 2018 17:31:47 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id e19-v6sm21781102pfb.153.2018.10.16.17.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 17:31:46 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpu: ipu-v3: Fix CSI offsets for imx53
Date:   Tue, 16 Oct 2018 17:31:40 -0700
Message-Id: <20181017003140.27248-1-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSI offsets are wrong for both CSI0 and CSI1. They are at
physical address 0x1e030000 and 0x1e038000 respectively.

Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 48685cddbad1..f487f25ed577 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -910,8 +910,8 @@ static struct ipu_devtype ipu_type_imx53 = {
 	.cpmem_ofs = 0x07000000,
 	.srm_ofs = 0x07040000,
 	.tpm_ofs = 0x07060000,
-	.csi0_ofs = 0x07030000,
-	.csi1_ofs = 0x07038000,
+	.csi0_ofs = 0x06030000,
+	.csi1_ofs = 0x06038000,
 	.ic_ofs = 0x06020000,
 	.disp0_ofs = 0x06040000,
 	.disp1_ofs = 0x06048000,
-- 
2.17.1

