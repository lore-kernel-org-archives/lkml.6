Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474836-5-10435426349764654485
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
    t=1521474835; b=ndSdJkKv4IHvZo0zkTglIAc0Jn4RNWCvS2dW7mNESa/d5bv
    JaXJWt1/V0uJIWp/QEF4j1hBwghKcs/0sr/qE1M57aPbiSgKl8zCX8fwjv53lSN8
    l8AbF+0uuo8/J0iE+BdYfIDmce7v8KOc/iu6VMjOTAedO04WFJPk6vYi0yFe7Pp0
    rG/8qgTf2V1p/7FqlBN02hvtFOETqMsN5/rQvov8sGCujgOgxFvv5CFAxLzJE7zt
    YHBu03Qf2W9F2VX97A4Bh+EjUXP/RrfoX6PJuLS8Afori9jIw5erMu2RnnC8MJRK
    LN8GTIrCBsicmiHtpoL4gUH63KWrumzJBDD7iYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474835; bh=mUHIEg
    rCimQnqZoxkuEyyEuD4BjaQG3Ph4oK/+Awz1g=; b=mYbC7QWm4ppBvqAS6UB5yw
    S14+mHZq1pLp0eZNGJIh6K7uVGmXWsUNpIbY0FVYE0uS0ScxBZoidT3G4p1YJyD7
    iYkefrEMdG6n2/u7l0RK5AsRU0Y99UPBLfWWhfAKFDNtqyBqj92YZbpAD78gg2j/
    +uKzzsxHDRTvF07BZSlBjHBzhckK1wyQ5jSp7PVhxRTUVTLaS2CTCTYpeab6qiKv
    95CgQwT7JezpT4GlgADtHxYi2FI7snmPGhw1GC4sjOkQukmy3SLYvGBIf3Ie5PgH
    2xxHoeTJe4MLi0+kklm/sH4LbLJ5DbOnV/3DRMBR3dsnEKJ403LxsoMA85MJJ8vg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jba71epc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduieehfeenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jba71epc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduieehfeenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933888AbeCSPxW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:53:22 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:9280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934025AbeCSPuP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 116/124] genirq/affinity: assign vectors to
 all possible CPUs
Thread-Topic: [PATCH AUTOSEL for 4.15 116/124] genirq/affinity: assign vectors
 to all possible CPUs
Thread-Index: AQHTv5nTG1Z/6rSE1kGbqxMJq72xbQ==
Date: Mon, 19 Mar 2018 15:49:11 +0000
Message-ID: <20180319154645.11350-116-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:Q1H3hZCikXWvQVeQeAox+eYOWFW5VNEFhVoLJk8nbL9j6JHNf1il3F6iKKwNO26cniGtwGwr41fpUH0kUvqhgZmcC9VWONzu9YHqsj9zFyok3u6bu/k/edI+bbmLZedSfVhzNTIiWFxyAlnVOdIyfp4Q8pWHAXcem1BaNL0YAMLCyTuJpjWB1Bi0RRo2usBPhWK62htXmlJJzmYeypFlrKpvwjWRWVY7JuwGeCExsZIlJSlb5T8IeF7hZgeYD8NF;20:oQXe5ink1Z8Ycv1AmA5E4wW3wiECZv+Q+1vdgy+mysYUQOltugEHRwcvGFZM9BIBdb3pg5HAck8JgJ4wCmEKE0UD18GMC1gCG3JtdgMj2qz86BWXodN0//+vx/nEZxWnYa1DVxKnWNaL/XEL++c9YqBOKquDTJrwxjt1i3Qk8H0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e179a3d-a4c7-471f-b5c8-08d58db11576
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110955471BF5150176E67D99FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(9452136761055)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kVWlep5LkMllmh7Z5iZunFgO4WncaWoLn7sAL/zEM03f+waRfrgSfINGG2a8vKrcXqTr0bYjLVxPTjKlvQ1uq/WcMRHAL60t02VMynsehpq0E0Ycc4+RxL1dIHPkmLYWKcf8ajoQoan6BYQtHhDUlX1nWoMsag15BFxFNHxT5HhwsJpCDeAgbYJQDuP5HsK0HgWHsPP3k2pEalrn/zucjA+O8qVczkluEclgK3H9fdqVCt2HVTXEGLhrD8ejD6+n8EqoGW4+ww+xOvqDZFi7cYlWcqbUTwmWxDVPlaYbGv7fXmLwRTAU8u/93kmAYAk5doHTtN1wYjnInfwpTTiaKw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e179a3d-a4c7-471f-b5c8-08d58db11576
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:11.7629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 84676c1f21e8ff54befe985f4f14dc1edc10046b ]

Currently we assign managed interrupt vectors to all present CPUs.  This
works fine for systems were we only online/offline CPUs.  But in case of
systems that support physical CPU hotplug (or the virtualized version of
it) this means the additional CPUs covered for in the ACPI tables or on
the command line are not catered for.  To fix this we'd either need to
introduce new hotplug CPU states just for this case, or we can start
assining vectors to possible but not present CPUs.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Fixes: 4b855ad37194 ("blk-mq: Create hctx for each present CPU")
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/irq/affinity.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index e12d35108225..a37a3b4b6342 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -39,7 +39,7 @@ static void irq_spread_init_one(struct cpumask *irqmsk, s=
truct cpumask *nmsk,
 	}
 }
=20
-static cpumask_var_t *alloc_node_to_present_cpumask(void)
+static cpumask_var_t *alloc_node_to_possible_cpumask(void)
 {
 	cpumask_var_t *masks;
 	int node;
@@ -62,7 +62,7 @@ static cpumask_var_t *alloc_node_to_present_cpumask(void)
 	return NULL;
 }
=20
-static void free_node_to_present_cpumask(cpumask_var_t *masks)
+static void free_node_to_possible_cpumask(cpumask_var_t *masks)
 {
 	int node;
=20
@@ -71,22 +71,22 @@ static void free_node_to_present_cpumask(cpumask_var_t =
*masks)
 	kfree(masks);
 }
=20
-static void build_node_to_present_cpumask(cpumask_var_t *masks)
+static void build_node_to_possible_cpumask(cpumask_var_t *masks)
 {
 	int cpu;
=20
-	for_each_present_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
 }
=20
-static int get_nodes_in_cpumask(cpumask_var_t *node_to_present_cpumask,
+static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
 				const struct cpumask *mask, nodemask_t *nodemsk)
 {
 	int n, nodes =3D 0;
=20
 	/* Calculate the number of nodes in the supplied affinity mask */
 	for_each_node(n) {
-		if (cpumask_intersects(mask, node_to_present_cpumask[n])) {
+		if (cpumask_intersects(mask, node_to_possible_cpumask[n])) {
 			node_set(n, *nodemsk);
 			nodes++;
 		}
@@ -109,7 +109,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_a=
ffinity *affd)
 	int last_affv =3D affv + affd->pre_vectors;
 	nodemask_t nodemsk =3D NODE_MASK_NONE;
 	struct cpumask *masks;
-	cpumask_var_t nmsk, *node_to_present_cpumask;
+	cpumask_var_t nmsk, *node_to_possible_cpumask;
=20
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -125,8 +125,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_a=
ffinity *affd)
 	if (!masks)
 		goto out;
=20
-	node_to_present_cpumask =3D alloc_node_to_present_cpumask();
-	if (!node_to_present_cpumask)
+	node_to_possible_cpumask =3D alloc_node_to_possible_cpumask();
+	if (!node_to_possible_cpumask)
 		goto out;
=20
 	/* Fill out vectors at the beginning that don't need affinity */
@@ -135,8 +135,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_a=
ffinity *affd)
=20
 	/* Stabilize the cpumasks */
 	get_online_cpus();
-	build_node_to_present_cpumask(node_to_present_cpumask);
-	nodes =3D get_nodes_in_cpumask(node_to_present_cpumask, cpu_present_mask,
+	build_node_to_possible_cpumask(node_to_possible_cpumask);
+	nodes =3D get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mas=
k,
 				     &nodemsk);
=20
 	/*
@@ -146,7 +146,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_a=
ffinity *affd)
 	if (affv <=3D nodes) {
 		for_each_node_mask(n, nodemsk) {
 			cpumask_copy(masks + curvec,
-				     node_to_present_cpumask[n]);
+				     node_to_possible_cpumask[n]);
 			if (++curvec =3D=3D last_affv)
 				break;
 		}
@@ -160,7 +160,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_a=
ffinity *affd)
 		vecs_per_node =3D (affv - (curvec - affd->pre_vectors)) / nodes;
=20
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_present_mask, node_to_present_cpumask[n]);
+		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
=20
 		/* Calculate the number of cpus per vector */
 		ncpus =3D cpumask_weight(nmsk);
@@ -192,7 +192,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_a=
ffinity *affd)
 	/* Fill out vectors at the end that don't need affinity */
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
-	free_node_to_present_cpumask(node_to_present_cpumask);
+	free_node_to_possible_cpumask(node_to_possible_cpumask);
 out:
 	free_cpumask_var(nmsk);
 	return masks;
@@ -214,7 +214,7 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, c=
onst struct irq_affinity
 		return 0;
=20
 	get_online_cpus();
-	ret =3D min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
+	ret =3D min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
 	put_online_cpus();
 	return ret;
 }
--=20
2.14.1
