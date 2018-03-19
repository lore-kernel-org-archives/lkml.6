Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475752-5-14340201429703298546
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
    t=1521475752; b=pbVdfGfKVgndcRlrXYhDnr6tfdvinTnG9rS/e+U7yCILRVc
    oxbK+NyRBKPsUNT0B+9e3fOB89H0gpCCpZ4u7J/YqTGYT34YhaEmEc5L1enXlJmg
    oqj63eGXWuvvsa+g7BPdBzBk0tZo9hgjJM0wVvexJvn0KoRj2Wpp/c426PzMtFh0
    Qstem20yjVhH1AqVdQ4ORLxhH8mRK43mKsK8FE0xDLskGDrTmvw8+nml/jKqUo1z
    vMViKzRgXUDJmXOcGxMl3JRo6QYg8c3iVDCeYjZWGhKEFFsNLeGULhfaZoKYzdjt
    vXZA58rWNgvImzaQ8D792/V6fDxXSBsZmD2UzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475752; bh=d+EWy3
    IFapjNN2MXqwEooi+EXNELSzocEd0LY1pxpIk=; b=qmiFU9iyA51Za0YCi136il
    aGzCrWaiJS1NK3be+9Ewu1MzQLLX4hWTzldGFEoE1/XPF1k0O/jMvA2ctc90WYMp
    OQaRjWjUxYsZQm5uf6jduwSW2J1LDO9LobtkxcZC0eGAi1n78FsYmh5/VcT/FAEK
    z8WMyXQX5eJJPChL8wXT2LOKLLlpZO9chLuF+DiXfGf0DjxE3At00mnOqwY/Wn1/
    Pp1i7wB4+UjQL8q6tmaDxT6jHp3HBL32PbkhSt2VT3PHYrErjs4doDEvoeFZShGG
    KIv+8lXdB23Hz6eI+quw+qndLoXGyMIaFU4M/kFRg1ER102BmaQX2HpJUjl1S15A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ArcWzsLG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvdefnecuvehluhhsthgvrhfuihiivgepjeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ArcWzsLG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduvdefnecuvehluhhsthgvrhfuihiivgepjeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966406AbeCSQJJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:09 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:46817
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966102AbeCSQJF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 066/167] block: fix an error code in
 add_partition()
Thread-Topic: [PATCH AUTOSEL for 4.4 066/167] block: fix an error code in
 add_partition()
Thread-Index: AQHTv5xGdWVmhUTObEewP85/5Ln2dQ==
Date: Mon, 19 Mar 2018 16:06:44 +0000
Message-ID: <20180319160513.16384-66-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:1eYeMoBPAabh0j1i0+UN4vNrBIdB85e9RHtz3qan24TFAvknog9fSPwVfleaghyg221e3m9xHnQcRrsqTIoLkV45Ogr7KhKV2PMNacuS9YqjXAZwuwAZobYcl2EqyO69nr5oP+Ei98Q2XBvdQfDg4iPvKKOdWaHCpKDfvGTtI09bhsbO5vtPI7iv7+gkcdDhXQgUQ8u8bRneENgpqZU4upIed3i1bN3cKrSsInyoAmgv+vcUChOoZSO0GC3BQZPL;20:edWtmpUsvc1ufxE7teGpwYoQFJTL+qoU+m69KABqvaGq5bZWksQTkupbOrysEr4/1/skD9znIZ47GPTEVmCkEBZwLDiLQZZEsytESojuYKJRt9TAmTgvXVv1g6ywTaARp+MY2kMmUG3UHjstGLrqgexiLi3Q1iH8gXqqYAB8//0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c35b5a6e-9e09-4c5c-b823-08d58db3b808
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965A9342A7C9FE972BF6BD6FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Db9lLG32g/UPkZ4IJoI5BatMD0pMl2hq+0u/SAgterVZrEeh/IRffvTSd/N3+PVsigVCJVGn7BNsc6TYxcBKoVK79jEcvzWY63shEp8y8GeI3xXkb8sTwYqwcgm8qEVYlaikct0c0tDj5FGtxO8ET4xzpzMUDXRlCGwmIKC2PtmvfNsV2JHl3fHKYDSI9NlTX2eYVtpT20FK6lH6KC6bJP5hkht+yAzxkGzn0MCbvLkwSDjh0US3VX+tEwlROyCLmV7C22FzhfrXnh7BcDjjGynhKajugvWE5A1ylPp0e51TOmBiuKIOX9owH2u82l+xj3vcxOMBYnQEMWW7ENbkww==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35b5a6e-9e09-4c5c-b823-08d58db3b808
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:44.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
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
index 3c062699f28b..29521753fb23 100644
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
