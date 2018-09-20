Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A21C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C3721533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWWL9z3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C3721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbeIUBE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35679 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbeIUBEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so4829376pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ukYBOxLGLxNeJsPgCPfVVlnqngyM2zNwpXi4wluZMac=;
        b=AWWL9z3Vd+BZwt7cXnMZLOj2N2dNSZFVMqnEImSjKMDJyyW0L++0kOWCJ9UNtNupGL
         KegZtYkSOvlZBtOA2cvd2V6Etm+4n2hsa/QU1Rdm5ZT+dZGEhquwRMJKwBrpUSVN8pOR
         vCAiNRdEKz/VM4yj2FiJj92mSOpT6PX4fngKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ukYBOxLGLxNeJsPgCPfVVlnqngyM2zNwpXi4wluZMac=;
        b=FMqZP26Gb2c93d6wRsz9WFhZe3bKuMnWz6pxEj0Ts9ziSqrLOLwkm8sBZwR+RJ7v+f
         EHlbZXwzP5CsqlMHc/59rj4C8Jg02TW3JgQfvCW7bD7u28BAwcIr2P2lzgkjidzqNKp4
         3uKM7fNqN2eATh0lf804+FHoJjAeJiYhiKe2X8KJJOaDRsB7IRXGMP/k9az+JLvA5zuN
         FOWjfJ7P5IUQSUcBNEz85K8QkaAmhSlSeQb32o0Lb/METiEAebW43+jraT7O++yshZ4r
         Tdkh2MMxhhPMEeNikC8t+SeMzM3u+rqx6P2/XvHjliSpj/B8piMfrqerTF8KkF6kFP59
         nxLw==
X-Gm-Message-State: APzg51AcoZPlaZS0UH3YIPzGsyuAqcL6WSP/YxrFr+894LCp1+FcQOKD
        zujcTx8+FOTG67HzKoefqPCFkA==
X-Google-Smtp-Source: ANB0Vdbe2RNStbsKmqIAMS/NME8Cy0C1QLfHUIkcoNrfFUo5nm0pI+B9Ni7zCdqxnkFzYMgdrRPoLw==
X-Received: by 2002:a62:fcd2:: with SMTP id e201-v6mr43154052pfh.101.1537471165756;
        Thu, 20 Sep 2018 12:19:25 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:24 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 42/44] coresight: dts: binding: Fix example for TPIU component
Date:   Thu, 20 Sep 2018 13:18:17 -0600
Message-Id: <1537471099-19781-43-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

TPIU component has an input port. The example uses out-ports
which is wrong. Let us fix it.

Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index f39d2c6eb49c..13b6198ce01c 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -132,7 +132,7 @@ Example:
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		out-ports {
+		in-ports {
 			port {
 				tpiu_in_port: endpoint@0 {
 					remote-endpoint = <&replicator_out_port1>;
-- 
2.7.4

