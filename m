Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D31C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A920863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Gim6DL1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1A920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeK3Ryz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:54:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34360 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3Ryz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:54:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so2320088pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=G1/NvKYWaeZu0h9wMdNm03wH2eQ+T8ZxVLtW8EssGt4=;
        b=Gim6DL1Isbmyz5t6h8Q4iGA7/hVPjUdJtASvQDtxtaSbydO+FN44atEs0Xs0qN6Vok
         CgS+KzcP5QcpTlmD+0zxAywJSu/wSjCZVHELqSuFsuOljZTNxrId+51e6Jve9vtsFfy/
         z5u5K+I/OAO6nloONnMn5PCDMPwE7kQZOzIirMLEF/nATORP+0iJYZnQy6wtQQsDmcNT
         cdQe9LXIEBNaGcVx+swYj0mn+wzVKRH27712QMYT/Q4167PvQdmFKBAB6kNg1GGPEez3
         S3bGxbSB3uWNZmgnfC0O0GjOz4a3t9GnUxxhunPWrt6zhHczDZiA5R3fYYOMFGSx2jX+
         GTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G1/NvKYWaeZu0h9wMdNm03wH2eQ+T8ZxVLtW8EssGt4=;
        b=bjMGgfZYxCKZoNQJaKBwDD7KNKCMiuCOYxbtujT2Qqi1GKul5WYAa0OL9AKiPBTOLd
         1+vgUWqOAOntvbCKKON7E3m5Qpux9zGKmLBYr7eg9b0rw3wtkh6esyrPuXqTrf6OTXGp
         u9WZUDNzIVwXWbWoTB3IoDNKRpfV0x7H1FEkzWTAs6g1pXyANs1i3ciw8zydOvhndbK0
         ZA0t4+6Mdue0ivsan3Kw2vhkZHK2/iYLrpl6KJRKSSPRDq54t2+JYazfyFz8tLeKo9Bn
         ab5lKYgyu+nwUMNyxlGkHDPswtT3FVdGcLNfkcrA+R+b4Feyd7T+3Gp8yrmImnsrCCQo
         anrQ==
X-Gm-Message-State: AA+aEWZ0BcBGY610NwHP8d6WtCXbCafIZFZEckk7xuklNbcBoeUQFgCd
        1QCcRx4q2chpXDvq93jFXlpeyQ==
X-Google-Smtp-Source: AFSGD/WP9gM0w31XtDMzKNHyqV0u2U/l8J9Zyy3t/KXWkV45tX+zYpRcQvT2EXbGidfjG44t9S5TOg==
X-Received: by 2002:a63:4566:: with SMTP id u38mr3860937pgk.4.1543560398953;
        Thu, 29 Nov 2018 22:46:38 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id c65sm9937251pfa.90.2018.11.29.22.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 22:46:38 -0800 (PST)
From:   Chris Chiu <chiu@endlessm.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] HID: input: support Microsoft wireless radio control hotkey
Date:   Fri, 30 Nov 2018 14:46:17 +0800
Message-Id: <20181130064617.67920-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS laptops start to support the airplane mode radio management
to replace the original machanism of airplane mode toggle hotkey.
On the ASUS P5440FF, it presents as a HID device connecting via
I2C, name i2c-AMPD0001. When pressing hotkey, the Embedded Controller
send hid report up via I2C and switch the airplane mode indicator
LED based on the status.

However, it's not working because it fails to be identified as a
hidinput device. It fails in hidinput_connect() due to the macro
IS_INPUT_APPLICATION doesn't identify HID_GD_WIRELESS_RADIO_CTLS
as a legit application code.

It's easy to add the HID I2C vendor and product id to the quirk
list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
can be more generic to support such kind of application on PC.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 include/linux/hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index d44a78362942..f4805f605fed 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -836,7 +836,7 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
 
 /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
 /* We ignore a few input applications that are not widely used */
-#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
+#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || || (a == 0x0001000c) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
 
 /* HID core API */
 
-- 
2.11.0

