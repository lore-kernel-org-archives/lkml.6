Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0918C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCFA2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s74v99vB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCFA2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJIB27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:28:59 -0400
Received: from mail-eopbgr700051.outbound.protection.outlook.com ([40.107.70.51]:43837
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeJIB27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRgQEkyBUTV5eifNKs/Pp6Ua4Y4i5r/HehyQA8GG8Jk=;
 b=s74v99vBc/gWySwfZYxW+CQHVPoUTrKE5hwQJv6CYHc6nwSxiQb3qfRiIuiTKMNDC4cGDWZHUU9AVUF8nf7VDLPmOwFggxQ9tGs7YM9nQ3IHFd8QkRZYKmsvChl1WnamcQoz9+ftAYotbPdOdJUbUV2iAL2WiQS7kiZbPvPwAzk=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1794.namprd12.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.19; Mon, 8 Oct 2018 18:13:56 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05%12]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:13:56 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Thread-Topic: [PATCH] amdgpu/gmc : fix compile warning
Thread-Index: AQHUXINz8METxdpO60GfNTlgx6+1AqUQVG0AgASscICAAFz5gIAABCGAgAAGYYCAAB3BgIAAF8yAgAAGwgCAAAejAA==
Date:   Mon, 8 Oct 2018 18:13:56 +0000
Message-ID: <4a1faa3b-8c42-b742-9b55-9d2711f7ecc1@amd.com>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <c6880c5b-e259-4923-8d5a-80c620563398@amd.com>
 <20181008174628.GB11442@roeck-us.net>
In-Reply-To: <20181008174628.GB11442@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: HE1PR05CA0375.eurprd05.prod.outlook.com
 (2603:10a6:7:94::34) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1794;20:mXA1lPq4S0N8wtvWjqfUDxmMQ5Vtz36VQm3nN+EcJrgEY110ybaQ6+VtYNmcYRhp+xa0/btfW2cRRYWOdKYlI8irx697YaJ7cObxTsgMvAd9S16xivL1cB0DT9rEk/lfezkLcfY21qRVC5BTSpVz+Qs422NHWAG9BpesS6QkPOFWX6F3ZgV+dECkgUNd58JgxId/cFHANrFDIfdaFGCpC/vCE+rr1ZulolCUlve9pKYtY8QapH2BmOmJk0a/esMC
x-ms-office365-filtering-correlation-id: bce00cf4-9929-4813-bf9f-08d62d49cf76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1794;
x-ms-traffictypediagnostic: BN6PR12MB1794:
x-microsoft-antispam-prvs: <BN6PR12MB1794890F4AE2769B4459EE2F83E60@BN6PR12MB1794.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BN6PR12MB1794;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1794;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(6486002)(93886005)(6116002)(81166006)(316002)(81156014)(2900100001)(31686004)(229853002)(386003)(102836004)(71200400001)(7736002)(6246003)(8936002)(6436002)(14444005)(97736004)(36756003)(2906002)(106356001)(305945005)(71190400001)(6506007)(6512007)(256004)(8676002)(105586002)(65956001)(186003)(52116002)(65806001)(11346002)(68736007)(446003)(86362001)(53936002)(4326008)(31696002)(5250100002)(476003)(486006)(46003)(478600001)(25786009)(65826007)(5660300001)(72206003)(6916009)(14454004)(99286004)(58126008)(76176011)(2616005)(64126003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1794;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FLUN4uKQw6c9UR/4fEAKO5gApnD7ojYcvNIx0LOCjxDpFnJzO8QpCUxNh/BFYRFnNoWE611LZA9h56WRSyi+4y2yBJH6CWYlW4p/AkOj3Q0J/q9/3lxUoJwmr+bgWGmA9Rkq6EaI3ZX5gj/u8D85inyfnOXOINPrAZ8lIvFXCi25sEbKinfb7eosVk1RDpt9wI0/INdcyITUhoxuKHig4K82U9u4+Xq/lBpmFSwdVJnJJObOA0TZlo9LuGDL1ULMmzUBHy+VnMVWJhL6lGLQUJ4K7s3qoYoogGydDnevnCGcY5JIpPN4aHJnp75ZXsNXlISok2yjgx5FQGO5Qezn2gwqUFUGj5xJr92DAG1zt3c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF023832E9E29E4AA1E95402F773B6D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce00cf4-9929-4813-bf9f-08d62d49cf76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:13:56.1096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDguMTAuMjAxOCB1bSAxOTo0NiBzY2hyaWViIEd1ZW50ZXIgUm9lY2s6DQo+IE9uIE1vbiwg
T2N0IDA4LCAyMDE4IGF0IDA1OjIyOjI0UE0gKzAwMDAsIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3Rl
Og0KPj4gQW0gMDguMTAuMjAxOCB1bSAxNzo1NyBzY2hyaWViIERldWNoZXIsIEFsZXhhbmRlcjoN
Cj4+Pj4+PiBPbmUgdGhpbmcgSSBmb3VuZCBtaXNzaW5nIGluIHRoZSBkaXNjdXNzaW9uIHdhcyB0
aGUgcmVmZXJlbmNlIHRvIHRoZQ0KPj4+Pj4+IEMgc3RhbmRhcmQuDQo+Pj4+Pj4gVGhlIEM5OSBz
dGFuZGFyZCBzdGF0ZXMgaW4gc2VjdGlvbiA2LjcuOCAoSW5pdGlhbGl6YXRpb24pIGNsYXVzZSAx
OToNCj4+Pj4+PiAiLi4uIGFsbA0KPj4+Pj4+IHN1Ym9iamVjdHMgdGhhdCBhcmUgbm90IGluaXRp
YWxpemVkIGV4cGxpY2l0bHkgc2hhbGwgYmUgaW5pdGlhbGl6ZWQNCj4+Pj4+PiBpbXBsaWNpdGx5
IHRoZSBzYW1lIGFzIG9iamVjdHMgdGhhdCBoYXZlIHN0YXRpYyBzdG9yYWdlIGR1cmF0aW9uIi4N
Cj4+Pj4+PiBDbGF1c2UgMjEgbWFrZXMgZnVydGhlciByZWZlcmVuY2UgdG8gcGFydGlhbCBpbml0
aWFsaXphdGlvbiwNCj4+Pj4+PiBzdWdnZXN0aW5nIHRoZSBzYW1lLiBWYXJpb3VzIG9ubGluZSBy
ZXNvdXJjZXMsIGluY2x1ZGluZyB0aGUgZ2NjDQo+Pj4+Pj4gZG9jdW1lbnRhdGlvbiwgYWxsIHN0
YXRlIHRoZSBzYW1lLiBJIGRvbid0IGZpbmQgYW55IHJlZmVyZW5jZSB0byBhDQo+Pj4+Pj4gcGFy
dGlhbCBpbml0aWFsaXphdGlvbiB3aGljaCB3b3VsZCBsZWF2ZSBtZW1iZXJzIG9mIGEgc3RydWN0
dXJlDQo+Pj4+Pj4gdW5kZWZpbmVkLiBJdCB3b3VsZCBiZSBpbnRlcmVzdGluZyBmb3IgbWUgdG8g
dW5kZXJzdGFuZCBob3cgYW5kIHdoeQ0KPj4+Pj4+IHRoaXMgZG9lcyBub3QgYXBwbHkgaGVyZS4N
Cj4+Pj4+Pg0KPj4+Pj4+IEluIHRoaXMgY29udGV4dCwgaXQgaXMgaW50ZXJlc3RpbmcgdGhhdCB0
aGUgb3RoZXIgNDggaW5zdGFuY2VzIG9mIHRoZQ0KPj4+Pj4+IHsgeyAwIH0gfSBpbml0aWFsaXph
dGlvbiBpbiB0aGUgc2FtZSBkcml2ZXIgZG9uJ3QgcmFpc2Ugc2ltaWxhcg0KPj4+Pj4+IGNvbmNl
cm5zLCBub3Igc2VlbWVkIHRvIGhhdmUgY2F1c2VkIGFueSBvcGVyYXRpb25hbCBwcm9ibGVtcy4N
Cj4+Pj4+IEZlZWwgZnJlZSB0byBwcm92aWRlIHBhdGNoZXMgdG8gcmVwbGFjZSB0aG9zZSB3aXRo
IG1lbXNldCgpLg0KPj4+Pj4NCj4+Pj4gTm90IG1lLiBBcyBJIHNlZSBpdCwgdGhlIHByb2JsZW0s
IGlmIGl0IGV4aXN0cywgd291bGQgYmUgYSB2aW9sYXRpb24gb2YgdGhlIEMNCj4+Pj4gc3RhbmRh
cmQuIEkgZG9uJ3QgYmVsaWV2ZSBoYWNraW5nIGFyb3VuZCBiYWQgQyBjb21waWxlcnMuIEkgd291
bGQgcmF0aGVyDQo+Pj4+IGJsYWNrbGlzdCBzdWNoIGNvbXBpbGVycy4NCj4+IFdlbGwgdGhlbiB5
b3Ugd291bGQgbmVlZCB0byBibGFja2xpc3QgYmFzaWNhbGx5IGFsbCBnY2MgdmFyaWFudHMgb2Yg
dGhlDQo+PiBsYXN0IGRlY2FkZSBvciBzby4NCj4+DQo+PiBJbml0aWFsaXppbmcgb25seSBrbm93
biBtZW1iZXJzIG9mIHN0cnVjdHVyZXMgaXMgYSBwZXJmZWN0bHkgdmFsaWQNCj4+IG9wdGltaXph
dGlvbiBhbmQgd2VsbCBrbm93biBpc3N1ZSB3aGVuIHlvdSB0aGVuIGNvbXBhcmUgdGhlIHN0cnVj
dHVyZQ0KPj4gd2l0aCBtZW1jcHkoKSBvciB1c2UgdGhlIGJ5dGVzIGZvciBoYXNoaW5nIG9yIHNv
bWV0aGluZyBzaW1pbGFyLg0KPj4NCj4gSXNuJ3QgdGhhdCBhYm91dCBwYWRkaW5nID8gVGhhdCBp
cyBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IGlzc3VlLg0KDQpDb3JyZWN0LCB5ZXMuIEJ1dCB0aGF0
IGlzIHRoZSByZWFzb24gd2h5IEkgcmVjb21tZW5kIHVzaW5nIG1lbXNldCgpIGZvciANCnplcm8g
aW5pdGlhbGl6YXRpb24uDQoNClNlZSB3ZSBkb24ndCBrbm93IHRoZSBpbm5lciBsYXlvdXQgb2Yg
dGhlIHN0cnVjdHVyZSwgY291bGQgYmUgYW5vdGhlciANCnN0cnVjdHVyZSBvciBhbiB1bmlvbi4N
Cg0KSWYgaXQncyBhIHN0cnVjdHVyZSBldmVyeXRoaW5nIGlzIGZpbmUgYmVjYXVzZSBpZiB5b3Ug
aW5pdGlhbGl6ZSBvbmUgDQpzdHJ1Y3R1cmUgbWVtYmVyIGFsbCBvdGhlciBnZXQgdGhlaXIgZGVm
YXVsdCB0eXBlICh3aGF0ZXZlciB0aGF0IG1lYW5zKSwgDQpidXQgaWYgaXQncyBhbiB1bmlvbi4u
Li4uDQoNCk5vdCBzdXJlIGlmIGNvbXBpbGVycyBzdGlsbCByZWFjdCBhbGxlcmdpYyB0byB0aGF0
LCBidXQgaXRzIHRoZSBzdGF0dXMgDQpJJ3ZlIGxlYXJuZWQgdGhlIGhhcmQgd2F5IHdoZW4gdGhl
IEM5OSBzdGFuZGFyZCBjYW1lIG91dCBhbmQgaXQgc3RpbGwgDQpzZWVtcyBsaWtlIHBlb3BsZSBh
cmUgd29ya2luZyBhcm91bmQgdGhhdCBzbyBJIHJlY29tbWVuZCBldmVyeWJvZHkgdG8gDQpzdGlj
ayB3aXRoIG1lbXNldCgpLg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gR3VlbnRlcg0KDQo=
