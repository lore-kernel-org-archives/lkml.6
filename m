Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF08C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A897E20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NO+IT5qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfAIIOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:14:50 -0500
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:24374
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729372AbfAIIOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1CXuK3Wltnd1RSE8xIm7Hw3Oznn4Q/hvtNeCWFkMR8=;
 b=NO+IT5qrhpc5u94+1uPVzFqwE1JQ2ULYcLYrnGPxy9Ra6obpxBdNGF25FNZYCQnZmEWEXmaHd7QGV6/xXDhBONcr7L0TOsFf0THTkkhqhSQMa/UFMeGSkfD/0yl+4RAwgPn14Oi7HxF5SMGfp44BOcYRFOOa18SEI42wsIk3PNU=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3924.eurprd08.prod.outlook.com (20.178.118.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 08:14:43 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::915f:e024:438d:7f2]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::915f:e024:438d:7f2%3]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 08:14:43 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/7] drm/komeda: Add d71_enum_resources and d71_cleanup
Thread-Topic: [PATCH 1/7] drm/komeda: Add d71_enum_resources and d71_cleanup
Thread-Index: AQHUm2bhNgH2INXXMEW03fUugk+EnqWj5rAAgANPSYA=
Date:   Wed, 9 Jan 2019 08:14:43 +0000
Message-ID: <4757EAE4-55DF-41D1-88CF-718F3D3D83B7@arm.com>
References: <20181224085716.2325-1-james.qian.wang@arm.com>
 <20181224085716.2325-2-james.qian.wang@arm.com>
 <20190107134151.uwmjlks5mnkzw6j2@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190107134151.uwmjlks5mnkzw6j2@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.14.0.181208
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3924;6:1if6qUxJDWn6BuYmmO1M3ydl+biRXwT5QfwQ6rye+wQYa+QVI5Of4s5G+kxKHWFPYvazskH3Y/DS/2C78OjgaZTcMPeET/qQb/zMnT2AJt5q3ZRJYc5c9td7HysP7oD4E8yAedOJGHhNo6DDMrW3hy4rXksuxCpOb9l7+e1kpUJbANEIDkgR6flr9H0bGIbtYbKvHdtsiwiG3/p+H2MbrrKlRoiJLla0jDqbFT/wzdB6IoJT8/8CEDgiHEvCU3yXeXIZrZ7A246nsWKy681d03ENA2STkbL8dwvCv0SzlBxAkBNTHG115fzxU3kmUKms9re7jRx6PQNBi5DfXx9enoqtkhCTar4EdXtu+I8A4TBN5aGdRn0e54cKoLI+jHjV6FpspDJ8EIag52rfJhIGgF/I+uYtMpB9uCbJ9JEeG5PJacGLQ4sVCc1V3uNd5OU9zFdMp1FW/utx5Nzqg6wwcQ==;5:iiQNuuuvVjvbBmXoNZ/2K2iY2+QoD+fpRWbSrFyjFJZ8OAnz5XdHdXYFEYx0V6PEtuKvq3CGDJkp1upAFIiz3DOmqkphDP0gFdmHLjfcXEhAyIaoVCLJnvT7bmbDXOKQ5Zwzp7JLcCNWoylmdqm0cVZaJu+0cvEr7rasP05k/1otu4lidJ04iCMWPhAoGJIrQzGePHFWlm9HRKKWrTM1CA==;7:FVJnijEWF+l6PmlfwoDTfoPw+yHQQDxaawhkkHnFNCoLZJhOSxM4uhptuRy8NKiPpo8m/R+Zli/6CCMUWxb+SOKw5hS4PQzOEc1a4SJ3JS8BLcgPuNMtm86MIXda+6V73d4Fw/VQ9OSlNS1kFFWzlg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a6b4c0d8-78a7-4c41-8307-08d6760a82dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3924;
x-ms-traffictypediagnostic: AM0PR08MB3924:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3924583E93073D33647C614EB38B0@AM0PR08MB3924.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3924;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3924;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(8936002)(7736002)(14454004)(8676002)(11346002)(2616005)(81156014)(186003)(81166006)(99286004)(486006)(476003)(478600001)(305945005)(71200400001)(6636002)(106356001)(6506007)(55236004)(54906003)(58126008)(316002)(33656002)(37006003)(76176011)(6512007)(36756003)(446003)(102836004)(105586002)(26005)(82746002)(68736007)(4326008)(83716004)(6862004)(6116002)(3846002)(25786009)(6486002)(53936002)(97736004)(229853002)(6246003)(66066001)(5660300001)(6436002)(575784001)(2906002)(256004)(14444005)(71190400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3924;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xb3WLbhOQUg2nF6Q5/nABB/ikMP7HxoWxhwQ+Trkq59BsWnohjeBAZ3E9iG1ugi5r4weAsCUae2KzGgYzcfbX5wzXZkFtMuhgfUZXKjLx93n7QBDTKEPkSXNzteiECAEV3o2RRkYt+k6DCQvwhz1Efg9sj8PVsXBLcCb5qXYXzx0GEMkK+nuslJs9fhQUERRAvFsilTjzGhO8WTwmw9iPUp1BULNZ71WO3cyZ8Rb8Lh/j+TMItHUlfPdbPmUJf97dMFvFlSChP4UKAkxRceucdpm3x+DKcZe0NgxaBWP+K6QFUWMkIYRSntpO0oIwwQW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EAFDD67F415494195C3F9BFADF93805@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b4c0d8-78a7-4c41-8307-08d6760a82dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 08:14:43.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3924
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDIwMTkvMS83LCA5OjQxIFBNLCAiQnJpYW4gU3RhcmtleSIgPEJyaWFuLlN0YXJr
ZXlAYXJtLmNvbT4gd3JvdGU6DQoNCiAgICBIaSBKYW1lcywNCiAgICANCiAgICBBIGZldyBtaW5v
ciBjb21tZW50cy4NCiAgICANCiAgICBPbiBNb24sIERlYyAyNCwgMjAxOCBhdCAwODo1ODo0NkFN
ICswMDAwLCBqYW1lcyBxaWFuIHdhbmcgKEFybSBUZWNobm9sb2d5IENoaW5hKSB3cm90ZToNCiAg
ICA+IEQ3MSBjb25zaXN0cyBvZiBhIG51bWJlciBvZiBSZWdpc3RlciBCbG9ja3MsIGV2ZXJ5IEJs
b2NrIGNvbnRyb2xzIGENCiAgICA+IHNwZWNpZmljIEhXIGZ1bmN0aW9uLCBldmVyeSBibG9jayBo
YXMgYSBjb21tb24gYmxvY2tfaGVhZGVyIHRvIHJlcHJlc2VudA0KICAgID4gaXRzIHR5cGUgYW5k
IHBpcGVsaW5lIGluZm9ybWF0aW9uLg0KICAgID4gDQogICAgPiBHQ1UgKEdsb2JhbCBDb250cm9s
IFVuaXQpIGlzIHRoZSBmaXJzdCBCbG9jayB3aGljaCBkZXNjcmliZSB0aGUgZ2xvYmFsDQogICAg
PiBpbmZvcm1hdGlvbiBvZiBENzEgSFcsIExpa2UgbnVtYmVyIG9mIGJsb2NrIGNvbnRhaW5lZCBh
bmQgdGhlIG51bWJlciBvZg0KICAgID4gcGlwZWxpbmUgc3VwcG9ydGVkLg0KICAgID4gDQogICAg
PiBTbyB0aGUgZDcxX2VudW1fcmVzb3VyY2VzIHBhcnNlZCBHQ1UgYW5kIGNyZWF0ZSBwaXBlbGlu
ZSBhY2NvcmRpbmcNCiAgICA+IHRoZSBHQ1UgY29uZmlndXJhdGlvbiwgYW5kIHRoZW4gaXRlcmF0
ZSBhbmQgZGV0ZWN0IHRoZSBibG9ja3MgdGhhdA0KICAgID4gaW5kaWNhdGVkIGJ5IHRoZSBHQ1Ug
YW5kIGJsb2NrX2hlYWRlci4NCiAgICA+IA0KICAgID4gQW5kIHRoaXMgY2hhbmdlIGFsc28gYWRk
ZWQgdHdvIHN0cnVjdCBkNzFfZGV2L2Q3MV9waXBlbGluZSB0byBleHRlbmQNCiAgICA+IGtvbWVk
YV9kZXYva29tZWRhX3BpcGVsaW5lIHRvIGFkZCBzb21lIGQ3MSBvbmx5IG1lbWJlcnMuDQogICAg
PiANCiAgICA+IFNpZ25lZC1vZmYtYnk6IEphbWVzIChRaWFuKSBXYW5nIDxqYW1lcy5xaWFuLndh
bmdAYXJtLmNvbT4NCiAgICA+IC0tLQ0KICAgIA0KICAgIC0tIHNuaXAgLS0NCiAgICANCiAgICA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2Q3MS9kNzFf
Y29tcG9uZW50LmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2Q3MS9kNzFf
Y29tcG9uZW50LmMNCiAgICA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQogICAgPiBpbmRleCAwMDAw
MDAwMDAwMDAuLmE0M2EyNDEwMTU5Zg0KICAgID4gLS0tIC9kZXYvbnVsbA0KICAgID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX2NvbXBvbmVudC5jDQog
ICAgPiBAQCAtMCwwICsxLDEyMCBAQA0KICAgID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQogICAgPiArLyoNCiAgICA+ICsgKiAoQykgQ09QWVJJR0hUIDIwMTggQVJNIExp
bWl0ZWQuIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQogICAgPiArICogQXV0aG9yOiBKYW1lcy5RaWFu
LldhbmcgPGphbWVzLnFpYW4ud2FuZ0Bhcm0uY29tPg0KICAgID4gKyAqDQogICAgPiArICovDQog
ICAgPiArI2luY2x1ZGUgImQ3MV9kZXYuaCINCiAgICA+ICsjaW5jbHVkZSAia29tZWRhX2ttcy5o
Ig0KICAgID4gKyNpbmNsdWRlICJtYWxpZHBfaW8uaCINCiAgICA+ICsNCiAgICA+ICtzdGF0aWMg
aW50IGQ3MV9sYXllcl9pbml0KHN0cnVjdCBkNzFfZGV2ICpkNzEsDQogICAgPiArCQkJICBzdHJ1
Y3QgYmxvY2tfaGVhZGVyICpibGssIHUzMiBfX2lvbWVtICpyZWcpDQogICAgPiArew0KICAgID4g
KwlEUk1fSU5GTygiRGV0ZWN0IEQ3MV9MYXllci5cbiIpOw0KICAgIA0KICAgIEkgdGhpbmsgYWxs
IG9mIHRoZXNlIGNhbiBiZSBEUk1fREVCVUcuDQogICAgDQogICAgLS0gc25pcCAtLQ0KDQpXaWxs
IGZpeCBpdCBvbiB0aGUgbmV4dCB2ZXJzaW9uLg0KICAgIA0KICAgID4gIA0KICAgID4gIHN0YXRp
YyBpbnQgZDcxX2VudW1fcmVzb3VyY2VzKHN0cnVjdCBrb21lZGFfZGV2ICptZGV2KQ0KICAgID4g
IHsNCiAgICA+IC0JLyogVE9ETyBhZGQgZW51bSByZXNvdXJjZXMgKi8NCiAgICA+ICsJc3RydWN0
IGQ3MV9kZXYgKmQ3MTsNCiAgICA+ICsJc3RydWN0IGtvbWVkYV9waXBlbGluZSAqcGlwZTsNCiAg
ICA+ICsJc3RydWN0IGJsb2NrX2hlYWRlciBibGs7DQogICAgPiArCXUzMiBfX2lvbWVtICpibGtf
YmFzZTsNCiAgICA+ICsJdTMyIGksIHZhbHVlLCBvZmZzZXQ7DQogICAgPiArDQogICAgPiArCWQ3
MSA9IGRldm1fa3phbGxvYyhtZGV2LT5kZXYsIHNpemVvZigqZDcxKSwgR0ZQX0tFUk5FTCk7DQog
ICAgPiArCWlmICghZDcxKQ0KICAgID4gKwkJcmV0dXJuIC1FTk9NRU07DQogICAgPiArDQogICAg
PiArCW1kZXYtPmNoaXBfZGF0YSA9IGQ3MTsNCiAgICA+ICsJZDcxLT5tZGV2ID0gbWRldjsNCiAg
ICA+ICsJZDcxLT5nY3VfYWRkciA9IG1kZXYtPnJlZ19iYXNlOw0KICAgID4gKwlkNzEtPnBlcmlw
aF9hZGRyID0gbWRldi0+cmVnX2Jhc2UgKyAoRDcxX0JMT0NLX09GRlNFVF9QRVJJUEggPj4gMik7
DQogICAgPiArDQogICAgPiArCWlmIChkNzFfcmVzZXQoZDcxKSkgew0KICAgID4gKwkJRFJNX0VS
Uk9SKCJGYWlsIHRvIHJlc2V0IGQ3MSBkZXZpY2UuXG4iKTsNCiAgICA+ICsJCWdvdG8gZXJyX2Ns
ZWFudXA7DQogICAgPiArCX0NCiAgICA+ICsNCiAgICA+ICsJLyogcHJvYmUgR0NVICovDQogICAg
PiArCXZhbHVlID0gbWFsaWRwX3JlYWQzMihkNzEtPmdjdV9hZGRyLCBHTEJfQ09SRV9JTkZPKTsN
CiAgICA+ICsJZDcxLT5udW1fYmxvY2tzID0gdmFsdWUgJiAweEZGOw0KICAgID4gKwlkNzEtPm51
bV9waXBlbGluZXMgPSAodmFsdWUgPj4gOCkgJiAweDc7DQogICAgPiArDQogICAgPiArCWlmIChk
NzEtPm51bV9waXBlbGluZXMgPiBENzFfTUFYX1BJUEVMSU5FKSB7DQogICAgPiArCQlEUk1fRVJS
T1IoImQ3MSBzdXBwb3J0cyAlZCBwaXBlbGluZXMsIGJ1dCBnb3Q6ICVkLlxuIiwNCiAgICA+ICsJ
CQkgIEQ3MV9NQVhfUElQRUxJTkUsIGQ3MS0+bnVtX3BpcGVsaW5lcyk7DQogICAgPiArCQlnb3Rv
IGVycl9jbGVhbnVwOw0KICAgID4gKwl9DQogICAgPiArDQogICAgPiArCS8qIHByb2JlIFBFUklQ
SCAqLw0KICAgID4gKwl2YWx1ZSA9IG1hbGlkcF9yZWFkMzIoZDcxLT5wZXJpcGhfYWRkciwgQkxL
X0JMT0NLX0lORk8pOw0KICAgID4gKwlpZiAoQkxPQ0tfSU5GT19CTEtfVFlQRSh2YWx1ZSkgIT0g
RDcxX0JMS19UWVBFX1BFUklQSCkgew0KICAgID4gKwkJRFJNX0VSUk9SKCJhY2Nlc3MgYmxrIHBl
cmlwaCBidXQgZ290IGJsazogJWQuXG4iLA0KICAgID4gKwkJCSAgQkxPQ0tfSU5GT19CTEtfVFlQ
RSh2YWx1ZSkpOw0KICAgID4gKwkJZ290byBlcnJfY2xlYW51cDsNCiAgICA+ICsJfQ0KICAgID4g
Kw0KICAgID4gKwl2YWx1ZSA9IG1hbGlkcF9yZWFkMzIoZDcxLT5wZXJpcGhfYWRkciwgUEVSSVBI
X0NPTkZJR1VSQVRJT05fSUQpOw0KICAgID4gKw0KICAgID4gKwlkNzEtPm1heF9saW5lX3NpemUJ
PSB2YWx1ZSAmIFBFUklQSF9NQVhfTElORV9TSVpFID8gNDA5NiA6IDIwNDg7DQogICAgPiArCWQ3
MS0+bWF4X3ZzaXplCQk9IDQwOTY7DQogICAgPiArCWQ3MS0+bnVtX3JpY2hfbGF5ZXJzCT0gdmFs
dWUgJiBQRVJJUEhfTlVNX1JJQ0hfTEFZRVJTID8gMiA6IDE7DQogICAgPiArCWQ3MS0+c3VwcG9y
dHNfZHVhbF9saW5rCT0gdmFsdWUgJiBQRVJJUEhfU1BMSVRfRU4gPyB0cnVlIDogZmFsc2U7DQog
ICAgPiArCWQ3MS0+aW50ZWdyYXRlc190YnUJPSB2YWx1ZSAmIFBFUklQSF9UQlVfRU4gPyB0cnVl
IDogZmFsc2U7DQogICAgPiArDQogICAgPiArCWZvciAoaSA9IDA7IGkgPCBkNzEtPm51bV9waXBl
bGluZXM7IGkrKykgew0KICAgID4gKwkJcGlwZSA9IGtvbWVkYV9waXBlbGluZV9hZGQobWRldiwg
c2l6ZW9mKHN0cnVjdCBkNzFfcGlwZWxpbmUpLA0KICAgID4gKwkJCQkJICAgTlVMTCk7DQogICAg
PiArCQlpZiAoIXBpcGUpDQogICAgPiArCQkJZ290byBlcnJfY2xlYW51cDsNCiAgICA+ICsNCiAg
ICA+ICsJCWQ3MS0+cGlwZXNbaV0gPSB0b19kNzFfcGlwZWxpbmUocGlwZSk7DQogICAgPiArCX0N
CiAgICA+ICsNCiAgICA+ICsJLyogbG9vcCB0aGUgcmVnaXN0ZXIgYmxrcyBhbmQgcHJvYmUgKi8N
CiAgICA+ICsJaSA9IDI7IC8qIGV4Y2x1ZGUgR0NVIGFuZCBQRVJJUEggKi8NCiAgICA+ICsJb2Zm
c2V0ID0gRDcxX0JMT0NLX1NJWkU7IC8qIHNraXAgR0NVICovDQogICAgPiArCXdoaWxlIChpIDwg
ZDcxLT5udW1fYmxvY2tzKSB7DQogICAgPiArCQlibGtfYmFzZSA9IG1kZXYtPnJlZ19iYXNlICsg
KG9mZnNldCA+PiAyKTsNCiAgICA+ICsNCiAgICA+ICsJCWQ3MV9yZWFkX2Jsb2NrX2hlYWRlcihi
bGtfYmFzZSwgJmJsayk7DQogICAgPiArCQlpZiAoQkxPQ0tfSU5GT19CTEtfVFlQRShibGsuYmxv
Y2tfaW5mbykgIT0gRDcxX0JMS19UWVBFX1JFU0VSVkVEKSB7DQogICAgPiArCQkJaWYgKGQ3MV9w
cm9iZV9ibG9jayhkNzEsICZibGssIGJsa19iYXNlKSkNCiAgICA+ICsJCQkJZ290byBlcnJfY2xl
YW51cDsNCiAgICA+ICsJCQlpKys7DQogICAgPiArCQl9DQogICAgPiArDQogICAgPiArCQlvZmZz
ZXQgKz0gRDcxX0JMT0NLX1NJWkU7DQogICAgPiArCX0NCiAgICA+ICsNCiAgICA+ICsJRFJNX0lO
Rk8oInRvdGFsICVkIChvdXQgb2YgJWQpIGJsb2NrcyBhcmUgZm91bmQuXG4iLA0KICAgID4gKwkJ
IGksIGQ3MS0+bnVtX2Jsb2Nrcyk7DQogICAgPiArDQogICAgPiArCXJldHVybiAwOw0KICAgID4g
Kw0KICAgID4gK2Vycl9jbGVhbnVwOg0KICAgID4gKwlkNzFfY2xlYW51cChtZGV2KTsNCiAgICA+
ICAJcmV0dXJuIC0xOw0KICAgIA0KICAgIC0xIGlzbid0IGEgdXNlZnVsIGVycm9yIGNvZGUsIGFu
ZCB5b3UgcmV0dXJuIC1FTk9NRU0gaWYgYWxsb2NhdGlvbg0KICAgIGZhaWxzLiBJdCB3b3VsZCBw
cm9iYWJseSBiZSBiZXR0ZXIgdG8gcmV0dXJuIHByb3BlciBjb2RlcyBldmVyeXdoZXJlDQogICAg
KGUuZy4geW91IG1pZ2h0IGdldCAtRUlOVkFMIGJhY2sgZnJvbSBkNzFfcHJvYmVfYmxvY2ssIGJ1
dCB5b3UgZG9uJ3QNCiAgICBwcm9wYWdhdGUgaXQpLg0KICAgIA0KICAgIC0tIHNuaXAgLS0NCg0K
T2ssIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQogICAgDQogICAgPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX3JlZ3MuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEvZDcxL2Q3MV9yZWdzLmgNCiAgICA+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQogICAgPiBpbmRleCAwMDAwMDAwMDAwMDAuLjJkNWU2ZDAw
YjQyYw0KICAgID4gLS0tIC9kZXYvbnVsbA0KICAgID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Fy
bS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX3JlZ3MuaA0KICAgIA0KICAgIC4uLg0KICAgIA0KICAg
ID4gKw0KICAgID4gKy8qIEltYWdlIHByb2Nlc3MgcmVnaXN0ZXJzICovDQogICAgPiArI2RlZmlu
ZSBJUFNfREVQVEgJCTB4MEQ4DQogICAgPiArI2RlZmluZSBJUFNfUkdCX1JHQl9DT0VGRjAJMHgx
MzANCiAgICA+ICsjZGVmaW5lIElQU19SR0JfWVVWX0NPRUZGMAkweDE3MA0KICAgID4gKw0KICAg
ID4gKyNkZWZpbmUgSVBTX0RFUFRIX01BUksJCTB4Rg0KICAgIA0KICAgIHMvTUFSSy9NQVNLLw0K
ICAgIA0KICAgIENoZWVycywNCiAgICAtQnJpYW4NCiAgICANCg0K
