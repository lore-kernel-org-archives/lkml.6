Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFB620652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFB620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeH3BIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:08:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728595AbeH3BIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:08:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TL8rMZ059081
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:09:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r15vxg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:09:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:09:41 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:09:36 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TL9Zpq45088916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:09:35 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 573A9124054;
        Wed, 29 Aug 2018 18:10:14 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F457124053;
        Wed, 29 Aug 2018 18:10:13 -0400 (EDT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:10:13 -0400 (EDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, andrew@aj.id.au, mchehab@kernel.org,
        joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 0/4] media: platform: Add Aspeed Video Engine driver
Date:   Wed, 29 Aug 2018 16:09:29 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18082921-0060-0000-0000-000002A65BFC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080714; UDB=6.00557479; IPR=6.00860700;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:09:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0061-0000-0000-000046558CC5
Message-Id: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=950 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
can capture and compress video data from digital or analog sources. With
the Aspeed chip acting as a service processor, the Video Engine can
capture the host processor graphics output.

This series adds a V4L2 driver for the VE, providing a read() interface
only. The driver triggers the hardware to capture the host graphics output
and compress it to JPEG format.

Testing on an AST2500 determined that the videobuf/streaming/mmap interface
was significantly slower than the simple read() interface, so I have not
included the streaming part.

It's also possible to use an automatic mode for the VE such that
re-triggering the HW every frame isn't necessary. However this wasn't
reliable on the AST2400, and probably used more CPU anyway due to excessive
interrupts. It was approximately 15% faster.

The series also adds the necessary parent clock definitions to the Aspeed
clock driver, with both a mux and clock divider.

Eddie James (4):
  clock: aspeed: Add VIDEO reset index definition
  clock: aspeed: Setup video engine clocking
  dt-bindings: media: Add Aspeed Video Engine binding documentation
  media: platform: Add Aspeed Video Engine driver

 .../devicetree/bindings/media/aspeed-video.txt     |   23 +
 drivers/clk/clk-aspeed.c                           |   41 +-
 drivers/media/platform/Kconfig                     |    8 +
 drivers/media/platform/Makefile                    |    1 +
 drivers/media/platform/aspeed-video.c              | 1307 ++++++++++++++++++++
 include/dt-bindings/clock/aspeed-clock.h           |    1 +
 6 files changed, 1379 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
 create mode 100644 drivers/media/platform/aspeed-video.c

-- 
1.8.3.1

