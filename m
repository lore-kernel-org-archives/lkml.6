Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488664-2-6896269497269166789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daenro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488663; b=Jb/3GZrZfhl50KS2/M2jTx0R0yEFADCaZKxeP8fQDdq7yrE
    E1ANfpUVm2H1ilAQNakfDoB7F8CoNGNqVMxxpRLzqhGrHhbXCNIWyNkepBXFvwAo
    vaRpGeaZCtbddCQ+wNAymrVFZvUNBQlc65OJxrUyLHlxI7Zyb4/t6pItV3Sf/03S
    tcNZY5qSRDivGMa0Z92NUKjPNhjTbaJXhEqxrRKB8INqO5rUo8GyxxHiUvFu6FFJ
    tgpWTVc6ECP5XaytkKZmcP7XlH7tTtVAQbC4CE7m2UuWeoa+dMjSAbeh5oIgjqY/
    4nDau4H+WBlC/5qNugkgqiqxbzeXFzeMCE016iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488663; bh=kYDo+6
    LqVuEQ2aZpr0zuvBWbXmAr27zP1eiUglKnVjY=; b=RTnK/3+tmfXxtD/1o4lhru
    QEp6EFiYKsFBaWopK1Y2BhGpH0oWFEnV/a04+oT1tyVVvjXR5Mo+VCeP2sNTzMuc
    lXxKUMt7Od8a9t9L3laIaVJASemt5JF1qIkbMWE73bxzWNl447/nGemgnAY7Oujd
    bsXZUJ/fpTrncU6stz8zsu2i+hnBtdzD07alGArl5msoFdydBOT5pntASDKvKcv6
    P4pJo9CkxzDHfiSOgC3Vqt9guCh2JK568UbDTnSIzT9sxrG2yHma1dGNVIf8iOrl
    N40Dv/Hjz5D7qsFtQ+ma8mIljvYrBQG1LngDBHfCtRAfo6cLNZd6HHWFiCoTDn8Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mJCfg/07 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mJCfg/07 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755256AbeCHFD3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:29 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:38578
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965755AbeCHFDY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Rientjes <rientjes@google.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 144/190] mm, vmstat: suppress pcp stats for
 unpopulated zones in zoneinfo
Thread-Topic: [PATCH AUTOSEL for 4.9 144/190] mm, vmstat: suppress pcp stats
 for unpopulated zones in zoneinfo
Thread-Index: AQHTtppM4TiDaitFPEqsIudhoenk8Q==
Date: Thu, 8 Mar 2018 04:59:55 +0000
Message-ID: <20180308045810.8041-144-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:d+Q82s42OeggmPlBGM17AVW/hPOwwl1z84VNKGxxsdyNqSh1Xg3oh5fAXZ9vMTSGKijxo0GFErMKzoTLXoKjdqWL3R2qIYCO3XSwerr1yOuqFaMqA+EZF5iYKTznHHyn3/TCqiO0EPFGixaomHye2I7R19Lj6A7bzcd/hYPerqU2aknW2Rp4VNV7sJnsau4MsDVk1lunwTHLLenLWG0SVsFtYWx3k1glb2mx8c5/TLgymcXTMdEfCXGNNXdBwzkR;20:v+kLqyk1nQibFuMHY+jfeNahd/BVXI9BU6yyUlW23YrhDaguuA/Q53pyKG5q5opqFn0NeDQyUxuvXHUs12FiVGH9ajfZ5SYNdxbzFIX0FK896dPX3El4ForE4pvfYm9vzBPibCtxnH9MptptZvQkPyO+hPRLoG+gZ2LGQm7cu3M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61cf6dc4-2259-431e-691b-08d584b1e992
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902709A775A6BD5D5BBB0F8FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(966005)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6306002)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: yoNDEVCu5PCZMdSLI1dlQrCETzfkIvjKkwj+Agan3bi6oFxCgOBT+tk6ZWhxncD8lmVsmPKYnZ4OQqhsvWiVM+INgDOoamCK+aTwnfnVFL0i2tP8UZDiD/OnFU7MkF9oUvFiWFty+QiZei/EgM3LQeYKbu5FWUU2IRG4vz4QDO0Uh03pQEAC8ADjbK/wRRZMsc5RGgFb3zj8QskvCnE6y1GfKAG74GEds/aOd1ABpounU/4k3cvnyblt8SPWzEJyj+zkwDwOYg8itWUG4HMkG6CfQGKSbsbM1YDvC5Y+PTA5fRi/M3+PA2OWX9+Ob6xWOW03Yg9oyy+J2TbQB9SBRw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cf6dc4-2259-431e-691b-08d584b1e992
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:55.5322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Rientjes <rientjes@google.com>

[ Upstream commit 7dfb8bf3b9caef4049bee51d2c22e1c3a311d483 ]

After "mm, vmstat: print non-populated zones in zoneinfo",
/proc/zoneinfo will show unpopulated zones.

The per-cpu pageset statistics are not relevant for unpopulated zones
and can be potentially lengthy, so supress them when they are not
interesting.

Also moves lowmem reserve protection information above pcp stats since
it is relevant for all zones per vm.lowmem_reserve_ratio.

Link: http://lkml.kernel.org/r/alpine.DEB.2.10.1703061400500.46428@chino.ki=
r.corp.google.com
Signed-off-by: David Rientjes <rientjes@google.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/vmstat.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3863b5d6d598..68b3193e4493 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1387,18 +1387,24 @@ static void zoneinfo_show_print(struct seq_file *m,=
 pg_data_t *pgdat,
 		   zone->present_pages,
 		   zone->managed_pages);
=20
-	for (i =3D 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		seq_printf(m, "\n      %-12s %lu", vmstat_text[i],
-				zone_page_state(zone, i));
-
 	seq_printf(m,
 		   "\n        protection: (%ld",
 		   zone->lowmem_reserve[0]);
 	for (i =3D 1; i < ARRAY_SIZE(zone->lowmem_reserve); i++)
 		seq_printf(m, ", %ld", zone->lowmem_reserve[i]);
-	seq_printf(m,
-		   ")"
-		   "\n  pagesets");
+	seq_putc(m, ')');
+
+	/* If unpopulated, no other information is useful */
+	if (!populated_zone(zone)) {
+		seq_putc(m, '\n');
+		return;
+	}
+
+	for (i =3D 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
+		seq_printf(m, "\n      %-12s %lu", vmstat_text[i],
+				zone_page_state(zone, i));
+
+	seq_printf(m, "\n  pagesets");
 	for_each_online_cpu(i) {
 		struct per_cpu_pageset *pageset;
=20
--=20
2.14.1
