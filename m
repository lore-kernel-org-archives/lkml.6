Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040C6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD38220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD38220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mixed-mode.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeGXLAr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:00:47 -0400
Received: from mailgate.pixel-group.de ([145.253.133.146]:49239 "EHLO
        mailgate.pixel-group.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGXLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:00:47 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2018 07:00:46 EDT
Received: from mail.pixel.de (unknown [10.63.25.81])
        by mailgate.pixel-group.de (Postfix) with ESMTP id AE0285E168;
        Tue, 24 Jul 2018 11:46:02 +0200 (CEST)
Received: from tragicomix (localhost [127.0.0.1])
        by mail.pixel.de (Postfix) with ESMTP id 36E9D1A192;
        Tue, 24 Jul 2018 11:46:02 +0200 (CEST)
Received: from lippe.pixel-group.local (10.63.25.67)
 by tragicomix (F-Secure/fsigk_smtp/550/tragicomix);
 Tue, 24 Jul 2018 11:46:02 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/tragicomix)
Received: from lippe.pixel-group.local (10.63.25.67) by
 lippe.pixel-group.local (10.63.25.67) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 11:46:01 +0200
Received: from lippe.pixel-group.local ([fe80::50c5:3a27:2d73:37cb]) by
 lippe.pixel-group.local ([fe80::50c5:3a27:2d73:37cb%16]) with mapi id
 15.00.1367.000; Tue, 24 Jul 2018 11:46:01 +0200
From:   Sven Schmitt <Sven.Schmitt@mixed-mode.de>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>
Subject: [PATCH v3 0/3] soc: imx: gpc: cleanups
Thread-Topic: [PATCH v3 0/3] soc: imx: gpc: cleanups
Thread-Index: AQHUIy94XBSLNsL4VkqsYdoEyZ/JQQ==
Date:   Tue, 24 Jul 2018 09:46:01 +0000
Message-ID: <1532425557359.10004@mixed-mode.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.63.25.69]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the power down delay in gpc.c 
and improves readability.

Changes in v3:
* rebased to 4.18
* split up patch into 3 parts

Changes in v2:
* dropped cntr_pup_bit

Sven Schmitt (3):
  soc: imx: gpc: fix PDN delay
  soc: imx: gpc: clean up
  soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes

 drivers/soc/imx/gpc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.17.1
