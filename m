Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576CAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E620F25490
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YTuOkxZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E620F25490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeFYFyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:54:06 -0400
Received: from mail-he1eur01on0043.outbound.protection.outlook.com ([104.47.0.43]:21225
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751984AbeFYFyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT4Rr7uB79H8hhlcXBud13f262PmzTOmhTS3XgaduI0=;
 b=YTuOkxZgHt6Zhi7yfEGa5MV/SZQfPP5HGPjoA5lm5HAZJGifQ9ywxcr6TrlSIn7MHAr/aZ6kjNdCUtLYrDTfDlirzgtYR3Zc8JauoDlT65ZF8+xPbKsc2OMq117UUzGg0INmcU2kzcJVgJaC69R5ZuuEK7qGro2Vm0tQUXrKRSc=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1250.eurprd04.prod.outlook.com (10.163.6.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Mon, 25 Jun 2018 05:53:59 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%6]) with mapi id 15.20.0884.023; Mon, 25 Jun 2018
 05:53:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Robin Gong <yibin.gong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Topic: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Index: AQHUDD3lRelNZaT6s0KCSbdeyjhmZKRweO5w
Date:   Mon, 25 Jun 2018 05:53:59 +0000
Message-ID: <AM3PR04MB13150F33BC062890B4E87477F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1250;7:yPcE6D3Dx/d5lnqjS8t84c7gL4PoDOh+59ZLSBkSIRxWTGraVogK39VkHf1hxsxD5c0zqAMWfdoN7trk1LHSxvY2a6YY990I8XNVr8HjSXPDJF4B92I+ZtqHNPt22+9UWrfhBJnFLMxR2353Oc0U6d33EYlTNPYcf+DOBJMO1+f9Oq501ECrOwl6pl5H+z+oGpNRIGO3XZUi8+3bYu8fPRLs+UNYl9/pmqcWTZ75/+Gpj5UAjfjAuoAW8r8WwzLc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5db5e635-3bf2-4d16-3f34-08d5da600c04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1250;
x-ms-traffictypediagnostic: AM3PR04MB1250:
x-microsoft-antispam-prvs: <AM3PR04MB125002E4622FC71EC1B65477F54A0@AM3PR04MB1250.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1250;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1250;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(396003)(366004)(39860400002)(189003)(199004)(13464003)(44832011)(6246003)(25786009)(33656002)(76176011)(476003)(9686003)(7696005)(6436002)(97736004)(229853002)(486006)(99286004)(446003)(11346002)(2906002)(55016002)(53936002)(4326008)(2900100001)(8936002)(66066001)(305945005)(74316002)(81166006)(81156014)(6506007)(7736002)(59450400001)(106356001)(3280700002)(8676002)(54906003)(53546011)(110136005)(102836004)(316002)(105586002)(3660700001)(478600001)(2201001)(5660300001)(5250100002)(6116002)(14454004)(2501003)(26005)(68736007)(86362001)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1250;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iOSk9+52tRZf7cujLhGZ8KAT14abZFQkImf3Juo4rIzGBmZVmMqociwlKNAs8DNYH7BLZ3D73HGyoG4E8SP+clldt5PtVusDGOmrbWHMzjWnwNgPX4ECdX1NNN/VFRNOtnXW+O1O2dviaJSkkNl6sghSCIbRkmQFSjddyJuvwlTdtG253DjPbyi4mrLtZMQaiPuBylK69CdQxmLAwUFhJ1HflzzL5rZOb0uTbHj2HrtzBN9W1JJMVPUAYy1dvoMMRq2Y8QYT4tjaIUgeivN/+tdx53NBkIGXUwU674uRGuBXVO5ge3ADHgP3mCH6a2hkyGjJNQ3AwbURbP7LDdhPuH8XDiCbwuldwNbtyVj5CLI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db5e635-3bf2-4d16-3f34-08d5da600c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 05:53:59.5019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Anson Huang <anson.huang@nxp.com>

I also saw such issue on i.MX6SLL evk board, and also sent out patch for i.=
MX6SLL.

Anson Huang
Best Regards!


> -----Original Message-----
> From: Robin Gong
> Sent: Monday, June 25, 2018 8:34 PM
> To: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> Anson Huang <anson.huang@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
>=20
> SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should be kept alw=
ays on.
> But it's disabled after switch disabled interface implemented in pfuze dr=
iver
> 'commit 5fe156f1cab4
> ("regulator: pfuze100: add enable/disable for switch")'.Thus, it breaks k=
ernel
> bootup. Add 'regulator-always-on' for SW4.
>=20
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts
> b/arch/arm/boot/dts/imx6sl-evk.dts
> index 37e792f..798df66 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -199,6 +199,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
>  			};
>=20
>  			swbst_reg: swbst {
> --
> 2.7.4

