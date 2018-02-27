Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbeB0Pdt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:33:49 -0500
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:32109
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753266AbeB0Pdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:33:47 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check
 structures
Thread-Topic: [PATCH v2 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check
 structures
Thread-Index: AQHTrzm0GBA0EHUlaEmx0Hbntxa59aO4WewAgAAHf2A=
Date: Tue, 27 Feb 2018 15:33:44 +0000
Message-ID: <DM5PR12MB1916C11E8B578EBA43CE2B82F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-6-Yazen.Ghannam@amd.com>
 <20180227150356.GH26382@pd.tnic>
In-Reply-To: <20180227150356.GH26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2582;7:zMfAU7uEXaRpz3OVZvjst2A6oaNaDvYGG3D/Of99ZzjL6l/E42Q++a5mPJkhP49IfBkGlHLhfzd7RZvMX2E7J9oscwZ3/Pusvjk4O84j6t4pDKzVNYZ5aiHs6/QHgOe3f9ebpyUwvZOCVQh1oxnjYultMrixPO9q+jA1kOMzve42tByFk0blvcZXT12juHZP6MID6VFi54IZyaLIOxDg87Xh/KQtsZh2D3QO+OM7hECNHN4UPSnxr8fGRDFje9Of;20:GuonwO248tjbT4f3DlniDAHSwJCtmVe2NdpQGI1fB/o1ka7qVGe7qXjf5l1wO37bCZq/VLaxkALzow8cndat/9qHxnBdmtRef1ur+mOBlFbfLhzk2nrZKRgjBwHqZ1AO8Yh2UHzmE7QKY5JblBarjFs6XOl//VBZihxOSI7AtLEAN7TZPqL3jHJSHG0aBwobyZekaScePgF8TPYY5qdiEBRX/UXEcch6aEddBenOSv/0s3z2b8GAgXJIhS9E/zP8
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8317d07e-4836-4c0f-a886-08d57df77d04
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB2582;
x-ms-traffictypediagnostic: DM5PR12MB2582:
x-microsoft-antispam-prvs: <DM5PR12MB2582205A3B7BB26823C883D0F8C00@DM5PR12MB2582.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB2582;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2582;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39380400002)(39860400002)(189003)(199004)(13464003)(2950100002)(6916009)(7736002)(97736004)(2906002)(14454004)(478600001)(25786009)(229853002)(74316002)(5660300001)(2900100001)(6436002)(4326008)(7696005)(305945005)(72206003)(102836004)(551934003)(5250100002)(59450400001)(6506007)(106356001)(53546011)(33656002)(105586002)(3660700001)(8936002)(3846002)(6246003)(6116002)(66066001)(99286004)(8676002)(76176011)(3280700002)(68736007)(316002)(55016002)(81166006)(81156014)(54906003)(26005)(53936002)(9686003)(86362001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2582;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OFgqkGgbPrvkD6VbmdRwqLHcodF/YJx18OVbPI/o22fRs3WfRjdkM9Q9KBnx4w5ju59eKwTMWq5JjWzM8GhY7elb/cBOwq1cLJLZy93shzn5p+lRWo9OwS2fnLDc51IYvsr9Exl5glboGGXOv34Gnw6MolVxPpK+/7abiGd2HZ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8317d07e-4836-4c0f-a886-08d57df77d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 15:33:44.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RFY4eJ015720

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 10:04 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check
> structures
> 
> On Mon, Feb 26, 2018 at 01:39:01PM -0600, Yazen Ghannam wrote:
> > +static void print_err_info(const char *pfx, u8 err_type, u64 check)
> > +{
> > +	u16 validation_bits = CHECK_VALID_BITS(check);
> > +
> > +	printk("%sValidation Bits: 0x%04x\n", pfx, validation_bits);
> > +
> > +	if (err_type == ERR_TYPE_MS)
> > +		return;
> > +
> > +	if (validation_bits & CHECK_VALID_TRANS_TYPE) {
> > +		u8 trans_type = CHECK_TRANS_TYPE(check);
> > +
> > +		printk("%sTransaction Type: %u, %s\n", pfx, trans_type,
> > +		       trans_type < ARRAY_SIZE(ia_check_trans_type_strs) ?
> > +		       ia_check_trans_type_strs[trans_type] : "unknown");
> > +	}
> > +
> > +	if (validation_bits & CHECK_VALID_OPERATION) {
> > +		u8 op = CHECK_OPERATION(check);
> > +
> > +		/*
> > +		 * CACHE has more operation types than TLB or BUS, though
> the
> > +		 * name and the order are the same.
> > +		 */
> > +		u8 max_ops = (err_type == ERR_TYPE_CACHE) ? 9 : 7;
> > +
> > +		printk("%sOperation: %u, %s\n", pfx, op,
> > +		       op < max_ops ? ia_check_op_strs[op] : "unknown");
> > +	}
> > +
> > +	if (validation_bits & CHECK_VALID_LEVEL)
> > +		printk("%sLevel: %llu\n", pfx, CHECK_LEVEL(check));
> > +
> > +	if (validation_bits & CHECK_VALID_PCC)
> > +		print_bool("Processor Context Corrupt", pfx, check,
> CHECK_PCC);
> 
> I think we want to print PCC here unconditionally and say:
> 
> 	PCC: (yes|no|invalid)
> 
> I don't think the absence of PCC in the error record is a good enough
> hint that the PCC field is invalid.
> 
> Ditto for the rest and transaction type above too. I think it would be
> much easier if we have fixed fields error record.
> 

I agree which is why I've included the Validation Bits. A user can then
check the Validation Bits for any field that is of interest but missing.

Thanks,
Yazen
