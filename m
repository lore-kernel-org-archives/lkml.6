Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2901C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA9020841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RXrz4Ork"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA9020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIBRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:42 -0400
Received: from mail-eopbgr720112.outbound.protection.outlook.com ([40.107.72.112]:54667
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbeIBRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhnZtR9UvZ6qf33cvRO7LWJOkggCa5S/NL4pgyXkvng=;
 b=RXrz4Ork4HryXJ3hQnG3ihbrRXgtrrCL+Q4Rg8lFklhmNUo5zQCMg3YilKRySyGvZh9sjlUUUZhb3V90lM59lLTVqNyMEkZWt0izHTQ7BqTS7SCadY+wuT9oEdfllgDbQJcOndxoMvd9C4uUnqGNe/IStPKpdbVkR1k242yqiyo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Roman Gushchin <guro@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Arthur Fabre <afabre@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 012/131] selftests/bpf: fix a typo in map in map
 test
Thread-Topic: [PATCH AUTOSEL 4.18 012/131] selftests/bpf: fix a typo in map in
 map test
Thread-Index: AQHUQr1OhnK7NZ4z50akeI3Y2eTTUQ==
Date:   Sun, 2 Sep 2018 13:03:13 +0000
Message-ID: <20180902064601.183036-12-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:H4TlJlBCrP9TYGPHEvk4KQooF/dGfje+ffsDgZTTwdE0EDPuvLk7tvC/5BynFoea9MDlbQp48+aWyj7AN56dry1UsUVvkbrtqq2+s7sxbytEC7NYAiSucS4JUUzcaVuDFCCDL5+YtjS44/HKPJdrcNQCT8t6nGtdWPvhM6vCdLEqnWw9NBZrIEg9pOd1pcrSOEcQnI24wTs1DDIFoyoOiaV0Yc8VAT0ZyFsvssrx6uM/nlYL5QNHAj3vhZe3y7UGdxH736DNlp7U4RfR2gFYLZlu7BxUVWTZnp43j8cR8PYL4B4E3yHBo7dXDc3s3FZeQuoDRCvqArZcRtdG7o37WhZNevUMA4u4MRbHHaheL9UNcl4q6bxzD9HCLPIJDkG1kwBghzXkiBc6hWHY8thX9vaKJvb4v8KvReak5nTrh0MCfj5m6LcSyh0jdNuwDU50yTzSo+Lsbda8eiWcTUkI+w==;5:GQpJK1SRhW9meVtdg72i/wax7Je+jr0tGFzjx0Z+Ul0owvdZYx6C54wCbfjn2XQZyO+51VMPTk4kvvcJAT70oOeXYE5qVbzLmEiVjnqlVRhu/mu/wcD3wyxZaUbzUrmPN/3A2Zz7qi2syWugF1KJS2a9PgWC0p3RC1Qrqk2sAZE=;7:qoCGmo+l9OFk0eZE4TZqFf0pq0SKDagb6gqCaQ9+E+Wl0PXVfNca3Nq/Bt9OR5suM0YMphsI4/zHODDUiCKXcJod9KZFEyooJo7HsZHyVJtv4IT6wPIHagDrDohzzJVILGaQ0lDNcKnNmptHWAdzoD6QJnd7dUb04MGbp8+qiHei26NsQQByhxdcrmeXWxobm0w36ZRv34o0bx88LsXAUhAKHlxzvTiLtUjdTuxPd735H1dKwTyvxuoEidsF8V1X
x-ms-office365-filtering-correlation-id: fb3d8117-87bc-41b0-d103-08d610d470ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0837BE21966484413C5FDD3FFB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7kU7z7h1Ff8UbHWoEd2hTd4SVVXmVcl91KZp5WKoj6K0iu50yBAyYrkfWy8CFq5CP61h/P1KdTA8zrdLEnh6EY/qVHsxkuwgQHMc0KCC5wnHdnHb+8gyZ18Kqxa/UhlW7OECj6oZ1FjF+thzp6A4oJllkQRzr3cL32SpMliP7XR+qXT9Qyl8QKT2HN9B9tfFdWhdtGSunnak/Z43GUXFcUmzlnpwaQB37sBDiKraz2VKwFcNOJcQ3MivYFawd3/rsLdyKUGv901/lqP1qPPkLRW0zEcrwiwM7A3EssXGsqaurALIvfNeQ2KT5QrKhg+6SoA2buy2j/cqWUGbwk4p8I7XMe3a4Xe5CIG7v6CDns4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3d8117-87bc-41b0-d103-08d610d470ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:13.1923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

[ Upstream commit 0069fb854364da79fd99236ea620affc8e1152d5 ]

Commit fbeb1603bf4e ("bpf: verifier: MOV64 don't mark dst reg unbounded")
revealed a typo in commit fb30d4b71214 ("bpf: Add tests for map-in-map"):
BPF_MOV64_REG(BPF_REG_0, 0) was used instead of
BPF_MOV64_IMM(BPF_REG_0, 0).

I've noticed the problem by running bpf kselftests.

Fixes: fb30d4b71214 ("bpf: Add tests for map-in-map")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Arthur Fabre <afabre@cloudflare.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/se=
lftests/bpf/test_verifier.c
index 41106d9d5cc7..f9c856c8e472 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -6997,7 +6997,7 @@ static struct bpf_test tests[] =3D {
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map =3D { 3 },
@@ -7020,7 +7020,7 @@ static struct bpf_test tests[] =3D {
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map =3D { 3 },
@@ -7042,7 +7042,7 @@ static struct bpf_test tests[] =3D {
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map =3D { 3 },
--=20
2.17.1
