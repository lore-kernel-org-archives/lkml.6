Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975352083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="IIbf74dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBEH70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:59:26 -0500
Received: from mail-eopbgr810044.outbound.protection.outlook.com ([40.107.81.44]:28704
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfBEH7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLH4MLJcMxRD5cEO1bnn6xtGYw+GXb/CTZUHOmDR1aA=;
 b=IIbf74dRCMqoFsIrtNdMj3D2wWZUNw7X39ny5VGlb7oAErZkDPb1cE80VckCx/Jyf0QFEWfayB+/HwBCZwRwsCktBVPUju3voTXx2mOnOsFNO478elcVnaNKWWDwLSlbA2RogoSxR2XOikpG/Bo/q5DEqbTgo44+rnPBV8BoY7Y=
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (20.177.186.153) by
 BYAPR05MB6632.namprd05.prod.outlook.com (20.179.60.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.14; Tue, 5 Feb 2019 07:59:23 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::112f:787b:1a2c:cd65]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::112f:787b:1a2c:cd65%4]) with mapi id 15.20.1601.016; Tue, 5 Feb 2019
 07:59:23 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs v2
Thread-Topic: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs v2
Thread-Index: AQHUvGJfIbvzwr9QgEOT4YLGTMEkcqXPjMcAgAFL2gA=
Date:   Tue, 5 Feb 2019 07:59:22 +0000
Message-ID: <d67d5aef5059c26a281c7ab00131d6ca202ab5ee.camel@vmware.com>
References: <20190125081215.4622-1-thellstrom@vmware.com>
         <20190125081215.4622-3-thellstrom@vmware.com>
         <20190204081932.GB5730@lst.de>
         <1f22fa519670f7caa3c2f4f48d7cb6daf79d6eb0.camel@vmware.com>
In-Reply-To: <1f22fa519670f7caa3c2f4f48d7cb6daf79d6eb0.camel@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6632;20:EGWmG5EZNsGgvLzE53yJivM3lwgl4o1FsTTWFrQ5hD89L0tH5SRJ/AFAi6aJNFnTygB8BeHelbcHZbVYZ3AIHoyu3tm1Sc/yXTmf+JPcJT/p9vnRSgbRVq2uzyzmd2WYbsFMb52bvnkWE6nVrCHEPRvbhNlhMmjZzz+ZePhGGe4=
x-ms-office365-filtering-correlation-id: e1616441-027b-42d4-3c90-08d68b3fd755
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6632;
x-ms-traffictypediagnostic: BYAPR05MB6632:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB66326EEBE2DB5C288B04CDCCA16E0@BYAPR05MB6632.namprd05.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(476003)(66066001)(4326008)(76176011)(486006)(11346002)(2616005)(93886005)(256004)(446003)(97736004)(316002)(99286004)(25786009)(5640700003)(6512007)(6436002)(6486002)(8676002)(1730700003)(81156014)(81166006)(8936002)(229853002)(7736002)(305945005)(118296001)(6916009)(3846002)(6116002)(6506007)(53936002)(6246003)(26005)(102836004)(186003)(2351001)(106356001)(105586002)(2501003)(68736007)(478600001)(14454004)(86362001)(71200400001)(71190400001)(36756003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6632;H:BYAPR05MB5592.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: taAyd069TSfnzHJ98iNar91kCiTeIJc/sCHJKE3+43Dvk1cAAW+qdAtkqCb/Fb/2nGmrlcM0HGhxrCzGDn4Gky90fAzPiOPHrS3j4mmfFXHbTftdJrWMuyCv1XEemTmgoJitoSdVAUTlIlognLw5kY17sS6X2oqzR0vYpYdp+2uIEpJxxQUNlRiY5ZW6Sm9jG7Ox7dktpb7WjaY1+JvMlWkbMIV8eYvZH1ldvW+wKpO6aqaMbEjkAtxRkvwL7SMOZZqxhTgDcOKHVTQXtNSt4PrJrEaOB1TXjesPWjAvBgbyGcFitLohCjDInK7oq2EPKco4vqkLn1WtARA983kSJ6j17bg0XIyVzkw2z1KOJIOxlTKnid3ytvW0XYbldpgasqyqkuBnMT0A7mTKVZEuGFgwvDpgq4gGjI7COzF07n0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B27038C2CBA5514BBF5F43CF288AF753@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1616441-027b-42d4-3c90-08d68b3fd755
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 07:59:22.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTA0IGF0IDEzOjExICswMTAwLCBUaG9tYXMgSGVsbHN0csO2bSB3cm90
ZToNCj4gT24gTW9uLCAyMDE5LTAyLTA0IGF0IDA5OjE5ICswMTAwLCBDaHJpc3RvcGggSGVsbHdp
ZyB3cm90ZToNCj4gPiBPbiBGcmksIEphbiAyNSwgMjAxOSBhdCAwOToxMjoxM0FNICswMTAwLCBU
aG9tYXMgSGVsbHN0cm9tIHdyb3RlOg0KPiA+ID4gLSNpZiAhZGVmaW5lZChDT05GSUdfU1dJT1RM
QikgJiYgIWRlZmluZWQoQ09ORklHX0lOVEVMX0lPTU1VKQ0KPiA+ID4gLQkvKg0KPiA+ID4gLQkg
KiBObyBjb2hlcmVudCBwYWdlIHBvb2wNCj4gPiA+IC0JICovDQo+ID4gPiAtCWlmIChkZXZfcHJp
di0+bWFwX21vZGUgPT0gdm13X2RtYV9hbGxvY19jb2hlcmVudCkNCj4gPiA+ICsJLyogTm8gVFRN
IGNvaGVyZW50IHBhZ2UgcG9vbD8gRklYTUU6IEFzayBUVE0gaW5zdGVhZCEgKi8NCj4gPiA+ICsJ
aWYgKCEoSVNfRU5BQkxFRChDT05GSUdfU1dJT1RMQikgfHwNCj4gPiA+IElTX0VOQUJMRUQoQ09O
RklHX0lOVEVMX0lPTU1VKSkgJiYNCj4gPiA+ICsJICAgIChkZXZfcHJpdi0+bWFwX21vZGUgPT0g
dm13X2RtYV9hbGxvY19jb2hlcmVudCkpDQo+ID4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+
IC0jZW5kaWYNCj4gPiA+ICsNCj4gPiANCj4gPiBJIGRvbid0IHRoaW5rIHRoaXMgZWRpdGVkIGlu
IGNoYW5nZSBtYWtlcyBhbnkgc2Vuc2UuICBUaGUgc3dpb3RsYg0KPiA+IHZzDQo+ID4gZG1hLWRp
cmVjdCB2ZXJzaW9ucyBvZiBkbWFfYWxsb2NfY29oZXJlbnQgYXJlIHRoZSBzYW1lLCBzbyB0aGlz
DQo+ID4gY2hlY2sNCj4gPiBzZWVtcyB2ZXJ5IG9ic2Z1Y2F0aW5nLg0KPiANCj4gU28gdGhpcyBw
YXJ0IG9mIGNvZGUgaXMgaWRlbnRpY2FsIGluIGZ1bmN0aW9uYWxpdHkgdG8gdGhlIHByZXZpb3Vz
DQo+IHZlcnNpb24uIEl0IGNoZWNrcyB3aGV0aGVyIHRoZSBUVE0gbW9kdWxlIGhhcyB0aGUgY29o
ZXJlbnQgcGFnZSBwb29sDQo+IGVuYWJsZWQuIChhbiBpZGVudGljYWwgdGVzdCBpcyBwcmVzZW50
IGluIFRUTSkuIFdoYXQgd2UgKnJlYWxseSogbmVlZA0KPiB0byBkbyBoZXJlIGluc3RlYWQgaXMg
dG8gYXNrIFRUTSB3aGV0aGVyIGl0IGhhcyBlbmFibGVkIGl0cyBjb2hlcmVudA0KPiBwYWdlIHBv
b2wgaW5zdGVhZCBvZiB0cnlpbmcgdG8gbWltaWMgVFRNJ3MgdGVzdCwgYW5kIEkgaGF2ZSBhDQo+
IGNoYW5nZXNldA0KPiB1bmRlciByZXZpZXcgZm9yIHRoYXQuIEJ1dCBhcyBtZW50aW9uZWQgcHJl
dmlvdXNseSwgSSBkb24ndCB3YW50IHRvDQo+IGNoYW5nZSB0aGUgVFRNIGludGVyZmFjZSBvdXRz
aWRlIG9mIGEgbWVyZ2Ugd2luZG93LCBzbyB3ZSBlaXRoZXIgaGF2ZQ0KPiB0byBsaXZlIHdpdGgg
dGhlIGFib3ZlIGZvciA1LjAgb3Iga2VlcCB0aGUgb2xkIGRlZmluZXMuIEknZCBwcmVmZXINCj4g
dGhlDQo+IGZvcm1lciBzbyBJIGRvbid0IGhhdmUgdG8gcmVzcGluIHRoZSBwYXRjaCBzZXJpZXMg
b25jZSBtb3JlLg0KPiANCj4gVGhhbmtzLA0KPiBUaG9hbXMNCj4gDQoNCkhpLCBDaHJpc3RvcGgs
DQoNCkkgbmVlZCB0byBnZXQgdGhpcyBtZXJnZWQgdGhpcyB3ZWVrLiBDb3VsZCB5b3UgcGxlYXNl
IGFjayBvciBhY2sNCnJlbW92aW5nIHRoaXMgaHVuayArIHVwZGF0aW5nIHRoZSBmb2xsb3dpbmcg
cGF0Y2hlcyBmb3IgbWVyZ2UgZXJyb3JzPw0KDQpJZiBubyByZXNwb25zZSwgSSdsbCBhZGQgYSBD
YzogdGFnIG9uIHRoZSBwYXRjaCBhbmQgYSAjdjEgdG8geW91ciBzLW8tDQpiLg0KDQpUaGFua3Ms
DQpUaG9tYXMNCg0KDQo=
