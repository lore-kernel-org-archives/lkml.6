Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234924-5-13059217255494371603
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234924; b=GGHoNR8ny1ttGpSnkVlU5w7jpd6pVpy0l4k13q3C2Uh5dDlHKD
    EtERCC7qz9+5IF+7M5Jmp3eiKUctufsEPLQfylYVB/lbW/VnIyMdzd3hTBrL8U+e
    c5p6f254e90WMPc29uiLn3jq2ROIZ9asudOXOv10qRPk6t9SzEuJCwhyzMqrJOOr
    CHxdVwf39ETRuhV8bcRbbaZYRWkkAuGqUfOZxDOHHvQ2ff/e14lmNAXiHhibky3h
    6X0+b8229bQxhTMOT4wD1GCWD7MJClLaCb85WCuykQpKcjhyT4aUqAm1rT2b69hO
    MFMlECRGf64ViHue2N4QMczasN9nlpvHbTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234924; bh=sDHBAzhZEz
    bKVhIgPMIZi6O7iv4kufmtfTwNKVjIVHI=; b=ptZQw0an+ssy0sa7rmKM15vrtL
    y8EZqZsx2Ss1w8TB5dAKD7JeULJyd0WHJYPeLt+vbh2SJHXrqvwsc4NqN+sWkyUW
    gD6A81g1kCIPd3kG5J8/Kg6O7YRCM6xvYQKN+tSfyGd0q6FjsmMG+NjRdHRaXFPm
    i5PljJjh/j0xE2X9tbbt7dGEY1CuZTNl+O3YVyFJpxjaZTYC3ocoAAfLKSW5SPq5
    EqtUxCRwNHd4Yyx4ji8ZhNI8gzP752pmPk12bnwjYx4hSrvV76cjP66awuuJ79Ah
    Qpz9pYDV48GLSMLl5wek2d2YMNhnQPBINwF/rnFZJxl9b2PtCshDGmcpVeCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X05yJ+/x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X05yJ+/x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOFmPbQQXHH+D9optIW6jmz4FTG8LG39XjnWxsNKxyCedo0pM6kqPsylcFpwpfYygMRt/B2G2wgTGmC7hYkzhgcUWe34iMgqu6SUyBsnV58lwnyjJJ1M
    CrGw+Q4cQ+UehA8mSCC7RhHWR84B3hApsSgqiPnF3EB91D3A28vVwW0pKhDRlZ3PMAp4zJTlBerwGAh+XeqsEA6Gitw0V0gXpPFRg0l1vWaFugszPc+QRp8w
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=M8ztRHds-MF4GhK9o70A:9
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757034AbeDIAsZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:48:25 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:61949
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755703AbeDIAlk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 076/101] btrfs: Fix out of bounds access in
 btrfs_search_slot
Thread-Topic: [PATCH AUTOSEL for 3.18 076/101] btrfs: Fix out of bounds access
 in btrfs_search_slot
Thread-Index: AQHTz5uD8hMx7LcZpkqRaGlFtd633g==
Date: Mon, 9 Apr 2018 00:41:35 +0000
Message-ID: <20180409004042.164920-26-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:sowljcvPHvBT/YgWMmUSCx/PkJczlvJMWmIjJGDVxDm72KogbQGcKw8qAEGuf2+29qt8Ki3/AxvBVxbi7zWkOReAPizgxkFSL/QCnrLTjAV/k37G7BaeDVKoOHMxz4NZu/JszU06+0KnTE2WSLud7U6mslJ+zXQwcGztsmxS3iUewsxIOX+D2RiJ+dIH04OQuGiN4Nj2ZkGWdzYHyI4XbBgtIYENg6lklruVTwpbZ5nthh6KLX2KZvwiuYDLre5f;20:FBFvpjXbLlQ/GJJSdyEGEJK2eThtC1+9CUs0pN8y+sJOIm9yryjdBoidp0sZKlh7YSQpQkDBevjnRjQlJ/JdqcY1VAnOfF+FjRk/5guBoSSWuRxmiztntNX2o28rGQJZs+wS0fXRICJQ9V3RzxWmgSNcOIjE2OgBh5afwO8YT3c=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d195356-874e-4fa0-0ba4-08d59db2a73f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062FA15AE67B61135F028C2FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(54906003)(5660300001)(110136005)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KtvOWPjpGSzAw3kAQwyCP1/pbnVM/erNBGXmI/Q3ZMWJ8M2HhdOkJXpq+9azo2acQB2M5Q+zVUKqk4atF8AfWXZsCTacOeNJTHiifGV5QG+IkU++omtdANlyCF23rr75DYwO6565cn81dBhcNFXdA1VmbX4z92dacjWcdT3n+ElnMs5bkEEn5v4rzeaOPfaweedAmO85lKpYXa03kUbZIARS5vD/LxblrmyyANxbVQj5NRG3MfoR9xefIY6xmH8EPBKzN6940c66oIegXHqmlenZQIg3hM1HwmWju0uf4XPKld8O/ahZZQJdvZTz5OduvnUo1VxiQuQa/LS6Afnivl5jcLafNq/jowLeiU3KoGgWxVaalIIX/kT7/cVp0shRtpZ1QKTTE9hOKd8uLpQcwTU57hdQ6RgS3TCl697rvcQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d195356-874e-4fa0-0ba4-08d59db2a73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:35.9397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 9ea2c7c9da13c9073e371c046cbbc45481ecb459 ]

When modifying a tree where the root is at BTRFS_MAX_LEVEL - 1 then
the level variable is going to be 7 (this is the max height of the
tree). On the other hand btrfs_cow_block is always called with
"level + 1" as an index into the nodes and slots arrays. This leads to
an out of bounds access. Admittdely this will be benign since an OOB
access of the nodes array will likely read the 0th element from the
slots array, which in this case is going to be 0 (since we start CoW at
the top of the tree). The OOB access into the slots array in turn will
read the 0th and 1st values of the locks array, which would both be 0
at the time. However, this benign behavior relies on the fact that the
path being passed hasn't been initialised, if it has already been used to
query a btree then it could potentially have populated the nodes/slots arra=
ys.

Fix it by explicitly checking if we are at level 7 (the maximum allowed
index in nodes/slots arrays) and explicitly call the CoW routine with
NULL for parent's node/slot.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Fixes-coverity-id: 711515
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/ctree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 39c68ef10808..c221d37e3ec9 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2758,6 +2758,8 @@ again:
 		 * contention with the cow code
 		 */
 		if (cow) {
+			bool last_level =3D (level =3D=3D (BTRFS_MAX_LEVEL - 1));
+
 			/*
 			 * if we don't really need to cow this block
 			 * then we don't want to set the path blocking,
@@ -2782,9 +2784,13 @@ again:
 			}
=20
 			btrfs_set_path_blocking(p);
-			err =3D btrfs_cow_block(trans, root, b,
-					      p->nodes[level + 1],
-					      p->slots[level + 1], &b);
+			if (last_level)
+				err =3D btrfs_cow_block(trans, root, b, NULL, 0,
+						      &b);
+			else
+				err =3D btrfs_cow_block(trans, root, b,
+						      p->nodes[level + 1],
+						      p->slots[level + 1], &b);
 			if (err) {
 				ret =3D err;
 				goto done;
--=20
2.15.1
