Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F875C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4762070C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gq7wVnmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437066AbfBNLjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:39:52 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:54266 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406014AbfBNLjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:39:52 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="23850715"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 04:39:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 04:39:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icoHS7kOy+N3XDf/9tL3+GTegwVoHTd2ZHGywEYycNg=;
 b=gq7wVnmtO8DIwutjiLXR5RozCAbxrDwTm8rmdrRSt5qiIw88O9YVOxxBTpAJTtyz4B1q5ec9qP3rCN8YIt1pRoNQLnS0PLeiKEHFFHkafIqSCufyA8YVfGXj179EyWo8IGYWgwfDwMpHXAX4TaASmIYTXyrxFa6jlYIp89QfKcw=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1614.namprd11.prod.outlook.com (10.172.54.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 14 Feb 2019 11:39:40 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 11:39:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] add slow clock support for SAM9X60
Thread-Topic: [PATCH 0/2] add slow clock support for SAM9X60
Thread-Index: AQHUxFGUN1PJs+Pmjka0w9X3F9luyKXfK0CA
Date:   Thu, 14 Feb 2019 11:39:40 +0000
Message-ID: <0d330ff8-e8f4-d157-299c-da181be4a0fd@microchip.com>
References: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0163.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::11) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190214133929439
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09935411-fdef-4058-709d-08d692711ae7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1614;
x-ms-traffictypediagnostic: MWHPR11MB1614:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxNjE0OzIzOjM5eGs0UVJTSlMvNnVpRmJFTisreGNtZlFF?=
 =?utf-8?B?dGs2NllZbFVtaHYyRTZmVkxveFFCd2d2QjljS25KVnVVOWVSajlNSzJGSWhz?=
 =?utf-8?B?cDU4aXhaM0FxUmNUbUt6bHZqTnFuYUtBS2svRE1jM01jdWZuelRZdzNQaC9i?=
 =?utf-8?B?ZXF4Rmg5M0pBSW1heklmbDgzQ1EzYndLbWpHWHRoU09nN2hDU0tWTHhsaHBS?=
 =?utf-8?B?M2JBRjI5NHV6bm1FcXZSa2JZVW1CWjhNK3VRVkVkaEhqWkFBbUR4QmNuOEp1?=
 =?utf-8?B?T3pSeEpsVHZhMy95dE93cENGZCtSUWZYYWxzeWZCVytHOFVtR3VOWmdic1NI?=
 =?utf-8?B?ZG1kUHZkelVFZ1ZWYUh0WXFZUnR3NEZ0dlRDZ2JBNmZBY3hySEQwbkc1K3lR?=
 =?utf-8?B?bExFaEc2c2xJeDhraTJyVXBwd3VXbVdHMC9IaXZDYitXSmdEOFJXcEFvQ21a?=
 =?utf-8?B?U2FQVWNsSGx1NFZza05BZjFGR0tLWFNVbHFNTG8rNTJtRG9ESUh1VXIxWEdJ?=
 =?utf-8?B?VEYrb084aWZyVzc3QU9uQllNamdkQjVzZDUyRXZ6aFVPcHIrT1Q2YVROSmNU?=
 =?utf-8?B?OGtwaXc5R2dpRTNyV1lyY0tpTnRONFVRUjNwNkk5ZGlCcVFXcUhGWFF5ZENu?=
 =?utf-8?B?U3ZXb1VteDlPNFFiUVJzYUVUUmt3V2p6TnpadFhTdWhNaTZVUnh2V09DY1BQ?=
 =?utf-8?B?ZlFCVmRkRXM1ZTMrWWhUZ1BmK1lzWnhmc2Z6cjZkbThJM20wM0ExYTNVbGZX?=
 =?utf-8?B?dDB2S25vZUozckRqMEhuZittWkZhN2VQV2t4am5xYmNnMWJIRUhVenpLSjR5?=
 =?utf-8?B?VjQxdDVuVXoyaHlscGp0SE9panNjMFNWK3VDWStkS09jUDVWZEdCRDdzZDRZ?=
 =?utf-8?B?RnRlWXNxOUhRTnhhK3QrNkRjVUc5NVFUbXVKRS9jSDdWQkNHc29rYmhacnlS?=
 =?utf-8?B?ckNVZFZ1Z2I2Wk81dUpKZTV5UDlWbTlpUlVwdi82eXlDNzVXa2VTR0R6ai8w?=
 =?utf-8?B?cGpzb1V5aVU1RmJReEhjNHNFbEV2TU5FUkpjWi9PZjZuZVZNUVMrT09CQnNR?=
 =?utf-8?B?bUFuMmR5MHJ4V3dhOGpESnFvWFlwa0thZTNhUHQ5OFJLVit6U0hoM1lMdVVw?=
 =?utf-8?B?aHhUcjBVbzhwMUlrdVIxTCtpb3VoZ25NbXJsME41d1JtYVNPWDNUblRmMXBE?=
 =?utf-8?B?QlhVVWtSQmNEK0tOYW95dEFoVGxKVW5UVHV1d0duYkFPSnIyK1MyTThMeHla?=
 =?utf-8?B?YVZpNmRhRUlFQnNDVlBwNUc1dkFhSkpJU3krZkpPSEpFTlM5dWttdkpNNDFs?=
 =?utf-8?B?c1FkSDI4RzJmUTFubkFmcEhGaVIyYmx2YUZCOWtSUjBKMDhDU0Z3Zi9qamxG?=
 =?utf-8?B?Sk13VTBjNDdsL1JWUnovYmFGWXd3Q3ZXZGdYZCttbUJmS0hwWFUxVlc4ajgx?=
 =?utf-8?B?NEV6eTU5WUUzd0ZyS2NyYlZObGJFQytCc2pzUGs0dDR1Q0hteE1OQzhvWXlO?=
 =?utf-8?B?bXF6dktiZ2NyNUtGZkI2RFVhRjMxekJPbzFtNlVqejFnalozb0M3YllDem42?=
 =?utf-8?B?U3V4Q3NwVklDcG1ja0xZb3FnNktZUzEvNnNIdDFnOGV4YW5HQVo2VjF3US91?=
 =?utf-8?B?cVFCUnpYSnhodUhnVnJEV3FaQ3d4M1FOeEMxUVdmR3FlZy9hN2NOTVJFTVo1?=
 =?utf-8?B?VmlIUFRadkM0c0diNnNQc25YZXFZNUtkdktBWS9VTzh2S3RvTkM5ekNXdGZl?=
 =?utf-8?Q?nIiGPBeVi5MSM2/XQUpkkDCf6pqlpKkf/UxlU=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB1614798C6C56484592E367AB87670@MWHPR11MB1614.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(97736004)(68736007)(36756003)(256004)(25786009)(6436002)(53936002)(6246003)(106356001)(105586002)(4326008)(31686004)(6512007)(6116002)(3846002)(26005)(6486002)(229853002)(186003)(8936002)(72206003)(53546011)(99286004)(76176011)(8676002)(81156014)(81166006)(486006)(52116002)(478600001)(11346002)(6506007)(305945005)(7736002)(386003)(2616005)(2501003)(110136005)(54906003)(31696002)(316002)(6636002)(14454004)(66066001)(102836004)(71190400001)(446003)(71200400001)(4744005)(2906002)(86362001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1614;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9b54vWe7GT74HYj9Hl6AyL7OTrLRWAquUNXBplPWzP+tTAPKJfXuu/aLISu1e2zPTEAMo62d5OjEgitG2gGbReWQp5TXAQgRZxItTaT6kEUlSHXtS+FxMX+cwkcFtvZ1SboRtsj8FBapxNp4bQ5pzc6JzOCP0CzQSTU+sqGWnlQlA8r2IbMisGdGtBpzspd6jTTrD8US+oYx9XA3+aC4iPXH3YMxgwcU8qIuJnXWdL7ARVtQvtwImez9Q396/uviBrH7E6GlmLpig6Sj8kqq4oVJ0+4eQbOKAaj+o7S3RYSt1CJKQMyqkA+h2ECEmyP+T+jKiVAg4PFqM46B/JP68rP8DKtHy9ixXtdYT9eHeO+5fb1RA6ohLekF+ECv0jIgYGE6qBz7x5xUy7dEnySg3PrNIZ1sB4jktwCcctGRM7g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9547A5A19A428E4DAC2C3B39CD29F5B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09935411-fdef-4058-709d-08d692711ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:39:35.8535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1614
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClBsZWFzZSBpZ25vcmUgdGhpcyBzZXJpZXMuIEknbGwgcmVzZW5kIGEgbmV3IG9uZSBi
ZXR0ZXIgZm9ybWF0aW5nIHRoZSBwYXRjaGVzLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5l
YQ0KDQpPbiAxNC4wMi4yMDE5IDEyOjM5LCBDbGF1ZGl1IEJlem5lYSAtIE0xODA2MyB3cm90ZToN
Cj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+
IA0KPiBIaSwNCj4gDQo+IFRoaXMgc2VyaWVzIGFkZCBzbG93IGNsb2NrIHN1cHBvcnQgZm9yIFNB
TTlYNjAuIEFwYXJ0IGZyb20gcHJldmlvdXMgSVBzLCB0aGlzDQo+IG9uZSB1c2VzIGRpZmZlcmVu
dCBvZmZzZXRzIGluIGNvbnRyb2wgcmVnaXN0ZXIgZm9yIGRpZmZlcmVudCBmdW5jdGlvbmFsaXRp
ZXMuDQo+IFRoZSBzZXJpZXMgYWRhcHQgY3VycmVudCBkcml2ZXIgdG8gd29yayBmb3IgYWxsIElQ
cyB1c2luZyBwZXIgSVANCj4gY29uZmlndXJhdGlvbnMgaW5pdGlhbGl6ZWQgYXQgcHJvYmUuDQo+
IA0KPiBUaGFuayB5b3UsDQo+IENsYXVkaXUgQmV6bmVhDQo+IA0KPiBDbGF1ZGl1IEJlem5lYSAo
Mik6DQo+ICAgY2xrOiBhdDkxOiBzY2tjOiBhZGFwdCBzY2tjIGRyaXZlciB0byB3b3JrIGZvciBT
QU05WDYwDQo+ICAgZHQtYmluZGluZ3M6IGNsazogYXQ5MTogYWRkIGJpbmRpbmdzIGZvciBTQU05
WDYwJ3Mgc2xvdyBjbG9jaw0KPiAgICAgY29udHJvbGxlcg0KPiANCj4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Nsb2NrL2F0OTEtY2xvY2sudHh0ICAgICAgIHwgICAzICstDQo+ICBkcml2ZXJz
L2Nsay9hdDkxL3Nja2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE0MiArKysrKysr
KysrKysrKysrLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTA5IGluc2VydGlvbnMoKyksIDM2
IGRlbGV0aW9ucygtKQ0KPiANCg==
