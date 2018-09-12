Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D5A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OC9SZOhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D5A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeILNdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:37 -0400
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:40352
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728091AbeILNdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07r3mvCDDPrHAgHzSgbFwBXTl8QP7fuimmf7ba1t+ds=;
 b=OC9SZOhnnIu3VdgRSz/8Jmq8hhucQS9HkaPP87ru3PcwNubt71UH5/+OktGv4BacZ1ZMm1lgRMjq4VkrtA9B+CHZ6e6f74oAidNi1hw5aT+WgvjwcL+D9FSBHTUfsnXVLg9xDEVhFkCa3tUDPi/9CIqM7JB9xh69zuAEc8wzPSQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Wed, 12 Sep 2018 08:30:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2%5]) with mapi id 15.20.1122.020; Wed, 12 Sep 2018
 08:30:04 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
Thread-Topic: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
Thread-Index: AQHUSnEkTUNaxTyCoESMrG9rWlwir6TsUDKAgAAAJBA=
Date:   Wed, 12 Sep 2018 08:30:04 +0000
Message-ID: <DB3PR0402MB3916249305E241849A32DC05F51B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
 <d989e700-0cf1-607a-b333-bdead49ae813@i2se.com>
In-Reply-To: <d989e700-0cf1-607a-b333-bdead49ae813@i2se.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3900;6:RS6vz2Mh0l7jD32eid7RcmKs38NCwopJKdjmRlBPQ5GAMAd5SzOdVzCpTIybTkGoIjrBiTUGRNW2MI4rkJ5SMfLm2Wr0Mw1zpbjTkwGxBTbaCVJdhV2kl+4OBM9kwaf8LEPi9cRh/1a5EUs1PRCVfvTRQAE4kleFt3iqrJx2C6P+yO2scWDCNGJt2BJG0AjRXn5hCj6dGjBVLtfnO4MP3pIgM4NVnwC3X0pt/e+3M+hIbFx1qb5a1HFWzoDScVNgO3vzmiiaVwIvn/THfqjx0VpWesfj4HrRzlwL093IKMZOdT2FWhdCXYzinU5dGZ9UkY8EsBnxzMVmtqO2fQsCMwkHXGc5EUQg27xljuzHUD1ejyOQZuh9rzax12Es4hLaaw2e3N2OIOXQ2v+OdjApQclMG9HN5ZoAdcU1qrKE6QgQYaSIR6HptMkIsk2afLC06VgiVT2Z+gO014PkqnIXQA==;5:w4eCMPmN3Tr/BQU20XNhhBWY5HuRjOL5cmhHcqX4A65OIs8N6Ohnt+amQ2TmKJcsi9+0DswzyNHD8ctnjDiMTm12Sd3r1gQtogPa2CGtvRbPMFT4iWcixLbmotDuWi8oBlqEIE8LfdabUMb/EiohztIF61gi4cygkaWtly3jd/4=;7:mOoM8nqdeozfHw8QS6TGnDllZi4MGB/ngwUZbD0QsofBcFat3oouDFnE+jJGLu7YwyRNGbOBI8ffvQNcf1rdNtsS1eUD7WVt2dLW4qHRZBXDWVaO3DAtTAeVCp95ETWKsmz/pV3llUSPigaoCwp0fi40+KT6k1K24VKwczoayrd6oG9A2vQScTFC7Lu15E03v0Q4e116hwfk7ccMhchDnoAL++JfcYWQn4XOtpgc+VtQ9neIZKKhQAxqwQoTsWAW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 524f8eaa-c2d9-4619-73ae-08d61889f0c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-microsoft-antispam-prvs: <DB3PR0402MB3900BDB0ACC850F8019C6746F51B0@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DB3PR0402MB3900;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3900;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(13464003)(189003)(199004)(6116002)(446003)(97736004)(53936002)(7696005)(66066001)(99286004)(476003)(68736007)(9686003)(76176011)(2906002)(11346002)(8936002)(33656002)(2900100001)(486006)(25786009)(110136005)(4326008)(102836004)(14444005)(256004)(186003)(105586002)(229853002)(106356001)(6436002)(6506007)(26005)(15650500001)(7736002)(5660300001)(5250100002)(55016002)(2501003)(74316002)(305945005)(316002)(53546011)(8676002)(6246003)(478600001)(81166006)(81156014)(14454004)(44832011)(86362001)(2201001)(3846002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fzEUaT0PsaxKZqDYBXIJ0AcZbxQGt4FWTG9f9ed4VXBWM8MAPWiK1KjU5QztjZnc7UOBj4wBnlnCBSyGZMDVTiFdkeLg380KKoaNxf5Sy9Li2dSVXWhl4CdJxScnpRBVwxbWQvag9/jmk1OELoui4z5A4B6z6m+VfCVN1AJvGIjhB7SGWsjDvkLKntW7lTEShNg4teKj9AEK5Mu9P/kkHMvH8yajsIWD9Zhk63yinNKRRyC3dbJH54FdNiUdsI0pwi2YTItiX5fmXYv1vkssvd3cI4IkFkFwMR2qMrHfO1Gzqan3Y9IX03aMh/fBMhTRzJ1ML10PV3mafNwEfUOPO347Ao9CrW7DN5wpvVIepQY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524f8eaa-c2d9-4619-73ae-08d61889f0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 08:30:04.8408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZWZhbg0KDQpBbnNvbiBIdWFuZw0KQmVzdCBSZWdhcmRzIQ0KDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIFdhaHJlbiA8c3RlZmFuLndhaHJlbkBp
MnNlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMTggNDoyOCBQTQ0K
PiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwu
b3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IEZh
YmlvIEVzdGV2YW0NCj4gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9y
ZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogZHRzOiBpbXg2dWxsOiB1cGRhdGUgdmRkX3NvYyB2b2x0
YWdlIGZvciA5MDBNSHoNCj4gb3BlcmF0aW5nIHBvaW50DQo+IA0KPiBIaSBBbnNvbiwNCj4gDQo+
IEFtIDEyLjA5LjIwMTggdW0gMTA6MTMgc2NocmllYiBBbnNvbiBIdWFuZzoNCj4gPiBVcGRhdGUg
VkREX1NPQyB2b2x0YWdlIHRvIDEuMjVWIGZvciA5MDBNSHogb3BlcmF0aW5nIHBvaW50IGFjY29y
ZGluZw0KPiA+IHRvIGRhdGFzaGVldCBSZXYuIDEuMywgMDgvMjAxOCwgMjVtViBpcyBhZGRlZCB0
byB0aGUgbWluaW11bSBhbGxvd2VkDQo+ID4gdmFsdWVzIHRvIGNvdmVyIHBvd2VyIHN1cHBseSBy
aXBwbGUuDQo+IA0KPiBpcyB0aGVyZSBhIHJlYXNvbiB3aHkgdGhlIG5ldyBkYXRhc2hlZXQgaXNu
J3QgcHVibGlzaGVkIHlldD8NCiANCldlIGp1c3QgZ290IHRoaXMgbmV3IGRhdGFzaGVldCByZWNl
bnRseSwgaXQgd2lsbCBiZSBwdWJsaXNoZWQgc29vbi4NCg0KQW5zb24uDQoNCj4gDQo+IFJlZ2Fy
ZHMNCj4gU3RlZmFuDQoNCg==
