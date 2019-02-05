Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA47C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0508217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eLxHlkR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfBEOAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:00:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40728 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfBEOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:00:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so3715721wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcoblHFaFi4RsLO9MO0RZmYRV0JEOPvzVX0oVuZ89dg=;
        b=eLxHlkR9KU4a/WB6sEzXMS7vYfI0JNcgBUOY/KQPKVMKlNhF+EuSoodN1AV8mqFpfZ
         No3cDT4kNzotzRLTd1xACimWWxffwikskI81LgQnXE6V0REv36Pfc1h4Vo1C+lXeiFm6
         vE03Rk8cqygciI8qJcfNHPR+5Nw5uVdRWiM9/9IPlmxqm3Tt4nMAweotIrGsB5f28eIx
         26fEuTaZHiTUBGMJ0hxVoaWZPHZSXg1KQrPjdAFNsutkXzomSVoU67U2rsLIWxIRoOYa
         TrneDnW7b7beMHPODp5nNRpscrjHg7Q3uVCb6mDVPNVcsvwFO5U3XvmM0UKpgahwfuta
         Q9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcoblHFaFi4RsLO9MO0RZmYRV0JEOPvzVX0oVuZ89dg=;
        b=Y8opnI0S2PzznVL6FJ2G+MEc0OUrdm66C9hiffoiui+W3q2s/timg0G1LdK4aLiEQs
         +j/r/sCUqFUBdG0eHgAbJtLsqeNaVFbWjz4ffLMzLGtpCH5+J5b29X1qhQnpLIRtD63b
         reMltkQ4dVWzH5LA64bbMczXG8FxGNGhnK0ScubblHuw4dXV0SIgDedVZHoxpsiyTect
         34fdr9rnD5i6PVBLIEbmWUBgSqvqEnwF73DQJZKjf4uMGqDvayhFuME318AG+HHsm+N4
         LBC8rX70wqKNZdKGqY7YqGjOae3Wg3cZQzxlXduDmniGDJThJ7KYbnnUVnyE3wXGW69D
         Oosw==
X-Gm-Message-State: AHQUAuZREBb12Y3vAxg5xKMTNKgLhUflu16BUdHJSn2509aY9nDld3Ub
        rERrCb+2GLaxvbxaij3WmSR33A==
X-Google-Smtp-Source: AHgI3IaibYCvQPlV5IRBR/B/r5m5zqLk6pg3cabycXkf/QEmtvDPI0nSqGpzide6akmF+EA3mph/hw==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr3822197wru.300.1549375204404;
        Tue, 05 Feb 2019 06:00:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y1sm5560379wru.4.2019.02.05.06.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 06:00:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] eeprom: at24: implement support for 'num-addresses' property
Date:   Tue,  5 Feb 2019 14:59:34 +0100
Message-Id: <20190205135934.18841-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205135934.18841-1-brgl@bgdev.pl>
References: <20190205135934.18841-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

If the device node defines 'num-addresses', let it override the default
behavior.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b806a403ca46..63aa541c9608 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -641,11 +641,14 @@ static int at24_probe(struct i2c_client *client)
 	if (!is_power_of_2(page_size))
 		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
-	if (flags & AT24_FLAG_TAKE8ADDR)
-		num_addresses = 8;
-	else
-		num_addresses =	DIV_ROUND_UP(byte_len,
-			(flags & AT24_FLAG_ADDR16) ? 65536 : 256);
+	err = device_property_read_u32(dev, "num-addresses", &num_addresses);
+	if (err) {
+		if (flags & AT24_FLAG_TAKE8ADDR)
+			num_addresses = 8;
+		else
+			num_addresses =	DIV_ROUND_UP(byte_len,
+				(flags & AT24_FLAG_ADDR16) ? 65536 : 256);
+	}
 
 	if ((flags & AT24_FLAG_SERIAL) && (flags & AT24_FLAG_MAC)) {
 		dev_err(dev,
-- 
2.20.1

