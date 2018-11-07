Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C32C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F212B2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVgQyiM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F212B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbeKGKUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:20:22 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:50816
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388387AbeKGKUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td+j12mi2+Ypq44SE0MqwHM7IIRG42z8GJ3eWcm1UeE=;
 b=OVgQyiM1x0CQ2mBckpyaMZFUw6Wi8rAi11skVm+MmiHghUVF/TFD40YG8ziF+dDzMJLXyagyNKZSQMd6NzAxcfp9NwOparMLl4PiLIG6XRnvx0yxLXa+p38AmiPG5/CY3ViwpcfwNUNP9QiahdN2dub4jvrtPw2yaWE1Kxc3S2g=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5198.eurprd04.prod.outlook.com (20.177.51.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 00:52:19 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::7171:60a1:df37:6ed6]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::7171:60a1:df37:6ed6%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 00:52:19 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] clk: qoriq: add more chips support
Thread-Topic: [PATCH v3] clk: qoriq: add more chips support
Thread-Index: AQHUcO5i0ZTMlhMFCUux5XPhzhajt6VDCWgAgAB7WkA=
Date:   Wed, 7 Nov 2018 00:52:19 +0000
Message-ID: <VI1PR04MB433328F4F568ED75019B2091F3C40@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20181031074616.24412-1-andy.tang@nxp.com>
 <154152509666.88331.15573532526011434275@swboyd.mtv.corp.google.com>
In-Reply-To: <154152509666.88331.15573532526011434275@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5198;6:EUO8A9/9kOjJriE9VY0pE4v9u66I8oTqHQqdzp3OwCIRhzj0zDLPUO070TrFU6qiXFf4+pLc72olzSrzP0mXpEHz2mkmNwD+6m4ECzmWZ/c7WFUd34g387nls2BLmDxxgTVMxAyKm1lrLa7LFuXm8sLqPvViwiAqblmIiEq1koLWIDkyEaMyiI8MgbVLIMarZ3YE2fizCFsreTUmXFivufIX1V93aReN8Anaz6nFhfanPbjidZABCA+6a2jzBtCRhf3O7Gxs65Ejb6KejmOxQICwZsLdRCDSpwXAB9TaKLBh76LF3O3l5Qm1DhNbDAa++EzOxAbJTRfS0YDvvhRlkR3lPn4C3LDY38e5cF0FSdk7XOaRMZeDrIK3weEj14s2h+D6H6QO3O1YwOtukLWtZcwCSSvXIg4sdJfHyun4BnP2+7dEWsCsuvPjkvJdQsmTkkOO3kJuxFxMcZWde6NWZw==;5:NRVyS5o/x7uklgoFb6h9ZjZYhbUL2PaMSs7mIdT41fs6d/gIBJ/dGR1+LRp0r95eWlpC0XeNwfyEXcIiJp4RaSLKKW9pJQjM4srQtT2DAw07T0sY0EJ1m4aj2OvGtL1uasp/em1zDss8bddo8ztgKO0gpWH59I41guU12vuBxXA=;7:WZBdhYRHJcQq2v+Jg5ixn9BzwsaM3Pi1OHmDdHD4Ii749ZDQgYTEYtvA2730aYZSnX6gMgQvIqyZXzvlXYCiv/4nNOJkjE6gR27c1/VKVlvMFI3D3Bp+Bse5OaGO+NZo0c0xk6ukXvvxipz7q0/guA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bb24af27-ddc3-4dac-09ba-08d6444b4585
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5198;
x-ms-traffictypediagnostic: VI1PR04MB5198:
x-microsoft-antispam-prvs: <VI1PR04MB5198EACCFEC4E4BA87E206ADF3C40@VI1PR04MB5198.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5198;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5198;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(13464003)(189003)(86362001)(71200400001)(2501003)(9686003)(11346002)(74316002)(7736002)(305945005)(446003)(2900100001)(25786009)(316002)(55016002)(6246003)(486006)(54906003)(110136005)(53936002)(478600001)(44832011)(4326008)(14454004)(256004)(476003)(66066001)(229853002)(71190400001)(6436002)(8676002)(106356001)(186003)(8936002)(2906002)(53546011)(102836004)(5660300001)(81166006)(81156014)(105586002)(26005)(33656002)(6506007)(4001150100001)(3846002)(6116002)(68736007)(99286004)(7696005)(97736004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5198;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TSoQahVbdgK2h6EtRD0Ywp1OzEOzafjxlgQ+9QrL/iAIqcyT+LEVjQ/ap+UeCjqXT/cA6GN3sR+o2CkSPc/0GFQ10+pmhnqHHHJTUW6F27gdIviGNqbsd9cHA/BaLHq+Cr5kR8473nEdSAELvhh9RXQYFA1aZ1OVmD3jRozvn8ib+oT+oVDOfAdC8GY/YZZDY+spPx6qRf3atQzHQ8y/3Sgqz/5ipMhmDFxhsS0J2bSYDVo6Gx9ZvzZ4Da/NigZ5RhR1kE3dCWWpwWvl4YJYGXmenaEsIeI334G4MNpKjl6zAWqhPA7HMUzjoBEewozAwDrghRjbfO225Vz8RSRsZntlhp/3Ec3pTD6bBxrtDCk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb24af27-ddc3-4dac-09ba-08d6444b4585
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 00:52:19.7775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTjlubQxMeaciDfml6UgMToy
NQ0KPiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT47IG10dXJxdWV0dGVAYmF5bGli
cmUuY29tDQo+IENjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBBbmR5IFRhbmcNCj4gPGFuZHkudGFuZ0BueHAuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzXSBjbGs6IHFvcmlxOiBhZGQgbW9yZSBjaGlwcyBzdXBwb3J0DQo+IA0K
PiBRdW90aW5nIFl1YW50aWFuIFRhbmcgKDIwMTgtMTAtMzEgMDA6NDY6MTYpDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jIGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMg
aW5kZXgNCj4gPiA0YzMwYjZlLi41YmFhOWUwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xr
L2Nsay1xb3JpcS5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMNCj4gPiBAQCAt
MTQxOCwxMiArMTQxOCwyMyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgY2xvY2tnZW5faW5pdChzdHJ1
Y3QNCj4gPiBkZXZpY2Vfbm9kZSAqbnApDQo+ID4NCj4gPiAgQ0xLX09GX0RFQ0xBUkUocW9yaXFf
Y2xvY2tnZW5fMSwgImZzbCxxb3JpcS1jbG9ja2dlbi0xLjAiLA0KPiA+IGNsb2NrZ2VuX2luaXQp
OyAgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fMiwNCj4gPiAiZnNsLHFvcmlxLWNsb2Nr
Z2VuLTIuMCIsIGNsb2NrZ2VuX2luaXQpOw0KPiA+ICtDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9j
a2dlbl9iNDQyMCwgImZzbCxiNDQyMC1jbG9ja2dlbiIsDQo+ID4gK2Nsb2NrZ2VuX2luaXQpOyBD
TEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9iNDg2MCwNCj4gPiArImZzbCxiNDg2MC1jbG9j
a2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KPiA+ICBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dl
bl9sczEwMTJhLCAiZnNsLGxzMTAxMmEtY2xvY2tnZW4iLA0KPiA+IGNsb2NrZ2VuX2luaXQpOyAg
Q0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHMxMDIxYSwNCj4gPiAiZnNsLGxzMTAyMWEt
Y2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9j
a2dlbl9sczEwNDNhLCAiZnNsLGxzMTA0M2EtY2xvY2tnZW4iLA0KPiA+IGNsb2NrZ2VuX2luaXQp
OyAgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHMxMDQ2YSwNCj4gPiAiZnNsLGxzMTA0
NmEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiBDTEtfT0ZfREVDTEFSRShxb3JpcV9j
bG9ja2dlbl9sczEwODhhLCAiZnNsLGxzMTA4OGEtY2xvY2tnZW4iLA0KPiA+IGNsb2NrZ2VuX2lu
aXQpOyAgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHMyMDgwYSwNCj4gPiAiZnNsLGxz
MjA4MGEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiArQ0xLX09GX0RFQ0xBUkUocW9y
aXFfY2xvY2tnZW5fcDIwNDEsICJmc2wscDIwNDEtY2xvY2tnZW4iLA0KPiA+ICtjbG9ja2dlbl9p
bml0KTsgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fcDMwNDEsDQo+ID4gKyJmc2wscDMw
NDEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiArQ0xLX09GX0RFQ0xBUkUocW9yaXFf
Y2xvY2tnZW5fcDQwODAsICJmc2wscDQwODAtY2xvY2tnZW4iLA0KPiA+ICtjbG9ja2dlbl9pbml0
KTsgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fcDUwMjAsDQo+ID4gKyJmc2wscDUwMjAt
Y2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiArQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xv
Y2tnZW5fcDUwNDAsICJmc2wscDUwNDAtY2xvY2tnZW4iLA0KPiA+ICtjbG9ja2dlbl9pbml0KTsg
Q0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fdDEwMjMsDQo+ID4gKyJmc2wsdDEwMjMtY2xv
Y2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiArQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tn
ZW5fdDEwNDAsICJmc2wsdDEwNDAtY2xvY2tnZW4iLA0KPiA+ICtjbG9ja2dlbl9pbml0KTsgQ0xL
X09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fdDIwODAsDQo+ID4gKyJmc2wsdDIwODAtY2xvY2tn
ZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiArQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5f
dDQyNDAsICJmc2wsdDQyNDAtY2xvY2tnZW4iLA0KPiA+ICtjbG9ja2dlbl9pbml0KTsNCj4gDQo+
IFNvbWUgb2YgdGhlc2UgY29tcGF0aWJsZXMgYXJlbid0IGRvY3VtZW50ZWQuIFdoYXQgaGFwcGVu
ZWQgdG8gdGhlDQo+IGJpbmRpbmcgcGF0Y2ggdG8gYWRkIG1vcmUgY29tcGF0aWJsZSBzdHJpbmdz
Pw0KTm90aGluZyBoYXBwZW5lZC4gQmluZGluZyBwYXRjaCB3aWxsIGJlIG1lcmdlZCB0byBQb3dl
clBDIHRyZWUgc29vbi4gQnV0IGl0IHdpbGwgdGFrZSB0aW1lIHRvDQpnZXQgdG8gbWFpbmxpbmUg
dHJlZSBvciB5b3VyIHRyZWUuDQoNCkJSLA0KQW5keQ0K
