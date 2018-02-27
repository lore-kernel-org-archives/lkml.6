Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeB0VcW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:32:22 -0500
Received: from mail-sn1nam01on0059.outbound.protection.outlook.com ([104.47.32.59]:64512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751455AbeB0VcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:32:20 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: RE: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Thread-Topic: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Thread-Index: AQHTrzm07vsANP0WAkKVOn1mh2z8gqO4TzGAgAANYECAAB8DgIAABrBwgAAJjoCAAALA0IAAEAcAgAAJTVA=
Date: Tue, 27 Feb 2018 21:32:18 +0000
Message-ID: <DM5PR12MB191691E786778FE380388B74F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-4-Yazen.Ghannam@amd.com>
 <20180227142531.GF26382@pd.tnic>
 <DM5PR12MB191637C1857C5D9499D08D66F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227170423.GK26382@pd.tnic>
 <DM5PR12MB1916D78FE4EEF146EE1D8612F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227180231.GO26382@pd.tnic>
 <DM5PR12MB1916230ED7225CE0EB00EDF1F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227190943.GQ26382@pd.tnic>
In-Reply-To: <20180227190943.GQ26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1146;7:ySVDRwPLKFpuEtE+A6NCmw6TUkMgM6C9Jqk5ABwSn9FOyFJlLlqs0wDt0sQfpNfw3mkygeHVTtqCllGO5H/5eVtaW7/qLGvfr3Z8uB/Ogc4GegEYvD4VHCYSccCvQlwR6RD1jboqop+OMQEoQH4rRbNeBPT5ZXh50r2s3Y+zCIH/MBKbgLaiYvYX0YuqJszhLA7xpXS0UUR6w6EvWo3YABfSDRPc6aHw0zjOuvF/iIiiERXyr5wN9tpugi4GWmMu;20:D+H7+bYpn4QicplbXzuwZkXawUIv2a6Vpl2iCPQbCB/B1JS06GclFBO+YY6NOBjoScPtyTe9zq219VdFFdY08oaeNAUVXv9Vcw6YtrWBvqo4ZLdcNWyDkwyAAzzF1AC6RJi7/9sd007Z3PhhHzkD+PSAKlYak6+oU9FbPi7Fy/zQX38vXhFwS3IVwFIZh5Ut86B0D7otJMThZd6yO8rMnbFU4YAw9VHy69PzYkIIuWgm1PXwBshbA62LKZMYpWr+
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1dcf64a-5d0b-409b-c545-08d57e299461
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1146;
x-ms-traffictypediagnostic: DM5PR12MB1146:
x-microsoft-antispam-prvs: <DM5PR12MB114638AF2360CCD6BB8B425AF8C00@DM5PR12MB1146.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(9452136761055)(767451399110)(788757137089)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501205)(52105095)(3002001)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1146;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1146;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(366004)(39380400002)(13464003)(199004)(189003)(316002)(5250100002)(7696005)(5660300001)(3280700002)(55016002)(53936002)(186003)(2900100001)(9686003)(105586002)(54906003)(74316002)(8936002)(76176011)(25786009)(6116002)(6506007)(6436002)(53546011)(3846002)(99286004)(7736002)(86362001)(72206003)(106356001)(33656002)(26005)(229853002)(2906002)(102836004)(6916009)(6246003)(6346003)(551934003)(8676002)(97736004)(93886005)(3660700001)(14454004)(2950100002)(478600001)(4326008)(66066001)(81166006)(68736007)(81156014)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1146;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-microsoft-antispam-message-info: 1l/lbMr4G0A7Cqk42r1vAOtA5wBlPtv5FKJmpoXFxQ+L1YhdRyeRNEL7d8luyieh6YvQx8OR1fKkHqw/QBUINfizu6nkDgIB31qMVKnnCJhWiZp5z/BE/PU7iBA5eKG6kGDT1JljlwrriKlUJ9DAKaLv8Jo4MlP4DtdAp2/hdyc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dcf64a-5d0b-409b-c545-08d57e299461
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 21:32:18.9737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RLWREH013414

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 2:10 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org; Tony Luck
> <tony.luck@intel.com>
> Subject: Re: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info
> Structure
> 
...
> > 1) No one except debug and HW design folks, who will eventually get a
> > report from a user.
> 
> Hahahha, yeah right.
> 
> The only people who get those reports are the maintainers of the code in
> the kernel and the distro people who get all the bugs assigned to them.
> 
> And if they can't decode the error - it is Tony and me.
> 
> HW folks hear about it from us. And we go and decode the damn crap
> *every* time. Do you catch my drift now?
> 

That's not true. You may get reports but so do platform and silicon vendors
directly.

> > [    1.990948] [Hardware Error]:  Error 1, type: corrected
> > [    1.995789] [Hardware Error]:  fru_text: ProcessorError
> > [    2.000632] [Hardware Error]:   section_type: IA32/X64 processor error
> > [    2.005796] [Hardware Error]:   Validation Bits: 0x0000000000000207
> > [    2.010953] [Hardware Error]:   Local APIC_ID: 0x0
> > [    2.015991] [Hardware Error]:   CPUID Info:
> > [    2.020747] [Hardware Error]:   00000000: 00800f12 00000000 00400800
> 00000000
> > [    2.025595] [Hardware Error]:   00000010: 76d8320b 00000000 178bfbff
> 00000000
> > [    2.030423] [Hardware Error]:   00000020: 00000000 00000000 00000000
> 00000000
> > [    2.035198] [Hardware Error]:   Error Information Structure 0:
> > [    2.039961] [Hardware Error]:    Error Structure Type: a55701f5-e3ef-
> 43de-ac72-249b573fad2c
> > [    2.049608] [Hardware Error]:    Error Structure Type: cache error
> > [    2.054344] [Hardware Error]:    Validation Bits: 0x0000000000000001
> > [    2.059046] [Hardware Error]:    Check Information: 0x0000000020540087
> > [    2.063625] [Hardware Error]:     Validation Bits: 0x0087
> > [    2.068032] [Hardware Error]:     Transaction Type: 0, Instruction
> > [    2.072423] [Hardware Error]:     Operation: 5, instruction fetch
> > [    2.076776] [Hardware Error]:     Level: 1
> > [    2.081073] [Hardware Error]:     Overflow: true
> > [    2.085360] [Hardware Error]:   Context Information Structure 0:
> > [    2.089661] [Hardware Error]:    Register Context Type: MSR Registers
> (Machine Check and other MSRs)
> > [    2.098487] [Hardware Error]:    Register Array Size: 0x0050
> > [    2.103113] [Hardware Error]:    MSR Address: 0xc0002011
> > [    2.107742] [Hardware Error]:    Register Array:
> > [    2.112270] [Hardware Error]:    00000000: d8200000000a0151
> 0000000000000000
> > [    2.116845] [Hardware Error]:    00000010: d010000000000000
> 0000000300000031
> > [    2.121228] [Hardware Error]:    00000020: 000100b000000000
> 000000004a000000
> > [    2.125514] [Hardware Error]:    00000030: 0000000000000000
> 0000000000000000
> > [    2.129747] [Hardware Error]:    00000040: 0000000000000000
> 0000000000000000
> 
> Lemme simplify that error record:
> 
> [Hardware Error]:  Corrected Processor Error
> [Hardware Error]:   APIC_ID: 0x0 | CPUID: 0x17|0x1|0x2
> [Hardware Error]:    Type: cache error during instruction fetch
> [Hardware Error]:    cache level 1
> [Hardware Error]:    Overflow: true
> 
> See how much more readable it got! And it is only 5 lines. I can make it
> even smaller.
> 

Not much more readable. It's still vague and confusing to a user and devoid
of any real info so an expert can't help. And now the information is printed
arbitrarily, so someone needs to read the source to figure out what it really
means.

> If it were a critical, uncorrectable error, every line counts: imagine
> you do the above fat record and the machine freezes at line 5.
> 

Maybe. But these records are generated by Platform Firmware. Why would
FW report the error knowing the system is about to die? Most likely we'll
only see CPERs in HEST if the OS can do something, or we'll see them in
BERT after recovering from a hang/reset.

> Now, I admit that my vesion of the record is not enough to debug it
> but it needs to contain only information which is clear and humanly
> readable to debug. You can always dump the raw data underneath from the
> tracepoint but make the beginning human readable.
> 
> Do you know what users say about your error record?
> 
> "Err, it says hardware error, is my machine broken? I need to replace my
> CPU."
> 

Your example still says "Hardware Error" and odds are general users won't
understand what the error type means or what a corrected error is. So it's
not much better.

> I read that on a weekly basis.
> 
> Do you know how expensive support calls are about such errors which are
> completely unreadable to people? 20 engineers need to get on a call to
> realize it was a dumb correctable error? Btw, this is one of the reasons
> why we did the error collector.
> 

Exactly! The more info available (usually) the more quickly it can be
diagnosed.

Hardware errors are generally rare and hard to reproduce. So when one
does occur we should capture the data and provide it.

Here are a couple of scenarios based on similar experiences I've had:

Scenario 1 (with minimal info)
User: "I have a hardware error. What does it mean?"

Debugger: "Do you have any more info?"

User: "Corrected Processor Error; cache error during instruction fetch"

Debugger: "'Corrected' sounds okay, but not sure about 'cache error during
fetch'. Linux dev, what does that mean?"

Linux dev: "It means this field and that field equal this."

Debugger: "What about the rest of the data?"

Linux dev: "It's in a trace buffer. Please use this tool or set this sysfs file to
this and that to collect the data."

Debugger: "There aren't any errors in the trace buffer. User, when did
this occur?"

User: "This error occurred last week. We've reset the machine a few times
since then. The error seems to happen every few days under a very
specific workload."

Debugger: "Okay, let's try to reproduce this."
*wait a few days, run a lot of systems to up the odds*

Debugger: "We finally have data and can now help you"

Scenario 2 (with all platform provided data)
User: "I have a hardware error. What does it mean?"

Debugger: "Do you have any more info?"

User: *provides complete error record*

Debugger: "Thank you, we have everything we need to help you."


I'll send a V3 set with the following changes:
1) Fix table numbering in commit messages.
2) Remove "Validation Bits" lines.
3) Only print error type GUID for unknown types.

I think this set should focus on printing the x86 CPER based on the UEFI
spec and the convention of the other CPER code. CPERs are generated
by Platform Firmware. So errors are explicitly intended to be viewed by
the user and all info should be displayed. Other errors not intended to
be seen by the user may be thresholded or masked by the Platform.

I *have* been thinking that it would be nice to take the CPER and pipe it
through the MCA decoding in arch/x86 and EDAC. This would be really
nice for when the CPER includes the MCA registers in the Context info.
So we'd get our usual MCA decoding instead of a binary blob of registers.

I was thinking that the MCA decoding would be in addition to this. But
based on Boris's comments, maybe we can make it a default selection.
For example, if MCA/EDAC decoding is available, use it. Otherwise, print
the CPER fields in a generic way like we do for the other CPER types.

That would be a separate set though.

Thanks,
Yazen
