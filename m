Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5A9C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3217820663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AyYWW7KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfAULWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:22:45 -0500
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:35008
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727726AbfAULWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NATK0NRwbsYbSipHyBonuBuZ2YQUlKUxvm1TuX9VHNw=;
 b=AyYWW7KMb0mf6eASdM5RvmAZz6lUaiKw5WvL1rRvsYXSNg4g4lmYuBt1tDUeKqqvhbauFc7efLkAuc0Vwi3bSTBQ1osXUbrmX0dRQ6LEssZIQUMLe1jeS0lKtY6lgRfxk+6Q/rjTqEs6X05eWynIDgokAnieH4Pa5iShRDJjDck=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.92.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 11:22:37 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 11:22:37 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Thread-Topic: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Thread-Index: AQHUrQGAzRpl+6N4dEWaN50+01WrkqWwqYAAgAFaUACAAB1/AIAAYa0AgAElgYCAAJLkAIABDbeAgARUHIA=
Date:   Mon, 21 Jan 2019 11:22:36 +0000
Message-ID: <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
References: <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
 <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com>
 <f53987d5-b7c1-61f4-de44-3d7b4a3c68fe@ti.com>
 <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
 <4a5d4147-765d-711f-af98-9022d0253b3b@ti.com>
 <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com>
 <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com>
 <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com>
 <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
In-Reply-To: <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: CWLP265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::32) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB2961;6:eOyOXrzv9IHUbDj6pT2sp3GlJi/d140IzirXxVpAeDmRx2xTUyVumN7uNlvOk/rGhBBe2Ynlj48ouLAeAWsqSheI2ngfXV+bZfJMJ/royDEbrS0CSMTvmlejcK7huczYndr0IhHqGCMXa3ZE2J6OO6V8oVCXVqf6wjvsUpIyPxRqac86qQHLf8EYyh6+6xQYICN1NtHZqHZrKlwqJX+qCyyjNIhWQofYRYvSF0me2EzOVDeb9boJZgQexte8v0I51pLMmIQuS2IaCD6PDwd/swADlIH7rxlDxJsYLlj23uV3qJdxNgCux2aGpy6CABViKZIIVxS+rR5p0UAyy7hGkjWAETLfSafUW5H1JTbqFgkpD9YQ5ZFod67gl/osWO7iJIAfxT2SNL3w31v2+5vANIKbG50G9ZLEH2FLgzpe5+TaDiz/HljAJawjL3UMzHv4GR4OQvIq+VsqeiVA+Zyc5Q==;5:lLns5kinavC3c2aqyAItH/0Fh/yMOFYn+tdNs8i4CDHtDHHGBn2uWCuDpgyvCN3P0OWUgmqm7M07ScdQUGwzrd2jgBwjqwrPH3AJWYu10t4HsBpNVziX0BeqqjuzZdXmSFeOjn8FhC5mhDtIgP8CHfLm106i9ZZ00ePRj6aG7bWs6z+b+T30F8yqFgvXq/K40f9Y4CMONedxayeH846jYQ==;7:32RlSdI0Ao5jOD0ea+Car15jhR3RE9oTKLkJ9g5ovSsYCYc1YyZsBOvCFxB6muhwXRHyNX/uvH1WVjZwf1ig7PUmySy8PcwMvQDdHiCxJIWbkM5RsOqMvHj6WHNbl3haLJJf1FSq5phrATUSYX5XVg==
x-ms-office365-filtering-correlation-id: 3e87c4af-859c-4287-8071-08d67f92bf0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB2961;
x-ms-traffictypediagnostic: AM0PR08MB2961:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB29613F4614D240DA9DCB1071F09F0@AM0PR08MB2961.eurprd08.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(366004)(136003)(52314003)(43544003)(189003)(199004)(11346002)(446003)(97736004)(5024004)(14444005)(256004)(1076003)(6916009)(58126008)(7736002)(476003)(186003)(3846002)(6116002)(68736007)(6512007)(6306002)(9686003)(53936002)(486006)(4326008)(6246003)(26005)(53946003)(86362001)(71200400001)(71190400001)(33896004)(52116002)(66066001)(6486002)(106356001)(102836004)(76176011)(105586002)(6506007)(53546011)(386003)(229853002)(44832011)(25786009)(966005)(72206003)(305945005)(2906002)(30864003)(81156014)(316002)(81166006)(54906003)(8936002)(99286004)(8676002)(93886005)(6436002)(14454004)(478600001)(7744002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB2961;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GaRRU6I9fLH8be4lDGVXoxE1KmrGLLwBf1OFUpDGOHG06jRD5r8rM/tHCwGbKhyB5pz/gCjJA70Q5PC2jVO38ubLezkpjopPszlMoXJHdnxSGWMSlowQQCdVRtFb02IWSnq/rZkjzO8TmhlfQSdlgCzTrPgf/usc4Bgq7K4UO+jXtP0bDNKv0x8QSd5zxv2G9SocVcdqeOuT6uQxz0kZm3t+3ljj4974TtA9uIGAWNWHUwfUUcXNnbXMULG0lX7SXLACPq5mMNjLnsxGF4M7CeRhgGJ1DLyeQOgzA0qTiIfZQ4aJd189wPFc+ioRHHCGtduRqcRMnUTzyTMIYJH9oQDzL7iVu/11teescSJNqZTBkrHK9AAxCxg0QhkIv3zrVozQ7tJyVnRXMEmLGMNodQuthYBJPcxKrNn+qr1+gpM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <550319C6A0A86545BE37210E455DB817@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e87c4af-859c-4287-8071-08d67f92bf0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 11:22:36.4264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for being a bit sporadic on this. I was out travelling last week
with little time for email.

On Fri, Jan 18, 2019 at 11:16:31AM -0600, Andrew F. Davis wrote:
> On 1/17/19 7:11 PM, Liam Mark wrote:
> > On Thu, 17 Jan 2019, Andrew F. Davis wrote:
> >=20
> >> On 1/16/19 4:54 PM, Liam Mark wrote:
> >>> On Wed, 16 Jan 2019, Andrew F. Davis wrote:
> >>>
> >>>> On 1/16/19 9:19 AM, Brian Starkey wrote:
> >>>>> Hi :-)
> >>>>>
> >>>>> On Tue, Jan 15, 2019 at 12:40:16PM -0600, Andrew F. Davis wrote:
> >>>>>> On 1/15/19 12:38 PM, Andrew F. Davis wrote:
> >>>>>>> On 1/15/19 11:45 AM, Liam Mark wrote:
> >>>>>>>> On Tue, 15 Jan 2019, Andrew F. Davis wrote:
> >>>>>>>>
> >>>>>>>>> On 1/14/19 11:13 AM, Liam Mark wrote:
> >>>>>>>>>> On Fri, 11 Jan 2019, Andrew F. Davis wrote:
> >>>>>>>>>>
> >>>>>>>>>>> Buffers may not be mapped from the CPU so skip cache maintena=
nce here.
> >>>>>>>>>>> Accesses from the CPU to a cached heap should be bracketed wi=
th
> >>>>>>>>>>> {begin,end}_cpu_access calls so maintenance should not be nee=
ded anyway.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>  drivers/staging/android/ion/ion.c | 7 ++++---
> >>>>>>>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/stag=
ing/android/ion/ion.c
> >>>>>>>>>>> index 14e48f6eb734..09cb5a8e2b09 100644
> >>>>>>>>>>> --- a/drivers/staging/android/ion/ion.c
> >>>>>>>>>>> +++ b/drivers/staging/android/ion/ion.c
> >>>>>>>>>>> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(s=
truct dma_buf_attachment *attachment,
> >>>>>>>>>>> =20
> >>>>>>>>>>>  	table =3D a->table;
> >>>>>>>>>>> =20
> >>>>>>>>>>> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> >>>>>>>>>>> -			direction))
> >>>>>>>>>>> +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->n=
ents,
> >>>>>>>>>>> +			      direction, DMA_ATTR_SKIP_CPU_SYNC))
> >>>>>>>>>>
> >>>>>>>>>> Unfortunately I don't think you can do this for a couple reaso=
ns.
> >>>>>>>>>> You can't rely on {begin,end}_cpu_access calls to do cache mai=
ntenance.
> >>>>>>>>>> If the calls to {begin,end}_cpu_access were made before the ca=
ll to=20
> >>>>>>>>>> dma_buf_attach then there won't have been a device attached so=
 the calls=20
> >>>>>>>>>> to {begin,end}_cpu_access won't have done any cache maintenanc=
e.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> That should be okay though, if you have no attachments (or all
> >>>>>>>>> attachments are IO-coherent) then there is no need for cache
> >>>>>>>>> maintenance. Unless you mean a sequence where a non-io-coherent=
 device
> >>>>>>>>> is attached later after data has already been written. Does tha=
t
> >>>>>>>>> sequence need supporting?=20
> >>>>>>>>
> >>>>>>>> Yes, but also I think there are cases where CPU access can happe=
n before=20
> >>>>>>>> in Android, but I will focus on later for now.
> >>>>>>>>
> >>>>>>>>> DMA-BUF doesn't have to allocate the backing
> >>>>>>>>> memory until map_dma_buf() time, and that should only happen af=
ter all
> >>>>>>>>> the devices have attached so it can know where to put the buffe=
r. So we
> >>>>>>>>> shouldn't expect any CPU access to buffers before all the devic=
es are
> >>>>>>>>> attached and mapped, right?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Here is an example where CPU access can happen later in Android.
> >>>>>>>>
> >>>>>>>> Camera device records video -> software post processing -> video=
 device=20
> >>>>>>>> (who does compression of raw data) and writes to a file
> >>>>>>>>
> >>>>>>>> In this example assume the buffer is cached and the devices are =
not=20
> >>>>>>>> IO-coherent (quite common).
> >>>>>>>>
> >>>>>>>
> >>>>>>> This is the start of the problem, having cached mappings of memor=
y that
> >>>>>>> is also being accessed non-coherently is going to cause issues on=
e way
> >>>>>>> or another. On top of the speculative cache fills that have to be
> >>>>>>> constantly fought back against with CMOs like below; some coheren=
t
> >>>>>>> interconnects behave badly when you mix coherent and non-coherent=
 access
> >>>>>>> (snoop filters get messed up).
> >>>>>>>
> >>>>>>> The solution is to either always have the addresses marked non-co=
herent
> >>>>>>> (like device memory, no-map carveouts), or if you really want to =
use
> >>>>>>> regular system memory allocated at runtime, then all cached mappi=
ngs of
> >>>>>>> it need to be dropped, even the kernel logical address (area as p=
ainful
> >>>>>>> as that would be).
> >>>>>
> >>>>> Ouch :-( I wasn't aware about these potential interconnect issues. =
How
> >>>>> "real" is that? It seems that we aren't really hitting that today o=
n
> >>>>> real devices.
> >>>>>
> >>>>
> >>>> Sadly there is at least one real device like this now (TI AM654). We
> >>>> spent some time working with the ARM interconnect spec designers to =
see
> >>>> if this was allowed behavior, final conclusion was mixing coherent a=
nd
> >>>> non-coherent accesses is never a good idea.. So we have been working=
 to
> >>>> try to minimize any cases of mixed attributes [0], if a region is
> >>>> coherent then everyone in the system needs to treat it as such and
> >>>> vice-versa, even clever CMO that work on other systems wont save you
> >>>> here. :(
> >>>>
> >>>> [0] https://github.com/ARM-software/arm-trusted-firmware/pull/1553
> >>>>

"Never a good idea" - but I think it should still be well defined by
the ARMv8 ARM (Section B2.8). Does this apply to your system?

"If the mismatched attributes for a memory location all assign the
same shareability attribute to a Location that has a cacheable
attribute, any loss of uniprocessor semantics, ordering, or coherency
within a shareability domain can be avoided by use of software cache
management"

https://developer.arm.com/docs/ddi0487/latest/arm-architecture-reference-ma=
nual-armv8-for-armv8-a-architecture-profile

If the cache is invalidated when switching between access types,
shouldn't the snoop filters get un-messed-up?

> >>>>
> >>>>>>>
> >>>>>>>> ION buffer is allocated.
> >>>>>>>>
> >>>>>>>> //Camera device records video
> >>>>>>>> dma_buf_attach
> >>>>>>>> dma_map_attachment (buffer needs to be cleaned)
> >>>>>>>
> >>>>>>> Why does the buffer need to be cleaned here? I just got through r=
eading
> >>>>>>> the thread linked by Laura in the other reply. I do like +Brian's
> >>>>>>
> >>>>>> Actually +Brian this time :)
> >>>>>>
> >>>>>>> suggestion of tracking if the buffer has had CPU access since the=
 last
> >>>>>>> time and only flushing the cache if it has. As unmapped heaps nev=
er get
> >>>>>>> CPU mapped this would never be the case for unmapped heaps, it so=
lves my
> >>>>>>> problem.
> >>>>>>>
> >>>>>>>> [camera device writes to buffer]
> >>>>>>>> dma_buf_unmap_attachment (buffer needs to be invalidated)
> >>>>>>>
> >>>>>>> It doesn't know there will be any further CPU access, it could ge=
t freed
> >>>>>>> after this for all we know, the invalidate can be saved until the=
 CPU
> >>>>>>> requests access again.
> >>>>>
> >>>>> We don't have any API to allow the invalidate to happen on CPU acce=
ss
> >>>>> if all devices already detached. We need a struct device pointer to
> >>>>> give to the DMA API, otherwise on arm64 there'll be no invalidate.
> >>>>>
> >>>>> I had a chat with a few people internally after the previous
> >>>>> discussion with Liam. One suggestion was to use
> >>>>> DMA_ATTR_SKIP_CPU_SYNC in unmap_dma_buf, but only if there's at lea=
st
> >>>>> one other device attached (guarantees that we can do an invalidate =
in
> >>>>> the future if begin_cpu_access is called). If the last device
> >>>>> detaches, do a sync then.
> >>>>>
> >>>>> Conversely, in map_dma_buf, we would track if there was any CPU acc=
ess
> >>>>> and use/skip the sync appropriately.
> >>>>>
> >>>>
> >>>> Now that I think this all through I agree this patch is probably wro=
ng.
> >>>> The real fix needs to be better handling in the dma_map_sg() to deal
> >>>> with the case of the memory not being mapped (what I'm dealing with =
for
> >>>> unmapped heaps), and for cases when the memory in question is not ca=
ched
> >>>> (Liam's issue I think). For both these cases the dma_map_sg() does t=
he
> >>>> wrong thing.
> >>>>
> >>>>> I did start poking the code to check out how that would look, but t=
hen
> >>>>> Christmas happened and I'm still catching back up.
> >>>>>
> >>>>>>>
> >>>>>>>> dma_buf_detach  (device cannot stay attached because it is being=
 sent down=20
> >>>>>>>> the pipeline and Camera doesn't know the end of the use case)
> >>>>>>>>
> >>>>>>>
> >>>>>>> This seems like a broken use-case, I understand the desire to kee=
p
> >>>>>>> everything as modular as possible and separate the steps, but at =
this
> >>>>>>> point no one owns this buffers backing memory, not the CPU or any
> >>>>>>> device. I would go as far as to say DMA-BUF should be free now to
> >>>>>>> de-allocate the backing storage if it wants, that way it could ge=
t ready
> >>>>>>> for the next attachment, which may change the required backing me=
mory
> >>>>>>> completely.
> >>>>>>>
> >>>>>>> All devices should attach before the first mapping, and only let =
go
> >>>>>>> after the task is complete, otherwise this buffers data needs cop=
ied off
> >>>>>>> to a different location or the CPU needs to take ownership in-bet=
ween.
> >>>>>>>
> >>>>>
> >>>>> Yeah.. that's certainly the theory. Are there any DMA-BUF
> >>>>> implementations which actually do that? I hear it quoted a lot,
> >>>>> because that's what the docs say - but if the reality doesn't match
> >>>>> it, maybe we should change the docs.
> >>>>>
> >>>>
> >>>> Do you mean on the userspace side? I'm not sure, seems like Android
> >>>> might be doing this wrong from what I can gather. From kernel side i=
f
> >>>> you mean the "de-allocate the backing storage", we will have some ca=
ses
> >>>> like this soon, so I want to make sure userspace is not abusing DMA-=
BUF
> >>>> in ways not specified in the documentation. Changing the docs to for=
ce
> >>>> the backing memory to always be allocated breaks the central goal in
> >>>> having attach/map in DMA-BUF separate.

Actually I meant in the kernel, in exporters. I haven't seen anyone
using the API as it was intended (defer allocation until first map,
migrate between different attachments, etc.). Mostly, backing storage
seems to get allocated at the point of export, and device mappings are
often held persistently (e.g. the DRM prime code maps the buffer at
import time, and keeps it mapped: drm_gem_prime_import_dev).

I wasn't aware that CPU access before first device access was
considered an abuse of the API - it seems like a valid thing to want
to do.

> >>>>
> >>>>>>>> //buffer is send down the pipeline
> >>>>>>>>
> >>>>>>>> // Usersapce software post processing occurs
> >>>>>>>> mmap buffer
> >>>>>>>
> >>>>>>> Perhaps the invalidate should happen here in mmap.
> >>>>>>>
> >>>>>>>> DMA_BUF_IOCTL_SYNC IOCT with flags DMA_BUF_SYNC_START // No CMO =
since no=20
> >>>>>>>> devices attached to buffer
> >>>>>>>
> >>>>>>> And that should be okay, mmap does the sync, and if no devices ar=
e
> >>>>>>> attached nothing could have changed the underlying memory in the
> >>>>>>> mean-time, DMA_BUF_SYNC_START can safely be a no-op as they are.
> >>>>>
> >>>>> Yeah, that's true - so long as you did an invalidate in unmap_dma_b=
uf.
> >>>>> Liam was saying that it's too painful for them to do that every tim=
e a
> >>>>> device unmaps - when in many cases (device->device, no CPU) it's no=
t
> >>>>> needed.
> >>>>
> >>>> Invalidates are painless, at least compared to a real cache flush, j=
ust
> >>>> set the invalid bit vs actually writing out lines. I thought the iss=
ue
> >>>> was on the map side.
> >>>>
> >>>
> >>> Invalidates aren't painless for us because we have a coherent system =
cache=20
> >>> so clean lines get written out.
> >>
> >> That seems very broken, why would clean lines ever need to be written
> >> out, that defeats the whole point of having the invalidate separate fr=
om
> >> clean. How do you deal with stale cache lines? I guess in your case th=
is
> >> is what forces you to have to use uncached memory for DMA-able memory.
> >>
> >=20
> > My understanding is that our ARM invalidate is a clean + invalidate, I =
had=20
> > concerns about the clean lines being written to the the system cache as=
=20
> > part of the 'clean', but the following 'invalidate' would take care of=
=20
> > actually invalidating the lines (so nothign broken).
> > But i am probably wrong on this and it is probably smart enough not to =
the=20
> > writing of the clean lines.
> >=20
>=20
> You are correct that for a lot of ARM cores "invalidate" is always a
> "clean + invalidate". At first I thought this was kinda silly as there
> is now no way to mark a dirty line invalid without it getting written
> out first, but if you think about it any dirty cache-line can be written
> out (cleaned) at anytime anyway, so this doesn't actually change system
> behavior. You should just not write to memory (make the line dirty)
> anything you don't want eventually written out.
>=20
> Point two, it's not just smart enough to not write-out clean lines, it
> is guaranteed not to write them out by the spec. Otherwise since
> cache-lines can be randomly filled if those same clean lines got written
> out on invalidate operations there would be no way to maintain coherency
> and things would be written over top each other all over the place.
>=20
> > But regardless, targets supporting a coherent system cache is a legitam=
ate=20
> > configuration and an invalidate on this configuration does have to go t=
o=20
> > the bus to invalidate the system cache (which isn't free) so I dont' th=
ink
> > you can make the assumption that invalidates are cheap so that it is ok=
ay=20
> > to do them (even if they are not needed) on every dma unmap.
> >=20
>=20
> Very true, CMOs need to be broadcast to other coherent masters on a
> coherent interconnect (and the interconnect itself if it has a cache as
> well (L3)), so not 100% free, but almost, just the infinitesimal cost of
> the cache tag check in hardware. If there are no non-coherent devices
> attached then the CMOs are no-ops, if there are then the data needs to
> be written out either way, doing it every access like is done with
> uncached memory (- any write combining) will blow away any saving made
> from the one less CMO. Either way you lose with uncached mappings of
> memory. If I'm wrong I would love to know.
>=20

From what I understand, the current DMA APIs are not equipped to
handle having coherent and non-coherent devices attached at the same
time. The buffer is either in "CPU land" or "Device land", there's no
smaller granule of "Coherent Device land" or "Non-Coherent Device
land".

I think if there's devices which are making coherent accesses, and
devices which are making non-coherent accesses, then we can't support
them being attached at the same time without some enhancements to the
APIs.

> >>> And these invalidates can occur on fairly large buffers.
> >>>
> >>> That is why we haven't went with using cached ION memory and "trackin=
g CPU=20
> >>> access" because it only solves half the problem, ie there isn't a way=
 to=20
> >>> safely skip the invalidate (because we can't read the future).
> >>> Our solution was to go with uncached ION memory (when possible), but =
as=20
> >>> you can see in other discussions upstream support for uncached memory=
 has
> >>> its own issues.
> >>>

@Liam, in your problematic use-cases, are both devices detached when
the buffer moves between them?

 1) dev 1 map, access, unmap
 2) dev 1 detach
 3) (maybe) CPU access
 4) dev 2 attach
 5) dev 2 map, access

I still think a pretty pragmatic solution is to use
DMA_ATTR_SKIP_CPU_SYNC until the last device detaches. That won't work
if your access sequence looks like above...

...however, if your sequence looks like above, then you probably need
to keep at least one of the devices attached anyway. Otherwise, per
the API, the buffer could get migrated after 2)/before 5). That will
surely hurt a lot more than an invalidate.

> >>
> >> Sounds like you need to fix upstream support then, finding a way to dr=
op
> >> all cacheable mappings of memory you want to make uncached mappings fo=
r
> >> seems to be the only solution.
> >>
> >=20
> > I think we can probably agree that there woudln't be a good way to remo=
ve=20
> > cached mappings without causing an unacceptable performance degradation=
=20
> > since it would fragment all the nice 1GB kernel mappings we have.
> >=20
> > So I am trying to find an alternative solution.
> >=20
>=20
> I'm not sure there is a better solution. How hard is this solution to
> implement anyway? The kernel already has to make gaps and cut up that
> nice 1GB mapping when you make a reserved memory space in the lowmem
> area, so all the logic is probably already implemented. Just need to
> allow it to be hooked into from Ion when doing doing the uncached mapping=
s.
>=20

I haven't looked recently, but I'm not sure the early memblock code
can be reused as-is at runtime. I seem to remember it makes a bunch of
assumptions about the fact that it's running "early".

If CPU uncached mappings of normal system memory is really the way
forward, I could envisage a heap which maintains a pool of chunks of
memory which it removed from the kernel mapping. The pool could grow
(remove more pages from the kernel mapping)/shrink (add them back to
the kernel mapping) as needed.

John Reitan implemented a compound-page heap, which used compaction to
get a pool of 2MB contiguous pages. Something like that would at least
prevent needing full 4kB granularity when removing things from the
kernel mapping.

Even better, could it somehow be restricted to a region which is
already fragmented? (e.g. the one which was used for the default CMA
heap)

Thanks,
-Brian

> >>>>>
> >>>>>>>
> >>>>>>>> [CPU reads/writes to the buffer]
> >>>>>>>> DMA_BUF_IOCTL_SYNC IOCTL with flags DMA_BUF_SYNC_END // No CMO s=
ince no=20
> >>>>>>>> devices attached to buffer
> >>>>>>>> munmap buffer
> >>>>>>>>
> >>>>>>>> //buffer is send down the pipeline
> >>>>>>>> // Buffer is send to video device (who does compression of raw d=
ata) and=20
> >>>>>>>> writes to a file
> >>>>>>>> dma_buf_attach
> >>>>>>>> dma_map_attachment (buffer needs to be cleaned)
> >>>>>>>> [video device writes to buffer]
> >>>>>>>> dma_buf_unmap_attachment=20
> >>>>>>>> dma_buf_detach  (device cannot stay attached because it is being=
 sent down=20
> >>>>>>>> the pipeline and Video doesn't know the end of the use case)
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>> Also ION no longer provides DMA ready memory, so if you are no=
t doing CPU=20
> >>>>>>>>>> access then there is no requirement (that I am aware of) for y=
ou to call=20
> >>>>>>>>>> {begin,end}_cpu_access before passing the buffer to the device=
 and if this=20
> >>>>>>>>>> buffer is cached and your device is not IO-coherent then the c=
ache maintenance
> >>>>>>>>>> in ion_map_dma_buf and ion_unmap_dma_buf is required.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> If I am not doing any CPU access then why do I need CPU cache
> >>>>>>>>> maintenance on the buffer?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Because ION no longer provides DMA ready memory.
> >>>>>>>> Take the above example.
> >>>>>>>>
> >>>>>>>> ION allocates memory from buddy allocator and requests zeroing.
> >>>>>>>> Zeros are written to the cache.
> >>>>>>>>
> >>>>>>>> You pass the buffer to the camera device which is not IO-coheren=
t.
> >>>>>>>> The camera devices writes directly to the buffer in DDR.
> >>>>>>>> Since you didn't clean the buffer a dirty cache line (one of the=
 zeros) is=20
> >>>>>>>> evicted from the cache, this zero overwrites data the camera dev=
ice has=20
> >>>>>>>> written which corrupts your data.
> >>>>>>>>
> >>>>>>>
> >>>>>>> The zeroing *is* a CPU access, therefor it should handle the need=
ed CMO
> >>>>>>> for CPU access at the time of zeroing.
> >>>>>>>
> >>>>>
> >>>>> Actually that should be at the point of the first non-coherent devi=
ce
> >>>>> mapping the buffer right? No point in doing CMO if the future acces=
ses
> >>>>> are coherent.
> >>>>
> >>>> I see your point, as long as the zeroing is guaranteed to be the fir=
st
> >>>> access to this buffer then it should be safe.
> >>>>
> >>>> Andrew
> >>>>
> >>>>>
> >>>>> Cheers,
> >>>>> -Brian
> >>>>>
> >>>>>>> Andrew
> >>>>>>>
> >>>>>>>> Liam
> >>>>>>>>
> >>>>>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Foru=
m,
> >>>>>>>> a Linux Foundation Collaborative Project
> >>>>>>>>
> >>>>
> >>>
> >>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >>> a Linux Foundation Collaborative Project
> >>>
> >>
> >=20
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> >=20
