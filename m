Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AEE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="sJm5CN5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AEE2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeJASTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:19:43 -0400
Received: from mail-eopbgr30106.outbound.protection.outlook.com ([40.107.3.106]:43844
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729092AbeJASTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oDpZ0xrMKR/CjFujUqDD9ujuR5We5qVJGs4ywRn29M=;
 b=sJm5CN5tXko5K3x29Cd5VipiFmFd9zcF4CvWxO7SorprweIJdBplgrt/4k0vlvxPmUgNhl4B5sCTzo2F7Ds7+RbsFgv9LbuXFqtr4DDLlj8rJv/PGE/a/yF9wHh+/snBK0bv5RhYF81Mx9bH8ZElE7/W2JH6rxlhRaN+9UJesi8=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Mon, 1 Oct 2018 11:42:15 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Joe Perches <joe@perches.com>
Subject: [PATCH] MAINTAINERS: use the correct location for dt-bindings includes for mux
Date:   Mon,  1 Oct 2018 13:41:40 +0200
Message-Id: <20181001114140.11751-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180928220055.30772-1-joe@perches.com>
References: <20180928220055.30772-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:802:16::33) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b38ea6de-2fe9-446b-1a12-08d62792efa6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:sU0mWPbzSeXtS4wP5ih2DeuN7KIebDeuCG/cGHtru9S+Qo1N2J/CElOn5vBnQWyp8ojkVQ/WtIMVKdfi/sfQBLgjIv9XdLSr3cxNOjl1zkEql4+Du9Ruu5D2ZDZGnDPFhBroOeGRxcRcsmkv2rrmdW2L6DlptKuCmbtGlEsbW1GBcAFHAbnB7q++JYdxBfxkKiwNb1OXHJCGSoasxX0Na6aVN/9gC8+9Zx4zqG84FKG2xftfjOdQ57+RzJ9d4ltc;25:+lnJj0Cbf+Fh+0LJlcz2oTh4m6hhCpI2OWTvm7Km9Q6s/p6vBg7yNOYlVW4DVwXA5PmLAD10IAQ7da5WiiI3FL+X2LbUsLK0UXRMfJop/lHrNjPZhAnY2gd+a/MAYqEnxP+9VxETJlk/nJsTxkiAV5zRaTaysBjZgLDVuKtyJNH3TYcUJlTDDe0Pq6KZ9Ej9f/9kIlRtRVEozIdZenom7loucDe9yACU042jgA+kSGeDIEypA00sJU5iifdQmZ6yLe2Hw61SzQ2TYx4df9MJ6wVXOoXri2pA7wk2hqaAa+b2iJ/mtOVPIBGmmLmCp4KIYmunisqtMAZLRK//FvxTaA==;31:X8+IMXf2FVeFYyIJgIC42b6JY05PNAopD0Ll3qNXriHRcWne1+BPWCC/bngI8N5wiyg9Hwr8qhp787eH9Ou8pGiNbFPrJYQhnkNdu6X6Zd3JpBsF8rVjBDgBX+NCFPn8fx6jRZ2KINwm/qkeN5cNR4lb59qZj9sK9HK2OkvxeyuOnAOuq4KUstTQzrv2JuZSptArlRwya9w8isZid029NYwQQrGhkhBMosY53yFHllA=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460F8305A22AEB507E463A9BCEF0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991041);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:mY6geC56MiVbFygoC3SC0BdFzi2TWuykV1Mo7R08+Vv7SlKO7cd2mrJMe6f7srS6bTHX0VTpLz1YR/No2LzNfs7oh6g65bqoD2RL89uMTiYIaSG9XFokbSl+zNl0fD0a7rMLr9UojLXCvudNLD3WBVqis/JZjbINWyzDvKPF9oee1Zi3oZYcTYMahIJEPRqdUTZikdd/73D0JR2JZ1cw+WImIewlEDHfndpP2ZGqjKepoYfsXuthcn2s3irSefVVu41l/dwCNruL37dpVRJrsQ==
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(1076002)(68736007)(97736004)(5660300001)(8676002)(47776003)(8936002)(50226002)(305945005)(7736002)(508600001)(66066001)(81166006)(81156014)(6486002)(3846002)(2906002)(53936002)(6666003)(2616005)(446003)(486006)(6916009)(476003)(956004)(6512007)(51416003)(186003)(105586002)(106356001)(6506007)(48376002)(386003)(16526019)(1857600001)(16586007)(11346002)(25786009)(36756003)(14444005)(86362001)(34290500001)(316002)(52116002)(6116002)(76176011)(50466002)(54906003)(2361001)(74482002)(2351001)(26005)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:IxFFDtKxDQpkizJA77QQIrVFb74RY21ePMbt6sg?=
 =?us-ascii?Q?KBZQeDaetnAOHAaULgXrdb2SEmosUXkP+34dwPgB0pSG86RfqPPYhZBkkotq?=
 =?us-ascii?Q?3sExYDnZBwkOemmUCj+FR1099Ld77P66hbxwvXCl5tH/BfimswJAQpNt1hU3?=
 =?us-ascii?Q?Ll++gNSrzujhSE4I/gYnB8Gt6pgbpl7WtEnjkE6pqpAhfDMcFvUi1vpWs2gd?=
 =?us-ascii?Q?1/cXsiW+IwsxrEpMQi47FOAmmwMExReOasUeneMLYwB4NT5iNbHxb46DeXDO?=
 =?us-ascii?Q?Twsx8Ga2ZYBbwegWfVoHF2hDTtWbppbur6LydM1DwBA+1Ccn+/LQtVFwmsVZ?=
 =?us-ascii?Q?M28ElVzQxKJt4sdW19qiGv94BOQk5c+PclrZNwfbrgqhjuzjSusT+FG6cIr/?=
 =?us-ascii?Q?0vSlhwUkOtyOSKWqQVreSqRMtU1jNgbsgg9phv3b2siuzYJdSV17WYnhxyqI?=
 =?us-ascii?Q?TQ38ah8kWm9GTmIqQpY0ff2bBhcRgmBk9Xvj+dlHjVnH3aUMfaFToIYvyhYn?=
 =?us-ascii?Q?/FzhNBtHsJMCliqQWFrgR7jLKIG0ksyvV/UKTWRIEWt+29VxwezcmZQCBbny?=
 =?us-ascii?Q?PPvNyIZpi28G/zi56oUZ+lZixuwnTK8WYOV2TtXAGAXUDuaS1U/GAsoDAtTJ?=
 =?us-ascii?Q?NctqgMr2wHWPvc3eAzmdkIMaduQrtPl+GHhW6s7Q1rI6DgvusiaoiTQE4yEY?=
 =?us-ascii?Q?HwgTysUhRTqjUJ7aXMLva20KB0C0efOWe/JAiSxCtiVmeEE3eT82vq29A5kv?=
 =?us-ascii?Q?3KMrnU1rQG0y9kaF/e3NWK6eWNX6rOnfdRlKU8rCgo1AC+7S/5vPFGok4lhL?=
 =?us-ascii?Q?vD3XrYFTT8egrsmdVEOVvGcFrqY9KNf9LPV2N01VI57h+ColX84WxTrpaHZ3?=
 =?us-ascii?Q?3hz3EA6UthJG3/2mWXttI3ISSwEV3bBwuBaGGfo8YtEuUUWNMJdyF1FWFMVr?=
 =?us-ascii?Q?KJyAkCbMtNsVME9yFo9c+O1G5b9DS/vGXeAoE8d1snkPFoE7oYSLRDhRmM9+?=
 =?us-ascii?Q?iHST0CF/4OJuSUdn8+0xdZUnV+cJQb2u+Zliq3OS1meVz24xgKJ1jRcl+Kj1?=
 =?us-ascii?Q?/jqgNzLMlvsJhm/VV7s1xWZ/HNYqkJf9nxYxz4nEc/dFRz8qoZvTN6xK3tcx?=
 =?us-ascii?Q?da1vAIhqLLwTRYACU4ZGEt90xuyqauiG3upN2SXmgggA1LffKqyQNZiJTJEL?=
 =?us-ascii?Q?vqCv8fZGBVdtyAVvYG+948pxYETJGvR7ooPtrQqXpzqxbXGJM6lLtT5MybcY?=
 =?us-ascii?Q?hCCJrwNYIAeZs3lb1LyjUBEByRdeQmk5iSmY3apOV9tzYsIlucMKzoCvQw4L?=
 =?us-ascii?Q?jqft25IYE9g/B1Xs8PFz9Rmw2+0A7FPuDeePfviDERC3VSlLGp/7pLeK8VuI?=
 =?us-ascii?Q?fjhk2YA=3D=3D?=
X-Microsoft-Antispam-Message-Info: burVcmgtNtErgPD77/L+Ewpel2i5cjGmi6PP88HXmeF+hwMMyktA4lpq1QF86s4aEAKPMnAAsbJASnWj8KtU6FxQ92QEJTbdF3a4z0gEcxVZGdiIYgC0HUa5HSE9SqdCT1GktDlYa1jBDwWiA7iuvK1Ho91TzHpdLCsLFL2r6Sv+inGjovMsQlfBUrbbS93sydHYPq9396oB9ZzBECsi6Ocdr/o7Ly14Xdgrp1CfDZV9P6BVEa8L0Bk2AGk4WMPkiaYA8YHGtP+uSzJgCrvckDFKbGgDosA7KEWyHoA7WAozaOYqtPqDbsRDA2PK1PJnv2Ca1pIsvVYcSBq3GtlaPzUzSc7CinxR119HhQvWWUU=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:Z/M8ukDdessLCOgBRxRe1qW4J3Ji4nKjUZ+9MrJ8IgXMLjeuZ5fG6G7+uboMVm5T526O2j3BksngMz1JoF1rMAZdLXeUY86hXfh4xLtrglYnepDnxK61tJwJzWl8rA/fPPbLvPNtrCBcNX2OgxY4RKmBq6U05u9Q6aLOrb5HOW2fMrxnjUxkvBVulSviM+av7UVGDTPsPWRe/YuRIAGjgWVpgAsmkxGB3FsYMFkeNNIg8xY/luToBaJ+NtrbBI4T8muygOambvWJjR+Ve+MEOIQbsh3dpm04pF8PAd5Ej/Z/H3KhJ0yFy6DJ7nsmBMYaodZqTGCxnm9AZpM2eeyaXck2KGVP72saBx4lARZDOfqeZWwUEHoEfvtw8viaYvN2uIjlq/ovHqD5Q10/13rFAqc9kTGTacOjOqsgQ453iClM6T+SvXIPG7o+jsRjLRqbNwgUKdtEyOMO/XO3g1+UEg==;5:9kmRvo085VShBSTNNUhhYUzzESLs4jcxauWcDFhHXHzrwo3aViqdz5t9yXRQFYH+J0CRFrFP4iGsoVLgrm2+AXvLxnD/LslQeD/W42DVnzMB0T1pOgxIueT9stWsaFmogcVol5FgFsS8vpm6wnePc7WJ3twysDn2VhG8TCPcOfs=;7:ALY3ZrtafhVfNSUc2gZTKc6wdVboVnP9vNrRS6JpBs+cFNPDo/YhzvNB7VyY5BiHm1BJuoUL/DseGKcJWlyXkfBvqvcd4z1aoWRd7IoupTRIWDrSrZjAB9IB9bFS7LGjfVyruz15NP4TmIbdDbk5fm2/swPfVwms/3EyUxHhtZ6haPS1uI4zYV+VG2sg16ou+lgR5QwR3ktnofIJ/fVi8QF+JcZJ58EOm7Ucelfmmff/LmoUXALsITKD2+3dW9cY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 11:42:15.4946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38ea6de-2fe9-446b-1a12-08d62792efa6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just drop the "linux" part of the path, it was never correct.

Reported-by: Joe Perches <joe@perches.com>
Fixes: 256ac0375098 ("dt-bindings: document devicetree bindings for mux-controllers and gpio-mux")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 955463f8d518..f47636fb5721 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9808,7 +9808,7 @@ M:	Peter Rosin <peda@axentia.se>
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-mux*
 F:	Documentation/devicetree/bindings/mux/
-F:	include/linux/dt-bindings/mux/
+F:	include/dt-bindings/mux/
 F:	include/linux/mux/
 F:	drivers/mux/
 
-- 
2.11.0

