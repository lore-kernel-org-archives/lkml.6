Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF26C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F30A20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g+S/kYMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfBBSoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 13:44:09 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:48347 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfBBSoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 13:44:08 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c55e4f60000>; Sun, 03 Feb 2019 02:44:06 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Sat, 02 Feb 2019 10:44:03 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Sat, 02 Feb 2019 10:44:03 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 2 Feb
 2019 18:44:02 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 2 Feb
 2019 18:44:01 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.53) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Sat, 2 Feb 2019 18:44:00 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3303.namprd12.prod.outlook.com (20.179.93.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Sat, 2 Feb 2019 18:43:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 18:43:57 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUulC5gnNOlUi0AEWt0UGRYeTykqXLS2aAgAAETSCAAAKYgIABPCQAgABIKwA=
Date:   Sat, 2 Feb 2019 18:43:57 +0000
Message-ID: <BYAPR12MB339885398C3B0218D452B6CAC2930@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
 <BYAPR12MB33984FB81B8BB1EC8C0C4908C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6150de70-6ca8-944a-780a-4574ff2b21c7@gmail.com>
 <f667ab55-c7c7-4ac1-100a-7f7ade87708d@gmail.com>
In-Reply-To: <f667ab55-c7c7-4ac1-100a-7f7ade87708d@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3303;6:6jNA+/iR58scPuycGmLOi23m6UyCDGwz0pENa7q/eKd7PIPUO9XbhPXDVmn6L5DnINNkNyl784foXLXMApHZ+RD3qlk8CAwbVQbqrd0dzdwSoiA/hiAVVJfcsbNeIXp33DRVKxoWCOKwSgZ2DnsTrSRh3D9zzjn9f930RwwtPhbKHIyhaA7NCZdBtWKi6VdTlenoqvbCfUREC7jXy8403+YkFP+2aXvzCRRnquL3F96Ye84gknHvW46NGKnxgyxvFp21+o44YqEcbHK8aLzOmge64kWQR+LUqMP19XirV0JJu1Epupc1gb/aiMHccnTGB7o4yi6M5B2mPKKTcdJGh/MCjcopSTODLSePHFy9ObsyMDY+zmCKdhz0Q8+ry7qYNBlCNdqVoPwCkl6DKfoHIHUBKGIkNEoLDjkT03K6v/wOd7906y/K24Sw+ErDRT7YrXNFfPylRTsvpRAmoWN2zQ==;5:ncIbwBiVKKLHZPFRnQoXqqCl2VlV121CeWaB4JE6X8oqwtuG9iiypnRTOEchNoWseDQ1TTElL98FJXgpZrER07NC3uV0p/6XmySVU6eOsrLSp+XRti4Nq6aGNi82OGgYxm8nHCU73NKroZJwjzfcRtBhN/fUAnvZi1evk+0m6J4QASIltg6JMa+9V9tcFxUMUesAk86mrboWGz+qAdBhwg==;7:bfupMDSEdV0BTOlHPapb8euhyJkPD7NZwcgKxYQA9eUQwXsVN35ywEaej8zOKopdC+6NKSTOJVHXWEXXmLZbUQFNAGuqkB5x5l1LpFaRo3iZEJ9/T8aAMCc8uz3jYXCBWTlgezqtbZ3gwXQz5HSGoQ==
x-ms-office365-filtering-correlation-id: 36b6d982-4719-4c16-2783-08d6893e63df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3303;
x-ms-traffictypediagnostic: BYAPR12MB3303:
x-microsoft-antispam-prvs: <BYAPR12MB330304620553B2957E3F1271C2930@BYAPR12MB3303.namprd12.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(7696005)(316002)(256004)(6246003)(76176011)(486006)(99286004)(39060400002)(14444005)(4326008)(68736007)(53936002)(55016002)(478600001)(33656002)(106356001)(105586002)(25786009)(6636002)(71190400001)(2501003)(9686003)(71200400001)(2906002)(305945005)(26005)(66066001)(6116002)(186003)(7736002)(11346002)(110136005)(446003)(54906003)(476003)(6436002)(81166006)(81156014)(86362001)(97736004)(8676002)(102836004)(14454004)(74316002)(229853002)(93886005)(3846002)(6506007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3303;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Typ9ZIm/LGwg0EZfrI5DzaFAXuNxLYT2St8WVcsURAYPxj4E7RqtdwH65VULj0fESq/JFQ8+ZlKqaRC79Lh7do8JsysTZRazWkdI8lfoKjbRh8FmG+AAsGnm3xpgfiVVyhwj14X/reie0ePosMLZTW9Q1c3FqpP7cUu1wYbVtpWIeCUsqR5Onpro7Qwnzo1FnpbAaXMiEkvIRT05qS0rxwhU/yKU8U7vcZIK8wBo3hqVu+LKgjILf8HgbvLlkK9y1GgEaMW2EjhROWrfCWkw5pgMpaYIMr7Mm54zl/15kmJinLPuAlhUqm9gTw3E+pneqxOBASJyee2ytFUTsmI0Dzyr3W6rQPsyygP5wzU4htLFoeisAHDG6TPTZLz3BOmGWdB6/Tavd48uWQshd7ZiV2HfVUCrjTxkKKoAuT/Md/U=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b6d982-4719-4c16-2783-08d6893e63df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 18:43:57.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549133047; bh=RI/ymdcSna3AP+lRs/9jKtNiFzJbRXpNhK2ucAVoFSk=;
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
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=g+S/kYMJ1uYb8oQRpvpezxwWM1p2ZX/9w9Ie51eEK3/Ts8HscxhT+EvvZ2qYSRux1
         JHHXdAX2UC3NhZNfIRj7yrqaCEw7+vU5kLxkz2BYH6VidKcpWZMrrTHwzGkNYPl0wl
         DLj0g1O5UM0qV2yLNr3DAcRrHVExY0LckNsYAIGr2JJ3PoNYMXUn9W9kt4ooVwIiVd
         0HMDiQIdfMLu20dnsnXlbjfiWbP05S+g/stK5qFzT1TIr9xB/TPBrQgJy38ASOPIz9
         kTGB5kHQhvVLxIpxRjaPF4BD3qYN+1+lI88LNipLAM3mxiwhr2rgUZWWedZfpz0FZM
         XoxwtPPhElfjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+Pj4gK3N0YXRpYyBpbnQgdGVncmFfaTJjX2luaXRfZG1hKHN0cnVjdCB0ZWdyYV9pMmNf
ZGV2ICppMmNfZGV2KSB7DQo+ID4+Pj4gKwlzdHJ1Y3QgZG1hX2NoYW4gKmRtYV9jaGFuOw0KPiA+
Pj4+ICsJdTMyICpkbWFfYnVmOw0KPiA+Pj4+ICsJZG1hX2FkZHJfdCBkbWFfcGh5czsNCj4gPj4+
PiArCWludCBlcnIgPSAwOw0KPiA+Pj4+ICsNCj4gPj4+PiArCWlmICghSVNfRU5BQkxFRChDT05G
SUdfVEVHUkEyMF9BUEJfRE1BKSkNCj4gPj4+PiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPj4+DQo+
ID4+PiBEcml2ZXIgc2hhbGwgbm90IGZhaWwgdG8gcHJvYmUgaWYgRE1BIGRyaXZlciBpcyBkaXNh
YmxlZCwgYnV0IHRvIGNvbnRpbnVlIHdpdGggdGhlIFBJTy1vbmx5IG1vZGUgYXZhaWxhYmxlLg0K
PiA+Pj4NCj4gPj4+IFNob3VsZCBiZToNCj4gPj4+DQo+ID4+PiAJaWYgKCFJU19FTkFCTEVEKENP
TkZJR19URUdSQTIwX0FQQl9ETUEpKQ0KPiA+Pj4gCQlyZXR1cm4gMDsNCj4gPj4+DQo+ID4+IEV4
Y2VwdCBFUFJPQkVfREVGRVIsIGFueXRoaW5nIGVsc2UgcmV0dXJuZWQgZnJvbSB0ZWdyYV9pMmNf
aW5pdF9kbWEgDQo+ID4+IChFTk9ERVYvRU5PTUVNKSBpcyBpZ25vcmVkIGluIGkyY19wcm9iZSBE
TUEgbW9kZSBkZWNpc2lvbiBpcyBiYXNlZCBvbiB4ZmVyIHNpemUgYW5kIGF2YWlsYWJpbGl0eSBv
ZiBkbWEgY2hhbm5lbCBvciBjYW4gYmUgY2hhbmdlZCBiYXNlZCBvbiB2YWxpZCBkbWEgYnVmIHRv
IHNob3J0ZW4gdGhlIGxpbmUuDQo+ID4+DQo+ID4gDQo+ID4gQWgsIHNvcnJ5LiBJIG1pc3NlZCB0
aGF0LCBzZWVtcyBnb29kIHRoZW4uDQo+ID4gDQo+DQo+IEJUVywgaXQgbWF5IGJlIHdvcnRod2hp
bGUgdG8gbW92ZSBvdXQgdGhlIGVycm9yIGNvZGUgaGFuZGxpbmcgaW50byB0ZWdyYV9pMmNfaW5p
dF9kbWEoKSBmb3IgY2xhcml0eS4gSXQgYWxzbyB3b24ndCBodXJ0IHRvIG5vdCBpZ25vcmUgZXJy
b3JzIG90aGVyIHRoYW4gLUVOT0RFVi4NCg0KRWl0aGVyIHdheXMgYXJlIHNhbWUuIFRvIGJlIG1v
cmUgcmVhZGFibGUvY2xlYXIgb24gZXJyb3IgdHlwZXMgZm9yIGRpZmYgY2FzZXMgYW5kIGVycm9y
cyB0aGF0IHdlIGFyZSBpZ25vcmluZywgSSBhbSBleHBsaWNpdGx5IGtlZXBpbmcgZXJyb3IgY29k
ZWNzIChFUFJPQkVfREVGRVIvRU5PREVWL0VOT01FTSkgc2FtZSB3YXkuDQpBbHNvIGluIHByb2Jl
IGZvciByZWFkYWJpbGl0eSBjaGVja2luZyB3aXRoIEVQUk9CRV9ERUZFUiB3aGljaCBleHBsaWNp
dGx5IGluZGljYXRpbmcgd2Uga2VlcCBkZWZlcnJpbmcgaTJjIHByb2JlIHJhdGhlciB0aGFuIHNp
bXBsZSByZXR1cm4uDQoNCg==
