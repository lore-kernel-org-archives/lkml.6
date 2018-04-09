Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234114-2-14738481260867068258
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
    1523234113; b=RsZc0dk3xMSjCOErkd0I8hpNxAAkOTiShj/wFkGyE6X0zDxICm
    +Bwq1arAbYucVPCUx6d0YL4Xnyh06XgZrKcjKzJsg7napw/pPJKFId7sou/xr7Yb
    vPpZDP+cqlFuAdsHL7IK2KklqD/sm+hcFDYj+qYvShGxcew3T2t4kzxD9GRnViC+
    rtOyMKWrjRikZGXbkIgXCjPzre/nS7HnAMYdaL7ZW1h6ddoCpedFRCk1Y5Mlz3r/
    dMvBPT/RtWH8ErT88JYoZlq1Fomce/UyoUJ+a+JppSGB84RMmfSuAdhnc9ZojYNN
    qxAb97s/aIDV9qXmyuivxhJyJGVUaaQpLzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234113; bh=xv+MzhbRqk
    6xoDlsTW4eQIjUoBlwxhsDdVI7cKoOnXw=; b=wj0HqrETMkMyaH4ousDXgCreA4
    HdhwPjkXr67yC4vCzEFW+k6Cf1USR2O3CWQcd/ktLZPWVWiOgf1NJgkqMRbhNLMx
    Ym+/pnI0Y6c2TcRSnmmRuMKziprzLCTDGKRqsUqLjaLB7+57xRkuehAIcQCgbjR4
    YAfw+wqFpE3pRsgAPAjPR/uee+ri0ysxkpik9aUIlZ3OD20dunejBiRo1FUd3MFK
    eLUgbF+axzA85ckMqDRym7HSzDc9zU5/ULJZDnLd7ApwgxQDGRHQbkp4mmEj4Pix
    7UbSP5Vqhr45aDXqYAu7woLr+bmNRJXRlu5BnZpLFpS4CX5Sc9kyahMibDRA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F83qCKav x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F83qCKav x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJgDkQ/4wSniLoBRmtRqcOeEftRJgQnJnKTjJ3EZwfbTlzm2RRmXOnc/o21NWGD7qV2/oZzkqUapYc1PAmuhf1Fstt1oYcHOVH3pgCBeqyLrd3zjrGmV
    9mmKg/CdTZw0VuvBC36zFQIGsmbM/kfKZ+NlOz/U8bZa3dOuCgAtqvrtfV6nKfZ2gXeCfmD9Af0WM0Pcar/AfdUMfYfDv5DNhcZj4i7fvgCNNxWaKt4fABl0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=XapYkokd9fjVYds4b-UA:9 a=wPNLvfGTeEIA:10
    a=92Q717GQZsEA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755925AbeDIAfF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:05 -0400
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:46358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755215AbeDIAey (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 290/293] locking/qspinlock: Ensure node->count
 is updated before initialising node
Thread-Topic: [PATCH AUTOSEL for 4.9 290/293] locking/qspinlock: Ensure
 node->count is updated before initialising node
Thread-Index: AQHTz5lv3gsVWtfZGUasLrStRynHag==
Date: Mon, 9 Apr 2018 00:26:43 +0000
Message-ID: <20180409002239.163177-290-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:1ndrlA44A433YTBiF9hzuo1/r+CnFonUkhwRowYMBaXrrgpknjXUF0M36g9Sy2yiiOPKS3X4hZEBOfDc2n4IqOan3rXL8/+eTdCRGd38SvidhJerCMNJvV8rCEeP9ECgdiGKcnmWOhwLaLvK6nudd9k8g1GXrz+ZG8FwmcCkZeCLwYFyuUvxJRtQ0gQGzRLE+Sr8X5IGtulQRgYITOaC3QKmvmzhFZeIeYHzIcH6xEarzpEnHoYYEORxy3i4uh1v;20:+DDIE07lPdCbTsnGxuV+pvwKvUCk+riDnzEDCvMcKScn4PT55WhQl+D0/s7jDj3OOpYiGE043QDHrF8jO2n1F8Axw36j6whfAcUFk7IqLykn7WihbI1gQ/jNT9u7pMuxAqisgIghwVQtOBCt2wTUGl1h/i5TRETacYVxkwTP15w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e1e4cc9-963b-4cea-aa9d-08d59db1b291
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080699E727F409DA78FA7916FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(51234002)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XxQAIEH+exP27PlsnBWaX1ypGExaaqEgVY0sT2yIKqpPiK5f2gHAHL921ak3XsJ+u9uEmPUsb3chzgM0K7O3YcNmkwSr07UiIEJ4Qt9mNw/kCASvb719FGfsaypzqtvDvgCVdRp6CXE2rk5ADp4uoOXWGqz0j+uDqnKPuUOy/5mak6oS+s+U+xmnMF1Afw1UXQc08JM67fdV4KrKexxyMSU2O2WA5VKK1VSUwrMYj3kBw85G6YWbJ6QrjZaf6pHzEaLJwFrTnPaYP5W+fU/yhJFN0+1Jm9j7X8FWBvah8gP5r48c+3RQaKXdXh5Lqe1rlsQu8AvqTJM+qv74fPFV+/XzZniWdG6kWv07xlQ8SzxcjMKCKzIN5TOgahGGlzsn0CJFgi0mI0NA9fTTUqyaFnqkkp13dAeOaFM7jhhML0Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1e4cc9-963b-4cea-aa9d-08d59db1b291
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:43.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index b2caec7315af..a72f5df643f8 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -495,6 +495,14 @@ queue:
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
