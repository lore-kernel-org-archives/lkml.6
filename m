Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58636FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CCC20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=landisgyr.com header.i=@landisgyr.com header.b="HofqrFYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CCC20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landisgyr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeG3Pf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:35:57 -0400
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com ([104.47.1.97]:12096
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbeG3Pf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC0vODNDuvqYLs2OmF4sue1GqS2Ij31S8OH1Uo2vQX4=;
 b=HofqrFYO86z3xJxOTGy5ExTCsplWUo5TJHUTsDlpZaZybJ/rd5W5GkySvnPmEAnn9U8absdYKK9XcyL7v2IVCVv2uID9Ut1wu9CexB09OE54InoRQWApI6URQxoqIgXkgJyszt2kIpZ9sQ3Y+Zf64FU4fcmaTucUKJ8imlYa/Mc=
Received: from AM6PR01MB4262.eurprd01.prod.exchangelabs.com (20.176.242.28) by
 AM6PR01MB4040.eurprd01.prod.exchangelabs.com (20.176.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Mon, 30 Jul 2018 14:00:44 +0000
Received: from AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 ([fe80::29fa:83cb:3fa7:452]) by AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 ([fe80::29fa:83cb:3fa7:452%3]) with mapi id 15.20.0995.020; Mon, 30 Jul 2018
 14:00:44 +0000
From:   "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
Thread-Topic: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
Thread-Index: AQHT/WzddNA8rOZVg02cuuZapzzJYaRTLA6AgBSJeGCAABQbAIBAHoYg
Date:   Mon, 30 Jul 2018 14:00:44 +0000
Message-ID: <AM6PR01MB4262FB2EBD4AFBC05C02F9B6F02F0@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
References: <1528272198-10825-1-git-send-email-alexander.onnasch@landisgyr.com>
 <20180606123947.GB14898@lunn.ch>
 <AM6PR01MB4262F8BB6004D246DFF5C3FEF0700@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
 <20180619152858.GD26796@lunn.ch>
In-Reply-To: <20180619152858.GD26796@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Onnasch@landisgyr.com; 
x-originating-ip: [80.239.165.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR01MB4040;6:N9kHrn9IfTwLl1WpmOlShFkdOqfmo+ZasCowCkQ5yv7W9Xu6lOEiJjIcPPnR7DidS503M+0nmw7ngi+XpXd9R6UmluQIJw33rOPRHkavFDiTIUeWm3jXS+LW/4VZCY2RvasslEgAT8asZtUlosmiiTJoMj4D406IWIw35QbnjrjjiSdZ7bsmKafkEZBqBIfQN72lOTdbOna73SSCBOZxHuKM4nmriWoHoh0vz6bcVPPqIiNqOkfDsizvER2kAxNewOqR9hCbLrZv1mC8N8i+uLtuELhwV1A4pTkfY+//zB1cKHi1L4RuW1DolPtnHqVuE0lwX1C8fgD4zWTY8gZ1+oaLDUGFrN+L3Xi2novDCQwM9nNLqOEcv5JzIlrgDQNju4hnMD7MRoXnl4Ah78Snq5TwsgQkL6enykCIGhUPK3w7/hrHpSMrhNEkkvAwnUWuBZkwN1DleCXK2QxBgMx47A==;5:S8AcyBDApMy3dCmmc9TVxczDrL6+SJj8OWj3Juf7BoIpVWhlWOijiBAWPbXXwYe3t2qqoqQeN26KV3PQPcDzp3/+B4pxvmi+jArVymj7/VXZldcBCBMtWpEhs61JPgDBMmj85U2xgHLgVXfvtSp0eH4cOuJ74w/JghFamFQ0yAM=;7:xf6S1+qTKA2sdEL9da+91EKVB6YzWOwfQe5GaecdgJIvNJvpVLSQ+y3Rp1bClnBox6lnNHlozD+I/HL2KfQ2lAzjrhGONDGUL+O4lTFGwsAR9tGfpw9oDSsBoIeKdcdNXyqh8Tz/L5R4ejKPc+Tgi6bgeqFYlUED4SWdqx/4/zLx1yMJkIEzKVCbtdc2QoEIL3WhXcChCUikRsJVNkOdvb/XaanIPhNeb9RKy8BNEjVKYRzX2kT52vOW/vyafv4y
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c1c0ab22-26ed-45b5-aaab-08d5f624d82f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR01MB4040;
x-ms-traffictypediagnostic: AM6PR01MB4040:
x-microsoft-antispam-prvs: <AM6PR01MB404053FF2B6BA68B22D07F0BF02F0@AM6PR01MB4040.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(144836121648609)(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR01MB4040;BCL:0;PCL:0;RULEID:;SRVR:AM6PR01MB4040;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(39860400002)(396003)(51914003)(13464003)(189003)(199004)(5250100002)(5660300001)(6246003)(105586002)(74316002)(2906002)(8676002)(39060400002)(66066001)(4326008)(316002)(53936002)(6436002)(25786009)(97736004)(55016002)(9686003)(229853002)(33656002)(54906003)(93886005)(7696005)(26005)(76176011)(68736007)(6916009)(446003)(11346002)(256004)(14444005)(6506007)(53546011)(8936002)(102836004)(81166006)(72206003)(476003)(186003)(81156014)(3846002)(6116002)(86362001)(106356001)(478600001)(7736002)(99286004)(2900100001)(486006)(14454004)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR01MB4040;H:AM6PR01MB4262.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: landisgyr.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PyA871Oe3WeQUxPGfd0VV9EO6mOVQI2r+SUALwJDdM9TEk6zKmsrYoqlDgjdmHeAKM76HGL9PKejwEDMPBsDqDOkKETQMMQyo3GG7wGr5kaGMGk+Z82EJ5ojlS/KiMpEb2Hp9zhJrO43MF6fPQ7xx0Kq2JTBz9sMOQvBBv05BhP1o2gqee69A/96CQQkdmDVrLvlVvlATf3tdGvCkyrMFiRwpKBveRyQ7XQYkinn1Nf8WRzyXR6NZDX2icHEsh+YHSYxJk7NKhyT42iAeInGrnxBN+/Zi2CsXnyxxjBNcIjLFqimfNAkKQpOyH/7/XkI88zy2Lo4nTS2jeygAStaoq7t5r7dPAUOU/IVUCNQN4E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c0ab22-26ed-45b5-aaab-08d5f624d82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 14:00:44.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR01MB4040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

thanks for your feedback. I was on holiday, thus just delayed, not forgotte=
n...
Sorry for top-posting - odd company default mail setup.
I checked again phy_write_mmd(), you are right !=20
Patch with changed implementation will follow.

Best regards, Alex


-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Dienstag, 19. Juni 2018 17:29
To: Onnasch, Alexander (EXT) <Alexander.Onnasch@landisgyr.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; linux-=
kernel@vger.kernel.org
Subject: Re: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable c=
onnect

On Tue, Jun 19, 2018 at 02:23:41PM +0000, Onnasch, Alexander (EXT) wrote:
> Hi Andrew
> thanks for the hint. But actually I cannot confirm - or I don't see it ye=
t.=20
>=20
> Without having tested, just from the code, the struct phy_driver instance=
 for PHY_ID_KSZ8061 in micrel.c does not have a .write_mmd function assigne=
d, thus phy_write_mmd should evaluate to its else-clause (see below) and no=
t to mdiobus_write (as in phy_write).
>=20
> Also the ksz8061_extended_write() function which I have added uses the sa=
me principle as already existing HW-specific functions in micrel.c for simu=
lar reasons (kszphy_extended_write and ksz9031_extended_write).
> They use phy_write all over the place in that file and never phy_write_mm=
d - for whatever reason they had.
> Thus I thought it would be a good idea ...

Hi Alexander

Please don't top post. And wrap your lines at around 75 characters=20

> 		struct mii_bus *bus =3D phydev->mdio.bus;
> 		int phy_addr =3D phydev->mdio.addr;
>=20
> 		mutex_lock(&bus->mdio_lock);
> 		mmd_phy_indirect(bus, phy_addr, devad, regnum);
>=20
> 		/* Write the data into MMD's selected register */
> 		bus->write(bus, phy_addr, MII_MMD_DATA, val);
> 		mutex_unlock(&bus->mdio_lock);


> > +static int ksz8061_extended_write(struct phy_device *phydev,
> > +				  u8 mode, u32 dev_addr, u32 regnum, u16 val) {
> > +	phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, dev_addr);
> > +	phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, regnum);
> > +	phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, (mode << 14) | dev_addr=
);
> > +	return phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, val); }
>=20
> Hi Alexander
>=20
> This looks a lot like phy_write_mmd().

Look closely at the two implementations. Look at what
mmd_phy_indirect() does. I _think_ these are identical. So don't add your o=
wn helper, please use the core code.

     Andrew
