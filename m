Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529AEECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D21208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M2RYwrqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D21208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeIOGuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:22 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725753AbeIOGuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuI35dqrTn8fmVlifC1iLxg5pp3LzKnfQ/s4b9+6GxY=;
 b=M2RYwrqBVVZghSZKK0RIc4Z2opDLP2fXdngd3Hrulv0uBPbREOmWTof1z+7ekq68uh90ZalDS7uaAfsS+wvbw3CYtIqB6ELSrJsFxv19DYraaowydK1O9URfr3yc2b/3dQFRTRT9O8266uNbKNzwEB+QZuNNF4qtXRnftDZK1+I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 32/57] parport: sunbpp: fix error return code
Thread-Topic: [PATCH AUTOSEL 4.14 32/57] parport: sunbpp: fix error return
 code
Thread-Index: AQHUTJQDJvoLDwNhikKrTkG9S82DKg==
Date:   Sat, 15 Sep 2018 01:32:49 +0000
Message-ID: <20180915013223.179909-32-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:9nxRjQZxv+SfnQ95VVRAquSxyieWvyugJv4XRtSvaJfDJhgCqCM+AlsEMTvkK1hZnERfl7fMgHRMpM7dV5Mts54zByaPkt0ccd/twv0c66DlfPtq7RGvztOpX9F5CgrznyYkmKkkrdaR2ywxoAIQTHiphFINquaZJX8I6CMYHdtexm64mXw/C19oVSm9YgjpAbsS2poeZybjcbfmMW2Sxtm/MdpV58/EpmmPzyIGBHYTA4F9aK6GcWnXUwWeNHWzsSqgSdx2MApyprXawvDNON5v8b0Af1ZLOB0bsAdASzlW16SkHnKylqAhNRoSt4cveBRADDCTKfTgDqMttVc17gZpxcpVtkL6ksiG7+NrBI50j0h3bnw05IGVR5WDm7UJNU5YIo4UQh9xYZq26OvQyQ8rlI2P4alqJF9X+tAQa0sNHxZG46ZWEVdtYa0bngiWnFm64T9PwwoCGPvo0emYYg==;5:BTDiby5Df8OiF0o7N/jjD2jwW5JkekxcOLIxphWM+YqdioO7oXcyzsgzes4nKpMGhW2NVziXgmkeELnfG6RF0uBWKq4812YoFh4FxdNpcRJcaP0nqGmPfxrHA5iS1bB2FqK+olSo2IMju90BImYTh5VpGItXfvTFuD45KYOs0mE=;7:xuG98ssMLG8uk1RUArlREyo69uRQ3dI2mHWbPYd0z4PhXlw7bkomhhH71NZ+rwWXjjbsx4xkZRGEQ3pWQVMW5M13ueL+hqqA7/rOaID6uaKAuljpg7yFgMsgkKspVcqJofluuITeicPYaIzOp1eyI8fGgIPdjinozVf++vlCaEZi1tE05Q0DXLvOn2SwtUa6S81CHB7fY6RfiGFMeCb8sqSpaBzC/xH6N7GxRJ3zTCYHn4FliE8IZ6wSHXc198NU
x-ms-office365-filtering-correlation-id: fedf5a84-aef7-48c9-d871-08d61aab3793
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471D2079B7264D24B3CCE3DFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(39060400002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wZ5/K7RUlFOg8I8327QHAPtNcDs0BkvyIWjOHZU8iE4pjTXZ439EyLbHpA+Bldun9/VN5Ls6tLKfyY9oyBmzmYBhiFhvs8nG2CQJT8ilizKSuDpNgJTFy6M5gHI+7I7ad8QOVpgpirlIPkZt4cNwqb+n5E2OZ03vA2g7SVhV2lTOQtFl6pL3B9EYiO50mzmHJbSNLC0rbCpvNoAORRGOpnT2+06nLNmbobRSwPZTMDBGdd62BfPiKX7HJlH9+cBtH6HABKNdWgJ+XKesp7db9LRydChBdfjBm1WFvDoqObtaFe/YbXnDBADdzevFtqwJi2v42+q4Iym4Su4ec1TzWf4xi+zFG9H6Rl86o/3KS9E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedf5a84-aef7-48c9-d871-08d61aab3793
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:49.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit faa1a47388b33623e4d504c23569188907b039a0 ]

Return an error code on failure.  Change leading spaces to tab on the
first if.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/parport/parport_sunbpp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sun=
bpp.c
index 01cf1c1a841a..8de329546b82 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -286,12 +286,16 @@ static int bpp_probe(struct platform_device *op)
=20
 	ops =3D kmemdup(&parport_sunbpp_ops, sizeof(struct parport_operations),
 		      GFP_KERNEL);
-        if (!ops)
+	if (!ops) {
+		err =3D -ENOMEM;
 		goto out_unmap;
+	}
=20
 	dprintk(("register_port\n"));
-	if (!(p =3D parport_register_port((unsigned long)base, irq, dma, ops)))
+	if (!(p =3D parport_register_port((unsigned long)base, irq, dma, ops))) {
+		err =3D -ENOMEM;
 		goto out_free_ops;
+	}
=20
 	p->size =3D size;
 	p->dev =3D &op->dev;
--=20
2.17.1
