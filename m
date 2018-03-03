Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118452-2-7518296207311391698
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118451; b=WnsMwjxZjHpEl54UQfcqE8WGCtQsAKRBFfK2Cw3bWCTmMPl
    rhKrK1ZaYeNolgGHXZlG1u3hXoagFcgXtZo8UgrDk4iJXDHcnRK/5zttcLq2z8U4
    ogRYnPd4/C5zkDnyp9uw9pgViTgbMFZcNx92+VW8f0yqmZexRuL0u9XjWKJ9/J4V
    HWmrGpTnDcOXK4rmMjgh8+Wh8eo8VVegdmTE9Ut3Iuoxl2sBZs9KmB+hCUzi/MJt
    I/EdZQQZFYzbmpreoJcdmptBmdPLerWF54fC0kn5qzyOT08MGp3mY7mgVoUsU7JK
    8dBW8B1dpyPjxoD+DZsMKq6OAEkNrVhs16SNSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118451; bh=x28MZq
    mznTy1MpdT/1qKpyu9/l2b2WVV2JFUHE2qdvg=; b=OYyj7i8xUez0BRcNI7cdwY
    2bE7b8xTPiUU02K/ttg/goK+y+A9G5aMluPgUmlxc8O7Ohiba4RiJXOdL2StPPgR
    Slpk8fbJrEkd6Mdi2mNenyboh/g8QlQBXjxBoCj0YUk/KmiIRkrr7yO2aoQemcxk
    IZra2u8i45HCLkuabZHl6RiKg6BFNuDkjLzRHnbp77Jzzr017K3xUxf83y0VfQ4K
    2Al2cPGTaY85fczCFWnXmlbNThjAW2YBXkq6gQsSgW8K/G43dG0k5ekl8MeKBZB2
    IzBcyjZ67O5prLKFIlEYSEXm1kgV70oxNHnaHukgTFa/uKpPkQz0AXIUgpt32hzw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i80xFOgi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i80xFOgi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934497AbeCCXGk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:06:40 -0500
Received: from mail-bl2nam02on0124.outbound.protection.outlook.com ([104.47.38.124]:62688
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935182AbeCCWkL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Carrillo-Cisneros <davidcc@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Simon Que <sque@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 077/115] perf session: Don't rely on evlist in
 pipe mode
Thread-Topic: [PATCH AUTOSEL for 4.4 077/115] perf session: Don't rely on
 evlist in pipe mode
Thread-Index: AQHTsz9iBydkcwOGBE2S+rMpMOnSUg==
Date: Sat, 3 Mar 2018 22:31:34 +0000
Message-ID: <20180303223010.27106-77-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:MRPiMKjWR8LDfFI4ISrWxNEPevkVXWFZ4Lg8oaMGEnBOQ6f64S0433krDdQ365mH8hu9BBJYH/gPBAKIPNX8GQszThiUiUGp3nkAjOFyQz1jGCS7QnvB34uoRLQetcEP6Qk1vAITnIbUC41Q513AeAteMZzvBtFArgyIhrzSva5IQQVX4Cjwv8VC7P1XtsmOMLIyBXj+nGkh5vOszmXtRc8ivfPq1XBu4OlqYxd3jfJmhCahvSyn+tr+5G7gle10
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06220430-6bfc-4f4b-a0db-08d58157b3df
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1033D0078304EDBDE387804DFBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6306002)(6512007)(6436002)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(966005)(7416002)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Z4S5PDi71KwkFjcdU1eVCsHFQwSQl/K0hKtIT9OFX0+C9r6xyLGQrv0ogbaWldaiyTCPgwIuFOnEsSKCjiWfAasLWX7pXz5s2zo+Esv/wB8gjb6cX+5K7ggsNZh06bd+4JVZeYxP7HYhACu9UYcKKwf/KJA9D5Gj87BCHPvxaRU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06220430-6bfc-4f4b-a0db-08d58157b3df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:35.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Carrillo-Cisneros <davidcc@google.com>

[ Upstream commit 0973ad97c187e06aece61f685b9c3b2d93290a73 ]

Session sets a number parameters that rely on evlist. These parameters
are not used in pipe-mode and should not be set, since evlist is
unavailable. Fix that.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170410201432.24807-6-davidcc@google.com
[ Check if file !=3D NULL in perf_session__new(), like when used by builtin=
-top.c ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/session.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index fe1c837459f4..0ae4f73dc8eb 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -135,8 +135,14 @@ struct perf_session *perf_session__new(struct perf_dat=
a_file *file,
 			if (perf_session__open(session) < 0)
 				goto out_close;
=20
-			perf_session__set_id_hdr_size(session);
-			perf_session__set_comm_exec(session);
+			/*
+			 * set session attributes that are present in perf.data
+			 * but not in pipe-mode.
+			 */
+			if (!file->is_pipe) {
+				perf_session__set_id_hdr_size(session);
+				perf_session__set_comm_exec(session);
+			}
 		}
 	} else  {
 		session->machines.host.env =3D &perf_env;
@@ -151,7 +157,11 @@ struct perf_session *perf_session__new(struct perf_dat=
a_file *file,
 			pr_warning("Cannot read kernel map\n");
 	}
=20
-	if (tool && tool->ordering_requires_timestamps &&
+	/*
+	 * In pipe-mode, evlist is empty until PERF_RECORD_HEADER_ATTR is
+	 * processed, so perf_evlist__sample_id_all is not meaningful here.
+	 */
+	if ((!file || !file->is_pipe) && tool && tool->ordering_requires_timestam=
ps &&
 	    tool->ordered_events && !perf_evlist__sample_id_all(session->evlist))=
 {
 		dump_printf("WARNING: No sample_id_all support, falling back to unordere=
d processing\n");
 		tool->ordered_events =3D false;
--=20
2.14.1
