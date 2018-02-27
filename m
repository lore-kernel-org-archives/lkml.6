Return-Path: <mmoese@suse.de>
X-Google-Smtp-Source: AH8x225Usbzxv5/ezGLJRJKLOiHVv5azhX6jvn0kbh/1R0oqEWuurIUgOMNX/psg9wTgQO+BpR09
ARC-Seal: i=1; a=rsa-sha256; t=1519738648; cv=none;
        d=google.com; s=arc-20160816;
        b=LpFaKG95jDpNqElKBspTfZVy/ruj08lJALWJGBw/5VpgAix7CnYS8EuIg+OyiaanVH
         UzlXH9Z/XFhu+8/MzWWB2jYbAXZczLOIsO/WqCfgLtEsKF7v9hGHU4LUkCv0ht2KzTgA
         EzuFVT1jTZJlHZpQYpsdeCCOItKoscpJy68uA2/372oHFT4iZVf/7JAPJpWkqPFNvtk2
         sPjFveR+F3QzDUNm72GVe++CRIB+L0V4w+pZNaqsDi1FKi6IcqRTfFf5VJYEo3aN9EUn
         HQyUrLZY2x+KgFfZaeyB+CIugBETyfQCyBJbQ+fQ6zZcjCCOgQN5S4uJRaHGzzVwAABX
         NZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Vg02e6nioK8GI+Ftf/Hwq25DYnbNrO9Q2CVAV8hbKu4=;
        b=EQXfLVcBQMHYj9eW3uyok8U+DBoiohqbc0wTiRr6D0HBlThlmngHEBcC9Hs/uydmhw
         G+vZv0AW3f0hp3exWS2S8y0anx9J1UR1Mbkkoo2ZPbDRrxFlGtl7lRB/ZM1dtSRSfJcx
         02S9B55dV9BcWFPi1iggne9TmM5gqdYGydPFlD9c5IG5r424j3mHymqQC8ucLn+c87+T
         HqEgmrrrbMwo1dKt9eKXDZ+BCB9xxzBlG3x7c55hWzycNEX3/ocUaei47eTti5NgJeaC
         MzyMydxDtSprd5jl5b/tPGHgRwOrwvYNBY5EVquUXNMXvdaiNH3J4YtsSrjlmbKOEJGl
         K95Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mmoese@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mmoese@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mmoese@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mmoese@suse.de
Date: Tue, 27 Feb 2018 14:37:26 +0100
From: Michael Moese <mmoese@suse.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Andreas =?iso-8859-1?Q?Gei=DFler?= <andreas.geissler@men.de>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] mcb: add Altera PCI ID to mcb-pci
Message-ID: <20180227133726.frfk2lymnyvrs4th@linux.suse.de>
References: <20180227133018.7732-1-jthumshirn@suse.de>
 <20180227133018.7732-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227133018.7732-3-jthumshirn@suse.de>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561031162206643?=
X-GMAIL-MSGID: =?utf-8?q?1593561473501138972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks good.

Reviewed-by: Michael Moese <mmoese@suse.de>


On Tue, Feb 27, 2018 at 02:30:18PM +0100, Johannes Thumshirn wrote:
> Some older PCI attached MEN FPGAs use an Altera PCI Vendor ID instead
> of the MEN one. Add it to the PCI ID table so the driver automatically
> attaches to it.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reported-by: Ben Turner <ben.turner@21net.com>
> Tested-by: Ben Turner <ben.turner@21net.com>
> Cc: Andreas Geißler <andreas.geissler@men.de>
> Cc: Michael Moese <mmoese@suse.de>
> ---
>  drivers/mcb/mcb-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
> index af4d2f26f1c6..286b32ca526f 100644
> --- a/drivers/mcb/mcb-pci.c
> +++ b/drivers/mcb/mcb-pci.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pci_ids.h>
>  #include <linux/mcb.h>
>  
>  #include "mcb-internal.h"
> @@ -117,6 +118,7 @@ static void mcb_pci_remove(struct pci_dev *pdev)
>  
>  static const struct pci_device_id mcb_pci_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MEN, PCI_DEVICE_ID_MEN_CHAMELEON) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_ALTERA, PCI_DEVICE_ID_MEN_CHAMELEON) },
>  	{ 0 },
>  };
>  MODULE_DEVICE_TABLE(pci, mcb_pci_tbl);
> -- 
> 2.13.6
> 

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
