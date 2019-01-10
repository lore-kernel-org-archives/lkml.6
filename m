Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58198C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B9C2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfAJNu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:50:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9961 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbfAJNu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:50:56 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADfdVd000386;
        Thu, 10 Jan 2019 14:50:53 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ptybn9mcu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 10 Jan 2019 14:50:53 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B73834;
        Thu, 10 Jan 2019 13:50:52 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5432C505E;
        Thu, 10 Jan 2019 13:50:52 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan
 2019 14:50:52 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan 2019 14:50:51
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 0/3] remoteproc: complete fixed memory region support
Date:   Thu, 10 Jan 2019 14:50:48 +0100
Message-ID: <1547128251-44137-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new series corresponds to the remaining patches from [1]
addressing fixed memory region support for remote processor.

The three remaining patches allow to:
- assign a specific memory region to vdev sub device. As all virtio based
  services are using virtio device parent for memory allocation, I propose to
  keep a dedicated vdev device per virtio link for memory allocation. A second
  step will be to used virtio device itself.
- migrate ST driver on new memory carveout management
- allocate virtio rpmsg buffer from parent device

Regards,
Loic


[1] https://lkml.org/lkml/2018/7/27/612

---
Changes from V1:
- rebase on kernel v5.0-rc0
- correct error management for device registering

Loic Pallardy (3):
  remoteproc: create vdev subdevice with specific dma memory pool
  remoteproc: st: add reserved memory support
  rpmsg: virtio: allocate buffer from parent

 drivers/remoteproc/remoteproc_core.c     | 47 +++++++++++++++--
 drivers/remoteproc/remoteproc_internal.h |  1 +
 drivers/remoteproc/remoteproc_virtio.c   | 42 ++++++++++++++-
 drivers/remoteproc/st_remoteproc.c       | 91 ++++++++++++++++++++++++++++----
 drivers/rpmsg/virtio_rpmsg_bus.c         |  6 +--
 include/linux/remoteproc.h               |  1 +
 6 files changed, 170 insertions(+), 18 deletions(-)

-- 
2.7.4

