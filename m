Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71439C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B24222D0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qSTLrjcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502177AbfBNPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:33:57 -0500
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:40490
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727571AbfBNPd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZcqk6laAm06ychsdvD3Fm3orm6Ecx8mF0qvryJxtGo=;
 b=qSTLrjcRpQeQ176JWtFAU0c8nLX5j++v48S1gPR+EqHN3XY2Ekx5HmAXOuWbvc4ttZL5aJDpITUWNZij67ACPwyzg1CY/BabO0yr2Fr5D6HZxGhz1VTmBWRYP1CsVxChP64SUnxnx+YtyHYkvkYc1fvpLZGakEVPzSqZuDKTG+A=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB3005.eurprd04.prod.outlook.com (10.170.228.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 15:33:12 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3d48:4560:6982:4c32]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3d48:4560:6982:4c32%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 15:33:12 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Thread-Topic: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Thread-Index: AQHUw4uiFsOjRsU/BUmhwPza339npKXeCTkAgAFPZ3A=
Date:   Thu, 14 Feb 2019 15:33:12 +0000
Message-ID: <VI1PR04MB4880C9EF6C9EBFCAA2209DD596670@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
 <1550055743-15542-3-git-send-email-claudiu.manoil@nxp.com>
 <20190213181554.GB708@lunn.ch>
In-Reply-To: <20190213181554.GB708@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a25cd08-79e3-4e25-a0c0-08d69291bb32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3005;
x-ms-traffictypediagnostic: VI1PR04MB3005:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB3005;23:hvObT0H/BJx5vOskhZPZFh0rqhytwNR/kHN6+eA4/?=
 =?us-ascii?Q?fs4rE+fupbHdXlzF4fWVOhh1AZa9EY5jk+8wnBGn91Sg96YE/BWorqKbMZyU?=
 =?us-ascii?Q?m7uYyKIs6n1dOL6KEkvKrFn4pJfJKrWUbWo8MF570DwrRJHcBgl4yzk0AW1k?=
 =?us-ascii?Q?2p3vdIdE48Gw/o6ZcHh+JiMdbx5YIH8jQ/GnAqHlK1ZMuXZK0TUeAuk4eZDZ?=
 =?us-ascii?Q?esr1ovrdIsY4OA2nrFxrm2smH2caeHcHf4zTVxz8g35yppFhKgPRUj1hp+wT?=
 =?us-ascii?Q?yss/Kq9+xf2bOm8siHByDNjwrgHvXESOFdnl8Utt07WKLTn9dm7wDGzZszXZ?=
 =?us-ascii?Q?C9DfokkzK/mR7zsaxXWT0CFO5pBRr+mKJuC5Ld10ZI0ZjNa8BukfalAYSv5d?=
 =?us-ascii?Q?RPP4rPI4EOTI0ixF5EI802TmV690qH1pbBEWTyOwVmYxMP40jFnMUj3xmJ4n?=
 =?us-ascii?Q?BxcVJkCvAybbiR9wP+qB+Ryy4j7G6wIXA5OTUAvmJTbepw/9+x8aLBtaIG+m?=
 =?us-ascii?Q?shxgrulDoT20vssBQ6uU9FgWd4/g9BHh2hn06/Mv2KmHhvzcr+wCUW/VcMAt?=
 =?us-ascii?Q?qrEUfrxWBpx5mCnzoJAYP75Z72Zm6SeHcNoV6MjnATZ/7+7h2ae3k19fmbip?=
 =?us-ascii?Q?QnK1y4foQcwHn5lSrrm2za+WZLGLilxYiuUQnPKGYXa/VaWiZp1NDAFHBYub?=
 =?us-ascii?Q?dLaWhIGOFots/BKeHAPXf6Zl/nEUfU4q2Atv+QHJ2X9HLISsxJTz9JpB2Px5?=
 =?us-ascii?Q?i4B3Gw9qsPTYnwYrmQniiba7gSbFrK6RAtqCrFVZjTVVYyuM1/1KBlCjaMCe?=
 =?us-ascii?Q?RtvC4k1dBJGRoZa1tZfFTR9rcFeCTY5+mhgy46ixGyMVuCQ6G1XRksieohLA?=
 =?us-ascii?Q?DZDU1bdB2hUrJBhTkVXv0pxiH0TJZpW2L8sEuxyHGbdVN2x3yowzEHSv8dCP?=
 =?us-ascii?Q?tQfwjMYZr7zXtUFBcvPPLivD0ZOFUr+fAjI54eskih7Y8jcCmpLUU7sRA1KS?=
 =?us-ascii?Q?xpv87rP99FovQQ9cfhv37VT+fbVJyJiaeBWWBoqNhx0AfuJuM7sfloNZnUU3?=
 =?us-ascii?Q?nTDUS9OAb2JdEWJ3FIw4V3h+UhUQ9zUoNzqZl0JXFAkAOZwfpJkwYgnBeYPF?=
 =?us-ascii?Q?7w0Urfcj3doraSUeXA3eF4eVUWeqUMroeaMFhdbejkmA1f726d21cmzErO1l?=
 =?us-ascii?Q?yxMAnEYipogDSO8t5ImezOPTPbNjskzBSo1aky3DlRLEi1ZMIzOymlrUQ=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB30058EA6938B166DF07FF20C96670@VI1PR04MB3005.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(13464003)(199004)(476003)(446003)(11346002)(74316002)(2906002)(486006)(478600001)(316002)(25786009)(6116002)(3846002)(9686003)(71190400001)(229853002)(97736004)(55016002)(86362001)(33656002)(99286004)(8936002)(81156014)(81166006)(53936002)(6916009)(106356001)(8676002)(105586002)(76176011)(6436002)(66066001)(7696005)(44832011)(71200400001)(7736002)(305945005)(14444005)(6506007)(102836004)(68736007)(26005)(186003)(4326008)(256004)(54906003)(6246003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3005;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fQgmK6W0kuZkE8ZFkWayFm2eij0xg6/TQ+f5gu8p5TjjqWmmHQ/zJXzOgCbMwtQgEtPwBl2rC7vsNCCEfkBln+5j8bAGfboduf/lcrn9gqgVDvWxxKweRYwIg1Qp/mejhYT7TRVNHR6w4GUS7p+ooe6hbpOIYiFWXuoXDDWU+c3iSR4+hspHUbzfF460rHMh4RfXzMZuj91cYNRuezeHiJrj8pXxXdEaLhwX0Y42B8TzhdEzuYGp4/zX2H69IzFakv6HiO2K21sq9ED1U5qrRSqmtPdx76pV2gAfSzJMsS6Ztk9XAI8SwXfuf9W9YzalinVAKyUw65+PwlXsx0kbfR+95xbA10zD9DDFD7Gl1wvI3qn1uXqq5JDZ7gqLaqvStwcgTDBmUGCeYzehVuFbi8KLixnGqNvOfeiBQ/053j8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a25cd08-79e3-4e25-a0c0-08d69291bb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:33:12.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Wednesday, February 13, 2019 8:16 PM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; David S =
.
>Miller <davem@davemloft.net>; devicetree@vger.kernel.org; Alexandru
>Marginean <alexandru.marginean@nxp.com>; linux-kernel@vger.kernel.org;
>linux-arm-kernel@lists.infradead.org; netdev@vger.kernel.org
>Subject: Re: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
>external eth ports for the LS1028A RDB board
>
>On Wed, Feb 13, 2019 at 01:02:22PM +0200, Claudiu Manoil wrote:
>> The LS1028A RDB board features an Atheros PHY connected over SGMII to
>> the ENETC PF0 (or Port0).  ENETC Port1 (PF1) has no external
>> connection on this board, so it can be disabled for now.
>>
>> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
>> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 15
>> +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> index fdeb417..c8487893 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> @@ -71,3 +71,18 @@
>>  &duart1 {
>>  	status =3D "okay";
>>  };
>> +
>> +&enetc_port0 {
>> +	phy-handle =3D <&sgmii_phy0>;
>> +	phy-connection-type =3D "sgmii";
>> +	#address-cells =3D <1>;
>> +	#size-cells =3D <0>;
>> +
>> +	sgmii_phy0: ethernet-phy@2 {
>> +		reg =3D <0x2>;
>> +	};
>> +};
>> +
>
>Hi Claudiu
>
>It is better to use:
>
>&enetc_port0 {
>	phy-handle =3D <&sgmii_phy0>;
>	phy-connection-type =3D "sgmii";
>	#address-cells =3D <1>;
>	#size-cells =3D <0>;
>
>	mdio {
>		sgmii_phy0: ethernet-phy@2 {
>			reg =3D <0x2>;
>		};
>	};
>};

Hi Andrew,

The extra node for mdio seems to complicate things somewhat.=20
Just adding this node seems not enough.  How to find out easily if a child=
=20
of a enetc port node is a mdio node? I was thinking to use device_type
for that, like this:

&enetc_port0 {
	phy-handle =3D <&sgmii_phy0>;
	phy-connection-type =3D "sgmii";
	mdio {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		device_type =3D "mdio";
		sgmii_phy0: ethernet-phy@2 {
			reg =3D <0x2>;
		};
	};
};

Would you agree with this?

Thanks,
Claudiu
