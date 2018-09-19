Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50980C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005A22150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kw3Q+xTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005A22150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbeISTcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:32:55 -0400
Received: from mail-db5eur01on0069.outbound.protection.outlook.com ([104.47.2.69]:27913
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730876AbeISTcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DFLbbv2UcsVLJI/yPJFUR8lCrsmReU2Ew1m1ZYve/s=;
 b=kw3Q+xTBsQnbNbtXsqt+K6OQXrj+WoLT9MP37W5tk9ZxpRbgvY4MeSosqY2RgM5CVzFmKA3QQoj9dPPU3IXX/uVo45g4MKTlm57Ejq2IrCV2bufY1oTxd92OY5eP62PL9z5LS+iPmEJc1Lf3BL8Q0rxy/dzmRqkqunjp5nzL+eI=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3479.eurprd04.prod.outlook.com (52.133.19.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 13:51:57 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764%2]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 13:51:57 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 16/21] arm64: dts: ls1046a: add smmu node
Thread-Topic: [PATCH 16/21] arm64: dts: ls1046a: add smmu node
Thread-Index: AQHUUBVuZ8utTEEVwEuFHEpFf/8bX6T3mdWAgAAF2wA=
Date:   Wed, 19 Sep 2018 13:51:57 +0000
Message-ID: <c5dfa099-c927-8843-9519-0687e68c4faf@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <20180919123613.15092-17-laurentiu.tudor@nxp.com>
 <a4d32163-71b1-35df-3a4c-eb27b605fc46@arm.com>
In-Reply-To: <a4d32163-71b1-35df-3a4c-eb27b605fc46@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3479;6:DlYUxJc6b0kInHhx7ggoY2HmMORmhmRZDKpCk/U0SdAvt0kR8/0k0FUxMPq9+9TvsuvPJLgQByO8qP/FL6ZiOL4xKt8FdPPxfEiYQBjfJ9cEx7VtUDRSnrARB4fY+TxfnjZR1/kvh4N5m+KEu+d7arJhj8reGOlFAIRpnjWnPQVXUK7sEy1VLMFwNNdNqUhFn5d4jnMUlPG5kzF+hZIx1F9sockcB4fEVwmIwzMmp9I56BQJunltdTVXiLtg01mQAvbSppLZYsM562oaj3YV/xg8/tkPOY0rxtP5ymMi4qYfpZ6oy/ayoX1O/PmUpVhVokWWpQr585LZ7YL/VEUCnlFISd2p3MS6QyX60GRxjY2IktzKA8udzO/e69yKGZ+tFlB+Se2iBFlvuH/FMk5VpyIZukWKl8+cEdwV+YbzdBVmkoe81JPcFStQa5AaGZt5i0wkYB4TDsYY6o21rAby1g==;5:k5n5V9aowEyY6ME8AKyBbnfNaKTCxC+lRWpM92n9lnVLJSG/l4VbI935+OkND46TU/iJuJsT7gsMwNui9mQ0aIf/We7XBJB6feau0N4gacQS6XsaspsARAmRHRrY2AaDbssXZUV43iMma9YHBcnQ1HW46zk2R54f00Kgmp7WH60=;7:z0AexGCVCyKSPbHRU22aHyx3Gqu3T1RbkZx/RNHKg8083tF+Fbpg+dpj4twmoInbujUIQHFZ3AwYv88NQhRlOtpnRiNe6U0pv0B4x2iDeoIf1SBJwza+Xn9l+1OvgXl0i+W3r/7cpRVkvcL1uwNyU2INnaekB8/OcK2u0skDbLsWcmS2z4ARZiB88IZsQg7zt1PSskdRtr/UlEwApq3vV+tsJlBh5pfJ5NArLHnkJKbar4aWnOTKDqUht52HjR4v
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0affda81-c9d7-46ef-c3c9-08d61e3710da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3479;
x-ms-traffictypediagnostic: AM6PR0402MB3479:
x-microsoft-antispam-prvs: <AM6PR0402MB34799EFA2E0C365D9DF72B88EC1C0@AM6PR0402MB3479.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:AM6PR0402MB3479;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3479;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(486006)(478600001)(8676002)(6512007)(25786009)(36756003)(316002)(66066001)(256004)(3846002)(7736002)(14454004)(110136005)(53936002)(54906003)(53546011)(31686004)(106356001)(476003)(2616005)(81156014)(6506007)(6246003)(81166006)(2201001)(102836004)(31696002)(14444005)(105586002)(8936002)(11346002)(44832011)(4326008)(6436002)(6486002)(2906002)(186003)(5250100002)(86362001)(2501003)(446003)(229853002)(2900100001)(68736007)(26005)(97736004)(6116002)(305945005)(76176011)(5660300001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3479;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KRRO52yc67J/QD3KlrPx7vakHciGq778LftE3emZfOI4YrXXmpCT8QdWbQlcr2/AMaX/I10DBAwAci+Lqa2ZCOhFP7F+DHul1jxOlCNjVWj42K/KyUmbuYhfdBYj/5JcB5S8gs9yAYNwROp7DPi4Blj+yHakGdutlj/hC6qQuFiY/kihStFruDGUK2c9yGrf0miZYYGnErKfq8lmbgB7zyBtVKUWq9wVVJy7ZebEzorc2qlLbL8tbuR3mFoosOiQRPo4AOeRWTFBDe0E9An5TBsVbKbOsSKVjOLdGQCvjPsrerQIMmVU+Hvg0E3HfMx3IJpmdanqcV0Lv7PnMLnSOyeT51vAucUtJbxUxMwHNxY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <471585F071FE6148B5ACF777B23D3565@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0affda81-c9d7-46ef-c3c9-08d61e3710da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 13:51:57.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCk9uIDE5LjA5LjIwMTggMTY6MzAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4g
T24gMTkvMDkvMTggMTM6MzYsIGxhdXJlbnRpdS50dWRvckBueHAuY29tIHdyb3RlOg0KPj4gRnJv
bTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4+DQo+PiBUaGlz
IGFsbG93cyBmb3IgdGhlIFNNTVUgZGV2aWNlIHRvIGJlIHByb2JlZCBieSB0aGUgU01NVSBrZXJu
ZWwgZHJpdmVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVu
dGl1LnR1ZG9yQG54cC5jb20+DQo+PiAtLS0NCj4+IMKgIC4uLi9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTA0NmEuZHRzaSB8IDQyICsrKysrKysrKysrKysrKysrKysNCj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kgDQo+PiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kNCj4+IGluZGV4IGVmODM3ODZi
OGI5MC4uMDY4NjNkM2U0YTdkIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWxzMTA0NmEuZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWxzMTA0NmEuZHRzaQ0KPj4gQEAgLTIyOCw2ICsyMjgsNDggQEANCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1cy13aWR0aCA9IDw0PjsNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCB9Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIG1tdTogaW9tbXVAOTAwMDAwMCB7DQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImFybSxtbXUtNTAwIjsNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwwIDB4OTAwMDAwMCAwIDB4NDAwMDAwPjsNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYS1jb2hlcmVudDsNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICNnbG9iYWwtaW50ZXJydXB0cyA9IDwyPjsNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICNpb21tdS1jZWxscyA9IDwxPjsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
dGVycnVwdHMgPSA8MCAxNDIgND4sIC8qIGdsb2JhbCBzZWN1cmUgZmF1bHQgKi8NCj4gDQo+IEVp
dGhlciB0aGF0J3Mgbm90IHJlYWxseSB0aGUgc2VjdXJlIGdsb2JhbCBpbnRlcnJ1cHQsIG9yIHRo
b3NlIGNvbnRleHQgDQo+IGludGVycnVwdHMgYXJlIHdyb25nLg0KDQpOb3cgdGhhdCB5b3UgcG9p
bnRpbmcgb3V0LCBJIHJlYWxpemUgdGhhdCB0aGUgY29tbWVudHMgZG9uJ3QgbWFrZSBtdWNoIA0K
c2Vuc2UuIEFjdHVhbGx5LCAxNDIgaXMgdGhlIG5vbi1zZWN1cmUgaW50ZXJydXB0IChhbGwgaW50
cyBhcmUgT1JlZCBvbiANCnRoaXMgSVJRKSB3aGlsZSAxNDMgaXMgdGhlIHNlY3VyZSB2ZXJzaW9u
LiBJJ2xsIHVwZGF0ZSB0aGUgY29tbWVudHMgaW4gDQp0aGUgbmV4dCByZS1zcGluLg0KDQotLS0N
ClRoYW5rcyAmIEJlc3QgUmVnYXJkcywgTGF1cmVudGl1DQoNCg0KPiANCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwwIDE0MyA0PiwgLyogY29tYmluZWQgc2Vj
dXJlIGludGVycnVwdCAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgPDAgMTQyIDQ+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIH07DQo+PiArDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgc2NmZzogc2NmZ0AxNTcwMDAwIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbXBhdGlibGUgPSAiZnNsLGxzMTA0NmEtc2NmZyIsICJzeXNjb24iOw0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MCAweDE1NzAwMDAgMHgwIDB4MTAwMDA+
Ow0KPj4=
