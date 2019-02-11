Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22E3206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="LFjNdOdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfBKGrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:47:36 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.208]:23380 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfBKGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:47:35 -0500
Received: from [67.219.251.54] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-west-2.aws.symcld.net id 83/A2-12728-28A116C5; Mon, 11 Feb 2019 06:47:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwTdxjH+d1bD8Kxs8B4bErnGucL2oYyEs/
  EZFuyPxqTJcv8Z2NEPcrZXlYK6ZUAbksKDmQgSkOkWZHIixkMxZcqmUptDFgNMKeyQXQSG5Q/
  VjEsjDm2yNA7fui2v+7z/L7fe77P7/IcS+r/YQysVOmTvB7RbWZSKNev04SlxiAW5nYFNwhnR
  q+TwszVg0gIHr2NhCtzbbTw3ckYIbQFDxBCZ90JSvjp8jFGOBC4rxMC9ROEUHfuKRIisXry3V
  R7dyRB2Bvblin74D0/Y+8+3ELbf4tOMPYfOq7p7Athk/1WfFn3IVtAy56i0sq9tKsn0E+UDZo
  qpy4O0H70FTSgFFbPP0ZwM7pI4OIGgru9tbRWUHwvCc2tt1eVAAHn2xdIXMQR1HR2Mg0omWX4
  zTDyZJLUOEPl8WNPaI1J/hAFF0ZyNE7nP4Gx6iCNPQXQ0pNY5Tw4//AmpTHFvwWHR+eQxhxfC
  N8v1VA4rBZBV/WfKwHJ/KewdPy5TmPEZ0PrwziBw7KgvTW00hR4Hk5EbpGYMyHxaFk9Z1X/Rz
  B3YTc+fgOOnGyiMGfD+PFGpGUBP41gLNyNsPABzDb9tSrcQxBpXCCwkAOzd/tXTQZYfDSvw/w
  ZXHkwwWA2wul4H4NfHqOh+ZcI0qbQ80XQ/0zGHhP0NU1TzWhL6D93wLwVOgZ/ZzBvgW87Z8nQ
  yodZAyPfzFAdiOpDQpFXdrp8JaLstthycy02W57F9vY29ZlvFfdbHNZyxVIhKT5LnlWsUKxKV
  YnDXWz1SL4wUlexuOxr70WUaHAOobUsYc7komlioT6tqLS4yiUqrj3ecrekDCEjy5qBi4Gqrf
  FKTqlyn+xW9/mlDGyqOYM7pcmcUiaWKLITS6PIwl7tmm4n9ZSn1CMZsrhezcRrJle551WLl3/
  FOMo2pHMoKSlJn1omeUtk3//1xyiLReZ0blLrkip7fK+S1P1V58/gUtbt1Ybwif9KBj8abnFU
  b9y5af7sfUdPee2RQ1PJz+Y/Hp7JythRf2djniEeMu6fop8O7Kuw7Ty7fZtvV2FivXPAtNv0W
  oGjLxKojmV++boQCx3Nfj70ID8tXgeXZnb8HZOH74Tz09bdiL7386TnsnPR7/9cXAzXvU9vrX
  on+uMXwe6lN41/TBqdBbu6zJTiEm05pFcRXwAYXoLlEAQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-30.tower-366.messagelabs.com!1549867646!1243504!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 984 invoked from network); 11 Feb 2019 06:47:30 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-30.tower-366.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Feb 2019 06:47:30 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 1da5_9314_35dbeba0_4a06_4a8f_a413_036764010956;
        Mon, 11 Feb 2019 06:47:14 +0000
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.58)
 by HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 11 Feb 2019 14:47:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2GaBCaY2PwKiiKuSEmTnoNEZtK918fhskoZPanPoWc=;
 b=LFjNdOdottHqBerUN8DbAr1ijcj8MRZa3TFoNCjQK6IxZ8+YwildI52WnH8JbFE/iUdKaCtpXTkwO+SPH2nbo5mct0cy603HTyj1T+OiiXjhXJ1kaerlAJmGrSvDbHE9187EaqeNzmQV45TMWCVC9fR0UZgyQxq5fb6cEYl6xv4=
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com (10.170.158.23) by
 HK2PR03MB0835.apcprd03.prod.outlook.com (10.161.188.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.12; Mon, 11 Feb 2019 06:47:06 +0000
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::d09d:c8a4:84e7:b581]) by HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::d09d:c8a4:84e7:b581%6]) with mapi id 15.20.1622.016; Mon, 11 Feb 2019
 06:47:06 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>, "jack@suse.cz" <jack@suse.cz>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH v3 0/5] Optimize writecache when using
 pmem as cache
Thread-Topic: [External]  Re: [PATCH v3 0/5] Optimize writecache when using
 pmem as cache
Thread-Index: AQHUvHzF1OYq+PybTkqmuMmULAM/KaXaHd9Q
Date:   Mon, 11 Feb 2019 06:47:06 +0000
Message-ID: <HK2PR03MB4418513AEBCD96612ED2CC9C92640@HK2PR03MB4418.apcprd03.prod.outlook.com>
References: <20190131022955.9920-1-yehs2007@zoho.com>
 <alpine.LRH.2.02.1902040606380.28217@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1902040606380.28217@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0835;20:9rGbkGIlYLftpTI+oi8IPHwW4C9aO0aNj6Wdy80RQ/4mArd4b/cPy+I4K3klUQagL0DuRKF9LRuJWVAUfT0nG055uEhGllb7BgGrJfMF4UyHqkT8MoPfx7VbKQRSL8R5ZpRDGAw0X6XVM+Ld+3mbffkzi+8z3vtQoJq2+C2BHhc=
x-ms-office365-filtering-correlation-id: 513f2695-e578-4fb0-63e0-08d68fecbcfb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0835;
x-ms-traffictypediagnostic: HK2PR03MB0835:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <HK2PR03MB08352E9D9916D3E3B997B17A92640@HK2PR03MB0835.apcprd03.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39850400004)(366004)(376002)(136003)(199004)(189003)(6506007)(25786009)(7696005)(68736007)(6916009)(186003)(33656002)(26005)(71190400001)(71200400001)(102836004)(14444005)(99286004)(229853002)(8676002)(76176011)(446003)(66066001)(256004)(11346002)(97736004)(476003)(486006)(53936002)(106356001)(6246003)(6116002)(3846002)(86362001)(54906003)(74316002)(105586002)(55016002)(14454004)(2906002)(316002)(81156014)(966005)(7416002)(6436002)(8936002)(6306002)(4326008)(81166006)(478600001)(9686003)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0835;H:HK2PR03MB4418.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h6oTleLZhurKdN0NB9wsLJoLH3IyTmCFkv8Ka3Fbo5POjHay5tTvpu+WKTDLN6CV7ydbN/+ll+Myf/i7DFELlEKfB4r5PfXedwn6XMETyUyWeET7w3BOHfDELBw+stKrgB77MHqMRKpLlCo54uAl6e/4mqY9dD1lWCuC8jFWBEkZ1itiwlTCgNtFCGJH/tQ3bvHqsWsdpoNUaDZmGOgV0p03buDtwMuODIXS9xS87hRYdbpHAJDo3QxVR0oacpmTSL6v8a3Zu6IJrouRd/7ZLqBI/t5bnA6WajLujaeBG0z3tRlOTcPSJUl6YTtyuhzKe//vEw/mwFK5BbR9BVxqjDs0qo2aB21ZhACO8PMiiz+cm7cqzR4B0TSJ9/wYAjDbeinQS89vLhxaIN/ZMHCBzTrrp5eFCrGrv9/4ZXKK02c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 513f2695-e578-4fb0-63e0-08d68fecbcfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 06:47:06.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mikulas Patocka <mpatocka@redhat.com>
> Sent: Monday, February 04, 2019 7:28 PM
> On Thu, 31 Jan 2019, Huaisheng Ye wrote:
>=20
> > From: Huaisheng Ye <yehs1@lenovo.com>
> >
> > This patch set could be used for dm-writecache when use persistent
> > memory as cache data device.
> >
> > Patch 1 and 2 go towards removing unused parameter and codes which
> > actually doesn't really work.
>=20
> I agree that there is some unused variables and code, but I would let it
> be as it is. The processors can write data to persistent memory either by
> using non-temporal stores (the movnti instruction) or by normal stores
> followed by the clwb instruction.
>=20
> Currently, the movnti instruction is faster - however, it may be possible
> that with some newer processors, the clwb instruction could be faster -
> and in that case, we need the code that you have removed.
>=20
> I would like to keep both flush strategies around (movnti and clwb), so
> that we can test how do they perform on various processors.
> Unfortunatelly, some upstream developers hate code with #ifdefs :-(
>=20
> Note that compiler optimizations already remove the unused parameter and
> the impossible code behind "if (WC_MODE_PMEM(wc)) if (!WC_MODE_PMEM(wc))"=
.

Hi Mikulas,

Thanks for your reply, now I could understand the code flow of dm-writecach=
e better
than before.

In the process of playing around the code, I found that writecache_flush wo=
uld try
to free earlier committed entry with lower seq-count. More seriously is tha=
t, writecache_flush
must check it for all entries which hasn't been committed. That's a lot of =
work to do when
there are many entries need to be flushed.

I have a plan for writecache_map to avoid using free entry when the committ=
ed writecache
has been hit. Does it make sense to simple the code flow, especially for sa=
ving additional rb-tree
node insertion and free steps?

Cheers,
Huaisheng Ye

> > Patch 3 and 4 are targeted at solving problem fn ctr failed to work
> > due to invalid magic or version, which is caused by the super block
> > of pmem has messy data stored.
>=20
> LVM zeros the beginning of new logical volumes, so there should be no
> problem with it. If the user wants to use the writecache target without
> LVM, he should zero the superblock with dd if=3D/dev/zero of=3D/dev/pmem0
> bs=3D4k count=3D1
>=20
> Note that other device mapper targets also follow this policy - for
> example see drivers/md/dm-snap-persistent.c:
>         if (le32_to_cpu(dh->magic) =3D=3D 0) {
>                 *new_snapshot =3D 1;
>                 return 0;
>         }
>=20
>         if (le32_to_cpu(dh->magic) !=3D SNAP_MAGIC) {
>                 DMWARN("Invalid or corrupt snapshot");
>                 r =3D -ENXIO;
>                 goto bad;
>         }
>=20
> So, I think there is no need for these patches - dm-writecache just does
> what others targets do.
>=20
> > Patch 5 is used for getting the status of seq_count.
>=20
> It may be accepted if other LVM team members find some use for this value=
.
>=20
> Mikulas
>=20
> > Changes Since v2:
> >         - seq_count is important for flush operations, output it within=
 status
> >           for debugging and analyzing code behavior.
> > 	[1]: https://lkml.org/lkml/2019/1/3/43
> >         [2]: https://lkml.org/lkml/2019/1/9/6
> >
> > Huaisheng Ye (5):
> >   dm-writecache: remove unused size to writecache_flush_region
> >   dm-writecache: get rid of memory_data flush to writecache_flush_entry
> >   dm-writecache: expand pmem_reinit for struct dm_writecache
> >   Documentation/device-mapper: add optional parameter reinit
> >   dm-writecache: output seq_count within status
> >
> >  Documentation/device-mapper/writecache.txt |  4 ++++
> >  drivers/md/dm-writecache.c                 | 23 +++++++++++++---------=
-
> >  2 files changed, 17 insertions(+), 10 deletions(-)
> >
> > --
> > 1.8.3.1
> >
> >
