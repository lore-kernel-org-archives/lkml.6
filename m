Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D97C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA042083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VptDh77U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA042083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeIGFS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:56 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730688AbeIGFSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz81IzEpgvS9KPFkxWPApmSEJJI/3U3vrUs11X9XEYo=;
 b=VptDh77Uq65heAOXzweIQqQU0ypJ8NTp4QKGi+CuyrIdGkJ/ol3nJwyvG8bgH5vNyL6ZwMmA5riIunZHrG7mJBO5hlZOT+0pKqK1EhCKkhrRHKZh/yAocesHiK8bJwSKEBJe11vsNreUjxwmjslhQ8dxA5mNRzlYJ6zKFj5o80I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 16/43] perf test: Fix subtest number when showing
 results
Thread-Topic: [PATCH AUTOSEL 4.9 16/43] perf test: Fix subtest number when
 showing results
Thread-Index: AQHURkMZeqqOsLxdNEqRKNZ7+CSIbg==
Date:   Fri, 7 Sep 2018 00:38:30 +0000
Message-ID: <20180907003816.57852-16-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:CHcFMOjUQB2oB3kmxXGcHYKqRzHrsC4bEYGBdfSb1sAIBaKhvbXHeAYGhoex6uQola2lzJxSuiuLpQQzKmec5MAf3iJufX1gI1/4o1lTigFR/JXAHn6Y6cUWmK1rP0oNZLkyZdX38HoWQTcbhhqy4UWcmDgvfWGY9LDpILkQPt8wgc93DgDKBewhrpGky8hrs5ypHalYkRKAIkMhyUAqJU/rvWdUgnvubt/F8UMdcmLXvW0HrUDiIDZG2ytrOU+YBbcpKuZbOZ5s/LLw3BJzrFHBPwRfZO7y+iDCXnnp189DFjAX7hvfqDHNNyJIna6e3RoNFYnnrxKp0vK4zG9+d9/+jzdiwjIs/skFIY6vIc3CMWlsqmL8w55sglyv2y/kJp7emhbQ1O6sSWW2W1Ji4Ml7S6TaM9ptjfyWZtS5vBijGwME1fxUBnXLpmGA5O06mF8t34zLMISEm/NcQ4rkcQ==;5:gO5+RKv7YIz2blWvlBm+XIu9zTUPmailw0BEJvWPMNXu9/0eIDARYCQZKtWAxIhaaCDQd4gAwMwV+m3Bj5evNCxqbLmByz1/+3Ea1OcS1dCJnXqUdzn1K1eqNvXRMc/7rg2t1qi7hXIW8yV9fZvYYC4pgq8VctrdpjCczGIO1mw=;7:zsRCdj+yIYL7Wa7n7NF5Wul7VbqXaA4RE51DR4savqEye0dIhOf78swkOif3RWbwvx/gZEsZpoJR5SosNlXse208YUotuw5bl9Rwf9+cC/k+lycDqNSj2xttH0vT873UkjhF8Y0xdQUfoaYKGztGbraMVV5s1UeKr8cEEZyT/t6UqcrlShDDifl3kGAA4d9gD2H6MiLV58+WsWaPtm4qXtvsjcv8Q4TtIAc+PhQqi6888lCHmSZnoJ5u7u8BP51v
x-ms-office365-filtering-correlation-id: 189375a9-4cec-4200-874e-08d6145a8ae3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB0149E5D57C0D4F67157B5B82FB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(6306002)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(966005)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: I+wYuEvZT+7WyxxRH16Zx263gD5PwLsHVoVc55nC5q+TurAT6ToQdqD43ruzrR1BCf4MOE0ACBkB+TVivbphLhpFCwaU8A5fKqCRiWnlzqcRAFvTbYo2UzIUzX+MKdN91GjTVyKH+HVefHsnWdErLq5RoZH/dqEwa34X5KOl+7LpDcdJwS4688k38zNlki1+W6o/BwD3fGaJjF9vWBl3AwgxMWpYMZs0UGgerXZvLchusxzR698n+ZFKOSP1sqYOmOHxvxYpftakmzjALRIRF8Ie1W3BznBdQJaQaqhi2mtxcMRafTR6+3PomCO21CrzW7a9wnj9vv3GYeI8R5dP2JjlTTuA6Mv6e8WTFd7kaGk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189375a9-4cec-4200-874e-08d6145a8ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:30.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 9ef0112442bdddef5fb55adf20b3a5464b33de75 ]

Perf test 40 for example has several subtests numbered 1-4 when
displaying the start of the subtest. When the subtest results
are displayed the subtests are numbered 0-3.

Use this command to generate trace output:

  [root@s35lp76 perf]# ./perf test -Fv 40 2>/tmp/bpf1

Fix this by adjusting the subtest number when show the
subtest result.

Output before:

  [root@s35lp76 perf]# egrep '(^40\.[0-4]| subtest [0-4]:)' /tmp/bpf1
  40.1: Basic BPF filtering                                 :
  BPF filter subtest 0: Ok
  40.2: BPF pinning                                         :
  BPF filter subtest 1: Ok
  40.3: BPF prologue generation                             :
  BPF filter subtest 2: Ok
  40.4: BPF relocation checker                              :
  BPF filter subtest 3: Ok
  [root@s35lp76 perf]#

Output after:

  root@s35lp76 ~]# egrep '(^40\.[0-4]| subtest [0-4]:)' /tmp/bpf1
  40.1: Basic BPF filtering                                 :
  BPF filter subtest 1: Ok
  40.2: BPF pinning                                         :
  BPF filter subtest 2: Ok
  40.3: BPF prologue generation                             :
  BPF filter subtest 3: Ok
  40.4: BPF relocation checker                              :
  BPF filter subtest 4: Ok
  [root@s35lp76 ~]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180724134858.100644-1-tmricht@linux.ibm.co=
m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-tes=
t.c
index 778668a2a966..ade7213943ad 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -413,7 +413,7 @@ static int __cmd_test(int argc, const char *argv[], str=
uct intlist *skiplist)
 			for (subi =3D 0; subi < subn; subi++) {
 				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
 					t->subtest.get_desc(subi));
-				err =3D test_and_print(t, skip, subi);
+				err =3D test_and_print(t, skip, subi + 1);
 				if (err !=3D TEST_OK && t->subtest.skip_if_fail)
 					skip =3D true;
 			}
--=20
2.17.1
