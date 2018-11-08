Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90AC20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Z0TmpyHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90AC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeKHXtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:49:03 -0500
Received: from mail-os2jpn01on0122.outbound.protection.outlook.com ([104.47.92.122]:44880
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeKHXtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2ghqQINSQwRXdJ2hpaYNr2z5Jispj0rAssmIP2Biw4=;
 b=Z0TmpyHw+lBvvqRq/WMxkBIfSfTlJwM/q9TEpRkwan41RbykvGeEZldsW/Qzv4KTWWAcwfMPfJKBzGw/+lu44ZdG6rI37C2Ff5lNg9G14ixQIVDqMaYLpuojVB0lX38RO2/8dCxYfgvju41d5hxBIIuusJ2DnovNNj5OTkn3wUg=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1165.jpnprd01.prod.outlook.com (10.174.225.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.24; Thu, 8 Nov 2018 14:13:18 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 14:13:18 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774a1
Thread-Topic: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774a1
Thread-Index: AQHUO3/950BhN4Ey1UKDiDbJFMgUuKVGS6ewgAAJOYCAAA5vMA==
Date:   Thu, 8 Nov 2018 14:13:18 +0000
Message-ID: <TY1PR01MB1770E2378C4F743AD78C7554C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB1770EDC8696798A93FB7E3D2C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20181108132121.2nrat2ecofcd3jc6@verge.net.au>
In-Reply-To: <20181108132121.2nrat2ecofcd3jc6@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1165;20:zziB+GfDquZpa5D1+ei7YxWInYmX4G+72UPbh6DLR88jUy/qcxurvHoNIif/cWxMlqbqs5Ir9ZEWosafM0s5SF9JHKIaA6fjKzHqDd8X4CLUgkT64o+Jp2fVUuURoitAUSBBJ8gFAaYCnqQxcOdZlaweY/hVyHpYe/mljDeG37U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a56e0030-8e9f-4f40-224f-08d64584550c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1165;
x-ms-traffictypediagnostic: TY1PR01MB1165:
x-microsoft-antispam-prvs: <TY1PR01MB1165E3477C2B5462390827E4C0C50@TY1PR01MB1165.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1165;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1165;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(81156014)(86362001)(102836004)(478600001)(7736002)(44832011)(97736004)(2900100001)(81166006)(6116002)(476003)(33656002)(3846002)(14454004)(76176011)(74316002)(305945005)(7416002)(2906002)(6506007)(11346002)(446003)(256004)(53546011)(8676002)(26005)(7696005)(486006)(99286004)(186003)(6916009)(106356001)(105586002)(93886005)(8936002)(5660300001)(6436002)(68736007)(6246003)(53936002)(4326008)(25786009)(229853002)(54906003)(71200400001)(316002)(66066001)(55016002)(9686003)(71190400001)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1165;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ib8cFQATBsX8SpscrikYOFDEkZTYBlqBs3MIBvfvYbDhlcyTvmht9OamTu0PIFmx2jO3TPXkHTEQQtOHS+p6GdzPn1g1+YrXwHzI6Y+4eLn0xFgM6XAXh8PPZP32EEGAu73qX/Yg2c3p4MMw+mq5IIRNsAx8VKN+glyvlZgMeDM7CT8QaqFVNlPqtx93hv19S4aSRAH6Wp7y3QpHilejLnkxjqgjtLFocZstp8bh03KwO1zF03ilEyBRGVJpSDBtoJFR8ijUgEolDG+ZuGMtrpY0NiDvKKCgGPopTZegUIoryPE5j9hTndHYzZK8JntLuL7YLozqFs/ZX7rKfZdurY6Brc8pdQjMUCgifdHmWSc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56e0030-8e9f-4f40-224f-08d64584550c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 14:13:18.3541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Simon for getting back to me.

> From: Simon Horman <horms@verge.net.au>
> Sent: 08 November 2018 13:21
> Subject: Re: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding fo=
r r8a774a1
>
> On Thu, Nov 08, 2018 at 12:48:46PM +0000, Fabrizio Castro wrote:
> > Dear All,
> >
> > Who is the best person to take this patch?
>
> I believe this one is for Vinod.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
