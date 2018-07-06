Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF67CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6263A21205
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LGTvAedT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6263A21205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeGFS5Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:57:24 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:40032
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934201AbeGFS5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGTgoiV2jo9AcuY5vf/ZmCZnn23nAaciOxGmMBcxxmQ=;
 b=LGTvAedTRhQFzCgaWKFNgUp6PPmX3HhLJGDnWU9v7hdPynwZ4XHPFzTF5PA1iyds0yELLS98KBNOLAafOxXcANQ1AcJdeppqPLYFYvBUZN/sCm4eEjIAuAJ+UvTjAuJCOhJZiNs8ACQL+7eHQ2slMVMUfbwcw2xTNzNs2YbW0tk=
Received: from AM3PR04MB338.eurprd04.prod.outlook.com (10.242.110.15) by
 AM3PR04MB1361.eurprd04.prod.outlook.com (10.163.185.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Fri, 6 Jul 2018 18:57:19 +0000
Received: from AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::84f9:3f8e:a8c7:1720]) by AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::84f9:3f8e:a8c7:1720%10]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 18:57:19 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH 0/2] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Thread-Topic: [PATCH 0/2] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Thread-Index: AQHUFJgtMRuXJ8mvPEGdOgjBQpkT8qSCjKbg
Date:   Fri, 6 Jul 2018 18:57:19 +0000
Message-ID: <AM3PR04MB338125F44EC72982F0F128694470@AM3PR04MB338.eurprd04.prod.outlook.com>
References: <20180705194113.16256-1-roy.pledge@nxp.com>
 <VI1PR0402MB34853F03375D3BCA4791432698470@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <VI1PR04MB4494A72D6734ECAA57BA93C586470@VI1PR04MB4494.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4494A72D6734ECAA57BA93C586470@VI1PR04MB4494.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1361;7:mhPjvfdaZUlaxTaNfiKiPoxbfZdzm6grUh3L0WlYLZDLzGEZfFK5bjfA2Vocy7sBuXunqNZ1CmwH/RSUZIq/5ViLGg3Hha8yUTgHZskIHd3na+OgFipVXHjEd/daCZ6AfBdUZF1uBNeXhc37qR8iivTYcLulGCXF4nmAI4j/AwaB9ZcqLhx5KkeIwsYIqrviz4hpwam3qte/nbCwyFBawp3jYKJgEgefMojtkedOnJVltIKry3Dwwol5uLxPGveg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86ba4a01-23f3-4aac-2001-08d5e3724cee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1361;
x-ms-traffictypediagnostic: AM3PR04MB1361:
x-microsoft-antispam-prvs: <AM3PR04MB1361E5EEB0CB7E355EF0D84B94470@AM3PR04MB1361.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231291)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1361;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1361;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(13464003)(68736007)(74316002)(7696005)(6436002)(7736002)(106356001)(55016002)(229853002)(305945005)(105586002)(33656002)(6636002)(14444005)(256004)(5660300001)(76176011)(2501003)(5250100002)(9686003)(26005)(6506007)(575784001)(4326008)(86362001)(102836004)(11346002)(25786009)(3846002)(6116002)(53936002)(2201001)(66066001)(486006)(97736004)(53546011)(110136005)(2906002)(2900100001)(478600001)(8676002)(54906003)(81156014)(81166006)(446003)(476003)(14454004)(99286004)(6246003)(8936002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1361;H:AM3PR04MB338.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q8Rr+kas1cghBGAqaeKtdUMBf2OEFCFSEMKHZs2IwBvejaKascw0zHoQdYZL19S9hMQbEIIQ/npnX7ozNz0uJRbL5I9+Vu/Be5fV5Xv0mEwWe/PZdj2cLE3j2QoehbKZ7t4pEa8oO4X1EOAPI/P9IX9n1JDhKNYI8HN/XE1C+7IzoauizIGQ4s+DFTFw69LaJVQFmX8TGfS3CCgBMStnlmMuikxOA/OP2bqVAKVV2LmcMp5Vo7KBOGkn9Sd8qE0AE6hWZXJI77DUsQX4+3po2YN4Os6s+7XnyYzGdrQcioBMGdDcx/YBUwNyZDUNY0MSHr033pyxPMbI55JpdcQtTHSqMrvFQ9phGcAJGMZLEw8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ba4a01-23f3-4aac-2001-08d5e3724cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 18:57:19.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Roy Pledge
> Sent: Friday, July 6, 2018 9:52 PM
> To: Horia Geanta <horia.geanta@nxp.com>; devel@driverdev.osuosl.org;
> linux-arm-kernel@lists.infradead.org; gregkh@linuxfoundation.org; Leo Li
> <leoyang.li@nxp.com>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>; linux-
> kernel@vger.kernel.org; arnd@arndb.de; catalin.marinas@arm.com;
> robin.murphy@arm.com
> Subject: Re: [PATCH 0/2] staging/fsl-mc/bus: Move DPIO from staging to
> drivers/soc/fsl
>=20
> On 7/6/2018 8:25 AM, Horia Geanta wrote:
> > On 7/5/2018 10:41 PM, Roy Pledge wrote:
> >> Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-
> mc/bus/dpio
> >> directory to the drivers/soc/fsl directory.
> >>
> >> The DPIO driver enables access to the Queue and Buffer Managemer
> (QBMAN)
> >> hardware of NXP DPAA2 devices. This is a prerequiste for moving the
> DPAA2
> >> Ethernet device driver from the staging directory.
> >>
> > Roy, Ioana,
> >
> > Would it be ok to add the following patch on top of the series?
> > It's a dependency for dpseci object.
> > If not added now I fear it won't be accepted until dpaa2-ethernet
> > moves out of staging, thus gating dpseci upstreaming.
> >
> > Thanks,
> > Horia
> I can add this to the series - I will respin and send a v2.

Roy, when you send the v2 you can also add for this patch:

Acked-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>

> >
> > --->8---
> > Previous commits:
> > 6e2387e8f19ed ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet
> driver")
> > 39163c0ce0f48 ("staging: fsl-dpaa2/eth: Errors checking update")
> > added bits that are not specific to the WRIOP accelerator.
> >
> > Move these where they belong (in DPIO) such that other accelerators
> > can make use of them.
> >
> > Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>
> > ---
> >  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  4 ++--
> >  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 18 +++++-------------
> >  drivers/staging/fsl-mc/include/dpaa2-fd.h      | 12 ++++++++++++
> >  3 files changed, 19 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > index 396371728aa1..d5f0ac5c2d1f 100644
> > --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > @@ -455,7 +455,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
> >  	dpaa2_fd_set_format(fd, dpaa2_fd_sg);
> >  	dpaa2_fd_set_addr(fd, addr);
> >  	dpaa2_fd_set_len(fd, skb->len);
> > -	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA |
> DPAA2_FD_CTRL_PTV1);
> > +	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);
> >
> >  	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags &
> SKBTX_HW_TSTAMP)
> >  		enable_tx_tstamp(fd, sgt_buf);
> > @@ -508,7 +508,7 @@ static int build_single_fd(struct dpaa2_eth_priv
> *priv,
> >  	dpaa2_fd_set_offset(fd, (u16)(skb->data - buffer_start));
> >  	dpaa2_fd_set_len(fd, skb->len);
> >  	dpaa2_fd_set_format(fd, dpaa2_fd_single);
> > -	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA |
> DPAA2_FD_CTRL_PTV1);
> > +	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);
> >
> >  	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags &
> SKBTX_HW_TSTAMP)
> >  		enable_tx_tstamp(fd, buffer_start);
> > diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> > index 905a4e6be8fa..9269cb05a84b 100644
> > --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> > +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> > @@ -124,21 +124,13 @@ struct dpaa2_eth_swa {
> >  #define DPAA2_FD_FRC_FAICFDV		0x0400
> >
> >  /* Error bits in FD CTRL */
> > -#define DPAA2_FD_CTRL_UFD		0x00000004
> > -#define DPAA2_FD_CTRL_SBE		0x00000008
> > -#define DPAA2_FD_CTRL_FSE		0x00000020
> > -#define DPAA2_FD_CTRL_FAERR		0x00000040
> > -
> > -#define DPAA2_FD_RX_ERR_MASK		(DPAA2_FD_CTRL_SBE	| \
> > -					 DPAA2_FD_CTRL_FAERR)
> > -#define DPAA2_FD_TX_ERR_MASK		(DPAA2_FD_CTRL_UFD	| \
> > -					 DPAA2_FD_CTRL_SBE	| \
> > -					 DPAA2_FD_CTRL_FSE	| \
> > -					 DPAA2_FD_CTRL_FAERR)
> > +#define DPAA2_FD_RX_ERR_MASK		(FD_CTRL_SBE |
> FD_CTRL_FAERR)
> > +#define DPAA2_FD_TX_ERR_MASK		(FD_CTRL_UFD	| \
> > +					 FD_CTRL_SBE	| \
> > +					 FD_CTRL_FSE	| \
> > +					 FD_CTRL_FAERR)
> >
> >  /* Annotation bits in FD CTRL */
> > -#define DPAA2_FD_CTRL_PTA		0x00800000
> > -#define DPAA2_FD_CTRL_PTV1		0x00400000
> >  #define DPAA2_FD_CTRL_ASAL		0x00020000	/* ASAL =3D
> 128B */
> >
> >  /* Frame annotation status */
> > diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/stagin=
g/fsl-
> mc/include/dpaa2-fd.h
> > index b55b89ba4eda..2576abaa7779 100644
> > --- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
> > +++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h
> > @@ -67,6 +67,18 @@ struct dpaa2_fd {
> >  #define SG_FINAL_FLAG_MASK	0x1
> >  #define SG_FINAL_FLAG_SHIFT	15
> >
> > +/* Error bits in FD CTRL */
> > +#define FD_CTRL_ERR_MASK	0x000000FF
> > +#define FD_CTRL_UFD		0x00000004
> > +#define FD_CTRL_SBE		0x00000008
> > +#define FD_CTRL_FLC		0x00000010
> > +#define FD_CTRL_FSE		0x00000020
> > +#define FD_CTRL_FAERR		0x00000040
> > +
> > +/* Annotation bits in FD CTRL */
> > +#define FD_CTRL_PTA		0x00800000
> > +#define FD_CTRL_PTV1		0x00400000
> > +
> >  enum dpaa2_fd_format {
> >  	dpaa2_fd_single =3D 0,
> >  	dpaa2_fd_list,
>=20

