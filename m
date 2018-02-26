Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeBZQAQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:00:16 -0500
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:5664
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751848AbeBZQAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:00:14 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH 3/8] efi: Decode IA32/X64 Processor Error Info Structure
Thread-Topic: [PATCH 3/8] efi: Decode IA32/X64 Processor Error Info Structure
Thread-Index: AQHTrOG01QooXLU6EkCK9DjYhZ89/qOzwoCAgAMYWWA=
Date: Mon, 26 Feb 2018 16:00:12 +0000
Message-ID: <DM5PR12MB191622BDE62D8C4F1031C015F8C10@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
 <20180223200333.6410-4-Yazen.Ghannam@amd.com>
 <CAKv+Gu_18==LT3eGPJh9Lveq_CWXwveBD4EYnTWvT7FbTtM_jg@mail.gmail.com>
In-Reply-To: <CAKv+Gu_18==LT3eGPJh9Lveq_CWXwveBD4EYnTWvT7FbTtM_jg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1884;7:/xnBjrVJJ9gBwAerIaHxgif96rvhvr7PD1CV2rBpktO37WjASWND2WdG2yfgryHlTUX8bLGZWyIU4NA8o1ORbNPyV6nPFxMflDfzlYrsapY7aJksf8ceZV410i7kG4dC2FmAyrCxwjjIVABVgTKkMXgv8gY/5i7LXGXBcNisFpMZKi0lRZ/7rKt4ZR8/oFpuH2JM21wrC3ehnT/U/uNKFaAgcOFcyAPTGsTKyNmAiyud2R6WGIWeq+1kjFtKu0w9;20:zJY0BiL0aVHx8Jg+DvUk2nJwhVDX8DN6mvdsUB4F4CCYBXMsfIueUzUTkN032/b7V6uuDy+t9TQ5M5MERnl9iZeO1DYJjJvF7iDh2yJTTNgPV+zq9CWiUkbbMgJQVQjzQb/Y4cMi/+RtGknKhd7Hvm2y8GJGVCCZlrvvhOxfmqjR+npt/K/TN5748YhL/jnjYrYcNR+pb8wl8Whax7KPhJEwGQFY3kZbjmkdjZIhwNqsxDlhnTelkJpsjDQEI539
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9290d9ac-f09d-4861-1e77-08d57d32051f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1884;
x-ms-traffictypediagnostic: DM5PR12MB1884:
x-microsoft-antispam-prvs: <DM5PR12MB18848C52DE10AA5D225A24F2F8C10@DM5PR12MB1884.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1884;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1884;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(366004)(376002)(396003)(13464003)(199004)(189003)(6506007)(81166006)(81156014)(105586002)(229853002)(5250100002)(26005)(53546011)(3280700002)(4326008)(3846002)(186003)(6116002)(66066001)(106356001)(76176011)(99286004)(86362001)(305945005)(5660300001)(74316002)(97736004)(7736002)(7696005)(102836004)(8676002)(9686003)(55016002)(53936002)(316002)(2950100002)(6916009)(6246003)(6436002)(25786009)(2900100001)(72206003)(33656002)(54906003)(3660700001)(2906002)(68736007)(8936002)(478600001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1884;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Jb9DX49zLM9OM/CRPcN1ZYvQsJnzIeBQKWTezZR2tXBUToObcPz44oV0ENgY+flYFmnQ+TWpa9cCMxpBdFGy3v8zuS7Q6nCbMi1zSQ5OdAEGJDIIiVSl4Jn9xIhLsIU6hSwVkJV7V4v1qnP/eq3yYAL+HAWxDXlqne2j7+DeUYg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9290d9ac-f09d-4861-1e77-08d57d32051f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 16:00:12.9618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QG0TY8000731

> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> Sent: Saturday, February 24, 2018 11:40 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Borislav Petkov <bp@suse.de>; the arch/x86
> maintainers <x86@kernel.org>
> Subject: Re: [PATCH 3/8] efi: Decode IA32/X64 Processor Error Info Structure
> 
...
> >
> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
> x86.c
> > index b50ee3cdf637..9d608f742c98 100644
> > --- a/drivers/firmware/efi/cper-x86.c
> > +++ b/drivers/firmware/efi/cper-x86.c
> > @@ -4,15 +4,28 @@
> >
> >  #include <linux/cper.h>
> >
> > +#define INDENT_SP      " "
> > +
> >  /*
> >   * We don't need a "CPER_IA" prefix since these are all locally defined.
> >   * This will save us a lot of line space.
> >   */
> >  #define VALID_LAPIC_ID                 BIT_ULL(0)
> >  #define VALID_CPUID_INFO               BIT_ULL(1)
> > +#define VALID_PROC_ERR_INFO_NUM(bits)  ((bits & GENMASK_ULL(7, 2))
> >> 2)
> > +
> 
> Parens around 'bits' please
> 

Like this?

#define VALID_PROC_ERR_INFO_NUM(bits)  (((bits) & GENMASK_ULL(7, 2)) >> 2)

I'll do the same for the others.

> > +#define INFO_VALID_CHECK_INFO          BIT_ULL(0)
> > +#define INFO_VALID_TARGET_ID           BIT_ULL(1)
> > +#define INFO_VALID_REQUESTOR_ID                BIT_ULL(2)
> > +#define INFO_VALID_RESPONDER_ID                BIT_ULL(3)
> > +#define INFO_VALID_IP                  BIT_ULL(4)
> >
> >  void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia
> *proc)
> >  {
> > +       int i;
> > +       struct cper_ia_err_info *err_info;
> > +       char newpfx[64];
> > +
> >         printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
> >
> >         if (proc->validation_bits & VALID_LAPIC_ID)
> > @@ -23,4 +36,44 @@ void cper_print_proc_ia(const char *pfx, const struct
> cper_sec_proc_ia *proc)
> >                 print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc-
> >cpuid,
> >                                sizeof(proc->cpuid), 0);
> >         }
> > +
> > +       snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
> > +
> > +       err_info = (struct cper_ia_err_info *)(proc + 1);
> > +       for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++)
> {
> > +               printk("%sError Information Structure %d:\n", pfx, i);
> > +
> > +               printk("%sError Structure Type: %pUl\n", newpfx,
> > +                        &err_info->err_type);
> > +
> 
> The indentation is a bit awkward here. Could you please align followup
> lines with the character following the ( on the first line?
> 

Yes, will do.

> > +               printk("%sValidation Bits: 0x%016llx\n",
> > +                        newpfx, err_info->validation_bits);
> > +
> > +               if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
> > +                       printk("%sCheck Information: 0x%016llx\n", newpfx,
> > +                                err_info->check_info);
> > +               }
> > +
> > +               if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
> > +                       printk("%sTarget Identifier: 0x%016llx\n",
> > +                                newpfx, err_info->target_id);
> > +               }
> > +
> > +               if (err_info->validation_bits & INFO_VALID_REQUESTOR_ID) {
> > +                       printk("%sRequestor Identifier: 0x%016llx\n",
> > +                                newpfx, err_info->requestor_id);
> > +               }
> > +
> > +               if (err_info->validation_bits & INFO_VALID_RESPONDER_ID) {
> > +                       printk("%sResponder Identifier: 0x%016llx\n",
> > +                                newpfx, err_info->responder_id);
> > +               }
> > +
> > +               if (err_info->validation_bits & INFO_VALID_IP) {
> > +                       printk("%sInstruction Pointer: 0x%016llx\n",
> > +                                newpfx, err_info->ip);
> > +               }
> > +
> > +               err_info++;
> > +       }
> >  }
> > --
> > 2.14.1
> >
