Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D629C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3B12089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dvHNqjPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3B12089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeGJGvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:51:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35642 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeGJGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:51:20 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6A6oxHi100320;
        Tue, 10 Jul 2018 01:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531205459;
        bh=i1btVGTdi9kSALJOZeq0Ixlqu2wdfAG5mSPtdXQO3nY=;
        h=From:To:CC:Subject:Date;
        b=dvHNqjPuH2XuGPBSz0yBy+L0/hXhX0FqkQ3Jooy4HT6QCwYQnutvUCtUetwHH5ZuM
         J44AUxjdzyOgrSeJViQz/eNO4Uydkp1PuZ74c6aSidKl5HuWOvy2fpGHX10Ll+S0w3
         FLn9QMSDCV+zaEssnaVxn3G67HGsz8YriyoNHias=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6A6oxAQ017780;
        Tue, 10 Jul 2018 01:50:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 01:50:59 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 01:50:59 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6A6ouGS000378;
        Tue, 10 Jul 2018 01:50:56 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <t-kristo@ti.com>, <j-keerthy@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>
Subject: [PATCH v3 0/4] rtc: OMAP: Add support for rtc-only mode
Date:   Tue, 10 Jul 2018 12:20:48 +0530
Message-ID: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare rtc driver for rtc-only with DDR in self-refresh mode.
The patch series is based on top of Johan Hovald's series:

https://lkml.kernel.org/r/20180704090558.16647-1-johan@kernel.org

Tested for suspend/resume and poweroff on am437x-gp-evm.

Keerthy (4):
  rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec
  rtc: OMAP: Add support for rtc-only mode
  rtc: omap: use of_device_is_system_power_controller function
  rtc: interface: Add power_off_program ops

 drivers/rtc/interface.c | 12 +++++++++
 drivers/rtc/rtc-omap.c  | 71 ++++++++++++++++++++++++++++++++++++-------------
 include/linux/rtc.h     |  2 ++
 3 files changed, 66 insertions(+), 19 deletions(-)

-- 
1.9.1

