Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5057ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1FD214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2Cq18Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1FD214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeIQSGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:06:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37672 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeIQSGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:06:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so7616968pgo.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z9jfznvLP5877DEI41TRSfMsn09yyhsnmohRBnfuYU4=;
        b=P2Cq18FaDrCuhBaj4NZMgDYN6x/rmMi7IQUYPXJ7LqzV/c0TcdqPLBSWN8YeLWpn/B
         Wllw1akklE1pmDmwdaChbKQor0kWyVmPV6Mp31kIr9Osi++JE1+cc2JGQJmoXVzwD1o8
         4r98N1sG4/wInqygzknm6cKVOjHnuNHYiDDYI+x7FIatL8Xkx+QsE2qMaXR0Z7xrdzJr
         H+IMS7h2aeXvsg2BYc2qIt8TQ4tFmmEEy5feK/PvLIOrDMEkzTPW4B34QFnSJwHd/AK/
         yDuopw+m0bWpSgCCgF4cYvVdT2q3BfjZSLiczWPqPj6pE5d1MKnK3BoYSe6k+oIumD5Q
         aY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9jfznvLP5877DEI41TRSfMsn09yyhsnmohRBnfuYU4=;
        b=CIwc15N2KV3t86EFWtIvwdagb1ifjzZV06Pz0itI+pI3h1njjXGoG5j0/xCj0TRB2O
         UUbY24ONwDPNppnzrJdE6XrBSgYcK6fGU4D1IH/7V+lUql1oCZE9M/cu4xXZy1XGikOv
         PtjmgtJ7jTNjtMWlKRziZnCccwjre22zFxI3ju2siBa4iStlPsAfgkPuf7t6xypDJgpK
         TQCGnLkBXLfN+p1BCAPv2jq7m+ZXEeEVz8qfJn/PVedNbHNHpeDJrkbNLVfHUYgXfA2O
         Cmm923K2V2+OC1yz8BVjTaQIoXC0jtJeeW5G6BhsPQxZTUCB1zgDg9DEBDN2NtqjWmOV
         2Wgw==
X-Gm-Message-State: APzg51DIbPphLui5xYKwdVzamKuXZJ11Ifp8QASURcMrYFxck0YU+fPT
        Y4hEm+xYR77Tn9JQ0HOsBPk=
X-Google-Smtp-Source: ANB0VdZ1h0xwHMo32i3o8N9xyYHt7d52TLjHwJSzoJnN/4+8tA91vnT6ejvK+vYsKpgliH8XHZsidA==
X-Received: by 2002:a63:586:: with SMTP id 128-v6mr23433637pgf.169.1537187984849;
        Mon, 17 Sep 2018 05:39:44 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:44 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/10] staging: gasket: Kconfig: describe Apex as an Edge TPU device
Date:   Mon, 17 Sep 2018 05:38:56 -0700
Message-Id: <20180917123905.213639-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917123905.213639-1-toddpoynor@gmail.com>
References: <20180917123905.213639-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add a brief description and URL for more information on the Apex device,
an Edge TPU (Tensorflow Processing Unit) machine learning accelerator.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
index 970e299046c37..e82b85541f7ef 100644
--- a/drivers/staging/gasket/Kconfig
+++ b/drivers/staging/gasket/Kconfig
@@ -14,8 +14,9 @@ config STAGING_APEX_DRIVER
 	tristate "Apex Driver"
 	depends on STAGING_GASKET_FRAMEWORK
 	help
-	  This driver supports the Apex device.  Say Y if you want to
-	  include this driver in the kernel.
+	  This driver supports the Apex Edge TPU device.  See
+	  https://cloud.google.com/edge-tpu/ for more information.
+	  Say Y if you want to include this driver in the kernel.
 
 	  To compile this driver as a module, choose M here.  The module
 	  will be called "apex".
-- 
2.19.0.397.gdd90340f6a-goog

