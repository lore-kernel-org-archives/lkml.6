Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA49EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3647206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Q1R6pmfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbfBROto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:49:44 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:47424 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbfBROtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:49:42 -0500
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; 
   d="scan'208";a="27900392"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 07:47:25 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 07:47:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrS1BzI/uXbq8mnpiqXBCfSVul7ViDQ4wQnZERBlesY=;
 b=Q1R6pmfwBp8WRUbfgfGLyCeWk2IDcZsitENcJkTjG42lPk4Gr0v/eveUDGNELyJF1xJNBoDpOgXY4hAO9ndniRADKRy5coi7MTqZHG+KftHvM7iOxocFuhbFW7t1h5W6bQLUHxkYE3MUJTJ2+WeysatUqs4GYSGmi4ZlwOiPrUI=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1694.namprd11.prod.outlook.com (10.169.232.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 14:47:23 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 14:47:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Topic: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Index: AQHUxFfTL1CYZiysKUi13XXnc4JnEKXlafyAgAA+/IA=
Date:   Mon, 18 Feb 2019 14:47:22 +0000
Message-ID: <44adcef4-a3df-f906-2d69-f357af1ebfaf@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
 <1550143407-26109-4-git-send-email-claudiu.beznea@microchip.com>
 <97af1d45-d74b-87d3-c934-baae80307e1d@microchip.com>
In-Reply-To: <97af1d45-d74b-87d3-c934-baae80307e1d@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0081.eurprd09.prod.outlook.com
 (2603:10a6:802:29::25) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190218164711766
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b5e8e01-4c48-46cf-b3b3-08d695affd56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1694;
x-ms-traffictypediagnostic: MWHPR11MB1694:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxNjk0OzIzOmc0Qk03Q3lxR2M0VFlyczB2MmxHRFF2anNH?=
 =?utf-8?B?ODlGTWVEdWg0NzcxTm5pL21Gc2lWNUU4YlRnRmkxaTFCZjQvdjNuVXh1blJ1?=
 =?utf-8?B?L1BJV1FBOFJiUk5ZaXBTZUFLQ3pPMnFxSG94b0I1MStOanNwU2hrcjNycmhk?=
 =?utf-8?B?Wk1hSG5kWlViUWR6YjZoTDBsRTNiL3drcURLRThHT2FVV2NYc0ZwNzVnQWdD?=
 =?utf-8?B?dW5IcW5Bd3Z2MnBPRnBpSm9XclMxR0NYcGY1cTFMejlsNGw5TWlsc2pSVU95?=
 =?utf-8?B?SzhycEZuUzhVQ1hrRlFxTzRId09vMVNwZ3Y2bmdFTnErNWZ0T2pxMjRzUFdS?=
 =?utf-8?B?b3VkUVg4MEV2aGtnQjBVMEFBQ1NkL2JqNHhXTkQ0cWVlVHVtakVlY3JoWURl?=
 =?utf-8?B?UlZkdzlrY3RaeDBKVUFMSCtlTTliSitXV3RWYldiYk1RYVFMdW11eHZJT1lj?=
 =?utf-8?B?bkpRVit2MGRvb3NGcFVGVktYTGlyT2QzMS82Lzh1Rk9zUTNKU1FKWVY4QjVU?=
 =?utf-8?B?bGtnRmE4U2VDdzVjUkN3cWNqVVZmT1dIVUh3ZW5OcVJVNTBGNWxzOGsxaDVS?=
 =?utf-8?B?b05WV2NmdGQ4QWcrazNIcDg4SVBaZWRNK0pnQzVwbVlhVFd6R2F2cXFwM1dZ?=
 =?utf-8?B?bmlZVHNlUUUrS25WeXFXOVhYdTJCVU5TaXZMR0M3SThLN3RRTCs5b0VVU0Mw?=
 =?utf-8?B?a0RJK2pQM1Z0T3dueVJiaU1NR0NKNURHbE04ai84dklrQkRSVTBzLzZwQkJk?=
 =?utf-8?B?cUpiZkNEdXVJQVFlV1lpRS9ma1VBY0Y3cFQxLzJOTndVSHJsODhFenVheDVY?=
 =?utf-8?B?cHNMQk1BSklnVGZxZGRRblZHRWxPMWdCTHhQMm8xbkQ4eHF0ZFNEY2dwTHNu?=
 =?utf-8?B?dk83VDAweGJIdmhQdStUQVU2VFNVZDBIcVM0V0hlSjZuYW1ONCtvSncxQmRE?=
 =?utf-8?B?Z3crUTg1NVNUT0FmZitmQyt5VlRmRmQzR3RYZkorcmN3a2RxUXlhU1p3N0JS?=
 =?utf-8?B?KzBSaGtpTUhvTW03WjZSVjBGcnVXSzY4WTBFOTdOakNYQkV0STZZdWJJNWlj?=
 =?utf-8?B?QkRuTWxaOUJOVllLUnNUckF2ZmUxQUFJS1E5T0tFQk41SHBNNXpTMWtESUhR?=
 =?utf-8?B?enJtZXJtZDd2MW10WEZucndmdERIVU01c1dUd2RtV3lpWC9PNm1iTHRuV0ZG?=
 =?utf-8?B?enZTa1RDQzJrTDhubWFNVkhTY3VaeEdiaGZXVTZWbmdOSnN2KzUyMnJkNGpj?=
 =?utf-8?B?VTVBQllrcGVvci80Tnp1NlFnUjhPaThIRFF3OTBPYm1MOEVjVWgxaGlpVDhS?=
 =?utf-8?B?M1M4MWNLTThpaDQvTXpnYjJuTURpdHBMRmcrNEEwTGxPT3hRZnB3cGg1Ykhy?=
 =?utf-8?B?aHRZUVhXYUpUVjRlWnE2WWFjUVlON0ZqRks4MWsrbGdhZ2VCdmhjZzhjdHFh?=
 =?utf-8?B?R3MxWi81ZU0xY3Z2U2JOOFBVOTN5ZE5NU2hMWmptU2RtcUlFUU8wRXJZN0Ev?=
 =?utf-8?B?MGVwZTgrWUVQdU10NUFOb2RJRWpBamxoSUwyRnN4cW51WkFZNEtoZmVnc20v?=
 =?utf-8?B?c3NGTkJCT05NdkhwVEEyZjhkamgwMHh1c0NMelRUK3VTcnY0eERkQ1JtNlVo?=
 =?utf-8?B?SDhTL3pmU0poazdmSHBMeUxTSGZya3l2UytsM0poeFdyUEZ0MHVpZVkrTTBR?=
 =?utf-8?B?OSs4RHhTYkdISUh4N1dLQVZNREl6M01lMU1mS2dXSjZOb0Y2Q1BLTllkNjVj?=
 =?utf-8?B?aFd2MUpoZXpQckhXTHJVa1p1ZHJTMDJXZ3NXOC91NVRRUVNkb21hNmVYd000?=
 =?utf-8?B?a1U0Ri9EMEFLTUg3cUFJMjl6cGJ6alhGWXAwcGNnUUtKU1E9PQ==?=
x-microsoft-antispam-prvs: <MWHPR11MB169476ACA80FDCFE7F6A8A0487630@MWHPR11MB1694.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(39860400002)(346002)(43544003)(189003)(199004)(31686004)(66066001)(186003)(110136005)(6246003)(316002)(8936002)(105586002)(106356001)(26005)(81156014)(71190400001)(2501003)(81166006)(31696002)(6486002)(7736002)(446003)(11346002)(86362001)(53936002)(478600001)(54906003)(14454004)(305945005)(2616005)(476003)(6512007)(6436002)(71200400001)(486006)(229853002)(25786009)(14444005)(256004)(99286004)(2906002)(8676002)(53546011)(5660300002)(386003)(6506007)(52116002)(76176011)(3846002)(6116002)(102836004)(68736007)(72206003)(36756003)(4326008)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1694;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5GhrlRRNkDXvY51igtBPt2yyjs+6HAgdCaQMT+b4yJKmpWTFI3TV6mDGzMnWR/QMnOhFs3k2iOO255KeayKvUYQsbcUF/2KNExKVeq2y3JmhSR7FCyswN5o7w80sIqye+XNudYWiPERthkBm9lI3IpdRHNGtuFQvScGuRT3fPf5fuSZz+CFRHi7XEvAF1aFFrfDgiiFOGmjnTLiyHcShgigTJMyM52S0vc3C/zWotWKQovsNTxc+7ipW3ywQztIHOcP1cUhC+xm4eaFEJSnLsbP3uHNvniFIhEoBikR7kokFkk7M2tIuAu+6fC6Sr+3Whj8p3YHmiQp7T4Jpm2HMKoF1JW8Qc8KGtmOuS+7rZtKVhi9ljTN4ebL2n2unnRD+gux3U/8UktY7YjLAwXfNAuQaeBH9xCJTLnsfl30zz1o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7B81ABD4F21E44BA0081B373E7CD1CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5e8e01-4c48-46cf-b3b3-08d695affd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 14:47:18.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1694
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE4LjAyLjIwMTkgMTM6MDEsIE5pY29sYXMgRmVycmUgLSBNNDMyMzggd3JvdGU6DQo+
IE9uIDE0LzAyLzIwMTkgYXQgMTI6MjQsIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0K
Pj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+
Pg0KPj4gQWRkIGRvY3VtZW50YXRpb24gZm9yIFNBTTlYNjAgc2h1dGRvd24gY29udHJvbGxlci4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWlj
cm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0IHwgNiArKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dA0KPj4g
aW5kZXggMTRmMzE5ZjY5NGI3Li45NzExMDUyYzU4MDAgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0DQo+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0
DQo+PiBAQCAtODMsNyArODMsNyBAQCBTSERXQyBTQU1BNUQyLUNvbXBhdGlibGUgU2h1dGRvd24g
Q29udHJvbGxlcg0KPj4gICAxKSBzaGR3YyBub2RlDQo+PiAgIA0KPj4gICByZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KPj4gLS0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJhdG1lbCxzYW1hNWQyLXNoZHdj
Ii4NCj4+ICstIGNvbXBhdGlibGU6IHNob3VsZCBiZSAiYXRtZWwsc2FtYTVkMi1zaGR3YyIgb3Ig
Im1pY3JvY2hpcCxzYW05eDYwLXNoZHdjIi4NCj4+ICAgLSByZWc6IHNob3VsZCBjb250YWluIHJl
Z2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQo+PiAgIC0gY2xvY2tzOiBwaGFuZGxlIHRvIGlu
cHV0IGNsb2NrLg0KPj4gICAtICNhZGRyZXNzLWNlbGxzOiBzaG91bGQgYmUgb25lLiBUaGUgY2Vs
bCBpcyB0aGUgd2FrZS11cCBpbnB1dCBpbmRleC4NCj4+IEBAIC05NSw2ICs5NSwxMCBAQCBvcHRp
b25hbCBwcm9wZXJ0aWVzOg0KPj4gICAgIG1pY3Jvc2Vjb25kcy4gSXQncyB1c3VhbGx5IGEgYm9h
cmQtcmVsYXRlZCBwcm9wZXJ0eS4NCj4+ICAgLSBhdG1lbCx3YWtldXAtcnRjLXRpbWVyOiBib29s
ZWFuIHRvIGVuYWJsZSBSZWFsLVRpbWUgQ2xvY2sgd2FrZS11cC4NCj4+ICAgDQo+PiArb3B0aW9u
YWwgcHJvcGVydGllcyBmb3IgbWljcm9jaGlwLHNhbTl4NjAtc2hkd2M6DQo+IA0KPiBpcyBpdCBm
b3Igc2FtOXg2MCBvbmx5IG9yIGlzIHRoZSBvcHRpb25hbCBwcm9wZXJ0eSAiZGVib3VuY2UtZGVs
YXktdXMiIA0KPiBhcHBsaWNhYmxlIHRvIHRoaXMgU29DPw0KDQpObywgSSBtZWFudCBvbmx5IHRv
IFJUQyBhbmQgUlRULg0KDQo+IA0KPj4gKy0gYXRtZWwsd2FrZXVwLXJ0Yy10aW1lcjogYm9vbGVh
biB0byBlbmFibGUgUmVhbC1UaW1lIENsb2NrIHdha2UtdXAuDQo+PiArLSBhdG1lbCx3YWtldXAt
cnR0LXRpbWVyOiBib29sZWFuIHRvIGVuYWJsZSBSZWFsLXRpbWUgVGltZXIgV2FrZS11cC4NCj4g
DQo+IFdlbGwsIEkgd291bGQgbWFrZSBjbGVhciB0aGF0IHRoZSBvbmx5IGFkZGl0aW9uYWwgb3B0
aW9uYWwgcHJvcGVydHkgaXMgDQo+ICJhdG1lbCx3YWtldXAtcnR0LXRpbWVyIiB3aGlsZSB0aGUg
MiBvdGhlciBvcHRpb25hbCBwcm9wZXJ0aWVzIHN0aWxsIA0KPiBhcHBseS4uLg0KDQpPaywgSSB3
aWxsIHRha2UgY2FyZSBvZiB0aGlzIGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmsgeW91LA0KQ2xh
dWRpdSBCZXpuZWENCg0KPiANCj4gDQo+PiAgIFRoZSBub2RlIGNvbnRhaW5zIGNoaWxkIG5vZGVz
IGZvciBlYWNoIHdha2UtdXAgaW5wdXQgdGhhdCB0aGUgcGxhdGZvcm0gdXNlcy4NCj4+ICAgDQo+
PiAgIDIpIGlucHV0IG5vZGVzDQo+Pg0KPiANCj4gDQo=
