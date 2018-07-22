Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93179ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4652320854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/TXDQo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4652320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbeGVXJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55864 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbeGVXJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so14079915wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pUv6TmW6KP1s54v6tgjNko29XgkzrxUNO80u6/2Npss=;
        b=o/TXDQo6RRrYmcrme8pbS+beMIIvz4E6Q8xz0PsaOZG4iJhVq7tmet9MJcK7Wdtt0v
         rr6fZht2mauzXT6fxcF2Ca0KpPxJtozcrNKSQNeWbURT2YM4V6BbjsJe3pjTHTao0QHf
         PbG8vGSbk6CbXrYNfJFMtkisjos07LQHm0YEZgUWkCn2vE/P+5lrfa2DDXRus+ZeWeE0
         yDYNYZqyqGezw7TbYWWTaSvJj/UyGCb/g9Mt+g+R82Wteam7z5J+MFYuqRxDYpakdmY9
         Q1GY7PhtxgyYJ6kppHAUHecD46s6OtKQE8xmIPlHweGx8ie8QckLUaUf2mOXBfxut669
         5XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pUv6TmW6KP1s54v6tgjNko29XgkzrxUNO80u6/2Npss=;
        b=UPfoEB2BJHL7kS0ZQgwbHIcbumctpj4NCTFAt1bbO2wE0yPehg6r8o3vdeRs9iZhEG
         f5IqF6wFyISNU/uhZGk/KRBrqlJFzOEKNMqzYRHFtjO0MEuGQ8/yI2eSSpzJXXss5xbh
         lQZrQsvZnnDqE6kQown1SWsEQs44fy0g4yqB8ueln6V/tiR4jsGConafVuMsP3NtoGOn
         VBeWbYI7JE26wgXkFECWR3lIHA7Ei29JcVPGBNoDGmA5bIp/6McxPGQr3I3pJQWdysqg
         LA9veuOA2kdmBjPrizB+aY4fj4xfY5Ugr5A4oHANGV/npBwQqixyrJ/V9TvjSUuGETuk
         k9HQ==
X-Gm-Message-State: AOUpUlF6r4mkQpTT51z1hO86taa0LcNLYBK6qvonqq0DQbkXmq2pofjF
        yIV0iEJZxpkJicsjxDIgNhwJl4nwoPk=
X-Google-Smtp-Source: AAOMgpdheNCodOJsw38Q5066YWubw8p5bOLMjVLRsInxVss+R2HAMaKb9i5i2t6/q7oQnBSJVm3THw==
X-Received: by 2002:a1c:f516:: with SMTP id t22-v6mr5833414wmh.103.1532297478573;
        Sun, 22 Jul 2018 15:11:18 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:17 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 19/20] staging:rtl8192u: Remove unused Zebra4 bit mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:34 +0100
Message-Id: <20180722221035.14453-20-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'Zebra4' bit mask definitions. These definitions fail
the checkpatch CamelCase naming tests. Rather then renaming, as the
definitions are unused they have simply been removed.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 09eade1f4dbe..708dae62c644 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -131,12 +131,6 @@
  */
 #define bZebra1_ChannelNum        0xf80
 
-/* Zebra4 */
-#define bRTL8256RegModeCtrl1      0x100
-#define bRTL8256RegModeCtrl0      0x40
-#define bRTL8256_TxLPFBW          0x18
-#define bRTL8256_RxLPFBW          0x600
-
 /* RTL8258 */
 #define bRTL8258_TxLPFBW          0xc
 #define bRTL8258_RxLPFBW          0xc00
-- 
2.18.0

