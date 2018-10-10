Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3402C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1D12086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1D12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJKAqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:46:31 -0400
Received: from shell.v3.sk ([90.176.6.54]:54473 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKAqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:46:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9CEABBCFC9;
        Wed, 10 Oct 2018 19:23:17 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id F07GVUskWNU4; Wed, 10 Oct 2018 19:23:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 25466BCFB2;
        Wed, 10 Oct 2018 19:23:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sl3oqLCkvF4c; Wed, 10 Oct 2018 19:23:02 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 99E71BCF86;
        Wed, 10 Oct 2018 19:23:01 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
Date:   Wed, 10 Oct 2018 19:22:45 +0200
Message-Id: <20181010172300.317643-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patchset adds support for the Embedded Controller on an OLPC XO
1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
the existing OLPC platform infrastructure, currently used by the x86
based models.

The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
uses extra handshake signal to signal readiness of SOC to accept data
from EC and to initiate a transaction if SOC wishes to submit data.

The SPI slave support for MMP2 was submitted separately:
https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t

THe "power: supply: olpc_battery: correct the temperature" patch was
already sent out separately, but I'm including it because the last
commit of the set depends on it.

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

Thanks in advance for reviews and feedback of any kind.

Lubo

