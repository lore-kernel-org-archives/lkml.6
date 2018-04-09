Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246439-2-10251021538262968733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246438; b=cFj8SCblefJp4Mlr9n/2bASOEFXM+FrBdSqoW3OfWqrEesNr1/
    cEPrbAKDMmttquFzayjKlwv+an9u5ehiii8MeddhajMyKPqSxNxY7Ig0KT2h3Q6h
    EGa4qdTZg6hUb4GcDZ122nSNsVxXYp0qrZGaj130jeJpzaulaQr2fz/398wwE/f6
    BN9B0ikvAguUYhADiIAp3svSwl1HWqT3A42NoVGmWUgxLUgLKIXOoe6DB6VIrB5L
    kBPFGlN3zUGBTfinLdNAcvXDmhViH9t9rsW/SHCRcTZaya+ZIlTPq2HKE++JlDml
    2CJBDXBUkPlp4EA6Lh/7lTvcXDE8oKhEI9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246438; bh=RitbNNY9S5
    rtn3jrihg+7MOd7yn8m+UQurnrhqJloZ8=; b=HNxy+j/EZoaslj4OhSNe48Ny/H
    uYImVHUZrOuUboY92NmllHoQdwtKGek+gYOKRcwENodDj7+VWk/HJOzJaNYUhgbR
    LIymwllj4wcOZarbVTq+6sAEVkMJJ9YJ3XJcd7VjqtgHJH2NNQQIu95ydnBVU1Ht
    pRF1EuEFO09leSazrqexBUwYwWGhBS5DWD1A+wVEz2GmnAF8GzOHU+hosJaDlaVZ
    0IRwsv9sij6ke/wSXzvb5KDVhsz4Yc/utMy6/cd0lo9Ky3gzDkQFwQn/8OdQNsBu
    MsXI6l1Y5BDo+iCVfgQ+zEvJb8dADQU51o9OOwg1bq04t0ToYzJ5thNx6WIA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ox6H3Nnc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ox6H3Nnc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMGPA6aexhy14N5YrzKbyIOKSGGVeWDDssa+4GO6YQCEqa4Dp87++9a/j/cArZ5iPK6FPxjpUoBd3Zf5Vci5FH0LCbKtuJ57zlOZPWXBZyDi5PYWf7Ec
    0wHwRF9pQ8amXni9j4UvEjLcAQrf2I1dyIuy7ZFnYEuDE23YsEO3e2jjWvNJdGs9he2g9cz5jlaKSdnlE9zdQEFtit/DLFR/jLdwfCRWQXtGtY4PRIbV76yT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=M8ztRHds-MF4GhK9o70A:9
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeDIEAc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:00:32 -0400
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:37278
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753599AbeDIASc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 062/189] btrfs: Fix out of bounds access in
 btrfs_search_slot
Thread-Topic: [PATCH AUTOSEL for 4.15 062/189] btrfs: Fix out of bounds access
 in btrfs_search_slot
Thread-Index: AQHTz5go0EZDqiGBZ0KktMShoQ7aeg==
Date: Mon, 9 Apr 2018 00:17:34 +0000
Message-ID: <20180409001637.162453-62-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:VbbaBvg7cqQhDKsvQIs49IvSSZpn/f7gKvC1qFpMxHz2Gt+CnAO0COhEXHQwa4PiSf763w6ztiHBuaXDsf7WTTNXsus3CWx0oh/R2Tc3fPOwubtdaeETzRk54JofqErajbuCwBjJ9PJKhurjr83Hh1OYSkMnbr7QkBSaBTooon7mimimrPV3aLN1GfRAerQn0DFA3uygldmWYnutsmxG0SE/lY+1EHIJUBoZ/IVb2WvmORqeVpq3VoZCh+2mCJNR;20:DLLaOTCjIYtoF4LLuzFZ2EG+ZNWOEywPGNhSKvpHKYJAuy1GP9y/a0/9I1ggJmPFgi4Qs5gQappS9GAm7PAEfBC38EseG3fvaQoY1EHf+qN3rpvOSjfl18aycSAcGzWaRp+WBgZnGw28i9a+LqItq6ta6/8FzpXcRNYHY0KP76c=
X-MS-Office365-Filtering-Correlation-Id: f32cbb45-9a52-4516-7177-08d59daf6b0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10460A9E6CCC3C4D2EFCCB90FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5c1QOct2n0TOSz3kOpbuKR05oz1YxMWOvTg2qiOgQwWt+tp56uq8G3u5eruwbcFPCEUDoePBhpt80jK+QTW+S9AoDVPJsaHe1ngNOJdfccdY2BDSu+Yw0V7V257N8n4+3WVe+4i/0h5yxs6RgqG6pHONENJ7zyHI31IUr+Q+A2Bk/Zy0qL+jnt3VzHXI+acA6N73ZZ0KpDdMF7tjrBiGA//+jm7ykq90hathp1wfjKU7ZoV7pEpj3Q4znZrCGQDqcfssArJv1yxlZOobSheezyD+pXkhkRFuowKTqiLPZvOO8Y/hsXteV5j4r9G+2Gz3NE22JdtKu0ZUFzAOdse1cUTJrj1mWjqSxWosr6wyOil7t4YBvVp1x6JBnHDlpQ+0GLOOfiqeghrpDMXEai+/ZXQYOC+6M90N0sIxZxJ8OEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32cbb45-9a52-4516-7177-08d59daf6b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:34.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index 1e74cf826532..5361f69433a3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2774,6 +2774,8 @@ again:
 		 * contention with the cow code
 		 */
 		if (cow) {
+			bool last_level =3D (level =3D=3D (BTRFS_MAX_LEVEL - 1));
+
 			/*
 			 * if we don't really need to cow this block
 			 * then we don't want to set the path blocking,
@@ -2798,9 +2800,13 @@ again:
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
