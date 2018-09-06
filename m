Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7C9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA49B2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r0dMCLJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA49B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeIFIEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:04:14 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:22560
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbeIFIEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjhqWYv43g8h8hVjodjI2QpQu1Sf9G94jCVai7NyI1Q=;
 b=r0dMCLJ1zdG6Cd0fAwcwBdSJCHHuehp2GeJcE+hE8QVlIJ0wPFxEvtj4pqXs8k1IwvilxzmxcBHtbVosjaeibr2IGfIbwMBCQT3aHIF/Kf+LHSuGfrw+6Ja1/87RJrdzLWUE4HBq5Cx3GPhc6F9I4v9KfrbAyFFkcnHjxBBwRuY=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.39.153) by
 AM0PR0402MB3507.eurprd04.prod.outlook.com (52.133.45.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 03:30:54 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::3564:4ef3:169:fc49]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::3564:4ef3:169:fc49%2]) with mapi id 15.20.1101.019; Thu, 6 Sep 2018
 03:30:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] input: egalax_ts: add system wakeup support
Thread-Topic: [PATCH 1/2] input: egalax_ts: add system wakeup support
Thread-Index: AQHURPs1JYWKjjjeH0+bcLzbSFIDgaTh8VcAgACoG2A=
Date:   Thu, 6 Sep 2018 03:30:53 +0000
Message-ID: <AM0PR0402MB3905F7737816174202D634CAF5010@AM0PR0402MB3905.eurprd04.prod.outlook.com>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
 <20180905172700.GA257188@dtor-ws>
In-Reply-To: <20180905172700.GA257188@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3507;6:YT4b3L+hYMgrOm9dBXWPxjUlibm4UIpiQlrjWF3nuj3X/n7P0TKr34GrEbmEaC2/e5fjtIR9HWvG+QYJUsvFoyngkja9tuJkeP8r/vmnWxwDQrDXw+bV2rje5N2noJieJtzzuhkaUORaxRTmU535Qu32vAjUAouh5koctgPgu96ka7wJLRABnOqz+z46l84Tqa7lYHUN4JBRP0hB8dnP7gf4j2tO/H5CGImMvZE44pIBajIkzD7ie4K4ceF8xLHwbvsriA9tCms0Eod+yGJ0GOAk/fJUBuu1mh2UFqAkOL0g74lC9kWbgzuzamnQB5VfP+fAles5yG84Rxs3l02a706VG9MLroe3UmwwM6qWxEuyxcJkM1Pqqa5Vzec9BkQe85eFlBF4Mp94Sf3WQqyX7t/krZg9ZTTicYSeC3iOX0KhgtF5uyOmDJBj9iqV6D2r8J2hMdBVJGu4uWKWYG5spw==;5:vqzA6ogG7Trv29Usgvg6dBRt2XY6o9uAZPnpGwKjey6v5p8XYBOKjjzg3P+RiqaKFUv+k5Mi8jcZnqS00yXLqUywL6t4zW7eE/ic4bUEbWpnitfpkA5KabU15X073Ru8llGkS+WuZnZvIdcEzNAKArC/5GQSPbHDrDNMml6PErc=;7:oxDglEURScocKf1Z+vVVO3EayRs5rD1gSXDXJEYGtvD/CrwAUyLYj4ItQ6f37x1KH1BTRVT865GRGH56tP9Fb0w6MV9nlRpjgJZu0avDqsRRaHYlgsX339rnJU4KJvcalu0m6O4EkI6bGu3JBZwq7QWsmST6cEL6BUbPeJr7lbH6F0N3b+z0DNe6O6FVqTGv0/kNdTFE4EE7fTgHT7K6oI5/69f2ooT5OBRmiheUBQ8gvNLNqGZebbyljCadGU1+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df34fe90-3f24-4109-c9bd-08d613a926cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3507;
x-ms-traffictypediagnostic: AM0PR0402MB3507:
x-microsoft-antispam-prvs: <AM0PR0402MB35075B80A595A6B7DB407DA9F5010@AM0PR0402MB3507.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR0402MB3507;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3507;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(13464003)(6916009)(2906002)(9686003)(86362001)(99286004)(74316002)(2900100001)(33656002)(55016002)(76176011)(53936002)(5660300001)(186003)(106356001)(7696005)(102836004)(53546011)(6506007)(26005)(8676002)(105586002)(81166006)(81156014)(476003)(316002)(229853002)(14454004)(11346002)(446003)(44832011)(305945005)(7736002)(256004)(8936002)(97736004)(478600001)(54906003)(3846002)(5250100002)(486006)(6436002)(6116002)(39060400002)(6246003)(25786009)(66066001)(68736007)(4326008)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3507;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IS47c3TTgrqE3o5+JD1WIZ+zrfwlb33UpQ6+oFMRDiUO8/2h8vGzv4xPg9fX96KcTCIJqyKJfEuWGmmljNfU4C+yjR6SnxN5IzNHGaCndPapZrITZ8SciI1Qh+3ziVK6h7yaYku4JpnPVfuvHiR8hzJr1jRpY5fWRAfzcLL2xjlXuVi9pZZOwVReMmzKM4rhj4b96Kwt1NyuIuSmyk0dPDl9nPLn+ch87ILD1KODbNq1BKrlEELFI3/oDfiQ2JMPB4xAxDkzlMlyhQOiaE4rviyPGA18Wk9hhLKTNa5shPQv27K0Y1rtm26lGUiXK8n0djIiFVJq4tx9GJWC7/m1+xu8mcS+XYCHWpnTrS2hRzE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df34fe90-3f24-4109-c9bd-08d613a926cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 03:30:53.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dmitry

Anson Huang
Best Regards!


> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Thursday, September 6, 2018 1:27 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: robh+dt@kernel.org; mark.rutland@arm.com; Marco Antonio Franchi
> <marco.franchi@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> linux-input@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH 1/2] input: egalax_ts: add system wakeup support
>=20
> Hi Anson,
>=20
> On Wed, Sep 05, 2018 at 05:26:46PM +0800, Anson Huang wrote:
> > This patch adds wakeup function support for egalax touch screen, if
> > "wakeup-source" is added to device tree's egalax touch screen node,
> > the wakeup function will be enabled, and egalax touch screen will be
> > able to wakeup system from suspend.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/input/touchscreen/egalax_ts.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/input/touchscreen/egalax_ts.c
> > b/drivers/input/touchscreen/egalax_ts.c
> > index 80e69bb..74984ed 100644
> > --- a/drivers/input/touchscreen/egalax_ts.c
> > +++ b/drivers/input/touchscreen/egalax_ts.c
> > @@ -164,6 +164,7 @@ static int egalax_firmware_version(struct
> > i2c_client *client)  static int egalax_ts_probe(struct i2c_client *clie=
nt,
> >  			   const struct i2c_device_id *id)  {
> > +	struct device_node *np =3D client->dev.of_node;
> >  	struct egalax_ts *ts;
> >  	struct input_dev *input_dev;
> >  	int error;
> > @@ -224,6 +225,9 @@ static int egalax_ts_probe(struct i2c_client *clien=
t,
> >  	if (error)
> >  		return error;
> >
> > +	if (of_property_read_bool(np, "wakeup-source"))
> > +		device_init_wakeup(&client->dev, true);
>=20
> This is done in i2c core, there is no need to do it in the driver.
=20
Correct, I removed it in V2 patch.


>=20
> > +
> >  	return 0;
> >  }
> >
> > @@ -241,6 +245,9 @@ static int __maybe_unused
> egalax_ts_suspend(struct device *dev)
> >  	struct i2c_client *client =3D to_i2c_client(dev);
> >  	int ret;
> >
> > +	if (device_may_wakeup(dev))
> > +		return enable_irq_wake(client->irq);
> > +
> >  	ret =3D i2c_master_send(client, suspend_cmd, MAX_I2C_DATA_LEN);
> >  	return ret > 0 ? 0 : ret;
> >  }
> > @@ -249,6 +256,9 @@ static int __maybe_unused egalax_ts_resume(struct
> > device *dev)  {
> >  	struct i2c_client *client =3D to_i2c_client(dev);
> >
> > +	if (device_may_wakeup(dev))
> > +		return 0;
>=20
> This will end up with unbalanced enable_irq_wake() from suspend.

Ah, it is a mistake, I fix it in V2 patch, please help review it.

And for the other patch about adding "wakeup-source" into dt-binding, I thi=
nk it may
be no need now, since it is already included in i2c's dt-binding, right?

Thanks.

Anson.

>=20
> > +
> >  	return egalax_wake_up_device(client);  }
> >
> > --
> > 2.7.4
> >
>=20
> Thanks.
>=20
> --
> Dmitry
