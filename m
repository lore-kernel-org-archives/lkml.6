Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA85C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF5020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF5020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeLMEos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:44:48 -0500
Received: from mail-eopbgr1400131.outbound.protection.outlook.com ([40.107.140.131]:33349
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727104AbeLMEop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lAfwYRtyC/mkHnEYZTfHwhkKWi+dMwpY9q1mlHC+90=;
 b=O9iG0l/WcSd1gRWvryxpL/1qoa2WCqC4jzwTiFAJI/YfBX3PMR4EVOlU0QceS5igUxv5dcELHLj5LmehfrHt4CvlEf21on1jLcbLqG7zagK8qolaXusnYScmrqMqixqi9KaIY47/BFuZmhegc9/9e3X6DRBm+GpAbX2fLEMVSC8=
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com (52.134.238.13) by
 OSAPR01MB2195.jpnprd01.prod.outlook.com (52.134.237.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 04:44:41 +0000
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7]) by OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 04:44:41 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 4.19 45/73] net: phy: micrel: add toggling phy
 reset if PHY is not attached
Thread-Topic: [PATCH AUTOSEL 4.19 45/73] net: phy: micrel: add toggling phy
 reset if PHY is not attached
Thread-Index: AQHUkpyG2HNJQGrK8kudwY3/T/elaKV8FwRw
Date:   Thu, 13 Dec 2018 04:44:41 +0000
Message-ID: <OSAPR01MB2290FE36AF50B2F29170383DD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
References: <20181213042838.75160-1-sashal@kernel.org>
 <20181213042838.75160-45-sashal@kernel.org>
In-Reply-To: <20181213042838.75160-45-sashal@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSAPR01MB2195;20:Rijs+53tlI0E/9DF2vGWfQqM9hPLAD3j/veU6SUaKLZUc8kFVx9uMHc+iCIojEXF9beYszyyw80Q0DPza+vMrfB0WH0QvuICX6KpQobiVHnNcbl8uBsJMi4hp8Jj3XqnwLh4wtfF0tPl2obHtdcHfifhdRJof+o3lBCFksKB7fY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b9ecee6c-2325-48ac-0723-08d660b5b25a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSAPR01MB2195;
x-ms-traffictypediagnostic: OSAPR01MB2195:
x-microsoft-antispam-prvs: <OSAPR01MB2195C3137C60BCED1C8D3EEED8A00@OSAPR01MB2195.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSAPR01MB2195;BCL:0;PCL:0;RULEID:;SRVR:OSAPR01MB2195;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(76176011)(105586002)(74316002)(7696005)(5660300001)(7736002)(186003)(53936002)(486006)(55016002)(97736004)(446003)(476003)(11346002)(305945005)(14444005)(8676002)(256004)(81156014)(81166006)(5024004)(6506007)(86362001)(2201001)(217873002)(9686003)(2501003)(26005)(102836004)(6246003)(4326008)(8936002)(14454004)(110136005)(229853002)(68736007)(6436002)(2906002)(478600001)(33656002)(6116002)(3846002)(316002)(25786009)(71190400001)(99286004)(71200400001)(66066001)(106356001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB2195;H:OSAPR01MB2290.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GVqlYfUSPxcOBd5xitA72n9VunSwA32V4ff54ib05+PECz1eJaxqNaLxAoEkx6jPDf65W0Zsg3Y8JJmkVgdc+DYcpymrH5NS8R+hC+BGwsL6IAxQUUtZrUPE3+BfLOyuZuF+TWU3x3bZ4EbBoEQ5MP6mCTVY3OLz5J/LBeL0mFp7Ydz1q6eSelbNCFwmDIjjOPELUpGYJ5ee8HGwTGQNZw/rmnUW4ppHPb/6OnEwQ6cyg7CSMVvSTCYlSkYKQ83gbSfA0lCaKUwn0T+8peun2Gsx+OdwDBZS0VA7zL1MMHVfeh7NpUP4bcDtX25GgWFi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ecee6c-2325-48ac-0723-08d660b5b25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 04:44:41.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Sasha Levin <sashal@kernel.org>, Sent: Thursday, December 13, 2018 =
1:28 PM
>=20
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> [ Upstream commit 8c85f4b81296a530b8af2796c110fa482ac42d4f ]

Since this upstream commit are reverted by the following commit,
we should not backport it.

---
commit 7b566f70e1bf65b189b66eb3de6f431c30f7dff2
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Dec 4 08:47:44 2018 -0800

    phy: Revert toggling reset changes.

    This reverts:

    ef1b5bf506b1 ("net: phy: Fix not to call phy_resume() if PHY is not att=
ached
    8c85f4b81296 ("net: phy: micrel: add toggling phy reset if PHY is not  =
attac

    Andrew Lunn informs me that there are alternative efforts
    underway to fix this more properly.

    Signed-off-by: David S. Miller <davem@davemloft.net>
---

Best regards,
Yoshihiro Shimoda

> This patch adds toggling phy reset if PHY is not attached. Otherwise,
> some boards (e.g. R-Car H3 Salvator-XS) cannot link up correctly if
> we do the following method:
>=20
>  1) Kernel boots by using initramfs.
>  --> No open the nic, so phy_device_register() and phy_probe()
>      deasserts the reset.
>  2) Kernel enters the suspend.
>  --> So, keep the reset signal as deassert.
>  --> On R-Car Salvator-XS board, unfortunately, the board power is
>      turned off.
>  3) Kernel returns from suspend.
>  4) ifconfig eth0 up
>  --> Then, since edge signal of the reset doesn't happen,
>      it cannot link up.
>  5) ifconfig eth0 down
>  6) ifconfig eth0 up
>  --> In this case, it can link up.
>=20
> Reported-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/phy/micrel.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 3db06b40580d..327f00034d01 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -23,6 +23,7 @@
>   *			 ksz9477
>   */
>=20
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/phy.h>
> @@ -725,6 +726,13 @@ static int kszphy_resume(struct phy_device *phydev)
>  {
>  	int ret;
>=20
> +	if (!phydev->attached_dev) {
> +		/* If the PHY is not attached, toggle the reset */
> +		phy_device_reset(phydev, 1);
> +		udelay(1);
> +		phy_device_reset(phydev, 0);
> +	}
> +
>  	genphy_resume(phydev);
>=20
>  	ret =3D kszphy_config_reset(phydev);
> --
> 2.19.1

