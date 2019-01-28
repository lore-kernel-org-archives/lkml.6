Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD49C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E672148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="AHsjvRs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA1IUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:20:10 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:52493 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfA1IUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:20:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,533,1539673200"; 
   d="scan'208";a="25998333"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jan 2019 01:20:09 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 28 Jan 2019 01:20:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nVOhVEs4ieN4bvpPHj6Uf4ijItakZ3Mrep4D+QbLHU=;
 b=AHsjvRs1mdDMxtERg+SytUPAStXj7+To/sdTDSsJb8+2dyNoLxpyqGfxt8Tu6DE7OCmjKe9xthC3d8F6H2L9YvKjq7GOB331V4gG7ZYxP0VZ09rHSId3BY47Wgdgbe0xzQbKUibqTKal9fKjKONzRv/rNiFDbiGCv0ranvT1xBY=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1280.namprd11.prod.outlook.com (10.169.237.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 08:20:07 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 08:20:07 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <axel.lin@ingics.com>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] regulator: mcp16502: Include linux/gpio/consumer.h to fix
 build error
Thread-Topic: [PATCH] regulator: mcp16502: Include linux/gpio/consumer.h to
 fix build error
Thread-Index: AQHUth2FzkcnWQZHS0SpOd1qVqXvFaXEWEuA
Date:   Mon, 28 Jan 2019 08:20:06 +0000
Message-ID: <7f96f237-ed95-7d6f-f269-5466fa144d5b@microchip.com>
References: <20190127085122.11821-1-axel.lin@ingics.com>
In-Reply-To: <20190127085122.11821-1-axel.lin@ingics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::18) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1280;6:jCE8HUBRS2ggBPdhi462ayki/AvrJBn2T/gKoPMCz8Z/xPNJ5KzQaFmh0nwkRsG+mImIt50bgsLtd6X8myLw+YmZJEDEjSaOZ/H9bfXZZwqsqf1fbrmuQ+CfYAGOw02rVfjaTmOrpyDCz0y46KmEFL+aPx1ebwEZu1ZCcTiTj+OyVuU8jO0yhCDUJbzlLUxHAbTIFPzBz+tdn2mr8+pFC6kLTxPqbWcVJ1OzalY4K/XR78gWScIhtcgvRELeFf1uUbNvjtAWPKFHa1YrhkRIc100S9NuaaYvsxbdeju784qZSCTHe0eaKwORyjqq8/Mac2XMz9uS0w5KyYOJuZXf7IekvSFxi5vy5IJR+REbwJeh7P6txshSrOSBtkUlnuhiCT5sj10vPKxt2g1dgDqX1SmIySzQqMf9nUUuB0JG6MwnMMPrvN6/dyxJ8ETJFpM0dPbDY5pAOaL3WaRD8AQOIA==;5:qDNTsm1EwJ1CQktKuQvoLyT+I1z/IA5TujoqyO5n0O2FGC/T378P40+lofkd7FFRNVX5dzkN2uljAs97I6sIy+3jJecDFCkT1Xu40yzcxjnkibS8y66ViuMhtqYCIBxi2tZWUe7lg0Xw3EyP0OJMi2Z4UBTSR0Esmnqw6dEf3iJUaOBrWn2yIkqRHpcr39AeobV2wXzCGSR5U/OeAixgTQ==;7:qKwE7q4X5ksVj7gdlEwXERcWj6JQw2l+6xvU/jazPMsmGlScONYxqvOSeS9kUSLGmUi8E58XiAvweqvRD2VCLX6Bw1afjKZ9MT75X/bjamJYBh2f8m0bRN/gthfGvGgQcYwg1DlPZ629mOXDp7wJhA==
x-ms-office365-filtering-correlation-id: 9e9e8d33-1d04-4cce-0374-08d684f96948
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1280;
x-ms-traffictypediagnostic: MWHPR11MB1280:
x-microsoft-antispam-prvs: <MWHPR11MB1280244E7FE4612308BE6061E0960@MWHPR11MB1280.namprd11.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(26005)(71190400001)(71200400001)(478600001)(446003)(72206003)(6506007)(36756003)(186003)(99286004)(386003)(229853002)(256004)(6436002)(53546011)(76176011)(52116002)(305945005)(6486002)(14454004)(102836004)(110136005)(31696002)(316002)(107886003)(8676002)(81156014)(81166006)(11346002)(2616005)(53936002)(7736002)(66066001)(25786009)(31686004)(68736007)(106356001)(39060400002)(97736004)(8936002)(486006)(54906003)(6116002)(3846002)(6512007)(105586002)(2906002)(6246003)(86362001)(476003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1280;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vjIf3rFVQzErfYjwf4KHBY5hdAo5LX0GDZ8Zp8Z3UdZDqb3WXmIl3L8wp4NvGPAjX2KfuTew6SuHzuIptXuAW7RLZP59s6UwKmm8eGDcEp9l9BaIwLmuPIMEMkPMvCv4qIL5rgvrbFd+utIJEw2+2/JDG8g1Wh+o7Y4zPPAiJuJFsV01jyuD5P4anWNehM+Xo3hmBw1C1mKVMQgX6xqrnTF5Q+uQ+6yXsMeAolK/hwCuEsuKkKpNGRTTT4YaOAUbRm2/uE9Gw+cisU+prnhcKFvCOdm12w4Ne+QO6uUneb8BABQZDvpk/o73fLY9T6sOPbR/5HCJwrD4zdShE+rU79w44vEtuYx3szONc/sdOJqfQA5h+OITWPGBq1FnA+XGGugtlXDOb59Kv6GaZgj86dqd+Gmt8F+hyPk3OM01GEg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56A46BED8861F54E9DB0C0CB62988F65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9e8d33-1d04-4cce-0374-08d684f96948
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 08:20:05.3302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1280
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDEvMjAxOSBhdCAwOTo1MSwgQXhlbCBMaW4gd3JvdGU6DQo+IEZpeCBiZWxvdyBidWls
ZCBlcnJvcjoNCj4gZHJpdmVycy9yZWd1bGF0b3IvbWNwMTY1MDIuYzogSW4gZnVuY3Rpb24g4oCY
bWNwMTY1MDJfZ3Bpb19zZXRfbW9kZeKAmToNCj4gZHJpdmVycy9yZWd1bGF0b3IvbWNwMTY1MDIu
YzoxMzU6MzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGdwaW9k
X3NldF92YWx1ZeKAmTsgZGlkIHlvdSBtZWFuIOKAmGdwaW9fc2V0X3ZhbHVl4oCZPyBbLVdlcnJv
cj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAgIGdwaW9kX3NldF92YWx1ZSht
Y3AtPmxwbSwgMCk7DQo+ICAgICBefn5+fn5+fn5+fn5+fn4NCj4gICAgIGdwaW9fc2V0X3ZhbHVl
DQo+IGRyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmM6IEluIGZ1bmN0aW9uIOKAmG1jcDE2NTAy
X3Byb2Jl4oCZOg0KPiBkcml2ZXJzL3JlZ3VsYXRvci9tY3AxNjUwMi5jOjQ4NjoxMzogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGRldm1fZ3Bpb2RfZ2V04oCZOyBk
aWQgeW91IG1lYW4g4oCYZGV2bV9ncGlvX2ZyZWXigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICBtY3AtPmxwbSA9IGRldm1fZ3Bpb2RfZ2V0KGRldiwgImxw
bSIsIEdQSU9EX09VVF9MT1cpOw0KPiAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+DQo+ICAg
ICAgICAgICAgICAgZGV2bV9ncGlvX2ZyZWUNCj4gZHJpdmVycy9yZWd1bGF0b3IvbWNwMTY1MDIu
Yzo0ODY6NDA6IGVycm9yOiDigJhHUElPRF9PVVRfTE9X4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVz
ZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKAmEdQSU9GX0lOSVRfTE9X4oCZPw0K
PiAgICBtY3AtPmxwbSA9IGRldm1fZ3Bpb2RfZ2V0KGRldiwgImxwbSIsIEdQSU9EX09VVF9MT1cp
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHUElPRl9JTklU
X0xPVw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGluZ2ljcy5jb20+
DQoNCkFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+
DQoNClRoYW5rcyBBbGV4IQ0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAy
LmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9tY3AxNjUwMi5jIGIvZHJpdmVycy9yZWd1bGF0b3Iv
bWNwMTY1MDIuYw0KPiBpbmRleCAzNDc5YWUwMDliMGIuLjBmYzQ5NjNiZDViMCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvbWNwMTY1MDIuYw0KPiArKysgYi9kcml2ZXJzL3JlZ3Vs
YXRvci9tY3AxNjUwMi5jDQo+IEBAIC0xNyw2ICsxNyw3IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4
L3JlZ21hcC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvZHJpdmVyLmg+DQo+ICAg
I2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1
bWVyLmg+DQo+ICAgDQo+ICAgI2RlZmluZSBWRERfTE9XX1NFTCAweDBEDQo+ICAgI2RlZmluZSBW
RERfSElHSF9TRUwgMHgzRg0KPiANCg0KDQotLSANCk5pY29sYXMgRmVycmUNCg==
