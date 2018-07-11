Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C70C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0FB2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vzV86kgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0FB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeGKHcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:32:36 -0400
Received: from mail-ve1eur01on0064.outbound.protection.outlook.com ([104.47.1.64]:25986
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbeGKHcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9OjAnV/HDUDD5TMprReoq6VjWujFkaURPU+PiK9e+c=;
 b=vzV86kgrJszY6BVP26QLd5refLKdVngcVbzaZQIa0foPItBMdi1WnkRNaGPhVWvXZG72EIVTH5Z4cB1lcqt5FiBoiSO4rj5DSrwvPm3Rdout1FGD1BoG6dzmyXECItEQSeAR8caT/IczrSecLHbw+oL9OCSGiS8Ysj4hoafzIco=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 07:29:39 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 07:29:39 +0000
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
Thread-Index: AQHUFsxVRb7g/AGotk2h6FoTYgzkeKSIhHsAgAEHGTA=
Date:   Wed, 11 Jul 2018 07:29:38 +0000
Message-ID: <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
In-Reply-To: <20180710141940.oed3kwhbplnykl36@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4211;7:ugdUN0OyvYJV2PjAtIoAFWS/Ea6aawhHbAPaWm5QPmkMPEOC9T7Fhz5Py9Gzd0k4nlOYeHrIlBszGZ2HwwZ7WVT8giS6ChHjk/tXJkuOt/M7H+zlZvBpCzDi0sEfEY3uTpxKgkc1sVH0bM7FMHTdl5O64fXmJpHZP/GFCZpEg60sFxON9IRyCJIshkCukP6zoAJRH6HPfJ8wBltvKTMXvcs/qHAI7aw+DFn8tTyb1aZcwo/TVvy3YXXxgpgfMqCo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b579163a-8f7e-4058-9bf9-08d5e7000f93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
x-ms-traffictypediagnostic: AM0PR04MB4211:
x-microsoft-antispam-prvs: <AM0PR04MB4211BBAE74EA634B16D782C1805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(13464003)(74316002)(2900100001)(7736002)(15650500001)(54906003)(305945005)(6116002)(3846002)(316002)(966005)(6916009)(14454004)(4326008)(39060400002)(25786009)(5660300001)(99286004)(45080400002)(53936002)(6246003)(478600001)(86362001)(229853002)(33656002)(486006)(68736007)(2906002)(5250100002)(256004)(14444005)(476003)(446003)(11346002)(106356001)(105586002)(76176011)(66066001)(8936002)(7696005)(97736004)(186003)(102836004)(6436002)(53546011)(6506007)(6306002)(81166006)(55016002)(81156014)(8676002)(9686003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9zp1kkeTmz5xkluoJaEpUc4AQRf2WWblLpKoYbl6r+Tg+isXAE3Ve0FAy+Y5tFbW1xNgHtq0fdhijqYHhj3S1iGVT/XiqAkJYCBUKYwJGhX0dvYSuEu6iRa8I4rre4r/Z7UboggvDoP3K8dJ3tZnYwqevkt2cmB8x6vm16GOJi8Cm8HP2cyLs2v+ev944421AQAQiHogcu9VaE+hBjBxsAkAjw28o0t/bNLB3TEl6cJ8gUglkm4VIJMttAI+wi9zVSHZSEY0xcu7jB8NZPepEbChzgelo/NxYdJKTV1g2CVMpSMx1JipPcXkdnMSHKBHGFTy+nNe+MEffY9/fgnMX7N5LxMUo4JvWZg4Tp/425M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b579163a-8f7e-4058-9bf9-08d5e7000f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 07:29:38.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> Sent: Tuesday, July 10, 2018 10:20 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com; Jassi Brar
> <jassisinghbrar@gmail.com>; linux-kernel@vger.kernel.org; Oleksij Rempel
> <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo@kernel.org
> Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
>=20
> Hi,
>=20
> On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> > This is used for i.MX multi core communication.
> > e.g. A core to SCU firmware(M core) on MX8.
> >
> > Tx is using polling mode while Rx is interrupt driven and schedule a
> > hrtimer to receive remain words if have more than
> > 4 words.
>=20
> You told us that using interrupts is not possible due to miserable
> performance, we then provided you a way with which you could poll.  Why
> are you using interrupts now?
>=20

Because mailbox framework does not support sync rx now, I think we do not
need to wait for that feature done first as it's independent and  separate
features of framework.=20

So for now, we're just using the common way in kernel as arm scpi and ti sc=
i.=20
When framework supports it, we can easily switch to it.

I optimized the performance a bit by removing the unnecessary memcopy
between tx/tx messages. The test result of booting time shows there's no
obvious regressions. I'm not sure whether it's due to we're booting a minim=
um
system or the extra cost is very minor to be noticed due to not too much cm=
ds
sent during booting.
(Copy Peng to comments more as he tried and reported that performance drop
with vendor tree)

From the time measurement of sc_call_rpc, we can see that most rpc command
In polling mode can finish within 10us and very rare ones over 20us.
If switched to irq mode, those 10us cmds will change to about 20us.=20

But the overall booting time did not increase much. Maybe the irq mode
also saves some CPU MIPS to execute other works in parallel?

> We also suggested a way how the SCU mode could be integrated into the
> generic MU support driver Oleksij posted and now you send a driver which
> uses the same name as Oleksijs driver, but it only and exclusively works =
in
> SCU mode. This doesn't bring us forward.
>=20

Can Oleksij's patch be implemented against this one?
As I remember you said we've still not determined whether Oleksij's approac=
h
is the most suitable way and it's still under discussion.
(Actually TI's approach looks better which is more simiar as SCU way?)

Furthermore, from this patch, you will notice that Oleksij's patch almost
did not work for SCU at all. I have to totally rewrite one for SCU.
So I did not write against his patch as it does not help.
And Oleksij's patch is quite simple while the SCU one is much complicated
than his one. So we probably better get SCU done first.

> We suggested a binding that allows coexisting of the SCU mode and the
> generic mode of the MU by putting the mode information into the second
> mbox-cell. Why don't you use this?
>=20

You mean this?
+#define IMX_MU_CHANNEL0		0
+#define IMX_MU_CHANNEL1		1
+#define IMX_MU_CHANNEL2		2
+#define IMX_MU_CHANNEL3		3
+#define IMX_MU_CHANNEL_IMX8_SCU 4

It's hard for me to believe it's correct and it's over abstract to HW.
So I thought using mbox-cells to distinguish seems to be better.

> I don't think it's necessary to rewrite Oleksijs driver, instead it shoul=
d rather
> be extended with the code I already provided as an example. With that we
> could make both of us happy since we can both have a suitable driver and
> even share most of the MU code.

As I said above, I even can't reuse 90%+ code of Oleksijs driver. So I can'=
t
see the meaning to demo the code on top of this driver. We can review
the SCU implementation directly with this driver which is more easy.
Then we can decide how to merge them together.

Regards
Dong Aisheng

>=20
> Regards,
> Sascha
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.pengutronix.de%2F&amp;data=3D02%7C01%7Caisheng.dong%40nxp.com%7
> Cb359a3eddee54bf1b40a08d5e6702f22%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C636668291863846639&amp;sdata=3DhSucaLRfCB1j1McwlfO%
> 2FL0921QXiHg68sl%2B23CvEp4Q%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
