Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C656C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50F62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CMgVxL5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfAUJh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:37:26 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38620 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfAUJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:37:26 -0500
X-IronPort-AV: E=Sophos;i="5.56,502,1539673200"; 
   d="scan'208";a="22846784"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Jan 2019 02:37:25 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 21 Jan 2019 02:37:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5D5mI93SZIikoPsQBmgC0+wDvabakb3w8/+y1cH8nU=;
 b=CMgVxL5zqtXqDE39XxLBlffNdXXrh8zQfZ1Fo9wlJxVtpdtuDLQmA8T4hhWEW08EAcfPnavFtWu1AitKsHVFnep+kp55uXAWO3P2UbaU78pqnFBVSo02yKLLYWvhHSvKItw+l1grUXwQ8PId8CDWFKPy5aUrqQsSRwe6TJeMk8o=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB0017.namprd11.prod.outlook.com (10.161.155.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Mon, 21 Jan 2019 09:37:24 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 09:37:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <purna.chandra.mandal@intel.com>, <f.blogs@napier.co.nz>,
        <boris.brezillon@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <dwmw2@infradead.org>,
        <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in
 STIG mode
Thread-Topic: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data
 in STIG mode
Thread-Index: AQHUk1NWYhjGe5LUyEiH2UgF0if0A6W5sxuA
Date:   Mon, 21 Jan 2019 09:37:24 +0000
Message-ID: <c627314d-fdf6-7e69-7c54-03a513f563fc@microchip.com>
References: <20181214021516.43609-1-purna.chandra.mandal@intel.com>
In-Reply-To: <20181214021516.43609-1-purna.chandra.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0028.eurprd05.prod.outlook.com
 (2603:10a6:803:1::41) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB0017;6:1FnJ3r3ybtRJPFNNPYRzxPm8JIUHzLjfZKsjV+ZYPgfaVHu4ZSBMyUrMwo1ALXlugkokN9v0+3fH3cLi4IFm5JYkWlINOMgzaDmWVYooO8uY/JSWyZZcAtwauMxCEXQerBoXKyWcLfhY/jChgZ7hMgtFlMTlAGW+0h6sGqwPSOngQ8jPoQUnoLLJTtmAP9YB54GB3uTguFXjyVFJ41RlrNkynmxk7mVGBH+YWlDEhFfb2NEcv48hzte9zkrKLRHm0lg/aRieyxZIKBpXaMJeRWfuwIYyBMA/3aNwyrCVYB+DuK1zgsXiM/voorJ7LYaUywFuAdKxnvY0r/0DQPtXXy+TZNNhhWAmuDsNapDkOsuWw9BXBrXYTunDOrUJ9qbY3HL5RjBJqn9xNn2WXkPERoNl4PoqBDgX41Hj6mz2JZQTDBXuonGjEIPDtnBtIfZgCL5WbU6A5h4u5OT+z12azg==;5:gG8fjpK4YVnaV6I6RUgBjX9g2nRrpSZuJiXRvDh59yTaAowfUQGUd0EnLQzcNWS0ixDJsNfzrGdyBMs7U6865+Ioeh0UR1tuN5NIfkPa89r4POczvqkU21fx9Er8OBAOUoCcJo8WQ/Wnwdnh4xkR/TsYHRhUXKwJovkgq+It6xUvgAOJ1qeqKeXdEDzuiC+y/WOGlgF6Y/xFhgCMA70okg==;7:zKuMT937JpMExSLFVWe5bxcW3rLDDn1ApGecF+eY7/N2IrcCCy+kXivgwocoOobUYXRCoMwA1Dpve+KYcZep3EOK96HdS8nZZregEzNtT4XYDpavbRRPXp/FhAcFhZirGRoFwTi7s+EXm0rar/dq7g==
x-ms-office365-filtering-correlation-id: 4487b4f6-eef3-49c7-3468-08d67f840c60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0017;
x-ms-traffictypediagnostic: BN6PR11MB0017:
x-microsoft-antispam-prvs: <BN6PR11MB0017DF1B48D1FC1A78BBBC63F09F0@BN6PR11MB0017.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(54906003)(31696002)(7416002)(36756003)(106356001)(99286004)(110136005)(86362001)(53936002)(316002)(97736004)(31686004)(72206003)(478600001)(6486002)(105586002)(8936002)(6512007)(229853002)(8676002)(2906002)(14454004)(6436002)(66066001)(68736007)(81156014)(81166006)(386003)(6506007)(102836004)(3846002)(76176011)(39060400002)(186003)(7736002)(305945005)(11346002)(26005)(2616005)(476003)(446003)(71190400001)(6246003)(4326008)(14444005)(71200400001)(6116002)(25786009)(52116002)(256004)(53546011)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0017;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DD0ZFCQ1CpITeeHdz9MfrKOio76LiVk36OBwTpQxEHaPhIP3Z1BtirvCDshx/SQb5pUn8V9kqamXRGaT5WhwNVo87b/EomfsZVL4iRTxriYQQeTeij6Dxd5b2rdfPMbv5FkkBTS1qJC+c11uknJuFjZy2gBRnM8nOoDMQb9JzS5qoXKhGGDKI9qTzF5VdSMJAVIPsSSZl7jZ1jT7jenN8Oa2vZh3ETLTKzDdF11+h6J73Ss/MXTingxdaUQd47hpH1pLTslFt7DN+Fg8PqWoCJ9jBBvnAyaR5+O9h6U16LgDapLhlnzbdJTcu6SSXr4fM1/kF6L8vVcnJKWshkfySwlMTMybnZeB0usxPeIgMGOWu9hgjLza88/trTdbtGHf4QbCbipZqsXFhh0gXlp12ST0ls/WASLKW8rYvZu47bg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B1B585C65BC6A40853F1315AD1E0952@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4487b4f6-eef3-49c7-3468-08d67f840c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 09:37:21.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0017
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFB1cm5hLA0KDQpPbiAxMi8xNC8yMDE4IDA0OjE1IEFNLCBQdXJuYSBDaGFuZHJhIE1hbmRh
bCB3cm90ZToNCj4gY2FkZW5jZS1xdWFkc3BpIGNvbnRyb2xsZXIgYWxsb3dzIHVwdG8gZWlnaHQg
Ynl0ZXMgb2YgZGF0YSB0byBiZSB0cmFuc2ZlcnJlZA0KPiBpbiBzb2Z0d2FyZSBUcmlnZ2VyZWQg
SW5zdHJ1Y3Rpb24gZ2VuZXJhdG9yIChTVElHKSBtb2RlIG9mIG9wZXJhdGlvbi4gTG93ZXINCj4g
NCBieXRlcyBhcmUgd3JpdHRlbiB0aHJvdWdoIHdyaXRlZGF0YWxvd2VyIGFuZCB1cHBlciA0IGJ5
dGVzIGJ5DQo+IHdyaXRlZGF0YXVwcGVyIHJlZ2lzdGVyLg0KDQpJcyB0aGlzIHN1cHBvcnRlZCBi
eSBhbGwgdmVyc2lvbnMgb2YgdGhlIElQPw0KDQo+IA0KPiBUaGlzIHBhdGNoIGFsbG93cyBhbGwg
dGhlIDggYnl0ZXMgdG8gYmUgd3JpdHRlbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFB1cm5hIENo
YW5kcmEgTWFuZGFsIDxwdXJuYS5jaGFuZHJhLm1hbmRhbEBpbnRlbC5jb20+DQo+IC0tLQ0KPiAN
Cj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMgfCA5ICsrKysrKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9jYWRlbmNlLXF1YWRzcGkuYw0KPiBpbmRleCAwNGNlZGQzYTJiZjYu
Ljk5MDkzNDM4N2ZlYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jYWRlbmNl
LXF1YWRzcGkuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5j
DQo+IEBAIC00MjAsNyArNDIwLDcgQEAgc3RhdGljIGludCBjcXNwaV9jb21tYW5kX3dyaXRlKHN0
cnVjdCBzcGlfbm9yICpub3IsIGNvbnN0IHU4IG9wY29kZSwNCj4gIAl1bnNpZ25lZCBpbnQgZGF0
YTsNCg0KSSBrbm93IHRoYXQgdGhpcyBpcyBub3QgeW91ciBjaGFuZ2UsIGJ1dCBkYXRhIHNob3Vs
ZCBiZSB1MzIgYW5kIG5vdCB1bnNpZ25lZA0KaW50LiByZWcgdG9vIC4uLiBwcm9iYWJseSBvbmUg
c2hvdWxkIHN1Ym1pdCBhIHBhdGNoIHRvIGNoYW5nZSB0aGlzLCBJIHNlZSB0aGF0DQp0aGUgc2Ft
ZSBlcnJvciBpcyBkb25lIGluIGNxc3BpX2NvbW1hbmRfcmVhZCgpLg0KDQo+ICAJaW50IHJldDsN
Cj4gIA0KPiAtCWlmIChuX3R4ID4gNCB8fCAobl90eCAmJiAhdHhidWYpKSB7DQo+ICsJaWYgKG5f
dHggPiBDUVNQSV9TVElHX0RBVEFfTEVOX01BWCB8fCAobl90eCAmJiAhdHhidWYpKSB7DQo+ICAJ
CWRldl9lcnIobm9yLT5kZXYsDQo+ICAJCQkiSW52YWxpZCBpbnB1dCBhcmd1bWVudCwgY21kbGVu
ICVkIHR4YnVmIDB4JXBcbiIsDQo+ICAJCQluX3R4LCB0eGJ1Zik7DQo+IEBAIC00MzUsOCArNDM1
LDEzIEBAIHN0YXRpYyBpbnQgY3FzcGlfY29tbWFuZF93cml0ZShzdHJ1Y3Qgc3BpX25vciAqbm9y
LCBjb25zdCB1OCBvcGNvZGUsDQo+ICAJCWRhdGEgPSAwOz4gIAkJbWVtY3B5KCZkYXRhLCB0eGJ1
Ziwgbl90eCk7DQoNCllvdSBzaG91bGQgbGltaXQgd2hhdCBpcyBjb3BpZWQgaW4gZGF0YSwgc2lt
aWxhciB0byB3aGF0IGlzIGRvbmUgaW4NCmNxc3BpX2NvbW1hbmRfcmVhZCgpOg0KDQp3cml0ZV9s
ZW4gPSAobl90eCA+IDQpID8gNCA6IG5fdHg7DQptZW1jcHkoJmRhdGEsIHR4YnVmLCB3cml0ZV9s
ZW4pOw0KdHhidWYgKz0gd3JpdGVfbGVuOw0KDQoNCg0KPiAgCQl3cml0ZWwoZGF0YSwgcmVnX2Jh
c2UgKyBDUVNQSV9SRUdfQ01EV1JJVEVEQVRBTE9XRVIpOw0KPiAtCX0NCj4gIA0KPiArCQlpZiAo
bl90eCA+IDQpIHsNCj4gKwkJCWRhdGEgPSAwOw0KYW5kIHRoZW46DQp3cml0ZV9sZW4gPSBuX3R4
IC0gNDsNCm1lbWNweSgmZGF0YSwgdHhidWYsIHdyaXRlX2xlbik7DQoNCkNoZWVycywNCnRhDQoN
Cj4gKwkJCW1lbWNweSgmZGF0YSwgdHhidWYgKyA0LCBuX3R4IC0gNCk7DQo+ICsJCQl3cml0ZWwo
ZGF0YSwgcmVnX2Jhc2UgKyBDUVNQSV9SRUdfQ01EV1JJVEVEQVRBVVBQRVIpOw0KPiArCQl9DQo+
ICsJfQ0KPiAgCXJldCA9IGNxc3BpX2V4ZWNfZmxhc2hfY21kKGNxc3BpLCByZWcpOw0KPiAgCXJl
dHVybiByZXQ7DQo+ICB9DQo+IA0K
