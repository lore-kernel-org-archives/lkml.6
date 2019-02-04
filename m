Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882ECC282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D132083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Psx8d03J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBDWKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:10:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:32968 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfBDWJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:09:59 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so12783959itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 14:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bPU4yGp8groZzMsMQG7ObLh9y+ne17hprQCw1G/vo/k=;
        b=Psx8d03JsRW6hTGNB7jLBqBocu3HOSbn1YqneJQHtrJcWgk4S0aJ9Fi7TDEOuMtHsw
         +h8ZRJUMSQ2pOdM4beoifEmnN3OIWjrIMibyrw5dFZVCia1HjZTAz3QOSXz1W/u06kuY
         FhXNk7bwbSRUne0vQl3zEABX3HKJtCe/gWHvxEVfDpXk9UYVJZ4PcfqeAlaHM3scHHa+
         amEc5ZMkDobbXM4YN0N3R0djQ4U+kR6SYqVhseVHm1sQ3cdQqXA2t2EEOJpv6uEO6MUy
         Jj6wpJ+h5AUdKaAgDZBWsiGaVgknlrcpilPMyBKhgbT5UhhjduyRGelaJEvFVtjKGgAH
         UUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bPU4yGp8groZzMsMQG7ObLh9y+ne17hprQCw1G/vo/k=;
        b=Sj0AzeG6Ifv6edu3+oGpQRhJ8NgaVQIzg9uKle0uJt+qeYi28dmzranRujb2O/qgd7
         hg+2PjpjclOxY0rUgPNfcPuPS54AvcKSlWwJoSMUxwmWCqVBDirNffjI7RnVfNZWf0QF
         o6p1F+Eq5eWR2n6jyePvAeuHdvQXu3Z8vYDcq5308GTEd4Dwk9VUf5rDpUUMCYpOFwf5
         cSr1bIbNrXf4uwD9tLwpvpp3UU/vzjoI863UFEP/Wqy2WVX6DE9b4E89k6EHiz53gN2A
         MihBol+m6YGc7ugIpQH1KA5xknaSAh5goCHlTW9njP0aPztSMDcp+YptbUmSxH70typw
         hNhw==
X-Gm-Message-State: AHQUAuZfNjHzCa/sLmoFp8zoHepIsKRSXkAwxJp4e804CM3t4ujIWY1s
        rzrCuvwbExBHPuAzyT+W/+k=
X-Google-Smtp-Source: AHgI3Ib6DCnel7xMOWDrVjsNRMmiz49YIQwRQsnLFlsGDFazY8g+gmNyaCDjzdvc9o+F60HcSiDQdQ==
X-Received: by 2002:a6b:ef02:: with SMTP id k2mr859976ioh.95.1549318198440;
        Mon, 04 Feb 2019 14:09:58 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id z1sm531602ioi.77.2019.02.04.14.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 14:09:57 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC v1 2/3] max17042_battery: fix potential user-after-free on module unload
Date:   Mon,  4 Feb 2019 17:09:51 -0500
Message-Id: <20190204220952.30761-3-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204220952.30761-1-TheSven73@googlemail.com>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The work which is scheduled on a POR boot is potentially left
pending or running until after the driver module is unloaded.

Fix by using resource-controlled version of INIT_WORK().

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/power/supply/max17042_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 2a8d75e5e930..a61e2b81f68a 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1100,7 +1100,10 @@ static int max17042_probe(struct i2c_client *client,
 
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if (val & STATUS_POR_BIT) {
-		INIT_WORK(&chip->work, max17042_init_worker);
+		ret = devm_init_work(&client->dev, &chip->work,
+				max17042_init_worker);
+		if (ret)
+			return ret;
 		schedule_work(&chip->work);
 	} else {
 		chip->init_complete = 1;
-- 
2.17.1

