Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475273-2-7755700608272633490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475271; b=Sb1Udn/XCayHywXL2Ba5n7RslzbAR/34PU6lLFxrnwZiZdk
    0VlL487rsUMm8PFs9CN0sBVFZcGwyNhEjFfYfwyx1s8FCuiHTsm8F7CwaRHfS6Hi
    bc8E/oqsrBnTaIUcQrIB/mLTSzqUIFOroAVSjdNbIiN3b1ZhreYeo2JUIv2H+OZ7
    20PKEMBJbMpnPs4D1VBzNBNuKeLtK14cJ7X0T9ZJFziuX/U4kttgXQ9d9AMtpgWl
    GtVlF5D4HqserRZLWo0KJ0/FUzs1+GCJ5Mqzw1IAFCvmyfB9oKFpihsNdkKU0zcs
    RMp8B3DbQ0e1CrLTgIvoXkPdi5AfeJSKobggP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475271; bh=1otU9f
    dyaMv0hChz8dRP2t++TonrpROFFoVGXG9RoEw=; b=XfO3QtXr0V5SYDQk/t9BpK
    NyHekLOg2Gt3Ep8HY8UqsNHzYtmXTCZdUjTkHshWPWt4A3Tnd2UOHfmebwN3GmU8
    +HLto7a5n7eJF1Nnyzed4nr6vK7ZxhjnSVLiKXtS9dNOT6d1eJWkcj9JtSp+/CJS
    aZnYNfVl/Id8T8O9aVhvQsKckbEp2w9qu/Z0GphJynaF194XNdZPALczEPzKt8OJ
    z3axwNNqYN77USBwTCdQyH4bfqlruJN/je4bxLy8bUxRrC+h65kNER1fFpqrPtpO
    +Oi+PjaAi5TsPyuBNHxXS0eCNWprah42lgAPx076g1M5FfXHhTDYnvbvU0f2tVKQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=faOoZx7t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdeggeenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=faOoZx7t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdeggeenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934099AbeCSQAt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:00:49 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:3840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965247AbeCSQAp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 093/281] perf/core: Fix error handling in
 perf_event_alloc()
Thread-Topic: [PATCH AUTOSEL for 4.9 093/281] perf/core: Fix error handling in
 perf_event_alloc()
Thread-Index: AQHTv5tLITPppbNUG0GGjA6DOmFJ6A==
Date: Mon, 19 Mar 2018 15:59:42 +0000
Message-ID: <20180319155742.13731-93-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:TMGa3zi0myO69tjuvErgAKyRy6L7hWQY85FS0PATbv2NfcBSAVDAqK0K1Bvo6/ME99F5a0nz5ZzV49QOMMt8gr881aC3MelwgUxxYtdptiYb/mOAbLIhROfroI0u/A0G7P6VP2tJ5DQCaTXElWSD6sJ6RFy6r0k644Kmz8Xs+lrELQ92MtD2eDz/RZYzYkC3EVlMPJfg7cXbYh3Ozk2jq4XlMmAqq9Oi/qRdQYMVV3iQ8/ryCgKl2jRNvxSp++gK;20:I71zNPz5GqiCUPcPZh4F82er6v8HkQ/fA2B0M/pEZ7R4rWQxaZwGCZA6SIjgwE7/damZjMzoEMo5q7vzFq68VETP4pY/98GGgLpcU8/s0UTwHUWqzAqpEA8lF624WSp3QFSomcvLXT6+lwZVxlv5zHNuTTSytRPw62wvdRVdtX0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fde47f8-597c-46d1-ab76-08d58db29046
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB093334671658CE62F90B85B3FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(7416002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(966005)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(6306002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Pg6NG9IMQZviKJZogprDcKVoM2H7yaUcfy7jw76ZwliwdFJgurGsMPWiQ6H/SEFhamWfFEwNGkWzKa4nH6qLQnPp+28qDzGEoA/LM4KzQk1c0bdP/YhvllXosUQ8zUM4xTs+Zf6wLogBTf6j8JDocfMqxTpavaU95GXoVukOyx0Mzeld0paejtj4/mri75cZvqsGLhQPCp/V/FqK5gSluFAX3ebfW+6oEjcloUOVZA+EjhgR5yIIeCmcGYdxR+pJmeLRjNGQYFOIK99BFxyaZw5TxM499TKzdnN/oKFRtjpOMxHOjbSnEG9KYZiPzANIjMCGU7OR1v50qNPmFDXTEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fde47f8-597c-46d1-ab76-08d58db29046
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:42.6530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 36cc2b9222b5106de34085c4dd8635ac67ef5cba ]

We don't set an error code here which means that perf_event_alloc()
returns ERR_PTR(0) (in other words NULL).  The callers are not expecting
that and would Oops.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
Link: http://lkml.kernel.org/r/20170522090418.hvs6icgpdo53wkn5@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 13b9784427b0..d7914fa6bc09 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9289,8 +9289,10 @@ perf_event_alloc(struct perf_event_attr *attr, int c=
pu,
 		event->addr_filters_offs =3D kcalloc(pmu->nr_addr_filters,
 						   sizeof(unsigned long),
 						   GFP_KERNEL);
-		if (!event->addr_filters_offs)
+		if (!event->addr_filters_offs) {
+			err =3D -ENOMEM;
 			goto err_per_task;
+		}
=20
 		/* force hw sync on the address filters */
 		event->addr_filters_gen =3D 1;
--=20
2.14.1
