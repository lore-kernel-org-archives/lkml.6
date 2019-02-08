Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333AEC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB60A20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="B8b1n5mY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfBHM1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:27:54 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:4991 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:27:54 -0500
X-IronPort-AV: E=Sophos;i="5.58,347,1544511600"; 
   d="scan'208";a="23581343"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Feb 2019 05:27:53 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 8 Feb 2019 05:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7HG3irp66dkoBvP4Nt45fvvA3IkoezTvatPhw3ovCY=;
 b=B8b1n5mYvAWAk19q8i5mc4pH/8NrKJf6otmWYa5FZgtdqlVPu153VjdPiA9mFZlqC+C9cBTfPZJlN4Y4u3pYRUAABi/EFGrJNQRTyhwA5RhG35iMC63WSGHYhVAys67Pi61a+bV6WqtleoVutgCY0hWmnHGaGpnkJHYeNZr4NSI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1795.namprd11.prod.outlook.com (10.175.98.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 12:27:51 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 12:27:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <beanhuo@micron.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] include: mtd: spi-nor: change HWCPAS to HWCAPS
Thread-Topic: [EXT] Re: [PATCH] include: mtd: spi-nor: change HWCPAS to HWCAPS
Thread-Index: AdS+60iqy/bLyT9iSLSC+lMdoEdfvQArYGaAAAIzopAAAgYLAA==
Date:   Fri, 8 Feb 2019 12:27:51 +0000
Message-ID: <102fb723-c66f-d6f3-bd1e-7b0585458f2d@microchip.com>
References: <BYAPR08MB45338B3B9FE13B8FB3070789DB680@BYAPR08MB4533.namprd08.prod.outlook.com>
 <f167ad30-2a15-e430-1a6e-d1e1ba455b67@microchip.com>
 <BYAPR08MB4533E2C1B5CBD0789F1A1F0EDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
In-Reply-To: <BYAPR08MB4533E2C1B5CBD0789F1A1F0EDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0019.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::29) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1795;6:RziCltlCtYrIJ9iwwbbTjLpJEta4CpSRXxnE+qNKQvNtxPLFwV7BDviFEEQ1Y5mcWgDZYDlAOA0Usw7eiF0Q0lwdUMBd5NYO0wOgPMW3lulUMMCsvq5GmBZkKqPFleqAA19tIOgJb40agi5LoeiRpXCq3Utk5eBcnQNYG86I3XMFyW+aFu5f+En9nBvSxb9QqoUsNQTe4hw+Qpsh3vmplHjan8kxWqI0MXMpoTOx1z+nMZR+ToB3uK5QrYLPXcyg51xszM02iKOTzcewJv4iRLHk8MozbzEmO/kGNU85KXTf4zWoUDV0nG0kHmxgGGCnbeP4+1iZuEtAvApSKXxGuDOUghg5XBtdckHup9tnVzrAqx/5LCqDPbHDn2qxaDaP6K4CHFjplozR1v2dZzh5YOwC3EpQ6voRBztEx9mtb9msIhU2AF3pPEXFPzXFLYmSgNLv3NbXGD4SvQRSRu2MLw==;5:zIchyWC4wknpGl1dxQSQJEFyn/EzAYrze/7O5J2Iy6D0aYjW74/K8px96NeNouadVH5888IhPaoSdg3k36ko4X1Dga2dgYgJ7EosaPKs369qTTlcYydHbamc0Yt5vXayZjdouCOfbPQ69NKqtMCZFGpg0ljTjc7JArGabmjGKigNlglrNuXXMq+eqgbgRcTwKH1UbTqKdEPmA85wjCh5xg==;7:o6/7NIku9KmdVklofkZwsTxfw1m/HuDSu+75pMSIrbmxSIkZ8GWoyHUeWrnmoO1IapsxwTYxVR1kaDlQVD4Ko6ZzouiCEvB4LyeAeaBpHRKsemg5buJmJUYod2NkvuDrgd/0oALXxfNZzMN6Ce9Ryg==
x-ms-office365-filtering-correlation-id: 85f939aa-d575-45bb-35ce-08d68dc0d79a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1795;
x-ms-traffictypediagnostic: BN6PR11MB1795:
x-microsoft-antispam-prvs: <BN6PR11MB17950FA21B9BB7241D364DE3F0690@BN6PR11MB1795.namprd11.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(76176011)(386003)(6506007)(305945005)(256004)(8936002)(26005)(186003)(99286004)(7736002)(52116002)(36756003)(53546011)(86362001)(97736004)(53936002)(2201001)(31686004)(14444005)(106356001)(105586002)(25786009)(110136005)(54906003)(2501003)(102836004)(2906002)(68736007)(31696002)(316002)(72206003)(6436002)(6486002)(6116002)(6512007)(81156014)(486006)(71190400001)(71200400001)(476003)(2616005)(446003)(8676002)(11346002)(81166006)(66066001)(6246003)(4326008)(14454004)(3846002)(229853002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1795;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pkRXeUpDMbaNHCNnRx0H2DcerjVJ7ZwA8vPRY2CXC3w6RwKSnopmf3ltQCH0bvszNIWVa7XZtUrfYwUJfTmcnhpGW+ICmBcAJivhnoVXlk0SB6zURQdMeYYbQboCEf8JsX1JGca4OVGcfHRkT0IxrTVRGhJBt8XJDzDrucuJwYfjRoQ+VH19gGghcaZ1XJ64yrGnDLQ/rzEJQwuZt/ysTkhJ0/kIFkrrlKUESKMJkhxjyv5GSQFpvj6iJJ0/lKnZ7V3rpdOyPbq3QHgUD2oWdg3Q0HkuZpL4JCOWZtIZ+yBbC/V1QQihRKwqpUlkkEcIEzrhBF2csWQmGWTGAkGzFNv2gl8y8qKTjQ5oCYGH3+skSdqbDw3/qACChyyHu2X9Touw6UVgr8NKFZML6S0eva+pvPjz2fIqx1OZCvzBCXY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5487A002132CC7458ABE85AFEA9A8BF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f939aa-d575-45bb-35ce-08d68dc0d79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 12:27:49.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1795
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzA4LzIwMTkgMDE6MzkgUE0sIEJlYW4gSHVvIChiZWFuaHVvKSB3cm90ZToNCj4g
SGksIFR1ZG9yDQo+IA0KPj4gU05PUl9IV0NQQVNfUkVBRF9PQ1RPIHdhcyByZW5hbWVkIHRvIFNO
T1JfSFdDUEFTX1JFQURfT0NUQUwNCj4+IHBsZWFzZSB1cGRhdGUgeW91ciByZW1vdGUgYW5kIHNl
bmQgYSBuZXcgcGF0Y2guDQo+Pg0KPiBXaGljaCBicmFuY2ggZG8geW91IG1lYW4/IEkgY2hlY2tl
ZCBsaW51eC1tdGQsIG5vdCByZW5hbWVkIHlldC4NCg0Kc3BpLW5vci9uZXh0DQoNCj4gDQo+PiBU
aGUgcGF0Y2ggcHJlZml4IGlzIHdyb25nLCBpdCBzaG91bGQgYmUgcHJlZml4ZWQgd2l0aCAibXRk
OiBzcGktbm9yOiIuIFdoZW4gaW4NCj4+IGRvdWJ0LCB5b3UgY2FuIGNoZWNrIGhvdyB3ZXJlIHBy
ZWZpeGVkIHByZXZpb3VzIHBhdGNoZXMgb24gdGhlIHNhbWUgZmlsZSBieQ0KPj4gcnVubmluZyBz
b21ldGhpbmcgbGlrZToNCj4+DQo+PiBnaXQgbG9nIC0tb25lbGluZSBpbmNsdWRlL2xpbnV4L210
ZC9zcGktbm9yLmgNCj4+DQo+PiBPbiAwMi8wNy8yMDE5IDAzOjQ2IFBNLCBCZWFuIEh1byAoYmVh
bmh1bykgd3JvdGU6DQo+Pj4NCj4+DQo+PiBUaGlzIGxvb2tzIGxpa2UgYSBibGFuayBsaW5lLCBp
dCdzIG5vdCBuZWVkZWQsIHJlbW92ZSBpdCBwbGVhc2UuDQo+Pj4gTWF5YmUgdGhpcyBpcyB3cm9u
ZyBhYmJyZXZpYXRpb24sIGNoYW5nZSBmcm9tIEhXQ1BBUyB0byBIV0NBUFMuDQo+Pg0KPj4gSW5k
ZWVkLCBpdCBpcywgdXNlIGltcGVyYXRpdmUsIHNvbWV0aGluZyBsaWtlOiAiRml4IHdyb25nIGFi
YnJldmlhdGlvbiwNCj4+IHMvSFdDUEFTL0hXQ0FQUyINCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IEJlYW4gSHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+DQo+Pg0KPj4gWW91ciBTLW8tYiB0YWcgZG9l
c24ndCBtYXRjaCB0aGUgYXV0aG9yIG5hbWUsIHBsZWFzZSBmaXggdGhpcyBhcyB3ZWxsLg0KPiAN
Cj4gSXQgaXMgYXV0b21hdGljYWxseSBhZGRlZCBieSBnaXQsIHdoYXQgaXMgY29ycmVjdCB3YXk/
DQoNCllvdXIgYXV0aG9yIG5hbWUgIkJlYW4gSHVvIChiZWFuaHVvKSIgaXMgZGlmZmVyZW50IHRo
YW4geW91ciBTLW8tYiBuYW1lLCAiQmVhbg0KSHVvIi4gRGlkIHlvdSBhZGQgeW91ciBTLW8tYiB0
YWcgYnkgaGFuZD8gVGhlIGF1dGhvciBuYW1lIGlzIGF1dG9tYXRpY2FsbHkgYWRkZWQNCmJ5IGdp
dCwgaXQgbG9va3MgaW50byB5b3VyIH4vLmdpdGNvbmZpZyBmaWxlLCBhdCBbdXNlcl0gbmFtZS4g
Uy1vLWIgdGFnIGNhbiBhbHNvDQpiZSBhZGRlZCBieSBnaXQsIGp1c3QgdXNlIHRoZSAiLXMiIG9w
dGlvbiB3aGVuIGNvbW1pdHRpbmcgdGhlIGNoYW5nZTogImdpdA0KY29tbWl0IC1zIi4NCg0KQ2hl
ZXJzLA0KdGENCg==
