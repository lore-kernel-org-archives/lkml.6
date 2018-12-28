Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F07C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A166F20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="BROPuEVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbeL1Shq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:37:46 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:46394 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeL1Shq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:37:46 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 8691FC92
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 18:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VQUpIJ6M0v6R for <linux-kernel@vger.kernel.org>;
        Fri, 28 Dec 2018 12:37:44 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 59662C9E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 12:37:44 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id q207so23442346iod.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 10:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eljkChJOJ7jxmeofuZOEFa4QAMQj6Qg64V1kBued0VE=;
        b=BROPuEVJgmR71YxhX9PgObSMlPREc0BRf8fZjyztpSWC19jdPkwRQG4M+a1Tq6rE1W
         wvEXuCnmsHpgdZ94iBuFafhJPP8NB+70RuU31T0heNZxjlQB+mQ06ryZCJ9WYJcFGNDM
         UiVZ7kMjDh2Pabp4qYFgIdOahFnNO3MUXO8oRAm1GC5J1L9mlMl3FTu+G5GlD5ISQO03
         Z3sCl8iLiUu1fApSQswuzh+KIpCN8w0FnM+qXD9WO70KfVhOkW3Ghbf7AzpkX8c24zOe
         oHN3HjWCitcusGSLaQSBUgPfOYjkxlC5P1wq7ufI0jY65RqFBnH5OQRyrS7Oqlg/AsjU
         vWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eljkChJOJ7jxmeofuZOEFa4QAMQj6Qg64V1kBued0VE=;
        b=U8X7G1rigDg6/CX7b76lkFQFPq88bv0lhJHD5jxUaRjM93f3HETi6VkpNjZEze9ZXZ
         TBxRWM1QKQLIqgf3UYYqti8/f8YEDXkJnNe+rKB5A3wLKJdeug93zYJF9NOkYb9VKnu/
         w7XBNkeF8ckncERbb/m6keIARraHCO8HKUjoG2iEyiJ/ZZRrewlSAgTSvn3yxx0Foxl8
         3dD2WW56UK518i/AtuuSJzZ4hR+9OyfQi+ZUP+h1cVffG5NwZR2PLBU1C++vtGDoLTiA
         6+oa9hlCbRZ/1R4fyRHcIn28NgXtQmwk2s/fzhovMFqp98zwkMk7e1O8aMZemuX1I7jZ
         +gwA==
X-Gm-Message-State: AA+aEWbUCe5jiMENhSjJnJOP9tbjLBR7UPOptQ0Q6wm8K0YfKjJDXCkU
        nZCoYJrE70u+7bnG+vyXA63MhYDV4Rdseukr5EN+CyLjSo+T0B7nyjek/g1SVqI0JRwjLfV9xWu
        breyrHZVFgRpFlcSTEkuwNDONqQgg
X-Received: by 2002:a02:a397:: with SMTP id y23mr19483868jak.9.1546022263923;
        Fri, 28 Dec 2018 10:37:43 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WODJYILaX3OjrQ1vjAibJchrlXa1lJk9Sk9XeJG9hc/d1a525kA1/fhaY+EEhq+KMm1UZYNA==
X-Received: by 2002:a02:a397:: with SMTP id y23mr19483857jak.9.1546022263658;
        Fri, 28 Dec 2018 10:37:43 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id v202sm15788444ita.13.2018.12.28.10.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 10:37:43 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Erik Andren <erik.andren@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: gspca: Check the return value of write_bridge for timeout
Date:   Fri, 28 Dec 2018 12:37:36 -0600
Message-Id: <20181228183736.7823-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In po1030_probe(), m5602_write_bridge() can timeout and return an error
value. The fix checks for the return value and propagates upstream
consistent with other usb drivers.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/usb/gspca/m5602/m5602_po1030.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/gspca/m5602/m5602_po1030.c b/drivers/media/usb/gspca/m5602/m5602_po1030.c
index 37d2891e5f5b..5e43b4782f02 100644
--- a/drivers/media/usb/gspca/m5602/m5602_po1030.c
+++ b/drivers/media/usb/gspca/m5602/m5602_po1030.c
@@ -158,6 +158,7 @@ static const struct v4l2_ctrl_config po1030_greenbal_cfg = {
 
 int po1030_probe(struct sd *sd)
 {
+	int rc = 0;
 	u8 dev_id_h = 0, i;
 	struct gspca_dev *gspca_dev = (struct gspca_dev *)sd;
 
@@ -177,11 +178,14 @@ int po1030_probe(struct sd *sd)
 	for (i = 0; i < ARRAY_SIZE(preinit_po1030); i++) {
 		u8 data = preinit_po1030[i][2];
 		if (preinit_po1030[i][0] == SENSOR)
-			m5602_write_sensor(sd,
+			rc |= m5602_write_sensor(sd,
 				preinit_po1030[i][1], &data, 1);
 		else
-			m5602_write_bridge(sd, preinit_po1030[i][1], data);
+			rc |= m5602_write_bridge(sd, preinit_po1030[i][1],
+						data);
 	}
+	if (rc < 0)
+		return rc;
 
 	if (m5602_read_sensor(sd, PO1030_DEVID_H, &dev_id_h, 1))
 		return -ENODEV;
-- 
2.17.1

