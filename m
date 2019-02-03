Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A2C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236E92084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O1a5OvNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfBCVuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 16:50:10 -0500
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:27524
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727364AbfBCVuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 16:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJU12yECnCduKNMw+isD0M0M3MPV1Ul02OOfxsro8Lk=;
 b=O1a5OvNdGrVqjPSw69Xz06PAapTeLf+5BewevtiGV4Jlkx/Bvyl6WBB/FFmokAp//RfWTmgYuO9zZKIHUhaKJB85u9YJHCVjthI12w+gDzLEWzrVPKDzJwrU0DpmcYKidH+yVn6xW4ZJDpM0gRs27Q4rAIKCIFsYAUbFoHLMaUk=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0999.namprd21.prod.outlook.com (52.132.133.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1622.6; Sun, 3 Feb 2019 21:50:05 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781%9]) with mapi id 15.20.1622.000; Sun, 3 Feb 2019
 21:50:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH V2 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Topic: [PATCH V2 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Thread-Index: AQHUuvlWYxKG3ZQG+Ua3DlU1ia1ZAaXOmDoQ
Date:   Sun, 3 Feb 2019 21:50:05 +0000
Message-ID: <DM5PR2101MB0918E63F306E9226A801BF55D76C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549113287-5606-3-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1549113287-5606-3-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-03T21:50:03.0888312Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9a97a53d-4187-44b3-9c36-4b28e1222bbf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;6:fxk1rwGjSrYyBlRHwbu8tWJNxCjtDC3m9JXmfVf38s+gxrvFwEcVyBzXXNz/rA8Zip48VIynqC39992h+6GrWxBR88Mf0UIBQChGprI/Ss7FIaEos272LRer5sVA2Ozx0luFspTWq4NR5oiQPnm4YI4tVElZdqLiP1fvN/Y/Q8h247mOHzOvvHAzR480QIbBtz8A5tWKc55hlDVszBoAtOB1aTPUA+vW+SWRRIUNhOJwr/FfJc0GHCNdUuY0Ez4yLDwQd/d25Bc9+k6bFjZ67t6t3NoWZCMnqjrED0DfMLO6xug8w0pyzN3nRMPbXk/UkKsNM/tU2xTpxqdhIfYhMGnOEM46nzpyEFE2LZOeEvLnhqSu2nif79RTXnBqAEoMIy3+dtwEcmYK3G4yXY4GODerUwcVgphFkdXYwFEQJ65M1ADbGuoyuXXJFs6aywBGlcnZgmk+OWHJm9diZ+1IZA==;5:o5uijQupBTb254InZvQMZQR2Ukiye0qdfgjvapVAoliOvXFCW+u0ysiDRdfXZ3ETxECHXKX9KJbjofPNJTWS77VLGMCd1aGrx6bjsVUu/8YLFfw4uTKjxUVQGw/W9Al2XShNvPmHe7YZEWOl7WM1/FYw/m2ElUx9Y5IfMu9IBvsnBSp/jMGzch2J7ZK2kkNVbTnSUEYCz0kzaxv4Ugnz2w==;7:tcXfhJtUVDEDzMkz0FJ+Pn96o/wwVFxWQuTrOH41NACR/c6DBnPs0HEooWDPlSihJ7VGsyhodvfPAFALc1eFLABDaHGdqBvu/vhDzBIa19VkLF+X74Qsn3Qoh+AaaREAYIQ524snZ8xIfolbsN7Acw==
x-ms-office365-filtering-correlation-id: 16e810f1-b5f9-4363-d55f-08d68a218ef5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB099936CD94D76F08A7DB3998D76C0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(486006)(1411001)(2906002)(305945005)(7736002)(26005)(186003)(14454004)(446003)(11346002)(476003)(81156014)(478600001)(102836004)(6506007)(8676002)(229853002)(97736004)(81166006)(7416002)(1361003)(66066001)(86362001)(10090500001)(6916009)(68736007)(8990500004)(74316002)(14444005)(256004)(105586002)(2351001)(106356001)(5640700003)(2501003)(6436002)(39060400002)(4326008)(6246003)(25786009)(86612001)(53936002)(3846002)(6116002)(55016002)(7696005)(71190400001)(33656002)(10290500003)(8936002)(99286004)(76176011)(9686003)(71200400001)(54906003)(316002)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NESTNaHrMqCHrbhx+23UUvM+hevv+8KMLOGHi526S97MAX3XWLmUB87hGAxf/gqhuc0q47pF+HYYiYJlnRSaLpiI85Gu6sW44tvHktQDLpmbx8xNwVvEaLL1YT4+Tj1bwjv4yxJJgwH3Y09pUe/rsc1O7c7Cl7ZSC4KTJpbyXNt05YQpOtdHFKJrSRrQdc28xv9u5n7MO6Z8kLbPTL2ZGKFF/C9qC0I1SMRohI/XnxBfdCA1zr/REW7FbZOhJH79Ms4HxaAGc8Xd+yf8sxUf+EWZBZ1j+hF6wSj2Rk8XQmpcoOFp3D6tvry7aj4PicKQA793e+D+HhR5nFtwVrjlyOSQt8hzbUpWZ4dipjRXAkbnFFZrl6fA9PcGFAPLhG0ukNiJp2X8n/1eNkFCLBrAbKW+fAeLwD98uu2twT9lHNc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e810f1-b5f9-4363-d55f-08d68a218ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 21:50:05.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogbGFudGlhbnl1MTk4NkBnbWFpbC5jb20gPGxhbnRpYW55dTE5ODZAZ21haWwuY29tPiBT
ZW50OiBTYXR1cmRheSwgRmVicnVhcnkgMiwgMjAxOSA1OjE1IEFNDQo+IA0KPiArLyoNCj4gKyAq
IEFjY29yZGluZyA4MjA5M0FBIElPLUFQSUMgc3BlYyAsIElPIEFQSUMgaGFzIGEgMjQtZW50cnkg
SW50ZXJydXB0DQo+ICsgKiBSZWRpcmVjdGlvbiBUYWJsZS4NCj4gKyAqLw0KPiArI2RlZmluZSBJ
T0FQSUNfUkVNQVBQSU5HX0VOVFJZIDI0DQoNClRoZSBvdGhlciB1bnN0YXRlZCBhc3N1bXB0aW9u
IGhlcmUgaXMgdGhhdCBIeXBlci12IGd1ZXN0IFZNcw0KaGF2ZSBvbmx5IGEgc2luZ2xlIElPQVBJ
QywgcmVnYXJkbGVzcyBvZiB0aGUgc2l6ZSBvZiB0aGUgVk0uDQpQZXJoYXBzIHRoYXQgc2hvdWxk
IGJlIHN0YXRlZCBpbiB0aGUgY29tbWVudCBleHBsYWluaW5nIHdoeQ0KdGhlcmUgYXJlIDI0IGVu
dHJpZXM/DQoNCj4gKw0KPiArc3RhdGljIGNwdW1hc2tfdCBpb2FwaWNfbWF4X2NwdW1hc2sgPSB7
IENQVV9CSVRTX05PTkUgfTsNCj4gK3N0YXRpYyBzdHJ1Y3QgaXJxX2RvbWFpbiAqaW9hcGljX2ly
X2RvbWFpbjsNCj4gKw0KPiArc3RhdGljIGludCBoeXBlcnZfaXJfc2V0X2FmZmluaXR5KHN0cnVj
dCBpcnFfZGF0YSAqZGF0YSwNCj4gKwkJY29uc3Qgc3RydWN0IGNwdW1hc2sgKm1hc2ssIGJvb2wg
Zm9yY2UpDQo+ICt7DQo+ICsJc3RydWN0IGlycV9kYXRhICpwYXJlbnQgPSBkYXRhLT5wYXJlbnRf
ZGF0YTsNCj4gKwlzdHJ1Y3QgaXJxX2NmZyAqY2ZnID0gaXJxZF9jZmcoZGF0YSk7DQo+ICsJc3Ry
dWN0IElPX0FQSUNfcm91dGVfZW50cnkgKmVudHJ5Ow0KPiArCWNwdW1hc2tfdCBjcHVtYXNrOw0K
PiArCWludCByZXQ7DQo+ICsNCj4gKwljcHVtYXNrX2FuZG5vdCgmY3B1bWFzaywgbWFzaywgJmlv
YXBpY19tYXhfY3B1bWFzayk7DQo+ICsNCj4gKwkvKiBSZXR1cm4gZXJyb3IgSWYgbmV3IGlycSBh
ZmZpbml0eSBpcyBvdXQgb2YgaW9hcGljX21heF9jcHVtYXNrLiAqLw0KPiArCWlmICghY3B1bWFz
a19lbXB0eSgmY3B1bWFzaykpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KDQpUaGUgYWJvdmUgdHdv
IGNwdW1hc2sgZnVuY3Rpb25zIGNhbiBiZSBjb21iaW5lZCBpbiBhIHNpbmdsZQ0KY2FsbCB0byBj
cHVtYXNrX3N1YnNldCgpLiAgVGhpcyBoYXMgdGhlIG5pY2UgcHJvcGVydHkgdGhhdCBkZXRlcm1p
bmluZw0Kd2hldGhlciB0aGUgY3B1cyBpbiAibWFzayIgYXJlIGEgc3Vic2V0IG9mIHRoZSBjcHVz
IGluICJpb2FwaWNfbWF4X2NwdW1hc2siDQppcyBleGFjdGx5IHdoYXQgdGhpcyBjb2RlIGlzIHRy
eWluZyB0byBkby4gOi0pICBBbmQgaXQgZ2V0cyByaWQgb2YgdGhlIGxvY2FsDQpjcHVtYXNrIHZh
cmlhYmxlIGFuZCB0aGUgYXNzb2NpYXRlZCBjb21waWxlciB3YXJuaW5ncyBhYm91dCBzdGFjayBm
cmFtZQ0Kc2l6ZS4NCg0KPiArDQo+ICsJcmV0ID0gcGFyZW50LT5jaGlwLT5pcnFfc2V0X2FmZmlu
aXR5KHBhcmVudCwgbWFzaywgZm9yY2UpOw0KPiArCWlmIChyZXQgPCAwIHx8IHJldCA9PSBJUlFf
U0VUX01BU0tfT0tfRE9ORSkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCWVudHJ5ID0gZGF0
YS0+Y2hpcF9kYXRhOw0KPiArCWVudHJ5LT5kZXN0ID0gY2ZnLT5kZXN0X2FwaWNpZDsNCj4gKwll
bnRyeS0+dmVjdG9yID0gY2ZnLT52ZWN0b3I7DQo+ICsJc2VuZF9jbGVhbnVwX3ZlY3RvcihjZmcp
Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgaXJxX2No
aXAgaHlwZXJ2X2lyX2NoaXAgPSB7DQo+ICsJLm5hbWUJCQk9ICJIWVBFUlYtSVIiLA0KPiArCS5p
cnFfYWNrCQk9IGFwaWNfYWNrX2lycSwNCj4gKwkuaXJxX3NldF9hZmZpbml0eQk9IGh5cGVydl9p
cl9zZXRfYWZmaW5pdHksDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IGh5cGVydl9pcnFfcmVt
YXBwaW5nX2FsbG9jKHN0cnVjdCBpcnFfZG9tYWluICpkb21haW4sDQo+ICsJCQkJICAgICB1bnNp
Z25lZCBpbnQgdmlycSwgdW5zaWduZWQgaW50IG5yX2lycXMsDQo+ICsJCQkJICAgICB2b2lkICph
cmcpDQo+ICt7DQo+ICsJc3RydWN0IGlycV9hbGxvY19pbmZvICppbmZvID0gYXJnOw0KPiArCXN0
cnVjdCBpcnFfZGF0YSAqaXJxX2RhdGE7DQo+ICsJc3RydWN0IGlycV9kZXNjICpkZXNjOw0KPiAr
CWludCByZXQgPSAwOw0KPiArDQo+ICsJaWYgKCFpbmZvIHx8IGluZm8tPnR5cGUgIT0gWDg2X0lS
UV9BTExPQ19UWVBFX0lPQVBJQyB8fCBucl9pcnFzID4gMSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+ICsNCj4gKwlyZXQgPSBpcnFfZG9tYWluX2FsbG9jX2lycXNfcGFyZW50KGRvbWFpbiwgdmly
cSwgbnJfaXJxcywgYXJnKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4g
Kw0KPiArCWlycV9kYXRhID0gaXJxX2RvbWFpbl9nZXRfaXJxX2RhdGEoZG9tYWluLCB2aXJxKTsN
Cj4gKwlpZiAoIWlycV9kYXRhKSB7DQo+ICsJCWlycV9kb21haW5fZnJlZV9pcnFzX2NvbW1vbihk
b21haW4sIHZpcnEsIG5yX2lycXMpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsN
Cj4gKwlpcnFfZGF0YS0+Y2hpcCA9ICZoeXBlcnZfaXJfY2hpcDsNCj4gKw0KPiArCS8qDQo+ICsJ
ICogSU9BUElDIGVudHJ5IHBvaW50ZXIgaXMgc2F2ZWQgaW4gY2hpcF9kYXRhIHRvIGFsbG93DQo+
ICsJICogaHlwZXJ2X2lycV9yZW1hcHBuZ19hY3RpdmF0ZSgpL2h5cGVydl9pcl9zZXRfYWZmaW5p
dHkoKSB0byBzZXQNCj4gKwkgKiB2ZWN0b3IgYW5kIGRlc3RfYXBpY2lkLiBjZmctPnZlY3RvciBh
bmQgY2ZnLT5kZXN0X2FwaWNpZCBhcmUNCj4gKwkgKiBpZ25vcnJlZCB3aGVuIElSUSByZW1hcHBp
bmcgaXMgZW5hYmxlZC4gU2VlIGlvYXBpY19jb25maWd1cmVfZW50cnkoKS4NCiANClNwZWxsaW5n
OiAiaWdub3JlZCIuDQoNCkkgc2F3IFZpdGFseSBwcmV2aW91cyBjb21tZW50cywgYW5kIEkgc3Rp
bGwgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzIGNvbW1lbnQuIDotKA0KSXMgSVJRIHJlbWFwcGluZyBj
b25zaWRlcmVkIHRvIGJlIGVuYWJsZWQgYnkgdGhpcyBJT01NVSBkcml2ZXIsIHN1Y2ggdGhhdA0K
Y2ZnLT52ZWN0b3IgYW5kIGNmZy0+ZGVzdF9hcGljaWQgYXJlIGlnbm9yZWQ/ICBPciBpcyB0aGUg
IndoZW4gSVJRIHJlbWFwcGluZw0KaXMgZW5hYmxlZCIgYSBzdGF0ZW1lbnQgYWJvdXQgc29tZSBm
dXR1cmUgZW5oYW5jZW1lbnQ/DQoNCj4gKwkgKi8NCj4gKwlpcnFfZGF0YS0+Y2hpcF9kYXRhID0g
aW5mby0+aW9hcGljX2VudHJ5Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBIeXB2ZXItViBJTyBBUElD
IGlycSBhZmZpbml0eSBzaG91bGQgYmUgaW4gdGhlIHNjb3BlIG9mDQo+ICsJICogaW9hcGljX21h
eF9jcHVtYXNrIGJlY2F1c2Ugbm8gaXJxIHJlbWFwcGluZyBzdXBwb3J0Lg0KPiArCSAqLw0KPiAr
CWRlc2MgPSBpcnFfZGF0YV90b19kZXNjKGlycV9kYXRhKTsNCj4gKwljcHVtYXNrX2FuZChkZXNj
LT5pcnFfY29tbW9uX2RhdGEuYWZmaW5pdHksDQo+ICsJCQlkZXNjLT5pcnFfY29tbW9uX2RhdGEu
YWZmaW5pdHksDQo+ICsJCQkmaW9hcGljX21heF9jcHVtYXNrKTsNCj4gKw0KPiArCXJldHVybiAw
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBoeXBlcnZfaXJxX3JlbWFwcGluZ19mcmVlKHN0
cnVjdCBpcnFfZG9tYWluICpkb21haW4sDQo+ICsJCQkJIHVuc2lnbmVkIGludCB2aXJxLCB1bnNp
Z25lZCBpbnQgbnJfaXJxcykNCj4gK3sNCj4gKwlpcnFfZG9tYWluX2ZyZWVfaXJxc19jb21tb24o
ZG9tYWluLCB2aXJxLCBucl9pcnFzKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBoeXBlcnZf
aXJxX3JlbWFwcG5nX2FjdGl2YXRlKHN0cnVjdCBpcnFfZG9tYWluICpkb21haW4sDQo+ICsJCQkg
IHN0cnVjdCBpcnFfZGF0YSAqaXJxX2RhdGEsIGJvb2wgcmVzZXJ2ZSkNCj4gK3sNCj4gKwlzdHJ1
Y3QgaXJxX2NmZyAqY2ZnID0gaXJxZF9jZmcoaXJxX2RhdGEpOw0KPiArCXN0cnVjdCBJT19BUElD
X3JvdXRlX2VudHJ5ICplbnRyeSA9IGlycV9kYXRhLT5jaGlwX2RhdGE7DQo+ICsNCj4gKwllbnRy
eS0+ZGVzdCA9IGNmZy0+ZGVzdF9hcGljaWQ7DQo+ICsJZW50cnktPnZlY3RvciA9IGNmZy0+dmVj
dG9yOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgaXJx
X2RvbWFpbl9vcHMgaHlwZXJ2X2lyX2RvbWFpbl9vcHMgPSB7DQo+ICsJLmFsbG9jID0gaHlwZXJ2
X2lycV9yZW1hcHBpbmdfYWxsb2MsDQo+ICsJLmZyZWUgPSBoeXBlcnZfaXJxX3JlbWFwcGluZ19m
cmVlLA0KPiArCS5hY3RpdmF0ZSA9IGh5cGVydl9pcnFfcmVtYXBwbmdfYWN0aXZhdGUsDQo+ICt9
Ow0KPiArDQo+ICtzdGF0aWMgaW50IF9faW5pdCBoeXBlcnZfcHJlcGFyZV9pcnFfcmVtYXBwaW5n
KHZvaWQpDQo+ICt7DQo+ICsJc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZuOw0KPiArCXUzMiBhcGlj
X2lkOw0KPiArCWludCBpOw0KPiArDQo+ICsJaWYgKHg4Nl9oeXBlcl90eXBlICE9IFg4Nl9IWVBF
Ul9NU19IWVBFUlYgfHwNCg0KVGhlIGZ1bmN0aW9uIGh5cGVydmlzb3JfaXNfdHlwZSgpIGV4aXN0
cyBmb3IgZG9pbmcgdGhlIGFib3ZlIHRlc3QuDQpTZWUgaW5jbHVkZS9hc20vaHlwZXJ2aXNvci5o
DQoNCj4gKwkgICAgIXgyYXBpY19zdXBwb3J0ZWQoKSkNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+
ICsNCj4gKwlmbiA9IGlycV9kb21haW5fYWxsb2NfbmFtZWRfaWRfZndub2RlKCJIWVBFUlYtSVIi
LCAwKTsNCj4gKwlpZiAoIWZuKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCWlvYXBp
Y19pcl9kb21haW4gPQ0KPiArCQlpcnFfZG9tYWluX2NyZWF0ZV9oaWVyYXJjaHkoYXJjaF9nZXRf
aXJfcGFyZW50X2RvbWFpbigpLA0KPiArCQkJCTAsIElPQVBJQ19SRU1BUFBJTkdfRU5UUlksIGZu
LA0KPiArCQkJCSZoeXBlcnZfaXJfZG9tYWluX29wcywgTlVMTCk7DQo+ICsNCj4gKwlpcnFfZG9t
YWluX2ZyZWVfZndub2RlKGZuKTsNCj4gKw0KPiArCS8qDQo+ICsJICogSHlwZXItViBkb2Vzbid0
IHByb3ZpZGUgaXJxIHJlbWFwcGluZyBmdW5jdGlvbiBmb3INCj4gKwkgKiBJTy1BUElDIGFuZCBz
byBJTy1BUElDIG9ubHkgYWNjZXB0cyA4LWJpdCBBUElDIElELg0KPiArCSAqIENwdSdzIEFQSUMg
SUQgaXMgcmVhZCBmcm9tIEFDUEkgTUFEVCB0YWJsZSBhbmQgQVBJQyBJRHMNCj4gKwkgKiBpbiB0
aGUgTUFEVCB0YWJsZSBvbiBIeXBlci12IGFyZSBzb3J0ZWQgbW9ub3RvbmljIGluY3JlYXNpbmds
eS4NCj4gKwkgKiBBUElDIElEIHJlZmxlY3RzIGNwdSB0b3BvbG9neS4gVGhlcmUgbWF5YmUgc29t
ZSBBUElDIElEDQo+ICsJICogZ2FwcyB3aGVuIGNwdSBudW1iZXIgaW4gYSBzb2NrZXQgaXMgbm90
IHBvd2VyIG9mIHR3by4gUHJlcGFyZQ0KPiArCSAqIG1heCBjcHUgYWZmaW5pdHkgZm9yIElPQVBJ
QyBpcnFzLiBTY2FuIGNwdSAwLTI1NSBhbmQgc2V0IGNwdQ0KPiArCSAqIGludG8gaW9hcGljX21h
eF9jcHVtYXNrIGlmIGl0cyBBUElDIElEIGlzIGxlc3MgdGhhbiAyNTYuDQo+ICsJICovDQo+ICsJ
Zm9yIChpID0gMDsgaSA8IDI1NjsgaSsrKSB7DQo+ICsJCWFwaWNfaWQgPSBjcHVfcGh5c2ljYWxf
aWQoaSk7DQo+ICsJCWlmIChhcGljX2lkID4gMjU1KQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4g
KwkJY3B1bWFza19zZXRfY3B1KGksICZpb2FwaWNfbWF4X2NwdW1hc2spOw0KPiArCX0NCg0KVGhl
IGFib3ZlIGZvciBsb29wIHdvdWxkIGJlIG1vcmUgY29tcGFjdCBhczoNCg0KCWZvciAoaT0wOyBp
IDwyNTY7IGkrKykNCgkJaWYgKGNwdV9waHlzaWNhbF9pZChpKSAgPCAyNTYpDQoJCQljcHVtYXNr
X3NldF9jcHUoaSwgJmlvYXBpY19tYXhfY3B1bWFzayk7DQoNCj4gKw0KPiArCXJldHVybiAwOw0K
PiArfQ0KPiArDQo=
