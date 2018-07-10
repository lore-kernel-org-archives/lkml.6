Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042FFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E0620878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="MztnYUUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E0620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeGJH7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:59:02 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:44888 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751057AbeGJH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:59:00 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 10 Jul 2018 16:58:58 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 3BFD67A749;
        Tue, 10 Jul 2018 16:58:58 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,333,1526310000"; 
   d="scan'208";a="284956920"
Received: from mail-ty1jpn01lp0182.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.182])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2018 16:58:58 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDMEpyAvgeagx37HUySUIjoSt/jQF5CW8J47u6oOYM8=;
 b=MztnYUUejoiz4hkEmcfZyGqWWqREGsPIy9VZQ5z8yPeuM21C8EzymP332/qzWz++Xj67ExRcBvdxA2975iRyxL1T1QkobjhHZo/wuMa0zn7NLurR92Ado0JBKsj2GhhW7HMhxvzz4kzNnHOjvwB+n0V6R6ywUZg3ojC0hmniLtU=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB3239.jpnprd01.prod.outlook.com (52.134.255.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 10 Jul 2018 07:58:56 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::3820:2ee6:79bd:c8b6]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::3820:2ee6:79bd:c8b6%3]) with mapi id 15.20.0930.022; Tue, 10 Jul 2018
 07:58:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>, "kishon@ti.com" <kishon@ti.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add bindings for
 r8a77990
Thread-Topic: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add bindings for
 r8a77990
Thread-Index: AQHT/WGkDAJMbto4EkClw9TYI4L8S6RdMlaAgCsaQjA=
Date:   Tue, 10 Jul 2018 07:58:56 +0000
Message-ID: <OSBPR01MB2293646B55B7C7ECA13BD37FD85B0@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1528267348-18960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20180612214433.GA28082@rob-hp-laptop>
In-Reply-To: <20180612214433.GA28082@rob-hp-laptop>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB3239;7:RIyntBx0zQmGbSjhqxmFZgr+h4yVzQpIJaaxwiTcEGaZa212wCg0P4gGg83uezjZZF13CkDP5P31EYyMko+gT1xn5oC7PjAppWgpOXKyolfBJRJE3oepoLi2UCu3JfR26vta7IyXI/8WWIKXWuXKFIPPcYS+v9yyo4mGYKXSVsxkHwUP4NLy/pqcUiRj+dL5n5fA252SixNH/Egjz6csiIwT2xKuf/0vP6cB46OB6BFtQQytOaMiziqSX2huYSqt;20:XfoZ3w+ApAFa9bmVqJ5BuneQTFJlBxoV4mlQspuY95AY7vPsC7Igym1g+GKTkKoUEexuYuCp2AOZa2NB8gZFeAQMl+FBZodAYA2ywV9+1NDBw0xDZWAfhl4icArmYr+yOmWoxmJRGrQ8fAvd65qg0IEEolReVsOJ+SG+cLnR6Zg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c085aef1-ef74-4eed-cbcc-08d5e63afca6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB3239;
x-ms-traffictypediagnostic: OSBPR01MB3239:
x-microsoft-antispam-prvs: <OSBPR01MB32392F8D332EEC490CD2B67CD85B0@OSBPR01MB3239.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(31051911155226)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB3239;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB3239;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(136003)(396003)(366004)(376002)(346002)(199004)(13464003)(189003)(3846002)(8936002)(305945005)(53936002)(476003)(6436002)(102836004)(33656002)(5660300001)(6116002)(478600001)(26005)(2501003)(2906002)(106356001)(486006)(7696005)(97736004)(5250100002)(9686003)(68736007)(14454004)(99286004)(53546011)(105586002)(66066001)(55016002)(8676002)(54906003)(110136005)(316002)(6246003)(11346002)(4326008)(7736002)(229853002)(76176011)(2900100001)(25786009)(186003)(446003)(6506007)(74316002)(81156014)(86362001)(256004)(345774005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3239;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Pf7ZkOZe5vNz6HOZsNidi3ioqG6fVuDAVpLW6gqJJR2mraLQ0HeCCVzyQXXpH/FU0PZIVZqrZtKBbfet+UbO/fdv2lGF1+0aNu0FTmh/GyiQlsIhuMhCxmQDxqjjJvVT8aHjvne7ZUUV7PNfp8xmhT2qXluZ+JzfMoZlIMPgXnAGXFvcy7gDZkc7GonZYe0RGNpobFe6tWlcubNU6vmr+Udu5slcmySbJjSbpcqo84Ss4Svk5KRLNrDw/nniIsIP+/nJikvfaepMrE4h/V7P1YCS0Lr6bbbuTjFwnwd2MT2Cl7kqcR/mIvp/ufX1wvED/yrKv/xpnEkDg2sK/RNQHuInSu6jQ8Tt/cozywDQHlk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c085aef1-ef74-4eed-cbcc-08d5e63afca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 07:58:56.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Would you review this patch?


Hi Rob,

Thank you for your review!

Best regards,
Yoshihiro Shimoda

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, June 13, 2018 6:45 AM
> To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: kishon@ti.com; mark.rutland@arm.com; linux-kernel@vger.kernel.org; de=
vicetree@vger.kernel.org;
> linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add bindings for r8=
a77990
>=20
> On Wed, Jun 06, 2018 at 03:42:28PM +0900, Yoshihiro Shimoda wrote:
> > This patch adds suuport for r8a77990 (R-Car E3).
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Acked-by: Rob Herring <robh@kernel.org>
