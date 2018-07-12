Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F24208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gzEwGkEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F24208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeGLFQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:16:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49946 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeGLFQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:16:32 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6C586kc026581;
        Thu, 12 Jul 2018 00:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531372086;
        bh=7kdBah8Gjw4OieujgWNKjaoYq2LOfChF8XdS+KloIxk=;
        h=From:To:CC:Subject:Date;
        b=gzEwGkEYc/S26suswij2y1H1tp1W+C1u6x+YobG/9P32/65SIMHahEt5NgTqhGJXH
         WCuhrw50ZGS7xIXdMZk6V/wfLC9IBzOd5XqvqQ7grKnqph8UklPx1aS4pGP6I2vCGj
         le4tYO7+SxbWBLy0yero1f3KuvMk921FwN7lQsBg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6C586f1007310;
        Thu, 12 Jul 2018 00:08:06 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 12
 Jul 2018 00:08:06 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 12 Jul 2018 00:08:06 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6C583Mi024383;
        Thu, 12 Jul 2018 00:08:04 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <t-kristo@ti.com>, <j-keerthy@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>
Subject: [PATCH v4 0/4] rtc: OMAP: Add support for rtc-only mode
Date:   Thu, 12 Jul 2018 10:37:36 +0530
Message-ID: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
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
  rtc: interface: Add power_off_program to rtc_class_ops

 drivers/rtc/interface.c | 12 +++++++++
 drivers/rtc/rtc-omap.c  | 70 +++++++++++++++++++++++++++++++++++--------------
 include/linux/rtc.h     |  2 ++
 3 files changed, 65 insertions(+), 19 deletions(-)

-- 
1.9.1

