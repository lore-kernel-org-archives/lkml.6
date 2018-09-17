Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A3E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="l6DluI1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A3E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbeIQIcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:36 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730361AbeIQIcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayyaboXY1IM99iBIpRlTvMm4TwpO7l0QrougNBqnx8E=;
 b=l6DluI1y7uwkRmRWFGqfk+5quSS89vpqLn2ndnDNKgLrxj/6wfEgGjzpvAUxwG8BZldsYpQOGawblQn2otL4L7oWPGgYuveCeDK1J/Kt7w+tcHeP8Vz+cw1freNNLHc+hzq+YAGbi72H89xUCzYb1e1Gh7jonxa12pjJFeO3DZU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:11 +0000
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
Subject: [PATCH AUTOSEL 4.4 26/43] media: soc_camera: ov772x: correct setting
 of banding filter
Thread-Topic: [PATCH AUTOSEL 4.4 26/43] media: soc_camera: ov772x: correct
 setting of banding filter
Thread-Index: AQHUTjM7qQlmbZJ58kyHkyn5j9iuMg==
Date:   Mon, 17 Sep 2018 03:05:05 +0000
Message-ID: <20180917030445.484-26-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:U+yE7i2LIvWGiVE5ZaHHSbNyoD1kcqXW5VdIVlB5EZSWT4tlEuiDhJIEApTE2b+ddcqRnLWIbcq3H9E8PUU1T3S35QWQRoFaCYcQ7jI0iSfpz8aQE8igh77BArY6g+scZ5xAwXu2sMdiXoCVsZEVkkSTQ+Ch71JjwfX4j4CslZlW7FBJMoL2FeElZGoe5lqIw5kbyc2n6rLV2aLbeDWug5rlSrHdcTGhWPuKgwu0ude+uGE7LpnjhLsHKBX7agqqMmShI0EppoopnWqfUZnMzLopzldqWFP0o9C8fIph+r+2med9XWqEmoWLZiUDv1EtP613kJXyLYKbAxlivm5GMAQ41VB5OOuejF2ohCwtMVYo4EgUExM67PiZ7siVlfg8l47XxKaPLu3+VafEtbNZLgfw2IihaI28+3n8eqWVCPkGWCKyUzPtWbg1W5hcgpqTaqNBlduIC336bzDX4NBgEA==;5:vlsyBe21Oyt48olZ+FX1eba6AIAMBIrOMTz43rSLK+ZrZKKvJKlMFf66pGMZuDt5dNXY0Eke9YkTQ7yOMislysW0V6S7licTCpQb0detizzSwiWDacsd8PqY7jVdnesbyiUOswVljosjtwnrTqyiVy1T6spf/dF/UajR8Uvm1AY=;7:Cr4Zz4B6W0wzC5ulhPVEHuAC32topZ/e7fHc71yEbWCSCEm6tnbF/cgUU0NwPjabU5LuqgcIXd1+pJvcaxMZRabSbx9k/2Oh+rscOkh4mYChNfmKORJjzagT4LrbLEXpOjz6QyIVKaDeZG4x2ZQc42Jai1DGXl0GnIRoQJUImCzYt5rMwxUMpGAric3jhiGQfTm1Sj2Mm4JRxWgi7E53JBUl49oANhyJtoulfGYO5oJ8+e4h63tplVIoTg9Ko8vu
x-ms-office365-filtering-correlation-id: af8870fc-4ed3-4961-1f44-08d61c4aa944
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759A5AB7064EAF7408861EEFB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AA12hTIFmmMcKhVD7X8s8TN9T/UDMIYOJe4ACWkHfrz6c8xeozZDOu19ildMukbaRaC6lAC+BxdswbNW9/rpkKMONPdjbRxyL6b8ZAkauI665hCozz9giQ55dtIy4BAlhX7Gcb+KKSSFxQud5sagBRkPrhcGR5hDIl85ZfAPb9MU79jbGaPJ6+BzZQSX894QbxhHJ+J9wmgmmcI8CU/pPoUqUu4+D3ekQ8GbcFbyz+JSaBYc3nvYchNUlN33yTfea6/1pChjhLkMp6M1jiucnjv2uf0Lt+k8XadV8f38pb/KJFnm8pvp09TAhDdwnR2w3Cy+BgopLUut88lE8nBuQ3V3398T/T+cqbS62mv+ASU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8870fc-4ed3-4961-1f44-08d61c4aa944
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:05.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index f150a8bd94dc..70f1a80d4e39 100644
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
