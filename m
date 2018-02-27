Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeB0PZL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:25:11 -0500
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:56544
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753220AbeB0PZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:25:08 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Thread-Topic: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Thread-Index: AQHTrzm07vsANP0WAkKVOn1mh2z8gqO4TzGAgAANYEA=
Date: Tue, 27 Feb 2018 15:25:06 +0000
Message-ID: <DM5PR12MB191637C1857C5D9499D08D66F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-4-Yazen.Ghannam@amd.com>
 <20180227142531.GF26382@pd.tnic>
In-Reply-To: <20180227142531.GF26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2408;7:aoaK29p9ER0WCnn6Em1uBGrFEtlncZ3nB6KjfclH2W1063ZKB5r/Qzvwdy6DN89AobX0cVXuFU8qUOIfcF4kHNVVmWd6e/pIoR9nmMKSQ9GRQFHqKnlbh6XcKvehTcX8emGrC52Guqlm1lUHst2gPVyS7YOMp0Nv9oUq+21g0xDV8sYNNceFGAizONquX9hyXaEnqFyL0LCVu5oxfiW2YLvkCaJgS91tgeFGRIvFGIDRFM1zqkHn2zT+82xbcxtd;20:kjMNKIdhky2yJG3XHPO6kL+qmeavShh+BUKs4gTsiMxSd0XoK7zbGzbi6Q6WhwL420GIW0fPLrGFAaBCMhqHcFM2cbypRj3R4Oa+enCdMVuYWjgdDSKwbdNK+9ddhukx72jmlqt2IGFzdSXGEzI9swC0IEMa+2QyASzty3QjP5EC3Kf5bZN3knhYUgnIHwV7nJzTreAEoPXST5Q/5lZYNbPUiPOt0LTH25HPX6w6f2gcl+QnF/eocX8T0y2i6ZeA
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee0110e5-b408-48bf-1ca3-08d57df64830
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB2408;
x-ms-traffictypediagnostic: DM5PR12MB2408:
x-microsoft-antispam-prvs: <DM5PR12MB24083F73028E4FA6FF9BA909F8C00@DM5PR12MB2408.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB2408;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2408;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(39380400002)(376002)(189003)(199004)(13464003)(6436002)(186003)(54906003)(53936002)(5660300001)(7696005)(575784001)(8936002)(2950100002)(25786009)(2900100001)(6916009)(14454004)(81156014)(81166006)(966005)(86362001)(26005)(316002)(72206003)(8676002)(6246003)(229853002)(33656002)(68736007)(3846002)(6116002)(3660700001)(74316002)(2906002)(76176011)(4326008)(5250100002)(106356001)(66066001)(3280700002)(105586002)(478600001)(6506007)(55016002)(53546011)(99286004)(6306002)(102836004)(305945005)(97736004)(9686003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2408;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: T5UaebjC2VRZ4tTRGetj256flTscYF6fEFFddHY13mbXz94D2k1h5PL1Licl1qvcA7NLljvSTfjZWZ1uJKq28tmI72GDZWPZUXSGbB1y2M+mMKHDyEZsMv801+sXfJTNV0Fkwz1VlyUwiH4DAf93+mw6R5uxWI9h2dT2C4xVxNs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0110e5-b408-48bf-1ca3-08d57df64830
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 15:25:06.7926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2408
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RFPH5k012175

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 9:26 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info
> Structure
> 
> On Mon, Feb 26, 2018 at 01:38:59PM -0600, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Print the fields in the IA32/X64 Processor Error Info Structure.
> >
> > Based on UEFI 2.7 Table 256. IA32/X64 Processor Error Information
> > Structure.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > Link:
> > https://lkml.kernel.org/r/20180223200333.6410-4-
> Yazen.Ghannam@amd.com
> >
> > v1->v2:
> > * Add parantheses around "bits" expression in macro.
> > * Fix indentation on multi-line statements.
> >
> >  drivers/firmware/efi/cper-x86.c | 53
> +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
> x86.c
> > index 9da0d981178f..417bd4e500a7 100644
> > --- a/drivers/firmware/efi/cper-x86.c
> > +++ b/drivers/firmware/efi/cper-x86.c
> > @@ -3,15 +3,28 @@
> >
> >  #include <linux/cper.h>
> >
> > +#define INDENT_SP	" "
> 
> That's just silly.
> 

This is the same as the other CPER code.

> > +
> >  /*
> >   * We don't need a "CPER_IA" prefix since these are all locally defined.
> >   * This will save us a lot of line space.
> >   */
> >  #define VALID_LAPIC_ID			BIT_ULL(0)
> >  #define VALID_CPUID_INFO		BIT_ULL(1)
> > +#define VALID_PROC_ERR_INFO_NUM(bits)	(((bits) & GENMASK_ULL(7,
> 2)) >> 2)
> > +
> > +#define INFO_VALID_CHECK_INFO		BIT_ULL(0)
> > +#define INFO_VALID_TARGET_ID		BIT_ULL(1)
> > +#define INFO_VALID_REQUESTOR_ID		BIT_ULL(2)
> > +#define INFO_VALID_RESPONDER_ID		BIT_ULL(3)
> > +#define INFO_VALID_IP			BIT_ULL(4)
> >
> >  void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia
> *proc)
> >  {
> > +	int i;
> > +	struct cper_ia_err_info *err_info;
> > +	char newpfx[64];
> > +
> >  	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
> >
> >  	if (proc->validation_bits & VALID_LAPIC_ID)
> > @@ -22,4 +35,44 @@ void cper_print_proc_ia(const char *pfx, const struct
> cper_sec_proc_ia *proc)
> >  		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc-
> >cpuid,
> >  			       sizeof(proc->cpuid), 0);
> >  	}
> > +
> > +	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
> > +
> > +	err_info = (struct cper_ia_err_info *)(proc + 1);
> > +	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits);
> i++) {
> > +		printk("%sError Information Structure %d:\n", pfx, i);
> > +
> > +		printk("%sError Structure Type: %pUl\n", newpfx,
> > +		       &err_info->err_type);
> 
> That dumps a GUID - how do I find out what type that GUID refers to?
> 

A later patch prints out the spec-defined type.

Also, the spec allows platform-defined GUIDs. So we should always print this
even if the GUID is not defined by the spec.

> > +
> > +		printk("%sValidation Bits: 0x%016llx\n",
> > +		       newpfx, err_info->validation_bits);
> 
> As before, no need for those.
> 
> > +
> > +		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
> > +			printk("%sCheck Information: 0x%016llx\n", newpfx,
> > +			       err_info->check_info);
> > +		}
> > +
> > +		if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
> > +			printk("%sTarget Identifier: 0x%016llx\n",
> > +			       newpfx, err_info->target_id);
> > +		}
> > +
> > +		if (err_info->validation_bits & INFO_VALID_REQUESTOR_ID) {
> > +			printk("%sRequestor Identifier: 0x%016llx\n",
> > +			       newpfx, err_info->requestor_id);
> > +		}
> > +
> > +		if (err_info->validation_bits & INFO_VALID_RESPONDER_ID) {
> > +			printk("%sResponder Identifier: 0x%016llx\n",
> > +			       newpfx, err_info->responder_id);
> > +		}
> 
> Those look like would need an additional decoding. Can we do that here
> too?
> 

The Check Information will be decoded further in another patch.

I don't think there's much else to decode for the ID fields.

> > +
> > +		if (err_info->validation_bits & INFO_VALID_IP) {
> > +			printk("%sInstruction Pointer: 0x%016llx\n",
> > +			       newpfx, err_info->ip);
> 
> The only thing that makes sense so far.
> 
> > +		}
> > +
> > +		err_info++;
> > +	}
> 
> Also, it is worth checking how much duplication there is with
> drivers/firmware/efi/cper-arm.c and unifying the common pieces into
> functions in cper-common.c or so.
> 

Other tables may have the same fields but the offsets are usually different.
So it may be more trouble than it's worth trying to unify the different tables.

Thanks,
Yazen 
