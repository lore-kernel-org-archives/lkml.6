Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B05CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCDE20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lzBf/WFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfAPRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:31:52 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:5152
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbfAPRbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4roUDKUCNg0eKoLtKsa3IEw651nJRge5sRyGmhH3Xic=;
 b=lzBf/WFEiYVlvHSx6R0kKwX/0bCI+cQ9asaHA0c696MzhlLsXcF5K3rfm+BxpI8Zm+5VFLcQIP1n87cX23cS+hPBjp7uTcF85tRzoNKEiZmeTRhbncG5ZYGCWdyP5rjmcGXUMblqDKvJA0guftUItRPy+KTa9pkFuT8V7qD2K58=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3581.eurprd04.prod.outlook.com (52.134.4.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 17:31:46 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426%7]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 17:31:46 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Topic: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Index: AQHUmUIyF6ylLjPS3UibJyYT5PgWG6WrD8gAgAbCicCAAA9NgIAAALAAgABrd1A=
Date:   Wed, 16 Jan 2019 17:31:46 +0000
Message-ID: <VI1PR0402MB2800477D1F1FE0E78F1D8D33E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
 <20190112024725.GO32649@dragon>
 <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20190116105559.GM15808@dragon>
 <VI1PR0402MB28007817A29E6116D1FAFC2BE0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB28007817A29E6116D1FAFC2BE0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3581;6:bq2NYa9E/UUBNquVH30y0OtgAqL+3IY62KI9YMNVbAh3Wl3T9Y0HhYPU5Fmo35h4oVgxEjbCl/J58KLJUEvcU5ZfsYRx8qrN4yFFhuRI2KEGisjaQVM84o8meRifY3h4RqpK+z6qiQMI1o7zKj3yAru9B9H4s0ghGvTE1FeDhMJMZyc3HaS7eui0+McT350UY2bQyqmgY0E6LWlhFAeRpVSsx7hVyPNxwHQPAwHvodP5zRxmi4PlxrMJRBMaxz7UPkzIZbXOjvDWe8WW3zTkEV6R4JzwfV/6GASyNtdEtGicd6TmIgVRn8AtShnhelUgn21UOonEyCXMaQcuJYSrPWBNjNyRKbL2s+fW6XOE6z6kl1Ndt0/cwwQlCh4ASpIdt2PJCLYXTN0lLXEnAVaauNhEuM3817VrqvfvDmrVa76oCXxZLuzWtrovSdOVhRUpiGlpM4XmwPQYYdBE3YK/Qw==;5:ue32SDocRK1H3p6EEiaDkUJ3Pqo7WhfyTtOx75WqKnWmCpnVFGJpwZo6aEcBx/9aaZWnwdxGmL1wTTOLt2xPqOZHlr+KszVY0HsvuNoukFtpUM/aPvsxDzLqZIRP00bCPozWXn+hf62INvUDFRMKEO1kVegglF6I4B6IJlvN1ASdp24JqSqb5dm/uSWaAcVezVhMPPcXzWMBq9tYTc2Dvw==;7:gSsl4tyGK3J4rqzyftIU2pXJV4mEMOCIZEw6VktITIWJj3kTmbDbXupMQNsJ5ipiDRLMhQ1SMTvZpVS4CbDbvcJW98p6MSCwiyRG/dLRiwCy5M6uKNZBiJ6SoinVA2sr6TQ9pH+K7sG1anPddSCZQg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 87a993c5-19aa-4c6e-46e1-08d67bd87d4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3581;
x-ms-traffictypediagnostic: VI1PR0402MB3581:
x-microsoft-antispam-prvs: <VI1PR0402MB3581FF13D7A48E6CCF24DDC8E0820@VI1PR0402MB3581.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(93886005)(106356001)(8936002)(105586002)(74316002)(97736004)(5660300001)(6916009)(7736002)(486006)(44832011)(81156014)(8676002)(305945005)(68736007)(81166006)(2940100002)(316002)(446003)(476003)(54906003)(478600001)(99286004)(14454004)(25786009)(4326008)(186003)(26005)(9686003)(102836004)(76176011)(6246003)(2906002)(7696005)(11346002)(229853002)(6506007)(3846002)(6436002)(93156006)(256004)(71190400001)(55016002)(33656002)(71200400001)(53936002)(6116002)(66066001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3581;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IoBcJsZR6UcZCpECh+fV0rx6JpfN2AkDUnLqAne6XJRLTRsXjufyzIE97lztAwXHUsQrGCWRpu4R0lXjMVYwNANLU78m+TRVeFem7VV1g4OFF0IAZiSewB2Seyrso88HBfmup1kFfrqcBUX7MNoCnZRYSbtY5Cg615C99CNeW0HwYXTpC6rlcovdGiFo0uBJmPj8kjsq7CQbiYnAaAtwIhX40s2yNNa6xYrjfo99SPNyh7F5BdLqlPjlNaqFw91E7JGVUy2trjrvT2fHtjfvg405hc89r0EQpDav3s/KRt0TS0+eysBlCIk9/WYgDOMUVW+ctVokAYSXG81z5Uy8JWeEyeragk0t/ItpyXo/rom9kb8zeI5YH/90PADylAJHhfXDQOQBrO6RFK4MRGiswF1vDkN9f/yq9yydizrZb9Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a993c5-19aa-4c6e-46e1-08d67bd87d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 17:31:46.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
> > platforms
> >
> > On Wed, Jan 16, 2019 at 10:02:01AM +0000, Ioana Ciornei wrote:
> > > > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for
> > > > DPAA2 platforms
> > > >
> > > > On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> > > > > Add the dpaa2-console device tree node for the following
> > > > > DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> > > > >
> > > > > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > > >
> > > > DTS patch generally goes to the last in a series.
> > >
> > > Should I resend this with the DTS patch the last?
> >
> > You do not have to resend the series only for this.  It's pretty much
> > a suggestion for future posting.
>=20

One more thing, do you have any other feedback on the DTS part?
I think the best path for this patch set is through Leo's fsl soc tree but =
of course we need an ack from the DTS part also.

Thanks,
Ioana
