Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A7520644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="b9M7SrvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A7520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeH3HBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:01:17 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:19892 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727042AbeH3HBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:01:17 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie2.idc.renesas.com with ESMTP; 30 Aug 2018 12:01:19 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id A02F4761CF;
        Thu, 30 Aug 2018 12:01:19 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,306,1531753200"; 
   d="scan'208";a="289468659"
Received: from mail-ty1jpn01lp0178.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.178])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2018 12:01:19 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvYdXIb7qbXlH3XhFWTqP1qBuqGWoWUJMc7SSjxI6Pc=;
 b=b9M7SrvTNfpbiXiLLa99DlmT2q9HhZkK+4HhLKuNxr8fFYA7+ugc0HremDpnOAjo315V/v5k+ETyEYSh25EFdU59vQwYImwbkEqbAMeJWoFftvtsmuc01aRAHa/8YdQWWF8csFt8WBLon+yCjwhdpTbyEJZZRYLROGISDaKrGj0=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB1607.jpnprd01.prod.outlook.com (52.134.226.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 30 Aug 2018 03:01:16 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::64ba:c30f:4366:5723]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::64ba:c30f:4366:5723%2]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 03:01:16 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/6] Document r8a774a1 USB bindings
Thread-Topic: [PATCH 0/6] Document r8a774a1 USB bindings
Thread-Index: AQHUO3/2vzNSxIcUMkG5XZ/cZSb19KTXo5Iw
Date:   Thu, 30 Aug 2018 03:01:15 +0000
Message-ID: <OSBPR01MB22938FC34C6AD58FF8A5B285D8080@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1607;20:UFQRw8JgUFXnVIGRf48aDorZg0MFtCLpCryFf1lZWWidn/sWmf7NCAUI3l3X1H5fKyLXh07g+kv5aXRDzOhsm+YH63JQJJqkpw12UqGkfj1VwamYdDLPn5XryVX098DzOvELTRextgNHjfHC0Hfh4XuWm3qXlApqUZ0VlSf4930=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 884b708a-9d0d-4f10-4605-08d60e24da5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1607;
x-ms-traffictypediagnostic: OSBPR01MB1607:
x-microsoft-antispam-prvs: <OSBPR01MB1607CB4B203903C79889967ED8080@OSBPR01MB1607.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(31051911155226)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:OSBPR01MB1607;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1607;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(106356001)(486006)(76176011)(446003)(256004)(99286004)(316002)(6506007)(7696005)(11346002)(476003)(4326008)(110136005)(345774005)(54906003)(53546011)(6246003)(74316002)(7416002)(305945005)(7736002)(2906002)(26005)(86362001)(25786009)(53936002)(5250100002)(105586002)(81156014)(6116002)(229853002)(9686003)(478600001)(3846002)(81166006)(33656002)(66066001)(97736004)(2900100001)(8676002)(5660300001)(6436002)(102836004)(8936002)(14454004)(55016002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1607;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bB6ZeQFv+qCooDKIZkFy7vPZ26fNdueeXypIXuCEPIQT7IxJ7bVIA3VthJLDp34aKkxq3ZUHPLOF+vC6nKTRJSguDWDV8+erOdM+dWUl52EeC3/MHE+2aJWDDT2NxN80xsb0T27+0Ia/XZUTLUObVOcGbmOtjrk/zMBU0iT8lyAZC+7Ilca8HIr5mCxzkE/52sq2oli+5W7gR8fKKD66KKw4Xn19GhtryrNAeEMFUcBx0OtxSa/Kx3UrkpZ5V6haOF1BXC0u4hxJLvPv+pqkkceADWKCYI9a/ZsjnmW7s76ahLEvTUfyN/kIsGAou6tSCYrgDjDLFlBHTDuENBfUxISr8WJe6wtNNkFcIZPrLzo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884b708a-9d0d-4f10-4605-08d60e24da5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 03:01:16.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio-san,

> From: Fabrizio Castro, Sent: Friday, August 24, 2018 4:56 PM
> To: Vinod Koul <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark=
 Rutland <mark.rutland@arm.com>
> Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>; Greg Kroah-Hartman =
<gregkh@linuxfoundation.org>; Kishon Vijay
> Abraham I <kishon@ti.com>; Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesa=
s.com>; Biju Das <biju.das@bp.renesas.com>;
> dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-usb@vger.ker=
nel.org; Simon Horman <horms@verge.net.au>;
> Geert Uytterhoeven <geert+renesas@glider.be>; Chris Paterson <Chris.Pater=
son2@renesas.com>;
> linux-renesas-soc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 0/6] Document r8a774a1 USB bindings
>=20
> Dear All,
>=20
> this series aims at documenting USB related dt-bindings for the
> r8a774a1.
>=20
> Applies on next-20180823.
>=20
> Thanks,
> Fab
>=20
> Biju Das (1):
>   dt-bindings: dmaengine: usb-dmac: Add binding for r8a774a1
>=20
> Fabrizio Castro (5):
>   dt-bindings: rcar-gen3-phy-usb2: Add r8a774a1 support
>   dt-bindings: rcar-gen3-phy-usb3: Add r8a774a1 support
>   dt-bindings: usb-xhci: Add r8a774a1 support
>   dt-bindings: usb: renesas_usbhs: Add r8a774a1 support
>   usb: gadget: udc: renesas_usb3: Add r8a774a1 support

Thank you for the patch.
For this series:

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

