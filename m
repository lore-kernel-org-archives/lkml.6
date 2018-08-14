Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39173C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C967D215A5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="JPLO4Imw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C967D215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbeHNUBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:01:41 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:20416 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730635AbeHNUBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:01:41 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 15 Aug 2018 02:13:37 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 6F17948F34;
        Wed, 15 Aug 2018 02:13:37 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,239,1531753200"; 
   d="scan'208";a="288130457"
Received: from mail-os2jpn01lp0151.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.151])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2018 02:13:37 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6Zlw5Nh8wCECuuyfh6A2bjYe7j0AGvIn1LyoLWIv9E=;
 b=JPLO4ImwEpnYekB4/YJSFuJS7tVpYLG91cmWCwjTn4vMZtLwM3euDO1dZI+VY7ir0w6ZURUnc8gD4ZZTQlO3VIUfBzJFcRr3C75ryx/Mns8a3qWSRRrdUQYShjLKHkuXkd4OhZCTc4gMWHywyj+vZGrhOqRdjDtFzyaF3RM46KY=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1883.jpnprd01.prod.outlook.com (52.133.161.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Tue, 14 Aug 2018 17:13:32 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b%5]) with mapi id 15.20.1038.025; Tue, 14 Aug 2018
 17:13:31 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     David Miller <davem@davemloft.net>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "horms@verge.net.au" <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH] dt-bindings: net: ravb: Add support for r8a774a1 SoC
Thread-Topic: [PATCH] dt-bindings: net: ravb: Add support for r8a774a1 SoC
Thread-Index: AQHUM8sMv0yKsjoXVEqm4Be5Tf0+CKS/e6qAgAAAnLA=
Date:   Tue, 14 Aug 2018 17:13:30 +0000
Message-ID: <TY1PR01MB177019FF77871E7149595ED9C0380@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534250017-15725-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180814.100957.1728722828479885181.davem@davemloft.net>
In-Reply-To: <20180814.100957.1728722828479885181.davem@davemloft.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1883;20:/ATKWTZrJtNiVsynmJ+rHvFP3rsCTWnQSI3zAD91TAYLgI0oxyidRsVdko9y3z85GKgxLmbDmaVJypOSIv9WEz6DEa0+pT3rv5Q9UO7NYRvK86k2wP6T8RUcIRiozZI9DDHzoZieiDLOXCgb0Xx70HZYo3OMtLg0A0X36iPvhpE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a71c18da-8ccf-4cfd-0428-08d60209427c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1883;
x-ms-traffictypediagnostic: TY1PR01MB1883:
x-microsoft-antispam-prvs: <TY1PR01MB1883AE04F7CE8538E9986AA7C0380@TY1PR01MB1883.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1883;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1883;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6246003)(256004)(5660300001)(76176011)(305945005)(106356001)(74316002)(68736007)(6506007)(44832011)(107886003)(4326008)(53936002)(6916009)(446003)(26005)(33656002)(186003)(2900100001)(7736002)(229853002)(97736004)(11346002)(105586002)(7696005)(81156014)(81166006)(8936002)(8676002)(476003)(99286004)(6116002)(478600001)(316002)(5250100002)(3846002)(54906003)(7416002)(55016002)(6436002)(486006)(86362001)(9686003)(25786009)(66066001)(14454004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1883;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Vuuh7iKQtSVejUWku3lf4zRNwjXqolRagFLZ/eWEuGsTEaaU8nVprsAzSCk0LVlD1MyCfff65NczQRVit8VgApRsbUu4kHaZxpvrTc2rrSvciIRxsrVRrS8iCl2P8rUlKiIyZjwfv7fBKCkG5C5uSKS9XISA3MkzxfuUbsyzDdnPtCsxirr+X+K437eB1R78YatHA5KtFsb0hMO4jsH7xXmB4xfGMDArzQcqA3TutBrRYJG0cemNBQoX2Z9jJcnobVR6RiwItKgcDahnmz9omYXV3xjovPfVzf6TZhakyFcEUQ78ZtrPZBuW3CcasgPnQQ/NMixWk8vASurUpb+wAYcZYgpz+8WN7ZPySPe5uNs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71c18da-8ccf-4cfd-0428-08d60209427c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 17:13:30.7905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

> Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a774a1 SoC
>
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Date: Tue, 14 Aug 2018 13:33:37 +0100
>
> > Document RZ/G2M (R8A774A1) SoC bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
>
> Which tree is this targetting?

This patch applies on next-20180814

Thanks,
Fab

>
> Thanks.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
