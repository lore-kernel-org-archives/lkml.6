Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEAAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94FE208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OJnSrsyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94FE208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbeGKKkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:40:51 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:31976
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbeGKKku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkzMcIqYsk28W8dKsnzxOtgJvPbYch9OjLZr1HobjvU=;
 b=OJnSrsyPexB3ekYCYSYnDoCDOaMIXfVCBOd9SYbP6E+LQSXP1l09O6vltNQaFNqy8AgWWm58nsSu1AAhBcRIXqH8JI1KG5dhOooZ7hrKQMEt/O9s4bJmwZzwy8T49xdfkisUSUtA3pIK1JX457Kebx17qz5t6ZeFfUz+AS0XXkw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4979.eurprd04.prod.outlook.com (20.177.40.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 10:37:05 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 10:37:05 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH V4 3/5] mailbox: imx: add imx mu support
Thread-Topic: [PATCH V4 3/5] mailbox: imx: add imx mu support
Thread-Index: AQHUFsxVRb7g/AGotk2h6FoTYgzkeKSIhHsAgAEHGTCAAB+9AIAAGVgw
Date:   Wed, 11 Jul 2018 10:37:05 +0000
Message-ID: <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
In-Reply-To: <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4979;7:1c4nko57zJBracJAa5dpM3UsPnTrO1DRJjSQeq4XqBONzmYeGeOMFJDh/345pnXjqKEQrBurInFeC5q7o4Sr8DDpwiKw597FeuND6yDPVueB62AyqMS/eqbeiCDCyEQ24+waQR9KrflRPGHvxr+veSh7Y079vc+4n4v6ec/5b5P9zsT8fDQQ6HRKqcbDWeXsxYtMo1HZJp4g2+AS1b+878nYqWp84TiNy1LB6pl/YBDxHqKjHVhdtvEK9dRFAOqJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1077d5c4-82a3-4ea9-47db-08d5e71a3f07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4979;
x-ms-traffictypediagnostic: AM0PR04MB4979:
x-microsoft-antispam-prvs: <AM0PR04MB49793847F3FABEBB1490A941805A0@AM0PR04MB4979.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4979;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4979;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(13464003)(6506007)(106356001)(93886005)(6246003)(25786009)(53936002)(4326008)(5660300001)(66066001)(6116002)(6916009)(3846002)(39060400002)(45080400002)(54906003)(68736007)(2906002)(478600001)(33656002)(966005)(9686003)(14454004)(186003)(316002)(305945005)(102836004)(55016002)(486006)(26005)(446003)(11346002)(6306002)(476003)(81156014)(81166006)(2900100001)(229853002)(105586002)(8676002)(86362001)(99286004)(8936002)(15650500001)(14444005)(256004)(74316002)(7696005)(53546011)(76176011)(6436002)(97736004)(7736002)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4979;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5D+teNhBVul9yzYPnNt+aTM5CjKZBWNK5Jxb7lbK3NIRbxMOae2dZxM86QSPzjXiYJTa9+XR5+RhafYerjt/vgAdJwve4Vp920LbzJJWGn53IYxwF8xOHiAajXqrqd6eD7/Kh9u9DGohPEZZQcj8zuUfAIo9ABmZs1vBuXF8gMitrnXhhpKFJF2GVecsMfHOdfBCsSg1/c2LBMYqU5wX4HxaFZy1m0Er0OsO2G1hgzMYwAH14ekHW2edsDgqb9XFoWrGNJXoEt/ovxjnyUsSpgroRxTfrNzWPaGe9ueNTVIbJOL/lSWayVQu+Vgx5hm9ek6BBpHZCudyaU1c3c8bSZcGJ33UAwmB7Gq8TCCC/9s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1077d5c4-82a3-4ea9-47db-08d5e71a3f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 10:37:05.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> Sent: Wednesday, July 11, 2018 3:55 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com; Jassi Brar
> <jassisinghbrar@gmail.com>; linux-kernel@vger.kernel.org; Oleksij Rempel
> <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo@kernel.org
> Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
>=20
> On Wed, Jul 11, 2018 at 07:29:38AM +0000, A.s. Dong wrote:
> > Hi Sascha,
> >
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> > > Sent: Tuesday, July 10, 2018 10:20 PM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com; Jassi
> > > Brar <jassisinghbrar@gmail.com>; linux-kernel@vger.kernel.org;
> > > Oleksij Rempel <o.rempel@pengutronix.de>; dl-linux-imx
> > > <linux-imx@nxp.com>; kernel@pengutronix.de; Fabio Estevam
> > > <fabio.estevam@nxp.com>; shawnguo@kernel.org
> > > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> > >
> > > Hi,
> > >
> > > On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> > > > This is used for i.MX multi core communication.
> > > > e.g. A core to SCU firmware(M core) on MX8.
> > > >
> > > > Tx is using polling mode while Rx is interrupt driven and schedule
> > > > a hrtimer to receive remain words if have more than
> > > > 4 words.
> > >
> > > You told us that using interrupts is not possible due to miserable
> > > performance, we then provided you a way with which you could poll.
> > > Why are you using interrupts now?
> > >
> >
> > Because mailbox framework does not support sync rx now, I think we do
> > not need to wait for that feature done first as it's independent and
> > separate features of framework.
>=20
> You can wait forever for this feature, nobody will add it for you. It's u=
p to you
> to add support for that feature. Who else should add this feature if not =
you?
> And when will you add that feature if not now when you actually need it?
> It is common practice that you adjust the frameworks to your needs rather
> than working around them.
>=20

I'm willing to add it. Just because you said Jassi already had the idea on =
how to
Implement it and does not add much complexity. So I just want to see his pa=
tches.
But if he did not work on it, I can also help on it.

Another reason is i did not observe regression as before, so it looks like =
the irq
is an applicable way currently and not must use polling at this point as th=
at's
an independent new feature of framework. So irq mode is the quickest way
to demo the mbox using  as we already had experience before.

> >
> > So for now, we're just using the common way in kernel as arm scpi and t=
i sci.
> > When framework supports it, we can easily switch to it.
> >
> > I optimized the performance a bit by removing the unnecessary memcopy
> > between tx/tx messages. The test result of booting time shows there's
> > no obvious regressions. I'm not sure whether it's due to we're booting
> > a minimum system or the extra cost is very minor to be noticed due to
> > not too much cmds sent during booting.
>=20
> Your boot time argument seems to be a very weak one. unnecessary
> memcpys of a few bytes only take a fraction of the time interrupt latenci=
es
> introduce.
>=20

Yes, interrupt latency may be the major part.

> > (Copy Peng to comments more as he tried and reported that performance
> > drop with vendor tree)
> >
> > From the time measurement of sc_call_rpc, we can see that most rpc
> > command In polling mode can finish within 10us and very rare ones over
> 20us.
> > If switched to irq mode, those 10us cmds will change to about 20us.
> >
> > But the overall booting time did not increase much. Maybe the irq mode
> > also saves some CPU MIPS to execute other works in parallel?
> >
> > > We also suggested a way how the SCU mode could be integrated into
> > > the generic MU support driver Oleksij posted and now you send a
> > > driver which uses the same name as Oleksijs driver, but it only and
> > > exclusively works in SCU mode. This doesn't bring us forward.
> > >
> >
> > Can Oleksij's patch be implemented against this one?
> > As I remember you said we've still not determined whether Oleksij's
> > approach is the most suitable way and it's still under discussion.
> > (Actually TI's approach looks better which is more simiar as SCU way?)
> >
> > Furthermore, from this patch, you will notice that Oleksij's patch
> > almost did not work for SCU at all. I have to totally rewrite one for S=
CU.
>=20
> You are kidding. You have to rewrite it because you didn't follow my
> suggestion to implement polling in the mailbox framework.
>=20

As I said, I did not observe regression when switch to irq way.
And irq way is the common mbox approach in kernel. So i just use
it to quickly demo the mbox using which we already implemented.
It's simple!

But I got your meaning that we must switch to polling mode
now, because we want to sync with M4, right?

> > So I did not write against his patch as it does not help.
> > And Oleksij's patch is quite simple while the SCU one is much
> > complicated than his one. So we probably better get SCU done first.
> >
> > > We suggested a binding that allows coexisting of the SCU mode and
> > > the generic mode of the MU by putting the mode information into the
> > > second mbox-cell. Why don't you use this?
> > >
> >
> > You mean this?
> > +#define IMX_MU_CHANNEL0		0
> > +#define IMX_MU_CHANNEL1		1
> > +#define IMX_MU_CHANNEL2		2
> > +#define IMX_MU_CHANNEL3		3
> > +#define IMX_MU_CHANNEL_IMX8_SCU 4
>=20
> Yes.
>=20
> >
> > It's hard for me to believe it's correct and it's over abstract to HW.
> > So I thought using mbox-cells to distinguish seems to be better.
>=20
> The MU has four rx registers, four tx registers and four interrupts.
> What else should this be than four channels? The number of channels the
> MU has is obviously defined by the software running at the other end of t=
he
> MU. Yes, the SCU makes one channel from it, in other cases it's four chan=
nels.
>

I'm not against 4 four channels. Just feel SCU using is strange because
SCU is using it as one channel from HW point of view. Not four.
And make them into four channels for M4 also lose the HW capability to send
Up to 4 words at one time. That's also an issue.=20
(I guess we're assuming no actual users of multi words sending, right?)

So using mbox-cells to distinguish seems more reasonable.
e.g.
For one channel case: (communicate with SCU)
Mbox-cells =3D <0>;

Client_node {
	....
	Mbox =3D<&lsio_mu0>;
}

For 4 channel case: (communicate with M4)
Mbox-cells =3D <1>;

Client_node {
	....
	mbox =3D<&mu0 1>;
}

Anything wrong with it?

It seems more reflect the real HW and will not introduce confusion.

> >
> > > I don't think it's necessary to rewrite Oleksijs driver, instead it
> > > should rather be extended with the code I already provided as an
> > > example. With that we could make both of us happy since we can both
> > > have a suitable driver and even share most of the MU code.
> >
> > As I said above, I even can't reuse 90%+ code of Oleksijs driver. So I
> > can't see the meaning to demo the code on top of this driver. We can
> > review the SCU implementation directly with this driver which is more e=
asy.
> > Then we can decide how to merge them together.
>=20
> You can only not share the code because the mailbox framework does not
> support polling. And yes, I even provided some code which implements SCU
> mode ontop of Oleksijs driver.
>=20
> Honestly, what I expect from you is no rocket science and we would alread=
y
> be there if we didn't spend our time discussing this.
>=20

I actually spent a lot time on it to switch to mbox to demo the using step =
by step,
and try to merge them with M4 users later. Although I don't think it's quit=
e worthy
to do that, but I still do it Just because I respect you guys.

From our point of view, we just tried to be more careful about the change r=
equest
as we have more information than outside.

I also don't want to stop at this point. So I will try to add sync polling =
in mailbox
Framework and switch to it now.

Regards
Dong Aisheng

> Sascha
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.pengutronix.de%2F&amp;data=3D02%7C01%7Caisheng.dong%40nxp.com%7
> Cb49570c607cf4057563d08d5e7039a70%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636668925017826212&amp;sdata=3DUT5AhUX%2FV7mCtUit0
> 1KSgJtf%2FdmOmmDMVz8EVebBaVk%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
