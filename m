Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC60206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lfXYq8Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC60206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503813AbeKWWRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:17:05 -0500
Received: from mail-eopbgr50129.outbound.protection.outlook.com ([40.107.5.129]:59894
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388116AbeKWWRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZQ+v6tyMEBZr5LdKgLDlNclwwbkMy//+LYX+mmDvIw=;
 b=lfXYq8Edfz0wQDp8/usylXtPIGY6ulOXPUe/x/FsUmV2NU61cTraKbD7OtVyQOT/bH+/iNXOeTML4Ili9xQTY9Hkt3fhb1+f2CqL/Fnwvbe64e03ksfunKKdN71g+N7NFAa1wHqUqekH1EWQHBIHM0dxCR5+hsRpHv0I//V2vfw=
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com (10.168.188.135) by
 HE1PR0701MB2076.eurprd07.prod.outlook.com (10.167.190.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.9; Fri, 23 Nov 2018 11:33:07 +0000
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77]) by HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77%9]) with mapi id 15.20.1361.013; Fri, 23 Nov 2018
 11:33:07 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Topic: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Index: AQHUgxDmRuGauPbUmUaN5hsWx0CViKVdKY2AgAAQ6IA=
Date:   Fri, 23 Nov 2018 11:33:07 +0000
Message-ID: <679e7fb8-f424-b72c-ac8a-315926080ede@nokia.com>
References: <20181122123552.15756-1-tudor.ambarus@microchip.com>
 <3d8a2b83-282d-7cb2-3c8b-addae3c2af7f@nokia.com>
 <65d03690-a475-dc5b-ab9d-14e6216ba0bd@microchip.com>
In-Reply-To: <65d03690-a475-dc5b-ab9d-14e6216ba0bd@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
x-clientproxiedby: HE1PR09CA0082.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::26) To HE1PR0701MB2729.eurprd07.prod.outlook.com
 (2603:10a6:3:99::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0701MB2076;6:gdeSAoRoxAjArn8wOdog1yhYIt7ALg/OpZ9Ncl3Y/oA/Ygw+kPp7nFlXFATZ/givh4A3o8H5IwDOVjlJXMs6a1ou0O2aHCZ7KN3RZ7Q8AlNTFjlkB0sIpUBdIl19zflylrpe/J/U7/IHZ+hy1mabPWDNip0z23+s5EoeR2DSa3Xj0ocoT03WAvNA+dRBVLgWyd+SAw7Yc9oG4X2bjwpqEEd9nDGdXLevTgQzuh962S/XBCPXT4sldfDlgOY0UWZDDN6mNExvPICK3pgZDEcSJ5PS0tykIbMNin3i6CnEThCqX2y1XEqlox8ZSHofkrgLGx4/4ygQcEFUvkygH8XSfBexENj6SzypxzjGVNWb9OFSe4DXXOtpN/Z4M43KdsBJ9GIg5JSu3HK0tS6DAYkRukjYk1DFUprp6FBrvcsmsfRNkuBLf0VYd8jsCR+BBoB7XhqVG8PPVq4TM5aXaHPPZg==;5:DDP0o8F1GgnJF6dZp/6cdfIJvsGU9mLdJmCxdxG7zcwdlmKhlOXKtZsB7tIdWUveJJBWEH3Rimba/s+ifgcGld1ZPRZQdRJEF6+ZV6TNpqf7hoFK/NdFqBwvBo0oLuayy1tIvNAQpNSuULfb4WsuMKY5Fwcj6Zr31tSNAfLoQzU=;7:bHjETfAQlOJgqBfErKsrgU7JIKMsFkxnJFW2pvSy7UjAn7iItNnYS5o7zGnPt/09eF2wzqFeml0PwTIeCFqIsOZCnWBDxhzHk2Qx/m/SDQeDyN/3hbmLBUbFmLo4GMQdBSgW8GncMNrAjnjf6Pkjeg==
x-ms-office365-filtering-correlation-id: 7ae2bbd4-211e-4a5a-1605-08d651376f54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0701MB2076;
x-ms-traffictypediagnostic: HE1PR0701MB2076:
x-microsoft-antispam-prvs: <HE1PR0701MB2076CA06B8AF4DE69B16258588D40@HE1PR0701MB2076.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(11241501184)(806099)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0701MB2076;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2076;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(2906002)(26005)(53936002)(486006)(6246003)(14444005)(256004)(11346002)(446003)(25786009)(2501003)(64126003)(97736004)(476003)(68736007)(2616005)(39060400002)(305945005)(6116002)(3846002)(65826007)(186003)(6512007)(5660300001)(4326008)(71200400001)(71190400001)(7736002)(2900100001)(31696002)(76176011)(2201001)(81156014)(6486002)(81166006)(8676002)(8936002)(31686004)(105586002)(386003)(86362001)(52116002)(99286004)(102836004)(6436002)(106356001)(316002)(6506007)(53546011)(478600001)(229853002)(36756003)(14454004)(66066001)(65956001)(65806001)(54906003)(110136005)(58126008)(473944003)(414714003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2076;H:HE1PR0701MB2729.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3mtbp2MzPdAv/13I/gTYjf8ko9qcmkQ41f9ATMd3UWPHVAn8JbiX+prAjFE121LcBPvD4+tkpeyJs31MBmJadz3Bb3JkjyBBxvdr7ENKXTE3L11dv1IaMNt/1n3K5p8cvHPoMEsf8VjM6dVCoLVohQC2pCboiPXQst8T+Dx4mmMlhrFIWqYKidRMu1Ft0Sh23Jjf+9dbOxiw85Ngu0JksP2W+wAV6QRtaP2lGFF1EQgZzGIfJo/2WBTGT9STwpH4xyVLjYWCdENJp9BtcleRgKkaA7k+7HphptwoqJpyXq69tb2hnM6qS7QkCWuO99kNjoN5NEgtG8vD9liAP2hvDznA/tqvtCSIFVlQHOjrBB8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7589A192E7D21A48B0470B71C372E894@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae2bbd4-211e-4a5a-1605-08d651376f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 11:33:07.5446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IsDQoNCk9uIDIzLzExLzIwMTggMTE6MzIsIFR1ZG9yLkFtYmFydXNAbWljcm9j
aGlwLmNvbSB3cm90ZToNCj4+IEkndmUgdGVzdGVkIHRoaXMgcGF0Y2ggYW5kIGl0IGZpeGVzIHRo
ZSBlcmFzZXNpemUgZm9yIFMyNUZTMTI4UyBhbmQNCj4+IG91ciAxMjhrIHBhcnRpdGlvbnMgYXJl
IHdyaXRlYWJsZSBhZ2FpbiB3aXRoIHRoaXMgcGF0Y2guDQo+IEdvb2QuIFlvdSBzYWlkIHRoYXQg
dGhlIGZsYXNoIGlzIGNvbmZpZ3VyZWQgaW4gbm9uLXVuaWZvcm0gbWFwcGluZyAoaHlicmlkDQo+
IHNlY3RvciBvcHRpb24pLiBUaGVyZSBpcyBubyB1bmlmb3JtIGVyYXNlIHR5cGUgdGhhdCBjYW4g
ZXJhc2UgdGhlIGVudGlyZQ0KPiBmbGFzaCBtZW1vcnkgYnkgaXRzIG93biwgc28gdGhlIGVyYXNl
IHNob3VsZCBiZSBkb25lIHVzaW5nIHRoZSBub24tdW5pZm9ybQ0KPiBlcmFzZSBjb2RlIChzcGlf
bm9yX2hhc191bmlmb3JtX2VyYXNlKCkgc2hvdWxkIHJldHVybiBmYWxzZSkuIERvZXMgdGhlDQo+
IG5vbi11bmlmb3JtIGVyYXNlIHdvcmsgYXMgZXhwZWN0ZWQ/IA0KDQp1bmZvcnR1bmF0ZWx5LCBp
dCBkb2Vzbid0LiBJIHdhcyB0b28gZmFzdCByZXBvcnRpbmcgdGhlIHN1Y2Nlc3MuLi4NClNvIGVy
YXNlc2l6ZSBpcyBiYWNrIHRvIHRoZSB2YWx1ZSBiZWZvcmUgbm9uLXVuaWZvcm0gc3VwcG9ydCBw
YXRjaGVzLA0KcGFydGl0aW9ucyBhcmUgbm90IG1hZGUgcmVhZCBvbmx5IGFueSBtb3JlLCBidXQg
YWN0dWFsIHdyaXRlIG9yDQplcmFzZSBzdGlsbCBmYWlscy4NCg0KSSdsbCBpbnZlc3RpZ2F0ZSBm
dXJ0aGVyLg0KDQpUYWtpbmcgaW50byBhY2NvdW50IHRoZSBjb21tZW50cyBmcm9tIEJvcmlzLCB3
ZSBwcm9iYWJseSBuZWVkIHRoaXMgcGF0Y2gNCmFueXdheS4NCg0KPiBGb3IgZXhhbXBsZSwgaWYg
dGhlIGh5YnJpZCBzZWN0aW9uIGlzIGF0IHRoZSB0b3Agb2YgdGhlIGFkZHJlc3Mgc3BhY2UsIHdo
ZW4NCj4gdXNpbmcgbXRkX3V0aWxzOg0KPiAkIG10ZF9kZWJ1ZyBlcmFzZSAvZGV2L3lvdXJfbXRk
IDQwOTYgMTI2OTc2DQo+IEkgd291bGQgZXhwZWN0IHRoZSB1c2Ugb2YgdGhlIGZvbGxvd2luZyBl
cmFzZSB0eXBlczogNyo0aywgMzJrLCA2NGsNCj4gVGhlbiB3cml0ZSBhbmQgcmVhZCBiYWNrIHRv
IGNoZWNrIGlmIHRoZSBlcmFzZSB3YXMgZG9uZSBjb3JyZWN0bHk6DQo+ICQgZGQgaWY9L2Rldi91
cmFuZG9tIG9mPWluIGJzPTQwOTYgY291bnQ9MzENCj4gJCBtdGRfZGVidWcgd3JpdGUgL2Rldi95
b3VyX210ZCA0MDk2IDEyNjk3NiBpbg0KPiAkIG10ZF9kZWJ1ZyByZWFkIC9kZXYveW91cl9tdGQg
NDA5NiAxMjY5NzYgb3V0DQo+ICQgc2hhMXN1bSBpbiBvdXQNCj4gdGhlIG91dHB1dCBzaG91bGQg
YmUgdGhlIHNhbWUuDQo+IA0KPiBGZWVsIGZyZWUgdG8gYWRkIHNvbWUgcHJpbnRzIGluIHRoZSBj
b2RlIHRvIGJlIHN1cmUgdGhhdCBub24tdW5pZm9ybSBlcmFzZSBjb2RlDQo+IHNlbGVjdHMgdGhl
IGNvcnJlY3QgZXJhc2UgdHlwZXMuDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkFsZXhhbmRl
ciBTdmVyZGxpbi4NCg==
