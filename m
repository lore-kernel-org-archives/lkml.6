Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE87C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D6821848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BgYTI0Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfBZL4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:56:16 -0500
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:6918
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBZL4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnGVBbfGWsMQG90dTksk/W4tpWkWIZ9cmSuCU38UY9o=;
 b=BgYTI0PwKBj+oO7bPJJ/dUGqDNNN4pK4I/f3AMJHDkROIfEBl20eb8QPb2Xd6ZUHbhRYGsRL60UoPr2Z3ktxu5hdg3cUAtrVInQOKHCWMeGUukaCHw7hdDDsJIm0FEtwKF94OKlPwqTv2XI8RAi+DIrTm4CiQQ7XHJ0Gxh78Yjg=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4445.eurprd04.prod.outlook.com (20.177.55.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Tue, 26 Feb 2019 11:56:09 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:56:09 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog
 binding
Thread-Index: AQHUx1azZw5wqQrc00um4LsJoxWck6XsQYyAgAFkewCABF4ZIA==
Date:   Tue, 26 Feb 2019 11:56:09 +0000
Message-ID: <VI1PR04MB422289A63E04FFC163265FEB807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
In-Reply-To: <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8bb120c-50d6-4d47-3df8-08d69be16582
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4445;
x-ms-traffictypediagnostic: VI1PR04MB4445:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NDQ1OzIzOnJNNXhnS0VjNVJRV3NuRmJ6U3duZWZaUG1w?=
 =?utf-8?B?L0gwT1BvNmxDSUlRMEpWNlk3VDFZdlhvVXNXMnZtQmVCY3F6LzBDc2lWT1ps?=
 =?utf-8?B?TTBmcWVEWmNZQjBRK0ZHMzdES05xVWxwR3paVVdQWjdtUDVDTTBXbThCMm8r?=
 =?utf-8?B?WFNnenp1dW5wUFR1TnQ3SVJySWJYT2xCbDkvaVd4a2hWaThESmlVeFRoWHlB?=
 =?utf-8?B?STg5MVVIVmk0aW9TdlpkS3J1czJxSHFzOS9WMi9ybXpiMStsWTRJR21NbEpP?=
 =?utf-8?B?YjVockhGYlJSZUdrdkNob0NsdU9DZHJHNksybFYwdlA2NmRrRXlZVTFmSVds?=
 =?utf-8?B?cm9iSnZMY3VkaFlVTlNIbjBGTnBPTEtMWUhhamhUUVZ1aGdEcW1ZSytIcWxo?=
 =?utf-8?B?Z3hBdUthYTBJOUhhSVRBTHN4WUVOK3M5Wk1kdjRUQzluRXVlZ1RzeHl1TDlV?=
 =?utf-8?B?bURpT29YRUxnNEo2a2dabkZoc1ZWTGJmOWY4QnFDOTNtS2pnQWZFT0VDNzhK?=
 =?utf-8?B?bUJHT2VtYkJZdUFrNktMOUx1dDFNeUxha3Y4QStzSktlU0NBOURaM0ZHblFm?=
 =?utf-8?B?WFZOdVAvMjhPM042VVBsdDFlV2JDdDVTQy9iZ0dqNEYwaXByRDNPSlh2QXdG?=
 =?utf-8?B?TEw3Y2UxSXdCc21rLzhtYlhEL3ZwbUVtNGd5cmlqenBWdWVtc0lQUE5BRDNV?=
 =?utf-8?B?aFFVZE13U0hyNlNDNkN3aXZaOEhVQm9IMjZFY1I4d042VC9nd3Z2VUo1cyt1?=
 =?utf-8?B?cWlueUZMenh4UXpvK09qb1pWWTloNFJWTWl4MHUvUFNEck5uR3gvTWRQWTRz?=
 =?utf-8?B?Z0JiQ1dacDBKSUZrclR3OGNRUXpoTWFSaGVQUTQ1Rk5uTnhuamFTNE0vdEhT?=
 =?utf-8?B?bTBOVFdEV2RHSGY1c3dWd1VmVThDZloyR2NLbHJTYjJrbkN1OUNkK05NOVE0?=
 =?utf-8?B?bnhXWldlbGdZamhRNkdBbkRlVlZES2grSUgrYzJTWVd1OS9SdEwrOVBtSHhO?=
 =?utf-8?B?UWpuYWljbm5mbTZ6TEhicmx3cVZsTTFNaTNLN0NtcFlXa243V1R0K2tQWDlV?=
 =?utf-8?B?cEMvVmlRL3lxTDN5U1YxQlhKRVhBNHRWVlpmN0RTeE4wcXE0YnVxUWxaRVJC?=
 =?utf-8?B?cmZ5RUJsanZ0bnp1clVTUnJuTTBiQTNrZWhRM2dMc1pVVnljNHRnRWFNV2U4?=
 =?utf-8?B?N3Zwd3Z5TlhjUlBIazlNTWt5aTFqL21WRksvaGRNeHdKTHpGdWltdGk0YlBY?=
 =?utf-8?B?RmRCaUZvdkRDem1jVS9TNHk0UUtoeDFjU3FtTGhaUkpzMVhiTU9YekV1Wkl4?=
 =?utf-8?B?emQvTHFLdlZ5MHRDbE5tWU40eVZVYUNWUzEyZEJkeE94U1Q2MFhGNUtnVFRl?=
 =?utf-8?B?WkNUdlpadExzY05IY0tPN1c5clcrM1N4dkhHRXIwNzZnbUpCTGpMeVc5Z0Iy?=
 =?utf-8?B?UEJpSWRXMndvY2o1ZFZUWkJYR05aTG03eG16N0FJeEt0YkVIbXBCUkNCVEFN?=
 =?utf-8?B?NFJ6cHpGTGt2OUNXTUs1SWYzNGtDWnY3VFZkTjd2SEcxazNNVGR2ZG5SYU1G?=
 =?utf-8?B?M1NobStHZGJFQStZMFBMYm9UWlR0M2hQREFDVmY0UXk5TUR5TWdXK2QvaGZR?=
 =?utf-8?B?S0FxOXNKRFhBQktldFI0RVVDcjdoVjhaek9kb2hjUHpFOGRjQ2NScHFZVzlq?=
 =?utf-8?B?SmswYlV0TzJ5dENrM2hyclJVUTB3YWFNbUNsNTVtUGkyQVUzdWJCbzFvcDRD?=
 =?utf-8?B?L1A5L2taRFNMSkNjS0dDOVVobHRmRzVHbzlYWmZCcEpyU2JocGRPNFFIRWVU?=
 =?utf-8?B?OEhINlBhSHd5WERWUDZLWHFGSzQvR0RGOS9YNitnQ2dJSVE9PQ==?=
x-microsoft-antispam-prvs: <VI1PR04MB444585638DC36419BF2497DD807B0@VI1PR04MB4445.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(52536013)(81156014)(86362001)(5660300002)(55016002)(26005)(6506007)(74316002)(68736007)(7736002)(99286004)(6346003)(6436002)(102836004)(8676002)(229853002)(14454004)(53936002)(8936002)(6636002)(53546011)(14444005)(256004)(6246003)(6116002)(81166006)(7696005)(2906002)(3846002)(7416002)(44832011)(486006)(110136005)(476003)(66066001)(446003)(11346002)(25786009)(54906003)(316002)(76176011)(9686003)(71200400001)(71190400001)(106356001)(105586002)(478600001)(186003)(4326008)(305945005)(93886005)(97736004)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4445;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: akvn/Xdg5gwPJ51w4I7bVtr+QsDdpSp0HzgAiJjeRJ/VZfX8BFG61VHykWt4XzSqRrqUUbmteG5ogDMIoL5Msy0U7cS9ONZMUHgEc3mQzOe59Rgta98i0bZPPEUH7mpyq7j9kUaCDO5wEha9Nkg8l8vHifKoIsYEmn67XBpmpRSqvNedza7VyOjwBCHlHTM21FHyiM5YjIFLHkn7Od8n/JpUmbvRZgbLEraqXcFEGaRDzaBg2cicCledik7GaOYAuuxu6tDY0a6uftRZXrkHSIql3LgzH5IBjrOeAnaOASZuPa3XFM8HdNpQgL93q+WW7/ncA4WiK22+QR9aaVnHAegdKM49f7vAcoNXbFs/ankUZoD/Qv1yEpNWyktDyeG9sQn3BQqBlZR7CXBAULyr6sT5O+XfEGpmg1IBpe4cn5Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bb120c-50d6-4d47-3df8-08d69be16582
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:56:09.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBHdWVudGVyIFJvZWNrIFttYWlsdG86Z3JvZWNrN0BnbWFpbC5jb21dIE9uIEJlaGFs
ZiBPZiBHdWVudGVyDQo+IFJvZWNrPiANCj4gT24gMi8yMi8xOSAxMTo1MiBBTSwgUm9iIEhlcnJp
bmcgd3JvdGU6DQo+ID4gT24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgMDY6NTM6NDhBTSArMDAwMCwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4+IEFkZCBpLk1YOFFYUCBzeXN0ZW0gY29udHJvbGxlciB3
YXRjaGRvZyBiaW5kaW5nLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8
QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPj4gLS0tDQo+ID4+IENoYW5nZXMgc2luY2UgVjE6DQo+
ID4+IAktIHVwZGF0ZSBkdHMgbm9kZSBuYW1lIHRvICJ3YXRjaGRvZyI7DQo+ID4+IC0tLQ0KPiA+
PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxz
Y3UudHh0IHwgMTANCj4gKysrKysrKysrKw0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQNCj4gPj4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+PiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+
ID4+IGluZGV4IDRiNzk3NTEuLmYzODhlYzYgMTAwNjQ0DQo+ID4+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxz
Y3UudHh0DQo+ID4+IEBAIC0xMzYsNiArMTM2LDEyIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+
ID4+ICAgCQkJICAgcmVzb3VyY2UgaWQgZm9yIHRoZXJtYWwgZHJpdmVyIHRvIGdldCB0ZW1wZXJh
dHVyZSB2aWENCj4gPj4gICAJCQkgICBTQ1UgSVBDLg0KPiA+Pg0KPiA+PiArV2F0Y2hkb2cgYmlu
ZGluZ3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wNCj4gPj4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiArDQo+
ID4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+PiArLSBjb21wYXRpYmxlOiBzaG91bGQgYmUg
ImZzbCxpbXg4cXhwLXNjLXdkdCI7DQo+ID4+ICsNCj4gPj4gICBFeGFtcGxlIChpbXg4cXhwKToN
Cj4gPj4gICAtLS0tLS0tLS0tLS0tDQo+ID4+ICAgbHNpb19tdTE6IG1haWxib3hANWQxYzAwMDAg
ew0KPiA+PiBAQCAtMTg4LDYgKzE5NCwxMCBAQCBmaXJtd2FyZSB7DQo+ID4+ICAgCQkJdHNlbnMt
bnVtID0gPDE+Ow0KPiA+PiAgIAkJCSN0aGVybWFsLXNlbnNvci1jZWxscyA9IDwxPjsNCj4gPj4g
ICAJCX07DQo+ID4+ICsNCj4gPj4gKwkJd2F0Y2hkb2c6IHdhdGNoZG9nIHsNCj4gPj4gKwkJCWNv
bXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2Mtd2R0IjsNCj4gPg0KPiA+IEFzLWlzLCB0aGVyZSdz
IG5vIHJlYXNvbiBmb3IgdGhpcyB0byBiZSBpbiBEVC4gVGhlIHBhcmVudCBub2RlJ3MNCj4gPiBk
cml2ZXIgY2FuIGluc3RhbnRpYXRlIHRoZSB3ZG9nLg0KPiA+DQo+IA0KPiBBcyB0aGUgZHJpdmVy
IGlzIGN1cnJlbnRseSB3cml0dGVuLCB5b3UgYXJlIGNvcnJlY3QsIHNpbmNlIGl0IGRvZXNuJ3Qg
YWNjZXB0DQo+IHdhdGNoZG9nIHRpbWVvdXQgY29uZmlndXJhdGlvbiB0aHJvdWdoIGRldmljZXRy
ZWUuDQo+IA0KPiBRdWVzdGlvbiBpcyBpZiB0aGF0IGlzIGludGVuZGVkLiBJcyBpdCA/DQo+IA0K
DQpQZXIgbXkgdW5kZXJzdGFuZGluZywgaWYgdGhlIHByb3RvY29sIGlzIHVubGlrZSB0byBjaGFu
Z2UsIGl0IGNhbiBiZSBpbnN0YW50aWF0ZWQNCmJ5IHBvcnRlbnQgbm9kZSdzIGRyaXZlci4NCg0K
SG9wZSBSb2IgY2FuIGhlbHAgZ2l2ZSBhIG1vcmUgZ2VuZXJhbCBleHBsYW5hdGlvbi4NCg0KUmVn
YXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4gVGhhbmtzLA0KPiBHdWVudGVyDQo=
