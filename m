Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6724DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCA320870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="PDhLW6It"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCA320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeLMEsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:48:16 -0500
Received: from mail-eopbgr1410097.outbound.protection.outlook.com ([40.107.141.97]:17096
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728076AbeLMEsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M7B1EZFzL8FhCeQO8ZcHrCRTtjhQwQr6SfJ2sakiCM=;
 b=PDhLW6ItKemvT9msDOAFRDujemnGl0Rmg8pqCetpSJ+V33URR8iLQEgBb0xPo/0M5uJXgINsCYUe6H0hfUCG8NqbgchMMEyZpPx2yjqykThb/pYqCf1GojZxEEJocYIN9s+Fx+fjkBaADXTGNZXv/gJR1EeDFKbuxkE30CxR4vs=
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com (52.134.238.13) by
 OSAPR01MB4098.jpnprd01.prod.outlook.com (20.178.128.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 04:48:07 +0000
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7]) by OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 04:48:07 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 4.19 44/73] net: phy: Fix not to call phy_resume()
 if PHY is not attached
Thread-Topic: [PATCH AUTOSEL 4.19 44/73] net: phy: Fix not to call
 phy_resume() if PHY is not attached
Thread-Index: AQHUkpyH3yB+48+oQE6bwchuEEBeOqV8GIBw
Date:   Thu, 13 Dec 2018 04:48:07 +0000
Message-ID: <OSAPR01MB229047CACB004208BC5F48ACD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
References: <20181213042838.75160-1-sashal@kernel.org>
 <20181213042838.75160-44-sashal@kernel.org>
In-Reply-To: <20181213042838.75160-44-sashal@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSAPR01MB4098;20:cODLfkvnrjjFNvOf8J2O+2if3nVnzqw9DMT92ymeliq7H18G5ikPv4zmeEmvhxb9Q0qe+kJQtExlWQg4XkEltBm9lE929v2EHXjijcbAE2/0MppehJNzwlvKnKBFMOILCyzBGPNvREd4O4nGvUiD3gkElbr39KcZPGI3hRtd7hE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a9334b1-b27f-415f-9fb3-08d660b62d43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSAPR01MB4098;
x-ms-traffictypediagnostic: OSAPR01MB4098:
x-microsoft-antispam-prvs: <OSAPR01MB4098C3AC4A6BAFF9F12E6B11D8A00@OSAPR01MB4098.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:OSAPR01MB4098;BCL:0;PCL:0;RULEID:;SRVR:OSAPR01MB4098;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(14454004)(9686003)(68736007)(45080400002)(105586002)(2501003)(8936002)(106356001)(81156014)(81166006)(7736002)(2906002)(97736004)(8676002)(305945005)(53936002)(6306002)(33656002)(478600001)(5660300001)(25786009)(6246003)(4326008)(55016002)(966005)(74316002)(99286004)(110136005)(6506007)(5024004)(6436002)(217873002)(3846002)(486006)(6116002)(86362001)(76176011)(446003)(66066001)(256004)(14444005)(26005)(11346002)(102836004)(7696005)(575784001)(186003)(71200400001)(71190400001)(229853002)(2201001)(54906003)(316002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB4098;H:OSAPR01MB2290.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Zn+mEqrOKShLmFh/bTuzb15gzjXohY+zq8vncbOjdwCnXvOkuU7OU/Lyi4vKChzrMbSRqlcnNxm1zM9GFgNSqs2f6zNh6OYal0BlWjTYbZrDLtmq0ciBDsFJAQckw0bvGLjSiM3nXY5ZCk8VtXpnpYwEpVzTuhtL3yp+yiIDgGsA5CUNZ7drUjYT2BIRJVrYmrulEoJm0eI58txIcMMmTDoHer+SCoJM4tn/q9lD3Q/9J6ljfU3dZmvL0iTkQ7QINrWJF0pmKCe4XQfzq5NldEdzA3naE+iB8Cmhp3VkWV2Pqss+xmhhsjsuzVe6qL7V
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9334b1-b27f-415f-9fb3-08d660b62d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 04:48:07.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Sasha Levin, Sent: Thursday, December 13, 2018 1:28 PM
>=20
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> [ Upstream commit ef1b5bf506b1f0ee3edc98533e1f3ecb105eb46a ]

This upstream commit is also reverted on mainline
as I mentioned other email thread[1]

[1]
https://lore.kernel.org/lkml/OSAPR01MB2290FE36AF50B2F29170383DD8A00@OSAPR01=
MB2290.jpnprd01.prod.outlook.com/T/#u

Best regards,
Yoshihiro Shimoda

> This patch fixes an issue that mdio_bus_phy_resume() doesn't call
> phy_resume() if the PHY is not attached.
>=20
> Fixes: 803dd9c77ac3 ("net: phy: avoid suspending twice a PHY")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/phy/phy_device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 20d1be2b070b..16a94f5b8073 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -76,7 +76,7 @@ static LIST_HEAD(phy_fixup_list);
>  static DEFINE_MUTEX(phy_fixup_lock);
>=20
>  #ifdef CONFIG_PM
> -static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
> +static bool mdio_bus_phy_may_suspend(struct phy_device *phydev, bool sus=
pend)
>  {
>  	struct device_driver *drv =3D phydev->mdio.dev.driver;
>  	struct phy_driver *phydrv =3D to_phy_driver(drv);
> @@ -88,10 +88,11 @@ static bool mdio_bus_phy_may_suspend(struct phy_devic=
e *phydev)
>  	/* PHY not attached? May suspend if the PHY has not already been
>  	 * suspended as part of a prior call to phy_disconnect() ->
>  	 * phy_detach() -> phy_suspend() because the parent netdev might be the
> -	 * MDIO bus driver and clock gated at this point.
> +	 * MDIO bus driver and clock gated at this point. Also may resume if
> +	 * PHY is not attached.
>  	 */
>  	if (!netdev)
> -		return !phydev->suspended;
> +		return suspend ? !phydev->suspended : phydev->suspended;
>=20
>  	if (netdev->wol_enabled)
>  		return false;
> @@ -126,7 +127,7 @@ static int mdio_bus_phy_suspend(struct device *dev)
>  	if (phydev->attached_dev && phydev->adjust_link)
>  		phy_stop_machine(phydev);
>=20
> -	if (!mdio_bus_phy_may_suspend(phydev))
> +	if (!mdio_bus_phy_may_suspend(phydev, true))
>  		return 0;
>=20
>  	return phy_suspend(phydev);
> @@ -137,7 +138,7 @@ static int mdio_bus_phy_resume(struct device *dev)
>  	struct phy_device *phydev =3D to_phy_device(dev);
>  	int ret;
>=20
> -	if (!mdio_bus_phy_may_suspend(phydev))
> +	if (!mdio_bus_phy_may_suspend(phydev, false))
>  		goto no_resume;
>=20
>  	ret =3D phy_resume(phydev);
> --
> 2.19.1

