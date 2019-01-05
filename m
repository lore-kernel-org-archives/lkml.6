Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911F6C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DB021915
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VIHeuBNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfAET64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:58:56 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:52064 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfAET64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:58:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 92387B6C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 19:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kfLrDW-5tK6B for <linux-kernel@vger.kernel.org>;
        Sat,  5 Jan 2019 13:58:54 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 5C9FA21B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 13:58:54 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id n124so3769960itb.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 11:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fxHY2b5Dry2iztEQxF5CiTxkfnRJixEDySXtasUbGpo=;
        b=VIHeuBNiLCCwJeljwnx6wmLotsIhA0cpe41WQ16s8OYeTCIfKANIh6nzI9kZh49XCB
         YXfoLEoKqQ8v11BTH3UYtdkS41Wn+XlsPbAtKkVhVyEFJ1uGAN/Bip0/RMOe3p4dzXhj
         vL+yii+/0sgg+YWefe4zpEmXWjf4tkXf/6z7hG5CZtnuiPQeQvc9LUwl3Q9KUSQ0jv5r
         jRTa5sppSj2Qy9dh33MR1VQep20VExcikYAdDE+tU9Nk4a/ydRA2Y/GInQbIZk6S3JMy
         qztIuwCwmReqJPHJ/wWAqRrMKgLDkKV5ABcheLSojjOXVUlrstCTp5YiWf+6fgxWSHa2
         q3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fxHY2b5Dry2iztEQxF5CiTxkfnRJixEDySXtasUbGpo=;
        b=DUKZeEJ6QAQswv8M2olyPr7rTmLKg9XkFs561gjBh4Kp+GcUNa6+iiZYLD1n0vzCEo
         0shvKHfavxjrHPWgbCry70N5d64zZFGgqb01O9mw3SLGZY30M6rZk0pQjMx6I5CIZaRu
         tpk2iiPqmB56uOUTElytSeDIUgkOdHrUeIVztU3D1SjpvqMTWE+ZDawPbrmrIUoSz/jj
         k9g1hLjvqFx9xEjVj3raseki1kWzoUX7dlQSGGAlNr+5Mj721tcbX/EADPDqQY/QqoEH
         VtrDYEoA3BXeuMfOHrb9p3dmNfWhYFtHu/+/4HtKymsEcLmlqZlJaOJHH3DCgMPB31oh
         hUFA==
X-Gm-Message-State: AJcUukdM0wq5csdCqviwKve4RFn1VxwGFA41tOmVpWZZT8pNKvbTq/xI
        6b2CafK4iNBsMFH3fMTzmx/Hi22WGVIK2MGIbcx6GvQhfAHphKGyurUSx+BU+ZB9nXLzie/DDIz
        LzdtWhFJzPERF2R0UnXRMrLYWMFQ1
X-Received: by 2002:a5d:898b:: with SMTP id m11mr10754976iol.181.1546718334008;
        Sat, 05 Jan 2019 11:58:54 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4aTEMnVgomFpdSrszsCMbfJgnXJ1IaKyvg5PnAW18OeXO0+0mRlY+bbvgsJAk1yhg6maRVvg==
X-Received: by 2002:a5d:898b:: with SMTP id m11mr10754971iol.181.1546718333795;
        Sat, 05 Jan 2019 11:58:53 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id y5sm2336758itb.42.2019.01.05.11.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 11:58:53 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] v2 pm: clk: fix a missing check of clk_prepare
Date:   Sat,  5 Jan 2019 13:58:45 -0600
Message-Id: <20190105195845.5453-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_prepare() could fail, so let's check its status, and if it fails,
issue an error message and change the clock_entry_status to
PCE_STATUS_ERROR

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/base/power/clock_ops.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 5a42ae4078c2..732764becafe 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -65,10 +65,15 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 	if (IS_ERR(ce->clk)) {
 		ce->status = PCE_STATUS_ERROR;
 	} else {
-		clk_prepare(ce->clk);
-		ce->status = PCE_STATUS_ACQUIRED;
-		dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
-			ce->clk, ce->con_id);
+		if (clk_prepare(ce->clk)) {
+			ce->status = PCE_STATUS_ERROR;
+			dev_err(dev, "clk_prepare failed\n");
+		} else {
+			ce->status = PCE_STATUS_ACQUIRED;
+			dev_dbg(dev,
+				"Clock %pC con_id %s managed by runtime PM.\n",
+				ce->clk, ce->con_id);
+		}
 	}
 }
 
-- 
2.17.1

