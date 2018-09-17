Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D69ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6203B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mcC6Qdmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6203B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeIQI1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:49 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729348AbeIQI10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEFuztxJHxawmOtPd4o9jEjBDPmF88vJtdP8KFyUTOo=;
 b=mcC6QdmdOLutm7NBA+t6lg4ulEsne1BgenPRjSrGQjFd1AuX7i+ZS6N4hWiT2F0hyzy1vs0UP/ajdxBvZ/tu+dwQ42b2iCOrBLiNjTUkPbT9NLDhMbX+NTu7MamHLx/4pSVKSeJVt+SMb0SnDLn6dpK7d0HyGAImZ6XyXojjifs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 079/136] arm64: dts: renesas: salvator-common:
 Fix adv7482 decimal unit addresses
Thread-Topic: [PATCH AUTOSEL 4.18 079/136] arm64: dts: renesas:
 salvator-common: Fix adv7482 decimal unit addresses
Thread-Index: AQHUTjKq8q52FhqGYk+Xtusjaf25zQ==
Date:   Mon, 17 Sep 2018 03:01:01 +0000
Message-ID: <20180917030006.245495-79-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:ymRu4YWz0vReUKlx9kw99U9H4J92iVkTAoCtmlgKnoSEGxusIZFMLZiAm21j/eZ9dV7HFJpC9RIch2rv74oD5UP9UG5gV0kVlIs74OdhkuQcl6WIsEUXHrhiw8fTWBKdaASC/kTdlX/RUNj4y47UasW4dRrW98semZI7x7uA6RwtL3S2tCUhk9GRrdEBOMM2q01Iiu5/4/PcZvEelwmU/EgsMNCFrnYj+YzAedxw/KMCdkm2Uipu2w7YbOXexPh5Cnr+7FWO3VbnTs1IDA/FE7PBb2cnF5/qCS4+0Ft5qwJOzazJ1xuM7FlupJCf6eiQecg3EsRbjFLzxTVgATZoJtnirOkdw177V8qBSeuu6Wn5kj3ILjecWkX0CEF8rpH3W+QxvM2vwWC1v+zOdxWN+7O/WxXHQNrA/fFOdejgxqe1kubJ+oWgKX6QUXBP2szTeIutwXuqoiQADBQgv6sZvQ==;5:zP2mg/BuqjhIE/yv9xlfHxfNl52rSH0Ce4m/CqJaXuS/pmTcqi8JkyOIyDYzicz+1LaNgN/HZ8kINl9IcRkPt8kx/x++/5Sp5bhTx3FT6TSujfrivSNjB/H31GlCTEEh9Z6pjIYazr7X9boaKE33V9+m2qeDFxBPAsNJZvDpyh4=;7:OR9MFxJDmdugvHXHLc/d2FVYJoGg5wnk2TSYasO2OiAqhntdCvvsMnlWgWlpsUdwzu5MosnxKARAEhP8nmfbyMBzJogG3Mh6HC2w+Sv6ckwK3tLP8Z7FDREqIw6BjWY+jlLtf/jR3u8yVpe5/6Inhm3N+4l8c8iRKwGF6Ek5skfstOaGZXwLcI3PYRx5gqQUvIQ0kR9sWtUJPu5cwIRXz2VRFD/xBQn0L6Ky7CIvKs7uxe3u9pBefPdwYmgrMKvc
x-ms-office365-filtering-correlation-id: 61a8ad0a-1fe7-4c18-1d49-08d61c49ef96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502BD26C71DE75EAB0C5358FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(6666003)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sw+JOtlwhJyxSw5eQiYpRzwq3DD4ghKLHkHEaNnimytkEVj0bCCyi+No58c8anZ0RCm20c/Nl80xsRvv5kCmqirETxWJo31miLZss0kpiMQN6MuZWU+/y0ihaQhh+TiFh+PpYjJWar2jJV9giPMO2jtS78e3pvaJ4fqWJLyFfPcWfXE26WRj0+osUFEiHUI192ioRsMURYsDdXYIwFqc1Mgcaujjx9Zg7Mnq9y9oMtNMKvLYL4jt/HEr3LzbhRkd67WeCjrHdX2/AEKh+5G7Ew6lQXphnjdtTJMazObBzDcAn4RHEqlp5S01ztZZq35bTMahsxTDmCwovWA0VdvLBWqZ4TT8qubaDufrtXjS5VY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a8ad0a-1fe7-4c18-1d49-08d61c49ef96
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:01.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit c5a884838ce34681200b5a45b2330177036affd0 ]

With recent dtc and W=3D1:

    ...salvator-x.dtb: Warning (graph_port): /soc/i2c@e66d8000/video-receiv=
er@70/port@10: graph node unit address error, expected "a"
    ...salvator-x.dtb: Warning (graph_port): /soc/i2c@e66d8000/video-receiv=
er@70/port@11: graph node unit address error, expected "b"

Unit addresses are always hexadecimal (without prefix), while the bases
of reg property values depend on their prefixes.

Fixes: 908001d778eba06e ("arm64: dts: renesas: salvator-common: Add ADV7482=
 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/=
boot/dts/renesas/salvator-common.dtsi
index 9256fbaaab7f..5853f5177b4b 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -440,7 +440,7 @@
 			};
 		};
=20
-		port@10 {
+		port@a {
 			reg =3D <10>;
=20
 			adv7482_txa: endpoint {
@@ -450,7 +450,7 @@
 			};
 		};
=20
-		port@11 {
+		port@b {
 			reg =3D <11>;
=20
 			adv7482_txb: endpoint {
--=20
2.17.1
