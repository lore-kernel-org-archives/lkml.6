Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965427AbeEYJRi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:17:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965348AbeEYJRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:17:35 -0400
From: Li Wei <liwei213@huawei.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <khilman@baylibre.com>, <arnd@arndb.de>,
        <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>, <yamada.masahiro@socionext.com>,
        <riku.voipio@linaro.org>, <treding@nvidia.com>, <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-scsi@vger.kernel.org>
CC: <zangleigang@hisilicon.com>, <gengjianfeng@hisilicon.com>,
        <guodong.xu@linaro.org>, <puck.chen@hisilicon.com>,
        <john.stultz@linaro.org>, <liwei213@huawei.com>,
        <fengbaopeng@hisilicon.com>
Subject: [PATCH v10 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
Date: Fri, 25 May 2018 17:17:07 +0800
Message-ID: <20180525091712.37227-1-liwei213@huawei.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.89.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.

Li Wei (5):
  scsi: ufs: add Hisilicon ufs driver code
  dt-bindings: scsi: ufs: add document for hisi-ufs
  arm64: dts: add ufs dts node
  arm64: defconfig: enable configs for Hisilicon ufs
  arm64: defconfig: enable f2fs and squashfs

 Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  41 ++
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  10 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  18 +
 arch/arm64/configs/defconfig                       |  11 +
 drivers/scsi/ufs/Kconfig                           |   9 +
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/ufs-hisi.c                        | 619 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-hisi.h                        | 115 ++++
 8 files changed, 821 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 create mode 100644 drivers/scsi/ufs/ufs-hisi.c
 create mode 100644 drivers/scsi/ufs/ufs-hisi.h

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
