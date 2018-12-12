Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0392C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F132084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Q7CuaH8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F132084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeLLLmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:42:24 -0500
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:44024
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbeLLLmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb1xNu3bBYsIpOcT4fcbOYpvoMfaxPmKll+VpXEzvow=;
 b=Q7CuaH8Drb1Gt5YUx17eSLZVtoTiAoHaKeKYSjEppSGQctrvMLbMMi+xiBLFXAk1qYnhyna3g+BJow9rlXon3+bZVSug+dnzQble16rUp09r0EGqzDLDgPTuZicV2dzujpZpdcebUkqBk8VCC1oytRzAF5DHlzJlnwolJwyH4SY=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4123.eurprd04.prod.outlook.com (52.135.130.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 11:42:17 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 11:42:17 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in disabled
 state
Thread-Topic: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Thread-Index: AQHUjWllpnSfybe6SEqAejrjFKHx0aV6xxEAgAA9jwA=
Date:   Wed, 12 Dec 2018 11:42:17 +0000
Message-ID: <52ed0614-d1f5-81cb-3b17-8eb137967872@ysoft.com>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181212080154.kcfh57mulypwuscu@pengutronix.de>
In-Reply-To: <20181212080154.kcfh57mulypwuscu@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0099.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::40) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4123;6:vBbbgpDHzkQqBATnpMN+lrjrxgdL5gqFji8sncrqbeAT7m7kSFTxYFiu90FKT1T1bpc2MeeFvFi2yd2GBbps4A7QEwSQuvCYv32ko3h/Y8s6ay4LoWWgI1lOivNvkhraVsk5WgjHb5aGrwgZ3hlorR43FSfg3HAXjsYMWQdIXsi7RZCvr10Q61aXT9n8r5X92SILI61GWBTH+krJXwa1uE20awA6KmC7wjIJEeqnDfbmTOuIKPt7dyIQv3HLpDDuPgpK9b8KUUGrkcX5FvquCuoEhCwFXfHCNjVIhDEplsbUIMH7NJFNvEVWPBXgK8e3F+XXJgn3eq53UC718GAu7PMJD/P2II9TD/IoqM4FUBa/9yJHnGFpCmJkOcPB9Hgppb1k1IJfnIgwZxOJebCFgNOM4mCZf/yqNMfCl8WW/lZMO9K0GhKgVW4qzVosc5zatq6ieWxfRlx4aGh1emM67w==;5:QDX8Dr7nSuU3nbF7m0TiVkY86UsXupQ1daxrjl2ujckWBkAuFj2dm4DJ8UiYZCaeVLrlMD6KZ6MoCZkVxk353VWhz+Krov/c8lath52dGn7AS4/QniSixh1DCW0vpFA0Nq0VDEcQEwQlD51/ZKQR8TdRGlZjXxF88NOu7bdjvWM=;7:PHRIHWT0i9JJEShkGAdGEzidORuQzeb22HXcUGDDGbriSMWtGAOVZ9bfV5eNTLnSBHLwKmew4dPIQAHbPIJdHnIBJ+xIJfeuKg70kbcZzv8qP3AD0P0GAoYhNhT3EdO7M3LR34SQNBx1iyvM02tzCA==
x-ms-office365-filtering-correlation-id: 83cc1133-97cd-4ba5-6c9c-08d66026ddf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4123;
x-ms-traffictypediagnostic: DB7PR04MB4123:
x-microsoft-antispam-prvs: <DB7PR04MB4123F5183537B8EF5EF60E8C9EA70@DB7PR04MB4123.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4123;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4123;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(6916009)(316002)(217873002)(31696002)(81166006)(2616005)(81156014)(6506007)(102836004)(6436002)(53546011)(6246003)(386003)(11346002)(99286004)(446003)(54906003)(86362001)(476003)(26005)(105586002)(53936002)(186003)(7736002)(85182001)(106356001)(478600001)(6512007)(72206003)(7416002)(36756003)(14444005)(68736007)(14454004)(305945005)(8676002)(256004)(66066001)(97736004)(31686004)(8936002)(52116002)(6486002)(71190400001)(76176011)(71200400001)(2906002)(3846002)(6116002)(25786009)(486006)(5660300001)(39060400002)(4326008)(229853002)(66574011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4123;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W3cSGyZQbXW9KIP4Ql1CgRjfGg7R1u4hWVuxuSTZurmbcyl1GdG64NbOmdIusGFo6rzajSbdqo05eS3PqdJWxGFTcn0c/Hni7hiTlgtFl7QLGNAwlp9Dt9MZKbNfPESp+zRu+vR2mJzIjjsr7he2umegM9orKslcW62MmlTRyeUCMwM5SXQ80xjNrO8ih6qRENyJpBxAindgVmVYliyBGFdjizuA3Ug/YEM5D5SGHfexx359BV/gI5WqecBcIZ9CqoR+To9PZo25+ZhYOCvsumqp+9crBCSJmnSnkDwVw0gt1fY+3sFI4P/vOV5GA3fz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1287C928D1C2794F83464EDC9125F542@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cc1133-97cd-4ba5-6c9c-08d66026ddf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 11:42:17.1441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMTIuMjAxOCAwOTowMSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IE9uIFRodSwg
RGVjIDA2LCAyMDE4IGF0IDAxOjQxOjMxUE0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0K
Pj4gTm9ybWFsbHkgdGhlIFBXTSBvdXRwdXQgaXMgaGVsZCBMT1cgd2hlbiBQV00gaXMgZGlzYWJs
ZWQuIFRoaXMgY2FuIGNhdXNlDQo+PiBwcm9ibGVtcyB3aGVuIGludmVydGVkIFBXTSBzaWduYWwg
cG9sYXJpdHkgaXMgbmVlZGVkLiBXaXRoIHRoaXMgYmVoYXZpb3INCj4+IHRoZSBjb25uZWN0ZWQg
Y2lyY3VpdCBpcyBmZWQgYnkgMTAwJSBkdXR5IGN5Y2xlIGluc3RlYWQgb2YgYmVpbmcgc2h1dC1v
ZmYuDQo+Pg0KPj4gQWxsb3cgdXNlcnMgdG8gZGVmaW5lIGEgInB3bSIgYW5kIGEgImdwaW8iIHBp
bmN0cmwgc3RhdGVzLiBUaGUgcHdtIHBpbmN0cmwNCj4+IHN0YXRlIGlzIHNlbGVjdGVkIHdoZW4g
UFdNIGlzIGVuYWJsZWQgYW5kIHRoZSBncGlvIHBpbmN0cmwgc3RhdGUgaXMNCj4+IHNlbGVjdGVk
IHdoZW4gUFdNIGlzIGRpc2FibGVkLiBJbiB0aGUgZ3BpbyBzdGF0ZSB0aGUgbmV3IHB3bS1ncGlv
cyBHUElPIGlzDQo+PiBjb25maWd1cmVkIGFzIGlucHV0IGFuZCB0aGUgaW50ZXJuYWwgcHVsbC11
cCByZXNpc3RvciBpcyB1c2VkIHRvIHB1bGwgdGhlDQo+PiBvdXRwdXQgbGV2ZWwgaGlnaC4NCj4+
DQo+PiBJZiBhbGwgdGhlIHBpbmN0cmwgc3RhdGVzIGFuZCB0aGUgcHdtLWdwaW9zIEdQSU8gYXJl
IG5vdCBjb3JyZWN0bHkNCj4+IHNwZWNpZmllZCBpbiBEVCB0aGUgUFdNIHdvcmsgYXMgdXN1YWwu
DQo+Pg0KPj4gQXMgYW4gZXhhbXBsZSwgd2l0aCB0aGlzIHBhdGNoIGEgUFdNIGNvbnRyb2xsZWQg
YmFja2xpZ2h0IHdpdGggaW52ZXJzZWQNCj4+IHNpZ25hbCBwb2xhcml0eSBjYW4gYmUgdXNlZCBp
biBmdWxsIGJyaWdodG5lc3MgcmFuZ2UuIFdpdGhvdXQgdGhpcyBwYXRjaA0KPj4gdGhlIGJhY2ts
aWdodCBjYW4gbm90IGJlIHR1cm5lZCBvZmYgYXMgYnJpZ2h0bmVzcyA9IDAgZGlzYWJsZXMgdGhl
IFBXTQ0KPj4gYW5kIHRoYXQgaW4gdHVybiBzZXQgUFdNIG91dHB1dCBMT1csIHRoYXQgaXMgZnVs
bCBicmlnaHRuZXNzLg0KPj4NCj4+IEludmVydGVkIG91dHB1dCBvZiB0aGUgUFdNIHdpdGggImRl
ZmF1bHQiIGFuZCB3aXRoICJwd20iKyJncGlvIiBwaW5jdHJsOg0KPj4NCj4+ICstLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tICstLS0tLS0tLS0t
LS0tKw0KPj4gfCBBZnRlciByZXNldCAgfCBCb290bG9hZGVyIHwgICBQV00gcHJvYmUgICB8ICAg
ICBQV00gICAgfCAgICAgUFdNICAgICB8DQo+PiB8IDEwMGsgcHVsbC11cCB8ICAgICAgICAgICAg
fCAgICAgICAgICAgICAgIHwgZW5hYmxlIDMwJSB8ICAgZGlzYWJsZSAgIHwNCj4+ICstLS0tLS0t
LS0tLS0tLSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLSstLS0tLS0t
LS0tLS0tKw0KPj4gfCBwaW5jdHJsICAgICAgfCAgICBub25lICAgIHwgICAgZGVmYXVsdCAgICB8
ICAgZGVmYXVsdCAgfCAgIGRlZmF1bHQgICB8DQo+PiB8IG91dCBIICAgX19fX19fX19fX19fX19f
X19fICAgICAgICAgICAgICAgICAgIF9fICAgX18gICAgICAgICAgICAgICAgIHwNCj4+IHwgb3V0
IEwgICAgICAgICAgICAgICAgICAgICBcX19fX19fX19fX19fX19fX18vICBcXy8gIFxfL1xfX19f
X19fX19fX18gfA0KPj4gfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeICAgIF4gICAgXiAgICAgICAgICAgICAgICB8DQo+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLSsNCj4+IHwg
cGluY3RybCAgICAgIHwgICAgbm9uZSAgICB8ICAgICAgZ3BpbyAgICAgfCAgICAgcHdtICAgIHwg
ICAgIGdwaW8gICAgfA0KPj4gfCBvdXQgSCAgIF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18gICBfXyAgIF9fICAgX19fX19fX19fX19fXyB8DQo+PiB8IG91dCBMICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFxfLyAgXF8vICBcXy8gICAgICAgICAgICAgIHwNCj4+
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXiAgICBeICAgIF4g
ICAgICAgICAgICAgICAgfA0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogTWljaGFsIFZva8OhxI0gPG1pY2hhbC52b2thY0B5c29mdC5jb20+DQo+PiAtLS0NCj4+IENo
YW5nZXMgaW4gdjM6DQo+PiAgIC0gQ29tbWl0IG1lc3NhZ2UgdXBkYXRlLg0KPj4gICAtIE1pbm9y
IGZpeCBpbiBjb2RlIGNvbW1lbnQgKFV3ZSkNCj4+ICAgLSBBbGlnbiBmdW5jdGlvbiBhcmd1bWVu
dHMgdG8gdGhlIG9wZW5pbmcgcGFyZW50aGVzZXMuIChVd2UpDQo+PiAgIC0gRG8gbm90IHRlc3Qg
ZGV2bV9waW5jdHJsX2dldCBmb3IgTlVMTC4gKFRoaWVycnkpDQo+PiAgIC0gQ29udmVydCBhbGwg
bWVzc2FnZXMgdG8gZGV2X2RiZygpIChUaGllcnJ5KQ0KPj4gICAtIERvIG5vdCBhY3RpdmVseSBk
cml2ZSB0aGUgcGluIGluIGdwaW8gc3RhdGUuIENvbmZpZ3VyZSBpdCBhcyBpbnB1dA0KPj4gICAg
IGFuZCByZWx5IHNvbGVseSBvbiB0aGUgaW50ZXJuYWwgcHVsbC11cC4gKFRoaWVycnkpDQo+Pg0K
Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+ICAgLSBVdGlsaXplIHRoZSAicHdtIiBhbmQgImdwaW8iIHBp
bmN0cmwgc3RhdGVzLg0KPj4gICAtIFVzZSB0aGUgcHdtLWdwaW9zIHNpZ25hbCB0byBkcml2ZSB0
aGUgb3V0cHV0IGluICJncGlvIiBwaW5jdHJsIHN0YXRlLg0KPj4gICAtIFNlbGVjdCB0aGUgcmln
aHQgcGluY3RybCBzdGF0ZSBpbiBwcm9iZS4NCj4+DQo+PiAgIGRyaXZlcnMvcHdtL3B3bS1pbXgu
YyB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQ0KPj4NCg0KWyBzbmlwIF0N
Cg0KPiBPbiB0aGluZyBJIG5vdGljZWQgd2hpbGUgbG9va2luZyBhdCB0aGUgcmNhciBkcml2ZXIg
aXM6IFRoaXMgZG9lc24ndA0KPiB3YWl0IGZvciB0aGUgY3VycmVudCBwZXJpb2QgdG8gZW5kLiBJ
cyB0aGlzIHN1cHBvc2VkIHRvIGhhcHBlbj8gQWxzbyBmb3INCj4gdGhlIGVuYWJsZSBjYXNlIHRo
ZSBoYXJkd2FyZSBpcyBjb25maWd1cmVkIGZvciB0aGUgZGVzaXJlZCBkdXR5IGN5Y2xlDQo+IGFu
ZCBvbmx5IHRoZW4gdGhlIHBpbmN0cmwgaXMgc3dpdGNoZWQgdG8gcHdtLiBCb3RoIG1pZ2h0IHJl
c3VsdCBpbiBhDQo+IHNwaWtlIHRoYXQgaXMgbm90IGRlc2lyZWQuDQoNClRoZSBiZWhhdmlvciBz
aG91bGQgbm90IGNoYW5nZSBmcm9tIGhvdyBpbXgtcHdtIHdhcyB3b3JraW5nIGJlZm9yZS4NCldo
ZW4gUFdNIGlzIGRpc2FibGVkIHRoZSBvdXRwdXQgaXMgaW1tZWRpYXRlbHkgZ2F0ZWQgb2ZmIChw
dXQgaW50bw0KdGhlIGlkbGUgc3RhdGUpIGluZGVwZW5kZW50bHkgb24gdGhlIHBlcmlvZC4gSSBt
ZWFzdXJlZCB0aGlzLg0KDQpGb3IgdGhlIGVuYWJsZSBjYXNlIHlvdSB3b3VsZCBjZXJ0YWlubHkg
bm90IGdldCBhbnkgYWRkaXRpb25hbCBzcGlrZXMuDQpUaGUgd29yc3QgdGhpbmcgdGhhdCBtYXkg
aGFwcGVuIGlzIHRoYXQgdGhlIGZpcnN0IHBlcmlvZCB3aWxsIGJlDQpzbGlnaHRseSBzaG9ydGVy
IGRlcGVuZGluZyBvbiBob3cgbG9uZyBpdCB0YWtlcyB0byB0ZXN0IHRoZSBwaW5jdHJsDQphbmQg
c3dpdGNoIHRoZSBtdXhpbmcuIEFuZCB0aGlzIGlzIHVuYXZvaWRhYmxlLCBpdCB3b3VsZCBoYXBw
ZW4gZXZlbg0KaWYgeW91IHdhaXQgZm9yIHRoZSBzdGFydCBvZiBhIHBlcmlvZC4gVGhlIHRlc3Qg
KyBtdXhpbmcgc3RpbGwgdGFrZXMNCnNvbWUgdGltZS4NCg0KTWljaGFsDQo=
