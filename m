Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206C8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE74C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JcV3XaCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE74C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeIGFQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:48 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:49760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbeIGFQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnPYzHtHj4CR7TmXir1r9/EP4HGEuIRQWFXaIDEf7TQ=;
 b=JcV3XaCJp+o0P9ZUNc5YWoel/sw9wycvP1cRxNScXiRYFPd0Ks3QONbwc3tk0XAZF/YUI115yiNKE5VfG35VoERJwbNec8tH0mQvFxa2pCJ/WlcV+gSlT0mzHtv7ikklzcooO1DTHn52j3QKoMU9FZvQZB/6AM2dvmfk/ckbjnU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 25/67] perf test: Fix subtest number when showing
 results
Thread-Topic: [PATCH AUTOSEL 4.14 25/67] perf test: Fix subtest number when
 showing results
Thread-Index: AQHURkL5+VQM8frlMk2SkzK05qae2A==
Date:   Fri, 7 Sep 2018 00:37:37 +0000
Message-ID: <20180907003716.57737-25-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:0MZx92kasEgF9S7ETqI76fRkDlm1jQZ6Hr6EI+A6mf5kSpyV8tmBuYi8m8rj5DBKgMNso1TuJPj4rmESjAUupD488mB0vii3G2sd/gpozz3B/qkDXT70HE28hNAbFuRYq++MiSrVHgTkGjxqqXMnschsciF3g5ptVaRGmwUy0fBr/dyWhNezss/Dhfx6fNl8t79eO//PLaCKEa/guahredb5Rz1AkQL4g7US0NCYZjgo0gW8V1ipKa3iazVk41m/eh77AbaY/76Ir9NhLQyP4HLEizxdXXo3bCaXnvAU3CDFbAxfsiOFZGL99sW18+90QtsMoZUTDvOmBauH5hkhDSP+jKG0ANeuTDdMCKc0FzNgl333zrIgEU1DSjtddpaYFYnVX/5K9PYKbTIV7FwENs+DqmkHIb76v7awkin/0ZR+qyG7yqZIAVmNBzlHG7WRPEed8l8Sh8GvcvzQKQnF2g==;5:NxEkR56d1D39zyOCesD09N5L3owF3+DooG6qYGw4uIlDP+jL1NSEoufKDp6wxloMMCv36VZwFp4MUUXWKlWjB/bzBZIookbWAzi+XQ/2ZJr8Rt+kjMdQClzE5ngU8GGuEFx/yNJaKH5S+3V91XSvg67MWypCMe4KVQ+lzhPGF3Y=;7:Nr/JcepPhGuHuFa6PgjDNbgOWBGg/09WD4EHQAYfUMpSp3Y6GbZP1yD/c4xWW+tDQxPfEjMhhERJDnpuHCqcE1hp0fs8aKJBcVeYtTj3AD35eYaPyDXbaHFt8054ae/lUHnr72IgQpgNY75D6F7sMUGjHvEI3iA0gQBUg9WiYZIl9oGIZssuw/JcnMu39xCyaXgVAdIAsFdPpOVOR34sglrxBJ9y1TzmfR9AuJ3llNFseL5VhK+H8lsFQfXFjRxc
x-ms-office365-filtering-correlation-id: c2cb3bdb-48e9-46e3-e3ba-08d6145a36fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07573522CBC7D0A419F08904FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(966005)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(6306002)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0tSf9lDzlr2NpXXgIOUbsk6sy1Ibt4YZtWLgqe22kPxHsqqD/J5pKFV7qJY6IufxBwBxX5JIp9No4BzcdLiHsv2uwTKpoAw7/PLR88KF3Zgd8i1j4ck2uULhAjDi6IvavqYqd6cPZUIM+hIHx1tmIaul1yRk7FQty3S4Q0t4nsifLTivzvTW4u9PYNkDo3Z6WlJg9V9TEAWI2hlNgT5mRxHOfCsvujOSixC+sriPzJ8UbbxfW3GLc5duiIz102xQKce6Sxp1RkppOIJqmWBrg/yVY83qmMJ9YO8OS/e/0Qla+oVTHd3cg6Oyd9jcwO4LTlFfdJLVOyjY7KA8zi/EvsF8Pncj8OMmJDU1C6D3dmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cb3bdb-48e9-46e3-e3ba-08d6145a36fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:37.5125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 53d06f37406a..5966f1f9b160 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -589,7 +589,7 @@ static int __cmd_test(int argc, const char *argv[], str=
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
