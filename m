Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37244C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6288208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcDMB6IH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6288208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeGLESj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:18:39 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40263 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeGLESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:18:38 -0400
Received: by mail-qk0-f196.google.com with SMTP id c126-v6so6080241qkd.7;
        Wed, 11 Jul 2018 21:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IEINbgyEUPVymArm/qrQsgD/JbfdbVxflMcXWN5h4XU=;
        b=GcDMB6IHfz88CZipdENavJiK+2nxT16wX73iC47RVS2faHnsVCP8ejkvZIC4MZUOO2
         17vJNHE5kg0hbvz8mu0ukvMxm2jbhGaiQVzWcRIKN9TVU6HOczCfWmcHb2fcizKUWwEi
         pIUaMkp93WHbms01I2a1A+4WbVCnwXyiazB6k+HPW7Fify4hVbQwfFr7051gba8LjPEB
         gnBiP5LoXoJ7Hip6FPT57sUWYhTOG1zISr00sCgSV9PVohoisPz5tFI7FzSObqx/VVuy
         qiNocsvDZA5NEC//rb4sqnnYYhaOPEOn34i3f+uDZRqbNER8ukdtmZKgMh3ILiMyw0Yn
         VHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IEINbgyEUPVymArm/qrQsgD/JbfdbVxflMcXWN5h4XU=;
        b=sFOPOhmmOHMGdLyV0e935Qmzc/KOyXNMFNTcc8eFRP5egdHbd7kY9Us2MZa/sawVob
         yc/b315jGCw+ZCuNIRUaJjhKgyCM8jQ9JrT8TLHC3nZ4aDYqdcMxyrXki/MwqqJscmRL
         sWyak5UOjnsUkE2OuzWZ4dQT13gba8vcTXju/gD5OzOcCE/d/AElx3/kTtXwIdfCutHR
         nECK+XzAINkDu5bPiwy6Tqtg/hYK217Gdw0u6kbVGxfXMMtweDg0ZybCOx3SLyt/1uXT
         IhsNV5sqR7i3mGo3O+SCuKoUTHZ4kQoGjYXbhU/IKBF/93lqFch2WmD67w0djFpswC9Z
         9Sjg==
X-Gm-Message-State: AOUpUlFUVSZKki7qZi800M7EGonglIGgnZw3E+sg0zDSJyfYoSOAeEwc
        XwRnfjX3klyUDpDpJHSteE8=
X-Google-Smtp-Source: AAOMgpe5RW/P4Agg9MrGjgZnwmT9M2zzLfZeotX2Nw135FMlfS2R7+6JExdT2f/JTgDgwxm/co+MjA==
X-Received: by 2002:a37:5d02:: with SMTP id r2-v6mr472798qkb.22.1531368658459;
        Wed, 11 Jul 2018 21:10:58 -0700 (PDT)
Received: from localhost.localdomain (186-106-119-105.baf.movistar.cl. [186.106.119.105])
        by smtp.gmail.com with ESMTPSA id m51-v6sm7260115qtc.85.2018.07.11.21.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 21:10:58 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v3 5/6] dt-bindings: Move Paralella board to Xilinx
Date:   Thu, 12 Jul 2018 00:10:23 -0400
Message-Id: <20180712041024.20583-6-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Adapteva Parallela board to Xilinx dt-bindings,
as it's based on a Zynq SoC from Xilinx

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 Documentation/devicetree/bindings/arm/adapteva.txt | 7 -------
 Documentation/devicetree/bindings/arm/xilinx.txt   | 3 +++
 2 files changed, 3 insertions(+), 7 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt

diff --git a/Documentation/devicetree/bindings/arm/adapteva.txt b/Documentation/devicetree/bindings/arm/adapteva.txt
deleted file mode 100644
index 1d8af9e36065..000000000000
--- a/Documentation/devicetree/bindings/arm/adapteva.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Adapteva Platforms Device Tree Bindings
----------------------------------------
-
-Parallella board
-
-Required root node properties:
-    - compatible = "adapteva,parallella";
diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index a8e70a794d2e..d1a6deac90b5 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -8,6 +8,9 @@ Required root node properties:
 
 Additional compatible strings:
 
+- Adapteva Parallella board
+  "adapteva,parallella"
+
 - Digilent Zybo Z7 board
   "digilent,zynq-zybo-z7"
 
-- 
2.18.0

