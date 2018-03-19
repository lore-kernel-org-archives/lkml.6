Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475987-2-18208672994811276462
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
    t=1521475986; b=Z3+02lUIulmVxsXsqXLit9ydcqUxHuw5OUzuFimvFmLKq4f
    OHzilDTa9ahUCT1ZLvZAOEDfMkL0Ds44blV5t6pol4VCGMnFr78H2Ux+wod5tKOi
    OSaoxHQScmUsznXxGfFN6uNkAAlX/k7pQMUTNKuBsMDjNESJrSXXrOuuvC1WfWoY
    x1wtUVf7NW47ouAQBO/SrIFgTjVFF6wr+teF1o924O9qhzXA/gTEP14qhLMau9Yz
    OtSefQ6IQkzgY4goWfE3HAduQwYurMoLgvi0WnHTcZo3+n0T27mFEI58Z+DKeGwS
    7dX1iUpOWKt3V86n7iRVY6MfQWjDMOvqiYln0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475986; bh=m3CdwZ
    TU0BUZ1Z3S5o8NSsLRfRjGjqAY4qdwuZi9Xao=; b=B5f9NC1Bjcqqv/RQhet/7B
    5FlDbo95J8bDiW6HBU1/RUwyBM/U577UEjQSBV0Y6Fh1ZJXM+l+R9aUmsAdfT4z9
    zefT/l74NdacGjkKSR8x2G4WvFH5MlChTu3kiuGAlgc4cUurmAK3lbtvLkA41QZ1
    hHdS6c36ke5HbgufZidMluB6ZfqFhC7RlEfCrIbBI++qwCoaZcfUZAlopOeSWqFS
    6JhI6+vSLrwgaGAam7/KfT85pDAL9asf8rbo/DfiItc9ntJs4zv+4rMQ9hG87xuI
    koiGJ/HGDjo5PkU0qZM1HHxkFY9EsNnIydR3DGhGWNLLCqaAN2ryC/EMpaXAJwYw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AT7O5gVU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelgedunecuvehluhhsthgvrhfuihiivgepuddtvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AT7O5gVU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelgedunecuvehluhhsthgvrhfuihiivgepuddtvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966866AbeCSQNE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:13:04 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:1938
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966851AbeCSQNB (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eryu Guan <eguan@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 045/102] ext4: fix off-by-one on max nr_pages
 in ext4_find_unwritten_pgoff()
Thread-Topic: [PATCH AUTOSEL for 3.18 045/102] ext4: fix off-by-one on max
 nr_pages in ext4_find_unwritten_pgoff()
Thread-Index: AQHTv50TBqFyFvaYyE2Jp0KV6VBdxw==
Date: Mon, 19 Mar 2018 16:12:27 +0000
Message-ID: <20180319161117.17833-45-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:iZ84sXikhOF9HeHB2SGungAd+C1dduiHn0VxzOdd6t04v24PWvtbpw2TnCC357HDK06Ude1qldudJUZo6L2WWdpLpmJ1YPyAalW24x7WJSlPdqjKv1ddfoOtjdyhkc8XidCXjBXX1qQj266xxoRvoDY7WYfN1XdkzhZRokkPG/X+V1fBLtpQeNVHnNF8UWUu9YFmL12hri+1MzjQYoNFm1sIcVNUrH+6iCv0yEOWYP9VXJe7/jDCh23xsrkSBUvt;20:WxUbqF5J3Iei/Agx1yMSsj93IjDavoFMR0tSSjEQ6iWI/gh1Yh4kDCTsd3iHzSj4ui4krY5klMfxvT7amDy+Pjeg1SPhhEG6oZGqRlPODpxZJesURRzya7MjKu1jVS+alS2Dh7XpU0VVj8rLNTed6pDUEwav7Ou4I7DrG+HoNvk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61cf6a27-c7fb-49de-c20e-08d58db44524
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10488AA3871DC0FB677C9F9BFBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(3846002)(6116002)(59450400001)(305945005)(6436002)(36756003)(54906003)(110136005)(53936002)(15760500003)(14454004)(97736004)(3660700001)(99286004)(76176011)(22452003)(7736002)(6512007)(316002)(6486002)(186003)(86362001)(2950100002)(6666003)(5250100002)(66066001)(3280700002)(102836004)(107886003)(10090500001)(106356001)(25786009)(6506007)(26005)(8936002)(2906002)(81156014)(81166006)(2900100001)(8676002)(86612001)(2501003)(478600001)(105586002)(1076002)(68736007)(4326008)(72206003)(5660300001)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: H6qh/s4bTHurzYQBB1/+9yODfJgqqELy0OWXqFVN9r0j9WFW/Y5VeTfwAy1iKtYTZvsm4SgG/AF9rNlpex63rkrYK4/VB6oNRO8ufPuep3RnXauM88ogZ9uTGFRdXEJB7lUqVIcNlBeCzGzJDoB4+a77nkDC9aWJiMxBgRscU4uV6UmXz4jAR/1pQcxgZHpCiHtm1pzamZCVSNP6A6cCZcMn1O4OLYMgU6mnHLW+U3N0zkggYp42MdpddVjSNSUWVgELLHqVmIBeQg3ewIvjhvTtId6jgCcD5wrnusFk1p0tQt6rB/xdONanPZqpb9w7ENZdXycBuWargZfbr017kQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cf6a27-c7fb-49de-c20e-08d58db44524
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:27.9748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
index 64623537f3b0..aa7cc4a51a84 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -300,7 +300,7 @@ static int ext4_find_unwritten_pgoff(struct inode *inod=
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
