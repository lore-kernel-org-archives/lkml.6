Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89106ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497F521533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Di0OAPm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497F521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbeIUBE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38243 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389113AbeIUBE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id t84-v6so4876763pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9/Th98XB46g+B7NIYKxKDyhv/UQQTG8EYyJi0X096vo=;
        b=Di0OAPm5fvE1O0TCuxvt9c2orF9JiH9IxdhmGgKhDnxc5EMOAoQV36yR2QwXzEqGfh
         GTa2bjZf/H2NAeSzI8Cbm+WZ5sY3I0ahGfZRl180XzZmJQ3/e41k9UyLFPgLW+eZN8do
         ns6xa0l1ZRW44oUH102fsz9xBZ6V/pY/4qC78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/Th98XB46g+B7NIYKxKDyhv/UQQTG8EYyJi0X096vo=;
        b=Xl0nvhO0itiUZBRTXfpx8y9VcAyqBwL6qRMPhFnEwA7a8ofOuUs6Z6RLMYg4xf3lFY
         /VX3iAOJgKb4EiEgzF3w1zqY6fugiQtfLPFG9Rply/e8tl16WiVpAMya3dHJUSpDGyfu
         5LaJZGflnW6nmRr/ps+lA5JmL0ajRCSWsDQiO9+AFmpOxhPQDcK0hNr184YxiQHlyw2j
         kDrkFMuypo9TImeHoXCEqcEfu+1fscpc89BtbKDtdmnta+wI2aVTyBz5XB+if1yOR/8o
         la4UGtbJ6RNMQNQJN1soIbolc3PwWaoQkX/YhpF6hh9MjxsBnXhOIQami+KwapsGcumy
         P/4Q==
X-Gm-Message-State: APzg51BqHCIaJz0LupewLEitbH3caNcS0tm8Ff1NxaQO7nEQGYDU0QNJ
        Ump9nEUhHsjIYcx29fsmY2mD3g==
X-Google-Smtp-Source: ANB0Vdb+1GNcurbxOwLnioMWa7pMeDTU83cQbqwEpjLpLh2oiS4iuOsNzMl9un8vjDa7aXIJQu4ngQ==
X-Received: by 2002:a62:5cc1:: with SMTP id q184-v6mr43401861pfb.241.1537471167235;
        Thu, 20 Sep 2018 12:19:27 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:26 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 43/44] coresight: dts: binding: Update coresight binding examples
Date:   Thu, 20 Sep 2018 13:18:18 -0600
Message-Id: <1537471099-19781-44-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

While we updated the coresight DT bindings, some of the
new examples were not updated due to the order in which they
were merged. Let us update all the missed out ones to the
new bindings to avoid confusion.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../devicetree/bindings/arm/coresight.txt          | 25 +++++++++-------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 13b6198ce01c..f8aff65ab921 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -147,22 +147,16 @@ Example:
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* input port */
-			port@0 {
-				reg =  <0>;
+		in-ports {
+			port {
 				etr_in_port: endpoint {
-					slave-mode;
 					remote-endpoint = <&replicator2_out_port0>;
 				};
 			};
+		};
 
-			/* CATU link represented by output port */
-			port@1 {
-				reg = <1>;
+		out-ports {
+			port {
 				etr_out_port: endpoint {
 					remote-endpoint = <&catu_in_port>;
 				};
@@ -310,10 +304,11 @@ Example:
 		clock-names = "apb_pclk";
 
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-		port {
-			catu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&etr_out_port>;
+		in-ports {
+			port {
+				catu_in_port: endpoint {
+					remote-endpoint = <&etr_out_port>;
+				};
 			};
 		};
 	};
-- 
2.7.4

