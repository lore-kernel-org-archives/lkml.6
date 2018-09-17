Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5161ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AB0208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hiz9Zj/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AB0208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeIQI1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:25 -0400
Received: from mail-eopbgr710103.outbound.protection.outlook.com ([40.107.71.103]:50082
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729324AbeIQI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rAfNe/jx9m3EVacZKsC4JoNYWV5W8VbBD5vhVNBPvQ=;
 b=hiz9Zj/e36GqobivL4oI2R7/YFLh6RBNiDAZSt4Ha8Gv4H+Da7/PBbzXY9gRsi9KwGelUxGMULCWWolWu44VnQKRxnt9Ist7ueWb692hlr3ToslV0NaMtLUHwdsLThJWATjQO6gTzRa/325Usj+NAUTVtN1L7n8EXc4nJeZ2l5M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 087/136] drm/sun4i: Enable DW HDMI PHY clock
Thread-Topic: [PATCH AUTOSEL 4.18 087/136] drm/sun4i: Enable DW HDMI PHY clock
Thread-Index: AQHUTjKtczTyY+T4gUCIIIroGeiG0w==
Date:   Mon, 17 Sep 2018 03:01:06 +0000
Message-ID: <20180917030006.245495-87-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:KwuM4SVkruV5ujXiu1Jl7l4pYJInG85bfywjV+EV8hAV7F/WBATAEgP3TkpjprpRtuDMiau+LhzJJYy+FkVteVGRtgvmvTbtMUynBrwz0ZDy5x+Ly1XjL6esGI9kK5dqJO+uK/adAQKLjmb+Sl1yTaD3uruPOLK5RLxJGCm5yoW1b2eYgqeOMuVGgAMEQTJThdzjWyuxo2rj+Fi9PPiDsjiH356hLoNFOVysZKEVBw8CNJYRFhRm7gut3nmQBIumjpYVBAobOifcYWME1RX0IWY94aRbp1FdsTHVXhnkK9K8uEEPcASr66LnGgoYhkkRuHSHvgUcPTYoIJp54WsWatUce1RgdJViqEHYCJp5PWXLsBYOWbRQ+qcRZhMo5gVzsD8Qc2m0Oyk3+NKeCJdURPIydIQKLNoUUyULoO/CeNMIZ9HgaeXxxqRhML1JItZwRwhv8PqT+Kj0b1rCR0pPCA==;5:Qf1vY3AXGeveyfaXuMRhFKpy4lR+E9hC9YADtaYkEfbgPTHyG4rlFuajRIPubMjwaYcIVSv6VGJ8qgSWi05gmdW4OiOekM9FRkblaYYLpBiu/Hdl64FQDvMfZuD/hi1QWkLOgDYbLgSASUeD7zTDUNZETsn2N/yIjtJg9lURjbg=;7:3VhNydO0z9yNatYmfZi7esZQ79of0s9Rb0ooXhJMX5B94kzwN1LX0rOZQ3m0B+VryHImjme9Ib57gyye9JvHZkVy+ee3vS9w8RPazI1JRYjs9yyXGHAspJvWM9ej8cn94VEXy+XLapLTbSmXV2X/6BnTdgGoyQhaTMFXtCBNC+sa0RT8yX2dAeWH3Q+BQDOvd7eLf4abfNIVQ/aO4Gd1cApt48kp8XMXTwPX+15/QDcpwcwLuxA98IUHvY8ueRPX
x-ms-office365-filtering-correlation-id: dc66efa5-cf5b-4825-a413-08d61c49f164
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790599C12FE5FAC5E2911A8FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(6306002)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(966005)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ARj/1QyRm8C4Zdg5+pBszXZK6qE6j9WcvkwCpYXd/nRyCIYQ06OzFzaglzx3l2y4IxH8tlOhKShPZDPG6xzFYwXMNNgZ4DWNT6q9hehpkjHtYTBVyXWO2MYmPbyIcyFltXhyhmA1p8HF0l4PUEyk/4tCaZHOYrRU82sgCFa2KJrc1wXjh7QLyG/aoUdp+cJG0WQ+0anW5xAzhwW1Jot17mgExpjSybfXMrJs5QUDIvny1Z8O8049Dl+yA0r+UW71GX7nrGYewXFo2NtCu4CFPHmGxRA9pQZPbBCRnB5SHILDGmmH9pVBtLj+WFXUzTajXYdwsRwB3uRExU1gvrnRag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc66efa5-cf5b-4825-a413-08d61c49f164
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:06.9011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit 09773c532d30187f86a142901c27c93e629ce6ba ]

Current DW HDMI PHY code never prepares and enables PHY clock after it is
created. It's just used as it is. This may work in some cases, but it's
clearly wrong. Fix it by adding proper calls to enable/disable PHY
clock.

Fixes: 4f86e81748fe ("drm/sun4i: Add support for H3 HDMI PHY variant")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180625120304.7543-17-=
jernej.skrabec@siol.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i=
/sun8i_hdmi_phy.c
index 5a52fc489a9d..966688f04741 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -477,13 +477,15 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, =
struct device_node *node)
 			dev_err(dev, "Couldn't create the PHY clock\n");
 			goto err_put_clk_pll0;
 		}
+
+		clk_prepare_enable(phy->clk_phy);
 	}
=20
 	phy->rst_phy =3D of_reset_control_get_shared(node, "phy");
 	if (IS_ERR(phy->rst_phy)) {
 		dev_err(dev, "Could not get phy reset control\n");
 		ret =3D PTR_ERR(phy->rst_phy);
-		goto err_put_clk_pll0;
+		goto err_disable_clk_phy;
 	}
=20
 	ret =3D reset_control_deassert(phy->rst_phy);
@@ -514,6 +516,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, st=
ruct device_node *node)
 	reset_control_assert(phy->rst_phy);
 err_put_rst_phy:
 	reset_control_put(phy->rst_phy);
+err_disable_clk_phy:
+	clk_disable_unprepare(phy->clk_phy);
 err_put_clk_pll0:
 	if (phy->variant->has_phy_clk)
 		clk_put(phy->clk_pll0);
@@ -531,6 +535,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
=20
 	clk_disable_unprepare(phy->clk_mod);
 	clk_disable_unprepare(phy->clk_bus);
+	clk_disable_unprepare(phy->clk_phy);
=20
 	reset_control_assert(phy->rst_phy);
=20
--=20
2.17.1
