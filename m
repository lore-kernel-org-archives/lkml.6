Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4E82170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MHQiHMsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4E82170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeHGMkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:40:45 -0400
Received: from mail-eopbgr680058.outbound.protection.outlook.com ([40.107.68.58]:51436
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbeHGMko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K91ytLYNVZca6R5TnP7wy9hovE4EQocEpINhs7OG3HA=;
 b=MHQiHMsgIxFBhLNekRMThPYl0g6lqCS77y48af/terBT+T6SBsLZ7kS+1HIRMfjGqaQErBEppUAzdU6iUFOtDjAATPi5xDEcOTkY3kQJHdorWOm/NWYQC72s6625xcjQ4JcQABK7avnQyqrGfAfbsBMybWpSvBP2ndMfE06DpdA=
Received: from DM5PR12MB1625.namprd12.prod.outlook.com (10.172.40.19) by
 DM5PR12MB1834.namprd12.prod.outlook.com (10.175.92.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Tue, 7 Aug 2018 10:27:03 +0000
Received: from DM5PR12MB1625.namprd12.prod.outlook.com
 ([fe80::780c:306f:5629:af5b]) by DM5PR12MB1625.namprd12.prod.outlook.com
 ([fe80::780c:306f:5629:af5b%6]) with mapi id 15.20.1017.019; Tue, 7 Aug 2018
 10:27:02 +0000
From:   "Russell, Kent" <Kent.Russell@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC:     Oded Gabbay <oded.gabbay@gmail.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Use true and false for boolean values
Thread-Topic: [PATCH] drm/amdkfd: Use true and false for boolean values
Thread-Index: AQHULWGXtBwK8QKpCUyXrMXSfNX1yKSzxCKAgABTU7A=
Date:   Tue, 7 Aug 2018 10:27:01 +0000
Message-ID: <DM5PR12MB16258B44772C699591CB7D8F85270@DM5PR12MB1625.namprd12.prod.outlook.com>
References: <20180805002702.GA26671@embeddedor.com>
 <20180807052818.GA913@hr-amur2>
In-Reply-To: <20180807052818.GA913@hr-amur2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:fea8:1d00:fdf::2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1834;20:XwGn7EeBb9zrDOHExHyJugfIO1ey7/XC1dj+x2PG2wlNWOeg4Vvv9QaelW+XMX5H8MqFUlr4pHcgTfA1K9ERGFt/EQJuYnNPDRWFwidMwGxrKiJ5VXCCnKj3QcZJxH/A9/hp36OMlFm2URtuerNDA3RzaXhhOvM2loMgwNxNzz4c0Ipf8ZGr0KVVjj59Z092DdxP6oWIjAi/U/caj/9eWOdiheU0lpDphCITq7VeVd1Y/zaXyet1pUoj8EBtVdyc
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(39860400002)(396003)(346002)(136003)(13464003)(189003)(199004)(68736007)(305945005)(7696005)(8936002)(2906002)(99286004)(55016002)(6246003)(81156014)(81166006)(8676002)(7736002)(6506007)(74316002)(6306002)(76176011)(53936002)(9686003)(102836004)(966005)(478600001)(86362001)(2900100001)(5250100002)(14454004)(72206003)(256004)(25786009)(6436002)(106356001)(6116002)(105586002)(476003)(11346002)(486006)(33656002)(39060400002)(4326008)(46003)(446003)(229853002)(6636002)(53546011)(110136005)(54906003)(97736004)(316002)(5660300001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1834;H:DM5PR12MB1625.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 12283330-7e05-47f9-a97a-08d5fc505084
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1834;
x-ms-traffictypediagnostic: DM5PR12MB1834:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB18345D14AF74F6876586780085270@DM5PR12MB1834.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(217544274631240);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1834;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1834;
x-forefront-prvs: 0757EEBDCA
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Xs3Ll3hPVH5/Q5pVm4NwQLfQiaYwnew3XQdtbOAFWPy8DTkoJCeWaq7KEfAh6vE0FVFLBAnOSJF3aTB7A+RQAGp/YDP2N91tYyIcB861KpD8+lPRlFMMfV42WnUzhRDDB1aAVKz0m5dKB5NzcoooKyntaApL0lISkr8NXgaNDkAsX9wQxVCfzP0H+DYmD8xzJdl+1XO8FpuklKea62UrIOyuWDs3APMcsxw/fI9WYxrcl2R/yUg5V3DfU51vcPprm3aaPL/Rjfn9KheFggOk+TNHZkpSAeVq5+xWPFPkgxg4/EOmmqt66AceWRoVX+ekAHa6piH48ZVBmSFk/v/M32/g13PebE3OVzFkTv2XWmU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12283330-7e05-47f9-a97a-08d5fc505084
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2018 10:27:01.9372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGF0IQ0KUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxs
QGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgSHVhbmcg
UnVpDQpTZW50OiBUdWVzZGF5LCBBdWd1c3QgMDcsIDIwMTggMToyOCBBTQ0KVG86IEd1c3Rhdm8g
QS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+OyBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpDYzogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWls
LmNvbT47IFpob3UsIERhdmlkKENodW5NaW5nKSA8RGF2aWQxLlpob3VAYW1kLmNvbT47IERhdmlk
IEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZGtmZDogVXNlIHRydWUgYW5kIGZhbHNlIGZvciBib29sZWFuIHZhbHVl
cw0KDQpPbiBTYXQsIEF1ZyAwNCwgMjAxOCBhdCAwNzoyNzowMlBNIC0wNTAwLCBHdXN0YXZvIEEu
IFIuIFNpbHZhIHdyb3RlOg0KPiBSZXR1cm4gc3RhdGVtZW50cyBpbiBmdW5jdGlvbnMgcmV0dXJu
aW5nIGJvb2wgc2hvdWxkIHVzZSB0cnVlIG9yIGZhbHNlIA0KPiBpbnN0ZWFkIG9mIGFuIGludGVn
ZXIgdmFsdWUuDQo+IA0KPiBUaGlzIGNvZGUgd2FzIGRldGVjdGVkIHdpdGggdGhlIGhlbHAgb2Yg
Q29jY2luZWxsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1
c3Rhdm9AZW1iZWRkZWRvci5jb20+DQoNCkxvb2tzIGdvb2QgZm9yIG1lLg0KUmV2aWV3ZWQtYnk6
IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQoNCkFkZCBGZWxpeCBmb3IgaGlzIGF3YXJl
bmVzcy4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2Npa19ldmVudF9p
bnRlcnJ1cHQuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9jaWtfZXZlbnRfaW50ZXJydXB0LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQvY2lrX2V2ZW50X2ludGVycnVwdC5jDQo+IGluZGV4IDVkMjQ3NWQuLjE2YWY5ZDEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2Npa19ldmVudF9pbnRlcnJ1cHQu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9jaWtfZXZlbnRfaW50ZXJydXB0
LmMNCj4gQEAgLTYyLDEyICs2MiwxMiBAQCBzdGF0aWMgYm9vbCBjaWtfZXZlbnRfaW50ZXJydXB0
X2lzcihzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiAgCXZtaWQgID0gKGlocmUtPnJpbmdfaWQgJiAw
eDAwMDBmZjAwKSA+PiA4Ow0KPiAgCWlmICh2bWlkIDwgZGV2LT52bV9pbmZvLmZpcnN0X3ZtaWRf
a2ZkIHx8DQo+ICAJICAgIHZtaWQgPiBkZXYtPnZtX2luZm8ubGFzdF92bWlkX2tmZCkNCj4gLQkJ
cmV0dXJuIDA7DQo+ICsJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAgCS8qIElmIHRoZXJlIGlzIG5v
IHZhbGlkIFBBU0lELCBpdCdzIGxpa2VseSBhIGZpcm13YXJlIGJ1ZyAqLw0KPiAgCXBhc2lkID0g
KGlocmUtPnJpbmdfaWQgJiAweGZmZmYwMDAwKSA+PiAxNjsNCj4gIAlpZiAoV0FSTl9PTkNFKHBh
c2lkID09IDAsICJGVyBidWc6IE5vIFBBU0lEIGluIEtGRCBpbnRlcnJ1cHQiKSkNCj4gLQkJcmV0
dXJuIDA7DQo+ICsJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAgCS8qIEludGVycnVwdCB0eXBlcyB3
ZSBjYXJlIGFib3V0OiB2YXJpb3VzIHNpZ25hbHMgYW5kIGZhdWx0cy4NCj4gIAkgKiBUaGV5IHdp
bGwgYmUgZm9yd2FyZGVkIHRvIGEgd29yayBxdWV1ZSAoc2VlIGJlbG93KS4NCj4gLS0NCj4gMi43
LjQNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1n
ZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo=
