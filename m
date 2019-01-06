Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E557EC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 18:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD75D2070D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 18:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="m58dfHPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfAFSRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 13:17:40 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:48130 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAFSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 13:17:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id BE21763A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 18:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yWHJje8kiXiT for <linux-kernel@vger.kernel.org>;
        Sun,  6 Jan 2019 12:17:37 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 9B0BE437
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 12:17:37 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id q16so22607394ios.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=R4rdnJmUl7RHx0SUd74LFc3h8YHD/OwyUQsNl0U59eI=;
        b=m58dfHPBEHibEnIk883CfTTIU0EF8Utsce+m3W65sQvpHtFCScIx9emI1bMaiG/bXS
         B34aWt6ngEkC2GInpgQb8yzWaozacAFxhOy5NhUS4D8ZN2ulV7s9PkBu+3ctHv1ed67J
         wF+p7wEMQ/tnVmrqw4eZCsIepstnNsBnlTOypoguicwoZX+4ZzPq3YPYhm5Cp4KFN5vt
         O1oUpLVGdcD+rTEU4F7E3Y3uMseXI5VtJs3ijJKWBkdQGfxc2ZqzOM8z/1N3SDDqTs6t
         yf5SoVtmGbDOC8IYWCVwW2yXlt5fm7OCzIXB7F2Jt7L94cDuimcSrgTIOL+eI2ADPFk5
         THQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R4rdnJmUl7RHx0SUd74LFc3h8YHD/OwyUQsNl0U59eI=;
        b=UPj/YaJoTduB2fHF+36HnZdnbhrjmg+BCTCyFDIlJ7xknD8OXPD9ljAvWq0d01p0sR
         JRRkwB714vktpMt5jg+80IFCLuLR/1nVJwnlrctJsfrdhoyYbrPfHa58b6hfYF4PO+P2
         I+wspRGlVrqg2Yn/wtCKyLiZQIosH0uqavHOdSYrZ/8j15lY0pyUu9YI0DsNeIOwjvRk
         XSAzfDVHG9lHcqH4vzwGddMVWJ/6MDj6XzkV5gQAlSey9vc1l5fmnluIuhhjrzG+24tB
         m1ZNzb3eQgg51R7wE94dM6+p79pIuAIX3lzi1DUkMP925EjCgjpla22td3s4P8OmSorc
         GfAw==
X-Gm-Message-State: AJcUuke7KT0kmXdrSxK8Pp3smjRY5jbhqAb/AoqC/rV6j7RSxTfrFaS5
        sDltywdq0cMWbMMu8i5AVUXwl0v5pHYZHiW1mBjakLP/Mb5M6G5LZkzL2FE112aodCKVWeBgM2A
        N5IiuhE3bwVYIeSqMLM4p2g7Wwa7h
X-Received: by 2002:a24:7a94:: with SMTP id a142mr4486761itc.88.1546798657209;
        Sun, 06 Jan 2019 10:17:37 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6rivm7cD2r6oyKrhC0cf6ZTjJ49PdGTA0B0ZoRD4UZQDvgzNhc3n7MJSSN7xKShvlAOCODIQ==
X-Received: by 2002:a24:7a94:: with SMTP id a142mr4486756itc.88.1546798656979;
        Sun, 06 Jan 2019 10:17:36 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id y5sm3451972itb.42.2019.01.06.10.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 10:17:36 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Michael Hennerich <michael.hennerich@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] Input: touchscreen: Fix a missing check on regmap_bulk_read
Date:   Sun,  6 Jan 2019 12:17:27 -0600
Message-Id: <20190106181727.11815-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_bulk_read() can return a non zero value on failure. The fix
checks if the function call succeeded before calling mod_timer. The
issue was identified by a static analysis tool.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/input/touchscreen/ad7879.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 6fa714c587b4..8c908572c1f2 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -246,11 +246,14 @@ static void ad7879_timer(struct timer_list *t)
 static irqreturn_t ad7879_irq(int irq, void *handle)
 {
 	struct ad7879 *ts = handle;
+	int error;
 
-	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
-			 ts->conversion_data, AD7879_NR_SENSE);
-
-	if (!ad7879_report(ts))
+	error = regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
+					ts->conversion_data, AD7879_NR_SENSE);
+	if (error)
+		dev_err_ratelimited(ts->dev, "failed to read %#02x: %d\n",
+					AD7879_REG_XPLUS, error);
+	else if (!ad7879_report(ts))
 		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 
 	return IRQ_HANDLED;
-- 
2.17.1

