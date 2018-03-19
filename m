Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495398-2-14693373237014079604
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
    t=1521495397; b=H5Jy5z6X177/nMzQOBVQF8kQ0ClREKaAMah4CyZfrQIlDlI
    0qu8gSa18O91kURzYELcnkghEdsmbmw9ny5NJSWuMDGmexcc1hUvt3RwHAMjn44/
    XWtavAe81GMqAGCdvjsfzveEFKSO40HfXcW7S4ou4vt8A736uAOF41u8icHlhCmj
    R4Cb+pCieUJJYxUs79UQy6cbLQpveNKdsXMhMCs+4Lv5vuhY/GCUxkePZ3IOmbNW
    wPG13x1RHObn0S4KCx+fwMUhkUa+qOyy3Gh8t1w4GQP/V2QNsHbnZamfaCxUWf/b
    iCnYOfgjYGU0Lj3kHu7FTYZzmnid93BdeiW1xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495397; bh=ZASANR
    eOnpsMhRtRukDpqcdg7mXnIEhezWMAoxUbaQs=; b=V+U8mOObjngxxwEUmxF3Qc
    L2KB6VbqBsI8ipvzzvcWlQUeBDvTnpw6SLk4fXvi7/VFZ39aUTNpeakQDnpd9vaR
    ym0CamOX7dEFfMOW2YHdYU0ohPmYzl8XpTC9SO+0r4lsDJIv8chzsTdyXZGNmeQA
    srx4iFh9gz0RFH+VVZ5bVRCtn1F1jmi8Ej92NtofuX378ubrflhOSfmfF7aYAznX
    dDYsjMVZANaY7uaSxJ8QoRAD+YmRBKPCkEE1MQbGtfrouDQy6nz2NUAmNE/NCt2Y
    oj7Ci/a8GVJQjZOB5sUVOey+RlwB+WiOYhUwFYpnlFYpj2BMF6MSdJGx4w5pWw3A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=flgUq7tB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejledvtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=flgUq7tB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejledvtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934614AbeCSVgR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:36:17 -0400
Received: from mail-bl2nam02on0101.outbound.protection.outlook.com ([104.47.38.101]:39744
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934545AbeCSP7c (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 055/281] async_tx: Fix DMA_PREP_FENCE usage in
 do_async_gen_syndrome()
Thread-Topic: [PATCH AUTOSEL for 4.9 055/281] async_tx: Fix DMA_PREP_FENCE
 usage in do_async_gen_syndrome()
Thread-Index: AQHTv5surTnWkwsLF0um9R/eOp9BwA==
Date: Mon, 19 Mar 2018 15:58:54 +0000
Message-ID: <20180319155742.13731-55-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:LLmxgckpL9DbkEy2WPtsn0oZiRKuQy0RWgVZkOhD3q7yGCvW0WYYkr0pe4gUfUMrqbpkUgGP/XpM2ATJHcsdgl1/2PvVpKuWo3hXjIMM4mkR1WqD3OAnxEG57VZ8zJRuk39uDNQCsquPcJQF8vMFX39zeDiEIoxgR7vo+hMcGXVbst/ZjPQX6dEwwr3I0sAW/vQSOrxFZKkuckrsbPWCPAIvS0pVc4P/hP6Lp1bicIAXC59kUD4cVY0G/01lmUvI;20:8abaBfYATU2Dd+wGk6KYwKU37umkOukLRAoTPVBSEDyofuHzBoDjecdZlZYZK9ihzumMLjYeEarmL4G2/u6Gfu4IwLaflgXvwPpxZTtPXJ47VoBFvtQLAerIph8mQ9Dx7H405k+IKy6u6BzZFNaHYHwddYNz4hxmNn1tKBP0NjI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c81fecbf-7dce-48f8-342e-08d58db26099
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109901B103F94B00CABC68AFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(575784001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 86HRK3TJmpmppfdoI6i+BjbDBhWEYy9tMPBtiWlpJXLTxwxaf2M9nQdjKWGS9rv2cLp70ZfE1ZYqcAdAi6O1C29kXIpYLlQpYRp2dsj+xRV0O3yB6j+n5sKpdvfitiqTsBSVRNPXk592vlFEb29NBJjk6O1X5HgrGY66He+wuNle2mdCRzeD3J/toNCcUE3z038io7Vaxu3TxABPXtIVfd7Y1z3VVz0UbtBEGkAblr/Y6oEtmLPl/isJ+MxTuYkbXbyBvju9EnHzDm5XC0U+GwIL3fb8q42bONuVjjpykYpgoMAPoh6166rF9J8CfLkWc4LiJyB6lAnWgcpjUdILXg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81fecbf-7dce-48f8-342e-08d58db26099
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:54.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index f83de99d7d71..56bd612927ab 100644
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
