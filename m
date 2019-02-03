Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A79C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA9F217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="emfH+eSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfBCMU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:20:29 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18675 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfBCMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:20:29 -0500
X-IronPort-AV: E=Sophos;i="5.56,556,1539673200"; 
   d="scan'208";a="26245025"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Feb 2019 05:20:28 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sun, 3 Feb 2019 05:20:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSuygxr80QQ8/ewvoNhPrOaSIEhvYrXCkBaoKD1DbJ8=;
 b=emfH+eSf6t8bmsdUpLKZoIte+MzBwMfgJHKoKOLBicAyQoPMUBwiKDLocavZ3KQoMEBCmvehv0WCLJRosgziqGtk5Cssd0PI/G3DkHpVBwAbcQc2Cg2k7fC8pAPT0lKEMNc8TOCG3yOPgXdcxuIB3adXbYuWQfvbl1wzdtdaayg=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1969.namprd11.prod.outlook.com (10.175.95.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Sun, 3 Feb 2019 12:20:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 12:20:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <purna.chandra.mandal@intel.com>, <f.blogs@napier.co.nz>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <computersforpeace@gmail.com>, <linux-mtd@lists.infradead.org>,
        <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in
 STIG mode
Thread-Topic: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data
 in STIG mode
Thread-Index: AQHUtsavKRvL8tLgwUyF1Z5VOHqEWaXOCBEA
Date:   Sun, 3 Feb 2019 12:20:20 +0000
Message-ID: <82eafaf8-803e-36a9-49ca-83d84c55537a@microchip.com>
References: <20190128050229.44965-1-purna.chandra.mandal@intel.com>
In-Reply-To: <20190128050229.44965-1-purna.chandra.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0401CA0009.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.121.188.150]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1969;6:y1NHKvjrj+zJmePT25QGX99NXozkgLqItwP1RHQklJeFlSNabPZ+BeUHArE9zJ7g8X5B4li34D+oTFNrlNheN8WKzGaeyRcqCyXHZMBIBSpS2Yu+hnEitUTv8IaoQMbRRdMqam/3WdZE18c4hGjM/QD67g2GHR0dFkGBqL1bB6LVzWbctYvJON+dYIxPsZld/iq1Z8vySpdeqCUowDwYZ5/GX2vwICZzBjxs/5L5m5DBbC2KH+StUd4VPq7L0avKGKt9E9M7zZI2cOyaOyjOX3Uf5lYTJxDXmQVdqDIO9I1gOCIFeQ8K+3/h0mp0PPyJiFGilkjPjPa4x7cDlp/6Rg3QaHI0itzdbIgx6H//YA1T32+YVLG4yvEFm92TEhcViUQ9yCMAh2bhcRwm/JgK/PSpgdRVTeA9mKvCu6ZLKD95Y9aXy1/8Lps5D9pt7mi30Z/RELDwd/YJX48OjluFCg==;5:3XAQ/bM6h+t5MltJ3uUU/avOffnRrr5Wgu3zag9ZFCqmPSMMSrjJWqvtnAygXKGFekUi1bdgVHUt0UD6e6nTEqEdG+37MXNe2pQcbZset11+tpqxWC098N5SCFoeGp6FgUxUDel8cqjN8atANVRjmeRBVwXMqn6yOkmtzc2SVxdIUc4zEtDHx/63PXtP+a6naMIJYj96S5fCphr1CI5Wsg==;7:pgrGKnb+8WyOOGgFPE+gSTnOOekmHexFLiokA8NYIYVhHRagwWxKaBa3BPlUM7u+4yfvhKv8s0RmqRYfuyy7f3nacW3n/d5Gy7mKB3LtI3uCSjxQO3QY0zBvs0ZM6A0CppK2xLX+qlML7XtuVi/SRQ==
x-ms-office365-filtering-correlation-id: 05f4b5d5-db63-4fb4-838a-08d689d1f6fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1969;
x-ms-traffictypediagnostic: BN6PR11MB1969:
x-microsoft-antispam-prvs: <BN6PR11MB1969DF28AA13DAC39323D0BBF06C0@BN6PR11MB1969.namprd11.prod.outlook.com>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(346002)(366004)(376002)(199004)(189003)(3846002)(7416002)(7736002)(105586002)(6436002)(72206003)(6116002)(86362001)(6486002)(8936002)(110136005)(53546011)(478600001)(8676002)(81166006)(386003)(2501003)(102836004)(26005)(6506007)(305945005)(11346002)(81156014)(6512007)(14454004)(66066001)(486006)(229853002)(186003)(2616005)(476003)(54906003)(25786009)(97736004)(39060400002)(2906002)(446003)(68736007)(31686004)(53936002)(71190400001)(71200400001)(316002)(106356001)(31696002)(4326008)(256004)(36756003)(6246003)(76176011)(99286004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1969;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n0i5Y/GAuPvaunhmN6Mc7G5IDObsqBfDysUd2z1JCUpLDsqHYP9/RKEu+yf2sZmkB2S7zeGnzuloH53IiZH5KIQiv1AKd3ZgWt2dnVob/VajXQJOu664t9X68y9lxLvSVhsInZ3YL3sO2D2K2bB1+uqUiLlzW3NZq9RgyckNUe2lKtNfCGquME5bhtJimZk3mA4Ml/B3nGIjPYHXD0KeuGk0xgD9aXQi1mpN420OzxnU6RBWb3GRNO2Ba4fzPltmjXBiCslmL7PhGXmmr3LziwC+KbbnIHYU81m1KX23Wdi+tEpID2g6tk6owH++dEaCQAUTbYE4EKmyKl+pqDre1hSzuwNNSn9YH4rPWBD3imhjPDgT55eXGGoIEq/zE/u4bENLICvAfee49QQS8rUx5SiXzrGY479uD22XiUhWQYA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50D78FB9539C2649A43C2A87BFE657E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f4b5d5-db63-4fb4-838a-08d689d1f6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 12:20:18.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1969
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBWaWduZXNoDQoNCk9uIDAxLzI4LzIwMTkgMDc6MDIgQU0sIFB1cm5hIENoYW5kcmEgTWFuZGFs
IHdyb3RlOg0KPiBjYWRlbmNlLXF1YWRzcGkgY29udHJvbGxlciBhbGxvd3MgdXB0byBlaWdodCBi
eXRlcyBvZiBkYXRhIHRvDQo+IGJlIHdyaXR0ZW4gaW4gc29mdHdhcmUgVHJpZ2dlcmVkIEluc3Ry
dWN0aW9uIGdlbmVyYXRvciAoU1RJRykgbW9kZQ0KPiBvZiBvcGVyYXRpb24uIExvd2VyIDQgYnl0
ZXMgYXJlIHdyaXR0ZW4gdGhyb3VnaCB3cml0ZWRhdGFsb3dlciBhbmQNCj4gdXBwZXIgNCBieXRl
cyBieSB3cml0ZWRhdGF1cHBlciByZWdpc3Rlci4NCj4gDQo+IFRoaXMgcGF0Y2ggYWxsb3dzIGFs
bCB0aGUgOCBieXRlcyB0byBiZSB3cml0dGVuLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHVybmEg
Q2hhbmRyYSBNYW5kYWwgPHB1cm5hLmNoYW5kcmEubWFuZGFsQGludGVsLmNvbT4NCg0KTG9va3Mg
Z29vZCBmb3IgbWU6DQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0Bt
aWNyb2NoaXAuY29tPg0KDQpWaWduZXNoLCBjYW4gd2UgaGF2ZSB5b3VyIFItYiBvciBULWIgdGFn
Pw0KDQpDaGVlcnMsDQp0YQ0KDQo+IC0tLQ0KPiANCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY2Fk
ZW5jZS1xdWFkc3BpLmMgfCAxNSArKysrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2Nh
ZGVuY2UtcXVhZHNwaS5jDQo+IGluZGV4IDA0Y2VkZDNhMmJmNi4uN2Y3OGY5NDA5ZGRkIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jDQo+ICsrKyBi
L2RyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMNCj4gQEAgLTQxOCw5ICs0MTgs
MTAgQEAgc3RhdGljIGludCBjcXNwaV9jb21tYW5kX3dyaXRlKHN0cnVjdCBzcGlfbm9yICpub3Is
IGNvbnN0IHU4IG9wY29kZSwNCj4gIAl2b2lkIF9faW9tZW0gKnJlZ19iYXNlID0gY3FzcGktPmlv
YmFzZTsNCj4gIAl1bnNpZ25lZCBpbnQgcmVnOw0KPiAgCXVuc2lnbmVkIGludCBkYXRhOw0KPiAr
CXUzMiB3cml0ZV9sZW47DQo+ICAJaW50IHJldDsNCj4gIA0KPiAtCWlmIChuX3R4ID4gNCB8fCAo
bl90eCAmJiAhdHhidWYpKSB7DQo+ICsJaWYgKG5fdHggPiBDUVNQSV9TVElHX0RBVEFfTEVOX01B
WCB8fCAobl90eCAmJiAhdHhidWYpKSB7DQo+ICAJCWRldl9lcnIobm9yLT5kZXYsDQo+ICAJCQki
SW52YWxpZCBpbnB1dCBhcmd1bWVudCwgY21kbGVuICVkIHR4YnVmIDB4JXBcbiIsDQo+ICAJCQlu
X3R4LCB0eGJ1Zik7DQo+IEBAIC00MzMsMTAgKzQzNCwxOCBAQCBzdGF0aWMgaW50IGNxc3BpX2Nv
bW1hbmRfd3JpdGUoc3RydWN0IHNwaV9ub3IgKm5vciwgY29uc3QgdTggb3Bjb2RlLA0KPiAgCQly
ZWcgfD0gKChuX3R4IC0gMSkgJiBDUVNQSV9SRUdfQ01EQ1RSTF9XUl9CWVRFU19NQVNLKQ0KPiAg
CQkJPDwgQ1FTUElfUkVHX0NNRENUUkxfV1JfQllURVNfTFNCOw0KPiAgCQlkYXRhID0gMDsNCj4g
LQkJbWVtY3B5KCZkYXRhLCB0eGJ1Ziwgbl90eCk7DQo+ICsJCXdyaXRlX2xlbiA9IChuX3R4ID4g
NCkgPyA0IDogbl90eDsNCj4gKwkJbWVtY3B5KCZkYXRhLCB0eGJ1Ziwgd3JpdGVfbGVuKTsNCj4g
KwkJdHhidWYgKz0gd3JpdGVfbGVuOw0KPiAgCQl3cml0ZWwoZGF0YSwgcmVnX2Jhc2UgKyBDUVNQ
SV9SRUdfQ01EV1JJVEVEQVRBTE9XRVIpOw0KPiAtCX0NCj4gIA0KPiArCQlpZiAobl90eCA+IDQp
IHsNCj4gKwkJCWRhdGEgPSAwOw0KPiArCQkJd3JpdGVfbGVuID0gbl90eCAtIDQ7DQo+ICsJCQlt
ZW1jcHkoJmRhdGEsIHR4YnVmLCB3cml0ZV9sZW4pOw0KPiArCQkJd3JpdGVsKGRhdGEsIHJlZ19i
YXNlICsgQ1FTUElfUkVHX0NNRFdSSVRFREFUQVVQUEVSKTsNCj4gKwkJfQ0KPiArCX0NCj4gIAly
ZXQgPSBjcXNwaV9leGVjX2ZsYXNoX2NtZChjcXNwaSwgcmVnKTsNCj4gIAlyZXR1cm4gcmV0Ow0K
PiAgfQ0KPiANCg==
