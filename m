Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B701C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D49217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OwgICgNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfAHRcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:32:52 -0500
Received: from mail-eopbgr810042.outbound.protection.outlook.com ([40.107.81.42]:52800
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbfAHRcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiRZRwH/FHlRc5mQEfBxLqpoUOqEHm5CMK5Gmy9ZVjI=;
 b=OwgICgNcnV+7hkOsNYp2N3w4+YXa6h91WOB+UjKXhlZHUyD6JrckzrXGQ4cPptx769t+cibH1oi5sTtIOLxxsPoQpaWAQR7l5k9F3NZU33cdDAkwS5Zgcxe7f44OZv4LUQS7jAH7wd8fpgsgjD2mXiqDL0tP9TENjySlWlbJ8Dk=
Received: from BN8PR12MB3602.namprd12.prod.outlook.com (20.178.212.86) by
 BN8PR12MB3268.namprd12.prod.outlook.com (20.179.67.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 17:32:46 +0000
Received: from BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::1819:aa95:7468:8e59]) by BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::1819:aa95:7468:8e59%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 17:32:46 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     Lyude Paul <lyude@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     Sean Paul <sean@poorly.run>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "S, Shirish" <Shirish.S@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        "Koo, Anthony" <Anthony.Koo@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 0/3] drm/amdgpu: Fix suspend/resume issues with MST
Thread-Topic: [PATCH 0/3] drm/amdgpu: Fix suspend/resume issues with MST
Thread-Index: AQHUpu0uNelLslmmlU6ptSAiHXHJMKWlonWA
Date:   Tue, 8 Jan 2019 17:32:45 +0000
Message-ID: <5db84bb9-6d2d-391d-3699-2331bdc75118@amd.com>
References: <20190108005651.25967-1-lyude@redhat.com>
In-Reply-To: <20190108005651.25967-1-lyude@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [69.171.153.184]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::43) To BN8PR12MB3602.namprd12.prod.outlook.com
 (2603:10b6:408:49::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR12MB3268;20:NfNGCfIgYcv/qtrxfWgJ+8zOjNxwokR4VH/DEcp0tCW52TvQzSIZb1um1xYwQkHwDI/PWvlDfXVBaLUkUegIYMgF128z4SuA5s7lQqiNB+ycFVh2T30+BKz3frxMnUL6D4InKwnoPa5letqcnZk2RBIHJ+6ZJLXhwAZocOIwlJkzpkF5cjDLAvfU9HUMvvqBC7tXWymnGyQzkSQhf2eGA6N2ULm1F0nYN511+5LavCvDzPFL/0PVVyShz/KkrJ55
x-ms-office365-filtering-correlation-id: 61a32867-1ea6-455b-074b-08d6758f4d30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN8PR12MB3268;
x-ms-traffictypediagnostic: BN8PR12MB3268:
x-microsoft-antispam-prvs: <BN8PR12MB326846137B428E986AE681128C8A0@BN8PR12MB3268.namprd12.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(99286004)(8936002)(386003)(4326008)(6512007)(102836004)(65826007)(53546011)(5660300001)(6246003)(31686004)(31696002)(71200400001)(305945005)(81156014)(11346002)(81166006)(53936002)(86362001)(7736002)(72206003)(25786009)(478600001)(14454004)(110136005)(2906002)(2501003)(71190400001)(8676002)(2201001)(58126008)(256004)(65956001)(316002)(66066001)(65806001)(446003)(64126003)(52116002)(105586002)(6436002)(97736004)(54906003)(229853002)(6486002)(14444005)(106356001)(3846002)(486006)(6116002)(68736007)(26005)(15650500001)(36756003)(76176011)(186003)(6506007)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR12MB3268;H:BN8PR12MB3602.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aGRN3ni1GgzOare920x5GkUZvIm7NGGD+RfG7Gt4Mbb2OHmriHfxMVrdIAz1+350/m3Ih00r5nhVy2EAS2YxHt77MH2cEpGOlOP394AVQEfdle9wDXMBEamNd/LhWHAKCk+adNkUGXTvDUNUiywQ9IA0OFaOhzkAFNhQm9Zc7CAxBd08U/nZV2WwCNLI0v+1lNBjBIvXjvCC4DAYKcAHS/Kg+hDZSzUG7W57Oj+ebr5U7VoVpUHx135ukXCl4lUpDYoQHgsmGXbwJKm6jtkpndmhMu8PMbs2vFiRY2CtTiKSLH/R+cdSVY+JrkjcpYIw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D189261AF3BD10469EF045FA58182B75@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a32867-1ea6-455b-074b-08d6758f4d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 17:32:45.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wNyA3OjU2IHAubS4sIEx5dWRlIFBhdWwgd3JvdGU6DQo+IEZpeCB0aGUgc3Vz
cGVuZC9pc3N1ZXMgdGhhdCBKZXJyeSBadW8gZm91bmQgaW4gYW1kZ3B1LCBhbmQgYWRkIHNvbWUN
Cj4gY29tcGlsZXIgd2FybmluZ3MgZm9yIGRyaXZlcnMgaWdub3JpbmcgdGhlIHJldHVybiBjb2Rl
IG9mDQo+IGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyX3Jlc3VtZSgpIHRvIGhlbHAgZW5zdXJlIHdl
IGRvbid0IG5lZWQgdG8gZml4DQo+IHRoaXMgYWdhaW4gaW4gdGhlIGZ1dHVyZSBmb3Igc29tZW9u
ZSBlbHNlJ3MgZHJpdmVyLg0KPiANCj4gQ2M6IEplcnJ5IFp1byA8SmVycnkuWnVvQGFtZC5jb20+
DQoNCldpdGggdGhlIHNtYWxsIGNoYW5nZSBEYW5pZWwgbWVudGlvbmVkIHRoaXMgc2VyaWVzIGlz
DQpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQoN
CkhhcnJ5DQoNCj4gDQo+IEx5dWRlIFBhdWwgKDMpOg0KPiAgIGRybS9hbWRncHU6IERvbid0IGln
bm9yZSByYyBmcm9tIGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyX3Jlc3VtZSgpDQo+ICAgZHJtL2Ft
ZGdwdTogRG9uJ3QgZmFpbCByZXN1bWUgcHJvY2VzcyBpZiByZXN1bWluZyBhdG9taWMgc3RhdGUg
ZmFpbHMNCj4gICBkcm0vZHBfbXN0OiBBZGQgX19tdXN0X2NoZWNrIHRvIGRybV9kcF9tc3RfdG9w
b2xvZ3lfbWdyX3Jlc3VtZSgpDQo+IA0KPiAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5jIHwgMzcgKysrKysrKysrKysrKy0tLS0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYyAgICAgICAgIHwgIDMgKy0NCj4gIGluY2x1ZGUvZHJt
L2RybV9kcF9tc3RfaGVscGVyLmggICAgICAgICAgICAgICB8ICAzICstDQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCg==
