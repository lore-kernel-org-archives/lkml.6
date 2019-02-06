Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0C6217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X914LnI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfBFV2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:28:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFV2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:28:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so9254355wrw.5;
        Wed, 06 Feb 2019 13:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=REMjD79T0FHMrNNon62g2SYipM1h1COazZz35+3JeWQ=;
        b=X914LnI917AWCcO0AJ98glANKNJYokEAYxU1A2sZKEhd5s171JAhAad0Y39rE0vcmn
         SYEw9EO0eQ9/60k9wf8R2dw0LltGc+XFVl8V15i3vFtQ6EqA9U0TBYr3G+mEdiVURjQp
         i8tSuJvvoSS9svlEZ+p+8rZWx/UbZSdn1QvUNOKCX3RUFNO8ySKUw1dwVeWNDT3ndsuD
         Rmf+NyJlAiQlHCFB+em57PvesgpOKKEQkgL7g76tAY14RLYhRvBUxfA06+Te40Aj3yho
         p5ksslVZ6QmnRHAXLe3bHbwP/2Z3FeaS1HomtLGAXZ9qX35YxTqTiWBjgdvzJKzk0nrl
         Nv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=REMjD79T0FHMrNNon62g2SYipM1h1COazZz35+3JeWQ=;
        b=Ykm2mSPfkDdgMnzoZKzVEE547mhpzPDHJVzQiSaUjXH8/5fhCDdEG+0+XwgrDr1QZj
         AthDw38Y3N+RDbfGi0Piz8Kr3TafgeVyO+k96ZJvlpalTcfo5R27fUsUYW4nC8rzoi63
         CmcAJhTHGoW1X3SWrmaOlPEU7hB/hZoA6Yf+yXvXMl2Nqob1D0LiOcDznUmcqKyrA+4A
         WBUpNP5rI9Q4i/ToZk4MalEofyhGVRCndK4rdyGEFqgjgLCa8LiTpX/jcLKbIZobj2aB
         KSonohaL0FBlPUr6xglzyv++aSeD8klP9psBtxROvr2F+gMuGI1NKn0yikVbVER8WS6F
         BqPQ==
X-Gm-Message-State: AHQUAuaEZSFtkxglaF6f/kWMXrkj1neFkqpr7Yu4Wf0OFxfYzFzzw7i3
        M+NljJGdLlBcXVOVbFPB+2Y=
X-Google-Smtp-Source: AHgI3IZd+4xDysd29lvbbWekKNnJ0udnrvsA1Zpb+jLLUUO1S6VIiMHSYO6bOgCE+IKGyvwUGlZYXQ==
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr9934281wrx.1.1549488532858;
        Wed, 06 Feb 2019 13:28:52 -0800 (PST)
Received: from localhost.localdomain ([89.128.102.109])
        by smtp.gmail.com with ESMTPSA id e27sm33766434wra.67.2019.02.06.13.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 13:28:52 -0800 (PST)
From:   Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Cc:     Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH] HID: steam: fix boot loop with bluetooth firmware.
Date:   Wed,  6 Feb 2019 22:27:54 +0100
Message-Id: <20190206212754.17929-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new firmware for the Steam Controller with support for BLE
connections. When using such a device with a wired connection, it
reboots itself every 10 seconds unless an application has opened it.

Doing hid_hw_open() unconditionally on probe fixes the issue, and the
code becomes simpler.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hid-steam.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index dc4128bfe2ca..8141cadfca0e 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -283,11 +283,6 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 static int steam_input_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
-	int ret;
-
-	ret = hid_hw_open(steam->hdev);
-	if (ret)
-		return ret;
 
 	mutex_lock(&steam->mutex);
 	if (!steam->client_opened && lizard_mode)
@@ -304,8 +299,6 @@ static void steam_input_close(struct input_dev *dev)
 	if (!steam->client_opened && lizard_mode)
 		steam_set_lizard_mode(steam, true);
 	mutex_unlock(&steam->mutex);
-
-	hid_hw_close(steam->hdev);
 }
 
 static enum power_supply_property steam_battery_props[] = {
@@ -623,11 +616,6 @@ static void steam_client_ll_stop(struct hid_device *hdev)
 static int steam_client_ll_open(struct hid_device *hdev)
 {
 	struct steam_device *steam = hdev->driver_data;
-	int ret;
-
-	ret = hid_hw_open(steam->hdev);
-	if (ret)
-		return ret;
 
 	mutex_lock(&steam->mutex);
 	steam->client_opened = true;
@@ -635,7 +623,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 
 	steam_input_unregister(steam);
 
-	return ret;
+	return 0;
 }
 
 static void steam_client_ll_close(struct hid_device *hdev)
@@ -646,7 +634,6 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	steam->client_opened = false;
 	mutex_unlock(&steam->mutex);
 
-	hid_hw_close(steam->hdev);
 	if (steam->connected) {
 		steam_set_lizard_mode(steam, lizard_mode);
 		steam_input_register(steam);
@@ -759,14 +746,15 @@ static int steam_probe(struct hid_device *hdev,
 	if (ret)
 		goto client_hdev_add_fail;
 
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev,
+			"%s:hid_hw_open\n",
+			__func__);
+		goto hid_hw_open_fail;
+	}
+
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
-		ret = hid_hw_open(hdev);
-		if (ret) {
-			hid_err(hdev,
-				"%s:hid_hw_open for wireless\n",
-				__func__);
-			goto hid_hw_open_fail;
-		}
 		hid_info(hdev, "Steam wireless receiver connected");
 		steam_request_conn_status(steam);
 	} else {
@@ -781,8 +769,8 @@ static int steam_probe(struct hid_device *hdev,
 
 	return 0;
 
-hid_hw_open_fail:
 input_register_fail:
+hid_hw_open_fail:
 client_hdev_add_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
@@ -809,8 +797,8 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_work_sync(&steam->work_connect);
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
-		hid_hw_close(hdev);
 	}
+	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	steam_unregister(steam);
 }
-- 
2.20.1

