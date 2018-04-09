Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233325-2-14794015038542528595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233324; b=CA1CiFdR+xDQdWH9x3R0xHHMTd+/ZbMvbP3YftfOYq0qN427Ul
    KWf8VI5ljVOyuNAiHk+hJ/MATRPZPFD8K6T7pdIBZKC183SNdRTgvnBP3HTBB9zB
    0bE0efRTRjaKeUv0UQXNsoy3CzwWsZiDO8gq3Kw+qb40QgaDAGobj30h14drrbF5
    rvR0D/+453QJVpI6+RauV4RyA9LvN27Az/WKrSh/YuRAYtoOOpwoUyMhtNV3cslX
    ThADIKJWtZLY0ISKLyMMM2OkUZOtxJkcacLDhI15naN2zYwkzHMqcz6YZDUOv3FH
    IfLPFnOk4z11zjOtnXYQQvtnf5E2o9FNed4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233324; bh=G6FBAzAhD1
    ZuEKsN4Fjtjy9z5YwNPzgjPAxjD7vsxus=; b=jk/lXPLdpGBUxs3reF3XR1/0n8
    ypdz/cp+coUZc0Hi1t2irVHeXYEesMRcaSGzK94kOPfVes1PY4i9UfqTKIje1Mil
    2nHx8Ot5iB5ffjQNJ8RmrM4GnNjeH562OqJDugHcaHHnLPIAqibzckvFgD4LvVkx
    RjetiVdSKXQevejqETXyJUkn3m+nVwuS9FQ7slSsZy0ktuDfVQUHZo59SKM+M7S/
    E5ofWq7tkEQABIY3zVrxz8zTituekGMHgCA+w1s+IGgk7wLKF0JueoykyTbEKA7S
    DGTeFCzbzhtiLzRF5RcufJ35BCnXE7F/pDJbCyiO6OvSTtWMh5Nh6mPy/Nbw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M4b1GYXr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M4b1GYXr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBQ0SdIIqv/y6rgpO90M8qDpEA/Lrw/V5PELAQ76liHx5WljQB6RHy8g+Pru0W0gSqQx83P4hPFvtsDJ/EZ1uDQM5I/h9iRGiYHFDiCKvlp6zrcd7n0c
    2sdQ9l40OBaSFA7gryjCGe4y6stXtbbbPUpOhF8+5isPKuAQ2VJH7mh87wPUq1Xp8VqTeQ8U8EF6gXgxCD18Lr77E9hKQc6j0diBrBYjYwccbo48+bqMd3iY
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=UqCG9HQmAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8
    a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
    a=30ouwem8p7Oa7RGj-EIA:9 a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeDIAV6 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:58 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:35872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754538AbeDIAVz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Kelley <mhkelley@outlook.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 188/189] cpumask: Make for_each_cpu_wrap()
 available on UP as well
Thread-Topic: [PATCH AUTOSEL for 4.15 188/189] cpumask: Make
 for_each_cpu_wrap() available on UP as well
Thread-Index: AQHTz5hlGMIUaEniZ0a+eADlYu9dGA==
Date: Mon, 9 Apr 2018 00:19:17 +0000
Message-ID: <20180409001637.162453-188-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:wPBEVwqsRZryed4LZR+KZeHPD9iIbBuLjQ8eOTe3Zn9YGNtaj+bT1V+iAeENtRuk1zfw7iDFhQxjf5d8VIlnZmlUubGGVNDrlhEzcAaPRhr9ZMbV1y607SBkZ8pJXrUmMp/wjpyoxeEUKGtDLgzdA+Ag2tClwuWizxl34iSTa1PI5xIgkLlR6leKUBr3zMiA2TXxyD0o26GJdMrwlXWNsxsE7d48OrFM7FAYW7Kk9ScxKP2NIYT6+aNv89Tha+/x;20:Mb9R/gEJ3aOUrdjPmma86vMFw1WSab8V5S42ocxw1Zv4htV/6mSiWWos10DWtbdU5iEwmOyvhOjocuFRcxWa/uzUEbeE0UvvorTA+wErKbakW66kytwp0Ikqw0AV8C8yV4yOrvc9IchEHrs5laiddAvYEsw0ZSW31a8Vd4MuLyE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1929927-a66a-4061-1e2d-08d59dafe52a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936C5BC7452EEC9CC95F290FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(189930954265078)(42068640409301)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(6306002)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(575784001)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(966005)(6512007)(86362001)(99286004)(446003)(10090500001)(11346002)(39060400002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UOge+KTI7ZSsqNxIxTvaI25rvHJfQwSfPfqpfYmp0ONqIHwW8MIT2zgvHtU2eOg3ualjxQzJV4R6KUVnl4Ww7Gz7b4IAqswpdzLr4ZRkmESe5RPOYSCWMKHVGI208/wTHizNYYIqXR1ucMLexQ60jpBDSRMpufZjZJVqWFmwT9LD8z3ldufKwxjGd3NwO8Mxp5ZjFCJ6PcDJoeZ3ZgoLeVExG0jm+TUthgmfDTaUQX0iH5avKPSi7oSGgF+frSDsDdPQdZiA3E6o31/7jVKgWcn8U22mKEq6/G3lOjoCQfLDjgcMY0v3wBzL5BF/W9+WearrwNPuAas/IMPo4nrWPxYijbPxJh/hWSnBGbDMMhnONiMA3tNjZ012QQcA0RKsilAau1TqYJjeFMc7dlDAJxvh+ELtgUy9tLyKk7v+864=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1929927-a66a-4061-1e2d-08d59dafe52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:17.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mhkelley@outlook.com>

[ Upstream commit d207af2eab3f8668b95ad02b21930481c42806fd ]

for_each_cpu_wrap() was originally added in the #else half of a
large "#if NR_CPUS =3D=3D 1" statement, but was omitted in the #if
half.  This patch adds the missing #if half to prevent compile
errors when NR_CPUS is 1.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Michael Kelley <mhkelley@outlook.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kys@microsoft.com
Cc: martin.petersen@oracle.com
Cc: mikelley@microsoft.com
Fixes: c743f0a5c50f ("sched/fair, cpumask: Export for_each_cpu_wrap()")
Link: http://lkml.kernel.org/r/SN6PR1901MB2045F087F59450507D4FCC17CBF50@SN6=
PR1901MB2045.namprd19.prod.outlook.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/cpumask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 75b565194437..09b8d8aaa35f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -170,6 +170,8 @@ static inline unsigned int cpumask_local_spread(unsigne=
d int i, int node)
 	for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
 	for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask)
+#define for_each_cpu_wrap(cpu, mask, start)	\
+	for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask, and)	\
 	for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
 #else
--=20
2.15.1
