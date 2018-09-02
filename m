Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC9BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F28520841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FPUAOCXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F28520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeIBRUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:37 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728001AbeIBRUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNNd6krAGF2tZlPr1XK2gCwOR6vTEmK1pagkK3NQG6s=;
 b=FPUAOCXN1D2vW+5ARfQqqc7bL0fKDvbtljgHiVy2PzLo/cKJ90qlZ5LB4YZMP4E0CP5CV9lOnH0pkanBDkWsNQYYZMJ3tXup3xZdZZiSd4oqZibxZDpZSwB6S0oLCpNf5aR1Z5g3bgFcqxIf8IS3KKGmbdDSE4XqvqHPX0DnZrw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 047/131] perf c2c report: Fix crash for empty
 browser
Thread-Topic: [PATCH AUTOSEL 4.18 047/131] perf c2c report: Fix crash for
 empty browser
Thread-Index: AQHUQr1qmaqDQLrz3ECfi/r7r2rdCw==
Date:   Sun, 2 Sep 2018 13:04:00 +0000
Message-ID: <20180902064601.183036-47-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:cSvxwggfFV1tLK1sYb9FrF1beHcnQ69cd0PYUeBkAC3vjPd/+oZMjY69OfpD70vlB/Vox0XOe89bObYopDLcpP+ZSwNJICdMaczUaEuHwsnLkUheGoL8L30u5XMKRwrF+Pfy7+YVKP1pEeKtnswzTfE5VuZG75w3D2d19UvChs5aSc0jamdY/Exena65nyjB5eGXz9LNTaRvlPe3WBwntrDRGS5HlV3tACdk5+IKjC13chgRuv9jTm5sEyCB7lfxhxWsEIBmWDVZ21dKU8oBaR61ZbSmuUk70X+kkEHWRn9Ons8UmdB9LOQotq48GW9TPkxiSAqW2vz0bhDIlXKSxjTl0z30o/k+Kz4kql84jt9vuOpJJNMDlqvPKSMZb3xdRWtxh/J8yV+yH/40cn2sbcMegJrh77kHI22wD8033WMrc8EkFq+HIIKbe2KXTN3Bgo4/P/YlQhgzVUpsVw00Pg==;5:w5VGuGwd15nd8qVTNwHRqLMMWvPGd3G/4g4eBArehnjlvkjDZktxFI0m0goM2YQ1S8iCduh99APfJ2co6Dv3Wiu1w3TkcvuzkzL35lw2Wy+FTKJsrNeUX7kpe2hfieVsPbSQx8NXYXVoRDJoo+JHaFdhucBBBRJe4fNqk2KgYcM=;7:wmw0HL+ICmkMai4M5Q6jn7w5NZ/CMJZaQPjzppJMN/4ddwebMBDoR413iH79hPjTJOXTSnRYGfFrHVnuPaXLega1VlpX/+0IdgVBpja5M7UumOk1pwCG6BWzhiX4+kSJVaQWu5cky9h75Q7h4QIlA3nmvMCm3Q7tU5XzTjxuQRb0YkB9c/FQy1hSTG/iAI6ffRKth1XgxizpETgIOA5gtNXo6EQ+j1FTfkmHsYq5WZ30uACzdQ2/Dodstr65+tfJ
x-ms-office365-filtering-correlation-id: 3b463eeb-7ea9-441a-6185-08d610d494a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB013508229A5C80FCEA6929E1FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(6306002)(2616005)(6512007)(966005)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(575784001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(7416002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(39060400002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zKRM4WpoPOeldGmTnmUwog8KkvPXa+Um2uNS0t1cEx86bmsmWu+kEfysqrNsgOH06DN42nPsdqw/rQM67trO1wlsSJvKE3Mo3eKAS7Lt2234i+5jbpM0+w0g8zZQ/wltnFf/vuuOo8jlL5UnpOt03eXbOwJ8x5SCQ+fzG4DdTaZcLOTrtkF9eUIrRegTBKkjaZ7EoxJDiTE8aJuI4Fy1TpJikFwUjqEfI/Qzimd3GG8SIPn23jtlJoNLjcgLORn629b4PzWRk9t/vCcTZ1GEA7IMTsuZili3azQkw2JKFmarTmSQ0mVg/Pg1wvRJvZFhlTHfwywXaO7xiuEj7JlJ11a+h9VaT2xyQypRLRId13Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b463eeb-7ea9-441a-6185-08d610d494a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:00.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 73978332572ccf5e364c31e9a70ba953f8202b46 ]

'perf c2c' scans read/write accesses and tries to find false sharing
cases, so when the events it wants were not asked for or ended up not
taking place, we get no histograms.

So do not try to display entry details if there's not any. Currently
this ends up in crash:

  $ perf c2c report # then press 'd'
  perf: Segmentation fault
  $

Committer testing:

Before:

Record a perf.data file without events of interest to 'perf c2c report',
then call it and press 'd':

  # perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
  # perf c2c report
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x5b1d2a]
  /lib64/libc.so.6(+0x346df)[0x7fcb566e36df]
  perf[0x46fcae]
  perf[0x4a9f1e]
  perf[0x4aa220]
  perf(main+0x301)[0x42c561]
  /lib64/libc.so.6(__libc_start_main+0xe9)[0x7fcb566cff29]
  perf(_start+0x29)[0x42c999]
  #

After the patch the segfault doesn't take place, a follow up patch to
tell the user why nothing changes when 'd' is pressed would be good.

Reported-by: rodia@autistici.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: f1c5fd4d0bb9 ("perf c2c report: Add TUI cacheline browser")
Link: http://lkml.kernel.org/r/20180724062008.26126-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-c2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6a8738f7ead3..eab66e3b0a19 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2349,6 +2349,9 @@ static int perf_c2c__browse_cacheline(struct hist_ent=
ry *he)
 	" s             Toggle full length of symbol and source line columns \n"
 	" q             Return back to cacheline list \n";
=20
+	if (!he)
+		return 0;
+
 	/* Display compact version first. */
 	c2c.symbol_full =3D false;
=20
--=20
2.17.1
