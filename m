Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E6C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF03C2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF03C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJPR21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:28:27 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38252 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbeJPR21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:28:27 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9G9XhDc013232;
        Tue, 16 Oct 2018 04:38:41 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2n3es3uftm-1;
        Tue, 16 Oct 2018 04:38:41 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 33051611C8B5;
        Tue, 16 Oct 2018 04:41:29 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Oct 2018
 10:38:40 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w9G9cdLl020683;        Tue, 16 Oct 2018 10:38:39 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <tglx@linutronix.de>,
        <marc.zyngier@arm.com>, <jason@lakedaemon.net>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v13 RESEND 0/2] irqchip support for Cirrus Logic Madera codecs
Date:   Tue, 16 Oct 2018 10:38:37 +0100
Message-ID: <20181016093839.6258-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=647 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810160084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the support for the interrupt controller on the Cirrus Logic
Madera codecs. The irqchip patch has dependencies on the MFD tree.

Lee - can you take both these through the MFD tree? The irqchip patch
has dependencies on headers in MFD that aren't upstream yet so
submitting it to the irqchip tree breaks that tree.

Richard Fitzgerald (2):
  mfd: madera: Add irqchip data pointer into struct madera
  irqchip: Add driver for Cirrus Logic Madera codecs

 MAINTAINERS                        |   2 +
 drivers/irqchip/Kconfig            |   3 +
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-madera.c       | 256 +++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/irq-madera.h | 132 +++++++++++++++++++
 include/linux/mfd/madera/core.h    |   2 +
 6 files changed, 396 insertions(+)
 create mode 100644 drivers/irqchip/irq-madera.c
 create mode 100644 include/linux/irqchip/irq-madera.h

-- 
2.11.0

