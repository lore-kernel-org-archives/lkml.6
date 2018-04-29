Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeD2Rx3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 13:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48951 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753574AbeD2Rx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 13:53:27 -0400
Date: Sun, 29 Apr 2018 19:53:05 +0200
From: Borislav Petkov <bp@suse.de>
To: Guenter Roeck <linux@roeck-us.net>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Brian Woods <brian.woods@amd.com>
Subject: Re: [PATCH 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
Message-ID: <20180429175305.GB19814@pd.tnic>
References: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 06:54:38PM -0700, Guenter Roeck wrote:
> Add Raven Ridge root bridge and data fabric PCI IDs.
> This is required for amd_pci_dev_to_node_id() and amd_smn_read().
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> This patch is a prerequisite for the second patch in the series.
> I'll be happy to apply both patches through hwmon if that is acceptable
> (and Cc: stable for 4.16+). If not, I'll be happy to wait for this patch
> to be available upstream.
> 
> Since that there is no public documentation available for Raven Ridge,
> PCI IDs are derived from output of lspci.
> 
>  arch/x86/kernel/amd_nb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index c88e0b127810..bd33613ecb7c 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -14,8 +14,11 @@
>  #include <asm/amd_nb.h>
>  
>  #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
> +#define PCI_DEVICE_ID_AMD_17H_RR_ROOT	0x15d0

I think the nomenclature we decided upon at the time was

...AMD_<family>H_M<model>H...

PCI_DEVICE_ID_AMD_15H_M10H_F3, for example.

And in this case, it should be

PCI_DEVICE_ID_AMD_17H_M<which model is RV>H_F<PCI function number>

Yazen, which is the first model of Raven Ridge?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
