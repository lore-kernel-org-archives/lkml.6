Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E16C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5559223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSNNEKcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5559223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeHJJr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:47:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50921 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeHJJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:47:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so804954wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 00:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xOXiqYEqP6UlZAJdXnjMY9VCMLzIFKoOEKYMMIJPKb8=;
        b=PSNNEKcELnCPmmKLkCCIOcWydM5USkftXtNeL3wOejXKRRTXjdI+KvTqALvfk3+0O+
         BVcGhmrkESZ+rowj0s8vJGPncPNqjEFsCu0BdxU1oW8ewNCkPJR3c1BqiphyKKidmHa8
         9CT1FcnShzew3s529nx07DLzIsLjtb7smSfcBqNERzTl8XXwejAxnY5PGQ3K+HoVc2nN
         nUg82A9AJx/GH5Pe1Xtto5LadLWRZbdkqHUSfFNgZePCE/HWPsKw/L6QTkxa6Pv9fEHY
         H8n17ylmMIMhJPzdLI0GIK65aTe1a8ftrtOycdQzAur66o+yOBtxeb0F+ep9TWkovwS3
         zmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xOXiqYEqP6UlZAJdXnjMY9VCMLzIFKoOEKYMMIJPKb8=;
        b=Hc5OUv5tT+fHsR5ZrScDR1QAG2hTQVCP1R3PCKHwFvQWr2sN3u0RHzgRx9o74spRhB
         /rkQLbAwW5mhkFIp8yRKxV//xExLKI0bBbzorcNuiVXZSLX0hTLBvnLDvWJqccu6uNzg
         qknu0irNEPj2wZVXOA6KCTIMsxjNu8w0H33iBqLe1OoAFHjmpn3gsscjoSeg60pS+AAo
         5M6VeaoTeJH5c4ur2dVoznDFh/fQxxwp4zWJ3gN/dgGeABXVn0BQsrdWBKf/5x+hZmBJ
         Yp47K2M9YYufTwICTcQvgMPq8M57cvL0LeIrbBHRcL988UjIHUA7KfXqbFKM/3et5DN4
         ztUA==
X-Gm-Message-State: AOUpUlFWeeYnQPJgcDw9IduYu+JkXqNIslB/5jMx5YldVgZhw/tgngs8
        0e9/Bwsz5N76BrFa5YGvPE4=
X-Google-Smtp-Source: AA+uWPwPHh3x15gwVNKUN86Hi4gI764UQnT9OrC1EaNyMtuUXk7SMOD3nJspbuUjr33CLguO64MaIg==
X-Received: by 2002:a1c:8e08:: with SMTP id q8-v6mr740823wmd.137.1533885529148;
        Fri, 10 Aug 2018 00:18:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id k4-v6sm13253875wrl.12.2018.08.10.00.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 00:18:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/5] staging: rtl8188eu: remove unused IS_MCAST
Date:   Fri, 10 Aug 2018 09:18:32 +0200
Message-Id: <20180810071833.1661-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810071833.1661-1-straube.linux@gmail.com>
References: <20180810071833.1661-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the now unused IS_MCAST.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 4a56e54e38f6..0a952edf8a81 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -257,14 +257,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-static inline int IS_MCAST(unsigned char *da)
-{
-	if ((*da) & 0x01)
-		return true;
-	else
-		return false;
-}
-
 static inline unsigned char *get_da(unsigned char *pframe)
 {
 	unsigned char	*da;
-- 
2.18.0

