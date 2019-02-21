Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D23EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54155214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uz1DbQ08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBUJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:31:32 -0500
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:45381
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfBUJbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e42h3drkekE1Gu64rETS21+GHlLER4S7CsaAu0AcXuo=;
 b=uz1DbQ08ydJQD7oFStH6n5WIazXfBmoni/52gIwH6vHHGBY8B5fi54MoACHjED/JdzBwOEkceSlwzfTHA+kE4s9oX/Bdd4zs0mSLF1JKVuS3UJlNs7zWwj6w9fe3EAu01mPuZ51jpLfqW0LqfzUXfB3eUbBCzZ4w3X2X00TBxAQ=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5486.eurprd04.prod.outlook.com (20.178.122.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 09:30:47 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2%3]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 09:30:47 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Topic: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Index: AQHUxUqvA6eOAzVWPUW+Xl7987JiyqXk4fzAgABcX4CABELMwIAAcYSAgAAAoXCAAAVfAIAADAKw
Date:   Thu, 21 Feb 2019 09:30:47 +0000
Message-ID: <VI1PR04MB5327CA438A1EAA5BB99E91188B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190215162225.19284-1-paul.kocialkowski@bootlin.com>
         <VI1PR04MB53274C03CD18C3D3ADB767408B630@VI1PR04MB5327.eurprd04.prod.outlook.com>
         <c80ee02db4a22d15a24281384ae561462593684f.camel@bootlin.com>
         <VI1PR04MB53278AE9AB6C14DA2AB96F6A8B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
         <3ed330798d31d01fdfbd40571d016a108c9c5040.camel@bootlin.com>
         <VI1PR04MB5327C5FCF2BCF404B78A2C6A8B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <8fa473aee266f6fdd90c6b90661977982488cb77.camel@bootlin.com>
In-Reply-To: <8fa473aee266f6fdd90c6b90661977982488cb77.camel@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c267aee-4db3-41ba-a53b-08d697df42c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5486;
x-ms-traffictypediagnostic: VI1PR04MB5486:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1NDg2OzIzOmxzVk9lWFhsK21IZ3kvL0VXb2xHOEs2dnlw?=
 =?utf-8?B?VmwxVm5NNFZ1TGo3US8rblV3SUZKTkZjMTg4LysycWY2bjNlOHVCdDN2UGdE?=
 =?utf-8?B?c3c3NGZpZEFaWEVxbUtGMGM5VmhxVzVpN0RKZHNsMmZ2MWE4Vm9PSENUby8x?=
 =?utf-8?B?MHN5RE53amppRzRDaDNLWEljL1Z6cWUxL3Y2RVpLelRSVDg1VDgwVjBKVnFQ?=
 =?utf-8?B?ZDRMS0FJUDBkVURCbTRRM2tPK3RNNnN2MWN5SGwvdDNlbVNCZmVpUmoyRGlt?=
 =?utf-8?B?RzgyOHE3RUpoTXJKOGpwSU10NFpSRUYxYTZtUHlYc3NWOUxRS3hoOEtaNWx3?=
 =?utf-8?B?RjlGazV4NnAwVUR2a2c2RG1ibDdpbTN6MG9HVzhtdXpYbEM1OGRSa1E1ZWcy?=
 =?utf-8?B?YTdPRE04dXhHYWhzTmlsRWpERjV6L29ubWNZV2x0bUhGZWdmZ1hCSE96cSt1?=
 =?utf-8?B?cG5aWUwyMFZvY0NyL0orL0xUV2c0K0RJUDBTZEljQ2NHOXR3cEsvSmtUb040?=
 =?utf-8?B?Y0NqVXg3U3liVUdBa0pQUEsrUXNBT3pXV0pMMTltQUlndm1Tbnp5bldjVk9t?=
 =?utf-8?B?Uy9QRkxiYytjM0R2TGVZWndqS1k5aitjSXZFNXhsMTRNZHlkaEV2dGlrUmg0?=
 =?utf-8?B?UThEOWVTeHdOdFN5T2UxYUNIZ1pwREJZajk5ZGl2MnduSDZrTkVnV0o2bmNu?=
 =?utf-8?B?ZCsxVklBczA3Yzg3aUFXUlpIb2EzbThoU2N4MmNjYkEvbFRlb1J1Q0VXRkJO?=
 =?utf-8?B?OFRPV0lBK21aS2tjWFR5RWRUSy9URkVDR2pMbUY1L3A3b2tXbjN3bkcrVUZC?=
 =?utf-8?B?enRJc0YrY1dPMGJ2NDVBR1RkWXpxQ291THE0aGExZDZJSlhaQW1IeWhKdlhk?=
 =?utf-8?B?eDNnUmgrL1o2QkJ4ZE9VeFhIS2dWQmI3V3BtcW8rcGo5ZC9CRGNlei9UUUE3?=
 =?utf-8?B?ZFNWTVFpK3lDMnl3Tld0eTNDZHVGbXZYR0ZrRkU2elMxd21sWE42Wi91R1pJ?=
 =?utf-8?B?REVveGluRSswMHk0TjJOS1ZMa29zMUxGN01rR1JqZi96UElKWTNxUnhCMisx?=
 =?utf-8?B?dVFVTXBMekpSUlNBdFRiMEwxaFhDOEl4QURlQkhCZVNvamk1T211ckY3OWNG?=
 =?utf-8?B?YlB6MTBFWkI1dFRDV24xakZheVNud0ZpakJwdjJNVGRGRjdrZm1ieVBlZjdl?=
 =?utf-8?B?ZHpGWThzcGQxdGNuY25LWnNQUG9tZmd4Q2U1OWUwRFZKRUYrZjhpbnNNQnBy?=
 =?utf-8?B?SVBDR2ZqNEVsTHQvdEpaQmo1QnVaeVF3MVM2dDJwNzBYU2Fhekd5Q2p5WVlW?=
 =?utf-8?B?WW9IcDFPUWplMEtnUWZVM1pjWWdxamYwZTZ5dFJSY2ZDOUtBdmQwbmttVWYw?=
 =?utf-8?B?b2VFK3phaVhnVXNCK1E3OVIwblhHZTIxcVJYRjBINFkvQmtEMzJBTjdMV0U0?=
 =?utf-8?B?UDNpVXV0eERwUGZrak5QYXZsdlg1SndpRkd6NCtka1Rkd2pxYTE3bU95Rmpt?=
 =?utf-8?B?cEJHb2s0MG9BM1NuTnBPOFphN2xqdTZLcmtVa3BhK1huWENtQnZSSE94TjJm?=
 =?utf-8?B?QkNSUFB4V1FEQXpPL09YVHVkT1Y0RTgrWTB1SDFybXFkR2JNL3NFS1o3bVl5?=
 =?utf-8?B?QXRLVzhSby9LVmlFd2Jaa284UGxGaTZPSjlaczdVNUUxQ0xrRHgwQzB6dnlh?=
 =?utf-8?B?dHNFeGN1dW1mWFcreHZ1YXA1VGp2aFo5VkpXVzhOa1NNZExlTkxndTVnbXh0?=
 =?utf-8?B?NzJuZ3hncldqeFVCWnd3UT09?=
x-microsoft-antispam-prvs: <VI1PR04MB5486A9D9F688D4609EC784A38B7E0@VI1PR04MB5486.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6116002)(14454004)(256004)(4744005)(316002)(2501003)(76176011)(6436002)(71190400001)(71200400001)(2906002)(99286004)(110136005)(4326008)(54906003)(7696005)(8936002)(6246003)(26005)(11346002)(229853002)(476003)(478600001)(97736004)(55016002)(486006)(44832011)(105586002)(186003)(446003)(102836004)(6506007)(93886005)(9686003)(5660300002)(106356001)(3846002)(53936002)(7736002)(33656002)(305945005)(74316002)(8676002)(66066001)(81156014)(2201001)(81166006)(68736007)(25786009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5486;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IBsBqjBpmz5f5wBdap20XpXkKpOmdooPiTdQfFCjjUT4i+6J59eQdSBwh07NQS0FBlCsb1tTVthOFUPk8PggQfnASIus01elFjyMa+qEWV0o3WmqLA8imsxor1b8xpaoWgKRtzUCDvzWIlxXo9LFFxblInEsD9Pk1MDrNRpKrrPO+yoRW1wPNi7k7+tquNeqnwNgpVIGX52R4QMFop1vRH1jBYi9xwdij7gq/GPmiqFMAw88iY7rd/dNLXz1XQOCw3El3QIzJBCcERxmy+OW9mUC2HHN+qZGc9S9GRL8y1znoOPsmTcVGI8yNSttKekbEcoYwAMX06q3wtKh+2eBrScZU3DT87AHxcrl+cSNo396zcTlzQBiwFEhDvUmJF7mtOfgAS0fo2OYg+/k8MB+nk5JBHyHAGJxZ3XdoSk7ANw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c267aee-4db3-41ba-a53b-08d697df42c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:30:47.2355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+IEN1cnJlbnQgY29kZSB3L28geW91ciBwYXRjaCwgaXQgaXMgcG9zc2libGUgYm90aCBj
aS0+cGh5IGFuZA0KPiA+IGNpLT51c2JfcGh5IGFyZSB2YWxpZCBpZiB0aGUgVVNCIFBIWSBpcyBu
b3QgYXQgdGhlIGRldmljZSB0cmVlLCBidXQgZ2VuZXJpYyBQSFkgaXMNCj4gYXQgdGhlIGRldmlj
ZSB0cmVlLg0KPiA+IElmIHlvdSBkb24ndCB3YW50IHRvIGZpeCB0aGlzIGlzc3VlIHdpdGggdGhp
cyBwYXRjaCwgaXQgaXMgb2sgdG9vLiBXZSBjb3VsZCBmaXggaXQgbGF0ZXIuDQo+IA0KPiBJJ20g
bm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBpc3N1ZS4gV2l0aCBteSBwYXRjaCwgaWYgdGhlcmUg
aXMgYSBnZW5lcmljIFBIWQ0KPiBkZXNjcmliZWQgaW4gZGV2aWNlLXRyZWUsIHRoZW4gZGV2bV91
c2JfZ2V0X3BoeV9ieV9waGFuZGxlIGZvciBsZWdhY3kgUEhZIHdpbGwNCj4gZmFpbCBhbmQgdGhl
IGNvZGUgd2lsbCBmYWxsYmFjayB0byBkZXZtX3VzYl9nZXRfcGh5LCB3aGljaCBpcyB0aGUgc2Ft
ZSBiZWhhdmlvciBhcw0KPiBiZWZvcmUuDQo+IA0KDQpZb3UgYXJlIHJpZ2h0LCBidXQgdGhpcyBi
ZWhhdmlvciBpcyBpbmNvcnJlY3Qgc2luY2UgZWFjaCBjb250cm9sbGVyIGhhcyBvbmx5IG9uZSBw
aHlzaWNhbA0KVVNCIFBIWS4NCg0KPiBJcyBpdCBhIHByb2JsZW0gdGhhdCB3ZSBjYW4gZW5kIHVw
IHdpdGggYm90aCBhIGdlbmVyaWMgYW5kIGxlZ2FjeSBQSFk/DQo+IEkgdGhvdWdodCB0aGlzIHdh
cyBleHBlY3RlZCBiZWhhdmlvciBhdCBwcm9iZSwgYW5kIHRoZSByZXN0IG9mIHRoZSBjb2RlIHdp
bGwganVzdCB1c2UNCj4gdGhlIGdlbmVyaWMgb25lIGluIHByaW9yaXR5Lg0KPiANCj4gRG8geW91
IHdhbnQgdG8gbWFrZSBpdCBzbyB0aGF0IG9ubHkgb25lIChnZW5lcmljIG9yIGxlZ2FjeSkgUEhZ
IHJlbWFpbnMgYWZ0ZXINCj4gcHJvYmU/DQo+IA0KIA0KWWVzLCBJIGp1c3Qgd2FudCBvbmx5IG9u
ZSB2YWxpZCwgZWl0aGVyIGNpLT5waHkgb3IgY2ktPnVzYl9waHksIGl0IG1ha2VzIHNlbnNlLg0K
DQpQZXRlcg0KDQo=
