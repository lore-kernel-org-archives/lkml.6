Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F06C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F97020883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="WiiLcMzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F97020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKHWYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:24:12 -0500
Received: from mail-ty1jpn01on0132.outbound.protection.outlook.com ([104.47.93.132]:34066
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbeKHWYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC+QfY+LAN901l9znSrQzfISqb3dRKOQtznrzDWujJA=;
 b=WiiLcMzFaPVMTVLX/nSiKyryn109dkLn/eOTY8JdsfVD7ItbVHfMXLmB62pUcx1kuGsPEw+21ziWfAGvvWEAJ01k7mGJSykRRsCDd5fxQMMHTJpYIoPcEb9S6mvvROrXmOZUc9E9eIJ/gu+SWH3J/Kg60IbnJPLO0FsLQEuOzeA=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1500.jpnprd01.prod.outlook.com (52.133.161.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 8 Nov 2018 12:48:47 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 12:48:46 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Biju Das <biju.das@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774a1
Thread-Topic: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774a1
Thread-Index: AQHUO3/950BhN4Ey1UKDiDbJFMgUuKVGS6ew
Date:   Thu, 8 Nov 2018 12:48:46 +0000
Message-ID: <TY1PR01MB1770EDC8696798A93FB7E3D2C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1500;20:W18oiiW/6EEGJjp4+DRx0212PdKQgEJd+yHWJIaLlqe6YIWSU3CdblbsbVKv85MzPrL+AkJMgqBCMbLNpPDWCXvAaTqhJxaSEsINB7P0+yJSZAizTUUMR9M0P4ugvhwIJmWDZ4O+OFAJbjE6UMhvhu0ctR8drXFCooaLnDFL9iM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 48494a2b-d9df-4450-95de-08d64578862d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1500;
x-ms-traffictypediagnostic: TY1PR01MB1500:
x-microsoft-antispam-prvs: <TY1PR01MB15002A43287B8AEF74024F05C0C50@TY1PR01MB1500.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1500;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1500;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(25786009)(5660300001)(97736004)(33656002)(66066001)(4326008)(2900100001)(7736002)(7416002)(106356001)(305945005)(105586002)(74316002)(26005)(478600001)(413944005)(44832011)(68736007)(8936002)(81156014)(81166006)(8676002)(229853002)(186003)(9686003)(256004)(3846002)(476003)(55016002)(446003)(11346002)(486006)(6246003)(86362001)(6436002)(53936002)(76176011)(6506007)(102836004)(54906003)(7696005)(6116002)(316002)(53546011)(71200400001)(2906002)(71190400001)(110136005)(14454004)(99286004)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1500;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VuWIrsUpI7NdSlceT6Zyj4vfJFt+j5XsXaQQQKbMOuppDBxwvrCDWFpBJv+nX+EeNLxw7bI52ju8a7FTCHFcnE0ueLk5P0wixlCCzgZZNcDo0NS4KbkMNyLAjNsD0SXkAdRI0qTplYRMC+H9ZTDelaI/Sa7HY5rLcZWLTRU9GnO/MHIUu8CznFDONeuyUA9M0+MacXboZnInoB+4DaEbUSAQCo6/wMhp25TrJtfSfJocogQsUYZRYoYhF6JW+2P/rfLkZS6pKeKjwr39dOWrAjzCuihulhZn6mUc7+uowXb/denyePOxOo1eenhcjqDtUz9f3isWfFHKYu6ztwUA4QTwu9v0xCYUIgPatd+t7G4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48494a2b-d9df-4450-95de-08d64578862d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 12:48:46.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Who is the best person to take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 24 August 2018 08:56
> Subject: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding for r8=
a774a1
>
> From: Biju Das <biju.das@bp.renesas.com>
>
> This patch adds binding for r8a774a1 (RZ/G2M).
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> index 482e543..417ca90 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> +++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> @@ -5,6 +5,7 @@ Required Properties:
>  Examples with soctypes are:
>    - "renesas,r8a7743-usb-dmac" (RZ/G1M)
>    - "renesas,r8a7745-usb-dmac" (RZ/G1E)
> +  - "renesas,r8a774a1-usb-dmac" (RZ/G2M)
>    - "renesas,r8a7790-usb-dmac" (R-Car H2)
>    - "renesas,r8a7791-usb-dmac" (R-Car M2-W)
>    - "renesas,r8a7793-usb-dmac" (R-Car M2-N)
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
