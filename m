Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61278C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB7020849
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5vSKq2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB7020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933834AbeGFGFW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:05:22 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33799 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933970AbeGFGDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:03:19 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so5763228qkj.1;
        Thu, 05 Jul 2018 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qq+EG7wXVKivIy3ypn6z12Z1wXP/HeznEJ+Ipq1yGSg=;
        b=f5vSKq2w8/qWDEBCt5ucKZGeNcWgZLHtIhDdDokbN7M8uZh3DfLtQVb3023RkRslRj
         N/OLKGPXQWbNh8ew9i53G8E/BiOujfzgHTL3aZpzSXmDmO7WYQ/04yt2ibKZ0h3YhNv6
         1wHvr7cE77FNL1Vc+G4zM5I3Qk9JrRskpRKuHuP7YYJgyN2bNr0HRTZnhsqmZe3lVnPm
         2QzVSbklyddCFSjz8bHYl4o/M8P32LGNOjBrPRDcUlUyw5/ZwaOTWnlOCzjRNSLDSdHm
         6hH7U+SZu//8Yjz1Ac6brG8D7SqHe8Es5C06t7htOt2Wd2WK6lSoP3FP5QbK14M8sE/D
         FosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qq+EG7wXVKivIy3ypn6z12Z1wXP/HeznEJ+Ipq1yGSg=;
        b=reaPbQbnpA4weQWq8uEZv+v4srb4nSi3CV7FqOC5OqBrgPi1rNYz8AFZ7+zSlO0onh
         ZVP/Qb7PFuxVu30wHM/jC+2Cwh6g5NGv3vJyoq5kTiznazVSFweumwEkevlUePEmymQR
         HyJ+1uFrutsk6T8rkv/qAkh6BAi1DaWWM3DK7JeA3OZyQ0OO8T4i1wIkdfibauMkqH2o
         sD9U2X362XxhXXFqcbKwIdH7vtCsDV5gbkMGtW9K7Dfkceike7SZZb9PwCBSp5GMHq96
         hGa1fw28saT0cpa4gYfZ+Phr+qgcH+NyGGfhzM4IK+qpIXwK4Me74XAZVKxYer8BvFq+
         3RTA==
X-Gm-Message-State: APt69E1DEZzrFnHSNTb2Zzv4jp/FjS9bWhnGaD/iMsiw4GQN8OlIKl9/
        nGkEb6kC8ueCz/fq5ND6hwqeMqmQxlA=
X-Google-Smtp-Source: AAOMgpc3H6vbN6zazJoxBIns8IOSyELUheBwR7pcPMZj+a4SAk1CvV4Y3/toyRj4P3G8SPmtcs3L4A==
X-Received: by 2002:a37:a9c1:: with SMTP id s184-v6mr7390372qke.199.1530856999095;
        Thu, 05 Jul 2018 23:03:19 -0700 (PDT)
Received: from localhost.localdomain (186-106-247-248.baf.movistar.cl. [186.106.247.248])
        by smtp.gmail.com with ESMTPSA id j11-v6sm1829119qtn.10.2018.07.05.23.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 23:03:18 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v2 0/3] arm: dts: zynq: improvements and cleanup
Date:   Fri,  6 Jul 2018 02:01:55 -0400
Message-Id: <20180706060158.24155-1-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to standardize device naming and improve
its information for better identification

The values of the "compatible" and "model" device-tree properties
are corrected for some devices, adding complementary information
when necessary

Changes since v1 (RFC):
- Add values to compatible property instead of replacing them
- Don't remove "internal" word from Xilinx boards on dt-bindings
- Migrate content of adapteva dt-binding file into Xilinx's
- Sort additional compatible strings alphabetically
  by manufacturer
- Dropped patch that renamed the zedboard development board
  (no apparent benefit)
- Dropped the patch that removed the "zynq" value from the
  compatible strings (breaks the ABI)

Luis Araneda (3):
  arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
    boards
  dt-bindings: xilinx: Add missing zynq boards and sort entries
  arm: dts: zynq: correct and improve the model property of dt files

 .../devicetree/bindings/arm/adapteva.txt      |  7 -----
 .../devicetree/bindings/arm/xilinx.txt        | 30 +++++++++++++++----
 arch/arm/boot/dts/zynq-cc108.dts              |  2 +-
 arch/arm/boot/dts/zynq-microzed.dts           |  4 +--
 arch/arm/boot/dts/zynq-parallella.dts         |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts              |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts              |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts        |  2 +-
 arch/arm/boot/dts/zynq-zed.dts                |  4 +--
 arch/arm/boot/dts/zynq-zybo-z7.dts            |  2 +-
 arch/arm/boot/dts/zynq-zybo.dts               |  2 +-
 14 files changed, 39 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt

-- 
2.18.0

