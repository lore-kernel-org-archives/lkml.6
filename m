Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29ADC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C152083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GQo89vi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C152083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeIGFOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:55 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeIGFOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iES7aGVFshfx4s2a7qxjxjguNFmHYltxuMRbCdbdK0Y=;
 b=GQo89vi5fXy30ZF/jEaryComkpXmJLdDqu02V1hcjRYi5MhPrNZzcJ+msC9HNwB3Ve8xvnrAJOzKPoNwBN+fVIQcvK1261IyHUIETbrEmUqMgToq8EaWs/pgcgec+JSnHGkCRJx+U+3aSifbCRDI8LgRIO+7X7OdoqO3TcORzzM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 33/88] perf test: Fix subtest number when showing
 results
Thread-Topic: [PATCH AUTOSEL 4.18 33/88] perf test: Fix subtest number when
 showing results
Thread-Index: AQHURkLJcaLV3wuup0yxW6j/ziIryQ==
Date:   Fri, 7 Sep 2018 00:36:15 +0000
Message-ID: <20180907003547.57567-33-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:mXFufbeVW4ESb+ABa5bdF8INtuTFuFvUgkrNYPpLEXBVtBUb13yIq3eps1zT0BFODr2Go4017ZQaqh1czfrK+yrr+qICmADvl7lJ1cV6vc7szALcbOppw/2UXhVktQ8nAzbyozeEK8voxs84EycDUk4hRGocpD1jK+vDW7L+Oc/35D1vnbIHl6jShMpJYlTAyjjoxTLR+MNre0UauHQdp//1ikOuLUqcxWgM1r1hXt0n0A+qEtsmXoduNBPgaCMHRqbuEZspWAjostBOVSXMMEH/eNvGLfKbL/QEQSuxdEejUTgOSvzqvcU1Wz248dWUom+79vVwRqLU3rt4qvFk30YwaNi+3Mm5IGmycOI1m1Xk0vpNrcuztXLPPAiohO6dCBBa+R7ZPrLuKNR+Au9xjGdAWLoHktaVGb+HnuKLGMSAD8KnXuPTlnJlCHu7KyX6tmX+WesL6JM2zzOy7ZjWEg==;5:2BfslrDTtKVgY9C2QPN6aaqbLMcLGZlyKdQCKbaL+a8FefRZCzgqhS+HNCXTSFVkx0SphLTAT3R2wp4qepXEDH0A9brbkkzxu/qZBS6sAi7KHnbXaRO5QUyhmQgijBqHQ38A5raT6rEob0hN9Si3b/8r6J6JPqvxetagsZEtlA0=;7:ykT0Od7gYC3VQg2mjaDmA3t4/YUU2w/ThOoJfVqw2WIB7WMNE/EtunBnpSu7lA0m/KI9a2PnoF/YS6yyFDBqJ68bc57ImiBAf8dERsFeGtqzGkKVe0Fdb29iiTuGH0Rmto8TzniQR3gtCDdaqBhVXDNV1wwPizhmi6sSgEIUugU+Zui7b4v0SMQ46S97BxTBcnybiU6wyDNJvpJXVBAe9rp7JwmM4hyKNytp8PRnpDIuatW1wuK0pZaBS6Kpd3Hq
x-ms-office365-filtering-correlation-id: 67b68843-b312-4561-f9c9-08d61459fd5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046926C25FCE079FB48ADD9DFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(6306002)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(966005)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yKeX9o8fMwGBw6l4lge3Jo2N+Y2JZa6hNztY4mt5Wj4ylyTBR/FpqAc5WFSo8lRqzDnW1JhnEcaQQuvbtt4dhdrQXmIlIyyA16pqZIYb8zvpgYqLq4DQKCqOY/BRGRs9lNCcXWzgvNgdQV2eI5PPDFobGNSxtb0AYPTtEZr1Q9UtVijGokqb28pwfZkqSzW9NbsUxZRCPCUHxiViIQosik6Z0Ru6u9IDilInr/Vhm89uh4L9RfpNDsKNTVFasCUH8RLASTbwIHp6NpEgU27MYtvcRbApiZc28rytHTA8DauWjHG6IaOSmzFb+6qjr7tF+7Bsb7iMB3XTyFhswLRfoGlta3Lhm7r7TMXY1cgbrgI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b68843-b312-4561-f9c9-08d61459fd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:15.8282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index dd850a26d579..4f5de8245b32 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -599,7 +599,7 @@ static int __cmd_test(int argc, const char *argv[], str=
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
