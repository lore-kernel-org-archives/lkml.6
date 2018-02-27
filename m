Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeB0R1q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:27:46 -0500
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:22992
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750746AbeB0R1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:27:44 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Topic: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
Thread-Index: AQHTrzm1EGCswNxnok6qbkQSpXWbnqO4HBMAgAA+gSCAAB/wgIAAAzCg
Date: Tue, 27 Feb 2018 17:27:39 +0000
Message-ID: <DM5PR12MB1916F8C7DF93C1C9402AE3ECF8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-3-Yazen.Ghannam@amd.com>
 <20180227112234.GE26382@pd.tnic>
 <DM5PR12MB1916B6AEE434A345E78BE234F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227170034.GJ26382@pd.tnic>
In-Reply-To: <20180227170034.GJ26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2342;7:Kf2RiE7tTUW5JEBqpUTLlU3SaLZmi3jvuSzIOAFc55uQ67Nc7sJCaSJOrS9b6opsbfg02fgV5TAE3sIQgigOpxY0akH2xEkopsJWg0QVtv93BAzjdQh7ZVp58Z9h13+sgf1h/SyRHUT3mxRIjve2zQ7L3mvUns2e/r3Dnw9mn/xp+w7dUGAVrm+pqX3oDy99yz7FR0oVRlvHKxy9rt/k5SlhxaBXXAA8UgpSDx/g80QModTxxgy6nm5XNc28MPLQ;20:Davd0OakECWZtRfwXKVvd4yssX4z5BpuT18EfQGoE3Do2LpFl0XdZHQDFw37UvaJ1NJl94IKkqr8lygLUllHpztnk/9uv97/5kM5xUYJChryQaabzXUNo8EYHnnycQWi8KuMT5hvAm+HbgWcVrSLgjQi2u3IbTpgly1hY3c6pFLo5rKiGAl9NDj1H4lFi2IIfM9ALgE+wg+vTldssGZg8W6wmqfqv5zAWucfjHXwO7QmWDZ3it4HfMIsxzBNAVuZ
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 854b66f8-f710-462c-a5b7-08d57e076699
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB2342;
x-ms-traffictypediagnostic: DM5PR12MB2342:
x-microsoft-antispam-prvs: <DM5PR12MB2342E6A0452B94036252EE0BF8C00@DM5PR12MB2342.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501161)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB2342;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2342;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(13464003)(81166006)(6916009)(6436002)(54906003)(66066001)(4326008)(8936002)(316002)(53936002)(8676002)(5250100002)(97736004)(68736007)(55016002)(33656002)(6246003)(81156014)(9686003)(74316002)(86362001)(93886005)(186003)(2906002)(105586002)(5660300001)(3846002)(6116002)(102836004)(106356001)(6506007)(3280700002)(53546011)(3660700001)(2900100001)(76176011)(99286004)(2950100002)(305945005)(478600001)(7736002)(7696005)(229853002)(14454004)(72206003)(25786009)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2342;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: vBh+1enl5twE5fZByfoXrYlQaDAYqdZ/u31WoYVR/7fkxg76tNu85Q/8hI7I9ckZzRrznWGw1ky51kxetEzzVbj9tFZFUkGP7kheqCdrCtha7UBeykaW3TtTDwadp+xqHJxsxeR7/shvaTIIxEBZ1ilLJAYxVK3xMn7F9EEYR7o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854b66f8-f710-462c-a5b7-08d57e076699
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 17:27:39.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RHRoc7027709

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 12:01 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
> 
> On Tue, Feb 27, 2018 at 03:13:11PM +0000, Ghannam, Yazen wrote:
> > I decided to print the Validation Bits as a sanity check for whomever is
> looking
> > at this. Since we only print fields with a valid bit, it may be confusing for
> users
> > who don't know why fields are missing.
> 
> I suggested what to do about that already: print the fields unconditionally.
> 

Sure, we can print the fields unconditionally if Ard is okay with that.

The issue is that the x86 behavior will be different from all the others, so that
might be confusing.

> > Also, I don't think we should be interpreting the spec for the user. We
> should
> > print the fields as they and users can refer back to the spec for more
> information.
> 
> This is a very very bad idea.
> 
> You can just as well dump binary blobs and then add a user script which
> deciphers that. Oh wait, we had that, it is called mcelog and it is a
> huge pain trying to decode an error properly.
> 
> By that same logic, we could simply dump 64-bit MCA MSR values.
> 
> And everytime we get an error, we have to go dig out the spec. Hell no!
> We had that, we know it is awful, we won't have it again.
> 
> You want to decode everything and fully in the kernel so that you can
> have a ready error record which people can simply *read* from dmesg and
> know what the error is.
> 

This set does decode everything fully so that people can read the error. The only
two places there are binary dumps are with the CPUID field and the Context info.

Maybe we can run the CPUID field through some decoder in arch/x86.

I already mentioned in the Context info patch that there could be further
decoding which we can do in the future. The two options that might be a pain
will be the MSR and MM register types, since these will be model and/or
platform specific.

Thanks,
Yazen
