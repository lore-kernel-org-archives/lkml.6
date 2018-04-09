Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242096-2-13647107044789090334
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
    1523242095; b=QX50qtKilpmQZ8+4s28Jc9Eo4XarcNxzkDTO+++HvOFqvFpTmS
    KxcLllC6F8HmmRweO1IBi5a3fTKRSyL8CwQjlj6o4ILRiPNi93uW9/VDR4vizQTO
    pASsWr88h1vfdTdlFPLznM7xmVEHPCEQBicw/5nJAC7iq4p3s7YYL0EtON9SV2tz
    9OF2YVOnIkVDzMtWqFyof6sMswCwOGv9bZztUXtvjcKUdOFs10zug4gr6YImSzk5
    +XZG3VK9cJ4cCY4LdI8//KOoFU/UQgSxixxcAHfBDY2Yac7DgBpY9v61h48AgKAS
    pHsxMJW7vjZLy0LBCqSjQ5VtnqdrJ4u3HfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242095; bh=MLYrJxpnk6
    NYeGLyFIiD/EVGa4QbvIrRgWhvqHyqj/Y=; b=OzaDHP2aUYZDRim560wtiVYMKE
    gcRD52ewv4iO76vd8EPoDcXTxvYTruI0CIXpT3AH6xzngTJ7ZQKidQMgJfBY8GsR
    srhfCdG4hUeu6VmFMLoVC1D0YYKMxzK9UmBxJozzPuydbuRY6XNUMNCD5hm5rySf
    yAoBRUEaPpTdOilFrQeBYT8Ou2V2oPLRpjz7aH6mUiyRnmmpW4QID9quky68UPeY
    27uLjCJcoDFrIod1YgHzDYkmcHkz2tWBfjIxzrDc+hUUKnNphh1V+SUEBNd+90Cc
    00E40YAjyy+UO7RMStLFnunZNzS9mYh7sAe11sHDlZtsq8Miga8PRYbA+vLQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CvjWn81s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CvjWn81s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNRThgg/XHHCCDAjPZf7AJJhhjzpnLQFKYlPMH7zuh4BxI/b3GeuE3LQxKwXwpVWlaC3onBoZpz52iN26ZF1olt/sajzQMSkNwLJ4riGZEVgAAwlrTkX
    Ox/x4p0ytgpOZNV4Jh4VqMPuIS5BLW8dBrupp2eJUtk8dw0O4WbczbxI4eFUv8A1NAfZnJ0PQujgu793Hz7ES/g99tAIUp7yHsDysBWo8eydTOFwFlABsfyb
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1755566AbeDICr5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:47:57 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755393AbeDIA0j (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:39 -0400
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
Subject: [PATCH AUTOSEL for 4.9 006/293] perf/core: Correct event creation
 with PERF_FORMAT_GROUP
Thread-Topic: [PATCH AUTOSEL for 4.9 006/293] perf/core: Correct event
 creation with PERF_FORMAT_GROUP
Thread-Index: AQHTz5jlREnPcUaLyECsKahc5X+CJg==
Date: Mon, 9 Apr 2018 00:22:51 +0000
Message-ID: <20180409002239.163177-6-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:fPsr7eczgChn7HgEMVXP+iagAHoSr9SGT1M1xWxLOmCoLicyvgbMC594MnW6dwuZYDgyFv3RF81N8ELd5kbtPXCHcBYqXjkBOSp5sAlXmhrq61qbZ630mQweYEkgf+mKJF8z28gF9qUhiA3iMW8skLWJj7SPUNgFqxeYd1bYuZQCqzVGssUfQo42VzuKilscwIbehvZk3vsl6ghe1BcUJGLw7XV5I0HOrg8LO+tNtPyMieerkWLY7Mwv6YhmMewz;20:G99FHXz/fwrZSltwnDbF2kzDle9b0zwSM+hs1ktFVEj0mplew6lyBENOu8CfdNM4FdTrYCMcKyrNCOQSsZpvukuiHMUwAfU74LGyLXR3bSymtyPPCxOYB+C7RH/TpeKNgKnz3j4ohYsDtTTfkD/KO0nPEObMEx70sVRKsDHJ0kw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcb9a3b4-dffe-4b27-b990-08d59db08c26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101522A63C3D837384110068FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(7416002)(476003)(6666003)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hjCg4LEfIMVIO8oaP3U0xKhP7DjPi7cITobtfEHqjYNem3p320ArftO86NzJlp4AqvemWBanIQrxjmY14o4u7/Bo1qSA9iY7lmU+ZLwnEvJBWIKFeOPe927P/rg7SaLiPoFGJo5NhJ0ihkElNHDm5EWKPCp2pr7fcUShMpURh7FzsIbi8Z6pRFLUmBa/6I6Jm8NkuesgyRUM3b51NmR1trIAW9H0vfSmlPR16tXNGX9GyTiFhHd6fXKlO3bw2CVG6Uhba79FHSP9lVlV1B1APWWHsGc9KNilJjSMgRDtqxI7/buJbULBBm9I5lzA5xFu3/HdSmbOXgeUI6bJnYNsBDb9aX6qCptG/p9fjPqTYiPDRyq/g36n7njF+U+mK20vR+OeK1XUVXq7QqoLMmzYFYb2BbiAvyfjWzTEAxfnn/Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb9a3b4-dffe-4b27-b990-08d59db08c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:51.1904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 13b9784427b0..4d6f2cd59696 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5669,9 +5669,6 @@ static void perf_output_read_one(struct perf_output_h=
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
@@ -5716,6 +5713,13 @@ static void perf_output_read_group(struct perf_outpu=
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
@@ -9259,9 +9263,10 @@ perf_event_alloc(struct perf_event_attr *attr, int c=
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
