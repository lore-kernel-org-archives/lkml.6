Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118621-2-15953182757068085858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118620; b=frLFNvZacdUXyuCbMawfARA2vfemeX5ff/QjUnB9YKuf2Zr
    bwL/SXe/ogG4tHpoKlf4hybqXKDMsEHL0wy+I7ZAsXfcg+qKlH7N2UIw019e/Scr
    b/Wl0x8CdyXXmo0cbPvAkagbOfvvwkEWWdgzcLAY500lexA/RAyvIy/P5YeZvV6+
    Cw08ORoazSXqKY8Rh5NQO+e1mtfnwMdMZGjG2SVe8u2oERsTYJFG9mx1DUVKix9r
    ZSY9pk6uROYZYKRFjjcILxVqN8tqRYFACefvxFQKRRHBdr2uRqOaoySxEBlnNe2f
    QFUpnm8l88fW9PMBEvweGemW2BlF017rL2I8urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118620; bh=XCuG21
    pviwqVjaflM04vQ7skPM1h2Dxh3ws+cIs+e9M=; b=mWCGvG+XUSzvL/x7GE8zCF
    U3q3hMOl5AD0eizn05/sVGdKZsG0rO0+LjCL9EHQ5v3isrO1lm/ginXZhtT6mhHz
    3BJ2T7V46U3joQZWG5gBONFijiG2hNY+1B9/tgbg8N9ZaDeyud4NmU+t0Zja7c+a
    AiouzRKbmWNIh3vIFcMqaLaMU03FoQ0XtrYqha1SyJoXGP1Fu0GiG+VJXowUvy/N
    tlkEq5b9vMXTDv6NqggJZkbvK1jg2+ZuSjxnEqJvQTitMq+Tl+TMJDayaFE6Y6uE
    MfBAGOOWi+OFeLSraMN4EZcc6dXerxrGXhucUxF8DXY5ms3FBhkchMJPJ2tNFdsg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GRxBcK4P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GRxBcK4P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933048AbeCCXJS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:09:18 -0500
Received: from mail-co1nam03on0096.outbound.protection.outlook.com ([104.47.40.96]:45422
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934399AbeCCWjy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nate Watterson <nwatters@codeaurora.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 061/115] iommu/iova: Fix underflow bug in
 __alloc_and_insert_iova_range
Thread-Topic: [PATCH AUTOSEL for 4.4 061/115] iommu/iova: Fix underflow bug in
 __alloc_and_insert_iova_range
Thread-Index: AQHTsz9cK4spez15EEG6Y6t2XKzQeQ==
Date: Sat, 3 Mar 2018 22:31:24 +0000
Message-ID: <20180303223010.27106-61-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:wCvottOP1b7U8htBhMY6VzKc1Yv8GqXo86YmkJUz/tX2+WtQCIBVwoEi/c1hXPCXnEeBohmXvgnzK1lyhkdAfcpD7x0oMWzp3QohtBm+Qq6u0Ua0t9/i0487yKnavixhGjEUsTg5zcgpfldJynj9f3dXwwwR4vLHNebxCxN4SCkxnl9OSF/7wBDLQgSqPgRZKCwrSyHW7EtISMJpPAS372UVYmuM73+z+W5FMj+ouZbfY7h0L8S8tKI6SVaZWYp5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07493800-d432-448c-cf31-08d58157adfc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113226A4F88E43CE8B8F239FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(575784001)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(6666003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: EdFPW96PUlYT3hrFZ1ODpxy9FFYFaZN71idpqCfm9WXIiOfmdu8wP0EyvZVwROclN+gtF0hwaSQsUSCdf0YBEoKJKLxPvGMvi2DtMiCgkCLeYtifvAvgrFC0KvoLARDR5OFmdxIgELmRCZwCQAEU0icrkkvHeKuUZUrJRubgiiw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07493800-d432-448c-cf31-08d58157adfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:24.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nate Watterson <nwatters@codeaurora.org>

[ Upstream commit 5016bdb796b3726eec043ca0ce3be981f712c756 ]

Normally, calling alloc_iova() using an iova_domain with insufficient
pfns remaining between start_pfn and dma_limit will fail and return a
NULL pointer. Unexpectedly, if such a "full" iova_domain contains an
iova with pfn_lo =3D=3D 0, the alloc_iova() call will instead succeed and
return an iova containing invalid pfns.

This is caused by an underflow bug in __alloc_and_insert_iova_range()
that occurs after walking the "full" iova tree when the search ends
at the iova with pfn_lo =3D=3D 0 and limit_pfn is then adjusted to be just
below that (-1). This (now huge) limit_pfn gives the impression that a
vast amount of space is available between it and start_pfn and thus
a new iova is allocated with the invalid pfn_hi value, 0xFFF.... .

To rememdy this, a check is introduced to ensure that adjustments to
limit_pfn will not underflow.

This issue has been observed in the wild, and is easily reproduced with
the following sample code.

	struct iova_domain *iovad =3D kzalloc(sizeof(*iovad), GFP_KERNEL);
	struct iova *rsvd_iova, *good_iova, *bad_iova;
	unsigned long limit_pfn =3D 3;
	unsigned long start_pfn =3D 1;
	unsigned long va_size =3D 2;

	init_iova_domain(iovad, SZ_4K, start_pfn, limit_pfn);
	rsvd_iova =3D reserve_iova(iovad, 0, 0);
	good_iova =3D alloc_iova(iovad, va_size, limit_pfn, true);
	bad_iova =3D alloc_iova(iovad, va_size, limit_pfn, true);

Prior to the patch, this yielded:
	*rsvd_iova =3D=3D {0, 0}   /* Expected */
	*good_iova =3D=3D {2, 3}   /* Expected */
	*bad_iova  =3D=3D {-2, -1} /* Oh no... */

After the patch, bad_iova is NULL as expected since inadequate
space remains between limit_pfn and start_pfn after allocating
good_iova.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fa0adef32bd6..62739766b60b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -126,7 +126,7 @@ static int __alloc_and_insert_iova_range(struct iova_do=
main *iovad,
 				break;	/* found a free slot */
 		}
 adjust_limit_pfn:
-		limit_pfn =3D curr_iova->pfn_lo - 1;
+		limit_pfn =3D curr_iova->pfn_lo ? (curr_iova->pfn_lo - 1) : 0;
 move_left:
 		prev =3D curr;
 		curr =3D rb_prev(curr);
--=20
2.14.1
