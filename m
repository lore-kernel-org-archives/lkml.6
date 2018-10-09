Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B2C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBBF2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="d+97wRaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBBF2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJISUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:20:31 -0400
Received: from mail-he1eur01on0074.outbound.protection.outlook.com ([104.47.0.74]:4032
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbeJISUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac4svbj10aqolEYUjxhDX+p9+9oMaU/t1uLm4oLU7mM=;
 b=d+97wRaBbHb4EGRIZsxwjF9RlY0ai6lZasld4DmIXSIDq/88AmYDSEfmmqrKq7rIN9P0T/3Ozu7KlbYNla+9hazmD1G6eYP992sr1lUaxODs4fjkelp/QoJbpmROGJlMwKewc6hB3bnJi9pg4CR0RVDtJI6S8sz3ZEqXN8MS3Mo=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4601.eurprd04.prod.outlook.com (52.135.138.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Tue, 9 Oct 2018 11:03:59 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd%2]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 11:03:59 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Lukasz Majewski <lukma@denx.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
Thread-Topic: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Thread-Index: AQHUOVz/YN07jQXB4U+/NWDnbjCE2aTNKJ6AgAAs8QD///NoAIBJw9uA
Date:   Tue, 9 Oct 2018 11:03:59 +0000
Message-ID: <1dff44a8-2c1a-910b-dde6-cb04e1ccc4b5@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180823123759.68b78e9f@jawa>
 <0691e93d-c2e2-21e5-374f-c29e7765de93@ysoft.com>
 <20180823143600.3e417542@jawa>
In-Reply-To: <20180823143600.3e417542@jawa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0602CA0005.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::15) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4601;6:TaJpDSyrqTqveBvggADA34DOqlGT5gqOgZ0SvzO4ZLFWaV/uaGNdxUzYm2ZadYRfONAKNcMUVR6KU1Pj74NnMJiPEdWzh3Ti41Qmtdo4ZETg/xE9rSejwwFX4+kanuan8piz9pze68tJHTGvlYxZyPjxfM5Nw5OQknNCE/BU7hBc1hIyth1I/kIUhQkAhsKlJmeTXN4BS8r/k3/UBMwU0l7LU02D4SAfbQ1LX60ZoEzn9ZyJSkrocW3OA2O10xVWtVY7tH/qnswoGY29n8tIGLUeKPxf+4oLHdcCheFvmbEKAlaPKfzFRCgCowzQDIoFqgvnIHCtLcyD9f/8TDf2q8Jtdvez1UpSTuCy3IdvFGC3NiFpNHeudL3MblIBkE61/D04sWV1p8ispjtuRQWM9MAXWMzRej2Q/KcyYMbCSZZA2DbZLR/Hu+nzb3p79hLxbu6i8Lz6n04iFRBODSYWDw==;5:cb/OdbDo2DJh/fsy52zdGc0HoTdEpuaUiaUSBEWC5xqROCuDPOfxQikEd71uOQBaZrFa9GWwRhSiFv/1D7KrzpAJccoQYPeVhaZDEB9td2dBYm2XfTWbjb2cnnNjWi3BqYEyeIkjuQ8V3iZ4fbkUeF5IMk5LZfIcNDv1Lqxmmpg=;7:7bdzt6QNK2/ezV7fEVkQY4vh7dpwT7YqEaBn7SmcXGNVV7Vf26IhvcyQRGW6hqoUaiKCsZPn9IijNGEXtA38EOk/EAcd4yt2ImLnhe8Y7YRdtaU3xhhSuLSTizdU+ZzgfYh2ZexsnSxmUxPe7spKcoATnd/S3/CUpIInZK4YyltjuUVoqXfN4KaSCQQlValfG+aDd7JVHbDfLS4fwE1VOOdFpn+WBQVWLTa7pfZrKQmlTn1gmF/1YlFzaaea6RLI
x-ms-office365-filtering-correlation-id: d9149fc5-c59c-4bc0-4173-08d62dd6ea22
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4601;
x-ms-traffictypediagnostic: DB7PR04MB4601:
x-microsoft-antispam-prvs: <DB7PR04MB4601E58AA21A20C79A3A7FBC9EE70@DB7PR04MB4601.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:DB7PR04MB4601;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4601;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(376002)(136003)(199004)(189003)(85664002)(51914003)(5660300001)(2906002)(97736004)(14444005)(256004)(93886005)(217873002)(316002)(575784001)(86362001)(6436002)(7736002)(36756003)(6116002)(3846002)(229853002)(31696002)(2900100001)(6916009)(305945005)(6512007)(68736007)(5250100002)(106356001)(6486002)(53936002)(105586002)(85182001)(4326008)(478600001)(2616005)(53546011)(39060400002)(6506007)(386003)(81166006)(76176011)(102836004)(81156014)(25786009)(6246003)(486006)(446003)(31686004)(52116002)(11346002)(99286004)(72206003)(54906003)(476003)(8676002)(14454004)(345774005)(8936002)(71200400001)(71190400001)(66066001)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4601;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K3Lc5hhviNpnLlR8s1JMSeq4DhjotrctMDMUusoulbFYyI2LM/k6KNmb4JCGFgTAGg5hF7/hKcThYcMyp8uLK/z/Paa3wUBX4KJ8xHOQ4q1vIFiLuwPf6jXR74YQVBCoVmdfZ/TFp5Y4Ki5nJQbK8ypBnCf4kuCGwu3zpQ9yIexBjpblUz6is4uR7iM3wk5CGwxMgjg6XarnMv/jRGfNdl8uJfgpX8B4l0xq+A7xrPR3BVLKB1/YB7Fq1SZBfVxWJng7BFtaLWgHbZ39MNmaLwn8vGMCAX1EE3UQ4VrnrcFm+/D5RqTJKbMSC52Mx1yqSmtvABwnmREgE8535v2iW9LSAAbzkoGeLWPb9+pgwPQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB252AD023EA1E46AD6D38FBAA19719B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9149fc5-c59c-4bc0-4173-08d62dd6ea22
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 11:03:59.6837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuOC4yMDE4IDE0OjM2LCBMdWthc3ogTWFqZXdza2kgd3JvdGU6DQo+IEhpIE1pY2hhbCwN
Cj4gDQo+PiBPbiAyMy44LjIwMTggMTI6NDAsIEx1a2FzeiBNYWpld3NraSB3cm90ZToNCj4+DQo+
PiBIaSBMdWthc3osIHRoYW5rcyBmb3IgdGhlIHJlcGx5IQ0KPj4+IEhpIE1pY2hhbCwNCj4+PiAg
ICANCj4+Pj4gT3V0cHV0IG9mIHRoZSBQV00gYmxvY2sgb2YgaS5NWCBTb0NzIGlzIGFsd2F5cyB6
ZXJvIHZvbHRzIHdoZW4gdGhlDQo+Pj4+IGJsb2NrIGlzIGRpc2FibGVkLiBUaGlzIGNhbiBjYXVl
IGlzc3VlcyB3aGVuIGludmVydGVkIFBXTSBwb2xhcml0eQ0KPj4+PiBpcyBuZWVkZWQuIFdpdGgg
aW52ZXJ0ZWQgcG9sYXJpdHkgYSBkdXR5IGN5Y2xlID0gMCUgY29ycmVzcG9uZHMgdG8NCj4+Pj4g
c29saWQgaGlnaCBsZXZlbCBvbiB0aGUgb3V0cHV0LiBJZiB0aGUgUFdNIGlzIGRpc3NhYmxlZCBp
dHMgb3V0cHV0DQo+Pj4+IGluc3RhbnRseSBnb2VzIHRvIHNvbGlkIHplcm8gd2hpY2ggY29ycmVz
cG9uZHMgdG8gZHV0eSBjeWNsZSA9DQo+Pj4+IDEwMCUuDQo+Pj4+DQo+Pj4+IFRvIGhhdmUgYSB0
cnVsbHkgaW52ZXJ0ZWQgUFdNIG91dHB1dCBjb25maWd1cmUgdGhlIFBXTSBwYWQgYXMgYQ0KPj4+
PiBHUElPIHdpdGggcHVsbC11cC4gVGhlbiBzd2l0Y2ggdGhlIHBhZCB0byBQV00gb3V0cHV0IHdo
ZW5ldmVyDQo+Pj4+IG5vbi16ZXJvIGR1dHkgY3ljbGUgaXMgbmVlZGVkLg0KPj4+DQo+Pj4gSnVz
dCB0byBhc2sgLSBJcyB5b3VyIGRpc3BsYXkgZXF1aXBwZWQgd2l0aCBwb3dlciBzdXBwbHkNCj4+
PiBlbmFibGUvZGlzYWJsZSBwaW4/DQo+Pg0KPj4gTm8gaXQgaXMgbm90LiBUaGUgYmFja2xpZ2h0
IG9uIG15IGRpc3BsYXkgaXMganVzdCBhIGJ1bmNoIG9mIHNlcmlhbC0NCj4+IHBhcmFsbGVsIGNv
bm5lY3RlZCBMRURzIHdpdGggc2VwYXJhdGUgR05EIGFuZCBWQ0MgcGlucyBvbiBhIHNlcGFyYXRl
DQo+PiBmbGV4IGNhYmxlLiBBbmQgdGhlIGRpc3BsYXkgaXRzZWxmIGFsc28gZG9lcyBub3QgaGF2
ZSBhIHJlc2V0IG9yDQo+PiBlbmFibGUgc2lnbmFsLiBJdCBpcyBhIFBJVEEgdG8gdXNlIGl0IEkg
bXVzdCBzYXkuLg0KPiANCj4gWWVzLCBpdCBzZWVtcyBzby4gSSBtdXN0IGhhdmUgaGFkIG1vcmUg
bHVjayB0aGFuIHlvdSB3aXRoIHRoZSBIVy4uLi4NCj4gDQo+PiAgICANCj4+PiBBcyBmYWlyIGFz
IEkgcmVtZW1iZXIgdGhlIHRyaWNrIHRvIGF2b2lkIGZsaWNrZXJpbmcgdGhlIGRpc3BsYXkNCj4+
PiB3YXMgdG8gZGlzYWJsZSB0aGUgZGlzcGxheSAoZW5hYmxlLWdwaW8gcHJvcGVydHkpIGFuZCBz
ZXQgdGhlIFBXTQ0KPj4+IFBJTiBhcyBHUElPIHRvIGhpZ2ggaW4gdS1ib290Lg0KPj4NCj4+IFll
cywgSSBrbm93IGFib3V0IHRoYXQuIEkgY2FuIG5vdCB1c2UgdGhpcyBhcyB0aGUgUFdNIG91dHB1
dCBpcyB0aGUNCj4+IG9ubHkgc2lnbmFsIEkgaGF2ZSB0byBjb250cm9sIHRoZSBiYWNrbGlnaHQu
IEkgbWVudGlvbmVkIHRoYXQNCj4+IHNvbWV3aGVyZSBpbiB0aGUgcHJldmlvdXMgZGlzY3Vzc2lv
biB3aXRoIExvdGhhci4NCj4gDQo+IFllcywgSSd2ZSByZWFkIGl0LiBJIGFsc28gZmluZCB0aGUg
UFdNIHBpbmN0cmwgYXMgImRlZmF1bHQiIHN0YXRlIG1vcmUNCj4gbmF0dXJhbC4NCj4gDQo+IE9u
ZSBtb3JlIGlkZWEgLSB0aG91Z2guDQo+IA0KPiBJbiBpTVg2USBpdCB3YXMgcG9zc2libGUgdG8g
c3BlY2lmeSB0aGUgcGluY3RybCBQSU4gc2V0dXAgYXMgMHg4MDAwMDAwMA0KPiAtIHRoaXMgbWVh
bnMgdGhhdCBpdCBnb2VzIHVudG91Y2hlZCB0byB0aGUgSVAgYmxvY2sgKGNvbmZpZ3VyZWQgYnkN
Cj4gICAgYm9vdGxvYWRlcikuDQoNCkhpIEx1a2FzeiwNClRoYW5rIHlvdSBmb3IgdGhlIGlkZWFz
IGFuZCBzb3JyeSBmb3IgdGhlIGxvbmcgZGVsYXkuDQoNCiBGcm9tIHJlYWRpbmcgYSBsb3Qgb2Yg
cmVwbGllcyBmcm9tIChub3Qgb25seSkgRFQgbWFpbnRhaW5lcnMgSSBnb3QgdGhlDQppbXByZXNz
aW9uIHRoYXQgdXNpbmcgdGhlIDB4ODAwMDAwMDAgY29uZmlndXJhdGlvbiB2YWx1ZSBpcyBnZW5l
cmFsbHkNCmRpc2NvdXJhZ2VkLiBBbmQgSSBzdXBwb3J0IHRoYXQgaWRlYS4NCg0KPiBNYXliZSBp
dCB3b3VsZCB3b3JrIHRvOg0KPiANCj4gMS4gU2V0dXAgdGhlIFBXTSBvdXRwdXQgYXMgR1BJTyBp
biB1LWJvb3QgKGhpZ2gpDQo+IA0KPiAyLiBJbiBQV00gSU1YIHByb2JlIGNvbmZpZ3VyZSBQV00g
dG8gYmUgMTAwJSBkdXR5IGN5Y2xlLiBBbmQgc3dpdGNoDQo+IGlvbXV4IHRvIFBXTSBmdW5jdGlv
biBvZiB0aGUgcGluDQoNClRoZSBwcm9iZSBmdW5jdGlvbiBzaG91bGQgb25seSBwcmVwYXJlIHN0
cnVjdHVyZXMsIG5vdCBjb25maWd1cmUgdGhlIEhXLg0KQWxzbyB5b3Ugc29tZWhvdyBuZWVkIHRv
IGtub3cgd2hldGhlciBvciBub3QgdG8gZW5hYmxlIHRoZSBQV00vR1BJTy4NCk5vcm1hbGx5IGl0
IGlzIHRoZSBjbGllbnQgKGJhY2tsaWdodCwgc3lzZnMuLikgd2hvIGNhbGxzIHRoZSBwd21fYXBw
bHkgdG8NCmNvbmZpZ3VyZSBhbmQgZW5hYmxlL2Rpc2FibGUgdGhlIFBXTS4NCg0KPiAzLiBUaGVu
IGxhdHRlciBpbiB0aGUgY29kZSBQV00gZ2V0cyBjb25maWd1cmVkIGFuZCB3ZSBjYW4gY29udHJv
bCBpdCBpbg0KPiAibm9ybWFsIiB3YXkgPw0KPiANCj4gT3IgYW0gSSBtaXNzaW5nIHNvbWUgaW1w
b3J0YW50IHBvaW50Pw0KDQpJZGVhbGx5LCB0aGUgZmluYWwgc29sdXRpb24gc2hvdWxkIGFsbG93
IGFsbCBwb3NzaWJsZSB1c2UtY2FzZXM6DQoNCi0gaW52ZXJ0ZWQgUFdNLCBlbmFibGVkIGZyb20g
Ym9vdGxvYWRlciB0byB1c2Vyc3BhY2UNCi0gaW52ZXJ0ZWQgUFdNLCBkaXNhYmxlZCBmcm9tIGJv
b3Rsb2FkZXIgdG8gdXNlcnNwYWNlDQoNClRoZSBzYW1lIGZvciBub24taW52ZXJ0ZWQgUFdNLg0K
DQpXaGF0IHlvdSBhcmUgc3VnZ2VzdGluZyBkb2VzIG5vdCBzZWVtIGxpa2UgaXQgc3VwcG9ydHMg
dGhhdCBpZGVhLg0KDQpJIHdpbGwgc2VuZCB2MiB3aXRoIHNvbWUgcHJvcG9zZWQgY2hhbmdlcyBz
b29uLg0KDQo+Pg0KPj4gSSBhbHNvIHRoaW5rIHRoaXMgY291bGQgYmUgdXNlZnVsIG5vdCBvbmx5
IGZvciBiYWNrbGlnaHQuIEFueSBjaXJjdWl0DQo+PiB0aGF0IHJlcXVpcmVzIHRydWx5IGludmVy
dGVkIFBXTSBzaWduYWwgY2FuIHVzZSBpdC4gSSBzZWUgaXQgYXMgYW4NCj4+IGVuaGFuY2VtZW50
IHRvIHdoYXQgeW91IHdpdGggTG90aGFyIGhhdmUgYWxyZWFkeSBkb25lIDspDQo+PiAgICANCj4+
Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFsIFZva8OhxI0gPG1pY2hhbC52b2thY0B5c29m
dC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcHdtL2lteC1wd20udHh0IHwgNDQNCj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysgMSBm
aWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS50eHQNCj4+Pj4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0IGluZGV4DQo+
Pj4+IGM2MWJkZjguLjNiMWJjNGMgMTAwNjQ0IC0tLQ0KPj4+PiBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS50eHQgKysrDQo+Pj4+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtcHdtLnR4dCBAQCAtMTQsNiArMTQsMTINCj4+
Pj4gQEAgU2VlIHRoZSBjbG9jayBjb25zdW1lciBiaW5kaW5nLA0KPj4+PiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svY2xvY2stYmluZGluZ3MudHh0DQo+Pj4+ICAgIC0g
aW50ZXJydXB0czogVGhlIGludGVycnVwdCBmb3IgdGhlIHB3bSBjb250cm9sbGVyDQo+Pj4+ICAg
IA0KPj4+PiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4+Pj4gKy0gcGluY3RybDogRm9yIGkuTVgy
NyBhbmQgbmV3ZXIgU29Dcy4gQWRkIGV4dHJhIHBpbmN0cmwgdG8NCj4+Pj4gY29uZmlndXJlIHRo
ZSBQV00NCj4+Pj4gKyAgcGluIHRvIGdwaW8gZnVuY3Rpb24uICBJdCBhbGxvd3MgY29udHJvbCBv
dmVyIHRoZSBwaW4gb3V0cHV0DQo+Pj4+IGxldmVsIHdoZW4gdGhlDQo+Pj4+ICsgIFBXTSBibG9j
ayBpcyBkaXNhYmxlZC4gVGhpcyBpcyBtZWFudCB0byBiZSB1c2VkIGlmIGludmVydGVkDQo+Pj4+
IHBvbGFyaXR5IG9mIHRoZQ0KPj4+PiArICBQV00gc2lnbmFsIGlzIHJlcXVpcmVkLiBTZWUgIklu
dmVydGVkIFBXTSBvdXRwdXQiIHNlY3Rpb24NCj4+Pj4gYmVsbG93LiArDQo+Pj4+ICAgIEV4YW1w
bGU6DQo+Pj4+ICAgIA0KPj4+PiAgICBwd20xOiBwd21ANTNmYjQwMDAgew0KPj4+PiBAQCAtMjUs
MyArMzEsNDEgQEAgcHdtMTogcHdtQDUzZmI0MDAwIHsNCj4+Pj4gICAgCWNsb2NrLW5hbWVzID0g
ImlwZyIsICJwZXIiOw0KPj4+PiAgICAJaW50ZXJydXB0cyA9IDw2MT47DQo+Pj4+ICAgIH07DQo+
Pj4+ICsNCj4+Pj4gK0ludmVydGVkIFBXTSBvdXRwdXQNCj4+Pj4gKy0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4+Pj4gKw0KPj4+PiArVGhlIGkuTVggU29DIGhhcyBzdWNoIGxpbWl0YXRpb24gdGhhdCB3
aGVuZXZlciBhIHBhZCBpcyBjb25maWd1cmVkDQo+Pj4+IGFzIGEgUFdNICtvdXRwdXQsIHRoZSBv
dXRwdXQgbGV2ZWwgaXMgYWx3YXlzIHplcm8gdm9sdHMgd2hlbiB0aGUNCj4+Pj4gUFdNIGJsb2Nr
IGlzIGRpc2FibGVkLiArVGhlIHplcm8gb3V0cHV0IGxldmVsIGlzIGFjdGl2ZWx5IGRyaXZlbg0K
Pj4+PiBieSB0aGUgb3V0cHV0IHN0YWdlIG9mIHRoZSBQV00gYmxvY2sgK2FuZCBjYW4gbm90IGJl
IG92ZXJyaWRkZW4gYnkNCj4+Pj4gcHVsbC11cC4gSXQgYWxzbyBkb2VzIG5vdCBtYXR0ZXIgd2hh
dCBQV00gcG9sYXJpdHkgK2EgUFdNIGNsaWVudA0KPj4+PiAoZS5nLiBiYWNrbGlnaHQpIHJlcXVl
c3RlZC4gKw0KPj4+PiArVG8gZ2FpbiBjb250cm9sIG9mIHRoZSBQV00gb3V0cHV0IGxldmVsIGlu
IGRpc2FibGVkIHN0YXRlIHR3bw0KPj4+PiBwaW5jdHJsIHN0YXRlcyArY2FuIGJlIHVzZWQuIFRo
ZSAiZGVmYXVsdCIgc3RhdGUgYW5kIHRoZSAicHdtIg0KPj4+PiBzdGF0ZS4gSW4gdGhlIGRlZmF1
bHQgc3RhdGUgdGhlICtQV00gb3V0cHV0IGlzIGNvbmZpZ3VyZWQgYXMgYQ0KPj4+PiBHUElPIHdp
dGggcHVsbC11cC4gSW4gdGhlICJwd20iIHN0YXRlIHRoZSBvdXRwdXQgK2lzIGNvbmZpZ3VyZWQg
YXMNCj4+Pj4gYSBQV00gb3V0cHV0LiBUaGlzIHNldHVwIGFzc3VyZXMgdGhhdCB0aGUgUFdNIG91
dHB1dCBpcyBhdCArdGhlDQo+Pj4+IHJlcXVpcmVkIGxldmVsIHRoYXQgY29ycmVzcG9uZHMgdG8g
ZHV0eSBjeWNsZSA9IDAgd2hlbiBQV00gaXMNCj4+Pj4gZGlzYWJsZWQuICtFLmcuIGF0IGJvb3Qu
ICsNCj4+Pj4gK0V4YW1wbGU6DQo+Pj4+ICsNCj4+Pj4gKyZwd20xIHsNCj4+Pj4gKwlwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiLCAicHdtIjsNCj4+Pj4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxf
YmFja2xpZ2h0X2dwaW8+Ow0KPj4+PiArCXBpbmN0cmwtMSA9IDwmcGluY3RybF9iYWNrbGlnaHRf
cHdtPjsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArcGluY3RybF9iYWNrbGlnaHRfZ3BpbzogcHdt
MWdycC1ncGlvIHsNCj4+Pj4gKwlmc2wscGlucyA9IDwNCj4+Pj4gKwkJLyogR1BJTyB3aXRoIDIy
a09obSBwdWxsLXVwICovDQo+Pj4+ICsJCU1YNlFETF9QQURfR1BJT185X19HUElPMV9JTzA5CTB4
RjAwOA0KPj4+PiArCT47DQo+Pj4+ICt9Ow0KPj4+PiArDQo+Pj4+ICtwaW5jdHJsX2JhY2tsaWdo
dF9wd206IHB3bTFncnAtcHdtIHsNCj4+Pj4gKwlmc2wscGlucyA9IDwNCj4+Pj4gKwkJLyogUFdN
IG91dHB1dCAqLw0KPj4+PiArCQlNWDZRRExfUEFEX0dQSU9fOV9fUFdNMV9PVVQJMHg4DQo+Pj4+
ICsJPjsNCj4+Pj4gK307DQoNCg==
