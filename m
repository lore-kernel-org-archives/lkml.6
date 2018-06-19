Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6803FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A3A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VdZYH5az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A3A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030583AbeFSTnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:43:47 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:24544 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030414AbeFSTnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:43:42 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJhbFs022545;
        Tue, 19 Jun 2018 14:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437417;
        bh=47ddtwbQO0Lq/cC3Gy1cvIK5eADSlrlHuaacW2LuCMA=;
        h=From:To:CC:Subject:Date;
        b=VdZYH5azkSqff/PPsYcDlz/Luu5ismgpxMiDeSpMbKX3pGdruRhB8HorzsOufoll4
         HwKLrMgPWnE2syYT/SINRL36M21cVsOkPdLG+jTNaN5g29so2APM+J4sswuHeQ2UNU
         kGCMRwLASdtmQq6Ked1pud9DbAqA0a85FS1U9i0I=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJhbLe024499;
        Tue, 19 Jun 2018 14:43:37 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:43:37 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:43:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJhbmu032504;
        Tue, 19 Jun 2018 14:43:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/6] mailbox: ti-msgmgr: Add support for AM654 Secure Proxy
Date:   Tue, 19 Jun 2018 14:43:31 -0500
Message-ID: <20180619194337.31522-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
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

