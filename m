Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED92A2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rGkySQGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfACVL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:11:26 -0500
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:6512
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbfACVLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJilDgRzReyb9BTck3pwxOO0x5bQsDlKV3a5YMWzNNo=;
 b=rGkySQGZOPio9QJth/9qjMzmroHbf24m17GyRUOq/5NdC8sDkES5Y340qTMUyUdZoUbSg7DpRPLh5ctAwRke0xQlQj0f8JyoXPjQ93Q93+p3/lA9YNIoi/mAxYqPG5RPtrz3znh4oB3CYKZ2qw/dU72MS7PE4woKQrK4s5/YxXE=
Received: from BN8PR12MB3602.namprd12.prod.outlook.com (20.178.212.86) by
 BN8PR12MB3010.namprd12.prod.outlook.com (20.178.208.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 3 Jan 2019 21:11:21 +0000
Received: from BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::1819:aa95:7468:8e59]) by BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::1819:aa95:7468:8e59%3]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 21:11:21 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Fix boolean expression in
 get_surf_rq_param
Thread-Topic: [PATCH] drm/amd/display: Fix boolean expression in
 get_surf_rq_param
Thread-Index: AQHUo51afiYevI/7HES1/AUiKkWuwaWeCoEA
Date:   Thu, 3 Jan 2019 21:11:21 +0000
Message-ID: <8169baae-434e-2d08-d63f-a285d1c3457e@amd.com>
References: <20190103194845.GA26175@embeddedor>
In-Reply-To: <20190103194845.GA26175@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To BN8PR12MB3602.namprd12.prod.outlook.com
 (2603:10b6:408:49::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR12MB3010;20:1p4KDdiQtBhb4iTBEWe4sEaCE4p8GYrLF4sps/eh1n9E6hita8+K3EK+83iRLL8dzDBzZV98tBT/P6LxbH6Jrm1D3rw8zvhP12sCLCCLN1cLS/QYG5WUBTKrNMm2MXk95hWbVOwNTx1w8sIx7onxg00jrwVBZw0lQd3Ffaz3jvayAtYFt+hfxYfzatNho4LCInQOp44DlFRrdX524NJjM9A6/PieFdQUhloFmboS99ppi72GgWAD4pFPowUuji25
x-ms-office365-filtering-correlation-id: 4ecf2c33-11de-4ba9-ceb2-08d671c002b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN8PR12MB3010;
x-ms-traffictypediagnostic: BN8PR12MB3010:
x-microsoft-antispam-prvs: <BN8PR12MB301049DB1E0701A1643FBB128C8D0@BN8PR12MB3010.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN8PR12MB3010;BCL:0;PCL:0;RULEID:;SRVR:BN8PR12MB3010;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(8676002)(486006)(66066001)(65806001)(72206003)(476003)(6486002)(386003)(5660300001)(6436002)(81156014)(81166006)(36756003)(68736007)(256004)(14444005)(52116002)(97736004)(65956001)(53546011)(76176011)(99286004)(102836004)(2906002)(6506007)(31696002)(106356001)(53936002)(64126003)(8936002)(478600001)(305945005)(105586002)(186003)(65826007)(31686004)(2616005)(11346002)(26005)(316002)(7736002)(86362001)(25786009)(229853002)(54906003)(58126008)(110136005)(6512007)(3846002)(71200400001)(71190400001)(6116002)(14454004)(6246003)(446003)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR12MB3010;H:BN8PR12MB3602.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xI7fddIQjaZk8/jVbGkxYw3pyL4AyQ0NgjYknyP/QxvHf3TtkIvgTwSHQtDUx4O/Fi1b3TDifOLs+a2jFc+M0EL1przsayKQVg5CVwmizdVPEUQLDif9GwS1dv9mfSB8skjgnVInkIlC0niNNOdCDMGfjbXvLJN8vO8Hq+38zvKSQgntEcx3QUlp9ozcL8kUj73FM6x4M3xz1Pvm12cDhT8A2GThIzulDupiyFj4LRhZUdoWrin9XXI0nTuvtEawt8lMwn3h5DhTMlzEu69oYBNp7lNOwalXTmYwMuyJuhhYH0m6OOEULF0gM1Y7C84c
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4E77005B6479441AD2D4820BF97ABCF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecf2c33-11de-4ba9-ceb2-08d671c002b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 21:11:21.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wMyAyOjQ4IHAubS4sIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+IEZp
eCBib29sZWFuIGV4cHJlc3Npb24gYnkgdXNpbmcgbG9naWNhbCBBTkQgb3BlcmF0b3IgJyYmJw0K
PiBpbnN0ZWFkIG9mIGJpdHdpc2Ugb3BlcmF0b3IgJyYnLg0KPiANCj4gVGhpcyBpc3N1ZSB3YXMg
ZGV0ZWN0ZWQgd2l0aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlLg0KPiANCj4gRml4ZXM6IDZkMDRl
ZTlkYzEwMSAoImRybS9hbWQvZGlzcGxheTogUmVzdHJ1Y3R1cmluZyBhbmQgY2xlYW5pbmcgdXAg
RE1MIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogR3Vz
dGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQphbmQgYXBwbGllZC4N
Cg0KSGFycnkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwv
ZG1sMV9kaXNwbGF5X3JxX2RsZ19jYWxjLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RtbDFfZGlzcGxheV9ycV9kbGdfY2FsYy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kbWwxX2Rpc3BsYXlfcnFfZGxnX2NhbGMu
Yw0KPiBpbmRleCBjMjAzN2RhYThlNjYuLmQzNDFiNjlmZGMxYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kbWwxX2Rpc3BsYXlfcnFfZGxnX2NhbGMu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RtbDFfZGlzcGxh
eV9ycV9kbGdfY2FsYy5jDQo+IEBAIC04ODEsNyArODgxLDcgQEAgc3RhdGljIHZvaWQgZ2V0X3N1
cmZfcnFfcGFyYW0oDQo+ICAJLyogdGhlIGRwdGVfZ3JvdXBfYnl0ZXMgaXMgcmVkdWNlZCBmb3Ig
dGhlIHNwZWNpZmljIGNhc2Ugb2YgdmVydGljYWwNCj4gIAkgKiBhY2Nlc3Mgb2YgYSB0aWxlIHN1
cmZhY2UgdGhhdCBoYXMgZHB0ZSByZXF1ZXN0IG9mIDh4MSBwdGVzLg0KPiAgCSAqLw0KPiAtCWlm
ICghc3VyZl9saW5lYXIgJiAobG9nMl9kcHRlX3JlcV9oZWlnaHRfcHRlcyA9PSAwKSAmIHN1cmZf
dmVydCkgLypyZWR1Y2VkLCBpbiB0aGlzIGNhc2UsIHdpbGwgaGF2ZSBwYWdlIGZhdWx0IHdpdGhp
biBhIGdyb3VwICovDQo+ICsJaWYgKCFzdXJmX2xpbmVhciAmJiAobG9nMl9kcHRlX3JlcV9oZWln
aHRfcHRlcyA9PSAwKSAmJiBzdXJmX3ZlcnQpIC8qcmVkdWNlZCwgaW4gdGhpcyBjYXNlLCB3aWxs
IGhhdmUgcGFnZSBmYXVsdCB3aXRoaW4gYSBncm91cCAqLw0KPiAgCQlycV9zaXppbmdfcGFyYW0t
PmRwdGVfZ3JvdXBfYnl0ZXMgPSA1MTI7DQo+ICAJZWxzZQ0KPiAgCQkvKmZ1bGwgc2l6ZSAqLw0K
PiANCg==
