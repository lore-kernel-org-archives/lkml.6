Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E5DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C9420894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gBgR6c/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C9420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeH1R4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:56:13 -0400
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:52256
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbeH1R4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1HHZmErkYz73Po6qKc3T/bTU8PD6OO2fgF1TFLeguI=;
 b=gBgR6c/MyalGZLNF7DhVCWiuIgKVpnoNGnJX3b+1aaQY6kuf1X6b6CRoRP+QGfIvY5O1ww5+5UIemOflBokdCJLl4UY0ypP/2jXLkJvWFDcTdE8qlvbKpRWPjep2XKBpRbpSI0KKLvGUwRpJcouLYE90oJHmrlDwdHM25ScPp2s=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0122.namprd21.prod.outlook.com (10.173.173.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Tue, 28 Aug 2018 14:04:18 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.000; Tue, 28 Aug 2018
 14:04:18 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 3/4] mm/memory_hotplug: Define nodemask_t as a stack
 variable
Thread-Topic: [PATCH v4 3/4] mm/memory_hotplug: Define nodemask_t as a stack
 variable
Thread-Index: AQHUNgi+2c4UtTpI3UKBrMq93dNlBaTVQ/KA
Date:   Tue, 28 Aug 2018 14:04:18 +0000
Message-ID: <cc7e1bac-2efb-b23f-bd76-8e836abeba0e@microsoft.com>
References: <20180817090017.17610-1-osalvador@techadventures.net>
 <20180817090017.17610-4-osalvador@techadventures.net>
In-Reply-To: <20180817090017.17610-4-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0122;6:VUKyCalszhmCKXVJNFbG/cZgy2Xo658ww9GqjRV10oRwHCTysnUGvoY8kJXaLycDZXm5g72uWv6shVCc3Gm9tjovhNVWpA9pGheU8H1rKxGI++LTFG3SYP6kYFLaYDdbaM4oiLBXlJkUC25T9gOCMiyRnaNfuLoGPdw154a8xMqV22vnzEYqdhIWPGsXsOPikO4kGqtULHSlWC0+fb57O8KbD3UadtijOaCkI0yscXnqkftducXYAMotNkV7Z8oXoba6D194l2ajEneysPU0ChqLaZgO4iQhjBi5Ov0iVEugtk+16EG1FARpwJWB4DDohuGOHH4bQiV+aJdTUPzliTOs8fVIdrr2sdiCBQUggzcNfFxoeW1OwIHhduVuc9Bt3QG0agK9cd3z4qPU8qeo9ZUgF4x+M8gLBvfVE9LmEv1NEIJSNZrR3bivPO6QMSzxVmzXqAWrjs08o9XMnloNMw==;5:tNupC+tKpzfVdJV/2IripulaT2Uv1bDcZFIUM2QmWrM0QWkArrPtkxfRGiEJ8AFR+kJzibc6ng9NWaFetSa5ObVMoSNBigP5zmQNB0mjSzcmkOUAlKl+A8xiQYWocFwFbzqQ0KoSKVEoXvKMCnK2cBdeenaUIvQrQZQZvtddo5g=;7:w8/sC5O33tYYxux82Xk7Oej4/sNAP+uDxtEssAYBHG3v3ywWuCHrGjzsJRwTlVmODZ9C/oJo2/qq7VWrhZBi7AoxVDUMkDR4gBF5dEMjbd2Duf3QCB7lKXYa0+lFmjxjrmM+pletCEM39MwSI5+kUoHMHQjRZ/k7We+0bTRBnQBvWvy5wezcy6IO0K7xa4yw6cDAzqs9C6WmQ2FPLYWoVDXIfr7DpWBEieKJhpqp2W9FzW7vMUsukLQXtGW+7P2q
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8f483829-8ccc-409c-b211-08d60cef25ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0122;
x-ms-traffictypediagnostic: DM5PR21MB0122:
x-microsoft-antispam-prvs: <DM5PR21MB01225B4A91296A7C57CC993F9D0A0@DM5PR21MB0122.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0122;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0122;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(99286004)(446003)(10290500003)(229853002)(5660300001)(305945005)(97736004)(7736002)(2616005)(11346002)(6116002)(3846002)(6486002)(10090500001)(186003)(7416002)(25786009)(81166006)(81156014)(39060400002)(476003)(486006)(14454004)(66066001)(478600001)(54906003)(106356001)(76176011)(72206003)(4326008)(2906002)(53936002)(68736007)(26005)(31686004)(105586002)(8936002)(86612001)(2900100001)(36756003)(31696002)(2501003)(102836004)(256004)(86362001)(6346003)(6436002)(22452003)(110136005)(6506007)(6246003)(6512007)(316002)(14444005)(5250100002)(8676002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0122;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: 3uRbAMGU6YIQ4o3FdnbWL3pPNZujepbQtAEKDqi3feO2avB4wOaLyz2LtHgO8NlI/8OJ1SL6B2vIEJMRKb7M03rT+2NdActjV8qxO1pP3rIirmUv1aT6r472idTX8cM5NdnBQQ3ODLZs5B1oqbf3lPssMosPUtrvkxQSKx4KXOtWcGD+MpHxerCddpdj7S7ATKQAd57VcwR3x8EXoyL+GFYRhFUu92sTxg7spCH+srGhAn3dkenOvG6pJEY8QpjpgFI0RxDF0lw/zwPYey0R1jtLkgn+bC/fuZAAJMkGFVF1ubLKcfdbS34uBEnpKereon0Y8706DkuNqEXNp+ICi715e+yWSNJAzTi7H9dHBCs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4625BC5878357146B66649E77C2C3028@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f483829-8ccc-409c-b211-08d60cef25ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 14:04:18.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDgvMTcvMTggNTowMCBBTSwgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+IEZyb206IE9z
Y2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gDQo+IEN1cnJlbnRseSwgdW5yZWdp
c3Rlcl9tZW1fc2VjdF91bmRlcl9ub2RlcygpIHRyaWVzIHRvIGFsbG9jYXRlIGEgbm9kZW1hc2tf
dA0KPiBpbiBvcmRlciB0byBjaGVjayB3aGl0aGluIHRoZSBsb29wIHdoaWNoIG5vZGVzIGhhdmUg
YWxyZWFkeSBiZWVuIHVubGlua2VkLA0KPiBzbyB3ZSBkbyBub3QgcmVwZWF0IHRoZSBvcGVyYXRp
b24gb24gdGhlbS4NCj4gDQo+IE5PREVNQVNLX0FMTE9DIGNhbGxzIGttYWxsb2MoKSBpZiBOT0RF
U19TSElGVCA+IDgsIG90aGVyd2lzZQ0KPiBpdCBqdXN0IGRlY2xhcmVzIGEgbm9kZW1hc2tfdCB2
YXJpYWJsZSB3aGl0aGluIHRoZSBzdGFjay4NCj4gDQo+IFNpbmNlIGttYWxsb2MoKSBjYW4gZmFp
bCwgd2UgYWN0dWFsbHkgY2hlY2sgd2hldGhlciBOT0RFTUFTS19BTExPQyBmYWlsZWQNCj4gb3Ig
bm90LCBhbmQgd2UgcmV0dXJuIC1FTk9NRU0gYWNjb3JkaW5nbHkuDQo+IHJlbW92ZV9tZW1vcnlf
c2VjdGlvbigpIGRvZXMgbm90IGNoZWNrIGZvciB0aGUgcmV0dXJuIHZhbHVlIHRob3VnaC4NCj4g
SXQgaXMgcHJldHR5IHJhcmUgdGhhdCBzdWNoIGEgdGlueSBhbGxvY2F0aW9uIGNhbiBmYWlsLCBi
dXQgaWYgaXQgZG9lcywNCj4gd2Ugd2lsbCBiZSBsZWZ0IHdpdGggZGFuZ2xlZCBzeW1saW5rcyB1
bmRlciAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvLA0KPiBzaW5jZSB0aGUgbWVtX2JsaydzIGRp
cmVjdG9yaWVzIHdpbGwgYmUgcmVtb3ZlZCBubyBtYXR0ZXIgd2hhdA0KPiB1bnJlZ2lzdGVyX21l
bV9zZWN0X3VuZGVyX25vZGVzKCkgcmV0dXJucy4NCj4gDQo+IE9uZSB3YXkgdG8gc29sdmUgdGhp
cyBpcyB0byBjaGVjayB3aGV0aGVyIHVubGlua2VkX25vZGVzIGlzIE5VTEwgb3Igbm90Lg0KPiBJ
biB0aGUgY2FzZSBpdCBpcyBub3QsIHdlIGNhbiBqdXN0IHVzZSBpdCBhcyBiZWZvcmUsIGJ1dCBp
ZiBpdCBpcyBOVUxMLA0KPiB3ZSBjYW4ganVzdCBza2lwIHRoZSBub2RlX3Rlc3RfYW5kX3NldCBj
aGVjaywgYW5kIGNhbGwgc3lzZnNfcmVtb3ZlX2xpbmsoKQ0KPiB1bmNvbmRpdGlvbmFsbHkuDQo+
IFRoaXMgaXMgaGFybWxlc3MgYXMgc3lzZnNfcmVtb3ZlX2xpbmsoKSBiYWNrcyBvZmYgc29tZXdo
ZXJlIGRvd24gdGhlIGNoYWluDQo+IGluIGNhc2UgdGhlIGxpbmsgaGFzIGFscmVhZHkgYmVlbiBy
ZW1vdmVkLg0KPiBUaGlzIG1ldGhvZCB3YXMgcHJlc2VudGVkIGluIHYzIG9mIHRoZSBwYXRoIFsx
XS4NCj4gDQo+IEJ1dCBzaW5jZSB0aGUgbWF4aW11bSBudW1iZXIgb2Ygbm9kZXMgd2UgY2FuIGhh
dmUgaXMgMTAyNCwNCj4gd2hlbiBOT0RFU19TSElGVCA9IDEwLCB0aGF0IGdpdmVzIHVzIGEgbm9k
ZW1hc2tfdCBvZiAxMjggYnl0ZXMuDQo+IEFsdGhvdWdoIGV2ZXJ5dGhpbmcgZGVwZW5kcyBvbiBo
b3cgZGVlcCB0aGUgc3RhY2sgaXMsIEkgdGhpbmsgd2UgY2FuIGFmZm9yZA0KPiB0byBkZWZpbmUg
dGhlIG5vZGVtYXNrX3QgdmFyaWFibGUgd2hpdGhpbiB0aGUgc3RhY2suDQo+IA0KPiBUaGF0IHNp
bXBsaWZpZXMgdGhlIGNvZGUsIGFuZCB3ZSBkbyBub3QgbmVlZCB0byB3b3JyeSBhYm91dCB1bnRl
c3RlZCBlcnJvcg0KPiBjb2RlIHBhdGhzLg0KPiANCj4gSWYgd2Ugc2VlIHRoYXQgdGhpcyBjYXVz
ZXMgdHJvdWJsZXMgd2l0aCB0aGUgc3RhY2ssIHdlIGNhbiBhbHdheXMgcmV0dXJuIHRvIFsxXS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4N
Cg0KTEdUTToNCg0KUmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBt
aWNyb3NvZnQuY29tPg0KDQpUaGFuayB5b3UsDQpQYXZlbA==
