Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB32ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551EF21536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ViGvdxHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551EF21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbeIUGZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:25:13 -0400
Received: from mail-eopbgr710101.outbound.protection.outlook.com ([40.107.71.101]:49184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725749AbeIUGZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9hJWzHHRmW330G5KPTkScr/lE3H3WXmDZjc5ksMsVU=;
 b=ViGvdxHxusWMmsal9mJxKHDUSaUN2zvy/0iGeFMMCRs3S7hYpdn9D60CUSsESdwyJbHOrgX+ogi5eo9D52eRHiHZXvr80Qs2XJqBZzz62ojhr0xBQVKaASiuyyuKvZQQwstnLK5T2WKDBDymqXqsUskjHHHzYUcpq53/XSXkPXQ=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0827.namprd21.prod.outlook.com (10.173.172.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Fri, 21 Sep 2018 00:38:59 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 00:38:59 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "malat@debian.org" <malat@debian.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 5/5] mm/memory_hotplug: Clean up
 node_states_check_changes_offline
Thread-Topic: [PATCH 5/5] mm/memory_hotplug: Clean up
 node_states_check_changes_offline
Thread-Index: AQHUUADBgoFJDRnQsEen4kyYM5nsZqT55vUA
Date:   Fri, 21 Sep 2018 00:38:59 +0000
Message-ID: <13ceceb0-6e01-71a1-1eaf-258b9cbb9f21@microsoft.com>
References: <20180919100819.25518-1-osalvador@techadventures.net>
 <20180919100819.25518-6-osalvador@techadventures.net>
In-Reply-To: <20180919100819.25518-6-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0827;6:0DZZtDeyd+kokXXVi8ekOIep7C9cbxlpVvG4MuoiCUfJUpRINN2ALfHZYjvqvbtRCB75L2pxCQg0x6BrUCPP93Cw4zYSPboyPzx1/gQNoZ3SSdAsG1HTeRKBw9rjBr2jleYJUoNK5ZeTv0DqoIZJ81kGg4rxGBgdnWeY5J6nzz2TAWCNfWPHIGcbabdg0BTrrCc16a5uSnc1zHC6YmIQU8gYszcKdjFYdBUFF80XuEzOLkZTHiCoIFYSHr81ro7BSr/R7KU9UMM6YzgHa2ZGdSb/QtxF75hLjiPy18S5emYDzelWFEUlypT5OBTZ+dhZ6K8u0cBzKhwyT04eeczu4izcU6nSMcrSVUI4W3gs2J8rgzopil8bw9VElTrHOKcnWafp0CYAI+aio1FAwZZIVQrZ27unNkQUbrKiKao00APzUgqFxieU/cHR7Fr8oH6Yv5yyH/6MJ3M0iKdQabV16w==;5:VjNkg1gcdyS8YvCow21ZFjGQsQHajrFsIS4UqbeV3rLrHqbbIf6k+hQnL14M5FzzsqJee9I8anu1PdLygIZDhrqxvWjasCsgQv9EWLzypI5JRdl4pGqSAQNPS6INl6zDYvMjZgzLCUtpitw3SA7CP69kuw0JNssYmr+BXbQlZSE=;7:+qiOWuFB8QP0sXIQ93seiRXdAXQEFZihn2w3JWaErcn2z8uzDiltXrcEYPwRIuOdBAv/EOoLY5S9JGJI/zBc9viqdBLrVZOdhq8Fr1Gr+k1bptX33+igGEgXwQFEkk4dvwYE4OsWRv7dRNNbhvhgHlV9JE6qyMIJPOGMYtYZhu7dQ2cCKLiy3JvgPYmNm8JFMK5h9UxWnVZNV9EiYmAWu/p99hMNWty8dOyqTFerZ299Qx51KcveKw9gsz3dnmhF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0d7194b0-1961-4102-b76d-08d61f5a9f3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0827;
x-ms-traffictypediagnostic: DM5PR21MB0827:
x-microsoft-antispam-prvs: <DM5PR21MB0827DD9F820EC6BE16853AE59D120@DM5PR21MB0827.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0827;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0827;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(6346003)(22452003)(99286004)(54906003)(110136005)(229853002)(53936002)(76176011)(8936002)(6512007)(5660300001)(6486002)(8676002)(97736004)(316002)(6436002)(66066001)(81156014)(81166006)(10090500001)(2906002)(106356001)(36756003)(5250100002)(105586002)(2501003)(31696002)(68736007)(86612001)(86362001)(31686004)(2900100001)(72206003)(186003)(4326008)(6246003)(39060400002)(10290500003)(478600001)(25786009)(102836004)(26005)(6116002)(3846002)(7736002)(446003)(11346002)(476003)(2616005)(305945005)(256004)(71200400001)(71190400001)(486006)(6506007)(14454004)(53546011)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0827;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: KlYYi6JIUArmrssB5AGLPfHnU9C0gr0zCm4MI48BBmD+AwkRG2Oaj9tWy7TmIM7obmpPtoEd/MWs0eK8k1vba6KZ+MVtlqheTsJOuooAjI78XMcNsjWD68RBP7yI2pQH2EGcWUTX4YdHFHdlbSgrAirtWORyh1703hi5Dln1qizjhuXhVpB1KPTRIBnoiK5qecwEJlRbh+F4e8WnwX/xihH9lXFD+kHdZ2yrssJ5o96HHdG68T4CEomiAwk9m4x7NDz1nhanF11Rd563sPPWh+OE9uZRn8Nl72yZDIp+yrxbKAMqBClD+JOSaxMr5MNosE5h365UIWaZcXH5QDTW1RjMgvKBotIenyP6/kfpCt0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <98FF2F5E5E63DC44B3E36955350CD803@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7194b0-1961-4102-b76d-08d61f5a9f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 00:38:59.6801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0827
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xOS8xOCA2OjA4IEFNLCBPc2NhciBTYWx2YWRvciB3cm90ZToNCj4gRnJvbTogT3NjYXIg
U2FsdmFkb3IgPG9zYWx2YWRvckBzdXNlLmRlPg0KPiANCj4gVGhpcyBwYXRjaCwgYXMgdGhlIHBy
ZXZpb3VzIG9uZSwgZ2V0cyByaWQgb2YgdGhlIHdyb25nIGlmIHN0YXRlbWVudHMuDQo+IFdoaWxl
IGF0IGl0LCBJIHJlYWxpemVkIHRoYXQgdGhlIGNvbW1lbnRzIGFyZSBzb21ldGltZXMgdmVyeSBj
b25mdXNpbmcsDQo+IHRvIHNheSB0aGUgbGVhc3QsIGFuZCB3cm9uZy4NCj4gRm9yIGV4YW1wbGU6
DQo+IA0KPiAtLS0NCj4gem9uZV9sYXN0ID0gWk9ORV9NT1ZBQkxFOw0KPiANCj4gLyoNCj4gICog
Y2hlY2sgd2hldGhlciBub2RlX3N0YXRlc1tOX0hJR0hfTUVNT1JZXSB3aWxsIGJlIGNoYW5nZWQN
Cj4gICogSWYgd2UgdHJ5IHRvIG9mZmxpbmUgdGhlIGxhc3QgcHJlc2VudCBAbnJfcGFnZXMgZnJv
bSB0aGUgbm9kZSwNCj4gICogd2UgY2FuIGRldGVybWluZCB3ZSB3aWxsIG5lZWQgdG8gY2xlYXIg
dGhlIG5vZGUgZnJvbQ0KPiAgKiBub2RlX3N0YXRlc1tOX0hJR0hfTUVNT1JZXS4NCj4gICovDQo+
IA0KPiBmb3IgKDsgenQgPD0gem9uZV9sYXN0OyB6dCsrKQ0KPiAJcHJlc2VudF9wYWdlcyArPSBw
Z2RhdC0+bm9kZV96b25lc1t6dF0ucHJlc2VudF9wYWdlczsNCj4gaWYgKG5yX3BhZ2VzID49IHBy
ZXNlbnRfcGFnZXMpDQo+IAlhcmctPnN0YXR1c19jaGFuZ2VfbmlkID0gem9uZV90b19uaWQoem9u
ZSk7DQo+IGVsc2UNCj4gCWFyZy0+c3RhdHVzX2NoYW5nZV9uaWQgPSAtMTsNCj4gLS0tDQo+IA0K
PiBJbiBjYXNlIHRoZSBub2RlIGdldHMgZW1wcnksIGl0IG11c3QgYmUgcmVtb3ZlZCBmcm9tIE5f
TUVNT1JZLg0KPiBXZSBhbHJlYWR5IGNoZWNrIE5fSElHSF9NRU1PUlkgYSBiaXQgYWJvdmUgd2l0
aGluIHRoZSBDT05GSUdfSElHSE1FTQ0KPiBpZmRlZiBjb2RlLg0KPiBOb3QgdG8gc2F5IHRoYXQg
c3RhdHVzX2NoYW5nZV9uaWQgaXMgZm9yIE5fTUVNT1JZLCBhbmQgbm90IGZvcg0KPiBOX0hJR0hf
TUVNT1JZLg0KPiANCj4gU28gSSByZS13cm90ZSBzb21lIG9mIHRoZSBjb21tZW50cyB0byB3aGF0
IEkgdGhpbmsgaXMgYmV0dGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT3NjYXIgU2FsdmFkb3Ig
PG9zYWx2YWRvckBzdXNlLmRlPg0KPiAtLS0NCj4gIG1tL21lbW9yeV9ob3RwbHVnLmMgfCA3MSAr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+
IGluZGV4IGFiM2MxZGUxOGM1ZC4uMTVlY2YzZDdhNTU0IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1v
cnlfaG90cGx1Zy5jDQo+ICsrKyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gQEAgLTE0ODUsNTEg
KzE0ODUsMzYgQEAgc3RhdGljIHZvaWQgbm9kZV9zdGF0ZXNfY2hlY2tfY2hhbmdlc19vZmZsaW5l
KHVuc2lnbmVkIGxvbmcgbnJfcGFnZXMsDQo+ICB7DQo+ICAJc3RydWN0IHBnbGlzdF9kYXRhICpw
Z2RhdCA9IHpvbmUtPnpvbmVfcGdkYXQ7DQo+ICAJdW5zaWduZWQgbG9uZyBwcmVzZW50X3BhZ2Vz
ID0gMDsNCj4gLQllbnVtIHpvbmVfdHlwZSB6dCwgem9uZV9sYXN0ID0gWk9ORV9OT1JNQUw7DQo+
ICsJZW51bSB6b25lX3R5cGUgenQ7DQo+ICANCj4gIAkvKg0KPiAtCSAqIElmIHdlIGhhdmUgSElH
SE1FTSBvciBtb3ZhYmxlIG5vZGUsIG5vZGVfc3RhdGVzW05fTk9STUFMX01FTU9SWV0NCj4gLQkg
KiBjb250YWlucyBub2RlcyB3aGljaCBoYXZlIHpvbmVzIG9mIDAuLi5aT05FX05PUk1BTCwNCj4g
LQkgKiBzZXQgem9uZV9sYXN0IHRvIFpPTkVfTk9STUFMLg0KPiAtCSAqDQo+IC0JICogSWYgd2Ug
ZG9uJ3QgaGF2ZSBISUdITUVNIG5vciBtb3ZhYmxlIG5vZGUsDQo+IC0JICogbm9kZV9zdGF0ZXNb
Tl9OT1JNQUxfTUVNT1JZXSBjb250YWlucyBub2RlcyB3aGljaCBoYXZlIHpvbmVzIG9mDQo+IC0J
ICogMC4uLlpPTkVfTU9WQUJMRSwgc2V0IHpvbmVfbGFzdCB0byBaT05FX01PVkFCTEUuDQo+ICsJ
ICogQ2hlY2sgd2hldGhlciBub2RlX3N0YXRlc1tOX05PUk1BTF9NRU1PUlldIHdpbGwgYmUgY2hh
bmdlZC4NCj4gKwkgKiBJZiB0aGUgbWVtb3J5IHRvIGJlIG9mZmxpbmUgaXMgd2l0aGluIHRoZSBy
YW5nZQ0KPiArCSAqIFswLi5aT05FX05PUk1BTF0sIGFuZCBpdCBpcyB0aGUgbGFzdCBwcmVzZW50
IG1lbW9yeSB0aGVyZSwNCj4gKwkgKiB0aGUgem9uZXMgaW4gdGhhdCByYW5nZSB3aWxsIGJlY29t
ZSBlbXB0eSBhZnRlciB0aGUgb2ZmbGluaW5nLA0KPiArCSAqIHRodXMgd2UgY2FuIGRldGVybWlu
ZSB0aGF0IHdlIG5lZWQgdG8gY2xlYXIgdGhlIG5vZGUgZnJvbQ0KPiArCSAqIG5vZGVfc3RhdGVz
W05fTk9STUFMX01FTU9SWV0uDQo+ICAJICovDQo+IC0JaWYgKE5fTUVNT1JZID09IE5fTk9STUFM
X01FTU9SWSkNCj4gLQkJem9uZV9sYXN0ID0gWk9ORV9NT1ZBQkxFOw0KPiAtDQo+IC0JLyoNCj4g
LQkgKiBjaGVjayB3aGV0aGVyIG5vZGVfc3RhdGVzW05fTk9STUFMX01FTU9SWV0gd2lsbCBiZSBj
aGFuZ2VkLg0KPiAtCSAqIElmIHRoZSBtZW1vcnkgdG8gYmUgb2ZmbGluZSBpcyBpbiBhIHpvbmUg
b2YgMC4uLnpvbmVfbGFzdCwNCj4gLQkgKiBhbmQgaXQgaXMgdGhlIGxhc3QgcHJlc2VudCBtZW1v
cnksIDAuLi56b25lX2xhc3Qgd2lsbA0KPiAtCSAqIGJlY29tZSBlbXB0eSBhZnRlciBvZmZsaW5l
ICwgdGh1cyB3ZSBjYW4gZGV0ZXJtaW5kIHdlIHdpbGwNCj4gLQkgKiBuZWVkIHRvIGNsZWFyIHRo
ZSBub2RlIGZyb20gbm9kZV9zdGF0ZXNbTl9OT1JNQUxfTUVNT1JZXS4NCj4gLQkgKi8NCj4gLQlm
b3IgKHp0ID0gMDsgenQgPD0gem9uZV9sYXN0OyB6dCsrKQ0KPiArCWZvciAoenQgPSAwOyB6dCA8
PSBaT05FX05PUk1BTDsgenQrKykNCj4gIAkJcHJlc2VudF9wYWdlcyArPSBwZ2RhdC0+bm9kZV96
b25lc1t6dF0ucHJlc2VudF9wYWdlczsNCj4gLQlpZiAoem9uZV9pZHgoem9uZSkgPD0gem9uZV9s
YXN0ICYmIG5yX3BhZ2VzID49IHByZXNlbnRfcGFnZXMpDQo+ICsJaWYgKHpvbmVfaWR4KHpvbmUp
IDw9IFpPTkVfTk9STUFMICYmIG5yX3BhZ2VzID49IHByZXNlbnRfcGFnZXMpDQo+ICAJCWFyZy0+
c3RhdHVzX2NoYW5nZV9uaWRfbm9ybWFsID0gem9uZV90b19uaWQoem9uZSk7DQo+ICAJZWxzZQ0K
PiAgCQlhcmctPnN0YXR1c19jaGFuZ2VfbmlkX25vcm1hbCA9IC0xOw0KPiAgDQo+ICAjaWZkZWYg
Q09ORklHX0hJR0hNRU0NCj4gIAkvKg0KPiAtCSAqIElmIHdlIGhhdmUgbW92YWJsZSBub2RlLCBu
b2RlX3N0YXRlc1tOX0hJR0hfTUVNT1JZXQ0KPiAtCSAqIGNvbnRhaW5zIG5vZGVzIHdoaWNoIGhh
dmUgem9uZXMgb2YgMC4uLlpPTkVfSElHSE1FTSwNCj4gLQkgKiBzZXQgem9uZV9sYXN0IHRvIFpP
TkVfSElHSE1FTS4NCj4gLQkgKg0KPiAtCSAqIElmIHdlIGRvbid0IGhhdmUgbW92YWJsZSBub2Rl
LCBub2RlX3N0YXRlc1tOX05PUk1BTF9NRU1PUlldDQo+IC0JICogY29udGFpbnMgbm9kZXMgd2hp
Y2ggaGF2ZSB6b25lcyBvZiAwLi4uWk9ORV9NT1ZBQkxFLA0KPiAtCSAqIHNldCB6b25lX2xhc3Qg
dG8gWk9ORV9NT1ZBQkxFLg0KPiArCSAqIG5vZGVfc3RhdGVzW05fSElHSF9NRU1PUlldIGNvbnRh
aW5zIG5vZGVzIHdoaWNoDQo+ICsJICogaGF2ZSBub3JtYWwgbWVtb3J5IG9yIGhpZ2ggbWVtb3J5
Lg0KPiArCSAqIEhlcmUgd2UgYWRkIHRoZSBwcmVzZW50X3BhZ2VzIGJlbG9uZ2luZyB0byBaT05F
X0hJR0hNRU0uDQo+ICsJICogSWYgdGhlIHpvbmUgaXMgd2l0aGluIHRoZSByYW5nZSBvZiBbMC4u
Wk9ORV9ISUdITUVNKSwgYW5kDQo+ICsJICogd2UgZGV0ZXJtaW5lIHRoYXQgdGhlIHpvbmVzIGlu
IHRoYXQgcmFuZ2UgYmVjb21lIGVtcHR5LA0KPiArCSAqIHdlIG5lZWQgdG8gY2xlYXIgdGhlIG5v
ZGUgZm9yIE5fSElHSF9NRU1PUlkuDQo+ICAJICovDQo+IC0Jem9uZV9sYXN0ID0gWk9ORV9ISUdI
TUVNOw0KPiAtCWlmIChOX01FTU9SWSA9PSBOX0hJR0hfTUVNT1JZKQ0KPiAtCQl6b25lX2xhc3Qg
PSBaT05FX01PVkFCTEU7DQo+ICsJenQgPSBaT05FX0hJR0hNRU07DQo+ICsJcHJlc2VudF9wYWdl
cyArPSBwZ2RhdC0+bm9kZV96b25lc1t6dF0ucHJlc2VudF9wYWdlczsNCj4gIA0KPiAtCWZvciAo
OyB6dCA8PSB6b25lX2xhc3Q7IHp0KyspDQo+IC0JCXByZXNlbnRfcGFnZXMgKz0gcGdkYXQtPm5v
ZGVfem9uZXNbenRdLnByZXNlbnRfcGFnZXM7DQo+IC0JaWYgKHpvbmVfaWR4KHpvbmUpIDw9IHpv
bmVfbGFzdCAmJiBucl9wYWdlcyA+PSBwcmVzZW50X3BhZ2VzKQ0KPiArCWlmICh6b25lX2lkeCh6
b25lKSA8PSB6dCAmJiBucl9wYWdlcyA+PSBwcmVzZW50X3BhZ2VzKQ0KPiAgCQlhcmctPnN0YXR1
c19jaGFuZ2VfbmlkX2hpZ2ggPSB6b25lX3RvX25pZCh6b25lKTsNCj4gIAllbHNlDQo+ICAJCWFy
Zy0+c3RhdHVzX2NoYW5nZV9uaWRfaGlnaCA9IC0xOw0KPiBAQCAtMTU0MiwxOCArMTUyNywxOCBA
QCBzdGF0aWMgdm9pZCBub2RlX3N0YXRlc19jaGVja19jaGFuZ2VzX29mZmxpbmUodW5zaWduZWQg
bG9uZyBucl9wYWdlcywNCj4gICNlbmRpZg0KPiAgDQo+ICAJLyoNCj4gLQkgKiBub2RlX3N0YXRl
c1tOX0hJR0hfTUVNT1JZXSBjb250YWlucyBub2RlcyB3aGljaCBoYXZlIDAuLi5aT05FX01PVkFC
TEUNCj4gKwkgKiBXZSBoYXZlIGFjY291bnRlZCB0aGUgcGFnZXMgZnJvbSBbMC4uWk9ORV9OT1JN
QUwpLCBhbmQNCj4gKwkgKiBpbiBjYXNlIG9mIENPTkZJR19ISUdITUVNIHRoZSBwYWdlcyBmcm9t
IFpPTkVfSElHSE1FTQ0KPiArCSAqIGFzIHdlbGwuDQo+ICsJICogSGVyZSB3ZSBjb3VudCB0aGUg
cG9zc2libGUgcGFnZXMgZnJvbSBaT05FX01PVkFCTEUuDQo+ICsJICogSWYgYWZ0ZXIgaGF2aW5n
IGFjY291bnRlZCBhbGwgdGhlIHBhZ2VzLCB3ZSBzZWUgdGhhdCB0aGUgbnJfcGFnZXMNCj4gKwkg
KiB0byBiZSBvZmZsaW5lZCBpcyBvdmVyIG9yIGVxdWFsIHRvIHRoZSBhY2NvdW50ZWQgcGFnZXMs
DQo+ICsJICogd2Uga25vdyB0aGF0IHRoZSBub2RlIHdpbGwgYmVjb21lIGVtcHR5LCBhbmQgc28s
IHdlIGNhbiBjbGVhcg0KPiArCSAqIGl0IGZvciBOX01FTU9SWSBhcyB3ZWxsLg0KPiAgCSAqLw0K
PiAtCXpvbmVfbGFzdCA9IFpPTkVfTU9WQUJMRTsNCj4gKwl6dCA9IFpPTkVfTU9WQUJMRTsNCj4g
KwlwcmVzZW50X3BhZ2VzICs9IHBnZGF0LT5ub2RlX3pvbmVzW3p0XS5wcmVzZW50X3BhZ2VzOw0K
PiAgDQo+IC0JLyoNCj4gLQkgKiBjaGVjayB3aGV0aGVyIG5vZGVfc3RhdGVzW05fSElHSF9NRU1P
UlldIHdpbGwgYmUgY2hhbmdlZA0KPiAtCSAqIElmIHdlIHRyeSB0byBvZmZsaW5lIHRoZSBsYXN0
IHByZXNlbnQgQG5yX3BhZ2VzIGZyb20gdGhlIG5vZGUsDQo+IC0JICogd2UgY2FuIGRldGVybWlu
ZCB3ZSB3aWxsIG5lZWQgdG8gY2xlYXIgdGhlIG5vZGUgZnJvbQ0KPiAtCSAqIG5vZGVfc3RhdGVz
W05fSElHSF9NRU1PUlldLg0KPiAtCSAqLw0KPiAtCWZvciAoOyB6dCA8PSB6b25lX2xhc3Q7IHp0
KyspDQo+IC0JCXByZXNlbnRfcGFnZXMgKz0gcGdkYXQtPm5vZGVfem9uZXNbenRdLnByZXNlbnRf
cGFnZXM7DQo+ICAJaWYgKG5yX3BhZ2VzID49IHByZXNlbnRfcGFnZXMpDQo+ICAJCWFyZy0+c3Rh
dHVzX2NoYW5nZV9uaWQgPSB6b25lX3RvX25pZCh6b25lKTsNCj4gIAllbHNlDQo+IA0KDQoNCkEg
Y291cGxlIG5pdHM6DQoNCkkgd291bGQgc2ltcGxpZnkgdGhpcyBhIGxpdHRsZSwgaW5pdGlhbGl6
ZSBhbGwgZmllbGRzIGF0IHRoZSBiZWdpbm5pbmcNCg0KICAgICAgICBhcmctPnN0YXR1c19jaGFu
Z2VfbmlkX25vcm1hbCA9IC0xOw0KICAgICAgICBhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2gg
PSAtMTsNCiAgICAgICAgYXJnLT5zdGF0dXNfY2hhbmdlX25pZCA9IC0xOw0KDQpBbmQgcmVtb3Zl
IGFsbCB0aGUgZWxzZXMsIGluY2x1ZGluZyBpZmRlZiBlbHNlLg0KDQpBbmQgcmVtb3ZlOg0KICAg
ICAgICB6dCA9IFpPTkVfSElHSE1FTTsNCiAgICAgICAgenQgPSBaT05FX01PVkFCTEU7DQoNClVz
ZSBtYWNyb3MgZGlyZWN0bHksIGxpbmVzIGFyZSBhcmUgc3RpbGwgZ29pbmcgdG8gYmUgdW5kZXIg
ODAgY2hhcnMuDQoNCk90aGVyd2lzZSBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogUGF2ZWwg
VGF0YXNoaW4gPHBhdmVsLnRhdGFzaGluQG1pY3Jvc29mdC5jb20+DQoNClBhdmVs
