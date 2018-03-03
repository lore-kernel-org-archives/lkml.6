Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123558-2-18300925538434665503
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123557; b=K8fK8w9Hnr02bjQQ/lR4SBwHt2/tUaQNUACbrXuRZCfPYxu
    vd8mL+NVJ5p0S2HzKo4dVeYYd+wLFlxVzh+P3t01iFsfGu+EYI9eRKelGp3rNhjA
    7+YdBtU2Gm3zOxbcufKl/tDbMc9bG1bq7DDlE3Uyh5ugxx/wZo8j9+Sahr2585tU
    4IprpV+yF+OQYefNs718A5cb+/fSdk3VhelkKasnxI4ZYvwqquOQeGpanR0GOezY
    s4LrdrvSS7MCeIh+RNzMYoM7xd7mKdVbR9EEiI/OJiFJ9q8ICq8i8puUYjHInZNa
    EXC7WbVpCqZi/eB/ZsnOeuCVdMzJWH3waZwYodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123557; bh=0GtO4S
    PnOif7hnF7PuevPqBkviJjvIgEE7OrbTvAvPI=; b=YMlImRP3si79Dh8xbcx6QX
    I83aNxbtJ+7ZrgwNYXbIlYfgOF7kSfnCPGqvqL4kyP+FpX7L/UcVRTXmhBDNfVpa
    LhjN9UUd27PifJ1V1s6tPlg9Am4na+zqOTTwtysB9DWJhM/WllEO3lepPr6IAJDH
    2uUVPTq5TOT9q2wSSzhQszi2fFXhvU4V91StE6YeelfC1Xr9t6fKrSGWQlGPtDBK
    nJN0Jwi1CZhGFU+XGXlGRvIC8mOBNadHl8cdlWEJMlUFxqvu5E8CXcTanzwlN8Ui
    Shjipz28qTkl23pdgzFm3dvnGmVxkXGURBuSdeY831ko7yjnYR6ojiUF3BLJ071w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Grfz+Y7t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Grfz+Y7t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932454AbeCCW1t (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:49 -0500
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:16576
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932963AbeCCW1T (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 088/102] powerpc/64: Don't trace irqs-off at
 interrupt return to soft-disabled context
Thread-Topic: [PATCH AUTOSEL for 4.15 088/102] powerpc/64: Don't trace
 irqs-off at interrupt return to soft-disabled context
Thread-Index: AQHTsz54MSwyrHsCTkiRY69wVtOV8Q==
Date: Sat, 3 Mar 2018 22:25:00 +0000
Message-ID: <20180303222318.26006-88-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:u+ZMigLRttznEMZUnEDYDdKM0dIEc2QfQUV8ZrhHN7es4BZuZYMBgE79G/z6wF2L5VOjZg+U0b89iwWfZbA+8KssHALqSeb9um0icBonVLRR3wV3We9iOMf1ldFMBuwOEof8CcbBOBM3bim/5oUONjB/FfcasO82V6PCC7bpr1+h6RR7eHBKGQmxHUb7QwwYNEz6pnOIi54hlzTIL4YYjG0APijn1S4Padvy/kRgQ5XWLdFPpiEEwxXdtC42xtW4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b98feb05-8504-457a-0a7c-08d58155eaf1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106716B94CE9D983BCA05D57FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(39060400002)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: s5Wp0iWnSnZnnYI0G85cNPc0RtOyxK5dIqOIfofh1k6XEzD4mDVscNw1tt+dEc4rUU1iafzm9OXQ/bGXRg1TvXoGVrrteJMEX+OJIjtH0yZVjf9fNKWwD1T20+R/QjLCSn5ZR0yd8+qyX4bmbLNEb0Z70bJjKYer2xRnLbNli5c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98feb05-8504-457a-0a7c-08d58155eaf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:00.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit acb1feab320e38588fccc568e3767761f494976f ]

When an interrupt is returning to a soft-disabled context (which can
happen for non-maskable interrupts or synchronous interrupts), it goes
through the motions of soft-disabling again, including calling
TRACE_DISABLE_INTS (i.e., trace_hardirqs_off()).

This is not necessary, because we must already be soft-disabled in the
interrupt context, it also may be causing crashes in the irq tracing
code to re-enter as an nmi. Replace it with a warning to ensure that
soft-interrupts are still disabled.

Fixes: 7c0482e3d055 ("powerpc/irq: Fix another case of lazy IRQ state getti=
ng out of sync")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/entry_64.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.=
S
index 2748584b767d..fde89f04f276 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -939,9 +939,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	beq	1f
 	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
 	stb	r7,PACAIRQHAPPENED(r13)
-1:	li	r0,0
-	stb	r0,PACASOFTIRQEN(r13);
-	TRACE_DISABLE_INTS
+1:
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
+	/* The interrupt should not have soft enabled. */
+	lbz	r7,PACASOFTIRQEN(r13)
+1:	tdnei	r7,0
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
+#endif
 	b	.Ldo_restore
=20
 	/*
--=20
2.14.1
