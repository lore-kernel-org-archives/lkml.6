Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1AEC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E176520855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jAyyghMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E176520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeIBRXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:04 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:31424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727723AbeIBRXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0J1256XmzTvvZVYeqfW7DdRFfpS9s8Gj9wPU5zekdc=;
 b=jAyyghMa35eAU+dGn629Xb/1rdo2aQBE2H1dQu7/ZzwwkMdPfYU/oq9uzcsv8mYwggYqR98WTHPmyh+Osvv+m0rMOwVsn8+5vFEJ8WQ1vVVNwqzC0X2XEOo5jVSyXSeWiyarqVVdUPgxUx0erMQVe42EHGuula0WQqxLOdH2x+c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:07 +0000
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
Subject: [PATCH AUTOSEL 4.14 31/89] perf c2c report: Fix crash for empty
 browser
Thread-Topic: [PATCH AUTOSEL 4.14 31/89] perf c2c report: Fix crash for empty
 browser
Thread-Index: AQHUQr3NMyPpIDlhP02czLa5IZ/PPA==
Date:   Sun, 2 Sep 2018 13:06:45 +0000
Message-ID: <20180902064918.183387-31-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:ZQxTDAGY22PgSuIyr66lfwIKROMEhyXnkySjZVQZNuZV6Oj2KivswFRwpjgYXZ0VjHKrBlp4qVgNXB6KMZknriR7clEvkVdOOO+oXnZVSL9UF3SL2017Ghn/qwfyGZ7X6uuATgjjFuoLUjHN5UfDxxI8aFX9aK5AKf2lZQk43LoAHhkVsOu2XAYBTWIEzNdJRCrT80PsCEcpSCpNhYBMkHnC7+BUtk20Ey7KEDQ4nNpVy3Oiubt614HnsIQ5fLWTBCuFjeQDogaUBybi95DpBdU3NhpZF6ikZ60TcjAddLn0mZCorQlx0pXX7vYUt2LXEVDo1k4/ejs4+X4t+Gp4E15j8pGGe1JkwdcOO6BsxI39//Qs1I5JhscnfjAERLV5YTQdcN0sxpz9AkQ2JTV8DXkIE0u9TvQCOlKatfTLAcyKK0JOMqyRE8Kzp+htZ+9PIQ7jBiMFMzqFwnJsHH1S1Q==;5:BhRFNhQbvfPGahnuQmlgU2sEQB5pvNujSeGnMTAf7R79mi8xdPYnGSJREFo0alBWUMrbbofekhtct/V/F8mfTRplMdBqXyf1RKNbLcjns72sgjYmMs9GBqIE6d2s93AOyaZ7u8TICgkFGQsq3pPxRRCcyKILWKBZPUTMURpBPkU=;7:Z2JSz6cYNajV7mGCATyBDtXGWxHTqb6QMZCqewI76hfSyKZs0Ha1eclqRz5ou05IxM6Y88Pbje7ZFVqzWXyro1F6E9734fmuWSsT2Oxl11hdTtatwrCOTYNg/gnGTUn6IlheItRTuKPmnla9JjtlRrpbO68oFMIucj++djKaOza4mJhSLe2ywTXWwFcd3dbfvcGdVRqD9VI/O4t4YAlKIMF5TqSzIhPXDBgpe0cTXB4zQX3rcleJ4Fy1W7X+zx+F
x-ms-office365-filtering-correlation-id: 6a8a992b-769a-44d0-88cf-08d610d4fc64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0856498245BCF99B76E16F7AFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(575784001)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(6306002)(8676002)(6512007)(6436002)(107886003)(66066001)(39060400002)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(7416002)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(966005)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H/xtKy3SIDV9Ml/THDLqKWIqj9pLFQpVx4OLxVOyu/AtC5fSbM5p4hzmimNfV6LVvg1qsGaUebLtZVTETkwPFDUF2A9QG2FayjfG7f13OHAJbxlqNap8IPeUBggFmADFnLNKevvTSUfY7F8O9ipRwlvXxx6vwF69GnBowgWufGWcqD9PQESAE1ngvmtIZzbMbyaiwGWzCkgKvNn5NkM/BWZ+L0YLoZBNp+iCfKbEoq3+74/DF4vd7MQ/g/beOfz7t2b2aRcfZCHME5C9m5BuuaKa4m2joXQeezGzVxBBXbaaB38LjiiLEC/VH6XAyC4HrtVcAYnvgBu2ePL/qFdgm7B/dt1hslK1BfZFSAxMQ5k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a992b-769a-44d0-88cf-08d610d4fc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:45.7282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 3479a1bc7caa..fb76423022e8 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2229,6 +2229,9 @@ static int perf_c2c__browse_cacheline(struct hist_ent=
ry *he)
 	" s             Togle full lenght of symbol and source line columns \n"
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
