Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC24C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96B8218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlW6Zrj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfAZELC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 23:11:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40458 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfAZELB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 23:11:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so5446713plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 20:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7/KChodqzOwOxKMahivIffCjoPXtO7yajVZ/FiXpfUE=;
        b=YlW6Zrj8L9/F4Uspc2nfzT8hGU7jQfXLyges7YZ5DvMFHtD+aKBclwW0MejxUq3bL9
         0r1yYG22fYnhid2Z89ZPEBa0J36XfOAwgNPPisYnFSahkO3f9eon+XIO2I9p/as4lCHF
         gxGv8plh8akl74lHSuqQRQvZ3F5nDk/+gyVsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7/KChodqzOwOxKMahivIffCjoPXtO7yajVZ/FiXpfUE=;
        b=YsqoxnBgGkxiMl5IEEIcjhNkOBgdizAB7Pq9Orethyq9sZxcEfyRhL3Zvgz2XojQfs
         rO9Q13440T5azeTtbpwBEzLNlQWW9D/8aIQOcDFdGq5g9u0wpfckiRKqLwd1cVDz0aHu
         B27eWskiv6A5qA8SjeNjwYr5fBBhYWnG5az4cFRmD8UwCH7dwYaCdcQfzw2XLwJUcWrx
         gGTYwwp6BZ/D7FMV4vOnjwr5UZer+n9bFILnFBmIgeFyEPNp1dNwis3lKE1lqtFIybgS
         CP5FKNgyNvwMS2cZP8+4c7sagAeWIs/pPJXWhG9qWLv4vvMcKTN+yjocL/dfCEYJ+dGO
         Fj9Q==
X-Gm-Message-State: AJcUukeoONpWOYUictDTLaOhLMUU+Em1rxYlZgmjMSOmSvPVJOCz6/nG
        h/tO3DVOn+NR0z9xqocsT+Ji
X-Google-Smtp-Source: ALg8bN4FU4X+LK5zVbWA4ZLCNLUYdSa72FtS6xk34+GnVD9YlZaEvToAbFr0tT5WVeLPEAi41coulQ==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr13679490plb.238.1548475860608;
        Fri, 25 Jan 2019 20:11:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
        by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 20:10:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
Date:   Sat, 26 Jan 2019 09:40:36 +0530
Message-Id: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds initial support for Bitmain BM1880 SoC and Sophon
Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
processor subsystem, a single core RISC-V subsystem and a Tensor
Processor subsystem. This patchset adds support for only ARM Cortex
A53 Application processor subsystem with UART, which enables the board to
boot into initramfs with 2 CPUs.

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: arm: Document Bitmain BM1880 SoC
  arm64: Add ARCH_BITMAIN platform
  arm64: dts: bitmain: Add BM1880 SoC support
  arm64: dts: bitmain: Add Sophon Egde board support
  MAINTAINERS: Add entry for Bitmain SoC platform

 .../devicetree/bindings/arm/bitmain.yaml      |  18 +++
 MAINTAINERS                                   |   7 ++
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/bitmain/Makefile          |   3 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   |  50 ++++++++
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       | 119 ++++++++++++++++++
 7 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bitmain.yaml
 create mode 100644 arch/arm64/boot/dts/bitmain/Makefile
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880.dtsi

-- 
2.17.1

