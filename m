Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3394C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEB821927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DkpON1um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404475AbeLUSpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:45:13 -0500
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:50624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730799AbeLUSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifJqlMPOO3cQvUQWI6UP979164HWdTvZQKMfDxJuVkw=;
 b=DkpON1umTgvNy51Y3C+ewBa5fFlW4Kr6LgJxEPU3vXqYakb+HvT59VSbU7eKdQ7hENFClFWBjO3tnGT0al0Zo40ouHAelTrjVav9Yk7qXsuMrST+c/7xEkCKT4jye1kdk6KqlFx6fQmNy3EQe0DUtjYzfAetVsPso0WsqzHAXqE=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1636.namprd12.prod.outlook.com (10.172.19.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Fri, 21 Dec 2018 18:45:08 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::45af:f970:9acc:6c74]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::45af:f970:9acc:6c74%10]) with mapi id 15.20.1446.022; Fri, 21 Dec
 2018 18:45:08 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Dmitry Osipenko <digetx@gmail.com>, Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH 2/2] drm: Revert syncobj timeline changes.
Thread-Topic: [PATCH 2/2] drm: Revert syncobj timeline changes.
Thread-Index: AQHUd3y8jj33F8u6206Ye3csXp/f9aWGmJiAgAMt9YCAAAJkAIAAAqAA
Date:   Fri, 21 Dec 2018 18:45:08 +0000
Message-ID: <6773eadb-5c15-8168-9bba-5e1cfd1c3194@amd.com>
References: <20181108160422.17743-1-eric@anholt.net>
 <20181108160422.17743-3-eric@anholt.net>
 <faf15d58-a076-49fb-c903-15acdf6f8ffe@gmail.com>
 <fadfc03c-7f80-216b-299f-27a1d8d7877b@gmail.com>
 <44f25278-fbbd-f95b-c2ab-87834e5d095e@gmail.com>
In-Reply-To: <44f25278-fbbd-f95b-c2ab-87834e5d095e@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM6P193CA0039.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::16) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1636;20:YU0cq3WwGY/1k2iXMQkNS5YBFRIic5/QCdP4+vLuPqURiteToi0WCnR4lR8tcg1PHnO5cP4ycP04u09MqHRAmHLG8dS9JPYf/b3OPRmoPDfnkniQLo2YPxwD7FkaT5izLkHDUy7wpPKyAk83EXubLjj/DcLnxH69D2+Ebb5a9+xdeVhPsRe08QX6PU4ci+cJoA43lXIU+R9RVPl7lxu6mZvoOmyjyiq2rUxsLTWW5MeKcabQ7J/id3KWg2yWDSJ4
x-ms-office365-filtering-correlation-id: a1f589fc-91cd-40a0-4479-08d667746e47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1636;
x-ms-traffictypediagnostic: BN6PR12MB1636:
x-microsoft-antispam-prvs: <BN6PR12MB16362A10E72B6DCB0BF5E52E83B80@BN6PR12MB1636.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1636;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1636;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(64126003)(486006)(72206003)(6246003)(305945005)(25786009)(2616005)(39060400002)(478600001)(446003)(7736002)(5660300001)(65826007)(476003)(105586002)(229853002)(54906003)(316002)(99286004)(6486002)(76176011)(102836004)(106356001)(6436002)(93886005)(53546011)(386003)(6506007)(110136005)(31686004)(58126008)(14454004)(11346002)(46003)(2906002)(4326008)(65806001)(68736007)(36756003)(186003)(53936002)(8676002)(52116002)(2501003)(65956001)(8936002)(97736004)(6512007)(81166006)(256004)(31696002)(81156014)(6116002)(71190400001)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1636;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KKVBiGfEJvFIHpmKsYHQ9muRbhA1kSOmBq7ccHQ1UIR6zR6oLafl7JxlK/+Q4B8LLLmWaJ5TE5j6QMNXgTdf+KsEYGc9vZCQIoN61DQJEC3V6Et7Nc7A4bhi+JILhmmJebunGLgJN32llOlcaIIzOgzIcLGLQRU/PtMXDrHxLYlzjMOqKd3M7dnKm9PVvFRT6Eb9SpKqMo8FkQpxbZAXk6OBB0f0tnLYr2+s9o7P3Fkc3Nnh7NhE+3DfJTElisaLHrj71BjkcNiVNX30wnLlpwy4Iua4NG0R5yre6e64xWfmyzjZEkXo4cS/VlM2OWVc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E28B976A8B9A6C45B6D0667BD4FD3AEC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f589fc-91cd-40a0-4479-08d667746e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 18:45:08.6297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjEuMTIuMTggdW0gMTk6MzUgc2NocmllYiBEbWl0cnkgT3NpcGVua286DQo+IE9uIDIxLjEy
LjIwMTggMjE6MjcsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+PiBBbSAxOS4xMi4xOCB1bSAx
ODo1MyBzY2hyaWViIERtaXRyeSBPc2lwZW5rbzoNCj4+PiBbU05JUF0NCj4+Pj4gQEAgLTkzMSw5
ICs3MTgsNiBAQCBzdGF0aWMgc2lnbmVkIGxvbmcgZHJtX3N5bmNvYmpfYXJyYXlfd2FpdF90aW1l
b3V0KHN0cnVjdCBkcm1fc3luY29iaiAqKnN5bmNvYmpzLA0KPj4+PiAgwqAgwqDCoMKgwqDCoCBp
ZiAoZmxhZ3MgJiBEUk1fU1lOQ09CSl9XQUlUX0ZMQUdTX1dBSVRfRk9SX1NVQk1JVCkgew0KPj4+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBjb3VudDsgKytpKSB7DQo+Pj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlbnRyaWVzW2ldLmZlbmNlKQ0KPj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4+PiAtDQo+Pj4+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcm1fc3luY29ial9mZW5jZV9nZXRfb3JfYWRkX2NhbGxi
YWNrKHN5bmNvYmpzW2ldLA0KPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZW50cmllc1tpXS5mZW5jZSwN
Cj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVudHJpZXNbaV0uc3luY29ial9jYiwNCj4+PiBIZWxsbywN
Cj4+Pg0KPj4+IFRoZSBhYm92ZSB0aHJlZSByZW1vdmVkIGxpbmVzIHdlIGFkZGVkIGluIGNvbW1p
dCAzMzdmZTlmNWMxZTdkZSAoImRybS9zeW5jb2JqOiBEb24ndCBsZWFrIGZlbmNlcyB3aGVuIFdB
SVRfRk9SX1NVQk1JVCBpcyBzZXQiKSB0aGF0IGZpeGVkIGEgbWVtbGVhay4gUmVtb3ZhbCBvZiB0
aGUgbGluZXMgcmV0dXJucyB0aGUgbWVtbGVhayBiZWNhdXNlIG9mIGRpc2JhbGFuY2VkIGZlbmNl
IHJlZmNvdW50aW5nIGFuZCBpdCBsb29rcyBsaWtlIHRoZXkgd2VyZSByZW1vdmVkIHVuaW50ZW50
aW9uYWxseSBpbiB0aGlzIHBhdGNoLg0KPj4gVGhhdCB3YXMgYWxyZWFkeSBmaXhlZCB3aXRoIDYx
YTk4YjFiOWE4YzcgZHJtL3N5bmNvYmo6IHJlbW92ZSBkcm1fc3luY29ial9jYiBhbmQgY2xlYW51
cC4NCj4+DQo+PiBUaGlzIGNsZWFudXAgcmVtb3ZlZCBhbGwgdGhlIGR1cGxpY2F0ZSBjaGVja2lu
ZyBhbmQgaXMgbm93IGFkZGluZyB0aGUgY2FsbGJhY2sgb25seSBvbmNlLg0KPiBPa2F5LCB0aG91
Z2ggdGhhdCBjb21taXQgaXMgbm90IGluIGxpbnV4LW5leHQuIEkgYXNzdW1lIGl0IHdpbGwgc2hv
dyB1cCBldmVudHVhbGx5Lg0KDQpOZWVkIHRvIGRvdWJsZSBjaGVjaywgdGhhdCBjb3VsZCBpbmRl
ZWQgYmUgYSBwcm9ibGVtLg0KDQpDaHJpc3RpYW4uDQo=
