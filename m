Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC030ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C262147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CEk/o/+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C262147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbeIQIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:21 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729645AbeIQIaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40EZXziYlPlrJFV7rMzAsBF/USvmDzs+gAtcNDr2CKM=;
 b=CEk/o/+/epMu3Jp7vHfE0zOZgrZlKgJQZ4Xy2PSc55OnpUmFqcqtthUdBLLTZROJC1DbB8VyptHTUAG0OBvggnH0WrFy1puRwBWDFDNlK5UjIAbPfFPTXCHA0lUyEvyoMz2UYSMC4mnxs/MgwPKFQiNiijMBiihtcWCxV1i0hB8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:04:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 71/87] MIPS: boot: fix build rule of
 vmlinux.its.S
Thread-Topic: [PATCH AUTOSEL 4.14 71/87] MIPS: boot: fix build rule of
 vmlinux.its.S
Thread-Index: AQHUTjL2VX5JMOkVP0CcXehZ06TEaQ==
Date:   Mon, 17 Sep 2018 03:03:09 +0000
Message-ID: <20180917030220.245686-71-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:ogoRStjPqCFt2IKqpPSY4JQb7ID/A7htzLheQSC7eM0I+Y5pEqppY8ymxicCJnt/+wqy4dYwlcBy9lPjenwD0zq6ymlFxG202F4XCSKymYxzo6atYopPdnJzuLrTuHsf2rcXJZVqrF+HBXZ4U1eT2shfci52LBtyaVcMfaHJyysquIfZ4DzDM0P5nto2y4cyzk+bR8A/JAhse5AAU95Ehs85M4F2KwvAQZH+kdUSFBPPCBp8ie/UURVE/SOL3or/DisoX1N/a7Y00u8tHsGrw8SYbAetd2DoIBrfLRXJOMx/R6W5YbHMUN0jCj7AhDdNmKQ5wGezNeeTowe6oj/ETyQ4Xm4fLCcUfYiWCxWFTUKxRIwxQtxCoMBetijCK3stWV51iqMAk31D0T8EYxa5+TuiEXuzDCmkxA7LrgzvTabE0VTF7p2svwJdkP+tE0oeCJEdqeqH3Qmrf5t8VQKGeA==;5:e1674xYQCSROGI72tDtB8b4TL535fk6z9KE+qZ68mcRg9m/uC4UhfRO6M25C/Me5sSOhg1EHJGzj0O29lTeHUeb1WoXWcEanovXFbW22Fqzob6cTRVbiXsLbF7Qpz4AMrBpOYAty43n3VZUzUw3C9AK1Sgmi68TdUPNDWAwhgY8=;7:F1plcaqfQn5rX1FrYC3ca1zYqpV5ZOcKJ2SPOFpYJpaE74Azh37cIYF5Mugg1nz+Ra78XCVLuqw77fjX7S1AAeTNbCZmTte59AV9oVD/3ociaf8MZtffuh8mgheZiSdCIl+t+560ffamMe0G4jfVlpUdeJS+R7m3+on0BOzu94D9V5zekcijscscYRX6/yfhYALpVOEmWi7z7+kHEIsFp2tGxEgfB2qC2BwQ8lj9QFmHOb7xjiTmy+NeD6jCo7QL
x-ms-office365-filtering-correlation-id: 2ae7fa6c-78c9-4b53-4c6e-08d61c4a5a04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01335BD2D6AA2CB69ED8F444FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(14454004)(966005)(72206003)(105586002)(99286004)(6486002)(6306002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cCXyLjsZGKxutPE7MmsuRTqRPBNDtCAPRihvBhCi/JtSq1AZeC2dg9Xk0zxLGtE6up4eNBBIkXvoLajJ1nz7G1DvadRTszvr0nUgsO+dK99BqmnZMFMoDKJMoq1gae6ioVzIHdFf8P76jS4bFF0+ZWDcIZBbYr+Np9K2Kou7DdyEHVHuhx1CmiEdpgvpeV3bmrOLgvW4iWVKL2oBpmS//4FsBdrgk4/8LgsAfUrz7DhXcGrem+chJsXqZe4HbzTMYeoHbo2H+Vit+Jx70r43tcb2EtZOvvDUGjzvNhRZTnojOMtZmWQrhOnqPdNSHb4YDib5yiToKz9eKgfQhJnJolqQkKI3bHoUEoOk2VS3vE8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae7fa6c-78c9-4b53-4c6e-08d61c4a5a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:09.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 67e09db507db3e1642ddce512a4313d20addd6e5 ]

As Documentation/kbuild/makefile.txt says, it is a typical mistake
to forget the FORCE prerequisite for the rule invoked by if_changed.

Add the FORCE to the prerequisite, but it must be filtered-out from
the files passed to the 'cat' command.  Because this rule generates
.vmlinux.its.S.cmd, vmlinux.its.S must be specified as targets so
that the .cmd file is included.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Patchwork: https://patchwork.linux-mips.org/patch/19097/
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/boot/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index c22da16d67b8..5c7bfa8478e7 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -118,10 +118,12 @@ ifeq ($(ADDR_BITS),64)
 	itb_addr_cells =3D 2
 endif
=20
+targets +=3D vmlinux.its.S
+
 quiet_cmd_its_cat =3D CAT     $@
-      cmd_its_cat =3D cat $^ >$@
+      cmd_its_cat =3D cat $(filter-out $(PHONY), $^) >$@
=20
-$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_=
INPUTS))
+$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_=
INPUTS)) FORCE
 	$(call if_changed,its_cat)
=20
 quiet_cmd_cpp_its_S =3D ITS     $@
--=20
2.17.1
