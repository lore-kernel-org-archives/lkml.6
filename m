Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeC2NrH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:47:07 -0400
Received: from mail-bn3nam01on0044.outbound.protection.outlook.com ([104.47.33.44]:45258
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752299AbeC2NrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:47:05 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: RE: [PATCH v3 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Topic: [PATCH v3 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Index: AQHTw6EUE8NPisR8RkSBUxCEiwHimKPm/kqAgAA4vIA=
Date: Thu, 29 Mar 2018 13:47:03 +0000
Message-ID: <DM5PR12MB1916DEB138196D26B89CB227F8A20@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
 <20180324184940.19762-3-Yazen.Ghannam@amd.com>
 <20180329094613.GA29198@pd.tnic>
In-Reply-To: <20180329094613.GA29198@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1531;7:56fLin8KJtJ+qstmaAilcNsYWHsJmYdvKvIE9wvP9bSAQ6n0d7yjmj/zAcRzqHZGBxHh8zZ0AqKU9+3wxV1sBYMqgk7AhCxZb2aznw0Q/d31b5HKckchzH4Rz5MW1hHD61y14kTIWp5tJ8qF5sa3NPHBk+zB1kztRwKPLtZLSM9paPIvag0ZgedmEBdQFqSLfscvFq7wToguMwyqF5kf7Ea5ep2ECYvyTqE2M9jsoTYtYiVgArFqa2OWYaota3BT;20:4AUCfNO/34lzOvKllYBZLQHug16GLhyRmqSO0zXRUDlxt55OGfLMFciRzWpR+ZXrABUas+QiqglJxgnKUfAF2ShnQ07Y4xLODB3MmRBpR1A7Azf8DN1A9FkjOkF5UwIR+8WUAvtb9wG9WzuBplzWVqPomsJH4G1kc3wHgxWCwx1DFDjEObWt9ST3yT9H//AlKZaYc/JV+loDy4yYnD3KMPu0FYIRhbrZa37b0oM8wKk22Ew3eNErEe1B6p9MdEc8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55f0457c-ea56-4946-8ab8-08d5957b8db7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1531;
x-ms-traffictypediagnostic: DM5PR12MB1531:
x-microsoft-antispam-prvs: <DM5PR12MB1531EC28D829277222C056E9F8A20@DM5PR12MB1531.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1531;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1531;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(366004)(396003)(13464003)(189003)(199004)(5250100002)(575784001)(106356001)(6116002)(2906002)(476003)(11346002)(446003)(3660700001)(3280700002)(229853002)(9686003)(8936002)(486005)(486005)(53936002)(8676002)(81166006)(81156014)(97736004)(6916009)(305945005)(6306002)(7736002)(74316002)(5660300001)(68736007)(6246003)(2900100001)(316002)(86362001)(478600001)(54906003)(76176011)(6506007)(53546011)(14454004)(99286004)(33656002)(105586002)(4326008)(102836004)(6436002)(55016002)(966005)(72206003)(7696005)(186003)(46003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1531;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: aW/9GZHxztKnp50U+pWvbKv9utMdUCcMlFcgmvCOSSpv7Mi+5fh8v34uEBgs5CbCU8SZY5g4s7ArXROszJqDrbqZ5G95mxS890LvO7XzsFihqhDQsuQyOHPfNoN/cuz91TrdnvjFw4giGaDKEmoK3HdVLId8EXuwJIongBPc0hMG32B8JQCxy8lin7xGymWteYsLB7t9dec0taX1RubK8A8a4cGF3Lo5oS7TLdqWmS5VvnOh/RnJbu1/4OZOy7lDM87Qx7bN94fw7zcP+IDwMM4Ewg15uDjwUoY2SMDxNy3UG0MPyPzRjBvcSMcuGLqGTusF07suS45fkDhhhmM6Kw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f0457c-ea56-4946-8ab8-08d5957b8db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 13:47:03.3144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1531
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2TDlDMt015272

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, March 29, 2018 5:46 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org; tony.luck@intel.com
> Subject: Re: [PATCH v3 2/8] efi: Decode IA32/X64 Processor Error Section
> 
> On Sat, Mar 24, 2018 at 01:49:34PM -0500, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Recognize the IA32/X64 Processor Error Section.
> >
> > Do the section decoding in a new "cper-x86.c" file and add this to the
> > Makefile depending on a new "UEFI_CPER_X86" config option.
> >
> > Print the Local APIC ID and CPUID info from the Processor Error Record.
> >
> > The "Processor Error Info" and "Processor Context" fields will be
> > decoded in following patches.
> >
> > Based on UEFI 2.7 Table 252. Processor Error Record.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > Link:
> > https://lkml.kernel.org/r/20180226193904.20532-3-
> Yazen.Ghannam@amd.com
> >
> > v2->v3:
> > * Fix table number in commit message.
> > * Don't print raw validation bits.
> >
> > v1->v2:
> > * Change config option depends to "X86" instead of "X86_32 || X64_64".
> > * Remove extra newline in Makefile changes.
> > * Drop author copyright line.
> >
> >  drivers/firmware/efi/Kconfig    |  5 +++++
> >  drivers/firmware/efi/Makefile   |  1 +
> >  drivers/firmware/efi/cper-x86.c | 23 +++++++++++++++++++++++
> 
> I'd prefer if that were:
> 
> drivers/firmware/efi/cper/x86.c
> drivers/firmware/efi/cper/arm.c
> 
> but that's Ard's call.
> 
> >  drivers/firmware/efi/cper.c     | 10 ++++++++++
> >  include/linux/cper.h            |  2 ++
> >  5 files changed, 41 insertions(+)
> >  create mode 100644 drivers/firmware/efi/cper-x86.c
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 3098410abad8..781a4a337557 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -174,6 +174,11 @@ config UEFI_CPER_ARM
> >  	depends on UEFI_CPER && ( ARM || ARM64 )
> >  	default y
> >
> > +config UEFI_CPER_X86
> > +	bool
> > +	depends on UEFI_CPER && X86
> > +	default y
> > +
> >  config EFI_DEV_PATH_PARSER
> >  	bool
> >  	depends on ACPI
> > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> > index cb805374f4bc..5f9f5039de50 100644
> > --- a/drivers/firmware/efi/Makefile
> > +++ b/drivers/firmware/efi/Makefile
> > @@ -31,3 +31,4 @@ obj-$(CONFIG_ARM)			+= $(arm-obj-
> y)
> >  obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
> >  obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
> >  obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
> > +obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
> x86.c
> > new file mode 100644
> > index 000000000000..863f0cd2a0ff
> > --- /dev/null
> > +++ b/drivers/firmware/efi/cper-x86.c
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018, Advanced Micro Devices, Inc.
> > +
> > +#include <linux/cper.h>
> > +
> > +/*
> > + * We don't need a "CPER_IA" prefix since these are all locally defined.
> > + * This will save us a lot of line space.
> > + */
> > +#define VALID_LAPIC_ID			BIT_ULL(0)
> > +#define VALID_CPUID_INFO		BIT_ULL(1)
> > +
> > +void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia
> *proc)
> > +{
> > +	if (proc->validation_bits & VALID_LAPIC_ID)
> > +		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
> > +
> > +	if (proc->validation_bits & VALID_CPUID_INFO) {
> > +		printk("%sCPUID Info:\n", pfx);
> > +		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc-
> >cpuid,
> > +			       sizeof(proc->cpuid), 0);
> 
> That's dumping 48 bytes of static information for every error!
> Information which can be dumped only once when collecting system info.
> 

Right, but here we just print the record as-is. We can do it different when
this hooks into the MCA decoding. And the use-case at the moment is for
BERT which shouldn't have very many errors.

Thanks,
Yazen
