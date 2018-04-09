Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238048-2-10636175363315781624
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238048; b=R7SxrKSV1nKqFWCL3H4DGA7leuCqOA3cx2CKn+Nk9L+u+u3cKo
    5gYbTskesB7Z3GZFI/Lbt4oKJ7Y/6lDQAHWbrolB2yfdp5utwn8pMByaMhs1D0vp
    kR+qgvUymtL9vjaAXXMZEg4OK/QoFS3wAY7xJsYEMpD2j/60SVPJbDLnYbg2T4h9
    ZVLZ5Pfz5qXi4lCTfFHroSipRNcn9fQ0B8OO5C7VeMhG7KPQQ4WB+gAwyVOc88ye
    dOzS9V4Mf394TBGOCzpWP6G2XLVbNgacJubj/1fuyjTdd3dRXUk+rtZA3At0lRQw
    FvpBFKG79gegOoSoyS2ERT92G9s2FHWYTFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238048; bh=Owe+6O+Pgq
    zUoi0UhjZx4R7ZQFkQoYIB2fiTKSPaMQw=; b=cmM7453q4iyBuK2mIpear6gXao
    1pq4ZiRCV9POwDJpDby+/6r+Pe+aSMP0wMiBlbOZOTQ9vj7QBM0c4o2dXgGdZ7ir
    sHKvNsImQRb7eGm7CUge9FFBkXyOLHpAJM+Eo1/lp8uP+VsWuLb2V3VL33VHPFxj
    Z+IYaBxvkf/9t+k81TX/Ti/Ohpa8oCoMwu/xCNsIZlgo7GKQXaoDGhARA57Jq1SI
    JhanqnfzrWzdC5VcquxSGmqmQHYb7ou0uH/6FSlvQKrT8igCDJHiS4rndTi+kw4B
    Tgtxy8wq2O9GV8u6dGkNyMV1WnZb52izZWynWOlvK9ylOphUoIE9ed8QIBmA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PVTkVVDI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PVTkVVDI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOo1TMvBAdm/y/uwUnhTF3QMjkVocz76rDPCSf+n2YWWdkHBOQvBGxup098+aRqr9kuzxFxSFoeHfv/56xpF8Pdhn7EGQvI+lMXFgMfMmyoHSRHU97LR
    0N3oxkHE9thz74+W6am2JyiSa/41DTk9/iGieIFgUzcl2Pr4kQTUPgwbBjQ46OUcIzqY42nRebWKmCrC6e7kf69Mm5k/MpeQZUmH2Xe+CWxIS/RLR9GA905L
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=TiaNW0bfAAAA:8 a=WsHKUha7AAAA:8
    a=yMhMjlubAAAA:8 a=HwfIkp-pSQ9a9caPooYA:9 a=wPNLvfGTeEIA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=AEymbdFwRXaGbywpKsZu:22 a=H4LAKuo8djmI0KOkngUh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeDIBkb (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:40:31 -0400
Received: from mail-by2nam01on0110.outbound.protection.outlook.com ([104.47.34.110]:2593
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932537AbeDIAe7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vince@deater.net>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 003/162] perf/core: Correct event creation
 with PERF_FORMAT_GROUP
Thread-Topic: [PATCH AUTOSEL for 4.4 003/162] perf/core: Correct event
 creation with PERF_FORMAT_GROUP
Thread-Index: AQHTz5mUoLANajnT1EOSCoXrBbYc1g==
Date: Mon, 9 Apr 2018 00:27:45 +0000
Message-ID: <20180409002738.163941-3-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:uGyAGl5xOzITVczSleHKrir3LQFgWjXKufypvjkgZltUDt/577qu7NpLbS809SLnP3MLezlra13cGiXunINep/jKMHPkk9/6n6rt18RODDTb4IkW6jrTOuGMfOuqDdSGiSjluQJdQY1eP+06tFV8wtti4hxzUG1QvEa8VkRsv8GkOmZfGNxfIhECUGMxJkfzuR6QKIWedQbdb6Nb42Epqj5rK5UTID8dtXP2Qt3sacbqxAHX2Ulx5fS/m31RZe3A;20:inpz3OZCsX+UT5B3Ce39BshAK0CziPXZO2U9uIXDyGtssSqOrmXkOk8bpCNczCxe2VLx02zq/XY0LDGvDnVBTHXGBhpRkTlWFiBOCsOWn2EvA6NSdXN8zcU7IlX235uf1I6bDFioGKOatTR48l32rFWUoOOF9+lF6QYuldciqeU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7898014f-f387-4c61-904d-08d59db1b4bf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08067C80D425A93A53C0A7C4FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(7416002)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lvS2xFRjnJoLOnZCK2AVMNC9joO0MaOwVB1ZxnQjED9gjUNhtaaU6tM/IFRT1QVUDh6ZKKHd3Tl6xvpxYTflfRv7v6nq2oiM0QD1IOJQVvPLcO9pbTXcoWvzmBa6xM4eYBXgWq/rsXIabOD0A82iQSAnWC6mwms3Uv1wkSZp32U5I9u30P9dOC3xx88BxuUuOT3phvC4BUNgsRROqsJEb/xMyp9pWfG+evaVNDt6aHOc8hFIU88+w9zzNi+5gYYZSeIYO+c8imX6Rs9gAVCt3od8cByT9ldgJidit7Ql5nuSv4o3ftQw5mmgQXDrQz+QGR9D3dAOAtp8qZAU3i3ctR1sasNtdnX71bBSiFCaG2rH538uBtF4LD0v/wgGLtpG0Y5vquy47vME6A6Ia6zs3xjoE12Kdv50MvEoYwfbwY0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7898014f-f387-4c61-904d-08d59db1b4bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:45.3328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit ba5213ae6b88fb170c4771fef6553f759c7d8cdd ]

Andi was asking about PERF_FORMAT_GROUP vs inherited events, which led
to the discovery of a bug from commit:

  3dab77fb1bf8 ("perf: Rework/fix the whole read vs group stuff")

 -       PERF_SAMPLE_GROUP                       =3D 1U << 4,
 +       PERF_SAMPLE_READ                        =3D 1U << 4,

 -       if (attr->inherit && (attr->sample_type & PERF_SAMPLE_GROUP))
 +       if (attr->inherit && (attr->read_format & PERF_FORMAT_GROUP))

is a clear fail :/

While this changes user visible behaviour; it was previously possible
to create an inherited event with PERF_SAMPLE_READ; this is deemed
acceptible because its results were always incorrect.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vince@deater.net>
Fixes:  3dab77fb1bf8 ("perf: Rework/fix the whole read vs group stuff")
Link: http://lkml.kernel.org/r/20170530094512.dy2nljns2uq7qa3j@hirez.progra=
mming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/events/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f75386e61a7..835ac4d9f349 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5271,9 +5271,6 @@ static void perf_output_read_one(struct perf_output_h=
andle *handle,
 	__output_copy(handle, values, n * sizeof(u64));
 }
=20
-/*
- * XXX PERF_FORMAT_GROUP vs inherited events seems difficult.
- */
 static void perf_output_read_group(struct perf_output_handle *handle,
 			    struct perf_event *event,
 			    u64 enabled, u64 running)
@@ -5318,6 +5315,13 @@ static void perf_output_read_group(struct perf_outpu=
t_handle *handle,
 #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\
 				 PERF_FORMAT_TOTAL_TIME_RUNNING)
=20
+/*
+ * XXX PERF_SAMPLE_READ vs inherited events seems difficult.
+ *
+ * The problem is that its both hard and excessively expensive to iterate =
the
+ * child list, not to mention that its impossible to IPI the children runn=
ing
+ * on another CPU, from interrupt/NMI context.
+ */
 static void perf_output_read(struct perf_output_handle *handle,
 			     struct perf_event *event)
 {
@@ -7958,9 +7962,10 @@ perf_event_alloc(struct perf_event_attr *attr, int c=
pu,
 	local64_set(&hwc->period_left, hwc->sample_period);
=20
 	/*
-	 * we currently do not support PERF_FORMAT_GROUP on inherited events
+	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->read_format & PERF_FORMAT_GROUP))
+	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
 		goto err_ns;
=20
 	if (!has_branch_stack(event))
--=20
2.15.1
