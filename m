Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683283-2-15837854249540583023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683282; b=IriE/dsp8nT9ySwvLazdE+/YDHHMCGFd+NL/aQC8OVoHsuD
    IaX64oI7vlmr8PtU/xOmf2uddmdfmkIv6h+QNEQ987NPRVFMN2CvqPSqCaxxa9LR
    0M2NMP9KapUmTbEKaLGBGFhaxKRVW0hcDLA54irDqabjlqaMiU4PD+r2v6d+U1IW
    ekhHAmPvbxhQO95mbSQYKHoyePd6eH5yi4qDTkVvHd205lIT4TnEyVGhRjfXpT6b
    u67RbdCaR5fRe+QtSKMd6j1DvNMnPkkPQ1zNwpaTcC9UaurM7nFJHeFCP7YJA2jy
    f+iZ485NTZTDCzB80NioWmuqgpOgx3aUqRz+ZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683282; bh=Se3NQ+
    ZVaqnKySBCnENBEhKu764a02lx6KuG9plX+vI=; b=ez9EcwGFe5Vl/IRMjJXlh7
    Jb0qnDPjJ6GttWtjKiZHwVsBvTCDC8JX7Ie564nF2Kv0k89DzatsWoXhVNk9jwD3
    oDQdtIHVzP7jZ2mKwlqH2ToK/03KdXEWvvSPlm0N88yLXB/1tjusWTo+dv+akvwE
    TQMBogdaPoxiZqFrqcRoa8ZV+S/lZOPaKnKAtwbOYBlt11RBWmTmZ312MigT2OEh
    81eAqcpnm0HgdLh6cNNbkHRgcgkFX4rccD6dTacylxnD5n30LkVWmqBvN3n9hYHJ
    F63eDL9VGeOqupztxnfgN3plRchPgAzCaFeIZFezOSG7my7nMUkDHRxqgCIDbkEQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BeF1XcqA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BeF1XcqA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbeBCSlP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:41:15 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753244AbeBCSD2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Howells <dhowells@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 068/110] afs: Fix missing error handling in
 afs_write_end()
Thread-Topic: [PATCH AUTOSEL for 4.14 068/110] afs: Fix missing error handling
 in afs_write_end()
Thread-Index: AQHTnRjzRINjaCinU02VytHpalYPcw==
Date: Sat, 3 Feb 2018 18:01:01 +0000
Message-ID: <20180203180015.29073-68-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;6:FD4B62RWiKkFPNdynaMOrJe4yX4UGnULrO+kksGae1UiYmm6WfK/7W+mEygCkvyzojymUR2vUAKbhcp6GbtCcV757AqLP7pHfY3We4sQIQNWlla+SCmfQX424hxpCxLyCGI/qvgGZ5EPH9j9K374EE3TSKWTYwpmQQYqBn8ohErP9+ywwSQv+73EAGtLO0RLhFDZ/YcNBueLf+oO2+E3KrJnXyGSN0dGQHr88wx5utOwHit+DiwawqjEjAyTT7T8XCQv+y4B0o6LFe7OP22AnHA6Oaq6o+/uSnzWnQhfoMZlAPktBI2Nv1I+khoDIPbf3eGVODwaI5r5qVXGO0RXp3amwI34XAKWhYjo5Iuj48opy8CXO3LdL/j1DxJDBtL5;5:uh2IAMdIP4XSjVez1PbSRRGjelsacFuv+QYL5dx1vg4Vux4+2Zbyl9TvjZU5TmeVLzbYm+yFecD5U9TUv0IBcT5ZWGKQ1+D5gjfiVuGN29dIQHe1nka9G25fDaGSRTR2ujrT0rwAm3M7m8KtN2YDvnvg6crKlGr5BbEcyUuWqZs=;24:8bd6VHeNMzUrk80PUX8zh6pyhtDlnrJ+qnGqwAZfVQQzek9cIM3qRHdaoKk7/MK1BPsKV6sMmnNjINsx0GHLl6HseO35/+/Y2ldbcLXARwg=;7:h2TS0liL63xJh3f2lVFM+dp5Qr6ANACQ972dJWgj7uJBPbsAxlr82prqwcfiMwX4nrV7QMsfG2VzcoEOUpp361z9YgiQIEllLvkL1wC1EPKe5AnQV2VlYNl/nCmvyc3dyCtZhjmeTjHRlJS+4GY/Hg8pqZm3qH2Fht3PVpI43/BOhteOI5e3CKQx5fNpmacWJr7rY40ll8LW6uWmagPc/9FWjrKtaZZUqqU2DmEOGRRQWdeiQsbo55lYbneDCKsC
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b53e8200-aa19-4dbd-5b6d-08d56b303c75
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB11055494C792989C8C2C5B4BFBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: bQtvU8kjbqf7wX3F3tcQS9jkW36u224p+rSvIVtBO4EjIUEkQ2wJZes/dYu4EewIDDzVqeQccJrhRG6Ew/JmNQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53e8200-aa19-4dbd-5b6d-08d56b303c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:01.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

[ Upstream commit afae457d874860a7e299d334f59eede5f3ad4b47 ]

afs_write_end() is missing page unlock and put if afs_fill_page() fails.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/afs/write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 106e43db1115..926d4d68f791 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -282,7 +282,7 @@ int afs_write_end(struct file *file, struct address_spa=
ce *mapping,
 			ret =3D afs_fill_page(vnode, key, pos + copied,
 					    len - copied, page);
 			if (ret < 0)
-				return ret;
+				goto out;
 		}
 		SetPageUptodate(page);
 	}
@@ -290,10 +290,12 @@ int afs_write_end(struct file *file, struct address_s=
pace *mapping,
 	set_page_dirty(page);
 	if (PageDirty(page))
 		_debug("dirtied");
+	ret =3D copied;
+
+out:
 	unlock_page(page);
 	put_page(page);
-
-	return copied;
+	return ret;
 }
=20
 /*
--=20
2.11.0
