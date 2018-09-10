Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63461C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BD920865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AbfX8xWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BD920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeIJOUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:20:10 -0400
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:50453
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbeIJOUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXuQWN2Qtpejz+ITNJfveYdYWJGeFFrmEQVGwRfeNMs=;
 b=AbfX8xWBHPv+HCgESqarmb6O9tAnu8zlmLnUs/lUD5F6WcXPlm72pzZhCDmVVg71Tgy9gBqdIQp3/aENqC8Xo+0SjlcmJirJpQZ8re6iWQqW/6GL7ujFnRiNt7rnirXgtJC8jWPeJ0pu2IIrsJ856iBoJe653AXGkRbVkHOiq/o=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2738.eurprd04.prod.outlook.com (10.175.40.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 09:26:58 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766%9]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 09:26:58 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Scott Wood <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@lists.linux-foundation.org" 
        <linux-pm@lists.linux-foundation.org>
Subject: RE: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Thread-Topic: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Thread-Index: AQHUQN58CVZQFHBBjEyvga7omBlOu6TlUssAgAP3gvA=
Date:   Mon, 10 Sep 2018 09:26:58 +0000
Message-ID: <AM5PR0402MB2865520968A3656EC904ECB8F1050@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <cad8c585fb415959e7ade8b500278c2c5e070873.camel@buserror.net>
In-Reply-To: <cad8c585fb415959e7ade8b500278c2c5e070873.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2738;6:PvZtS96QhoLDdkzLBxCrN3Mgj3chrvRJXFblw+dC1tOyBaghQ64PZXD0WJRV2styXnsgb2W9Ce39kNSr7edXAzCIXZDpSeLL7SmcHG/FMXfV4Bei/FLGFT6CvfEh/ebJElVGLw13Li6RvWSY6DvBEpl7iayVR5g1UVaV0A/NZ/9zkmfNMX/Ioxn63jxF4p4hOcKBThEjd9Y1gkmLAUwPO+N2lW8aHd7aOwN4/rftWlB+wdspmoHSqsRPIRi7tYWH6V0xIhPYrl90ickd53M/Gunvbb8Wk4ZvS452ktyI5WVUDKkrv3XAqEt2fQKJaO/7LsTvgPcRK2J3rFQVPa83RTgrdsaEE/XSzl+Ho/zS1DDoswoLXvAm+aWLlrRaGZ4E85KbdqtuTaiy51EnzQOl9YSa9RZeRhQcDFH2VRhlgLgtjUZZmCYHeaesVw+myZENw6Gi0JVLDcRMYbGqOrAxpQ==;5:fL5hjCSDmhni7vqnMAtqc6j4UaZWUFdjpB5qVhQlbcWAQG9fWKqmrhgzUidLfqQJlSNBkM3MIF96PA3H0zHoypZ3WeWlqj7SEQawnds+sMHJiH6tFFBprRs6xOXAIqbIORwANJMbVlr4nkjEWxhIW7gp8sX5mlTsEG7Wj34SbVo=;7:xmKTDz9BQSuB9Vv+cDX7QZ0n2myiXwwMts4KKTb+q8+6P+k49CLSCQ/r1zBNHLCHFRkwtgz2wpp+6gOLyLBnNlngf9SFNeBKSocUK2AdyxsAAndtXi4S4q/m8iKIuGTWNs91ASXxHipO7xSeMlHKaKZmg92THAHVQfP1p14WcNFMKV9kCT0mHX7gW79/LkR9mm/8nA7Ch41NaR2vbWTBSXxSF59mbB+Nj6U/PaBl0gOzP6LLiKxOjCJw/aA45gbE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 054c658a-69f6-4487-c82a-08d616ff8e80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2738;
x-ms-traffictypediagnostic: AM5PR0402MB2738:
x-microsoft-antispam-prvs: <AM5PR0402MB27380644568FA3FDFE2373ECF1050@AM5PR0402MB2738.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AM5PR0402MB2738;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2738;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(14454004)(8936002)(186003)(6246003)(5250100002)(5660300001)(316002)(53546011)(6116002)(106356001)(102836004)(105586002)(6506007)(476003)(3846002)(97736004)(446003)(66066001)(11346002)(26005)(486006)(2906002)(4326008)(110136005)(81156014)(478600001)(81166006)(33656002)(25786009)(8676002)(54906003)(55016002)(7696005)(53936002)(9686003)(2900100001)(86362001)(74316002)(305945005)(76176011)(6436002)(7736002)(99286004)(229853002)(68736007)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2738;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1AQLezW50MzRgpoef2Lhp+fMis7285l/ZsoX+zKjL7teEOUpi/J41i4dqsfhyL9CghKsGLaeaTq1PyLjuosQ0MkwkHnXUSNQbzUQrRM+oM45y5ou6MizQoOHL0NO7s1t98s2DPXHJFXnNM2lDLL61JMdeLImfaYfyBpVa5xPj3rpmppJZu6RD85+hifTiGVfatYELYJAOjc/hpNK2CDe37sBx5z4G6S5BbQ96NcIy0ID98mZJIyI5dBiHs3L/Wr2paxjYOjERquZd2u0q2lekVxcNlmQMy0i/20Hgqowy1yxmvsutF0wzrDbzRK9V0G+UM1IClQqdh0JdEt/xkPe3jWijPy3Iz2pyinoTI7af/M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054c658a-69f6-4487-c82a-08d616ff8e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 09:26:58.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2NvdHQsDQoNCk9uIDIwMTgvOS84IDQ6MzUsIFNjb3R0IFdvb2Qgd3JvdGU6DQo+IA0KPiBP
biBGcmksIDIwMTgtMDgtMzEgYXQgMTE6NTIgKzA4MDAsIFJhbiBXYW5nIHdyb3RlOg0KPiA+IFRo
aXMgZHJpdmVyIGlzIHRvIHByb3ZpZGUgYSBpbmRlcGVuZGVudCBmcmFtZXdvcmsgZm9yIFBNIHNl
cnZpY2UNCj4gPiBwcm92aWRlciBhbmQgY29uc3VtZXIgdG8gY29uZmlndXJlIHN5c3RlbSBsZXZl
bCB3YWtlIHVwIGZlYXR1cmUuIEZvcg0KPiA+IGV4YW1wbGUsIFJDUE0gZHJpdmVyIGNvdWxkIHJl
Z2lzdGVyIGEgY2FsbGJhY2sgZnVuY3Rpb24gb24gdGhpcw0KPiA+IHBsYXRmb3JtIGZpcnN0LCBh
bmQgRmxleCB0aW1lciBkcml2ZXIgd2hvIHdhbnQgdG8gZW5hYmxlIHRpbWVyIHdha2UgdXANCj4g
PiBmZWF0dXJlLCB3aWxsIGNhbGwgZ2VuZXJpYyBBUEkgcHJvdmlkZWQgYnkgdGhpcyBwbGF0Zm9y
bSBkcml2ZXIsIGFuZA0KPiA+IHRoZW4gaXQgd2lsbCB0cmlnZ2VyIFJDUE0gZHJpdmVyIHRvIGRv
IGl0LiBUaGUgYmVuZWZpdCBpcyB0byBpc29sYXRlDQo+ID4gdGhlIHVzZXIgYW5kIHNlcnZpY2Us
IHN1Y2ggYXMgZmxleCB0aW1lciBkcml2ZXIgd2lsbCBub3QgaGF2ZSB0byBrbm93DQo+ID4gdGhl
IGltcGxlbWVudCBkZXRhaWxzIG9mIHdha2V1cCBmdW5jdGlvbiBpdCByZXF1aXJlLiBCZXNpZGVz
LCBpdCBpcw0KPiA+IGFsc28gZWFzeSBmb3Igc2VydmljZSBzaWRlIHRvIHVwZ3JhZGUgaXRzIGxv
Z2ljIHdoZW4gZGVzaWduIGlzIGNoYW5nZWQNCj4gPiBhbmQgcmVtYWluIHVzZXIgc2lkZSB1bmNo
YW5nZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9mc2wvS2NvbmZpZyAgIHwgICAxNCArKysr
Kw0KPiA+ICBkcml2ZXJzL3NvYy9mc2wvTWFrZWZpbGUgIHwgICAgMSArDQo+ID4gIGRyaXZlcnMv
c29jL2ZzbC9wbGF0X3BtLmMgfCAgMTQ0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvc29jL2ZzbC9wbGF0X3BtLmggfCAgIDIy
ICsrKysrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxODEgaW5zZXJ0aW9ucygrKSwgMCBkZWxl
dGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IGRyaXZlcnMvc29jL2ZzbC9wbGF0X3Bt
LmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGluY2x1ZGUvc29jL2ZzbC9wbGF0X3BtLmgNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvS2NvbmZpZyBiL2RyaXZlcnMvc29j
L2ZzbC9LY29uZmlnIGluZGV4DQo+ID4gN2E5ZmI5Yi4uNjUxNzQxMiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NvYy9mc2wvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL2ZzbC9LY29u
ZmlnDQo+ID4gQEAgLTE2LDMgKzE2LDE3IEBAIGNvbmZpZyBGU0xfR1VUUw0KPiA+ICAJICBJbml0
aWFsbHkgb25seSByZWFkaW5nIFNWUiBhbmQgcmVnaXN0ZXJpbmcgc29jIGRldmljZSBhcmUNCj4g
PiBzdXBwb3J0ZWQuDQo+ID4gIAkgIE90aGVyIGd1dHMgYWNjZXNzZXMsIHN1Y2ggYXMgcmVhZGlu
ZyBSQ1csIHNob3VsZCBldmVudHVhbGx5IGJlDQo+ID4gbW92ZWQNCj4gPiAgCSAgaW50byB0aGlz
IGRyaXZlciBhcyB3ZWxsLg0KPiArDQo+ID4gK2NvbmZpZyBGU0xfUExBVF9QTQ0KPiA+ICsJYm9v
bCAiRnJlZXNjYWxlIHBsYXRmb3JtIFBNIGZyYW1ld29yayINCj4gDQo+IFRoaXMgbmFtZSBzZWVt
cyB0byBiZSBzaW11bHRhbmVvdXNseSB0b28gZ2VuZXJpYyAoZm9yIHNvbWV0aGluZyB0aGF0IGlz
DQo+IGxpa2VseSBpbnRlbmRlZCBvbmx5IGZvciB1c2Ugd2l0aCBjZXJ0YWluIEZyZWVzY2FsZS9O
WFAgY2hpcCBmYW1pbGllcykgYW5kIHRvbw0KPiBzcGVjaWZpYyAoZm9yIHNvbWV0aGluZyB0aGF0
IHNlZW1zIHRvIGJlIGdlbmVyYWwgaW5mcmFzdHJ1Y3R1cmUgd2l0aCBubyByZWFsDQo+IGhhcmR3
YXJlIGRlcGVuZGVuY2llcykuDQoNClllcywgdGhpcyBkcml2ZXIgaGFzIG5vIHJlYWwgSFcgZGVw
ZW5kZW5jaWVzIGF0IGFsbC4gQnV0IHdlJ2QgbGlrZSB0byBpbnRyb2R1Y2UgaXQNCnRvIGhlbHAg
cHJvdmlkaW5nIG1vcmUgZmxleGliaWxpdHkgJiBnZW5lcmljIG9uIEZTTCBQTSBmZWF0dXJlIGNv
bmZpZ3VyZSAoc28gZmFyIA0Kd2UgaGF2ZSBSQ1BNIG9uIHN5c3RlbSB3YWtldXAgc291cmNlIGNv
bnRyb2wpLiBJIHRoaW5rIGl0J3MgZ29vZA0KZm9yIGRyaXZlci9JUCBwb3J0aW5nIGFtb25nIGRp
ZmZlcmVudCBTb0MgaW4gdGhlIGZ1dHVyZS4gQXMgdG8gdGhlIG5hbWUsIGRvIHlvdQ0KaGF2ZSBi
ZXR0ZXIgc3VnZ2VzdGlvbj8NCg0KPiBXaGF0IHNwZWNpZmljIHByb2JsZW1zIHdpdGggTGludXgn
cyBnZW5lcmljIHdha2V1cCBpbmZyYXN0cnVjdHVyZSBpcyB0aGlzDQo+IHRyeWluZyB0byBzb2x2
ZSwgYW5kIHdoeSB3b3VsZCB0aG9zZSBwcm9ibGVtcyBub3QgYmUgYmV0dGVyIHNvbHZlZCB0aGVy
ZT8NCg0KQWN0dWFsbHksIEkgYW0gbm90IHN1cmUgaWYgZ2VuZXJpYyB3YWtldXAgaW5mcmFzdHJ1
Y3R1cmUgaGF2ZSB0aGlzIGtpbmQgb2YgUE0gZmVhdHVyZQ0KKGtlZXAgc3BlY2lmaWMgSVAgYWxp
dmUgZHVyaW5nIHN5c3RlbSBzdXNwZW5kLCBjb3VsZCB5b3UgcGxlYXNlIHNob3cgbWU/KS4NCkFu
ZCBJIHRoaW5rIGl0IGlzIG5vdCBjb21tb24gcmVxdWlyZW1lbnQsIHNvIEkgZGVjaWRlIHRvIHB1
dCBpdCBpbiBGU0wgZm9sZGVyLiANCg0KPiBBbHNvLCB5b3Ugc2hvdWxkIENDIGxpbnV4LXBtIG9u
IHRoZXNlIHBhdGNoZXMuDQoNClllcywgdGhhbmtzIGZvciBzdWdnZXN0aW9uDQoNClJlZ2FyZHMs
DQpSYW4NCg0KPiAtU2NvdHQNCg0K
