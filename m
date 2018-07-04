Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72467C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6772454F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lmH7jv0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6772454F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933837AbeGDHyy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:54:54 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:28896
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932319AbeGDHyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NO1QIAj6BG3l2GVBxXcLoQ9ezmcXuaVA6BB9Y1nG74=;
 b=lmH7jv0YBmxqxqYujtqBIo6GwDmAYWX9f657/ScUx0cxOK4+lNikIjgeOwZZ6By5Iun7ZE+81x3UfoChK8Z7ZTh9IM7299IWoEUg6XRpp9almPPZoS6+M9/AMNxFbisznbaYglwEjfF/T206VN6BC+yAMyyCpnibddv6WsPZ2ik=
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com (10.165.45.7) by
 AM4PR0401MB2323.eurprd04.prod.outlook.com (10.165.45.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Wed, 4 Jul 2018 07:54:49 +0000
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::9117:e4c5:7baa:3269]) by AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::9117:e4c5:7baa:3269%5]) with mapi id 15.20.0930.016; Wed, 4 Jul 2018
 07:54:49 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fec: remove redundant variable 'inc'
Thread-Topic: [PATCH] net: fec: remove redundant variable 'inc'
Thread-Index: AQHUE2uTRTWFnPNl/UeKQ8Kq0jb4ZqR+sXUw
Date:   Wed, 4 Jul 2018 07:54:49 +0000
Message-ID: <AM4PR0401MB22603C0B20F4EED3F4318A0DFF410@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180704074943.15820-1-colin.king@canonical.com>
In-Reply-To: <20180704074943.15820-1-colin.king@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB2323;7:5x7StJUuFeAi6QkF+7mSPX+6/61y+nib8rrQV5/SdJw3YiIbXvYFILmF504drOnRRghgwM30/w6nPlKK5fO5GWT7xDzZlz6VS7iolIaNtCoySFZRiR9Czb1TimSq+MsPdS+laHrxliKJMIFGCgxr+zGqTOARUW9lCn03LLNNsLe+NRkDmmPtwbxElXO/QTFlnzlOZxAZT2J0TvJWUnc46rJgeGcBGiaiQOqPr0PVtBCtoHyromKe7IvpIHChJJS6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8bd9539-da79-4783-073c-08d5e1836af4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2323;
x-ms-traffictypediagnostic: AM4PR0401MB2323:
x-microsoft-antispam-prvs: <AM4PR0401MB23230314AE1805167C58FC66FF410@AM4PR0401MB2323.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB2323;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2323;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(2906002)(316002)(33656002)(8936002)(305945005)(74316002)(476003)(97736004)(5660300001)(7736002)(81166006)(3846002)(66066001)(486006)(8676002)(81156014)(68736007)(6116002)(14454004)(4326008)(478600001)(2900100001)(5250100002)(6246003)(2501003)(106356001)(105586002)(53936002)(25786009)(110136005)(86362001)(55016002)(76176011)(446003)(14444005)(102836004)(54906003)(6506007)(6436002)(26005)(186003)(11346002)(9686003)(7696005)(99286004)(229853002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2323;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iVJtgP2hB3hYJW9qNG6OpV7L9lucwwRYOq1xNMlxmw5qdazG/iVD5OpbcgnjYFpRrhjwF86bORd9M+Kv6Xje04U/wHbdXuFwK3WwxvJObEHhkjCanuwMaKu2TIlGqRi6q7blt5R6jSh/VF28xbOZ0tUTMoclQdeI6+pF/YNMRddeMRAQg7T1WsND9U705lxcmJX3mg4lOPyMhgVHOZ9mdr401Cx5EO08ZTrxlgqrR+Zx69ftq414imyq6Yga0AT5HRUAiGxc/nhS2NlmsYDps3u37imIJqgYxIQlM6xeVbcCg0E+19JrHmwyidA35J7MUDKA8C4Su3zAVoaTfsgjcuknDw1xaOKjqQEAMj9gIic=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bd9539-da79-4783-073c-08d5e1836af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 07:54:49.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ29saW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPiBTZW50OiAyMDE45bm0
N+aciDTml6UgMTU6NTANCj4gVmFyaWFibGUgJ2luYycgaXMgYmVpbmcgYXNzaWduZWQgYnV0IGlz
IG5ldmVyIHVzZWQgaGVuY2UgaXQgaXMgcmVkdW5kYW50IGFuZA0KPiBjYW4gYmUgcmVtb3ZlZC4N
Cj4gDQo+IENsZWFucyB1cCBjbGFuZyB3YXJuaW5nOg0KPiB3YXJuaW5nOiB2YXJpYWJsZSAnaW5j
JyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCg0K
VGhhbmtzLg0KDQpBY2tlZC1ieTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQoN
Cj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jIHwgMiAt
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gaW5kZXggMzZjMmQ3ZDZlZTFiLi43ZTg5
MmIxY2JkM2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfcHRwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAu
Yw0KPiBAQCAtOTksNyArOTksNiBAQCBzdGF0aWMgaW50IGZlY19wdHBfZW5hYmxlX3BwcyhzdHJ1
Y3QNCj4gZmVjX2VuZXRfcHJpdmF0ZSAqZmVwLCB1aW50IGVuYWJsZSkgIHsNCj4gIAl1bnNpZ25l
ZCBsb25nIGZsYWdzOw0KPiAgCXUzMiB2YWwsIHRlbXB2YWw7DQo+IC0JaW50IGluYzsNCj4gIAlz
dHJ1Y3QgdGltZXNwZWM2NCB0czsNCj4gIAl1NjQgbnM7DQo+ICAJdmFsID0gMDsNCj4gQEAgLTEx
NCw3ICsxMTMsNiBAQCBzdGF0aWMgaW50IGZlY19wdHBfZW5hYmxlX3BwcyhzdHJ1Y3QNCj4gZmVj
X2VuZXRfcHJpdmF0ZSAqZmVwLCB1aW50IGVuYWJsZSkNCj4gDQo+ICAJZmVwLT5wcHNfY2hhbm5l
bCA9IERFRkFVTFRfUFBTX0NIQU5ORUw7DQo+ICAJZmVwLT5yZWxvYWRfcGVyaW9kID0gUFBTX09V
UFVUX1JFTE9BRF9QRVJJT0Q7DQo+IC0JaW5jID0gZmVwLT5wdHBfaW5jOw0KPiANCj4gIAlzcGlu
X2xvY2tfaXJxc2F2ZSgmZmVwLT50bXJlZ19sb2NrLCBmbGFncyk7DQo+IA0KPiAtLQ0KPiAyLjE3
LjENCg==
