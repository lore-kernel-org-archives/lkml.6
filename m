Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA48C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0752720685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bwHIwSKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfBTK67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:58:59 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:41810 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfBTK66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:58:58 -0500
X-IronPort-AV: E=Sophos;i="5.58,390,1544511600"; 
   d="scan'208";a="28011828"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 03:56:57 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 03:56:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vx8CY1WOiiAp1dI3TjhBhkWBJU2gFkcxu+uya4lW84=;
 b=bwHIwSKOeVXJqjo/0MG3HhVAHWnNw7iAxGAZsRd6MVhjUmlM+hnktmm4l2sXTewgrIxpDRzFU8I/PKNV+X5LUPvUW89P/47nm+G5XH+1cOEWD+Pkpo3zDjaNZywwpRddwjQ7S1+GXUkrSwglusuwrnXVd1SWOl9q8/hYhw5K6y4=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB0007.namprd11.prod.outlook.com (10.171.254.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 10:56:55 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%8]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 10:56:55 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <afd@ti.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <dannenberg@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Thread-Topic: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Thread-Index: AQHUyHBItzr+dNeZQEqfT8mjpFYo1qXnWh4AgAEq9wA=
Date:   Wed, 20 Feb 2019 10:56:55 +0000
Message-ID: <a1e133fe-2fdf-db02-4fe2-6b5e259191b7@microchip.com>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
 <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
 <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
In-Reply-To: <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0211.eurprd08.prod.outlook.com
 (2603:10a6:802:15::20) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b939d2b-cd57-4dc4-1370-08d6972220ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB0007;
x-ms-traffictypediagnostic: CY4PR11MB0007:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjExTUIwMDA3OzIzOmZldStRN0tESmU0RFdMZVdQTzU2aWJWaFFt?=
 =?utf-8?B?ajdxMzJVMEx6MGw5S2pKcTRPRFZCazVjSVZ3czV2WEowQXBjZWFVNGFxdXlP?=
 =?utf-8?B?UUo3K3pHUFlJbnFUUVhHNlNHOWQ3MkVOaHFZTFRTeVhsUnBick5BWkVMQTR0?=
 =?utf-8?B?aVF4bklKZUNYeFBwRkpOSDROQ1Vvb1pCNCt1RGZ3VkowSFpzN2JRTWpmUXp0?=
 =?utf-8?B?TGxja3lrT1R5MDZWQ0hmV3RFMDUxeS90WDhRcGlNa0g3MnkxNmU1VEhnN2VX?=
 =?utf-8?B?Vm9LOXg4a1o1Ry9rSi8wR2VrOXlsQm8waUJRQTh6Q2VLWDJEV2htRnd4a3Jn?=
 =?utf-8?B?M1hlYlJ3cHJSay9mVlNUQ1Nwb1Y5Q09Xb2FFVGJQNi9hR2szeEhjemlZbTFh?=
 =?utf-8?B?T2o0bVMvQXJDY2VvenZvS1ZiY0tJb0F3NVlXanNURk9wWFJpYmN2VE96WTBV?=
 =?utf-8?B?dkR4UW9zOFJIMzJCOHBmTTQzeWVQNUExTEhXQ0tpakRDS0psdnRmM0tkREk0?=
 =?utf-8?B?NjFWZFZlbUlrL3dYWkE4OVZsNS9ydWtVQnhZdUJDdW50Q3FGY0MzcGNycHZn?=
 =?utf-8?B?YXB1RVdxWGF2bkN3aFJwOXFCYmRsKzVVUkQrazJ1UVRwOVhQVmtEcGxBWVZI?=
 =?utf-8?B?WGF1cmNnbUpDZiszSGtkN0hRNUVHQXFpUTVDOHdZdHNBWnNOd2NYaTg2TVZB?=
 =?utf-8?B?NjdZL2srd05QbVllZUl5eG1pWlVyTWFidlZVckJyeFFmcjExaEtDRngralov?=
 =?utf-8?B?V3NMdFMxL1JhbmNVWnRNTEl0Z2ZzRGcvSFArdEU5UWxvTzVJMFI4WGI5Mkp0?=
 =?utf-8?B?NmdKaXVRVkdlME1GaUxLbXZBQ0lRQVo3NWI0L3JFekFBWFF1V3BSblBaOE1y?=
 =?utf-8?B?dFR5c0ZMdUJ2VEpENWtERGxoYytVeDlHN3FiV0JRYUlUMTcwSGs4YzVWT3Ry?=
 =?utf-8?B?RkZPdzRPUTZicTlocHhHK3ZZcDR5U2JMdU4vSEpqaEpLWks4Q1ZhdXIxaUto?=
 =?utf-8?B?UCtrMEJRa2Y0c2N4TnpUc0kvUXAyV0NwaUdnelVJMWI1am0rcytQWTlGazd0?=
 =?utf-8?B?UitXVDV4R0VqSU1ueGN5UU43NlVsQVF6NHdJZ3FpWVhyNld5cUVqeUdtSlg5?=
 =?utf-8?B?VlJBTHRkMlBHY0tWNkxlMEYzbzNGNzBtRStKTkFHODVxMXpJNTA4WVNqRkh6?=
 =?utf-8?B?M1pQbzcwQVpFVkszcGEwMEw5SUk3dUorV2hNUmwzZHc1OC8wcXJLdmhJS09I?=
 =?utf-8?B?N3NuYWE0NUlIU3JOa3ZuY0ZuYlljaWNaVjlvNHl5UEc1c1RwWER3cFF5Q2dW?=
 =?utf-8?B?Z1dLZHBaeW5uMWhmK0RoWGoxNVlQYUMzNHY0QVAyaURwZ0l5VXlkOGF1K3dV?=
 =?utf-8?B?cWcrb3pUTFRvTlRpRGxieXEvbHNIRFA1UkU5UmY2dUdsZldNVmNuekN0WUtt?=
 =?utf-8?B?LyszbCttOWZUVFFqcXVlOEpuZ1ZzblZyaExCMHNOQksvV0FzbTIrYWlhMm0w?=
 =?utf-8?B?WG9oY3huTk42QUxyVWJKWVd1dVRGREVyNHRSaTRkWGZwakRYTFBmcGgzUDFn?=
 =?utf-8?B?MjNWUXFmMzVQRWpTenk1b2pWaE5zUmgxdy9NdlBheUZISHNMbmxxWWx0UVdv?=
 =?utf-8?B?cTNKc0pOK0tpdllUcVl4dWdXOWZ1eEQxeXBVb0I0QTdvZmNvVXd0d09ZUTZh?=
 =?utf-8?B?RWNCbjJJbVcrekFWRVJzdjAyZmVTSmcvTlZxUitiRk5SZ3hrMXZiMEpkOUwy?=
 =?utf-8?B?SG1WWlBJUTNmaklHNXJLMENZRTU4MSsxMlZXZlN5REVaNXNXNXBHT3Z3VWt0?=
 =?utf-8?B?OS9reXhwUWJINWRtR2dLVXMxb1Q4ejNWMC9XZkNCM3htMHVhVFgwR0tFWDVY?=
 =?utf-8?Q?5H9Uyme8gHQ=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB00071ECE40BA23AA6C5DD095E77D0@CY4PR11MB0007.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(54094003)(2906002)(72206003)(66066001)(6246003)(7736002)(305945005)(54906003)(36756003)(4326008)(229853002)(97736004)(6512007)(6116002)(3846002)(14454004)(105586002)(106356001)(8676002)(8936002)(81166006)(81156014)(53936002)(478600001)(31686004)(6486002)(6436002)(2201001)(486006)(2616005)(102836004)(2501003)(186003)(6506007)(53546011)(31696002)(76176011)(386003)(5660300002)(476003)(52116002)(256004)(26005)(446003)(11346002)(71190400001)(99286004)(316002)(25786009)(86362001)(110136005)(68736007)(71200400001)(197533005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB0007;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dPCXMNxfiCuUu5yWWhubIrQOEFiuEyNT/WTLZPYAl3+k2wNL0OtMdeH/yo07qjWY6GNkz4vC8jphPZf4WtndAerH4T6ENfZo44am2PlncAWZ8gDMLpQng9cGUgiACMVgB4H+d6BXwuiBJ1qGhcZNcpGlxjUmGxx+1NEbdbIffA1a/ZT95mcTzME50UVFM3VZkU+nxoiOntk6IasZ/pBlulbl/PKV5IFAMV5r0gj4vzp8Mrl5/GQnk2KkzHLTM1qZQKFKK+xkCYQYTxA7RdNG8oBOmG7GhgTTOS88Xa6yVW3jspu30dhu0uEH9J2a5VdZ3aCOBPt/1E/TVn44a5Q1GtqiQnIn3bDrZEUXwcSY88Noi2gPtlKmLZikUbG+8g0Q9ZMCIfDDI8yldbzsPY+lPUYWtGZJLNODPazVmMtnqyo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <755D4C5D3444694889594766D0FAD874@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b939d2b-cd57-4dc4-1370-08d6972220ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 10:56:53.4913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0007
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDIuMjAxOSAxOTowNiwgQW5kcmV3IEYuIERhdmlzIHdyb3RlOg0KPiBPbiAyLzE5LzE5
IDEwOjI5IEFNLCBDb2RyaW4uQ2l1Ym90YXJpdUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gRnJv
bTogQ29kcmluIENpdWJvdGFyaXUgPGNvZHJpbi5jaXVib3Rhcml1QG1pY3JvY2hpcC5jb20+DQo+
Pg0KPj4gVGhlIEFEQ3MgYXJlIHNsZWVwaW5nIHdoZW4gdGhlIFNMRUVQIGJpdCBpcyBzZXQgYW5k
IHJ1bm5pbmcgd2hlbiBpdCdzDQo+PiBjbGVhcmVkLCBzbyB0aGUgYml0IHNob3VsZCBiZSBpbnZl
cnRlZC4NCj4+IFRlc3RlZCBvbiBwY20xODYzLg0KPj4NCj4gDQo+IERpZCB0aGlzIHdvcmsgZm9y
IHlvdSBiZWZvcmU/IFN0cmFuZ2UgaXQgd291bGQgaWYgcmV2ZXJzZWQsIEkgd29uZGVyIGlmDQo+
IHRoZSBTTEVFUCBiaXQgaXMgcmVhbGx5IGRvaW5nIGFueXRoaW5nIGhlcmUuIENhbiBpbnZlc3Rp
Z2F0ZSBsYXRlciwgZm9yDQo+IHRoaXMgcGF0Y2g6DQoNClRoZSBTTEVFUCBiaXQgc2VlbXMgdG8g
d29yay4gQXQgbGVhc3QgU1RBVEUgZnJvbSByZWdpc3RlciAxMTQgc2F5cyB0aGUgDQpJUCBpcyBz
bGVlcGluZy4gV2l0aG91dCB0aGlzIGNoYW5nZSwgaWYgcGNtMTg2MyBpcyB1c2VkIGFzIG1hc3Rl
ciwgSSBjYW4gDQpzZWUgQkNLIGFuZCBMUkNLIGdlbmVyYXRlZCB3aGlsZSBubyBzb3VuZCBpcyBw
bGF5ZWQuIE9uY2UgSSBzdGFydCBhbiANCmF1ZGlvIHN0cmVhbSwgdGhlIGNsb2NrcyBzdG9wLg0K
DQpUaGFuayB5b3UgZm9yIHlvdXIgQUNLLiBJIHdvdWxkIHJlYWxseSBhcHByZWNpYXRlIGlmIHlv
dSBjb3VsZCBhbHNvIHRlc3QgDQppdCBvbiB5b3VyIHNpZGUuDQoNCkJlc3QgcmVnYXJkcywNCkNv
ZHJpbg0KDQo+IA0KPiBBY2tlZC1ieTogQW5kcmV3IEYuIERhdmlzIDxhZmRAdGkuY29tPg0KPiAN
Cj4+IFNpZ25lZC1vZmYtYnk6IENvZHJpbiBDaXVib3Rhcml1IDxjb2RyaW4uY2l1Ym90YXJpdUBt
aWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+ICAgLSBub25l
Ow0KPj4NCj4+ICAgc291bmQvc29jL2NvZGVjcy9wY20xODZ4LmMgfCA2ICsrKy0tLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3BjbTE4NnguYyBiL3NvdW5kL3NvYy9jb2RlY3Mv
cGNtMTg2eC5jDQo+PiBpbmRleCBjMzZhMzkxZmVjOGEuLmM1ZmNjNjMyZjY3MCAxMDA2NDQNCj4+
IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvcGNtMTg2eC5jDQo+PiArKysgYi9zb3VuZC9zb2MvY29k
ZWNzL3BjbTE4NnguYw0KPj4gQEAgLTE1OCw3ICsxNTgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHNuZF9zb2NfZGFwbV93aWRnZXQgcGNtMTg2M19kYXBtX3dpZGdldHNbXSA9IHsNCj4+ICAgCSAq
IFB1dCB0aGUgY29kZWMgaW50byBTTEVFUCBtb2RlIHdoZW4gbm90IGluIHVzZSwgYWxsb3dpbmcg
dGhlDQo+PiAgIAkgKiBFbmVyZ3lzZW5zZSBtZWNoYW5pc20gdG8gb3BlcmF0ZS4NCj4+ICAgCSAq
Lw0KPj4gLQlTTkRfU09DX0RBUE1fQURDKCJBREMiLCAiSGlGaSBDYXB0dXJlIiwgUENNMTg2WF9Q
T1dFUl9DVFJMLCAxLCAgMCksDQo+PiArCVNORF9TT0NfREFQTV9BREMoIkFEQyIsICJIaUZpIENh
cHR1cmUiLCBQQ00xODZYX1BPV0VSX0NUUkwsIDEsICAxKSwNCj4+ICAgfTsNCj4+ICAgDQo+PiAg
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCBwY20xODY1X2RhcG1fd2lk
Z2V0c1tdID0gew0KPj4gQEAgLTE4NCw4ICsxODQsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNu
ZF9zb2NfZGFwbV93aWRnZXQgcGNtMTg2NV9kYXBtX3dpZGdldHNbXSA9IHsNCj4+ICAgCSAqIFB1
dCB0aGUgY29kZWMgaW50byBTTEVFUCBtb2RlIHdoZW4gbm90IGluIHVzZSwgYWxsb3dpbmcgdGhl
DQo+PiAgIAkgKiBFbmVyZ3lzZW5zZSBtZWNoYW5pc20gdG8gb3BlcmF0ZS4NCj4+ICAgCSAqLw0K
Pj4gLQlTTkRfU09DX0RBUE1fQURDKCJBREMxIiwgIkhpRmkgQ2FwdHVyZSAxIiwgUENNMTg2WF9Q
T1dFUl9DVFJMLCAxLCAgMCksDQo+PiAtCVNORF9TT0NfREFQTV9BREMoIkFEQzIiLCAiSGlGaSBD
YXB0dXJlIDIiLCBQQ00xODZYX1BPV0VSX0NUUkwsIDEsICAwKSwNCj4+ICsJU05EX1NPQ19EQVBN
X0FEQygiQURDMSIsICJIaUZpIENhcHR1cmUgMSIsIFBDTTE4NlhfUE9XRVJfQ1RSTCwgMSwgIDEp
LA0KPj4gKwlTTkRfU09DX0RBUE1fQURDKCJBREMyIiwgIkhpRmkgQ2FwdHVyZSAyIiwgUENNMTg2
WF9QT1dFUl9DVFJMLCAxLCAgMSksDQo+PiAgIH07DQo+PiAgIA0KPj4gICBzdGF0aWMgY29uc3Qg
c3RydWN0IHNuZF9zb2NfZGFwbV9yb3V0ZSBwY20xODYzX2RhcG1fcm91dGVzW10gPSB7DQo+Pg0K
DQo=
