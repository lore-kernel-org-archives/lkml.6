Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487938-2-13389045845906985109
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvit, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487937; b=jO3V4es6DzFENjjtgEbKkp1kkZ5S7SgsOgirmRQ9M/kSFTa
    bdqYyLW/KtNXSrCIAGj4ITvpVXb13ffiIiOlZr/0rtjYwJVlzE5BH0Vk9SoajNzd
    sCkrQejOq0Gs/oNXQFyKFplqn34VGzjEmJ3NDQGyPbSacslBWZHN8UItyxrua1s6
    Q+AzTburR+YUZC4Rf2iXJ/mw5jFidE3XPMn99mbHLfGJp4P6Y0vykIwdMzusoIvz
    TIKn6vadMC+98H8cI/Pu/GSmXN8aVnfd88oFu3DY1SiVhFy0efCtGyzedNRPl7Us
    nTtOFMr20Oh2I5cCaliq5LwCs9BHciKsI4n3cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487937; bh=5uYmfK
    O4t7Ruv4v/9+yKTMExEGir9nZR05LicUpnrC4=; b=an+YKHEpA+rEhIJaCMcBkp
    liZrkTyv3TrQRuAuA8sIi6+Ft5cjnFdBg/e/htJXMlHIMPJ0rL0Cwavzt6oPAzVO
    3lINqy/duxn2KJZMDTPUADMh/uyp6TYavVNLKZRl+5X4068rVH21q3K/PJToTTkX
    Cbi/lE48EhK4spRsh6V3Pu5Jrt8JpCv13BN6u7xWyeL5WZSj/QwqddUPhxB0wyCd
    PqMqmWBKeDQBUw99br0kG/GjSGN7QvnSPpaqCdUFHcaQ6S7IPwoGSYaXYXlEMvVn
    stQ+NaJf1hSBhfRJpXS+B0ssDvSrS+y7NqrHN8lEK1NX9lP8JXaMpb7y/l/OxdQw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=glZ4Df9c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=glZ4Df9c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966451AbeCHFpQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:45:16 -0500
Received: from mail-cys01nam02on0130.outbound.protection.outlook.com ([104.47.37.130]:16451
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966171AbeCHFFL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:11 -0500
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
Subject: [PATCH AUTOSEL for 4.4 004/101] perf session: Don't rely on evlist in
 pipe mode
Thread-Topic: [PATCH AUTOSEL for 4.4 004/101] perf session: Don't rely on
 evlist in pipe mode
Thread-Index: AQHTtpp4QAFp1M9pkESOhhKxRSlDsw==
Date: Thu, 8 Mar 2018 05:01:09 +0000
Message-ID: <20180308050023.8548-4-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:QsB9kUGhm846EXEJHxJWtQgqupHDfXvWN+J5G+97dSI0oI4/ZC6A8ENyFXuykoES7K4zCp5TalHh4CDvaPGj+c7tLh6v1SfrvFJo3kKYXQ05j2ihImIXoS19i/022mb93JpVQpcxOKstIo9NKheRdmtDxUw2GfELhW9kxlm74ileMV7V068vG0yJ74zRpf+fkLRHwRZlfwTUTqFhw3vVhBfyayoKUaoSS/0ZggyAP2ZMRrCuFB512SGfU0+osrrY;20:hg4gAPcFfBFccy2JF1RSRe14lQRAEETXaxw1C4c6uIkiRxJa0G0h0ybate9E8fx4dE3eq+8wImWuhndsbweACyFrTURBM6Ch6SW8vX8GuFBonk6yuxkKrmF9ifhhZNp8pJ05Loe5DLpkR2mE9kechpHZ0mlZxOdRMBZKk5aj1no=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa79b53f-48c0-4fd1-2c2a-08d584b22786
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981E0B9A27D619A19007A4EFBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(7416002)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(6306002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(6116002)(81166006)(99286004)(72206003)(966005)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YqFG/sqFoz9vSlzt62EDDPGsCO4PT5I4gpPKbtfpzFrfoLHcK9LUZAKFUU6tuEB8zjGNoZFxkedH5QGXmYP+2/RqxsMg82WYlTWewGDi+9rObVzkgrZeocYLsixjqMjeX3hRklIlT5nX142WzkcupeJ/5f3M4t3R1f43ekm9/Ao9tBwvVA2GII53C1pN8C6Uk8prE2uLiBlyT7Nok8BlLOmi+PtSUzfMaqtOVRN6LOKeq9vdmu2CU0XWDPWQ2ns/pUPrISe53DXACJuKRVZhd6pRJK8rLfDyhdrDFWxWW/LXca7XiBi8UttVsGiPkRucocJyebOntqgDifu671HHEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa79b53f-48c0-4fd1-2c2a-08d584b22786
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:09.4085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
index 468de95bc8bb..4ff7c425a706 100644
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
