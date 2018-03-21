Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeCUBtb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:49:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34709 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751481AbeCUBta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:49:30 -0400
From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH]arm64:defconfig:enable ACPI_APEI_SEA
To: Shiju Jose <shiju.jose@huawei.com>, <xuwei5@hisilicon.com>
CC: <arnd@arndb.de>, <james.morse@arm.com>, <tbaicar@codeaurora.org>,
        <xiexiuqi@huawei.com>, <zhengqiang10@huawei.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <aa732187-e12a-68e5-d15e-84090855d2c5@huawei.com>
Message-ID: <a56d6415-0755-6125-84c3-f5aef95434ca@huawei.com>
Date: Wed, 21 Mar 2018 09:48:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <aa732187-e12a-68e5-d15e-84090855d2c5@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiju,
   The configuration "CONFIG_ACPI_APEI_SEA" is needed to manually enable?
In the "drivers/acpi/apei/Kconfig" file, the default value of ACPI_APEI_SEA is "y"

config ACPI_APEI_SEA
        bool "APEI Synchronous External Abort logging/recovering support"
        depends on ARM64 && ACPI_APEI_GHES
        default y
        help
          This option should be enabled if the system supports
          firmware first handling of SEA (Synchronous External Abort).
          SEA happens with certain faults of data abort or instruction
          abort synchronous exceptions on ARMv8 systems. If a system
          supports firmware first handling of SEA, the platform analyzes
          and handles hardware error notifications from SEA, and it may then
          form a HW error record for the OS to parse and handle. This
          option allows the OS to look for such hardware error record, and
          take appropriate action.


On 2018/3/20 20:23, Shiju Jose wrote:
> Enable ACPI APEI SEA option for arm64, to handle
> ARMv8 SEA(Synchronous External Abort).
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Dongjiu Geng <gengdongjiu@huawei.com>
> Cc: Xie XiuQi <xiexiuqi@huawei.com>
> Cc: Qiang Zheng <zhengqiang10@huawei.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373..5ddf25c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -574,6 +574,7 @@ CONFIG_ACPI_APEI_GHES=y
>  CONFIG_ACPI_APEI_PCIEAER=y
>  CONFIG_ACPI_APEI_MEMORY_FAILURE=y
>  CONFIG_ACPI_APEI_EINJ=y
> +CONFIG_ACPI_APEI_SEA=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> 
