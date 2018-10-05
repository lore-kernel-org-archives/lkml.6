Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4517920875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="oGwj76b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4517920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeJEPL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:57 -0400
Received: from mout01.posteo.de ([185.67.36.65]:58613 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbeJEPL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:56 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E07DE210FA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 10:14:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1538727258; bh=QtsZEHeRfZ7OJkkRthjjZYZ+sD/UaKSAGERjoV2u/1I=;
        h=From:To:Cc:Subject:Date:From;
        b=oGwj76b0cbhX06BgleCBphK4n8fFCuRl1MHmDdoiiReS0EO5IFHd4xR/X/pLhmmUU
         8loFqVu1fHsFQaJNYCXBp88Gmiifb9UuTkK2FnMjoN6d5bOhHen2rMuI4Zw8ieX7oc
         RK76UZPPZy/+QoEndENQc+K74INmf0VGfybf/Y7cQXMQ89hkQTHHCnW01uclmSmf9B
         4go2awIxgFea/A73iKk5AUXUKLvU+whQXJE/uGAVU0ZxYgyGVVJcTXMvitjuWTosOH
         KbmRrZo6kOxQzDgsPzT94KMGrRB3JJC/+ZmoxeNkC/Ukq8l4rhWdHrZrLoxosOquTv
         rdW+dsqPlvv8w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 42RMwp2F0xz6tm5;
        Fri,  5 Oct 2018 10:14:18 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     dmitry.torokhov@gmail.com, geert+renesas@glider.be
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] input: st1232: set INPUT_PROP_DIRECT property
Date:   Fri,  5 Oct 2018 10:14:07 +0200
Message-Id: <20181005081407.15376-1-martink@posteo.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is how userspace checks for touchscreen devices most reliably.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/touchscreen/st1232.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index d5dfa4053bbf..b71673911aac 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -195,6 +195,7 @@ static int st1232_ts_probe(struct i2c_client *client,
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 
+	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 	__set_bit(EV_SYN, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(EV_ABS, input_dev->evbit);
-- 
2.19.0

