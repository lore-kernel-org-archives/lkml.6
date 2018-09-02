Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A651DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5651D2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QR5V/C/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5651D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeIBRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:23 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbeIBRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+oc0so40B3ql9//h7GKoSwBPqsZQt2/wiPZRW2G/5Y=;
 b=QR5V/C/8ykZ/PunW6oiFpK5d7+Ofc6HdJSMJT8vcvYWnOZZvK6vpr/tRnDO4WJaU+VEX6T+5ZROgZqZXzZoBJ0hkYc+L9JDPEczI/30+WMmYWBt5rYgjq8CIDngO59IH3yO8Tqsbf3pkr0Lj+9K2nTRCtrfkxthUWeJmo98qq64=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Roman Gushchin <guro@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Arthur Fabre <afabre@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 08/89] selftests/bpf: fix a typo in map in map
 test
Thread-Topic: [PATCH AUTOSEL 4.14 08/89] selftests/bpf: fix a typo in map in
 map test
Thread-Index: AQHUQr28LsKTcVumXU2VmCWs0Wn8PQ==
Date:   Sun, 2 Sep 2018 13:06:18 +0000
Message-ID: <20180902064918.183387-8-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:yQqjWGyf7DidgT4BQUGlABSS8w7Urmdb1yZwodnZpVVpAIl+lRIoN4GJxojG9KS0HdA8zcM5QGxP5XsKInGN26s3dwCTk7TBJH+0o4EWoXGcg2N94ollflnWAlx2fmhUJgnxFO21dx59AkfqqHVAS5I/VxNOVG3CmpkSl9dlT6/0NjE9PtoCGAwzxcLvABaPQwt7B6kIi5RWY9yZdHxAetLwUyRUPcOQvBQ0lf0N36H1+0R2pRlFGe9iHILJN7fBUxc7YD0RdkvTrPACFI21rUrF++c85oJUDLekfHFQ6Ts+9jBvYAWGoxLBnNiwnLGzcF8VEQcCp5Rxc67wI+tyJw2AfYHqawVy1PwSr9tfqTVPPo5G4DVwsK93OTeZtoMyi9DnnguR6ZC2P8yVS+rWK+/QRCNScc3fotsOCY1P6zSIHkrxzR2q0TtKwsj5w3jmgftGPin8rBtwCSubytrZgg==;5:cEwlXWa5dmGA95j7KVCyzEOrkO+Pb4IXOizXBfRf0gN6gGy0YnS6i6IVLlAWASx70+S94+zINzJTFFu39Ub3NTYKI6FYq8pHnge9V9ihlbkLBJxcf5BCgHLUTSGjSSKKTPaUUoaxOrMdL63+IzDKYD/KcV6RPKwVm40lwzVUnqU=;7:azdNStWrG2MA+gyC2U2o/BujCV8URwucqFQVmEbw3KkJxr/JktbwM1JpJAV2Y0ygEwQIVxEC75USHDVsLm0yhYSniZnNto/5SXgW/vS2n5pLOa3GFax9T0SXqz257ap3Uw3lieJ0QxDKqVQRKPweoHavHJUVzv2gCxL0XygOIinVYCiyDqwcS019vh7FxTw157xJZbASkvjRldlms5pwxVRqzHx5L2/iXNEJm4jBd9MYGctjdLuDW4H1vuLuPCHF
x-ms-office365-filtering-correlation-id: 49b01ebf-5a4e-467e-59e4-08d610d4e1f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822E7F4E8C70B55C3B9470EFB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rloTb0luEYxX2TB+kWZVZzF9JdvrFhLk9+VnlP5cM5YrrcjEpIYHtNrAvKpynI2xKFtX04CT7yVEDM7c5u3pDzY8REClxkW+zn0wtWyY0X2GD+fSNvsYm7dXJGfsxBX0gscEqKrO3vMH0aEOZiPnD7FQz2yGR0+vKxoeyMb/PJqRbEEVXcNFMcz063ChiytEaELR+NqwjNYK5/uxIbReYJGpY9w+LxadyzxDWm7WACqK2HCgTroPV/EITy9wTQOmRq0JUdDbBrna5wnexDUN13iAUmQnfiZ1xHGznfgmKNDK2VwQZp2am+jyd0I74ro+rmhUunWcBU4hOM/yfKUyPGO85+dO20J81t2xb58InLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b01ebf-5a4e-467e-59e4-08d610d4e1f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:18.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 9167ee976314..041dbbb30ff0 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -5895,7 +5895,7 @@ static struct bpf_test tests[] =3D {
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map =3D { 3 },
@@ -5918,7 +5918,7 @@ static struct bpf_test tests[] =3D {
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map =3D { 3 },
@@ -5941,7 +5941,7 @@ static struct bpf_test tests[] =3D {
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
