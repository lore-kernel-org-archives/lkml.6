Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A174ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD7420870
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="lXpMMl1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD7420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbeGLUkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:40:07 -0400
Received: from mail-eopbgr10100.outbound.protection.outlook.com ([40.107.1.100]:56194
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732409AbeGLUkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UUgtXfi9p8l6F/RuxDKyPCmavuCe+0z3OvW+rB3hto=;
 b=lXpMMl1oFWCWV4D8ilT8VbV8WV12ZtaN/IzXWbPc7ANinCpgCKTm3ivgO8fw7bvknjQvD7ssR4ttXNNWvxGdtHq2R7zbkOvB1Owlno1zJe+WEPK5a+1/gxVVNJnvd+nFIVe93LnaJf2yyF8f71ubtnR6MI1KvQw82AIH7zj5iUM=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB1966.eurprd05.prod.outlook.com (10.166.45.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 20:28:50 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5570:f225:bd5b:1aa3%10]) with mapi id 15.20.0930.022; Thu, 12 Jul
 2018 20:28:49 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "tszucs@protonmail.ch" <tszucs@protonmail.ch>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [RESEND PATCH] mmc: tegra: enable ddr_signaling for
 MMC_TIMING_MMC_DDR52
Thread-Topic: [RESEND PATCH] mmc: tegra: enable ddr_signaling for
 MMC_TIMING_MMC_DDR52
Thread-Index: AQHUGh7w5GoOr5ujmk+uLwrFv580yA==
Date:   Thu, 12 Jul 2018 20:28:49 +0000
Message-ID: <1531427327.5479.4.camel@toradex.com>
References: <20180712173837.2921-1-tszucs@protonmail.ch>
In-Reply-To: <20180712173837.2921-1-tszucs@protonmail.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB1966;7:65zM6LObXoDDmHKtaV09OLkiTA7p8LHyL/AasXJBIG7fx6BrrgCgw4vClBjTTCTfLZAX7DqA9HAaG7RMRJJ1Vq6mdvzP7GgtSuHssApOsY0bD3CeZdTpVsYYn8FdTtst0Ejf7Jd/Jc7S9Xm8K+T1S0Qv1ZFBSbno4wIQII6ntnP5nzp0vh8YVeyyqLd+hBduyCqRCk0WaxKToOw3vV+5CsO1bSfRRe/7JYu6dZ0WCn7xPcFxBf8SmzWbrdInKesO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4edc8b02-b44c-401c-2a08-08d5e83613bd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB1966;
x-ms-traffictypediagnostic: VI1PR0501MB1966:
x-microsoft-antispam-prvs: <VI1PR0501MB196614CF156E41F479C2F8A2FB590@VI1PR0501MB1966.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB1966;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB1966;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39850400004)(136003)(396003)(366004)(189003)(199004)(8676002)(2906002)(6512007)(106356001)(8936002)(81166006)(81156014)(36756003)(5660300001)(6306002)(39060400002)(53936002)(66066001)(6436002)(6246003)(14444005)(5250100002)(256004)(86362001)(54906003)(2501003)(99286004)(6116002)(3846002)(105586002)(110136005)(15760500003)(316002)(97736004)(2201001)(2900100001)(103116003)(14454004)(186003)(478600001)(2616005)(68736007)(486006)(476003)(44832011)(7736002)(6486002)(229853002)(25786009)(4326008)(11346002)(305945005)(446003)(966005)(26005)(76176011)(6506007)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB1966;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SI1dlTjqY6oUeQUjRcKFLhtM1JHIRNYpbLSoUyORZaJnnxZFDU/m9NyTYdYTpDBOOKWeAlitSpfV8dgLHoourx7tDMlWHYlwCou8YYpRwHAJ9ep4Jabg8kP23CC5OKoemlrz68bPTRHcd2Ij0M2fU2v0d35R7lGRakI96mn7229RmAvX70ZBwgPEHJ0hgMJf3A2DWKuKK6fP0GmskChovjKy/Mrg1DRVzg+/fvnNmXPd2YNS1PDnO+fGnKUkTV2VHcC8XjUE7U5eB6n2J0qR+rO02+/0Szk4MvV41aTUy2LVr9sqY7cHE/ThuUewbI1EG6PfZ9PJPP1xiiE8U5RkncqmnzUexRLX7V99/ZJEhNw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8534ED6D00B8544AD6A779A03A07E15@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edc8b02-b44c-401c-2a08-08d5e83613bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 20:28:49.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB1966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTEyIGF0IDE5OjM4ICswMjAwLCBUYW3DoXMgU3rFsWNzIHdyb3RlOg0K
PiBUaGlzIGZpeGVzIHNhbXBsaW5nIGVycm9ycyB3aXRoIGVNTUMgbW9kdWxlcyB1c2luZyBERFI1
MiB3aGVuIGhvc3QNCj4gY2FwYWJpbGl0aWVzDQo+IHZpYSBzZXR0aW5nIE5WUVVJUktfRU5BQkxF
X0REUjUwIGFuZCBOVlFVSVJLX0VOQUJMRV9TREhDSV9TUEVDXzMwMA0KPiBhcmUgZW5hYmxlZC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRhbcOhcyBTesWxY3MgPHRzenVjc0Bwcm90b25tYWlsLmNo
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYyBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktDQo+IHRlZ3JhLmMNCj4gaW5kZXggOTcwZDM4ZjY4OTM5Li5hM2JmYWE3MDY3YzggMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYw0KPiArKysgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXRlZ3JhLmMNCj4gQEAgLTIyOCw3ICsyMjgsNyBAQCBzdGF0aWMg
dm9pZCB0ZWdyYV9zZGhjaV9zZXRfdWhzX3NpZ25hbGluZyhzdHJ1Y3QNCj4gc2RoY2lfaG9zdCAq
aG9zdCwNCj4gIAlzdHJ1Y3Qgc2RoY2lfcGx0Zm1faG9zdCAqcGx0Zm1faG9zdCA9IHNkaGNpX3By
aXYoaG9zdCk7DQo+ICAJc3RydWN0IHNkaGNpX3RlZ3JhICp0ZWdyYV9ob3N0ID0NCj4gc2RoY2lf
cGx0Zm1fcHJpdihwbHRmbV9ob3N0KTsNCj4gIA0KPiAtCWlmICh0aW1pbmcgPT0gTU1DX1RJTUlO
R19VSFNfRERSNTApDQo+ICsJaWYgKHRpbWluZyA9PSBNTUNfVElNSU5HX1VIU19ERFI1MCB8fCB0
aW1pbmcgPT0NCj4gTU1DX1RJTUlOR19NTUNfRERSNTIpDQo+ICAJCXRlZ3JhX2hvc3QtPmRkcl9z
aWduYWxpbmcgPSB0cnVlOw0KPiAgDQo+ICAJc2RoY2lfc2V0X3Voc19zaWduYWxpbmcoaG9zdCwg
dGltaW5nKTsNCg0KVGhpcyBpcyByZWFsbHkgYSBkdXBsaWNhdGUgb2YgU3RlZmFuJ3MgIltQQVRD
SCAyLzNdIG1tYzogdGVncmE6IGZpeCBlTU1DIEREUjUyDQptb2RlIiBbMV0gcmVzcC4gU3RlZmFu
J3MgaXMgYSBkdXBsaWNhdGUgb2YgVGFtw6FzJy4gV2UgbWlzc2VkIGl0IGFzIGl0IHNvbWVob3cN
CmJvdW5jZWQgdGhlIHRlZ3JhIG1haWxpbmcgbGlzdC4gV2UgYmFzaWNhbGx5IGludmVzdGlnYXRl
ZCB0aGlzIHVwb24gVGFtw6FzJw0KcmVxdWVzdCAodS1ibG94IGJlaW5nIG91ciBjdXN0b21lcikg
bW9yZSBvciBsZXNzIGluIHBhcmFsbGVsLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8yMDE4MDcxMjA3MzkwNC40NzA1LTItc3RlZmFuQGFnbmVyLmNo
