Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AEAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6327321019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KKW4jA7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6327321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeK1VEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:04:13 -0500
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:17557
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeK1VEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlYqLQXkn1CJqKJ+gnbyCUQp+LyPcMRa04969EFOxCA=;
 b=KKW4jA7mEk7ocavyAfB3kSQ9iODEmHTbZvh2lJJyhwxtiaPVkS/emJAoKN8pOlPlkZ7cw0ct9F0mcnhFOLdQiXR9XBrN0pvvL2cCj95uBQK5jfTidfkN1Yi1qR5K4i5FTvR0f0snnpSduyqMsjjxhhLzrgCs8u1rd73PCcHUcAE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 10:03:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 10:03:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     =?utf-8?B?TG90aGFyIFdh77+977+9bWFubg==?= <LW@KARO-electronics.de>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Topic: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Thread-Index: AQHUhjVp2fzkoSnTjEGBUoXMaMsjH6Vk5kcAgAAALcCAAAQfgIAAAEBQgAADrICAAADeYIAABgSAgAAAWHA=
Date:   Wed, 28 Nov 2018 10:03:01 +0000
Message-ID: <DB3PR0402MB39164C9E9A7DC29C6D451AC0F5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
 <20181128100420.0c9a721a@karo-electronics.de>
 <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20181128091943.GB8952@piout.net>
 <DB3PR0402MB39168AC8DB69B81C51CE63C2F5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20181128093345.GC8952@piout.net>
 <DB3PR0402MB3916DE94D437DC51435D00CEF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20181128095823.GE8952@piout.net>
In-Reply-To: <20181128095823.GE8952@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3916;6:BXRw0EEuDF7Kf0odD4MoDJRRBwGY6REo3mNd/yRa0WgOkDf1cLB3boA51UhlIGX1+W0wCUqhSt+Kv/HO6NcS7f+6B2ieI7zr4zRNS+EpXV9CdCu4DJfNv0ZBKRtoG+xJdvPGKXnaoXYJWafpT/GPNead1s6V8dxxILbAqSuJ/VjKhRNZjiD8yCl9dyzmCkG/X/1ix0ThuXR6kU6yUxiGDXzgLk6cRz9H1dBqDFuLcInmiOB4vJtfhrQWdE96OYeCwXat1yCiK9GjkFOv2Z8WJLd0nPPXSg92nH0irClCSMzt0Ydau9s6yKVJnCK8RFZV0+l/hROv/1+LhuyfTpU+I6XDrBm/swKZ5kAvtaiX7Ve0fNSGOeJ+3ZWItIvqWTCoTOqrrT4bcA9arDCcZRIby4Wti5yPfT4HKo5qyrVYK2+xWMe4kOBdSc1Rt65ifoWHixhrt7ev4dcYIy5AoRJBFQ==;5:IOVe5pTbX+ahSR1iQRvyeY+lzvOSlaiDMDtMeFHjGnwBujSN481ks0BibGPbvGI9BPxAye/xpySDmhuKiAu/AwPslKiuPZrZnvLL+p+l93Ylm3SOl0iR1v2PTfDsLbYvQszMdTtR8KtF0UPi6xzauWQLrB+qTEl+z+toP5coJRY=;7:eLPfbNiPUPTPj8J0VIgLFsIqJ+nzgmPcqK0/BB17fY6qHDUz1ZuMScNfj2PYXz4d/oC8T5qwX47cZKcdzv0FAzqTK/OkEPcLGT8rDR+I42GijFAx6jD9UG7fL1tA6O+ZfVx2GJSl896gk9dGxEvgGg==
x-ms-office365-filtering-correlation-id: c0c26e55-3e62-4f05-95dd-08d65518aea7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB39160BDF59C6C82668DC63B0F5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(999002)(944501436)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(346002)(376002)(39860400002)(136003)(13464003)(189003)(199004)(305945005)(102836004)(44832011)(5660300001)(53936002)(186003)(55016002)(33656002)(54906003)(446003)(11346002)(486006)(97736004)(256004)(9686003)(6346003)(4326008)(476003)(6306002)(74316002)(7736002)(26005)(7416002)(25786009)(76176011)(66066001)(7696005)(71190400001)(316002)(8936002)(229853002)(71200400001)(6246003)(8676002)(99286004)(93886005)(14454004)(81166006)(81156014)(6916009)(68736007)(966005)(6506007)(575784001)(86362001)(3846002)(53546011)(6116002)(6436002)(45080400002)(106356001)(105586002)(478600001)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: pXCO1N5wvKHx5rOyI3Gfh7ODa5E46t/xKdT3gDHuB++jtlnzRXozwIqwtpo3/IUALC5sA90AgI8fRQ3GJnr1sjUtcsEipuvixd7p3TmkaKTFqLQIvfxHJJQ5tNgfUhXggsqh809QGYII0BecRFr21gChgXz9LacqxgfCWQ7QnghZi9MqxgHxrSQgyZPN59M1C8nc+aXG8liWkp0CDOBVe8tkUmj52RCiFggfyacRWZJmEpqAWG2lxu9LmXyGIulIc7OaBlDubYwXUkXDL5ih+xk7PHuNsoADL8RfW/0UwttaCu/zoQ3HVTwNtXa0Va49LBeofz6JdUy82EyXtrtNQn6l4YBA1dBNgeIZBnNRPhk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c26e55-3e62-4f05-95dd-08d65518aea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 10:03:01.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWxleGFuZHJlIEJlbGxvbmkgW21haWx0bzphbGV4YW5kcmUuYmVsbG9u
aUBib290bGluLmNvbV0NCj4gU2VudDogMjAxOOW5tDEx5pyIMjjml6UgMTc6NTgNCj4gVG86IEFu
c29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogTG90aGFyIFdh77+977+9bWFu
biA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT47IGEuenVtbW9AdG93ZXJ0ZWNoLml0Ow0KPiByb2Jo
K2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsNCj4gd2lsbC5kZWFjb25AYXJtLmNvbTsgQWlzaGVuZyBET05HIDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT47IEFuZHkgR3Jvc3MNCj4gPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47IGFybmRAYXJu
ZGIuZGU7IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1Ow0KPiBoZWlrb0BzbnRlY2guZGU7IGJq
b3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOw0K
PiBhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc7IGV6ZXF1aWVsQGNvbGxhYm9yYS5jb207IG9sb2ZA
bGl4b20ubmV0Ow0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBsaW51eC1ydGNAdmdlci5rZXJuZWwu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gQVJN
NjQ6IGR0czogaW14OiBhZGQgaS5NWDhRWFAgc3lzdGVtIGNvbnRyb2xsZXINCj4gUlRDIHN1cHBv
cnQNCj4gDQo+IE9uIDI4LzExLzIwMTggMDk6NDE6MjIrMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6
DQo+ID4gPiA+IGkuTVggU29DcyBPTkxZIGhhdmUgMSBSVEMuIEFuZCBSVEMgYXJlIGFsd2F5cyBl
bmFibGVkIGJ5IGRlZmF1bHQNCj4gPiA+ID4gZm9yIGFsbCBpLk1YIFNvQ3MsIHNvIGRvIHdlIGhh
dmUgdG8gZGlzYWJsZSBpdCBoZXJlIGFuZCBlbmFibGUgaXQgaW4gYm9hcmQNCj4gZHRzPw0KPiA+
ID4gPg0KPiA+ID4NCj4gPiA+IEkgd291bGQgc2F5IHRoYXQgbW9zdCBvZiB0aGUgaS5NWCBiYXNl
ZCBib2FyZHMgaW5jbHVkZSBhbm90aGVyIFJUQw0KPiA+ID4gYmVjYXVzZSB0aGUgU29DIG9uZSBj
b25zdW1lcyB3YXkgdG9vIG11Y2ggcG93ZXIuDQo+ID4gPg0KPiA+ID4gTm90ZSB0aGF0IEkgZG9u
J3QgY2FyZSB0b28gbXVjaCB3aGV0aGVyIGl0IGlzIGVuYWJsZWQgYnkgZGVmYXVsdCwgSQ0KPiA+
ID4gd2FzIHNpbXBseSBleHBsYWluaW5nIHdoeSB5b3UgbWF5IHdhbnQgdG8gZGlzYWJsZSBpdCBi
eSBkZWZhdWx0Lg0KPiA+DQo+ID4gT0ssIHRoaXMgc3lzdGVtIGNvbnRyb2xsZXIgUlRDIGlzIGEg
bGl0dGxlIGRpZmZlcmVudCwgaXQgaXMgY29udHJvbGxlZA0KPiA+IGJ5IHN5c3RlbSBjb250cm9s
bGVyIGZpcm13YXJlLCBhbmQgc3lzdGVtIGNvbnRyb2xsZXIgZmlybXdhcmUgd2lsbA0KPiA+IGFs
d2F5cyBzZWxlY3QgdGhlIGJlc3Qgb25lIGZvciBpdHMgdXNlcihMaW51eCBrZXJuZWwpIGlmIHRo
ZXJlIGFyZSBvdGhlciBSVENzDQo+IGF2YWlsYWJsZSwgc28gSSB0aGluayB3ZSBjYW4ga2VlcCBp
dCBlbmFibGVkIGJ5IGRlZmF1bHQgZm9yIG5vdy4gVGhhbmtzLg0KPiA+DQo+IA0KPiBEbyB5b3Ug
bWVhbiB0aGF0IHRoZSBwbGFuIGlzIHRvIHB1c2ggc3VwcG9ydCBmb3IgdGhlIGV4dGVybmFsIFJU
Q3MgKGUuZy4NCj4gdGhlIGkyYyBvbmVzKSB0byB0aGUgTTQgZmlybXdhcmU/DQoNCkFzIGZhciBh
cyBJIGtub3csIGN1cnJlbnRseSB0aGVyZSBpcyBubyBzdWNoIHBsYW4vc3VwcG9ydCBpbiBzeXN0
ZW0gY29udHJvbGxlciAoTTQpIGZpcm13YXJlLA0KYW5kIGlmIHRoZXJlIGFyZSBleHRlcm5hbCBS
VENzLCBsaWtlIHNvbWUgUE1JQ3MgaGF2ZSBSVEMgaW5zaWRlLCB5ZXMsIE00IHdpbGwNCmNvbnRy
b2wgaXQgYW5kIExpbnV4IGtlcm5lbCAoQVApIGRvZXMgTk9UIG5lZWQgdG8gY2FyZSBhYm91dCB3
aGljaCBSVEMgaXMgdXNlZCwNCnNhbWUgSVBDIEFQSSB3aWxsIGJlIHVzZWQgSSB0aGluay4NCg0K
QW5zb24uDQoNCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290bGluDQo+IEVtYmVk
ZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmJvb3RsDQo+IGlu
LmNvbSZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDMDE1ZmU4YTE1
ZjM2NA0KPiAwNjZhNmE2MDhkNjU1MTgxZDAzJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlN0MwJTdDDQo+IDAlN0M2MzY3ODk5NTkzOTg4MTU0OTUmYW1wO3NkYXRhPXdtZ1ZlcGFN
alp5YzdkSlEweDhjTFNhUVVsc2hzDQo+IDZqS0NqQmRnQzRGb1lnJTNEJmFtcDtyZXNlcnZlZD0w
DQo=
