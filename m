Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D04C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A06C2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i1uCX46F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfBDPOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:14:31 -0500
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:7850
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729819AbfBDPOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laPCYG8SmjAxZNSwpg3HeDGGPgOzwkxd5GA4+bkJGGA=;
 b=i1uCX46Fi8lpOf2/slA/YA9wOL/D4VXJuzJnR6tMCvkl8/z0Oo6997R+Am/sRYW/T9uYfkJpGE1NozFOhbxKnSLnJZTo7WSMJdgeLYZYDOtwQqf/nDL6GtJPkmjmb+C70gLCOfQhE1u+SE2pC0BtAUWw1roTgGjMWg54fZch7xI=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2740.namprd12.prod.outlook.com (20.176.178.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 15:14:28 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 15:14:28 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 5/5] EDAC, mce_amd: Print ExtErrorCode and description on
 a single line
Thread-Topic: [PATCH 5/5] EDAC, mce_amd: Print ExtErrorCode and description on
 a single line
Thread-Index: AQHUuoFJQ5YnKMTJLEmBDjZXcu8IOqXOARoAgAHBdEA=
Date:   Mon, 4 Feb 2019 15:14:27 +0000
Message-ID: <BN7PR12MB2593CF4ABBC4ECFCDE87FC7AF86D0@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
 <20190201225534.8177-6-Yazen.Ghannam@amd.com>
 <20190203122158.GA21750@zn.tnic>
In-Reply-To: <20190203122158.GA21750@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2740;20:U++zxsHJgFCKW7INf98CaGTHY4n7t51OEqUD1BSxr7t9iPPRzH5e62Wk7UVaSDDI84VEbZtj9irxn5FqmFPac5h6zm4MO39mtNaKa7bUiMzpEvfNac7PD+wlmxtqbdwvcLnzReRZpFsuymR0/vbU78hpzhL28//rlKhXraB7ivp2YUWg7WVvqh0COAqsvSerj02pz2lKAGav1QsmECUtgQgBe52TgaeEs69OU0smhB0bSzqC3y01cZy8Z4++V6F0
x-ms-office365-filtering-correlation-id: b1d790b5-5403-4de7-39d9-08d68ab374d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2740;
x-ms-traffictypediagnostic: BN7PR12MB2740:
x-microsoft-antispam-prvs: <BN7PR12MB2740B4B980E4217E67F4AE5FF86D0@BN7PR12MB2740.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(13464003)(189003)(199004)(6246003)(446003)(4326008)(11346002)(106356001)(8936002)(7736002)(476003)(305945005)(54906003)(74316002)(53936002)(316002)(71200400001)(71190400001)(25786009)(6916009)(55016002)(9686003)(6436002)(14454004)(8676002)(2906002)(486006)(229853002)(81166006)(6506007)(53546011)(68736007)(26005)(186003)(81156014)(72206003)(86362001)(33656002)(256004)(102836004)(3846002)(6116002)(105586002)(97736004)(7696005)(76176011)(66066001)(478600001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2740;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0KRqJSMYY4EzIglwGZf53StXdrdE8QEh2UUfcYEFEOp3MWYCNKtxl1lfkekcvH9nRId0taJPIFcK4AeADepaHJDQglxbJDE0A+AWEgtOLtkVoWKFMdjktE3HBjsxLm5uFVa5rjJWbFzLidtG9DJBucjnOtDIiNnEEZRG2v8Zf1q0azinupUhRcKjPYQ1r8EUXRQ8wEYUX26jDKwK8Zo6mzwueWfNTRvh1Y7dpiDuoxN/Y1q7ECfhul1VSTdHGuPCJXZwHGouozQtGJrpEncTj50xrnPAIPlXi6AArrETL5oSyuTZKhV4zg5HiNKhWLcdlVhvoIwEUYXGZBFMTNcGTHo3OnQ9bq12zq6QxBPb6bHLWxJ8PnhZRoyiOCj3Fb2hoMAT5hVYax1geCRGPQd/douOJf9d3nQBWo8HHyl5N9I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d790b5-5403-4de7-39d9-08d68ab374d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 15:14:28.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogU3VuZGF5LCBGZWJydWFyeSAzLCAyMDE5IDY6MjIgQU0NCj4g
VG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENjOiBsaW51eC1l
ZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYnBAc3Vz
ZS5kZTsNCj4gdG9ueS5sdWNrQGludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCA1LzVdIEVEQUMsIG1jZV9hbWQ6IFByaW50IEV4dEVycm9yQ29kZSBhbmQgZGVz
Y3JpcHRpb24NCj4gb24gYSBzaW5nbGUgbGluZQ0KPiANCj4gT24gRnJpLCBGZWIgMDEsIDIwMTkg
YXQgMTA6NTU6NTRQTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gRnJvbTogWWF6
ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiA+DQo+ID4gU2F2ZSBhIGxvZyBs
aW5lIGJ5IHByaW50aW5nIHRoZSBleHRlbmRlZCBlcnJvciBjb2RlIGFuZCB0aGUgZGVzY3JpcHRp
b24NCj4gPiBvbiBhIHNpbmdsZSBsaW5lLiBUaGlzIGlzIHNpbWlsYXIgdG8gaG93IGVycm9ycyBh
cmUgcHJpbnRlZCBpbiBvdGhlcg0KPiA+IHN1YnN5c3RlbXMsIGUuZy4gIiMsIGRlc2NyaXB0aW9u
Ii4gSWYgd2UgZG9uJ3QgaGF2ZSBhIHZhbGlkIGRlc2NyaXB0aW9uDQo+ID4gdGhlbiBvbmx5IHRo
ZSBudW1iZXIvY29kZSBpcyBwcmludGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWF6ZW4g
R2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Vk
YWMvbWNlX2FtZC5jIHwgNSArKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9t
Y2VfYW1kLmMgYi9kcml2ZXJzL2VkYWMvbWNlX2FtZC5jDQo+ID4gaW5kZXggN2UyOWNlYWJkZjZm
Li5mMjg2Yjg4MGY5ODEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL21jZV9hbWQuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZWRhYy9tY2VfYW1kLmMNCj4gPiBAQCAtOTY1LDEzICs5NjUsMTIg
QEAgc3RhdGljIHZvaWQgZGVjb2RlX3NtY2FfZXJyb3Ioc3RydWN0IG1jZSAqbSkNCj4gPg0KPiA+
ICAJaXBfbmFtZSA9IHNtY2FfZ2V0X2xvbmdfbmFtZShiYW5rX3R5cGUpOw0KPiA+DQo+ID4gLQlw
cl9lbWVyZyhIV19FUlIgIiVzIEV4dGVuZGVkIEVycm9yIENvZGU6ICVkXG4iLCBpcF9uYW1lLCB4
ZWMpOw0KPiA+ICsJcHJfZW1lcmcoSFdfRVJSICIlcyBFeHQuIEVycm9yIENvZGU6ICVkIiwgaXBf
bmFtZSwgeGVjKTsNCj4gPg0KPiA+ICAJLyogT25seSBwcmludCB0aGUgZGVjb2RlIG9mIHZhbGlk
IGVycm9yIGNvZGVzICovDQo+ID4gIAlpZiAoeGVjIDwgc21jYV9tY2VfZGVzY3NbYmFua190eXBl
XS5udW1fZGVzY3MgJiYNCj4gPiAgCQkJKGh3aWQtPnhlY19iaXRtYXAgJiBCSVRfVUxMKHhlYykp
KSB7DQo+ID4gLQkJcHJfZW1lcmcoSFdfRVJSICIlcyBFcnJvcjogIiwgaXBfbmFtZSk7DQo+ID4g
LQkJcHJfY29udCgiJXMuXG4iLCBzbWNhX21jZV9kZXNjc1tiYW5rX3R5cGVdLmRlc2NzW3hlY10p
Ow0KPiA+ICsJCXByX2NvbnQoIiwgJXMuXG4iLCBzbWNhX21jZV9kZXNjc1tiYW5rX3R5cGVdLmRl
c2NzW3hlY10pOw0KPiANCj4gSWYgdGhlIGlmLWNvbmRpdGlvbiBkb2Vzbid0IGhpdCwgd2UgbmV2
ZXIgcHJpbnQgdGhlIFxuDQo+IA0KDQpZZXMsIHlvdSdyZSByaWdodC4gQnV0IGl0IHNlZW1zIHRo
YXQgdGhlIG5leHQgcHJfKiB0aGF0J3Mgbm90IGEgcHJfY29udCB3aWxsIGJlIG9uDQphIG5ld2xp
bmUgYXV0b21hdGljYWxseS4NCg0KU2hvdWxkIEkgYWRkIGFuIGV4cGxpY2l0IG5ld2xpbmUganVz
dCB0byBiZSBzdXJlIHdlIGdldCBvbmU/DQoNClRoYW5rcywNCllhemVuDQo=
