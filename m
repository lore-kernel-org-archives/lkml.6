Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDC7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66F420856
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uht/tVGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66F420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeGQPIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:08:13 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:52011
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729621AbeGQPIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xzokMrKji6U8739/44/LBi/UrNElMMr1EBOhbIbwmI=;
 b=Uht/tVGkafyF40rAFSLoKUllRhljaxR3Wi6J7BilRQZM3TU8iLTvaeabHvYAskKKzVfYNKSmc+7cOWGLYT9p0il30Lk7j2tXeUZaz94N+iSZsrZpiRWEQU3IOvgql852VDcdiST2ib9nzZbs7VZZWt9S9nI+2E8rjSWUh95ATFc=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5012.eurprd04.prod.outlook.com (20.177.40.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Tue, 17 Jul 2018 14:34:32 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::64a5:e067:9a23:97ce]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::64a5:e067:9a23:97ce%2]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 14:34:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "laurent.pinchart+renesas@ideasonboard.com" 
        <laurent.pinchart+renesas@ideasonboard.com>,
        "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "gnuiyl@gmail.com" <gnuiyl@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: Remove unused field imx_drm_device.pipes
Thread-Topic: [PATCH] drm/imx: Remove unused field imx_drm_device.pipes
Thread-Index: AQHUHcdVUs1dDE6oh0q9afwQXxr9y6STZooAgAAUc4A=
Date:   Tue, 17 Jul 2018 14:34:32 +0000
Message-ID: <dbce0f8d369c306b5bb8489afd0a9d25954a0f03.camel@nxp.com>
References: <69a927983d003e7ebfbd19cbc940c5e2a13b9473.1531828221.git.leonard.crestez@nxp.com>
         <1531833680.3468.8.camel@pengutronix.de>
In-Reply-To: <1531833680.3468.8.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5012;7:7lDNwthxjCVOPM+cYqSeryQq5mWPWx7C/kav7q8+ZbPxA1no9g+C2v1NK8t4vgdGZ4R+9n/igIfi+oKZEyGUFxl05MjzX3qJQPL2ROBrkgt3n/IYloUbrr7wzM+aoSA8TdCIjfipIsECnGRdSRdt6iEU1VNwRrbIN2+Jhq4re2bqJrIHnICokXhBV4IJT1MsrN9rUwQ90+0X3EU1ApdzY9crKqEXMrHUqeHcoayjcl8cJtrWF8ohnuOIjW86DLCd
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 292a5355-360e-4224-5274-08d5ebf269a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5012;
x-ms-traffictypediagnostic: AM0PR04MB5012:
x-microsoft-antispam-prvs: <AM0PR04MB50125C86C2DC6E6FF98AF9FEEE5C0@AM0PR04MB5012.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5012;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5012;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(118296001)(305945005)(50226002)(446003)(8676002)(68736007)(53936002)(2501003)(11346002)(97736004)(7416002)(99286004)(102836004)(26005)(186003)(5660300001)(76176011)(7736002)(5250100002)(8936002)(81156014)(81166006)(2616005)(66066001)(6506007)(476003)(229853002)(110136005)(6436002)(36756003)(256004)(14444005)(44832011)(54906003)(4326008)(6486002)(6512007)(6116002)(3846002)(106356001)(486006)(316002)(25786009)(14454004)(2906002)(86362001)(6246003)(2201001)(39060400002)(478600001)(2900100001)(105586002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5012;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +eu/+Y7yRxBxlnJdcbKxnbuoF9olGdwDuBSqhHCLPgm0C+XfXh1/cdX7OadWXNbFr6kqYjU3vMCjGC6L6g2fRrTyWLejpDzD4Ej2f3LzCV9NePKr3oaVsFH0UOHlKMfipj7K/vXHFVBGbw4nAUMPpW0OilcBCcnAbTx4t2qXOFcPYz7VjXcVAaMLxY0Fx4fAQJ7l36roFnk7ml1ypSMczMQa3N6NU3Tn4ViSgfnaTRpyc1W0qkzQWWuv2LefSS5EKwLw5Tr/zUlV7YXmdd/GuSTzoDZBPF7y+qb4y/7V4QeXomlUl25b3IONtbNDckOAprcNiyvDJTNGeyTN9BXvghQdT3awZOOXrgiYJ4akkmI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <455AACD179D24B46B09B74B29C6F98EF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292a5355-360e-4224-5274-08d5ebf269a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 14:34:32.8714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTE3IGF0IDE1OjIxICswMjAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBPbiBUdWUsIDIwMTgtMDctMTcgYXQgMTU6MTEgKzAzMDAsIExlb25hcmQgQ3Jlc3RleiB3cm90
ZToNCj4gPiBUaGlzIGhhcyBiZWVuIHVudXNlZCBzaW5jZSBjb21taXQgNDRiNDYwY2ZlNTU0ICgi
ZHJtOiBpbXg6IHJlbW92ZSBzdHJ1Y3QNCj4gPiBpbXhfZHJtX2NydGMgYW5kIGlteF9kcm1fY3J0
Y19oZWxwZXJfZnVuY3MiKQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQ3Jlc3Rl
eiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+DQo+IA0KPiBBcHBsaWVkIHRvIGlteC1kcm0vbmV4
dCwgdGhhbmsgeW91Lg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2lteC9pbXgt
ZHJtLWNvcmUuYyB8IDEgLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+
IA0KPiA+IExvb2tpbmcgYXQgdGhlIGlteF9kcm1fZGV2aWNlIHN0cnVjdCBpdCBpcyBvbmx5IHVz
ZWQgdG8gc2F2ZSB0aGUNCj4gPiBkcm1fYXRvbWljX2hlbHBlcl9zdXNwZW5kIHN0YXRlLiBJdCBz
ZWVtcyBsaWtlIHRoaXMgY291bGQgYmUgcmVwbGFjZWQNCj4gPiB3aXRoIGRybV9tb2RlX2NvbmZp
Z19oZWxwZXJfc3VzcGVuZC9yZXN1bWUgYW5kIHRoZSBlbnRpcmUgc3RydWN0DQo+ID4gcmVtb3Zl
ZC4NCj4gPiANCj4gPiBUaGUgb25seSBkaWZmZXJlbmNlIGJldHdlZW4gaW14X2RybV9zdXNwZW5k
L3Jlc3VtZSBhbmQNCj4gPiBkcm1fbW9kZV9jb25maWdfaGVscGVyX3N1c3BlbmQvcmVzdW1lIGlz
IHRoYXQgdGhlIGxhdHRlciBhbHNvIHN1c3BlbmRzDQo+ID4gdGhlIGZiX2hlbHBlci4gVGhpcyB3
b3VsZCBiZSBhbiBpbXByb3ZlbWVudCwgcmlnaHQ/DQo+IA0KPiBUaGlzIGxvb2tzIGFib3V0IHJp
Z2h0IHRvIG1lLiBXZSBjdXJyZW50bHkgZG9uJ3QgY2FsbCB0aGUNCj4gZmJkZXYgc3VzcGVuZC9y
ZXN1bWUgbm90aWZpZXJzIGF0IGFsbC4gVGhlIGNvcnJlY3QgY2FsbA0KPiB3b3VsZCBiZSBkcm1f
ZmJkZXZfY21hX3NldF9zdXNwZW5kX3VubG9ja2VkIGluc3RlYWQgb2YNCj4gZHJtX2ZiX2hlbHBl
cl9zZXRfc3VzcGVuZF91bmxvY2tlZCwgdGhvdWdoLg0KPiANCj4gU2luY2UgZHJtX2ZiX2NtYV9m
YmRldl9pbml0IHJlZ2lzdGVycyBpdHMgZmJfaGVscGVyIHdpdGggdGhlDQo+IGRybV9kZXZpY2Ug
dmlhIGRybV9mYl9oZWxwZXJfaW5pdCwgYm90aCAoY3VycmVudGx5KSBkbyBleGFjdGx5DQo+IHRo
ZSBzYW1lIHRoaW5nLg0KDQpJcyBkcm1fZmJkZXZfY21hX3NldF9zdXNwZW5kIGV4cGVjdGVkIHRv
IGV2ZXIgZG8gYW55dGhpbmcgZXh0cmEgb24gdG9wDQpvZiBkcm1fZmJfaGVscGVyX3NldF9zdXNw
ZW5kPyBTaW5jZSBpdCBvbmx5IGhhbmRsZXMgbWVtb3J5IG1hbmFnZW1lbnQNCm15IGFuc3dlciB3
b3VsZCBiZSAibm8iLg0KDQpHcmVwcGluZyBmb3IgZHJtX2ZiZGV2X2NtYV9zZXRfc3VzcGVuZCBJ
IG9ubHkgZmluZCB0d28gdXNlcnM6IHJjYXItZHUNCmFuZCBoZGxjZC4gVGhlIHN1c3BlbmQvcmVz
dW1lIGNvZGUgaW4gYm90aCBvZiB0aG9zZSBkcml2ZXJzIGxvb2tzDQplbnRpcmVseSBlcXVpdmFs
ZW50IHRvIGRybV9tb2RlX2NvbmZpZ19oZWxwZXJfc3VzcGVuZC9yZXN1bWUuDQoNClNvIG1heWJl
IGRybV9mYmRldl9jbWFfc2V0X3N1c3BlbmQgaXRzZWxmIHNob3VsZCBiZSBkcm9wcGVkIGluIGZh
dm9yIG9mDQpkcm1fbW9kZV9jb25maWdfaGVscGVyX3N1c3BlbmQgZXZlcnl3aGVyZS4=
