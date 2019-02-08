Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7000C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771AB2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qpdjACKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfBHPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:50:04 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:17619 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfBHPuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:50:03 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5da5260001>; Fri, 08 Feb 2019 23:49:58 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 07:49:58 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 08 Feb 2019 07:49:58 -0800
Received: from DRBGMAIL102.nvidia.com (10.18.16.21) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 15:49:56 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL102.nvidia.com
 (10.18.16.21) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 15:49:55 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 15:49:55 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3589.namprd12.prod.outlook.com (20.178.197.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 15:49:52 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 15:49:52 +0000
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
Subject: RE: [PATCH V15 4/6] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V15 4/6] i2c: tegra: Add DMA support
Thread-Index: AQHUvy64ygjLqqj+r0yzTYtI5VJ73KXV2pEAgAAvldA=
Date:   Fri, 8 Feb 2019 15:49:52 +0000
Message-ID: <BYAPR12MB3398BE6DA6F1E82E5F2525C2C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-4-git-send-email-skomatineni@nvidia.com>
 <7806f2cd-72b4-6ae3-b75f-0fc74fb62b95@gmail.com>
In-Reply-To: <7806f2cd-72b4-6ae3-b75f-0fc74fb62b95@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3589;6:HPa3iUSvWjkRGOujQ0ulAFvXkXCu/Jtq853WODe+1rKjWioxVdaACD6v/3XLszL8HLBTnoMNU8XL3C2sa5wICgy9s2douuDy2m1RdmkltXTw3Sjtj7E06/0tcM1Qa36ciqgk7Ujy0xLJYykDWUlpyoXsNhfJL1S+ZQASkh9B3v3oQhB2xZMom9gKhtn3HaDd/0Brt2lzRcDvnPiS68RJJ1kkQT74uB26626m7FvKZZAQtY3TW4t5xSu2Xu+UeURMIbAqrOVNiSqbfbt+Uo6nZNdk/Nl9EvlwLmBt9Q/C7e1L8nAqOmbo+bXfezY7m48M/XyES3ZFBkFE7suoM2yZQulpi/2jHh66FW3LcT70Y43m9SiyaZ1NOopvVVvmuDIajuku99p37FjjjKyon7sNCROdbI7Rlo8pyh6hD3x+oSETGTCGI4lD+6nMq5bizVtyJ2G0YXhBNzXPRpCaOtkv1A==;5:+c/vYWLzgsoXK86GCsHkGMg4AItiovlpIHe1OLT1dAxbrViV+9T5pqBPrURPcx0XGuq2ssI5+OM6Gks/NHT8iSfTzavzoUvd1YJYtceRK4RS6N9as32sLYd7xwFWs4NfwXWAlnFXg/KJBPYZgO5zEFRqVImP4j8Zj1IGt+SXmuCA5ERIHeQacf+I9QuvgWHXoJGr+Y5/KgDRrUHt955K+g==;7:gLUX5bTMKQ4tQ9Jvlc74YlSb1oWrgJybfXQp8Q3zZefnV3TTIyTnCeSSXIgaijmTFPZyOiNuUQQSw81amR9VODHmMOkayZrQ4NGVfShVqGMIVMEkNs65UGQYtPWxTuhEX3ZEXOaAUcWwk2MZZsuMWg==
x-ms-office365-filtering-correlation-id: dbcc3b8e-4236-493f-b0d8-08d68ddd10ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3589;
x-ms-traffictypediagnostic: BYAPR12MB3589:
x-microsoft-antispam-prvs: <BYAPR12MB3589244402EA808594FF96DDC2690@BYAPR12MB3589.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(2501003)(8936002)(25786009)(81166006)(8676002)(81156014)(2906002)(66066001)(102836004)(446003)(97736004)(26005)(4326008)(186003)(11346002)(476003)(106356001)(105586002)(486006)(86362001)(71200400001)(71190400001)(68736007)(6506007)(9686003)(99286004)(6636002)(7696005)(76176011)(3846002)(6116002)(229853002)(478600001)(55016002)(14444005)(256004)(33656002)(305945005)(53936002)(6246003)(110136005)(54906003)(7736002)(316002)(14454004)(74316002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3589;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /ZCjToDu4DRu+46LefCdqjEE2apWSDuL16dYqi395fqXKyQR04Rvq08MsUbDqbJqFuAWKbR0NvjmrkwyVrQd+9zdqPQsJc8zU5l01v/eN4hShES5T5N49JNR8H5+UpAb3JnXjtlkQqq6DSCy6ObYHeh+T2cjMRRVYY3/JKm5VZhOmjLb3pzQR1JUFNGI572MOOgw2ZZ4PMghwcm57SokIKBXlNRp52ZMO4cAc1S6Ze/PShQhjI0BkEOwUhUu9sn4uh7K5NO1KTnowVAK+NCalmV59DSeFk1v+YcVOl7nxcMVITwmwkJL7pQtm5H/ARANKtIz9NO2HYVNlmTQei4vMoD94UXRggZT7a2YHDoWNWvkh+w8A/j8j4YWv4RGGOBay4bD3TGJkGDOF5KcYdK1XqmSY/Eq5sBj5sQmBqcxvr4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcc3b8e-4236-493f-b0d8-08d68ddd10ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:49:52.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3589
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549640998; bh=f4qQMWlPUEMsrPFw+wP5j9yPzQ1Lk0835unEk+Bgvew=;
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
        b=qpdjACKo1VhFufPeTLQ6ly44+ccCcbRP0OEbDQHgy6WzQQl3xvbezhxeI68vBbdhD
         y0v3a/5q9FMr6xioGemiuThuCJXGLwOc6GKpQcg8aYMbsXcMpOPlGk1WGSXw8zN/Di
         XHSr9f60GTaRMdgihm5S6WLue81d+5z7nNzRePiHpNvq1cPKkKPcuehwqhhDO3mCuz
         JPYad9AGu2sIIyguJ2odxkXS2a/s3ms1k+fa+SSPcNmrYPRxYCiSP9hoUk4vvNvdAO
         PXLX5iF2jxEC9i84/7gGLVMsRhE/Yx7GK1PHN5MBjHTIFyJNthGhlsThy1zdipGXwt
         hp2hkmQ4z5c+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsJcmV0ID0gdGVncmFfaTJjX2luaXRfZG1hKGkyY19kZXYpOw0KPiA+ICsJaWYgKHJldCA8
IDApDQo+ID4gKwkJZ290byBkaXNhYmxlX2Rpdl9jbGs7DQo+ID4gKw0KPiA+ICAJcmV0ID0gdGVn
cmFfaTJjX2luaXQoaTJjX2Rldik7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gIAkJZGV2X2Vycigm
cGRldi0+ZGV2LCAiRmFpbGVkIHRvIGluaXRpYWxpemUgaTJjIGNvbnRyb2xsZXJcbiIpOyBAQCAN
Cj4gPiAtMTE2MCw2ICsxNTAwLDcgQEAgc3RhdGljIGludCB0ZWdyYV9pMmNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSANCj4gPiAqcGRldikNCj4gPiAgZGlzYWJsZV9kaXZfY2xrOg0KPiA+
ICAJaWYgKGkyY19kZXYtPmlzX211bHRpbWFzdGVyX21vZGUpDQo+ID4gIAkJY2xrX2Rpc2FibGUo
aTJjX2Rldi0+ZGl2X2Nsayk7DQo+ID4gKwl0ZWdyYV9pMmNfcmVsZWFzZV9kbWEoaTJjX2Rldik7
DQo+DQo+IFBsZWFzZSB1c2UgInJlbGVhc2VfZG1hOiIgdmFyaWFudCB0aGF0IEkgc3VnZ2VzdGVk
IGluIHRoZSBjb21tZW50IHRvIHYxNCBiZWNhdXNlOg0KPg0KPiAxKSBJdCdzIGp1c3QgYSBnb29k
IChhbmQgY29tbW9uLXN0eWxlIGluIGtlcm5lbCkgdG9uZSB0byB1bndpbmQgZXJyb3JzIGhhbmRs
aW5nIGluIHRoZSBvcHBvc2l0ZSBvcmRlciwgaXQgbWFrZXMgY29kZSBtb3JlIHN0cmFpZ2h0IGZv
cndhcmQgYW5kIGhlbHBzIHRvIGF2b2lkIHNpbGx5IG1pc3Rha2VzLg0KPg0KPiAyKSBJdCBrZWVw
cyB0aGUgY3VycmVudCBjb2RlIGNvbnNpc3RlbnQgaW4gcmVnYXJkcyB0byBwcm9iZSBlcnJvci1o
YW5kbGluZy4NCj4NCg0KQ2FuIG1vdmUgdGVncmFfaTJjX3JlbGVhc2VfZG1hIHVuZGVyIHRoZSBz
YW1lIGRpc2FibGVfZGl2X2NsayBsYWJlbCBiZWZvcmUgY2xrX2Rpc2FibGUNCg0KT3JkZXIgaW4g
cHJvYmUgaXMNCgljbGtfcHJlcGFyZQ0KCWkyY19ydW50aW1lX3Jlc3VtZQ0KCWNsa19lbmFibGUg
aW4gY2FzZSBvZiBtdWx0aW1hc3RlciBtb2RlDQoJaTJjX2luaXRfZG1hDQoNCnVud2luZGluZyBz
aG91bGQgYmUgb3JkZXIgaXMNCglyZWxlYXNlX2RtYQ0KCWRpc2FibGVfZGl2X2Nsaw0KCWRpc2Fi
bGVfcnBtDQoJdW5wcmVwYXJlZA0KDQpQcm9iZSBmYWlsdXJlIGZyb20gdGVncmFfaTJjX2luaXRf
ZG1hLCB0ZWdyYV9pMmNfaW5pdCwgZGV2bV9yZXF1ZXN0X2lycSwgaTJjX2FkZF9udW1iZXJlZF9h
ZGFwdGVyIGFsbCBvZiB0aGVtIHBlcmZvcm0gZ290byBkaXNhYmxlX2Rpdl9jbGsNCg0KSSBjYW4g
YWRkIHRlZ3JhX2kyY19yZWxlYXNlX2RtYSBiZWZvcmUgcGVyZm9ybWluZyBjbG9jayBkaXNhYmxl
IHVuZGVyIHNhbWUgZGlzYWJsZV9kaXZfY2xrIHNvIGFsbCBleGlzdGluZyBkaXNhYmxlX2Rpdl9j
bGsgbGFiZWxzIHJlbWFpbiBzYW1lLg0KT3RoZXJ3aXNlIGFkZGluZyBuZXcgbGFiZWwgcmVsZWFz
ZV9kbWEgY2F1c2VzIGFsbCBnb3RvIGRpc2FibGVfZGl2X2NsayBzdGF0ZW1lbnQgYWxzbyB0byBi
ZSBjaGFuZ2VkIGJ1dCBpdHMgc2FtZSBhcyBhZGRpbmcgcmVsZWFzZV9kbWEgdW5kZXIgZGlzYWJs
ZV9kaXZfY2xrIGFib3ZlIHRoZSBjbGtfZGlzYWJsZS4NCg0KPiA+ICANCj4gPiAgZGlzYWJsZV9y
cG06DQo+ID4gIAlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+DQo+DQo+IFtzbmlw
XQ0KPg0KPiBQbGVhc2UgYWxzbyBhZGRyZXNzIG15IGNvbW1lbnQgdG8gdGhlICJmaXggbWF4aW11
bSB0cmFuc2ZlciBzaXplIiBwYXRjaC4gQW5kIHBsZWFzZSBhZGQgV29sZnJhbSBTYW5nIHRvIHRo
ZSBDQyBsaXN0Lg0KPg0KPiBMb29rcyBsaWtlIHYxNiBzaG91bGQgYmUgdGhlIGZpbmFsLCBzbyB3
aXRoIGV2ZXJ5dGhpbmcgYmVpbmcgYWRkcmVzc2VkOg0KPg0KPiBSZXZpZXdlZC1ieTogRG1pdHJ5
IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPg0KPiBUZXN0ZWQtYnk6IERtaXRyeSBPc2lwZW5r
byA8ZGlnZXR4QGdtYWlsLmNvbT4NCg0KDQo=
