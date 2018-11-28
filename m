Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C666EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794FF208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QgH1UQB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794FF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeK1Uma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:42:30 -0500
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:44736
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727541AbeK1Um3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px+NCu5qq8iyw1859QgRNQy3u4ebczI8GFLW0dZ4+XY=;
 b=QgH1UQB4a6ip91agt9l5oovwoMX0YLzY1Ffik2AuB9rvWu7civ+XIbK6o+6RK+7ySamfDsfyDEzc69ZMaSs9D1iAzcyI+wExYIlHffVAjWSnJ6YiKZXY4dFkd3XIIEcFO786QrYCiUGeMCS2dqJIHKf58vyDdqbTyyEVlylEiYE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 09:41:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:41:22 +0000
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
Thread-Index: AQHUhjVp2fzkoSnTjEGBUoXMaMsjH6Vk5kcAgAAALcCAAAQfgIAAAEBQgAADrICAAADeYA==
Date:   Wed, 28 Nov 2018 09:41:22 +0000
Message-ID: <DB3PR0402MB3916DE94D437DC51435D00CEF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
 <20181128100420.0c9a721a@karo-electronics.de>
 <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20181128091943.GB8952@piout.net>
 <DB3PR0402MB39168AC8DB69B81C51CE63C2F5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20181128093345.GC8952@piout.net>
In-Reply-To: <20181128093345.GC8952@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3755;6:AgkkmBNbLPTbKu989X/qSVKtFzxqvb6etJTr3ZApELFlKRJgSUZ/U6XrAPndhXBJJyxv/BFoxapU9a35Wud8styaBYCBSwi/ifyv/ZZr8BhJqMHSygznM9pY2L99a7Ev5VQe9Zk4ScGcrOTb8PiwOVlq1EfmSlSdKZsOMxkyEOnjT6BkJ+eHgJj002uTAFP8I36T1yqbrMD0fm99BCzjPoR09/bPlWZJV8OH7+A9dNVjTN9dvHVjGzwIqCygvENAA8TZ2a9MzJpBoxzpYMaxBPtZsa60bC6e30iBcReU/w+6Kev3pBmCOcHGNqIxC97CumsWzd/U705VBMYU2pPVuiSbjt8Vop3s99N7cB4A6bWzlH65iMKu1M532RQDoxAc2Qwwk3jR4no+E3q/OHBKSk3GZVRb/6dCRYdh/8XbZ6gcG+gAlPDD6/9ToZuTALjtEeY86uAh2E7yiu8tY1uL2Q==;5:hcb8fsl3WHhpAlim5vobFVgeKSHoCHD3QTH2MCuDx+v/9PpMAsu7pLg5nPqlT7l1T7RYRivKbkY9fGEdyDn0GRAtByF5IcUruuNaPT0v7Gl0u54d0aSy9f/PbAri1wqiTKEwOPPM7u/CjhTT6HiW/HmTHFOePAUCOc8Gc9goNhI=;7:ABOsnxa9aR5khVdqAgg6aAKHhZLzxLRXc9sJrEKegkIoSl9bHJ3DyzJ2qMGsTYT5dqvh8pBAP6Fdx0YSJqNhuWLAm74c+ot6Xe6tK6jaXln2AESka4orToFMRPAhCvtk9n36d6cwA/Dh4yNY+EZe0A==
x-ms-office365-filtering-correlation-id: 96842ea6-5557-463a-81df-08d65515a852
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3755C051D371335190EDB7A5F5D10@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3755;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3755;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(13464003)(199004)(189003)(106356001)(53936002)(8936002)(81166006)(81156014)(8676002)(33656002)(14454004)(54906003)(229853002)(25786009)(2906002)(55016002)(6306002)(316002)(9686003)(99286004)(478600001)(305945005)(7736002)(26005)(66066001)(68736007)(186003)(97736004)(4326008)(966005)(6506007)(7696005)(6116002)(74316002)(3846002)(93886005)(45080400002)(76176011)(476003)(446003)(11346002)(102836004)(53546011)(486006)(6246003)(105586002)(575784001)(86362001)(5660300001)(6436002)(71200400001)(71190400001)(6916009)(44832011)(256004)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BnrquGZvK/T77D6HOPOpvDvzzFt/mRYMgSQVb2IcJ9inwznEqbsiRJGa+p5d0jN2vZsrDoGRiwj9cHJPBtE8oylXlcLAwpYVm2JSJmpA7kRTap2YgLAa0f0Wy+9pTdmebQnyv6FkyRHi/MEEozzj0qSsM0Kk2hFwx+N+O5o+bwKsPb/7UDw2XIRliqRIuxzSJ74qdV8hkssNrtfXPBRGIIQnCVIJ0toT0wMlvLVVrAIMVdQnslUlzGrDPFsnqhoJM93LVuGO+zVRGL8ishM+Rug7sxx2B6vf9CXmMiE7knmUeBJTEMOTouu46S//JmsdeoZ9nnUcJ7xbmWB2+bZrfb1ouV+0T38OYJLb1bLyd4w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96842ea6-5557-463a-81df-08d65515a852
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:41:22.5220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWxleGFuZHJlIEJlbGxvbmkgW21haWx0bzphbGV4YW5kcmUuYmVsbG9u
aUBib290bGluLmNvbV0NCj4gU2VudDogMjAxOOW5tDEx5pyIMjjml6UgMTc6MzQNCj4gVG86IEFu
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
cnQNCj4gDQo+IE9uIDI4LzExLzIwMTggMDk6MjE6NTYrMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6
DQo+ID4gPiA+IFRoaXMgbW9kdWxlIGlzIE5PVCBkZXBlbmRpbmcgb24gYW55IGJvYXJkIGRlc2ln
biwgc2hvdWxkIGl0IGJlDQo+ID4gPiA+IGVuYWJsZWQgYnkNCj4gPiA+IGRlZmF1bHQgaW4gc29j
IGR0c2k/DQo+ID4gPiA+IExpa2Ugd2RvZyBldGMuLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEkg
Z3Vlc3MgdGhlIHBvaW50IGlzIHRoYXQgeW91IG1heSBub3Qgd2FudCBpdCBlbmFibGVkLCBldmVu
IGlmIGl0DQo+ID4gPiBzaG91bGQgYWx3YXlzIGJlIHdvcmtpbmcuIGVuYWJsaW5nIGl0IGJ5IGRl
ZmF1bHQgd291bGQgYWZmZWN0IHRoZSBSVEMNCj4gb3JkZXJpbmcgZm9yIGV4YW1wbGUuDQo+ID4N
Cj4gPiBpLk1YIFNvQ3MgT05MWSBoYXZlIDEgUlRDLiBBbmQgUlRDIGFyZSBhbHdheXMgZW5hYmxl
ZCBieSBkZWZhdWx0IGZvcg0KPiA+IGFsbCBpLk1YIFNvQ3MsIHNvIGRvIHdlIGhhdmUgdG8gZGlz
YWJsZSBpdCBoZXJlIGFuZCBlbmFibGUgaXQgaW4gYm9hcmQgZHRzPw0KPiA+DQo+IA0KPiBJIHdv
dWxkIHNheSB0aGF0IG1vc3Qgb2YgdGhlIGkuTVggYmFzZWQgYm9hcmRzIGluY2x1ZGUgYW5vdGhl
ciBSVEMgYmVjYXVzZQ0KPiB0aGUgU29DIG9uZSBjb25zdW1lcyB3YXkgdG9vIG11Y2ggcG93ZXIu
DQo+IA0KPiBOb3RlIHRoYXQgSSBkb24ndCBjYXJlIHRvbyBtdWNoIHdoZXRoZXIgaXQgaXMgZW5h
YmxlZCBieSBkZWZhdWx0LCBJIHdhcyBzaW1wbHkNCj4gZXhwbGFpbmluZyB3aHkgeW91IG1heSB3
YW50IHRvIGRpc2FibGUgaXQgYnkgZGVmYXVsdC4NCg0KT0ssIHRoaXMgc3lzdGVtIGNvbnRyb2xs
ZXIgUlRDIGlzIGEgbGl0dGxlIGRpZmZlcmVudCwgaXQgaXMgY29udHJvbGxlZCBieSBzeXN0ZW0g
Y29udHJvbGxlciBmaXJtd2FyZSwNCmFuZCBzeXN0ZW0gY29udHJvbGxlciBmaXJtd2FyZSB3aWxs
IGFsd2F5cyBzZWxlY3QgdGhlIGJlc3Qgb25lIGZvciBpdHMgdXNlcihMaW51eCBrZXJuZWwpIGlm
IHRoZXJlIGFyZSBvdGhlcg0KUlRDcyBhdmFpbGFibGUsIHNvIEkgdGhpbmsgd2UgY2FuIGtlZXAg
aXQgZW5hYmxlZCBieSBkZWZhdWx0IGZvciBub3cuIFRoYW5rcy4NCg0KQW5zb24uDQoNCj4gDQo+
IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBL
ZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmJvb3RsDQo+IGluLmNvbSZhbXA7ZGF0YT0w
MiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDNWJlNmQwMTRmMmE1DQo+IDQ4NzZjYzk0
MDhkNjU1MTRlYWYzJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDDQo+
IDAlN0M2MzY3ODk5NDU2NjQ2NDY3ODUmYW1wO3NkYXRhPU1XMHh5M2NVaENMQlRyRUZrazR2QXls
eFNBd0INCj4gbXgxV3M2WmVFaEFzZE1FJTNEJmFtcDtyZXNlcnZlZD0wDQo=
