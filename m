Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B359ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8B1208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jcMjUygY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B1208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeIQI1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:22 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729221AbeIQI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/i9zGxEgm97l4zjOLe8VNVntlMkIYzMW7g6oEhmmAY=;
 b=jcMjUygYgeaFCCZEY0hHMr6Q1AXmFf9roHLRSfeG2V4GbbnAi7MvTUowAA1EcxzOFA3JGDt2hzZTM8x+OAK8Hg73GqmQlpMEN8b1D/frNhAo9NrL5kkSWiBluh5qWNGc04QA4vErB/zFUAX1pzamyx5Cuhs/XL9k6MT1b+zqr8Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 072/136] media: soc_camera: ov772x: correct
 setting of banding filter
Thread-Topic: [PATCH AUTOSEL 4.18 072/136] media: soc_camera: ov772x: correct
 setting of banding filter
Thread-Index: AQHUTjKnLKw4lld0XkeMEVHNlut7Ow==
Date:   Mon, 17 Sep 2018 03:00:57 +0000
Message-ID: <20180917030006.245495-72-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:Unv5smJrBixR+wO+cwOq8oliXfkjrfnBBDkecJXsq25E6MIjyf3JnMR2GCWAumLlZIXVZMdiNVX7hfdLwQDsBWPMkWe6sETUbtUn7BTJdeOJlicsk6XklAVhuTbyqhQ0G5K6SrQC1Pdj3JfALJm77nOsbl0RudHRxMJd5MLyE9lcH9pIM54RnsMnCO2FAEqMl3iaPctO9/XWpMN8uxNKSnbqOI9RtleTTXxnxe3y2Q319J9Z1VinVgIPD0qpa3b3O2v3ljYp4QeRb5kgGx2veB/moR+57H9Ql8x/Flmli/kCmIDflsFILZod9q5VEdiwguxbQ70gMtccKIlU65U82hAwIArl62HVM2EpTZMASOqaW2FRAMhCCipNANlngfvvGyQZMy6xs34H/SIc5LeVwnfnRsGgT+p8Ua5C/M83UtlmOjPn34gFhuylcLVNZlld05ymdLIMIQ6mlheDBVbzfw==;5:9jYG5iKSj4tDCnB2drIFdd7weuhxLrwkWVS8x15nvzk9jxnA68v6VmIQZZp7+oKMe9eCwO/GXlEZwZNOwNCVxka1SERjo6faQ57Y8tkcqBFSp4bP50EKL0FX2S0FmAJydLWaa/Yt92C5qmGATWERJWEhvcaeyTR4RmS5Roqdi50=;7:tN81RdVWVaSdxHJIgekMdkqC1M8Zs4wOsN2yM4/iAeBH8wxTjndBdAQCCCejyCzVu8qiQZ8tIf+S6Q8ZPKps0GZrBkSb9NUDo/NdEMioE/FmWZcIR0aOgPvo3AVgKIdmJmmJI0d+ihYr5mpnM7KlvaH924SRQ6JA8y7IjEdlqdvgbETRkCinuIb6zVMqclK3f/muYv+mB1RiES/nY9x5BpIE/yZPkRNEdRbxQMx1em5VpM7XiCGEu09mjNpAWz8w
x-ms-office365-filtering-correlation-id: 420ddf66-0ca0-4028-0d1f-08d61c49edbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502C734A5C27CBE981D799DFB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(10290500003)(39060400002)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AHIfjPzHuYWpxRgjLRbW1dczzRm8Grvl9quvK6gNBB7vDsanToEFup4ApNCwPa53JJAGa8bxqDgSMsQ078P1J1EbrZPC75+wSquyqw+HJsnvAIUPos7D1rxbWey9gBz7jdn0JfYwi/cyoRkG8VReT8Q4twoUyFPZldnmgsyV7UdtDGvOkcpKYRkBtfbAkVR2nPODyd6lryVW2Nok8IBSG2fb7rNsfDFKETNRIq6vvoRXMKKFKPFkzCxnK3OfSZw4n/7ayS+C6rRpTePdjrWh22sQ2n7r1bIpqdEeA4GgbviK+3OUM8XSe81AEcJZ8WkBML/bXfCId41juJ0GkjWwjQb7xMujJ1L7/KGwMDQz4XQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420ddf66-0ca0-4028-0d1f-08d61c49edbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:57.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 22216ec41e919682c15345e95928f266e8ba6f9e ]

The banding filter ON/OFF is controlled via bit 5 of COM8 register.  It
is attempted to be enabled in ov772x_set_params() by the following line.

	ret =3D ov772x_mask_set(client, COM8, BNDF_ON_OFF, 1);

But this unexpectedly results disabling the banding filter, because the
mask and set bits are exclusive.

On the other hand, ov772x_s_ctrl() correctly sets the bit by:

	ret =3D ov772x_mask_set(client, COM8, BNDF_ON_OFF, BNDF_ON_OFF);

The same fix was already applied to non-soc_camera version of ov772x
driver in the commit commit a024ee14cd36 ("media: ov772x: correct setting
of banding filter")

Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/soc_camera/ov772x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/soc_camera/ov772x.c b/drivers/media/i2c/soc_=
camera/ov772x.c
index 806383500313..14377af7c888 100644
--- a/drivers/media/i2c/soc_camera/ov772x.c
+++ b/drivers/media/i2c/soc_camera/ov772x.c
@@ -834,7 +834,7 @@ static int ov772x_set_params(struct ov772x_priv *priv,
 	 * set COM8
 	 */
 	if (priv->band_filter) {
-		ret =3D ov772x_mask_set(client, COM8, BNDF_ON_OFF, 1);
+		ret =3D ov772x_mask_set(client, COM8, BNDF_ON_OFF, BNDF_ON_OFF);
 		if (!ret)
 			ret =3D ov772x_mask_set(client, BDBASE,
 					      0xff, 256 - priv->band_filter);
--=20
2.17.1
