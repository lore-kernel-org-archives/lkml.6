Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE01C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D73F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="KNRcy7hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D73F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeG3JER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:04:17 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.114]:22274 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726416AbeG3JEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:04:15 -0400
Received: from [67.219.250.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-west-2.aws.symcld.net id 2C/61-01618-59EBE5B5; Mon, 30 Jul 2018 07:30:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTfUwbZRzee3e9HoTOd4WFn2SgaVzCmG1oUfP
  6x4yGGC9my8QscRkV1kJt62hL2iIfugSsAwNhAwygdDA2dIx9sFGMTMbHaITSfVDGotlAQdjm
  Bs5NB1OUD73j2NT763l+z3PP73kv93K0ckwew5ny3Can3ZClYsMZc9yMRl3dk5aa+Ekgipy+M
  ECTEz8cYMnI4hwitUUhOamtHkZk8HoRS7rveWXE03SaJQPD0wzx1noocqnMRrq6gwy52nmQJZ
  7KMTmpOOyhSXNgmSKVtxcYMjtULCfFbQ8RCS0FZGS0YoAiC/OCuav/Y/rlaN5beIXh+6b8LN9
  +LIFv6pqm+KuXc/iGYArfW39Szpd5lxn+t1ujDH+/51uWv9T4jZxvv/g+P+uL40vOl1G87+Yv
  FB+aWJa/gXfJrHajI2+3zFJcUoqyl3DetWZbIbqmKEXhnBJPIzgxd4SWSD+C1tlhSiQMPkZDT
  9HgqrKfgt8XL1MSmUDwkc8vkDCOxZsgePe7FVcUrkFw8k6tXCQ0PsKBf+GgTHRF4rfgi+59go
  sTXDthstckjqOwDvaNn0EiZvBG6OyrYESswHoovH5DLtqV+HnwtKWI4zD8Apxtu7KyF+FYqJm
  aWME0job6mrqVTYAxfN4VoiW8HqZvLMvEGITfhHtfpkljFXQcKJVLOBZGDpUhsTHgchrOdUyu
  5myDhiYPKwkBBF/1/rUamgD186dYMRTwHhiozpDGO+H8T/OshOPgePkkI73ro+HWvFQU8AZoK
  R5c3Twng4clWyuQpu4/Z5Dws9B47gEr4c1w9PDPdN3KZ1kHwc9uMo2IOY6I0Wk1W9w2gzVLrU
  1MVGu1OrU2KUmtfe5FjaFAbdTkuNS5JpdbrdMYcl0aV74tIytTYze5fUj4xdcIz1k0fyfTj57
  kKNV6BWPTpyrXGh2Z+RaDy5LuzMkyufxoA8epQJHenZaqXOc0mU1571izhHvySAYuQhWlKBBl
  hSvbYHNZzZJ0ASVxDS1VVTS3eL+6ilYydofdFBOt8IpWLFotOfbHQY/u3AiKjYlUIKGaMiLb5
  LRZ3f/XZ1A0h1SRinwxJcJqdz/eNyNUoYQqm3e8LVZxG/6VYgrRruCnmR8q+4x/41MF+tq05F
  DHE8/o95RPjVeM16Sbc/9c+sM33rl1x2u68g+2V27Uz4zGb3l3aIp97/U1rReZUPzedrM2cKh
  mb1JKfPOPr7xk19QFi/q9c1FH87aEf6//+lc/6FoyOna3licHHzzluD0y9nTYNot/+36dQzn0
  au/au8kqxmUxaBNop8vwD3IYqH1uBAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-11.tower-346.messagelabs.com!1532935815!1421961!1
X-Originating-IP: [103.30.234.46]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12258 invoked from network); 30 Jul 2018 07:30:28 -0000
Received: from unknown (HELO apsmtp03.lenovo.com) (103.30.234.46)
  by server-11.tower-346.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Jul 2018 07:30:28 -0000
Received: from HKGWPEXCH01.lenovo.com (unknown [10.128.62.30]) by apsmtp03.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 6099_18cb_e9c22e37_e18c_48ff_b39d_8059d9fc7171;
        Mon, 30 Jul 2018 15:30:12 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (65.55.88.22) by
 HKGWPEXCH01.lenovo.com (10.128.62.30) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Mon, 30 Jul 2018 15:30:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhDxMpCDQLbcNZgoxK86lEV+GSZYT8iAsZYQ8p89YaY=;
 b=KNRcy7hVVjv6ETAKKJCxoAaizTPeHRH1uh6wIm28cgqA+8JT18vVZwdsUcuQEKZir6zAUHPtpoGFAWFW/WJPcvm5eM5Y/THOGG3tE0y+3Bevlyd7Br79UBaaLBqLDno6FXXjSfBz92hOHag4nV/+3nkh2HO+/XkKaoV+6iXntHY=
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com (20.177.20.145) by
 TY2PR03MB3614.apcprd03.prod.outlook.com (20.177.22.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.8; Mon, 30 Jul 2018 07:30:07 +0000
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::2970:a034:38d1:9afe]) by TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::2970:a034:38d1:9afe%2]) with mapi id 15.20.1017.010; Mon, 30 Jul 2018
 07:30:07 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Huaisheng Ye <yehs2007@zoho.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "jack@suse.cz" <jack@suse.cz>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "colyli@suse.de" <colyli@suse.de>,
        "NingTing Cheng" <chengnt@lenovo.com>
Subject: RE: [External]  [PATCH v3 0/6] kaddr and pfn can be NULL to
 ->direct_access()
Thread-Topic: [External]  [PATCH v3 0/6] kaddr and pfn can be NULL to
 ->direct_access()
Thread-Index: AQHUJ9WH5zyztuES2kqSHgsXOFvGeKSnXaLA
Date:   Mon, 30 Jul 2018 07:30:07 +0000
Message-ID: <TY2PR03MB3343C33E4D747830A550438E922F0@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180730071548.9172-1-yehs2007@zoho.com>
In-Reply-To: <20180730071548.9172-1-yehs2007@zoho.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [221.219.122.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR03MB3614;20:Py4AUaHSGA4Mmq2kjGwPIxmd5KhFe/PqozvqdE+/76uPE7YhQg5B0PF7fP4PPj8m54F2MSA3qd5e7aiQPXEiNUrgfev5fJOhazsN6FpXBL9hWKw2hh+6CdtImGyicuKiEXTxwE3ZOGQbqrev8AtwztuE2g+I961pQX/uk1EPVkq9GnxtgfhqrOHlbWkaCk4p18v8OC8LJruIbtx10R4G3u+n6r0opsRr4piazO/sQQaBOqjwpa/hRQgY//G7C6bN1Az3sXSTxkssl3L/Gx6uN+m3PMan01xO8pfROiS0Ajs2DakfhsYJW6k5prQSHyP7ilWIjas1kcoRbSdciW2J9Q==
x-ms-office365-filtering-correlation-id: c4e025fe-a123-4779-a5a4-08d5f5ee46a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR03MB3614;
x-ms-traffictypediagnostic: TY2PR03MB3614:
x-microsoft-antispam-prvs: <TY2PR03MB36148EDAD92C589EEADEE960922F0@TY2PR03MB3614.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(788757137089)(247784426924974);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY2PR03MB3614;BCL:0;PCL:0;RULEID:;SRVR:TY2PR03MB3614;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(396003)(366004)(376002)(136003)(189003)(199004)(7416002)(105586002)(2900100001)(446003)(476003)(11346002)(486006)(5660300001)(110136005)(106356001)(54906003)(6436002)(2201001)(81156014)(81166006)(97736004)(3846002)(6116002)(2906002)(305945005)(74316002)(9686003)(6306002)(55016002)(7736002)(229853002)(8676002)(2501003)(5250100002)(6246003)(14444005)(33656002)(14454004)(53936002)(256004)(86362001)(478600001)(107886003)(966005)(4326008)(8936002)(7696005)(76176011)(316002)(99286004)(25786009)(186003)(6506007)(68736007)(66066001)(26005)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR03MB3614;H:TY2PR03MB3343.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (HKGWPEXCH01.lenovo.com: yehs1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WjlXBHvtU+hGWna8tRTdEj14g3mK0R+jvukeFdFJZDBIE0oq/iwIfSpmDM47uoXKsHxxyUhLMo6Bej3i8MHAH0Kpmly3g3PL0LYpn7k+xdXTYLiNdFf2pI78fc8up6Km9TBEYV8EmZzCWJVociBWmF437JzICA4EAp1un28XskP4oraR7v66jl8A2g27Jg7ynJIVoJ44PTUZqqLHK5VtzXLE5jIsPUEZKAiYWsZ4WbOkgX/gCHTQUPUgWUGft8cDKGfaApgjLj9OOPIvndsZ0ZcTxn4Mr92MQMIUJUt1hPRQ2DsZkoo46W7RbVWMF36tXnS8o+ymFx5Kn2ikIku6hSIgqYyxpdjkfHB7hdMM8ys=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e025fe-a123-4779-a5a4-08d5f5ee46a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 07:30:07.7876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing one in changes log.

> From: Huaisheng Ye <yehs2007@zoho.com>
> Sent: Monday, July 30, 2018 3:16 PM
>=20
> From: Huaisheng Ye <yehs1@lenovo.com>
>=20
> Changes since v2 [2]:
> * Collect Martin and Mike's acks for dcssblk and dm-writecache;
> * Rebase the series of patch to v4.18-rc7.
* Collect Ross's reviewed-by for series.

>=20
> Changes since v1 [1]:
> * Involve the previous patches for pfn can be NULL.
> * Reword the patch descriptions according to Christian's comment.
> * According to Ross's suggestion, replace local pointer dummy_addr
>   with NULL within md/dm-writecache for direct_access.
>=20
> [1]: https://lkml.org/lkml/2018/7/24/199
> [2]: https://lkml.org/lkml/2018/7/25/581
>=20
> Some functions within fs/dax, dax/super and md/dm-writecache don't
> need to get local pointer kaddr or variable pfn from direct_access.
> Assigning NULL to kaddr or pfn with ->direct_access() is more
> straightforward and simple than offering a useless local pointer or
> variable.
>=20
> So all ->direct_access() need to check the validity of pointer kaddr
> and pfn for NULL assignment. If either of them is equal to NULL, that
> is to say callers may have no need for kaddr or pfn, so this series of
> patch are prepared for allowing them to pass in NULL instead of having
> to pass in a local pointer or variable that they then just throw away.
>=20
> Huaisheng Ye (6):
>   libnvdimm, pmem: kaddr and pfn can be NULL to ->direct_access()
>   s390, dcssblk: kaddr and pfn can be NULL to ->direct_access()
>   tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()
>   dax/super: Do not request a pointer kaddr when not required
>   md/dm-writecache: Don't request pointer dummy_addr when not required
>   filesystem-dax: Do not request kaddr and pfn when not required
>=20
>  drivers/dax/super.c             |  3 +--
>  drivers/md/dm-writecache.c      |  3 +--
>  drivers/nvdimm/pmem.c           |  7 +++++--
>  drivers/s390/block/dcssblk.c    |  8 +++++---
>  fs/dax.c                        | 13 ++++---------
>  tools/testing/nvdimm/pmem-dax.c | 12 ++++++++----
>  6 files changed, 24 insertions(+), 22 deletions(-)
>=20
> --
> 1.8.3.1
>=20

