Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeB0SGZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:06:25 -0500
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:50976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbeB0SGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:06:24 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Topic: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Index: AQHTrzm1EGCswNxnok6qbkQSpXWbnqO4HBMAgAA+gSCAAB/wgIAAAzCggAAJKACAAAG4MA==
Date: Tue, 27 Feb 2018 18:06:21 +0000
Message-ID: <DM5PR12MB1916C280DA5B51FE9666EE21F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-3-Yazen.Ghannam@amd.com>
 <20180227112234.GE26382@pd.tnic>
 <DM5PR12MB1916B6AEE434A345E78BE234F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227170034.GJ26382@pd.tnic>
 <DM5PR12MB1916F8C7DF93C1C9402AE3ECF8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227174446.GN26382@pd.tnic>
In-Reply-To: <20180227174446.GN26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1514;7:LxTBEey77u7kh/H24n2tesjtTRwH4TBl6pM0unpVUWKVh0QBCXBDo6Rt/2gI3g1gI0KwJq9Rj5Qa6QDqJ6x2lRLDTeToj1nuoDm7smUeBA5tVEVHdze5wn6LLq6NFvZX/OlAQSe6lqMAbc35c7GIQS1jAvApm4RLQYSBeyyAhTXSKAwX2NO/RL9qCCU4uoxDag8XntVkkCoSNxbBIxgCA6mND/tkGTOOWzPQaOLie4sHNqmVWER7+7oW8ujNhxap;20:8ieYKxL4w9O+OH1o4Bi2H/Sjb5P6mLKcMgETHPJj94Qd/acg7pB0jmuzrr9ktZtmGSA2GW08n9xd1sXYsnoZdGrtL4Ruwmaae8lwkFwyB79Yf9K/CGjXSagZwrvwfZa8YiFzq/zcwUw4miYkx5WfFpIr7IMUelAUDx2mW6gTFOPuq3INth7oCtpbWsa7tLgHl2MCmPcvGHT31cRFPMOSia+YInZXLHQhCoxx1+pl7pg0HqDKaQTYlQlSBQGQEKtg
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 6b2a54ed-0281-4991-6b78-08d57e0cced7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1514;
x-ms-traffictypediagnostic: DM5PR12MB1514:
x-microsoft-antispam-prvs: <DM5PR12MB1514D26B7BDA2E68F51CED50F8C00@DM5PR12MB1514.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1514;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1514;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(39380400002)(376002)(13464003)(199004)(189003)(6246003)(86362001)(81156014)(72206003)(4326008)(53936002)(66066001)(8676002)(81166006)(3846002)(316002)(105586002)(54906003)(33656002)(478600001)(6436002)(7696005)(106356001)(3280700002)(3660700001)(9686003)(99286004)(55016002)(53546011)(229853002)(2900100001)(6506007)(7736002)(14454004)(25786009)(186003)(6116002)(102836004)(2950100002)(6916009)(2906002)(76176011)(305945005)(26005)(68736007)(97736004)(5250100002)(93886005)(8936002)(74316002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1514;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uSOuQgDmU61J1A3CWjc//3P/1UI+T9UZDgIjFi5965tu9xRq+OUrkI2Ezeka2FmIoo0ehnhi3r5v9MQ4TNWRYIU6ZFekDDUUTb8tjrrs/lZ3i5ZTbJT/vRtxCSRLFKyyz1sY2GgZd8Qu/aKQsUYwYvgCJOJ/GaaAqIN8W9EdM/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2a54ed-0281-4991-6b78-08d57e0cced7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 18:06:21.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RI6Ufi010261

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 12:45 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
> 
> On Tue, Feb 27, 2018 at 05:27:39PM +0000, Ghannam, Yazen wrote:
> > Sure, we can print the fields unconditionally if Ard is okay with that.
> >
> > The issue is that the x86 behavior will be different from all the others, so
> that
> > might be confusing.
> 
> Confusing for whom?
> 
> Are we sharing tools with other arches or what am I missing?
> 

It's not just about arches but record types. A single platform can report
using arch-specific records, memory records, PCIe records, etc.

So all the other record types only show fields with a valid bit set and this
has always been the case. There may be users or tools who expect that
same behavior.

> > This set does decode everything fully so that people can read the error.
> 
> No, it doesn't. It dumps
> 
>         printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
> 
>         printk("%sError Structure Type: %pUl\n", newpfx,
>                 &err_info->err_type);
> 
>         printk("%sCheck Information: 0x%016llx\n", newpfx,
>                  err_info->check_info);
> 
> and so on which are half-baked.
> 
> Think of it this way: if you look at the error record and you still need
> to look at the spec to decode it, then it is still not good enough.
> 
> Users don't care about validation bits, or unreadable GUIDs or WTF is
> "Check Information" even?
> 
> "This section details the layout of the Processor Error Information
> Structure and the detailed check information which is contained within."
> 
> And that "Check Information" thing is mentioned only twice in the whole
> spec.
> 
> StructureErrorType only there in the table.
> 
> Very informative that.
> 
> So no, users don't care about any of that internal crap - they wanna
> know what is wrong with their box and that should be written in plain
> english.
> 

Please see the other patches where these are decoded further. As I
mentioned the cover letter, the decoding is applied incrementally rather
than having one large patch.

Also, like I said in another thread, we should always print the raw value
followed by the decoding. That way the raw info is there in case a user
wants to send the data to the vendor or other expert party. 

> > I already mentioned in the Context info patch that there could be
> > further decoding which we can do in the future.
> 
> Then decode only those pieces fully now which you can do now and when
> you add something in the future, add it then with the full decoding
> functionality. No fields which need additional decoding with the spec
> opened on one side.
> 

Okay.

Thanks,
Yazen
