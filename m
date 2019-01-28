Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E3EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF6420989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="T1Ah+Ziv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfA1OHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:07:41 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:6592
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbfA1OHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn4CUZJCPDwnxWagAZd+xZxy4a7zFmCIRYb9qz0/Y6E=;
 b=T1Ah+ZivK6iaAPLMouTyWPg2sHcycKFxX99eZ4Ru4+8zXMz0UqDSug/EwfO0jrz/SXaHA3teb9b2n4n6AUO855E4rHLL17S2/1iLtMOQ3tpi3UJzUSddWXLnxYzAq2B2FV5d4vk6SwQr28Pm8Wouxx1N24HxFZoDvuneeXZ1yPg=
Received: from AM6PR08MB3365.eurprd08.prod.outlook.com (20.177.112.214) by
 AM6PR08MB3384.eurprd08.prod.outlook.com (20.177.112.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 14:04:43 +0000
Received: from AM6PR08MB3365.eurprd08.prod.outlook.com
 ([fe80::c990:1662:320a:dacc]) by AM6PR08MB3365.eurprd08.prod.outlook.com
 ([fe80::c990:1662:320a:dacc%5]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 14:04:43 +0000
From:   Qais Yousef <Qais.Yousef@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Juri Lelli <juri.lelli@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Thread-Topic: [PATCH 0/3] drivers: Frequency constraint infrastructure
Thread-Index: AQHUtw7cjuSMdLHsTE6mmnhVRJOqY6XEtrWA
Date:   Mon, 28 Jan 2019 14:04:42 +0000
Message-ID: <20190128140441.yetyx7hgtdoyk4mn@e107158-lin.cambridge.arm.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190117131631.GA14385@localhost.localdomain>
 <CAJZ5v0jFqXGf_G2v1VNXSxyiDzgeFY8OKUFu2tQ8Wso3dBS+_w@mail.gmail.com>
 <20190118123900.GJ14385@localhost.localdomain>
 <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
 <CA+mqd+7EqERei8eekAsVxa_bJUYETyO3T76L8Q_sV=C9rwiy3g@mail.gmail.com>
In-Reply-To: <CA+mqd+7EqERei8eekAsVxa_bJUYETyO3T76L8Q_sV=C9rwiy3g@mail.gmail.com>
Reply-To: "CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com" 
          <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::21) To AM6PR08MB3365.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Qais.Yousef@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3384;6:dtSlLZAJ0RqQBb8NRc1bTWWbMGY4o2KJvEu9C1j8EUnxqsP+aGleNIczCkj9E0CZP/W630PVUhoUxHm8uhDT0DJ4674p4zvXCQ22VxCQmM79mtY2+AOwzBRc6uNszBFtgx60fZjUtRx/TwLuUR7ECKlbpKMzWIqx+8igSzesj4Xpgf2A2RCTwowHi/mam8y1Zs8VlsNDh6pDViVr+l8X9JhBWxH2sDhEEE4PNhAJeYuc8C5hyUEbS8x0W+XQdkjOKghq/Uy+479KedATYLSzzIYrvYPsQ7J24pLCsTAXe+M2gzwRHc/isCYqn53uV2DlGH14sgID4t8iaT1Q1ZXSm/oVP+7obRszhVKO/mrvT4gUGQfRPYGOx51IC2jJGpQig36evVPBh7Irv82B37DkxgPOY9SxoyntfNPQqzZeGBRBqvC4n4ubYigJf8+V7RDWvwFbt0YLdDC9nfn8DnOkSA==;5:d8x/n1S/pTeZw1jfRFhbchhfzm45CK/AU8r4CEm5EHUdg2qOl6f4VAWSJ+KeIyzn2bMJTIuIusofOxuU3ko4VVadoTCfwlVGljHSqs8EekGMbDZHi8ua/5CRTs1y/i3FKfQIZqWySS3E0imD2r7Ela3OfK+lOKPc2XE9s3ouSgTmS9S5ebQvGVoWxMU5F1VQwGzPP6Z9F+2DGFlPmYpZIA==;7:dDn1ZqWA8MCnZIq+LLvOi7Jn9zUxHM5JkQCOKxyi69JlN8n74RT7NuVs0URkxhrDk6oiRk1g2+ekeCklXFpXPx3+Xqu97Rec2A2KlJWFiJOjImYC+sCXY5H8DOXkE6tCxiDCv+2FrsIKH842Y38stw==
x-ms-office365-filtering-correlation-id: 58499057-bc75-4fb1-3e4c-08d685298d0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3384;
x-ms-traffictypediagnostic: AM6PR08MB3384:
x-microsoft-antispam-prvs: <AM6PR08MB3384418711A41CBD1E9E2DB4FC960@AM6PR08MB3384.eurprd08.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(366004)(40434004)(199004)(189003)(86362001)(25786009)(26005)(305945005)(478600001)(97736004)(561944003)(71190400001)(4326008)(93886005)(71200400001)(81156014)(54906003)(72206003)(1076003)(102836004)(81166006)(186003)(68736007)(14444005)(7736002)(229853002)(99286004)(8676002)(43066004)(256004)(5024004)(316002)(53936002)(76176011)(52116002)(44832011)(6506007)(53546011)(7416002)(486006)(386003)(11346002)(476003)(8936002)(39060400002)(14454004)(446003)(6512007)(6486002)(6916009)(6116002)(2906002)(3846002)(106356001)(66066001)(105586002)(6246003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3384;H:AM6PR08MB3365.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zWOKzhV1nWp2m0/xmLeUVlLGAZ9neF5QppXRmtTcchm2RA5YeX3j2ILhpWCdyjNaBN3UuVN/pfeUyVn6xjDuRMGrmGJilQi4Oa3j375OynUzaMz8tAMPUiK8QqHDk1IfFl8EWvCQBe5+snucnLKxaCBE9hS2TcwX9900H+wu+uVL3JqsRbp8wGe0/Aeun29QVw+HweUFen/X3gIkgMYQ2a7/3K12y8u6FgtK8mbRpmWIeZwc+XW0sXjb2Los7CoooGPJOLdD1b/xVdOWGGx8wbKPhiUjznMoYoy7BJgFCKhU8H21RGD3Pdwn4u2EkyHzEUV4AcBrQmbQxr60hOs9xfAHCxpTBZJDnBYG9KFg8Ly7KDDmkJvgSrqjXAR9ulYdvAzk3YAKEgotqeu1bKzK0FEzV7+27FZBpN5nvZk7wFk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A8FE7A5F49D1E4EBE68DCF52829E318@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58499057-bc75-4fb1-3e4c-08d685298d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 14:04:42.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAxOjM5IFBNIEp1cmkgTGVsbGkgPGp1cmkubGVsbGlA
Z21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIDE3LzAxLzE5IDE1OjU1LCBSYWZhZWwgSi4g
V3lzb2NraSB3cm90ZToNCj4gPiA+IE9uIFRodSwgSmFuIDE3LCAyMDE5IGF0IDI6MTYgUE0gSnVy
aSBMZWxsaSA8anVyaS5sZWxsaUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBP
biAxMS8wMS8xOSAxMDo0NywgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiA+ID4gT24g
RnJpLCBKYW4gMTEsIDIwMTkgYXQgMTA6MTggQU0gVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJA
bGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSGksDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBjb21taXQgaW50cm9kdWNlcyB0aGUgZnJlcXVlbmN5IGNv
bnN0cmFpbnQgaW5mcmFzdHJ1Y3R1cmUsIHdoaWNoDQo+ID4gPiA+ID4gPiBwcm92aWRlcyBhIGdl
bmVyaWMgaW50ZXJmYWNlIGZvciBwYXJ0cyBvZiB0aGUga2VybmVsIHRvIGNvbnN0cmFpbnQgdGhl
DQo+ID4gPiA+ID4gPiB3b3JraW5nIGZyZXF1ZW5jeSByYW5nZSBvZiBhIGRldmljZS4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGUgcHJpbWFyeSB1c2VycyBvZiB0aGlzIGFyZSB0aGUgY3B1
ZnJlcSBhbmQgZGV2ZnJlcSBmcmFtZXdvcmtzLiBUaGUNCj4gPiA+ID4gPiA+IGNwdWZyZXEgZnJh
bWV3b3JrIGFscmVhZHkgaW1wbGVtZW50cyBzdWNoIGNvbnN0cmFpbnRzIHdpdGggaGVscCBvZg0K
PiA+ID4gPiA+ID4gbm90aWZpZXIgY2hhaW5zIChmb3IgdGhlcm1hbCBhbmQgb3RoZXIgY29uc3Ry
YWludHMpIGFuZCBzb21lIGxvY2FsIGNvZGUNCj4gPiA+ID4gPiA+IChmb3IgdXNlci1zcGFjZSBj
b25zdHJhaW50cykuIFRoZSBkZXZmcmVxIGZyYW1ld29yayBkZXZlbG9wZXJzIGhhdmUgYWxzbw0K
PiA+ID4gPiA+ID4gc2hvd24gaW50ZXJlc3QgWzFdIGluIHN1Y2ggYSBmcmFtZXdvcmssIHdoaWNo
IG1heSB1c2UgaXQgYXQgYSBsYXRlcg0KPiA+ID4gPiA+ID4gcG9pbnQgb2YgdGltZS4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGUgaWRlYSBoZXJlIGlzIHRvIHByb3ZpZGUgYSBnZW5lcmlj
IGludGVyZmFjZSBhbmQgZ2V0IHJpZCBvZiB0aGUNCj4gPiA+ID4gPiA+IG5vdGlmaWVyIGJhc2Vk
IG1lY2hhbmlzbS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPbmx5IG9uZSBjb25zdHJhaW50
IGlzIGFkZGVkIGZvciBub3cgZm9yIHRoZSBjcHVmcmVxIGZyYW1ld29yayBhbmQgdGhlDQo+ID4g
PiA+ID4gPiByZXN0IHdpbGwgZm9sbG93IGFmdGVyIHRoaXMgc3R1ZmYgaXMgbWVyZ2VkLg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE1hdHRoaWFzIEthZWhsY2tlIHdhcyBpbnZvbHZlZCBpbiB0
aGUgcHJlcGFyYXRpb24gb2YgdGhlIGZpcnN0IGRyYWZ0IG9mDQo+ID4gPiA+ID4gPiB0aGlzIHdv
cmsgYW5kIHNvIEkgaGF2ZSBhZGRlZCBoaW0gYXMgQ28tYXV0aG9yIHRvIHRoZSBmaXJzdCBwYXRj
aC4NCj4gPiA+ID4gPiA+IFRoYW5rcyBNYXR0aGlhcy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiBGV0lXLCBUaGlzIGRvZXNuJ3QgaGF2ZSBhbnl0aGluZyB0byBkbyB3aXRoIHRoZSBib290LWNv
bnN0cmFpbnRzDQo+ID4gPiA+ID4gPiBmcmFtZXdvcmsgWzJdIEkgd2FzIHRyeWluZyB0byB1cHN0
cmVhbSBlYXJsaWVyIDopDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGlzIHF1aXRlIGEgYml0
IG9mIGNvZGUgdG8gcmV2aWV3LCBzbyBpdCB3aWxsIHRha2Ugc29tZSB0aW1lLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gT25lIGltbWVkaWF0ZSBvYnNlcnZhdGlvbiBpcyB0aGF0IGl0IHNlZW1zIHRv
IGRvIHF1aXRlIGEgYml0IG9mIHdoYXQNCj4gPiA+ID4gPiBpcyBkb25lIGluIHRoZSBQTSBRb1Mg
ZnJhbWV3b3JrLCBzbyBtYXliZSB0aGVyZSBpcyBhbiBvcHBvcnR1bml0eSBmb3INCj4gPiA+ID4g
PiBzb21lIGNvbnNvbGlkYXRpb24gaW4gdGhlcmUuDQo+ID4gPiA+DQo+ID4gPiA+IFJpZ2h0LCBo
YWQgdGhlIHNhbWUgaW1wcmVzc2lvbi4gOi0pDQo+ID4gPiA+DQo+ID4gPiA+IEkgd2FzIGFsc28g
d29uZGVyaW5nIGhvdyB0aGlzIG5ldyBmcmFtZXdvcmsgaXMgZGVhbGluZyB3aXRoDQo+ID4gPiA+
IGNvbnN0cmFpbnRzL3JlcXVlc3QgaW1wb3NlZC9nZW5lcmF0ZWQgYnkgdGhlIHNjaGVkdWxlciBh
bmQgcmVsYXRlZA0KPiA+ID4gPiBpbnRlcmZhY2VzICh0aGlua2luZyBhYm91dCBzY2hlZHV0aWwg
YW5kIFBhdHJpY2sncyB1dGlsX2NsYW1wKS4NCj4gPiA+DQo+ID4gPiBNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgaXQgaXMgb3J0aG9nb25hbCB0byB0aGVtLCBsaWtlIGFkZGluZyBleHRyYQ0KPiA+
ID4gY29uc3RyYWludHMgb24gdG9wIG9mIHRoZW0gZXRjLg0KPiA+DQo+ID4gTW1tLCBvay4gQnV0
LCBpZiB0aGF0IGlzIGluZGVlZCB0aGUgY2FzZSwgSSBub3cgd29uZGVyIHdoeSBhbmQgaG93DQo+
ID4gZXhpc3RpbmcgKG9yIGhvcGVmdWxseSB0byBiZSBhZGRlZCBzb29uKSBpbnRlcmZhY2VzIGFy
ZSBub3Qgc3VmZmljaWVudC4NCj4gPiBJJ20gbm90IGFnYWluc3QgdGhpcyBwcm9wb3NhbCwganVz
dCB0cnlpbmcgdG8gdW5kZXJzdGFuZCBpZiB0aGlzIG1pZ2h0DQo+ID4gY3JlYXRlIHVud2FudGVk
LCBoYXJkIHRvIG1hbmFnZSwgb3ZlcmxhcC4NCg0KSSBlY2hvIHRoZXNlIGNvbmNlcm5zIGFzIHdl
bGwuDQoNCj4NCj4gVGhhdCBpcyBhIHZhbGlkIGNvbmNlcm4gSU1PLiAgRXNwZWNpYWxseSB0aGUg
dXRpbGl6YXRpb24gY2xhbXBpbmcgYW5kDQo+IHRoZSBpbnRlcmNvbm5lY3QgZnJhbWV3b3JrIHNl
ZW0gdG8gYXBwcm9hY2ggdGhlIHNhbWUgcHJvYmxlbSBzcGFjZQ0KPiBmcm9tIGRpZmZlcmVudCBk
aXJlY3Rpb25zLg0KPg0KPiBGb3IgY3B1ZnJlcSB0aGlzIHdvcmsgY2FuIGJlIHJlZ2FyZGVkIGFz
IGEgcmVwbGFjZW1lbnQgZm9yIG5vdGlmaWVycw0KPiB3aGljaCBhcmUgYSBiYW5kYWlkIG9mIHNv
cnRzIGFuZCBpdCB3b3VsZCBiZSBnb29kIHRvIGdldCByaWQgb2YgdGhlbS4NCj4gVGhleSBhcmUg
bW9zdGx5IHVzZWQgZm9yIHRoZXJtYWwgbWFuYWdlbWVudCBhbmQgSSBndWVzcyB0aGF0IGRldmZy
ZXENCj4gdXNlcnMgYWxzbyBtYXkgd2FudCB0byByZWR1Y2UgZnJlcXVlbmN5IGZvciB0aGVybWFs
IHJlYXNvbnMgYW5kIEknZA0KPiByYXRoZXIgbm90IGFkZCBub3RpZmllcnMgdG8gdGhhdCBmcmFt
ZXdvcmsgZm9yIHRoaXMgcHVycG9zZS4NCj4NCj4gSG93ZXZlciwgYXMgc3RhdGVkIHByZXZpb3Vz
bHksIHRoaXMgcmVzZW1ibGVzIHRoZSBQTSBRb1MgZnJhbWV3b3JrDQo+IHF1aXRlIGEgYml0IHRv
IG1lIGFuZCB3aGF0ZXZlciB0aGVybWFsIGVudGl0eSwgc2F5LCBzZXRzIHRoZXNlDQo+IGNvbnN0
cmFpbnRzLCBpdCBzaG91bGQgbm90IHdvcmsgYWdhaW5zdCBzY2hlZHV0aWwgYW5kIHNpbWlsYXIu
ICBJbg0KDQpCdXQgd2UgaGF2ZSBubyB3YXkgdG8gZW5mb3JjZSB0aGlzLCBubz8gSSdtIHRoaW5r
aW5nIGlmIGZyZXF1ZW5jeSBjYW4gYmUNCmNvbnN0cmFpbmVkIGluIFBNIFFvUyBmcmFtZXdvcmss
IHRoZW4gd2Ugd2lsbCBlbmQgdXAgd2l0aCBzb21lIGRyaXZlcnMgdGhhdA0KdGhpbmsgaXQncyBh
IGdvb2QgaWRlYSB0byB1c2UgaXQgYW5kIHBvdGVudGlhbGx5IGVuZCB1cCBicmVha2luZyB0aGlz
ICJzaG91bGQNCm5vdCB3b3JrIGFnYWluc3Qgc2NoZWR1dGlsIGFuZCBzaW1pbGFyIi4NCg0KT3Ig
ZGlkIEkgbWlzcyBzb21ldGhpbmc/DQoNCk15IHBvaW50IGlzIHRoYXQgaWYgd2UgaW50cm9kdWNl
IHNvbWV0aGluZyB0b28gZ2VuZXJpYyB3ZSBtaWdodCBlbmQgdXANCmVuY291cmFnaW5nIG1vcmUg
dXNlcnMgYW5kIGVuZCB1cCB3aXRoIGEgY29tcGxleCBzZXQgb2YgcnVsZXMvaW50ZXJhY3Rpb25z
IGFuZA0KbG9zZSBzb21lIGRldGVybWluaXNtLiBCdXQgSSBjb3VsZCBiZSByZWFkaW5nIHRvbyBt
dWNoIGludG8gaXQgOi0pDQoNCkNoZWVycw0KDQotLQ0KUWFpcyBZb3VzZWYNCg0KPiBzb21lIHNp
dHVhdGlvbnMgc2V0dGluZyBhIG1heCBmcmVxdWVuY3kgbGltaXQgdG8gY29udHJvbCB0aGVybWFs
cyBpcw0KPiBub3QgdGhlIG1vc3QgZWZmaWNpZW50IHdheSB0byBnbyBhcyBpdCBlZmZlY3RpdmVs
eSB0dXJucyBpbnRvDQo+IHRocm90dGxpbmcgYW5kIG1ha2VzIHBlcmZvcm1hbmNlIGdvIHNvdXRo
LiAgRm9yIGV4YW1wbGUsIGl0IG1heSBjYXVzZQ0KPiB0aGluZ3MgdG8gcnVuIGF0IHRoZSBsaW1p
dCBmcmVxdWVuY3kgYWxsIHRoZSB0aW1lIHdoaWNoIG1heSBiZSB0b28NCj4gc2xvdyBhbmQgaXQg
bWF5IGJlIG1vcmUgZWZmaWNpZW50IHRvIGFsbG93IGhpZ2hlciBmcmVxdWVuY2llcyB0byBiZQ0K
PiB1c2VkLCBidXQgaW5zdGVhZCBjb250cm9sIGhvdyBtdWNoIG9mIHRoZSB0aW1lIHRoZXkgY2Fu
IGJlIHVzZWQuICBTbw0KPiB3ZSBuZWVkIHRvIGJlIGNhcmVmdWwgaGVyZS4NCklNUE9SVEFOVCBO
T1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJl
IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24s
IHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9u
IGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
