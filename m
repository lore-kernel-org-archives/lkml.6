Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2266EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF32521934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405041AbeLVXgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:36:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392969AbeLVXgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:36:05 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 024E98B3BF910;
        Sat, 22 Dec 2018 15:50:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Sat, 22 Dec 2018 15:50:45 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 0/4] crypto: hisilicon: Add HiSilicon QM and ZIP controller driver
Date:   Sat, 22 Dec 2018 15:51:41 +0800
Message-ID: <1545465105-133138-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds HiSilicon QM and ZIP controller driver in crypto subsystem.

A simple QM/ZIP driver which helps to provide an example for a general
accelerator framework is under review in community[1]. Based on this simple
driver, this series adds HW v2 support, PCI passthrough, reset, PCI/misc error
handler, debug support. But unlike [1], driver in this patchset only registers
to crypto subsystem.

There will be a long discussion about above accelerator framework in the
process of upstreaming. So let's firstly review and upstream QM/ZIP crypto
driver.

References:
[1] https://lkml.org/lkml/2018/11/12/1951

Zhou Wang (4):
  Documentation: Add debugfs doc for hisi_zip
  crypto: hisilicon: Add queue management driver for HiSilicon QM module
  crypto: hisilicon: Add HiSilicon ZIP accelerator support
  MAINTAINERS: add maintainer for HiSilicon QM and ZIP controller driver

 Documentation/ABI/testing/debugfs-hisi-zip |   50 +
 MAINTAINERS                                |    8 +
 drivers/crypto/hisilicon/Kconfig           |   11 +
 drivers/crypto/hisilicon/Makefile          |    2 +
 drivers/crypto/hisilicon/qm.c              | 1823 ++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h              |  177 +++
 drivers/crypto/hisilicon/zip/Makefile      |    2 +
 drivers/crypto/hisilicon/zip/zip.h         |   60 +
 drivers/crypto/hisilicon/zip/zip_crypto.c  |  410 +++++++
 drivers/crypto/hisilicon/zip/zip_main.c    | 1161 ++++++++++++++++++
 10 files changed, 3704 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-zip
 create mode 100644 drivers/crypto/hisilicon/qm.c
 create mode 100644 drivers/crypto/hisilicon/qm.h
 create mode 100644 drivers/crypto/hisilicon/zip/Makefile
 create mode 100644 drivers/crypto/hisilicon/zip/zip.h
 create mode 100644 drivers/crypto/hisilicon/zip/zip_crypto.c
 create mode 100644 drivers/crypto/hisilicon/zip/zip_main.c

-- 
2.8.1

