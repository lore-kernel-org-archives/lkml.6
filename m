Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5556020C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teqNnHIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5556020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbeGQCkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45513 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbeGQCkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so15801788pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IYfvjfdX/zKsaH8sw7r+VxHkaI76EoX+lo/79eYCabE=;
        b=teqNnHIY/42dt1qkDImcegiy1zUuHtF5A+roctv7KK9T1F0/+7mY0TEb0OKTpPiY0r
         Xyp2yX3q5vTXHjJxtgkX63OVXrstXz/WYnZu20PlX0hoP0KeInCrS6DBMNnCNO1pRm5/
         O/HUmqszq+jL6mDpkf0K+cfg2AXc/lwfxTQOav9z79PgymMeCFhK3tQmQJPAONxclufm
         awNLlIpvBn95PXGmPYUfauPNnQB3VxVVtt0V1lHHgTlusgVKdcdehQNV7oPEKhHY8hyj
         RcRhrD+seuL1v+Yj3hk1e12Zlh4RwCOxlfGZF2zJMIS4xSIADVX5ZuMBEf1pihrU3alp
         rcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IYfvjfdX/zKsaH8sw7r+VxHkaI76EoX+lo/79eYCabE=;
        b=Dnlwdnb8RnW3EqaxpvztYHob0meVA3GEOA3hHX/2T558WZwdZRnVjb2W6LPiYXlHI+
         CJYk0+cOJBBV6w20MP8V8C7JyiGmbGAn7iVnecDAd7MWVCGvGc/c4mwyi6BVCsJGRlnu
         4zXNMIpEEGzz477FcZJ6B3zqLUl7zRD3O9TsJsjcLBuUJvT5STzkmP6uxdTFZLUsj+cG
         7ePvYuOb31mRV2N/3diFOcEJihhXg5PJKYK2Bad0fq7c0+d6HILCm6zhGwOY1x1ixL/d
         nRIQWLt1V11NvI8dCw422U/Dx6iZDdYJ0KBy4/QtsnlvkHC/EiCjByyCnbuBs66c0fvB
         ehLw==
X-Gm-Message-State: AOUpUlE/lHW7jqUCf9bzMOZIXoYBFabMDGG5MTXyRHyWBylheIPhua8t
        cwSvbRV9n7snGZeB6jugg60=
X-Google-Smtp-Source: AAOMgpdQ8WS91+zj8f7j2eZZeKKsS6aPUl9cDYK5CRxcWLpfuAt4ll/6LI461Lqhhhg7F+j676nnpA==
X-Received: by 2002:a63:3c4a:: with SMTP id i10-v6mr17512472pgn.415.1531793404687;
        Mon, 16 Jul 2018 19:10:04 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:04 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 14/32] staging: gasket: bail out of reset sequence on device callback error
Date:   Mon, 16 Jul 2018 19:09:08 -0700
Message-Id: <20180717020926.176408-15-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

If device reset callback returns an error, error out at the gasket
level.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index a7f696d8e1026..4808bac93f983 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1875,9 +1875,11 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
-	if (ret)
+	if (ret) {
 		gasket_log_error(
 			gasket_dev, "Device reset cb returned %d.", ret);
+		return ret;
+	}
 
 	/* Reinitialize the page tables and interrupt framework. */
 	for (i = 0; i < driver_desc->num_page_tables; ++i)
-- 
2.18.0.203.gfac676dfb9-goog

