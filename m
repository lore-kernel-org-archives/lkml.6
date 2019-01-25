Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16392C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCB1218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GauY5z6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfAYPaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:30:19 -0500
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:35292
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbfAYPaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U1ewO1Gi4Qhoc4wb+CEz7xfziR8hoQ1s8gbj5VuuIk=;
 b=GauY5z6uy2c2kyCz9mpPb43TDgoEWCR8OPAMtZGSANifW0cXM0oCdWf0yc8jbO6jrUtSlLmtSIEaRpXZJOp4XqDtM60D9I01P0u3YVP23CJG3RCn4yqG5RHwQ9c20GoealW/t7pE+1lJ+IH9w8woOWhRUkh93bvDBnJxy2l6h+4=
Received: from BN8PR12MB3602.namprd12.prod.outlook.com (20.178.212.86) by
 BN8PR12MB3187.namprd12.prod.outlook.com (20.179.64.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 15:29:37 +0000
Received: from BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::d5b4:3e1d:432f:4f62]) by BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::d5b4:3e1d:432f:4f62%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 15:29:37 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "S@google.com" <S@google.com>, "S, Shirish" <Shirish.S@amd.com>,
        Matthias Kaehlcke <mka@google.com>,
        James Y Knight <jyknight@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Thread-Topic: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Thread-Index: AQHUtEhgHoOlRe+0fkeG56Pm7j0rtKXAHPsA
Date:   Fri, 25 Jan 2019 15:29:37 +0000
Message-ID: <04bc6844-2a3b-2de8-60a7-a027149709fd@amd.com>
References: <20190125005304.183322-1-ndesaulniers@google.com>
In-Reply-To: <20190125005304.183322-1-ndesaulniers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To BN8PR12MB3602.namprd12.prod.outlook.com
 (2603:10b6:408:49::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR12MB3187;20:2+YVEUDQIA0NKXYZbxfiqjojErcVM1iMXcVnKSxmQaS4PqgHVoBk9QVKq/gGByXDcg/a7+s4XKYAs01F4I0TRWGPHoCyMhR6MsGd1dSlMVnOeiKij0jCfF7jRoPvFTIQNFBW3Jjwt4qI6ZR6D+F6ohv1SL3ZYzNlgnpPEZh/5ITSiNJhPHoIRUSCLK97seQlXAGqSlgVQ3RCXtzprPiPa6v8L60hTo15i5pZojb1mHd4GktjAEoo9weQYRju18rk
x-ms-office365-filtering-correlation-id: bc4c31b6-8b90-411a-6bd8-08d682d9ea43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN8PR12MB3187;
x-ms-traffictypediagnostic: BN8PR12MB3187:
x-microsoft-antispam-prvs: <BN8PR12MB31879A3FEE3AE14B194D10238C9B0@BN8PR12MB3187.namprd12.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(386003)(8676002)(229853002)(53546011)(6506007)(2201001)(6512007)(6306002)(3846002)(31686004)(81156014)(2906002)(81166006)(99286004)(7416002)(6436002)(52116002)(97736004)(6116002)(110136005)(14454004)(26005)(39060400002)(305945005)(8936002)(7736002)(64126003)(54906003)(31696002)(316002)(6246003)(966005)(86362001)(186003)(66066001)(2616005)(476003)(71200400001)(71190400001)(2501003)(6486002)(486006)(256004)(478600001)(65826007)(72206003)(25786009)(68736007)(106356001)(36756003)(105586002)(65956001)(65806001)(76176011)(446003)(58126008)(11346002)(102836004)(53936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR12MB3187;H:BN8PR12MB3602.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BTyZKqyVJY/7uQWSri1In/zjjcdXxfBnXMwStlaeY1edx67/Ev7KHn6+RQoCZhwDQnVdSOE9T7RyXq9NndYpO/rjqqC42Lj0NtwfAUazlVbKtGbv2FMf273ErbPqLT9HXHDbglE7M8gkyvfJXF1q/3sirC7R8a2PVQ24wdKHUjYg5qLAWB58xAqbHu14hzfoVtm5Zk8RL9woVB6SlwV6XXWNH5jQNhLXPItW78THH4Yy7zdh6Nf4OewUzL4HSetKLJk6BTGxHpZQqJUddQ0Fu4b9BfzNHWjuoazK0GOcvNWtPRTL7Yq5dtydLLI3mfcyCXSOYafvCeC1RA7gLAvSTbQSFy/Fmn2RBHcglF+iS7B1EI8Cz7DIhSpbCbJOk7IxDx0tTwtycieypu8bJBbqjZ/ZA1XRaSc59tVvClLzSJs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FB46B220EC61A4DA9249E130EB5DAE5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4c31b6-8b90-411a-6bd8-08d682d9ea43
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 15:29:36.1129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0yNCA3OjUyIHAubS4sIG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tIHdyb3RlOg0K
PiBhcmNoL3g4Ni9NYWtlZmlsZSBkaXNhYmxlcyBTU0UgYW5kIFNTRTIgZm9yIHRoZSB3aG9sZSBr
ZXJuZWwuICBUaGUNCj4gQU1ER1BVIGRyaXZlcnMgbW9kaWZpZWQgaW4gdGhpcyBwYXRjaCByZS1l
bmFibGUgU1NFIGJ1dCBub3QgU1NFMi4gIFR1cm4NCj4gb24gU1NFMiB0byBzdXBwb3J0IGVtaXR0
aW5nIGRvdWJsZSBwcmVjaXNpb24gZmxvYXRpbmcgcG9pbnQgaW5zdHJ1Y3Rpb25zDQo+IHJhdGhl
ciB0aGFuIGNhbGxzIHRvIG5vbi1leGlzdGVudCAodXN1YWxseSBhdmFpbGFibGUgZnJvbSBnY2Nf
cyBvcg0KPiBjb21waWxlcl9ydCkgZmxvYXRpbmcgcG9pbnQgaGVscGVyIHJvdXRpbmVzLg0KPiAN
Cj4gTGluazogaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djY2ludC9Tb2Z0LWZsb2F0
LWxpYnJhcnktcm91dGluZXMuaHRtbA0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vQ2xhbmdC
dWlsdExpbnV4L2xpbnV4L2lzc3Vlcy8zMjcNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcg
IyA0LjE5DQo+IFJlcG9ydGVkLWJ5OiBTLCBTaGlyaXNoIDxTaGlyaXNoLlNAYW1kLmNvbT4NCj4g
UmVwb3J0ZWQtYnk6IE1hdHRoaWFzIEthZWhsY2tlIDxta2FAZ29vZ2xlLmNvbT4NCj4gU3VnZ2Vz
dGVkLWJ5OiBKYW1lcyBZIEtuaWdodCA8anlrbmlnaHRAZ29vZ2xlLmNvbT4NCj4gU3VnZ2VzdGVk
LWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NCj4g
VGVzdGVkLWJ5OiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQoNClJldmlld2Vk
LWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KYW5kIGFwcGxp
ZWQuDQoNCkhhcnJ5DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y2FsY3MvTWFrZWZpbGUgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZG1sL01ha2VmaWxlICAgfCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY2FsY3MvTWFrZWZpbGUgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY2FsY3MvTWFrZWZpbGUNCj4gaW5kZXggOTVmMzMyZWUzZTdlLi5kYzg1YTNjMDg4YWYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9NYWtlZmls
ZQ0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvTWFrZWZpbGUN
Cj4gQEAgLTMwLDcgKzMwLDcgQEAgZWxzZSBpZm5lcSAoJChjYWxsIGNjLW9wdGlvbiwgLW1zdGFj
ay1hbGlnbm1lbnQ9MTYpLCkNCj4gIAljY19zdGFja19hbGlnbiA6PSAtbXN0YWNrLWFsaWdubWVu
dD0xNg0KPiAgZW5kaWYNCj4gIA0KPiAtY2FsY3NfY2NmbGFncyA6PSAtbWhhcmQtZmxvYXQgLW1z
c2UgJChjY19zdGFja19hbGlnbikNCj4gK2NhbGNzX2NjZmxhZ3MgOj0gLW1oYXJkLWZsb2F0IC1t
c3NlIC1tc3NlMiAkKGNjX3N0YWNrX2FsaWduKQ0KPiAgDQo+ICBDRkxBR1NfZGNuX2NhbGNzLm8g
Oj0gJChjYWxjc19jY2ZsYWdzKQ0KPiAgQ0ZMQUdTX2Rjbl9jYWxjX2F1dG8ubyA6PSAkKGNhbGNz
X2NjZmxhZ3MpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZG1sL01ha2VmaWxlIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9NYWtlZmls
ZQ0KPiBpbmRleCBkOTdjYTY1MjhmOWQuLjMzYzdkNzU4ODcxMiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL01ha2VmaWxlDQo+IEBAIC0zMCw3ICszMCw3IEBA
IGVsc2UgaWZuZXEgKCQoY2FsbCBjYy1vcHRpb24sIC1tc3RhY2stYWxpZ25tZW50PTE2KSwpDQo+
ICAJY2Nfc3RhY2tfYWxpZ24gOj0gLW1zdGFjay1hbGlnbm1lbnQ9MTYNCj4gIGVuZGlmDQo+ICAN
Cj4gLWRtbF9jY2ZsYWdzIDo9IC1taGFyZC1mbG9hdCAtbXNzZSAkKGNjX3N0YWNrX2FsaWduKQ0K
PiArZG1sX2NjZmxhZ3MgOj0gLW1oYXJkLWZsb2F0IC1tc3NlIC1tc3NlMiAkKGNjX3N0YWNrX2Fs
aWduKQ0KPiAgDQo+ICBDRkxBR1NfZGlzcGxheV9tb2RlX2xpYi5vIDo9ICQoZG1sX2NjZmxhZ3Mp
DQo+ICBDRkxBR1NfZGlzcGxheV9waXBlX2Nsb2Nrcy5vIDo9ICQoZG1sX2NjZmxhZ3MpDQo+IA0K
