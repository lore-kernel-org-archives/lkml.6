Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236404-2-18395468252399544024
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
    1523236403; b=BiokseVPf8DQIBCGNijjUYoZ6Xwym2IOVG7eAAe90trCttQq7S
    HC0iuItMX/rUqZhM672wKy0OicxubqowTMnuW6NSpnJw1esp7p4HLbEmQdhIyKul
    SJ25Qg6WN6SLnWhT4xqb4Uj8EVc93aCAtNF5sd0pv7EPW17yGJ/maXNYKLXTWyoX
    GOI0RqjQbCzSrFR0q9s76Z9gYsIerJqABUmFer+XwOaydja3WK+JNjpnkJ2P2daH
    wvMsQHwcQLjqgb9EWlrS+XZzyUrtiwM2myXNNo5seNYUxw2EPzDW/czJrEs6PXfl
    WvGTxuH7FkC22MTfltmEiQiMWLkPOkfJ9eYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236403; bh=9EJBjVsICg
    B2sM+VI0sZAGAZdkIZ0ChwvWxpbk/9Bps=; b=nDXsQCV+rgZvzj/5FnwVZivJMf
    shP8E7PXcfcQ9OGZY8xzOWMvqU7R1fR20gRNpAL7iZO1YtiZWeu5EwMR81n6X79i
    mc2PtZ+FturlaTzvXccFxBGa4/nw32eFebQM9qWzOX19CdfvNMDq5aOFpf20CPG+
    1BaI5B/frnpKC4y2VWrx+VSfLXcuUOw1I91xtJEVqLUibUv9gmyU8r+r07CH6AA1
    xGwNuGHroEVOpri4OufWDwYNptk1I7Ojim3yL1FegryF7vdg5sDeo6uX6mgEe7El
    MYF2n46blB9Qe0GaJcocKZV4+88PoQUNY+9NHiXYsdBkpQ5Hxq9diIhNJUSA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EoFq8xti x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EoFq8xti x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPGD6tuMYhmIJPYO6B/IGe1KMHW1uqPXTeP/1+g6ghdnvnHfGb7C3iZoJb5dSflBcypHrYXnkLJNFFTTWiHHWKlW4F1eMEcPkpi1dM26Q/UZYEeoB1S0
    ZfKw+2yQmSgEH8wJ5n8ZPQSW7qdlTLd2zBNNl6eJzyDVS8rI1cjecnoJXgUNeNCQi08dgy1SwfyRVG0jRNsWPxJTSgnvvUmu5KqbwxsUYtEqfGT9UrMGbcQr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=M8ztRHds-MF4GhK9o70A:9
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755709AbeDIBNC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:13:02 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932957AbeDIAii (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 126/162] btrfs: Fix out of bounds access in
 btrfs_search_slot
Thread-Topic: [PATCH AUTOSEL for 4.4 126/162] btrfs: Fix out of bounds access
 in btrfs_search_slot
Thread-Index: AQHTz5nOpTBKEZemrEuIYl8DdRxZdg==
Date: Mon, 9 Apr 2018 00:29:23 +0000
Message-ID: <20180409002738.163941-126-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:dwmfDI7y699l85rCoLpiftg1DWB9cSE8Vv+dBC+OdBnb7OqWdUCK2LywOAO8mS+GaFhyV7IZMqy39BFJjyjiuZp3qkVH/e5NRUQG3RqiJqws1/jjeVarmx4jYI1l9yKHvoSf4ruL6zRu30Hx2lOfI4MgLporVsaCGFXKk4hCJ6QrLlyq+4bk1AgvUMkfWUPyyKwueqk9BC8EGTTrk+1zEAhplBljEzRr9+GwK9prJdVgXr/7ERhMZhzTv4dHKMVu;20:iUFoiumB8m85nizziuYyCu5f7wm0bzzjHxnqGK6vul9EZApqkuSA26qhx+anzYue9wGreX0dNIOttS2/NnCGzHYOOKtiWFJNLZSmpCFyQe9v1pX5HhSIZP1d4mntjKh8p3OrS0Y9JgTTd5bcCoaEDy7Y2GFiF1HZvAdQ5qX1FrE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66031d7f-794a-4c15-1d53-08d59db23963
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10954E2978B24FF29F2CB7E3FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1BMYdZsuib0X/vGPOX0ar4EdEiaQy2UH8wYiBuW3n55vs7lcPx/5lVDMq/mw98frWiKM9hStdWg7F/I/NJjcsZrXNqgRtS4U/68jveizHqFuPmBKZvz4vzWzyowIk71Ppt9+Q14hIyvvZkqSGvvxaFPhJZAWTfjhhZKDEPsS3b+RY8+0DM2V2MlfjsDBisERfKOeTbtF8wlDssb6ZohAk2TnUtKJVfumM0kuSmeW1QgFuUfzakKCP4Vmr5KOu8Vpeh83I8Is4ykDTFSXe+VgGJvaajcrwTt2RKx5gDHdZCGti6dmK4Mca3IjHeAFcF6sgmPyQM3+4aPS+WpYk0oUpmzayYviNRfLeiuAS13db7+Hh1ejF0Zrh4JSyvc7nSp48+1vDJR3xjH3R2i6zgBO9uKcRjtMK9hCeLfcOVHeD8Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66031d7f-794a-4c15-1d53-08d59db23963
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:23.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index 0f2b7c622ce3..ce1861620ef7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2769,6 +2769,8 @@ again:
 		 * contention with the cow code
 		 */
 		if (cow) {
+			bool last_level =3D (level =3D=3D (BTRFS_MAX_LEVEL - 1));
+
 			/*
 			 * if we don't really need to cow this block
 			 * then we don't want to set the path blocking,
@@ -2793,9 +2795,13 @@ again:
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
