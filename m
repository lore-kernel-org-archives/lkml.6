Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495950-2-17033205326966422722
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
    t=1521495950; b=B5etyi80gul3zR5iG2wcrjl9Sp32b18ciXeGxBGevNn8xub
    LniZ+HxgvlL6pR44feHJOuxeIN/S07xDoHmHxxOko10hpXh4peXgqi5z/M/JxZIc
    5nAX7qamtJ7q1VBuLzmB8e7hQRpHXKDwz5u0GeItE46cfL5kzQBb5x5y0G2peiK3
    ZROtDAeoSUCMw4oU8qmVoHgB6onZKyOFWlybbBJbi+oKxPzy1aThE0K5bHQNjhmO
    AWi6RbEA0w6Ql7dFBSu/XJwLAxbzMDmsp+jJ5yaf3p6fRWO6cU6bHnyeskv2mHCp
    nUAYNA/tevnj3oxY3y5BC1oiUNUg57+hWaBWOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495950; bh=IozAM3
    4NMRMJz7XimoA4bk+BAHrlf9absvZ4G+vn7Ck=; b=wyrJhMj3MTq5r89+qop28B
    Ok5cBfVrGbJhloNHNvtim7GdL37VNsQsAwaziqXJAD01PHm/R8ERxNfAcTYq8bat
    nqevr1DevlaeksKzd4TU0BD5AErto75/KZu4gEdeSpafej2aQymIbKUXX+TlQsNJ
    2TeflM4DaZ/O9AUkBsaxVT5H3YTJD3Vx93mgF48eZBcp0kkDoW8LRuwVobuebDmp
    OeFi2yLa854KLnnVbv+NBwIIQrxazcNo4kltSiDaHaoMWk8P29kGK4zxJd1u3bWt
    LRzt73o/3yYi0UrRFbdfdhoY7TsPHR5xVDnr23FxVlHJC0egh7s7RxEV3IJKHm2w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DXe3mRnC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdekkeenucevlhhushhtvghrufhiiigvpedvke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DXe3mRnC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdekkeenucevlhhushhtvghrufhiiigvpedvke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934574AbeCSVpH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:45:07 -0400
Received: from mail-co1nam03on0139.outbound.protection.outlook.com ([104.47.40.139]:4928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964938AbeCSP60 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 028/281] perf/callchain: Force USER_DS when
 invoking perf_callchain_user()
Thread-Topic: [PATCH AUTOSEL for 4.9 028/281] perf/callchain: Force USER_DS
 when invoking perf_callchain_user()
Thread-Index: AQHTv5scx2iaUVFoZE+HqB8iz8jBVg==
Date: Mon, 19 Mar 2018 15:58:23 +0000
Message-ID: <20180319155742.13731-28-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:ATa29ZJGos5aweRTLQmYXkmV9G7xHRsYuxxtF9XfQtmLy1m+tBu3TsO5202vJNryXt/idrpZn0iE23Rl1Ap5clR/rkAcLfcDMLInLEfRFUyaRuP7UiEov8h712QP9giboPczYLhD3zIFvlhA8WYyYUtPiPz7tzWCn8od/HoZER8K60QcaIFQZi1hLwi4u5GovdmRBnIEO2L7AurQu/DXVNDJf4Ns8H6RdYoM2aot6a/g9NK8zm2paYvG3uBsBB+8;20:oIVKIHFuRz8O15jWOQ3GRbTGg/p90JNuIaiVcgzByS3k0MLhggMyHLwItsI9JBzl94JrP8cRDxc27werOSoo/IiDZ8XGJfiRbOcv/dZ+vlOLbAM6pe250QH1uY8Scvy2IqxJiuzHrw6X9xSXbrUA+04LDe6lSWdCPz2hWK4FEZU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9af78896-12f2-4b51-b306-08d58db23ee0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933F1F14BF36C3A877FDB5CFBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: tgcRJGXz0fTQULr6qomu73P7jaCxslstCOhqM8LWHYGI3lR8LWAlVFGIFySV9/a+psOi7vCgOoRf7HzCAOJMSmZy48Hb1VA7hJSQHcJNT3BGPNPspoAgOOwkN1Dx9xGonxXa35KTH4JJAP4JF2ClsYqkhEOPev4q5+p0OGyZuTXo6jbqiqu38lM1yzsQ2sgNuM0vc/0QaEW4vf//KC0Pbp14WmwZnM8C4P/N0UbkX7RnI4/AYGsN11tifdqImrjHsJxuMwqsVyS9Nd8DgHPfYmjMYzdTDbRoQSdwwb600wa9NIiSnUfpJy6Wg2U44lmxNiDHe88vKTL4hb1yy3AwuA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af78896-12f2-4b51-b306-08d58db23ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:23.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 88b0193d9418c00340e45e0a913a0813bc6c8c96 ]

Perf can generate and record a user callchain in response to a synchronous
request, such as a tracepoint firing. If this happens under set_fs(KERNEL_D=
S),
then we can end up walking the user stack (and dereferencing/saving whateve=
r we
find there) without the protections usually afforded by checks such as
access_ok.

Rather than play whack-a-mole with each architecture's stack unwinding
implementation, fix the root of the problem by ensuring that we force USER_=
DS
when invoking perf_callchain_user from the perf core.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/events/callchain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index e9fdb5203de5..411226b26bca 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -227,12 +227,18 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr,=
 bool kernel, bool user,
 		}
=20
 		if (regs) {
+			mm_segment_t fs;
+
 			if (crosstask)
 				goto exit_put;
=20
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+
+			fs =3D get_fs();
+			set_fs(USER_DS);
 			perf_callchain_user(&ctx, regs);
+			set_fs(fs);
 		}
 	}
=20
--=20
2.14.1
