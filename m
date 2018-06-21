Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E9BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEF720883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9CCp1sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEF720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbeFUL7Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:59:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55225 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933190AbeFUL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:58:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so4674188wmf.4;
        Thu, 21 Jun 2018 04:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Apqd+GfKVKk1i99FPZm+Qz6t1n7y2NfsrpFch2y7tQ=;
        b=g9CCp1svjFwRILVTWKh2lrq7Kf9H63ec39flg9DYSdC+T4GzUVB98UzKtmnHwF1KuI
         UDR4Hn2fuGrmrjNEjkYoWuyZWMDMlJ1mvkOOiTYkNGGamlf2lyJiVLKZrOHp2jDGBaUa
         0lppnVY2ZdLWFrEOF4hOMnpcgD3SgZ4Mhi4w5A1dJyjOYqPUbxyTEYWOd0zjhHi2G1vn
         hNJxcKGz4OJJLwyxYXym817kaTgcQ4YpxLNCeweIew3KnRk/EPzFvoz0j32z/vMxyOQa
         0UCYZKXND4HQPSUGK6VBY6I2+HcWoMs30sca9sDjJM/uDFpArj3f8RelG7ezrFfue0Ja
         GS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Apqd+GfKVKk1i99FPZm+Qz6t1n7y2NfsrpFch2y7tQ=;
        b=OaqP/5xwbtX7ibi8Wf+pFy5W+UXzF+CgFgx1Pf6tLeJ6c/s2DYnob80IDjH1EsU3En
         WHTMl04boyMHuItBJL7vUn1MkzDUZN944oNrB14FsFt/0nQ8thyHcB4qQ6qK31yihJKw
         FnF49KXwA+N82aXNixSQ6iwtyWzrgZVodF8OLhJ99DAwp34doy8te3+Y/vpwtV8dLcF2
         2DIOXcV1Qi2tVH+J5hApycGB/tBtSjUOjSLuh/FHckRiR3zilRhXDWZMaHF8UYF3+hUQ
         H6+vH1siwuP/LuvD3xlJrJchCYBIvrfPpdpx6ckh5Q+l1pbNYq25KwBvuOHAfZzB5I+T
         PfXg==
X-Gm-Message-State: APt69E0B6JgLU4c57S6SyaBEuT1BnqlVF2L08jWPkhwltDm85YFfAhrZ
        B4+bq+vMFnfDb5Unt/mvuZg=
X-Google-Smtp-Source: ADUXVKIEucBXLeByURzliIbiB+gQ23+SuIe1hirFw1dEAHnIY1buUWQdCBg1+irC8IJt1w9EADAJQw==
X-Received: by 2002:a1c:bfc8:: with SMTP id o69-v6mr5305778wmi.8.1529582310904;
        Thu, 21 Jun 2018 04:58:30 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id e188-v6sm13779773wmf.21.2018.06.21.04.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:58:30 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/5] dt-bindings: xilinx_dma: add optional xlnx,sg-length-width property
Date:   Thu, 21 Jun 2018 13:58:19 +0200
Message-Id: <20180621115822.20058-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621115822.20058-1-andrea.merello@gmail.com>
References: <20180621115822.20058-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add DOC for it.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
Changes in v2:
	- change property name
	- property is now optional
	- cc DT maintainer
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfaec43c..c894abe28baa 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -41,6 +41,7 @@ Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
 	the hardware.
 Optional properties for AXI DMA:
+- xlnx,sg-length-width: Should be the width of the length register as configured in h/w.
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
-- 
2.17.1

