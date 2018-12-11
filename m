Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C28C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1772084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qoEqno7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1772084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeLKMcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:32:45 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:50937 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKMcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:32:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="24232166"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 05:32:44 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 05:32:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBCzqyuLKy6zjnGaXCt2XCD/j7AEagAQhXorNxnF+l8=;
 b=qoEqno7pREOQXDf57IdoFLHhj3YHWkUgDOjNl7CvdOgitOilWawkA1Ma0I67vPsTJiIt4VRu6h53KJbLvV/Fu+aFYDvfzWVyTJ3ATyp8XHxAnJVQHhA3ov6Kn2A72pPZww2wSaYiDwlZS+hdxOjqk+my2xEYQpljvWWe7h7gM6k=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1970.namprd11.prod.outlook.com (10.175.100.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 12:32:41 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 12:32:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Cyrille.Pitchen@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Index: AQHUkKvzXXGQaMBmgEiVjL0m4mUE46V4f0+AgAD6hoA=
Date:   Tue, 11 Dec 2018 12:32:40 +0000
Message-ID: <22730de3-55f0-df21-312a-560a02f02dc7@microchip.com>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181210213553.GK8952@piout.net>
In-Reply-To: <20181210213553.GK8952@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0099.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::25) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.19]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1970;6:2s+iQ3KBRgTi2QnSueCY5xDmGFI8mSm7tQLq0QY4gwMSAgYMp9DOZptJrGPZXRRY0XnB+KSHdqaOKRXA9CcFFTe+f60UoGw5XPyQFGbA1757/Jk7bH4SCSIHmfAeHZHKBWGkt/xFReQOvH8wsrLvq8phj62cjic9qWuHRMl32jx9oE9yZsKKdkOsD1Mr+5NDAkS/i/cTarEkUMEegJkbvJSEZUzXp1EkO72qO3wstix36gC7BARwzSiCI8dEmR7RmoM4DnEjCz/QwQDxwnFPb39riVbyHmb4ml6Vyu2Fu1UZHw9tQW9+k80XT1FcZc7IzCgufV6CfAErLW2LXseTImD6XKSW2rNP8/gUENW01NBj2q6NfxTjz02PHERZ3aULlPSvlA698ex9MX7eWoxceq+3bRAn5JJpR9bXpFfQmzrtfhzUECW7QSzx5PqVci33lZeeZYABkqWde2+XDqlznQ==;5:vv48AWDGtEVt1ZedShQajiZpPRsmcFSMOGqYpo0sxIGSCDW84rcFhrh6jtBHePWfsGAMRvTPYUk2ZL0BfO3t7rs+/obEHWgCqpY1SuUwGFVcPzqZ8WMAtJjYVrawWs1oBuEtMdMipHuv6sKRx4KyzZmetB2dl/wgQ08/LVxU4BI=;7:rmKxgbWMyniBFBkTQIX8lvD5bndYL+gnIqCMmZ8FvsQJ9VEUkNkiU9MepnHznOeGrFuFQOVioMMIm56O9T2sSzwb8yJQzamXDQz+3SGDmgimG1EtK8OrzIYDKtRKAP545o+TrOSVrXcqMkqrECKYSA==
x-ms-office365-filtering-correlation-id: deb2d04d-ae0a-424a-3706-08d65f64bdce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1970;
x-ms-traffictypediagnostic: BN6PR11MB1970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-microsoft-antispam-prvs: <BN6PR11MB1970ADB4E694A05071DDEB43F0A60@BN6PR11MB1970.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1970;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1970;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(31686004)(229853002)(106356001)(7416002)(386003)(6506007)(71190400001)(72206003)(71200400001)(99286004)(68736007)(3846002)(8936002)(6116002)(6246003)(446003)(52116002)(97736004)(6486002)(25786009)(11346002)(6916009)(478600001)(2616005)(186003)(53546011)(6436002)(256004)(14444005)(102836004)(486006)(476003)(76176011)(217873002)(86362001)(5660300001)(26005)(66066001)(81156014)(36756003)(8676002)(6512007)(2906002)(54906003)(81166006)(14454004)(7736002)(4326008)(305945005)(105586002)(53936002)(316002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1970;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: leNb24rlb82FmNPlgFEALcCPYaId0V+J8Pj/pSEq4GSivEKUt7dmxZH+Ok1NAwtrL6Ymt8sa8pfnzXFilF7HrKm17Ea/DhIKYZTIoq7cVy4yT9DuHGl+ZvvPdJuePC6SeDYqjB10+lKJe2zLbNCtdkHzIXIXzUpEbMrbhJg3QPIPQPJ/I/UfOKhSOxENAkUXv+9rTRNW3LRz4dYeNlimNIE7tWBgYJ252ZSxiP3gto0x8JABNO/1tUqBDMiRfnvt9nn27VfG21qU+Z6e03+xkQ6X6J6kW2FpkVduQ/Da3QHPls1eho37gbVXrZe1egG/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDD38498AEBB3547A3FAB81144C33D0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: deb2d04d-ae0a-424a-3706-08d65f64bdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 12:32:40.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1970
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsZXhhbmRyZSwNCg0KT24gMTIvMTAvMjAxOCAxMTozNSBQTSwgQWxleGFuZHJlIEJlbGxv
bmkgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24gMTAvMTIvMjAxOCAxNzoxNToyOSswMDAwLCBUdWRv
ci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBDeXJpbGxlIFBpdGNoZW4g
PGN5cmlsbGUucGl0Y2hlbkBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFRoaXMgcGF0Y2ggY29uZmln
dXJlcyB0aGUgUVNQSTAgY29udHJvbGxlciBwaW4gbXV4aW5nIGFuZCBkZWNsYXJlcw0KPj4gYSBq
ZWRlYyxzcGktbm9yIG1lbW9yeS4NCj4+DQo+PiBzYW1hNWQyIFhwbGFpbmVkIFJldkIgYW5kIFJl
dkMgdXNlIHRoZSBNYWNyb25peCBNWDI1TDI1NjczRyBmbGFzaA0KPj4gbWVtb3J5IHdoaWNoIGFk
dmVydGlzZXMgYSBtYXhpbXVtIGZyZXF1ZW5jeSBvZiA4ME1IeiBmb3IgUXVhZCBJTw0KPj4gRmFz
dCBSZWFkLiBTZXQgdGhlIHNwaS1tYXgtZnJlcXVlbmN5IHRvIDgwTUh6IGtub3dpbmcgdGhhdCBh
Y3R1YWxseQ0KPj4gdGhlIFFTUEkgZHJ2ZXIgd2lsbCBzZXQgdGhlIFNQSSBidXMgY2xvY2sgdG8g
MTY2TUh6IC8gMyA9IDU1LjNNSHouDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ3lyaWxsZSBQaXRj
aGVuIDxjeXJpbGxlLnBpdGNoZW5AbWljcm9jaGlwLmNvbT4NCj4+IFt0dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb206DQo+PiAtIGRyb3AgcGFydGl0aW9ucywNCj4+IC0gYWRkIHNwaS1yeC90eC1i
dXMtd2lkdGgNCj4+IC0gY2hhbmdlIHNwaS1tYXgtZnJlcXVlbmN5IHRvIG1hdGNoIHRoZSA4ME1I
eiBsaW1pdCBhZHZlcnRpc2VkIGJ5DQo+PiAgIE1YMjVMMjU2NzNHIGZvciBRdWFkIElPIEZhc3Qg
UmVhZCwNCj4+IC0gcmV3b3JkIGNvbW1pdCBtZXNzYWdlIGFuZCBzdWJqZWN0Ll0NCj4+IFNpZ25l
ZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+
IC0tLQ0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMgfCAz
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEt
c2FtYTVkMl94cGxhaW5lZC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfeHBs
YWluZWQuZHRzDQo+PiBpbmRleCA1MThlMmIwOTVjY2YuLjE3MWJjODJjZmJiZiAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMNCj4+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMNCj4+IEBAIC0x
MDgsNiArMTA4LDIxIEBADQo+PiAgCQl9Ow0KPj4gIA0KPj4gIAkJYXBiIHsNCj4+ICsJCQlxc3Bp
MDogc3BpQGYwMDIwMDAwIHsNCj4+ICsJCQkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+
ICsJCQkJcGluY3RybC0wID0gPCZwaW5jdHJsX3FzcGkwX2RlZmF1bHQ+Ow0KPj4gKwkJCQkvKiBz
dGF0dXMgPSAib2theSI7ICovIC8qIGNvbmZsaWN0IHdpdGggc2RtbWMxICovDQo+IA0KPiBJc24n
dCB0aGF0IGNvbmZsaWN0aW5nIHRoZW4gYmVjYXVzZSBJIHRoaW5rIHRoZSBkZWZhdWx0IGlzIG9r
YXkuDQpxc3BpMCBpcyBkaXNhYmxlZCBpbiBzYW1hNWQyLmR0c2kuDQoNClRoYW5rcywNCnRhDQo=
