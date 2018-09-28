Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AD3C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF062172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G+1Ulla9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF062172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeI1QoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:44:09 -0400
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:12960
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729193AbeI1QoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZWbCPuJpq0l83ilWslB5ozgHnecMhWSys7Z86Mnsi8=;
 b=G+1Ulla9tUyjqAkkz4qzNl1PQH8rC5Vq25mELOBfGx+eQw5A6eMQnWSwSgtC3PA2aPX3bEI/8jbRttPCVTD4wR+9esCdOob54C6tz1583vKCKXxMy1709CeqbjXXATFWlG1cjt0rKc+J3r0NsxsU3E0y4yLVf1B9JEualB0Y7m4=
Received: from DBXPR04MB349.eurprd04.prod.outlook.com (10.141.13.144) by
 DBXPR04MB413.eurprd04.prod.outlook.com (10.141.15.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 10:20:56 +0000
Received: from DBXPR04MB349.eurprd04.prod.outlook.com
 ([fe80::bcbd:c728:a686:13d4]) by DBXPR04MB349.eurprd04.prod.outlook.com
 ([fe80::bcbd:c728:a686:13d4%11]) with mapi id 15.20.1185.022; Fri, 28 Sep
 2018 10:20:55 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>, Andrew Lunn <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Topic: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Index: AQHUVlODydoczAdnGUGD+YTbzcfAFKUEHlyAgAE4nQCAACKAAA==
Date:   Fri, 28 Sep 2018 10:20:55 +0000
Message-ID: <DBXPR04MB3490DB9A1EF2D814568843B94EC0@DBXPR04MB349.eurprd04.prod.outlook.com>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
 <20180927132507.GB23375@lunn.ch>
 <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBXPR04MB413;6:LBSzONnauteNAToBSmo6PaHWH5cIekwNYjX318ruMEJjtm+qT5Ws40ZTG/H89HaPAyrTfu69/tECGlKOnPZZZbdfNn7QO7OQN6rSbG7ak5gxUSKGxksCDA8Nd+KYo2qOgjv+mjoj1XklleDejojmRCycscqgtSNATXkTdA5luLxrrC0yfuhyOhCEIBwalllVE3NVClPUCHF1iRMDY6ziRLAJCbnlPfjN/G9yrsinXc6Ghm/pz4dO/eYnE9xoFWFa6BRhCBygT5/edY6J9v2BXswk/KEd7IDME0mpzC59jwPxjg9IC4XXEn8f6XhHyiagnbCOMEeZ885/dohJw48Dv4It9kUGiiZJt3wY0RP5p34ebeRnGrpGraYnCmVR6iBtAaBbdqwi09Aj1auYB+vhideFQZVZTEvth5GJIbLLADdlghNNmCRLJKFRqd648jzqjmfGMSCbt06aCXHKqRx8Kg==;5:ghX9ERAOLOcLx7dNflZgl3oE06Ps/XExCOnfNN8ne34w5nwNEU+Vfsf+K+g+hHL3Hd0rmTJ8U28wnyugAjSwj7uUJ+AgSsnFnMYKvG902r6udCmeBCuIt0b0oUHK2aDVcGPKTV0+zhfAtxOe7AhMMPcV3Rv9xmHDOWiBhaRIWkQ=;7:OYwo2TzKYcfw7MMKJlk4raOAfFnnPoIAf4ROozGmHNNS3iDZs5Z9emuyfkvIFP1HXYJw5f3HJ2Krlg4a1BHjU7O+fUr4C9+SiMx5yLxR7h4nea3TsJRAubAdtaigGktxjUS05foCsVSdoenvri4MeH1uSpFnbK+9YNVhNbIMM47V2PNnIKkzy89IxKnLGKNR8hzJu7XGKbXUN2sjsM7iE/5zId3nmYUWmW8t3c8V+TlsNHUMW+fHC0j0ZVcwV22q
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2641f0af-fc29-4231-c1e8-08d6252c13c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBXPR04MB413;
x-ms-traffictypediagnostic: DBXPR04MB413:
x-microsoft-antispam-prvs: <DBXPR04MB4138B1B68773EB2A5A0FC3A94EC0@DBXPR04MB413.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DBXPR04MB413;BCL:0;PCL:0;RULEID:;SRVR:DBXPR04MB413;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(13464003)(189003)(7696005)(5250100002)(3846002)(5660300001)(14454004)(25786009)(6436002)(86362001)(106356001)(478600001)(105586002)(53546011)(6506007)(9686003)(55016002)(53936002)(99286004)(11346002)(71190400001)(2900100001)(446003)(71200400001)(6116002)(76176011)(33656002)(316002)(486006)(476003)(7736002)(256004)(97736004)(102836004)(229853002)(81166006)(81156014)(8936002)(305945005)(6246003)(8676002)(66066001)(2906002)(74316002)(26005)(39060400002)(54906003)(34290500001)(68736007)(4326008)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR04MB413;H:DBXPR04MB349.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S8y8hyP0YP660MhoBawrwpRLi7PZNnj/Hg5bFh02RJkpVCcopQyO5idCeSpp94ZgxWTGkzYobi663vlfbjNbpjH5EHnrmSfdENdf2E2yCbZvtWQDEChfzm+UdSMSW6iWuTrYyQYPN6ztcRu7qnRh7HsVexskUttUaxoJKzu68do9bVRaehQqSnf2tUY8Us1eZ6w0YNEEB+5x/EnHhPSbhG1K0qY1jPfZobfCvRRLngbDRGMHvJtprXfrWXM8iQpGLwclLB6pixBbbTWEUJrEsrA41XepZDzjFbsM04oHl13y1B91+Eaqtq+3ghq+POftP4szXIY64Be1lSO38d+NeQgK3EM4b4+HtS3NS2DIP3g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2641f0af-fc29-4231-c1e8-08d6252c13c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 10:20:55.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR04MB413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Y.b. Lu
> Sent: Friday, September 28, 2018 11:04 AM
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging=
/
>=20
> Hi Andrew,
>=20
> Thanks a lot for your comments.
> Please see my comments inline.
>=20
> Best regards,
> Yangbo Lu
>=20
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Thursday, September 27, 2018 9:25 PM
> > To: Y.b. Lu <yangbo.lu@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> > netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> > David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> > <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>
> > Subject: Re: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of
> staging/
> >
> > On Thu, Sep 27, 2018 at 07:12:27PM +0800, Yangbo Lu wrote:
> > > This patch is to move DPAA2 PTP driver out of staging/ since the
> > > dpaa2-eth had been moved out.
> > >
> > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > ---
> > >  drivers/net/ethernet/freescale/Kconfig             |    9 +--------
> > >  drivers/net/ethernet/freescale/dpaa2/Kconfig       |   15
> > +++++++++++++++
> > >  drivers/net/ethernet/freescale/dpaa2/Makefile      |    6 ++++--
> > >  .../ethernet/freescale/dpaa2}/dprtc-cmd.h          |    0
> > >  .../rtc =3D> net/ethernet/freescale/dpaa2}/dprtc.c   |    0
> > >  .../rtc =3D> net/ethernet/freescale/dpaa2}/dprtc.h   |    0
> > >  .../rtc =3D> net/ethernet/freescale/dpaa2}/rtc.c     |    0
> > >  .../rtc =3D> net/ethernet/freescale/dpaa2}/rtc.h     |    0
> > >  drivers/staging/fsl-dpaa2/Kconfig                  |    8 --------
> > >  drivers/staging/fsl-dpaa2/Makefile                 |    1 -
> > >  drivers/staging/fsl-dpaa2/rtc/Makefile             |    7 -------
> > >  11 files changed, 20 insertions(+), 26 deletions(-)  create mode
> > > 100644 drivers/net/ethernet/freescale/dpaa2/Kconfig
> > >  rename drivers/{staging/fsl-dpaa2/rtc =3D>
> > > net/ethernet/freescale/dpaa2}/dprtc-cmd.h (100%)  rename
> > > drivers/{staging/fsl-dpaa2/rtc =3D>
> > > net/ethernet/freescale/dpaa2}/dprtc.c (100%)  rename
> > > drivers/{staging/fsl-dpaa2/rtc =3D>
> > > net/ethernet/freescale/dpaa2}/dprtc.h (100%)  rename
> > > drivers/{staging/fsl-dpaa2/rtc =3D> net/ethernet/freescale/dpaa2}/rtc=
.c
> > > (100%)  rename drivers/{staging/fsl-dpaa2/rtc =3D>
> > > net/ethernet/freescale/dpaa2}/rtc.h (100%)
> >
> > Hi Yangbo
> >
> > Calling a ptp driver rtc.[ch] seems rather odd. Could you fixup the nam=
e,
> > change it to ptp.[ch]. Also, some of the function names, and structures=
,
> > rtc_probe->ptp_probe, rtc_remove->ptp_remove, rtc_match_id_table->
> > ptp_match_id_table, etc.
>=20
> [Y.b. Lu] Indeed, it's odd and confusing...
> For dpaa2, all hardware resources are allocated and configured through th=
e
> Management Complex (MC) portals.
> MC abstracts most of these resources as DPAA2 objects and exposes ABIs
> through which they can be configured and controlled.
> This ptp timer was named as rtc in MC firmware and APIs as you saw in
> dprtc.*.
> So initially I wrote this driver using rtc as name.
>=20
> No worries, let me change it in next version.
>=20
> >
> > ptp_dpaa2_adjfreq() probably should return err, not 0.
> > ptp_dpaa2_gettime() again does not return the error.
> > If fact, it seems like all the main functions ignore errors.
>=20
> [Y.b. Lu] Will fix the returns in next version.
>=20
> >
> > kzalloc() could be changed to devm_kzalloc() to simplify the cleanup
>=20
> [Y.b. Lu] Will use devm_kzalloc() in next version.
>=20
>  Can
> > ptp_dpaa2_caps be made const?
>=20
> [Y.b. Lu] Yes. Will change it in next version.
>=20
> > dpaa2_phc_index does not appear to be used.
>=20
> [Y.b. Lu] It's used in dpaa2-ethtool.c for .get_ts_info interface of
> ethtool_ops.
>=20
> > dev_set_drvdata(dev, NULL); is not needed.
>=20
> [Y.b. Lu] Will remove it in next version.
>=20
> > Can rtc_drv be made const?
>=20
> [Y.b. Lu] Will use const in next version.
>=20
> > Is rtc.h used by anything other than rtc.c? It seems like it can be rem=
oved.
>=20
> [Y.b. Lu] Let me remove it in next version.
>=20
> >
> > It seems like there is a lot of code in dprtc.c which is unused. rtc.c =
does
> nothing
> > with interrupts for example. Do you plan to make use of this extra code=
? Or
> > can it be removed leaving just what is needed?
>=20
> [Y.b. Lu] Currently the ptp/rtc driver is not full-featured. The extra co=
de is
> being planed to be used.

Are there any interrupts associated to the real time clock module that will
actually be used by the driver? Also, I don't think the create/destroy func=
tions
are meant to be used by the PTP kernel driver, even though MC exposes the
APIs for them.

Generally speaking, I think it's better to remove unused code from the curr=
ent
driver and re-add it along with the feature actually using it.
=20
>=20
> >
> > struct dprtc_cmd_get_irq - Putting pad at the beginning of a struct see=
ms
> very
> > odd. And it is not the only example.
>=20
> [Y.b. Lu] This should depended on MC firmware and APIs I think. Once the
> MC improves this, the APIs could be updated to fix this.

These structures map the command format expected by the MC firmware. I
agree that some of the command layouts are less than inspired, but I'm not
sure we can expect MC to "improve" them without a good reason, as this woul=
d
break backward compatibility.

I also want to bring up the question of where the dpaa2 ptp driver should b=
e
located. The qoriq_ptp driver (which targets previous gen Freescale/NXP
architectures) is located in drivers/ptp. I'm not sure if the dpaa2 ptp dri=
ver should
be moved there as well or it's better suited for the currently proposed loc=
ation.

Thanks,
Ioana
