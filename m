Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD94ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35E121523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WBSawenG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35E121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeITPX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:23:58 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:30688
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbeITPX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRdlolzQhpKQ3j+3lhZmhCDrSIiE/t7BRyTDPeLIOEc=;
 b=WBSawenGwiBW+UaxQEvWnNPxekiLNhu0cZvLPULzUy8oMSik9ATWwpS/c1x/dfQEaMfqJi+WUrIgV/jPf95aea29mC77xQ+QdsqDqdLUr6TkhR2ckPduHQ61q/046fOpEKXfDYhsafnNNTKZpSwfBIQhDhTUURRnP0VIZogFzlo=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3949.eurprd04.prod.outlook.com (52.134.17.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 09:41:18 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849%6]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 09:41:18 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jslaby@suse.cz" <jslaby@suse.cz>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, Han Xu <han.xu@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        Leo Zhang <leo.zhang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Zening Wang <zening.wang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] serial: imx: remove set but not used variable
 'rtsirq'
Thread-Topic: [PATCH -next] serial: imx: remove set but not used variable
 'rtsirq'
Thread-Index: AQHUUK2BjiCmViLF0kWmryq0h9SVQaT43KyAgAAM6mA=
Date:   Thu, 20 Sep 2018 09:41:18 +0000
Message-ID: <VI1PR0402MB3600A7368D538E3B6D044C5FFF130@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1537408725-196364-1-git-send-email-yuehaibing@huawei.com>
         <3b23675a-f537-868f-2432-b7f8a0c8c466@suse.cz>
 <96170d620618804d49ad19323d3cdee853070c72.camel@nxp.com>
In-Reply-To: <96170d620618804d49ad19323d3cdee853070c72.camel@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3949;6:ywCm2v7TvD/vpApJb972WiiwCzypUiluRuHY+izSKb0YVzqcZeWBDS39s7drfQ6icFP8d/snPdqGlij4LI4WFzWOiz7AUia+hTXp0cULL1Qvx2mSe0G3yyQsfv1F0BhknZjIWlNtBvjd2woF4oATfLL5ov7wrhPQnqqJFqzocqJ2Pw1vbXLDK+z3hoHadXmKPt2JmLEVhY2sxoiqe+FiFtJNHgB5+Qi/CKM2DBRCWU33BPKeXed9pqq4cYcCOTShTpAGEiV06Bj+FMLMSDkryQN5A/L6J/FZsPXGwod5mhJGYPRA1c+5+MNB30w2cjDzCU3SX5v+tDCh+kbAiXIOz2aF0UupqkAjZbkLVo7GLeQrvaobllYNzn3njqKNygzM9LmLhD4a2/rEkFjVbtk+aFLuTigCO4d3LXqsTuvgGHPz18DZyYIOqyEjv/I7cHHCZoZY+nrossVcVXtsq/nkAA==;5:2f5vjhlq5yRWtlLwOi2h2sBduhAtjdXCZFQNOgo1A+68M98K9e6GGAiFqzxms5MUHPCNX1ON8zCXrWsgiqqJ9za8E3c4dyzv4N2qN43qhd/A8CCGaTMRoejTc4BFlvBMM3EOZh996qZmNsTrM67GjpmB3bdjgBWPy7NSEj2FATc=;7:U7sIeMs7NOYjNBTQ2KCdjyS2GJ6wfiZDGA1wf4wUXyikA0CI8hwqFtV17XNsJki7Tbdo0cvDXp+O3mB9go5+y5BR8bdWxpxHT98SsaX6JbBGaXRcOQV3F15Gln+cr1Hl8ZnAMjqOSeayzKL4zUuu5CIWggnnjdK75ceHQHciM7656ArPxYuYdajCS6QmHaJuFXRRxc2x76lX3Y/g2QuRvkHLfW2gvrfL7XnRlaG6Ku9I6iYlIvJyXQgbRKfGc+Vm
x-ms-office365-filtering-correlation-id: 89319a68-8103-4757-3948-08d61edd3768
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3949;
x-ms-traffictypediagnostic: VI1PR0402MB3949:
x-microsoft-antispam-prvs: <VI1PR0402MB3949675A044D8890F5A567BCFF130@VI1PR0402MB3949.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:VI1PR0402MB3949;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3949;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(446003)(5250100002)(6116002)(9686003)(3846002)(2501003)(11346002)(97736004)(486006)(55016002)(81156014)(81166006)(4326008)(476003)(25786009)(54906003)(110136005)(74316002)(316002)(33656002)(14454004)(8936002)(53936002)(99286004)(6246003)(6436002)(2906002)(256004)(305945005)(7736002)(66066001)(76176011)(68736007)(14444005)(5660300001)(106356001)(53546011)(2201001)(8676002)(6506007)(105586002)(26005)(102836004)(2900100001)(478600001)(229853002)(7696005)(86362001)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3949;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7DoC749jHTiymoKnzZCoEsEkaxN/cKKd33qBfIfEXPLFYUowTIQf/aA70Bbuxah5FAJjPXK2N9z2uwlhWYVFMj17GE1zDoPQ87ky85hFPC4w3Dq3XpxgwlYn7lh4HYDQmB8MmFgSV/daE6BZVoqlmSCBF2yR2dwFMWo001mipQHHxf+AIvVdHGmlUnw6Uz2RHj4JxbPpkuCdxgzm79VUUOnGEswblzh7/z9oQq61UHRXsrmPVyIi5yW/2+UECPzSB/LvSkHXPLQZogjzuCMRMmP1P/hMYB2bicFqmN7D1y7mCGsdwtr30IoE076KVQvyuar88faaLfx4jb/Elz2SB1DA+tTLdFr6mjxUjTG2fLw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89319a68-8103-4757-3948-08d61edd3768
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 09:41:18.4425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGVvbmFyZCBDcmVzdGV6IFNlbnQ6IDIwMTjlubQ55pyIMjDml6UgMTY6NTENCj4gT24g
VGh1LCAyMDE4LTA5LTIwIGF0IDA4OjQ1ICswMjAwLCBKaXJpIFNsYWJ5IHdyb3RlOg0KPiA+IE9u
IDA5LzIwLzIwMTgsIDAzOjU4IEFNLCBZdWVIYWliaW5nIHdyb3RlOg0KPiA+ID4gRml4ZXMgZ2Nj
ICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOg0KPiA+ID4NCj4gPiA+IGRyaXZl
cnMvdHR5L3NlcmlhbC9pbXguYzogSW4gZnVuY3Rpb24gJ2lteF91YXJ0X3Byb2JlJzoNCj4gPiA+
IGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYzoyMTk4OjIwOiB3YXJuaW5nOg0KPiA+ID4gIHZhcmlh
YmxlICdydHNpcnEnIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVd
DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9pbXguYyBAQA0KPiA+ID4gLTIyMjAsNyArMjIyMCw2IEBAIHN0YXRp
YyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZQ0KPiA+ID4gKnBk
ZXYpDQo+ID4gPg0KPiA+ID4gIAlyeGlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+
ID4gPiAgCXR4aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAxKTsNCj4gPiA+IC0JcnRzaXJx
ID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAyKTsNCj4gPg0KPiA+IEkgYW0gbm90IHN1cmUgdGhp
cyBpcyBjb3JyZWN0LiBwbGF0Zm9ybV9nZXRfaXJxIGhhcyBzaWRlIGVmZmVjdHMgKGxpa2UNCj4g
PiBlbmFibGluZyB0aGUgSVJRKS4gQXJlIHlvdSBzdXJlIHRoaXMgd29uJ3QgY2hhbmdlIHRoZSBi
ZWhhdmlvdXIgKHRoaXMNCj4gPiBpcyBxdWVzdGlvbiBtb3N0bHkgdG8gSU1YIGZlbGxvd3MpPw0K
PiANCj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhlcmUgd2FzIGEgcmVxdWVzdF9pcnEgY2FsbCBm
b3IgcnRzaXJxIHdoaWNoIHdhcw0KPiByZW1vdmVkIGJ5IG1pc3Rha2UgaW4gY29tbWl0IGFmZTlj
YmIxYTZhZCAoInNlcmlhbDogaW14OiBkcm9wIHN1cHBvcnQNCj4gZm9yIElSREEiKToNCj4gDQo+
IC0gICAgICAgICAgICAgICAvKiBkbyBub3QgdXNlIFJUUyBJUlEgb24gSXJEQSAqLw0KPiAtICAg
ICAgICAgICAgICAgaWYgKCFVU0VfSVJEQShzcG9ydCkpIHsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBydHNpcnEsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW14X3J0c2ludCwgMCwN
Cj4gLQ0KPiBkZXZfbmFtZSgmcGRldi0+ZGV2KSwgc3BvcnQpOw0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICBpZiAocmV0KQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+IC0gICAgICAgICAgICAgICB9DQo+IA0KPiBUaGlzIHNob3VsZCBoYXZlIGp1c3Qg
cmVtb3ZlZCB0aGUgSVJEQSBjaGVjayBhbmQgcmVxdWVzdCBydHNpcnENCj4gdW5jb25kaXRpb25h
bGx5LiBOb2JvZHkgbm90aWNlZCB0aGlzIGJ5IHRlc3RpbmcgUlRTIG9uIGlteDEsIHRoaXMgaXMg
YW4gb2xkDQo+IGNoaXAgYW5kIGxhdGVyIHZhcmlhbnRzIGhhdmUgYSBzaW5nbGUgY29tYmluZWQg
aXJxLg0KPiANCj4gVGhlIGNvcnJlY3QgZml4IGZvciB0aGUgd2FybmluZyB3b3VsZCBiZSB0byBy
ZXN0b3JlIHRoYXQgcmVxdWVzdF9pcnEuDQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBMZW9uYXJk
DQoNClllcywgeW91ciBleHBsYWluIGlzIHZlcnkgY29ycmVjdCEgVGhhbmtzIGZvciB5b3VyIGNv
bW1lbnQuDQpXZSBzaG91bGQgcmVzdG9yZSBydHNpcnEgcmVxdWVzdCB0aGF0IGZvciBpLk1YMS4N
Cg0KUmVnYXJkcywNCkFuZHkgRHVhbg0K
