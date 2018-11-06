Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36EAC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8132A2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dWpTKzrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8132A2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbeKGBAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:00:12 -0500
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:34592
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387741AbeKGBAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUXX9y1r8lHixYuC+AfOf054HDkCWkg/oK9dUcNrrEs=;
 b=dWpTKzrsxnaBpmMoqPcytF1RvYbaaqr3Gevwr5VWNF4dOPDogB7HctJKtmG0ns46oL4rAyYDask36c6xVmgQYdGqqq9x7rmcR55YFUEfsuQcinXaSO1KmkYEWbiZ7coH6nd/2qqzSXyII81wfvj7Vx/uK4ftA2IMQufx/eXkAT0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5059.eurprd04.prod.outlook.com (20.177.40.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 15:34:24 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:34:24 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUaT95oCO6Jr50e0qyeeRGaZQa8qUprLpggBlLwPCAAAFpgA==
Date:   Tue, 6 Nov 2018 15:34:24 +0000
Message-ID: <7e58f0dcf83a0bd8139e58e27bfa137fc186b4bf.camel@nxp.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
         <AM0PR04MB4211576EF2FE906A6B0C3F1680FB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
         <AM0PR04MB4211280B09B72F637FC5650280CB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211280B09B72F637FC5650280CB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5059;6:I7eWF/idQEwXJZLbUAVHUx+DhGlqv5t2RK3fwA0RgXC2aXN9Xh14TxDzWf3/k2bp9agbdUcK1TbCXle8aez/JEGptOhpKlp2vEV546PN/x9boA8VHXRdyw8dNOr5rxTDYNe441Pfm3JDz9lGxwcuwGFyKhq1+lsNpW++dpuSnz0Z/LjZhbcHrdM78bXOFWbN9hBQg7FZxWB0CDsS2r466WWksnCbQNQc+vn2+ysThXjLYZO8eCZ2NhFsTpFDP+9To80lMPBr18DhPF/URCJOLiSyqLTyGvxs4looEsKSxQEgslQKBJcRp4xZpUaf4upy19SkavcfDKFoW0iIGKuNt3LIpTPG4xKgAH2YTjlG81s4Omg+ZT32FMpYhe56/plvtG5EOk9FqxwOvyJwL9zZATzSVjCJZI+M2h+4kP19zFZIqclSvZ+7x3rwvqb1ThkO2b8SpOpywDxD+917NEQy0A==;5:D1ZQNHlALViLQshfNgGsrlLO+YCupWTxsNQv2t88E95Hhph1e/F8TL8AzgcfHKDtNED0smEWE4uUjzw9zFYIWiGmXYDhwLwvH9vSlqn7RVaP0h2SxYw2AaaRIvdTVEr0fp/LxpvOEV8Lotoky/ZShO2VGUyEgO5rlzdBQmLU4S4=;7:oFx5cQLwfWNsQJjhFQy5iUfLmuDq7G5YGDGof/FthgMtmDifxa4Khe4ADa7ruSdW9az0gEBU9CFLhSC2vTqh01ulAGwCUxcZbUL3h73jSSP+S751WGYkGwR3Wz14ISvn3mnCAfLG2ZzExSsaRxnpcQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c1dbb1c7-2241-49f6-4da5-08d643fd547a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5059;
x-ms-traffictypediagnostic: AM0PR04MB5059:
x-microsoft-antispam-prvs: <AM0PR04MB50599840AD75442A2AFBD611EECB0@AM0PR04MB5059.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5059;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5059;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(76176011)(229853002)(81166006)(53936002)(3846002)(81156014)(25786009)(99286004)(6512007)(6486002)(26005)(6506007)(6436002)(97736004)(186003)(2501003)(102836004)(6116002)(14444005)(2900100001)(217873002)(50226002)(86362001)(256004)(8676002)(71200400001)(71190400001)(68736007)(8936002)(6636002)(36756003)(4326008)(118296001)(446003)(105586002)(11346002)(106356001)(5660300001)(486006)(66066001)(2906002)(44832011)(7736002)(305945005)(476003)(478600001)(2616005)(6246003)(54906003)(316002)(110136005)(14454004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5059;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yTl9cjNAFG7aLlRIONNx9xvm7oollV4fKrCtTGtvk+kRlfUM1r12mDRlPP6COZBmBogPj7rbRCNnUBCuoNTDE8tBbQWZTSGlnD6PdkPuH+bXLoWv2CrbdNotdgcfwaRby69soiGaaPjAR6S12h4vKETuaCSlC71/u3kr0jJDjF7T5EGzZkkrLsU8Ze6CxDDDddvUTpuhY+5rsqtCCOA/RsKSmLs4hUZGgrkNsEph3xo0Jfy0dAj+el+Bi7lsMoL6S2snnLYe0LQIA8cwpQsA/kusLxkCb5c2M+8D1GJtNvDsJwXBNTa72M/itjZXPs6JIzVgq9O8ici9ziddanCY+dJ0s8wZTkIHUVrUyXb/Yoo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <86D8C0D19E51F24893F5EEC86A083DE7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dbb1c7-2241-49f6-4da5-08d643fd547a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:34:24.1498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTA2IGF0IDE1OjMwICswMDAwLCBBLnMuIERvbmcgd3JvdGU6DQo+IEdl
bnRseSBQaW5nLi4uDQoNCj4gZHJpdmVycy9jbGsvaW14L2Nsay1jb21wb3NpdGUuYyAgICAgICAg
ICAgICAgICAgICAgfCAgODUgKysrKysrKysrDQoNCkR1cmluZyByZXZpZXcgZm9yIDhtIGNsb2Nr
cyBhIHNlcGFyYXRlIGJ1dCBkaWZmZXJlbnQgY29tcG9zaXRlIGNsayB3YXMNCmFkZGVkLiBJbiBv
cmRlciB0byBhdm9pZCBjb25mdXNpb24gdGhhdCB3YXMgbmFtZWQgImNsay1jb21wb3NpdGUtOG0u
YyIsIA0KaXQgd291bGQgbWFrZSBzZW5zZSB0byBtb3ZlIHRoZSA3dWxwIGNvZGUgdG8gY2xrLWNv
bXBvc2l0ZS03dWxwLmMuDQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA0K
