Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5BFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503572083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj82rHeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503572083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeIZOsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:48:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51648 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:48:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so1306760wmi.1;
        Wed, 26 Sep 2018 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XGBX8FleWuHvexwQfEEFCexolkCjvHy+vQUuOui4WYM=;
        b=Gj82rHeEKUmgSlH51GeKo8K8qPzRHlzuw3OCEGFpsDtx66Qwm/dfWdDzDyxdezqHCD
         bCoLHHWh31HhvDjWkax2H0bra9Mw51eAFhbtms0QzuNxcoSVrrPsoQmVre3G/nVU4R0E
         BBiM+l3jKFYzRlmgqoHRhu2JZoHmwTu1bcMYfOF5MV36VqNTwXqFZQ2KgW9Pu/gbxmO0
         MJvjYmAxXa4xk3Q67+/YarDTmtfVZRcy10Pa9c9X49Y6rhbc40S3IOjUPBk/t2I2rKEf
         yk7wxiar3szh6hx5ZtqxAa/tVfTIOZEVxtnyT1Cb3X5AfnXJpxU0U3a8B+mMfxevDmU0
         tBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XGBX8FleWuHvexwQfEEFCexolkCjvHy+vQUuOui4WYM=;
        b=pdr7p0ac/5Pll9bFWX6ILYA9ejup0Y6niPukazW33qo/YQzJ4FQ7bl/0xoJatSkiPD
         UD79AvfVzMPQGUVjJVwqrHflQW8TRigEywP7s4wRkLqsE6LJwZENYXyk3GnvD1fsAo00
         QGL33o7z74uuKxOHwwbKJwRShWl61ASxk4pE3w595U+/pdojRI53MScJVveWrP68QeHF
         1SJFa5Q7wxx/zZVe/VqiDdJOEEnOJBRFhsfPEviv+z9Pec0C3zfPVM2WlY58sLaXWskh
         bTALdwe2Mln388vVtswRKTF19bD7sUMrz6aV381axLZZ5mIlNMzR36mWQhOy1xq1ULWS
         wTUg==
X-Gm-Message-State: ABuFfohM00ArR1NA1o1Jqyh5dbeyGK3TfTrWxe35JjsvBbHve9OTSeKc
        2SxPcMv3DYVFP+sSuxx1Ik44hlxn
X-Google-Smtp-Source: ACcGV625HTSHX0I7IxDDrhUBbYeEQonnEFZh/UInHAmRuujAUl6glHFykc5FGwr3lKzFCi1njY4jXA==
X-Received: by 2002:a1c:c3:: with SMTP id 186-v6mr3451949wma.126.1537951007584;
        Wed, 26 Sep 2018 01:36:47 -0700 (PDT)
Received: from pc-ceresoli.dev.aim (45.11.168.109.cust.ip.kpnqwest.it. [109.168.11.45])
        by smtp.gmail.com with ESMTPSA id 1-v6sm6332971wmf.47.2018.09.26.01.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:36:47 -0700 (PDT)
From:   Luca Ceresoli <lucaceresoli77@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH RESEND] i2c: mux: pca954x: simplify code to reach the adapter
Date:   Wed, 26 Sep 2018 10:35:34 +0200
Message-Id: <20180926083534.21999-1-lucaceresoli77@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

struct i2c_client has a direct pointer to the adapter, no need to dig
it out of the struct device tree.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---

Sorry for the RESEND noise, but my provider and vger are not
interacting (again). I'll solve the issue at its root ASAP, but in the
meanwhile I'm sending from a different account.

 drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 24bd9275fde5..bfabf985e830 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -347,7 +347,7 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 static int pca954x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adap = client->adapter;
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
-- 
2.17.1

