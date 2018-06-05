Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeFEO7g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:59:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751925AbeFEO7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:59:34 -0400
Subject: Re: [PATCH v10 0/5] scsi: ufs: add ufs driver code for Hisilicon
 Hi3660 SoC
To: Li Wei <liwei213@huawei.com>, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        khilman@baylibre.com, arnd@arndb.de,
        gregory.clement@free-electrons.com,
        thomas.petazzoni@free-electrons.com, yamada.masahiro@socionext.com,
        riku.voipio@linaro.org, treding@nvidia.com, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org
Cc: zangleigang@hisilicon.com, gengjianfeng@hisilicon.com,
        guodong.xu@linaro.org, puck.chen@hisilicon.com, john.stultz@linaro.org,
        fengbaopeng@hisilicon.com
References: <20180525091712.37227-1-liwei213@huawei.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f9cde7df-2d4d-3d7e-5269-ef879211b2ee@arm.com>
Date: Tue, 5 Jun 2018 15:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525091712.37227-1-liwei213@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/05/18 10:17, Li Wei wrote:
> This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.
> 
> Li Wei (5):
>   scsi: ufs: add Hisilicon ufs driver code
>   dt-bindings: scsi: ufs: add document for hisi-ufs
>   arm64: dts: add ufs dts node
>   arm64: defconfig: enable configs for Hisilicon ufs
>   arm64: defconfig: enable f2fs and squashfs
> 
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  41 ++
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  10 +-
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  18 +
>  arch/arm64/configs/defconfig                       |  11 +
>  drivers/scsi/ufs/Kconfig                           |   9 +
>  drivers/scsi/ufs/Makefile                          |   1 +
>  drivers/scsi/ufs/ufs-hisi.c                        | 619 +++++++++++++++++++++
>  drivers/scsi/ufs/ufs-hisi.h                        | 115 ++++
>  8 files changed, 821 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>  create mode 100644 drivers/scsi/ufs/ufs-hisi.c
>  create mode 100644 drivers/scsi/ufs/ufs-hisi.h
> 
> Major changes in v10:
>  - solve review comments from Rob Herring.
>    *Modify the "reset-names" describe in ufs-hisi.txt binding file.
>    *List clocks in ufs-hisi.txt binding file.
>    *remove the "arst" and keep only "rst" in the binging files.
>    *remove the "arst" member from both dts and c code. 
> Major changes in v9:
>  - solve review comments from Rob Herring.
>    *remove freq-table-hz in ufs-hisi.txt binding file.
>    *Move the rst to the ufshcd_pltfm.txt common binding file.
>    *Modify the member "assert" of UFS host structure to "arst".
> Major changes in v8:
>  - solve review comments from zhangfei.
>    *Add Version history.
>  - solve review comments from Rob Herring.
>    *remove freq-table-hz.
>  -  solve review comments from Riku Voipio.
>    *Add MODULE_DEVICE_TABLE for ufs driver.
> 

Tested on top of linux-next (4.17.0-next-20180605), I can reliably load
my debian userspace flashed on the 'system' fastboot partition.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
