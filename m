Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B1C65C14
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FB020657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G9KXC4fe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O4A2SbL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfARUMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:12:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39082 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729356AbfARUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:12:41 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0IK9Lg0010850;
        Fri, 18 Jan 2019 12:12:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=e/uH1WKjG5FpUzWed3tVDT9cbRVO3vFMXz4ruZf+Izo=;
 b=G9KXC4feverdl32RfAKowu8znrpyuLBgUOWDrvPmN4JOSn1h3QonH/FB2iFD4i91BCa2
 n8n3pSizqLvdQVHKyZLd4UwNpNU2EVgjCcf462WCa99MgaGOvfMASnZ5V1oIwTgYichm
 CZSPucDToxAJI7/4l4CTYlrRGxRZ/ng9H2U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q3k0krkwf-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Jan 2019 12:12:21 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 18 Jan 2019 12:12:08 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 18 Jan 2019 12:12:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/uH1WKjG5FpUzWed3tVDT9cbRVO3vFMXz4ruZf+Izo=;
 b=O4A2SbL1vKJgbhDFF+mSEZtidjblNbiGzOrPIKibuS6RGy94e2EkEAYvl0vuU7AYno1IbUXoDpnZjyOcCiKoFsURXppNqxxNGtrgnFbYxB7Co9Ekf45Q/U40nYnJtdDcr08aMKFg9cLtuehVQgeCVm+2sqyy1hya+F/yWrQAjLU=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1191.namprd15.prod.outlook.com (10.172.177.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 20:12:07 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d%10]) with mapi id 15.20.1516.019; Fri, 18 Jan
 2019 20:12:07 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
Thread-Topic: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
Thread-Index: AQHUrecp120UxlsdUUK9uZiXf1PR66W0eREAgAB5LwA=
Date:   Fri, 18 Jan 2019 20:12:07 +0000
Message-ID: <DCD8D2E5-DB18-427C-AA8F-18289E9AB0AB@fb.com>
References: <20190116220154.1026171-1-vijaykhemka@fb.com>
 <1547787502.2061444.1637712576.1F1E21B4@webmail.messagingengine.com>
In-Reply-To: <1547787502.2061444.1637712576.1F1E21B4@webmail.messagingengine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:efd9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1191;20:y8dJldrMZIedDuKnzabUz+zSMGctXsH/2ErtwCp+ugwhTWAI+/A4ox4mnw18mThSWU7Ok+d/DI4Y9WUtDEk+62Yzc3+eXL29rpvGsKwk/xPV2EjT109xkAJhfifKnmNVL6NTc5Vb/6g+kDtAbvU9XqzcVONy7OOnpDZWUrTo6Lo=
x-ms-office365-filtering-correlation-id: 23cb4845-579d-4cfa-fd98-08d67d8138ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1191;
x-ms-traffictypediagnostic: CY4PR15MB1191:
x-microsoft-antispam-prvs: <CY4PR15MB1191140C91DF98F216811914DD9C0@CY4PR15MB1191.namprd15.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(68736007)(4326008)(6116002)(102836004)(6246003)(53936002)(2201001)(82746002)(446003)(6512007)(2616005)(229853002)(6436002)(86362001)(14454004)(105586002)(478600001)(186003)(305945005)(7736002)(6506007)(25786009)(6486002)(76176011)(8676002)(99286004)(8936002)(36756003)(46003)(106356001)(81166006)(2906002)(316002)(11346002)(2501003)(33656002)(256004)(14444005)(81156014)(97736004)(476003)(5660300001)(71200400001)(71190400001)(486006)(110136005)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1191;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +693iAGDsalQhQQV63q3TbztKR8em2JWM+81KukHymdboPDzcTwXNf5diPkDdo6+utIAOzURm7YpL79ZdgBHDKYlQxGwdkfutsb1We3cs1dHZTGItQxclVLOny641Ix/IiP+1p8p5Jme6xP5kGcZ2PF0YCkvJ4O9jaYhzG+RsMIHW/hR1THR1zCgxJqiMaAYa/sVBfUJXZQg9iLMibgCF/KD/s6uFwnhzhCLA78Kg6DxKlhAN2QALdbZlTxf/+lilXg6QCvAB5D71mLKBcdfVEBvYxBOfEnURrEHlci5vFOskdbvvwil2ll1yk4eLiR5dh2hWIKfe+PtrKrDofUg7dpEHi5eq+9o3V8U93vuzA8+QaoaSvXxXqUiCEYfIna05Zf3yhTdCR4i0bWloCVjbEN//CkRhzyPoE3YTr9FMMo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAAB050E20538549A5ED189692CFCF68@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cb4845-579d-4cfa-fd98-08d67d8138ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 20:12:07.4078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1191
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KVGhhbmtzIGZvciB0aGlzIHJldmlldywgSSB3aWxsIGhhdmUgYSBmb2xsb3cg
dXAgcGF0Y2ggZm9yIHRoaXMgcmV0dXJuIHZhbHVlcy4NCg0KUmVnYXJkcw0KLVZpamF5DQoNCu+7
v09uIDEvMTcvMTksIDg6NTggUE0sICJBbmRyZXcgSmVmZmVyeSIgPGFuZHJld0Bhai5pZC5hdT4g
d3JvdGU6DQoNCiAgICBIaSBWaWpheSwNCiAgICANCiAgICBUaGFua3MgZm9yIGRvaW5nIHRoZSB3
b3JrIHRvIGZpeCB0aGUgZHJpdmVyLiBTb21lIG1pbm9yIHF1ZXJpZXMvcG9pbnRzDQogICAgYmVs
b3cuDQogICAgDQogICAgT24gVGh1LCAxNyBKYW4gMjAxOSwgYXQgMDg6MzEsIFZpamF5IEtoZW1r
YSB3cm90ZToNCiAgICA+IE1ha2lpbmcgbWVtb3J5LXJlZ2lvbiBhbmQgZmxhc2ggYXMgb3B0aW9u
YWwgcGFyYW1ldGVyIGluIGRldmljZQ0KICAgID4gdHJlZSBpZiB1c2VyIG5lZWRzIHRvIHVzZSB0
aGVzZSBwYXJhbWV0ZXIgdGhyb3VnaCBpb2N0bCB0aGVuDQogICAgPiBuZWVkIHRvIGRlZmluZSBp
biBkZXZpY2V0cmVlLg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2Eg
PHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMvbWlzYy9hc3Bl
ZWQtbHBjLWN0cmwuYyB8IDU4ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiAg
ICA+ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQog
ICAgPiANCiAgICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvYXNwZWVkLWxwYy1jdHJsLmMg
Yi9kcml2ZXJzL21pc2MvYXNwZWVkLWxwYy0NCiAgICA+IGN0cmwuYw0KICAgID4gaW5kZXggYTAy
NGY4MDQyMjU5Li4zMzIyMTBlMDZlOTggMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL21pc2Mv
YXNwZWVkLWxwYy1jdHJsLmMNCiAgICA+ICsrKyBiL2RyaXZlcnMvbWlzYy9hc3BlZWQtbHBjLWN0
cmwuYw0KICAgID4gQEAgLTY4LDYgKzY4LDcgQEAgc3RhdGljIGxvbmcgYXNwZWVkX2xwY19jdHJs
X2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlLCANCiAgICA+IHVuc2lnbmVkIGludCBjbWQsDQogICAg
PiAgCQl1bnNpZ25lZCBsb25nIHBhcmFtKQ0KICAgID4gIHsNCiAgICA+ICAJc3RydWN0IGFzcGVl
ZF9scGNfY3RybCAqbHBjX2N0cmwgPSBmaWxlX2FzcGVlZF9scGNfY3RybChmaWxlKTsNCiAgICA+
ICsJc3RydWN0IGRldmljZSAqZGV2ID0gZmlsZS0+cHJpdmF0ZV9kYXRhOw0KICAgID4gIAl2b2lk
IF9fdXNlciAqcCA9ICh2b2lkIF9fdXNlciAqKXBhcmFtOw0KICAgID4gIAlzdHJ1Y3QgYXNwZWVk
X2xwY19jdHJsX21hcHBpbmcgbWFwOw0KICAgID4gIAl1MzIgYWRkcjsNCiAgICA+IEBAIC05MCw2
ICs5MSwxMiBAQCBzdGF0aWMgbG9uZyBhc3BlZWRfbHBjX2N0cmxfaW9jdGwoc3RydWN0IGZpbGUg
KmZpbGUsIA0KICAgID4gdW5zaWduZWQgaW50IGNtZCwNCiAgICA+ICAJCWlmIChtYXAud2luZG93
X2lkICE9IDApDQogICAgPiAgCQkJcmV0dXJuIC1FSU5WQUw7DQogICAgPiAgDQogICAgPiArCQkv
KiBJZiBtZW1vcnktcmVnaW9uIGlzIG5vdCBkZXNjcmliZWQgaW4gZGV2aWNlIHRyZWUgKi8NCiAg
ICA+ICsJCWlmICghbHBjX2N0cmwtPm1lbV9zaXplKSB7DQogICAgPiArCQkJZGV2X2VycihkZXYs
ICJEaWRuJ3QgZmluZCByZXNlcnZlZCBtZW1vcnlcbiIpOw0KICAgID4gKwkJCXJldHVybiAtRUlO
VkFMOw0KICAgIA0KICAgIEkgZmVlbCBsaWtlIEVJTlZBTCBpc24ndCBxdWl0ZSByaWdodCAtIGl0
J3MgcHJldHR5IGdlbmVyaWMsIGFuZCB0aGUgcGFyYW1ldGVyDQogICAgdmFsdWUgY2hhbmdlcyBp
dHMgdmFsaWRpdHkgd2l0aCB0aGUgZGV2aWNldHJlZSBjb250ZXh0LiBNeSBndXQgaW5zdGluY3QN
CiAgICB3b3VsZCBiZSB0byB1c2UgRUlOVkFMIGZvciBwYXJhbWV0ZXIgdmFsdWVzIHRoYXQgdmlv
bGF0ZSBhc3N1bXB0aW9ucw0KICAgIG9mIHRoZSBkcml2ZXIgcmF0aGVyIHRoYW4gdmlvbGF0ZSBj
b25maWd1cmF0aW9uIG9mIHRoZSBkcml2ZXIuIE1heWJlIEVOWElPDQogICAgKCJObyBzdWNoIGRl
dmljZSBvciBhZGRyZXNzIikgaXMgYW4gaW1wcm92ZW1lbnQ6ICJJIGNhbid0IG1hcCB0aGF0IGRl
dmljZQ0KICAgIGJlY2F1c2UgdGhlcmUncyBubyBzdWNoIGRldmljZSBvciBhZGRyZXNzIj8NCiAg
ICANCiAgICA+ICsJCX0NCiAgICA+ICsNCiAgICA+ICAJCW1hcC5zaXplID0gbHBjX2N0cmwtPm1l
bV9zaXplOw0KICAgID4gIA0KICAgID4gIAkJcmV0dXJuIGNvcHlfdG9fdXNlcihwLCAmbWFwLCBz
aXplb2YobWFwKSkgPyAtRUZBVUxUIDogMDsNCiAgICA+IEBAIC0xMjYsOSArMTMzLDE4IEBAIHN0
YXRpYyBsb25nIGFzcGVlZF9scGNfY3RybF9pb2N0bChzdHJ1Y3QgZmlsZSANCiAgICA+ICpmaWxl
LCB1bnNpZ25lZCBpbnQgY21kLA0KICAgID4gIAkJCXJldHVybiAtRUlOVkFMOw0KICAgID4gIA0K
ICAgID4gIAkJaWYgKG1hcC53aW5kb3dfdHlwZSA9PSBBU1BFRURfTFBDX0NUUkxfV0lORE9XX0ZM
QVNIKSB7DQogICAgPiArCQkJaWYgKCFscGNfY3RybC0+cG5vcl9zaXplKSB7DQogICAgPiArCQkJ
CWRldl9lcnIoZGV2LCAiRGlkbid0IGZpbmQgaG9zdCBwbm9yIGZsYXNoXG4iKTsNCiAgICA+ICsJ
CQkJcmV0dXJuIC1FSU5WQUw7DQogICAgDQogICAgU2VlIHRoZSBlcnJvciBjb2RlIGRpc2N1c3Np
b24gYWJvdmUuIEFsc28sIHRoaXMgaXMgdXNlcnNwYWNlJ3MgZXJyb3Igbm90IA0KICAgIHRoZSBr
ZXJuZWwncywgc28gSSB0aGluayBkZXZfZXJyKCkgaXMgYSBiaXQgaGFyc2guIFByb2JhYmx5IGJl
c3QgdG8ganVzdCBsZXQNCiAgICB1c2Vyc3BhY2UgbG9nIHRoZSBlcnJvciBpZiBpdCB0aGlua3Mg
dGhlIGl0IGlzIGNvbmNlcm5pbmcuDQogICAgDQogICAgPiArCQkJfQ0KICAgID4gIAkJCWFkZHIg
PSBscGNfY3RybC0+cG5vcl9iYXNlOw0KICAgID4gIAkJCXNpemUgPSBscGNfY3RybC0+cG5vcl9z
aXplOw0KICAgID4gIAkJfSBlbHNlIGlmIChtYXAud2luZG93X3R5cGUgPT0gQVNQRUVEX0xQQ19D
VFJMX1dJTkRPV19NRU1PUlkpIHsNCiAgICA+ICsJCQkvKiBJZiBtZW1vcnktcmVnaW9uIGlzIG5v
dCBkZXNjcmliZWQgaW4gZGV2aWNlIHRyZWUgKi8NCiAgICA+ICsJCQlpZiAoIWxwY19jdHJsLT5t
ZW1fc2l6ZSkgew0KICAgID4gKwkJCQlkZXZfZXJyKGRldiwgIkRpZG4ndCBmaW5kIHJlc2VydmVk
IG1lbW9yeVxuIik7DQogICAgPiArCQkJCXJldHVybiAtRUlOVkFMOw0KICAgIA0KICAgIGFzIGFi
b3ZlLg0KICAgIA0KICAgID4gKwkJCX0NCiAgICA+ICAJCQlhZGRyID0gbHBjX2N0cmwtPm1lbV9i
YXNlOw0KICAgID4gIAkJCXNpemUgPSBscGNfY3RybC0+bWVtX3NpemU7DQogICAgPiAgCQl9IGVs
c2Ugew0KICAgID4gQEAgLTE5NiwxNyArMjEyLDE3IEBAIHN0YXRpYyBpbnQgYXNwZWVkX2xwY19j
dHJsX3Byb2JlKHN0cnVjdCANCiAgICA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAgICA+ICAJ
aWYgKCFscGNfY3RybCkNCiAgICA+ICAJCXJldHVybiAtRU5PTUVNOw0KICAgID4gIA0KICAgID4g
KwkvKiBJZiBmbGFzaCBpcyBkZXNjcmliZWQgaW4gZGV2aWNlIHRyZWUgdGhlbiBzdG9yZSAqLw0K
ICAgID4gIAlub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUsICJmbGFzaCIsIDAp
Ow0KICAgID4gIAlpZiAoIW5vZGUpIHsNCiAgICA+IC0JCWRldl9lcnIoZGV2LCAiRGlkbid0IGZp
bmQgaG9zdCBwbm9yIGZsYXNoIG5vZGVcbiIpOw0KICAgID4gLQkJcmV0dXJuIC1FTk9ERVY7DQog
ICAgPiAtCX0NCiAgICA+IC0NCiAgICA+IC0JcmMgPSBvZl9hZGRyZXNzX3RvX3Jlc291cmNlKG5v
ZGUsIDEsICZyZXNtKTsNCiAgICA+IC0Jb2Zfbm9kZV9wdXQobm9kZSk7DQogICAgPiAtCWlmIChy
Yykgew0KICAgID4gLQkJZGV2X2VycihkZXYsICJDb3VsZG4ndCBhZGRyZXNzIHRvIHJlc291cmNl
IGZvciBmbGFzaFxuIik7DQogICAgPiAtCQlyZXR1cm4gcmM7DQogICAgPiArCQlkZXZfZGJnKGRl
diwgIkRpZG4ndCBmaW5kIGhvc3QgcG5vciBmbGFzaCBub2RlXG4iKTsNCiAgICA+ICsJfSBlbHNl
IHsNCiAgICA+ICsJCXJjID0gb2ZfYWRkcmVzc190b19yZXNvdXJjZShub2RlLCAxLCAmcmVzbSk7
DQogICAgPiArCQlvZl9ub2RlX3B1dChub2RlKTsNCiAgICA+ICsJCWlmIChyYykgew0KICAgID4g
KwkJCWRldl9lcnIoZGV2LCAiQ291bGRuJ3QgYWRkcmVzcyB0byByZXNvdXJjZSBmb3IgZmxhc2hc
biIpOw0KICAgID4gKwkJCXJldHVybiByYzsNCiAgICA+ICsJCX0NCiAgICA+ICAJfQ0KICAgID4g
IA0KICAgID4gIAlscGNfY3RybC0+cG5vcl9zaXplID0gcmVzb3VyY2Vfc2l6ZSgmcmVzbSk7DQog
ICAgPiBAQCAtMjE0LDIyICsyMzAsMjIgQEAgc3RhdGljIGludCBhc3BlZWRfbHBjX2N0cmxfcHJv
YmUoc3RydWN0IA0KICAgID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KICAgID4gIA0KICAgID4g
IAlkZXZfc2V0X2RydmRhdGEoJnBkZXYtPmRldiwgbHBjX2N0cmwpOw0KICAgID4gIA0KICAgID4g
KwkvKiBJZiBtZW1vcnktcmVnaW9uIGlzIGRlc2NyaWJlZCBpbiBkZXZpY2UgdHJlZSB0aGVuIHN0
b3JlICovDQogICAgPiAgCW5vZGUgPSBvZl9wYXJzZV9waGFuZGxlKGRldi0+b2Zfbm9kZSwgIm1l
bW9yeS1yZWdpb24iLCAwKTsNCiAgICA+ICAJaWYgKCFub2RlKSB7DQogICAgPiAtCQlkZXZfZXJy
KGRldiwgIkRpZG4ndCBmaW5kIHJlc2VydmVkIG1lbW9yeVxuIik7DQogICAgPiAtCQlyZXR1cm4g
LUVJTlZBTDsNCiAgICA+IC0JfQ0KICAgID4gKwkJZGV2X2RiZyhkZXYsICJEaWRuJ3QgZmluZCBy
ZXNlcnZlZCBtZW1vcnlcbiIpOw0KICAgID4gKwl9IGVsc2Ugew0KICAgID4gKwkJcmMgPSBvZl9h
ZGRyZXNzX3RvX3Jlc291cmNlKG5vZGUsIDAsICZyZXNtKTsNCiAgICA+ICsJCW9mX25vZGVfcHV0
KG5vZGUpOw0KICAgID4gKwkJaWYgKHJjKSB7DQogICAgPiArCQkJZGV2X2VycihkZXYsICJDb3Vs
ZG4ndCBhZGRyZXNzIHRvIHJlc291cmNlIGZvciByZXNlcnZlZCBtZW1vcnlcbiIpOw0KICAgID4g
KwkJCXJldHVybiAtRU5PTUVNOw0KICAgIA0KICAgIFdvdywgSSB0aGluayB0aGlzIGlzIGFuIGFi
dXNlIG9mIEVOT01FTS4gSXRzIGRlc2NyaXB0aW9uIGlzICJPdXQgb2YgbWVtb3J5Ig0KICAgIHdo
aWNoIGRvZXNuJ3QgcmVhbGx5IHJlZmxlY3QgdGhlIHByb2JsZW0gaGVyZS4NCiAgICANCiAgICBO
b3QgcmVhbGx5IHlvdXIgZmF1bHQgdGhvdWdoLCBtYXliZSB3ZSdsbCBmaXggdGhhdCB3aXRoIHNv
bWUgZm9sbG93LXVwIHBhdGNoZXMuDQogICAgDQogICAgQ2hlZXJzLA0KICAgIA0KICAgIEFuZHJl
dw0KICAgIA0KICAgID4gKwkJfQ0KICAgID4gIA0KICAgID4gLQlyYyA9IG9mX2FkZHJlc3NfdG9f
cmVzb3VyY2Uobm9kZSwgMCwgJnJlc20pOw0KICAgID4gLQlvZl9ub2RlX3B1dChub2RlKTsNCiAg
ICA+IC0JaWYgKHJjKSB7DQogICAgPiAtCQlkZXZfZXJyKGRldiwgIkNvdWxkbid0IGFkZHJlc3Mg
dG8gcmVzb3VyY2UgZm9yIHJlc2VydmVkIG1lbW9yeVxuIik7DQogICAgPiAtCQlyZXR1cm4gLUVO
T01FTTsNCiAgICA+ICsJCWxwY19jdHJsLT5tZW1fc2l6ZSA9IHJlc291cmNlX3NpemUoJnJlc20p
Ow0KICAgID4gKwkJbHBjX2N0cmwtPm1lbV9iYXNlID0gcmVzbS5zdGFydDsNCiAgICA+ICAJfQ0K
ICAgID4gIA0KICAgID4gLQlscGNfY3RybC0+bWVtX3NpemUgPSByZXNvdXJjZV9zaXplKCZyZXNt
KTsNCiAgICA+IC0JbHBjX2N0cmwtPm1lbV9iYXNlID0gcmVzbS5zdGFydDsNCiAgICA+IC0NCiAg
ICA+ICAJbHBjX2N0cmwtPnJlZ21hcCA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcCgNCiAgICA+ICAJ
CQlwZGV2LT5kZXYucGFyZW50LT5vZl9ub2RlKTsNCiAgICA+ICAJaWYgKElTX0VSUihscGNfY3Ry
bC0+cmVnbWFwKSkgew0KICAgID4gQEAgLTI1OCw4ICsyNzQsNiBAQCBzdGF0aWMgaW50IGFzcGVl
ZF9scGNfY3RybF9wcm9iZShzdHJ1Y3QgDQogICAgPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQog
ICAgPiAgCQlnb3RvIGVycjsNCiAgICA+ICAJfQ0KICAgID4gIA0KICAgID4gLQlkZXZfaW5mbyhk
ZXYsICJMb2FkZWQgYXQgJXByXG4iLCAmcmVzbSk7DQogICAgPiAtDQogICAgPiAgCXJldHVybiAw
Ow0KICAgID4gIA0KICAgID4gIGVycjoNCiAgICA+IC0tIA0KICAgID4gMi4xNy4xDQogICAgPiAN
CiAgICANCg0K
