Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3423DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE50820833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMm4TYFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE50820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeIJNh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:37:58 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:43137
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727635AbeIJNh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScCMuf9udAjWBmYERXZ7MQD+XwnkMz3pQybAB/Z2mew=;
 b=XMm4TYFbFsaAnqUL83zFVHtohBu3rn14W7q2OKqtip6jQnmH6ZuP07ByFUAhG0VtUSR5bIADbGu229EQguZUD9IBH+LUGpDM5cgbcCtegTdjloystn0zxff8c4DOdi/GfF7jUUftOTID7Lg9m9N5rxfcXqOAp93XMdnWenI2HJE=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2737.eurprd04.prod.outlook.com (10.175.40.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 08:44:55 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766%9]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 08:44:55 +0000
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
Subject: RE: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
Thread-Topic: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
Thread-Index: AQHUQN58VHTeiUfa70eLJzpyIbtKMKTlT1kAgAOfCcA=
Date:   Mon, 10 Sep 2018 08:44:55 +0000
Message-ID: <AM5PR0402MB28655442E42632DDAF22B769F1050@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
         <20180831035219.31619-2-ran.wang_1@nxp.com>
 <c19f11e200258297dbe5a61392a4bbc1e937d7c3.camel@buserror.net>
In-Reply-To: <c19f11e200258297dbe5a61392a4bbc1e937d7c3.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2737;6:51fjA3Ut9RmLuoptl3amWEzG2Akst88n2dszczuheAesA0EJ3N97xz9jV07ADGDsV1lEyeQkIGGR4PY5rKCFMN/Bpnp0M0YPVMOgRU2LCXilt+2N8zSTiJmRJtcL4FQ6zGUYqmaY9TUoFG07x88TaK7ToG8shjafegpTbPD2TbajmkJ9idzERhwgBc/tugmE2EMDxMkYnxa55KTaXh20YSkLt9rSbfY1vOn0TQw58KtNBqCfWTjrU1ooNdwqThTjH2RC1mJU5nHV3yB7nnPRjZ5maTLkg3KU9/IHTPy/ZwmxpSIA5mEy1m6ED+1nnNTWNQbUYvQkv0Cx+P4FRZ/cuVQ/BiC5AlAPb0u3a6VZ7ZlDkAmRZ6RpBCa45kgXSvYdTeMTdkMIgT40yc/HTR34aPDdmzkIYpIg4+5m9t3kMFT+nfkJrY8y/Q+71gVnTOckL35/KaBpXZI4jrTYWdlJGA==;5:op1TRPzPUKQd95kYGfHFdnRn0eIP0KV65rotA5gPc3HTad2Bho2NQgcb0xPmS+MhqtQTROZ3KJKSa+DO6wL67onc8eE+P9ffVvM6C9KzgR0YRk9xQAdraUHWgZPjgGpEbhPlAFAnWabfyZthSYAJpkkiJ5HFzkqR8/3kd8HqeNA=;7:GCmVK8pt22prSan/TQtOmWJ830R8/NF5j+TRe+a2nRu77azoh26ERnZ4aiK06vfZ8tGW5UuVEDMghDl0s2VMW1Dql+6fwZyauWZWV5Mn3O/6YuqX1rXGCFpq2egWiqc5CofezKjE904E8Pn4kYNkEr7dayo4y5EFH00B6Frz2WrLHulO883nOrYsI1hmu/Qq35fGWSXTRw+Cv+iUQFAhUP2OR7Xfg8f1fbDuPwtaA12FHXmXXYyb4CgI7TaE18qC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d68923bb-c9d5-4e9f-be52-08d616f9ae9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2737;
x-ms-traffictypediagnostic: AM5PR0402MB2737:
x-microsoft-antispam-prvs: <AM5PR0402MB27377C4D9DD90111655DE0DCF1050@AM5PR0402MB2737.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AM5PR0402MB2737;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2737;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(57704003)(74316002)(2900100001)(316002)(76176011)(110136005)(305945005)(8676002)(53546011)(6506007)(33656002)(53936002)(81166006)(54906003)(81156014)(15650500001)(2906002)(68736007)(186003)(6116002)(3846002)(7736002)(106356001)(105586002)(99286004)(102836004)(7696005)(8936002)(486006)(26005)(446003)(11346002)(66066001)(229853002)(476003)(9686003)(6246003)(25786009)(86362001)(4326008)(5660300001)(14454004)(55016002)(97736004)(478600001)(6436002)(256004)(5250100002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2737;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BAvF+Ajkk+M8EUF0Nxo+2z70O6aeyhshYgF8yeaMVkXCvJ5hLysMHucOGqIGJaXgjELgW50IPiu4+iUdXEBXd7rBpFX7YiTehEnJ13TrJGhyutvhtbtsRE1rrrmMq8mWmm84bhc+WzIi+R9qYhu5qx0Ukt7MiI1Wm+H8NLIx1HYx9iqNwHRM8+a4qEMlY/3MyGg3cihtTSEXlk5OEEcCR2g6Ggp8kTb5bDhBkxThfmaeLwMHLrb4vSuo7fJeJ5vDFLfNRBVI1xn+J6hdOnDAb9vRz0pzRuDU0rD1LRYi6gENOIF3fg5aYp344eXLu3BVeC3+Ju2OZnjTeazlUj/rJfWOPZyAhtiaWxNmvBtlQO8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68923bb-c9d5-4e9f-be52-08d616f9ae9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:44:55.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2NvdHQsDQoNCk9uIDIwMTgvOS84IDQ6MjMsIFNjb3R0IFdvb2Qgd3JvdGU6DQo+IA0KPiBP
biBGcmksIDIwMTgtMDgtMzEgYXQgMTE6NTIgKzA4MDAsIFJhbiBXYW5nIHdyb3RlOg0KPiA+ICtP
cHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICsgLSBiaWctZW5kaWFuIDogSW5kaWNhdGUgUkNQTSBy
ZWdpc3RlcnMgaXMgYmlnLWVuZGlhbi4gQSBSQ1BNIG5vZGUNCj4gPiArICAgdGhhdCBkb2Vzbid0
IGhhdmUgdGhpcyBwcm9wZXJ0eSB3aWxsIGJlIHJlZ2FyZGVkIGFzIGxpdHRsZS1lbmRpYW4uDQo+
IA0KPiBZb3UndmUganVzdCBicm9rZW4gYWxsIHRoZSBleGlzdGluZyBwb3dlcnBjIGRldmljZSB0
cmVlcyB0aGF0IGFyZSBiaWctZW5kaWFuDQo+IGFuZCBoYXZlIG5vIGJpZy1lbmRpYW4gcHJvcGVy
dHkuDQoNClllcywgcG93ZXJwYyBSQ1BNIGRyaXZlciAoYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xf
cmNwbS5jKSB3aWxsIG5vdCByZWZlcg0KdG8gYmlnLWVuZGlhbi4gSG93ZXZlciwgSSB0aGluayBp
ZiBMYXllcnNjYXBlIFJDUE0gZHJpdmVyIHVzZSBkaWZmZXJlbnQgY29tcGF0aWJsZQ0KaWQgKHN1
Y2ggYXMgJyBmc2wscW9yaXEtcmNwbS0yLjInKSwgaXQgbWlnaHQgYmUgc2FmZS4gSXMgdGhhdCBP
Sz8NCg0KPiA+ICsgLSA8cHJvcGVydHkgJ2NvbXBhdGlibGUnIHN0cmluZyBvZiBjb25zdW1lciBk
ZXZpY2U+IDogVGhpcyBzdHJpbmcNCj4gPiArICAgaXMgcmVmZXJyZWQgYnkgUkNQTSBkcml2ZXIg
dG8ganVkZ2UgaWYgdGhlIGNvbnN1bWVyIChzdWNoIGFzIGZsZXggdGltZXIpDQo+ID4gKyAgIGlz
IGFibGUgdG8gYmUgcmVnYXJkcyBhcyB3YWtldXAgc291cmNlIG9yIG5vdCwgc3VjaCBhcw0KPiA+
ICsgJ2ZzbCxsczEwMTJhLQ0KPiA+IGZ0bScuDQo+ID4gKyAgIEZ1cnRoZXIsIHRoaXMgcHJvcGVy
dHkgd2lsbCBjYXJyeSB0aGUgYml0IG1hc2sgaW5mbyB0byBjb250cm9sDQo+ID4gKyAgIGNvcmVz
cG9uZGluZyB3YWtlIHVwIHNvdXJjZS4NCj4gDQo+IFdoYXQgd2lsbCB5b3UgZG8gaWYgdGhlcmUg
YXJlIG11bHRpcGxlIGluc3RhbmNlcyBvZiBhIGRldmljZSB3aXRoIHRoZSBzYW1lDQo+IGNvbXBh
dGlibGUsIGFuZCBkaWZmZXJlbnQgd2FrZXVwIGJpdHM/ICANCg0KWW91IGdvdCBtZSEgVGhpcyBp
cyBhIHByb2JsZW0gaW4gY3VycmVudCB2ZXJzaW9uLiBXZWxsLCB3ZSBoYXZlIHRvIGRlY291cGxl
IHdha2UgdXANCnNvdXJjZSBJUCBhbmQgUkNQTSBkcml2ZXIuIFRoYXQncyB3aHkgSSBhZGQgYSBw
bGF0X3BtIGRyaXZlciB0byBwcmV2ZW50IHdha2UgdXAgSVANCmtub3dpbmcgYW55IGluZm9ybWF0
aW9uIG9mIFJDUE0uIFNvIGluIGN1cnJlbnQgY29udGV4dCwgb25lIGlkZWEgY29tZSB0byBtZSBp
cyB0bw0KcmVkZXNpZ24gcHJvcGVydHkgJyBmc2wsbHMxMDEyYS1mdG0gPSA8MHgyMDAwMD47Jywg
Y2hhbmdlIHRvICdmc2wsbHMxMDEyYS1mdG0gPSA8JmZ0bTAgMHgyMDAwMD47Jw0KV2hhdCBkbyB5
b3Ugc2F5PyBBbmQgY291bGQgeW91IHRlbGwgbWUgd2hpY2ggQVBJIEkgY2FuIHVzZSB0byBjaGVj
ayBpZiB0aGF0IGRldmljZSdzDQpuYW1lIGlzIGZ0bTAgKGZvciBleGFtcGxlIHdlIHdhbnQgdG8g
ZmluZCBhIG5vZGUgZnRtMDogZnRtQDI5ZDAwMCk/DQoNCj5QbHVzLCBpdCdzIGFuIGF3a3dhcmQg
ZGVzaWduIGluDQo+IGdlbmVyYWwsIGFuZCB5b3UgZG9uJ3QgZGVzY3JpYmUgd2hhdCB0aGUgdmFs
dWUgYWN0dWFsbHkgbWVhbnMgKGJpdHMgaW4gd2hpY2gNCj4gcmVnaXN0ZXI/KS4gDQoNClllcywg
SSBhZG1pdCBteSBkZXNpZ24gbG9va3MgdWdseSBhbmQgbm90IGZsZXhpYmxlIGFuZCBleHRlbnNp
YmxlIGVub3VnaC4gSG93ZXZlciwgZm9yIGFib3ZlIHJlYXNvbiwgDQpkbyB5b3UgaGF2ZSBhbnkg
Z29vZCBpZGVhLCBwbGVhc2U/IDopDQoNCkFzIHRvIHRoZSByZWdpc3RlciBpbmZvcm1hdGlvbiwg
SSBjYW4gZXhwbGFpbiBoZXJlIGluIGRldGFpbHMgKHdpbGwgYWRkIHRvIGNvbW1pdA0KbWVzc2Fn
ZSBvZiBuZXh0IHZlcnNpb24pOiBUaGVyZSBpcyBhIFJDUE0gSFcgYmxvY2sgd2hpY2ggaGFzIHJl
Z2lzdGVyIG5hbWVkIElQUERFWFBDUi4NCkl0IGNvbnRyb2xzIHdoZXRoZXIgcHJldmVudCBjZXJ0
YWluIElQIChzdWNoIGFzIHRpbWVyLCB1c2IsIGV0YykgZnJvbSBlbnRlcmluZyBsb3cNCnBvd2Vy
IG1vZGUgd2hlbiBzeXN0ZW0gc3VzcGVuZGVkLiBTbyBpdCdzIG5lY2Vzc2FyeSB0byBwcm9ncmFt
IGl0IGlmIHdlIHdhbnQgb25lDQpvZiB0aG9zZSBJUCB3b3JrIGFzIGEgd2FrZXVwIHNvdXJjZS4g
SG93ZXZlciwgZGlmZmVyZW50IExheWVyc2NhcGUgU29DcyBoYXZlIGRpZmZlcmVudCBiaXQgdnMu
DQpJUCBtYXBwaW5nICBsYXlvdXQuIFNvIEkgaGF2ZSB0byByZWNvcmQgdGhpcyBpbmZvcm1hdGlv
biBpbiBkZXZpY2UgdHJlZSBhbmQgZmV0Y2hlZCBieSBSQ1BNIGRyaXZlcg0KZGlyZWN0bHkuDQoN
CkRvIEkgbmVlZCB0byBsaXN0IGFsbCBTb0MncyBtYXBwaW5nIGluZm9ybWF0aW9uIGluIHRoaXMg
YmluZGluZyBkb2MgZm9yIHJlZmVyZW5jZT8NCg0KPldoYXQgd2FzIHdyb25nIHdpdGggdGhlIGV4
aXN0aW5nIGJpbmRpbmc/ICANCg0KVGhlcmUgd2FzIG9uZSB2ZXJzaW9uIG9mIFJDUE0gcGF0Y2gg
d2hpY2ggcmVxdWlyaW5nIHByb3BlcnR5ICdmc2wsI3JjcG0td2FrZXVwLWNlbGxzJyBidXQgd2Fz
IG5vdA0KYWNjZXB0ZWQgYnkgdXBzdHJlYW0gZmluYWxseS4gTm93IHdlIHdpbGwgbm8gbmVlZCBp
dCBhbnkgbG9uZ2VyIGR1ZSB0byBuZXcgZGVzaWduIGFsbG93IGNhc2Ugb2YgbXVsdGlwbGUNClJD
UE0gZGV2aWNlcyBleGlzdGluZyBjYXNlLg0KDQo+QWx0ZXJuYXRpdmVseSwgdXNlIHRoZSBjbG9j
ayBiaW5kaW5ncy4NCg0KU29ycnkgSSBkaWRuJ3QgZ2V0IHlvdXIgcG9pbnQuDQoNCj4gPiAtDQo+
ID4gLUV4YW1wbGU6DQo+ID4gLQlscHVhcnQwOiBzZXJpYWxAMjk1MDAwMCB7DQo+ID4gLQkJY29t
cGF0aWJsZSA9ICJmc2wsbHMxMDIxYS1scHVhcnQiOw0KPiA+IC0JCXJlZyA9IDwweDAgMHgyOTUw
MDAwIDB4MCAweDEwMDA+Ow0KPiA+IC0JCWludGVycnVwdHMgPSA8R0lDX1NQSSA4MCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4gPiAtCQljbG9ja3MgPSA8JnN5c2Nsaz47DQo+ID4gLQkJY2xvY2st
bmFtZXMgPSAiaXBnIjsNCj4gPiAtCQlmc2wscmNwbS13YWtldXAgPSA8JnJjcG0gMHgwIDB4NDAw
MDAwMDA+Ow0KPiA+ICsJCWJpZy1lbmRpYW47DQo+ID4gKwkJZnNsLGxzMTAxMmEtZnRtID0gPDB4
MjAwMDA+Ow0KPiA+ICsJCWZzbCxwZmUgPSA8MHhmMDAwMDAyMD47DQo+IA0KPiBmc2wscGZlIGlz
IG5vdCBkb2N1bWVudGVkLg0KDQpwZmUgcGF0Y2ggaXMgbm90IHVwc3RyZWFtIHlldCwgd2lsbCBy
ZW1vdmUgaXQuDQoNClJlZ2FyZHMsDQpSYW4NCg0KPiAtU2NvdHQNCg0K
