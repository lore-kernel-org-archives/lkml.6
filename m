Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE041C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EF1204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="oy7HG/Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EF1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeIGArU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:47:20 -0400
Received: from mail-by2nam01on0134.outbound.protection.outlook.com ([104.47.34.134]:26640
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728639AbeIGArT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT79SvgBwJa4mNSEEvDcy3TKbrG054Xc9WmeoS+LuO4=;
 b=oy7HG/Mke+CSCiHk3oaM2Fop+NvLuJ28nlNBf3pBqgC+z1atngsksVLHp5J2tijCPjJFnZOi9u5WfEKuHztkm+Ksz+EJwtlrPtA2ZrrhHmugzaPHiT0gqZbMtCvE4LOhNnF6PJBWKnaHpHyXdlOY3+rhN1SVZhuCBgN/4WxX7Ms=
Received: from MWHPR01MB2336.prod.exchangelabs.com (10.169.237.8) by
 MWHPR01MB2464.prod.exchangelabs.com (10.168.202.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 20:08:20 +0000
Received: from MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::c086:ef30:bfc3:29ab]) by MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::c086:ef30:bfc3:29ab%9]) with mapi id 15.20.1101.019; Thu, 6 Sep 2018
 20:08:19 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Open Source Submission <patches@amperecomputing.com>,
        Rameshwar Sahu <Rameshwar.Sahu@amperecomputing.com>
Subject: RE: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Thread-Topic: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Thread-Index: AQHURgwxlvsYSwD++0WmVzt64VJHs6TjrhEAgAAAOHA=
Date:   Thu, 6 Sep 2018 20:08:19 +0000
Message-ID: <MWHPR01MB2336EE4B6E4923C9ED851F20B3010@MWHPR01MB2336.prod.exchangelabs.com>
References: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
 <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
In-Reply-To: <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
x-originating-ip: [2601:646:8e01:9030:ddb:a5b8:d993:eed7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR01MB2464;6:QZVFG1MpUXYNHUL5iNgY5wNFmxag0HR8MEEW1ZRrUtZnubvbppHuMD52r7nyjAqi0XThf+0IBH3E6k4HXF7oWkDwMRjX7HoOrj4EsTo6568IlAcs4AYT9AElLtnbjHTKnF1nNSVriNuPPa7UTZQi1L7MW3zgfoSBGW//vuqsEyf11bbTaMeEITXMeCwkuoPOmCickIkoeKMfGgtdKSXaCkDXZGJxm44yxkzwhM0My5gkdbn0QUqskAqqKhhDqqI220osD4V2JPOpzIHWDSRY0KAhToi9JMBiFx+cSfdikkMNIEynN79+T87noGgmK3YwYII0njLa6V9MaIHea8lACxKKjuHFq3rcotZb0K3YXMHYzxUSeLl74vgtcfgjKZbQpW7FXTOpZdiZ1xtU+n1P4U5zTHDhqnk3bT9Bh7Zx5V/phUINIm0Mdu3zXRDXzeEzQ3zxNQv5CfZdtLGfzZQnfw==;5:MF8lUiwuoX9SjHCU7GqiTWEmNYvti8F8fEingMlYvJ6yPjDCtK9sbjzcTobbjo0nf/xeDvahBeZxSsje0gfQp+6t5shP6IV5CZuY3qY7s+HDp6DG1T0KaMCY1S+GjVbXSbU1rAj7mFXgIjvh5h+oGEMx8LKF2LqghXOgcoZKkv4=;7:xFMA1kdemv+YpPAaQktCz1f6RpdvfOjtXHkNf60YJGtmjBtsHxRjRSSmFP+v2m8EeXzGMGbyA5IL2gMXxh5Lb1RUIYoJAODVPaeonU5PKogIJCgBtQUF1c7DzhFZhy2a6suZEJZUXZn0n9E83nbM05o4n+m9bY6/O+qkwY4Djn0owNzWkEzONcZFHGW8NsWnoxM2ULz+xZQ8Lg3d7x07bMmEdyhzeAdVcoCpWa6i34jEc+ZtY594+RNp+O+mk40P
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39840400004)(13464003)(199004)(189003)(5660300001)(97736004)(6506007)(54906003)(316002)(106356001)(110136005)(14454004)(478600001)(33656002)(305945005)(74316002)(7736002)(105586002)(4326008)(6246003)(9686003)(46003)(8676002)(107886003)(186003)(2900100001)(55016002)(53546011)(53936002)(446003)(11346002)(25786009)(476003)(6436002)(102836004)(6116002)(8936002)(81166006)(486006)(81156014)(99286004)(229853002)(68736007)(5250100002)(2906002)(575784001)(86362001)(7696005)(217873002)(2501003)(256004)(14444005)(76176011)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2464;H:MWHPR01MB2336.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 48c11d8e-69c8-4059-45cc-08d614347d78
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR01MB2464;
x-ms-traffictypediagnostic: MWHPR01MB2464:
x-microsoft-antispam-prvs: <MWHPR01MB24649D570B1CD640D0B28BB4B3010@MWHPR01MB2464.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR01MB2464;BCL:0;PCL:0;RULEID:;SRVR:MWHPR01MB2464;
x-forefront-prvs: 0787459938
received-spf: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: vP7uwQbF3vGSWlO2X8NqQ9Bp43F42+DEpw4tOw7APf0Il190Zj+F+bQGum6lDDtcKGJxPVuehO6oA9EdJ1+HL81zwxcy3/T8DP1wpgBMdEtfW/N9th9WVzhb3En8hRa0gmixn74AAaCX/rdo9Lm/ePgsfqdtx1Nnob7wlMxMtNFMiEIUBL1h/DGb8zDfVrtdIaJSrYXWrB+JhSM7CcPbA1+0GE2Dq1YXdJ7rNEi7+yXQ3ADdCfv11XPPr0xJd2cx7UbRUrfJ7IjxFJ1DfegjMO6VXGeAVWJAFWQdJ5Q1mqMb8Cx/JZH0cB991N62KkgHjc3i87J59ZUEYG9Efh/FQNsbqtyYEEXr09qm3WpJcbI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c11d8e-69c8-4059-45cc-08d614347d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 20:08:19.4142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KDQpXaXRoIHJlZ2FyZHMsDQpTdW1hbg0KDQoNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IA0K
U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciA2LCAyMDE4IDE6MDYgUE0NClRvOiBTdW1hbiBUcmlw
YXRoaSA8c3RyaXBhdGhpQGFtcGVyZWNvbXB1dGluZy5jb20+OyBheGJvZUBrZXJuZWwuZGs7IHRq
QGtlcm5lbC5vcmc7IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgam9lQHBl
cmNoZXMuY29tOyBhcm5kQGFybmRiLmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZw0KQ2M6
IE9wZW4gU291cmNlIFN1Ym1pc3Npb24gPHBhdGNoZXNAYW1wZXJlY29tcHV0aW5nLmNvbT47IFJh
bWVzaHdhciBTYWh1IDxSYW1lc2h3YXIuU2FodUBhbXBlcmVjb21wdXRpbmcuY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSCB2M10gYXRhOiBEaXNhYmxlIEFIQ0kgQUxQTSBmZWF0dXJlIGZvciBBbXBl
cmUgQ29tcHV0aW5nIGVNQUcgU0FUQQ0KDQpbTk9USUNFOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQg
ZnJvbSBhbiBleHRlcm5hbCBzZW5kZXIuIFBsZWFzZSBiZSBtaW5kZnVsIG9mIHNhZmUgZW1haWwg
aGFuZGxpbmcgYW5kIHByb3ByaWV0YXJ5IGluZm9ybWF0aW9uIHByb3RlY3Rpb24gcHJhY3RpY2Vz
Ll0gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQoNCkhpLA0KDQpPbiAwNi0wOS0xOCAyMDowNSwgU3VtYW4gVHJpcGF0aGkgd3Jv
dGU6DQo+IER1ZSB0byBoYXJkd2FyZSBlcnJhdGEsIEFtcGVyZSBDb21wdXRpbmcgZU1BRyBTQVRB
IGNhbid0IHN1cHBvcnQgQUhDSSANCj4gQUxQTSBmZWF0dXJlLiBUaGlzIHBhdGNoIGRpc2FibGVz
IHRoZSBBSENJIEFMUE0gZmVhdHVyZSBmb3IgZU1BRyBTQVRBLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBTdW1hbiBUcnBhdGhpIDxzdHJpcGF0aGlAYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogUmFtZXNod2FyIFByYXNhZCBTYWh1IA0KPiA8cmFtZXNod2FyLnNhaHVAYW1wZXJl
Y29tcHV0aW5nLmNvbT4NCg0KU29ycnksIGJ1dCB0aGUgcGF0Y2ggaXMgc3RpbGwgY29taW5nIHRo
cm91Z2ggbWFuZ2xlZC4gRGlkIHlvdSB1c2UgZ2l0IHNlbmQtZW1haWwgPw0KW1N1bWFuIFRyaXBh
dGhpXSB5ZXMuIEkgcmVjaGVja2VkIGJlZm9yZSBzZW5kaW5nIHR3aWNlLiBTb3JyeSBmb3IgdGhl
IGluY29udmVuaWVuY2UuIFdpbGwgZmlndXJlIHRoZSBpc3N1ZSBvdXQNCg0KUmVnYXJkcywNCg0K
SGFucw0KDQoNCg0KDQo+DQo+IC0tLQ0KPiBDaGFuZ2VzIGZvciB2MzoNCj4NCj4gKiBGaXggdGhl
IGluZGVudGF0aW9uIGFuZCB3aGl0ZXNwYWNlIHdhcm5pbmdzLg0KPg0KPiBDaGFuZ2VzIGZvciB2
MjoNCj4NCj4gKiBJbnRyb2R1Y2UgdGhlIG5ldyBhdGFfcG9ydF9pbmZvIG9iamVjdCB3aGljaCBp
bmNsdWRlcyBBVEFfRkxBR19OT19MUE0uDQo+ICogSW5jbHVkZSB0aGlzIG9iamVjdCBmb3IgZU1B
RyBTQVRBIGluc2lkZSB0aGUgYWNwaSBtYXRjaCB0YWJsZS4NCj4gKiBSZXRyaWV2ZSB0aGUgYXRh
X3BvcnRfaW5mbyBmcm9tIHRoZSBhY3BpIG1hdGNoIHRhYmxlLg0KPg0KPiAtLS0NCj4gICBkcml2
ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMgfCAxNSArKysrKysrKysrKysrKy0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jIGIvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9y
bS5jIA0KPiBpbmRleCA5OWY5YTg5Li45YmEyODNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2F0
YS9haGNpX3BsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jDQo+
IEBAIC0zMyw2ICszMywxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0YV9wb3J0X2luZm8gYWhj
aV9wb3J0X2luZm8gPSB7DQo+ICAgICAgIC5wb3J0X29wcyAgICAgICA9ICZhaGNpX3BsYXRmb3Jt
X29wcywNCj4gICB9Ow0KPg0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdGFfcG9ydF9pbmZvIGFo
Y2lfcG9ydF9pbmZvX25vbHBtID0gew0KPiArICAgICAuZmxhZ3MgICAgICAgICAgPSBBSENJX0ZM
QUdfQ09NTU9OIHwgQVRBX0ZMQUdfTk9fTFBNLA0KPiArICAgICAucGlvX21hc2sgICAgICAgPSBB
VEFfUElPNCwNCj4gKyAgICAgLnVkbWFfbWFzayAgICAgID0gQVRBX1VETUE2LA0KPiArICAgICAu
cG9ydF9vcHMgICAgICAgPSAmYWhjaV9wbGF0Zm9ybV9vcHMsDQo+ICt9Ow0KPiArDQo+ICAgc3Rh
dGljIHN0cnVjdCBzY3NpX2hvc3RfdGVtcGxhdGUgYWhjaV9wbGF0Zm9ybV9zaHQgPSB7DQo+ICAg
ICAgIEFIQ0lfU0hUKERSVl9OQU1FKSwNCj4gICB9Ow0KPiBAQCAtNDEsNiArNDgsNyBAQCBzdGF0
aWMgaW50IGFoY2lfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICB7DQo+
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAgICAgIHN0cnVjdCBh
aGNpX2hvc3RfcHJpdiAqaHByaXY7DQo+ICsgICAgIGNvbnN0IHN0cnVjdCBhdGFfcG9ydF9pbmZv
ICpwb3J0Ow0KPiAgICAgICBpbnQgcmM7DQo+DQo+ICAgICAgIGhwcml2ID0gYWhjaV9wbGF0Zm9y
bV9nZXRfcmVzb3VyY2VzKHBkZXYpOw0KPiBAQCAtNTcsNyArNjUsMTEgQEAgc3RhdGljIGludCBh
aGNpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgIGlmIChvZl9k
ZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJoaXNpbGljb24saGlzaS1haGNpIikp
DQo+ICAgICAgICAgICAgICAgaHByaXYtPmZsYWdzIHw9IEFIQ0lfSEZMQUdfTk9fRkJTIHwgQUhD
SV9IRkxBR19OT19OQ1E7DQo+DQo+IC0gICAgIHJjID0gYWhjaV9wbGF0Zm9ybV9pbml0X2hvc3Qo
cGRldiwgaHByaXYsICZhaGNpX3BvcnRfaW5mbywNCj4gKyAgICAgcG9ydCA9IGFjcGlfZGV2aWNl
X2dldF9tYXRjaF9kYXRhKGRldik7DQo+ICsgICAgIGlmICghcG9ydCkNCj4gKyAgICAgICAgICAg
ICBwb3J0ID0gJmFoY2lfcG9ydF9pbmZvOw0KPiArDQo+ICsgICAgIHJjID0gYWhjaV9wbGF0Zm9y
bV9pbml0X2hvc3QocGRldiwgaHByaXYsIHBvcnQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJmFoY2lfcGxhdGZvcm1fc2h0KTsNCj4gICAgICAgaWYgKHJjKQ0KPiAgICAg
ICAgICAgICAgIGdvdG8gZGlzYWJsZV9yZXNvdXJjZXM7DQo+IEBAIC04NSw2ICs5Nyw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFoY2lfb2ZfbWF0Y2hbXSA9IHsNCj4gICBN
T0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhaGNpX29mX21hdGNoKTsNCj4NCj4gICBzdGF0aWMgY29u
c3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIGFoY2lfYWNwaV9tYXRjaFtdID0gew0KPiArICAgICB7
ICJBUE1DMEQzMyIsICh1bnNpZ25lZCBsb25nKSZhaGNpX3BvcnRfaW5mb19ub2xwbSB9LA0KPiAg
ICAgICB7IEFDUElfREVWSUNFX0NMQVNTKFBDSV9DTEFTU19TVE9SQUdFX1NBVEFfQUhDSSwgMHhm
ZmZmZmYpIH0sDQo+ICAgICAgIHt9LA0KPiAgIH07DQo+IC0tDQo+IDIuNy40DQo+DQo=
