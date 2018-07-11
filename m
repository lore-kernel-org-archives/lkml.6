Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B8C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7B020C10
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h0t0dDgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7B020C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbeGKXs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:48:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57380 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbeGKXs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:48:58 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6BNgFZi102602;
        Wed, 11 Jul 2018 18:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531352535;
        bh=NPpakumofGxALmeUDn8rVrbvzBb7/wspaUsGyLYf1vM=;
        h=From:To:CC:Subject:Date;
        b=h0t0dDgVrDQGAZIMaza/uVnztQUv0f0UBij31plC8mCTCM1XYaoiTXUqQBuIDjF5w
         SFnvJ6j48gByGcW1zWKhpQPw6T/aKbjFRZzXB0RqJHnvNXFua8iL9I3tVloOtWrZbd
         3LI4BYmJ6RTnGeNae0F1cYGFuNYO3IdsOT8AvOpI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6BNgFpv022476;
        Wed, 11 Jul 2018 18:42:15 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 11
 Jul 2018 18:42:15 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 11 Jul 2018 18:42:15 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6BNgFb1025585;
        Wed, 11 Jul 2018 18:42:15 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w6BNgEx17973;
        Wed, 11 Jul 2018 18:42:14 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] OMAP Mailbox cleanups for 4.19
Date:   Wed, 11 Jul 2018 18:42:10 -0500
Message-ID: <20180711234212.7756-1-s-anna@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

The following series includes couple of cleanup patches on
the OMAP Mailbox driver. Please pick them for 4.19.

The first patch switches the licensing to use the SPDX license
identifier. The second patch is some code cleanup in preparing
the driver to be built against a 64-bit platform in K3 AM654 SoC
(support for that in OMAP Mailbox driver will be added once the
base K3 AM654 pieces are part of mainline).

regards
Suman

Suman Anna (2):
  mailbox/omap: switch to SPDX license identifier
  mailbox/omap: use of_device_get_match_data() to get match data

 drivers/mailbox/omap-mailbox.c | 31 +++++++++++++++----------------
 include/linux/omap-mailbox.h   |  5 +----
 2 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.17.1

