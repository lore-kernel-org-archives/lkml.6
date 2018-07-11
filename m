Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F47C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4697520CA9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l///wr9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4697520CA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbeGKT2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43962 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390199AbeGKT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id u11-v6so20004533eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zFnY/CHU9+J0A+1VHugOhtsNwWYubSIr94scRW1ezB4=;
        b=l///wr9oiCM77WesOw0uttU6MHq//CbuNih1Ghq2yU7Xv0cG5QcHegVPIdJU56BP1t
         gAtZnkoH/caPTzZoYhJ4LZL5TMoXYQIEmdbcYtnL2k8hJy8GDFsJZ2OcrgL1D4dn0MWF
         05cnF8BEPpKBNqC94ETlDf2Rk8uYZ2Dw7kspSUGKFJtUFZVw4QhGRoMR6Pb2G6yw7VU8
         BpL6s/p26L43frYRmlOk16cAehrmCj35HIUQyt/WSJ33muCNMeVvSnjP/I4VCNOBC/1q
         p/8CAKvV/B1f6h0waAvEsrtuLlc6gyjKbcmfOTA/G8ZOUlbMD3NpFl3aL/DrF2PMUCa6
         qoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zFnY/CHU9+J0A+1VHugOhtsNwWYubSIr94scRW1ezB4=;
        b=ZTUyh9Q3psafql786UmNBcmpIMU/NnDONIttWUKR+22+59IC/uZN5p/5Q01/vaP+wl
         UFt2pAAoRLqwfQLT1jrBBe7BbkNqZo5/Zj3ki7E4WK/fdAuH8YOIvXhfg+KRrCYlAd3b
         R96FaPdVtv2NhfJPOvqL+9M/P2pJn8Dm3nRHi1JDG43WbjDWvjSnXiOCSS/rfADHqCjp
         GRzCb8jhGX2JWC6g7nYf5ZE5BG6R2XNu+ehSc9C24yII1t9RKwmfy/f9hIyz2A3yKveA
         NYM6ImHh9tSsWqzWAYMjv7xo0JMJFff5DwzAfaxpTd7IS3bht7OLDX0FMAoKXa9aLKdj
         22fQ==
X-Gm-Message-State: APt69E0RwJmQxraxvGCeWxf6jA3HprokQO9slU7L0/qzreN8Rk2VBc/H
        65zuEeeL8MKdWpb6wE/5Mxx+V3v3
X-Google-Smtp-Source: AAOMgpc1Z5OHhiR9ltp09y7j5O25ZydCUGdPVl+X+7SbEdThAEoM+y79uonWyXtWd74nrJ5aUaNsaw==
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr32358010ede.213.1531336955050;
        Wed, 11 Jul 2018 12:22:35 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:34 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/10] staging:rtl8192u: Remove struct rx_desc_819x_usb_aggr_subframe
Date:   Wed, 11 Jul 2018 20:21:47 +0100
Message-Id: <20180711192149.21621-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of structure rx_desc_819x_usb_aggr_subframe from local header file,
which is not used outside the header file.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index d7f090c1bb44..c8a23a831d51 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -294,24 +294,6 @@ struct rx_desc_819x_usb {
 	u32                 Reserved2;
 };
 
-#ifdef USB_RX_AGGREGATION_SUPPORT
-typedef struct _rx_desc_819x_usb_aggr_subframe {
-	/* DOWRD 0 */
-	u16			Length:14;
-	u16			CRC32:1;
-	u16			ICV:1;
-	u8			Offset;
-	u8			RxDrvInfoSize;
-	/* DOWRD 1 */
-	u8			Shift:2;
-	u8			PHYStatus:1;
-	u8			SWDec:1;
-	u8			Reserved1:4;
-	u8			Reserved2;
-	u16			Reserved3;
-} rx_desc_819x_usb_aggr_subframe, *prx_desc_819x_usb_aggr_subframe;
-#endif
-
 typedef struct rx_drvinfo_819x_usb {
 	/* DWORD 0 */
 	u16                 Reserved1:12;
-- 
2.18.0

