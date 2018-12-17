Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97D72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="VUnlKlS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbeLQOow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:44:52 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:10266 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbeLQOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:44:51 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id D7/9B-09202-D56B71C5; Mon, 17 Dec 2018 14:44:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRWlGSWpSXmKPExsWSoc9kpBu7TTz
  G4OIzBYvbU08yWTQvXs9m0bV6J4vFvo/rmCwu75rDZrFoWSuzxZOFZ5gc2D0WbCr1mHcy0GP/
  3DXsHju/N7B7fN4kF8AaxZqZl5RfkcCaMfvSH8aCw4YVd27MZWlg/GDQxcjFwSKwnlni2srrT
  CCOkMAUJonHp/9DOY8ZJZZfXsTcxcjJwSZgITH5xAM2kISIQDOTxJGJf8GqmAWWMkpsurKEvY
  uRg0NYIEpi0hsxkAYRgWiJ2cu2sEDYRhKfLs5iBbFZBFQlPu+YDWbzCiRKXN66A6xGSMBcYtn
  p72A2J9Cy6+f2MoLYjAKyEl8aV4MdwSwgLnHryXwmEFtCQEBiyZ7zzBC2qMTLx/9YIepTJU42
  3WCEiOtInL3+hBHkNAkBRYm+x9YQYVmJS/O7GUHOlxC4ySbR9WoV1ExfibUP7zFBJO4wSrR9e
  ssGM2hG91IWCNtCYkl3K5RdIPFl6Rl2CFtOYlXvQxaI5rvMEtM3PoFKyEh0XGiBmvqfVaL78F
  xWiJeTJT7MPcs+gVFnFpLvZgFdyyygKbF+lz5EWFFiSvdD9lngABOUODnzCcsCRpZVjOZJRZn
  pGSW5iZk5uoYGBrqGhka6hpamuuZmeolVuol6qaW65anFJbqGeonlxXrFlbnJOSl6eaklmxiB
  ySul4LDPDsZ7y9MPMUpyMCmJ8r5cKh4jxJeUn1KZkVicEV9UmpNafIhRhoNDSYL3x3KgnGBRa
  npqRVpmDjCNwqQlOHiURHiTtgCleYsLEnOLM9MhUqcYLTm2nemcwcxxBUwe7/w6h1mIJS8/L1
  VKnPcuSIMASENGaR7cOFiqv8QoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHcByBSezLwSuK2
  vgA5iAjooZwsTyEEliQgpqQbG7f4H3q849ZThzLIVGR2GEbU3GQ1PyFx6pLPgUqqx4xrDF4ey
  J51l/rRX37LhwLTi9d72X5e9vPZY9lZrg6fKbLsXEmIXZZUCqxLrfxpkPJjLE3DwcEnfOp59/
  2SeHmHkEzB9HehrO8XWy2mb77SQdAPrM1u8rlb3HFlzZOGGvRyR4uU3Z3QnKbEUZyQaajEXFS
  cCABgnRlvwAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-27.tower-262.messagelabs.com!1545057884!109847!1
X-Originating-IP: [104.47.2.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20735 invoked from network); 17 Dec 2018 14:44:45 -0000
Received: from mail-db5eur01lp2050.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.50)
  by server-27.tower-262.messagelabs.com with AES256-SHA256 encrypted SMTP; 17 Dec 2018 14:44:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XGWA9H/z2wH6DjHFTy+bnCrn/g0BPYSaFxJks9AIZM=;
 b=VUnlKlS9g9Rpi6Pd1bJ1jFUqIN27iRL4JARpYIgpmGh3BfY9eZr5wDyjPefmtE9Qi6RXHkgNfxqa5KnD4+uaxemv5+trptRLwBjIhlUlACRYXABdvfwGwFgQdhc7BLWrMVrSn5uwdrokt+5dZkWUoQzYftwxAfYqV9CkKdop7Ug=
Received: from HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM (10.168.129.142) by
 HE1PR1001MB0876.EURPRD10.PROD.OUTLOOK.COM (10.167.193.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 14:44:34 +0000
Received: from HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b806:2864:5268:3447]) by HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b806:2864:5268:3447%5]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:44:33 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Kyle Tso <kyletso@google.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "badhri@google.com" <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] usb: typec: tcpm: Extend the matching rules on PPS
 APDO selection
Thread-Topic: [PATCH v3] usb: typec: tcpm: Extend the matching rules on PPS
 APDO selection
Thread-Index: AQHUlguPO0aeV5rVZ06xgwLCc/KUsqWC90iA
Date:   Mon, 17 Dec 2018 14:44:33 +0000
Message-ID: <HE1PR1001MB1002682A2227CBF547A41BC780BC0@HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM>
References: <20181217132213.91566-1-kyletso@google.com>
In-Reply-To: <20181217132213.91566-1-kyletso@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR1001MB0876;6:ErNwi7Kx7pgijT0akNqF5scDUKTv6/LYK7MlKDjPLB50J4m/1S1fA09i41rroi9PusGgm3uGJFeI4OIut/MR63JgNrGxu9cSiKPIrSjDFG8vEOycJSOmIX6jf9W7jxwp+TajqxPGqTg2ZWoCyFgNgLkDFOB46jMZAiOMhwqzWb6nasyQJ9t+Y/dndtt6L1Ahp8glGFvsdColPx+6pYDkvQptx8MXX/JVIceixGjgpd1ITzWdgxQEYS6SCiIHgGfcInFloBUvHwqyuZaGVidTFS4TDMG00i1CNUrfk2ISFe/1e4/PX67994AnZLu+e1UYKeeOQdsDonrN2BZXFzT0fb6v9j+h5IcsfbZkPLrWoKHcVbMkMPFhWeAsEzVL4biQsdW46MqtUXOuNmVkp/KNGNUSbbskfIyj77r9MoKD38qbWkH4swmOx8Id7LPhWUiuJ1GK9F5EVWLNJqYQCbHxBw==;5:roMrWX9mRsNcDyrTNl6yit+46oTWMyBRZZY/G6tZ0b7XXYlqjtJFoFKO1ro3y8x0LATDCKAvylhvKsGDIrFW6GRIqNHVaGii1oKHK744ZbSf+YQrSI8LhSn0YsvoIraJnq3izIx4/v6rNDjAyniIeYnsc+jABhov9DHcahspIQ4=;7:pgsHolU8kUrWCbTfJtl7CY9Xmn8q1A67uOoa/E6WN4225XGqC+ueZOxMBCIYxD6Lsd2SNXhrvU89/4hHwiuAW1MaaBPgZjGA85nAXNLQCI+qbLes8ULnSfrgeI5QPC/fDZXBW+lezeZ5ScwZQxVf5A==
x-ms-office365-filtering-correlation-id: e19ae825-6dd9-4c5c-ac87-08d6642e2912
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR1001MB0876;
x-ms-traffictypediagnostic: HE1PR1001MB0876:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <HE1PR1001MB087679EC0477C39C7F769C8CA7BC0@HE1PR1001MB0876.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:HE1PR1001MB0876;BCL:0;PCL:0;RULEID:;SRVR:HE1PR1001MB0876;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39850400004)(366004)(136003)(54534003)(189003)(199004)(25786009)(55016002)(6436002)(33656002)(7736002)(66066001)(256004)(3846002)(74316002)(72206003)(99286004)(478600001)(14454004)(8936002)(217873002)(2906002)(97736004)(6116002)(486006)(68736007)(81166006)(316002)(110136005)(54906003)(305945005)(8676002)(446003)(76176011)(26005)(4326008)(53546011)(106356001)(476003)(81156014)(11346002)(102836004)(53936002)(7696005)(71190400001)(71200400001)(229853002)(2501003)(105586002)(5660300001)(55236004)(2201001)(186003)(9686003)(6246003)(6506007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR1001MB0876;H:HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Gkk3CwzsydgfhIh3vDKdyEAli8kdSZPotx6hhYuDDo+IRk2x8+qvR+qBEhZ/wuUEno+5GFnFzLV5S4LP4wef31hFKNm6aGnfCbD/q0VQSGXmOqC34c4kpCmIxwN1GuQtNfh4PVvZsLgcJ1JkIJUCABFhIFspnP29ATwQuNvsereyrtHzPRYNcZnySX8YZNYajx0woK+0FTyxcI4x2nkclSFqDk0A7ghmqH8gyPHkLl43G044c4bJwAUQUVXKROpQH30ln5nDXw0QyLBsRT3GYP038TKy3LSjXOyj6XCNeZS5zZvxKq0mL6jAYqGImIyd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19ae825-6dd9-4c5c-ac87-08d6642e2912
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:44:33.8385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB0876
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcgRGVjZW1iZXIgMjAxOCAxMzoyMiwgS3lsZSBUc28gd3JvdGU6DQoNCj4gQ3VycmVudCBt
YXRjaGluZyBydWxlcyBlbnN1cmUgdGhhdCB0aGUgdm9sdGFnZSByYW5nZSBvZiBzZWxlY3RlZCBT
b3VyY2UNCj4gQ2FwYWJpbGl0eSBpcyBlbnRpcmVseSB3aXRoaW4gdGhlIHJhbmdlIGRlZmluZWQg
aW4gb25lIG9mIHRoZSBTaW5rIENhcGFiaWxpdGllcy4gVGhpcw0KPiBpcyByZWFzb25hYmxlIGJ1
dCBub3QgcHJhY3RpY2FsIGJlY2F1c2UgU2luayBtYXkgbm90IHN1cHBvcnQgd2lkZSByYW5nZSBv
Zg0KPiB2b2x0YWdlIHdoZW4gc2lua2luZyBwb3dlciB3aGlsZSBTb3VyY2UgY291bGQgYWR2ZXJ0
aXNlIGl0cyBjYXBhYmlsaXRpZXMgaW4NCj4gcmVsYXRpdmVseSB3aWRlciByYW5nZS4gRm9yIGV4
YW1wbGUsIGEgU291cmNlIFBETyBhZHZlcnRpc2luZyAzLjNWLTExVkAzQSAoOVYNCj4gUHJvZyBv
ZiBGaXhlZCBOb21pbmFsIFZvbHRhZ2UpIHdpbGwgbm90IGJlIHNlbGVjdGVkIGlmIHRoZSBTaW5r
IHJlcXVpcmVzIDVWLQ0KPiAxMlZAM0EgUFBTIHBvd2VyLiBIb3dldmVyLCB0aGUgU2luayBjb3Vs
ZCB3b3JrIHdlbGwgaWYgdGhlIHJlcXVlc3RlZCB2b2x0YWdlDQo+IHJhbmdlIGluIFJET3MgaXMg
NVYtMTFWQDNBLg0KPiANCj4gQ3VycmVudGx5IGFjY2VwdGVkOg0KPiAJCXwtLS0tLS0tLS0gc291
cmNlIC0tLS0tfA0KPiAJfC0tLS0tLS0tLS0tIHNpbmsgLS0tLS0tLS0tLS0tLS0tfA0KPiANCj4g
Q3VycmVudGx5IG5vdCBhY2NlcHRlZDoNCj4gCQkJfC0tLS0tLS0tLSBzb3VyY2UgLS0tLS18DQo+
IAl8LS0tLS0tLS0tLS0gc2luayAtLS0tLS0tLS0tLS0tLS18DQo+IA0KPiAJfC0tLS0tLS0tLSBz
b3VyY2UgLS0tLS18DQo+IAkJfC0tLS0tLS0tLS0tIHNpbmsgLS0tLS0tLS0tLS0tLS0tfA0KPiAN
Cj4gCXwtLS0tLS0tLS0gc291cmNlIC0tLS0tLS0tLS0tLS0tLS0tfA0KPiAJCXwtLS0tLS0gc2lu
ayAtLS0tLS0tfA0KPiANCj4gVG8gaW1wcm92ZSB0aGUgdXNhYmlsaXR5LCBjaGFuZ2UgdGhlIG1h
dGNoaW5nIHJ1bGVzIHRvIHdoYXQgbGlzdGVkDQo+IGJlbG93Og0KPiBhLiBUaGUgU291cmNlIFBE
TyBpcyBzZWxlY3RhYmxlIGlmIGFueSBwb3J0aW9uIG9mIHRoZSB2b2x0YWdlIHJhbmdlDQo+ICAg
IG92ZXJsYXBzIG9uZSBvZiB0aGUgU2luayBQRE8ncyB2b2x0YWdlIHJhbmdlLg0KPiBiLiBUaGUg
bWF4aW11bSBvcGVyYXRpb25hbCB2b2x0YWdlIHdpbGwgYmUgdGhlIGxvd2VyIG9uZSBiZXR3ZWVu
IHRoZQ0KPiAgICBzZWxlY3RlZCBTb3VyY2UgUERPIGFuZCB0aGUgbWF0Y2hpbmcgU2luayBQRE8u
DQo+IGMuIFRoZSBtYXhpbXVtIHBvd2VyIHdpbGwgYmUgdGhlIG1heGltdW0gb3BlcmF0aW9uYWwg
dm9sdGFnZSB0aW1lcyB0aGUNCj4gICAgbWF4aW11bSBjdXJyZW50IGRlZmluZWQgaW4gdGhlIHNl
bGVjdGVkIFNvdXJjZSBQRE8gZC4gU2VsZWN0IHRoZSBTb3VyY2UgUERPDQo+IHdpdGggdGhlIGhp
Z2hlc3QgbWF4aW11bSBwb3dlcg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3lsZSBUc28gPGt5bGV0
c29AZ29vZ2xlLmNvbT4NCg0KQWNrZWQtYnk6IEFkYW0gVGhvbXNvbiA8QWRhbS5UaG9tc29uLk9w
ZW5zb3VyY2VAZGlhc2VtaS5jb20+DQoNCj4gDQo+IC0tLQ0KPiBDaGFuZ2Vsb2cgc2luY2UgdjE6
DQo+IC0gdXBkYXRlZCB0aGUgY29tbWl0IG1lc3NhZ2UgYXMgc3VnZ2VzdGVkIGJ5IEd1ZW50ZXIg
Um9lY2sgPGxpbnV4QHJvZWNrLQ0KPiB1cy5uZXQ+DQo+IA0KPiBDaGFuZ2Vsb2cgc2luY2UgdjI6
DQo+IC0gZml4ZWQgdGhlIGNvZGluZyBzdHlsZSBwcm9ibGVtcyBhcyBzdWdnZXN0ZWQgYnkgSGVp
a2tpIEtyb2dlcnVzDQo+ICAgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+DQo+IC0g
Q29ycmVjdGVkIGEgd3Jvbmcgd29yZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYXMgc3VnZ2VzdGVk
IGJ5IEFkYW0NCj4gVGhvbXNvbg0KPiAgIDxBZGFtLlRob21zb24uT3BlbnNvdXJjZUBkaWFzZW1p
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYyB8IDM1ICsrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5z
ZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvdHlwZWMvdGNwbS90Y3BtLmMgYi9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0KPiBp
bmRleCAzNjIwZWZlZTI2ODguLjRiYzI5YjU4NjY5OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvdHlwZWMvdGNwbS90Y3BtLmMNCj4gKysrIGIvZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3Bt
LmMNCj4gQEAgLTIyMTMsNyArMjIxMyw4IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgdGNwbV9wZF9z
ZWxlY3RfcHBzX2FwZG8oc3RydWN0DQo+IHRjcG1fcG9ydCAqcG9ydCkNCj4gIAl1bnNpZ25lZCBp
bnQgaSwgaiwgbWF4X213ID0gMCwgbWF4X212ID0gMDsNCj4gIAl1bnNpZ25lZCBpbnQgbWluX3Ny
Y19tdiwgbWF4X3NyY19tdiwgc3JjX21hLCBzcmNfbXc7DQo+ICAJdW5zaWduZWQgaW50IG1pbl9z
bmtfbXYsIG1heF9zbmtfbXY7DQo+IC0JdTMyIHBkbzsNCj4gKwl1bnNpZ25lZCBpbnQgbWF4X29w
X212Ow0KPiArCXUzMiBwZG8sIHNyYywgc25rOw0KPiAgCXVuc2lnbmVkIGludCBzcmNfcGRvID0g
MCwgc25rX3BkbyA9IDA7DQo+IA0KPiAgCS8qDQo+IEBAIC0yMjYzLDE2ICsyMjY0LDE4IEBAIHN0
YXRpYyB1bnNpZ25lZCBpbnQgdGNwbV9wZF9zZWxlY3RfcHBzX2FwZG8oc3RydWN0DQo+IHRjcG1f
cG9ydCAqcG9ydCkNCj4gIAkJCQkJY29udGludWU7DQo+ICAJCQkJfQ0KPiANCj4gLQkJCQlpZiAo
bWF4X3NyY19tdiA8PSBtYXhfc25rX212ICYmDQo+IC0JCQkJICAgIG1pbl9zcmNfbXYgPj0gbWlu
X3Nua19tdikgew0KPiArCQkJCWlmIChtaW5fc3JjX212IDw9IG1heF9zbmtfbXYgJiYNCj4gKwkJ
CQkgICAgbWF4X3NyY19tdiA+PSBtaW5fc25rX212KSB7DQo+ICsJCQkJCW1heF9vcF9tdiA9IG1p
bihtYXhfc3JjX212LA0KPiBtYXhfc25rX212KTsNCj4gKwkJCQkJc3JjX213ID0gKG1heF9vcF9t
diAqIHNyY19tYSkgLyAxMDAwOw0KPiAgCQkJCQkvKiBQcmVmZXIgaGlnaGVyIHZvbHRhZ2VzIGlm
IGF2YWlsYWJsZSAqLw0KPiAgCQkJCQlpZiAoKHNyY19tdyA9PSBtYXhfbXcgJiYNCj4gLQkJCQkJ
ICAgICBtaW5fc3JjX212ID4gbWF4X212KSB8fA0KPiArCQkJCQkgICAgIG1heF9vcF9tdiA+IG1h
eF9tdikgfHwNCj4gIAkJCQkJICAgIHNyY19tdyA+IG1heF9tdykgew0KPiAgCQkJCQkJc3JjX3Bk
byA9IGk7DQo+ICAJCQkJCQlzbmtfcGRvID0gajsNCj4gIAkJCQkJCW1heF9tdyA9IHNyY19tdzsN
Cj4gLQkJCQkJCW1heF9tdiA9IG1heF9zcmNfbXY7DQo+ICsJCQkJCQltYXhfbXYgPSBtYXhfb3Bf
bXY7DQo+ICAJCQkJCX0NCj4gIAkJCQl9DQo+ICAJCQl9DQo+IEBAIC0yMjg1LDE2ICsyMjg4LDE4
IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgdGNwbV9wZF9zZWxlY3RfcHBzX2FwZG8oc3RydWN0DQo+
IHRjcG1fcG9ydCAqcG9ydCkNCj4gIAl9DQo+IA0KPiAgCWlmIChzcmNfcGRvKSB7DQo+IC0JCXBk
byA9IHBvcnQtPnNvdXJjZV9jYXBzW3NyY19wZG9dOw0KPiAtDQo+IC0JCXBvcnQtPnBwc19kYXRh
Lm1pbl92b2x0ID0gcGRvX3Bwc19hcGRvX21pbl92b2x0YWdlKHBkbyk7DQo+IC0JCXBvcnQtPnBw
c19kYXRhLm1heF92b2x0ID0gcGRvX3Bwc19hcGRvX21heF92b2x0YWdlKHBkbyk7DQo+IC0JCXBv
cnQtPnBwc19kYXRhLm1heF9jdXJyID0NCj4gLQkJCW1pbl9wcHNfYXBkb19jdXJyZW50KHBkbywg
cG9ydC0+c25rX3Bkb1tzbmtfcGRvXSk7DQo+IC0JCXBvcnQtPnBwc19kYXRhLm91dF92b2x0ID0N
Cj4gLQkJCW1pbihwZG9fcHBzX2FwZG9fbWF4X3ZvbHRhZ2UocGRvKSwgcG9ydC0NCj4gPnBwc19k
YXRhLm91dF92b2x0KTsNCj4gLQkJcG9ydC0+cHBzX2RhdGEub3BfY3VyciA9DQo+IC0JCQltaW4o
cG9ydC0+cHBzX2RhdGEubWF4X2N1cnIsIHBvcnQtPnBwc19kYXRhLm9wX2N1cnIpOw0KPiArCQlz
cmMgPSBwb3J0LT5zb3VyY2VfY2Fwc1tzcmNfcGRvXTsNCj4gKwkJc25rID0gcG9ydC0+c25rX3Bk
b1tzbmtfcGRvXTsNCj4gKw0KPiArCQlwb3J0LT5wcHNfZGF0YS5taW5fdm9sdCA9DQo+IG1heChw
ZG9fcHBzX2FwZG9fbWluX3ZvbHRhZ2Uoc3JjKSwNCj4gKwkJCQkJICAgICAgcGRvX3Bwc19hcGRv
X21pbl92b2x0YWdlKHNuaykpOw0KPiArCQlwb3J0LT5wcHNfZGF0YS5tYXhfdm9sdCA9DQo+IG1p
bihwZG9fcHBzX2FwZG9fbWF4X3ZvbHRhZ2Uoc3JjKSwNCj4gKwkJCQkJICAgICAgcGRvX3Bwc19h
cGRvX21heF92b2x0YWdlKHNuaykpOw0KPiArCQlwb3J0LT5wcHNfZGF0YS5tYXhfY3VyciA9IG1p
bl9wcHNfYXBkb19jdXJyZW50KHNyYywgc25rKTsNCj4gKwkJcG9ydC0+cHBzX2RhdGEub3V0X3Zv
bHQgPSBtaW4ocG9ydC0+cHBzX2RhdGEubWF4X3ZvbHQsDQo+ICsJCQkJCSAgICAgIHBvcnQtPnBw
c19kYXRhLm91dF92b2x0KTsNCj4gKwkJcG9ydC0+cHBzX2RhdGEub3BfY3VyciA9IG1pbihwb3J0
LT5wcHNfZGF0YS5tYXhfY3VyciwNCj4gKwkJCQkJICAgICBwb3J0LT5wcHNfZGF0YS5vcF9jdXJy
KTsNCj4gIAl9DQo+IA0KPiAgCXJldHVybiBzcmNfcGRvOw0KPiAtLQ0KPiAyLjIwLjAuNDA1Lmdi
YzFiYmM2Zjg1LWdvb2cNCg==
