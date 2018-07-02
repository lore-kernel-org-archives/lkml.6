Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA29AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504FC25182
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="AxRXLIiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504FC25182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeGBUoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:44:04 -0400
Received: from mail-dm3nam03on0106.outbound.protection.outlook.com ([104.47.41.106]:27407
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752715AbeGBUoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xSlZteBUpXDZW9bqwJBgTHXeh4d9ANYqyRLPG9/tkI=;
 b=AxRXLIiN4hESBVndx9rHnMrJLc+iem5KAGVF12DGXyKxfYqHd78RsE31L7CTl/ziXv0w3qs4QYqWUaOYv/NGMSDN9JIPMPUJwH3OutUAjYk+NGVFUQ/qx5/JhN5jZFRu8ZglFFzXPcB18nEGyTdqCWcY45kJtCHbP45zeE3CflU=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1161.namprd02.prod.outlook.com (10.162.108.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Mon, 2 Jul 2018 20:43:56 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da%4]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 20:43:56 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?iso-8859-1?Q?Michael_R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Steve deRosier <derosier@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>
Subject: RE: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Thread-Topic: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Thread-Index: AQHUESvvwSr5pLbXbkmh3lgaa2XdVqR8HL0AgAAWvYCAADBOgA==
Date:   Mon, 2 Jul 2018 20:43:55 +0000
Message-ID: <BY1PR02MB111481D94EB0D68AD5FCA689E7430@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
In-Reply-To: <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [146.200.117.72]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR02MB1161;7:6NT2k4Dkx05j7+Eu4XeSVyGX9EuWlfKXOR3bDaXHFqfn+aUc45JwFBw87Ig6fGM7MFFMGxFm7p4xCSXd9KJSxd40qAEiiNeLG4vM6q99ZXEO5aWijikF7MCW/L0sWRZpVna+Q4jTpYPv3FXx9qgMjXk55EaLF0xt4k3ivuYN/WCKjErkEK1KurOoqfvstkXxiW013trciVN+9mlS7iOdjySQYKIsn3c+3c1bCFhw8At3ziRe9tm8LA77sDfwhN43
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1179e702-79cd-4b86-2f69-08d5e05c87a4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY1PR02MB1161;
x-ms-traffictypediagnostic: BY1PR02MB1161:
x-microsoft-antispam-prvs: <BY1PR02MB11617FBEB2EC70DC5BDDFA90E7430@BY1PR02MB1161.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY1PR02MB1161;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1161;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(78114003)(199004)(189003)(551934003)(9686003)(105586002)(106356001)(93886005)(55236004)(33656002)(11346002)(446003)(6246003)(53936002)(6436002)(39060400002)(72206003)(476003)(55016002)(7696005)(2906002)(81156014)(81166006)(4326008)(966005)(5660300001)(186003)(8936002)(2900100001)(54906003)(6306002)(99286004)(110136005)(6506007)(5250100002)(5024004)(7736002)(14454004)(86362001)(66066001)(68736007)(6116002)(486006)(305945005)(3846002)(26005)(7416002)(76176011)(14444005)(478600001)(97736004)(8676002)(74316002)(256004)(229853002)(316002)(102836004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR02MB1161;H:BY1PR02MB1114.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Eu+1qhGnMCr6HxKCDL6dfdStJypi+PsYN1SQOuUyZYPvCeK4B303xyCzjNFGvw4suLrRV7Oop+xLu5z2CmVomseFZsr6ZMtF0mm30sig4Yn6hXfRugUG3WU5FwXFi03MEZpmTQJjX2VZF10g18xGJ3DX20EHvRX8HGpZEdg2NTWmUlo4HIdqFLXUFPqIQL+yBEw6o/AnaV3lPUPtl24MD+v2D49L/4uydilLNGuJydXXWQjs/KOH6ttDmC5ufyo+fHU5rgzuqc7nhDt/vf24+aNbWVZi14reueGRFP34HZvH+91C8DTbxMhZx5k9uQs1dC5/OUWwvC4ZAE2LraGPqGeRCfIdCqleGQ07cTmdINo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1179e702-79cd-4b86-2f69-08d5e05c87a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 20:43:55.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
>=20
> Hi Mark,
>=20
> This driver is still evolving, there's newer code on my lora-next branch
> already: https://github.com/afaerber/linux/commits/lora-next
>=20
> The reason you're in CC on this RFC is two-fold:
>=20
> 1) You applied Ben's patch to associate "semtech,sx1301" with spidev,
> whereas I am now preparing a new driver for the same compatible.
>=20
> 2) This SPI device is in turn exposing the two SPI masters that you
> already found below, and I didn't see a sane way to split that code out
> into drivers/spi/, so it's in drivers/net/lora/ here - has there been
> any precedence either way?

In my work in progress driver I just register one controller for the sx1301=
 with two chip selects and use the chip select information to choose the co=
rrect radio to send to, this is based on the DT reg information. No need to=
 register two separate masters.

> More inline ...
>=20
> Am 02.07.2018 um 18:12 schrieb Mark Brown:
> > On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas F=E4rber wrote:
> >
> >> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enab=
le)
> >> +{
> >> +	int ret;
> >> +
> >> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
> >> +
> >> +	if (enable)
> >> +		return;
> >> +
> >> +	ret =3D sx1301_radio_set_cs(spi->controller, enable);
> >> +	if (ret)
> >> +		dev_warn(&spi->dev, "failed to write CS (%d)\n", ret);
> >> +}
> >
> > So we never disable chip select?
>=20
> Not here, I instead did that in transfer_one below.
>=20
> Unfortunately there seems to be no documentation, only reference code:
>=20
> https://github.com/Lora-
> net/lora_gateway/blob/master/libloragw/src/loragw_radio.c#L121
> https://github.com/Lora-
> net/lora_gateway/blob/master/libloragw/src/loragw_radio.c#L165
>=20
> It sets CS to 0 before writing to address and data registers, then
> immediately sets CS to 1 and back to 0 before reading or ending the
> write transaction. I've tried to force the same behavior in this driver.
> My guess was that CS is high-active during the short 1-0 cycle, because
> if it's low-active during the register writes then why the heck is it
> set to 0 again in the end instead of keeping at 1... confusing.
>=20
> Maybe the Semtech folks CC'ed can comment how these registers work?
>=20
> >> +	if (tx_buf) {
> >> +		ret =3D sx1301_write(ssx->parent, ssx->regs +
> REG_RADIO_X_ADDR, tx_buf ? tx_buf[0] : 0);
> >
> > This looks confused.  We're in an if (tx_buf) block but there's a use o=
f
> > the ternery operator that appears to be checking if we have a tx_buf?
>=20
> Yeah, as mentioned this RFC is not ready for merging - checkpatch.pl
> will complain about lines too long, and TODOs are sprinkled all over or
> not even mentioned. It's a Proof of Concept that a net_device could work
> for a wide range of spi and serdev based drivers, and on top this device
> has more than one channel, which may influence network-level design
> discussions.
>=20
> That said, I'll happily drop the second check. Thanks for spotting!
>=20
> >> +		if (ret) {
> >> +			dev_err(&spi->dev, "SPI radio address write
> failed\n");
> >> +			return ret;
> >> +		}
> >> +
> >> +		ret =3D sx1301_write(ssx->parent, ssx->regs +
> REG_RADIO_X_DATA, (tx_buf && xfr->len >=3D 2) ? tx_buf[1] : 0);
> >> +		if (ret) {
> >> +			dev_err(&spi->dev, "SPI radio data write failed\n");
> >> +			return ret;
> >> +		}
> >
> > This looks awfully like you're coming in at the wrong abstraction layer
> > and the hardware actually implements a register abstraction rather than
> > a SPI one so you should be using regmap as the abstraction.
>=20
> I don't understand. Ben has suggested using regmap for the SPI _device_
> that we're talking to, which may be a good idea. But this SX1301 device
> in turn has two SPI _masters_ talking to an SX125x slave each. I don't
> see how using regmap instead of my wrappers avoids this spi_controller?
> The whole point of this spi_controller is to abstract and separate the
> SX1255 vs. SX1257 vs. whatever-radio-attached into a separate driver,
> instead of mixing it into the SX1301 driver - to me that looks cleaner
> and more extensible. It also has the side-effect that we could configure
> the two radios via DT (frequencies, clk output, etc.).

You want an SPI controller in the SX1301 as the down stream radios are SPI =
and could be attached directly to a host SPI bus, makes sense to have one r=
adio driver and talk through the SX1301.
But you should use the regmap to access the SX1301 master controller regist=
ers.
Example I use with one SPI master and some clock info:
eg:
	sx1301: sx1301@0 {
		compatible =3D "semtech,sx1301";
		reg =3D <0>;
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		spi-max-frequency =3D <8000000>;
		gpios-reset =3D <&pioA 26 GPIO_ACTIVE_HIGH>;
		clocks =3D <&radio1 0>, <&clkhs 0>;
		clock-names =3D "clk32m", "clkhs";

		radio0: sx1257@0 {
			compatible =3D "semtech,sx125x";
			reg =3D <0>;
			spi-max-frequency =3D <8000000>;
			tx;
			clocks =3D <&tcxo 0>;
			clock-names =3D "tcxo";
		};

		radio1: sx1257@1 {
			compatible =3D "semtech,sx125x";
			reg =3D <1>;
			spi-max-frequency =3D <8000000>;
			#clock-cells =3D <0>;
			clocks =3D <&tcxo 0>;
			clock-names =3D "tcxo";
			clock-output-names =3D "clk32m";
		};
};


> You will find a datasheet with some diagrams mentioning "SPI" at:
> https://www.semtech.com/products/wireless-rf/lora-gateways/SX1301
>=20
> >> +	if (rx_buf) {
> >> +		ret =3D sx1301_read(ssx->parent, ssx->regs +
> REG_RADIO_X_DATA_READBACK, &rx_buf[xfr->len - 1]);
> >> +		if (ret) {
> >> +			dev_err(&spi->dev, "SPI radio data read failed\n");
> >> +			return ret;
> >> +		}
> >> +	}
> >
> > For a read we never set an address?
>=20
> To read, you first write the address via tx_buf, then either in the same
> transfer in the third byte or in a subsequent one-byte transfer as first
> byte you get the data.
>=20
> If you have better ideas how to structure this, do let me know.
>=20
> >> +static void sx1301_radio_setup(struct spi_controller *ctrl)
> >> +{
> >> +	ctrl->mode_bits =3D SPI_CS_HIGH | SPI_NO_CS;
> >
> > This controller has no chip select but we provided a set_cs operation?
>=20
> Oops, I played around with those two options and was hoping SPI_NO_CS
> would avoid the undesired set_cs invocations, but it didn't work as
> expected and so I added the "if (enabled)" check above.
>=20
> Thanks for your review,
>=20
> Andreas
>=20
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=FCrnberg)

