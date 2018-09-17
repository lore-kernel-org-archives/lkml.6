Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27576ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB42214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZnPiCKO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB42214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeIQOgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:36:20 -0400
Received: from mail-by2nam03on0060.outbound.protection.outlook.com ([104.47.42.60]:48640
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbeIQOgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OYCJrI+cU3eTVtXL6Nfivv9BnOBrmai0ddoGAgyAsU=;
 b=ZnPiCKO+0iAuJxpae8mS92+znlhyc+xpY4aT8FZ/2Vvsy9iJkHL99Gs/mcc/LG70z+6s4T6ypUBQLOYH0ZZ2CetgVL0ejIK7bMp4gR/t/np02PIaBT2fE3Mf5lkxf17lcqj1zVtpQV3S+Q4IBSeueki5vFK7InAPfXgqUkw5934=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB5175.namprd02.prod.outlook.com (20.176.254.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 17 Sep 2018 09:09:46 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::80dc:1608:389e:bdd8]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::80dc:1608:389e:bdd8%5]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 09:09:46 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP
 reset driver
Thread-Topic: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP
 reset driver
Thread-Index: AQHUROdicf/LQjvTwE+b+sRENje4CaTp+10AgApCiaA=
Date:   Mon, 17 Sep 2018 09:09:45 +0000
Message-ID: <BYAPR02MB471009755B88F55A97DA5694C21E0@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
 <1536131342-28041-3-git-send-email-nava.manne@xilinx.com>
 <20180910201224.GA31501@bogus>
In-Reply-To: <20180910201224.GA31501@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB5175;6:2483sDo20CXd0a350xIbUhLsLziMaoVvlO+HecT4PHzC1Vi0ZWi//aTu+N1jvIWazYEzuNV0cfqM2Dvm+Uu+R7wqqvMaUyXOC70hIJcn3XRkwnSSBxyun+7ajygQFaiZOKUTlERK4P1Sr1XShv4uwbHsKtFQCR3DRGIkf2WR4KmScj+D1Mjp4nf3dVbf+aZ5Ux4AyBmNKOVBwXh9lSw+x19ncexkftFOnJlt+x6w3dLjMzh2Io8CHf5x3Oc364jrADKD/xdpeuTd4iRYqQEAro7cj0Nl8xHYL3s+ppjttCAgHzdwdyvVzT8krdXjmGbdH8H+81CrJ7UvFmqxmNddRPuOu6eyzESFspc50tAhPAURz9ulCVjkwChlV2zr0FGEemgQ34kIC8xAuLuRKPfkQRJEx26IphM2pMCq3veg+LZXM1QTFp41kC+Lw18F8OrQBbgQXPn+TCyDd9uGcQx4ZA==;5:kqVT0D88YVUs6j4jazKSa1zacbOD8rgcsXX8DGG28l47KUdmB0S4K9Lqtl9tukR15aaiY3284oRDS83C4SkP6tR3qEuI0Pe6dYpWzAbkN19F2CjdYRARAsNHY8PMT/6FBg4ejrjyMex1urcnaq1dB7hSNgixj8GaUR7JezIQUy4=;7:e6CvLzVj2rz3VkH12kk9CF31gnFEiVUrFN0ohFiFAS++QQPzBdQ9Basit7ObexUvTfHJm+jqZ9UEV/S0vDMmuFUivCGuXJHKA7Ddoc4F2SfQ24Sh99rcZ6OKP5ZZMHR1HdiMDgfAaMpeyQv/qG16RsHH/BiRZMJH437h2P5DekIGRGPPvfp2lgpmLGrTRS4XFKhiYWk2KRQGwVk1/SrHYSfYH5Dm7NgKHT/dUMaX8lW+nt2cAUOVpYFKVc+F/tgb
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: fdfe563b-c542-45cb-c903-08d61c7d5029
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5175;
x-ms-traffictypediagnostic: BYAPR02MB5175:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5175B9D731B267E0826F7611C21E0@BYAPR02MB5175.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:BYAPR02MB5175;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5175;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(396003)(346002)(13464003)(189003)(199004)(6246003)(305945005)(74316002)(25786009)(97736004)(478600001)(7696005)(53936002)(2906002)(55016002)(76176011)(9686003)(68736007)(6436002)(217873002)(7736002)(86362001)(229853002)(6306002)(4326008)(966005)(8676002)(66066001)(476003)(81166006)(81156014)(486006)(102836004)(26005)(186003)(316002)(256004)(6506007)(53546011)(3846002)(5660300001)(99286004)(14454004)(5250100002)(106356001)(8936002)(6116002)(2900100001)(446003)(33656002)(11346002)(105586002)(54906003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5175;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fvHSwgH6Xo2LoW57X0WlPce1JBE6lAhJAFJZOVPTF9pPnP0O2w8mKnbOjImCJbQl6fSWo/3f/8w1bnQfuDj6maCVsPZgdIrZFsKsgZfGifcEM2YGTgNCAbNMA0/z4qm2Iigo2KLjl65SWwRCCbJuvvCedMCZJzbDbkWNrtMDHSyXVfXkBKvRYipJDPUBEZzXLnFCS3I2vGaGZkJuezuV4CEh8VAQmvCOgTYNClnrKCz/MQ2riBt7QWcJP/yFBx35UW+6OX3HAzi5J4GvL+XLAxwTHRfW/1jAC4IIQIl7XLCx2ifecb1hk9nGShvmEGBFuIxf8U36/NdjaYessGfL+6wBzd0EvR4NOFhomnbv6DA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfe563b-c542-45cb-c903-08d61c7d5029
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 09:09:45.9034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for providing the comments...
Please find my response inline.

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, September 11, 2018 1:42 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>;
> p.zabel@pengutronix.de; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for Zynq=
MP
> reset driver
>=20
> On Wed, Sep 05, 2018 at 12:39:01PM +0530, Nava kishore Manne wrote:
> > Add documentation to describe Xilinx ZynqMP reset driver bindings.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v3:
> > 		-Corrected Commit Msg.
> > Changes for v2:
> > 		-Moved reset node as a child to firwmare
> > 		 node.
>=20
> Why? There's no reason for that. The parent can be multiple providers.
> You only need child nodes if the sub functions have their own DT resource=
s.
>=20

This driver having a dependency on firmware. So I have moved this node as a=
 child to firmware
As per other drivers which is using this firmware interface=20
https://lkml.org/lkml/2018/8/14/432=20
I didn't get your comment could you please elaborate more???=20
Did you mean I should move the changes in the file to Documentation/devicet=
ree/bindings/reset/ ???

Regards,
Navakishore.
