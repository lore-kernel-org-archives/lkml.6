Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114A2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE229208F7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxVe4yiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE229208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeHOXXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:23:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35210 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeHOXXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:23:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so1939654ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TWNhjrmgLpSO5MJV73m5bOu5n1H+413r7T8xRTQZNdA=;
        b=HxVe4yiXT/cVV+jcYufkzUnRhINVIclBJ6+TZeyxYDn+E9lClIiJ94c7K32GTtBoMH
         MoqnRk9OE3GoxDL2nMCoApEWWe0BJrRJF8BJ6eTap96qrGtQuxC4hGNnASIJUC8KDGgm
         rB7r4/AD9a+q91ipw30ZUKyBV3I1iW/PpmepI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TWNhjrmgLpSO5MJV73m5bOu5n1H+413r7T8xRTQZNdA=;
        b=o4M/A0ygYMxvJtdH956mWF6sX2eG0iL2FLoCihSuwETLvc38HZcIbrofRcZcdt5yt9
         hsZ8LtRxbCmmsELwiERy8ITHCVUWkx2jBHUWztC+NPApBt8DxvsCdX+6VGcsM8iNshNv
         kuEuV6Yup46DKUCTRW4v9tiflg9TaOMYxN+u5S7JUx7xDMEMJwmjQtRMsOk0LGkes+R0
         U+B6elb2afE76CXn3Su2vUW7zwrpHu4KnogQ3RjJQYhdJl3NyOeMe7t3c+DkWxDTQ/ym
         VWNLaI2zSOkrevqCgl+h/UEo9E9CEh8V3l1mJhvGMgwznbTyDhEXia9B118QosdWuvv8
         hqSA==
X-Gm-Message-State: AOUpUlEnaseJ2b2Cj2lJNL4K84Xb5Jq/yHm56VQmQRuzFN9k7OtPR9ww
        0pKu1jKjN+45DCV3gciXFdyPWVeNGaA=
X-Google-Smtp-Source: AA+uWPyRKpiccg6z9nNCverE8fzsWvrRsw9Y4gMmHbbk0N+67mNfjJSfK4ERdsrOl7ECr3dG+bxcAQ==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr9111405lja.149.1534364996620;
        Wed, 15 Aug 2018 13:29:56 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id w2-v6sm4139026lje.73.2018.08.15.13.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:29:55 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     corbet@lwn.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] Documentation: networking: ti-cpsw: correct cbs parameters for Eth1 100Mb
Date:   Wed, 15 Aug 2018 23:29:53 +0300
Message-Id: <20180815202953.10137-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set cbs parameters calculated for 1000Mb, but use on 100Mb port
w/o h/w offload (for cpsw offload it doesn't matter), it works
incorrectly. According to the example and testing board, second port
is 100Mb interface. Correct them on recalculated for 100Mb interface.
It allows to use the same command for CBS software implementation for
board in example.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net-next/master

 Documentation/networking/ti-cpsw.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ti-cpsw.txt b/Documentation/networking/ti-cpsw.txt
index 67039205bd69..d4d4c0751a09 100644
--- a/Documentation/networking/ti-cpsw.txt
+++ b/Documentation/networking/ti-cpsw.txt
@@ -469,17 +469,18 @@ $ tc -g class show dev eth1
 
 14)
 // Set rate for class A - 31 Mbit (tc0, txq2) using CBS Qdisc for Eth1
-// here only idle slope is important, others ignored
+// here only idle slope is important, others ignored, but calculated
+// for interface speed - 100Mb for eth1 port.
 // Set it +1 Mb for reserve (important!)
-$ tc qdisc add dev eth1 parent 100:3 cbs locredit -1453 \
-hicredit 47 sendslope -969000 idleslope 31000 offload 1
+$ tc qdisc add dev eth1 parent 100:3 cbs locredit -1035 \
+hicredit 465 sendslope -69000 idleslope 31000 offload 1
 net eth1: set FIFO3 bw = 31
 
 15)
 // Set rate for class B - 11 Mbit (tc1, txq3) using CBS Qdisc for Eth1
 // Set it +1 Mb for reserve (important!)
-$ tc qdisc add dev eth1 parent 100:4 cbs locredit -1483 \
-hicredit 34 sendslope -989000 idleslope 11000 offload 1
+$ tc qdisc add dev eth1 parent 100:4 cbs locredit -1335 \
+hicredit 405 sendslope -89000 idleslope 11000 offload 1
 net eth1: set FIFO2 bw = 11
 
 16)
-- 
2.17.1

