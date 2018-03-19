Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494454-2-9433519914440086217
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
    t=1521494453; b=ox8SkaUGifNgtTywxFSCZI5+TcZbg/6S11K33XNXiHesve4
    7AXld4YCV4UkimrvYS/k0GK08IXQnToyFrMuCcgoyPdBm7AHlNydJZQyes5vbLDL
    Fmr2pjFd++WclsoDRayc/SpxY68qib4sXqfapWTpg1QEn08c9pdlbw1CZiMeN2KB
    VnUxRG6a7I4v5B1594uExtfrrDwtOy66eHxaz6uDMdT99qOnq76BmChDomX+/6zf
    xGAECW5s1fKNiZHqT2PtVMxuPMGpB7BndpiewIvmLiufa2jK0pjpvLktx0j6U4Xe
    3zNvjq8lOV7Uc+gnsj1byQf94i71tITGdxnP2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494453; bh=V1JOxV
    LXthPmqeeXAQMUShtR34bkm/30EbbC2smbIRg=; b=WdOdO1oPgS9axW0spdmELU
    lwFnjIJ0DkSb1nbUUS5xMN3QURqHhScNNax3Jp85bH4qJzZLIAhn7TEj7AZ7x8I6
    yjCg/pYU/UwRi7erOb+gSnv3dmZJtBtK9trr62NCBfXtR+FIv41J6xO4p5wmHQ2J
    Th3O/LDSa2P5dREtBdEm4h3xTzfGrKPF76rjujoPDhBw0etGULVtYjkxR2wBb53p
    FvA6yLDR86uGizjkHR3g8u5cErvL3jmpoxH8+Pz1oPqSasu5FX5hja+VBlvGjotu
    AWTW20IyGs7adE0R89dFdOnWZZ/w2uXyXsA/wwAdVWs09NJsrYuJ+GJHMPWxbYUA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CvaSgxbg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleeltdenucevlhhushhtvghrufhiiigvpeeije;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CvaSgxbg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleeltdenucevlhhushhtvghrufhiiigvpeeije;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969547AbeCSVUs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:20:48 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:39043
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934601AbeCSQAv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eryu Guan <eguan@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 108/281] ext4: fix off-by-one on max nr_pages
 in ext4_find_unwritten_pgoff()
Thread-Topic: [PATCH AUTOSEL for 4.9 108/281] ext4: fix off-by-one on max
 nr_pages in ext4_find_unwritten_pgoff()
Thread-Index: AQHTv5tWjXPeD6S9uE2VIUh4AY67iQ==
Date: Mon, 19 Mar 2018 16:00:01 +0000
Message-ID: <20180319155742.13731-108-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:T0md4aoRsIBLXi865sgHbNuL88gct5XFUZfnAgynVluJpna+DkkGU5KXS3nnDfKI+GIBr2XsHfvypPv/zO3z3k0rSqTipVWAt/lu+H7KTWtXnNZVzMOhe3tN5b7SkDam0S4WJiQfNoLEjwhtmz/eHlhBwD1Nk65rkbSBGgJjMXDpQxEcrz/4uVtthekzSJXgAT5Lox5i+EREv/m7Cw4OR3xIPPRy7Ssz1aTjgZfqsnvYIonaplTBbNCMXdbeGl/A;20:EpjN+hXqtgBND7TSkTLgoCKQqPJEBsr0FnUn/Takl5toXxauq8JBDTQPGpKSUt1cObi/UeKX4Uq2GTP7DsYOAd7BgfUISUZkEAg5IzO8bWOWEYZmXH1zNDjZBjrtkuSvC62yQFlVbFWEgP7IyrFNRwnEDqZLPLJj1isBOKv6oRk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6cb30e7-e54f-47b4-6834-08d58db29553
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10150ACE56035790A218FEA8FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(15760500003)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kqd8g9MDkPwdMil5Al+/JRTorACn5eDqljjP+GgLZ8i7PL8qtzD8s5hDXnH5fEx/cqSUsn4my2J+XQc8FHoUp5GLFqCTVWkOuJmbQn4rBlHJNNgYeiJokdNT4GrH80IeRbaw6zVXufjtI4v+1occNSsTmOK7VQYYBrFlMZP9hA9geOy217k+/yp8d5wZXJ6cbhHd+AiYUo5atTy0v2f30mwWmaTFn7qcQXZLtph/swYnNtHeoF13Fh8VYOzR/gDxhp0/utjrazXCuzSRFP/pdHAbb4t3g/ilIZ3zsPSL+eY4KWGKRdYAMZQzvZol7K7CBGHNdY5rjDxUOHEWmE6OmA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cb30e7-e54f-47b4-6834-08d58db29553
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:01.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 510e66422f04..08fca4add1e2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -429,7 +429,7 @@ static int ext4_find_unwritten_pgoff(struct inode *inod=
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
