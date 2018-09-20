Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB5ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F1121526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k839o0ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F1121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbeITOdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:33:12 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:61446
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbeITOdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9OWehp/sO8PSpb9qAy9bWj0LpZoO7PfXzSErhM8UfA=;
 b=k839o0bav1Fq8oyieFVwsVz7noODdmt7QaDYc6/w63MSvuAAqrq7AaC0wvMLl8Mge+BDq0QY5E2h3kECnSuiUD1G1jqCNZj4Ql+luDmAubWhwDvunhjARtGOe3XKfzZ6ypDVSNW8MFJiZ8QIt3D0S3EljmCp5mGcHQVkd7sitjg=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4996.eurprd04.prod.outlook.com (20.177.40.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Thu, 20 Sep 2018 08:50:44 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03%2]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 08:50:44 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jslaby@suse.cz" <jslaby@suse.cz>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] serial: imx: remove set but not used variable
 'rtsirq'
Thread-Topic: [PATCH -next] serial: imx: remove set but not used variable
 'rtsirq'
Thread-Index: AQHUUK2BjiCmViLF0kWmryq0h9SVQaT43KyA
Date:   Thu, 20 Sep 2018 08:50:44 +0000
Message-ID: <96170d620618804d49ad19323d3cdee853070c72.camel@nxp.com>
References: <1537408725-196364-1-git-send-email-yuehaibing@huawei.com>
         <3b23675a-f537-868f-2432-b7f8a0c8c466@suse.cz>
In-Reply-To: <3b23675a-f537-868f-2432-b7f8a0c8c466@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4996;6:+lM+bZfQhZbdgVwcKz92LQ6baN+/Q2fhVTRfPhErJ+QROogKggK48NO+0szgwgI5Nx5ExkCPvOvUbNI67zIIYkIF0ezSClpNEAR2Lv+C33dPvI3oF3vHBYRx+E8s6OVKN+RZXaHE9JPD4BGj9mDBAz72LSUGtPAhkqgruuVoo411pB/4VeXyK0wCO7ML48MGWk2MglaYLgq1AHiH8PoiEKvbjseGM/gIBDseQi5r+DKgvLfSH+lJaXEL8bFkNeFXzljoYyGn9TWttTprKlkIAFXTJdOlgkWuKIoUMLTgdC75DuT4VL4rokZJ+kRTqck+vKTEDA/EeAQpS3TGCEENkrKZ8gTp5NMnWWjprRL5drTQf9jxS6+abEY+kUL6EpXJnROixeYnOnrErlURkomkTnuzcR2ZqsqJrNe1Mxyp1iU2+mupzSUlzrTUIAGuMb6zziSFE3Ry2/qQrdO2P8GL/w==;5:oznH8VDRK0efK9wthpWWK8gc9+1bV6icMjtMJoNuRNCwSwQUJo1EqjXjE6IH3LP/+V/P1tA4EnrTKDX5Mmg4IJj6TO0LC9dRwdy96EaJSUJ0LVl7bGEAI2oiWO6ojnZEBQtoY2JwaU/9UPv30lrBGMzKEm5QmaRwMRpZRokqWkg=;7:VOPTgZE5tYsrkU3qbUt99211bFV5fjva/7Tr9wE08aLrJ0dBhsIAs/yg/SatbGIHAMJgDhBBQqB2OF4XZQjJD9DnLgdWTQHZzRBPwxZmsxPFiSYDMhxy0wEe+84cuG3zp+W6RUrHJRZ2V1+DcbPE+V4qI43FxhHyAudN8CR7I+on016gv8aCyVkScimATMAabNwoiEx6tRA+3EAfDyjcWfMY5bD33DtI2NqNovHNxMVKFs7MYyBnGRa6sxkbQXxL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 912ae276-5ee6-4764-466c-08d61ed62711
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4996;
x-ms-traffictypediagnostic: AM0PR04MB4996:
x-microsoft-antispam-prvs: <AM0PR04MB49961C6809C25BF0AAEFC19FEE130@AM0PR04MB4996.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR04MB4996;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4996;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(5660300001)(6486002)(14444005)(76176011)(36756003)(14454004)(86362001)(8936002)(81166006)(81156014)(478600001)(2900100001)(6246003)(5250100002)(25786009)(229853002)(26005)(2201001)(53546011)(6506007)(50226002)(102836004)(186003)(2501003)(66066001)(44832011)(11346002)(486006)(8676002)(53936002)(446003)(2906002)(68736007)(97736004)(4326008)(6436002)(316002)(256004)(99286004)(6512007)(105586002)(6116002)(3846002)(305945005)(110136005)(7736002)(476003)(118296001)(54906003)(2616005)(106356001)(71200400001)(71190400001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4996;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LvFfpFpFBGy0EDWnL6VIp0wODduMFlsMQMGg8IvLtKRKdnOjzNT3kOKmMkc5Ta1I9DW7+ElQtZbLuheARU0EdYCAyL9MwcuVUAJXkRXr3Fv8/9/oB9UXXtDW8HmJLfZeYhEnBP/HPF/OTc4S5m3LMLF2Ke69GRwW1hAdWR2D/z0VoAki0xn/jAqqmrG4oc5aMO7o1uO3cM7GN4dHZT5v1fWHYTYT6sxE9mY7t5wR9YA+QfROR8lOh8orrAzyx1mtgS2eUbBcfj//dvjEJxptfA76dJsiDB7dTSFDFCATtXxhL3sjgmH1rIGLLY7qAGO2epL/HFg0lTqPp6TqdfU1EFq9ddGMF4KSUf21MnyWHrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C1F8B952E84E45884A0D1BA851D765@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912ae276-5ee6-4764-466c-08d61ed62711
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 08:50:44.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4996
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA5LTIwIGF0IDA4OjQ1ICswMjAwLCBKaXJpIFNsYWJ5IHdyb3RlOg0KPiBP
biAwOS8yMC8yMDE4LCAwMzo1OCBBTSwgWXVlSGFpYmluZyB3cm90ZToNCj4gPiBGaXhlcyBnY2Mg
Jy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6DQo+ID4gDQo+ID4gZHJpdmVycy90
dHkvc2VyaWFsL2lteC5jOiBJbiBmdW5jdGlvbiAnaW14X3VhcnRfcHJvYmUnOg0KPiA+IGRyaXZl
cnMvdHR5L3NlcmlhbC9pbXguYzoyMTk4OjIwOiB3YXJuaW5nOg0KPiA+ICB2YXJpYWJsZSAncnRz
aXJxJyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvaW14LmMNCj4gPiBAQCAtMjIyMCw3ICsyMjIwLDYgQEAgc3RhdGljIGludCBpbXhfdWFy
dF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICANCj4gPiAgCXJ4aXJx
ID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gPiAgCXR4aXJxID0gcGxhdGZvcm1fZ2V0
X2lycShwZGV2LCAxKTsNCj4gPiAtCXJ0c2lycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMik7
DQo+IA0KPiBJIGFtIG5vdCBzdXJlIHRoaXMgaXMgY29ycmVjdC4gcGxhdGZvcm1fZ2V0X2lycSBo
YXMgc2lkZSBlZmZlY3RzIChsaWtlDQo+IGVuYWJsaW5nIHRoZSBJUlEpLiBBcmUgeW91IHN1cmUg
dGhpcyB3b24ndCBjaGFuZ2UgdGhlIGJlaGF2aW91ciAodGhpcyBpcw0KPiBxdWVzdGlvbiBtb3N0
bHkgdG8gSU1YIGZlbGxvd3MpPw0KDQpBcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGVyZSB3YXMgYSBy
ZXF1ZXN0X2lycSBjYWxsIGZvciBydHNpcnEgd2hpY2ggd2FzDQpyZW1vdmVkIGJ5IG1pc3Rha2Ug
aW4gY29tbWl0IGFmZTljYmIxYTZhZCAoInNlcmlhbDogaW14OiBkcm9wIHN1cHBvcnQNCmZvciBJ
UkRBIik6DQoNCi0gICAgICAgICAgICAgICAvKiBkbyBub3QgdXNlIFJUUyBJUlEgb24gSXJEQSAq
Lw0KLSAgICAgICAgICAgICAgIGlmICghVVNFX0lSREEoc3BvcnQpKSB7DQotICAgICAgICAgICAg
ICAgICAgICAgICByZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIHJ0c2lycSwNCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW14X3J0c2ludCwg
MCwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X25h
bWUoJnBkZXYtPmRldiksIHNwb3J0KTsNCi0gICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQp
DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQotICAgICAgICAg
ICAgICAgfQ0KDQpUaGlzIHNob3VsZCBoYXZlIGp1c3QgcmVtb3ZlZCB0aGUgSVJEQSBjaGVjayBh
bmQgcmVxdWVzdCBydHNpcnENCnVuY29uZGl0aW9uYWxseS4gTm9ib2R5IG5vdGljZWQgdGhpcyBi
eSB0ZXN0aW5nIFJUUyBvbiBpbXgxLCB0aGlzIGlzIGFuDQpvbGQgY2hpcCBhbmQgbGF0ZXIgdmFy
aWFudHMgaGF2ZSBhIHNpbmdsZSBjb21iaW5lZCBpcnEuDQoNClRoZSBjb3JyZWN0IGZpeCBmb3Ig
dGhlIHdhcm5pbmcgd291bGQgYmUgdG8gcmVzdG9yZSB0aGF0IHJlcXVlc3RfaXJxLg0KDQotLQ0K
UmVnYXJkcywNCkxlb25hcmQNCg==
