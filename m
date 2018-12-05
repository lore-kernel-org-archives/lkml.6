Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D9C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C0020892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iWwODtGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C0020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeLEXwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:52:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39592 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbeLEXwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:52:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so12196620wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=al5p6J+IXq07JJbJ8z3BhRpw1vY72Jm+LA+y8PImFhY=;
        b=iWwODtGL+p5+HjcFOD9WW5VmwWfFYIMYB5jTpIMby8Eoa7ES5fP6D+o6Bu+0yYt9tZ
         qLdkVQqSCbtDTsdjNW8KEv9abXO7grTu9z7qgSbX3n22OYHQ7CnOZh+HQp1vevlKIBgw
         Ai0fOtx9QKTq8YKoth5ORCAaQUzFZlsKwrJKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=al5p6J+IXq07JJbJ8z3BhRpw1vY72Jm+LA+y8PImFhY=;
        b=ZTx1KXyjRAoSNOjFQHtY6V+DMqJzxBCJkJiIjL0kw4MhXlCdWP8tgZj4FHjBAFv0ZC
         I4YnExs6vRfyEx9Wu6Wr+CNiY7ttD26yjh1Vdjb6DgPpCkJHcuZ2ErAhhEhelKhrqRTi
         uIDRCU+zMNN/+cFNDJ+gjkdChrOGcUa0YZr6y+rK5rHzSPTRJ/+IV001cXEgltFERmmt
         L5/0d3mvNQTHO1wr308A0BEX9uL+yzJkf5wvEDJ90yYZk1nHbgTN/ueGbsZnPT3qEkYU
         DzTCuY88mrNN5BrEPyfzQqNvkcoKSF2oOaihc/jr6ne1HGd5KdGKU2i17sZMhCAMehOZ
         jGRg==
X-Gm-Message-State: AA+aEWYribH81uIcMfgrJsfTWjG7USUGtX7QjiidtI0NQ3Gqe6bdHGLq
        KsCHdFJ/3enOeL03IMEyDE+mTQ==
X-Google-Smtp-Source: AFSGD/WUtGTyXChQB4SSF3UhZTr4VvBJV5a8ZH5dzmD+Sxl8FGfrmT8vSxlL+DviCLcyzbzS2grvwQ==
X-Received: by 2002:a1c:b94b:: with SMTP id j72mr17615353wmf.11.1544053954594;
        Wed, 05 Dec 2018 15:52:34 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com. [213.198.161.243])
        by smtp.gmail.com with ESMTPSA id x15sm19113324wrs.27.2018.12.05.15.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:52:33 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 4/4] Input: goodix - Add GT5663 CTP support
Date:   Thu,  6 Dec 2018 05:22:20 +0530
Message-Id: <20181205235220.3461-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181205235220.3461-1-jagan@amarulasolutions.com>
References: <20181205235220.3461-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures.

Add support for it by adding compatible and supported chip data.

The chip data on GT5663 is similar to GT1151, like
- config data register has 0x8050 address
- config data register max len is 240
- config data checksum has 16-bit

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- add chipdata

 drivers/input/touchscreen/goodix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 7371f6946098..735ab8e246b6 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -218,6 +218,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5663:
 		return &gt1x_chip_data;
 
 	case 911:
@@ -965,6 +966,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.18.0.321.gffc6fa0e3

