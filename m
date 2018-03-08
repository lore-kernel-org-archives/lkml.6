Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490780-2-10307383424255129917
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
    t=1520490779; b=Gajrqeg/i4czuBFUgVeT9pLnHhmM7C6TSyVx/yiTHYtXl05
    i7v99E8Vxh4sLtTJ/8oZd6gZF6eSjBJWV9m8LPkNHtXXYjcOatdJN2SFiLU4VAYd
    zllXe780GXdRkBuKf6aB5stdJeYIE0Pj/tDG43lR9uVyYs90JUR2QrjfNJbvPtVC
    FragtTBEufUKUlbjcHiHg0b5EICG3yFT8o5rs2P+r2yiq0PV4sPg2mtiwj/v0An2
    27ptRw8sn13gqc7MRTF9bqXHC+BfqiPBXwrk5e3FuBzhZaSaGY+5zMf3N4YChslj
    TFSvwKXQrP8NNnileibspogjNfahtRv0ZN7U0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490779; bh=NBjfhu
    vSuFW+9jDzh0de9kVNxtlj+/7EWfgS3ebLVsU=; b=Qh/SAbNxXI4Qs4XC9bNubw
    f4W/EXr18ksYig0umqWxRqlNv1E/1mgq6OBVEnwFWu8EwmvP8+hAZyZNBBaQ9ZmM
    Def+X9Pn0xqlIOGFqrTDv+IVFzzcMbQ3jkw2HVFyJ/ovineOjkcL7kHpnQYsDRLY
    SMOSvOmUp1cP+i6jFpGXvzS7c4Kh6wwcNA0F3uC81Xd7OhSbogCJeSdgDUIVIHRX
    VG7tN9lJ59iXZY2unUtsEJYeJo+ALWxcIGyZEan55WoheBW1IpeiPgwTgquVe9X2
    zix4gm3dlMPRAHQit2T0HCQl1VwUlj+DB3nCu1gxSlnY7HZzwf6KZMeIm0eoohpg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KVrhnTMh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KVrhnTMh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755430AbeCHGco (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:32:44 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965551AbeCHFAC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:02 -0500
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
Subject: [PATCH AUTOSEL for 4.9 007/190] perf session: Don't rely on evlist in
 pipe mode
Thread-Topic: [PATCH AUTOSEL for 4.9 007/190] perf session: Don't rely on
 evlist in pipe mode
Thread-Index: AQHTtpol2PcfyggmDUmO5ef5pNsMTg==
Date: Thu, 8 Mar 2018 04:58:49 +0000
Message-ID: <20180308045810.8041-7-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:ZVYlu/4fjM7atzMDWpax6Hsr06Gl6AyB21sZy1A9CyAZ6oPVo+fxRPU70jreSY55bs1QHVCGGByFo8JVGVIdDqx1aL0DAxFs09PkoOxDCPdGCgLAJKlE0l5HM4MYSGwQPEbvM9fmG8Q3ULCiCErHXEPNOJR/AACzFF+WWnKQPDtCWsSTv6SgfQlJJ3TEEtQBvhGzhdrTDCKrh6+CpCtz7Yjp/Gh9Qdvpotc1vJz5BG2W/XImb/6x2VQoKkmD/yGD;20:eSE2zUIWDjRa/l8/aWc5mRANjWIRARvW2Lh3BhfsjT/34MU/Q8iRDmfUniuCBo92aSdi947w9MYVlG8FjtBl3RLNxy6BzfzROpZtF1jomvspWCVgp/GUEyOxCsV1mr/oKDFDJqfAXUwHpAqIglqIMGMV2b24MZgF9T3HK6JiyGA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80cc4c0d-79ec-48cf-92b1-08d584b16e6e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920ACE6C3621B1E42210421FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(966005)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(7416002)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(6306002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: LvTP5hVSAgMr7YuDxFYPj8TRqIg3at3RPhZs9BYVeQUGVPbnEMCNhZCvaU2cb2nnP1xUp6oh/OwONuknLswY0X16OLFhTKw/VoRpOsZhqCuz373ExEu/vEFUSvjCvhLM/gZF7oynRbR2KypAnVSCdDZVfPTge3Z2jjdcAcsdT9YAspEPCknD5sqrZrEfQZtEinyR1mg4phrD7zTdEV/01jF77whID/6uN3IIxbNmuwWHgfzzjzjjyIVwm03vbdSyWFF1xPrs3yvrdDWVi5JroIsw6yGG412AFt5oGcT9PQK36hrhD8HE92VFJRItGt2xNllAuAO9sCljnMZoW4myPQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cc4c0d-79ec-48cf-92b1-08d584b16e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:49.7126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 5d61242a6e64..982916c09a12 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -139,8 +139,14 @@ struct perf_session *perf_session__new(struct perf_dat=
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
@@ -155,7 +161,11 @@ struct perf_session *perf_session__new(struct perf_dat=
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
