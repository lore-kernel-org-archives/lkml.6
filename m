Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED89255E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxgOsMfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED89255E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965200AbeF1TSw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:18:52 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42121 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964936AbeF1TSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:18:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id p1-v6so6580793wrs.9;
        Thu, 28 Jun 2018 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RlQfmqcJPBxthFiicpKoW37pGxEMISxz43RFJspSjo0=;
        b=XxgOsMfVaa5UwT0PUm9odRsD0WbKC4k8V8FBS+s6hPSkX1/f4sdR1uJtGxp1VPLMjQ
         uvdZ4wmhK7K1IYb0AAx3zn1NZn7PThdcPOcKc9UMiQuIzDcj2dXVPG0I7wC7GKiy9YK/
         9d0QIQTpA3APEOVi7d7iBArwq181XGdqEQhXWiLLeGRo5nayXxg20neJU6zQ/OoElKfl
         uGeVsYZpr5jIGZFU4iYjMhAG5yPZNUMzoZGnBwf67ojjULQ2in4iEI0utXJxwAnAqMXI
         7cj+v+xfvbt91iDu3q5+dpJRbziYAc7WMBPn/Liarl/0CAR7nomzhh8n1ygeZBjEkPXO
         wDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RlQfmqcJPBxthFiicpKoW37pGxEMISxz43RFJspSjo0=;
        b=hlp22Z4ed5915+VYU15auiG0U0dWbBxeOIEMGZnDmLlGOJHkYyyaaQx+EBUdF2BAps
         lwI79mmwe6C9SpogdcSUf1sXZ03V2qekkScGalVyHkuh342UyfadRVgOqq5WZ07v6yuW
         gOMKbYiCicXat3PcrXhiSTBvwXKJxBLppYpZl6A6bC+PCk6JWZsp940i8I6qYAFZudBc
         8GMoO/lHm48kdaP1M5reoPXx7oRru7GO4+xzYGMXeXNuQAN02Nj0t3t5y9QcZtoBkhOH
         lOv0nnWCLjYE3vRWeahC9cDTm/7vfq5UhxZc5Qhyl1FmlDWSCkjX4V0jEnLj3NDpjU4s
         n5Qw==
X-Gm-Message-State: APt69E0GGop5OSD0d7Js62JBH3/OHQ2oz8QunoVjnOoex8CKH2VZKZ3P
        Y4FxWpKavs3ygMPBtbDkSt8=
X-Google-Smtp-Source: AAOMgpfgVCW1KWfvEbuaMkE4nMvJxzCa/eJ7sIjFuBDSjdw2yYLRZ6dXPBB7HzuXQbsTQJfxm6O2rQ==
X-Received: by 2002:adf:e590:: with SMTP id l16-v6mr9233840wrm.190.1530213515779;
        Thu, 28 Jun 2018 12:18:35 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7CDF.dip0.t-ipconnect.de. [91.63.124.223])
        by smtp.gmail.com with ESMTPSA id r123-v6sm12289559wmb.21.2018.06.28.12.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 12:18:34 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, sboyd@kernel.org
Cc:     pn@denx.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, manivannan.sadhasivam@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock bindings
Date:   Thu, 28 Jun 2018 21:18:05 +0200
Message-Id: <20180628191805.3722-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628191805.3722-1-sravanhome@gmail.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify clock bindings common Actions Semi Soc family S700/S900.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)

diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
similarity index 71%
rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
index 93e4fb827cd6..8dc7edb4d198 100644
--- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
@@ -1,12 +1,14 @@
-* Actions S900 Clock Management Unit (CMU)
+* Actions S900/S700 Clock Management Unit (CMU)
 
-The Actions S900 clock management unit generates and supplies clock to various
-controllers within the SoC. The clock binding described here is applicable to
-S900 SoC.
+The Actions S900/S700 clock management unit generates and supplies clock to
+various controllers within the SoC. The clock binding described here is
+applicable to S900/S700 SoC.
 
 Required Properties:
 
-- compatible: should be "actions,s900-cmu"
+- compatible: should be one of this
+	"actions,s900-cmu"
+	"actions,s700-cmu"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - clocks: Reference to the parent clocks ("hosc", "losc")
@@ -15,9 +17,9 @@ Required Properties:
 Each clock is assigned an identifier, and client nodes can use this identifier
 to specify the clock which they consume.
 
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/actions,s900-cmu.h header and can be used in device
-tree sources.
+All available clocks are defined as preprocessor macros in corresponding
+dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in
+device tree sources.
 
 External clocks:
 
-- 
2.18.0

