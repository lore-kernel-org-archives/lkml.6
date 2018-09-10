Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B80C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005F520854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tnRgAL6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005F520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeIJJgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 05:36:23 -0400
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:3202
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbeIJJgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 05:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng8sUMnQU9033hj6YXhvRsDG626SjDbUCtqsscdZYc0=;
 b=tnRgAL6C3bVq+G1On0iyXJRIBOS961ub5O9k3TOlLgatHwlE9B5y9vuL9Dvd4BBYV02NlSKaMNf9VP3/zIkDyjpdA1egvvJYGO5c4CXrroAILR+juZsrVPfF2q/ro17ACDjMEMiJbuTfqpukf/jjnVBgQg7Z+NlRSVpV7Wb4IoU=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4565.namprd02.prod.outlook.com (52.135.239.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 04:43:33 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8169:d66c:a34d:e91e]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8169:d66c:a34d:e91e%4]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 04:43:27 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP
 reset driver
Thread-Topic: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP
 reset driver
Thread-Index: AQHUROdicf/LQjvTwE+b+sRENje4CaThd1gAgAeAGJA=
Date:   Mon, 10 Sep 2018 04:43:27 +0000
Message-ID: <BYAPR02MB47104ED6BE886376B9232685C2050@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
         <1536131342-28041-3-git-send-email-nava.manne@xilinx.com>
 <1536142188.4084.1.camel@pengutronix.de>
In-Reply-To: <1536142188.4084.1.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4565;6:5wCgQN6rzavFroL67kP6ISwwcCo1jSEZXrWDTmUcBoDro16LKHJcH+mcOgIYH+nwAQDVi9QlhGTT/HVvVz24+sOJEv92GbCfakjqNKe7coS5Z67TqgYwh/N6hjyEAam+vL3Yd3/eCaof+pVCLidiRjpKiHwAlQdeFVFkYnGdl8F3Y6BAj6x3o4sTRqH1knQDRUGkeRwSHpgxmzYHJJDIHTXJaFpz0NbVXz0akssv4XGixKsOVBC9caaq2lIgWqdgmTirQ28IFuL4vmKfTqAVWaxGi0OC5o/Zw2BuSao3oDEVDOVAohkhV61VUWyL+d5RskCXeqKRqN0fTaxCVrc2TXPn/KRl0BgGxOsN3eodQPj/rdDCJaIM6L/EIAOkjKeg+nsiL4VVIxxF/YPSEQPw6exLlcl00EWX9dhlcZGdmvgxgnJfyXAgMIbMJXsu9qjzozfe4/A6wk4X9YRpll9zOQ==;5:mA+MxzP9RjtMISRgYUPwVQcZ4GywUcUZbYBl0ctdu8AgSC+plNcU7JHdMVcUCuC7/0lf9RG31Tdo18UVhHGZwm0WXqaAsCnRfrKOjVEw/9oXkzwjxQu2s+HXgRbwi9rQxXjgK3sfjtZ246Iy9CpgujUnEZIMBWR0cCcy0kTvDts=;7:JFP/lJuYDtsZ2w7Kel/zkCmo76221x6TpksUSIzJOgkivuQXmIh8vawDn19scz2x6iR1lRTvHdRjjkwukntA1LRe9p6CPLfBgrhlNTJyViRP2QM04hhgkBb8sjpJJvGO8xStndciss6EtiyxLSadVQmt3p93rpytlhyzuR0uDgV1MJjGFMVrDLHe18zq5iwq3ZDdZmLfYkmvdAQRWUXnHjI5tOyzGkVlsiOiphjDEPmBdmwLWG8bH+TVtiA0yl5L
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(346002)(376002)(366004)(51914003)(189003)(13464003)(199004)(25786009)(99286004)(102836004)(6506007)(53546011)(33656002)(76176011)(7696005)(8936002)(105586002)(106356001)(8676002)(26005)(186003)(110136005)(66066001)(3846002)(6116002)(5250100002)(14454004)(2501003)(97736004)(2906002)(316002)(81156014)(81166006)(2900100001)(6246003)(446003)(305945005)(9686003)(7736002)(11346002)(5660300001)(217873002)(86362001)(256004)(476003)(55016002)(229853002)(2201001)(6436002)(68736007)(486006)(53936002)(478600001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4565;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: c6242b44-d25d-4747-a912-08d616d7f388
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4565;
x-ms-traffictypediagnostic: BYAPR02MB4565:
x-microsoft-antispam-prvs: <BYAPR02MB4565037A556B86100241A0C9C2050@BYAPR02MB4565.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:BYAPR02MB4565;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4565;
x-forefront-prvs: 07915F544A
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 760hb82iy/gCoZNVlJ3fnGb7MmCCXT7xO702NxHPgbNBPX62Ya32K4WtohPwvNEhm3CKWPhNw3cpCEW3wJUBK056pvmAmnv/HPiqus9QGrR1G9P8UwfpGtpT9wKEongHECB7xVOa0VG0UFYQydUtAW93SVovXloHuz70F3eV8CQzQhpGfxRfvzNakqr20Vh7hooyRoHs29mOdgpX06LUZgGn+xVxMFdf5Rx8R+oDKnxhnCZgxCOS43goY6/Tc82mqLfJAEIy+egTD4MAwFU1Wlgi64CwWn171czIUxhPYSrcPQocDGAClG1P6CjLFF/5KHGapHxjdrCtZAh4FdDCGgGbwAMxakst4QhywvdCit0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6242b44-d25d-4747-a912-08d616d7f388
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 04:43:27.8092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcA0KDQpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4uDQpQbGVhc2UgZmlu
ZCBteSBjb21tbmV0cyBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogUGhpbGlwcCBaYWJlbCBbbWFpbHRvOnAuemFiZWxAcGVuZ3V0cm9uaXguZGVdDQo+IFNl
bnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDUsIDIwMTggMzo0MCBQTQ0KPiBUbzogTmF2YSBraXNo
b3JlIE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBSYWph
biBWYWphDQo+IDxSQUpBTlZAeGlsaW54LmNvbT47IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbngu
Y29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMi8zXSBkdC1iaW5kaW5nczogcmVzZXQ6IEFkZCBiaW5k
aW5ncyBmb3IgWnlucU1QDQo+IHJlc2V0IGRyaXZlcg0KPiANCj4gSGksDQo+IA0KPiBPbiBXZWQs
IDIwMTgtMDktMDUgYXQgMTI6MzkgKzA1MzAsIE5hdmEga2lzaG9yZSBNYW5uZSB3cm90ZToNCj4g
PiBBZGQgZG9jdW1lbnRhdGlvbiB0byBkZXNjcmliZSBYaWxpbnggWnlucU1QIHJlc2V0IGRyaXZl
ciBiaW5kaW5ncy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hdmEga2lzaG9yZSBNYW5uZSA8
bmF2YS5tYW5uZUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+
IAkJLUNvcnJlY3RlZCBDb21taXQgTXNnLg0KPiA+IENoYW5nZXMgZm9yIHYyOg0KPiA+IAkJLU1v
dmVkIHJlc2V0IG5vZGUgYXMgYSBjaGlsZCB0byBmaXJ3bWFyZQ0KPiA+IAkJIG5vZGUuDQo+ID4N
Cj4gPiAgLi4uL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC1maXJtd2FyZS50eHQgICAgICAg
fCAxNDINCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNDIg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC1maXJtd2ENCj4g
PiByZS50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2Fy
ZS94aWxpbngveGxueCx6eW5xbXAtZmlybXdhDQo+ID4gcmUudHh0DQo+ID4gaW5kZXggMWI0MzFk
OS4uMzUxYjFiYiAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9maXJtd2FyZS94aWxpbngveGxueCx6eW5xbXAtZmlybXdhDQo+ID4gcmUudHh0
DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL3hp
bGlueC94bG54LHp5bnFtcC1maQ0KPiA+ICsrKyBybXdhcmUudHh0DQo+IFsuLi5dDQo+ID4gIC0t
LS0tLS0NCj4gPiAgRXhhbXBsZQ0KPiA+ICAtLS0tLS0tDQo+ID4gQEAgLTI1LDUgKzE2Myw5IEBA
IGZpcm13YXJlIHsNCj4gPiAgCXp5bnFtcF9maXJtd2FyZTogenlucW1wLWZpcm13YXJlIHsNCj4g
PiAgCQljb21wYXRpYmxlID0gInhsbngsenlucW1wLWZpcm13YXJlIjsNCj4gPiAgCQltZXRob2Qg
PSAic21jIjsNCj4gPiArCQlyZXNldC1jb250cm9sbGVyOnJlc2V0LWNvbnRyb2xsZXJAMCB7DQo+
IA0KPiBJIHRoaW5rIHRoZSBsYWJlbCBzaG91bGQgdXNlIHVuZGVyc2NvcmUgaW5zdGVhZCBvZiBo
eXBoZW4sIGFuZCB0aGUgdW5pdCBhZGRyZXNzDQo+IHBhcnQgc2hvdWxkIGJlIHJlbW92ZWQgZnJv
bSB0aGUgbm9kZSBuYW1lLiBUaGVyZSBpcyBubyB1bml0IGFkZHJlc3MsIGFzIHRoZXJlDQo+IGlz
IG5vIHJlZyBwcm9wZXJ0eSBpbnNpZGUgdGhlIG5vZGUgYW5kIHRoZSBwYXJlbnQgbm9kZSBkb2Vz
bid0IGhhdmUgI2FkZHJlc3MtDQo+IGNlbGxzOg0KPiANCg0KV2lsbCBmaXggaW4gdGhlIG5leHQg
dmVyc2lvbi4NCg0KUmVnYXJkcywNCk5hdmFraXNob3JlLg0K
