Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63337C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F7A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqxNyPmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfANKVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34518 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANKVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so9284501pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=byULAGSeZNWa3W0w1dufQsekRO4Y2LIQcIZw7lG1sDc=;
        b=YqxNyPmqeSemR3i0XwfTEMVm34/Yobe5oCd1I44cPpI5u7kG0zAAJrpA/FS000TKym
         eoeijKITHPsJ4moGo4NL85QJeD3iAwqD9VaSImg0//SIZHzPaR5UtvinwQY5fZK5JJ16
         svihcMDXmIEmm4ciOc9unuTgvdTExTZus6rRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=byULAGSeZNWa3W0w1dufQsekRO4Y2LIQcIZw7lG1sDc=;
        b=tE1LxIqiGWCBRyc3vDLmPK+eDfphs2SJQWPe2A6dAFpHTqgmzjcQ/hv/CxYDKOAPN0
         wnwRjCVlRL5/7tb21nauumN4y2I5S6loQ4ReL+3Qebf6A30YP+AuV5VCuATDVM7O9dQI
         bV173D41pcaeiwGETMgvfGDnSEadnT9+tM7uSys6dQI/nR7/+dchafUapmFrHHOmTwEs
         QTYvOnZMs1dtHNJgUQW0ualgvJ5ccP8a3cEjNEx6dAsvbE7UDhPfWuBiNyYQT6zI8eRb
         bPqOScaebWBK1MwkJlKovWBl4w0EjuC18NbIKPksXP59t1kaGtj64VktA5gWNkBZyG96
         U0jg==
X-Gm-Message-State: AJcUukdRz7QTnYyjCHRxV/9hzsdFxT2Z/vKlOWX5nGBe32JA8dLvy/6p
        K8JKs469wEbBO4/fwCoSaC4g
X-Google-Smtp-Source: ALg8bN65ODkdbHsWgghes22ck2YQOFIKwqB2s+0TF0PCZeY/lK/y+mooHAh6/tWT039y2J6fYNluyg==
X-Received: by 2002:a62:d2c1:: with SMTP id c184mr24852797pfg.248.1547461265216;
        Mon, 14 Jan 2019 02:21:05 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
        by smtp.gmail.com with ESMTPSA id 15sm36429pfr.55.2019.01.14.02.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:21:04 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add Oxalis board support
Date:   Mon, 14 Jan 2019 15:50:50 +0530
Message-Id: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds Oxalis board support. This board is one of the
96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
of the key features of this board:

* SoC: NXP Layerscape LS1012A
* RAM: 1GB DDR3L
* PMU: NXP VR5100
* Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
* Connectivity: 2x Ethernet
* USB: 2x USB3.0

More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/oxalis/

Ethernet and SPI flash are not supported yet!

Thanks,
Mani

Changes in v2:

As per Rob's review:

* Adopted the Oxalis board binding to JSON format.
* Sorted the EBS-SYSTART vendor prefix alphabetically.
* Used the generic node name for audio codec.

Manivannan Sadhasivam (3):
  dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
  dt-bindings: arm: fsl: Add devicetree binding for Oxalis
  arm64: dts: freescale: Add devicetree for Oxalis

 .../devicetree/bindings/arm/fsl.yaml          |  3 +-
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts

-- 
2.17.1

