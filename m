Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2145C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80388208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4XJSYp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80388208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbeFRMep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:34:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37982 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754145AbeFRMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:34:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so16670764wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 05:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ouib5iDvZtx/AeucgNZuIHtV+L4Pi3sGZRLvwgPVETs=;
        b=L4XJSYp1lzOzdR2UEtHKLGprpu+j8aER+Pr1zcMqHKumFDQ/F+1PidaxzUsu76wSoA
         203HKhXAq6Mll1s/sZdQAZ8/Vddsn0iLnk4Ese+kd9NtIvt88E7/efCpwHmmRyx4tFsJ
         9GeEywrUcw21sT8ks8j8FOYtoQsTQPmeABIYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ouib5iDvZtx/AeucgNZuIHtV+L4Pi3sGZRLvwgPVETs=;
        b=IDIxMNguxlk/CV1nFhqDmBFyxn6WCHH05eUNMCcZuqzSL4+1kFZ8lrzew9A6FYoy0W
         9661BhLhbtJIVMEEMIRsx7Uuv8292GAJ9K9mRbQOM/ZTaluf46KhKZAFVWBe/PyP9Iio
         +R0pAa3SrDVqmB9HpC+BdNaNSiGIeb4xR/rO5Nb3sr3x7idi2dm6KWxYkxk+hSzLR8PG
         uQ/VyEZPYk2+MzGjA4jSsr8czfODBXuZZw8tR29a/QkKfqPqt2kg/N8v5CJ6tOzyS6KS
         l8UDr6PdmcQgASwSpwbkXECD1Le3OlUVOhNpFIr7RJBV9Z2iXdyhlHk4D8GYYabMmGTx
         QOjQ==
X-Gm-Message-State: APt69E1GqpHA9puUED2zWApHJt9+RPP1aR/fXcN55gOnYa2NTMRwQrzy
        02Xl41jtLxK3fbTnZCvxRwaIQQ==
X-Google-Smtp-Source: ADUXVKIZhakAVetzCFh9So6TPihvfwv5NPpfhueG9Br3PHthM95ycc6eyQM/Za7EXisao0wUj3RKCg==
X-Received: by 2002:adf:8837:: with SMTP id d52-v6mr9933110wrd.41.1529325245266;
        Mon, 18 Jun 2018 05:34:05 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r10-v6sm24291318wrm.66.2018.06.18.05.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 05:34:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] rpmsg: glink: correctly annotate intent members
Date:   Mon, 18 Jun 2018 13:33:37 +0100
Message-Id: <20180618123339.24115-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180618123339.24115-1-srinivas.kandagatla@linaro.org>
References: <20180618123339.24115-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As intent structure members are not correctly annotated, leading to below warnings

qcom_glink_native.c:614:16: warning: incorrect type in assignment (different base types)
qcom_glink_native.c:614:16:    expected unsigned short [unsigned] [usertype] id
qcom_glink_native.c:614:16:    got restricted __le16 [usertype] <noident>
qcom_glink_native.c:615:18: warning: incorrect type in assignment (different base types)
qcom_glink_native.c:615:18:    expected unsigned short [unsigned] [usertype] lcid
qcom_glink_native.c:615:18:    got restricted __le16 [usertype] <noident>
qcom_glink_native.c:616:19: warning: incorrect type in assignment (different base types)
qcom_glink_native.c:616:19:    expected unsigned int [unsigned] [usertype] count
qcom_glink_native.c:616:19:    got restricted __le32 [usertype] <noident>
qcom_glink_native.c:617:18: warning: incorrect type in assignment (different base types)
qcom_glink_native.c:617:18:    expected unsigned int [unsigned] [usertype] size
qcom_glink_native.c:617:18:    got restricted __le32 [usertype] <noident>
qcom_glink_native.c:618:18: warning: incorrect type in assignment (different base types)
qcom_glink_native.c:618:18:    expected unsigned int [unsigned] [usertype] liid
qcom_glink_native.c:618:18:    got restricted __le32 [usertype] <noident>

Fix this by correctly annotating them.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index f505f58b797d..e4eb5a1f417a 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -603,11 +603,11 @@ static int qcom_glink_advertise_intent(struct qcom_glink *glink,
 				       struct glink_core_rx_intent *intent)
 {
 	struct command {
-		u16 id;
-		u16 lcid;
-		u32 count;
-		u32 size;
-		u32 liid;
+		__le16 id;
+		__le16 lcid;
+		__le32 count;
+		__le32 size;
+		__le32 liid;
 	} __packed;
 	struct command cmd;
 
-- 
2.16.2

