Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06872ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AEB20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Pw1HF7hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AEB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeGTVsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:48:45 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:38803 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbeGTVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:48:44 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7A19A10C1325;
        Fri, 20 Jul 2018 13:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532120325; bh=hZEIQQ380ZxseFXAlSDPeoXx4fT+GvDsIH9nmOWqcvU=;
        h=From:To:Cc:Subject:Date:From;
        b=Pw1HF7hgQ3niL7lCPfnmsCnvOwa2IThj5bREjZTdHr47OnfLVTMxd1QUqbML4RRza
         nzbSdkld/OzBHlOd4KC0HnMULkej3MeNl7Bcn85UdA7N3j6KwDaibeqB4f6MJw/iSB
         THxp9SkKcTXgHw7ItH8t72MluSTiLrXZq1lyFY2bFMvOigU1otiL5konO9U/4G+uWM
         gjSMHwTIpVbtBluCE2AnkxvZuFgAPhqAGEElyWMiLpuF4ShtK5cR4vMv3622Dm9ZPV
         nlumNbR9sWTRRDjEwAWaySfIxhSdQtESKfWh+SmoUaP7TtS0MkEb6rqNyI6GFZjQhV
         /LspjgH57sWfw==
Received: from vitor-VirtualBox.internal.synopsys.com (soares-e7470.internal.synopsys.com [10.107.25.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3BD515B8A;
        Fri, 20 Jul 2018 13:58:38 -0700 (PDT)
From:   Vitor soares <Vitor.Soares@synopsys.com>
To:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com,
        bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com,
        cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        Joao.Pinto@synopsys.com, Vitor.Soares@synopsys.com
Subject: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Date:   Fri, 20 Jul 2018 21:57:49 +0100
Message-Id: <1532120272-17157-1-git-send-email-soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a proposal for the I3C master driver for Synopsys IP.
This patch is to be applied on top of I3C subsystem RFC V6 submitted
by Boris Brezillon.

Supported features:
  Regular CCC commands.
  I3C private transfers.
  I2C transfers.

Missing functionalities:
  Hot-join.
  IBI.

Vitor soares (3):
  i3c: master: Add driver for Synopsys DesignWare IP
  dt-bindings: i3c: Document Synopsys DesignWare I3C master bindings
  MAINTAINERS: Add myself as the dw-i3c-master module maintainer

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt |   43 +
 MAINTAINERS                                        |    6 +
 drivers/i3c/master/Kconfig                         |   10 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/dw-i3c-master.c                 | 1255 ++++++++++++++++++++
 5 files changed, 1315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 create mode 100644 drivers/i3c/master/dw-i3c-master.c

-- 
2.7.4


