Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeB0SkT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:40:19 -0500
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:52192
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750810AbeB0SkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:40:16 -0500
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
Thread-Index: AQHTrzm07vsANP0WAkKVOn1mh2z8gqO4TzGAgAANYECAAB8DgIAABrBwgAAJjoCAAALA0A==
Date: Tue, 27 Feb 2018 18:40:13 +0000
Message-ID: <DM5PR12MB1916230ED7225CE0EB00EDF1F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-4-Yazen.Ghannam@amd.com>
 <20180227142531.GF26382@pd.tnic>
 <DM5PR12MB191637C1857C5D9499D08D66F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227170423.GK26382@pd.tnic>
 <DM5PR12MB1916D78FE4EEF146EE1D8612F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227180231.GO26382@pd.tnic>
In-Reply-To: <20180227180231.GO26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1179;7:mnSIN18tGLt6fHthKDwMjCZQGmsReUzYOEkkSmqYCzMRSzcSmFBCF8rYCjx1Z37fnpJAceqJoFKo6NwOKyAa2dhkpejwLK6SjLg9jJfREyZvmQIIHqK0G/410ESHcbUbFJkh+Zu0Rg+CsAg3y8M2DvDP3CELJDI1e4Hg4ZopUIOMARqEDMqge0Fv81hRGJaVGGqUchLfl/WVRsKMQLRxBQRC0oqDSsSX5rxERlnUb647WUs7kcoyu86Zp808jh3s;20:BMJ0+U+Np7dAYFgI2qRN4+4wLHZYULyN2HDwy3eKpqvv3ZiFlyquOtEqoWJiiKYRBiuwRcjGqvCNv+xwzGyVCE6ts7ThcJ5Kjzg8yHPtAa4IYV62g2IfjWsjSM1VVlKbKvPqZvC05yXxmb+3znKkBnSUVFnuqzihbPDMe/58EG9TsYGCkCmH5jFXgNMErT3LBlUub/m1kbvEPz0P2L3j+j/Q2fBeWHzuruebNxa0RpY47QVD0J+PLJYAaCG1oSWd
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a41ca3d3-44ef-447e-ce59-08d57e1189da
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1179;
x-ms-traffictypediagnostic: DM5PR12MB1179:
x-microsoft-antispam-prvs: <DM5PR12MB1179FFA568F74A41909C72BEF8C00@DM5PR12MB1179.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231220)(944501161)(3002001)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1179;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1179;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39380400002)(39860400002)(13464003)(189003)(199004)(5250100002)(74316002)(5660300001)(53546011)(186003)(54906003)(86362001)(6436002)(2900100001)(316002)(33656002)(55016002)(25786009)(26005)(478600001)(106356001)(2906002)(81166006)(6246003)(68736007)(7736002)(305945005)(9686003)(53936002)(8676002)(102836004)(551934003)(97736004)(6506007)(4326008)(3846002)(14454004)(8936002)(93886005)(66066001)(6116002)(229853002)(72206003)(76176011)(7696005)(2950100002)(3280700002)(3660700001)(6916009)(81156014)(105586002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1179;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:3;A:1;LANG:en;
x-microsoft-antispam-message-info: 3PWpnEWIhRNsi6cBLMfT0HM6LmQo7MfuJx9V3R9K4wk30MVXwNE78j85s81jOyHLdyKSlCEWBzNhsM892d2WLzpS9fJX57qVk0sDSXgJzmU/32tgK0URlRcv+qO23daF51JZqLvqQTxcn9aRYD5CH224TwcjnuFT5nZaLGqoQik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41ca3d3-44ef-447e-ce59-08d57e1189da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 18:40:13.3592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RIeQl5021011

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 1:03 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info
> Structure
> 
> On Tue, Feb 27, 2018 at 05:46:54PM +0000, Ghannam, Yazen wrote:
> > I think there's value in following the conventions in a subsystem.
> 
> "conventions in a subsystem" my ass. That's brainless copy-pasting.
> 
> It was added by
> 
> f6edea77c8c8 ("ACPI, APEI, CPER: Cleanup CPER memory error output
> format")
> 
> and then replicated everywhere.
> 
> It is simply a dumb way of writing:
> 
> 	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> 

There's a space after the %s, right? I missed it at first glance, though maybe
my LASIK didn't take very well.

> 
> > I can change this if you give a reason besides "it's dumb".
> 
> Two can play that game: you get to keep it if you give a good reason
> why.
> 

Code readability.

...
> > And the raw value should still be printed because
> > 1) It may represent a type that we can't decode. Maybe a type that's not
> part of
> > the spec.
> 
> If we can't decode it, *then* you dump it:
> 
> 	"Unrecognized type: 0x%llx ..."
> 
> > 2) It's good to have the raw value for reference. We do this with
> MCA_STATUS
> > where we print the raw value followed by the decoding.
> 
> 1. No one stares at the raw value if the bits are decoded
> 2. MCA_STATUS is one register - this error record is huge.
> 

1) No one except debug and HW design folks, who will eventually get a
report from a user.
2) You're right, the record is huge. Printing out the Validation Bits, GUID,
and raw Check Info will be an extra 5 lines.

I posted an example at the end.

We could get rid of the GUID for known types like you suggest. Also, we
can drop the Validation Bits for the Check Info since that's already part of
it.

Thanks,
Yazen

[    1.990948] [Hardware Error]:  Error 1, type: corrected 
[    1.995789] [Hardware Error]:  fru_text: ProcessorError 
[    2.000632] [Hardware Error]:   section_type: IA32/X64 processor error 
[    2.005796] [Hardware Error]:   Validation Bits: 0x0000000000000207 
[    2.010953] [Hardware Error]:   Local APIC_ID: 0x0 
[    2.015991] [Hardware Error]:   CPUID Info: 
[    2.020747] [Hardware Error]:   00000000: 00800f12 00000000 00400800 00000000 
[    2.025595] [Hardware Error]:   00000010: 76d8320b 00000000 178bfbff 00000000 
[    2.030423] [Hardware Error]:   00000020: 00000000 00000000 00000000 00000000 
[    2.035198] [Hardware Error]:   Error Information Structure 0:
[    2.039961] [Hardware Error]:    Error Structure Type: a55701f5-e3ef-43de-ac72-249b573fad2c
[    2.049608] [Hardware Error]:    Error Structure Type: cache error
[    2.054344] [Hardware Error]:    Validation Bits: 0x0000000000000001
[    2.059046] [Hardware Error]:    Check Information: 0x0000000020540087
[    2.063625] [Hardware Error]:     Validation Bits: 0x0087
[    2.068032] [Hardware Error]:     Transaction Type: 0, Instruction
[    2.072423] [Hardware Error]:     Operation: 5, instruction fetch
[    2.076776] [Hardware Error]:     Level: 1
[    2.081073] [Hardware Error]:     Overflow: true
[    2.085360] [Hardware Error]:   Context Information Structure 0:
[    2.089661] [Hardware Error]:    Register Context Type: MSR Registers (Machine Check and other MSRs)
[    2.098487] [Hardware Error]:    Register Array Size: 0x0050
[    2.103113] [Hardware Error]:    MSR Address: 0xc0002011
[    2.107742] [Hardware Error]:    Register Array:
[    2.112270] [Hardware Error]:    00000000: d8200000000a0151 0000000000000000
[    2.116845] [Hardware Error]:    00000010: d010000000000000 0000000300000031
[    2.121228] [Hardware Error]:    00000020: 000100b000000000 000000004a000000
[    2.125514] [Hardware Error]:    00000030: 0000000000000000 0000000000000000
[    2.129747] [Hardware Error]:    00000040: 0000000000000000 0000000000000000
