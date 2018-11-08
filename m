Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37292086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="DJCTnNA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37292086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeKHXjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:39:15 -0500
Received: from mail-os2jpn01on0127.outbound.protection.outlook.com ([104.47.92.127]:16213
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbeKHXjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iSjQMuP5Lt/67r6zDFokZljHju7jTtLwEIRHOR6nhQ=;
 b=DJCTnNA325YH67aeIYZ43UkeDzE2bwC0gi6tZSy7hFLxANe8ULNOAVfAYeTfU1zYe7peNu1TN6XXbHr8HVfezKVP9tQCm+0aNKLLJnmJr84oLbPk9PoEdEZ9o6kAMHeCAxdMz/c9Uh5xVnb2SrP2nHxVMfk3yTlMdKiQxiTZ42s=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1644.jpnprd01.prod.outlook.com (52.133.163.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 8 Nov 2018 14:03:33 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 14:03:33 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
Thread-Topic: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
Thread-Index: AQHUNjcFVnH3t67d7UOm/r2/5E0IhKVGPoRAgAAW6gCAABWl4A==
Date:   Thu, 8 Nov 2018 14:03:33 +0000
Message-ID: <TY1PR01MB17708164ACBFB62E8FB4947EC0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534516265-10059-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534516265-10059-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB177011B91A9CA579E01760A4C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20181108124530.dgbucminxi3z63gx@verge.net.au>
In-Reply-To: <20181108124530.dgbucminxi3z63gx@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1644;20:lrN3TXxTfcGl0+ZRkmTHafp7lfbcsJICpZRHtPhyB0EIBdXG3NfhlCUdb7pUapr4IlhbjxsnjdrGoccMSweLbcF+xKpJTEsXwG6GTg78tDaTfIhXRSGXvsp0WckSsUxmXiVC+KLR31RxDftHH77ESXO4TqJ87rH2FHQ+1PuUMRk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 2b1759eb-18bb-4397-6f96-08d64582f891
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1644;
x-ms-traffictypediagnostic: TY1PR01MB1644:
x-microsoft-antispam-prvs: <TY1PR01MB1644863DDEECA3743AD4C9F5C0C50@TY1PR01MB1644.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1644;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1644;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(7736002)(68736007)(229853002)(305945005)(74316002)(99286004)(316002)(7696005)(86362001)(6506007)(53546011)(54906003)(5660300001)(102836004)(105586002)(26005)(71190400001)(76176011)(186003)(71200400001)(8676002)(11346002)(81166006)(81156014)(446003)(106356001)(476003)(256004)(44832011)(486006)(8936002)(33656002)(55016002)(93886005)(6916009)(478600001)(4326008)(9686003)(25786009)(6246003)(53936002)(14454004)(97736004)(6116002)(2900100001)(2906002)(66066001)(3846002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1644;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N5T9DWgWd3M8i+ug3MfqBkJGpU+YgvbmaHhPntPnT/rgk9uDO4ZjJA5sQXXjqmyY0DK8+woh/D4Uc3NhDAgFKa84uf/Chl+aS8Ez7+ZqgGLcmszGbl1MqNlIDfFqWyJQDACySapmJ93YWp+MgVYhN1TqcD1mM4AjtxQN8lhCLaReaYiQzpTjihx9qAoXXEUgif0lOZqW7WIXfctGRGR1Ofs3pkT16ZDpUGnNXqeMRLP6xl8c94H/qlWQINpNl8854uIG1CcnNNR3pPfNLg9d+gj+WDTH6ikLO+at2D1i2NCaWyns/dtlO4fYC7k6dqSAcyeG/k4HCUjW5Z3BpzRbZzjpx8Y+Po5OY7bvar6SWUM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1759eb-18bb-4397-6f96-08d64582f891
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 14:03:33.7039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Simon for getting back to me.

Joerg, does this patch look ok to you?

Thanks,
Fab

> Subject: Re: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 sup=
port
>
> On Thu, Nov 08, 2018 at 11:23:58AM +0000, Fabrizio Castro wrote:
> > Dear All,
> >
> > Who is the best person to take this patch?
>
> I believe this one is also for Joerg.
>
> > Thanks,
> > Fab
> >
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Sent: 17 August 2018 15:31
> > > Subject: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 sup=
port
> > >
> > > Document RZ/G2M (R8A774A1) SoC bindings.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > > ---
> > > This patch applies on top of next-20180817
> > >
> > >  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vm=
sa.txt
> > > b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > > index ffadb7c..68446dd 100644
> > > --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > > @@ -13,6 +13,7 @@ Required Properties:
> > >      - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
> > >      - "renesas,ipmmu-r8a7743" for the R8A7743 (RZ/G1M) IPMMU.
> > >      - "renesas,ipmmu-r8a7745" for the R8A7745 (RZ/G1E) IPMMU.
> > > +    - "renesas,ipmmu-r8a774a1" for the R8A774A1 (RZ/G2M) IPMMU.
> > >      - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
> > >      - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
> > >      - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
> > > --
> > > 2.7.4
> >
> >
> >
> >
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne En=
d, Buckinghamshire, SL8 5FH, UK. Registered in England
> & Wales under Registered No. 04586709.
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
