Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243915-2-2109718049185571843
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
    1523243914; b=n9SztZUWp+M41vim6qaH4EXnITtgem2g1xUZaQYR1FQq4EIRz5
    b5+1ZE3E8XpEGNXC+V2rG55KWYeiRaiK3C+iVRBBzzvqz6fRNbDllll7wI7624ZD
    XEQ1JVvt24NPAVMpb3dGyr7hAeYXXTuZ1NiYweb4bptTNC+H0nIgW4CTYPgO8qDP
    oXBn5wmzutedxfPbzVv5Spfgitv1gXgM5UlxAn3r2NDFQ96CPCMAmuUrJrnGIJUM
    L2/3KkGthOkFYC8qJuoIhlf9hrrkUfRVZQHRodl91xGLJi3b4H0pna3jVjchFUvT
    1YmiMQkR7hLem6JJE3/hwADBlUFKDuKTiAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243914; bh=QE5ErK72jl
    V6Slg+XI245S7d8lDUCN/DOrS/KKiMrP8=; b=Ju1WqesZdYEVVERCAtA9lOWtjq
    nJlJ2hi7IWWHbWjYfo7Y7xapQH7Nvrt6kiQfSIBmthgNrV26IWQhJLJpW++6SLRD
    NEEBOD1U5s/8mGrNuTbEc/4cYx3kqjpOgIUpP4Ghu8BH7sX63eRHfAYZwFmDu5KG
    dBUTM4tq1Ksg4IPuNBxuzzFZmjI0nqU7vWd1ge80GKO5gR0uNwPQjWLJtqWhe4v4
    YjZzLlw8lXRCKW4rSRKE6jd87v0Y9kSaNIia6cdCMdTOZON52e+NCckq8msozdic
    sgj4KKAcw06K3Cb8xLXyLmI5c5yBy+P3UIntWb4j/wVLkBiELr0tmVa80+Pg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zn1km7sv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zn1km7sv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCbqJsNdNhcrgBuwiGbB+vUMTax5T0nIsicRUowsmTdkSL9BkPOASH2xqdXUZ+H38HSF4UK7Bvy2YzUzW8amCV9LvwJjad9hTUE7BMXCOsL6DD7JiQmr
    ZfO23+B6YsAM/sU0vXiaceIrVqGpm0FYXBkV0nDr8kohpYV/9ZcyqzBo5FEsOynXlU908PLIeKTgiroHq0ahs9BZYcp0nKiva8rRUJzk/VS+uzbwnL5SlzCH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=M8ztRHds-MF4GhK9o70A:9
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeDIAXc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:32 -0400
Received: from mail-bn3nam01on0095.outbound.protection.outlook.com ([104.47.33.95]:56127
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752775AbeDIAXa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 052/161] btrfs: Fix out of bounds access in
 btrfs_search_slot
Thread-Topic: [PATCH AUTOSEL for 4.14 052/161] btrfs: Fix out of bounds access
 in btrfs_search_slot
Thread-Index: AQHTz5iQXRnqSKEK0ECc5tmy2F+T0Q==
Date: Mon, 9 Apr 2018 00:20:28 +0000
Message-ID: <20180409001936.162706-52-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:/1GWKM8KZKZxusNjmwuVcsSig6VKgbVnlxUXXdWdYCDuAKKdjEyIH1i/hsY/WBUlBciYPV9kWa3lsJKpXgGnX4vrngs2FTHwu/kX2hH4UrOLQelNasDUAry89pY1tPyhlk65qacyStOcU04yRQTo8ndW5l6zKRHJe8OfvGmORFQt6OWtG0OmjDGZGh5ut4N8j8ERrbCM6oCxLxVQLZq0YOTwoEaS3Ruup+Kali8Yaelfypz4CkbmYhsGwp4eBYlz;20:tDzUgD+oKRXBNy61pl3OLXIQVhXo1IfzLrr4r8e3b0xOP8yxUziMpQEZsJGyWJLvwrina1mJnHuAdHm7IB3+cXfC3T1kUBHncfHd4TgwCw9/7TuIGd0NPDvmoLxMyMlmmxCqFqqhyFQKygIqMqO0BYRkDrZkDeeot3XC0fr0V+M=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e38cfeec-9f16-4246-943c-08d59db01e05
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10144E3F4EE9F1A3C80777EFFBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: O1SsZCuG6VAJrWPPvEuQjQ6glif6FRGGOX4NWknEpZwFLmvBzQqRcRQlmKJx+zP4XYq0gWe242jpCi/YzT3houSMZBpVtvTwUjfnuvUlXk20qRy7nUJ5b+yOQ45nhn5z++vj/q0PQ7cpjptrRFd4f8WLSqOtw2Qdhm/e5yDWvQxztAnMHWd49rZ8qxujne+YTIA7ptprpTz+zgaTQbimVCYtm6ZKCOXGGgtDi1aEkEUKrMVXkWRH1h79zJBqPmiXKj0ammFPfRJhs46GbYjYUjr1y4irwvz36zydyIVgP7y2D68wCQyneTbB7fC5HbH/+LF8u4u5M9jPs6S+5v/9p+51oa4QYG8Cvsjm5EJ4/XhloPdIo+1Y/vE7G2dqej/Ib4N5BTW6NiHkZfXKaAB984QT7zuafl2wzLfsXWDA4Wg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38cfeec-9f16-4246-943c-08d59db01e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:28.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
index e2bb2a065741..21cc27509993 100644
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
