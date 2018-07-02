Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2961C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38AF25471
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38AF25471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964866AbeGBJgA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:36:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59015 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933423AbeGBJf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:35:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF21231311901;
        Mon,  2 Jul 2018 17:35:53 +0800 (CST)
Received: from vm107-89-192.huawei.com (100.107.89.192) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Mon, 2 Jul 2018 17:35:48 +0800
From:   Li Wei <liwei213@huawei.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <khilman@baylibre.com>,
        <arnd@arndb.de>, <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>,
        <yamada.masahiro@socionext.com>, <riku.voipio@linaro.org>,
        <treding@nvidia.com>, <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC:     <zangleigang@hisilicon.com>, <gengjianfeng@hisilicon.com>,
        <sunzhaosheng@hisilicon.com>, <ian.rickards@arm.com>,
        <guodong.xu@linaro.org>, <puck.chen@hisilicon.com>,
        <john.stultz@linaro.org>, <liwei213@huawei.com>,
        <fengbaopeng@hisilicon.com>
Subject: [PATCH v11 0/4] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
Date:   Mon, 2 Jul 2018 17:35:43 +0800
Message-ID: <20180702093547.39507-1-liwei213@huawei.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.89.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.

Li Wei (4):
  scsi: ufs: add Hisilicon ufs driver code
  dt-bindings: scsi: ufs: add document for hisi-ufs
  arm64: dts: add ufs dts node
  arm64: defconfig: enable configs for Hisilicon ufs

 Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  41 ++
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  10 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  18 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/scsi/ufs/Kconfig                           |   9 +
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/ufs-hisi.c                        | 619 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-hisi.h                        | 115 ++++
 8 files changed, 811 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 create mode 100644 drivers/scsi/ufs/ufs-hisi.c
 create mode 100644 drivers/scsi/ufs/ufs-hisi.h

Major changes in v11:
 - solve review comments from John Stultz.
  *include Rob Herring's Reviewed-by tag to the dt-binding patch.
  *drop the defconfig changes, such as f2fs and squashfs related.
Major changes in v10:
 - solve review comments from Rob Herring.
   *Modify the "reset-names" describe in ufs-hisi.txt binding file.
   *List clocks in ufs-hisi.txt binding file.
   *remove the "arst" and keep only "rst" in the binging files.
   *remove the "arst" member from both dts and c code. 
Major changes in v9:
 - solve review comments from Rob Herring.
   *remove freq-table-hz in ufs-hisi.txt binding file.
   *Move the rst to the ufshcd_pltfm.txt common binding file.
   *Modify the member "assert" of UFS host structure to "arst".
Major changes in v8:
 - solve review comments from zhangfei.
   *Add Version history.
 - solve review comments from Rob Herring.
   *remove freq-table-hz.
 -  solve review comments from Riku Voipio.
   *Add MODULE_DEVICE_TABLE for ufs driver.
-- 
Major changes in v7:
 - solve review comments from Philippe Ombredanne.
   *use the new SPDX license ids instead of the GNU General Public License.
-- 
2.15.0

