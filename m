Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83B721722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ulqgB1hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83B721722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeH0H1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:27:42 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:61312
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeH0H1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaKg+lynZgjYBl0wRMHyI0lI54GxkYdVRMv5VzPHkbA=;
 b=ulqgB1hDz2kmmApf1tX9LJmLObVMn6YHNNccipr/NVtIx5M4ef24DB0XCbl/QLzApAvbMN4Y+k3usvJuvr921uE39HNfz8gud86lcWXa6bQ4Al3Hsl+EVsrHshQ4G87KXgLytF4T2xxW+EmQVvY8QVkJ6FDH04sCKrfNEDfssp4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4514.eurprd04.prod.outlook.com (52.135.148.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 27 Aug 2018 03:42:52 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290%3]) with mapi id 15.20.1080.015; Mon, 27 Aug 2018
 03:42:52 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH V4 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUHpzNbEQ50bW8r0K17gNet3HqL6Sgx+QwgBT4Y4CAHXAhEA==
Date:   Mon, 27 Aug 2018 03:42:52 +0000
Message-ID: <AM0PR04MB4211EB200D335FCEC382BD0E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <5a5950a4-e164-a604-ccb4-ae6d5bbe1708@baylibre.com>
In-Reply-To: <5a5950a4-e164-a604-ccb4-ae6d5bbe1708@baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4514;6:wbzeIjkNPHbR7vvErhm1KsLN5q02sNHd8hNuT2VC/Bob4tm31GQ+ZGEp+LaqK8m/Tgl4dzkdsB0r5jT0tAsaRRXyXHu3CZxaBwHgU4ybZSgIAsaztEi7RX72oSba7i7XRpFySkTv+vO7A4jS4/05Gu3L3eLlzCZdDl4D1HrVCfZ1AQ6lSreTVmYXFMqFisJE6YXh63Uy6eMVV5nfGzFDE5dpH0MGWk/SwQ+9ne9F+RqrcYDxKSr4db7+4UnHEsBAGwSq55D3D26UmC7muooJlHFPosGQjl0Yv+7wB9Zj1QJFUc6gDgNTEEsnkS4+5pFXnWHXdqusBJdzPYVKXhr/QyZrzSFsGG5D/z3FEdsPO+JtKSDu/+mYj5lOb3WKKHcJJNgjLFcedwwM/uCnEjwUZS4WYcCQ9EOWRWezvjBIESwgSJqQzUFR9awwiaDF+CBiAQSydLdbaE6jukdm8VZJkQ==;5:dwMyxRcwngvIOj1aM17oU0ewV8oPhTwi5AcfMM94W8UgUM9O8e1IAU6/31BDgY6TyaMxcuJ/+P73VsEH4XILquYEo5Wosi6ukx811pHJMYRCO4SvejKeqzDE53BR+L2KswFyn6RKV0r2m9cZAPPoUrLgedQefFBqjyLORD55d3M=;7:VUHtWruM05nnEWa6C0O2UbTq5f21n5VDzcSrbAt8BGJHWik5O5MSpTQWZxpPLS6Y6uW0KJPb+yQZ8fnW/fj5MP2NTmdFk1x29XGNzFQyvBTVhbwRlLUDaH8ftV94fCr11eYuVkt/B9QA7FlRYq7rOLIWJ4uYJ6RXU2aWI/G1Do5vZ0U/zilB3qUFEovzCUHgn62wz4kg2DHuYAXY64YPNYnOmRQuBVPCJ+YnCtQ9EiCWvEcALgBtz0M/XAdIddJq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: be1c4447-f270-44d9-6990-08d60bcf2ab8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4514;
x-ms-traffictypediagnostic: AM0PR04MB4514:
x-microsoft-antispam-prvs: <AM0PR04MB451494F86A2EBC8357A120D7800B0@AM0PR04MB4514.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR04MB4514;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4514;
x-forefront-prvs: 07778E4001
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(13464003)(189003)(199004)(6506007)(53546011)(8936002)(110136005)(68736007)(54906003)(102836004)(478600001)(186003)(2906002)(81166006)(81156014)(53936002)(86362001)(9686003)(14454004)(55016002)(2201001)(7736002)(6116002)(4326008)(446003)(11346002)(25786009)(3846002)(7696005)(99286004)(2501003)(316002)(8676002)(5250100002)(2900100001)(26005)(6246003)(256004)(14444005)(105586002)(476003)(305945005)(97736004)(76176011)(6436002)(486006)(74316002)(66066001)(106356001)(5660300001)(229853002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4514;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vdvZuJ21E6FmeEBJRlifFPfHflaEF/aHnTLTLxxlts88Opf7HQiiv4E2+wyGzE4OzirdODZZypmmwVH06LENlqrFMb6v+yFLlZoS89IAdjc0p/vlsY9SJ5/REnW+GNNTnf04bS47EwD4qKKDGjsuqX3kAS+S50fd1pd11fFK1IGh2QySOHtVK2teQJ9nHeclhoAPf7/Y85itHHCY5CLNX0zrkMD7DMv/nJilSQOjwN23KqZq1/Auqbob+CeB5GV+Fhag8ZtU8ZRdfN1Lse2uTh2RnFpif52e22+S5EvWL4NwzLZX+L0+4imTZ/dEr6uPb1kaBWhrZvT4kW6tGHWNjOKlGctvR36h3iFXhue9uHU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1c4447-f270-44d9-6990-08d60bcf2ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 03:42:52.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFs
ZXhhbmRyZSBCYWlsb24gW21haWx0bzphYmFpbG9uQGJheWxpYnJlLmNvbV0NCj4gU2VudDogV2Vk
bmVzZGF5LCBBdWd1c3QgOCwgMjAxOCA2OjAxIFBNDQo+IFRvOiBBLnMuIERvbmcgPGFpc2hlbmcu
ZG9uZ0BueHAuY29tPjsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gc2JveWRAa2VybmVs
Lm9yZw0KPiBDYzogSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgQW5zb24gSHVhbmcgPGFu
c29uLmh1YW5nQG54cC5jb20+Ow0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDAvOV0gY2xrOiBhZGQgaW14N3VscCBjbGsg
c3VwcG9ydA0KPiANCj4gSGkgRG9uZyBBaXNoZW5nLA0KPiANCj4gT24gMDcvMjYvMjAxOCAwMzo1
MCBBTSwgQS5zLiBEb25nIHdyb3RlOg0KPiA+IEhpIFN0ZXBoZW4sDQo+ID4NCj4gPiBEbyB5b3Ug
aGF2ZSBhIGNoYW5jZSB0byBsb29rIGF0IGl0Pw0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGhhcyBi
ZWVuIHBlbmRpbmcgZm9yIHF1aXRlIGEgbG9uZyB0aW1lIHdpdGhvdXQgbXVjaA0KPiBjb21tZW50
cy4NCj4gSSdtIG5vdCBhIGtlcm5lbCBtYWludGFpbmVyIGJ1dCBJIHdvdWxkIG5vdCByZXZpZXcg
YSBzZXJpZXMgdGhhdCBoYXMgY2hlY2twYXRjaA0KPiBlcnJvcnMuDQo+IFBsZWFzZSBydW4gY2hl
Y2twYXRjaCwgZml4IHRoZSBlcnJvcnMgYW5kIHRoZSB3YXJuaW5ncywgYW5kIHRoZW4gcmVzdWJt
aXQgYQ0KPiBzZXJpZXMuDQoNClllcywgSSBkaWQgaXQuIFRoZXJlJ3JlIHNvbWUgd2FybmluZ3Mu
IEJ1dCB1bmxpa2UgZXJyb3JzLCBub3JtYWxseSB3YXJuaW5ncyBhcmUganVkZ2FibGUuDQpGb3Ig
dGhpcyBwYXRjaCBzZXQsIGFsbCBrbm93biB3YXJuaW5ncyBzZWVtcyB0byBtZSBub3QgbmVlZCB0
aGUgZml4LiANCkUuZy4gbGluZSBvdmVyIDgwIG9yIG1pc3NpbmcgbWFpbnRhaW5lciBmb3IgbmV3
IGZpbGVzLi4uLg0KDQpCVFcgdGhlcmUncyBvbmUgc3BlY2lhbCB3YXJuaW5nIEkgZG9uJ3Qgc2Vl
IGhvdyB0byBmaXgsIHNlZW1zIHJlcG9ydGVkIHdyb25nbHkuDQoNCjAwMDUtY2xrLWlteC1hZGQt
Y29tcG9zaXRlLWNsay1zdXBwb3J0LnBhdGNoDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShz
KSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPw0KIzQ3OiANCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQoNCldBUk5JTkc6IGZ1bmN0aW9uIGRlZmluaXRpb24gYXJndW1lbnQgJ2NvbnN0IGNo
YXIgKiBjb25zdCcgc2hvdWxkIGFsc28gaGF2ZSBhbiBpZGVudGlmaWVyIG5hbWUNCiMxNDU6IEZJ
TEU6IGRyaXZlcnMvY2xrL2lteC9jbGsuaDo3NDoNCitzdHJ1Y3QgY2xrX2h3ICppbXhfY2xrX2Nv
bXBvc2l0ZShjb25zdCBjaGFyICpuYW1lLA0KDQp0b3RhbDogMCBlcnJvcnMsIDIgd2FybmluZ3Ms
IDEwNCBsaW5lcyBjaGVja2VkDQoNCk5PVEU6IEZvciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZl
Y3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvDQogICAgICBtZWNoYW5pY2FsbHkgY29udmVy
dCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLg0KDQpJ
ZiB5b3UgaGF2ZSBiZXR0ZXIgc3VnZ2VzdGlvbnMgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQpSZWdh
cmRzDQpEb25nIEFpc2hlbmcNCg==
