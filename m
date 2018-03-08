Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486426-2-8245515184745355247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486426; b=sZ2Ee4YxCD6AnduymsFNatjauUe0CbIIwbtlXtCgGRbPmWS
    2sqYFJj1xp7dgKqIBY8EukYhkVtifr17Yscxt+30mUNVZJiLRwfkV44Ruq+TMVIF
    0JvCCMFllLyTcq3tYkcMgLRQ1qhy+GwcpdV4UuIp6nBT7uFN3Tfb6c+OVRMPEwqD
    Mbt3vEcMnlhaSqJhnNH6yuDFuNMAiMRSNyAnoufoBaODE7zcWzEV/7j85F67a8YF
    ds2799qERxW2qgNVUbTiNQ8UV4AIeNZM9CEV3kEJAoGvUY30Pyx+z8hP61zgJXHh
    v7nNAoubfvZJxgQEKP2/n0DQJ8XxdxYuFl57T0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486426; bh=DGwMYX
    2/Gb4lYJZGliWySPLqsCPACmOb+lDOIuhXY2Y=; b=w2DOm3LQlroJtK8RTsrKKQ
    0FvW75f8yPGmFb8XqOQgKSaR0CSmzXC1tx/PlNy0+yg9hsfyu2xAEgow+zD+oRIO
    BUuo2Dci08eFlQhOypdDTnJQSQtEncMI0KyryW4Qkihi4m3UT9DWWnc8vg0dB9cy
    WfnDhfR8fRDKNzpDPYyX7sh1WP64XXvQ+/IXig3w3pYl7ZFC5g/JmTYsQyELCYVV
    vtmuUiONotOVdtf0FT3WCdFnVOkNOtZqIJasRGyRsh6CDOOG3nMkLWiXpbPrI0bT
    yTSe/5ecwUQNEhyGC3mlBgpGBtMlcCwnMPfTL/W8NImZkv/986ysDm5svxXGzy1A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nr/XYAW+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nr/XYAW+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966800AbeCHFUL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:20:11 -0500
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:43456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966653AbeCHFII (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:08 -0500
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
Subject: [PATCH AUTOSEL for 3.18 02/53] perf session: Don't rely on evlist in
 pipe mode
Thread-Topic: [PATCH AUTOSEL for 3.18 02/53] perf session: Don't rely on
 evlist in pipe mode
Thread-Index: AQHTtpq+T6oXtzS9bEGrV6MUGGRNQg==
Date: Thu, 8 Mar 2018 05:03:05 +0000
Message-ID: <20180308050230.8876-2-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:lJUeIs+o4eNh0ZMD68gdzvJRJILlGFv68N9H76Pfn/pPzOqlmwYz2QjruHEAO090s/W3/hhn3rLz6LKQvnqfSl5N7d5Mi6mnx9wMqQwDpz9oSkIhLtkKR4QKq3w7ANzAuQq90ya1idWOh+n6ky4aAGHf0nMVU0fwgcJQt87VAqLK6P1EVmrKfF+mzCqVrTJQKLF+KjdtYUbKpGAQsTNZmttTdievV0iofSpcy7TELq+5NnLhUgXaMqDK/j3/J6xY;20:onwjkK9nU2k+j/lfwfjQ3Ojij2qliXuDe6B4FhshHSRUhJTOZvt+tyz/xKBuBcFmd1lHBVrjOgde+YkEVCBJE0v+Y9HT94eXXs4vZuhHmyoNU0+Grbe1xzYh1oDxSbxma049taIgHj7FdM1H9N//KUdiXUosxC5IE8N/8CCB334=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25b34464-f630-4606-74b4-08d584b2909c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072709F864F9E1F640E4B61AFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(7416002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: thMlnvy9EeyZsOZHdprM/QdkPhKl9Y3yY+ARSK4q7I4jsLPrWKwS58wGc1r4KJQHRRCjYzo46+a+INHI9sxm4N5io3A3G6VD8kJQEXYpgCgkDbPSlR+79IVRjSQ0P/Mcc019yjb8mg5xp9IZDY7X8Yq99akMR0zWBLgCaBQ1QwxJBCSTGbD78PvWlg+a3OUkfQkeUdXGm04FE5P+WZlj+3/pR40JDjsBabebyh0zjKpVHgd7Y8PQpkpBsePTH1ojRppuX9rrGHVXJmAs2II67oi2E5w6T1Nx1RcGchxqbwwfr/kS00R1ZngRa5ZfvYHSNA4plRAv1e5f6saclvJwqg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b34464-f630-4606-74b4-08d584b2909c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:06.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 80dbba095f30..08051ee2116d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -108,8 +108,14 @@ struct perf_session *perf_session__new(struct perf_dat=
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
 	}
=20
@@ -122,7 +128,11 @@ struct perf_session *perf_session__new(struct perf_dat=
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
