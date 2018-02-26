Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeBZQFJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:05:09 -0500
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:43982
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752054AbeBZQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:05:07 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH 8/8] efi: Decode IA32/X64 Context Info structure
Thread-Topic: [PATCH 8/8] efi: Decode IA32/X64 Context Info structure
Thread-Index: AQHTrOGCZl/l9e8fg0uWGZbUn2eLzaOzw/8AgAMYhjA=
Date: Mon, 26 Feb 2018 16:05:00 +0000
Message-ID: <DM5PR12MB1916F87127E0C2EF6F042247F8C10@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
 <20180223200333.6410-9-Yazen.Ghannam@amd.com>
 <CAKv+Gu_kwJTxsmmQSAMKgSmK6w_-BhqBTnv3Sqv-K1TCYq4X-Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu_kwJTxsmmQSAMKgSmK6w_-BhqBTnv3Sqv-K1TCYq4X-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2406;20:8M6tOqDPh/2I7PrrIq+oAgjWG8Zu+XkNL+HA6wIVuPDig9dNn+2wWtjEW1Htw4Vz3W8QrmajhKCg7GAQUD2SmHqoiKpqYaMdYfO3xzDTdAR3e8gP36BvPChnriJtKY2v3mWcaxhQaqj1RHWngpAJc6qW8odHVPjGbf26/9eHHXbd+jfu8vEPEMVyvOD+YW/VcqVpRlW9Ri9/xyXsmEefVj6H0AwfB8+1kSemXGzmePmix3ANSWI2JhAjQFTtO/vy
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12fa6cbd-54ef-41f5-5b62-08d57d32b06e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB2406;
x-ms-traffictypediagnostic: DM5PR12MB2406:
x-microsoft-antispam-prvs: <DM5PR12MB24063BEB0C5248EDF630CA7BF8C10@DM5PR12MB2406.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB2406;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2406;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39380400002)(366004)(39860400002)(13464003)(199004)(189003)(26005)(55016002)(106356001)(478600001)(53936002)(86362001)(575784001)(2906002)(14454004)(6436002)(5250100002)(105586002)(9686003)(68736007)(186003)(66066001)(2900100001)(316002)(6246003)(25786009)(6506007)(229853002)(6116002)(3846002)(33656002)(7736002)(2950100002)(6916009)(99286004)(74316002)(53546011)(102836004)(76176011)(7696005)(54906003)(97736004)(8936002)(72206003)(305945005)(3280700002)(81156014)(4326008)(81166006)(8676002)(5660300001)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2406;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8Vix94IF4v1l3kH27esAksU5FmaEsbzZyjGUrRxO7m3r597o+wShAMOrEy8g4uS5SChIHLKgDzSZmXpYfuH0kVgFg+Gje8CtR3r+5WvA7qj3THHA+2H88up8HzCK51gzIIK7aEFqn8SqnoJsLolYiA1IO6h+Rj1T6qWkdbrtr1I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fa6cbd-54ef-41f5-5b62-08d57d32b06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 16:05:00.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2406
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QG5JxL002566

> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> Sent: Saturday, February 24, 2018 11:46 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Borislav Petkov <bp@suse.de>; the arch/x86
> maintainers <x86@kernel.org>
> Subject: Re: [PATCH 8/8] efi: Decode IA32/X64 Context Info structure
> 
> On 23 February 2018 at 20:03, Yazen Ghannam
> <Yazen.Ghannam@amd.com> wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Print the fields of the IA32/X64 Context Information structure.
> >
> > Print the "Register Array" as raw values. Some context types are defined
> > in the UEFI spec, so more detailed decoded may be added in the future.
> >
> > Based on UEFI 2.7 section N.2.4.2.2 IA32/X64 Processor Context
> > Information Structure.
> >
> > Cc: <stable@vger.kernel.org> # 4.16.x
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  drivers/firmware/efi/cper-x86.c | 55
> +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
> x86.c
> > index 02b1b424f537..bb6cef0b5e53 100644
> > --- a/drivers/firmware/efi/cper-x86.c
> > +++ b/drivers/firmware/efi/cper-x86.c
> > @@ -13,6 +13,7 @@
> >  #define VALID_LAPIC_ID                 BIT_ULL(0)
> >  #define VALID_CPUID_INFO               BIT_ULL(1)
> >  #define VALID_PROC_ERR_INFO_NUM(bits)  ((bits & GENMASK_ULL(7, 2))
> >> 2)
> > +#define VALID_PROC_CNXT_INFO_NUM(bits) ((bits & GENMASK_ULL(13,
> 8)) >> 8)
> 
> Parens
> 
> Also, CNXT isn't really idiomatic when abbreviating 'context' (and you
> use CTX below as well)
> 

The UEFI spec uses PROC_CONTEXT_INFO_NUM. 

Would you prefer 1 or 2 below?
1) VALID_PROC_CONTEXT_INFO_NUM
2) VALID_PROC_CTX_INFO_NUM

Thanks,
Yazen
