Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B001C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26F1216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UJvyJDko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26F1216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeI1CvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:51:08 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:54312
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbeI1CvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Altvjro2CKd4cwAD+CaziJA+TXeWrHt0n1kyGsEqLRc=;
 b=UJvyJDko1Amt2lAobusqyjnowjnDGvnMoKiKS8f0fGB4Si4O4RxT1UpeByRp8W8g7KLCc7awH/g0n6Sej+aJYp56A2q6gRDAe8cHVJ1Zm4QCWCTjXOauZPguUdt22ap4mwjABpWU6eIELG5cNfgBUUIOg2mgK0YPz7sAPdf7pd8=
Received: from MWHPR1201MB2541.namprd12.prod.outlook.com (10.172.96.23) by
 MWHPR1201MB0046.namprd12.prod.outlook.com (10.174.98.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Thu, 27 Sep 2018 20:28:06 +0000
Received: from MWHPR1201MB2541.namprd12.prod.outlook.com
 ([fe80::81ca:ee39:9755:a062]) by MWHPR1201MB2541.namprd12.prod.outlook.com
 ([fe80::81ca:ee39:9755:a062%11]) with mapi id 15.20.1143.022; Thu, 27 Sep
 2018 20:28:06 +0000
From:   Jiandi An <jiandi@amd.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "An, Jiandi" <Jiandi.An@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>
Subject: Re: [PATCH 1/1] drm/ttm: Set memory as decrypted for ttm framebuffer
 mappings
Thread-Topic: [PATCH 1/1] drm/ttm: Set memory as decrypted for ttm framebuffer
 mappings
Thread-Index: AQHUOkoUs+ZxM9jdRUOp0Tlo3FvoqaTMIsEA//+5ngCAAQlyAIAArLiAgADvKoCANkrkgA==
Date:   Thu, 27 Sep 2018 20:28:06 +0000
Message-ID: <42ed6188-0479-1ba2-99a0-a725286cf476@amd.com>
References: <20180822185754.104729-1-jiandi.an@amd.com>
 <d22f2dce-7229-aac8-036b-5312927632e4@gmail.com>
 <2eeaae95-181c-b856-09ae-4ee2423fe3fd@amd.com>
 <92cfac31-a408-210a-d901-1e6511a1cb9a@amd.com>
 <3ef2e755-eb99-0e4b-1e0c-c2ae62aafc10@amd.com>
 <b44280d7-eb13-0996-71f5-3fbdeb466801@amd.com>
In-Reply-To: <b44280d7-eb13-0996-71f5-3fbdeb466801@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:300:d4::29) To MWHPR1201MB2541.namprd12.prod.outlook.com
 (2603:10b6:300:e0::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0046;20:XVw3gwCoY652aIrzKRDplJ/pKtYvXvJd+66H66sj8lIU2iFeLu2QbNyy0Ep3N1RPrCx254wUdp8YQpVcjmTB9J4GCO6FNzrJ/pIsTXlCgqZ1Yeuob/SIFUOVx0UKsywYv03h+WPJIRsMqQqMIgL0e/+4/wJPsBiaFmpTk4P8nCZZJoZY2tFfFl5tXtVt54sKte9MYEzSny//u9svvtkDUbXpzV1cZ/gdZMOqZA6sH5lSpGyJ6Q00+GefKqLPBQL+
x-ms-office365-filtering-correlation-id: 5fb0b77f-ab31-4f8b-08d6-08d624b7bb6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0046;
x-ms-traffictypediagnostic: MWHPR1201MB0046:
x-microsoft-antispam-prvs: <MWHPR1201MB00461C7EFD8E132655E12802FD140@MWHPR1201MB0046.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:MWHPR1201MB0046;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0046;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(51914003)(43544003)(229853002)(99286004)(66066001)(2906002)(110136005)(25786009)(2900100001)(2501003)(5250100002)(3846002)(4326008)(6486002)(5660300001)(6246003)(93886005)(256004)(6116002)(54906003)(26005)(102836004)(106356001)(31686004)(966005)(105586002)(72206003)(386003)(478600001)(316002)(14454004)(8676002)(68736007)(81156014)(81166006)(8936002)(97736004)(76176011)(476003)(2616005)(53936002)(31696002)(6306002)(6436002)(34290500001)(7736002)(52116002)(36756003)(305945005)(53546011)(446003)(486006)(71190400001)(6506007)(6512007)(71200400001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0046;H:MWHPR1201MB2541.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OhtIFsMgAncDKk3Jw/44eVz+rDTWIinKfnB7DAz4cJdhp36D6uY456DpNxgFxHFTmenecryYDdI1FNPp0FrgCPPoKUETdPdaFcyA9xmDhxS3Yfhk1lRrUPWhqVghx9QbWN2TvSVE5i4yqzP97zBHQDaBLB4mH+CKxn7eiABXRpgsrTN5ZulSOXcV2Elovalll/YJ7kFulJdFCIht0DYXlQhgS/KoFjka3h1EpQXVtsE4J1q7XApogNDbYYDqah9z0m9TikXAlsqJyOnmh/OxdMi8WEOW2WMJUmQks4OVmCyTqJPBI8fRqwbNupQ1yEp/LwKYkFGMy837K1oPTIH2bIMDQld+1wXc3g8zoi3JC9M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1006887ED6AA984AA1977BD13DEE35D4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb0b77f-ab31-4f8b-08d6-08d624b7bb6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 20:28:06.7238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI0LzIwMTggMDI6MjEgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IEFt
IDI0LjA4LjIwMTggdW0gMDE6MDUgc2NocmllYiBKaWFuZGkgQW46DQo+Pg0KPj4NCj4+IE9uIDA4
LzIzLzIwMTggMDE6NDcgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+Pj4gQW0gMjIuMDgu
MjAxOCB1bSAyMjo1NyBzY2hyaWViIEppYW5kaSBBbjoNCj4+Pj4NCj4+Pj4gT24gMDgvMjIvMjAx
OCAwMjowOSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4+Pj4+IEFtIDIyLjA4LjIwMTgg
dW0gMjA6NTcgc2NocmllYiBKaWFuZGkgQW46DQo+Pj4+Pj4gRnJhbWVidWZmZXIgbWVtb3J5IG5l
ZWRzIHRvIGJlIGFjY2Vzc2VkIGRlY3J5cHRlZC7CoCBFbnN1cmUgdGhlDQo+Pj4+Pj4gbWVtb3J5
IGVuY3J5cHRpb24gbWFzayBpcyBub3Qgc2V0IGZvciB0aGUgdHRtIGZyYW1lYnVmZmVyIG1hcHBp
bmdzLg0KPj4+Pj4gTkFLLCB0aGUgbWVtb3J5IG5vdCBvbmx5IG5lZWRzIHRvIGJlIGRlY3J5cHRl
ZCB3aGlsZSBDUFUgYWNjZXNzZWQgYnV0IGFsbCB0aGUgdGltZS4NCj4+Pj4+DQo+Pj4+PiB0dG1f
cGFnZV9hbGxvYy5jIGFuZCB0dG1fcGFnZV9hbGxvY19kbWEuYyBzaG91bGQgYWxyZWFkeSB0YWtl
IGNhcmUgb2YgdGhhdCB3aGlsZSBtYXBwaW5nIHRoZSBwYWdlcy4NCj4+Pj4+DQo+Pj4+PiBSZWdh
cmRzLA0KPj4+Pj4gQ2hyaXN0aWFuLg0KPj4+Pj4NCj4+Pj4gVGhlIHBhdGggd2hlcmUgdGhlIGlz
c3VlIGNvbWVzIGluIGlzIGJvb3RpbmcgZ3Vlc3Qgd2l0aCBBTUQgU0VWIGVuYWJsZWQgd2hpbGUg
dXNpbmcgdmlydGlvLXZnYSBkZXZpY2UuDQo+Pj4+IFRoZSB0dG0tPnBhZ2VzIGRvZXNuJ3QgZ28g
dGhyb3VnaCB0dG1fcG9wdWxhdGVfYW5kX21hcF9wYWdlcygpLg0KPj4+DQo+Pj4gQW5kIHRoYXQg
aXMgdGhlIHBvaW50IHdoZXJlIHlvdSBuZWVkIHRvIGp1bXAgaW4gYW5kIGZpeCB0aGUgcHJvYmxl
bS4NCj4+Pg0KPj4+IFdoZW4gYSBkcml2ZXIgaW1wbGVtZW50cyB0aGUgcG9wdWxhdGUoKSBhbmQg
dW5wb3B1bGF0ZSgpIGNhbGxiYWNrcyB0aGVtc2VsdmVzIGl0IG5lZWRzIHRvIHRha2UgY2FyZSBv
ZiBhbGwgdGhhdCBoYW5kbGluZy4NCj4+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24gYW5kIGd1
aWRhbmNlLsKgIFNvIHlvdSB3YW50IG1lIHRvIHJlZ2lzdGVyIHRoZSBjYWxsYmFja3Mgc29tZXRo
aW5nIGxpa2UgdmlydGlvX2dwdV90dG1fcG9wdWxhdGUoKSBhbmQgdmlydGlvX2dwdV90dG1fdW5w
b3B1bGF0ZSgpIGluIHRoZSB2aXJ0aW9fZ3B1X2JvX2RyaXZlciwNCj4gDQo+IFllcywgdGhhdCBp
cyBvbmUgcG9zc2liaWxpdHkuIFRoZSBhbHRlcm5hdGl2ZSBpcyBkaXJlY3RseSBoYWNrIHRoYXQg
aW50byB0aGUgdHRtX3R0X3BvcHVsYXRlKCkgYW5kIHR0bV90dF91bnBvcHVsYXRlKCkgZnVuY3Rp
b25zLg0KPiANCj4+IGFuZCBwZXJmb3JtIG1hcHBpbmcgYnkgY2FsbGluZyB0dG1fYm9fa21hcCgp
P8KgIFRoZW4gYnJpbmcgc2V0dGluZyBtZW1vcnkgZGVjcnlwdGVkL2VuY3J5cGVkIGJ5IGNhbGxp
bmcgc2V0X21lbW9yeV9kZWNyeXB0ZWQoKS9zZXRfbWVtb3J5X2VuY3J5cHRlZCgpIG91dHNpZGUg
b2YgdHRtX2JvX2ttYXAoKSwgZG8gaXQgd2l0aGluIHZpcnRpb19ncHVfdHRtX3BvcHVsYXRlKCkg
YW5kIHZpcnRpb19ncHVfdHRtX3VucG9wdWxhdGUoKSBjYWxsYmFja3M/DQo+IA0KPiBObywgZG9u
J3QgY2FsbCB0dG1fYm9fa21hcCgpIGhlcmUuIEkgdGhpbmsgSSBub3cgdW5kZXJzdGFuZCB3aGVy
ZSB3ZSBoYXZlIGEgbWlzdW5kZXJzdGFuZGluZy4NCj4gDQo+IHR0bV9ib19rbWFwKCkganVzdCBj
cmVhdGVzIGEgdm1hcCBvZiB0aGUgb3JpZ2luYWwgcGFnZXMgdG8gbWFrZSB0aGVtIGxvb2sgbGlu
ZWFyIHRvIHRoZSBrZXJuZWwgc3BhY2UuDQo+IA0KPiBXaGF0IHlvdSBuZWVkIHRvIGRvIGluc3Rl
YWQgaXMgdG8gY2hhbmdlIHRoZSBhdHRyaWJ1dGVzIG9mIHRoZSBvcmlnaW5hbCBwYWdlIG1hcHBp
bmcsIG5vdCB0aGUgY29weSBpbiB0aGUgdm1hcC4NCj4gDQo+IEluIG90aGVyIHdvcmRzIHlvdSBz
aG91bGQgY2FsbMKgIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgZm9yIGVhY2ggaW5kaXZpZHVhbGx5
IGFsbG9jYXRlZCBwYWdlLg0KPiANCj4+DQo+PiBUaGVuIGdldCByaWQgb2YgdGhlIHNlcGFyYXRl
IGNhbGwgb2YgdmlydGlvX2dwdV92bWFwX2ZiKCkgdGhlIHZpcnRpb19ncHUgZHJpdmVyIGRvZXM/
DQo+Pg0KPj4+DQo+Pj4+DQo+Pj4+IEluIHRoZSBrZXJuZWwgcGF0aCwgdGhlIHZpcnRpb19ncHUg
ZHJpdmVyIGNhbGxzIHZpcnRpb19ncHVfYWxsb2Nfb2JqZWN0KCkgYW5kIGdvZXMgZG93biB0byB0
dG0gdG8NCj4+Pj4gYWxsb2NhdGUgcGFnZXMgaW4gdHRtX3Bvb2xfcG9wdWxhdGUoKS7CoCBEcml2
ZXIgaW4gZ3Vlc3QgdGhlbiBkb2VzIHZpcnRpb19ncHVfdm1hcF9mYigpIHdoaWNoIGdvZXMNCj4+
Pj4gZG93biB0byB0dG1fYm9fa21hcF90dG0oKSBhbmQgZG9lcyBhIHZtYXAoKSBmb3IgR1ZBIHRv
IEdQQSBmb3IgdGhvc2UgcGFnZXMuwqAgSWYgU0VWIGlzIGVuYWJsZWQsDQo+Pj4+IGRlY3J5cHRp
b24gc2hvdWxkIGJlIHNldCBpbiB0aGlzIEdWQSB0byBHUEEgbWFwcGluZy4NCj4+Pg0KPj4+IFRo
YXQgYXNzdW1wdGlvbiBpcyB3aGF0IGlzIGluY29ycmVjdCBoZXJlLg0KPj4+DQo+Pj4gVFRNIGNh
bid0IHdvcmsgd2l0aCBlbmNyeXB0ZWQgcGFnZXMsIHNvIHlvdSBuZWVkIHRvIHNldCB0aGUgcGFn
ZXMgYXMgZGVjcnlwdGVkIGRpcmVjdGx5IGFmdGVyIGNhbGxpbmcgdHRtX3Bvb2xfcG9wdWxhdGUo
KS4NCj4+Pg0KPj4+IEFuZCBvYnZpb3VzbHkgc2V0IGl0IHRvIGVuY3J5cHRlZCBhZ2FpbiBiZWZv
cmUgY2FsbGluZyB0dG1fcG9vbF91bnBvcHVsYXRlKCkuDQo+Pj4NCj4+PiBQcm9iYWJseSBiZXN0
IGlmIHdlIGFkZCB0aGF0IHRvIHR0bV90dF9wb3B1bGF0ZSgpL3R0bV90dF91bnBvcHVsYXRlKCku
DQo+Pg0KPj4gSGVyZSB3aGVuIHlvdSBzYXkgdHRtX3R0X3BvcHVsYXRlKCkgYW5kIHR0bV90dF91
bnBvcHVsYXRlKCkgeW91IG1lYW4gdGhlIHZpcnRpb19ncHVfdHRtX3BvcHVsYXRlKCkgYW5kIHZp
cnRpb19ncHVfdHRtX3VucG9wdWxhdGUoKSB0aGF0IEkgcmVnaXN0ZXIgaW4gdmlydGlvX2dwdV9i
b19kcml2ZXIgcmlnaHQ/DQo+IA0KPiBFaXRoZXIgYXMgZHJpdmVyIHNwZWNpZmljIGNhbGxiYWNr
cyBvciBkaXJlY3RseSBpbiB0aGUgZmFsbGJhY2sgcGF0aCBvZiB0dG1fdHRfcG9wdWxhdGUoKSBh
bmQgdHRtX3R0X3VucG9wdWxhdGUoKS4NCj4gDQoNCkFmdGVyIHdvcmtpbmcgYW5kIHRlc3Rpbmcg
d2l0aCBHZXJkIEhvZmZtYW5uJ3MgcGF0Y2hlcywgZ2V0dGluZyB2aXJ0aW8tZ3B1IGZyYW1lYnVm
ZmVyIHBhZ2VzIHRvDQpnbyB0aHJvdWdoIGRtYS1hcGkgaXMgbW9yZSBhcHByb3ByaWF0ZSBmaXgg
YW5kIGlzIHdoYXQgd2Ugd291bGQgbGlrZSB0byBkbyBmb3IgU0VWIGFzIHdlbGwuDQoNCkdlcmQg
SG9mZm1hbm4ncyBwYXRjaGVzIHRvIGFkZCBpb21tdSBzdXBwb3J0IGZvciB2aXJ0aW8tZ3B1IGlu
IFFFTVUgYW5kIGtlcm5lbCB0b2dldGhlciB0byBhbGxvdw0KaW9tbXVfcGxhdGZvcm0gYXR0cmli
dXRlIHRvIGJlIHNwZWNpZmllZCBmb3IgdmlydGlvLWdwdSBkZXZpY2VzIGluIHFlbXUgY29tbWFu
ZCBsaW5lIGFuZCB0aGUgdHRtDQpwYWdlcyBmb3IgdmlydGlvLWdwdSBmcmFtZWJ1ZmZlcnMgdG8g
Z28gdGhyb3VnaCBkbWEtYXBpLiAgVGhpcyBzb2x2ZXMgdGhlIGlzc3VlIGZvciBTRVYgYXMgU0VW
DQpmb3JjZXMgZG1hLWFwaSB0byBnbyB0byBzd2lvdGxiIGZvciBib3VuY2UgYnVmZmVyIGFuZCB0
aGF0J3Mgc2V0IGFzIGRlY3J5cHRlZC4NCg0KR2VyZCBIb2ZmbWFubiBRRU1VIHBhdGNoDQpodHRw
czovL2dpdC5rcmF4ZWwub3JnL2NnaXQvcWVtdS9jb21taXQvP2g9c2lyaXVzL3ZpcnRpby1ncHUt
aW9tbXUmaWQ9NTg4ZWJkMDJlOWRhZWRkNmUxYzU0NTNlZjgyOGMwNjRhMTZlNDNjMyANCmh0dHBz
Oi8vZ2l0LmtyYXhlbC5vcmcvY2dpdC9xZW11L2NvbW1pdC8/aD1zaXJpdXMvdmlydGlvLWdwdS1p
b21tdSZpZD04NmY5ZDMwZTRhNDRjYTQ3ZjAwN2U1MWFiNTc0NGY4N2U3OWZiODNlIA0KDQpHZXJk
IEhvZmZtYW5uIEtlcm5lbCBwYXRjaA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4
MDgyOTEyMjAyNi4yNzAxMi0yLWtyYXhlbEByZWRoYXQuY29tLw0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDE4MDgyOTEyMjAyNi4yNzAxMi0zLWtyYXhlbEByZWRoYXQuY29tLyANCg0K
R2VyZCBIb2ZmbWFubidzIGtlcm5lbCBwYXRjaCBpcyBtaXNzaW5nIGRtYV9zeW5jLCBncmFwaGlj
YWwgc2NyZWVuIHR1cm5zIGJsYWNrIGJsYW5rIHNjcmVlbi4NCkZpeCBpcyB0aGUgZm9sbG93aW5n
IHR3byBwYXRjaGVzDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgwOTE5MTEzNDA2
LnVraGdiaXVreDd2c3VpbndAc2lyaXVzLmhvbWUua3JheGVsLm9yZy8gDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sL2ZmYzA4ZDRlLTVkYTgtNzYzMS00MzhmLTMxMWZkMDU2NDg2NEBhbWQu
Y29tLw0KDQotIEppYW5kaQ0KDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4gDQo=
