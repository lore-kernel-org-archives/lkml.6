Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeDQOIl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:08:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42058 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752206AbeDQOIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:08:39 -0400
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
        <guodong.xu@linaro.org>
Subject: [PATCH v9 5/5] arm64: defconfig: enable f2fs and squashfs
Date: Tue, 17 Apr 2018 22:08:14 +0800
Message-ID: <20180417140814.38098-6-liwei213@huawei.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180417140814.38098-1-liwei213@huawei.com>
References: <20180417140814.38098-1-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.89.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partitions in HiKey960 are formatted as f2fs and squashfs.
f2fs is for userdata; squashfs is for system. Both partitions are required
by Android.

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d42b1ecaf490..e8036cddb272 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -613,6 +613,7 @@ CONFIG_ACPI_APEI_MEMORY_FAILURE=y
 CONFIG_ACPI_APEI_EINJ=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
+CONFIG_F2FS_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
@@ -628,6 +629,13 @@ CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_EFIVAR_FS=y
 CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_FILE_DIRECT=y
+CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
+CONFIG_SQUASHFS_XATTR=y
+CONFIG_SQUASHFS_LZ4=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
-- 
2.15.0
