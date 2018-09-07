Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FB1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1609B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NxmhRERc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1609B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeIGFge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:36:34 -0400
Received: from mail-sn1nam01on0109.outbound.protection.outlook.com ([104.47.32.109]:39556
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726498AbeIGFPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIclNX57bRjHAM9wMxoQ70UrlkQ/TJaLUwMbFQjfLZo=;
 b=NxmhRERc8YnIPYcaRhLQNKqV1Uk1uyEctKqgOOcUn4JsxZhRQK5aRycn9OvQNAtd8X6UsTtlzdn/h99LLEjCtDNBHqNv8sokb2qT9BuJwekg8WO/JewqnflpEI0zQn1MI7uTVCMxuL+6dtQcnbHaR1NLf0bmCEARJZdDbzmntX4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 60/88] MIPS: jz4740: Bump zload address
Thread-Topic: [PATCH AUTOSEL 4.18 60/88] MIPS: jz4740: Bump zload address
Thread-Index: AQHURkLVZjnIOiL9FkOlYUrje9KgsQ==
Date:   Fri, 7 Sep 2018 00:36:35 +0000
Message-ID: <20180907003547.57567-60-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:ePXIAssccd/L+4kjmKogGbeB6z0yOrhJQuZymvm3t11DviDe2+RG30py+yGK0eLsAj961LPy7hY7ba4KahRegI4QN2gw0IWlk8IPqjin0vm49oWUax6QGb0ESOMnh7bBhrz8BK/HYSws8m77iIAcV2ZK8KFUaL81K5EXzC4+evqBj15hDjRM4ODow30etE+fF2SGMz5kBlg3uCMpS9wbsQcWTnnsx5E9DRtrAZPmygyHBXgSJxUBJK38K8+PWmley3Mx3tyyjc4e6ERk67Lxxc0tJkrotvHWBC901tKOkxGQTPD/7LtHZDA4bIGNd/ynYYd8FRDHnmNj2GHU4Ktu20Zq1+655DxFf/UEVPDpE4QjH5pp5Qwek9R2k2CFn+O2qygSPo7XlJPqbZ9t9Jog9QYmJFGU7R9TkV+1FFhno5r4p+Sg+cvMqCbpiYkATyZD2x1O4Hv3dF+eXRH9+xc7zA==;5:sXxboNjAPexJF/zLHhG+TUGzhcMU/yj1Hk1fmFy8/s/EZppxV2EvbMR220a5y/iTSaejNUh0M3k/HWy0RSXBJxdXlro6F5qRT9iyWsU8/akP+Td1qWdB2OSsLlsTL9H7qR7QV+GYctq5pl9hiyFM3aYBB2B392nm18YGP4YCtFQ=;7:N/lKvTjggcMtQuakR6ZhPMis00dXMtqCG3RQAZOuhstKFKzOk5YJbgyNb+0ira9Qz8APmPKLuRjA8Bl/cXkstiodUd1j1ixARgLx1WF2nti0qpc4XFebGZNo/5Z3RtEz5sjKbuLqCfEY+yxXuGGIU6rc18jVZtRGxR6lkbMV4n1tRBZVj/LRWeHaEzOb4ytjwzkZ/zLZIDQe/FBAUlYux2arPTkRIC0PWXOGcX1i7ub3NiYBH9ddZT/hT0fCau+7
x-ms-office365-filtering-correlation-id: 52e18791-7280-40d8-0306-08d6145a05cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469C20B3083678A62CC33EAFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(6306002)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(966005)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vNGoebrBU18V3gfJXGujhVnxxuX2MRhgfKfs16TpEPBVD59UlON9r04UftY9JLiRZr/ZBe+hwesC1FbbWeZ4/hlwUMoHSDA36iOOuW3zr5L8+BDB37x07Zaq1TWnfdNU9bqq7FfK+ToBkl5UH5JD92fznOeL42ft5NK/TzosRNogX5IM5VlaO8AO2z71z/nmImHaGJe513CJG5lIupVap3sLLCGURpLZpufIW1g5uec1t3R0Ki5tIaq12sINYgxXn1kr+w9GAQu886WrWJqEOrR4q/WMwgaCdaOlB4XZdOfzR6eoUSyPPzKsjrgBfpvamw+fh8sPXITMDX5YfrTjtWEuzrlkRZgsQMwOVS21uDI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e18791-7280-40d8-0306-08d6145a05cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:35.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit c6ea7e9747318e5a6774995f4f8e3e0f7c0fa8ba ]

Having the zload address at 0x8060.0000 means the size of the
uncompressed kernel cannot be bigger than around 6 MiB, as it is
deflated at address 0x8001.0000.

This limit is too small; a kernel with some built-in drivers and things
like debugfs enabled will already be over 6 MiB in size, and so will
fail to extract properly.

To fix this, we bump the zload address from 0x8060.0000 to 0x8100.0000.

This is fine, as all the boards featuring Ingenic JZ SoCs have at least
32 MiB of RAM, and use u-boot or compatible bootloaders which won't
hardcode the load address but read it from the uImage's header.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19787/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/jz4740/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/Platform b/arch/mips/jz4740/Platform
index 28448d358c10..a2a5a85ea1f9 100644
--- a/arch/mips/jz4740/Platform
+++ b/arch/mips/jz4740/Platform
@@ -1,4 +1,4 @@
 platform-$(CONFIG_MACH_INGENIC)	+=3D jz4740/
 cflags-$(CONFIG_MACH_INGENIC)	+=3D -I$(srctree)/arch/mips/include/asm/mach=
-jz4740
 load-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff80010000
-zload-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff80600000
+zload-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff81000000
--=20
2.17.1
