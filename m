Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602ECC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188BB21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cju3DHep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfAWRL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:11:58 -0500
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:34054
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfAWRL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFsi30jHkN2GqIpYOtrtCWva5hOY5p5KA9YC7ze6zrE=;
 b=Cju3DHepVWkhCCEK2ESqMO831d+5X0pCTJTgPppOalqTy7wd4FRaM/maQJJZzVcU2eA3M0GGrECtrA0Bmzy2HOoxlg66Xz64Ng5sBQl3PQmHHof5rscTsj376T85QXo9qISBL0y6PE0EfxsYIYHR2OeX32mVy7ZHrVv8Sv6lvEo=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3171.eurprd08.prod.outlook.com (52.134.93.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Wed, 23 Jan 2019 17:11:53 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%3]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 17:11:53 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Thread-Topic: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Thread-Index: AQHUrQGAzRpl+6N4dEWaN50+01WrkqWwqYAAgAFaUACAAB1/AIAAYa0AgAElgYCAAJLkAIABDbeAgARUHICAAKdjgIABUooAgAGGmwCAAAW5gA==
Date:   Wed, 23 Jan 2019 17:11:53 +0000
Message-ID: <20190123171153.ql25gyg6sma4fpqb@DESKTOP-E1NTVVP.localdomain>
References: <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
 <4a5d4147-765d-711f-af98-9022d0253b3b@ti.com>
 <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com>
 <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com>
 <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com>
 <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
 <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
 <b89df12e-00bc-5484-6458-f7c85a362b42@ti.com>
 <CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com>
 <d24949d2-3736-0e6f-99ae-b8550d53a828@ti.com>
In-Reply-To: <d24949d2-3736-0e6f-99ae-b8550d53a828@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.50]
x-clientproxiedby: CWXP265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2e::32) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3171;6:DpAYpTiqtoKMslglt8/7mkRnBQRnkml+pjUE66NFGFgPgZkaF0BVYcDOUOaq6BfwfpKwYnlrwXa8yeNy6OkVDynKdABvGKFxRS5Vc/cvVWDut7iIbKV7c0jya8VYePjhYls7qOckPQaO0W0bJv9FWfaZYzxWn0A70NtY28gYsB1hRUaPR9XTS9EdTT6y2VbRY8zCWTJJffC4b6hsJN7VBW5siIW0KVdtG+2eYIbctiZSOMvFOfwX0IBr3uDhYRVnDCtQ1Erogljm84PaXssMJov0GamMrieV0mMWr4ghdbBeavhxtURjb6wCygQ/30sXCZmzxSznh3x49+5nn8FYJw1XEiBFyYaaxZdgxhw/to1+tmNnTJgE3ewDoXI0mMoumQ4aq+ODdASqqhtVHIPIX/z3saxpJPpWzhYUL3IdvhbrCQ+1c+WcbSZv9bDxvSeItmUNfQ3JMyjatc5K11syOg==;5:hCntsSDl4kdGK1k6i1GziptEHDvlUhHPwfuenNXAFVXDLGpLqSJhmFKuCnDINUAaCmiEWEtBjVemP7Buf1QTr+wn1X81YYJ6/IE0ZYLl9H778HHPS8r55XtbZmm9KNng32CqtM8z7O5VwLoa0Jb8dZQeEQxj3v6CWTiE5Aq/7yctNVtV2/xmJ7yc7SH71Ns34lrktL27cPKZeTDIJyAV7A==;7:w3EiPJSlHMexFot/7Wa1Cyv6FRvMb+QkH9AnD2NsUly0treVYVaGtuiOFJQrRX9Va/OSaaVxzTTsbZoi9RC0nOkTbYxaTW7CV6O/bBAEqQ6t8hU74+NwUCPnpLRojl/ABoF6+GNYtdk8CrgSknOcWg==
x-ms-office365-filtering-correlation-id: 3ba43547-5cd7-4b86-a5c8-08d68155deed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3171;
x-ms-traffictypediagnostic: AM0PR08MB3171:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB317147F8128C84DBBE4BBD56F0990@AM0PR08MB3171.eurprd08.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(53754006)(66066001)(186003)(14454004)(72206003)(316002)(71190400001)(97736004)(71200400001)(102836004)(486006)(33896004)(478600001)(44832011)(106356001)(305945005)(256004)(14444005)(7736002)(446003)(26005)(966005)(5024004)(11346002)(8936002)(68736007)(81166006)(8676002)(81156014)(99286004)(105586002)(2906002)(7416002)(76176011)(4326008)(53546011)(54906003)(476003)(58126008)(9686003)(3846002)(6512007)(6306002)(6916009)(229853002)(6486002)(1076003)(6116002)(6246003)(52116002)(386003)(53936002)(6436002)(93886005)(25786009)(6506007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3171;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FPQcV4/mGhncHr8dHYOoq31Sx+AOk6PEi/11Trimp6SASIUNn5SNZC9ClP4k7uHfvUF6aplCeYz82EGG8PpnvWd+KYb0Ov8nAxRhZ7RMKCxjiFZcJ/3CZ5b0KHz7pK0ktCV/ky+FCATJw+Krc7MzfWh6fLPb38YrPge0niPqST5Ec1REwlNldSdOGWDE/9tOpQw7gxmzX5gc5zp/VMQ8Awg32LFceGyz6ZK0Fy1GmrQOnmPAQED5rNNW/K63ZSX0o1AIP3M6+AoSYIZUnAvScXYU9BtmNt7MeMs7k6h6WUD4A7LqLtdOqL8k9rUiRFNM/RoaxGqa3L9nuAj3m0wsdlWIKOge+CmN9n1RriCTw9V/6PpIHLgaQOJ1pKHml41MXu3CR2mwCzMeQ3jGrc2+t/5xKEnz34g603NYTJekGiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <63CE0C09706F2B46A17602B1D24C4724@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba43547-5cd7-4b86-a5c8-08d68155deed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 17:11:52.8881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Jan 23, 2019 at 10:51:24AM -0600, Andrew F. Davis wrote:
> On 1/22/19 11:33 AM, Sumit Semwal wrote:
> > Hello everyone,
> >=20
> > Sincere apologies for chiming in a bit late here, but was off due to
> > some health issues.
> >=20
>=20
> Hope you are feeling better friend :)
>=20
> Looks like this email was a bit broken and you replied again, the
> responses are a little different in each email, so I'd like to respond
> to bits of both, I'll fix up the formatting.
>=20
> > Also, adding Daniel Vetter to the mix, since he has been one of the
> > core guys who shaped up dma-buf as it is today.
> >=20
> > On Tue, 22 Jan 2019 at 02:51, Andrew F. Davis <afd@ti.com> wrote:
> >>
> >> On 1/21/19 5:22 AM, Brian Starkey wrote:
>=20
> [snip]
>=20
> >>>
> >>> Actually I meant in the kernel, in exporters. I haven't seen anyone
> >>> using the API as it was intended (defer allocation until first map,
> >>> migrate between different attachments, etc.). Mostly, backing storage
> >>> seems to get allocated at the point of export, and device mappings ar=
e
> >>> often held persistently (e.g. the DRM prime code maps the buffer at
> >>> import time, and keeps it mapped: drm_gem_prime_import_dev).
> >>>
> >>
> >=20
> > So I suppose some clarification on the 'intended use' part of dma-buf
> > about deferred allocation is due, so here it is: (Daniel, please feel
> > free to chime in with your opinion here)
> >=20
> >  - dma-buf was of course designed as a framework to help intelligent
> > exporters to defer allocation until first map, and be able to migrate
> > backing storage if required etc. At the same time, it is not a
> > _requirement_ from any exporter, so exporters so far have just used it
> > as a convenient mechanism for zero-copy.
> > - ION is one of the few dma-buf exporters in kernel, which satisfies a
> > certain set of expectations from its users.
> >=20
>=20
> The issue here is that Ion is blocking the ability to late allocate, it
> expects its heaps to have the memory ready at allocation time. My point
> being if the DMA-BUFs intended design was to allow this then Ion should
> respect that and also allow the same from its heap exporters.
>=20
> >> I haven't either, which is a shame as it allows for some really useful
> >> management strategies for shared memory resources. I'm working on one
> >> such case right now, maybe I'll get to be the first to upstream one :)
> >>
> > That will be a really good thing! Though perhaps we ought to think if
> > for what you're trying to do, is ION the right place, or should you
> > have a device-specific exporter, available to users via dma-buf apis?
> >=20
>=20
> I'm starting to question if Ion is the right place myself..
>=20
> At a conceptual level I don't believe userspace should be picking the
> backing memory type. This is because the right type of backing memory
> for a task will change from system to system. The kernel should abstract
> away these hardware differences from userspace as much as it can to
> allow portable code.
>=20
> For instance a device may need a contiguous buffer on one system but the
> same device on another may have some IOMMU. So which type of memory do
> we allocate? Same issue for cacheability and other properties.
>=20
> What we need is a central allocator with full system knowledge to do the
> choosing for us. It seems many agree with the above and I take
> inspiration from your cenalloc patchset. The thing I'm not sure about is
> letting the device drivers set their constraints, because they also
> don't have the full system integration details. For cases where devices
> are behind an IOMMU it is easy enough for the device to know, but what
> about when we have external MMUs out on the bus for anyone to use (I'm
> guessing you remember TILER..).
>=20
> I would propose the central allocator keep per-system knowledge (or
> fetch it from DT, or if this is considered policy then userspace) which
> it can use to directly check the attached devices and pick the right memo=
ry.
>=20
> Anyway the central system allocator could handle 90% of cases I can
> think of, and this is where Ion comes back in, the other cases would
> still require the program to manually pick the right memory (maybe for
> performance reasons, etc.).
>=20
> So my vision is to have Ion as the the main front-end for DMA-BUF
> allocations, and expose the central allocator through it (maybe as a
> default heap type that can be populated on a per-system basis), but also
> have other individual heap types exported for the edge cases where
> manual selection is needed like we do now.
>=20
> Hence why Ion should allow direct control of the dma_buf_ops from the
> heaps, so we can build central allocators as Ion heaps.
>=20
> If I'm off into the weeds here and you have some other ideas I'm all ears=
.
>=20

This is a topic I've gone around a few times. The crux of it is, as
you know, a central allocator is Really Hard. I don't know what you've
seen/done so far in this area, so please forgive me if this is old hat
to you.

Android's platform-specific Gralloc module actually does a pretty good
job, and because it's platform-specific, it can be simple. That does
have a certain appeal to it over something generic but complex.

It seems that generic gets insanely complicated really quickly -
picking out "compatible" is hard enough, but improving that to pick
out "optimal" is ... well, I've not seen any good proposals for that.

In case you didn't come across it already, the effort which seems to
have gained the most "air-time" recently is
https://github.com/cubanismo/allocator, which is still a userspace
module (perhaps some concepts from there could go into the kernel?),
but makes some attempts at generic constraint solving. It's also not
really moving anywhere at the moment.

Cheers,
-Brian

> Andrew
>=20
> >>> I wasn't aware that CPU access before first device access was
> >>> considered an abuse of the API - it seems like a valid thing to want
> >>> to do.
> >>>
> >>
> >> That's just it, I don't know if it is an abuse of API, I'm trying to g=
et
> >> some clarity on that. If we do want to allow early CPU access then tha=
t
> >> seems to be in contrast to the idea of deferred allocation until first
> >> device map, what is supposed to backing the buffer if no devices have
> >> attached or mapped yet? Just some system memory followed by migration =
on
> >> the first attach to the proper backing? Seems too time wasteful to be
> >> have a valid use.
> >>
> >> Maybe it should be up to the exporter if early CPU access is allowed?
> >>
> >> I'm hoping someone with authority over the DMA-BUF framework can clari=
fy
> >> original intentions here.
> >=20
> > I don't think dma-buf as a framework stops early CPU access, and the
> > exporter can definitely decide on that by implementing
> > begin_cpu_access / end_cpu_access operations to not allow early CPU
> > access, if it so desires.
> >=20
