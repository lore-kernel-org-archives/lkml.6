Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C885F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LlHS/WUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfAPKCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:02:12 -0500
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:64320
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728780AbfAPKCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjpuq6xQKLf3cHWyfFYYmXeE+3HWsK7WpyxJXj7wcCw=;
 b=LlHS/WUebdkk11L6DHTz9WqfcO55ltBkuK3kG/BBzE+QGnYPk7rH3y3MZDAJkDdvDRVEuYQdxYSv83LFVZaewonabVolRinisQunEicarlLbjjFq0BFAOuV7S0sn6yDrGskjIF6juzEGgTv3p72iM/A5efqyE4THbNWF+HbtG44=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3693.eurprd04.prod.outlook.com (52.134.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 16 Jan 2019 10:02:02 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426%7]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 10:02:02 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Topic: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Index: AQHUmUIyF6ylLjPS3UibJyYT5PgWG6WrD8gAgAbCicA=
Date:   Wed, 16 Jan 2019 10:02:01 +0000
Message-ID: <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
 <20190112024725.GO32649@dragon>
In-Reply-To: <20190112024725.GO32649@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3693;6:VMV2rgwytmBELYFSC4xiYOypRJVnFFnXmHog9PSMD6BuvkDI8IGYFyxiJN9t+0HERAzGYda84wMVQRgZYXGNqKt5HilVhkiUveVofUSb54n+DWuK/OESsoKLoFcLroGunTtdQlGo9mJyzvq0EBQjzOwOajLN0TwJu1T9RXKgU5LLnfhH1FJTGiKvhmBNww/uPqqkyyMx6iF5OGI9vbfNioJqX8CVy04fy3aIXXaHt2FwNruJsPFqfbS9DWOFfF4wmFz9xA6LSJ7YpCxgwaTMDcENDHge6IUpRBM3Idt7Og2uCO1cOT5ES7SpbkUyU/gRTMkCASlLLdnHr5xzfrZdhBUdFWSJpGI3MCt6OMb81c2oRa7b+R4Uwczo+sdyn0l5KI2CtMFNzrpyE7XehIdJGGXZjK00e1Pc73UbnBrsN88EWEfE+uLUPsalVULZshBFNkTMhtsAzP5XesR348owbA==;5:u4APyoMzkUHOmu8x+iPGyg+5u57GslESbymuO5KYQUS72EEXN9AH9lHiz1Xf7C2aBbZqchtyfxyX/O4XbIUEFa+IWXPYVmNY6kdM0Egadl/OJD2s6C7yT/bNPhJ3GrhUJ9ECVjbMfsHd3v0UdufpmJQHruU86o/Bdnf/t1GOvicUSKOFHCCFcmSMY5IhUPrMM9f5gLeHUcC/Moi+1gj5fg==;7:ja6LKHDweUr4KgWNKJewi93o34OY5MEaxfaPIVXo0MuqwnTmygkhRhYGMoouFJ3wiaik6f3tB4TyZ8raN7vVBuDsuXb4gkA2rqmEUx1BIR4fXHY/zCaaufYrs7sgY//0UOkrj48bPpDqQMgulMBTwQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3afc2003-0387-4607-ffcc-08d67b99a94b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3693;
x-ms-traffictypediagnostic: VI1PR0402MB3693:
x-microsoft-antispam-prvs: <VI1PR0402MB3693B73540765872F2EAA590E0820@VI1PR0402MB3693.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(26005)(97736004)(446003)(229853002)(11346002)(66066001)(6436002)(478600001)(305945005)(256004)(55016002)(76176011)(6506007)(86362001)(186003)(476003)(7696005)(71200400001)(7736002)(71190400001)(8676002)(99286004)(2906002)(9686003)(44832011)(6246003)(81156014)(81166006)(14454004)(316002)(8936002)(486006)(53936002)(105586002)(6916009)(68736007)(102836004)(106356001)(54906003)(25786009)(74316002)(3846002)(33656002)(5660300001)(6116002)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3693;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PboTVS6JosOvDesUOGT+r00cStXbyB2EbF/8CYpRkJrSNeb7uV+d2hzl+6AY/3NlKEfb7Zt+NNsqlRDlZTWEQIHbcrd9KTEYxrRbJbU8CdfdCOPuRXaice8vSxtlpP6zG3Bu69QhmDi4oCyfhv7QkyxDEdyCP2hpuVEiLgu43isIYz9cOWJssJy3UDzLTV6ho3Aek+EutZGiQatt7p74tyI4vcnGrMW0k38yucwmuaBPg4cpuE8jJZQY1iq/5eLHKrmRYJ3vRUrZO/oI2ThUqxZS38efnsCAEvpoAt+yjF55LXk/yWzz3+No9UH7mDvkCs6xnXk7F6ZpLimbq/QhwxlNh/hIL14LM/PqJb8+BJhw+PDCOCZjBmVXrLe1FFGcZUAK1tM2dYuEi3CXdLc0YA5aEboQQ5RukOsiwJkHPXs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afc2003-0387-4607-ffcc-08d67b99a94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 10:02:01.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
> platforms
>=20
> On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> > Add the dpaa2-console device tree node for the following
> > DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>=20
> DTS patch generally goes to the last in a series.

Should I resend this with the DTS patch the last?

Ioana

>=20
> Shawn
