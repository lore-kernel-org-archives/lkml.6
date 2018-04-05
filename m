Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDEHZk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:25:40 -0400
Received: from goliath.siemens.de ([192.35.17.28]:36658 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDEHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:25:39 -0400
Subject: Re: [PATCH] uapi: fix asm/bootparam.h userspace compilation errors
To: "Dmitry V. Levin" <ldv@altlinux.org>
References: <20180405043210.GA13254@altlinux.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
From: Jan Kiszka <jan.kiszka@siemens.com>
Openpgp: preference=signencrypt
Message-ID: <32e449e9-5738-d347-20ad-50ee4a2257e2@siemens.com>
Date: Thu, 5 Apr 2018 09:25:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180405043210.GA13254@altlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-05 06:32, Dmitry V. Levin wrote:
> Consistently use types provided by <linux/types.h> to fix the following
> asm/bootparam.h userspace compilation errors:
> 
> /usr/include/asm/bootparam.h:140:2: error: unknown type name 'u16'
>   u16 version;
> /usr/include/asm/bootparam.h:141:2: error: unknown type name 'u16'
>   u16 compatible_version;
> /usr/include/asm/bootparam.h:142:2: error: unknown type name 'u16'
>   u16 pm_timer_address;
> /usr/include/asm/bootparam.h:143:2: error: unknown type name 'u16'
>   u16 num_cpus;
> /usr/include/asm/bootparam.h:144:2: error: unknown type name 'u64'
>   u64 pci_mmconfig_base;
> /usr/include/asm/bootparam.h:145:2: error: unknown type name 'u32'
>   u32 tsc_khz;
> /usr/include/asm/bootparam.h:146:2: error: unknown type name 'u32'
>   u32 apic_khz;
> /usr/include/asm/bootparam.h:147:2: error: unknown type name 'u8'
>   u8 standard_ioapic;
> /usr/include/asm/bootparam.h:148:2: error: unknown type name 'u8'
>   u8 cpu_ids[255];
> 
> Fixes: 4a362601baa6 ("x86/jailhouse: Add infrastructure for running in non-root cell")
> Cc: <stable@vger.kernel.org> # v4.16
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/x86/include/uapi/asm/bootparam.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index aebf60357758..a06cbf019744 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -137,15 +137,15 @@ struct boot_e820_entry {
>   * setup data structure.
>   */
>  struct jailhouse_setup_data {
> -	u16	version;
> -	u16	compatible_version;
> -	u16	pm_timer_address;
> -	u16	num_cpus;
> -	u64	pci_mmconfig_base;
> -	u32	tsc_khz;
> -	u32	apic_khz;
> -	u8	standard_ioapic;
> -	u8	cpu_ids[255];
> +	__u16	version;
> +	__u16	compatible_version;
> +	__u16	pm_timer_address;
> +	__u16	num_cpus;
> +	__u64	pci_mmconfig_base;
> +	__u32	tsc_khz;
> +	__u32	apic_khz;
> +	__u8	standard_ioapic;
> +	__u8	cpu_ids[255];
>  } __attribute__((packed));
>  
>  /* The so-called "zeropage" */
> 

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

But how did you trigger this?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
