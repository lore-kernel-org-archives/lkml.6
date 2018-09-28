Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE0EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5B22174E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eXRj82pD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5B22174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeI1O0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:26:38 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:11402
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727389AbeI1O0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqMxHqXZKNlvrTKGx4ZXqC8aBh3wJqsofmdT3wLTcbQ=;
 b=eXRj82pDDchw4RDQzHJlUwlfadWgEd7DgrH4onCdf/A6s57u3fiLKUdXE4UGNRWahar/+/86jdEZO8//Gx1kBiMsAoqlHLuDiasH/6vw19/9eFPAC2yvASVeCNrQyfV5I1jK0Y4fbMFbgqxAqUpnvFCkcNuPx9Htwqa58ilMngw=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.133.18) by
 VI1PR0401MB2557.eurprd04.prod.outlook.com (10.168.65.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Fri, 28 Sep 2018 08:04:00 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::984e:2d7e:1a9c:c1b9]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::984e:2d7e:1a9c:c1b9%7]) with mapi id 15.20.1185.022; Fri, 28 Sep 2018
 08:04:00 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Topic: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Index: AQHUVlODYLzUr6TXRkCk3Aso2dGK1KUEHlyAgAEqd6A=
Date:   Fri, 28 Sep 2018 08:04:00 +0000
Message-ID: <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
 <20180927132507.GB23375@lunn.ch>
In-Reply-To: <20180927132507.GB23375@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB2557;6:RAvfMt6mTS1Bh9qZIJPZxN72dujkiVIl+vF7vSZqj4zRyL8Cx1TY5v1VaXL/eugG9IDGHd9Tgxy/czzNtUVMrWaYks/FPeoSvyLNUb/BG+wt6AeWbjUGw71xH8rKOFg3HbRlbDReuRJoPLPahbpvjxZJ/5eaqV07rtYNUJn0nLfpYgpqagLywSqy1N6xuJKH0Bfz5pjlwCub+MkZsc8hIIS93NqXVX0HWZ2JUcd++pom2W2wX/lPazEOxMnDy1d47M9cznIprF5VKq9dyXSLkq3Ui6kTi7rUXbU2ifz58tAGbm0PskK7wP4dsIVkHtG+bgUXDmPAiJvhyJH6WLMHfbZ9PldGq6MCDmELnsHJy/FHF7/x5rl6hYGzf0mBtXPfinsWAg3/R6MJV9ZVcyC8UeQCeLcKxhf0xQ5sOz+CacRGr9TMhTZ+PMJBPoR0R/zt6Stp7EpcPrSoHy8huvTjEw==;5:JQEI4IlHPHGSMowWmAAYwjl87PkL7RPbfd1bEAwhyhTAOKS1c2qJ4rrTTRek4SFbqdhnMHl7f/hCswOPH0z7o/R91Wgmlrz7rlEwOXNPp2HwUV938y9ZP+65A03n0PRA39HXN41VvW9PFKtP/XC7NTZnPGvYBBGRT3QYnSXtS38=;7:eiueYJ4BCjfdoz+Hq7sRDXl7nNLwk6EUD3HPwS5pA5Cgd68+K5NyJ2h1XZ/4ok5RbG+TdNohmYCtFxfg34H1ynrKqAqsj3zGJjNBY7MHZE8ijTIpx4fVao6/gGDO5sGfahoYHg4tQ5dxQe7YIWNWub4sN2IHSxY/Bk5ggQ7SUiEKD1kWR+MU1GQEmDikc763GPmtmTuJ8FRv/q+W8QS11dTee3GAUL06ho5RsWP7XNHvDEvk9dXwA96rTfvLTohy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e44f3c18-8910-4e2f-4bcc-08d62518f302
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2557;
x-ms-traffictypediagnostic: VI1PR0401MB2557:
x-microsoft-antispam-prvs: <VI1PR0401MB255746D35BE6FB755E4F2B6BF8EC0@VI1PR0401MB2557.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:VI1PR0401MB2557;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2557;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(366004)(136003)(13464003)(189003)(199004)(256004)(39060400002)(186003)(6916009)(97736004)(4326008)(14454004)(305945005)(316002)(34290500001)(74316002)(66066001)(71190400001)(26005)(71200400001)(68736007)(25786009)(2900100001)(7736002)(102836004)(33656002)(6116002)(3846002)(6506007)(8936002)(53546011)(476003)(486006)(6246003)(5660300001)(81156014)(76176011)(7696005)(81166006)(99286004)(8676002)(5250100002)(106356001)(54906003)(55016002)(9686003)(446003)(6436002)(86362001)(229853002)(2906002)(53936002)(11346002)(105586002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2557;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rIIqHNpAuxCPrQgsoQ8rrYD5IhJFdNt1zOKnEzX3MazwonhTv1mU9DAMh22i57Zx8CL5RQ7DN79DCDGX0y22bSnvyCVr/VHBpEARw2pLl8HJv8g3GWRd/vYjH6bNDrZU4ftHOxKqW1xethx93cJi5KcFpH+c+OFjSbNQBQGy9D8RetYLjHrX397JM67y7dqcu8EQQsR6oL/jPTbCwkSs0yaXYmJtpSHSB3x8L25LF375KVvyPadBsO1JS+06IlaemHrik7nyIsyRUeF0eLGtopcD+NT4mrH2fC3ehtpcLQn9EYqdPFUNAgVXri0pkBXTect+chu1L+H/kFiEfeltu6YsEGWX69bbQYfOcjED7rk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44f3c18-8910-4e2f-4bcc-08d62518f302
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 08:04:00.4866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks a lot for your comments.
Please see my comments inline.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, September 27, 2018 9:25 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: Re: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging=
/
>=20
> On Thu, Sep 27, 2018 at 07:12:27PM +0800, Yangbo Lu wrote:
> > This patch is to move DPAA2 PTP driver out of staging/ since the
> > dpaa2-eth had been moved out.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/Kconfig             |    9 +--------
> >  drivers/net/ethernet/freescale/dpaa2/Kconfig       |   15
> +++++++++++++++
> >  drivers/net/ethernet/freescale/dpaa2/Makefile      |    6 ++++--
> >  .../ethernet/freescale/dpaa2}/dprtc-cmd.h          |    0
> >  .../rtc =3D> net/ethernet/freescale/dpaa2}/dprtc.c   |    0
> >  .../rtc =3D> net/ethernet/freescale/dpaa2}/dprtc.h   |    0
> >  .../rtc =3D> net/ethernet/freescale/dpaa2}/rtc.c     |    0
> >  .../rtc =3D> net/ethernet/freescale/dpaa2}/rtc.h     |    0
> >  drivers/staging/fsl-dpaa2/Kconfig                  |    8 --------
> >  drivers/staging/fsl-dpaa2/Makefile                 |    1 -
> >  drivers/staging/fsl-dpaa2/rtc/Makefile             |    7 -------
> >  11 files changed, 20 insertions(+), 26 deletions(-)  create mode
> > 100644 drivers/net/ethernet/freescale/dpaa2/Kconfig
> >  rename drivers/{staging/fsl-dpaa2/rtc =3D>
> > net/ethernet/freescale/dpaa2}/dprtc-cmd.h (100%)  rename
> > drivers/{staging/fsl-dpaa2/rtc =3D>
> > net/ethernet/freescale/dpaa2}/dprtc.c (100%)  rename
> > drivers/{staging/fsl-dpaa2/rtc =3D>
> > net/ethernet/freescale/dpaa2}/dprtc.h (100%)  rename
> > drivers/{staging/fsl-dpaa2/rtc =3D> net/ethernet/freescale/dpaa2}/rtc.c
> > (100%)  rename drivers/{staging/fsl-dpaa2/rtc =3D>
> > net/ethernet/freescale/dpaa2}/rtc.h (100%)
>=20
> Hi Yangbo
>=20
> Calling a ptp driver rtc.[ch] seems rather odd. Could you fixup the name,
> change it to ptp.[ch]. Also, some of the function names, and structures,
> rtc_probe->ptp_probe, rtc_remove->ptp_remove, rtc_match_id_table->
> ptp_match_id_table, etc.

[Y.b. Lu] Indeed, it's odd and confusing...
For dpaa2, all hardware resources are allocated and configured through the =
Management Complex (MC) portals.
MC abstracts most of these resources as DPAA2 objects and exposes ABIs thro=
ugh which they can be configured and controlled.
This ptp timer was named as rtc in MC firmware and APIs as you saw in dprtc=
.*.
So initially I wrote this driver using rtc as name.

No worries, let me change it in next version.

>=20
> ptp_dpaa2_adjfreq() probably should return err, not 0.
> ptp_dpaa2_gettime() again does not return the error.
> If fact, it seems like all the main functions ignore errors.

[Y.b. Lu] Will fix the returns in next version.

>=20
> kzalloc() could be changed to devm_kzalloc() to simplify the cleanup

[Y.b. Lu] Will use devm_kzalloc() in next version.

 Can
> ptp_dpaa2_caps be made const?

[Y.b. Lu] Yes. Will change it in next version.

> dpaa2_phc_index does not appear to be used.

[Y.b. Lu] It's used in dpaa2-ethtool.c for .get_ts_info interface of ethtoo=
l_ops.

> dev_set_drvdata(dev, NULL); is not needed.

[Y.b. Lu] Will remove it in next version.

> Can rtc_drv be made const?

[Y.b. Lu] Will use const in next version.

> Is rtc.h used by anything other than rtc.c? It seems like it can be remov=
ed.

[Y.b. Lu] Let me remove it in next version.

>=20
> It seems like there is a lot of code in dprtc.c which is unused. rtc.c do=
es nothing
> with interrupts for example. Do you plan to make use of this extra code? =
Or
> can it be removed leaving just what is needed?

[Y.b. Lu] Currently the ptp/rtc driver is not full-featured. The extra code=
 is being planed to be used.

>=20
> struct dprtc_cmd_get_irq - Putting pad at the beginning of a struct seems=
 very
> odd. And it is not the only example.

[Y.b. Lu] This should depended on MC firmware and APIs I think. Once the MC=
 improves this, the APIs could be updated to fix this.

>=20
>       Andrew
