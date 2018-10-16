Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B8C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39722087A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RaAeaHPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39722087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJQDFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:05:10 -0400
Received: from mail-eopbgr730092.outbound.protection.outlook.com ([40.107.73.92]:19134
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbeJQDFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMRgPtOWxhgHPqW+wEGrSU1hd/6lCW1U1c5wdDwfvRg=;
 b=RaAeaHPMsnS01M8QcFxs8oQ+Z5moyO4lhvbM3J1WpeWjJw6blrrZSV5fNEskA5yMlpCgwM/569xDNBASU9n2sDp8RRC7635dyHSK0seUp/aThs2KxHDfBARS7yMjLR7tWdG/psEJCRg0NEXcpS9mbCYd8O0/8QllkuJqWizkavU=
Received: from DM5PR2101MB1013.namprd21.prod.outlook.com (52.132.133.35) by
 DM5PR2101MB0807.namprd21.prod.outlook.com (10.167.110.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.3; Tue, 16 Oct 2018 19:13:12 +0000
Received: from DM5PR2101MB1013.namprd21.prod.outlook.com
 ([fe80::8415:b182:814c:9124]) by DM5PR2101MB1013.namprd21.prod.outlook.com
 ([fe80::8415:b182:814c:9124%3]) with mapi id 15.20.1273.004; Tue, 16 Oct 2018
 19:13:12 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Thread-Topic: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Thread-Index: AQHUZXPIE/St4iULVkCeltejmox0kaUiPMFw
Importance: high
X-Priority: 1
Date:   Tue, 16 Oct 2018 19:13:12 +0000
Message-ID: <DM5PR2101MB10138BCFD40D703FEE14EC35CAFE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170522.303317746@linuxfoundation.org>
In-Reply-To: <20181016170522.303317746@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-16T19:13:11.4656107Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;6:PND32cE6XFgfnRZRRgkGgJlWUSJ9nl9J61mNcoCbkdxM7QWdcVWtZrndjfLIf5j8mOSX+HZ+P5VwbleRamrcHBvX/DXOW/OJ5jKD4SnFQYD4scUz+t6kTDDS0+6xgTFNMZETV6PlbpKg7sMctjwDhMMeHhlZpLLmHbgAWCUx/LC7w7jtieyJUnYitQom2VkZ8G9LPFklP9SxSJVMN+pp6nQNFcR8OYPYKSnViyxQc+Bl7qJP7nq0g394jheKcFpMjzz3TyT2exMC8uSwG1cvf0xNIs1UgH4O44mdtIkmMm4OAbHcBmMPNZGtp1v4wDjepxzLvG/76XISgQ+cxacMIK6GBzsTt5aeNBpTBW4k0LI2iVdxoUAfylzTomvaTe/lcGQVw2ys4qEAIKRdSjW/VX8WLaiNDq1z5MHHHMqMLw5pf5n+GxW+14dWuO0Rld0O/BOq1PeNXhLtg5MnfFJmKA==;5:zWFPpJWc/mfEJtRt+R7PYjzoFnxekTxKyQeANIjiVUqm0uuhe8xX/0mctOhwOZbQ9aJJYMgvCtkZ2a3s+cHfKtCXW1e1tOGsVM8v50wjq295VCqRAOOZeK6XijrGDfFzh8BCe43Lk2q3fGLWmakFNDmwOcAa57gEW1HTIRPVUf0=;7:QdxxtClK8I07pBSNJNjtrv0L6ZA4VIYn1Keovhbe+c0xdKsR/BiVGz/yxHfW1HieqnQ/33/VTspHIrYEkPy4AmehE+leUSJPOTytvlhOOsYaQquoVB+ydFmcOAK84SkQSoMV3KN5y0Y1aA14ZUTxwA==
x-ms-office365-filtering-correlation-id: 310b66f8-fd8d-460f-06b0-08d6339b6b0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
x-microsoft-antispam-prvs: <DM5PR2101MB0807A3F18561C8549A354DDFCAFE0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(84791874153150)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991071);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(13464003)(40224003)(105586002)(256004)(229853002)(14454004)(7736002)(106356001)(71190400001)(71200400001)(54906003)(9686003)(11346002)(110136005)(966005)(6306002)(486006)(478600001)(476003)(446003)(2501003)(10290500003)(14444005)(97736004)(10090500001)(53936002)(68736007)(25786009)(107886003)(2906002)(186003)(4326008)(102836004)(26005)(6246003)(66066001)(6116002)(55016002)(86612001)(99286004)(33656002)(8676002)(6506007)(53546011)(74316002)(6436002)(5250100002)(7696005)(3846002)(575784001)(86362001)(6346003)(81166006)(5660300001)(2900100001)(8936002)(305945005)(8990500004)(22452003)(316002)(81686011)(81156014)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1013.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: F1cRulzqEPytzRz8ENK2qarlbQhYTEpvQNuwO3MvvXC6Ie/2r0NZ+uHLJsUi5qgneR6y8axG7MveEqx3fZjOlefZQijQhoItixUZiBFzSQbiOoZzViTmuqLOkjhb5yc1cB29BM45x/mt80N8MUPyeNNG+uuaESHqwnaz1db59st/bBuXBy/AooSgRFbHDWbaIlwTAclSNE73ecKuWVg8swsH1cdzC272ZurwG46WpFhhssLR+mW4aTl6k5c615DxrZU/slxr4BPRdz2bPHe6CetdqTxU/MRMxbkrLGUBXDBwl5xYN2UNInD/6Ppw4rEvU0CAAh4j9ieL7EBUxK9Ck4HG5ty6bNZBdGiW+K6nDiI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b66f8-fd8d-460f-06b0-08d6339b6b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 19:13:12.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gU2VudDogVHVlc2RheSwgT2N0
b2JlciAxNiwgMjAxOCAxOjA2IFBNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsN
Cj4gc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgU3RlcGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1p
Y3Jvc29mdC5jb20+Ow0KPiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBT
YXNoYSBMZXZpbg0KPiA8QWxleGFuZGVyLkxldmluQG1pY3Jvc29mdC5jb20+DQo+IFN1YmplY3Q6
IFtQQVRDSCA0LjE4IDEwMS8xMzVdIGh2X25ldHZzYzogcGFpciBWRiBiYXNlZCBvbiBzZXJpYWwg
bnVtYmVyDQo+IA0KPiA0LjE4LXN0YWJsZSByZXZpZXcgcGF0Y2guICBJZiBhbnlvbmUgaGFzIGFu
eSBvYmplY3Rpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0NCj4gDQo+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVy
Lm9yZz4NCj4gDQo+IFsgVXBzdHJlYW0gY29tbWl0IDAwZDdkZGJhMTE0MzYyM2IzMWJjMmMxNWQx
ODIxNmUyZGEwMzFiMTQgXQ0KPiANCj4gTWF0Y2hpbmcgbmV0d29yayBkZXZpY2UgYmFzZWQgb24g
TUFDIGFkZHJlc3MgaXMgcHJvYmxlbWF0aWMgc2luY2UgYSBub24gVkYNCj4gbmV0d29yayBkZXZp
Y2UgY2FuIGJlIGNyZXRlZCB3aXRoIGEgZHVwbGljYXRlIE1BQyBhZGRyZXNzIGNhdXNpbmcgY29u
ZnVzaW9uDQo+IGFuZCBwcm9ibGVtcy4gIFRoZSBWTUJ1cyBBUEkgZG9lcyBwcm92aWRlIGEgc2Vy
aWFsIG51bWJlciB0aGF0IGlzIGEgYmV0dGVyDQo+IG1hdGNoaW5nIG1ldGhvZC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+
IFNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjLmMgICAgIHwg
ICAgMyArKw0KPiAgZHJpdmVycy9uZXQvaHlwZXJ2L25ldHZzY19kcnYuYyB8ICAgNTggKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+IC0NCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMzYgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+IA0KPiAtLS0gYS9kcml2ZXJz
L25ldC9oeXBlcnYvbmV0dnNjLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvaHlwZXJ2L25ldHZzYy5j
DQo+IEBAIC0xMjAzLDYgKzEyMDMsOSBAQCBzdGF0aWMgdm9pZCBuZXR2c2Nfc2VuZF92ZihzdHJ1
Y3QgbmV0X2RlDQo+IA0KPiAgCW5ldF9kZXZpY2VfY3R4LT52Zl9hbGxvYyA9IG52bXNnLT5tc2cu
djRfbXNnLnZmX2Fzc29jLmFsbG9jYXRlZDsNCj4gIAluZXRfZGV2aWNlX2N0eC0+dmZfc2VyaWFs
ID0gbnZtc2ctPm1zZy52NF9tc2cudmZfYXNzb2Muc2VyaWFsOw0KPiArCW5ldGRldl9pbmZvKG5k
ZXYsICJWRiBzbG90ICV1ICVzXG4iLA0KPiArCQkgICAgbmV0X2RldmljZV9jdHgtPnZmX3Nlcmlh
bCwNCj4gKwkJICAgIG5ldF9kZXZpY2VfY3R4LT52Zl9hbGxvYyA/ICJhZGRlZCIgOiAicmVtb3Zl
ZCIpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyAgdm9pZCBuZXR2c2NfcmVjZWl2ZV9pbmJhbmQoc3Ry
dWN0IG5ldF9kZXZpY2UgKm5kZXYsDQo+IC0tLSBhL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2Nf
ZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvaHlwZXJ2L25ldHZzY19kcnYuYw0KPiBAQCAtMTc5
NCwyMCArMTc5NCw2IEBAIG91dF91bmxvY2s6DQo+ICAJcnRubF91bmxvY2soKTsNCj4gIH0NCj4g
DQo+IC1zdGF0aWMgc3RydWN0IG5ldF9kZXZpY2UgKmdldF9uZXR2c2NfYnltYWMoY29uc3QgdTgg
Km1hYykgLXsNCj4gLQlzdHJ1Y3QgbmV0X2RldmljZV9jb250ZXh0ICpuZGV2X2N0eDsNCj4gLQ0K
PiAtCWxpc3RfZm9yX2VhY2hfZW50cnkobmRldl9jdHgsICZuZXR2c2NfZGV2X2xpc3QsIGxpc3Qp
IHsNCj4gLQkJc3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IGh2X2dldF9kcnZkYXRhKG5kZXZfY3R4
LQ0KPiA+ZGV2aWNlX2N0eCk7DQo+IC0NCj4gLQkJaWYgKGV0aGVyX2FkZHJfZXF1YWwobWFjLCBk
ZXYtPnBlcm1fYWRkcikpDQo+IC0JCQlyZXR1cm4gZGV2Ow0KPiAtCX0NCj4gLQ0KPiAtCXJldHVy
biBOVUxMOw0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgc3RydWN0IG5ldF9kZXZpY2UgKmdldF9uZXR2
c2NfYnlyZWYoc3RydWN0IG5ldF9kZXZpY2UgKnZmX25ldGRldikgIHsNCj4gIAlzdHJ1Y3QgbmV0
X2RldmljZV9jb250ZXh0ICpuZXRfZGV2aWNlX2N0eDsgQEAgLTE5MzYsMjYgKzE5MjIsNDgNCj4g
QEAgc3RhdGljIHZvaWQgbmV0dnNjX3ZmX3NldHVwKHN0cnVjdCB3b3JrXw0KPiAgCXJ0bmxfdW5s
b2NrKCk7DQo+ICB9DQo+IA0KPiArLyogRmluZCBuZXR2c2MgYnkgVk1CdXMgc2VyaWFsIG51bWJl
ci4NCj4gKyAqIFRoZSBQQ0kgaHlwZXJ2IGNvbnRyb2xsZXIgcmVjb3JkcyB0aGUgc2VyaWFsIG51
bWJlciBhcyB0aGUgc2xvdC4NCj4gKyAqLw0KPiArc3RhdGljIHN0cnVjdCBuZXRfZGV2aWNlICpn
ZXRfbmV0dnNjX2J5c2xvdChjb25zdCBzdHJ1Y3QgbmV0X2RldmljZQ0KPiArKnZmX25ldGRldikg
ew0KPiArCXN0cnVjdCBkZXZpY2UgKnBhcmVudCA9IHZmX25ldGRldi0+ZGV2LnBhcmVudDsNCj4g
KwlzdHJ1Y3QgbmV0X2RldmljZV9jb250ZXh0ICpuZGV2X2N0eDsNCj4gKwlzdHJ1Y3QgcGNpX2Rl
diAqcGRldjsNCj4gKw0KPiArCWlmICghcGFyZW50IHx8ICFkZXZfaXNfcGNpKHBhcmVudCkpDQo+
ICsJCXJldHVybiBOVUxMOyAvKiBub3QgYSBQQ0kgZGV2aWNlICovDQo+ICsNCj4gKwlwZGV2ID0g
dG9fcGNpX2RldihwYXJlbnQpOw0KPiArCWlmICghcGRldi0+c2xvdCkgew0KPiArCQluZXRkZXZf
bm90aWNlKHZmX25ldGRldiwgIm5vIFBDSSBzbG90IGluZm9ybWF0aW9uXG4iKTsNCj4gKwkJcmV0
dXJuIE5VTEw7DQo+ICsJfQ0KPiArDQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShuZGV2X2N0eCwg
Jm5ldHZzY19kZXZfbGlzdCwgbGlzdCkgew0KPiArCQlpZiAoIW5kZXZfY3R4LT52Zl9hbGxvYykN
Cj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCWlmIChuZGV2X2N0eC0+dmZfc2VyaWFsID09IHBk
ZXYtPnNsb3QtPm51bWJlcikNCj4gKwkJCXJldHVybiBodl9nZXRfZHJ2ZGF0YShuZGV2X2N0eC0+
ZGV2aWNlX2N0eCk7DQoNCkdyZWcsDQoNCkkgaGFkIGEgZml4IHRvIHRoaXMgcGF0Y2guIElmIG5v
dCBhbHJlYWR5LCBDb3VsZCB5b3UgaW5jbHVkZSBteSBmb2xsb3dpbmcgZml4IHRvZ2V0aGVyPw0K
aHZfbmV0dnNjOiBmaXggdmYgc2VyaWFsIG1hdGNoaW5nIHdpdGggcGNpIHNsb3QgaW5mbw0KaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZGF2ZW0vbmV0LW5l
eHQuZ2l0L2NvbW1pdC8/aWQ9MDA1NDc5NTU2MTk3ZjgwMTM5NzcxOTYwZGRhMGRmZGNkMmQyYWFk
NQ0KDQpUaGFua3MsDQotIEhhaXlhbmcNCg0K
