Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238843-2-15115247236713622427
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
    1523238843; b=vrATOCGR7wdLWpmH/xnPO5TXTYxLEFChVxNF3GnotCYX2m+fJ9
    7n0Kx+gvrVl2vUNwKGMdPQpuYNL3+EhiMmJkg2wAq2LOZrDQKTGsz+TEPA3GHbpR
    tmZGCbmlfDNa7RMzfDKo2a7G4t3nJ8K4jBtM/YN9NStXIEP7x9EOTAYZSLbsKiG2
    dsrZwy/EYpfWtoNWaqWGKxv+sbCCT3FkT+Th/DzXMb660T+P66NTb7UeKGGzi5rg
    EObyaeT1tyibCeQaGHnh7NEnm3soXTeWJSiLlQHVv3PiI4za4u2j8eK78cy1peB7
    ccSaCAEuVdIgyTcf5/eQPf6H1vp7+KV14Dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238843; bh=tTLGaCOa+T
    HvW8xiLsAWwzzbaZK+QEc4chGdziZk3I4=; b=Vh6sVOqC4DEY56T3Ek7UqM0qoU
    YuFguW7V/9R9EtjBRwF/IAgrq3ObJwXYiVSR8i8Q5DGdnpmimJe8p7weNoRbeh5n
    oJzhY3NHZbpqeT1GAtY0/atjrLY4JYehNrrr31KLtUvmo59HjLgGFMpUYZ1kiG81
    mm9a1TCaG3gTsbcJgjPna0uzx9HwFHQ3o5HMbvaiwLyTBFSbvGVh9Ts+EjhZWAXR
    UQIxYD5/SrL4yE+VLwzRL2pOlbWqmmG6LpLvFrPB1EDrbyVr3IHGd7/KsTKBfyuC
    l4Eo3UKTSwsTTwLUjORBSPRn1uh12aGCioZRT/A0fQGE5/8EzMu4ykjxxHeA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VkdsTSUm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VkdsTSUm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN749lghBcAkD3dUWR/u7MyjedES+HLVMryUpWHR1at6XXuJGucHREMD991QZOyYiimTGaVFCOkyG4sZJWyyJ//610pBMt6wAnzPwtNDXd8e+SsHwhz6
    7RzFoDWQUDNOo0q2Z8QQt1M9puXWQovrrHIYuT/2JRNKAVH9YLX8sqWJ/97m4pQT2pTni/C9/V7mSI6ASk5H/198M2Q65E3BVxC5E7w//utgyetvuZaFav8X
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=M8ztRHds-MF4GhK9o70A:9
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757527AbeDIBxr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:53:47 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932230AbeDIAdP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 238/293] btrfs: Fix out of bounds access in
 btrfs_search_slot
Thread-Topic: [PATCH AUTOSEL for 4.9 238/293] btrfs: Fix out of bounds access
 in btrfs_search_slot
Thread-Index: AQHTz5lVH22Uvif2LkCQ195dTVhXKQ==
Date: Mon, 9 Apr 2018 00:25:58 +0000
Message-ID: <20180409002239.163177-238-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:y1XS+FL2Ubfy1r+jkW5WNUkcU/OAJHWAq1M+05sL5QWqiFOdv1GhOtKHp60VboHjwB6DuHjRKhywse8Ii3bAURAWS1Sh5R6rhFLSVG5UbFH/FSpA0rMIz2pgk8wSE2pl/LO79Dk7iFHMRdV9X8Ecr72N/ttFqHV8OSg6GXAVI1FIkMZCfKRg8OpBbQnCBqaXyAYkeVyB0L3X1MbtITUqQ4EiIpBcyxFsunilqjOq1gfHNOwyHVxye4pyqWkLxhUM;20:SPdyoX8HJnsj4PyAJFVcL2Xt/Yt1lgzjmt7W9PdejkDKSNhjJHK0TdtVLM/xeb+vhqiUneKohtLJDtOK0qKiRLn1Q10/C7zl4ulwPBsY1OkoM/cZPeREUjbvpvDOygU/ajyrbCyk6PbWl1X0jxgYzLmkMhNlVOcOzoHMFSumeoM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4adafa9-01e0-41d3-485a-08d59db177bb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902F3A48271D847265B9ED3FBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dMtu+Pbq1SuEOK7H+DRkrbonmOOejF8Rj+x7iyYXCNJspYdZdhU6oqZkwYnb9LGbaGg0R/hM1McyltJ8hCn1KjbQedekkk7B3HC2OjcTuUWoXoLHuUgCPiKhxXAGf83TkTbLFbAdO6+96i+lBzJtHpeRQ7XBLlutlxL9m1dEIrHrOeSzFIdkJlr9vy1wPcRAuSaEy1BYb3ikshG+2dBCbso1IUy7pJbwxuR0PyuIVCaFa8/k/gmy6w/Xvyr5+Dv0rPXXDqeGGvXn6It7BQm9qRx3hlhPxBY/nOvHzMSvTg7aSVZuDzHTdev8XS2V3ekSpIlHCl/epe/QbwsxSkcXhW2xCuKfIyZrmEntCTabxJ5q2+hAy8Qvxd5Kb57ZJndLxocc4BGaWIuUB2DweE8zgEqUPh9JXJlqByCmrtqfxnU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4adafa9-01e0-41d3-485a-08d59db177bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:58.8005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index f6ba165d3f81..f22ffc6793cd 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2760,6 +2760,8 @@ again:
 		 * contention with the cow code
 		 */
 		if (cow) {
+			bool last_level =3D (level =3D=3D (BTRFS_MAX_LEVEL - 1));
+
 			/*
 			 * if we don't really need to cow this block
 			 * then we don't want to set the path blocking,
@@ -2784,9 +2786,13 @@ again:
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
