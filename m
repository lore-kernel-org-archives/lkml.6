Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C826C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1642086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1642086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJKAdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:33:11 -0400
Received: from shell.v3.sk ([90.176.6.54]:54121 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJKAdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:33:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 51D9BBCF83;
        Wed, 10 Oct 2018 19:10:02 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JthTz9ZBV8Ky; Wed, 10 Oct 2018 19:09:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2D45CBCF86;
        Wed, 10 Oct 2018 19:09:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8cTahxDa-WJo; Wed, 10 Oct 2018 19:09:51 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E15C9BCF81;
        Wed, 10 Oct 2018 19:09:50 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/11] spi: pxa2xx: add DT and slave mode support
Date:   Wed, 10 Oct 2018 19:09:25 +0200
Message-Id: <20181010170936.316862-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patchset adds devicetree and slave mode support to pxa2xx SPI
controller. The objective is that it will be able to support the
OLPC XO 1.75 embedded controller that is a SPI master talking to a
MMP2 SOC. The EC driver will be submitted in a separate patch set
shortly.
=20
These patches have been submitted previously, but not applied:

[PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
[PATCH v2 02/11] PCI: Provide pci_match_id() with CONFIG_PCI=3Dn
[PATCH 03/11] spi: pxa2xx: Use an enum for type
[PATCH 04/11] spi: pxa2xx: Add devicetree support
[PATCH v2 05/11] DT: marvell,mmp2: Add SSP1 and SSP3

These are new:

[PATCH 06/11] dt-bindings: spi/spi-pxa2xx: Add spi-slave property
[PATCH 07/11] spi: Deal with slaves that return from transfer_one()
[PATCH 08/11] spi: pxa2xx: Add slave mode support
[PATCH 09/11] dt-bindings: spi/spi-pxa2xx: Add ready GPIO signal
[PATCH 10/11] spi: pxa2xx: Add ready signal
[PATCH 11/11] spi: pxa2xx: Deal with the leftover garbage in TXFIFO

Verified on a OLPC XO 1.75 machine.

Thank you,
Lubo

