Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521482063-2-7562559095280126642
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
    t=1521482062; b=qoo2cU4V2qAXh93QW6cCXw9ATsBwhBlRvo0HE7acmxbk59K
    U1s8tR3KS56mecz1t3K4cbacibDAWXIZeAZ0K+hjC4GZj57XOQ/u3kXpAA68GTWv
    STHRj246tZ+KIEW99MmLYiLMtMmMmWEW8uGh1jJxtA1++UhN3K5XXVk+oSBqM1Cn
    x3AebIX7nxHA72YcruUuv4uHthvlpQfZd+i3rLGTOBB9oyaik5HDOSpm1SnKPOSt
    8DrVH0pVm0Ot+OlB32zUJbTdo8NEyFRVB8S2hLvVqnRWWd8OCaFiOukojQIlqAWH
    WqakikvSqPl4PewjDGRWNArH/5j45RKkGfm/b6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482062; bh=v3lTvh
    T1LC6v4f9BvtrVdJkzQltcBhZBQc4KnWTBrsY=; b=ABL/YSgK5ZxIvz+2vV8GOS
    XUOwqyQzkQn/Hqi+NJ70nCQ0fDLB/h5W7Dg1hkKm4w6EUYTkkhKyfGalMuSPlSP3
    hARSxw7NWKM8GqZ6oKSh14iPxvO/PuUg1TVPty0Iq3Z21v+mH4v2z/CXz4kLnYg4
    UdKkms4Wqs5hNvrkdGYHEgsJo4ttM/8v60E40OxJO3jQydSQEURGLuRLLeXQRY/o
    wLVHQncLMHEeTloYBD8ne6sF2WtfuANy+d/12VlBBfq9sKg1RNaro384tJTWXg6f
    ypT9jbCMdmZyWk8Qr9G53ykpJUNtRv4zd/ckBwHpw0IoLlVv3nkzZookElap1t3A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f7ybmq2v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleejtddvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f7ybmq2v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleejtddvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968356AbeCSRxE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:53:04 -0400
Received: from mail-dm3nam03on0105.outbound.protection.outlook.com ([104.47.41.105]:45007
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965702AbeCSQEu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
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
Subject: [PATCH AUTOSEL for 4.9 221/281] perf/core: Correct event creation
 with PERF_FORMAT_GROUP
Thread-Topic: [PATCH AUTOSEL for 4.9 221/281] perf/core: Correct event
 creation with PERF_FORMAT_GROUP
Thread-Index: AQHTv5umSi32MImiOEWKgnOd7dXBhA==
Date: Mon, 19 Mar 2018 16:02:15 +0000
Message-ID: <20180319155742.13731-221-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:Usyrye2r81SA7zNUsEYmvlta/NRVfbABE8maM4O/ke3VHnT1mZDRu13R4jRKdB6a11cXvBe+fpHH5OE9SJZ6CVX+U0JRevkt0sf4BgRBP62te8Inm+cafqc2uC6VAQTdiPTiQXJowu+l+0WL5M30byzJ+UT+DUfsiDOuZkEm88/7q0Nf6fOkk8cO9Kyx4NbdIW9lOXj1udx75Wg2ifX9gJHZqAjDDLLQWRHI2nQg3lkxnaeJ13nRDjWNqypMcLLp;20:kdBz2ut1VC3pOIGEA4vjXr9ShNdXC+15TJHvK6RbIMaIxiUZrI/5nButGVf3VBP5Bo8nyMNlp89sjScUdqT0XQVT1G9UNTQ8TICPT/a0/lRQchOiv/MKTUfLluSrmQlQgUrLB4gCSSqS8Hr7TtyhHzUZ7yCHxd1Rxga8900bSQw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fa48d6d-3a16-41e6-6b9b-08d58db3214e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080543FC9CE11A3C8109009AFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(966005)(66066001)(22452003)(10290500003)(4326008)(6306002)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(7416002)(3846002)(2950100002)(86362001)(186003)(305945005)(3660700001)(5660300001)(6116002)(6666003)(6506007)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: l+STIwPTMVTKHRGC0VPd5ljEp5oRMwJ3jPz19qTBRNNUc3VH3dxb3geou2IZP2+4CJ3ifzVhcTjdm0BC24QM/zcIAe2gHZEh9TzYXHzwszevfYzFmUxeKJB6CDsLPworPIs+Ile/zylTJHrokY9dGQe03vw3IjcQzGUu6qM5bAfzqRzK/5nKFxHQndKQlOjb1BQiu84+CS4N1cSI+d+Lxdr4xqCf9HhS9M7qwlkVegUHDIh1SU4HSsRylVb7Qiz664pOvHzHoL81Oc6O/opBu3O9vyYTTqYl63V4D8Z3CpcXKV361lTsB9GtFlYG79GUSCla4kCUhXjACwpjq4k4Zw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa48d6d-3a16-41e6-6b9b-08d58db3214e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:15.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index d7914fa6bc09..c4100c38a467 100644
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
2.14.1
