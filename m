Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55CB20896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsr/dctq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55CB20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeGFGFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:05:42 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35912 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933992AbeGFGDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:03:24 -0400
Received: by mail-qt0-f193.google.com with SMTP id f1-v6so9114397qti.3;
        Thu, 05 Jul 2018 23:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kspsciOKKSUyxVC/6c9DJf+eew3BmUduJx4JKWWTX9c=;
        b=tsr/dctqCGQrXBYyLiy4W2oJv2F0vSq3ZMi304pm0GWiFv8B0jjuJM+JZTbcmw4Ps8
         p2TqkWzrdctIQsNzVL6dSj/JCG6hYyNF8Q8LwtXOol6HE2lPQztbGuLzPql2y9NCEVs3
         BC2AVIa7LyTfdRFsdJv/zG76S8sMByjHfW4EQNegJcfUvWthSV1z3yTzNNG89/uR8seG
         NsS9dkVtkI3CXM3ZiblpS9MlXXo+sT0dObv9+r2eH/+RLKSfstydR8+lMFHo6cyHHoiT
         OR/fi5t0wfgQ7auMvsKBWp2p+Zygy1m9t4iNkChX5mOxxYCHPIBIP9QS5Hebh3k9++em
         DSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kspsciOKKSUyxVC/6c9DJf+eew3BmUduJx4JKWWTX9c=;
        b=fJCen5zqcoOUz+RGS2eDpws/6w4LZieBrVUCFmHEJ/q6012vvKmQ7vgHpQaWMQqeY5
         a1Fw64inX+AxH+aJzsBy1MF2sy+rstgghiG2Tw8uPnI4XHrziTmCxFKQ4O0t/qB/Cw8G
         4lwPZb+IyvbXTpN7YEvr1sTqIbVB389BM5QrVaHlOX/ffzrWMWMM/UD92ygV5sdMAcrC
         hHcpPYjD8vhD1+QFPU9PjwjlvcE9iDZxIRH8Tz5QHZOIm6SXS/RqxumyKXYwfFZ3oy3l
         yidw5r++GG1VjW2ZgyKwKYkj0RV6WcB1bh5cZBha5vJzjiKH9tZhJCmrwr/+VAxN01eK
         fmuw==
X-Gm-Message-State: APt69E2XWygqynXrKeb4rGuFjTA+qkD9m5GB9qNZNRhhkZlV2hkpDQyk
        xAgf84GY5TBw8i3NRaDkFnU=
X-Google-Smtp-Source: AAOMgpefA3qi0e1JhWSxz82wA9X3/LOK69PnAWWP9yi7sN9gnCMGDpGmUxl0qhuMok7qbqrumyCXOA==
X-Received: by 2002:ac8:3318:: with SMTP id t24-v6mr7976807qta.224.1530857003312;
        Thu, 05 Jul 2018 23:03:23 -0700 (PDT)
Received: from localhost.localdomain (186-106-247-248.baf.movistar.cl. [186.106.247.248])
        by smtp.gmail.com with ESMTPSA id j11-v6sm1829119qtn.10.2018.07.05.23.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 23:03:22 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: xilinx: Add missing zynq boards and sort entries
Date:   Fri,  6 Jul 2018 02:01:57 -0400
Message-Id: <20180706060158.24155-3-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706060158.24155-1-luaraneda@gmail.com>
References: <20180706060158.24155-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings were missing when adding the device-tree files

Also, improve description of existing boards, sort them
alphabetically by manufacturer, and migrate the contents
of adapteva dt dindigns into Xilinx's

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---

Changes since v1 (RFC):
- Don't remove "internal" word from Xilinx boards on dt-bindings
- Migrate content of adapteva dt-binding file into Xilinx's
- Sort additional compatible strings alphabetically
  by manufacturer

 .../devicetree/bindings/arm/adapteva.txt      |  7 -----
 .../devicetree/bindings/arm/xilinx.txt        | 30 +++++++++++++++----
 2 files changed, 25 insertions(+), 12 deletions(-)
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
index b9043bc35c14..26fe5ecc4332 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -8,18 +8,38 @@ Required root node properties:
 
 Additional compatible strings:
 
-- Xilinx internal board cc108
+- Adapteva Parallella board
+  "adapteva,parallella"
+
+- Avnet MicroZed board
+  "avnet,zynq-microzed"
+  "xlnx,zynq-microzed"
+
+- Avnet ZedBoard board
+  "avnet,zynq-zed"
+  "xlnx,zynq-zed"
+
+- Digilent Zybo board
+  "digilent,zynq-zybo"
+
+- Digilent Zybo Z7 board
+  "digilent,zynq-zybo-z7"
+
+- Xilinx CC108 internal board
   "xlnx,zynq-cc108"
 
-- Xilinx internal board zc770 with different FMC cards
+- Xilinx ZC702 internal board
+  "xlnx,zynq-zc702"
+
+- Xilinx ZC706 internal board
+  "xlnx,zynq-zc706"
+
+- Xilinx ZC770 internal board, with different FMC cards
   "xlnx,zynq-zc770-xm010"
   "xlnx,zynq-zc770-xm011"
   "xlnx,zynq-zc770-xm012"
   "xlnx,zynq-zc770-xm013"
 
-- Digilent Zybo Z7 board
-  "digilent,zynq-zybo-z7"
-
 ---------------------------------------------------------------
 
 Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
-- 
2.18.0

