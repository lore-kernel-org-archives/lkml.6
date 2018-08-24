Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BFBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36D720837
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VHtmi9nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36D720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeHXKnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:43:37 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:48144
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbeHXKng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTIhTvds1mWZmxjJBtcF13TzTuTeOhZ0d8Ik5mw9ptc=;
 b=VHtmi9ncXDjZS19FvXZXuX5MUYZ8kuOTLj9oXWG9ub5ULl9P53Aw0BKfAa0LQqfXJAVPYPTWwj70oPi7XEGA3wdIuOgoSRBG8ufvqvPjb2OCyjnnYUplitK9yRbtutyx4ZINfmANtM2xfPWxui3Y2HpNUxZdHQ54eMmkw8nM/GU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Fri, 24 Aug 2018 07:10:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c%3]) with mapi id 15.20.1059.023; Fri, 24 Aug 2018
 07:10:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>, Nitin Garg <nitin.garg@nxp.com>
Subject: RE: [PATCH] thermal: of-thermal: disable passive polling when thermal
 zone is disabled
Thread-Topic: [PATCH] thermal: of-thermal: disable passive polling when
 thermal zone is disabled
Thread-Index: AQHUKCbd2YdEc1DEhUi4WLPN+3wVwKTOopyw
Date:   Fri, 24 Aug 2018 07:10:13 +0000
Message-ID: <DB3PR0402MB39168BB2C854A55401D4C648F5360@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1532969809-8300-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1532969809-8300-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3707;6:nxCdqUHoFl9fJ14QZ6TMRX9PPb4K3Pmpou878whWCnvvV/96abOSs3cUS9wKZ99eLO7eGmgZO3h0owI4h51BonpJg1QfZOHZqrHmxNZsxt7lcQnxbM08cEQ6i96XtDLV+UTJUQ48IQ/wihwdRQO6BLXUfUIVrlzQyH/il39rejDOysNfQuKlBTTqK7kXAYBoP8vzFawzdCat+XDLsgZx9xzoIgw+yl7OaQ05KnWF6uWj47MNXHMt4SsQp9v9vAugAYYIP6nN8dh4nG9uZ7NAOQD2/z3aOKG5KYwG7LgXIjqiHqdloCI7gHU5D0aywaeIEHpU7ct6HvU+gYd9+BvAbOR27Ccq63cHHmSSfmJJ6D4lMilXgmeLWFU6P2AWOvoeR2YEOTtuZUUjsx9RyWGia6e8JIsjt5uwSIehypEZ2BgM7trcIBHQo5VVOkn5ejRg9V8iXoVDIBtcgMRvIT4uuw==;5:ejJyAV142itBTXx1OtOdINGxijkTbmEj9HjxWpmapS1skyfD3E0Nzh8hCNYqBp5REHL89lYzv00nZIaBtkQS7HFn+cksS1G/wF6qFuz8fpXQDUDWjbrsSJVIoxGKruWZd1e6s6zfpAypETOgvX2rG7pdyYMLamfNw6orkleGfEI=;7:ncYB9VvJ9rx22E1EyX41oY/57C7P4CiZ5vv4xiPFuRmpUGrKREaykvSW3z1ZF9DxAESP2keN4jkdx1JrvZeIwgNYV4yMm00j8dcDGLcRNFe2lbCOb0MM5tZ9/5dbWj4xy8kCNpiRqbteGqg2T3uiH4aKGDIQuQ4Re+leBkWGlgPRxs9zhAOO3d5s87gm5MVnBCPqHxgph8cvkqFIe6zCm3uS9YsJQslFGjMHw8TmaZ92FWG2H7Vc/D66xhP7weah
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46317c8f-3fdd-43bf-6e18-08d60990a316
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-antispam-prvs: <DB3PR0402MB37079C330DEF0256359F5FFFF5360@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB3PR0402MB3707;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3707;
x-forefront-prvs: 07749F8C42
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(13464003)(4326008)(54906003)(316002)(106356001)(26005)(186003)(110136005)(39060400002)(478600001)(97736004)(53936002)(25786009)(6246003)(8676002)(55016002)(5660300001)(99286004)(7696005)(7736002)(305945005)(229853002)(76176011)(6436002)(11346002)(446003)(86362001)(476003)(486006)(14444005)(53546011)(2201001)(102836004)(256004)(74316002)(81166006)(6116002)(3846002)(5250100002)(33656002)(81156014)(6506007)(2900100001)(44832011)(8936002)(68736007)(105586002)(2501003)(14454004)(2906002)(9686003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H9HrW+yaOnQlbvDwJTNhrZuSl6icINc0bAe6KnOak2iNg8Lxb+7bNuYYkWrsAVTX+/KArnYnZj56pUy3mf8QNHuvk8FG2pT+rndm68j3+erO9OE/AhNDGBYjBeHr04os1J6f3754pAOkiT6ZreSyZ01BTeTWSOEamudzSiAnfVjFuyaBPmtqiGHUdoOKpUpDqCLi0jw97pCXLWZV8ep/Be4BXJ5cxB0hjGk8Jco/dwYnMkTg1HTATh1OLbMWkhyWqcPFp7q5V45HRabWbjOu1ve139aiUZp0/JBEUSvTm7+Gd0Wjq9zHKus8D11lx5hhXbN0MNFTnlGUsosQw+FAngCHFeOZ7DDfWYfanEhp4yU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46317c8f-3fdd-43bf-6e18-08d60990a316
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 07:10:13.5060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Tuesday, July 31, 2018 12:57 AM
> To: rui.zhang@intel.com; edubezval@gmail.com; linux-pm@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>; Nitin Garg <nitin.garg@nxp.com>
> Subject: [PATCH] thermal: of-thermal: disable passive polling when therma=
l
> zone is disabled
>=20
> When thermal zone is in passive mode, disabling its mode from sysfs is NO=
T
> taking effect at all, it is still polling the temperature of the disabled=
 thermal
> zone and handling all thermal trips, it makes user confused. The disablin=
g
> operation should disable the thermal zone behavior completely, for both a=
ctive
> and passive mode, this patch clears the passive_delay when thermal zone i=
s
> disabled and restores it when it is enabled.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/of-thermal.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c =
index
> 977a830..4f28165 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -260,10 +260,13 @@ static int of_thermal_set_mode(struct
> thermal_zone_device *tz,
>=20
>  	mutex_lock(&tz->lock);
>=20
> -	if (mode =3D=3D THERMAL_DEVICE_ENABLED)
> +	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
>  		tz->polling_delay =3D data->polling_delay;
> -	else
> +		tz->passive_delay =3D data->passive_delay;
> +	} else {
>  		tz->polling_delay =3D 0;
> +		tz->passive_delay =3D 0;
> +	}
>=20
>  	mutex_unlock(&tz->lock);
>=20
> --
> 2.7.4

