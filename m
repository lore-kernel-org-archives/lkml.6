Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E493C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DD620896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwbBN/dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DD620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeGFGFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:05:44 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40919 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933971AbeGFGDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:03:21 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so9118883qtj.7;
        Thu, 05 Jul 2018 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e/8VnoI/gk3B9oYPV3iMClWxrM6dscLlhMd/0+YhIqU=;
        b=SwbBN/dBelP6ZCVC/O4vNewLqNW//7oAfoveDue2GHMTi/ILCppG7YyMsOlSaalT9k
         5TNvtHN3UAlFOa8XbRYNYF7CXlrcSPcUT9DGPmilyH+CSlK90v+bKynulfaa96RVbgsc
         SYemAg3wenS5VjIEJHlXnSAt2RYF8x4eou4l3KigQKLAgfA56tbNAACexGU6YspvaCWe
         UaI1WfttBc286JucDfzk1ArK0+B9WxZHYh4NEsaHg2/DNEX1GFKexbW5/0Rrd2EVBjwd
         IhwJTw8ePcXhrpQpcrjdn4V6IuVMhuUsjL3uRQoaUBPgZqFyj5dEBPHz63p3zAGqcx5O
         fLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e/8VnoI/gk3B9oYPV3iMClWxrM6dscLlhMd/0+YhIqU=;
        b=mmTmyBmtHQ/ZUk874HXu/8k3TYgPx9lQmnCTJCwUgN6bArIuZtQ41HZPbwue7GBuZV
         F/Kx9I9qnNywXO1Z806wtKLS+aoZKqbbZRuJvqknJ/p72lACbBiIBCtm/Im0ShEqemAj
         S+SCUxtjQOB2588NlqfwW3yzug1bewI4Hr20fJph8babaTk9g6xjsDmFhBp0liYzXhek
         AguNwPCnkP14408sXxCEaxxhIlv1YNV5Q++Hy9CTQhqesw7VIEc7FT9DROLbe3PtzPCq
         hvfZh0nlREbr7IBVbo+SUKaDTy/b3drkQ4JQN7lOvGx3BohCJo7jfl242Nf1XziBfDJm
         DqZA==
X-Gm-Message-State: APt69E0jtShRhrhdu5K5PYxE94nl7ab6egCqnQqwfKsRTUiX95AdArBl
        CCvPhWxjtW+cFB2iAJFqBZs=
X-Google-Smtp-Source: AAOMgpdOS0+NjN2zWTvuTwi9BY7Pcp5qJpLqO49sKwTnBSPVeu3p6WtDRGDawSpzUlOrXVfP2Rix/Q==
X-Received: by 2002:aed:25a2:: with SMTP id x31-v6mr7909249qtc.228.1530857001166;
        Thu, 05 Jul 2018 23:03:21 -0700 (PDT)
Received: from localhost.localdomain (186-106-247-248.baf.movistar.cl. [186.106.247.248])
        by smtp.gmail.com with ESMTPSA id j11-v6sm1829119qtn.10.2018.07.05.23.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 23:03:20 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v2 1/3] arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed boards
Date:   Fri,  6 Jul 2018 02:01:56 -0400
Message-Id: <20180706060158.24155-2-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706060158.24155-1-luaraneda@gmail.com>
References: <20180706060158.24155-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both boards are made by Avnet, Inc. So add an additional
value to the compatible property

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---

Changes since v1 (RFC):
- Add values to compatible property instead of replacing them

 arch/arm/boot/dts/zynq-microzed.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index aa4a0b6defb8..574ef2276182 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq MicroZED Development Board";
-	compatible = "xlnx,zynq-microzed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-microzed", "xlnx,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 53c6883ce1f6..595022487965 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq Zed Development Board";
-	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-zed", "xlnx,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
-- 
2.18.0

