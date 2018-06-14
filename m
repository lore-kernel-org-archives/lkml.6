Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0216CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A152D208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FvgY/JLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A152D208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755512AbeFNSaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:30:12 -0400
Received: from mail-eopbgr720061.outbound.protection.outlook.com ([40.107.72.61]:64064
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755319AbeFNSaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfvm2CvGBtDBmHfT0J41uENc64lhTg1JH1f4thikEaI=;
 b=FvgY/JLEFGB2hqQm6H/6BrpGSo1gVp7a5ccNEBDmJU8S1cip5qH+FZgQPBuNE8EWmH4wE9L5M1lIUBsGpepGeT6RF908NAdliPOUKYf49lkrlUwPUlmliYPTk1QRchFnw7Po/wpNGfRS4sXyjC0AXnJaJt6hRXRXY9huN771xZA=
Received: from SN1PR02MB3758.namprd02.prod.outlook.com (52.132.200.144) by
 SN1PR02MB3646.namprd02.prod.outlook.com (52.132.198.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 18:30:03 +0000
Received: from SN1PR02MB3758.namprd02.prod.outlook.com
 ([fe80::b5c5:3fdb:45a1:8d8d]) by SN1PR02MB3758.namprd02.prod.outlook.com
 ([fe80::b5c5:3fdb:45a1:8d8d%3]) with mapi id 15.20.0841.021; Thu, 14 Jun 2018
 18:30:03 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: RE: [PATCH v7 10/10] drivers: clk: Add ZynqMP clock driver
Thread-Topic: [PATCH v7 10/10] drivers: clk: Add ZynqMP clock driver
Thread-Index: AQHT+FijUijlzngt2UaHFao5Jktj46RIxqwAgBdj86A=
Date:   Thu, 14 Jun 2018 18:30:03 +0000
Message-ID: <SN1PR02MB3758971F60A9800642B16F95B87D0@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
 <1527713725-1086-11-git-send-email-jollys@xilinx.com>
 <c042fd9b-85cb-f0d3-101c-f78f3dc4fc44@infradead.org>
In-Reply-To: <c042fd9b-85cb-f0d3-101c-f78f3dc4fc44@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3646;7:cuIMx/5rEJOwBNWkufaR2pSBKI5EAE2iUdZ2utM7BKAZH49PLCx0P0vqhpNBr6+QKkDFWVMBgRNLkNHsFrKCxUd54SbRtTVBGE1BqZN1GYaQ8MluWpKYxZtgz1398sC/Btn6zTp2UU3q29w2XtEgRAy1TEn6FLPH1KJgRZHy1/AJk+Kc4BFyZ7vhbKE+mir5Us+J2a4G+MEH4VK+BObbVzQBi/zy9/G+GoCVC1PefYEZWGXLhn6ffFXqIXafX1h7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 786e5b0e-9878-43ed-60b3-08d5d224d85d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3646;
x-ms-traffictypediagnostic: SN1PR02MB3646:
x-microsoft-antispam-prvs: <SN1PR02MB36465AD6DADC49199BD2FC28B87D0@SN1PR02MB3646.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB3646;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3646;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(366004)(396003)(376002)(13464003)(199004)(189003)(33656002)(53546011)(54906003)(2906002)(229853002)(4326008)(478600001)(476003)(55016002)(9686003)(68736007)(106356001)(110136005)(2501003)(102836004)(11346002)(446003)(25786009)(86362001)(2201001)(3280700002)(2900100001)(6116002)(3846002)(97736004)(3660700001)(6506007)(5250100002)(105586002)(14454004)(486006)(5660300001)(99286004)(8676002)(26005)(53936002)(186003)(316002)(72206003)(76176011)(66066001)(107886003)(7416002)(74316002)(8936002)(6246003)(39060400002)(81166006)(81156014)(6436002)(7696005)(7736002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3646;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dbvs5xBbnanQvUIpauIQUniF04hdPETcXkQ8RxllStMFFMxwoKlrrtMDn3aa2BBRS0WF0vI6IzrCq9QW9LX+RdKB02tpDyvo+PiRZ2DeY7ZN6qHzM/XPIM6sHoX5g0ds9OJfBofvl4rT+Qgf2Kbnq2Fc0PCyFvGddyrMwVIBymZw6FQN1ono7TNeaaByvUc3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786e5b0e-9878-43ed-60b3-08d5d224d85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 18:30:03.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNClRoYW5rcyBmb3IgcmV2aWV3LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFJhbmR5IER1bmxhcCBbbWFpbHRvOnJkdW5sYXBAaW5mcmFkZWFkLm9y
Z10NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMzAsIDIwMTggMjoxOCBQTQ0KPiBUbzogSm9sbHkg
U2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+OyBhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnOw0KPiBt
aW5nb0BrZXJuZWwub3JnOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbWF0dEBjb2RlYmx1
ZXByaW50LmNvLnVrOw0KPiBzdWRlZXAuaG9sbGFAYXJtLmNvbTsgaGthbGx3ZWl0MUBnbWFpbC5j
b207IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbTsg
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lkQGNvZGVhdXJvcmEub3JnOyBtaWNoYWwu
c2ltZWtAeGlsaW54LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJt
LmNvbTsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZw0KPiBDYzogUmFqYW4gVmFqYSA8UkFKQU5W
QHhpbGlueC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBU
ZWphcyBQYXRlbA0KPiA8VEVKQVNQQHhpbGlueC5jb20+OyBTaHViaHJhanlvdGkgRGF0dGEgPHNo
dWJocmFqQHhpbGlueC5jb20+OyBKb2xseSBTaGFoDQo+IDxKT0xMWVNAeGlsaW54LmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NyAxMC8xMF0gZHJpdmVyczogY2xrOiBBZGQgWnlucU1QIGNs
b2NrIGRyaXZlcg0KPiANCj4gT24gMDUvMzAvMjAxOCAwMTo1NSBQTSwgSm9sbHkgU2hhaCB3cm90
ZToNCj4gPiBGcm9tOiBKb2xseSBTaGFoIDxqb2xseS5zaGFoQHhpbGlueC5jb20+DQo+IA0KPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvenlucW1wL0tjb25maWcgYi9kcml2ZXJzL2Ns
ay96eW5xbXAvS2NvbmZpZw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAu
LmZlODE1ZjcNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvenlucW1w
L0tjb25maWcNCj4gPiBAQCAtMCwwICsxLDExIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCj4gPiArDQo+ID4gK2NvbmZpZyBDT01NT05fQ0xLX1pZTlFNUA0KPiA+
ICsJYm9vbCAiU3VwcG9ydCBmb3IgWGlsaW54IFp5bnFNUCBVbHRyYXNjYWxlKyBjbG9jayBjb250
cm9sbGVycyINCj4gPiArCWRlcGVuZHMgb24gT0YNCj4gPiArCWRlcGVuZHMgb24gQVJDSF9aWU5R
TVAgfHwgQ09NUElMRV9URVNUDQo+ID4gKwlkZXBlbmRzIG9uIFpZTlFNUF9GSVJNV0FSRQ0KPiA+
ICsJaGVscA0KPiA+ICsJICBTdXBwb3J0IGZvciB0aGUgWnlucW1wIFVsdHJhc2NhbGUgY2xvY2sg
Y29udHJvbGxlci4NCj4gPiArCSAgSXQgaGFzIGEgZGVwZW5kZW5jeSBvbiB0aGUgUE1VIGZpcm13
YXJlLg0KPiA+ICsJICBTYXkgWSBpZiB5b3Ugd2FudCB0byBzdXBwb3J0IGNsb2NrIHN1cHBvcnQN
Cj4gDQo+IAkgIFNheSBZIGlmIHlvdSB3YW50IHRvIGluY2x1ZGUgY2xvY2sgc3VwcG9ydC4NCj4g
DQoJRml4ZWQgaW4gdjgNCg0KPiANCj4gLS0NCj4gflJhbmR5DQo=
