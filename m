Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521498934-2-14132932479762553656
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
    t=1521498934; b=Hw3jumakr/U+vdxh/SHigYn4kAEwbLCOjzTxVy0S8jnU8md
    eKs4CdJA1llJvKb/tGInGWRUynU03/OW5Lwhl6xwLMueNjLFR2nu9CdGStb4eAbV
    c7UDVm5vNXmSO/6s12cjlhKCTaHe+RdXdwi8ItJfFVEukrvJoxuxllqChmQZdoeI
    GE3ZnyPoc8VxOkegzEN7q7ZTgcPstTMKTK4MM7ckwgtHdh+hSeswN2Z36knu8HgL
    ii3QlRSRzbp2gC5cqrtwqQ+pYA/o/Ja6wCd1aArAyqhSTKA+cHiiCqrM2F+g/ZYF
    Oxu/BUs5tean5ZV4S7IMRGQxqy8Y5w3rdF4tIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498934; bh=HLh8UA
    C9TmBZR4HojPWBc88IUAcM1OF7UABlJ7a43Lw=; b=xBdM6gA31GJWdZA3bPGFcR
    zQhv5tJbRn4cm/1QlUP7+lW81jSEz4R2TsydUqFrddS7NzRor8yojZK96vbFJDpX
    AGlFC3aKHbzNJxfTFICmhpH2CSbM1VFWnzTmLZcfKx3OUB1QS6V15+HwBYv1EUlg
    j/hXKl7vojn5WwPq8UJewZWYX4MsBpWQMKza/4AZ1c681sM2gs2Aj088TS+CZfC8
    e+9MYzQMKAYHkPz0e9VPGIzFUJJ5RZLEiCk4OoE8oRYtGooOEOBJ/UVCw+8CPW2l
    ygjta53u1h32YZamUcedEtr0GrNhDcDslVNqM5pVrOrl0MaDHTT9ijiWRGRmz6CQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lciKvijR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludehjeenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lciKvijR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludehjeenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933820AbeCSWcn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:43 -0400
Received: from mail-by2nam01on0119.outbound.protection.outlook.com ([104.47.34.119]:13392
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933722AbeCSPsH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 033/124] f2fs: fix lock dependency in between
 dio_rwsem & i_mmap_sem
Thread-Topic: [PATCH AUTOSEL for 4.15 033/124] f2fs: fix lock dependency in
 between dio_rwsem & i_mmap_sem
Thread-Index: AQHTv5mYzuw4ZT1xtUW12YnOWJRvNQ==
Date: Mon, 19 Mar 2018 15:47:33 +0000
Message-ID: <20180319154645.11350-33-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:fxIFFj69/0jj4F7H/8OV8RhTV/tG/dkqt29eS/pq0nWehIHx4hXRCtawXDaUB9BLLWWBbSdNec6lM7FBeSxUcv1wd/0iwA5yfv3+ml1xDGI26i1x+KmAXvNxeVyCyUbjFp1g4K0cOPf4h2OwFkhBc/NW+l5W5A94mFYw6KnU/QuLFi01jy4cRkKOSYXhweJ/58osKJ5s16oqB6Qk+3G6H8zRJxwE43cauVcyMFpXBnWWGRl+wJovJWsdeS1SGj6g;20:zT43zgkseRRu2JtVb1gLmrh8KvSBqXEPN1l73fjtRTm9NSpDI87pauJqhEMAO00vlBmvcv6IWrTWDEglLU5s5QnkwHYTf/Cf+SEvntGMSAN0/5tIGW4X1YjQZK2VNaTOUel9pPQEYWbUecFu+Fk1oxxXQKN6pJEY6rsBVqK+rCU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bc4ac37-53c4-4dd1-17cc-08d58db0cc83
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030AE7504C07C6243EB4D3FFBD40@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(6486002)(5250100002)(478600001)(86612001)(102836004)(1076002)(97736004)(575784001)(99286004)(72206003)(6436002)(2906002)(107886003)(66066001)(10090500001)(81166006)(6116002)(81156014)(305945005)(8676002)(86362001)(7736002)(68736007)(54906003)(110136005)(26005)(3846002)(105586002)(3280700002)(316002)(53936002)(8936002)(186003)(76176011)(2900100001)(59450400001)(6506007)(36756003)(10290500003)(2950100002)(22452003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iqCQxtlR1cWYqRMNYTjh5gKVY3emF37FW2/iX5olz/Y8AnLDjv01xRqiAnEojvd1yoBBuPrv1GkRnD6Z3cSiikjr3sl7RR9Ypm0gWxARyGovbRg0csJjmr5t1L+YtA3eyLTGDdc/0WOEXcpTleEJEWqlxoV+M1IcJ8ATHrnUKbQ5wX6A2fdo1zHZtuuIz4GxmyV9EsfZrfI3NzvAAoQpEjozALytsDQp2Jb/ultC9uPA2Wq9VqdaUcO6wVpc4cbQ6k6L5wOahZoyhHUbxrPJ5pYdbABMAO8hPC5mLU9eulo0GUSmXqdMVrL0wbuZJF9B/rSv6TNXNFyXIFfzykVnCA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc4ac37-53c4-4dd1-17cc-08d58db0cc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:33.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 21020812c9e1ab593367fad9ce579f842a0b406d ]

test/generic/208 reports a potential deadlock as below:

Chain exists of:
  &mm->mmap_sem --> &fi->i_mmap_sem --> &fi->dio_rwsem[WRITE]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fi->dio_rwsem[WRITE]);
                               lock(&fi->i_mmap_sem);
                               lock(&fi->dio_rwsem[WRITE]);
  lock(&mm->mmap_sem);

This patch changes the lock dependency as below in fallocate() to
fix this issue:
- dio_rwsem
 - i_mmap_sem

Fixes: bb06664a534b ("f2fs: avoid race in between GC and block exchange")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/file.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7874bbd7311d..84a011a522a1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1186,14 +1186,14 @@ static int f2fs_collapse_range(struct inode *inode,=
 loff_t offset, loff_t len)
 	pg_start =3D offset >> PAGE_SHIFT;
 	pg_end =3D (offset + len) >> PAGE_SHIFT;
=20
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	/* write out all dirty pages from offset */
 	ret =3D filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX)=
;
 	if (ret)
-		goto out;
-
-	/* avoid gc operation during block exchange */
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+		goto out_unlock;
=20
 	truncate_pagecache(inode, offset);
=20
@@ -1212,9 +1212,8 @@ static int f2fs_collapse_range(struct inode *inode, l=
off_t offset, loff_t len)
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
 out_unlock:
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
-out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	return ret;
 }
=20
@@ -1385,6 +1384,9 @@ static int f2fs_insert_range(struct inode *inode, lof=
f_t offset, loff_t len)
=20
 	f2fs_balance_fs(sbi, true);
=20
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret =3D truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
@@ -1395,9 +1397,6 @@ static int f2fs_insert_range(struct inode *inode, lof=
f_t offset, loff_t len)
 	if (ret)
 		goto out;
=20
-	/* avoid gc operation during block exchange */
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
-
 	truncate_pagecache(inode, offset);
=20
 	pg_start =3D offset >> PAGE_SHIFT;
@@ -1425,10 +1424,9 @@ static int f2fs_insert_range(struct inode *inode, lo=
ff_t offset, loff_t len)
=20
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
-
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	return ret;
 }
=20
--=20
2.14.1
