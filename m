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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ABD21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZGH83Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ABD21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeIZLu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:50:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51719 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeIZLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:50:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so817642wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQIZYNJXLSb6yJ7TVvMH0cF1nkFkq4p4oj+e1LECGjI=;
        b=aZGH83SllVkg30wAvsDCB7rpYucEbdBYEu2XdbrTs6O3ijBwISEai5fyjlM6Kuybz5
         /XnygQTQMxejIMhrLzi87uVoG653VeARC4/a6d9OQFjAZfJQ8PkOohr6NsBsOdYo1WSL
         WSQV81NXI7vfqxGmQvXG7rFG2595wUHDOfHt/MPMzOmcmXY44at1jLiymyDQz0g4GfpR
         ADJMnrWs6lEXgLzGyPtMN5DhFa7dRhfECpTICXkU+7Cx8Xl/7CtBV1YX12UR+hCpgOzJ
         oNWcOwX26TOhaY0HPnQassz9YYJZf5Htbvxhkn7Mrc64xl+mvnh7Andks2LyNAD6ns+R
         9NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQIZYNJXLSb6yJ7TVvMH0cF1nkFkq4p4oj+e1LECGjI=;
        b=MACeAuUdX4r1kKYLsol+uvk08E9PIDxj8uBepyz8837aYkqRpg1b8nMBwYRyQC8q9j
         EUFbrtqvMdLHj9k977rMA/fAs0zy0lk3C/DaX3GHs8lH3j9Kfi+zFxmNVn6VRFbaZSWL
         PYiiza7xwiXoX+V7UQc6kmoA7oBl1dIp2N3AaPvkAie8/+bNCWUsfkYTnnqS8UgDqOfm
         GdKoTbuCEoaaHJVpuo8tGr3XU+1mpWKESRkdwb1sDnmtWIvKKTLNS0JEP54v2bTksWyp
         v5Pzgcf4kyDuZ+guKhOOadjbiW6bQYY8hR/k+dga0uuTlIN4uWzDv28F1Es0vpAbIv0x
         Iurw==
X-Gm-Message-State: ABuFfohj2gn1UPLeD7H3WDiZav34T5UWcReS1CydOXeDUt0TBfuYcOgA
        9gRsrK86VhKiBhIIBYh07VM=
X-Google-Smtp-Source: ACcGV61qmKZWRQsDpEJMb2/6P56FE1+iyqovoH4V8xvBgTCw+Wml0CKGrBJ33FWigvfFiqUWm65pHA==
X-Received: by 2002:a1c:a386:: with SMTP id m128-v6mr2826593wme.139.1537940356192;
        Tue, 25 Sep 2018 22:39:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r30-v6sm7175016wrc.90.2018.09.25.22.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 22:39:15 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Remove ACPI table declaration
Date:   Tue, 25 Sep 2018 22:39:10 -0700
Message-Id: <20180926053910.26833-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the acpi_id declaration is not going to be emitted
in the final assembly:

drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
'acpi_ids' is not needed and will not be emitted
[-Wunneeded-internal-declaration]
static const struct acpi_device_id acpi_ids[] = {
                                   ^
1 warning generated.

This is because it's marked as static const and it is not used anywhere
in this file. Doing a git grep on this driver for 'acpi' shows that this
declaration has been unused since the driver's initial induction. Remove
it since it's not doing anything.

Link: https://github.com/ClangBuiltLinux/linux/issues/169
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 6d02904de63f..d473f9bd08c3 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -22,13 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
 	{ SDIO_DEVICE(0x024c, 0xb723), },
 	{ /* end: all zeroes */				},
 };
-static const struct acpi_device_id acpi_ids[] = {
-	{"OBDA8723", 0x0000},
-	{}
-};
-
 MODULE_DEVICE_TABLE(sdio, sdio_ids);
-MODULE_DEVICE_TABLE(acpi, acpi_ids);
 
 static int rtw_drv_init(struct sdio_func *func, const struct sdio_device_id *id);
 static void rtw_dev_remove(struct sdio_func *func);
-- 
2.19.0

