Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeBZP4E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:56:04 -0500
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:35776
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751908AbeBZP4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:56:02 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Topic: [PATCH 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Index: AQHTrOG3PIo4V0EfjUqEu1qvc8lwWqOzwh6AgAMWjwA=
Date: Mon, 26 Feb 2018 15:55:59 +0000
Message-ID: <DM5PR12MB19162BF302938727F04FA470F8C10@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
 <20180223200333.6410-3-Yazen.Ghannam@amd.com>
 <CAKv+Gu8ShPeJz0HsqR=8GSjj+PyC=sVJv_MhidVR6cU4W-WjLA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8ShPeJz0HsqR=8GSjj+PyC=sVJv_MhidVR6cU4W-WjLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1561;7:eaKmoD+X3ZPPWo8ad2zcKW3doDeLdvC8fSg/ZymZy2AkKBXhbitK1vC0ELDCWFC52J5PrLd9Cz5uFHe2aRAXAxz+Q1lGna9wfdkixxpMMc9W37H4FIf9AK7Ai+OBFUDC03Jg7FZpWtkRvJN8Nefoy4u/Xlh0iksh/AkUiYNk6Cz8fuxKd53U9daDTGIHpB9cLy72hQQ2nKtmdo70duck37w9kxJERRPYhLycTeOy1DbvLN3pBRUQ57Xna12JD3ZM;20:DC0tLPvL1Cbmm5TgqXwk2fIACJ13A40/z+LAeSkz/mM0eYOLgD3P1Xjtis/zSIfZkqaVO5EdNABaoiICQN865EZPlOpdvFvYxmbyJOG6cfaxuQImRJ7qMD1FNzyFzb2HB60hsALmqTuHX9goHOgoYLymQNGqCXZ7PpccHsL8wy8uarAwdB18pSAoNU+un8iNoJwvsnzCeGMyNNj3lBne9ho4A2MycEBDRFwEypYOdH7tiI7tp8ys0SvwZ2QezEJZ
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cb29596-d8fd-4baf-9ef1-08d57d316e24
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1561;
x-ms-traffictypediagnostic: DM5PR12MB1561:
x-microsoft-antispam-prvs: <DM5PR12MB15619AB912BAB41C6E006862F8C10@DM5PR12MB1561.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1561;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1561;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(13464003)(7696005)(478600001)(3846002)(55016002)(26005)(8936002)(186003)(72206003)(14454004)(102836004)(86362001)(575784001)(6116002)(6506007)(4326008)(81166006)(8676002)(3660700001)(97736004)(81156014)(66066001)(6436002)(2900100001)(33656002)(3280700002)(53546011)(25786009)(2906002)(53936002)(6916009)(5250100002)(54906003)(74316002)(316002)(2950100002)(229853002)(6246003)(99286004)(7736002)(305945005)(9686003)(5660300001)(76176011)(105586002)(106356001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1561;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qmQRpithytlTz27lcvCT6ezjPtMAcR9ZztSqh0N53ZtKt5g6KVxn+c52JeyOXr2AqgWxidlFJBIhi6Hk3djbxgP07cNpXnp1Y11zuqqEMyYlyzK2CP3cMkCY1ODtukgkTzlx8GXt0i6txQnFJu5M6SK2qj32bPg3CbiTWDlsV34=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb29596-d8fd-4baf-9ef1-08d57d316e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 15:55:59.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1561
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QFuASi031444

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Ard Biesheuvel
> Sent: Saturday, February 24, 2018 11:39 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Borislav Petkov <bp@suse.de>; the arch/x86
> maintainers <x86@kernel.org>
> Subject: Re: [PATCH 2/8] efi: Decode IA32/X64 Processor Error Section
> 
...
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 3098410abad8..8b684147835d 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -174,6 +174,11 @@ config UEFI_CPER_ARM
> >         depends on UEFI_CPER && ( ARM || ARM64 )
> >         default y
> >
> > +config UEFI_CPER_X86
> > +       bool
> > +       depends on UEFI_CPER && ( X86_32 || X86_64 )
> 
> Just 'UEFI_CPER && X86' should be sufficient, no?
> 

Yes.

> > +       default y
> > +
> >  config EFI_DEV_PATH_PARSER
> >         bool
> >         depends on ACPI
> > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> > index cb805374f4bc..7cf8d75ebe51 100644
> > --- a/drivers/firmware/efi/Makefile
> > +++ b/drivers/firmware/efi/Makefile
> > @@ -31,3 +31,5 @@ obj-$(CONFIG_ARM)                     += $(arm-obj-y)
> >  obj-$(CONFIG_ARM64)                    += $(arm-obj-y)
> >  obj-$(CONFIG_EFI_CAPSULE_LOADER)       += capsule-loader.o
> >  obj-$(CONFIG_UEFI_CPER_ARM)            += cper-arm.o
> > +
> 
> Spurious newline
> 

Okay.

> > +obj-$(CONFIG_UEFI_CPER_X86)            += cper-x86.o
> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
> x86.c
> > new file mode 100644
> > index 000000000000..b50ee3cdf637
> > --- /dev/null
> > +++ b/drivers/firmware/efi/cper-x86.c
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018, Advanced Micro Devices, Inc.
> > +// Copyright (C) 2018, Yazen Ghannam <yazen.ghannam@amd.com>
> > +
> 
> Do you really own the copyright for code that you write on behalf of
> your employer?
> 

I'll drop that line.

> > +#include <linux/cper.h>
> > +
> > +/*
> > + * We don't need a "CPER_IA" prefix since these are all locally defined.
> > + * This will save us a lot of line space.
> > + */
> > +#define VALID_LAPIC_ID                 BIT_ULL(0)
> > +#define VALID_CPUID_INFO               BIT_ULL(1)
> > +
> > +void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia
> *proc)
> > +{
> > +       printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
> > +
> > +       if (proc->validation_bits & VALID_LAPIC_ID)
> > +               printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
> > +
> > +       if (proc->validation_bits & VALID_CPUID_INFO) {
> > +               printk("%sCPUID Info:\n", pfx);
> > +               print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc-
> >cpuid,
> > +                              sizeof(proc->cpuid), 0);
> > +       }
> > +}
> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > index c165933ebf38..5a59b582c9aa 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -469,6 +469,16 @@ cper_estatus_print_section(const char *pfx, struct
> acpi_hest_generic_data *gdata
> >                         cper_print_proc_arm(newpfx, arm_err);
> >                 else
> >                         goto err_section_too_small;
> > +#endif
> > +#if defined(CONFIG_UEFI_CPER_X86)
> > +       } else if (guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
> > +               struct cper_sec_proc_ia *ia_err = acpi_hest_get_payload(gdata);
> > +
> > +               printk("%ssection_type: IA32/X64 processor error\n", newpfx);
> > +               if (gdata->error_data_length >= sizeof(*ia_err))
> > +                       cper_print_proc_ia(newpfx, ia_err);
> > +               else
> > +                       goto err_section_too_small;
> >  #endif
> >         } else {
> >                 const void *err = acpi_hest_get_payload(gdata);
> > diff --git a/include/linux/cper.h b/include/linux/cper.h
> > index 4b5f8459b403..9c703a0abe6e 100644
> > --- a/include/linux/cper.h
> > +++ b/include/linux/cper.h
> > @@ -551,5 +551,7 @@ const char *cper_mem_err_unpack(struct
> trace_seq *,
> >                                 struct cper_mem_err_compact *);
> >  void cper_print_proc_arm(const char *pfx,
> >                          const struct cper_sec_proc_arm *proc);
> > +void cper_print_proc_ia(const char *pfx,
> > +                       const struct cper_sec_proc_ia *proc);
> >
> >  #endif
> > --
> > 2.14.1
> >
