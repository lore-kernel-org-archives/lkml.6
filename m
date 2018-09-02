Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12558C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BA720855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="emLYxY/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BA720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeIBRUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:55 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com ([40.107.68.117]:50363
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728375AbeIBRUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOYEvyw8fa971fVf7AGdfYc5aMA+y3PW7fOrbavbYNE=;
 b=emLYxY/jXqjrJCSct/N0sOyRAQoV6j7Vk4Di71MjkZCsh8mmFb+qEuRuPkrKjY5aEIgKyocPHp6665P9VtteKMrCWsQMPFVPx/uKZ2bXGgHonEqyL02li8jN7qsqwjar9BEiJNU4+cLCKWNPb7QqcHiOQ3HqBB/W6v7HkAYLFyg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Simon Horman <horms+renesas@verge.net.au>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 090/131] thermal: rcar_thermal: avoid NULL
 dereference in absence of IRQ resources
Thread-Topic: [PATCH AUTOSEL 4.18 090/131] thermal: rcar_thermal: avoid NULL
 dereference in absence of IRQ resources
Thread-Index: AQHUQr2MBOZLBlKnBUWuzVhQwmxz3A==
Date:   Sun, 2 Sep 2018 13:04:58 +0000
Message-ID: <20180902064601.183036-90-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:rGJPLqKLX/m3eaA2aCqTttQ752FEYRaudyHzyFqoxy8V2nz3uYu3lOvs2H2DfSI4BLtw1NOebjkyPu9BUaWXMUaNVSKLwEWtX4t8ZqOGmzN8vsdzWnTQFE5EvROr7JXd+/QTYh7zHH2HE+vcX9Gzkz5hnhQOykfau2XXdvqrWaOGqs4B83R2ta+DX7+vMFLFeJlbqGG1DOEFoDJa4NckfT4JR+uq313h0Td9r8+loUMYB91lYnd2JjG4mWxYKGhP6RN9tEozGYkR3OVpebEBucepAMXHctFD7BsABFGhDe6ysd5qzNJjWfDDyhal8bDVyEVpoAGuKAMbpqVT+AW3Uha8baEYS5CP3+IjslxWjOCeTXlihFdSpmW8YzqocxH9fe/EO/ulD/sVCx+F57Zp2y4i7YftcbEYQst2k0Q7NAMdgz6pIkqgihufIdoBdQ7osC8Xm0fjpESscRJSOBJt7g==;5:WdMtd3gcDaqKH5ywC3nLCrkoeDSdyrOEX1o/r9rdR48eipCOItFy9rlv9V5ikk1Bfr2MA9LJyqXU25ur4CzefjYgnAEL2/zU5PixBFpv3ngWBjmugiTdVJyfqnF788LAuxA2PT4Ro+Eg0VGOvQRmUMMqip9bUEJD1CFrKugJl74=;7:/lHkApkimR1m81BN0VgaoYUm7xFSpEQz6ib1SDl6DQbiE3zqaoZlaM/yfN8v7G32zaUVhjVjOyPE9BYxO81ZhH5bo/XMAgx9UHTE5Bup7Qh/ohKsnXNH6qI0AXMgCQrQ4YE+fNRewbwc+pUMzc7mJ5PbkG5Y7SFQtIGNjpyc3N1scA6zzEL0VUtyLliso3NOHZgjShdQLSwmSEra37fLEZ02auYFk4VMCwBOvyYMBlxoLemy30x9BtbLUVcp96iA
x-ms-office365-filtering-correlation-id: 6a553556-cdca-4972-a9bf-08d610d4b115
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07413B748BC8EA41B9444A70FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(99286004)(6486002)(39060400002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c9p8VPVf4g7WVHMSHBwB3Wt/y+VPfFomGIRW5OEjN2RatWyRL5rfKTHriUddulkrJzyQLFLVw4GOINlXhYhsK+Q01pJ3rg81t8ZjaEYCBJ1XQwinMQuFT35AH03erMFz3IOoW6Sr2Rlh5YZIzZi3dBHqXz3XyqfO6GlrZe1Ou8/svy/ZThZdk3CTmq66Q1jYzY6Ekg3Li0MNQ5AZtqyTSWb/uoV2A3m3azEz+PiGszYFEKTbEuT6/cOYQpUDYGddyhj78HnxohSmxTcEjghu2LTVTsLLsu5eSk2ggGRVk5e6QHB0MGDh10TjfFJ2f67tZtibpum+WmyOOj9AFSeI54qHXP+ktLCM/e/AWQeyalw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a553556-cdca-4972-a9bf-08d610d4b115
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:58.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Horman <horms+renesas@verge.net.au>

[ Upstream commit 542cdf4068049458e1411b120bd5a4bbe3ddc49a ]

Ensure that the base address used by a call to rcar_thermal_common_write()
may be NULL if the SOC supports interrupts for use with the thermal device
but none are defined in DT as is the case for R-Car H1 (r8a7779). Guard
against this condition to prevent a NULL dereference when the device is
probed.

Tested on:
* R-Mobile APE6 (r8a73a4) / APE6EVM
* R-Car H1 (r8a7779) / Marzen
* R-Car H2 (r8a7790) / Lager
* R-Car M2-W (r8a7791) / Koelsch
* R-Car M2-N (r8a7793) / Gose
* R-Car D3 ES1.0 (r8a77995) / Draak

Fixes: 1969d9dc2079 ("thermal: rcar_thermal: add r8a77995 support")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.=
c
index 45fb284d4c11..e77e63070e99 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -598,7 +598,7 @@ static int rcar_thermal_probe(struct platform_device *p=
dev)
 			enr_bits |=3D 3 << (i * 8);
 	}
=20
-	if (enr_bits)
+	if (common->base && enr_bits)
 		rcar_thermal_common_write(common, ENR, enr_bits);
=20
 	dev_info(dev, "%d sensor probed\n", i);
--=20
2.17.1
