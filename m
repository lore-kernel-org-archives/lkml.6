Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479363-2-9546263349470796350
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
    t=1521479362; b=esmp6klrWv9g6i0iPt3rbFUFpO/aLnmGIX/wlA9WNYfoxt5
    tbG+vARdGeJF2elSjgoU5hyuyeJ1v5Y+xQixWb5guZcFfSTC3gHkPd34guBVFtpd
    Qk25sAjZAZFATLTrjFB48gTlwoYygVTRC+7apCdfRAqCXDHjAxCD+7p9h8jDt4Gg
    olJFBdQ1c5+HMqrgmY0aI0w4AN2PEDLDdXIMKxkDeBUSTvX+4Yv3hIt18e7Fvq4X
    kBZs1T0Xpi2XSYWOk0G108j7diuW6j9MFGQ0ttgSK6s3HghX/jEVe4wQTm/szHh5
    DOfwszfgcetGllSbqLWNkga35F7QrWgiCv12HsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479362; bh=bbn1ik
    Jk75zPtgxeCaccO1+Zf6zuW1GX3frhNXLT+cQ=; b=WtN6fCM/0vFEEh41IeVMQp
    4X2LmbEnRH0B8TA0RInVyza9FsAlf/H1I8RGb53CjldxtjcujBgcLtMBXB/5VNdg
    6/MSHAsdwKCEHV3wAt8NVMJxhxCQ2uilwctcO3cE268Acd709XV3v33sLIEDqLdl
    CPrPlA2lsUe+osunoSmJ4CbAFvMBAKUNgc0kdp39rTHu9hpw24/ZQ+01O5V+OsEf
    o7CuJKz6Qs4FVrhDzbzN5NQEa59qTGXZuJvm4d9vFl2Oku//4mBxFrgkf+g1vrDR
    e4e1LE7Ba4DhWcqsL+DnTXZWXo8htoquCLZELyGRQZbueQaI0fgjlVBU46RLJy9w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aQWqj4ko x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljedttdenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aQWqj4ko x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeljedttdenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933961AbeCSRIv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:08:51 -0400
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:18758
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966644AbeCSQKo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:44 -0400
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
Subject: [PATCH AUTOSEL for 4.4 134/167] perf/core: Correct event creation
 with PERF_FORMAT_GROUP
Thread-Topic: [PATCH AUTOSEL for 4.4 134/167] perf/core: Correct event
 creation with PERF_FORMAT_GROUP
Thread-Index: AQHTv5x6qYTnLfIKC0i95x9FUu3U5A==
Date: Mon, 19 Mar 2018 16:08:11 +0000
Message-ID: <20180319160513.16384-134-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:SqeF7rYiEZl0Bwnb/Vp4i8GR6iEY6ytdxcWuM/wZ8IzC1/36+ZP/DX7a96WmWL7BT+U7Icb5PLivmdA6aDUoxAtMN7cflPz8alFfkwihImdEScndtF1pWbcAEak1ReMLHbpQUP+aaYJe5HgEm7j+UcdMxNAWAMYlc9oXZYw+qkefmKxCFJz5dGjOBvPl+A2J4dtS3LN465BkmxizpcLWax4ri9L1rgTsn+43eKdzb2UGbQUhtqcvQavt9393uzZK;20:c0gzJ1Tny0UNZiBeHpmA9qW2rGyRU0xrKCYTRjSLGGp2dJtuVGLaP0UEcum8FGowdtDS6uUH1P4gE7Awmr5zaq22i56A9JWdXIwAJPraAauWo+uAromUwgONOLH5W6dI3h3vN1MoHLz6I5eIkkUm/Ymx4I9dXY09H92DV1iH/r8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be98ac5d-92b6-4116-2a15-08d58db3f5e1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095CC27831B0E2EFF7EF23CFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(7416002)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(966005)(97736004)(54906003)(6512007)(6306002)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PEy4SX1mQY0/ExFf2B55BcI4iuAYPrYBgwXeE/+xqe3FPvUOFZLh0LEzSXN33tNCTwK+K26htN3M6dNRKhEhR8JEujoUQnLFhp+pCMD7MM4oXWNWa3BGk9h3MFGaPI9at65vYgTimgsbH3PbvLyzEcfCp6bKl6a1aXXecDf+M/V8Deb8zWjLgZjndvepnXD/XTe4jzpbqAnnLqMQGubuPOIvV/W/9aG7bW277lLMK8PVq1Wi4SFFljYje4132GpHvPdQYa0mf+WLG4IiVFdZywGDUGgYbzSi2mBd4Uya8aSyNY8aKKTOiCoBlurmBVGlu6HX/qutcBLprrKN5SrJzA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be98ac5d-92b6-4116-2a15-08d58db3f5e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:11.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
2.14.1
