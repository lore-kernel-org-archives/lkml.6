Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B494C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC58C20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="USyS9cwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC58C20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJMVLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 17:11:37 -0400
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:11632
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbeJMVLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 17:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8m/8kKJ5N0iT+fv5TrhYPceo1FnCEIb2JLs6qLPUzM=;
 b=USyS9cwAgvP1mavQued7usdz4uFt1Bg/XW1Oc80pzK24tszJntNYhNdqaJ6ChBIsaoPHRBdUmYeMqzeyTl8X3/0PwVv+t872DnYEO+DI72xFaAMAx3kehNZ1TxqMztjD665OO0lMnlkw4GdKnvsYQYdBfI8a5GfaUB/vqp14duo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5060.eurprd04.prod.outlook.com (20.177.40.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Sat, 13 Oct 2018 13:33:54 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1%3]) with mapi id 15.20.1228.020; Sat, 13 Oct 2018
 13:33:54 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: RE: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Thread-Topic: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Thread-Index: AQHUQOYAqzg0fl5c6km76P92aepQ6qTin9AQgBBfjVCABM4uAIAAv5kggBzYKaCACAuTYA==
Date:   Sat, 13 Oct 2018 13:33:54 +0000
Message-ID: <AM0PR04MB4211DBDC8D0684442A927CE580E30@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211EF6D783562BA8C8D690380010@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211A3900BC5A2DF857F7451801F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <7e612f6f-e9d2-2f6f-1903-3a6bcf1b65ba@linux.intel.com>
 <AM0PR04MB4211B170CAC1B3F9E7356AF980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB42119BD28DDB7826DEE577F180E60@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42119BD28DDB7826DEE577F180E60@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5060;6:nM+WUeNYZamMZCDeaBABPRyIXPz/KgxGHi7Qz2zfVLayqFM31LgDg8Px2++4pDKLL2YxXgNvrvFFfzsUHnpEsREGqUweIkI8gBLvqQXPosSc6iChLbg4oQGu0KQsaUqDzUM02uUS/oeKprA9SOwrC08IL4Np32hHrguKrvi1NjfYMCTB6ytA3jnctsR/jHdg38y5YLOUtccmhRYTc8388I4rzwfdHT8gSnA9ySNCANUIxhRKCZyZ6lzzTjaE1L2vSxFK/edjx1wanx2KFlEBjMDjeAIzLb7sOU9THA+Jp1o/ZFYvl9Lo+pG/o7qzAimNz0C5t8J0HHYwhHiN6BuOw5hrCx5ILJuNTiClRfF2nGN+0tOtW1vgGHT/y/6KyZj+lZs4hEzpZezNjvcE8quvGVbPNK4yintdaZJ3LWmZ8k1TEnx/9uf7bvk4iXXIcct2k/lZyiPXHsQLwYUaxadFgQ==;5:rBA5U7RSzPYm90Gy5PDsbm31AlSZFCIX0pYx2wU8swOsjM4KJXab26nIZUH6XtHfyQOWTg7WM5n9Um+I9qO/1JDVRk1qSb9jfKfjvyA0HLXVeKlL2P4M78gDjsvI7SBJBmUnUENmRFtT5l5oslk5IKf2vN0sY7/qlP4eUusBTrE=;7:v7WjPclYx9w8jRnJseRa3FCQUflkWuaRIOTDF+qpz8abh7MAFipUcqtgBy7shaKBDMGlof0LN9Q+f+0yox5YJdi1b+nTZIkrRx8CbV5bfycLKErOFJRaXLogbkh8HhavkPt8pfGISRndIDnWx7QjbMMJA930c73NZv9lASh7xEj7gyg9BDb1KkTKjaHr9dZf1NvwnBt9cxlrBBKKmkE2Qr/fH+wvagifSMRYu+yOIUTRcF3tRvbrtCFUofotamxt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b3ced4ec-1761-43b5-a83c-08d631108515
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5060;
x-ms-traffictypediagnostic: AM0PR04MB5060:
x-microsoft-antispam-prvs: <AM0PR04MB50604526C764BA4FE43E92B680E30@AM0PR04MB5060.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(9452136761055)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR04MB5060;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5060;
x-forefront-prvs: 082465FB26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(366004)(346002)(199004)(189003)(13464003)(86362001)(2201001)(68736007)(8676002)(3846002)(54906003)(6116002)(97736004)(5660300001)(106356001)(105586002)(102836004)(110136005)(8936002)(256004)(33656002)(71190400001)(14454004)(71200400001)(2906002)(478600001)(81156014)(81166006)(55016002)(25786009)(9686003)(4326008)(53936002)(74316002)(6436002)(11346002)(229853002)(6246003)(316002)(305945005)(99286004)(7736002)(26005)(76176011)(486006)(186003)(2900100001)(93886005)(2501003)(476003)(446003)(5250100002)(66066001)(7696005)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5060;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yhn7//pbBwlwnU36kzCCItTVgW2Lk3ekHc7GadEZ4VtFpoag+QthqOW4Dw0D63Ywa3acMx8eLXT52kLSKPvx6sWPhFMLPKxha+kS5f4MNvgTfVKhuf4aZ6MxDRk5r7Aed9n/TcM0xqy5MgqJ9kbYb/SxC9K2wHPGb+9Ge0umsg9NiJg7VNitBA85mSSnmBf4o0PWZhtuxSWSbmnI+aP1T9iEoUK2Pnv9bInmJieriEm3HAoyncqDPSrR3oTKz7HPejzmZecgdWVtppLD9p31/6fXILRyqhAr1uTTC4AcenVtIMXtF94oS+0e8POvQ8y5x5IXXAehlqiWkzDuaXu1rb3p57Rt+SRYZAugSr55DLM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ced4ec-1761-43b5-a83c-08d631108515
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2018 13:33:54.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEEucy4gRG9uZw0K
PiBTZW50OiBNb25kYXksIE9jdG9iZXIgOCwgMjAxOCA2OjQzIFBNDQo+IFRvOiB0aG9yLnRoYXll
ckBsaW51eC5pbnRlbC5jb207IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IHNib3lkQGtlcm5l
bC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBoZGVn
b2VkZUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjYgMC80XSBjbGs6IG5ldyBB
UElzIHRvIGhhbmRsZSBhbGwgYXZhaWxhYmxlIGNsb2Nrcw0KPiANCj4gSGkgU3RlcGhlbiwNCj4g
DQo+IEdlbnRseSBwaW5nIGFnYWluLi4NCj4gDQo+ID4gPiA+DQo+ID4gPiBKdXN0IGNoZWNraW5n
IG9uIHRoZSBzdGF0dXMgb2YgdGhpcyBwYXRjaC4gVGhlIGNsb2NrIHJvdXRpbmVzDQo+ID4gPiAo
cGF0Y2hlcw0KPiA+ID4gMS0zKSBhcmUgdXNlZnVsIGZvciBvbmUgb2YgbXkgZHJpdmVycyBidXQg
aWYgdGhleSBhcmVuJ3QgYWNjZXB0ZWQgb3INCj4gPiA+IHdpbGwgdGFrZSBhIGxvbmcgdGltZSB0
byBiZSBhY2NlcHRlZCwgSSdsbCBuZWVkIHRvIHJlZmFjdG9yIG15IGRyaXZlci4NCj4gPiA+DQo+
ID4NCj4gPiBUaGFua3MgZm9yIHRoaXMgaW5mb3JtYXRpb24uDQo+ID4NCj4gPiBTdGVwaGVuLA0K
PiA+IFdvdWxkIHlvdSBoZWxwIHRvIHByb2NlZWQgdGhpcz8NCj4gPg0KPiANCj4gUmVnYXJkcw0K
PiBEb25nIEFpc2hlbmcNCg==
