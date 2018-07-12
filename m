Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7554C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D38208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGl5ft3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D38208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeGLESm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:18:42 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41321 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeGLESk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:18:40 -0400
Received: by mail-qk0-f194.google.com with SMTP id d22-v6so14815014qkc.8;
        Wed, 11 Jul 2018 21:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aDExclJhLJWTbA25rlG2UPQ4GRZEzI0y+px46zubYu4=;
        b=UGl5ft3xuFfuxzaCRaCbi1kzF3BxF4QsEJuxBn5GaLxPUdMzkW5ekKINr503Mrl2MQ
         W7Exd51q4CmrQLWudgfbQ2LYOKKmtjLtAQsDhK+/TyadZc2F9bKianFAiEyze+xAkFEM
         t7QJEScvlR8KegC7HgN8f6Z73FhdbNR00hGfWjnjB+OP+au9f4z2TDtHG5CGromLZVCK
         ysInRIIpi7V3PL6EFl6MWC3y+W6VMP6Wh92syqZppghurGbGxvFUcB013onOtbGQMbVh
         2fA3LpOYkPxJAtvZvc8gxH8TL0W5xqqdgpMRZKvRcEx1eFGIJ5M3vfJoEQGOBGxIwcV9
         9B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aDExclJhLJWTbA25rlG2UPQ4GRZEzI0y+px46zubYu4=;
        b=eBo9TEQwjKkLDwp2PvzQASK4lfNLMzlfX54Nvd+fpCzmP4ZA8HMF8r5BqOS0CFFFg2
         2koJEpf6xeiVsNLRksqgq+ZL6RumxOi8yLnYPPx17GT9m6RPij2WCEvV+LqryvlbqNFc
         m+icjwsM+AKLwnFmQ+uDwCP/NE9RI45IF/XPtNY3l1bvFnR7avFyzNLtsiFPoLI6IFJZ
         T/WUn+ElYtDafQb1YM7nDKzmeo967J9zyFGV6ULsDGOdp6tfdR5FyiSUa8OzcFv/xrHU
         Z5DnE1jhxONJwdicLlH0YeyzsYhNus6TC/M+4ErzVLA1Yq0m+dlbopp9jYyaZfAAuwrA
         gv/Q==
X-Gm-Message-State: AOUpUlFU/B7MImW3DVNGmr4rzVajTRWDqeDYeALnrSldraZX8NoeCJC2
        s3EAnqsghpdhvSrqkRkHBuA=
X-Google-Smtp-Source: AAOMgpenBSHhI+/aNjkJBedZq3zxhXzjME3T9xgeK3qW9zmFmkMNpypJFiCKFe7bWjyxRgcTyFauxg==
X-Received: by 2002:a37:a4d:: with SMTP id 74-v6mr482667qkk.148.1531368660648;
        Wed, 11 Jul 2018 21:11:00 -0700 (PDT)
Received: from localhost.localdomain (186-106-119-105.baf.movistar.cl. [186.106.119.105])
        by smtp.gmail.com with ESMTPSA id m51-v6sm7260115qtc.85.2018.07.11.21.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 21:11:00 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v3 6/6] dt-bindings: xilinx: zynq: Add missing boards
Date:   Thu, 12 Jul 2018 00:10:24 -0400
Message-Id: <20180712041024.20583-7-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings were missing when the device-tree
files were added

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 .../devicetree/bindings/arm/xilinx.txt          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index d1a6deac90b5..26fe5ecc4332 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -11,12 +11,29 @@ Additional compatible strings:
 - Adapteva Parallella board
   "adapteva,parallella"
 
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
 - Digilent Zybo Z7 board
   "digilent,zynq-zybo-z7"
 
 - Xilinx CC108 internal board
   "xlnx,zynq-cc108"
 
+- Xilinx ZC702 internal board
+  "xlnx,zynq-zc702"
+
+- Xilinx ZC706 internal board
+  "xlnx,zynq-zc706"
+
 - Xilinx ZC770 internal board, with different FMC cards
   "xlnx,zynq-zc770-xm010"
   "xlnx,zynq-zc770-xm011"
-- 
2.18.0

