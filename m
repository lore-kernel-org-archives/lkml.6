Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234112-2-6092089496561132886
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234111; b=mQDArGxAojYt1aRKPFiEvWzU3SSMUn2DetZmWcMoynfvXsa6m+
    7FCpdTR0TWsJ6E7UZWNRaLSssF8JRWWEB6GLz/vWbmDznVZX4e7RN4SyToZLJbW4
    yQO1qIV6MBvdv5QPfA91+Cl1YXexQkQAfef3HNem9wMOAtfb9vUqLc0PjAk995N1
    MDMowOIfGXGiNqSrL3Tj11LPGX8H+LQxeMBTiEvRdf/xQ7rDo1QuRDoVgaZrgDCi
    fGe2Ccy21tblsl7c5Ms6K1HtKcUvtmcfMxcLf0YxxNyDRSBwLKnFiHW7LtkWTtfq
    ZccDGgILamcK0GoorJsDWubD0Hm4PaIfDLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234111; bh=pgL5iDLpPm
    cSuiIq9FeHnymmSAws8Xo5GKl5wykUdZY=; b=D3Oluyya6Ba29iEj6WkoYsc7Up
    EO0OMivwkoW2iaNT71A6fWfvBePwf8atbOZW9ENgmP2pXubiL0h/NOAgL5HdBvbM
    NPWsuR1LJpVfTKlNWIWmJTkTe86RYUau6tPjZgDZTgIlxW4L+t+EXqKA9OrRuB6P
    cg21T/inpXfD6/l+d51YTTYYJqtRDrbGT8ko+cJxQ3eUJhaZ0vaTaMpM6ytOtnv7
    wyrb2p3e90yiW4YyDDNoBrh1MEoaK4K5jrpxpx2/TayKZ5607GEq7yJEtSjvDgX6
    fvM5rhuMW+hur6CyaKYXDYgocoLvRJagi6c9GBq1Uo+FOu8Jk8YAmD8Xur2g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=co8L2jqY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=co8L2jqY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEky+CHjoO20keHmLSLDyegANkNrQgxHwrWnOp63jIQwn3kYo7xrLOlDvI88HZg1K1F0wkkFAHtGLZGKESSvEAYxQdS3rQCoqv+ZizlGZioQrxh4hsFE
    ljPuXqgBNsmgD9qbjxdg35bo9Ef73S9fbleYoqdcTJw3cjblLYIoK/p8ehv7Xf3ySQKkSoREe/0N5IwqMJFHifT15i1LRhCgKFcNT2iY9ye2z3dUtQp/1Orn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=UqCG9HQmAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8
    a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
    a=30ouwem8p7Oa7RGj-EIA:9 a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeDIAe7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:34:59 -0400
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:46358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755731AbeDIAey (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:54 -0400
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
Subject: [PATCH AUTOSEL for 4.9 292/293] cpumask: Make for_each_cpu_wrap()
 available on UP as well
Thread-Topic: [PATCH AUTOSEL for 4.9 292/293] cpumask: Make
 for_each_cpu_wrap() available on UP as well
Thread-Index: AQHTz5lwkvhPa9Gn20ydvw4OEKXgDw==
Date: Mon, 9 Apr 2018 00:26:45 +0000
Message-ID: <20180409002239.163177-292-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:vqRGxQ0+ccts4TZ6bnaVGxcqUREdBabCldLUZ9LzC10NSkU5ot1NO0IK3KDYoh7jP7aeBQ5p/VTizm3TNxMXP3nt5T0NDrMgMVzkjTaJUuGED97jEwCu1qw24onncBMw2n6MO4Ij0Xv6w5G1ryK2wuHYVg+jsXfEZHUSNhby3O1PuIayS84V1jrvo6n/F7dv8DWtWJykY73WZBK7EbhXhav+siM2lbiV7tGNjvH+/RywVPJK+V2keS0aJt2K3Y/S;20:+fQ7wcyYXrTx2GO3rhAC9KgRhIa5wOMbl6bC+ILeFojceWGPWZXCUItlVYfJRDjR2ZvHYB/hlGPTDIgrLwyTk5BJnaJsG2IVp3Pbb9M9THAK6PeTvFetsS8feboJMSKSUPSkEK/eu9kLpB3VBDM3KsBm1DFe8WJNNxQCUrCrK9Q=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1c33a7a-1139-4fbe-c76b-08d59db1b371
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806C87ECA102E03E83E9CBEFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(189930954265078)(42068640409301)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(39060400002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(575784001)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qfU0jS1nM3FlXffp+pNHZ4kEFuYzlrh7bcFwkPaefbG1+s993Uu2gQQoCkHAuBWaDuZrPWpUBD/CgG7bxhxFJJk3BtmVbNsMf/xYu5D3cOqK0zs3JDYSD84x6Ez2oeN468uFNHOT1XxWFC5Z7ZMwsruKOTO72YdHP7YqffAPlI62uN3/qfMR11SzBoQV43hgDn4YWL+Y64BGoyq+GrLZsG+k7mrg6TMeIXp2kPgHb7jVJ/M3QPluonFiaNMkJQxhc3o7D+uRLy0ufZuBQnU+MFhhWwZGXxuSfjZx3pnkoq0Q36vEfuslO6GdAzVL/w/WUR4G1YtNiggrQh6bQP2KqT/YBLJWSBqwQYIlNpbTUswX0o6ToyVuxhNsvOWEIO61BHlirCVZDvlfkUC4GY/N7XztTu4RsOJVXnDFMi3dSRs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c33a7a-1139-4fbe-c76b-08d59db1b371
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:45.0822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 2d65bbd6dbd1..c6d12da39c3a 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -164,6 +164,8 @@ static inline unsigned int cpumask_local_spread(unsigne=
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
