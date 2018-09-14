Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C102DFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4586B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kmg+Iv10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4586B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeINFhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:37:02 -0400
Received: from mail-db5eur01on0069.outbound.protection.outlook.com ([104.47.2.69]:52496
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbeINFhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5nvGf3DI0r0gXnPTseAAbtdmWPm5K2ePMJvzM9M2Mg=;
 b=kmg+Iv10YXTZ06trXDsxgwdQCvPJZXa4iv2jhcZvY2PchWQXA8fds/WigFeYse0pxYge4Z6r2hM9/Eb0qIzibvdbiqZ3wgNaVYkttM4eBc5rTf8w+qXWfHiOkp/YT5MIqPPPUvYOQvkvYNrqrGPbw/4R6dkQzGWLIcOfziqqkFU=
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com (20.177.55.216) by
 VI1PR04MB3984.eurprd04.prod.outlook.com (10.171.182.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 14 Sep 2018 00:25:08 +0000
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::806e:6caa:e774:689f]) by VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::806e:6caa:e774:689f%4]) with mapi id 15.20.1122.021; Fri, 14 Sep 2018
 00:25:08 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Angus Ainslie <angus@akkea.ca>, Peter Chen <hzpeterchen@gmail.com>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH v3] usb: typec: get the vbus source and charge values from
  the devicetree
Thread-Topic: [PATCH v3] usb: typec: get the vbus source and charge values
 from  the devicetree
Thread-Index: AQHUS1JYxlnWFjVdqUGB7lFiUCPer6Tu425Q
Date:   Fri, 14 Sep 2018 00:25:08 +0000
Message-ID: <VI1PR04MB45588659231E3F4693B62D5E89190@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180911145931.32441-1-angus@akkea.ca>
 <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com>
 <9d7431e51aa069f288dd4bf39e9db9f1@www.akkea.ca>
 <20180912163259.GC3300@roeck-us.net>
 <CAL411-qmQ23=hfXX3s5Zo100rSASrByMWR70qLZ8cWqt9hPgSg@mail.gmail.com>
 <aa08abf87b945dc5c8268fab3cb55cbb@www.akkea.ca>
In-Reply-To: <aa08abf87b945dc5c8268fab3cb55cbb@www.akkea.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3984;6:vp4LTdT7i0FGukjLzxOyFbvRVnXrWm1NMTHWyW5UIdpC8kwtEn3VBJ6pRoJIEcOBymOqV8mC70Z0Ardx9Ahi3tkP6LorAtFqGjHGVC5+e3ZO1ko0obK/k/pXIUp/ND6S0yNjienmVnF6KLJDIwlmlI7XLMa/i8O3iQ9xnyEAuWhI1PWIXbwhdJxPDSs8WVYuQlRMe2Hw0hNj74x3w57tsjGljroHZ+7YTPHdfapO+Zucp8lXTfZLiuKCr9fM/Q3gF0/XyzzbzbU2gkz1TvwjK91SetJ62kWd6Xny4AsIiIfRw7b5zuA3Vyx+5DCjswDamebA6t7fnIDDDp/AjZdZHsp0RcS92zjUEGIAnfH937kqxpKGH6QDX6+b68cahg4yon9vMMMXr73kU4ynEHSGSFObL4BJVcHdbbNwevqIVJtZE02Ohq3ZbgdO1PI4eUcfWbnvpRlaJr64ret3FyJrzg==;5:Wj0SEE4B9Q/U0pHrtp5+rCK8ebVaRUY8/4xHo+s5lWs9DwVhW+36ICXdsUc6NKArgBUzKGYHl9nZv0Nc658etHksRgKUdmrYIYLiIccDKYkVF9JV6jeEkw+RYJrLjzfQa8Z48Tw+pdm83F+qPC60lSu+WgtBEY3UhTmQ1bmlHG0=;7:7qPGyU4X90gSNRClyFOSFMmRpyeewhtluB8d7cZnjp67xU1thFOBgfBMHwxWb1pe+KToV0VZnxxgezH2KcxibZ94/Eb+zkZdlEM7ZG1eH4hYU/es0x45100f1wqNYCN4vdxsCwaJ0rFVT7FW5w4z7LtqGcayN4/f7occTqDkVZBOq68I0sP4b/ToXf4Bye5gJL5ebzAyFTNeCAxeqeNGpaaJgBEyX51MiIJm0faVVl3pxFZiuNqZnlYzW96XN+fc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46d6c58c-d300-46e5-a210-08d619d886ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3984;
x-ms-traffictypediagnostic: VI1PR04MB3984:
x-microsoft-antispam-prvs: <VI1PR04MB3984EE35CE1509254BF6FF5789190@VI1PR04MB3984.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231344)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:VI1PR04MB3984;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3984;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(13464003)(189003)(11346002)(68736007)(110136005)(229853002)(54906003)(86362001)(256004)(97736004)(316002)(102836004)(93886005)(7736002)(66066001)(305945005)(8936002)(446003)(5250100002)(53546011)(7696005)(476003)(486006)(8676002)(2906002)(44832011)(76176011)(99286004)(2900100001)(74316002)(25786009)(33656002)(14454004)(53936002)(26005)(39060400002)(81166006)(5660300001)(81156014)(6346003)(6436002)(478600001)(4326008)(6246003)(105586002)(186003)(106356001)(6506007)(3846002)(6116002)(55016002)(9686003)(15583001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3984;H:VI1PR04MB4558.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-microsoft-antispam-message-info: mvnrh/YcJdJnKb1Eszedza4dyfJwX6CnsJkfOT+/5J3F6zbliiYeetxh2+s+dClHK2hJ1B0pIiW6vTNjI80gjvg6Ywg8IWe9O19NWJ3lG0+w9QKLr9O9gGWNK+W1mnLgC6OS+BqiEkt1wZjNZdUn6CgmjIYUghcZ6nlVO0BL2Ap5DI0hvlkXF76L/n/0Xf+jc8uA/RCfYXrlhjRlyIxJYsyZMxqqeKtpw8w7DoMf/QJa8e9h9W7V8XJ0SRBKK/um7e29KR3d1ZWp0RhR0+yB5MVfASHhKdvsUJe3jV8tVN0uCZY5SP/kjH8Q0hQm/ZqGazE7/YRKmiV5DDmSMEXJu3gWxg9tq/Y7vMYe5CGFApU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d6c58c-d300-46e5-a210-08d619d886ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 00:25:08.3229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5ndXMgQWluc2xpZSA8
YW5ndXNAYWtrZWEuY2E+DQo+IFNlbnQ6IDIwMTjlubQ55pyIMTPml6UgMTk6MTANCj4gVG86IFBl
dGVyIENoZW4gPGh6cGV0ZXJjaGVuQGdtYWlsLmNvbT4NCj4gQ2M6IGxpbnV4QHJvZWNrLXVzLm5l
dDsgSGVpa2tpIEtyb2dlcnVzIDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPjsgR3Jl
Zw0KPiBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4LXVz
YkB2Z2VyLmtlcm5lbC5vcmc7IGxrbWwNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBQZXRlciBDaGVuIDxwZXRlci5jaGVuQG54cC5jb20+OyBKdW4gTGkNCj4gPGp1bi5saUBueHAu
Y29tPjsgR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzXSB1c2I6IHR5cGVjOiBnZXQgdGhlIHZidXMgc291cmNlIGFuZCBjaGFyZ2UgdmFs
dWVzIGZyb20gdGhlDQo+IGRldmljZXRyZWUNCj4gDQo+IE9uIDIwMTgtMDktMTMgMDE6MjcsIFBl
dGVyIENoZW4gd3JvdGU6DQo+ID4gT24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMTI6MzUgQU0gR3Vl
bnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiA+IHdyb3RlOg0KPiA+Pg0KPiA+PiBP
biBXZWQsIFNlcCAxMiwgMjAxOCBhdCAxMDowODo1OEFNIC0wNjAwLCBBbmd1cyBBaW5zbGllIHdy
b3RlOg0KPiA+PiA+IE9uIDIwMTgtMDktMTEgMDk6MzMsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+
ID4+ID4gPkkgY2FudCBwdXQgbXkgZmluZ2VyIG9uIGl0IGJ1dCB0aGlzIHNlZW1zIHdyb25nLiBB
cyBpIHNhaWQgYm90aA0KPiA+PiA+ID5zcmMgYW5kIHNpbmsgc2hvdWxkIG5ldmVyIGJlIHRydWUg
YXQgdGhlIHNhbWUgdGltZS4gSSBhbHNvIGRpbuKAmXQNCj4gPj4gPiA+dW5kZXJzdGFuZCB3aHkg
dHVybmluZyBvZmYgc3JjIHNob3VsZCBwb3dlciBvZmYgeW91ciBib2FyZC4NCj4gPj4gPiA+VWx0
aW1hdGVseSBteSBjb25jZXJuIGlzIHRoYXQgd2UgbWF5IGJlIGp1c3QgcGFpbnRpbmcgb3ZlciB0
aGUNCj4gPj4gPiA+cmVhbCBwcm9ibGVtLCBhbmQgdGhhdCB3b3VsZCBiZSByZWFsbHkgYmFkIHRv
IGRvIHdpdGggZHQgcHJvcGVydGllcy4NCj4gPj4gPiA+DQo+ID4+ID4NCj4gPj4gPiBJIGFncmVl
IHRoYXQgdGhpcyBkb2Vzbid0IHNlZW0gbGlrZSB0aGUgY29ycmVjdCB3YXkgb2Ygc29sdmluZyB0
aGUgcHJvYmxlbS4NCj4gPj4gPiBPbiB0aGlzIEhXIChFbWNyYWZ0IGlNWDhNIEJTQikgSSB0aGlu
ayB0aGUgUFRONTExMCBjaGlwIGhhcyBiZWVuDQo+ID4+ID4gY29ubmVjdGVkIGNvcnJlY3RseSBz
byBJJ20gYXNzdW1pbmcgdGhhdCBpdCBpcyBzb21lIHF1aXJrIG9mIHRoZSBQVE41MTEwLg0KPiA+
PiA+DQo+ID4+ID4gSSBkaWRuJ3QgZGVzaWduIHRoZSBIVyBvciB0aGUgY2hpcC4gVGhpcyBpcyBh
IHdvcmthcm91bmQgZm9yICJxdWlya3kiDQo+ID4+ID4gaGFyZHdhcmUgYW5kIHRoZXJlIG1heSBi
ZSBvdGhlcnMgdGhhdCBkb24ndCBiZWhhdmUgZXhhY3RseSBhcyBleHBlY3RlZC4NCj4gPj4gPg0K
PiA+Pg0KPiA+PiBJIHdvdWxkbid0IGJlIHRoYXQgc3VyZSBhYm91dCB0aGF0LiBJdCBtYXkgYXMg
d2VsbCBiZSB0aGF0IHRoZSB0Y3BjDQo+ID4+IGRyaXZlciBhbmQvb3IgdGhlIHRjcG0gZHJpdmVy
IGFyZSBkb2luZyBzb21ldGhpbmcgd3Jvbmcgd2hlbg0KPiA+PiBpbml0aWFsaXppbmcuDQo+ID4+
DQo+ID4+IEkgZGlkbid0IHJlYWxseSB1bmRlcnN0YW5kIHRoZSBsb2dzIHlvdSBzZW50IG91dCBl
YXJsaWVyLiBJdCBsb29rZWQNCj4gPj4gbGlrZSB0aGUgc3lzdGVtIHdvdWxkIGxvb3NlIHBvd2Vy
IGlmIHRoZSBUQ1BDX0NNRF9ESVNBQkxFX1NSQ19WQlVTDQo+ID4+IGNvbW1hbmQgaXMgc2VudC4g
IFRoYXQgZG9lc24ndCByZWFsbHkgbWFrZSBzZW5zZSB0byBtZSBzaW5jZSBpdA0KPiA+PiBpbmRp
Y2F0ZXMgdGhhdCB0aGUgY2hpcCBzb3VyY2VzIHBvd2VyIHRvIHRoZSByZW1vdGUsIGFuZCB0dXJu
aW5nIHRoYXQNCj4gPj4gb2ZmIHNob3VsZCBub3QgcmVzdWx0IGluIGEgbG9jYWwgbG9zcyBvZiBw
b3dlci4NCj4gPj4NCj4gPj4gTm90ZSB0aGF0IHRoZSBjaGlwIGlzIHN1cHBvc2VkIHRvIGJlIGFi
bGUgdG8gcmVwb3J0IGlmIGl0IGlzIHNvdXJjaW5nDQo+ID4+IHZidXMgYW5kIGlmIFZCVVMgaXMg
cHJlc2VudCwgaW4gdGhlIFBPV0VSX1NUQVRVUyByZWdpc3Rlci4gQW5vdGhlcg0KPiA+PiBxdWVz
dGlvbiBpcyB0aGUgY29udGVudCBvZiB0aGUgUk9MRV9DT05UUk9MIHJlZ2lzdGVyIHdoZW4gdGhl
IHN5c3RlbQ0KPiA+PiBib290cywgYW5kIHRoZSBERVZJQ0VfQ0FQQUJJTElUSUVTIHNldHRpbmdz
Lg0KPiA+Pg0KPiA+PiBPdmVyYWxsIEkgc3VzcGVjdCB0aGF0IHdlIGRvbid0IGhhbmRsZSBzdGFy
dHVwIGZvciB5b3VyIHN5c3RlbQ0KPiA+PiBjb3JyZWN0bHkgaW4gdGhlIHRjcGMgZHJpdmVyLiBU
aGUgaWRlYWwgc29sdXRpb24gd291bGQgYmUgdG8gZmluZCBhDQo+ID4+IHNvbHV0aW9uIHdoaWNo
IGRvZXMgbm90IHJlcXVpcmUgYW55IGRldmljZXRyZWUgcHJvcGVydGllcywgYnV0IHRvIGRvDQo+
ID4+IHRoYXQgd2UnbGwgbmVlZCB0byBnZXQgYSBiZXR0ZXIgdW5kZXJzdGFuZGluZyBhYm91dCB5
b3VyIHN5c3RlbSdzDQo+ID4+IHJlcXVpcmVtZW50cy4NCj4gPj4NCj4gPj4gR3VlbnRlcg0KPiA+
DQo+ID4gSGkgQW5ndXMsDQo+ID4NCj4gPiBXb3VsZCB5b3UgcGxlYXNlIGNoZWNrIGlmIGJlbG93
IHBhdGNoIGNhbiBmaXggeW91ciBpc3N1ZT8NCj4gPg0KPiA+IHN0YWdpbmc6IHR5cGVjOiBkb24n
dCBkbyB2YnVzIHNvdXJjZSBkaXNhYmxlIGZvciBkZWFkIGJhdHRlcnkNCj4gPg0KPiA+IEluIFBU
TjUxMTAgZGVzaWduLCBEaXNhYmxlU291cmNlVkJVUyBjb21tYW5kIGFsc28gZGlzYWJsZXMgdGhl
IHNpbmsNCj4gPiBlbmFibGUgc2lnbmFsIGJlY2F1c2UgdGhlIEVOX1NOSyBjYW4gYmUgdXNlZCB0
byBzb3VyY2UgaGlnaGVyIHZvbHRhZ2UsDQo+ID4gYW5kLCB0aGVyZSBpcyBvbmx5IG9uZSBUQ1BD
IGNvbW1hbmQgdG8gZGlzYWJsZSBzb3VyY2luZyB2b2x0YWdlDQo+ID4gd2l0aG91dCB0ZWxsaW5n
IHdoZXRoZXIgdG8gZGlzYWJsZSA1ViBvciB0aGUgaGlnaCB2b2x0YWdlLCBhbmQgdG8ga2VlcA0K
PiA+IHRoZSBkZXNpZ24gc2ltcGxlIHRoZXkgZGVzaWduZWQgdGhlIFBUTjUxMTAgdG8gZGlzYWJs
ZSBib3RoLiB3aXRoIHRoaXMNCj4gPiBmYWN0LCB3ZSB1c2UgdGhlIGZsYWcgZHJpdmVfdmJ1cyB0
byBjaGVjayBpZiB0aGUgc291cmNlIHZidXMgZW5hYmxlDQo+ID4gd2FzIGlzc3VlZCwgaWYgeWVz
IHdlIHRoZW4gZG8gdmJ1cyBzb3VyY2UgZGlzYWJsZSwgaW4gZGVhZCBiYXR0ZXJ5DQo+ID4gY2Fz
ZSwgd2UgbmV2ZXIgZGlkIHZidXMgc291cmNlIGVuYWJsZSwgc28gd2lsbCBub3QgaXNzdWUgdmJ1
cyBzb3VyY2UNCj4gPiBkaXNhYmxlIGNvbW1hbmQuDQo+ID4NCj4gDQo+IFRoYW5rcyBQZXRlciwg
dGhpcyBzb3VuZHMgbGlrZSB0aGUgbWlzc2luZyBwaWVjZSBvZiBpbmZvcm1hdGlvbiBhbmQgSSB0
aGluayBzb21lIGZvcm0gb2YNCj4gdGhlIGNvZGUgYmVsb3cgd2lsbCBmaXggdGhhdC4NCj4gDQo+
IFRoZXJlIGlzIHN0aWxsIHRoZSBpc3N1ZSB0aGF0IG15IGJvYXJkIHdpbGwgbmVlZCBzb21lIHdh
eSBvZiBjb250cm9sbGluZyB0aGUgaW5pdGlhbCBzdGF0ZSBvZg0KPiB2YnVzLXNpbmsuDQo+IA0K
PiBAR3VlbnRlcjogd291bGQgbXkgaW5pdGlhbCBwYXRjaCBiZSBhY2NlcHRhYmxlIHRvIHNldCB0
aGUgZGVmYXVsdCBzdGF0ZSBvZiB2YnVzLXNvdXJjZSBhbmQNCj4gdmJ1cy1zaW5rLiBXb3VsZCB5
b3UgbGlrZSBzb21lIGNvZGUgdG8gc2FuaXR5IGNoZWNrIHRoYXQgYm90aCB3ZXJlIG5vdCBlbmFi
bGVkIGF0IHRoZQ0KPiBzYW1lIHRpbWUgPw0KDQpJIGFncmVlIEd1ZW50ZXIgdXNpbmcgYSBkdCBw
cm9wZXJ0eSBpcyBub3QgdGhlIHByb3BlciB3YXkgaGVyZShtYXliZSB2YWxpZA0KZm9yIHlvdXIg
SFcgd2l0aCBvbmx5IHR5cGVjIHBvd2VyIHN1cHBseSksIEkgdGhpbmsgYSByaWdodCB3YXkgaXMg
dG8gY2hhbmdlDQp0Y3BtIHRvIGhhbmRsZSB0aGlzIGtpbmQgY2FzZShsaWtlIHRoZSBleGlzdGlu
ZyB2YnVzX25ldmVyX2xvdyBmbGFnKSBzbyB3ZQ0Kd2lsbCBoYXZlIGEgY29tbW9uIGhhbmRsaW5n
DQoNCmlmICh2YnVzX29uICYmIENDX3N0YXRlX2lzX1JQKQ0KCWRlYWRfYmF0dGVyeSA9IHRydWU7
DQoJYnlwYXNzIHRjcG1faW5pdF92YnVzIG9yIG9ubHkgZW5hYmxlIHNpbmsuDQo=
