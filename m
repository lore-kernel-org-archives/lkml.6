Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CC4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0F220849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="P3kpqB0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0F220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeLKOtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:49:49 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:29139 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:49:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="24236732"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 07:49:47 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 07:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNKu8IAA+qKn5ERU3lyO8d+jgFQpq/KVmfE9jMqNrQ0=;
 b=P3kpqB0F1Ixkv1HsGHufNWnzIZ4Xso6I3HcwpC5QhVX5cCMrwFIZ7SY7mPF2qe/TEVT5cDq40mYS4bDThr27Ve4XRLFn233/aOmiIX11yelGgmhmhnRJ1k8IERE1a7oqokFrSRfH2PlHk+SSTTcGPs+iYx2woovn7+6gIT7MyVU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1363.namprd11.prod.outlook.com (10.173.33.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Tue, 11 Dec 2018 14:49:44 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 14:49:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Cyrille.Pitchen@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Index: AQHUkKvzXXGQaMBmgEiVjL0m4mUE46V5nZmAgAACiIA=
Date:   Tue, 11 Dec 2018 14:49:44 +0000
Message-ID: <6e2aa831-dc12-8431-d089-10f35cec4cd6@microchip.com>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181211154033.076506aa@bbrezillon>
In-Reply-To: <20181211154033.076506aa@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:803:50::36) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.19]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1363;6:mD7pnay1GdXrdJ09aQJEpFBRCEfkGzNdlLzX6t4cYzkN/Osc7BX6a/rAARmt6eKkpzR8BGq3jZ8h+W/Cm/g/Hk3OP7EUJ+v6Voe91w1vrEHz44G6+yd9W9R+WjzchiF82h2Cffps4JL5o+HFC9xZ7DSuDpYSARPTt107ncKOR6U4lqrOfnNUNqTfbI/OQF2BFQO+VFWaIo49tTXjHuRXoFbSHWSiS+X4WNbmx/nf1UvXtraAy89rAXPq8kwN8rgA6aXEOrUqWMB7C1hMG4vZfK6N30J5eYBH4LYBiM8E4p0qdF2AR5RqUYjkGjykEopA/gA26eVAq6z4epetD+rgjOGPyS/FyJ/CWH2E/4HJxV2A1Ht1f29MxqOBU83GVeM4rKvzU/e2X+1alxiCabYxIeFoFwrqZQRWK8Xh1gL17nIGtrS/4GnsgBNxmdzxg/MB7xLHS19wyQ6l4Ih6YECovw==;5:LcBqHL8lz2Fcznzk8LsZ2s92aa+1PkMBBAagOUC118971sTHRdNIMpDzUzsZKfEcnPJK3TqdXPh2zXf5Q0fiEAAPwcGkHz6grmf1k2c1Rg7H5Nx5EF0lL+e7lu9Ni6iJ5Xpl8nBJ4T4UkeiP1q5dPt6yWt9ziAJbn2NRt6sQfxc=;7:OL3QBwaSgBbChusIcFneOOFY7QO8dmBLp7LCG2CKdBYGqHn8rCNDNW47EBMqIBheJMHTpsJmgzsWhAHJReEMwWIKjBVmiCNFzrJE9wQFCLDvImk66++h1fsAfEFCcOaTOXL6pq/cUlaJ77M3paC6uw==
x-ms-office365-filtering-correlation-id: 86c0f57b-36c2-427c-7080-08d65f77e37a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1363;
x-ms-traffictypediagnostic: BN6PR11MB1363:
x-microsoft-antispam-prvs: <BN6PR11MB136376FA5B0DF859EE126FA3F0A60@BN6PR11MB1363.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1363;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1363;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(8676002)(6512007)(86362001)(36756003)(6486002)(53936002)(5660300001)(31696002)(14444005)(256004)(478600001)(316002)(72206003)(8936002)(6916009)(106356001)(4326008)(229853002)(25786009)(31686004)(2906002)(486006)(81156014)(2616005)(81166006)(476003)(97736004)(105586002)(446003)(76176011)(11346002)(14454004)(6246003)(186003)(52116002)(54906003)(66066001)(71190400001)(26005)(7416002)(386003)(102836004)(53546011)(71200400001)(6506007)(217873002)(7736002)(6116002)(6436002)(99286004)(305945005)(3846002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1363;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lZTt+nImGvAkaBkh4f8ns1A9PV5aDcaKfNRyH/dzUJvUBo2HOpyNu4brL32MOGT8If+DEI8xNmuf5rWrrzFs/plXrfRVqtKq/B3kU1FCjhNPEfBXhIZudhyD3VZuvFo817bhlhCjGVkSJTOPhlXuPzb6MJm87L3Q15XwQXqgCffqLfeHU+DeaIcWroP8ZgziKCecn0l8FfaSxwFfTl38tqujyfO65frB9iFguLHmoYUH0kXHAr3M1WhtnT4XEueUZ0NK/qgeH5uLB442OB88sSBL7o1355uvzTk2PgNbkJT4BRsUUaFzQOPeKRlKDvod
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AE205E46F5C584988A42C922C116D79@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c0f57b-36c2-427c-7080-08d65f77e37a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 14:49:44.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1363
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJvcmlzLA0KDQpPbiAxMi8xMS8yMDE4IDA0OjQwIFBNLCBCb3JpcyBCcmV6aWxsb24gd3Jv
dGU6DQo+IE9uIE1vbiwgMTAgRGVjIDIwMTggMTc6MTU6MjkgKzAwMDANCj4gPFR1ZG9yLkFtYmFy
dXNAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+IA0KPj4gRnJvbTogQ3lyaWxsZSBQaXRjaGVuIDxj
eXJpbGxlLnBpdGNoZW5AbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBUaGlzIHBhdGNoIGNvbmZpZ3Vy
ZXMgdGhlIFFTUEkwIGNvbnRyb2xsZXIgcGluIG11eGluZyBhbmQgZGVjbGFyZXMNCj4+IGEgamVk
ZWMsc3BpLW5vciBtZW1vcnkuDQo+Pg0KPj4gc2FtYTVkMiBYcGxhaW5lZCBSZXZCIGFuZCBSZXZD
IHVzZSB0aGUgTWFjcm9uaXggTVgyNUwyNTY3M0cgZmxhc2gNCj4+IG1lbW9yeSB3aGljaCBhZHZl
cnRpc2VzIGEgbWF4aW11bSBmcmVxdWVuY3kgb2YgODBNSHogZm9yIFF1YWQgSU8NCj4+IEZhc3Qg
UmVhZC4gU2V0IHRoZSBzcGktbWF4LWZyZXF1ZW5jeSB0byA4ME1IeiBrbm93aW5nIHRoYXQgYWN0
dWFsbHkNCj4+IHRoZSBRU1BJIGRydmVyIHdpbGwgc2V0IHRoZSBTUEkgYnVzIGNsb2NrIHRvIDE2
Nk1IeiAvIDMgPSA1NS4zTUh6Lg0KDQpzL2RydmVyL2RyaXZlcg0KDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogQ3lyaWxsZSBQaXRjaGVuIDxjeXJpbGxlLnBpdGNoZW5AbWljcm9jaGlwLmNvbT4NCj4+
IFt0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb206DQo+PiAtIGRyb3AgcGFydGl0aW9ucywNCj4+
IC0gYWRkIHNwaS1yeC90eC1idXMtd2lkdGgNCj4+IC0gY2hhbmdlIHNwaS1tYXgtZnJlcXVlbmN5
IHRvIG1hdGNoIHRoZSA4ME1IeiBsaW1pdCBhZHZlcnRpc2VkIGJ5DQo+PiAgIE1YMjVMMjU2NzNH
IGZvciBRdWFkIElPIEZhc3QgUmVhZCwNCj4+IC0gcmV3b3JkIGNvbW1pdCBtZXNzYWdlIGFuZCBz
dWJqZWN0Ll0NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNA
bWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVk
Ml94cGxhaW5lZC5kdHMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMgYi9hcmNoL2FybS9ib290L2R0
cy9hdDkxLXNhbWE1ZDJfeHBsYWluZWQuZHRzDQo+PiBpbmRleCA1MThlMmIwOTVjY2YuLjE3MWJj
ODJjZmJiZiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94
cGxhaW5lZC5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxh
aW5lZC5kdHMNCj4+IEBAIC0xMDgsNiArMTA4LDIxIEBADQo+PiAgCQl9Ow0KPj4gIA0KPj4gIAkJ
YXBiIHsNCj4+ICsJCQlxc3BpMDogc3BpQGYwMDIwMDAwIHsNCj4+ICsJCQkJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCj4+ICsJCQkJcGluY3RybC0wID0gPCZwaW5jdHJsX3FzcGkwX2RlZmF1
bHQ+Ow0KPj4gKwkJCQkvKiBzdGF0dXMgPSAib2theSI7ICovIC8qIGNvbmZsaWN0IHdpdGggc2Rt
bWMxICovDQo+PiArDQo+PiArCQkJCWZsYXNoQDAgew0KPj4gKwkJCQkJY29tcGF0aWJsZSA9ICJq
ZWRlYyxzcGktbm9yIjsNCj4+ICsJCQkJCXJlZyA9IDwwPjsNCj4+ICsJCQkJCXNwaS1tYXgtZnJl
cXVlbmN5ID0gPDgwMDAwMDAwPjsNCj4+ICsJCQkJCXNwaS10eC1idXMtd2lkdGggPSA8ND47DQo+
PiArCQkJCQlzcGktcngtYnVzLXdpZHRoID0gPDQ+Ow0KPj4gKwkJCQkJbTI1cCxmYXN0LXJlYWQ7
DQo+PiArCQkJCX07DQo+IA0KPiBJJ20gYSBiaXQgbG9zdC4gV2hhdCdzIHRoZSBwb2ludCBvZiBk
ZWZpbmluZyB0aGlzIGlmIHRoZSBRU1BJDQo+IGNvbnRyb2xsZXIgaXMgbm90IGVuYWJsZWQ/DQoN
CllvdSBjYW4gZW5hYmxlIHFzcGkgaWYgeW91IGRpc2FibGUgc2RtbWMxLiBJIHRob3VnaHQgb2Yg
aGF2aW5nIGFsbCBkZXNjcmliZWQNCnRvZ2V0aGVyIGFuZCBjaG9vc2Ugb25lIG9yIGFub3RoZXIg
ZGVwZW5kaW5nIG9uIG5lZWRzLg0KDQp0YQ0K
