Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeB0Rq6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:46:58 -0500
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:7663
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750952AbeB0Rq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:46:56 -0500
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
Thread-Index: AQHTrzm07vsANP0WAkKVOn1mh2z8gqO4TzGAgAANYECAAB8DgIAABrBw
Date: Tue, 27 Feb 2018 17:46:54 +0000
Message-ID: <DM5PR12MB1916D78FE4EEF146EE1D8612F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-4-Yazen.Ghannam@amd.com>
 <20180227142531.GF26382@pd.tnic>
 <DM5PR12MB191637C1857C5D9499D08D66F8C00@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180227170423.GK26382@pd.tnic>
In-Reply-To: <20180227170423.GK26382@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2342;7:jHou5crlzbQVmYBV9JsnNfghhY79qzmeXu/42HZbPBWA/kalU0q9PY0bDRnkmwqOlLONMxuqY3VdnRZKTbxyDPFLpRC5J0r9aNh1ZfMcT9gGHuqnhFx5xXxYtUKGmsilwo2/K37BULfwotKdv0uEQqjDUJjg7dvPXBwwEr2/d/SOHGwhIx3g7x1fPNceo7QVEXrRmGpgYfwwQT02NrNHmC0a6txDFZsXTY66oZ73X/JXxxdn1X6N1tFPPN5U8dKO;20:PhQhZ59EIVt62E9aLlAZ5ZZ3Pis+5hEH8wVC1tRlmyRHbMZ648oST9lIAOjjfSYqvIEroJPJUvyjJpA9wD1fdLyafFH0sLowAAjtvaxFqus/CX/4ZQLNmyXFdNHUvJgKcWYzhlwaltSFmcaz2FdoSdUqGDSBVePAayr5j4Yc0twWRdB2fA0Z1+VVGINnkfYiSZD+39aAbdeg2/TGgE3DwEVJH+N60GEJTZBsoUjgYoQF5Ump72lTdv9xR+GVpqIK
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08a9c346-5369-45f3-1455-08d57e0a16fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB2342;
x-ms-traffictypediagnostic: DM5PR12MB2342:
x-microsoft-antispam-prvs: <DM5PR12MB2342137C454CFAA2CC7D13B2F8C00@DM5PR12MB2342.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501161)(52105095)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB2342;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2342;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39380400002)(39860400002)(396003)(13464003)(189003)(199004)(6506007)(106356001)(102836004)(3280700002)(53546011)(2906002)(105586002)(186003)(86362001)(74316002)(93886005)(6116002)(3846002)(5660300001)(3660700001)(14454004)(7696005)(229853002)(25786009)(26005)(72206003)(2900100001)(7736002)(305945005)(478600001)(76176011)(99286004)(2950100002)(66066001)(4326008)(54906003)(8936002)(316002)(81166006)(6436002)(6916009)(55016002)(33656002)(68736007)(6246003)(81156014)(9686003)(8676002)(53936002)(97736004)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2342;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: X2uC/kCOfDzBNKPGuOSS5r+hj69SciTsDNEkU7K/rd1RqiLmxUfQhXHeLsxjw9f7RVoHN1XDq41WV1dUeHIN+GbSkaFYV1MYy6GXAhNUj6BDJ8A6cfsOO7UgGbf2RbMt+xRLgvYQuhb/AJpcgnmdTps9LGEFvSNwoynFGJQEXuY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a9c346-5369-45f3-1455-08d57e0a16fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 17:46:54.1647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RHl4eq001581

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@suse.de]
> Sent: Tuesday, February 27, 2018 12:04 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org
> Subject: Re: [PATCH v2 3/8] efi: Decode IA32/X64 Processor Error Info
> Structure
> 
> On Tue, Feb 27, 2018 at 03:25:06PM +0000, Ghannam, Yazen wrote:
> > This is the same as the other CPER code.
> 
> Dude, turn on brain!
> 
> So if it is in the other CPER code, we should copy it, no matter how
> dumb it is?!?
> 

I think there's value in following the conventions in a subsystem.

I can change this if you give a reason besides "it's dumb". This could apply
to the other CPER code also.

> > Also, the spec allows platform-defined GUIDs. So we should always print
> this
> > even if the GUID is not defined by the spec.
> 
> We need to have a way to map the GUID to a hw part. Dumb numbers mean
> shit
> because the error record is worthless.
> 

We do map the spec-defined GUIDs in patch 4 of this set. I don't know if there's
a central place where all vendor-defined GUIDs are listed. I can look into this.

> > The Check Information will be decoded further in another patch.
> >
> > I don't think there's much else to decode for the ID fields.
> 
> Again, those numbers can't help decoding the error, no need to dump
> them. Or we find a way to make sense out of that info.
> 

Which numbers? The Check Information? Like I said, that's decoded in another
patch, patches 5, 6, and 7.

And the raw value should still be printed because
1) It may represent a type that we can't decode. Maybe a type that's not part of
the spec.
2) It's good to have the raw value for reference. We do this with MCA_STATUS
where we print the raw value followed by the decoding.

> > Other tables may have the same fields but the offsets are usually different.
> > So it may be more trouble than it's worth trying to unify the different
> tables.
> 
> If the structs are the same, you can use generic functions for dumping -
> the offsets are meaningless then.
> 

The structs are all different even though some fields may be the same.

Thanks,
Yazen
