Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCF1C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22EB214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bwiSvi6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22EB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJJGTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:19:18 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:6144
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725750AbeJJGTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CHBZEV2SUR/q55uWMS/9RKiWa2M4jywsEjdzGjGv0A=;
 b=bwiSvi6+jlQEj1gCdzzmbGasUzVDqCDVwm3VWjA/tWo8VkFFQYzD4PhgeSqy7jfO+CuaLCCDDsAC/8ABLKKfypVZGOOrkuOimLNEmTUtMTjzwsvxnEou0K/eezj6rVM05zg6XLLfK7jxk9x4dKyviQBNL13EnACmTlcla4Fk5po=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4388.eurprd04.prod.outlook.com (52.135.148.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Tue, 9 Oct 2018 23:00:00 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.029; Tue, 9 Oct 2018
 23:00:00 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Topic: [PATCH v3] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Index: AQHUXxt/otjVETax2kKjUwsgexWsHKUWGyOAgAFuQYA=
Date:   Tue, 9 Oct 2018 23:00:00 +0000
Message-ID: <2e4fd39e1e2271f12f6f11fe644cad7c93d1d363.camel@nxp.com>
References: <c4478a98b0d2c69d58b4ba5cad3c13d73c5b387f.1539012355.git.leonard.crestez@nxp.com>
         <20181009010905.GY3587@dragon>
In-Reply-To: <20181009010905.GY3587@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4388;6:zJSOXG9u+6+uipbNr5EWNWqzCANV+eELpKMW5kgzNchkQp8ru1m/N2oEsWo6gxqsau3YQq3ynHii7bHD/9zdyO9NzZaHmkhiJOcF2tIJU/25VgvfIMC5pf+AhVippaHkGVzXsHk/zS2VPEnkBEQ24uoqixcJdF81cFukpuBT8/RnOwS6i+bQlce2CePlmchm4wg26Nz71SCO2M72cTWIElcZUAWV9VuafTSiV67yfkgc99YsKN9xgXdHLrOBQMNG+I6/+K6BhUryZBPUWgz2KMZ6lopiGh06jEc0kU+xDynJm9WzMztULdScPKDHttH1qnSiDDKzHmSnp44eZB3H4bObtk1J6W3l5QK5gqnyW2Ar+NGcXqiGbjgsJn+SJ1zoc+SKla5ACTPbsQx3t7FWUWx7tmoauBlDI6FSoCcFQsbAiGP6LqZMSwQMh+SGER5iZF41P89CI0VlljYjGrWbHQ==;5:CWCNx24htMfJJEtC7q9NUUD9BcHkIlwKLkv5jYse6qEIixITchYTP6ZNJJU3vn4nFSAecNaohWllHHqVI9lWabnyzFaJuBxpuILJsquQojyMMWryQSyl2XIMD52mF1y8qTVrhsLxU9hq7GYZMuVy/lFObGVEH4RvRPZRffk22co=;7:gTfIqKV6JmqVXHfbU4nE9YYCoCizZ9MAXc/bJDlgAKse1nYw2KjfM1LEnpBOsMl4f20idJTgJ3hlWQqScW6c6LJfHld7Cl5gMYp6PVoJ9UB5iqTK/N9XNUJ8Dbs3GkKlQE48j5ftgvLKjsIJJRa4rQzVCpqNxxmdMBMUbe/DgrsnLkCUB6+kPf1ATpN4sKFKPaIuPU1eDSN6XpoGu6WWoThywTKJegWQ0AQKxeS/8bzOwlf3QEMUJWHgcFtHSQTG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2149b0cd-162b-4093-4d33-08d62e3af0ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4388;
x-ms-traffictypediagnostic: AM0PR04MB4388:
x-microsoft-antispam-prvs: <AM0PR04MB438826AAE3CF8F5ED333CAE0EEE70@AM0PR04MB4388.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:AM0PR04MB4388;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4388;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(71190400001)(36756003)(316002)(8676002)(4326008)(39060400002)(6116002)(81156014)(81166006)(2501003)(3846002)(256004)(110136005)(5660300001)(14444005)(186003)(44832011)(7736002)(86362001)(71200400001)(25786009)(8936002)(66066001)(105586002)(305945005)(68736007)(54906003)(2616005)(106356001)(53936002)(2906002)(6486002)(76176011)(102836004)(476003)(6436002)(229853002)(97736004)(11346002)(26005)(6246003)(6636002)(5250100002)(486006)(118296001)(6506007)(99286004)(446003)(478600001)(6512007)(14454004)(2900100001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4388;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2kL+kuwIJUWFtbLUw/R0Jpq7Rl0Glc0t0lMIL3w4MH441QV87NMByqnQmUxCzwltJRt/kKIE1Vvui1n3NK9YN4KYqYICha+3M3HRUcCdWmzrfFIH4/32oKgZef6Iini92u5A+rbhSLxDnsuyGkRrvL7lxK4u3LnEF9jMEbucm4LvKbf2eTeQ+Efr4xmDp4z6p1bmjmmdX+TZg+Shkr8KWTOILjymQ24Qg7vp/ri4S6Y0FdZ0r0E75F7LmEig21n+P6buQAoMzNngS9TZ5+dqEMQmel+Dp/m6USn5/OYTpL3IF6DZZB7FjJ9YPqNdTuED8pJtY/3u5W0OniTJgbCrG7uI+sV8WhsbxFwrYVTh19s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FFB843FFAAA1646B5D82CF4BC9B7891@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2149b0cd-162b-4093-4d33-08d62e3af0ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 23:00:00.3948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4388
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTA5IGF0IDA5OjA5ICswODAwLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9u
IE1vbiwgT2N0IDA4LCAyMDE4IGF0IDAzOjI4OjAxUE0gKzAwMDAsIExlb25hcmQgQ3Jlc3RleiB3
cm90ZToNCj4gPiBCaW5kaW5ncyBmb3IgImZpeGVkLXJlZ3VsYXRvciIgb25seSBleHBsaWNpdGx5
IHN1cHBvcnQgImdwaW8iIHByb3BlcnR5LA0KPiA+IG5vdCAiZ3Bpb3MiLiBGaXggYnkgY29ycmVj
dGluZyB0aGUgcHJvcGVydHkgbmFtZS4NCj4gPiANCj4gPiBUaGUgZW5ldCBQSFlzIG9uIGlteDZz
eC1zZGIgbmVlZHMgdG8gYmUgZXhwbGljaXRseSByZXNldCBhZnRlciBhIHBvd2VyDQo+ID4gY3lj
bGUsIHRoaXMgY2FuIGJlIGhhbmRsZWQgYnkgdGhlIHBoeS1yZXNldC1ncGlvcyBwcm9wZXJ0eS4g
U2FkbHkgdGhpcw0KPiA+IGlzIG5vdCBoYW5kbGVkIG9uIHN1c3BlbmQ6IHRoZSBmZWMgZHJpdmVy
IHR1cm5zIHBoeS1zdXBwbHkgb2ZmIGJ1dA0KPiA+IGRvZXNuJ3QgYXNzZXJ0IHBoeS1yZXNldC1n
cGlvcyBhZ2FpbiBvbiByZXN1bWUuDQo+ID4gDQo+ID4gU2luY2UgYWRkaXRpb25hbCBwaHktbGV2
ZWwgd29yayBpcyByZXF1aXJlZCB0byBzdXBwb3J0IHBvd2VyaW5nIG9mZiB0aGUNCj4gPiBwaHkg
aW4gc3VzcGVuZCBmaXggdGhlIHByb2JsZW0gYnkganVzdCBtYXJraW5nIHRoZSByZWd1bGF0b3Ig
YXMNCj4gPiAiYm9vdC1vbiIgImFsd2F5cy1vbiIgc28gdGhhdCBpdCdzIG5ldmVyIHR1cm5lZCBv
ZmYuIFRoaXMgYmVoYXZpb3IgaXMNCj4gPiBlcXVpdmFsZW50IHRvIG9sZGVyIHJlbGVhc2VzLg0K
PiA+IA0KPiA+IEtlZXAgdGhlIHBoeS1yZXNldC1ncGlvcyBwcm9wZXJ0eSBvbiBmZWMgYW55d2F5
IGJlY2F1c2UgaXQgaXMgYSBjb3JyZWN0DQo+ID4gZGVzY3JpcHRpb24gb2YgYm9hcmQgZGVzaWdu
Lg0KPiA+IA0KPiA+IFRoaXMgaXNzdWUgd2FzIGV4cG9zZWQgYnkgY29tbWl0IGVmZGZlYjA3OWNj
MyAoInJlZ3VsYXRvcjogZml4ZWQ6DQo+ID4gQ29udmVydCB0byB1c2UgR1BJTyBkZXNjcmlwdG9y
IG9ubHkiKSB3aGljaCBjYXVzZXMgdGhlICJncGlvcyIgcHJvcGVydHkNCj4gPiB0byBhbHNvIGJl
IHBhcnNlZC4gQmVmb3JlIHRoYXQgY29tbWl0IHRoZSAiZ3Bpb3MiIHByb3BlcnR5IGhhZCBubw0K
PiA+IGVmZmVjdCwgUEhZIHJlc2V0IHdhcyBvbmx5IGhhbmRsZWQgaW4gdGhlIHRoZSBib290bG9h
ZGVyLg0KDQo+IFNvIHRoaXMgaXMgYSBmaXggd2Ugb25seSBuZWVkIHRvIGFwcGx5IGZvciA0LjIw
LXJjLCByaWdodD8NCg0KWWVzLg0KDQpUaGlzIGlzc3VlIHdhcyBleHBvc2VkIGJ5IGdwaW8gY2hh
bmdlcyBmb3IgNC4yMCBidXQgNC4xOSBSQ3MgYXJlIGZpbmUuDQoNCi0tDQpSZWdhcmRzLA0KTGVv
bmFyZA0K
