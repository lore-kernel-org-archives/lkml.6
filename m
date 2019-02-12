Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9BE217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfBLBCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:02:46 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:43110 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727492AbfBLBCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:02:46 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C11Ghw001122;
        Mon, 11 Feb 2019 19:02:40 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2qhw8uh4um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:40 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod3.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x1C12dJc016754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:39 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 11 Feb 2019 19:02:39 -0600
Received: from nisurp-linux-2.ni.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 19:02:39 -0600
From:   Virendra Kakade <virendra.kakade@ni.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sre@kernel.org>,
        <moritz.fischer@ettus.com>,
        Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 0/6] Add support for Ettus Research E31x devices PMU
Date:   Mon, 11 Feb 2019 19:01:37 -0600
Message-ID: <20190212010143.3729-1-virendra.kakade@ni.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E31x devices are embedded devices made by Ettus Research which have
a Zynq based FPGA architecture. This code adds driver support for the
charger and battery to enable query of properties like voltage,
temperature, charge and online status among others via the device tree
on addition of overlay.

The driver follows a MFD structure with a parent driver and two
sub-drivers.

* Patch 1 and 2: Add device bindings and E31x-PMU MFD device driver

* Patch 3 and 4: Add device bindings for the charger and the sub-driver
  for it. This driver shares the register map from its parent MFD
  driver.

* Patch 5 and 6: Add device bindings for the battery and the sub-driver
  for it. Register map is re-used.

Virendra Kakade (6):
  mfd: Support for Ettus Research E31x devices PMU
  mfd: Support for Ettus Research E31x devices PMU
  power: supply: Ettus Research E31x charger driver
  power: supply: Ettus Research E31x charger driver
  power: supply: Ettus Research E31x battery driver
  power: supply: Ettus Research E31x battery driver

 .../devicetree/bindings/mfd/e31x-pmu.txt      |  28 ++
 .../bindings/power/supply/e31x-battery.txt    |  14 +
 .../bindings/power/supply/e31x-charger.txt    |  14 +
 drivers/mfd/Kconfig                           |   7 +
 drivers/mfd/Makefile                          |   2 +-
 drivers/mfd/e31x-pmu.c                        |  89 +++++
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   2 +
 drivers/power/supply/e31x-battery.c           | 357 ++++++++++++++++++
 drivers/power/supply/e31x-charger.c           | 190 ++++++++++
 include/linux/mfd/e31x-pmu.h                  |  35 ++
 11 files changed, 749 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/e31x-pmu.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-charger.txt
 create mode 100644 drivers/mfd/e31x-pmu.c
 create mode 100644 drivers/power/supply/e31x-battery.c
 create mode 100644 drivers/power/supply/e31x-charger.c
 create mode 100644 include/linux/mfd/e31x-pmu.h

-- 
2.17.1

