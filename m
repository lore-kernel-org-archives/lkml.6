Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42429C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CEB223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjpVzsy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CEB223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbeKMOdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:33:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43644 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:33:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so5352781plb.10;
        Mon, 12 Nov 2018 20:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3y+yTLwyYVx24KL2ywn6JGLG8tzH987amqhBDQ2OLYg=;
        b=IjpVzsy6nOdvvlAqkuRLmeq21SVsQSspmwQtz0Hh3Yfq4/BEzmwutMFD0urp1d9PC4
         5zTNyWa4du81WqiBvL8OV4oUXkQxBZm2NH4utTI+ExBukPelPGYf777xf0w6icOb6F5H
         0dKUT6P8wlWaMRCUsvNIgkTGpmm69g2VkSaSkOTonnTB9rIVfKxK9IJXnF1ySZtkDmSW
         D7GhtkKW8UAZ1hu3NNOGGf6/e3SFesruoh1H6heioVBuktCUwnmjsPgqvpRQHIFBVQ9w
         X7y/q3Y4UVIXryuUwBnQ4+Vh6HwQbQuOXkIoyKxW/p5PSvnxhxpqhsOKGGNdZhlvTDFt
         tD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3y+yTLwyYVx24KL2ywn6JGLG8tzH987amqhBDQ2OLYg=;
        b=slsujkTKbRc6WHMgEfIYu8Q0Yivb9+Gmh8+qb9NvtP2gEgCfDec0BRwlomNiPKV8P+
         EAV50aVrSKIZNRAQf3BRfKQuTct7xmyqIBQAhxnr10KMo9UBlZGNIzmjeFYOjGdy3JLQ
         1uZrVk/Uu6erRLXX77O4heVatbyv55Y60QM+oJPL1CkHle2tWghiMRTGYnb2NL8HjIFG
         /mxrGyC6jIXS3i3swi2tbjzszGeuYMrlBnL7OWTxISvOwbV19psmXIvjtd1ZST1JqDQk
         0KCYSVuyAfAa+0dAGBfMAwImve0nClSulSSkRxRzbVu50OAQAT4gWn26N2zu7T7ofchT
         pnBg==
X-Gm-Message-State: AGRZ1gLiaOVs9aTxDheDfrsLMxIpGXE4UoShPM+cvREjsrhd5XqKrmQu
        sF6211znErpwOZDKWVVkP9oGZBl6
X-Google-Smtp-Source: AJdET5eLYnQ/asYsTrJsORn5OsfoEB0WTsL4HnDE26yiTYOfwZN02TFJycT81w4hw/n6R95aiNBPjg==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr1694816pls.167.1542083825378;
        Mon, 12 Nov 2018 20:37:05 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d24-v6sm31481333pfe.40.2018.11.12.20.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 20:37:04 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon (lm63) Do not overwrite data->kind
Date:   Mon, 12 Nov 2018 20:36:56 -0800
Message-Id: <20181113043656.25765-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the code right before the removed line, data->kind
should be either from DT or from id pointer. So there shouldn't
be an additional overwriting after the if-else statement.

So this patch just removes the overwriting line.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Guenter,
    I have not really tested this change but still sent it out
    since it looks obvious. Please feel free to drop it if you
    have concern at an untested change. Thanks.

 drivers/hwmon/lm63.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 4c1770920d29..eac54b9cdeec 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -1120,7 +1120,6 @@ static int lm63_probe(struct i2c_client *client,
 		data->kind = (enum chips)of_device_get_match_data(&client->dev);
 	else
 		data->kind = id->driver_data;
-	data->kind = id->driver_data;
 	if (data->kind == lm64)
 		data->temp2_offset = 16000;
 
-- 
2.17.1

