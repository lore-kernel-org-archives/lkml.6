Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475683-2-16561684504864051639
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
    t=1521475682; b=LwOuH9UfBhzLfCtvBBTJnrZfV6lYlHxhvH8Qx6vI1QWUAfG
    vEv10rbAC8vwsEPoXWHDTh++/w/8bnm8Zj0/brIaGTOjt54/SW92yY5vYh3Pbx3h
    Z2Truf4m1u7pIdumPv/h6Ny6tD3fNwGHEo8kWqELqYqUMeJxXhHj+GoYivyGPpCR
    +tb5cIGuMM21vOQcm5iiIukk4N7dtB4zv3+x2HhdtBsCfZY1YfA8huhvlsqgg6Ri
    CKFucjKoqJ19TmNurkquAOPVCl9HA7cLYclh2fyvEEFCkcOd3GhC8mZS0jgrHYPG
    nq+G18fN7BXlfog3N5QYo6VyXdAR9ttfjCuJ71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475682; bh=/3I5wl
    gS7YHHZmJUR96BjRrOag5Za9wTm+EQh9a2d4E=; b=BzfjbDxSjjAA/H5JtuALov
    3I21b4MZw/b1l/0AUBKP/Sk6St699ffdi2zDFlwrypFTlKugboCrN60XWsdV4pvg
    KSDmr0GbPMibwPOL3HL09R+ouVLkpAGUFzQnkD1pYmURX1sBz+0zP3WDx9NPyh8O
    vU3mRI0zoqC+QYrNqDg42ieH9BL2ro+Km22bLkn6xvefiL+VdM/bSqgLzlAoOmp3
    ofhmqO8YUAunro0zhfZ+Z2vcx9sSvMckEaLthvc06kiVj2255bm7EF2P7kOv/j5i
    CgQo8vLnMHGpBff7C1NM7QgUGxfda7qAf5jGodWsGTlB5IN7pGXwzklj856SMSiw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bfdov9H5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelvddunecuvehluhhsthgvrhfuihiivgepgeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bfdov9H5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelvddunecuvehluhhsthgvrhfuihiivgepgeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966180AbeCSQHt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:49 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:54368
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966200AbeCSQHn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 038/167] async_tx: Fix DMA_PREP_FENCE usage in
 do_async_gen_syndrome()
Thread-Topic: [PATCH AUTOSEL for 4.4 038/167] async_tx: Fix DMA_PREP_FENCE
 usage in do_async_gen_syndrome()
Thread-Index: AQHTv5wxhsNkOYr2J0GBTz4lRIqkyg==
Date: Mon, 19 Mar 2018 16:06:08 +0000
Message-ID: <20180319160513.16384-38-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:xT3cwgHl0rKYBzcBYbifdhKuDunSMAuT9w203kQre0vQrqURAnVymO+E4PTmchXDCVN+2IkU+MsS+eziwuQMDOtxZ2aFqYHK9fArOZ+SIb9w5kQ3QqqCsLasxua5vcJOot3Vsj5jFr7uZ1cXz4p6arS4pcUZrkIIGhbw/X7G1Dp6ZZqnoJMB+dN7kKi9Qei2AEKQC5BWtTyhSBNhmrTC/SX4W1NqK6bKr9kkN+CabP3yWas91byc8dKKB6sC6L1q;20:AuJeiLOPSt9mvinWe6MObH2o2R0ldHA1fvpMUAaJxjU1GBRGQQK5Rx7pSXhb2puf3JkQjGbzl3iWg19o2p/mLIxSKq1DQouhKiiP7KjfsFEAgeelIc/01uYFqI7a7ZudHg+N96D0/J4hKf8gUbrUWfk44ifwCN7Qaxo6QMte2Bg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30c5492f-b217-4904-2a89-08d58db388f7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920AE2843B4DFBB027F88C7FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zmmBbgHM9XtYi4yhQElU6XfYExe2rqrGDQgTUsvc9qSCRYHnA9GAKlaJwMr/izq55HOrMdAD9NNE1T2lnEAquOX1o2f2EpGArhANYmP7JsTeXAWWWZcr0r/MvgW9lZaSPSBtMp0StJI0pMd1SxYxpkEJYGZLok8g8ySxdFGVov/kIDi2fSOZwQLO8iKR0r61i4STqlz+DJ83uESJDP8AunH9t9ooYua70NRsTApwDRf3ia5PkF7csVYrnXMUtjxtkpkpF5fmjKW7DRTI3y5fqtG1agylbvDdfyeLG1405dfpyWAoD2OOcnOlD5SA3XrF2V8wERWwb2kjdQTMfyjMxA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c5492f-b217-4904-2a89-08d58db388f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:09.0025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anup Patel <anup.patel@broadcom.com>

[ Upstream commit baae03a0e2497f49704628fd0aaf993cf98e1b99 ]

The DMA_PREP_FENCE is to be used when preparing Tx descriptor if output
of Tx descriptor is to be used by next/dependent Tx descriptor.

The DMA_PREP_FENSE will not be set correctly in do_async_gen_syndrome()
when calling dma->device_prep_dma_pq() under following conditions:
1. ASYNC_TX_FENCE not set in submit->flags
2. DMA_PREP_FENCE not set in dma_flags
3. src_cnt (=3D (disks - 2)) is greater than dma_maxpq(dma, dma_flags)

This patch fixes DMA_PREP_FENCE usage in do_async_gen_syndrome() taking
inspiration from do_async_xor() implementation.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 crypto/async_tx/async_pq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/crypto/async_tx/async_pq.c b/crypto/async_tx/async_pq.c
index 84f8d4d8b6bc..09f706b7b06e 100644
--- a/crypto/async_tx/async_pq.c
+++ b/crypto/async_tx/async_pq.c
@@ -62,9 +62,6 @@ do_async_gen_syndrome(struct dma_chan *chan,
 	dma_addr_t dma_dest[2];
 	int src_off =3D 0;
=20
-	if (submit->flags & ASYNC_TX_FENCE)
-		dma_flags |=3D DMA_PREP_FENCE;
-
 	while (src_cnt > 0) {
 		submit->flags =3D flags_orig;
 		pq_src_cnt =3D min(src_cnt, dma_maxpq(dma, dma_flags));
@@ -83,6 +80,8 @@ do_async_gen_syndrome(struct dma_chan *chan,
 			if (cb_fn_orig)
 				dma_flags |=3D DMA_PREP_INTERRUPT;
 		}
+		if (submit->flags & ASYNC_TX_FENCE)
+			dma_flags |=3D DMA_PREP_FENCE;
=20
 		/* Drivers force forward progress in case they can not provide
 		 * a descriptor
--=20
2.14.1
