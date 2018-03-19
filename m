Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478008-2-15860139157098088889
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
    t=1521478007; b=cqtp09evR2LOQ/dX+e1zVNmUaD46jjVVtm7UgSz1S19yRWr
    WknjkPLk+qTp1/snOibP7Z1AECZXL9Q9n8YSxZgI52Wr6GrTiaFBzu6D1Db+zHt6
    JnTNt0kZ6Ku0AF8e7sElk/qmT/xRx9baWqG31CFoVVJU5XTmRlHFltABqFlIklnv
    VRt+iyX4ZUNAZfYbmSWq7QzAamdqtTG0rPZnitzjbN8yJneDv85olBDRb/P06PVd
    2OkiV54k9wFknmKJEt4FY0nLje7sNPAgztQDPGPtV8o/WhgU1KeV80WnAw4lP6Mj
    zaDRUdK0pZvMSf6PVJ+fq6GU7CUg36i9sNvFr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478007; bh=NckQF9
    wcu9cPu3IVFcBY1KpRljfkEhQZZuExIc/RACw=; b=YYU3fKF2q0jS7zF1wIZeFM
    06TiIA0HUrcZnXp54cVqsMi29+j+tX8ATWpyH76XkZqboCERDARyetQQkHU3IKQa
    Sp6D0m5j/RlNp1+F9ErXx+4kJdypLBY+Ujz/VdF7RlzJ3WNdhEksGChGHUViRZqS
    mfo3wdfdM9McaRC+6L0D/Mdnam3f7wLNsfpLe5vSdjWBVScOIyEsegYzSw0DcY+T
    YN59XqjwTdMASumkoiC+H70SJ5yNtIbXohtPXI+QmaCDDDh/RIg4mHrZtrj4oznu
    lx+ggLhdpWXmdNpZOEHMVSJjdbCAhZGzz4WtJ0biqn7jq3fO8A0RbClr3Ny71WwA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kgSosWqB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeludegnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kgSosWqB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeludegnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967373AbeCSQqF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:46:05 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:59520
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966801AbeCSQMN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 024/102] async_tx: Fix DMA_PREP_FENCE usage
 in do_async_gen_syndrome()
Thread-Topic: [PATCH AUTOSEL for 3.18 024/102] async_tx: Fix DMA_PREP_FENCE
 usage in do_async_gen_syndrome()
Thread-Index: AQHTv50BW7MjLagXhEeUHRccxfWPOg==
Date: Mon, 19 Mar 2018 16:11:58 +0000
Message-ID: <20180319161117.17833-24-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:6+YSjzJuLdtC/4QzO8aFZ20DJ89N18clZLDY9q10E/eJL5WswBXaTNsniYyVUO28kTdqjeCaS6u4kIZ0CiknSsUkQs9oJCN269nJiQaqYk7GQZus/CBeA/uzRotax78fuKBgcAEIbmurDRBN+0ezJm5ICLNKsLkB9Kj+I2lPMHwJ4jT75tRNnqtfaw7lBQWa//uTXxw6iyIfNFSNQH1qG/KbJyy8esTRI/qtDDQbUsIVfiG8mcxLhzuz4xiP5YpN;20:nzZC/qN+rm3jeF4hWHZ3iFLW/2vQTKvPVs0YvUGyXi5c6KRWqUMYkFYYf7D4fP+uI7/w45mSC8v5xZbb04tVpGgrnGdIzmn3tQTk+a/7FQMn77GLKD6rdS4O+KTXZBitfymPMwtAqm4qvfnC14vld2FiVmuiSsSpJLcIBFTCnnQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f51f72de-7e84-49bb-ffe8-08d58db42414
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920F8C51364F6A5E2C8AD7CFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ARndpcDDBYDVUKDR7YkDEXbeKjst6M3OUuto9/igy/qv7p6q8CEl8ad0D7s/hsUsTaNmeuJkCug067xDbPSTNkiVqtWLhYK0rKKl3RiANzoXVACZiMDwWZdUArdsuUH9DUQHKDscDrgzG2LcogPFROlvqOSCu374Sq3zsiEUGIqBOL0/bu7hMdtyZn/dNG7LWUBOv6bAC8HyJVVkmTfMUTqItjX34GPaxW46b84MtLVuF2OAWpSY4I1O9BZ/X5Ia9DMtl6plE0lFVpkLpp8NoO0Q68YDpPPRqFtByUADaV1X1wZbA6QQK4Fp/geidzYeswHg/xO1I0BJ6ccgbFmuBQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51f72de-7e84-49bb-ffe8-08d58db42414
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:58.0618
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
index d05327caf69d..c09a51dbe59e 100644
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
