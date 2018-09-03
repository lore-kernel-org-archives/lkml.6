Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7A3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2B32077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VFHeThkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2B32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeICNKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:10:37 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:10688
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbeICNKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGcjVWAW169y203IFjaffzMZnhH4XE7iTCUStUTGj/U=;
 b=VFHeThkISmMITHMabpnLQLgCiFryTiARlYHRpcuuDeBNKQxh5IF5Z6VmI+LjUK0LOr2aeeVHogXz1LoxEkbmGKD5nJq8co9rOxrsYGsacBbYfk0PDHqo8IkH2RX2NFbVx1X3hYsodzQnark8waWjbTQpr1tePOsTupcmyw1HIJw=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3496.eurprd04.prod.outlook.com (52.133.19.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 3 Sep 2018 08:51:24 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::ccea:795:beb3:5637]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::ccea:795:beb3:5637%2]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 08:51:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: imx: add pinctrl sleep/default mode
 switch for suspend
Thread-Topic: [PATCH 2/2] tty: serial: imx: add pinctrl sleep/default mode
 switch for suspend
Thread-Index: AQHUL8kvLZA1hsakIU+YlqeE8Nv2ZKTeZvCg
Date:   Mon, 3 Sep 2018 08:51:23 +0000
Message-ID: <AM6PR0402MB3911C74F62B845CF83644D6DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
 <1533809169-24133-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1533809169-24133-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3496;6:4XCeUis5rqH3WF5VrlhIyZ4RY5QRCL9XPUsX8NPbLsz+9ASe09APYlIfjWjw0goCIeNA4bCBJrxc+aFIStshwSWTWoGqssiDNEbzE8BpPxuF2lHhc6gL6qO4bsk71QNfFVzqPhrRM3yY1DfNEh+63Sa03SedVWgAf8+hqFWbDsqCSckojM4m150Ag6yxJV7g/K3wQlh04p/0CzKFLvGShqSjJetBeh5MxDL+aljy9HrLUBKzctMKoltFj6fN1vzzELYo2Kzp1n+2zCIhg+qqUrpTrnbuLQbErim4KbHGQ+BFn36CMP0ilHOsgFQZqyLzBF5f3hl3pkyR+X8gCEA93b6u6X0TwcsmiFFINjQLTaEgv2EfyVrDJBUsDn2ZRMecEII0/Xswq3nLgZVEeCloBR5TH3gSdBSRz63oasd3EnNNa6BToMm+5SbCFKONWO3eCFc3oa/qjNPnsqz9UMfIHg==;5:Ie/nZUtrsWLWguOwPbhyv7sOu9u91gOGmSYXnPRIE4GQlDSDfL0DF0X55cvgw2jzuxAc6VWFRhvxr07SBTc0fF1DXkS8imee/dQ7rZXe44IZUjXndsVV8ZPIE1VfxcsM6h49A3PAyAe3bOoHoEygid2bN31MICt21/LQjP6HQX8=;7:aXPo3I5EjHS1/suPYDTZwBCaHF2nY9pY2JNcVkYXqndgDctoDod06qkOQ27rydLGyi35NWckJpLnA6yGB2j3wiqebUOYoB1zC9ol3PfJvk4i5mSYws/azSF1POVIbZ4enxktWoESJ5zi9rqVPeYq4c9FMGJHzMYtMPYbi6kdvxVLeS1MuRuMeZ+PUm46y/aJbZTfXx/gc2qRz04Gdu3ViKUhgxIlvn6XQG3iAnFoCKQs+PeaUoRyr4j9U63SQ19O
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9828d042-e23b-4038-0794-08d6117a6d8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3496;
x-ms-traffictypediagnostic: AM6PR0402MB3496:
x-microsoft-antispam-prvs: <AM6PR0402MB3496AF419B155DAE183371D5F50C0@AM6PR0402MB3496.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:AM6PR0402MB3496;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3496;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(13464003)(189003)(8676002)(15650500001)(74316002)(97736004)(14444005)(6116002)(76176011)(14454004)(5250100002)(3846002)(256004)(7696005)(99286004)(486006)(66066001)(5660300001)(305945005)(44832011)(7736002)(2906002)(86362001)(2900100001)(2201001)(68736007)(53936002)(105586002)(11346002)(106356001)(26005)(229853002)(33656002)(186003)(446003)(81156014)(476003)(110136005)(6506007)(53546011)(8936002)(4326008)(316002)(102836004)(2501003)(81166006)(6246003)(478600001)(6436002)(25786009)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3496;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sWEfb8FCmZ6OYzu0iAYcJtrChpcOpRFEA8VuFkIW22oG9hl4FnbQMiq6pJ7G9Y0RwG6bblenIendVz1kRxBPZYeJWrpREfhGtO6q25ZUqEKOs55tzrziuLmiHHceBFHqPcLb6LYydfaP6pg/NgRZd34TO/V3YtvfQ4+v0cOjb3OQWyj35injXUSrsU6UhoVhuMfLsBncgks2nPtOnQaadY75ptdRbFJF3AiPU0lh9nHVAIcQO8xfXJ0FdKT55hHr98IooD/RthZV+SRcZm1t/pVNaggTcvcFq374c/Z52rQoQTl5oVfTlt6GE6QXYxIfi+SIra3lGRlDROP5iIj/KT2FQ4yv3cvGuLiQY5sIYbw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9828d042-e23b-4038-0794-08d6117a6d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 08:51:23.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Thursday, August 9, 2018 6:06 PM
> To: gregkh@linuxfoundation.org; jslaby@suse.com;
> linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH 2/2] tty: serial: imx: add pinctrl sleep/default mode swi=
tch for
> suspend
>=20
> On some i.MX SoCs' low power mode, UART iomux settings may be lost, need
> to add pinctrl sleep/default mode switch during suspend/resume to make su=
re
> UART iomux settings are correct after resume.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> a09ccef..c280d43 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -24,6 +24,7 @@
>  #include <linux/serial.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/rational.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> @@ -2447,6 +2448,8 @@ static int imx_uart_suspend_noirq(struct device
> *dev)
>=20
>  	clk_disable(sport->clk_ipg);
>=20
> +	pinctrl_pm_select_sleep_state(dev);
> +
>  	return 0;
>  }
>=20
> @@ -2455,6 +2458,8 @@ static int imx_uart_resume_noirq(struct device
> *dev)
>  	struct imx_port *sport =3D dev_get_drvdata(dev);
>  	int ret;
>=20
> +	pinctrl_pm_select_default_state(dev);
> +
>  	ret =3D clk_enable(sport->clk_ipg);
>  	if (ret)
>  		return ret;
> --
> 2.7.4

