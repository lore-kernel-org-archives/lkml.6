Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1524C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7385120870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MaKHUSxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfBAOtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:49:33 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:43754 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfBAOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:49:33 -0500
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="23304111"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 07:49:31 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 07:49:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGyvDOjuUGYx8sP6qUZPFxnHD/04D/tDI5VRzkafaRo=;
 b=MaKHUSxJ8nEYrOr2Gs0YevQzKclUdSGWAJZ2vEkDuyGUzdfNqMnL1PhvKzPJOeEjfFJ9p5fwyoPywHsJoQYaYDk4/G3e126XXvSYNaxSxt6D6b02qNekIYnIAwrVRvVlI8lmgUY0HGUo3LDkX9hYIVXBXC4ChgYSbxyx5Ji/zrw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1635.namprd11.prod.outlook.com (10.172.22.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Fri, 1 Feb 2019 14:49:28 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Fri, 1 Feb 2019
 14:49:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUuYA85AgiqORGIUCz49OB4RqXzKXJkgKAgAD0mICAAA3/gIAAcwQA
Date:   Fri, 1 Feb 2019 14:49:27 +0000
Message-ID: <8b935a95-0aaa-3430-e2c2-f5793fd9cf11@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
 <20190131161515.21605-11-tudor.ambarus@microchip.com>
 <20190131173207.56481a42@bbrezillon>
 <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
 <20190201085739.775add3f@bbrezillon>
In-Reply-To: <20190201085739.775add3f@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0124.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::26) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1635;6:D5JYhjSQvNWgExdAiocQtBCKDe0oL+zliZIaXGteza9KMmzZwADgJd96yhQv2qS8K+22TRp9d9ynTagFbHpiMF0fp8xNcSLQuK7BA9wjfC+u1C27n2aY4+ig7CZ2QNIj8J0iF51pAN9DkGU+zZ/WJeko1lTxtvVu/GJLk+nE/K5I+BDdIIqc8K/f50F5sqqPLJNB7e3Cn85DJcp4sDJs+Uet5oGNihzw4cDaY5bn6+KuVRHuXvAerj7legftl+SUniwhWgGkAQG09ieqTGAmB0pkS+AefyxlxGvwEjR/jr4IqYokDv3Ex1nvdmsj/6Y9b+fQHZ31cf+AtbWD8d2E3oG6h+aveTLRmznnBHKE/MzTAoUz8omtEL6mj0RRPgiCGeySAljqgzIZ9mbdlpC6Wa6C9O6Jt/tg4oeDH8csyDzOV2KzUKTE5ZdmdwW5catT1CTEUDUu4FoAUqAxxog61g==;5:Lnj8K1eGdLBUDtoPpg1S/wRAzrmJ8UHLeTYzwmbPBAhCwqvWuY2qOR3pvz1yDgDpI5jp9VQtYan1eDoe3buZHod9rhX5YhdhRkr0ksGvn4QiMEvNaO1xNIKwT1vyT/yKEl3hWnl28nGRBKCCJ4z6VclRUS5u35OUe6mPg5ysVc/lWJBxJPDt3WSnFKxfyhLW9vtxqulciE8ZBnau+9gbOQ==;7:h+UgHB7Q9VgBr6vHt7ZcT0Q0GlfYxWxBhR47RfTw1EaIyNkf0XJTspFYYaemNh1jYhenEAJZkVZ7Ssj1N+PG3hVVk4vKjJygJVfo0z7ferjP/sR3065AjhGdWkMHSryLOk1SwzkeBdu23nNsHwVhrA==
x-ms-office365-filtering-correlation-id: 390e6d20-d65a-4e55-fce2-08d6885476f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1635;
x-ms-traffictypediagnostic: BN6PR11MB1635:
x-microsoft-antispam-prvs: <BN6PR11MB16357957C2F366FD4A2D2D60F0920@BN6PR11MB1635.namprd11.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(446003)(31696002)(186003)(2616005)(476003)(99286004)(486006)(68736007)(229853002)(26005)(2906002)(7736002)(11346002)(66066001)(3846002)(6116002)(305945005)(106356001)(93886005)(8936002)(81156014)(81166006)(14454004)(86362001)(4744005)(8676002)(6436002)(4326008)(31686004)(6916009)(6246003)(71200400001)(54906003)(76176011)(25786009)(102836004)(478600001)(71190400001)(105586002)(52116002)(6486002)(72206003)(53936002)(97736004)(7416002)(6506007)(386003)(53546011)(36756003)(6512007)(316002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1635;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /l+12Kpr8u7N1YUudJBufhpoJk9jwM6Pj/mt/B0JA6Lh+qYUCj/lWhFqFYP9Qka/87rpWZt2ZsSBW7yRSBzqk0A3wOSzFnfOmrkTkTBsMNmEWBxPafMSbnBoYwSA9omTHDRtyfxgRp22EBQg03Sc3I9E9oslDSxlhM03KMcyEoCSLWfDrahS4Ps4lRT/iqFaXSuEKTaqn9hFyqFoVDn0F6+8cBAyRAG6py/C+NNCYYtedn+wtZE/71VlXxmTpwhh+GMYNniYmQ6xtNDGpDJvY0gNqCjW69PQSxgNv8/7jpBFIa8gtW3FMcf0P5OG1+gdhJJNb21EdmXg8dkYNlEQvOzWNRXUj0ZkaGYRx7n99rmPY7yO1LYOMSZsidlMfYbmun4TYgruwZx8q+FMnVOcfek/koaDyPTwNG2muFWldMc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDEBE13018FC9646BCC995CB63ADBC6C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 390e6d20-d65a-4e55-fce2-08d6885476f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 14:49:23.8670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1635
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzAxLzIwMTkgMDk6NTcgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
RnJpLCAxIEZlYiAyMDE5IDA3OjA3OjQwICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiANCj4+PiAgIA0KPj4+PiAgI2RlZmluZSBRU1BJX0lGUl9URlJUWVBf
TUFTSyAgICAgICAgICAgIEdFTk1BU0soMTMsIDEyKQ0KPj4+PiAgI2RlZmluZSBRU1BJX0lGUl9U
RlJUWVBfVFJTRlJfUkVBRCAgICAgICgwIDw8IDEyKQ0KPj4+PiAgI2RlZmluZSBRU1BJX0lGUl9U
RlJUWVBfVFJTRlJfUkVBRF9NRU0gICgxIDw8IDEyKSAgDQo+Pj4NCj4+PiBMb29rcyBsaWtlIHRo
ZSByZWFkL3dyaXRlIGZsYWcgaXMgb24gYml0IDEzLiBDYW4gd2UganVzdCBhZGQgIA0KPj4NCj4+
IGZvciBzYW1hNWQyIG9ubHkNCj4gDQo+IEZlZWwgZnJlZSB0byBwcmVmaXggbWFjcm9zIHdpdGgg
dGhlIFNvQyBuYW1lIHRvIG1ha2UgaXQgY2xlYXI6DQo+IA0KPiAjZGVmaW5lIFFTUElfSUZSX1NB
TUE1RDJfV1JJVEVfVFJTRlIJCUJJVCgxMykNCg0KYWdyZWVkDQoNCj4gDQoNCmN1dA0KDQo+Pj4+
ICsjZGVmaW5lIFFTUElfSUZSX0FQQlRGUlRZUF9SRUFECQlCSVQoMjQpDQo+IA0KPiBBbmQgdGhp
cyBvbmUgd291bGQgYmUNCj4gDQo+IGRlZmluZSBRU1BJX0lGUl9TQU05WDYwX1JFQURfVFJTRlIJ
CUJJVCgyNCkNCg0KSSBwcmVmZXIgbGV0dGluZyB0aGlzIGJpdCBuYW1lZCBhcyBpbiB0aGUgZGF0
YXNoZWV0LCBRU1BJX0lGUl9BUEJURlJUWVBfUkVBRCwNCmFuZCBjaGFuZ2UgaXQgaWYgZnV0dXJl
IHZlcnNpb25zIG9mIHRoZSBJUCB3aWxsIG1vZGlmeSBpdHMgc2Vuc2UuIEl0IGlzIGEgUkVBRA0K
dHJhbnNmZXIgZG9uZSBvbiBBUEIsIGl0IGlzIG1vcmUgZ2VuZXJpYyB0aGlzIHdheS4gSWYgeW91
IGhhdmUgYSBzdHJvbmcgb3Bpbmlvbg0Kb24gdGhpcywgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQp0
YQ0K
