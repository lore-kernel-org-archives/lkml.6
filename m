Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F422CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70AC208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U5Euhq7b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GhxMP14j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70AC208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fastmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965415AbeFOIua (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:50:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52677 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934701AbeFOIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:50:28 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 8061021AEF;
        Fri, 15 Jun 2018 04:50:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 15 Jun 2018 04:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=dw3V9oVcv3wp6JYIkZfEpD4fdBMqQ3dLcnC67dOfu
        LQ=; b=U5Euhq7bq9Es6LBd6bIeL8Jenw9+XgXnZh0pIqsTeK7l5+43rszMdaeyg
        DRxYOh3ONNmMxO2qiIZyTuS9CMm1T5QRff6rzHmRTZ6k8fOc1l0fU3jiBPXT0GaD
        lMQ9zhZ2RDvMvBvghmQK6ZRu9QhvllRCV0VmfaA6+CKIljiz9FTR5mx5ONT6KElq
        GqZcaeYbtJEJg+S7rcc44k1F7YE8jipPxnZnlMWNLo/mJxIv0M3BRbDP82o4SS0S
        1cqz6sH8BwMuEu+LwvwDNAjeIk9f0tIe7NGVCTz7DwyVRrxAQBGthCg/TmzCRusH
        01z3NXcXl4D6Jypm8xzHbOEi6wCNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dw3V9oVcv3wp6JYIk
        ZfEpD4fdBMqQ3dLcnC67dOfuLQ=; b=GhxMP14jy88PUuHxtuT45pufGn5yD7Wm0
        tZjD93NvA5BhnhTEY1U4n5FKVeXyb4KUDVBtkKajTaLTICUzhXuGKoFY81vr3S7E
        zgwN5Sx54PQSOooeO3veC5lB88jazeTZKpcBC7cy1hYFpGvj/DKrize2n3Nahoy8
        oEufPkaWoFXNI1pRL8YAaPVpY/b7PXDmYFpubxqt5drPXfpRYEOxhTEfHvtyEwKW
        98T7oYeQs9GxI6Yqg4N/1M4xneCtdCi1Ogk2moEx+Vyo5GXfrBHyJ34RzsmK3Vzz
        VQgKETtHtuZ7VavSWO5bANy6XTPxHFgpv/3jELyj568Qxvyd3HEyQ==
X-ME-Proxy: <xmx:030jW3JBA2u9U29DJuOtsTkWGn2V9CX-jv3XLd8Vytnx8ojPm77U4A>
    <xmx:030jW55nKTf7Y7BiaszW_ojWmjtqtIpkFweOp9XMhl7Uy9YNBziVvQ>
    <xmx:030jW_Savj7NNx-z1VGn5dgHm7jxWUW_TLaHSpbKPqSpuP_Z7OoKRQ>
    <xmx:030jW6t3hgjirYEAfyUJixhIivuEXElMUqLWhjJEcB5rlEk-FDP9Kw>
    <xmx:030jW2ufRySCy_SGgFod5UxHEYyT2et5eC2pP8Naj-w5SnyXgzXQMA>
    <xmx:030jWzmunYUNcG_ztw0TkCUX_mvkVvsUbopIxXP8meW3eE4MthAvzg>
X-ME-Sender: <xms:030jW6BSxXnxfRGVBkdhLXujGUsqC05D-KLYxR7FUbZiudLzyYj5iw>
Received: from blackbeard.lan (pool-108-18-105-9.washdc.fios.verizon.net [108.18.105.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B0171028B;
        Fri, 15 Jun 2018 04:50:27 -0400 (EDT)
From:   Tristian Celestin <tristiancelestin@fastmail.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tristian Celestin <tristiancelestin@fastmail.com>
Subject: [PATCH] Default to s2idle in all machines supporting LP S0.
Date:   Fri, 15 Jun 2018 04:50:18 -0400
Message-Id: <1529052618-370-1-git-send-email-tristiancelestin@fastmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell Venue Pro 7140 supports the Low Power S0 Idle state, but does not
support any of the _DSM functions that the current heuristic checks
for. Since suspend-to-mem can not be safely performed on this machine,
and since the bitfield check can't cover this case, it is safer
to enable s2idle by default by checking for the presence of the _DSM
alone and removing the bitfield check.

Signed-off-by: Tristian Celestin <tristiancelestin@fastmail.com>
---
 drivers/acpi/sleep.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 974e584..d0ddd4d 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -718,9 +718,6 @@ static int acpi_suspend_begin_old(suspend_state_t pm_state)
 #define ACPI_LPS0_ENTRY		5
 #define ACPI_LPS0_EXIT		6
 
-#define ACPI_LPS0_SCREEN_MASK	((1 << ACPI_LPS0_SCREEN_OFF) | (1 << ACPI_LPS0_SCREEN_ON))
-#define ACPI_LPS0_PLATFORM_MASK	((1 << ACPI_LPS0_ENTRY) | (1 << ACPI_LPS0_EXIT))
-
 static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
 static char lps0_dsm_func_mask;
@@ -924,17 +921,14 @@ static int lps0_device_attach(struct acpi_device *adev,
 	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
 		char bitmask = *(char *)out_obj->buffer.pointer;
 
-		if ((bitmask & ACPI_LPS0_PLATFORM_MASK) == ACPI_LPS0_PLATFORM_MASK ||
-		    (bitmask & ACPI_LPS0_SCREEN_MASK) == ACPI_LPS0_SCREEN_MASK) {
-			lps0_dsm_func_mask = bitmask;
-			lps0_device_handle = adev->handle;
-			/*
-			 * Use suspend-to-idle by default if the default
-			 * suspend mode was not set from the command line.
-			 */
-			if (mem_sleep_default > PM_SUSPEND_MEM)
-				mem_sleep_current = PM_SUSPEND_TO_IDLE;
-		}
+		lps0_dsm_func_mask = bitmask;
+		lps0_device_handle = adev->handle;
+		/*
+		 * Use suspend-to-idle by default if the default
+		 * suspend mode was not set from the command line.
+		 */
+		if (mem_sleep_default > PM_SUSPEND_MEM)
+			mem_sleep_current = PM_SUSPEND_TO_IDLE;
 
 		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
 				  bitmask);
-- 
1.8.3.1

