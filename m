Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EACC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1DE21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CZ41naqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1DE21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbeIUF1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:27:20 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:35050
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbeIUF1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKfhkEP0Bcr6c5P25NADuXUt0At86yiUGMZqXjgfDT4=;
 b=CZ41naqvFCq3yKmQ8d/oNIwFSLngTnJJYtvRsp5DWU4jrEBnlkrKH3PRjAExpwOZBwIrM/UmQsyfq+nwUT7+/Ds2Zc9Jmkd1kEbJpPwBlkF3V+3wN6kmxsR618C+vQVmMXmMbWV2GTNjg6Dhtsl/QV/296i0W6EjJnQTCXyTC3o=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0779.namprd21.prod.outlook.com (10.173.172.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 23:40:39 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 23:40:39 +0000
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
Subject: Re: [PATCH 3/5] mm/memory_hotplug: Tidy up node_states_clear_node
Thread-Topic: [PATCH 3/5] mm/memory_hotplug: Tidy up node_states_clear_node
Thread-Index: AQHUUAC/M+i0kRkOSEiF45xse2nJ6KT51qiA
Date:   Thu, 20 Sep 2018 23:40:39 +0000
Message-ID: <73bf94f3-d53b-0123-0b1e-86fd00f66694@microsoft.com>
References: <20180919100819.25518-1-osalvador@techadventures.net>
 <20180919100819.25518-4-osalvador@techadventures.net>
In-Reply-To: <20180919100819.25518-4-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0779;6:+mgprQuKV+WXe1BEX4MMBMCjYgFrlvQkwZe/j0902p5bCAwrk3Z3dna1/UqEBPaQHpFR4vIFXM4ly67U1UOb6Cr1+0tNL/caR1vKmgeK75/Sw+LHJDx05bsddzBot0XJGNCgrUD0uE86qZmQBRH4QW19wPkcaueTJzLmGuP2TxSzId6Nn9WlhrTN5ufOtT2jhhsblG0/FctIV+pY4yMiBFfu+xk7yJjEwYSVN7S5hlRK0eJkkAo0GTrZc8uLgYYyeFh9m8Jk8957/r+a6V13aznX+j9Frl8E8XUDl/3qNZ6xKPYPqjd7dFd2cw43fzmYAY+jGQ85OPge1qsFYfNA014JGkuUJo1cfYh3ScTHdFOq4KPfKru/Lw97ymNF85CWq+NmR+HdCWnyU5h/ef5+ko2oRcUTRUTwRBrbHYEnCm3IVev2ATOo7OfWlxNHFmnU7l74oXfE9O1xt2SwXHZDfg==;5:R7Dw53gP+sW9GSkxBUW8tA/7KoKEEMnXveCsxzc1LfQDMStMcsvB4ZnTP7tP6xLxsq5P04hrsssngwYtH+DZ372gncauxT+rcVqFl23xvfEtXVkUqOcCOGwNCMR99X/OJwoN+UC3skcT+1yoWq/r66NjohIAWR+YPlaDJaue3q0=;7:q7PHUM4DQ53nkoukoUeAsrSn4w1hGRiHh9pUYbQiFCeK2NldEYERWKcjwB93tIvL1NqaytZ0wWatYL0Lc+XlE0bIiSikCSme839HafzNdFtp+jwHm6Uu5a77NjMSKKXAYZ4ibhZUizf+6IKKYOhOAvumE44yZYgXQ8T/zWsw5ac1c5B9yYIj8OX8hDYiXhRjYXXOnUB8emCxq5WhWnOcHrf+z2xQd7a7Gzn7AcDLBsHPLFMmVGZfG7E3i6L3bz0u
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 619b75fd-26a0-46ba-ccbf-08d61f5278ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0779;
x-ms-traffictypediagnostic: DM5PR21MB0779:
x-microsoft-antispam-prvs: <DM5PR21MB0779A25752D736E2B0EE4ABE9D130@DM5PR21MB0779.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(219752817060721)(189930954265078)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0779;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0779;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(7416002)(6512007)(53936002)(8936002)(99286004)(22452003)(6306002)(316002)(4326008)(6346003)(25786009)(102836004)(2906002)(2900100001)(36756003)(6116002)(5250100002)(3846002)(110136005)(54906003)(5660300001)(71200400001)(68736007)(14454004)(8676002)(6486002)(71190400001)(966005)(575784001)(97736004)(81156014)(31696002)(81166006)(53546011)(6506007)(31686004)(2501003)(86362001)(10090500001)(2616005)(476003)(7736002)(105586002)(10290500003)(486006)(11346002)(446003)(86612001)(106356001)(72206003)(6436002)(305945005)(478600001)(6246003)(186003)(26005)(39060400002)(229853002)(76176011)(66066001)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0779;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: LJJLBHQ/OcqtONb5x7FNG8Y5kN2dSPI4Q6VyloW7gsgQg11LiuhMObp4bIAdBX9xzVta9B8rAv1ozWYFTPEydvTeRN2RfhngxtBF5DNycHd/qVhVuiaLNif9Z3PRNWfAkvD0va2hfv8jYr6NH7ifNhuOcCj2F4YpNqGUD6SDtf0oB1kudzJ/3uLlwfig3EdM4k4t/rKZbKJy7Pwn6BZ7S5WQ7cfDbunbwNZre9HwE5TaHxa56ucPEDDn6G2E1ScWXdfvzC7vFpr9ksImMHtNMOTlgA6u7Ry82oDSJviMvP/RQfSCftGfo7WRMqmkzONu+Rh+0Z/26ZkwAt7AqoVvXe5/twAGlaxH6rxvkvuWRWI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <185D7EE10A691F46BD40E305BEFC8A01@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619b75fd-26a0-46ba-ccbf-08d61f5278ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 23:40:39.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0779
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTkvMTggNjowOCBBTSwgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+IEZyb206IE9z
Y2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gDQo+IG5vZGVfc3RhdGVzX2NsZWFy
IGhhcyB0aGUgZm9sbG93aW5nIGlmIHN0YXRlbWVudHM6DQo+IA0KPiBpZiAoKE5fTUVNT1JZICE9
IE5fTk9STUFMX01FTU9SWSkgJiYNCj4gICAgIChhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2gg
Pj0gMCkpDQo+ICAgICAgICAgLi4uDQo+IA0KPiBpZiAoKE5fTUVNT1JZICE9IE5fSElHSF9NRU1P
UlkpICYmDQo+ICAgICAoYXJnLT5zdGF0dXNfY2hhbmdlX25pZCA+PSAwKSkNCj4gICAgICAgICAu
Li4NCj4gDQo+IE5fTUVNT1JZIGNhbiBuZXZlciBiZSBlcXVhbCB0byBuZWl0aGVyIE5fTk9STUFM
X01FTU9SWSBub3INCj4gTl9ISUdIX01FTU9SWS4NCj4gDQo+IFNpbWlsYXIgcHJvYmxlbSB3YXMg
Zm91bmQgaW4gWzFdLg0KPiBTaW5jZSB0aGlzIGlzIHdyb25nLCBsZXQgdXMgZ2V0IHJpZCBvZiBp
dC4NCj4gDQo+IFsxXSBodHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNod29yay5rZXJuZWwub3JnJTJGcGF0Y2glMkYxMDU3
OTE1NSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDUGF2ZWwuVGF0YXNoaW4lNDBtaWNyb3NvZnQuY29t
JTdDMWUzMWU2YTVjODc1NGFiZTBiNDYwOGQ2MWUxN2UwMWMlN0M3MmY5ODhiZjg2ZjE0MWFmOTFh
YjJkN2NkMDExZGI0NyU3QzElN0MwJTdDNjM2NzI5NDg1MjQxMzY3NTg0JmFtcDtzZGF0YT16dGtQ
TnlSSXYyYzBqNWxydWp3R00lMkZyRDVpbjZHN0F2dmRxeFZYQ3p3R3MlM0QmYW1wO3Jlc2VydmVk
PTANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5k
ZT4NCg0KUmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3Nv
ZnQuY29tPg0KDQo+IC0tLQ0KPiAgbW0vbWVtb3J5X2hvdHBsdWcuYyB8IDYgKystLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+IGlu
ZGV4IGMyYzczNTliZDBhNy4uMTMxYzA4MTA2ZDU0IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnlf
aG90cGx1Zy5jDQo+ICsrKyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gQEAgLTE1OTAsMTIgKzE1
OTAsMTAgQEAgc3RhdGljIHZvaWQgbm9kZV9zdGF0ZXNfY2xlYXJfbm9kZShpbnQgbm9kZSwgc3Ry
dWN0IG1lbW9yeV9ub3RpZnkgKmFyZykNCj4gIAlpZiAoYXJnLT5zdGF0dXNfY2hhbmdlX25pZF9u
b3JtYWwgPj0gMCkNCj4gIAkJbm9kZV9jbGVhcl9zdGF0ZShub2RlLCBOX05PUk1BTF9NRU1PUlkp
Ow0KPiAgDQo+IC0JaWYgKChOX01FTU9SWSAhPSBOX05PUk1BTF9NRU1PUlkpICYmDQo+IC0JICAg
IChhcmctPnN0YXR1c19jaGFuZ2VfbmlkX2hpZ2ggPj0gMCkpDQo+ICsJaWYgKGFyZy0+c3RhdHVz
X2NoYW5nZV9uaWRfaGlnaCA+PSAwKQ0KPiAgCQlub2RlX2NsZWFyX3N0YXRlKG5vZGUsIE5fSElH
SF9NRU1PUlkpOw0KPiAgDQo+IC0JaWYgKChOX01FTU9SWSAhPSBOX0hJR0hfTUVNT1JZKSAmJg0K
PiAtCSAgICAoYXJnLT5zdGF0dXNfY2hhbmdlX25pZCA+PSAwKSkNCj4gKwlpZiAoYXJnLT5zdGF0
dXNfY2hhbmdlX25pZCA+PSAwKQ0KPiAgCQlub2RlX2NsZWFyX3N0YXRlKG5vZGUsIE5fTUVNT1JZ
KTsNCj4gIH0NCj4gIA0KPiA=
