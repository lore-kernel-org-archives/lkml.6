Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CC321850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dfY5/5c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeLSLpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:45:12 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27873 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeLSLpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:45:12 -0500
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="22467829"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 19 Dec 2018 04:45:11 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 19 Dec 2018 04:45:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKfix1ZS/jZjuyOjWgi0eiq9HzP57/2Zhm1/mYw2MTg=;
 b=dfY5/5c2dKUoUzcFiPlEkmS+Dl+UYyVFIe19CBUasDh6bufX97nHku40u54lMSnVh5GGyEI6SSeZq3iE0Z5tH4KrUX+zWKBeezFiQqdbEBPWeKaSzs/pmYSlZj2BrPexI6pFfJECSTO4YPeuJfHWQjBjP7LilTC9gRndszC4Zuc=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2179.namprd11.prod.outlook.com (10.174.112.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 11:45:06 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 11:45:06 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <axel.lin@ingics.com>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH] regulator: mcp16502: Fix missing n_voltages setting
Thread-Topic: [PATCH] regulator: mcp16502: Fix missing n_voltages setting
Thread-Index: AQHUl3lCwjbraqyIiUKoORGfEssbl6WF8YwA
Date:   Wed, 19 Dec 2018 11:45:06 +0000
Message-ID: <3cc3ff18-e0e1-76e7-16ef-56b17831aa8c@microchip.com>
References: <20181219085804.9601-1-axel.lin@ingics.com>
In-Reply-To: <20181219085804.9601-1-axel.lin@ingics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::19) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2179;6:C5SWjfI7jno0/uU9auT8tcqAwL1eKNR2d5XKyJ4u4YXCR1heKyK49xxnbNFp0riI3nbCoW/YUnci28Sf0NfNM9peY9/KQCMSGO6MHEoPxhVOsU93f/AbH1vWl1CN46O9Nyx2NvWq8BnyRtl66WXAD3bbRNBpypSVKTa51Y9nYArpETEcHWFAym22AZdVugRqz+9pVEDGzue97OzoBGKtlVzKbXRuV+xQ/yHywrEFjMvXBgjLSXqT8t3t6qZzQ18acVCCXpmxB5PqFnSSD8koqjpLSaLxHvUObOgWAJP1+3Y5s1PBTqtaOlZCQaXsp6Ya55WWQ0F2v5d/RfR1SRnJDBv/xclG9d6f3kPWlog2XNrxYXRqqDt4yvyNXf518NPq8ZVyTxB/TFT8WGoly80possTe/Zdx1u1NVEorxi7f2DRz4b1nDgSUV4Rb87mO6pkd1voV3OZupbf6ZG02EYXYQ==;5:wuTOpXqG4K1g48BgWfX4Q7H/iCYnUuBpK49eCIP4QmbQXMSAybf4naiL1SEIEX7PPz8FsdOJAX4pDlJLylh8ngmRPNRZn6eyarx1Gt1DA/GdV7HKLNL4fN75J1Axo4tB8BmcJhUJknT29j+FCAAcVVizZz38eYOYgwOotmJ4XqQ=;7:6Q3nKRp4eFtwRxHBzOzis5+1cl9uwDVgHPIYx7ECbBp2ipCU2uUkxGkZlqn2/hyT/OYXtDTluf02UJhVh+AIA5AgOU4JYnoYUKUWIRAdwjhky7BQajvPWsCzrG/agR0EZHdC2821l4YucOblzDCqYg==
x-ms-office365-filtering-correlation-id: 1b777156-9f35-4b6d-aec7-08d665a76bed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2179;
x-ms-traffictypediagnostic: BN6PR1101MB2179:
x-microsoft-antispam-prvs: <BN6PR1101MB2179F21E803AB88FB95464D0EDBE0@BN6PR1101MB2179.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2179;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2179;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(446003)(99286004)(478600001)(102836004)(186003)(71200400001)(76176011)(6512007)(72206003)(36756003)(6486002)(26005)(71190400001)(2906002)(97736004)(486006)(81156014)(106356001)(256004)(105586002)(6116002)(86362001)(8936002)(54906003)(8676002)(53936002)(53546011)(31696002)(14454004)(110136005)(6506007)(386003)(81166006)(345774005)(31686004)(316002)(39060400002)(5660300001)(25786009)(3846002)(7736002)(52116002)(6436002)(305945005)(476003)(11346002)(66066001)(107886003)(4326008)(68736007)(2616005)(6246003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2179;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 02F1Xt7/vm9Yc5RFZZX4AIhdKZ+McrYKFZoMQIWLxmQ7FqexIB/17H5BJ4zQya8IHANAzoFAafSvfOwi2lj00DevIS0CIqb3NO+rWs0YcPj8dURGuRj50ofIAH5WLdX2XDI35ReUmpToo+Zi4qohM8WfX0S1IkGOr/78f9grZFytD9283bid7aWCh7viY9j3f2dRxH1TF1XcfKM4nXR5QHgiFnITYeqYIhnK/lzcMzgyX9H5KD+vrXgpTPw4PcaVlDBJIIyELjTJB9iBKl1H5U4OCsgwQKMBUO5aX5/nMSmPN6WkvmJQfabAUSX+q4IV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDC9516A5E8E7845BB4667462D5730EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b777156-9f35-4b6d-aec7-08d665a76bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 11:45:06.6728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2179
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXhlbCwNCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghDQoNCkhvd2V2ZXIsIHRoZXJlIGFy
ZSBub3QgTUNQMTY1MDJfVlNFTCArIDEgdm9sdGFnZXMsDQpidXQgVkREX0hJR0hfU0VMIC0gVkRE
X0xPV19TRUwgKyAxICg9NTEpLg0KDQpCZXN0IHJlZ2FyZHMsDQpBbmRyZWkNCg0KT24gMTkuMTIu
MjAxOCAxMDo1OCwgQXhlbCBMaW4gd3JvdGU6DQo+IFRoZSBuX3ZvbHRhZ2VzIHNldHRpbmcgaXMg
bm90IHNldCwgZml4IGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5A
aW5naWNzLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9yZWd1bGF0b3IvbWNwMTY1MDIuYyB8IDEg
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9yZWd1bGF0b3IvbWNwMTY1MDIuYyBiL2RyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAy
LmMNCj4gaW5kZXggMjVkN2I0MzNmYWZkLi5lYzViNjgzNmEyMGMgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmMNCj4gKysrIGIvZHJpdmVycy9yZWd1bGF0b3IvbWNw
MTY1MDIuYw0KPiBAQCAtOTAsNiArOTAsNyBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG1jcDE2NTAy
X29mX21hcF9tb2RlKHVuc2lnbmVkIGludCBtb2RlKQ0KPiAgIAkJLm9wcwkJCT0gJihfb3BzKSwJ
CQlcDQo+ICAgCQkudHlwZQkJCT0gUkVHVUxBVE9SX1ZPTFRBR0UsCQlcDQo+ICAgCQkub3duZXIJ
CQk9IFRISVNfTU9EVUxFLAkJCVwNCj4gKwkJLm5fdm9sdGFnZXMJCT0gTUNQMTY1MDJfVlNFTCAr
IDEsCQlcDQo+ICAgCQkubGluZWFyX3JhbmdlcwkJPSBfcmFuZ2VzLAkJCVwNCj4gICAJCS5uX2xp
bmVhcl9yYW5nZXMJPSBBUlJBWV9TSVpFKF9yYW5nZXMpLAkJXA0KPiAgIAkJLm9mX21hdGNoCQk9
IG9mX21hdGNoX3B0cihfbmFtZSksCQlcDQo=
