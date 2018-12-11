Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67901C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E020811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QfcxJLQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5E020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLKIJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:09:47 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:44856 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLKIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:09:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; 
   d="scan'208";a="22122525"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 01:09:45 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 01:09:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsmfQNacvQYmkniq2LeCDXAcufxkQR2u4W+t509ZixY=;
 b=QfcxJLQBC4/7432xGslMtmqh383WwhvNSkI5EaYNC8h87QrEvNxhrhVCa00MJgH0gsEIfQzw0qR7WERJhGeZfqbHRa7dhA+qZoiVW/fY3IOaoo2r1hpFxCv1Br7kvZHFosJ1v4Q4c0pCIyOqOZyYEjLQNnlCujyZ3VhmKKPQ0mI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1859.namprd11.prod.outlook.com (10.175.100.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 08:09:40 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 08:09:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <broonie@kernel.org>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh@kernel.org>, <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <computersforpeace@gmail.com>, <frieder.schrempf@exceet.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUiuPgL6l2VShjyka5vhSTd0gdZqV31OaAgAEwzICAADY3AA==
Date:   Tue, 11 Dec 2018 08:09:40 +0000
Message-ID: <141c6d79-ae7a-60aa-865a-f6b6997f8da9@microchip.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
 <VI1PR04MB57264CBB25E2984DF221ED2E99A60@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB57264CBB25E2984DF221ED2E99A60@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0045.eurprd05.prod.outlook.com
 (2603:10a6:800:60::31) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.19]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1859;6:YK8GV2jHhjw9WEV0K4ShO6AKIKTB6wzb+/HdWn0QgBEHuIrMux42XSgqQxezxMcSbgBfYKXK+LnZ899ac7AzNm+Jcf242Q2p3eu26b0Z6afLJh41wam9cJYeuIY/2wUANK1RCBCKUZlunlSxjp0gnI+h3R5xwm5KhC0SztMdqK15SSLp9fhwCIeOpxqx5mb3dl0QWMx8csgqiUPyHq/woTBnZ2336uwEl3LG7eoQhNiIT4/Qlwy6rOiG2k2fdHVBvFRmBJJuEo8V0+redQxLXXReF+fLfjby8JGhuHVgtlNUzQXS1gFtzRhDw8iHGlk9CCM+/cH9CHyGKfjGRAud5lKUOsi2sBZE2OAm5Lm+Uva8yPW+WJmGZiNDZgSdyfMQEsdWfgl82zcv0Cm9bxevkKRaxblg85muqZqzYjIb6uGRn9SVHZgMQFt7WllHfGmLCuyveDNlhDkwMZvVJk5/0g==;5:/exLXHmGMt/5EqjkJGGYk1I74lLBjUymUABsj3DJ8ha5BiBG8Cy6TbJkp2jplh+5qoCKQXPYWWjRLIGv04HxzSu93sr7471YvWn1i6o+cWxOgQVDaIF4CZJcE26ZMNmNsLw5It07QQKtWPogl6rJrqOt8baIhwDgvjcw8BlLObc=;7:6IHarEE/+9gdcQ5Q3Mvz76h/+bOc/c/CRkrvUQnVjvuc9nMo77Ewp5/DEhtk0RaYfJFn6lH0SowRsAslEnzICSxWFHH1fXgUsusg4UnrVMMIy0VYdIsdrurljTcKKr+lcUX/uQJAeMf5EqGdqsOoRw==
x-ms-office365-filtering-correlation-id: 0785727c-2484-40ed-e379-08d65f3ffff8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1859;
x-ms-traffictypediagnostic: BN6PR11MB1859:
x-microsoft-antispam-prvs: <BN6PR11MB18592EACEBE2D1EAEF51BD59F0A60@BN6PR11MB1859.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1859;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1859;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(36756003)(14454004)(110136005)(54906003)(5660300001)(6506007)(256004)(71200400001)(31686004)(6486002)(106356001)(105586002)(66066001)(53546011)(102836004)(68736007)(71190400001)(386003)(478600001)(6116002)(3846002)(72206003)(2906002)(31696002)(81156014)(52116002)(8936002)(8676002)(486006)(25786009)(26005)(81166006)(316002)(93886005)(99286004)(2616005)(11346002)(476003)(86362001)(229853002)(305945005)(6512007)(2201001)(7736002)(97736004)(4326008)(76176011)(186003)(2501003)(6246003)(7416002)(446003)(39060400002)(6436002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1859;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GZVgMHzvjURbnekVx4jOJUTtH2eN62PG6Qu/l8vGG2744mJsShUmb+y5NwSDGxF0nCCt8TWWuSOSrGeYz8hahEMJf7nGwtUrLsrcJPzq9GHZuz4vE28Yve3Wk7yrgSYLJJ0/jlh1C8xtlPiM1AtzpKlbXOybizoxmCdL7VIhZsmc2IkLkMOw1uwFlfvDPNOkZvxzw7xoCxgsduuGSOAeGQ966e6lM15fvzhPFdKUqS1tdMU23ZTBHO3r+roCh4aMJz9FwXZEsbsVPUDNy+Ck/IS62ulV1HXxb43yHTUR4pHQGMd1AoT2Mt6U9bvudxFN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1348CB47DA43624A9189A93FFB3DF89A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0785727c-2484-40ed-e379-08d65f3ffff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 08:09:40.4956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1859
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDEyLzExLzIwMTggMDY6NTUgQU0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6
DQo+IFRodXMgd291bGQgZ29pbmcgdG8gbW9kaWZ5IHRoZSBjb25kaXRpb24gY2hlY2sgYXMgYmVs
b3csIHNvIHRoYXQgU0ZEUCBwYXJzaW5nIHdvdWxkIGFsc28gYmUgcGVyZm9ybWVkIHdoZW4gU1BJ
X05PUl9PQ1RBTF9SRUFEIGlzIHNldC4gQ29ycmVjdD8NCj4gDQo+ICAgICAgICAgaWYgKChpbmZv
LT5mbGFncyAmIChTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4gICAg
ICAgICAgICAgIFNQSV9OT1JfT0NUQUxfUkVBRCkpICYmICEoaW5mby0+ZmxhZ3MgJiBTUElfTk9S
X1NLSVBfU0ZEUCkpIHsNCg0KWWVzLCB0aGlzIGlzIHdoYXQgSSB3YXMgc3VnZ2VzdGluZy4gT24g
YSBzZWNvbmQgdGhvdWdodCwgd2UgaGF2ZW4ndCBhZGRlZCB5ZXQNCnN1cHBvcnQgZm9yIHBhcnNp
bmcgc2ZkcCB0byBnZXQgdGhlIG9jdGFsIG1vZGUgaW5mbywgc28gdGhlIHBhcnNpbmcgd2lsbCBi
ZSBkb25lDQpncmF0dWl0b3VzbHkuIExldCdzIGRyb3AgdGhpcyBjaGFuZ2UgYW5kIGFkZCBpdCB3
aGVuIGFkZGluZyBzdXBwb3J0IGZvciBwYXJzaW5nDQpvY3RhbCBtb2RlIGluZm8gZnJvbSBzZmRw
LiBJJ2xsIHByZXBhcmUgYSBwYXRjaCBmb3IgdGhpcy4NCg0KUGxlYXNlIHJlYmFzZSBvbiB0b3Ag
b2Ygc3BpLW5vci9uZXh0LCBzL29jdG8vb2N0YWwgaW4gc3BpLW5vci5oIGFuZCBjb3JyZWN0IHlv
dXINClMtby1iIHRhZyBhbmQgeW91J2xsIGhhdmUgbXkgUi1iIHRhZy4NCg0KVGhhbmtzIFlvZ2Vz
aCwNCnRhDQo=
