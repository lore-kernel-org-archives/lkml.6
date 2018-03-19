Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477777-2-6513880056840103058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477776; b=gSW7lb/ga2UAlyUWwObv6Xi+ckW4slMdQZ0N70EIs5Ty4g0
    oHwhWdqZ+OpHLaQ45iL+GM/ALK06mNgFQzt8COV7825CDuNlMTOLGKxPL3cOKCT0
    /2MsxIELZuNgVbMeNsBmjjHKl/o06jZxMEJdH1Dm/ni/VwqLEaQd4gt2/YqbJ4/V
    O07Q4mm9d1DMdAXhRz76ZmMdldFgkxTAhvR/Wun+ypUKDIAz1pBxvvVdeP64TkyT
    zRwJ9BpeX8q1GTSv9Be6VyX6UyPvOMBbEjbi6b0Uzw/Z0kSLOMZq0rBnOe+plUsq
    g9/xQ45KF57zL0JHDmHgQqvgsT4cjJtyNHHMhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477776; bh=JJS1za
    iPsoau/T4YbFH4f4gNhogbaEbkkV/SNiQA6HA=; b=bZ4VQk1FHupsYgeQrssAnT
    5oqthTvPTIF7pJTD7QlyaMwY95D1HGEOk16OWAUorvlO04ZvDP4yX4rLg2WPjEkS
    dOMzDU/s1TEnzfobblNgJxADYQTG3IZE4gLeTe4mkp4oZG0mkBjos1MbQC5tFaeQ
    6IylDNLYMzfy8U8F3vbqyppqLeu5v1ZffFkCnXiFemFyseZKwVbbMDAmeJypV0lw
    Z9pc9LBYzlibqeJ+1QxXkJICUxXKGwIGV0Dvib0Tk32iXxqm9hymwbU8Fq8Ekith
    saL8ypfHgk/1/jGzSmvb1CnulLwxF7U1aQIEzrXyzol18PhLfJsGL6JRPvZiHGFA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l6NHatLf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduhedtnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l6NHatLf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduhedtnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966386AbeCSQml (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:42:41 -0400
Received: from mail-co1nam03on0119.outbound.protection.outlook.com ([104.47.40.119]:64870
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966823AbeCSQMx (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 041/102] libceph: NULL deref on
 crush_decode() error path
Thread-Topic: [PATCH AUTOSEL for 3.18 041/102] libceph: NULL deref on
 crush_decode() error path
Thread-Index: AQHTv50Q+aHxHTS520Ofn+gyIr+q7w==
Date: Mon, 19 Mar 2018 16:12:23 +0000
Message-ID: <20180319161117.17833-41-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:z5W6Fr2SHO17xrl//aIysBhQz/+3hFGeZJnLP0K3+hMqz9w7mdwp3LNUY6L9VtZS++ruPUhtEwZ6yCyjTa+qCNELjAss8Vdk5HodLxsGeMtqJ5T+0l2bywPocBv3NuBlPWBFZDvhpb+VwDat3D8pxBFfdDlo/wit+njrTwUr6P2Fate4ZLxt436mc0FRP8geRMqQMorbeFOarsFMhkNqbIV4zWEnx7IQQ87ekky8QfbyYKc7jf7krBlcXwyEj2mf;20:ouEr7dshyS9Uf3U86guWtD991/9u7XfXx9NDh2OVbXpIBfrOfEjh0GuSPRJTpUOSLLspAulCpzxWTxk4n9wey4OtTXnjDl6334auHyGqPEEqS33N2Z6cdr67NiqPrQxqZ9TdhySgU7yIfJYMC+Gm+qHEBhWt4g7LBIV1FjNzC6E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c67fa44-d5b1-4918-729b-08d58db443de
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112D41104D6439ACC48425BFBD40@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(189003)(53936002)(26005)(14454004)(36756003)(2501003)(186003)(305945005)(86362001)(107886003)(316002)(575784001)(7736002)(6506007)(110136005)(5250100002)(4326008)(2900100001)(25786009)(102836004)(105586002)(72206003)(10090500001)(54906003)(2950100002)(478600001)(39060400002)(99286004)(106356001)(6436002)(3280700002)(3660700001)(10290500003)(66066001)(2906002)(6486002)(76176011)(81166006)(81156014)(8676002)(68736007)(8936002)(5660300001)(6666003)(22452003)(86612001)(6116002)(3846002)(1076002)(97736004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1z7DxmfoaMuF/gEDEpTI71d/y0qFUXRy8hOsGvufeWU+foEp0a990Tm1L05lxDtb9OHc8CxafcKYPEMXA7hzq8TEkYQny7ySXvdPH+Z/2VScx5hAr39MD5xUBZz+Q1V8bjOuzMPkJKzxWkKDE6lc88fJ1Vc8Y4zYKZ9xAc5O68+H/sA4qJ+Vb9/kpPphYUkmTVMceJLbkxf1RRsi2jxJLYHWyhu0QsZZ/jjgleA8wrbIIvyncPvNcHo5q29BX+46m9YYIOYTB2At60SwTFX+/Wli7sAQX0pwgjJEOi1mF+MCvso5yOdsJQ0Dy8f+uNqCcvv41zlrN5vUDkMXcznwiQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c67fa44-d5b1-4918-729b-08d58db443de
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:23.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 293dffaad8d500e1a5336eeb90d544cf40d4fbd8 ]

If there is not enough space then ceph_decode_32_safe() does a goto bad.
We need to return an error code in that situation.  The current code
returns ERR_PTR(0) which is NULL.  The callers are not expecting that
and it results in a NULL dereference.

Fixes: f24e9980eb86 ("ceph: OSD client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ceph/osdmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8bb2e0c1cb50..c2f815d44914 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -270,6 +270,7 @@ static struct crush_map *crush_decode(void *pbyval, voi=
d *end)
 		u32 yes;
 		struct crush_rule *r;
=20
+		err =3D -EINVAL;
 		ceph_decode_32_safe(p, end, yes, bad);
 		if (!yes) {
 			dout("crush_decode NO rule %d off %x %p to %p\n",
--=20
2.14.1
