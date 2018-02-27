Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeB0PNk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:13:40 -0500
Received: from mail-bl2nam02on0062.outbound.protection.outlook.com ([104.47.38.62]:33578
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753292AbeB0PNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:13:36 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Topic: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Index: AQHTrzm1EGCswNxnok6qbkQSpXWbnqO4HBMAgAA+gSA=
Date: Tue, 27 Feb 2018 15:13:11 +0000
Message-ID: <DM5PR12MB1916B6AEE434A345E78BE234F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-3-Yazen.Ghannam@amd.com>
 <20180227112234.GE26382@pd.tnic>
In-Reply-To: <20180227112234.GE26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1721;7:UQL2nk2d9qm8+c8AtRZjAx/LU+irlfoU8yMFNwdXbt4JHybQJPa0X1a+7PlLpQzWASK70JuW8jctJCa7jSlfY1erzzcE/+hG4mghYqsJVUPU9GlGqXA/M12V8n6hoJjDqBmUeU9Emcq/W9eQuLbn/P19fayTdIny8NAgf1TEjD03UWJZHol5PQHFBjRU0p13c6PSUFCXD0+ndRV9PlOjkhPZ4wS+6mMpkoJPywKER/Ya5lqjvPIgBHzTQ97m7nxO;20:zFUP7LTVQfdYOFwxMCewMS01QvoBozH02HFkP7igTGJV/kiNMvx4W8kzY+w5HOtHFblxpvNNs3yPJRVNm/FkJ8wtDY5F2+2V/K0IRKjoXGC1R7x1vSjucvi5sqtuAcaIzWjE5mg5S0OrzxO+BIHT2ONJnqpZuyETdtoTUpk9NBrxgQ8VNZGK73m7QTvYDxJAHQEqphEdxaRKtIQrPKTERFS7WgWdUyAcl5lt3FLFVBh5YjhRCZHXnW3X61GSzZx3
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3543a3c0-a591-4859-5403-08d57df49d9e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1721;
x-ms-traffictypediagnostic: DM5PR12MB1721:
x-microsoft-antispam-prvs: <DM5PR12MB1721E579C030154D58C18571F8C00@DM5PR12MB1721.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501161)(52105095)(3002001)(10201501046)(6055026)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(396003)(346002)(366004)(13464003)(189003)(199004)(68736007)(14454004)(81156014)(99286004)(106356001)(2906002)(3660700001)(76176011)(81166006)(3846002)(3280700002)(6116002)(8676002)(8936002)(6916009)(66066001)(7696005)(186003)(105586002)(5250100002)(26005)(5660300001)(305945005)(316002)(7736002)(74316002)(54906003)(2950100002)(72206003)(33656002)(97736004)(229853002)(86362001)(25786009)(6436002)(9686003)(55016002)(102836004)(53936002)(478600001)(4326008)(2900100001)(53546011)(6246003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 0JNHaOH/HPYVAsiNKC9srulbHWTO/dpR0hjF3DcBNrr8hYALreizvRrxMr7GrtlD69Y7GdeuVbEz09o9TgYGiYYozq2Bp+VcArvtaChx5QlzC1Z5gmxHKMqB46dXAYVZXRV4z3sTkoz4POtGVttm6pkqO9PV1jv5gIxB3nKQi0w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3543a3c0-a591-4859-5403-08d57df49d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 15:13:11.1122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RFF5Ir009138

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 6:23 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
> 
> On Mon, Feb 26, 2018 at 01:38:58PM -0600, Yazen Ghannam wrote:
> > + * We don't need a "CPER_IA" prefix since these are all locally defined.
> > + * This will save us a lot of line space.
> > + */
> > +#define VALID_LAPIC_ID			BIT_ULL(0)
> > +#define VALID_CPUID_INFO		BIT_ULL(1)
> > +
> > +void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia
> *proc)
> > +{
> > +	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
> 
> Ok, so this...
> 
> > +
> > +	if (proc->validation_bits & VALID_LAPIC_ID)
> > +		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
> > +
> > +	if (proc->validation_bits & VALID_CPUID_INFO) {
> > +		printk("%sCPUID Info:\n", pfx);
> > +		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc-
> >cpuid,
> > +			       sizeof(proc->cpuid), 0);
> 
> ... and this are semi-decoded information bits which I'd have to go open
> the spec and continue decoding.
> 
> Can we please change the whole approach of not simply dumping such
> fields but decode them fully. We want that error information to be
> helpful to the user and she should be able to immediately understand
> what type of error it is.
> 
> Validation Bits and a CPUID hexdump simply makes you go look at the spec
> again and such dumps are only useful as a debugging aid but nothing
> more.
> 
> The APIC ID dump is how this should be done - properly and fully decoded
> error info which can be used immediately for diagnosing the error.
> 

I decided to print the Validation Bits as a sanity check for whomever is looking
at this. Since we only print fields with a valid bit, it may be confusing for users
who don't know why fields are missing. They can check the Validation Bits to see
that the fields printed have a valid bit set and those not printed don't have valid
bits set.

Also, I don't think we should be interpreting the spec for the user. We should
print the fields as they and users can refer back to the spec for more information.

The more detailed info about the error is printed later. Even just printing the fields
at that point should be enough for most users.

Thanks,
Yazen
