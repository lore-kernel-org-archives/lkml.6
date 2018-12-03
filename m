Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FD0C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8791220834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="f+83RxbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8791220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbeLCGqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:46:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34689 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbeLCGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:46:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so5958992plz.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 22:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DMiwCO/LzfHiirOee4XUq+AAox1MmJBmWKL+nCVtjmI=;
        b=f+83RxbM0ThG0q7TaJrDNwESeRo6qO8ridfKR4zUTCNQCUGzAjelvOdunwO0nhJf3S
         DI7UkAd/A77gYjZXkbRE0kKvKi6O5pxSBexuA/fCJKnjv/DKgnd/QE6k6aVRWQkrrBlt
         snbX7zR5BJFL3m4BjiKKL9aB1wG4eulk8oYwK8ua3/z2QYFuBPjbfXbzKahOBNPYkMNC
         DkSWMwbUJ5L3mpXlX1zcry2ZgQuxw1lHs8/W32I+J44XMcVLQr5QRmIcKDMK1Uvg/AHO
         pfROP0csoZLJok/a5o3jlMPtLxTb5esGbcCZV7RNMiEz2UWG+/m9l6oa0e/xvkB/1PL1
         zMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DMiwCO/LzfHiirOee4XUq+AAox1MmJBmWKL+nCVtjmI=;
        b=L70g7+y1utp8VvbrW0TMk4yassSOqHozzjFrlgoSRLSsNpY9VjuVWhQDnVJXBT6bt9
         BvOgwS0Osg+ixlQ143rqNB0UYqQsEYYGAYPC7FgUzRHa7/bKeFKanzolDv/aX4t4AmzN
         w8NldqFDLZf5IyKeNqC25VRvSssXP6kJbEPe3gO27amS/gLJzR0g/yW24LAxc/XO69sy
         b2YwFmBMyLUlPFfqCKzX/3AiLzE5RNQO+FAnXFCrsY4jNxSV1WLTi20n2qWnvR7QF9ks
         33oRK96aN3SHaapGvtZuQaMKzw/vxS5j83yOvQ7Og/JmsgzRMh9iIiz6WvZQzuD6fDse
         o7Hw==
X-Gm-Message-State: AA+aEWbfiwudMbuxrBtGDp6YV889Z1j0x1pYQTCCDe7P+uWAx475Pvu5
        OB7fsSs1m6QTC1ItMs31L5JvhA==
X-Google-Smtp-Source: AFSGD/UEX8a/EB8cPmIRLQEqIxE2U6RCYcPNM3VEsuiFyMV3eAp+wymk0GcIJ8seFydhEtJYx0UAaQ==
X-Received: by 2002:a17:902:4:: with SMTP id 4mr14873639pla.20.1543819589669;
        Sun, 02 Dec 2018 22:46:29 -0800 (PST)
Received: from localhost.localdomain (220-133-8-225.HINET-IP.hinet.net. [220.133.8.225])
        by smtp.gmail.com with ESMTPSA id v70sm22692874pfa.152.2018.12.02.22.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 22:46:28 -0800 (PST)
From:   Chris Chiu <chiu@endlessm.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: [PATCH 2/2] HID: input: support Microsoft wireless radio control hotkey
Date:   Mon,  3 Dec 2018 14:46:21 +0800
Message-Id: <20181203064621.69876-2-chiu@endlessm.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181203064621.69876-1-chiu@endlessm.com>
References: <20181203064621.69876-1-chiu@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS laptops start to support the airplane mode radio management
to replace the original mechanism of airplane mode toggle hotkey.
On the ASUS P5440FF, it presents as a HID device connecting via
I2C, named i2c-AMPD0001. When pressing it, the Embedded Controller
send hid report via I2C and switch the airplane mode indicator LED
based on the status.

However, it's not working because it fails to be identified as a
hidinput device. It fails in hidinput_connect() due to the macro
IS_INPUT_APPLICATION doesn't have HID_GD_WIRELESS_RADIO_CTLS as
a legit application code.

It's easy to add the HID I2C vendor and product id to the quirk
list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
makes more sense to support it as a generic input application.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 include/linux/hid.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index ce5f996c8d3d..42079116fb61 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -840,7 +840,8 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
 #define IS_INPUT_APPLICATION(a) \
 		(((a >= HID_UP_GENDESK) && (a <= HID_GD_MULTIAXIS)) \
 		|| ((a >= HID_DG_PEN) && (a <= HID_DG_WHITEBOARD)) \
-		|| (a == HID_GD_SYSTEM_CONTROL) || (a == HID_CP_CONSUMER_CONTROL))
+		|| (a == HID_GD_SYSTEM_CONTROL) || (a == HID_CP_CONSUMER_CONTROL) \
+		|| (a == HID_GD_WIRELESS_RADIO_CTLS))
 
 /* HID core API */
 
-- 
2.19.1

