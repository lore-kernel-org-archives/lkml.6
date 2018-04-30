Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbeD3QCF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:02:05 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:45520 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbeD3QCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:02:03 -0400
Date: Mon, 30 Apr 2018 09:01:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>,
        "x86@kernel.org" <x86@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Woods, Brian" <Brian.Woods@amd.com>
Subject: Re: [PATCH 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
Message-ID: <20180430160159.GB19372@roeck-us.net>
References: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
 <20180429175305.GB19814@pd.tnic>
 <a4b1d937-c5b8-67d0-b5f0-312145fefc09@roeck-us.net>
 <MWHPR12MB1566866B2ACF36EAD7E4856AF8820@MWHPR12MB1566.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR12MB1566866B2ACF36EAD7E4856AF8820@MWHPR12MB1566.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 03:38:59PM +0000, Ghannam, Yazen wrote:
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Sunday, April 29, 2018 2:24 PM
> > To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
> > <Yazen.Ghannam@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>; Clemens Ladisch
> > <clemens@ladisch.de>; x86@kernel.org; Jean Delvare <jdelvare@suse.com>;
> > linux-kernel@vger.kernel.org; linux-hwmon@vger.kernel.org; Woods, Brian
> > <Brian.Woods@amd.com>
> > Subject: Re: [PATCH 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
> > 
> > On 04/29/2018 10:53 AM, Borislav Petkov wrote:
> > > On Sat, Apr 28, 2018 at 06:54:38PM -0700, Guenter Roeck wrote:
> > >> Add Raven Ridge root bridge and data fabric PCI IDs.
> > >> This is required for amd_pci_dev_to_node_id() and amd_smn_read().
> > >>
> > >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >> ---
> > >> This patch is a prerequisite for the second patch in the series.
> > >> I'll be happy to apply both patches through hwmon if that is acceptable
> > >> (and Cc: stable for 4.16+). If not, I'll be happy to wait for this patch
> > >> to be available upstream.
> > >>
> > >> Since that there is no public documentation available for Raven Ridge,
> > >> PCI IDs are derived from output of lspci.
> > >>
> > >>   arch/x86/kernel/amd_nb.c | 6 ++++++
> > >>   1 file changed, 6 insertions(+)
> > >>
> > >> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> > >> index c88e0b127810..bd33613ecb7c 100644
> > >> --- a/arch/x86/kernel/amd_nb.c
> > >> +++ b/arch/x86/kernel/amd_nb.c
> > >> @@ -14,8 +14,11 @@
> > >>   #include <asm/amd_nb.h>
> > >>
> > >>   #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
> > >> +#define PCI_DEVICE_ID_AMD_17H_RR_ROOT	0x15d0
> > >
> > > I think the nomenclature we decided upon at the time was
> > >
> > > ...AMD_<family>H_M<model>H...
> > >
> > > PCI_DEVICE_ID_AMD_15H_M10H_F3, for example.
> > >
> > > And in this case, it should be
> > >
> > > PCI_DEVICE_ID_AMD_17H_M<which model is RV>H_F<PCI function
> > number>
> > >
> > 
> > Makes sense.
> > 
> > > Yazen, which is the first model of Raven Ridge?
> > >
> > 
> > 2400G is model 17 (0x11). I was unable to find information if there are
> > other chips/models using the same set of PCI IDs.
> > 
> > I'll wait for additional feedback before resending.
> 
> There are other models using the same set of IDs, but the first is 10h.
> 
Ok, I'll make it PCI_DEVICE_ID_AMD_17H_M10H_ROOT and
PCI_DEVICE_ID_AMD_17H_M10H_DF_F{3,4}.

> Also, the F3 IDs for Fam17h and Fam17hMod10h are used in both amd_nb.c
> and k10temp.c. Can you please delete the F3 IDs from these files and add
> them to "include/linux/pci_ids.h"?
> 
I'll be happy to do that. However, my preference would be to do that
in a separate patch. I would like to see this patch and patch 2/2
applied to 4.16+ since together they fix a potential race condition
as well as temperature reporting problems with multi-die Zen chips
(Threadripper and EPYC). The pci_id.h changes are not bug fixes
and would be more appropriate for v4.18.

Thanks,
Guenter

> Thanks!
> 
> -Yazen
