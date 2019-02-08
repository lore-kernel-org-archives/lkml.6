Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836BBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AF8206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDf3csYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfBHK6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:58:46 -0500
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:51363
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfBHK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87hdJgEuPKx4Z9fg+p6yY338IKP9MvyI//9aFYtJot4=;
 b=RDf3csYf89QoZEhIyGJQnAavifwIvvir9Ttn2mV+WIVpGLxQnZiQaMHQ5GvaMDp2/Sfm0QJF+jN8VLVUEAlM6PBzF7GReAHrbujmC4oUbsMxYOQlVcLjUfguP9HZ0dBlPwHzPPgbIPrLXIkSIhVa+VQhEAba4WCEmi10RzjAF7k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3723.eurprd04.prod.outlook.com (52.134.72.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 10:58:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 10:58:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtc: imx-sc: depend on HAVE_ARM_SMCCC
Thread-Topic: [PATCH] rtc: imx-sc: depend on HAVE_ARM_SMCCC
Thread-Index: AQHUv5XWqj44llWn9E6iZtZbP9h8raXVuwBg
Date:   Fri, 8 Feb 2019 10:58:41 +0000
Message-ID: <DB3PR0402MB3916931E7D13EB0657A5C226F5690@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190208100530.21872-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190208100530.21872-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3723;6:nW6IqnUrEiVeZ/D0m/93g5YgtMOaiLaAEY1GQi1GcbxwJIMnLOIRTotAa9zNC6iaycn6GjvNR1s+51CnT1j4TCpxaZkIZ78QbvS7NJapU0clHPVhuL1oPAaHIzzNk9Ebjw5zJo4+0NTLDTrsRZxLii5r3qD4k6pwhUeGSa63SIy5wytp3EupSSUD2wYEBNw5nSpiTw0D5W4zfedZic5GBPOWl21y3zNVjWVn1yB//wmzLfbDlGDTpOMfu+CP8lSNSzLsSulpYgnb2kaXVjkVTbPDGJniIXC0ciSViH32xEIjw4ISF90VbuYlAva/jxot+lWwRbqXBNbPkLDeJl7daYBoV+tY/UG/WRgjiYRQB6O3waLVxJuZjgIG8spkJEDUz51mEhZe6X+GnoAYWmJIg88XCEIxuBcA4myIidscAnOPv0ldyIEB03BVnEMLZtpqPupW9byvrLGczBaNonkoag==;5:u5Nxlca2lisV9k5+JDMsI8hHRWy9a1G5QFAene0lu/GfQa7EyDN+3sC2aY7l3r9ZeaC2w6XlKR4Z48wS283p8xk/W3WHYe+EZuM1MKKvWStdj4gnfZOF80UFmQ9lAk3zmK5WnE/WKW9vel29S0eVCF1K9ZllMt0xMRVCW0gRMN+M9dTRAuwID2sA5p+Pt/khNgiswAL9RE0ZAAIJjtXuHw==;7:ezCc4EWRFDjTK4krZi85dKE9zhz7Hss4pWeios0fArN8zGWivkL2U4tHGZSLpPQrLF3CV/DKwVTD6odUjRhadBllbKHae5aj8uCL0H2fQfaqAP7LmCjUwtiGTp+zQdAw6tvhh5e13eI9DZy/pRC2aQ==
x-ms-office365-filtering-correlation-id: 9da15248-a504-44e2-28d8-08d68db462eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3723;
x-ms-traffictypediagnostic: DB3PR0402MB3723:
x-microsoft-antispam-prvs: <DB3PR0402MB37239A777DE5C86F2B103332F5690@DB3PR0402MB3723.eurprd04.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(13464003)(189003)(199004)(55016002)(7696005)(305945005)(9686003)(6436002)(86362001)(7736002)(68736007)(14454004)(76176011)(26005)(97736004)(8936002)(6116002)(3846002)(8676002)(186003)(2906002)(81156014)(81166006)(256004)(102836004)(478600001)(66066001)(110136005)(316002)(4326008)(53546011)(6246003)(33656002)(25786009)(486006)(53936002)(6506007)(44832011)(446003)(11346002)(99286004)(74316002)(476003)(71190400001)(2501003)(106356001)(105586002)(71200400001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3723;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Fl5CwuyWgFH1w53iUNjeAOTlQu0rScpKpyXVj7q3HPzWne4t0HpXeMt9jA1EfHUMqolYl4Ncemm4hp8qNTcpZOI2BaXLpDaT9OpDGpjfVSDU0EPsPMl8jTzvS6QRaYCtl1cvqmZSr+pXUD4YngdYStw0ia+Un+U2QaXWBZy47kOShW3vteivEMwOZgpHkad44tX95CWthYcN28BBnLnGzQde8m3alAi8e5xRu0R7F19/6xPFg/nMTW7CWxrfWYRB/l7yYQ8Xm4z8RpW2qXQdjsKji6eSVsHipua9WUvqlxHBGL7W4yjs4DPivbUWXQE10eW5Bh668p7SJFn8EDZrYv76j6aT+ZFvGI2Bfls8Fi9hCIJwI1HLFB6HhzB3F2d70/xlTWnU3lbgN0aFQuGp1MH60w4aBW4ho4EHzGnxac=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da15248-a504-44e2-28d8-08d68db462eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 10:58:41.1521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWxleGFuZHJlIEJlbGxvbmkgW21haWx0bzphbGV4YW5kcmUuYmVsbG9u
aUBib290bGluLmNvbV0NCj4gU2VudDogMjAxOcTqMtTCOMjVIDE4OjA2DQo+IFRvOiBsaW51eC1y
dGNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNv
bT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEFsZXhhbmRyZSBCZWxsb25pIDxh
bGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBydGM6IGlt
eC1zYzogZGVwZW5kIG9uIEhBVkVfQVJNX1NNQ0NDDQo+IA0KPiBGaXggdGhlIGZvbGxvd2luZyBi
dWlsZCBpc3N1ZToNCj4gDQo+IGRyaXZlcnMvcnRjL3J0Yy1pbXgtc2MubzogSW4gZnVuY3Rpb24g
YGlteF9zY19ydGNfc2V0X3RpbWUnOg0KPiA+PiBydGMtaW14LXNjLmM6KC50ZXh0KzB4MjEyKTog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX19hcm1fc21jY2Nfc21jJw0KPiANCj4gRml4ZXM6IDEz
YTkyOWYzOGFkNyAoInJ0YzogaW14LXNjOiBhZGQgcnRjIHNldCB0aW1lIHN1cHBvcnQiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxp
bi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ydGMvS2NvbmZpZyB8IDEgKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvS2Nv
bmZpZyBiL2RyaXZlcnMvcnRjL0tjb25maWcgaW5kZXgNCj4gZmFhOWFlMWEzMDYyLi44ZjY3MzVl
MGZmMTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcnRjL0tjb25maWcNCj4gKysrIGIvZHJpdmVy
cy9ydGMvS2NvbmZpZw0KPiBAQCAtMTY5OCw2ICsxNjk4LDcgQEAgY29uZmlnIFJUQ19EUlZfU05W
Uw0KPiANCj4gIGNvbmZpZyBSVENfRFJWX0lNWF9TQw0KPiAgCWRlcGVuZHMgb24gSU1YX1NDVQ0K
PiArCWRlcGVuZHMgb24gSEFWRV9BUk1fU01DQ0MNCj4gIAl0cmlzdGF0ZSAiTlhQIGkuTVggU3lz
dGVtIENvbnRyb2xsZXIgUlRDIHN1cHBvcnQiDQo+ICAJaGVscA0KPiAgCSAgIElmIHlvdSBzYXkg
eWVzIGhlcmUgeW91IGdldCBzdXBwb3J0IGZvciB0aGUgTlhQIGkuTVggU3lzdGVtDQo+IC0tDQo+
IDIuMjAuMQ0KDQpTb3JyeSBmb3IgdGhlIG1pc3Rha2UuDQoNClJldmlld2VkLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0K
