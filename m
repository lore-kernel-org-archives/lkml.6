Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB3C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356992054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ol5LUrUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356992054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeLNIMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:12:03 -0500
Received: from mail-eopbgr1410119.outbound.protection.outlook.com ([40.107.141.119]:44128
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbeLNIMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4D8rpy2y6A/UM4t0BJDU8iS7gB8rexyqupU3CZbKbs=;
 b=ol5LUrUhtk9fL/s+94IpRzb/DM4A8+PQujBhH30V2EF/fP09fuOsM6zAEOgdGxvRRlPeot/1oZohVXKSHcZB4inFori+QhCfAPGtaBY2Q4rQEKj7MG/661jfLM9vKpcucveCGJHLIC/9Nz8wo/D37BhVa6qMqKv5cWXVh7w2LqE=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1629.jpnprd01.prod.outlook.com (52.133.167.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 08:11:56 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::64fb:82d3:31d2:1a12]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::64fb:82d3:31d2:1a12%2]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:11:56 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] drm: rcar-du: lvds: add R8A774C0 support
Thread-Topic: [PATCH] drm: rcar-du: lvds: add R8A774C0 support
Thread-Index: AQHUkyG9PM5JudpEokOEN6UKbQHSxaV9MfiAgACw9cA=
Date:   Fri, 14 Dec 2018 08:11:55 +0000
Message-ID: <TYXPR01MB177586488BBE3A0995E68F5EC0A10@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732616-7322-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <19818144.G1rqBgM4ba@avalon>
In-Reply-To: <19818144.G1rqBgM4ba@avalon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1629;20:xpUBmtmYbUaYoIzDJvzlXkzQazKDA5q9ErhLW9uFJUSTXRpKQngFJTCqzUgX6OJwRJ1jHzReFqIHThK29Qu9E0lRrJpIyVgLOjLD7VJpLeXfcvhssYX7yJjXY4DZgR5wvtpUGME7bP/jSWSkFrG+p6Khnwtmx8VDhCceHFwEBHM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 63eb6537-f758-48c7-ec60-08d6619bd039
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1629;
x-ms-traffictypediagnostic: TYXPR01MB1629:
x-microsoft-antispam-prvs: <TYXPR01MB16299A59525BF3111A8404FDC0A10@TYXPR01MB1629.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYXPR01MB1629;BCL:0;PCL:0;RULEID:;SRVR:TYXPR01MB1629;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(39860400002)(366004)(13464003)(189003)(199004)(76176011)(106356001)(102836004)(26005)(256004)(10126004)(4326008)(3846002)(5660300001)(54906003)(86362001)(6916009)(71190400001)(186003)(229853002)(2906002)(6116002)(71200400001)(6306002)(81156014)(9686003)(7696005)(8676002)(53546011)(44832011)(81166006)(486006)(105586002)(6506007)(345774005)(55016002)(316002)(14454004)(8936002)(478600001)(99286004)(33656002)(6436002)(107886003)(6246003)(53936002)(74316002)(97736004)(446003)(11346002)(66066001)(25786009)(305945005)(68736007)(7736002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1629;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q2NoKNJIa49AwrUUwf6nWIkoqsNCUy+83wqODsINLPzOpwJTtgdlMaSvXrOjGGJlumONN9oje7NxF11CkyvSrDE4ZzE+7J4JMqI8xjQIkFccbsF3mx5EH0ZETf0HF4mGUQWLAtADlk1St7gl4IdVGWn27dx4FlOeqlGAzRUaf7GGypIgVSiSSLo1+O+4UZgNV2AbJYkXZ9ye6flusnxnWB5uwy/2vIfyu703YZLULNFrVrEG6IXDm+Vqp5how6f0qJqkDsJtssfZJWIs8UtWyODftZfNfzDPs4IQ5VVOsDV8uVYGw+a+x/g7N2Af1AbM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eb6537-f758-48c7-ec60-08d6619bd039
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:11:55.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

> -----Original Message-----
> From: linux-renesas-soc-owner@vger.kernel.org <linux-renesas-soc-owner@vg=
er.kernel.org> On Behalf Of Laurent Pinchart
> Sent: 13 December 2018 21:38
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: David Airlie <airlied@linux.ie>; Kieran Bingham <kieran.bingham+renes=
as@ideasonboard.com>; dri-devel@lists.freedesktop.org;
> linux-renesas-soc@vger.kernel.org; linux-kernel@vger.kernel.org; Simon Ho=
rman <horms@verge.net.au>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson <Chris.Paterson2@renesas.com>; =
Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [PATCH] drm: rcar-du: lvds: add R8A774C0 support
>
> Hi Fabrizio,
>
> Thank you for the patch.
>
> On Thursday, 13 December 2018 22:23:36 EET Fabrizio Castro wrote:
> > The LVDS implementation on the RZ/G2E (a.k.a. R8A774C0) is very similar
> > to the one found on R-Car E3 (a.k.a. R8A77990), therefore add RZ/G2E
> > LVDS support to the LVDS encoder driver in a similar fashion to what
>
> s/what/what is/
>
> > done for R-Car E3.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> and applied to my tree with the above fix.

Thank you for fixing.

Fab

>
> > ---
> >  drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > b/drivers/gpu/drm/rcar-du/rcar_lvds.c index 173d7ad..329dfca 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > @@ -785,6 +785,7 @@ static const struct rcar_lvds_device_info
> > rcar_lvds_r8a77995_info =3D {
> >
> >  static const struct of_device_id rcar_lvds_of_table[] =3D {
> >  { .compatible =3D "renesas,r8a7743-lvds", .data =3D &rcar_lvds_gen2_in=
fo },
> > +{ .compatible =3D "renesas,r8a774c0-lvds", .data =3D &rcar_lvds_r8a779=
90_info
> > }, { .compatible =3D "renesas,r8a7790-lvds", .data =3D &rcar_lvds_r8a77=
90_info
> > }, { .compatible =3D "renesas,r8a7791-lvds", .data =3D &rcar_lvds_gen2_=
info },
> > { .compatible =3D "renesas,r8a7793-lvds", .data =3D &rcar_lvds_gen2_inf=
o },
>
>
> --
> Regards,
>
> Laurent Pinchart
>
>



[https://www2.renesas.eu/media/email/unicef.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
