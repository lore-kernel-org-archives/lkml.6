Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09631C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD312173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x8rRLNCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfAGPNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:13:53 -0500
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:34784
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727161AbfAGPNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFzewsxNVsUwduJrdBFHJBdNWSwqPzDls4czAeo31No=;
 b=x8rRLNCC9COaFKAFNdpk7kwqaRhaZSyZ1vZ0LwuPNSkelfqmVX8UnxyE1s7lesff5zU1CGxa/SIV9iub0Zjd6LBA/mS9XofY+bOTO17JTTTTAOjH9kt0Pp/JaVHkF9gkYqk8jFReROKCZdA3Wk4y1aBcibhlMZexpg0f6yD4H7Y=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 15:13:49 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a%3]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 15:13:49 +0000
From:   S@vger.kernel.org
To:     Borislav Petkov <bp@alien8.de>, "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] x86/mce/amd: apply missing quirks for family 15
 models
Thread-Topic: [PATCH 0/2] x86/mce/amd: apply missing quirks for family 15
 models
Thread-Index: AQHUpnTwU/LtRrDUoUWagrKeCoPsL6WjqjIAgABDqQA=
Date:   Mon, 7 Jan 2019 15:13:49 +0000
Message-ID: <7d6aa3af-092a-db11-0985-13c2d729340d@amd.com>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <20190107112430.GA28223@nazgul.tnic>
In-Reply-To: <20190107112430.GA28223@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3248;20:Rat2wi1/AkMmGHC8O/9kjvBkxZqf1m8vLkEfGIZBjGuf3jLhClvnhTMJofnL8hSOjHVjnHmuAS4Y3kXyYLWbpir/wWkZ5H6aq0/QDj3pqEn5iE7XcD2ItrpYt32ZoY0K6ORrD1idd8j/NQMLKoSmtM2va1u1/flS9ZsgfHtRPRn+6XB6NHRhOYFrvIWBQ4WMCM71SIyRtDbG4eOFwGqA+gHamaiV+Ec7rpM5caPqJRPlRVzJIDFcXqRLpfsf0otk
x-ms-office365-filtering-correlation-id: 0ed2712e-6f32-44b9-4891-08d674b2b9c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3248;
x-ms-traffictypediagnostic: MN2PR12MB3248:
x-microsoft-antispam-prvs: <MN2PR12MB3248AABCB3A904954E5F010CF2890@MN2PR12MB3248.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MN2PR12MB3248;BCL:0;PCL:0;RULEID:;SRVR:MN2PR12MB3248;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(51344004)(189003)(199004)(54534003)(106356001)(11346002)(486006)(6436002)(2906002)(6506007)(36756003)(446003)(476003)(31696002)(229853002)(2616005)(6306002)(66066001)(3846002)(71200400001)(105586002)(6116002)(99286004)(71190400001)(6512007)(6486002)(53546011)(76176011)(110136005)(186003)(26005)(8676002)(81166006)(81156014)(7736002)(31686004)(54906003)(316002)(305945005)(102836004)(72206003)(6246003)(53936002)(25786009)(52116002)(68736007)(386003)(8936002)(97736004)(6636002)(14454004)(478600001)(14444005)(966005)(256004)(5660300001)(4326008)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3248;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0oRJGvafrW2OXuxBBqjKRg9UOwYrrrAk+deXw4rDqIIYOfCDfLpkMNYIDmoWLtifKqTiSvlYpsW975/LRGkZEktADSA668plauafsv3EI4CHxUcnsDOd8kVNjpm/kE7JodV4NjnkBYgD7XItRgaWqCafJzO/9VPdoT2nFHSqZ1d8gLkrpw9lFU418BtA46M2elnIz/JBb1HF2XBCYusMvxl3eSN7hzSh/Twcb6ERHp8owf8lKlVD56Lk2m9r/yfIxq4Mqckb0yz3Jdb5/xTNScJoYEKNWihXO42G42UYNiHh7C+qeFLA9z0SkuSwxp0d
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5CEA9E185255348A18575A6C72DE04F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed2712e-6f32-44b9-4891-08d674b2b9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 15:13:49.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzcvMjAxOSA0OjU0IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIE1vbiwg
SmFuIDA3LCAyMDE5IGF0IDEwOjM3OjA3QU0gKzAwMDAsIFMsIFNoaXJpc2ggd3JvdGU6DQo+PiBU
aGlzIHBhdGNoIHNlcmllcyBhcHBsaWVzIHRvIGZhbWlseSAxNSBDUFUncyBvZiBBTUQgcGxhdGZv
cm1zLA0KPj4gc28gYXMgdG8gYWRkcmVzcyBhIGNvbnNpc3RlbnQgd2FybmluZyBvZg0KPj4gICAi
W0Zpcm13YXJlIEJ1Z106IGNwdSAwLCBpbnZhbGlkIHRocmVzaG9sZCBpbnRlcnJ1cHQgb2Zmc2V0
Ig0KPj4gYXQgZXZlcnkgYm9vdCBhbmQgdXBvbiBjb21wbGV0aW9uZyBvZiBzdWNjZXNzZnVsIFMz
IGN5Y2xlLA0KPj4gZHVlIHRvIGEgbWlzc2luZyBxdWlyaywgd2hpY2ggd2FzIG5vdCBleHRlbmRl
ZCB0byBuZXdlciBtb2RlbHMNCj4+IGFuZCBhbHNvIG5vdCBhcHBsaWVkIGluIHJlc3VtZSBwYXRo
Lg0KPj4NCj4+IFNoaXJpc2ggUyAoMik6DQo+PiAgICB4ODYvbWNlL2FtZDogRXh0ZW5kICJEaXNh
YmxlIGVycm9yIHRocmVzaG9sZGluZyBiYW5rIDQiIHRvIG1vcmUgbW9kZWxzDQo+PiAgICB4ODYv
bWNlL2FtZDogRW5zdXJlIHF1aXJrcyBhcmUgYXBwbGllZCBpbiByZXN1bWUgcGF0aCBhcyB3ZWxs
DQo+Pg0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQuYyAgfCAzNCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2Nv
cmUuYyB8ICAyICstDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4NCj4+IC0tIA0KPiBZb3Ugc2VudCB0aG9zZSBvbmNlIHRocmVlIGRheXMg
YWdvLiBXaHkgYXJlIHlvdSBzZW5kaW5nIHRoZW0gYWdhaW4/DQo+IFRoZXJlJ3Mgbm8gY2hhbmdl
bG9nIHRvIGV4cGxhaW4gd2hhdCB0aGUgZGlmZmVyZW5jZSBpcyBmcm9tIHRoZSBsYXN0DQo+IHN1
Ym1pc3Npb24gc28gd2hhdCdzIHVwPw0KDQpJIGZvdW5kIHRoYXQgdGhlIGdldF9tYWludGFpbmVy
cy5wbCBkaWQgbm90IGFkZCBhbnlvbmUgYnV0IG1lIGZvciB0aGUgDQpjb3ZlciBsZXR0ZXIuDQoN
CkhlbmNlIGkgaGF2ZSByZS1zZW50IHRoZSBlbnRpcmUgc2VyaWVzIGFsb25nIHdpdGggY292ZXIg
bGV0dGVyIHNvIHRoYXQgdGhlDQoNCnJldmlld2VycyB3b3VsZCBnZXQgY29udGV4dC4NCg0KPiBB
bHNvLCBJJ2Qgc3VnZ2VzdCB5b3UgaGF2ZSBtb3JlIHBhdGllbmNlLg0KDQpTdXJlLCBJIHdpbGwg
d2FpdCwgbm8gd29ycmllcy4NCg0KUmVnYXJkcywNCg0KU2hpcmlzaCBTDQoNCj4gICBBbmQgd2hp
bGUgeW91IHdhaXQsIHlvdSBjYW4NCj4gdGFrZSBhIGxvb2sgYXQNCj4NCj4gaHR0cHM6Ly93d3cu
a2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRt
bA0KPg0KPiB0byByZWFkIHVwIG9uIGFsbCB0aGUgbW9kYWxpdGllcyB3aGVuIHNlbmRpbmcgcGF0
Y2hlcy4NCj4NCj4gVGh4Lg0KPg0KLS0gDQpSZWdhcmRzLA0KU2hpcmlzaCBTDQoNCg==
