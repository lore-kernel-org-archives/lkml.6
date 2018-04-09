Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233317-2-4751013998703797873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233316; b=LW+ZdpOkhzvzz+bYRI+SSr/XIKyKWT5ndA5PGn2UI2DzV14/1X
    SBtuWxvf/9imdzz1cnblENm8ckheoxGUmdn5neQV28aCquKyG88c8/4CQECPIyTR
    tELZagAjsDJhGZWhw7V+mFNp3/BcPzFlDWaZ2y4mRPB0/zBBEdpqT6KFwDB+B6h4
    I4TQouHgJw+qDb3bqetKLp/Ikca73eV4YS8QYWAyxeJKoP1jv2V1ZPPXI6TEHkvq
    Pn2jOQ/Lcz7H1eXZKbKVg7SG7xVhCLeaa2G0HjeXBnL66cJPvJOH1Aul3iwSQKkN
    sglg3ihFWOospJTfvPCxwPHkGghlw3TE6p6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233316; bh=eupEr1OImI
    C1dqrHon02FUZNbis2rWHcIzoICgpkI+s=; b=DKuvGHXuiZRfug8ZCsiOijaU+D
    pmZox8DP7kB5V3Y7MGOgkucSz/FbZlHgtX4wfiZAsI7DlC0XT4pxYCM2cGTb4Xwk
    wKjnJCmCC7kXAWf9DxoabrrTdpq41v298Sg5LIn0iy93EWHB6JwdA3QBy03BmdDi
    nKn+ngPy9vUrVPUJQ8StFByfwgaEhp/cphj2tz4rZtyV+hI/ZR6vY7b47GrYUsHZ
    IiAiwlB3Liix4zBdKilwTZ6FoZlDB8r+DXcMqRF1wM55geqtCDEmPbFUt6+7lbni
    8o3TWngmpGSVacIRYGFM0FfK7JYm3K01dtl/GHLu5BgHCtaCWa15SnAe88aA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m/8/xtTB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m/8/xtTB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDXNlWl5FpIRu33CRQVIN6ot8rP6cJ8WTAnhNDY2l4CJH/BXF7S6rBFg31U6C76qjJVxOObqTgERbC3MJEovC7JG/FEOmMwqi2N3cMsNXNmQTKSZwEjL
    WTMtuZkXcmXrs1uHqSKC+iROhN90mSwOIxMgICQoLuS+URI8BbHgIB49MyS5D7kaCE0rNnFMB4rcMFBY5mYBVn3JyGAXGP8b3Tjvwnxba5lmO4rsGeGIv/1z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=XapYkokd9fjVYds4b-UA:9 a=wPNLvfGTeEIA:10
    a=92Q717GQZsEA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbeDIAVy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:54 -0400
Received: from mail-bl2nam02on0124.outbound.protection.outlook.com ([104.47.38.124]:27520
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754514AbeDIAVw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 184/189] locking/qspinlock: Ensure
 node->count is updated before initialising node
Thread-Topic: [PATCH AUTOSEL for 4.15 184/189] locking/qspinlock: Ensure
 node->count is updated before initialising node
Thread-Index: AQHTz5hjB8f5t6qcs0yvvTsHcbKj2g==
Date: Mon, 9 Apr 2018 00:19:14 +0000
Message-ID: <20180409001637.162453-184-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:8khjXMp6EbU5LHbjQS84+CW+TCZM/FTdOYCTkIgKW4QVAGil5MUHtmETiQZREqrR5SoPQbcre6CzDS30CxPdBdf+6v9kpemmcpoUk1LCPrsWsIQ7gFJVGRVJZ1r0Zurg9e82uDKb7t011QYR9+Cj6GJqsWMjAheLgwwbJD0+u9R/hxqt4DFCCsxIwEX7K5KwnAsl+S+xef8m/UsNJMRKrbZC5+idaUjnaNNYXZCpPE3mAJmzPq0C0PcmXATAmYBb;20:ujbLrDDs0+6jcl4SV/W+YfoPPLm3CalB9lsjPNeZ3Gswv/ZTOIPkvnT2czJ2MJEusK9Jn0lMReitfANVSav2ah9Jq10i8G2yfQ27csThYfOsOWBcPE+PJdMZGzUDJeFgzP3Co5BgrK7CjxEtrL/kLb+cTEFhN039Px7/OHq39mc=
X-MS-Office365-Filtering-Correlation-Id: 7fc6e134-e863-476c-f5d9-08d59dafe39b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125D4DB11FD411552DC5DB6FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(51234002)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(966005)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(6306002)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C7xk4qsiqvQq7PUpbTRyY5B11EvboGxceJfdfynR9KuXgiYso+HtUpD89XNXQBkXfpDTGBPlx86Yb/D4G2nnQNqIbeJnde+PESv/BHt0+41nY+sHaT/AXK845wFNs4i1B+blPximBMpwU19JTVa7w3/nta6PyjMMsvw56i9/fJP4JiIDmqLBDNHGLjk59eFOM1G2+ammDjLRXe4XVN4Fq+dNwj5ElADHxmjzaxLNdWKlZJwjwUsgpmo7hzhpPc0miUUlrAjGw9Jf6sTlK/PejjPtwdv7ZrHaU7f3rFtmAVqDaARjAaKTw/LI8ZqQiYsC8doBJvSFp8x1cY5uL65ZSFrEuuSBUQNLRTF0dX/OLjI4PSwMtaxxo8e8veHUW40kHwmJorl+31m7O9BKeijSa4XDdNNG39aKd2nF+IEIiZQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc6e134-e863-476c-f5d9-08d59dafe39b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:14.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 11dc13224c975efcec96647a4768a6f1bb7a19a8 ]

When queuing on the qspinlock, the count field for the current CPU's head
node is incremented. This needn't be atomic because locking in e.g. IRQ
context is balanced and so an IRQ will return with node->count as it
found it.

However, the compiler could in theory reorder the initialisation of
node[idx] before the increment of the head node->count, causing an
IRQ to overwrite the initialised node and potentially corrupt the lock
state.

Avoid the potential for this harmful compiler reordering by placing a
barrier() between the increment of the head node->count and the subsequent
node initialisation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518528177-19169-3-git-send-email-will.deaco=
n@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/locking/qspinlock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 294294c71ba4..50dc42aeaa56 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -379,6 +379,14 @@ queue:
 	tail =3D encode_tail(smp_processor_id(), idx);
=20
 	node +=3D idx;
+
+	/*
+	 * Ensure that we increment the head node->count before initialising
+	 * the actual node. If the compiler is kind enough to reorder these
+	 * stores, then an IRQ could overwrite our assignments.
+	 */
+	barrier();
+
 	node->locked =3D 0;
 	node->next =3D NULL;
 	pv_init_node(node);
--=20
2.15.1
