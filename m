Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EE4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FC6214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjY7pItn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FC6214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeJQMBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:01:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34955 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeJQMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:01:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so683708pgu.2;
        Tue, 16 Oct 2018 21:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WqRMWJuBSB3hCcvdUEjvDSzhuZD66PAfR/9wvsMWHu4=;
        b=DjY7pItnqBTdA6UjHuWei7dkA43Gtlhxfp16fFfP5GqyuOOmSTwUCiOEtaNPkhsoD5
         z+4CnyH8ZvzfmCfh0s3NrETN4w91/jneE334nHtoU/7OAH6TZ+pPjWOaQV1Gh2XH4L1n
         PsMvLWmBSUAJvTLjzWVdJvl4VdoAdXFRwzjN8TuUaT++zP2oETnEn9y4w45v62gK9ceW
         IOISGAg8alHaKrdfCv4aRiPg2aMMnVmCvzL6M+7EMvl926OdV0qM9DC7zH+Em7ZniQTq
         crLDOMiwd4ZHL/7Z9gvYIAk5K7dSuwnLn5vgrEw5qvlfGBMjEdPu+h94CJmFBmu1EGeT
         C/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WqRMWJuBSB3hCcvdUEjvDSzhuZD66PAfR/9wvsMWHu4=;
        b=GxlqiUDAt/e/LRiR/Ca6N714g8oxaDXabD0RpLLUk89Z4bZmO9DfGYFeCub7yKeIH/
         qyy1MGcvh+J1j5rglIoIoATxaCwM0Dk5JbVzbEJqAtAA+gb7MF4NS25LHoPcw7DN7c6L
         smCh3aKcTrcJ273gS8IYESe5v0mUgMNbg7xOHhpIn6jquyYhvBlvkqZOehWzLdNaF9ey
         bwUDCYQQ+V/Yk4ILe1iMPFsJnHJU26jPVRbv7JbI60wI9b8t/usl3Xm+njvBrPQIYXZv
         Q0BDtiuPKd8bm+g+a5+OCixpOB++cEDRIa7P9Q+FSov/zqYmlPozglkQMI7yxdF/nNcB
         PH2w==
X-Gm-Message-State: ABuFfoiW2Otrl//FbpbUSQzw2FYZFMCWT7/MADli3GySYYhtyUSaJoZY
        2umIzz1uGyRigVHiLiWZjpg=
X-Google-Smtp-Source: ACcGV61kVIYjPd2TV20Fg1oNDpAAN8SEAntMKzHA6K89DhRUxkuAYNlgcfg3fj/ETNP1VSYVcevr+Q==
X-Received: by 2002:a62:670a:: with SMTP id b10-v6mr24807297pfc.243.1539749271549;
        Tue, 16 Oct 2018 21:07:51 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id i21-v6sm20998554pgj.55.2018.10.16.21.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 21:07:50 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     "sudheer.v" <open.sudheer@gmail.com>,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: [[PATCH] 0/9] *** DMA support for UART in ASPEED's AST2500  ***
Date:   Wed, 17 Oct 2018 09:40:57 +0530
Message-Id: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA controller driver  and UART dma client driver for aspeed's AST2500

sudheer.v (9):
  DT-changes-for-DMA-UART-of-AST2500
  Defconfig-changes-for-DMA-UART-of-AST2500
  configuration-for-DMA-of-AST2500
  Documentation-DTbindings-DMA-controller-of-AST2500
  DMA-driver-for-AST2500
  configuration-for-DMA-UART-of-AST2500
  Documentation-DTbindings-DMA-UART-of-AST2500
  DMA-UART-Driver-for-AST2500
  updating MAINTAINERS for DMA and DMA-UART drivers of AST2500

 .../devicetree/bindings/dma/ast-uart-sdma.txt      |   23 +
 .../devicetree/bindings/serial/ast-sdma-uart.txt   |   34 +
 MAINTAINERS                                        |   26 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |   20 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   85 ++
 arch/arm/configs/aspeed_g5_defconfig               |    6 +-
 drivers/dma/Kconfig                                |    9 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/aspeed_uart_sdma.c                     |  810 ++++++++++
 drivers/tty/serial/8250/8250_aspeed_uart_dma.c     | 1594 ++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   34 +
 drivers/tty/serial/8250/Makefile                   |    1 +
 12 files changed, 2641 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ast-uart-sdma.txt
 create mode 100644 Documentation/devicetree/bindings/serial/ast-sdma-uart.txt
 create mode 100644 drivers/dma/aspeed_uart_sdma.c
 create mode 100644 drivers/tty/serial/8250/8250_aspeed_uart_dma.c

-- 
1.9.1

