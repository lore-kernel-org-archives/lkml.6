Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32451C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6540214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="JJlJTTes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6540214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeHVShs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:37:48 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:4893 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728682AbeHVShs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:37:48 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 23 Aug 2018 00:12:28 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id EEEC686E1A;
        Thu, 23 Aug 2018 00:12:27 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,274,1531753200"; 
   d="scan'208";a="290305108"
Received: from mail-os2jpn01lp0148.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.148])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2018 00:12:27 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GS01DzsplowfmcCchsH57GAXNFCZPbt6U7F8XIPcXE=;
 b=JJlJTTesGyzMWhPb9rAaSKgxWYeD0lqF0UneDjfHU0F3zPsNdu/1JYF/nD1vwAFIjlEtLvcLkJRla5tvdYq070WkT0GFV3jZ9BWKlvMHS9ILuQ0vuj4pYtJlzDiP9Zs/EubJd6KoGgn8bc885hdHZbhKP6rGQTjedZJyKzRRFtU=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB2959.jpnprd01.prod.outlook.com (20.177.102.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Wed, 22 Aug 2018 15:12:26 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::f94e:fc01:f90f:9f3e]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::f94e:fc01:f90f:9f3e%4]) with mapi id 15.20.1059.023; Wed, 22 Aug 2018
 15:12:26 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Simon Horman <horms@verge.net.au>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Topic: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Index: AQHUNjf7ffRVJL4Wf0OE3nhhLA8mh6TLnwIAgAA7dCA=
Date:   Wed, 22 Aug 2018 15:12:26 +0000
Message-ID: <TYAPR01MB2285834E95AB0D0D3E2C5B72B7300@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1534516703-11448-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180822104856.34nusjd4ajtwb4ef@verge.net.au>
In-Reply-To: <20180822104856.34nusjd4ajtwb4ef@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [193.141.219.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2959;20:fnGG7w4DIywkdDC+GH8cL1UZyuPjO4CZ+eYGKuDIcz3M9JDDtSre9TzjseDvSS9/g4MJYhEi3dJG8z7Ab5crf08C6st7zFUbcl2pULV4zAgDjwjRZveL7rqgzDPeYVqupSDxIWvQbkWJPnJ/zpmNKvb3frJn5htjYsygSrRGtK4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: c012f556-f925-4b21-4337-08d60841aba4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2959;
x-ms-traffictypediagnostic: TYAPR01MB2959:
x-microsoft-antispam-prvs: <TYAPR01MB295935A22240036317ED0947B7300@TYAPR01MB2959.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:TYAPR01MB2959;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2959;
x-forefront-prvs: 0772E5DAD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(66066001)(6436002)(6246003)(7696005)(8676002)(26005)(99286004)(97736004)(186003)(54906003)(76176011)(478600001)(53936002)(33656002)(55016002)(4326008)(9686003)(81166006)(6116002)(81156014)(72206003)(74316002)(25786009)(7736002)(5660300001)(3846002)(305945005)(7416002)(476003)(110136005)(2900100001)(5250100002)(86362001)(256004)(102836004)(105586002)(14444005)(2906002)(68736007)(229853002)(106356001)(11346002)(446003)(316002)(6506007)(14454004)(486006)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2959;H:TYAPR01MB2285.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9z2sISESnI+15Yj8xI9HQ5hfySx1qhFIWCgCa6C2ySuZyzuSthpue95HzoUjAdrIAb3pik6zAEZkuEZi7SVUoeKidBiwQJAMEx4hotxT82/u1+VkHrVRY4KnnqBUFH1lyBA8QNSR64+MLUChRtqb4YjUx9Nap5DEQh3c9Q1tCf1IGOfbNDAo/91fEAifcD6UafZ3GnsF3xlbp2Al8zK19orXTMg3UahivOvnxNOb/4yLyE70Bf3/nBguGl1KKOmuY179U33kC1kA6l7eEacRtY1RbwkVYT+UwqHTZtJdRf1EN1MrP/7EZjelj06MvIO/1xHnCuWcq2/Wdylpvgeex8DZVd1hLKJBX0d81cFfPUY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c012f556-f925-4b21-4337-08d60841aba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 15:12:26.3194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon,

> From: Simon Horman <horms@verge.net.au>
> Sent: 22 August 2018 11:49
>=20
> On Fri, Aug 17, 2018 at 03:38:23PM +0100, Fabrizio Castro wrote:
> > Document RZ/G2M (r8a774a1) SoC bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
>=20
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thank you.

>=20
> > ---
> > This patch applies on top of next-20180817
> >
> >  Documentation/devicetree/bindings/net/can/rcar_can.txt | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > index 94a7f33..84afc78 100644
> > --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
> > Required properties:
> >  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A=
7743
> SoC.
> >  	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 So=
C.
> > +	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 =
SoC.
> >  	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 So=
C.
> >  	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 So=
C.
> >  	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 So=
C.
> > @@ -16,7 +17,8 @@ Required properties:
> >  	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible dev=
ice.
> >  	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
> >  	      compatible device.
> > -	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible dev=
ice.
> > +	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
> > +	      compatible device.
> >  	      When compatible with the generic version, nodes must list the
> >  	      SoC-specific version corresponding to the platform first
> >  	      followed by the generic version.
> > @@ -24,7 +26,9 @@ Required properties:
> >  - reg: physical base address and size of the R-Car CAN register map.
> >  - interrupts: interrupt specifier for the sole interrupt.
> >  - clocks: phandles and clock specifiers for 3 CAN clock inputs.
> > -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk"=
.
> > +- clock-names: 2 clock input name strings for RZ/G2: "clkp1",
> > +"can_clk", and
>=20
> Minor comment: Personally I would start a new sentence at "and".
>=20
> Question: Is a driver update required so support 2-clock SoCs?

The driver will work okay as-is.

In theory CAN could be broken if renesas,can-clock-select is set to 0x1 (cl=
kp2) in the DT, as this value will be written to the CAN Clock Select Regis=
ter. However if the documentation is followed there will be no problems.

We should probably update the driver to fix this though, which will be a ch=
ange specific to all RZ/G2 devices, so perhaps we should also be adding a "=
renesas,rzg-gen2-can" family compatible string as well? (to driver and docu=
mentation)

Kind regards, Chris

>=20
> > +	       3 clock input name strings for every other SoC: "clkp1", "clkp=
2",
> > +	       "can_clk".
> >  - pinctrl-0: pin control group to be used for this controller.
> >  - pinctrl-names: must be "default".
> >
> > --
> > 2.7.4
> >
