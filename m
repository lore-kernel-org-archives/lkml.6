Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CA8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2E021104
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl7UvvSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2E021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755134AbeFYJ2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:28:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55382 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbeFYJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:27:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so8415395wmh.5;
        Mon, 25 Jun 2018 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JgUt5Sd6UFh+b813nY7URxLA4MuZZZjQ1TQiz0Ev88Y=;
        b=Vl7UvvSMTo4vhUuw94n841bP3Si2TeQNaFSSv9wDdNxR5f1VzedRR8XRVJi9zI3/je
         82UGj3mPDZb8+vNDXZfjvQ6J8MsTLZPmO4Gzln+kTgXDpXLBNZHOe9tjM7DDaVR57UeL
         dYjCAtIfnwGhZdk00FA2I2hVz2p20aSiU8+pqpikVIA5hn+X37SDwbg70v900RSoUL76
         x8gt6MPV1rujvpZ7Fm28wP3WybsR0bGdxAja5vQW5K0ICZDbFHCkpqvhoaaYTAuyl4Lj
         3hxqEYb4cqJh7oTxWkJgYX8s5Z2ZLeuZmN/89LuYUashLx+OFN8IRgN0jgyaLRmXUSVO
         ZQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JgUt5Sd6UFh+b813nY7URxLA4MuZZZjQ1TQiz0Ev88Y=;
        b=QeS8RT1VzS5ljm+GKSfHlqZhb4rg2J3Jf7NhddMPoDD8qRCNbZEJ1AXUSHts290V1v
         lMvNrIfcApBIA2/dKuBPKJniI44wUSdRXIXeBob9HGrxodinelEhx3T+DtJGzLCGMDKc
         zYJebBtZKUfVOxFzmC24nNKyhVj48VtqSLO/W0qnPIvW71cRdgGa0NK/eqCM1KM2K7he
         X459qdQ+1+zaBmO/ZpRzuAx5Ff6KDQo25iO7tHOzOE+Fg6k0Qaq9qzI6BixkShQ2ZhtB
         LGPm4ri/P1HEBwFxiKf3DAKZ3gyIHWgN/zHuqCBrWUFkK+u0jVik5VQkg+guk9WUrnO+
         gT2g==
X-Gm-Message-State: APt69E1SV1iQS9wDFN9POXf/hI7OhxHRkcV/8ciVu6UIB8CWRPqNUTWT
        lwFiPiXVdToo3p9QhfWQILg=
X-Google-Smtp-Source: ADUXVKJRVx4zKkYceboHNU72zfUFjQ8djlaEFo8474++sAw6yxslNmbn6IlOcxOGcFL5nAy9wTnf7g==
X-Received: by 2002:a1c:47cf:: with SMTP id m76-v6mr357841wmi.80.1529918869400;
        Mon, 25 Jun 2018 02:27:49 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id v2-v6sm15638779wrm.84.2018.06.25.02.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:27:48 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v3 2/5] dt-bindings: dmaengine: xilinx_dma: add optional xlnx,sg-length-width property
Date:   Mon, 25 Jun 2018 11:27:21 +0200
Message-Id: <20180625092724.22164-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625092724.22164-1-andrea.merello@gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add DOC for it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
	- change property name
	- property is now optional
	- cc DT maintainer
Changes in v3:
	- reword
	- cc DT maintainerS and ML
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

