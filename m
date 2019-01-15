Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC44BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820E02085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pwPfbRs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbfAOMa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:30:29 -0500
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:60643
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbfAOMa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6lG3oUOMh1sVI7QAaMcA0H54FRfLrrkuLTBRdBZ69c=;
 b=pwPfbRs35f8tDPPJXX7HwE7gyIoru1tbCDv4s7qIqC6HLiTjGtnLLaUMDDdoDxjP/eyVekBlqyXbCvmSxc38BfTddgHL0hZEnWrxUFu0V6T4vSGJfNB+5QBSA4zo/WkTa6y1jLlhbjMNY9M+7RSOqExAGa00rdiop/pWtuSJj28=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5277.eurprd04.prod.outlook.com (20.177.51.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Tue, 15 Jan 2019 12:30:23 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%5]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:30:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Thread-Topic: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Thread-Index: AQHUqXKJSi5DEBdu5UKeaKryAiY5Gg==
Date:   Tue, 15 Jan 2019 12:30:23 +0000
Message-ID: <e892304bde543b86a9d0ad4409d0c6a1f509a312.camel@nxp.com>
References: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
         <20190114005600.GN11426@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5277;6:jHtDCYatfdSjjQNcj6Fk+AWgSTcXT8B1/LMpJ/qU+AhiUdWyFNogn/3Xx7U+b/OXp+XmzGXnDQf5HSIn1no1x/Kg8tk+6UViNeNXjfPoKTtapd0Rv5nzsagX4ayVJQ4a2366CbQ9XsAxb7D19A7JCuk8/NwhcANhq2W35bI2ppgKgtXwjXVMDej4D46iSO7GuVCvIGa8ezV7dcTR2RfZ4l8rf1cu4bLbZtzv/PYhQKGohwtFSv9Yr8V2bN7H69iuxcUfzDj12bi/3TwTa2pujIyP+BnyqEHjcK1JBXuAb2/q0QeqINRwwFjXEXGtWPBKVPLF2ad8Il+GYFXm13BaNWvJD40Ww67GyZhmAxjzqkG1qGwfhGXnFo+EseSN4VX7Lt40j4Oo1p+dx6fSHWkj7xlYr2OeA3whUeel2frhhYO+/Cz4d6JAxgmWwT3MNym0UHeoxfa0DyMsoIwaVrsoDA==;5:+sLzHyBNb1YgBA/8rqYLKGb5xOAUIu6Ymosl+R/Gtb1QPRrs/Jl9lK9IUC2+oAGN0vukdkgEgA1dzT40B9vhJygCC2wKvWealtHQYv0BgNoaQYHFEg5X6ATuOP05K+rPV19E47ZKWHE6NatWmWqxUiOhlBSaxqveZicGk+HCDIS6DFSZojS+fJKyB7de4CBKMA2+W3K5Gm8VldZB1udqpQ==;7:IszjyN8rvbekkePTOV42Bszxl/GLd5B0MYitlVBugU8AR4Xm5U2upqjP+NejJBzQEUX+1Iz19RxUP+UET6yUuVh8AgjQCclRimhpZbgU/iPCGPqMZSTpaL3GpU3foUL8Z9deBwyE+npUWDyeGV3BhQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2a8c069f-9a7f-421f-0dec-08d67ae538bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5277;
x-ms-traffictypediagnostic: VI1PR04MB5277:
x-microsoft-antispam-prvs: <VI1PR04MB527724F34432504E213C0030EE810@VI1PR04MB5277.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(99286004)(4326008)(256004)(76176011)(14444005)(6506007)(316002)(118296001)(6246003)(26005)(446003)(186003)(53936002)(2616005)(66066001)(97736004)(86362001)(2906002)(36756003)(53546011)(102836004)(6116002)(3846002)(476003)(14454004)(966005)(106356001)(105586002)(6512007)(478600001)(110136005)(81166006)(68736007)(486006)(5660300001)(6306002)(71200400001)(71190400001)(54906003)(229853002)(8936002)(6436002)(50226002)(4744005)(8676002)(81156014)(2501003)(6486002)(44832011)(25786009)(7736002)(305945005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5277;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cGwwBz+WjcjCRSczItDPJwtsC6gfTamKcRcSZQkJPHC00zHzftbBq4fNLWtWUMG3+3meOHEb//0hrWACBshag4xusBoK6UasD8AM5vMF6NxLHe3GBaQJSHQfyCYBt5lb+M/5bagbB/JwTNV+GJ51v87W5KlIuS2+k//Sq/xyg5W0CvRT7opDPsrnRE013rK6sw4IAQ4L4FXI4ZhjozQTMpF3il/8cWDm5VORqQVm7TOVUBtcNOkZfx7w+889Eh/+fZMm80JdfMkPm0zVp6oG6dbNlxX7nEZx+7+kfF/xqE5BAnvcql0aAuduWOrDxJzMtCl0pZGQfngW5mnSDvRG4kivcNg9B1h+gJoxNl5GEncJJqYdNJWm8rBD4J3QLKec+9Gn++6pZawf9h3tY9QWXwN2aSar3vTKYkBnFQPq5Z0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <792730552A7B8A4E8B6CD2DF20208615@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8c069f-9a7f-421f-0dec-08d67ae538bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:30:23.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xNC8xOSAyOjU2IEFNLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9uIEZyaSwgSmFuIDExLCAy
MDE5IGF0IDA1OjU3OjMwQU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IFRoaXMgcGF0
Y2ggYWRkcyBjcHVpZGxlIHN1cHBvcnQgZm9yIGkuTVg3VUxQLCAzIGNwdWlkbGUNCj4gPiBzdGF0
ZXMgc3VwcG9ydGVkIGFzIGJlbG93Og0KPiA+IA0KPiA+IDEuIFdGSSwganVzdCBBUk0gd2ZpOw0K
PiA+IDIuIFdBSVQgbW9kZSwgbWFwcGVkIHRvIFNvQydzIHBhcnRpYWwgc3RvcCBtb2RlICMzOw0K
PiA+IDMuIFNUT1AgbW9kZSwgbWFwcGVkIHRvIFNvQydzIHBhcnRpYWwgc3RvcCBtb2RlICMxLg0K
PiA+IA0KPiA+IEluIFdBSVQgbW9kZSwgc3lzdGVtIGNsb2NrIGFuZCBidXMgY2xvY2sgd2lsbCBi
ZSBlbmFibGVkOw0KPiA+IEluIFNUT1AgbW9kZSwgc3lzdGVtIGNsb2NrIGFuZCBidXMgY2xvY2sg
d2lsbCBiZSBkaXNhYmxlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8
QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IEFwcGxpZWQsIHRoYW5rcy4NCj4gDQoNCkhlbGxv
LA0KDQpJJ20gbm90IHN1cmUgaWYgYW55b25lIGVsc2UgYWxyZWFkeSBub3RpY2VkIGJ1dCBpdCBz
ZWVtcyB0aGUNCmFyY2gvYXJtL21hY2gtaW14L2NwdWlkbGUtaW14N3VscC5jIGZpbGUgd2FzIGRy
b3BwZWQ/DQoNCkl0J3Mgbm90IGluIHlvdXIgdHJlZToNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2hhd25ndW8vbGludXguZ2l0L2NvbW1pdC8/aD1p
bXgvc29jJmlkPWNmMmQyZDM5MjkwNmY1NjAzY2YwZDBmMzYzMGY2Mzg2YmFiZjdlNGINCg0KVGhp
cyBjYXVzZXMgYnVpbGQgZmFpbHVyZXMgaW4gbmV4dC0yMDE5MDExNSB3aXRoIGlteF92Nl92N19k
ZWZjb25maWcuDQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA0K
