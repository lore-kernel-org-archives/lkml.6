Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 583C1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A6B208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="K8yUCP6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A6B208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935572AbeFMQCQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:02:16 -0400
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:55680
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935408AbeFMQCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO1OK83zpxOs96CE+HqtcJcqz4nbHKg2qih4NtXdmjU=;
 b=K8yUCP6R2fO9bvckm9SYaU3ZRzK8G0WNl8ktXaMXo61XQc5E+arskZrDuiGp7ym9z9OJrzH1/Mxpxw90pNI92ilwiZ1a+hXryZgMLm5TRU5M5paBFhjMebrKKe02fmKHPM2gsQAZhek2PK0YAJh7YKaILpB69pmX8TbMb5Io0BQ=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB4297.namprd02.prod.outlook.com (20.176.104.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Wed, 13 Jun 2018 16:02:12 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::5560:23d:6ccf:b73d]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::5560:23d:6ccf:b73d%2]) with mapi id 15.20.0841.021; Wed, 13 Jun 2018
 16:02:12 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup return
 check
Thread-Topic: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup return
 check
Thread-Index: AQHUAuDSyxoj0rQvUUmR5matfG8OY6RdyqiAgACIQOA=
Date:   Wed, 13 Jun 2018 16:02:11 +0000
Message-ID: <DM6PR02MB4361C8FE169512A8C8E75E41C77E0@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528871719-1681-5-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180613072905.GE24314@lunn.ch>
In-Reply-To: <20180613072905.GE24314@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [183.83.203.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4297;7:4xVBVuzeGay7xu07+7HmCYSlBN9RsORUv9g0wtZKCZbPDXJL0RXSjyoVm1jg9DADAZlWqaJ3qiqMhYFjXOA5AdNBBtLmDjfutNN8xPgvkOpkn3RjEgdkcC6DYitVAIIzkF7OSmcKGQnM+vADBuyp1RG3PIZQ1mw8TRmWBIzuPfHrAFh/d592hXA8a6PTvBqQVl4fgSvzRteow0y4TdCChYNFb9ayWJi6EZ0Hh/J5bn0us7uwJZzEq2HyL5+fnzVd
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cefa051-6935-4368-3091-08d5d1470639
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4297;
x-ms-traffictypediagnostic: DM6PR02MB4297:
x-microsoft-antispam-prvs: <DM6PR02MB429708EB3D4C637322876F44C77E0@DM6PR02MB4297.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4297;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4297;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(13464003)(199004)(189003)(51914003)(54906003)(55016002)(4326008)(59450400001)(6506007)(53546011)(486006)(105586002)(106356001)(11346002)(102836004)(97736004)(76176011)(7696005)(446003)(476003)(81166006)(86362001)(81156014)(7736002)(6436002)(8676002)(8936002)(316002)(3280700002)(575784001)(68736007)(33656002)(3660700001)(2906002)(3846002)(5660300001)(66066001)(6116002)(74316002)(305945005)(478600001)(99286004)(229853002)(25786009)(9686003)(186003)(2900100001)(5250100002)(14454004)(6916009)(26005)(53936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4297;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HD1ZFTNVxhx1uzHn8FaZVnRm0q7Zz+pCfDAn6k077vmqokU6qnXeqTvtRGTmJy/WM3WvarDltA+LRrqq6J8g//MedixGmkeq1sjlQD78So8KHCZcxYBcg1HKBAdSxxrpEcCOPfbnL17XaGqQk3/NUMrHprVoXpsq6G71Y3QJdiu0UovtoJlCLW7y2ne1WmeQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cefa051-6935-4368-3091-08d5d1470639
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 16:02:11.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Wednesday, June 13, 2018 12:59 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: davem@davemloft.net; michal.simek@xilinx.com;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup retur=
n
> check
>=20
> On Wed, Jun 13, 2018 at 12:05:19PM +0530, Radhey Shyam Pandey wrote:
> > Errors are already reported in xemaclite_mdio_setup so avoid
> > reporting it again.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > index ec4608e..2a0c06e 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > @@ -1143,9 +1143,7 @@ static int xemaclite_of_probe(struct
> platform_device *ofdev)
> >  	xemaclite_update_address(lp, ndev->dev_addr);
> >
> >  	lp->phy_node =3D of_parse_phandle(ofdev->dev.of_node, "phy-
> handle", 0);
> > -	rc =3D xemaclite_mdio_setup(lp, &ofdev->dev);
> > -	if (rc)
> > -		dev_warn(&ofdev->dev, "error registering MDIO bus\n");
> > +	xemaclite_mdio_setup(lp, &ofdev->dev);
> >
> >  	dev_info(dev, "MAC address is now %pM\n", ndev->dev_addr);
>=20
> The patch itself is O.K.
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>=20
> However, do you want to keep going if the MDIO bus fails? Maybe you
> should failed the probe?
Thanks for the review. Yes, I will fix it in next series.

-Radhey
>=20
>     Andrew
