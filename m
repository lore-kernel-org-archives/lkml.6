Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF09ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4512086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZnlRqdnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4512086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeGPSe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:34:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53252 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:34:58 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6GI68JW103545;
        Mon, 16 Jul 2018 13:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531764368;
        bh=YTQeCS6nl4Qts8tAZKkfLvpxaRSrd4sZhQ2nlw39sKY=;
        h=From:To:CC:Subject:Date;
        b=ZnlRqdnU/HMpPLgBk/dG6h8MxQLIb2fuF/kQOamWIRMsnr0UAuGyS8uEK+XHcii9m
         XVy3VopOgY+PECMHcCrFaWwaE8oCKVHtcZ58SvtAIhIRgFrfI41MDFhyyZi5PRHSzX
         1EjWEnU0GDrNrljL1sFIR1zLnlNcES3K9eGSiRkg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GI68q6024974;
        Mon, 16 Jul 2018 13:06:08 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 16
 Jul 2018 13:06:08 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 16 Jul 2018 13:06:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GI6880024748;
        Mon, 16 Jul 2018 13:06:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 0/6] mailbox: ti-msgmgr: Add support for AM654 Secure Proxy
Date:   Mon, 16 Jul 2018 13:06:01 -0500
Message-ID: <20180716180607.16526-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V2 of the series updates a minor comment in binding and picks up Rob's Reviewed-by

Since I have'nt seen additional comments, I am assuming things are fine for v4.19.

The following series enables support for Secure Proxy in newest addition in TI's SoC
portfolio - AM654 SoC (posted previously as RFC).

The series is based on v4.18-rc1 and is available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-sproxy

There are a couple of follow on patches to be posted as well (Kconfig changes
for K3_ARCH and actual dts node changes).

Changes since RFC are highlighted in each of the patches, but overall:
* The K3 dependency has been broken out into a seperate series independent of
  this.
* Binding has been seperated out as it's own file (even though the driver is
  reused).

Consolidated all patches (including all series) are available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ

Full Boot log  on AM654 (integrated with all patch series) is available here:
   https://pastebin.ubuntu.com/p/bBFmnzYtCd/

Nishanth Menon (6):
  mailbox: ti-msgmgr: Get rid of unused structure members
  mailbox: ti-msgmgr: Allocate Rx channel resources only on request
  mailbox: ti-msgmgr: Change message count mask to be descriptor based
  mailbox: ti-msgmgr: Move the memory region name to descriptor
  dt-bindings: mailbox: Add support for secure proxy threads
  mailbox: ti-msgmgr: Add support for Secure Proxy

 .../bindings/mailbox/ti,secure-proxy.txt           |  50 +++
 drivers/mailbox/ti-msgmgr.c                        | 353 +++++++++++++++++----
 2 files changed, 336 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt

-- 
2.15.1

