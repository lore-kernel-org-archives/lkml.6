Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB2C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC03F21653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="C0e4gVU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC03F21653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeHNUqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:46:45 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:15208 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728308AbeHNUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:46:44 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 15 Aug 2018 02:58:26 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 5165D4BDAE;
        Wed, 15 Aug 2018 02:58:26 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,239,1531753200"; 
   d="scan'208";a="288132583"
Received: from mail-os2jpn01lp0146.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.146])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2018 02:58:25 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXargKRjc6bk/IuQXraalx8Mv4WHVUCe3+mBRRPku0o=;
 b=C0e4gVU8EqWTNz4tbeGulCVIsThw6FSe608Cf0JcE78AnHF/6Cf1A5NSrzepAAiX3I+V1dgXo8dyVWIFwxxupGW9kOsMbHxh7j1/4UOIf35qjlqgy43WUQ8h1uk0aUI34NfOYh0jeFbCTslc1Vs44ABcqyqndTqwKOlEYgbPZ3c=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB0457.jpnprd01.prod.outlook.com (10.167.155.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Tue, 14 Aug 2018 17:58:21 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b%5]) with mapi id 15.20.1038.025; Tue, 14 Aug 2018
 17:58:21 +0000
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
Thread-Index: AQHUM8sMv0yKsjoXVEqm4Be5Tf0+CKS/e6qAgAAAnLCAAAIUAIAABVxw
Date:   Tue, 14 Aug 2018 17:58:21 +0000
Message-ID: <TY1PR01MB17704E702054D5368C84C029C0380@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534250017-15725-1-git-send-email-fabrizio.castro@bp.renesas.com>
        <20180814.100957.1728722828479885181.davem@davemloft.net>
        <TY1PR01MB177019FF77871E7149595ED9C0380@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20180814.101934.1621967443721994871.davem@davemloft.net>
In-Reply-To: <20180814.101934.1621967443721994871.davem@davemloft.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0457;20:2n04tMzGf+/sHYwXdWgKYqNL+Ipui7WjB7qEwt9SuHWB518QMlL1fHgOPaDNqoUCeHEAf8EAp8OYo2wR48i9v/YvOAmedm2M2lE5++rTE8QB50AWrAb6PlEZvPL1rA0wwTnM2UN7GFMGCje//NWuPS9tutsenhxJM14CXbPvTMA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 4d008eb3-10fa-468e-3db7-08d6020f8618
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0457;
x-ms-traffictypediagnostic: TY1PR01MB0457:
x-microsoft-antispam-prvs: <TY1PR01MB04574AF136D262D8A4C6A61CC0380@TY1PR01MB0457.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301033)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0457;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0457;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(54906003)(186003)(6436002)(66066001)(9686003)(102836004)(316002)(26005)(6916009)(6506007)(446003)(4326008)(33656002)(256004)(6306002)(93886005)(11346002)(74316002)(7416002)(229853002)(55016002)(5660300001)(53936002)(486006)(476003)(97736004)(14454004)(44832011)(478600001)(86362001)(99286004)(7696005)(76176011)(5250100002)(2900100001)(105586002)(2906002)(106356001)(25786009)(305945005)(8936002)(966005)(107886003)(7736002)(81166006)(8676002)(81156014)(6246003)(68736007)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0457;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fUIAZBfS59s1tbHKkBNOp95dl98wbxNQzk9I4m2h2cXwbNj4rYO/G8hfpa0HD4mtsSpmCyNsU4hry0I92Cb1Usai+wbrdNmvpInGLqPwSO9LvpE08JkjXtVtfOmnX3D4/gWw92VbNEoXam3YGiXuXyMyUBeVWLrLz55Pf9Lkba3cLFetiooz9aOPEHKnAuMLC4VlD+WfQ8MQs8f2IwLuS12QsQDTVx68Dm+asSwRpmyipRNlTIpyGnj+D6zjeqPWMlYCc5kIm4XJXYq6XedJeVMzAiGAhF1gILl5mcrUtmTpxbKqODOHvplePyGLWxCof0jNd07NIPfp5Hg11YtWkoKHfjj65gkCF3l27gEPBTs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d008eb3-10fa-468e-3db7-08d6020f8618
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 17:58:21.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Date: Tue, 14 Aug 2018 17:13:30 +0000
>
> > Hello David,
> >
> >> Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a774a1 =
SoC
> >>
> >> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >> Date: Tue, 14 Aug 2018 13:33:37 +0100
> >>
> >> > Document RZ/G2M (R8A774A1) SoC bindings.
> >> >
> >> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> >>
> >> Which tree is this targetting?
> >
> > This patch applies on next-20180814
>
> I'm asking something different.  I'm asking which subsystem tree, and
> which maintainer, should apply this patch.

I think this is appropriate for net-next, and as far as I can tell previous=
 patches have either been applied by you (mostly) or Rob Herring.
Maybe I should have put "[PATCH net-next]" in the Subject like the followin=
g?
https://patchwork.kernel.org/patch/10314835/

Thanks,
Fab



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
