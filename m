Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CE8C282C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F9720855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I92I6Oav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAVEWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:22:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33650 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfAVEV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:21:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so10816279plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 20:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YXvkxSWI9j7PH0XLfIk7l4OYwr3HALayuS+GuaRQtDA=;
        b=I92I6OavRkseVq6UgzadkRcCAFJqwXyWpfd7gTHODjdJrmBQVQUO63UcisumFR9v3L
         F6rJxjJWYvT8gu7mndjRGueKI4Y99rWws7RDuxSXJQqM/2xkBPh5j/X8v4isn2V1Dk9l
         /pq6R2tNo/Big+HUyDxtEhQapDUfBedfiBQmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YXvkxSWI9j7PH0XLfIk7l4OYwr3HALayuS+GuaRQtDA=;
        b=THa74dpf9ygUfjXHcu6L0Pa0vThASzWlzSNjPlTDmrSjDygMaTBJjGcr2yeus6ygBL
         Vfj6o1xaaztorOysjTDS5y03tHSOBjvH/sP+vm5Imzbt02DFhI4vplIsZKin6hQlC4+V
         eQBoJ26QUyRu4TNPMlJxf637BSLx8N1fzHVuNDRIf1hyv/cCTJibDBXdPwiKheLAOXJ/
         Xhe3bb3rCUB7ntiEoEX8EzpU3K5jJ6wvdwsnlUx2WJxiIPQUWFI7RLig54LNZ++eUqWn
         YoBNGvjPsH0AsVKVqCyPpgT/tsQHRENHfAwFyyITsdFNRls5cqpfz6UZX3ubiX7wUNuA
         Tk7w==
X-Gm-Message-State: AJcUukc5H5jhVAaZok8IrBdiOIZ4a4otVFBwEz3BNL1xqq8OvU5wcxG2
        BYces30hF2w3q4lvuiOO1Wyo
X-Google-Smtp-Source: ALg8bN7j+tSgVz4MKoqY8moyFNHw2w5gs9ueo65QTBhc3v9SH5i3Yx8KDr0ZahVXcKftDS2Dc5PTiw==
X-Received: by 2002:a17:902:4:: with SMTP id 4mr32930147pla.20.1548130918456;
        Mon, 21 Jan 2019 20:21:58 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
        by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 20:21:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/5] Add Oxalis board support
Date:   Tue, 22 Jan 2019 09:51:42 +0530
Message-Id: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
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

Changes in v3:

* Fixed LS1012A and LS1021A bindings
* Added missing devicetree compatibles for LS1021A based boards
* Added Rob's Reviewed-by tag for Vendor prefix patch

Changes in v2:

As per Rob's review:

* Adopted the Oxalis board binding to JSON format.
* Sorted the EBS-SYSTART vendor prefix alphabetically.
* Used the generic node name for audio codec.

Manivannan Sadhasivam (5):
  dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based
    boards
  ARM: dts: Add devicetree compatibles for LS1021A based boards
  dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
  dt-bindings: arm: fsl: Add devicetree binding for Oxalis
  arm64: dts: freescale: Add devicetree for Oxalis

 .../devicetree/bindings/arm/fsl.yaml          | 11 ++-
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts   |  1 +
 arch/arm/boot/dts/ls1021a-qds.dts             |  1 +
 arch/arm/boot/dts/ls1021a-twr.dts             |  1 +
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
 7 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts

-- 
2.17.1

