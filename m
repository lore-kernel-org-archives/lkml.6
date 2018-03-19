Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476631-2-4262022575368846669
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
    t=1521476630; b=tWQnbsUnN63tZ+uHeYUjHzAaC/t6GKai/XgyObHP9QTO6cK
    akaXgst1MN3bSuJ6BHCulk6TwqeAzFdxudLwlk9jeLsQ2Boy1u0TUbwHh4QT58pU
    fImtmK2VLwjT/tU14ql82dXjIpdkb+Q/FrH5Bgi/sb6qeMV77iCj3p4nAgxsJwcN
    doItez9aMxc0obn4ieJgzKUYRS+k1MchKg/DpAFts38WiXleDRROVPWGG0+mKY3s
    vRW7rr7Q6QFUr5FGeJs/8fuRAZGf/wALl3elmtJjMczcdeh+r40b4AxVUn21hScp
    taDkBG5t4DpNB4WE115a63SP6Ev7i0nNSUViSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476630; bh=ld9GUR
    tcoYob7U7Wt1dc+wMvk48Eh2HKGyKOloqorx4=; b=d9vvbloN0p/fB/16vU5HB5
    or0X7GcTyKU5CcUg2m/KhTfpg3V/a8fZriZV246Y0qed+kuTq2R4OMiV6aQqmCfi
    gsg/YuS/1iLiAZbMfxV4Qu47c3NxGC953d+Ytz3ueQ6r5i+QTgBbctsMryNb0pBc
    U8y1cuv5SklLguzNtaLAsGK5WtJr7fRzieyotU9aLQbsU3QlLVoNSBiRYwhL3v2E
    OMaZ0u28+gGQZR42lsohVj594GTRmclzNjXAswgqNmh+YubUgTxj2g/hAdJdgdYP
    7lQbznCGz2vbcdtKp+pwsW+T7U6kUHbP/M9PaDZnYv8LuTCe71xX84TYRVzvskrw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hhGfYmME x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelieeljeenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hhGfYmME x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelieeljeenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935419AbeCSQXN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:23:13 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:50448
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966920AbeCSQOM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:12 -0400
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
Subject: [PATCH AUTOSEL for 3.18 078/102] perf/core: Correct event creation
 with PERF_FORMAT_GROUP
Thread-Topic: [PATCH AUTOSEL for 3.18 078/102] perf/core: Correct event
 creation with PERF_FORMAT_GROUP
Thread-Index: AQHTv50qdSKLDZI0xUCcIWldE8YQjg==
Date: Mon, 19 Mar 2018 16:13:07 +0000
Message-ID: <20180319161117.17833-78-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:eMCbV7WojKCq/8vRtVZuXYKTMkjsFE5K1Wo9oxiYQRkPJpYSlyNXf4D/SMnewp5Gpmz7M/SUFUSOt28YAlDmGNKUo7y968Jv2GqWypcV071N5RKnn18EdBC06N5WhjFd0/roTjqBVFDJVsn8+XDav0TUHjB4qdu6UaIXVHArZnIUBQoMmeMeCXgvCbcMTLz1CHYPhXK4Hv3/ZxbcmBNl1p3c/8a4kP1rglSMW6ecWox38jd2HUJqTNDIfhCyhAmT;20:l3tcioh6+3NykekMcenUqBD1qx2pdTv0DM52YDPMLn99a1XkMarXc3LhYp/wacN5yexY6RNxE0C1rSrC7Ym0fxdlGk9/nOYDYkiDK9y9BlQfjZd8OFHfjGC24Bne/L0gZTJQwRCp08P3urykLbmgFmNqe+3ZcseEzcuVGBTeP2Y=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b391278-7355-4e9d-5551-08d58db46f83
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10635C0BB880D8FA07B70E2FFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6306002)(6116002)(8936002)(1076002)(8676002)(7416002)(3280700002)(2501003)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(966005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OdctlQuOOuhhXZHU1Fu1RyzRrZiyN5ckWoFboQo1eTMaLnSTVY4OFK60qlCnPBfoVhvXCdbDgtZAU3YN7v9LdyMdKITxJXfE7Gkg5VvllJVcU8xQZrw0Ww67m9TCd14moJjSC/2D5e5zpLRd/HTB3kDgUou4JvMRad18J34484YhkmJXxo160adAyFNM0e3hHJ+Nkbv3KroX/O8mac11KIaXuXP2WGgWCjdMtP9uzp5ehAhgl/7HucmfwcbM4e5oU5n/lqzhHOf+XK3U+sIF+evn3LhYs38/eKIfGKK+xAddTNpou7KP8MdjV3WPA0HmwEykNL3YzKN1yqoCJySN8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b391278-7355-4e9d-5551-08d58db46f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:07.2165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index de3303aab7d6..9eb7710914fb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4861,9 +4861,6 @@ static void perf_output_read_one(struct perf_output_h=
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
@@ -4908,6 +4905,13 @@ static void perf_output_read_group(struct perf_outpu=
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
@@ -7194,9 +7198,10 @@ perf_event_alloc(struct perf_event_attr *attr, int c=
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
 	pmu =3D perf_init_event(event);
--=20
2.14.1
