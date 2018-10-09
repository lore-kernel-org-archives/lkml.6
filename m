Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324E3C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C679D2089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="IAvdeQRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C679D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeJIPpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:45:39 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:43637
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbeJIPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwlBfV6mugr/7tqw+A30bG2VZvgBin/SKAPwBVpBvfk=;
 b=IAvdeQRcqi4F8Dv/xydh2jhKiXXfNaNrdfiQRfMGNdSQQkRo0dls7Rhx636mi3XxlhzfmLWyyGlABXirF4sv4n+7tngx4EWY8b76VTz2YwEUF2B86R4QCFjMZKoW+3tnEwJw9hl6R0cFS9wQE3LCn/RJT8xGZl+Yvx4HsXvBZFE=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Tue, 9 Oct 2018 08:29:08 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd%2]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 08:29:08 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
Thread-Topic: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
Thread-Index: AQHUVkRSdlHfynMwIEC0L77BDqk26KUVbdWAgACxa4CAAH4OgIAACnOA
Date:   Tue, 9 Oct 2018 08:29:08 +0000
Message-ID: <bfbfd490-3872-2fd9-e088-3add596b987c@ysoft.com>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
 <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
 <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
 <CGME20181009002056epcas5p24207204c9e65e8f34382de6672adb993@epcas5p2.samsung.com>
 <20181009002031.GU3587@dragon>
 <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
In-Reply-To: <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:209:15::41) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5242;6:ATFF0x4zUj95diK6jT18/3P9WSmIxCFoPrBUHNxgyZyu6hv1LKSzmj5tbX2eSxlfwW+/wU7XsPaLUnv3e02ChQLxW10fpRqdz60k6Q7Cc9ISwSsCmUVovODVKuzXJQziX3zpZM+zdu3aI/ezdFs/wWuIBMS0uQ8xxJKhc3ISqWTGGGCbk2HLW8fESrXtGZyHHvi3cZ8TA+EMOrSBL/O1rMhCvgDeIonHZ/3ArFMk1Oe16yPOn7NCSHJtY2SzexOiBN7prUGKXL88WgPE1dIV9Ie1tdcnQi9JgHjheVs6pK6ybpu2Vu6hdtoexvdEhAFWSwT7+a9DPSv+kFUA6x1fabHbZwj1N9cSQUiKQ8UVa1bL7iM7GNsUZiYatE36WbfHDpDyA3UpYmXrMBtjBfyo1AeEO7tvVgPYDBy8gI+epcLAkzSqiSf860tJ3VODp24hAh5Xth0g9Vs0afhHJeGJow==;5:0/rl2u/BPV3GiQqyNOXK4Wb0Bv6wKuM6zhhpRDuwiSlbRR0qwry6VUQEutUnub7bMwtTTMPPws2JoGPvyQF23MvNIuO8faR/BgTp3xJuEFBFUCaJ8voaCkciQ8R6W5ugqmBUCrUvJFC8FL6CiFPN4ezwZL9QWv7fLYTPXvVhVjM=;7:ItZo8ty0WwWqPaU4+DkaY3uWNesh0JtEESzYClzYgFeqWhWqpP8DjZclQ/6FubAtSOHooyLAoXHF7jx6m7SNku6/lOvMJqvYv7JK6Maq3S8DsP99g5U9HI4BwonS/x245DgT8IDEkRAF6BKsj/XrvqG/bqPXARiOPY2EUwU3L4E2Ie3EX//G6hUHxRiE0JiiCocOZ1NeU+Lix4Jl09eenMWEVmkpkvvjLG44GJmQ7AWFIU6fR9fS48bXTmLp98Me
x-ms-office365-filtering-correlation-id: 93272d94-0bf3-406a-65d2-08d62dc14849
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5242;
x-ms-traffictypediagnostic: DB7PR04MB5242:
x-microsoft-antispam-prvs: <DB7PR04MB5242D9E4DAB0B199E70B2D329EE70@DB7PR04MB5242.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DB7PR04MB5242;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5242;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39850400004)(346002)(396003)(376002)(199004)(189003)(486006)(2616005)(53546011)(5660300001)(11346002)(476003)(72206003)(6506007)(186003)(386003)(99286004)(6486002)(6512007)(76176011)(2900100001)(446003)(110136005)(54906003)(6116002)(478600001)(3846002)(53936002)(25786009)(5250100002)(26005)(4326008)(102836004)(68736007)(6436002)(52116002)(85182001)(7736002)(71200400001)(229853002)(256004)(66066001)(31696002)(31686004)(8936002)(2906002)(14454004)(305945005)(86362001)(6246003)(81166006)(217873002)(316002)(93886005)(105586002)(97736004)(36756003)(8676002)(81156014)(106356001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5242;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R1mDpsXVKEbYKoqZfUy00XBsOptHF2habgoWrvRzZhPkupPaKfdxz8cfGavXeBRR8VEVA2Pq5gxoSmZ5au3tIvEWSwErY1sloxSnIUlTLp2+YX1VtdxB+PYbKM0SujzsjqKNNfNQ211vJjnkflhgBJLEZ1DQ6dFtbtW8qAYkfeX9Z/w37MPU3tiAQZ4Qcsu+zEfYrPAMJmPVEUA5JYzA0bOtZZynhgVutHYNUOATGOxmQnLP9A0/+5SWUF1QKLnLJAI46aOeHnWO18BftlQX3wokwQDhVataff2UsKTIo3K9YdQPMwg9i5WTqImnWNJ3hZDDML26Hmh72DHoDFruzw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAAA63CA2E856D41B4452063ADEF946E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93272d94-0bf3-406a-65d2-08d62dc14849
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 08:29:08.7180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS4xMC4yMDE4IDA5OjUxLCBCYXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6IHdyb3RlOg0KPiAN
Cj4gT24gMTAvMDkvMjAxOCAwMjoyMCBBTSwgU2hhd24gR3VvIHdyb3RlOg0KPj4gT24gTW9uLCBP
Y3QgMDgsIDIwMTggYXQgMTE6NDU6MzZBTSArMDAwMCwgVm9rw6HEjSBNaWNoYWwgd3JvdGU6DQo+
Pj4gT24gMjcuOS4yMDE4IDExOjI0LCBNaWNoYWwgVm9rw6HEjSB3cm90ZToNCj4+Pj4gVGhlIHJl
c2V0IHNpZ25hbCBvZiB0aGUgU1NEMTMwNiBPTEVEIGRpc3BsYXkgaXMgYWN0dWFsbHkgYWN0aXZl
LWxvdy4NCj4+Pj4gQWRhcHQgdGhlIERUIHRvIHJlZmxlY3QgdGhlIHJlYWwgd29ybGQuDQo+Pj4+
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBWb2vDocSNIDxtaWNoYWwudm9rYWNAeXNvZnQu
Y29tPg0KPj4+PiAtLS0NCj4+Pj4gdjIgY2hhbmdlczogTmV3IHBhdGNoIGluIHRoZSBzZXJpZXMN
Cj4+Pg0KPj4+IEJhcnRsb21pZWoganVzdCBxdWV1ZWQgdGhlIGZpcnN0IHR3byBwYXRjaGVzIGZv
ciB2NC4yMC4NCj4+PiBXaWxsIHNvbWVib2R5IHRha2UgdGhpcyBvbmU/IE90aGVyd2lzZSB0aGlz
IFNvTSB3aWxsIGVuZCB1cCB3aXRoDQo+Pj4gYnJva2VuIE9MRUQgZGlzcGxheSByZXNldC4NCj4+
DQo+PiBXZWxsLCBpdCBtZWFucyB0aGUgY2hhbmdlIGJyZWFrcyB0aGUgQUJJIGJldHdlZW4ga2Vy
bmVsIGFuZCBkZXZpY2UgdHJlZSwNCj4+IGUuZy4gdGhlIG5ldyBrZXJuZWwgd2lsbCBub3Qgd29y
ayB3aXRoIGV4aXN0aW5nL2luc3RhbGxlZCBEVEJzLg0KPiANCj4gU2hvdWxkIEkgcmV2ZXJ0IHRo
aXMgc2RkMTAzMDdmYiBwYXRjaCB0aGVuPw0KDQpTb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2Ug
OiggTGVzc29uIGxlYXJuZWQuLg0KDQpTbyBpbiBvdGhlciB3b3JkcyAobm8gb2ZmZW5zZSk6IGJy
b2tlbiBkcml2ZXJzIG5lZWQgdG8gc3RheSBicm9rZW4gYmVjYXVzZQ0KdXNlcnMgbWF5IGFscmVh
ZHkgZ2V0IHVzZWQgdG8gdGhlIGJyb2tlbiBiZWhhdmlvcj8NCg0KUGVyc29uYWxseSBJIHdvdWxk
IG5vdCBkZXNjcmliZSB0aGlzIGNoYW5nZSBhcyBhIGRldmljZSB0cmVlIEFCSSBjaGFuZ2UuDQpJ
dCBpcyBub3QgYSBjaGFuZ2UgaW4gdGhlIERUIGJpbmRpbmcuIE9yIGFyZSAic3RhYmxlIGRldmlj
ZSB0cmVlIEFQSSIgYW5kDQoiZGV2aWNlIHRyZWUgQUJJIiByZWFsbHkgdHdvIGRpZmZlcmVudCB0
aGluZ3M/DQoNClRoZSBmaXJzdCBwYXRjaCBzaG91bGQgYmUgT0sgdGhvdWdoLg0KDQpNaWNoYWwN
Cg==
