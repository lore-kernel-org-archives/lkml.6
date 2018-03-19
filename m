Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477685-2-1801476077242859532
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477684; b=B3/Tqkbn+czJUKUIMdmHtQ3L490lbUHO6WWqWW5Fu2LFt/E
    2aggeEIhvn3nFONSC9QrfBnuigF07MuoD50N6X3m2TmfJPlNt2NdCp9eqmL9LMnV
    oEdO7Xsl/3R2ntWSVRNb8I+yTj4qUT4EkIN67IaiEB7i/CDCwp4JXVcI67Q5njTs
    /7zfI5nrdgahWgu5AGHk6csLU3idlILow836HcQMlublS31KY3E/f4rILKK2evfI
    ka0vcWb75rXZ1BgJuwkmWWs4s4BouwyoMg0l8P7e18xDQlp3lhBox1k133LKQeMj
    NuGWBnNRlnZO+aWc9TL6jD3f3xV0B0sDEJUrZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477684; bh=JVrWuO
    uONZRXFel4VrpMVcIHa9kZJEHxXeRjW2MRAic=; b=RR6ImxHCSJ82jQ8v9JtmiC
    0vzxElW3Ae2zXay/zt0yOXlj9aJz34Mkh1NROVJZCbaM6HQepGoWf7YnFMtYRAyc
    75WTxhoY94luaqvX6Su/QratzdhbeHFA+vYUkVQQZsLWMKsaHxg8zEbhyQqkTQ0n
    rMMSqN7ZxZLdjih9GV/PDfY9qqpsOtAw20ABrFKLktjeUWWCSHaWI8K2HhvpuQhS
    e/ar3Jg7GENKR+iypQaFloKTNEXH0qM9lON8eXRIoIgrKiS1EzvuimF/8CxS1mO5
    ssKxMqa21qBdVTipKYen8V19t4lKpAmANOS+r9QwMDDguaALVxoz7rzqxDSuIcQA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JR3kSrct x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvdegnecuvehluhhsthgvrhfuihiivgephedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JR3kSrct x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvdegnecuvehluhhsthgvrhfuihiivgephedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966837AbeCSQM5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:12:57 -0400
Received: from mail-co1nam03on0094.outbound.protection.outlook.com ([104.47.40.94]:52832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965084AbeCSQMz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 040/102] block: fix an error code in
 add_partition()
Thread-Topic: [PATCH AUTOSEL for 3.18 040/102] block: fix an error code in
 add_partition()
Thread-Index: AQHTv50Quaz6iERKGk6NNDP0rldZJw==
Date: Mon, 19 Mar 2018 16:12:22 +0000
Message-ID: <20180319161117.17833-40-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:iVmroBArsSDkDuokCx3sic1YvFGB+EVW5iID6MYbLbUvWdGOd57jdZX1NY65CqoAJyJV1Ro2pDlSiOODpnepQ+oblwJTmtFRBdUA47cysgBgWM/Vft1eQUnBP21PVnEtz14mT36K7TieYqa+8E/I+efbGRJt6mD0oAvzu1xV1OaONMeZHD3LWY0k0eA33R+bk9ZBMWzMdvfIe4kzuS7gyS1LWjSjBHVwh51eF8oYVrev9JbcBBJvBgFfbIdraDM/;20:lKBY4b3VQY1I4sSgObPm8O7nuop0bOajOcLrhdg9IT9XFz2ZyZ5SfDk5HpACThUf9s+JSXcgeTJQ95TebD4i5u2gpiiDTnwLKdLH61fA766/bjss+KZ0TbPUkWYZt3vXMyrrb0vsFlSeXlbNfOMWYngJnWEAnSUsFSqDe9HGi4I=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef979570-5329-4b6b-275c-08d58db44395
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014E892C91FAEC95AD0885AFBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(575784001)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(76176011)(2900100001)(59450400001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DXSprYe4iLOsgOvWZ1KKQUMHjCM9mb9toCeyKB5Pe5BHZpaoU5lFSKR2qpg1iGaX/W95mEPVEj2fodCINeKOiloIrRRn7IseCB4i/9/+ZTC+1CyItqzUWxfWdyLDMmmfj5bofMGdIjJTV+Nc2bkP58fx7Mhv5b/OPT+4/p9BNUJQeG4Xtcv5hom/xOg8nNt5Pto6q4SHSnr4iOBy1WrLLk6JPZnOQ0u29KmncASHKi7ftAAwg/5x27otOu8P+RRE88Ri31D3Y5DhVgGRIJXLasvnHUvao2msPmN5yJaCWPHILV0Ea13oxm6aXTsYGreL6UxLiHfsdlSlnv7AapocbA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef979570-5329-4b6b-275c-08d58db44395
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:22.5380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7bd897cfce1eb373892d35d7f73201b0f9b221c4 ]

We don't set an error code on this path.  It means that we return NULL
instead of an error pointer and the caller does a NULL dereference.

Fixes: 6d1d8050b4bc ("block, partition: add partition_meta_info to hd_struc=
t")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/partition-generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 0d9e5f97f0a8..94de2055365e 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -309,8 +309,10 @@ struct hd_struct *add_partition(struct gendisk *disk, =
int partno,
=20
 	if (info) {
 		struct partition_meta_info *pinfo =3D alloc_part_info(disk);
-		if (!pinfo)
+		if (!pinfo) {
+			err =3D -ENOMEM;
 			goto out_free_stats;
+		}
 		memcpy(pinfo, info, sizeof(*info));
 		p->info =3D pinfo;
 	}
--=20
2.14.1
