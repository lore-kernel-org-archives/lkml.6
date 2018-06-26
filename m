Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08055C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9E326D17
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y17XrEM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9E326D17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeFZPVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:21:51 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:63736
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750936AbeFZPVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnERIEndtg/thWiRDxZ/iLirDMAaX/Zzi/vMmufUkD0=;
 b=Y17XrEM9WZI+/aoSVNTZvTqcGmRXXsTP85Cdcs0C+jIhIRBsPV34P3y5UTaigUFKx7dvboKBXdVF4Cdj38h4wtsue/Mc74TJfvtwggMgICAhKMzGCRcy5rnJTr1LmOMs4QagD2FL/JHKXJN+rB0G9podLxIxLOPp9U6DN342njA=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3751.eurprd04.prod.outlook.com (52.133.29.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Tue, 26 Jun 2018 15:21:47 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::8436:c34b:11c1:7713]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::8436:c34b:11c1:7713%3]) with mapi id 15.20.0884.024; Tue, 26 Jun 2018
 15:21:47 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCH] irqchip/ls-scfg-msi: update effective affinity mask
Thread-Topic: [PATCH] irqchip/ls-scfg-msi: update effective affinity mask
Thread-Index: AQHUDVswhkZIRupCE0e4CjtWroSc3qRyoQIAgAAHEQA=
Date:   Tue, 26 Jun 2018 15:21:47 +0000
Message-ID: <8e4b85b7-f75f-aa9c-1baa-837f66906cee@nxp.com>
References: <20180626143712.30489-1-laurentiu.tudor@nxp.com>
 <86efgt7g0z.wl-marc.zyngier@arm.com>
In-Reply-To: <86efgt7g0z.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3751;7:bhgoaRIixQDBxb95+3N+pD8gDjLZNgcF2ROs31i7veVIpUF3muzuPSOs8/fPw4Ok8K7KylL/BH0KZEatHD5yYniafqi+Lxv9cBvrxSVm21+Fn7g1+zmt7SPKl0Aly5E5OUu6zc0Zgrxf3OCTTi9nDHSv9+i3tky3ZbHlV6ceJKJOWevSxRsjLdGGZiQRDR/p4ZHE33noR9cxiBc3y4ONlLTWrmyXNUIQ92XCTK82VGf8NBvJdMNw+MZ1N+0DbYGQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 877d2cd8-d50e-40e3-3c35-08d5db78888c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3751;
x-ms-traffictypediagnostic: AM6PR0402MB3751:
x-microsoft-antispam-prvs: <AM6PR0402MB37518D0B38767B9BD1274CF4EC490@AM6PR0402MB3751.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR0402MB3751;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3751;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(366004)(396003)(43544003)(199004)(189003)(51914003)(2616005)(76176011)(6512007)(476003)(2900100001)(5250100002)(486006)(11346002)(2906002)(68736007)(97736004)(186003)(14444005)(86362001)(44832011)(53936002)(6246003)(102836004)(99286004)(478600001)(53546011)(6506007)(31696002)(26005)(36756003)(256004)(4326008)(54906003)(6436002)(316002)(6486002)(305945005)(229853002)(105586002)(106356001)(6116002)(8676002)(15650500001)(7736002)(6916009)(14454004)(5660300001)(3846002)(446003)(66066001)(31686004)(8936002)(25786009)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3751;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4GubYJiawAruRHd4VecMwlbn5vAvq4AAEgRJwSBJwAw7ebc8/fLlr/jXcoNE7xsdhF8L2QaIazzomP+aLo8XlV4XsZT9ANBQk+vdcQtDcfRZnNpkOjBKsXPZC1xog8Hs3qBQCXIVs/jGqBy7FPN7JlQnjc1uv/n/kAJfwqlrDaJxYduN3EnrnCiYo9bNYTZmWHA5MBDo0vqn1BC7dq9O1bIB5P6OWNeW8WcW0SdVApQMoQtDtzsKqKR83m0xAlQdEBIF37dZwDA3UdRT0jKVZyrvIUnU3Y0x3n/NG4GU0Ajob/ngPRxck7w3N81Ap+f8TXpyyid23wdniW/7QIeDFRJ0ISbc6AHdUIGeVSvt35Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC6DAF8D1043FD4EBFE5E6800EA5682D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877d2cd8-d50e-40e3-3c35-08d5db78888c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 15:21:47.5372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KT24gMjYuMDYuMjAxOCAxNzo1NiwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBP
biBUdWUsIDI2IEp1biAyMDE4IDE1OjM3OjEyICswMTAwLA0KPiBMYXVyZW50aXUgVHVkb3IgPGxh
dXJlbnRpdS50dWRvckBueHAuY29tPiB3cm90ZToNCj4+DQo+PiBVcGRhdGUgdGhlIGVmZmVjdGl2
ZSBhZmZpbml0eSBtYXNrIHRvIGZpeCB0aGlzIHdhcm5pbmcgaXNzdWVkIGJ5IHRoZQ0KPj4gZ2Vu
ZXJpYyBpcnEgaGFuZGxpbmcgY29kZToNCj4+DQo+PiAiZ2VuaXJxOiBpcnFfY2hpcCBNU0kgZGlk
IG5vdCB1cGRhdGUgZWZmLiBhZmZpbml0eSBtYXNrIG9mIGlycSB4Ig0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+PiAtLS0N
Cj4+ICAgZHJpdmVycy9pcnFjaGlwL2lycS1scy1zY2ZnLW1zaS5jIHwgMSArDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ly
cWNoaXAvaXJxLWxzLXNjZmctbXNpLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWxzLXNjZmctbXNp
LmMNCj4+IGluZGV4IDFlYzNiZmU1NjY5My4uZDgxZDViMDE2NDM4IDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9pcnFjaGlwL2lycS1scy1zY2ZnLW1zaS5jDQo+PiArKysgYi9kcml2ZXJzL2lycWNo
aXAvaXJxLWxzLXNjZmctbXNpLmMNCj4+IEBAIC0xMjIsNiArMTIyLDcgQEAgc3RhdGljIGludCBs
c19zY2ZnX21zaV9zZXRfYWZmaW5pdHkoc3RydWN0IGlycV9kYXRhICppcnFfZGF0YSwNCj4+ICAg
CX0NCj4+ICAgDQo+PiAgIAljcHVtYXNrX2NvcHkoaXJxX2RhdGEtPmNvbW1vbi0+YWZmaW5pdHks
IG1hc2spOw0KPj4gKwlpcnFfZGF0YV91cGRhdGVfZWZmZWN0aXZlX2FmZmluaXR5KGlycV9kYXRh
LCBtYXNrKTsNCj4+ICAgDQo+PiAgIAlyZXR1cm4gSVJRX1NFVF9NQVNLX09LOw0KPj4gICB9DQo+
IA0KPiBJdCBoYXMgYWxyZWFkeSBiZWVuIGFkZHJlc3NlZCBoZXJlOg0KPiANCg0KVGhhbmtzIGZv
ciB0aGUgb2J2aW91c2x5IG11Y2ggYmV0dGVyICYgY29tcGxldGUgZml4Lg0KV2lsbCB0YWtlIGNh
cmUgdG8ga2VlcCBteSBsb2NhbCByZXBvIG1vcmUgdXAtdG8tZGF0ZS4NCg0KLS0tDQpCZXN0IFJl
Z2FyZHMsIExhdXJlbnRpdQ==
