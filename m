Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D7CC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF1520657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AW8xhjDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF1520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKCIXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:23:25 -0400
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:10320
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbeKCIXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP72CBqlHVSdg4E2/mRo6QsFfqVqPpBrlh9677KqZMM=;
 b=AW8xhjDq/ti4fRzhWteBlW1CijgOJgPQXrh7RoPtmwolOI5e60pHcqAL9hpCkgXPOPstLXP+qyIHh0yjWVcjrPbz/qjCM/6Qtn0rY6PC2tz702BFEKJNoM7a00I6wtTlbM49lqIPsqnacEMFqWXVAb0W4Ut8mNiF+4clwOHmNYU=
Received: from DM5PR12MB1707.namprd12.prod.outlook.com (10.175.89.136) by
 DM5PR12MB1244.namprd12.prod.outlook.com (10.168.237.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Fri, 2 Nov 2018 23:14:13 +0000
Received: from DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::74d5:db9a:60e2:2f7f]) by DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::74d5:db9a:60e2:2f7f%9]) with mapi id 15.20.1273.027; Fri, 2 Nov 2018
 23:14:13 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "Cornwall, Jay" <Jay.Cornwall@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv@altlinux.org" <ldv@altlinux.org>
Subject: Re: [PATCH 2/2] uapi: fix more linux/kfd_ioctl.h userspace
 compilation errors
Thread-Topic: [PATCH 2/2] uapi: fix more linux/kfd_ioctl.h userspace
 compilation errors
Thread-Index: AQHUcdKH3RbXdVfvdE6Zi3ZeFneXLKU9H+GA
Date:   Fri, 2 Nov 2018 23:14:13 +0000
Message-ID: <653fdf2e-cecb-2016-c934-607672ec22a5@amd.com>
References: <20181101110328.GB20538@altlinux.org>
In-Reply-To: <20181101110328.GB20538@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::24) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1244;20:na+MfUX6+OGIaXO+TDUcBo85oqADHfujzNCD3a8HhvV753YYoYFGooi+BK/gRBp2aMvt1Zua5HZRh82NNPjcH/nOlQ1CL9WkcwTZj5B2E0/mI1xSG8BlUThD12C/jsFpzz33S96k9KuEM6F0CHkGK79nMQEMWOriUk8PQXGp7bKjgC3mSGSf1ovBzVy7gWmCCrG4UQp+FS/AICF1tdRxjhLjQNHMSNdl2qEHSwkaNdB6rsyI0x8w+65DZt2ShXcl
x-ms-office365-filtering-correlation-id: 405dfce8-4355-4432-ba03-08d64118e719
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1244;
x-ms-traffictypediagnostic: DM5PR12MB1244:
x-microsoft-antispam-prvs: <DM5PR12MB1244A6C0BE96A8F140D31F2192CF0@DM5PR12MB1244.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1244;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1244;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(86362001)(256004)(2501003)(65806001)(66066001)(345774005)(65956001)(97736004)(186003)(486006)(2616005)(476003)(11346002)(105586002)(31686004)(106356001)(7736002)(2906002)(305945005)(36756003)(2900100001)(6486002)(446003)(3846002)(6116002)(6436002)(64126003)(5660300001)(53936002)(6512007)(478600001)(68736007)(71190400001)(71200400001)(102836004)(52116002)(76176011)(26005)(58126008)(110136005)(316002)(6506007)(81156014)(6246003)(8676002)(81166006)(229853002)(99286004)(39060400002)(65826007)(72206003)(25786009)(31696002)(53546011)(386003)(14454004)(2201001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1244;H:DM5PR12MB1707.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oSZo0uEXgAJYVq0uk4xmZ5PBJqFmlku215sV659A4CCUg6wmVtJCLZ1lRWFBsM2ydidtm47RFspSseatbpmd0aJ0jkorspPq/eDD8DpYZu7lflpNF6F5oJYjKrE46TOCCk8pBjZ1qjgFTlagXvCBw5UsEQz0/dIbUUm823Ctcn78QidkhhQ+62P7PxIjlqoKcKqNcdkYiqxyshi4Y9Ybio9olTqRK6ywJD6pvgAjIyQIhi6cRQHkv/obDHxpJdbCCBIEmQulB0AOuUX/I6iVxkVohJGxZx1C2TIzS+sRN9ELG9Bp6jG6aIafQVUFsqd9e4tDV9ACrKi3D7mlaXa4DJguitK0CvcVMpPHQLEGAr0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8309910E2A79224DACE4AEE121B8CBFD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405dfce8-4355-4432-ba03-08d64118e719
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 23:14:13.6761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0wMSA3OjAzIGEubS4sIERtaXRyeSBWLiBMZXZpbiB3cm90ZToNCj4gQ29uc2lz
dGVudGx5IHVzZSB0eXBlcyBwcm92aWRlZCBieSA8bGludXgvdHlwZXMuaD4gdmlhIDxkcm0vZHJt
Lmg+DQo+IHRvIGZpeCBzdHJ1Y3Qga2ZkX2lvY3RsX2dldF9xdWV1ZV93YXZlX3N0YXRlX2FyZ3Mg
dXNlcnNwYWNlIGNvbXBpbGF0aW9uIGVycm9ycy4NCj4NCj4gRml4ZXM6IDVkZjA5OWU4YmM4M2Yg
KCJkcm0vYW1ka2ZkOiBBZGQgd2F2ZWZyb250IGNvbnRleHQgc2F2ZSBzdGF0ZSByZXRyaWV2YWwg
aW9jdGwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgVi4gTGV2aW4gPGxkdkBhbHRsaW51eC5v
cmc+DQoNClRoYW5rIHlvdSBmb3IgY2F0Y2hpbmcgdGhpcywgYW5kIHNvcnJ5IGZvciBtZXNzaW5n
IGl0IHVwIGluY3JlbWVudGFsbHkuDQpPdXIgaW50ZXJuYWwgYnJhbmNoIGlzIGFscmVhZHkgZml4
ZWQsIGJ1dCBJIG11c3QgaGF2ZSBtaXNzZWQgdGhpcyB3aGVuIEkNCmNoZXJyeS1waWNrZWQgb2xk
ZXIgcGF0Y2hlcy4NCg0KVGhlIHNlcmllcyBpcyBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQoNCkkgYWxzbyBhcHBsaWVkIGl0IHRvIG91ciBhbWQt
c3RhZ2luZy1kcm0tbmV4dCBicmFuY2guDQoNClJlZ2FyZHMsDQrCoCBGZWxpeA0KDQoNCj4gLS0t
DQo+ICBpbmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmggfCAxMCArKysrKy0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oIGIvaW5jbHVkZS91YXBpL2xp
bnV4L2tmZF9pb2N0bC5oDQo+IGluZGV4IGRhZTg5N2YzOGU1OS4uYjAxZWI1MDJkNDljIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmgNCj4gKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oDQo+IEBAIC04MywxMSArODMsMTEgQEAgc3RydWN0IGtm
ZF9pb2N0bF9zZXRfY3VfbWFza19hcmdzIHsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBrZmRfaW9j
dGxfZ2V0X3F1ZXVlX3dhdmVfc3RhdGVfYXJncyB7DQo+IC0JdWludDY0X3QgY3RsX3N0YWNrX2Fk
ZHJlc3M7CS8qIHRvIEtGRCAqLw0KPiAtCXVpbnQzMl90IGN0bF9zdGFja191c2VkX3NpemU7CS8q
IGZyb20gS0ZEICovDQo+IC0JdWludDMyX3Qgc2F2ZV9hcmVhX3VzZWRfc2l6ZTsJLyogZnJvbSBL
RkQgKi8NCj4gLQl1aW50MzJfdCBxdWV1ZV9pZDsJCS8qIHRvIEtGRCAqLw0KPiAtCXVpbnQzMl90
IHBhZDsNCj4gKwlfX3U2NCBjdGxfc3RhY2tfYWRkcmVzczsJLyogdG8gS0ZEICovDQo+ICsJX191
MzIgY3RsX3N0YWNrX3VzZWRfc2l6ZTsJLyogZnJvbSBLRkQgKi8NCj4gKwlfX3UzMiBzYXZlX2Fy
ZWFfdXNlZF9zaXplOwkvKiBmcm9tIEtGRCAqLw0KPiArCV9fdTMyIHF1ZXVlX2lkOwkJCS8qIHRv
IEtGRCAqLw0KPiArCV9fdTMyIHBhZDsNCj4gIH07DQo+ICANCj4gIC8qIEZvciBrZmRfaW9jdGxf
c2V0X21lbW9yeV9wb2xpY3lfYXJncy5kZWZhdWx0X3BvbGljeSBhbmQgYWx0ZXJuYXRlX3BvbGlj
eSAqLw0K
