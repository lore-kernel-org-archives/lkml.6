Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F871C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453332175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BXZ8h9X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfA2Hlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:41:47 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:1689 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfA2Hlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:41:46 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5003b60000>; Tue, 29 Jan 2019 15:41:42 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 23:41:41 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 28 Jan 2019 23:41:41 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 07:41:40 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 07:41:39 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.55) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 29 Jan 2019 07:41:39 +0000
Received: from SN6PR12MB2640.namprd12.prod.outlook.com (52.135.103.17) by
 SN6PR12MB2783.namprd12.prod.outlook.com (52.135.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 07:41:36 +0000
Received: from SN6PR12MB2640.namprd12.prod.outlook.com
 ([fe80::e53d:71b1:ce2:664f]) by SN6PR12MB2640.namprd12.prod.outlook.com
 ([fe80::e53d:71b1:ce2:664f%2]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 07:41:36 +0000
From:   Mark Zhang <markz@nvidia.com>
To:     Billy Laws <blaws05@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: =?utf-8?B?562U5aSNOiBbMi8yXSBtZmQ6IG1heDc3NjIwOiBBZGQgbG93IGJhdHRlcnkg?=
 =?utf-8?Q?monitor_support?=
Thread-Topic: [2/2] mfd: max77620: Add low battery monitor support
Thread-Index: AQHUtlBQvVPaj4gjcUW/hMnAJ3b8JqXF0ciAgAAMOICAAAFrIA==
Date:   Tue, 29 Jan 2019 07:41:36 +0000
Message-ID: <SN6PR12MB264000075CD2584DBE9EDA80C7970@SN6PR12MB2640.namprd12.prod.outlook.com>
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
 <bd942195-4f1c-1a39-283f-610354308f45@nvidia.com>
 <CAFUUQHM88kVh0ov1G30Sz9WQKJRY4p78hBMporL1xU=aY_tNCA@mail.gmail.com>
In-Reply-To: <CAFUUQHM88kVh0ov1G30Sz9WQKJRY4p78hBMporL1xU=aY_tNCA@mail.gmail.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@nvidia.com; 
x-originating-ip: [203.18.50.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2783;6:4kp5Qp8+Pnlr5CoW/zag0zOwSWgZYs7QLpoRfWHZrbzwm65RHrkTPvFyQyg2INzR4uQn1Ew+HRSC11chX2sJ0u0pImVlJaILuHjmz8mc8FGW1JFkdabfke24hjue3m3/+gmQM53FNl896nN78HRGaeplDKBqz/ZpF/MfMCrldbvqTX3eEc5bd3MoChfs/12yGfV6c+mTWaUuAMQ4Ny/fe30hLB2HpMEvmfVxcO22nCnKNSHWLVHcQ0FiBDadXPV5mL+SK1cXpBviA2XymDR79nlmdg6+pOxvzPBAiGJVgj9BHyfgBEtompJl8iQJaiNGLL6HrLzU8iQumjDzjAFGKYuL6KDUyqEWCvnMSXQh1GDy33qlCPqJ2s8QP/KWii1OCbYNmHsGdrxeDwAiI8DSBcXRZR/8R3Du2gonNsizYYySAPQ60QYJPFU9GRkIIeLF68HwTwthFi8dSp8XsHgbPg==;5:X44BdzFg/DEAJY0CetdrLxD65ZfLZ0fkmVsfPgw5myzxRbNz5Zn1mx6/EAWJ5SChioO80wVQMpY8PcWwndlUMjiYxcxiwhsXyIW3b/IWA8BfekB/8eqv84yp3Wy37qUxSlwkpB7WKIHHSHFDmSKTCMxJyVM9dnaJ4cSMII8iRuOpsq1s+t6za/ITy2nvT9s0cqSlY7pAhshVdBNdyak6rg==;7:Wo7S+AtCWjiBOcExLc6e3+PzhfLvUfCQDTJC0VwobV43BmDKoz+LY9hHkFcmm9VYkXfT23gE0SWISizXJrlHCU0ZzotK9r44WUEl0zej0Gki26a2GD+uKSy5gMNDCYapD7U9GuBEUxEkksHtWl1VeA==
x-ms-office365-filtering-correlation-id: 81e297f5-b487-45d6-bf44-08d685bd32f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2783;
x-ms-traffictypediagnostic: SN6PR12MB2783:
x-microsoft-antispam-prvs: <SN6PR12MB2783B187473D47BD35ED01DFC7970@SN6PR12MB2783.namprd12.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(81156014)(81166006)(8936002)(76176011)(74316002)(7696005)(39060400002)(7736002)(305945005)(66066001)(446003)(54906003)(11346002)(316002)(86362001)(97736004)(476003)(6916009)(68736007)(106356001)(224303003)(105586002)(1411001)(102836004)(71190400001)(33656002)(6506007)(99286004)(26005)(186003)(486006)(478600001)(53546011)(71200400001)(2906002)(6436002)(53936002)(14444005)(6116002)(107886003)(9686003)(4326008)(6306002)(14454004)(966005)(55016002)(3846002)(25786009)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2783;H:SN6PR12MB2640.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kAfn7TkFBOutrhh4+nzrHWaSj9f1jkQlDZt9Wtb4Q2ww8+1Mn/YHjbsToubNHWQeoc1pUeSUw+YuYv9oUjiiSU2verXS63jLxewRk4RN9U8Y5G8UhZwmN/ohwcFDTA9lxHHEIWHPYMZl15QNXcFUEJomKi8s/sUesI8qWOjqgys+7Z0HwLiMLHg4w3CBh5R9PvqCadp895VOu0dHk8KExy6ggds1yGA4mDma3jVgxXmKlNupvY1a1uOlvg14s3ZlqS6GNGBK8OvVJQRT1nx+IxGPYAR+L7iWG/ETyIu4QNdkZYNO+wjpuL8jegZnPi9x1CntX95zqJXeKTA0Ty3Nnnjgec0XGgap39yI4GuxrzppOAQQcvjmV/KY4xcYc2C9OqDPQQ6coQ5EL52JsLo3iixZcKv+UhIO9F3zP5NDw2M=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e297f5-b487-45d6-bf44-08d685bd32f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 07:41:36.9085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
X-OriginatorOrg: Nvidia.com
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548747702; bh=07bB7fp854zdnWMP6e7DieJAuTVKyY+xnHCXBJjMmPw=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=BXZ8h9X+nSshjeOhk351661vIStNkwTCxlsgDPbMRalsuWRt5GgCGPnqWgO9yTvhF
         eFM6lr0b/j1SnysTWmissDGjOTnjHmwk8qO6yXpVAqecDbRSF5X1fr1cdDtMdSl/Xc
         QoR8VsIt3Zw7Oa2OMUBDvyVVPTYlzZ0/RLpMXULPrJS+dVZA5KAjHYX6Ga8ZzWKsr8
         OaA4Jw73XQbdhQjWtOT7zuw2kWm1JooytjPc7J9BWBSGuQsRp6EtfRXiyz1wmjMxuN
         oE5xwqU2wJopd6X54wlHxdm/diScIBkUl1ZDsSqa2IUMmXQxyg5hYqNeww9Mv2dlpP
         4o49orFBVnWkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2ggeWVhaCB3aWxsIGRvLCB0aGFua3MuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7
tuS6ujogQmlsbHkgTGF3cyA8Ymxhd3MwNUBnbWFpbC5jb20+IA0K5Y+R6YCB5pe26Ze0OiBUdWVz
ZGF5LCBKYW51YXJ5IDI5LCAyMDE5IDM6MzYgUE0NCuaUtuS7tuS6ujogTWFyayBaaGFuZyA8bWFy
a3pAbnZpZGlhLmNvbT4NCuaKhOmAgTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9y
ZzsgTGF4bWFuIERld2FuZ2FuIDxsZGV3YW5nYW5AbnZpZGlhLmNvbT47IFZlbmthdCBSZWRkeSBU
YWxsYSA8dnJlZGR5dGFsbGFAbnZpZGlhLmNvbT4NCuS4u+mimDogUmU6IFsyLzJdIG1mZDogbWF4
Nzc2MjA6IEFkZCBsb3cgYmF0dGVyeSBtb25pdG9yIHN1cHBvcnQNCg0KU3VyZSwgdGhhdCdzIGZp
bmUgd2l0aCBtZSwgd2lsbCBzZW5kIHRoZW4gdGhpcyBnZXRzIGFjY2VwdGVkLiBUd28gb3RoZXIg
dGhpbmdzOiB5b3Ugc2hvdWxkIHByb2JhYmx5IHNldCB0aGUgcmVnIHRvIDAgaWYgdGhlIHByb3Bl
cnR5IGlzbid0IHNwZWNpZmllZCBhcyByZWdtYXBfYWRkX2lycWNoaXAgc2V0cyBpdCB0byAweGZm
IChiYXNpY2FsbHkgYWxsIGVuYWJsZWQgb24gaGlnaGVzdCBsaW1pdCksIGFuZCB5b3UgaGF2ZW4n
dCB1cGRhdGVkIHRoZSBkdC1iaW5kaW5ncy4NCg0KT24gVHVlLCBKYW4gMjksIDIwMTkgYXQgNjo1
MiBBTSBNYXJrIFpoYW5nIDxtYXJrekBudmlkaWEuY29tPiB3cm90ZToNCj4NCj4gT24gMS8yNy8y
MDE5IDEwOjU0IFBNLCBCaWxseSBMYXdzIHdyb3RlOg0KPiA+ICA+VGhpcyBwYXRjaCBhZGRzIFBN
SUMgY29uZmlndXJhdGlvbnMgZm9yIGxvdy1iYXR0ZXJ5ICA+bW9uaXRvcmluZyANCj4gPiBieSBo
YW5kbGluZyBtYXg3NzYyMCByZWdpc3RlciBDTkZHR0xCTDEuDQo+ID4gID4NCj4gPiBJdCBtaWdo
dCBiZSBhbiBpZGVhIHRvIGFkZCBsYmh5c3QgY29uZmlndXJhdGlvbiBoZXJlIGFuZCBzdXBwb3J0
IA0KPiA+IHVzaW5nIGN1c3RvbSBsYmRhYyB2YWx1ZXMgdG8gc3BlY2lmeSBhIGRpZmZlcmVudCBj
dXRvZmYgcG9pbnQuDQo+DQo+IFllYWggdGhpcyBwYXRjaCBkb2Vzbid0IGhhdmUgc3VwcG9ydCB0
byBwcm9ncmFtIExCSFlTVCAmIExCREFDIGJlY2F1c2UgDQo+IGFjY29yZGluZyB0byBvdXIgZXhw
ZXJpZW5jZXMsIHdlIGRvbid0IGhhdmUgcmVxdWlyZW1lbnQgdG8gbW9kaWZ5IHRoZW0gDQo+IHdo
ZW4gbG93IGJhdHRlcnkgbW9uaXRvciBzdXBwb3J0IGFkZGVkLg0KPg0KPiBJIHRoaW5rIHdlIGNh
biBjcmVhdGUgYSBuZXcgcGF0Y2ggdG8gc3VwcG9ydCB0aGVzZSAyIGZpZWxkcyBpbiB0aGUgDQo+
IGZ1dHVyZSB3aGVuIHdlIHJlYWxseSBuZWVkIHRoZW0uIE9yIHlvdSBjYW4gY3JlYXRlIGEgcGF0
Y2ggaWYgeW91IGhhdmUgDQo+IHJlcXVpcmVtZW50IGZvciB0aGVtLCBpcyB0aGlzIE9LIHRvIHlv
dSBCaWxseT8NCj4NCj4gTWFyaw0KPg0KPiA+DQo+ID4gU2VlOiBodHRwczovL2RhdGFzaGVldHNw
ZGYuY29tL3BkZi1maWxlLzkyNDIzMC9NYXhpbS9NQVg4Njk4Qy8xICBwZyANCj4gPiA0Ng0KPiA+
ICA+U2lnbmVkLW9mZi1ieTogTGF4bWFuIERld2FuZ2FuIDxsZGV3YW5nYW5AbnZpZGlhLmNvbT4N
Cj4gPiAgPlNpZ25lZC1vZmYtYnk6IFZlbmthdCBSZWRkeSBUYWxsYSA8dnJlZGR5dGFsbGFAbnZp
ZGlhLmNvbT4NCj4gPiAgPlNpZ25lZC1vZmYtYnk6IE1hcmsgWmhhbmcgPG1hcmt6QG52aWRpYS5j
b20+DQo+ID4gID4tLS0NCj4gPiAgPiBkcml2ZXJzL21mZC9tYXg3NzYyMC5jIHwgNTcgDQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gID4gMSBmaWxl
IGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkgID4gID5kaWZmIC0tZ2l0
IA0KPiA+IGEvZHJpdmVycy9tZmQvbWF4Nzc2MjAuYyBiL2RyaXZlcnMvbWZkL21heDc3NjIwLmMg
ID5pbmRleCANCj4gPiBmNTgxNDMxMDMxODUuLjllNTBkMTQ1YWZkOCAxMDA2NDQNCj4gPiAgPi0t
LSBhL2RyaXZlcnMvbWZkL21heDc3NjIwLmMNCj4gPiAgPisrKyBiL2RyaXZlcnMvbWZkL21heDc3
NjIwLmMNCj4gPiAgPkBAIC00NzQsNiArNDc0LDU3IEBAIHN0YXRpYyBpbnQNCj4gPiBtYXg3NzYy
MF9pbml0X2JhY2t1cF9iYXR0ZXJ5X2NoYXJnaW5nKHN0cnVjdCBtYXg3NzYyMF9jaGlwICpjaGlw
KSAgPiAgDQo+ID4gcmV0dXJuIHJldDsgID4gfSAgPiAgPitzdGF0aWMgaW50IA0KPiA+IG1heDc3
NjIwX2luaXRfbG93X2JhdHRlcnlfbW9uaXRvcihzdHJ1Y3QgbWF4Nzc2MjBfY2hpcCAqY2hpcCkg
ID4reyAgDQo+ID4gPisgc3RydWN0IGRldmljZSAqZGV2ID0gY2hpcC0+ZGV2OyAgPisgc3RydWN0
IGRldmljZV9ub2RlICpucDsgID4rIA0KPiA+IGJvb2wgcHZhbDsgID4rIHU4IG1hc2sgPSAwOyAg
PisgdTggdmFsID0gMDsgID4rIGludCByZXQ7ICA+KyAgPisgbnAgDQo+ID4gPSBvZl9nZXRfY2hp
bGRfYnlfbmFtZShkZXYtPm9mX25vZGUsICJsb3ctYmF0dGVyeS1tb25pdG9yIik7ICA+KyBpZiAN
Cj4gPiAoIW5wKSB7ICA+KyBkZXZfaW5mbyhkZXYsICJMb3cgYmF0dGVyeSBtb25pdG9yaW5nIHN1
cHBvcnQgDQo+ID4gZGlzYWJsZWRcbiIpOyAgPisgcmV0dXJuIDA7ICA+KyB9ICA+KyAgPisgcHZh
bCA9IA0KPiA+IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgIm1heGltLGxvdy1iYXR0ZXJ5LWRh
Yy1lbmFibGUiKTsgID4rIGlmIA0KPiA+IChwdmFsKSB7ICA+KyBtYXNrIHw9IE1BWDc3NjIwX0NO
RkdHTEJMMV9MQkRBQ19FTjsgID4rIHZhbCB8PSANCj4gPiBNQVg3NzYyMF9DTkZHR0xCTDFfTEJE
QUNfRU47ICA+KyB9ICA+KyAgPisgcHZhbCA9IA0KPiA+IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChu
cCwgIm1heGltLGxvdy1iYXR0ZXJ5LWRhYy1kaXNhYmxlIik7ICA+KyBpZiANCj4gPiAocHZhbCkg
ID4rIG1hc2sgfD0gTUFYNzc2MjBfQ05GR0dMQkwxX0xCREFDX0VOOyAgPisgID4rIHB2YWwgPSAN
Cj4gPiBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJtYXhpbSxsb3ctYmF0dGVyeS1zaHV0ZG93
bi1lbmFibGUiKTsNCj4gPiAgPisgaWYgKHB2YWwpIHsNCj4gPiAgPisgbWFzayB8PSBNQVg3NzYy
MF9DTkZHR0xCTDFfTVBQTEQ7ICA+KyB2YWwgfD0gDQo+ID4gTUFYNzc2MjBfQ05GR0dMQkwxX01Q
UExEOyAgPisgfSAgPisgID4rIHB2YWwgPSANCj4gPiBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAs
ICJtYXhpbSxsb3ctYmF0dGVyeS1zaHV0ZG93bi1kaXNhYmxlIik7DQo+ID4gID4rIGlmIChwdmFs
KQ0KPiA+ICA+KyBtYXNrIHw9IE1BWDc3NjIwX0NORkdHTEJMMV9NUFBMRDsgID4rICA+KyBwdmFs
ID0gDQo+ID4gb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAibWF4aW0sbG93LWJhdHRlcnktcmVz
ZXQtZW5hYmxlIik7DQo+ID4gID4rIGlmIChwdmFsKSB7DQo+ID4gID4rIG1hc2sgfD0gTUFYNzc2
MjBfQ05GR0dMQkwxX0xCUlNURU47ICA+KyB2YWwgfD0gDQo+ID4gTUFYNzc2MjBfQ05GR0dMQkwx
X0xCUlNURU47ICA+KyB9ICA+KyAgPisgcHZhbCA9IA0KPiA+IG9mX3Byb3BlcnR5X3JlYWRfYm9v
bChucCwgIm1heGltLGxvdy1iYXR0ZXJ5LXJlc2V0LWRpc2FibGUiKTsNCj4gPiAgPisgaWYgKHB2
YWwpDQo+ID4gID4rIG1hc2sgfD0gTUFYNzc2MjBfQ05GR0dMQkwxX0xCUlNURU47ICA+KyAgPisg
cmV0ID0gDQo+ID4gcmVnbWFwX3VwZGF0ZV9iaXRzKGNoaXAtPnJtYXAsIE1BWDc3NjIwX1JFR19D
TkZHR0xCTDEsIG1hc2ssIHZhbCk7ICANCj4gPiA+KyBpZiAocmV0IDwgMCkgID4rIGRldl9lcnIo
ZGV2LCAiUmVnIENORkdHTEJMMSB1cGRhdGUgZmFpbGVkOiANCj4gPiAlZFxuIiwgcmV0KTsgID4r
IHJldHVybiByZXQ7ICA+K30gID4rICA+IHN0YXRpYyBpbnQgDQo+ID4gbWF4Nzc2MjBfcmVhZF9l
c192ZXJzaW9uKHN0cnVjdCBtYXg3NzYyMF9jaGlwICpjaGlwKSAgPiB7ICA+ICANCj4gPiB1bnNp
Z25lZCBpbnQgdmFsOyAgPkBAIC01NjMsNyArNjE0LDExIEBAIHN0YXRpYyBpbnQgDQo+ID4gbWF4
Nzc2MjBfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgID4gIGlmIChyZXQgPCAwKSAg
PiAgDQo+ID4gcmV0dXJuIHJldDsgID4NCj4gPiAgPi0gcmV0ID0gIGRldm1fbWZkX2FkZF9kZXZp
Y2VzKGNoaXAtPmRldiwgUExBVEZPUk1fREVWSURfTk9ORSwgID4rIA0KPiA+IHJldCA9IG1heDc3
NjIwX2luaXRfbG93X2JhdHRlcnlfbW9uaXRvcihjaGlwKTsNCj4gPiAgPisgaWYgKHJldCA8IDAp
DQo+ID4gID4rIHJldHVybiByZXQ7DQo+ID4gID4rDQo+ID4gID4rIHJldCA9IGRldm1fbWZkX2Fk
ZF9kZXZpY2VzKGNoaXAtPmRldiwgUExBVEZPUk1fREVWSURfTk9ORSwNCj4gPiAgPiAgICAgIG1m
ZF9jZWxscywgbl9tZmRfY2VsbHMsIE5VTEwsIDAsDQo+ID4gID4gICAgICByZWdtYXBfaXJxX2dl
dF9kb21haW4oY2hpcC0+dG9wX2lycV9kYXRhKSk7DQo+ID4gID4gIGlmIChyZXQgPCAwKSB7DQo+
ID4NCg==
