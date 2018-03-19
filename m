Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475785-5-12736644167779618800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475785; b=s1u8O3ggngKRTdee7EiMzwkj2MwN5p5s/Mh+pyptA1XXRXe
    OlQVUAnNOd5O95jkPXnMiCVu6WsNvDZ8DD+LMg4TG7gub/q40bwvXT746ntKhhVG
    jk7C9LiZ5ATLQYkaooNxzzBEJVIgZDWZoJ+Kl6CWFz+fIUyLSOAVA70VS5ktT6VS
    TdkfmQ5BUbwhYRlq0X9fRsA1C/IrvCfVxli22uR6lfGN2YdMdbOgS3q4eBWDcqW6
    3wPQbhTJZiAweBMOt9ZCkcHaDLVR3n8DFSSn+SW/qVjq6K54Q3UJBCZNDuFVviQv
    Q9pSE6CJIiN3wcCMYvfrLn1cj/1TCeG6V08hnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475785; bh=g51SyS
    XnUDWTx+ppBVRxl7lOdANZK66hIc3f9JRU+UI=; b=bT1TDVI3ULmzxIwxLC2utT
    IfwpnHk/qp42TgzZvtw50CIUVyoWZcb/gFOCKpyU8JCEtNkEe/Sa1WuzMhCgmoJB
    w4ZLsRWguo9K8p2TB4AQoz7Jbj7FEKQiwE3zkcvlQ8gIPK5GjNcmHG32AJoTNw8c
    U4CoAy4wSB2xEYeGSsN7VCBnPFpgyEljSbakS35tGLO0fedW371sEb+2MjzMRHNN
    Bm3OSWypggv/r1DO8JFQjeYCIuOE7pmU/7R2ExelvXxwfIDcXdYyMwfy1hZjU+sX
    0gADefnXKtrfwOcm7o9K3KxzScN7yswwHHDrKWGgdo7boRF85KIS+sj0yUszRBGw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z5gQfXzh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelgedtnecuvehluhhsthgvrhfuihiivgepleek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z5gQfXzh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelgedtnecuvehluhhsthgvrhfuihiivgepleek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966102AbeCSQJj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:39 -0400
Received: from mail-cys01nam02on0124.outbound.protection.outlook.com ([104.47.37.124]:59524
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966418AbeCSQJM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eryu Guan <eguan@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 075/167] ext4: fix off-by-one on max nr_pages
 in ext4_find_unwritten_pgoff()
Thread-Topic: [PATCH AUTOSEL for 4.4 075/167] ext4: fix off-by-one on max
 nr_pages in ext4_find_unwritten_pgoff()
Thread-Index: AQHTv5xNrc8+8kJadUmkD7ntnSBCvg==
Date: Mon, 19 Mar 2018 16:06:56 +0000
Message-ID: <20180319160513.16384-75-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:ArdG/etw6ARveN7znICoGNf76ceOjsyUlJFf9TNQYJvCe7aNVqGR785cmKMLVB62KnH0upONe4+ffLK735yLltPZDR8mSbVkd/4/JCn5yq8NXOUZlsUoIwqQxhW9+rAEE1v7AleOwHukzHE3bcxTqdk22JSOeXhGNBVKil3SMciPdR/ihv1pR+MVEJyEPcvnpVrWu7xvNbkTZfUw5UXOeWKxobRvj5qYQ4cv8hP6+/2vGYXAglckjCtMMBeYN7Vq;20:ltTxHHgwvlnOEaCUQkxDcuMRX1rZiA7M2T0lfqhYm2s0cFnk3jwiORpbStuVUCk14fxP1zZZmNgthsRFdNFS/TrG/XljPZZDIOc7eNaFSALw9S9r1fm/JYUijx8n6BguG70Ws+xd8eme41NoJcP/R9gC5FeWVDpezED1h01/P6E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b86968f1-30c7-4cd8-e87f-08d58db3ba9b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965E24DB0C7F40D8540BEB4FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(15760500003)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1YzqNIR3wWrhG01/zlK0M47krxoyHwzoWH1UQpmWA4hPDxICkomU9uf40+B2AxpcFCZgvY7Cfbpuqfc1G57c98M6dC+YCChjU9VKATeE1aSbC0Ggh/bHvKm9YGodHE9tmu2VCI02x6IowX9cz17vbkGP3IP0BvTcUPSdUXs1AF2ZuV1SFd6KZl4sQ1KvdfDv60jwX71jYlIJpAw6H6ywqxrlyc1OGLGF2rQjQbqLKsLXduc3O4dLsWx9jOmE4WSkbQ9DpBU3W0gSvfXhBfPp/50g9YPq4nA/jxrGWiE4BUvXArEVYKDwRm8NAWm0+Sjuq/bK3lWjiVT8LqTXzt5Dhw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86968f1-30c7-4cd8-e87f-08d58db3ba9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:56.1559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eryu Guan <eguan@redhat.com>

[ Upstream commit 624327f8794704c5066b11a52f9da6a09dce7f9a ]

ext4_find_unwritten_pgoff() is used to search for offset of hole or
data in page range [index, end] (both inclusive), and the max number
of pages to search should be at least one, if end =3D=3D index.
Otherwise the only page is missed and no hole or data is found,
which is not correct.

When block size is smaller than page size, this can be demonstrated
by preallocating a file with size smaller than page size and writing
data to the last block. E.g. run this xfs_io command on a 1k block
size ext4 on x86_64 host.

  # xfs_io -fc "falloc 0 3k" -c "pwrite 2k 1k" \
  	    -c "seek -d 0" /mnt/ext4/testfile
  wrote 1024/1024 bytes at offset 2048
  1 KiB, 1 ops; 0.0000 sec (42.459 MiB/sec and 43478.2609 ops/sec)
  Whence  Result
  DATA    EOF

Data at offset 2k was missed, and lseek(2) returned ENXIO.

This is unconvered by generic/285 subtest 07 and 08 on ppc64 host,
where pagesize is 64k. Because a recent change to generic/285
reduced the preallocated file size to smaller than 64k.

Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ext4/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index a8b1749d79a8..debf0707789d 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -460,7 +460,7 @@ static int ext4_find_unwritten_pgoff(struct inode *inod=
e,
 		int i, num;
 		unsigned long nr_pages;
=20
-		num =3D min_t(pgoff_t, end - index, PAGEVEC_SIZE);
+		num =3D min_t(pgoff_t, end - index, PAGEVEC_SIZE - 1) + 1;
 		nr_pages =3D pagevec_lookup(&pvec, inode->i_mapping, index,
 					  (pgoff_t)num);
 		if (nr_pages =3D=3D 0)
--=20
2.14.1
