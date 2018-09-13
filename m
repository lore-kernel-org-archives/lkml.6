Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECD8C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFB920854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFB920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sma.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeIMUcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:32:14 -0400
Received: from msgsrv4.atosorigin.de ([194.8.120.226]:6248 "EHLO
        msgsrv4.atosorigin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeIMUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:32:14 -0400
Received: from unknown (HELO julia-mo2.ccsn.de.ao-srv.com) ([194.8.124.179])
  by msgsrv-out2.atosorigin.de with ESMTP; 13 Sep 2018 17:22:12 +0200
Received: from julia-mo2.ccsn.de.ao-srv.com (unknown [194.8.124.179]) by MCS01-MA1.atosorigin.de with smtp
         id 3d1c_40db_019f8145_95b9_401b_9dc4_2d061b4432eb;
        Thu, 13 Sep 2018 17:22:12 +0200
Received: from julia-mo2 (localhost [127.0.0.1])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 58197A9BFAA;
        Thu, 13 Sep 2018 17:22:12 +0200 (CEST)
Received: from MCS02-MA1.atosorigin.de (mcs02-ma1.deuser.de.intra [194.8.120.181])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 454DAA9BFAA;
        Thu, 13 Sep 2018 17:22:12 +0200 (CEST)
Received: from SVR-DE-EXMBX-01.sma.de (unknown [10.99.42.82]) by MCS02-MA1.atosorigin.de with smtp
         id 44ce_3a48_65b32d56_835a_4565_a70a_217ec3b6d062;
        Thu, 13 Sep 2018 17:22:05 +0200
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (10.0.42.37) by
 webmail.sma.de (10.0.42.161) with Microsoft SMTP Server (TLS) id 14.3.389.1;
 Thu, 13 Sep 2018 17:21:30 +0200
Received: from DB7PR04MB5243.eurprd04.prod.outlook.com (20.176.236.87) by
 DB7PR04MB4795.eurprd04.prod.outlook.com (20.176.233.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Thu, 13 Sep 2018 15:21:28 +0000
Received: from DB7PR04MB5243.eurprd04.prod.outlook.com
 ([fe80::f198:36b7:1793:542b]) by DB7PR04MB5243.eurprd04.prod.outlook.com
 ([fe80::f198:36b7:1793:542b%3]) with mapi id 15.20.1143.014; Thu, 13 Sep 2018
 15:21:28 +0000
From:   Andre Kalb <Andre.Kalb@sma.de>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Thread-Topic: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Thread-Index: AdREZxxSehcX9yb4Tui0YlbCxpETAwCflhgAAIFiuDAACG4qAACZ52vg
Date:   Thu, 13 Sep 2018 15:21:27 +0000
Message-ID: <DB7PR04MB52433D93A8536DC7F71E169AFC1A0@DB7PR04MB5243.eurprd04.prod.outlook.com>
References: <AM6PR04MB52394FDB1266388BCE1374E3FC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
 <c0bcc2c1-3058-db4d-ca4d-4e56c502891b@gmail.com>
 <DB7PR04MB5243B6ADEBCB4B53B5A161F8FC050@DB7PR04MB5243.eurprd04.prod.outlook.com>
 <CAL_JsqKc1-Rz6iBJ_dpDrEDoFRpTaLR+1voXdTgiJjjG65druA@mail.gmail.com>
In-Reply-To: <CAL_JsqKc1-Rz6iBJ_dpDrEDoFRpTaLR+1voXdTgiJjjG65druA@mail.gmail.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andre.Kalb@sma.de; 
x-originating-ip: [62.157.91.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4795;6:Yuuh1qNo/DkeuAKRnwbOYwD0ntUXmtWCzgmTefhCDu1O3TwlG88qwAAG0zvSSo3/WGqS+NgTkxUBGsJUSjV5wICjqVQwIUpgTKOh1yd7ZUydrR+nsDKvgdfbtMarHcqu0zf17yUBshwpW4YcVmjzYoWF2jDBnuVnrZdoaX1cxWJz1SXUnkSQfPouJ9Hd4UXEiFrc+2tFof/egs+od7sw9pb3csF/fCYke3b8ri4bF9r95AAztNAgQTxvFmOQ3ZPj/4LVSooKDqW9kdzq3PyZiToD2TP0vgtLvDT81D0beZF6xI0+XJ2ViMdBC/L846D/+9bzfzzXc9oz1Bd+H43mOE7ZKpvx5efvAjdBl/GeFocrxmESDWDQCRJSqcj5ub2k3y1QGrN7VIKRanhqd7B8RHJ8LaU23lImmeMF5+zteMC3ySYLXZ19bXClnUCDqbRRlYX25hM5ETA5NRbjQ8VvdQ==;5:AW5EIW9Scx0urrw6c2e84tVXk7WWxh0W5it79RktcKxenwADGL6ygh3bqdppLC+q9ivn6KGCrXD44YCe0ksgKVrXbrrq492nHXr5xsbsoKly7Tq1LHRVLGVI7e4mW09zT96BvjtI0jk0xLCOi6jE8l5SZo7B1O6cng6sv7VuR/M=;7:LKD6FK7kOGu+pSsEngJEVRExoJcJ/Tef/phF6x5lRoEyUuTHU2h4AJJiXYDAMs+7BZuEiOmo3KdeGySQ09RHbjXNraMbpKdVyMtmHlssTLbtCZWpjU/1bNOnAJuYfe4pDkcPu2FqxUk+neP61UivDavCNCE+aolY6TdYB2VhAHEaCQU2RCD6UvZe44w/O0E557+m4OwQBxBbHOlJfxuODtYae0uto5nyFM1bkxIDlD9pP3+t6CIy5pZMCsbYzrly
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 82cd747b-5f16-44ca-5b5c-08d6198c9380
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4795;
x-ms-traffictypediagnostic: DB7PR04MB4795:
x-microsoft-antispam-prvs: <DB7PR04MB47954F24F28D5DB4EC950771FC1A0@DB7PR04MB4795.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DB7PR04MB4795;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4795;
x-forefront-prvs: 07943272E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(93886005)(53546011)(186003)(102836004)(26005)(8676002)(74316002)(14454004)(6506007)(7736002)(99286004)(76176011)(2900100001)(74482002)(7696005)(5660300001)(75402003)(305945005)(66066001)(8936002)(68736007)(2906002)(97736004)(478600001)(3846002)(5250100002)(6116002)(106356001)(45080400002)(105586002)(316002)(72206003)(9686003)(53936002)(55016002)(5024004)(6436002)(4326008)(81166006)(81156014)(25786009)(39060400002)(54906003)(446003)(14444005)(11346002)(575784001)(476003)(33656002)(486006)(256004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR04MB4795;H:DB7PR04MB5243.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sma.de does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V34qHORLdUceifHWKQyY02BxaUzGBX4ab6GOJ9m/mPHPr5lj/lAL2UCXYfx32IGrqBV/KxakS6+VOV8b5IMY2ISHR9TjA+S+GyjDB0A2XD1AuECAap6hSxnuz0IN8idjtkZ0MH2th8D6CT8LB0NfE4NseYWGYTMNry+vyXe+a2C9r5Z3tctTP5UwZhBnILpgmGDPo+1175CF2cGmhzvfZpVt7Hkr7o2UBlAJlyj0a8wc/kZ8hJG3rqNQ+flYlQcK71D3xaRa4OAG/1hqzIGFwXiCwGjDgmMW9/CVYtIWSsqDEFZptz/O7BdXPpikRfG7tfoSHxtSdsI5EmBqv9ABm1ojvAeFodZf8wG6JRr8Izo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cd747b-5f16-44ca-5b5c-08d6198c9380
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 15:21:27.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4795
X-OriginatorOrg: sma.de
X-NAI-Spam-Flag: NO
X-NAI-Spam-Level: *
X-NAI-Spam-Threshold: 8
X-NAI-Spam-Score: 1.5
X-NAI-Spam-Version: 2.3.0.9418 : core <6373> : inlines <6877> : streams
 <1798340> : uri <2709693>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpJIGhhdmUgdXNlZCBhbiBvdGhlciBoYXJkd2FyZSB0byBjaGVjayB0aGUgcGF0
Y2guIEkgaG9wZSBpdCBkb2VzbuKAmXQgbWF0dGVyLiBJIGFkZGVkIGZldyBsaW5lcyBhdCB0aGUg
dW50aXRlc3QuYy4gQWxsIGV4aXN0aW5nIHVuaXR0ZXN0IHVzZSBhbiBhdHRhY2hlZCBzeXNmcywg
dGhlcmVmb3JlIHRoZSBidWcgaXNuJ3QgZGV0ZWN0YWJsZS4NCg0KQmVzdCByZWdhcmRzDQpBbmRy
ZSBLYWxiDQoNCkZyb20gMWU4NmUzNTFlZmExYTdjZWEzMWQxNTdiYWZiMGFlNDBiODU2Y2RjYyBN
b24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IEFuZHJlIEthbGIgPEFuZHJlLkthbGJAc21h
LmRlPg0KRGF0ZTogVGh1LCAxMyBTZXAgMjAxOCAxNjo0Mjo0OCArMDIwMA0KU3ViamVjdDogW1BB
VENIXSBBZGRlZCBuZXcgdW5pdHRlc3QNCg0KLS0tDQogZHJpdmVycy9vZi91bml0dGVzdC5jIHwg
MTggKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvb2YvdW5pdHRlc3QuYyBiL2RyaXZlcnMvb2YvdW5pdHRl
c3QuYw0KaW5kZXggMmE1NDdjYTNkNDQzLi4xN2Y2Y2FjYjRmYWUgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL29mL3VuaXR0ZXN0LmMNCisrKyBiL2RyaXZlcnMvb2YvdW5pdHRlc3QuYw0KQEAgLTkyMyw2
ICs5MjMsMjQgQEAgc3RhdGljIGludCBfX2luaXQgdW5pdHRlc3RfZGF0YV9hZGQodm9pZCkNCiAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAgfQ0KDQorICAgICAgIHsNCisg
ICAgICAgICAgICAgICBzdHJ1Y3QgcHJvcGVydHkgKnByb3A7DQorDQorICAgICAgICAgICAgICAg
cHJvcCA9IGt6YWxsb2Moc2l6ZW9mKCpwcm9wKSwgR0ZQX0tFUk5FTCk7DQorICAgICAgICAgICAg
ICAgaWYgKCFwcm9wKSB7DQorICAgICAgICAgICAgICAgICAgICAgICB1bml0dGVzdCgwLCAia3ph
bGxvYygpIGZhaWxlZFxuIik7DQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01F
TTsNCisgICAgICAgICAgICAgICB9DQorDQorICAgICAgICAgICAgICAgbnAgPSBvZl9maW5kX25v
ZGVfd2l0aF9wcm9wZXJ0eSh1bml0dGVzdF9kYXRhX25vZGUsICJwcm9wLXVwZGF0ZSIpOw0KKyAg
ICAgICAgICAgICAgIHVuaXR0ZXN0KG5wLCAiZmluZCBwcm9wLXVwZGF0ZSIpOw0KKw0KKyAgICAg
ICAgICAgICAgIHByb3AtPm5hbWUgPSAicHJvcC11cGRhdGUiOw0KKyAgICAgICAgICAgICAgIHBy
b3AtPnZhbHVlID0gIm5ldy1wcm9wZXJ0eS1kYXRhIjsNCisgICAgICAgICAgICAgICBwcm9wLT5s
ZW5ndGggPSBzdHJsZW4ocHJvcC0+dmFsdWUpICsgMTsNCisgICAgICAgICAgICAgICB1bml0dGVz
dChvZl91cGRhdGVfcHJvcGVydHkobnAsIHByb3ApID09IDAsICJVcGRhdGUgYSBleGlzdGluZyBw
cm9wZXJ0eSBmYWlsZWRcbiIpOw0KKyAgICAgICB9DQorDQogICAgICAgIGlmICghb2Zfcm9vdCkg
ew0KICAgICAgICAgICAgICAgIG9mX3Jvb3QgPSB1bml0dGVzdF9kYXRhX25vZGU7DQogICAgICAg
ICAgICAgICAgZm9yX2VhY2hfb2ZfYWxsbm9kZXMobnApDQotLQ0KMi4xNi40DQoNCg0KLS0tLS0t
LS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQpXQVJOSU5HOiBDUFU6IDAgUElEOiAxIGF0
IGZzL2tlcm5mcy9kaXIuYzoxNDgxIGtlcm5mc19yZW1vdmVfYnlfbmFtZV9ucysweDljLzB4YTQN
Cmtlcm5mczogY2FuIG5vdCByZW1vdmUgJyhudWxsKScsIG5vIGRpcmVjdG9yeQ0KTW9kdWxlcyBs
aW5rZWQgaW46DQpDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIgTm90IHRhaW50ZWQgNC4xOC43
ICMzDQpIYXJkd2FyZSBuYW1lOiBGcmVlc2NhbGUgaS5NWDYgVWx0cmFsaXRlIChEZXZpY2UgVHJl
ZSkNCls8YzAxMGYzMzg+XSAodW53aW5kX2JhY2t0cmFjZSkgZnJvbSBbPGMwMTBjZWZjPl0gKHNo
b3dfc3RhY2srMHgxMC8weDE0KQ0KWzxjMDEwY2VmYz5dIChzaG93X3N0YWNrKSBmcm9tIFs8YzAx
MjIwMDQ+XSAoX193YXJuKzB4ZTAvMHhmOCkNCls8YzAxMjIwMDQ+XSAoX193YXJuKSBmcm9tIFs8
YzAxMjIwNjA+XSAod2Fybl9zbG93cGF0aF9mbXQrMHg0NC8weDY4KQ0KWzxjMDEyMjA2MD5dICh3
YXJuX3Nsb3dwYXRoX2ZtdCkgZnJvbSBbPGMwMmM2NTQwPl0gKGtlcm5mc19yZW1vdmVfYnlfbmFt
ZV9ucysweDljLzB4YTQpDQpbPGMwMmM2NTQwPl0gKGtlcm5mc19yZW1vdmVfYnlfbmFtZV9ucykg
ZnJvbSBbPGMwNTVhNzA0Pl0gKF9fb2ZfdXBkYXRlX3Byb3BlcnR5X3N5c2ZzKzB4MzgvMHg1MCkN
Cls8YzA1NWE3MDQ+XSAoX19vZl91cGRhdGVfcHJvcGVydHlfc3lzZnMpIGZyb20gWzxjMDU1N2I5
ND5dIChvZl91cGRhdGVfcHJvcGVydHkrMHhjMC8weDEwNCkNCls8YzA1NTdiOTQ+XSAob2ZfdXBk
YXRlX3Byb3BlcnR5KSBmcm9tIFs8YzA5NTIxYmM+XSAob2ZfdW5pdHRlc3QrMHgxYjgvMHgyOGQ0
KQ0KWzxjMDk1MjFiYz5dIChvZl91bml0dGVzdCkgZnJvbSBbPGMwMTAyZDg4Pl0gKGRvX29uZV9p
bml0Y2FsbCsweDQwLzB4MjE4KQ0KWzxjMDEwMmQ4OD5dIChkb19vbmVfaW5pdGNhbGwpIGZyb20g
WzxjMDkwMTAxYz5dIChrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDI0Yy8weDJlNCkNCls8YzA5MDEw
MWM+XSAoa2VybmVsX2luaXRfZnJlZWFibGUpIGZyb20gWzxjMDZhMWY2Yz5dIChrZXJuZWxfaW5p
dCsweDgvMHgxMTApDQpbPGMwNmExZjZjPl0gKGtlcm5lbF9pbml0KSBmcm9tIFs8YzAxMDEwZTg+
XSAocmV0X2Zyb21fZm9yaysweDE0LzB4MmMpDQpFeGNlcHRpb24gc3RhY2soMHhjYzA5OWZiMCB0
byAweGNjMDk5ZmY4KQ0KOWZhMDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCjlmYzA6IDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
DQo5ZmUwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAxMyAwMDAw
MDAwMA0KLS0tWyBlbmQgdHJhY2UgNDUyMmY2OWUwNzYwZTRkNSBdLS0tDQoNCg0KDQo+IC0tLS0t
VXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NCj4gVm9uOiBSb2IgSGVycmluZyBbbWFpbHRv
OnJvYmgrZHRAa2VybmVsLm9yZ10NCj4gR2VzZW5kZXQ6IE1vbnRhZywgMTAuIFNlcHRlbWJlciAy
MDE4IDE1OjQ3DQo+IEFuOiBBbmRyZSBLYWxiDQo+IENjOiBGcmFuayBSb3dhbmQ7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IEJldHJl
ZmY6IFJlOiBbUEFUQ0ggdjJdIG9mOiBfX29mX3VwZGF0ZV9wcm9wZXJ0eV9zeXNmcyBvbmx5IGNh
bGwNCj4gX19vZl9zeXNmc19yZW1vdmVfYmluX2ZpbGUgaWYgb2Zfbm9kZV9pc19hdHRhY2hlZA0K
Pg0KPiBPbiBNb24sIFNlcCAxMCwgMjAxOCBhdCA0OjUxIEFNIEFuZHJlIEthbGIgPEFuZHJlLkth
bGJAc21hLmRlPiB3cm90ZToNCj4gPg0KPiA+IEhpIEZyYW5rLA0KPiA+DQo+ID4gPiAtLS0tLVVy
c3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+ID4gPiBWb246IEZyYW5rIFJvd2FuZCBbbWFp
bHRvOmZyb3dhbmQubGlzdEBnbWFpbC5jb21dDQo+ID4gPiBHZXNlbmRldDogRnJlaXRhZywgNy4g
U2VwdGVtYmVyIDIwMTggMjI6MDENCj4gPiA+IEFuOiBBbmRyZSBLYWxiOyByb2JoK2R0QGtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgtIGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IEJldHJlZmY6IFJlOiBbUEFUQ0ggdjJdIG9mOiBfX29mX3Vw
ZGF0ZV9wcm9wZXJ0eV9zeXNmcyBvbmx5IGNhbGwNCj4gPiA+IF9fb2Zfc3lzZnNfcmVtb3ZlX2Jp
bl9maWxlIGlmIG9mX25vZGVfaXNfYXR0YWNoZWQNCj4gPiA+DQo+ID4gPiBIaSBBbmRyZWQsDQo+
ID4gPg0KPiA+ID4gT24gMDkvMDQvMTggMDg6NTEsIEFuZHJlIEthbGIgd3JvdGU6DQo+ID4gPiA+
IFRvIHByZXZlbnQgd2FybmluZyAia2VybmZzOiBjYW4gbm90IHJlbW92ZSAnKG51bGwpJywgbm8g
ZGlyZWN0b3J5Ig0KPiA+ID4gPiBpZiBhbiBvdmVybGF5DQo+ID4gPiBpc24ndCBhcHBsaWVkIHRv
IHRoZSBhY3RpdmUgZGV2aWNldHJlZS4NCj4gPiA+ID4NCj4gPiA+ID4gVXNpbmcgb2ZfcmVtb3Zl
X3Byb3BlcnR5IGFuZCB0aGVuIG9mX2FkZF9wcm9wZXJ0eSBkb2Vzbid0IHNob3cgdGhlDQo+ID4g
PiB3YXJuaW5nLg0KPg0KPiBbLi4uXQ0KPg0KPiA+ID4gV2hhdCBpcyB0aGUgY2FsbGluZyBwYXRo
IHRoYXQgcmVzdWx0cyBpbiB0aGUgd2FybmluZz8NCj4gPiA+DQo+ID4gPiAtRnJhbmsNCj4gPg0K
PiA+IFRoZXJlIGlzIHRoZSBjYWxsc3RhY2sgb2YgdGhlIHdhcm5pbmcuDQo+ID4NCj4gPiBbICAg
MTAuNzgyODMwXSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gPiBbICAg
MTAuODMwMzU3XSBXQVJOSU5HOiBDUFU6IDAgUElEOiAxNzAgYXQgL2xpbnV4LTQueC9mcy9rZXJu
ZnMvZGlyLmM6MTI3Ng0KPiBrZXJuZnNfcmVtb3ZlX2J5X25hbWVfbnMrMHgzMC8weDgwKCkNCj4g
PiBbICAgMTAuOTI4OTk3XSBrZXJuZnM6IGNhbiBub3QgcmVtb3ZlICcobnVsbCknLCBubyBkaXJl
Y3RvcnkNCj4gPiBbICAgMTAuOTkzMTA3XSBNb2R1bGVzIGxpbmtlZCBpbjogbW9kdWxlX2NhcGVt
Z3IoKykNCj4gPiBbICAgMTEuMDQ1NzUwXSBDUFU6IDAgUElEOiAxNzAgQ29tbTogc3lzdGVtZC11
ZGV2ZCBOb3QgdGFpbnRlZCA0LjQuMTQzLQ0KPiAwMDE1OC1nOGU1Y2E2NWVjN2VlLWRpcnR5ICMx
MTQNCj4NCj4gMTU4IHBhdGNoZXMgb24gdG9wIG9mIGFuIGFsbW9zdCAzIHllYXIgb2xkIGtlcm5l
bC4uLg0KPg0KPiA+IFsgICAxMi4wMTEzNzNdIFs8YmYwMDAwZTQ+XSAobW9kdWxlX2NhcGVtZ3Jf
c2xvdF9zY2FuIFttb2R1bGVfY2FwZW1ncl0pDQo+IGZyb20gWzxiZjAwMDdiYz5dIChtb2R1bGVf
Y2FwZW1ncl9wcm9iZSsweDNjLzB4NTggW21vZHVsZV9jYXBlbWdyXSkNCj4NCj4gQW5kIGEgZHJp
dmVyIHRoYXQncyBub3QgdXBzdHJlYW0uDQo+DQo+IE5vdCBzYXlpbmcgdGhlIGZpeCBpc24ndCB2
YWxpZCwgYnV0IHBsZWFzZSByZXByb2R1Y2Ugb24gcmVjZW50IG1haW5saW5lLiBBZGQgYQ0KPiB1
bml0dGVzdCBpZiB5b3UgaGF2ZSB0by4NCj4NCj4gUm9iDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpTTUEgU29sYXIgVGVjaG5vbG9neSBB
Rw0KQXVmc2ljaHRzcmF0OiBEci4gRXJpayBFaHJlbnRyYXV0IChWb3JzaXR6ZW5kZXIpDQpWb3Jz
dGFuZDogVWxyaWNoIEhhZGRpbmcsIERyLi1JbmcuIEp1ZXJnZW4gUmVpbmVydCwgUGllcnJlLVBh
c2NhbCBVcmJvbg0KSGFuZGVsc3JlZ2lzdGVyOiBBbXRzZ2VyaWNodCBLYXNzZWwgSFJCIDM5NzIN
ClNpdHogZGVyIEdlc2VsbHNjaGFmdDogMzQyNjYgTmllc3RldGFsDQpVU3QtSUQtTnIuIERFIDEx
MyAwOCA1OSA1NA0KV0VFRS1SZWcuLU5yLiBERSA5NTg4MTE1MA0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo=
