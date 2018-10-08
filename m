Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C22C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D537A20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K7gXG3ZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D537A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJHU7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:59:47 -0400
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:21388
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbeJHU7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ5S7AEiTHKQvHwirBDp28F86MZOXKf8R54jMyHPz2s=;
 b=K7gXG3ZLmO+R/fpvPbWA/a5X/9ijujwbK7B3OjtYPUsoTODEJAc3lrpOgAfn8k8+exhgSZByTixs2+N0h9iW3K/ttet8yVccWNt6feACzr2HQCNYNzoz2JUqqrNZfJtL0CibMyfBWhbY+JzlXs5JjA7MQTVZBBBKs9LZrtLhngE=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1345.namprd12.prod.outlook.com (10.168.228.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 13:47:55 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05%12]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 13:47:55 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>, Peng Hao <peng.hao2@zte.com.cn>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Thread-Topic: [PATCH] amdgpu/gmc : fix compile warning
Thread-Index: AQHUXINz8METxdpO60GfNTlgx6+1AqUQVG0AgASscICAAFz5gIAABCGA
Date:   Mon, 8 Oct 2018 13:47:55 +0000
Message-ID: <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
In-Reply-To: <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: HE1PR05CA0213.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::13) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1345;20:ajhz8r/qfmXVg8qzhR1mQ1kXf27U05z2lf3RTt0m7AQ4ovt/XGeTJ1m11VYgbpKHW9BzkCZaVFR9CYEBF6J7KzNgmynchWLjLunqYTEN8AYSP7NMWmVD9CDVMBJoiF6kf3lOSdIeVNi5F4MXwVqZIwN6Val7Jl4vEe4+06NiKzR+f1FBXb7GrTl0jL6aq0DNWPVSfNAXELaoqftfYzkH/QPs32zuTOsCFjTWW87jX4HGoZpCc1qo8Z5lDSvzwP5w
x-ms-office365-filtering-correlation-id: fd2f02f6-c9d7-4695-06df-08d62d24a614
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1345;
x-ms-traffictypediagnostic: BN6PR12MB1345:
x-microsoft-antispam-prvs: <BN6PR12MB1345A445BF67413409B22EE783E60@BN6PR12MB1345.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:BN6PR12MB1345;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1345;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(52314003)(199004)(189003)(81166006)(14444005)(72206003)(6506007)(386003)(256004)(81156014)(8676002)(53936002)(53546011)(316002)(8936002)(6436002)(93886005)(6512007)(14454004)(58126008)(99286004)(478600001)(110136005)(105586002)(106356001)(54906003)(6486002)(31686004)(36756003)(2906002)(65956001)(97736004)(5250100002)(65806001)(52116002)(186003)(2900100001)(476003)(4326008)(486006)(446003)(11346002)(2616005)(64126003)(46003)(68736007)(5660300001)(229853002)(65826007)(25786009)(76176011)(102836004)(6246003)(71190400001)(71200400001)(86362001)(6116002)(305945005)(7736002)(66574009)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1345;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W8uQuSuSjnYqSR1PrrpHcrRJokaJcJ3pQjLcUuoyexCwxNZol5R1qX6CxSRfgRwRLAZeKMrUGarbV6CbyxGQXe31yCfe+TqwiBDJRU6o518R734qrnpxcPljQ1GU+lDKKGG0MDfiYc9VuAIJwmDGY27Y8R338cRYxZeR3NdBCnzNm2Ynj8OLR0w70My7bLen1tln7cDivdmUFSmGQazmGjX4hJXRHyx/Bglg79emQ5hRVhwmFFkMIiy583WQ/1FZvR2JQy3/Q15urh85VdxaM/rg32w4OE+9qRX9txQJ346C5cDBje6LkxwnW4oZyrl4WBGaYpkd/jpnEG4SNordh2C794rXgcSIoDpSikr18EI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <288F2CE92F620E468FFE685D735D787D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2f02f6-c9d7-4695-06df-08d62d24a614
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 13:47:55.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1345
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDguMTAuMjAxOCB1bSAxNTozMyBzY2hyaWViIEd1ZW50ZXIgUm9lY2s6DQo+IE9uIDEwLzA4
LzIwMTggMDE6MDAgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+PiBBbSAwNS4xMC4yMDE4
IHVtIDEwOjM4IHNjaHJpZWIgR3VlbnRlciBSb2VjazoNCj4+PiBPbiAxMC8wNS8yMDE4IDAxOjE0
IEFNLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4+Pj4gQW0gMDQuMTAuMjAxOCB1bSAyMDo1
MiBzY2hyaWViIEd1ZW50ZXIgUm9lY2s6DQo+Pj4+PiBIaSwNCj4+Pj4+DQo+Pj4+PiBPbiBGcmks
IFNlcCAxNCwgMjAxOCBhdCAwNjowNTo1MlBNICswODAwLCBQZW5nIEhhbyB3cm90ZToNCj4+Pj4+
PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhfMC5jOg0KPj4+Pj4+IMKgwqDCoMKg
wqAgSW4gZnVuY3Rpb24g4oCYZ21jX3Y4XzBfcHJvY2Vzc19pbnRlcnJ1cHTigJk6DQo+Pj4+Pj4g
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYzoxNDQ3OjEwOg0KPj4+Pj4+IMKg
wqDCoMKgwqAgd2FybmluZzogbWlzc2luZyBicmFjZXMgYXJvdW5kIGluaXRpYWxpemVyIFstV21p
c3NpbmctYnJhY2VzXQ0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUGVuZyBIYW8gPHBl
bmcuaGFvMkB6dGUuY29tLmNuPg0KPj4+Pj4gV2FzIHRoZXJlIGFueSBmZWVkYmFjayBvbiB0aGlz
IHBhdGNoID8gVGhlIHByb2JsZW0gZG9lcyBhZmZlY3QgdXMsDQo+Pj4+PiBhbmQgd2UnbGwgbmVl
ZCBhIGZpeC4NCj4+Pj4NCj4+Pj4gV2VsbCBhcyBkaXNjdXNzZWQgdXNpbmcgInsgeyAwIH0gfSIg
aXMgYXMgd3JvbmcgYXMgdXNpbmcgInsgMCB9Ii4NCj4+Pj4NCj4+Pg0KPj4+IEFoLCBzb3JyeSwg
SSBtdXN0IGhhdmUgbWlzc2VkIHRoZSBkaXNjdXNzaW9uLg0KPj4+DQo+Pj4gSXQgaXMgZm9yIHN1
cmUgbm90IHRoZSBiZXN0IHNvbHV0aW9uLCBidXQgYXQgbGVhc3QgaXQgY29tcGlsZXMsIGFuZCAN
Cj4+PiBpdCBzZWVtcw0KPj4+IHRvIGJlIHByb2xpZmVyYXRpbmcuDQo+Pg0KPj4gWWVhaCwgYW5k
IGV4YWN0bHkgdGhhdCdzIHRoZSBwcm9ibGVtLiBBcyB0aGUgZGlzY3Vzc2lvbiBzaG93ZWQgInsg
eyAwIA0KPj4gfSB9IiBpcyBidWdneSBiZWNhdXNlIGl0IHRlbGxzIHRoZSBjb21waWxlciB0byBv
bmx5IGluaXRpYWxpemUgdGhlIA0KPj4gZmlyc3QgbWVtYmVyIG9mIHRoZSBzdHJ1Y3R1cmUsIGJ1
dCBub3QgYWxsIG9mIGl0Lg0KPj4NCj4+IFRoYXQgaXMgaW5jb3JyZWN0IGFuZCByYXRoZXIgZGFu
Z2Vyb3VzIGNhdXNlIGl0IGNhbiBsZWFkIHRvIA0KPj4gdW5mb3Jlc2VlbiByZXN1bHRzIGFuZCBz
aG91bGQgcHJvYmFibHkgdHJpZ2dlciBhIHdhcm5pbmcuDQo+Pg0KPj4+DQo+Pj4gJCBnaXQgZ3Jl
cCAieyAqeyAqMCAqfSAqfSIgfCB3Yw0KPj4+IMKgwqDCoCAxNDTCoMKgwqAgMTE4MMKgwqAgMTE4
MDINCj4+PiAkIGdpdCBncmVwICJ7ICp7ICowICp9ICp9IiBkcml2ZXJzL2dwdS9kcm0vYW1kLyB8
IHdjDQo+Pj4gwqDCoMKgwqAgNTDCoMKgwqDCoCA0NTnCoMKgwqAgNTIzOQ0KPj4+DQo+Pj4+IFdl
IHNob3VsZCBlaXRoZXIgdXNlIG9ubHkgInsgfSIgb3IgZXZlbiBiZXR0ZXIgbWFrZSBuYWlscyB3
aXRoIA0KPj4+PiBoZWFkcyBhbmQNCj4+Pj4gdXNlIG1lbXNldCgpLg0KPj4+DQo+Pj4gSSdkIHJh
dGhlciBsZWF2ZSBpdCB1cCB0byB0aGUgY29tcGlsZXIgdG8gZGVjaWRlIHdoYXQgaXMgbW9zdCAN
Cj4+PiBlZmZpY2llbnQuDQo+Pg0KPj4gQW5kIEkgd291bGQgcmF0aGVyIHByZWZlciB0byBoYXZl
IGEgd29ya2luZyBkcml2ZXIgOikNCj4+DQo+DQo+IFNvIHsgfSBpc24ndCBjb3JyZWN0IGVpdGhl
ciA/DQoNClllcywgaW5pdGlhbGl6aW5nIHN0cnVjdHVyZXMgd2l0aCB7IH0gaXMga25vd24gdG8g
YmUgcHJvYmxlbWF0aWMgYXMgd2VsbC4NCg0KSXQgZG9lc24ndCBuZWNlc3NhcnkgaW5pdGlhbGl6
ZSBhbGwgYnl0ZXMgd2hlbiB5b3UgaGF2ZSBwYWRkaW5nIGNhdXNpbmcgDQpyYW5kb20gZmFpbHVy
ZXMgd2hlbiBzdHJ1Y3R1cmVzIGFyZSBtZW1jbXAoKS4NCg0KPg0KPiBPbmUgdGhpbmcgSSBmb3Vu
ZCBtaXNzaW5nIGluIHRoZSBkaXNjdXNzaW9uIHdhcyB0aGUgcmVmZXJlbmNlIHRvIHRoZSBDIA0K
PiBzdGFuZGFyZC4NCj4gVGhlIEM5OSBzdGFuZGFyZCBzdGF0ZXMgaW4gc2VjdGlvbiA2LjcuOCAo
SW5pdGlhbGl6YXRpb24pIGNsYXVzZSAxOTogDQo+ICIuLi4gYWxsDQo+IHN1Ym9iamVjdHMgdGhh
dCBhcmUgbm90IGluaXRpYWxpemVkIGV4cGxpY2l0bHkgc2hhbGwgYmUgaW5pdGlhbGl6ZWQgDQo+
IGltcGxpY2l0bHkNCj4gdGhlIHNhbWUgYXMgb2JqZWN0cyB0aGF0IGhhdmUgc3RhdGljIHN0b3Jh
Z2UgZHVyYXRpb24iLiBDbGF1c2UgMjEgDQo+IG1ha2VzIGZ1cnRoZXINCj4gcmVmZXJlbmNlIHRv
IHBhcnRpYWwgaW5pdGlhbGl6YXRpb24sIHN1Z2dlc3RpbmcgdGhlIHNhbWUuIFZhcmlvdXMgb25s
aW5lDQo+IHJlc291cmNlcywgaW5jbHVkaW5nIHRoZSBnY2MgZG9jdW1lbnRhdGlvbiwgYWxsIHN0
YXRlIHRoZSBzYW1lLiBJIA0KPiBkb24ndCBmaW5kDQo+IGFueSByZWZlcmVuY2UgdG8gYSBwYXJ0
aWFsIGluaXRpYWxpemF0aW9uIHdoaWNoIHdvdWxkIGxlYXZlIG1lbWJlcnMgb2YgDQo+IGEgc3Ry
dWN0dXJlDQo+IHVuZGVmaW5lZC4gSXQgd291bGQgYmUgaW50ZXJlc3RpbmcgZm9yIG1lIHRvIHVu
ZGVyc3RhbmQgaG93IGFuZCB3aHkgDQo+IHRoaXMgZG9lcw0KPiBub3QgYXBwbHkgaGVyZS4NCj4N
Cj4gSW4gdGhpcyBjb250ZXh0LCBpdCBpcyBpbnRlcmVzdGluZyB0aGF0IHRoZSBvdGhlciA0OCBp
bnN0YW5jZXMgb2YgdGhlDQo+IHsgeyAwIH0gfSBpbml0aWFsaXphdGlvbiBpbiB0aGUgc2FtZSBk
cml2ZXIgZG9uJ3QgcmFpc2Ugc2ltaWxhciBjb25jZXJucywNCj4gbm9yIHNlZW1lZCB0byBoYXZl
IGNhdXNlZCBhbnkgb3BlcmF0aW9uYWwgcHJvYmxlbXMuDQoNCkZlZWwgZnJlZSB0byBwcm92aWRl
IHBhdGNoZXMgdG8gcmVwbGFjZSB0aG9zZSB3aXRoIG1lbXNldCgpLg0KDQo+DQo+IEFueXdheSwg
SSBmaXhlZCB1cCB0aGUgY29kZSBpbiBvdXIgdHJlZSAod2l0aCB7IH0pLCBzbyBJJ2xsIGxlYXZl
IGl0DQo+IHVwIHRvIHlvdSBmb2xrcyB0byBkZWNpZGUgd2hhdCBpZiBhbnl0aGluZyB0byBkbyBh
Ym91dCBpdC4NCg0KV2VsbCBjb25zaWRlcmluZyB0aGUga25vd24gcHJvYmxlbXMgd2l0aCB7fSBp
bml0aWFsaXphdGlvbiBJJ20gY2VydGFpbmx5IA0KcmVqZWN0aW5nIGFsbCBwYXRjaGVzIHdoaWNo
IHR1cm5zIG1lbXNldCgpIGludG8ge30uDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4g
VGhhbmtzLA0KPiBHdWVudGVyDQoNCg==
