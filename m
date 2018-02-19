Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeBSC6H (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:58:07 -0500
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:48501
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752216AbeBSC6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:58:05 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CnAAA7OYpa/zXSMGcNTxkBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEHAQEBAQGFTYNnmGoBAQEBAQEGgQ0ngReYX4VFAoMeFAECAQEBAQEBAoY?=
 =?us-ascii?q?2AQEBAQIBI1YFCwsNAQoCAiYCAlcGAQwGAgEBihEFqVtugichhGCDc4ITAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEhgQ+DfIM3glkMgnmIOoJlBaQ1CAGiXYd0mVs2gXMzGgg?=
 =?us-ascii?q?oCIJ9hQhmjkcBAQE?=
X-IPAS-Result: =?us-ascii?q?A2CnAAA7OYpa/zXSMGcNTxkBAQEBAQEBAQEBAQEHAQEBAQG?=
 =?us-ascii?q?FTYNnmGoBAQEBAQEGgQ0ngReYX4VFAoMeFAECAQEBAQEBAoY2AQEBAQIBI1YFC?=
 =?us-ascii?q?wsNAQoCAiYCAlcGAQwGAgEBihEFqVtugichhGCDc4ITAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEhgQ+DfIM3glkMgnmIOoJlBaQ1CAGiXYd0mVs2gXMzGggoCIJ9hQhmjkcBA?=
 =?us-ascii?q?QE?=
X-IronPort-AV: E=Sophos;i="5.46,533,1511798400";
   d="scan'208";a="74053760"
Subject: Re: [PATCH net 1/4] net/8390: Remove redundant make dependencies
To: Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1519007130.git.fthain@telegraphics.com.au>
 <ad208b917b7eb0e581ca46246253692db71484cb.1519007130.git.fthain@telegraphics.com.au>
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <c7a53542-3098-9932-ef92-92f16b39dc91@linux-m68k.org>
Date: Mon, 19 Feb 2018 12:47:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ad208b917b7eb0e581ca46246253692db71484cb.1519007130.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On 19/02/18 12:39, Finn Thain wrote:
> The hydra, zorro8390 and mcf8390 drivers all #include "lib8390.c" and
> have no need for 8390.o. modinfo confirms no dependency on 8390.ko.
> Drop the redundant dependency from the Makefile. objdump confirms
> that this patch has no effect on the module binaries.
> 
> The superfluous additions of 8390.o were introduced in
> commit 644570b83026 ("8390: Move the 8390 related drivers").
> 
> Cc: Greg Ungerer <gerg@linux-m68k.org>

Looks right for mcf8390.c.

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/net/ethernet/8390/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/8390/Makefile b/drivers/net/ethernet/8390/Makefile
> index f975c2fc88a3..1d650e66cc6e 100644
> --- a/drivers/net/ethernet/8390/Makefile
> +++ b/drivers/net/ethernet/8390/Makefile
> @@ -7,8 +7,8 @@ obj-$(CONFIG_MAC8390) += mac8390.o
>  obj-$(CONFIG_APNE) += apne.o 8390.o
>  obj-$(CONFIG_ARM_ETHERH) += etherh.o
>  obj-$(CONFIG_AX88796) += ax88796.o
> -obj-$(CONFIG_HYDRA) += hydra.o 8390.o
> -obj-$(CONFIG_MCF8390) += mcf8390.o 8390.o
> +obj-$(CONFIG_HYDRA) += hydra.o
> +obj-$(CONFIG_MCF8390) += mcf8390.o
>  obj-$(CONFIG_NE2000) += ne.o 8390p.o
>  obj-$(CONFIG_NE2K_PCI) += ne2k-pci.o 8390.o
>  obj-$(CONFIG_PCMCIA_AXNET) += axnet_cs.o 8390.o
> @@ -16,4 +16,4 @@ obj-$(CONFIG_PCMCIA_PCNET) += pcnet_cs.o 8390.o
>  obj-$(CONFIG_STNIC) += stnic.o 8390.o
>  obj-$(CONFIG_ULTRA) += smc-ultra.o 8390.o
>  obj-$(CONFIG_WD80x3) += wd.o 8390.o
> -obj-$(CONFIG_ZORRO8390) += zorro8390.o 8390.o
> +obj-$(CONFIG_ZORRO8390) += zorro8390.o
> 
