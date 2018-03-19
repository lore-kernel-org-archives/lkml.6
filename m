Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498606-2-12778839657292183357
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
    t=1521498605; b=i71lAbhevoorDDu9DeZAaPbEZEoxPbRIDLaURDNbLmiXCkS
    2THpiW5FjIE+FKSxCGXr4vaUCfOawel/EO7ogCt5awMufS+ZAPmFbwlJdVqH5IgT
    0RQ7OFJ6qXq656ICvsy+g61G2ubJ5gommr2OPtzAYh5qVwbg7UKesDdsWj1fWASb
    U37LTOUuChtKz8k1lbX86rIRyEvjE0KbLuNDjof/qWjOvvyAh7ybGbtXRWJJIYw6
    ge1ZrUPkSBi51Rocf+gfz4y/ZBdSZepWwHQItfvJHo45BswEm+mwbW0vLbPy1+Z1
    YIOe6H8nsQI1xmZE6yWpTs7F1Zol+cyBqOITgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498605; bh=9kYPuM
    UFeGhDq02hbqs31IMFqCISMQAl55wBwTpE/Yg=; b=dJZBMJzjLPreeNqapPyh3y
    X+5CjmD/bxkbubeMZx5eedaIm/6HK1UYpY66dXEYtIL9aRy/+hjLEQgpio7KiHjk
    GJiBSoP82ukvaiOKdEYd2z17AqkI5i+JJpj0Rl8gZO5YEp0kGTLncFB+CGJJEKZE
    RAp4nqV9+SSBCROvL8VbojRWk7G7RvY1Y4hpTgobYhMomEM/Znw1S7FcidnmRQuD
    Rm9sB3ugsKFpdr99oLe9FLn6wJQu8gHbjT+HuVyRTIl/qCpfd+sm5L6cNrWDguKi
    gEyEqu8UGdRSP39c99vXS6SAi5RD1mG3BVgHIIcMk0xncBQtmr272vIYvFdY25dQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BUHmYY+r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddutdefjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BUHmYY+r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddutdefjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933828AbeCSW36 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:29:58 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:15712
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933785AbeCSPsi (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 053/124] arm64: asid: Do not replace
 active_asids if already 0
Thread-Topic: [PATCH AUTOSEL for 4.15 053/124] arm64: asid: Do not replace
 active_asids if already 0
Thread-Index: AQHTv5mlUZNMn7KDvkq0Rkvp79GfjA==
Date: Mon, 19 Mar 2018 15:47:55 +0000
Message-ID: <20180319154645.11350-53-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:8wgjjLVb8M/Z6LPeoiilaPXZuB+365H/Ma0DI902E46di1jiuiDtxeKXNMA1Riev8lqq92cuZjnbt6crmrbgpOkOlKaCDdEQ9b+/KScd+mjtXObopY/s2ZHusz+QZIGdyY2dDhCXG0WS3GgLJ4r1fHUhgUUlxgvIvv4l/RYsMklfvWSxnOJKZNBeaH3g+aoCaW5kRhOUXNKIvEa45mvVLcSAdGE7veGZs31to4Fit7i9/BP107ygDNI8gBoebjWy;20:+ZZvaYQsBlQjekrshXGtl6a7FdYTn8Yn9q4Nk/8bMTuKY30zr4HPLs7PimvWMgjOmiHosfpqtIvj1UnWlMNIXxzMreej9Qv1t927A86IOK39nZ4kZGjwbeXppis36NkhWWad96cFuq5z1Q4pXLTanwt993BUNitdzRQoGNo4XhU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba615d28-2717-4ea6-fcee-08d58db0d389
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10312F113521B931BB0CFFA4FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(788757137089)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6306002)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(575784001)(86362001)(53936002)(107886003)(86612001)(966005)(22906009)(87944003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YmZE9Ax43UA/s6B2Ec6GvniuV/fRoZO8CMCU3puNNRzYkzaiEThYbEdxr/91kF75bYhhchDLwbpIpfjySeuxdUuk0T1q8efjvHHODASZDOd2ZhADyDNJgnI+1lZPvg4EKSom6iJM/u6EGmCASG8nAHdibR5r1jb2CsX49QvVbqOX+9W8OXadb7Wu0MxnkhVeIoyrY8W3c9a8UxUAasnRbu1BI+dFlKH8VWsUDy+EumF0yFu09mCcfuBXl1PmARxu0Fk1vZUenHpVsemfFCI8uRQQYN1ebLiN47lTjcMxMByVhAwRmSa+5DK2qK79fW28c76YqrYSaW6WcgLeOnSJNQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba615d28-2717-4ea6-fcee-08d58db0d389
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:55.7588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit a8ffaaa060b8d4da6138e0958cb0f45b73e1cb78 ]

Under some uncommon timing conditions, a generation check and
xchg(active_asids, A1) in check_and_switch_context() on P1 can race with
an ASID roll-over on P2. If P2 has not seen the update to
active_asids[P1], it can re-allocate A1 to a new task T2 on P2. P1 ends
up waiting on the spinlock since the xchg() returned 0 while P2 can go
through a second ASID roll-over with (T2,A1,G2) active on P2. This
roll-over copies active_asids[P1] =3D=3D A1,G1 into reserved_asids[P1] and
active_asids[P2] =3D=3D A1,G2 into reserved_asids[P2]. A subsequent
scheduling of T1 on P1 and T2 on P2 would match reserved_asids and get
their generation bumped to G3:

P1					P2
--                                      --
TTBR0.BADDR =3D T0
TTBR0.ASID =3D A0
asid_generation =3D G1
check_and_switch_context(T1,A1,G1)
  generation match
					check_and_switch_context(T2,A0,G0)
 				          new_context()
					    ASID roll-over
					    asid_generation =3D G2
					    flush_context()
					      active_asids[P1] =3D 0
					      asid_map[A1] =3D 0
					      reserved_asids[P1] =3D A0,G0
  xchg(active_asids, A1)
    active_asids[P1] =3D A1,G1
    xchg returns 0
  spin_lock_irqsave()
					    allocated ASID (T2,A1,G2)
					    asid_map[A1] =3D 1
					  active_asids[P2] =3D A1,G2
					...
					check_and_switch_context(T3,A0,G0)
					  new_context()
					    ASID roll-over
					    asid_generation =3D G3
					    flush_context()
					      active_asids[P1] =3D 0
					      asid_map[A1] =3D 1
					      reserved_asids[P1] =3D A1,G1
					      reserved_asids[P2] =3D A1,G2
					    allocated ASID (T3,A2,G3)
					    asid_map[A2] =3D 1
					  active_asids[P2] =3D A2,G3
  new_context()
    check_update_reserved_asid(A1,G1)
      matches reserved_asid[P1]
      reserved_asid[P1] =3D A1,G3
  updated T1 ASID to (T1,A1,G3)
					check_and_switch_context(T2,A1,G2)
					  new_context()
					    check_and_switch_context(A1,G2)
					      matches reserved_asids[P2]
					      reserved_asids[P2] =3D A1,G3
					  updated T2 ASID to (T2,A1,G3)

At this point, we have two tasks, T1 and T2 both using ASID A1 with the
latest generation G3. Any of them is allowed to be scheduled on the
other CPU leading to two different tasks with the same ASID on the same
CPU.

This patch changes the xchg to cmpxchg so that the active_asids is only
updated if non-zero to avoid a race with an ASID roll-over on a
different CPU.

The ASID allocation algorithm has been formally verified using the TLA+
model checker (see
https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tre=
e/asidalloc.tla
for the spec).

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/mm/context.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index b1ac80fba578..301417ae2ba8 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -194,26 +194,29 @@ static u64 new_context(struct mm_struct *mm, unsigned=
 int cpu)
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 {
 	unsigned long flags;
-	u64 asid;
+	u64 asid, old_active_asid;
=20
 	asid =3D atomic64_read(&mm->context.id);
=20
 	/*
 	 * The memory ordering here is subtle.
-	 * If our ASID matches the current generation, then we update
-	 * our active_asids entry with a relaxed xchg. Racing with a
-	 * concurrent rollover means that either:
+	 * If our active_asids is non-zero and the ASID matches the current
+	 * generation, then we update the active_asids entry with a relaxed
+	 * cmpxchg. Racing with a concurrent rollover means that either:
 	 *
-	 * - We get a zero back from the xchg and end up waiting on the
+	 * - We get a zero back from the cmpxchg and end up waiting on the
 	 *   lock. Taking the lock synchronises with the rollover and so
 	 *   we are forced to see the updated generation.
 	 *
-	 * - We get a valid ASID back from the xchg, which means the
+	 * - We get a valid ASID back from the cmpxchg, which means the
 	 *   relaxed xchg in flush_context will treat us as reserved
 	 *   because atomic RmWs are totally ordered for a given location.
 	 */
-	if (!((asid ^ atomic64_read(&asid_generation)) >> asid_bits)
-	    && atomic64_xchg_relaxed(&per_cpu(active_asids, cpu), asid))
+	old_active_asid =3D atomic64_read(&per_cpu(active_asids, cpu));
+	if (old_active_asid &&
+	    !((asid ^ atomic64_read(&asid_generation)) >> asid_bits) &&
+	    atomic64_cmpxchg_relaxed(&per_cpu(active_asids, cpu),
+				     old_active_asid, asid))
 		goto switch_mm_fastpath;
=20
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
--=20
2.14.1
