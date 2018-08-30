Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD40C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA28A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R/e0+asq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA28A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeHaClB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:41:01 -0400
Received: from mail-eopbgr690117.outbound.protection.outlook.com ([40.107.69.117]:8646
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727181AbeHaClB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnVcQCu78EAYSqAQYfchmh7OUCeIoyoMp13JqTjTfLk=;
 b=R/e0+asqsoEkMXCgEQf0q2Q2lE9siLrbo8j/Fe4y5Te7+1Q5zpeXoIAG6v+YRIKVTQCk6SMR+9Im50TyGbZyMlqa+oji1uYaunZAvJqDlW5rA5VncE421QdSitqg3C0dNR8B0Jurxunuc7WInE5hO6hAWLAOsLaO4VAHTN4Bx9g=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0763.namprd21.prod.outlook.com (10.173.172.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1122.6; Thu, 30 Aug 2018 22:36:33 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 22:36:33 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: print only with DEBUG_VM in
 online/offline_pages()
Thread-Topic: [PATCH v1 5/5] mm/memory_hotplug: print only with DEBUG_VM in
 online/offline_pages()
Thread-Index: AQHUQLHn7NnCJkqsQkWo3fehnkJsNg==
Date:   Thu, 30 Aug 2018 22:36:33 +0000
Message-ID: <1c503734-e662-a775-609e-1a9862dedd50@microsoft.com>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-6-david@redhat.com>
 <7892e949-6c2c-9659-a595-177037d0e203@redhat.com>
In-Reply-To: <7892e949-6c2c-9659-a595-177037d0e203@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0763;6:8ZohjPu6lruZKjCAmOq9gYXJMSihNhE4US+zFZpU9aM/Tb7AMJ/IwjTgLMaZZefB/5OBjOOBrEihWdyk8ayUtuZqVJAYJ3+s9IWbCsKJLBqvWAuRcQXwUzNn888QYykMFK7tijuOBxdcVEad0utyHAVb2VlR53AdCTGUHg4EeWheQBYSgAhgU/pEpfiSVEG5Vz5bOXp4i0c/MMVfWY7C7apTjGN9L7xChtjkoQKwgCr6PxHXRHmWFU3mAUaQ2Ia9qWUQV03Y+oNlPx1eUarISDqrPvPYopHhbpNo2oty/ZDxF0V8TiynRycrPnmfFmHTQ+f6+TP9ahk+b/jtrFVk+WG0aTuezQ2cJYNnEdIsA8ymZCzdH1M7JmdRPZF4h0qisHa3TT6jEuzFnbVUj/Lh+QqAGm8dIBtFiNM2kjbSKxKuniZkMbnllo1/BDuJPgWiDmmhCroprd/RSqRb2gXiWQ==;5:XFXGv/gVATXsgGNykyJhC7rE367nXtRy5IhfeCZZcIF33lyCf1x6zQf6dZOETV2FunawHiGrzQ0Sci8wteFhljPvCNts3YAb2rQZ9FAuscYJf1LLo3kvJX/YPWmycc8Yx910TNT2T+/KYmbk8nYo/LbBQJmtPaYlqYMez5pUvpY=;7:0a3+MxD+em0Q8AakrWC/tzx01DT9n5jitmuY+lRZDxFG4FrZvIX1+/QOoO/Brr4Y/6SbJUWkWGkqwKY7x4OC6O3lo3Kpk3jvvtLbdcqWbNi60BZVeT3KcA4JMEK6zdWyISiwsMs8NZZsl5OXk7BpTy4HBV3A5pgq5G2SeJz3EXx+dNhYyUfaUuHiySn+8/oEugnAk+pzFcjWmgq83ay+TzXOnUzfFyFyAVioTCcnU13Br23w+kV99wHo71mHy2C5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: edebcf31-d315-43f7-3233-08d60ec909e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0763;
x-ms-traffictypediagnostic: DM5PR21MB0763:
x-microsoft-antispam-prvs: <DM5PR21MB076316CD08686B1AD0AC7AAF9D080@DM5PR21MB0763.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0763;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0763;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(189003)(186003)(68736007)(10090500001)(36756003)(5250100002)(54906003)(7416002)(6116002)(86362001)(6486002)(110136005)(6436002)(316002)(8936002)(102836004)(22452003)(229853002)(99286004)(53546011)(3846002)(86612001)(6506007)(6512007)(31696002)(53936002)(31686004)(6246003)(39060400002)(5660300001)(486006)(476003)(2616005)(97736004)(11346002)(446003)(26005)(8676002)(76176011)(4326008)(81156014)(81166006)(25786009)(10290500003)(6346003)(2501003)(72206003)(2900100001)(305945005)(7736002)(256004)(478600001)(66066001)(105586002)(14454004)(2906002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0763;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: fV5o7DJ689x/TKJg7HI7nET84lVp1A83eQuKBtWeJBqw77BMJ7MN9v2cqfsXJqasoRv27tyYw+w7VZKqJz0iCcmP2JrWY5wZNOamJTQslFs/aelHNFpcmL2A+ZNJytnHhlHT03Vigq5KwJLUTPGhclai3fJgULC5vjKI/XUomePhGG1lV4QhuUjDrCJswoTt3sgiM19SPiiJs0CwIbeVo4sKkbQasytyo1puIDPbx4OWiAWqeuBGLl0kj7GydNyi6/obPwtIN2J7G2msRQT9KG+GSBKvPn6qV2mat1AUS4KyMWfzqCowJC/VdOUtAbdJaM477s1FxEi3RasISF39fyxhDEJcY/DgS04vnCfMDd4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B54AEF0D4F11840BFFC7E8A5EEC8C1E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edebcf31-d315-43f7-3233-08d60ec909e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 22:36:33.5179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDgvMjAvMTggNjo0NiBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IE9uIDE2
LjA4LjIwMTggMTI6MDYsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4gTGV0J3MgdHJ5IHRv
IG1pbmltemUgdGhlIG5vaXNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJy
YW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgbW0vbWVtb3J5X2hvdHBsdWcuYyB8
IDYgKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9tbS9tZW1vcnlfaG90cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPj4g
aW5kZXggYmJiZDE2ZjlkODc3Li42ZmVjMmRjNmE3M2QgMTAwNjQ0DQo+PiAtLS0gYS9tbS9tZW1v
cnlfaG90cGx1Zy5jDQo+PiArKysgYi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+PiBAQCAtOTY2LDkg
Kzk2NiwxMSBAQCBpbnQgX19yZWYgb25saW5lX3BhZ2VzKHVuc2lnbmVkIGxvbmcgcGZuLCB1bnNp
Z25lZCBsb25nIG5yX3BhZ2VzLCBpbnQgb25saW5lX3R5cA0KPj4gIAlyZXR1cm4gMDsNCj4+ICAN
Cj4+ICBmYWlsZWRfYWRkaXRpb246DQo+PiArI2lmZGVmIENPTkZJR19ERUJVR19WTQ0KPj4gIAlw
cl9kZWJ1Zygib25saW5lX3BhZ2VzIFttZW0gJSMwMTBsbHgtJSMwMTBsbHhdIGZhaWxlZFxuIiwN
Cj4+ICAJCSAodW5zaWduZWQgbG9uZyBsb25nKSBwZm4gPDwgUEFHRV9TSElGVCwNCj4+ICAJCSAo
KCh1bnNpZ25lZCBsb25nIGxvbmcpIHBmbiArIG5yX3BhZ2VzKSA8PCBQQUdFX1NISUZUKSAtIDEp
Ow0KPj4gKyNlbmRpZg0KPj4gIAltZW1vcnlfbm90aWZ5KE1FTV9DQU5DRUxfT05MSU5FLCAmYXJn
KTsNCj4+ICAJcmV0dXJuIHJldDsNCj4+ICB9DQo+PiBAQCAtMTY2MCw3ICsxNjYyLDkgQEAgaW50
IG9mZmxpbmVfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sIHVuc2lnbmVkIGxvbmcgbnJf
cGFnZXMpDQo+PiAgCW9mZmxpbmVkX3BhZ2VzID0gY2hlY2tfcGFnZXNfaXNvbGF0ZWQoc3RhcnRf
cGZuLCBlbmRfcGZuKTsNCj4+ICAJaWYgKG9mZmxpbmVkX3BhZ2VzIDwgMCkNCj4+ICAJCWdvdG8g
cmVwZWF0Ow0KPj4gKyNpZmRlZiBDT05GSUdfREVCVUdfVk0NCj4+ICAJcHJfaW5mbygiT2ZmbGlu
ZWQgUGFnZXMgJWxkXG4iLCBvZmZsaW5lZF9wYWdlcyk7DQo+PiArI2VuZGlmDQo+PiAgCS8qIE9r
LCBhbGwgb2Ygb3VyIHRhcmdldCBpcyBpc29sYXRlZC4NCj4+ICAJICAgV2UgY2Fubm90IGRvIHJv
bGxiYWNrIGF0IHRoaXMgcG9pbnQuICovDQo+PiAgCW9mZmxpbmVfaXNvbGF0ZWRfcGFnZXMoc3Rh
cnRfcGZuLCBlbmRfcGZuKTsNCj4+IEBAIC0xNjk1LDkgKzE2OTksMTEgQEAgaW50IG9mZmxpbmVf
cGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sIHVuc2lnbmVkIGxvbmcgbnJfcGFnZXMpDQo+
PiAgCXJldHVybiAwOw0KPj4gIA0KPj4gIGZhaWxlZF9yZW1vdmFsOg0KPj4gKyNpZmRlZiBDT05G
SUdfREVCVUdfVk0NCj4+ICAJcHJfZGVidWcoIm1lbW9yeSBvZmZsaW5pbmcgW21lbSAlIzAxMGxs
eC0lIzAxMGxseF0gZmFpbGVkXG4iLA0KPj4gIAkJICh1bnNpZ25lZCBsb25nIGxvbmcpIHN0YXJ0
X3BmbiA8PCBQQUdFX1NISUZULA0KPj4gIAkJICgodW5zaWduZWQgbG9uZyBsb25nKSBlbmRfcGZu
IDw8IFBBR0VfU0hJRlQpIC0gMSk7DQo+PiArI2VuZGlmDQo+PiAgCW1lbW9yeV9ub3RpZnkoTUVN
X0NBTkNFTF9PRkZMSU5FLCAmYXJnKTsNCj4+ICAJLyogcHVzaGJhY2sgdG8gZnJlZSBhcmVhICov
DQo+PiAgCXVuZG9faXNvbGF0ZV9wYWdlX3JhbmdlKHN0YXJ0X3BmbiwgZW5kX3BmbiwgTUlHUkFU
RV9NT1ZBQkxFKTsNCj4+DQo+IA0KPiBJJ2xsIGRyb3AgdGhpcyBwYXRjaCBmb3Igbm93LCBtYXli
ZSB0aGUgZXJyb3IgbWVzc2FnZXMgYXJlIGFjdHVhbGx5DQo+IHVzZWZ1bCB3aGVuIGRlYnVnZ2lu
ZyBhIGNyYXNoZHVtcCBvZiBhIHN5c3RlbSB3aXRob3V0IENPTkZJR19ERUJVR19WTS4NCj4gDQoN
ClllcywgcGxlYXNlIGRyb3AgaXQsIG5vIHJlYXNvbiB0byByZWR1Y2UgYW1vdW50IG9mIHRoZXNl
IG1lc3NhZ2VzLiBUaGV5DQphcmUgdXNlZnVsLg0KDQpUaGFuayB5b3UsDQpQYXZlbA==
