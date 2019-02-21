Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76829C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3398220836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XaO3yZcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfBUQWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:22:45 -0500
Received: from mail-eopbgr790058.outbound.protection.outlook.com ([40.107.79.58]:21376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfBUQWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVp2hrojPNkQlMuC2sgFtFvIGWLeDlbooLrxVXSOcmM=;
 b=XaO3yZcLC5JSvsCFFi30lb1Hk2jEFGrbJQD9TAxXG3wHQMBhE1um8+I1/GZ8F35J3LqB9D7jX2LS/4K6vb5jbFdJhi7H/A51QH36twe95XVcxgSPd41yAsEJva0qV1rSBl17LHNYRwJ0TGr6HwxTbUs6WGoX7da+m3IqcGd44QY=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB2488.namprd12.prod.outlook.com (52.132.141.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 16:22:41 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3165:79a0:3e5c:b8fe]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::3165:79a0:3e5c:b8fe%8]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 16:22:41 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>
CC:     "Hook, Gary" <Gary.Hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu: Fix IOMMU debugfs fallout
Thread-Topic: [PATCH] iommu: Fix IOMMU debugfs fallout
Thread-Index: AQHUyRzx8yPqiuUY20aGWfMKX8rpMqXqcRgA
Date:   Thu, 21 Feb 2019 16:22:41 +0000
Message-ID: <107726bd-fad4-7d76-e1b5-6d5ecfeb6a3e@amd.com>
References: <20190220130505.1188-1-geert+renesas@glider.be>
In-Reply-To: <20190220130505.1188-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0052.prod.exchangelabs.com (2603:10b6:800::20) To
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0be053ea-087d-487a-1a7f-08d69818cd14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2488;
x-ms-traffictypediagnostic: DM5PR12MB2488:
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2488;20:BSkAOYeri8iDK9FbzOudscPd8heRMi7694ph/7gJMXg2kHoYB5YuKMTey37x395HjdPWy36C/eTtOcSFXZboI6UwTiEr5xOY2KxXl79OffLjISnhkG+aZ7wqwilBgT18flkKJ7kOqwau8mC8JbjAaD+5QnrUTVMmcuJ8ICEahJFkPsc0U6cwcGW9payY/FnBnZnJ5Ial9YAakeg5RvwZ4FQb69NotDdJ3SZMkG+UO8irPYs7AVsqMqhgKSuPaamE
x-microsoft-antispam-prvs: <DM5PR12MB2488B4B781BE31108DDF8739FD7E0@DM5PR12MB2488.namprd12.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(386003)(6512007)(53546011)(26005)(31696002)(99286004)(81166006)(81156014)(8936002)(6506007)(68736007)(6116002)(3846002)(11346002)(8676002)(53936002)(110136005)(186003)(54906003)(4326008)(476003)(5660300002)(97736004)(478600001)(71200400001)(316002)(2616005)(446003)(6246003)(71190400001)(6436002)(31686004)(106356001)(486006)(25786009)(256004)(14444005)(102836004)(72206003)(7736002)(66066001)(76176011)(2906002)(6486002)(229853002)(52116002)(36756003)(14454004)(305945005)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2488;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xgFJxCXqjqPmaYvTkpqRhy3A1z8yWI8GFiG0/phKEXGc48N0Wyked9QowkJTQZHKVM47vOKBvBKvB+bL5bfbqhKg6sMGEO64P49gYG7fcxmNxrzVA1DJdR2yx7gPXOWL2B2I5LOes3YifDxtKtD+8EuUoeuJfIWNMKg2zjEIkrdwNb0X3vHjin3RjQfdvlf9vy8cL/lN10UXLGs6OOej4PRmybtMHfmgMbRgIxUwDRqczHgIboLII46cOuEf36Ac4Sfq1Pm8Z7ckUjKCT+EsY8gLG63XdjTE75hfC7rOhL/ks3Ac8Hcbl1sQp2ZlMi+peupqhXsy/Gx/o96lDbKKXIFHXRT/hZVmzMrVEMrOhEw5yld0SmBQJC8X2J0chzAAJxSl4fIPbMZnirc4nSo8BG8dt8j7lAWUYaG1brFfEC4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <379F3A945D4C85419D119241B192D2A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be053ea-087d-487a-1a7f-08d69818cd14
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 16:22:40.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMC8xOSA3OjA1IEFNLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+IEEgY2hhbmdl
IG1hZGUgaW4gdGhlIGZpbmFsIHZlcnNpb24gb2YgSU9NTVUgZGVidWdmcyBzdXBwb3J0IHJlcGxh
Y2VkIHRoZQ0KPiBwdWJsaWMgZnVuY3Rpb24gaW9tbXVfZGVidWdmc19uZXdfZHJpdmVyX2Rpcigp
IGJ5IHRoZSBwdWJsaWMgZGVudHJ5DQo+IGlvbW11X2RlYnVnZnNfZGlyIGluIDxsaW51eC9pb21t
dS5oPiwgYnV0IGZvcmdvdCB0byB1cGRhdGUgYm90aCB0aGUNCj4gaW1wbGVtZW50YXRpb24gaW4g
aW9tbXUtZGVidWdmcy5jLCBhbmQgdGhlIHBhdGNoIGRlc2NyaXB0aW9uLg0KPiANCj4gRml4IHRo
aXMgYnkgZXhwb3J0aW5nIGlvbW11X2RlYnVnZnNfZGlyLCBhbmQgcmVtb3ZpbmcgdGhlIHJlZmVy
ZW5jZSB0bw0KPiBhbmQgaW1wbGVtZW50YXRpb24gb2YgaW9tbXVfZGVidWdmc19uZXdfZHJpdmVy
X2RpcigpLg0KPiANCj4gRml4ZXM6IGJhZDYxNGIyNDI5M2FlNDYgKCJpb21tdTogRW5hYmxlIGRl
YnVnZnMgZXhwb3N1cmUgb2YgSU9NTVUgZHJpdmVyIGludGVybmFscyIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQoNCkFja2Vk
LWJ5OiBHYXJ5IFIgSG9vayA8Z2FyeS5ob29rQGFtZC5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVy
cy9pb21tdS9pb21tdS1kZWJ1Z2ZzLmMgfCAyMyArKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUtZGVidWdmcy5jIGIvZHJpdmVycy9pb21t
dS9pb21tdS1kZWJ1Z2ZzLmMNCj4gaW5kZXggM2IxYmY4OGZkMWIwNDk0YS4uZjAzNTQ4OTQyMDk2
NDhmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS1kZWJ1Z2ZzLmMNCj4gKysr
IGIvZHJpdmVycy9pb21tdS9pb21tdS1kZWJ1Z2ZzLmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4g
ICAjaW5jbHVkZSA8bGludXgvZGVidWdmcy5oPg0KPiAgIA0KPiAgIHN0cnVjdCBkZW50cnkgKmlv
bW11X2RlYnVnZnNfZGlyOw0KPiArRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZGVidWdmc19kaXIp
Ow0KPiAgIA0KPiAgIC8qKg0KPiAgICAqIGlvbW11X2RlYnVnZnNfc2V0dXAgLSBjcmVhdGUgdGhl
IHRvcC1sZXZlbCBpb21tdSBkaXJlY3RvcnkgaW4gZGVidWdmcw0KPiBAQCAtMjMsOSArMjQsOSBA
QCBzdHJ1Y3QgZGVudHJ5ICppb21tdV9kZWJ1Z2ZzX2RpcjsNCj4gICAgKiBFbWl0IGEgc3Ryb25n
IHdhcm5pbmcgYXQgYm9vdCB0aW1lIHRvIGluZGljYXRlIHRoYXQgdGhpcyBmZWF0dXJlIGlzDQo+
ICAgICogZW5hYmxlZC4NCj4gICAgKg0KPiAtICogVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgZnJv
bSBpb21tdV9pbml0OyBkcml2ZXJzIG1heSB0aGVuIGNhbGwNCj4gLSAqIGlvbW11X2RlYnVnZnNf
bmV3X2RyaXZlcl9kaXIoKSB0byBpbnN0YW50aWF0ZSBhIHZlbmRvci1zcGVjaWZpYw0KPiAtICog
ZGlyZWN0b3J5IHRvIGJlIHVzZWQgdG8gZXhwb3NlIGludGVybmFsIGRhdGEuDQo+ICsgKiBUaGlz
IGZ1bmN0aW9uIGlzIGNhbGxlZCBmcm9tIGlvbW11X2luaXQ7IGRyaXZlcnMgbWF5IHRoZW4gdXNl
DQo+ICsgKiBpb21tdV9kZWJ1Z2ZzX2RpciB0byBpbnN0YW50aWF0ZSBhIHZlbmRvci1zcGVjaWZp
YyBkaXJlY3RvcnkgdG8gYmUgdXNlZA0KPiArICogdG8gZXhwb3NlIGludGVybmFsIGRhdGEuDQo+
ICAgICovDQo+ICAgdm9pZCBpb21tdV9kZWJ1Z2ZzX3NldHVwKHZvaWQpDQo+ICAgew0KPiBAQCAt
NDgsMTkgKzQ5LDMgQEAgdm9pZCBpb21tdV9kZWJ1Z2ZzX3NldHVwKHZvaWQpDQo+ICAgCQlwcl93
YXJuKCIqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqXG4iKTsNCj4gICAJfQ0KPiAgIH0NCj4gLQ0KPiAtLyoqDQo+IC0gKiBpb21tdV9k
ZWJ1Z2ZzX25ld19kcml2ZXJfZGlyIC0gY3JlYXRlIGEgdmVuZG9yIGRpcmVjdG9yeSB1bmRlciBk
ZWJ1Z2ZzL2lvbW11DQo+IC0gKiBAdmVuZG9yOiBuYW1lIG9mIHRoZSB2ZW5kb3Itc3BlY2lmaWMg
c3ViZGlyZWN0b3J5IHRvIGNyZWF0ZQ0KPiAtICoNCj4gLSAqIFRoaXMgZnVuY3Rpb24gaXMgY2Fs
bGVkIGJ5IGFuIElPTU1VIGRyaXZlciB0byBjcmVhdGUgdGhlIHRvcC1sZXZlbCBkZWJ1Z2ZzDQo+
IC0gKiBkaXJlY3RvcnkgZm9yIHRoYXQgZHJpdmVyLg0KPiAtICoNCj4gLSAqIFJldHVybjogdXBv
biBzdWNjZXNzLCBhIHBvaW50ZXIgdG8gdGhlIGRlbnRyeSBmb3IgdGhlIG5ldyBkaXJlY3Rvcnku
DQo+IC0gKiAgICAgICAgIE5VTEwgaW4gY2FzZSBvZiBmYWlsdXJlLg0KPiAtICovDQo+IC1zdHJ1
Y3QgZGVudHJ5ICppb21tdV9kZWJ1Z2ZzX25ld19kcml2ZXJfZGlyKGNvbnN0IGNoYXIgKnZlbmRv
cikNCj4gLXsNCj4gLQlyZXR1cm4gZGVidWdmc19jcmVhdGVfZGlyKHZlbmRvciwgaW9tbXVfZGVi
dWdmc19kaXIpOw0KPiAtfQ0KPiAtRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZGVidWdmc19uZXdf
ZHJpdmVyX2Rpcik7DQo+IA0KDQo=
