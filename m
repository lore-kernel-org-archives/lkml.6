Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDC520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jzxnPxOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfBYQq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:46:57 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:21569 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfBYQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:46:56 -0500
X-IronPort-AV: E=Sophos;i="5.58,411,1544511600"; 
   d="scan'208";a="26850550"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Feb 2019 09:46:26 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Feb 2019 09:44:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+mKEqtAHsmqeHMNpTNGLDKtNel51wxJhQW2dKFIUUg=;
 b=jzxnPxOZbhH21g26n50wJIy4SeB4OdRyw1ihmkTJkNDE2b69/u0ivFmBFxciOCyO9X9TlqGoi8z4xOimXyZSFEg+sD3E5kg/M5Mzg6hYBCCfHE7dRMo8dGj4MpPgJel+x+BV7oZ+iXB0QrkqvVUtTPomNZ9s0CXbE44ykv+plFY=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 16:44:34 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:44:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 1/5] pwm: atmel: add struct atmel_pwm_data
Thread-Topic: [PATCH v3 1/5] pwm: atmel: add struct atmel_pwm_data
Thread-Index: AQHUzSliQ2KmCLJyZE2AEuVad3ALHQ==
Date:   Mon, 25 Feb 2019 16:44:33 +0000
Message-ID: <1551113039-937-2-git-send-email-claudiu.beznea@microchip.com>
References: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c2a659d-f441-4dbd-8f49-08d69b408521
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1662;
x-ms-traffictypediagnostic: MWHPR11MB1662:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxNjYyOzIzOll6OWlpRjloTDlhdjVDcHpwYVlXSlFvQ016?=
 =?utf-8?B?ZjRZa0NoeWlCZmxVeEVJWkU5dTQ3RFU2T1RDKzFkUk1ZSEVmN0l1WU5uWUc3?=
 =?utf-8?B?VEtOWXQ4UDZsRzhZUnRvazBvVml3NlNhSC9NcGlCMlVSYTlhNDNFYUdDSjdM?=
 =?utf-8?B?MEpnK3JGdDZpT0NKR01Mc0VuTVNaaTVGZzJuMWFMb1RjMnAwQlUxeW1mUE1t?=
 =?utf-8?B?QWttUnBhS3RtWU9TVDcrZ3NUSVlBMjh6d2JwbU9YdnJMbmtkOCtkblBnZTJm?=
 =?utf-8?B?K1BhekxKbEFSbVprQVJ3cU9nNjFDbE5pRkFoYTBqLzY2TGd6LytCQ2Z3ZHV5?=
 =?utf-8?B?UFdIMEhWR0c3WHdKaTB1OG5vcWpxUHQ3OW43U1RZK1JGK1hObkY1VGJHckNh?=
 =?utf-8?B?Y0pyZWJxWjZYTU1tVXRkV0FwVzhJcElpaCtFeXBqRHdYbTJSays4TjM2RlFB?=
 =?utf-8?B?bWhoZVpBSnc1UytldTJER2NPMTdqOFZwNUdqQkQrbit4R1JJVURYckxtTk1D?=
 =?utf-8?B?NGp0aVBtTTlsL0cwS1JRSGhZNUthdDVvUkhLRVNjRWxUdk9wcWVPbmNnZ3lX?=
 =?utf-8?B?TG0yeVVpTVVPM0JvZHdLVjVHWHFCcGFFRGVoVmVyWDhZSE95TDNscHcyZVdt?=
 =?utf-8?B?RSsvUXZ1MCs4MUE4QjRmZDlQaEU2SGUzbEg0cnpneFh5cGZURkkvamx1TmVa?=
 =?utf-8?B?NUFzaDlPQVZiYmJpdEljWUNSMEtmRjc3QXgwUFRFQ1RhL3EzMGFlSGc4OC9E?=
 =?utf-8?B?QXhYZ3owbUI0NFVvelNJdUIzTENHWTViamFrZndvcG5PNEtmOUxTaHM3NzFR?=
 =?utf-8?B?Q2tydVFISEUrWTdrcGxCUFBJY3Y5dXYweDg4bzJUQUc0bktJemZNZGd0cWpR?=
 =?utf-8?B?Y2dOTHFHZmJYVlM3bVRGaS9vakZ0akR6cDVLdFRYRktYR0ptY3lhcGpXd3ZH?=
 =?utf-8?B?S0JQT2hvYlkxazU0bDdVMFlqRnhKS1dpL2xaN1Z3bzBPd2NZaFR5UENZakdh?=
 =?utf-8?B?NGRTMHRmTXptNjhJL0NHS2Zxd2pySGVaemRDM0xNL2p4QWZCNlFkcjVFVGFE?=
 =?utf-8?B?cGVaN0pYRlFmQWEyeFE4aWVwcjVlZlZTU1hmeTJGU3JkRkJtU2pxeU1PdGlE?=
 =?utf-8?B?TVh4enpLcVR4YkpQMysxWHVySGRxc1lRdXJMVG45eWI1ZEl4TzdGbGR3ZWFV?=
 =?utf-8?B?bmcydDBldEZJV3hGQTdaSTFwVUJWWFZWcTQxelVmL1NYLzF5MGVFVnprN2R0?=
 =?utf-8?B?V0dtMHVSNjRCeFhMZTRVVEYwTkxVNVo2Qy8xckFsYmRaYXdkVy9TNG1oZE1B?=
 =?utf-8?B?TTNxK2RKMDgzTm9oVFdlbnkrOW9RWXUzZmp3b2RNQlBLWGhxRHBlNUlRQks0?=
 =?utf-8?B?RGg4YStyeS9xcGVxdElMS3VJNm5IQTdiUkFLT2xYamxIL0x2Qnk0TWcrT3E1?=
 =?utf-8?B?R0R1b2RGZE5VWEwyaS80YlZBRDQ4ei9mU3A0K0pWMzY5eVVFZjJlbXg4Rlha?=
 =?utf-8?B?cjh4dEwzY3JNUk5Oby92dDRyUWNXNVQ5MHJYZFJPSmVTRHVmUU9xWkRCeHQ1?=
 =?utf-8?B?RnZXRmpWaFhqcUVENnN6WEtPS2NvM2NpTzZKME1KMk1pclZFM0p5OEptakRB?=
 =?utf-8?B?cHlFTklIMW9veUJaNElsYnpXc1JpZktGWmtYenR2MFU0a25TZ3NHVjdmcUp4?=
 =?utf-8?B?bjJmUVdsT2w5M21tYnZXSzBuMlQycGVEdGhmZVBxcmdmQXVlKzZQaEE0SkUx?=
 =?utf-8?Q?HeGc0Wu79TRYPh6iSUT+xXjAgScqz5mwb+6UU=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB1662CCCA1A4DFD26EF493B01877A0@MWHPR11MB1662.namprd11.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(68736007)(2501003)(97736004)(5660300002)(105586002)(106356001)(66574012)(36756003)(14444005)(256004)(110136005)(54906003)(316002)(86362001)(99286004)(6636002)(52116002)(76176011)(66066001)(446003)(2616005)(476003)(72206003)(6512007)(6506007)(11346002)(386003)(6116002)(3846002)(50226002)(14454004)(478600001)(8676002)(81166006)(81156014)(486006)(8936002)(53936002)(6486002)(107886003)(305945005)(71190400001)(71200400001)(6436002)(102836004)(186003)(4326008)(25786009)(26005)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1662;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A5zlhL7jQt4TzWm4oCyBMPtxNUo7U5Z3uZ9Xu+OlDau463jN2Rz63iOpnzOboAYrV+RQFAXXtHUnGOhsqwgHZF2BV9unBNy+ezhlnkM4QlWFuh1wZe4R19AExh6ondrDp/2K5PsEoAKHkFxAFj8fuXcJ1yM7pmSCXM5cRJUCshoHtL++bIaPp0sxWEzlE1Z1A1OwO3Cp8A1f5XZreZL5rolVU/rjyXJgxrPSb9woi390AQNri8a46ePEUunqqs/+2GALGSbII2ptzCJKguboEx4GpcqwtUsAUaT9uyxQHfVhmbIGQ37658FkT8chgE3YruT7X+6PHEW2Fe9BRtp3uGJSjuENyX6RZshoseRBMCF7yqZcFtl02Bf4IuDaE23sXtdNMHjbksrf5gFNCkPBoV8HVBxF2Gxc+fcSLCBu0Nk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EAD1B03EC6BE242B11644AC315A7519@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2a659d-f441-4dbd-8f49-08d69b408521
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:44:30.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1662
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBzdHJ1Y3QgYXRtZWxfcHdtX2RhdGEgdG8gZW1iZWQgZGlmZmVyZW50IHBlciBjb250cm9sbGVy
IGluZm9ybWF0aW9uLg0KSXQgcHJlcGFyZXMgYWRkaW5nIHN1cHBvcnQgZm9yIGFub3RoZXIgc2lt
aWxhciBjb250cm9sbGVyIHRoYXQgbmVlZHMNCmFkZGl0aW9uYWwgaW5mb3JtYXRpb24uIEF0IHRo
aXMgc3RhZ2UsIGVtYmVkIGEgbWVtYmVyIG9mIHR5cGUgc3RydWN0DQphdG1lbF9wd21fcmVnaXN0
ZXJzIGluIGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWFAbWljcm9jaGlwLmNvbT4NCkFja2VkLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUt
a29lbmlnQHBlbmd1dHJvbml4LmRlPg0KLS0tDQogZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgfCA2
NCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0K
aW5kZXggNTMwZDdkYzVmMWI1Li43ZTg2YTUyNjZlYjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3B3
bS9wd20tYXRtZWwuYw0KKysrIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMNCkBAIC02NSwxMSAr
NjUsMTUgQEAgc3RydWN0IGF0bWVsX3B3bV9yZWdpc3RlcnMgew0KIAl1OCBkdXR5X3VwZDsNCiB9
Ow0KIA0KK3N0cnVjdCBhdG1lbF9wd21fZGF0YSB7DQorCXN0cnVjdCBhdG1lbF9wd21fcmVnaXN0
ZXJzIHJlZ3M7DQorfTsNCisNCiBzdHJ1Y3QgYXRtZWxfcHdtX2NoaXAgew0KIAlzdHJ1Y3QgcHdt
X2NoaXAgY2hpcDsNCiAJc3RydWN0IGNsayAqY2xrOw0KIAl2b2lkIF9faW9tZW0gKmJhc2U7DQot
CWNvbnN0IHN0cnVjdCBhdG1lbF9wd21fcmVnaXN0ZXJzICpyZWdzOw0KKwljb25zdCBzdHJ1Y3Qg
YXRtZWxfcHdtX2RhdGEgKmRhdGE7DQogDQogCXVuc2lnbmVkIGludCB1cGRhdGVkX3B3bXM7DQog
CS8qIElTUiBpcyBjbGVhcmVkIHdoZW4gcmVhZCwgZW5zdXJlIG9ubHkgb25lIHRocmVhZCBkb2Vz
IHRoYXQgKi8NCkBAIC0xNTAsMTUgKzE1NCwxNSBAQCBzdGF0aWMgdm9pZCBhdG1lbF9wd21fdXBk
YXRlX2NkdHkoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0K
IAlzdHJ1Y3QgYXRtZWxfcHdtX2NoaXAgKmF0bWVsX3B3bSA9IHRvX2F0bWVsX3B3bV9jaGlwKGNo
aXApOw0KIAl1MzIgdmFsOw0KIA0KLQlpZiAoYXRtZWxfcHdtLT5yZWdzLT5kdXR5X3VwZCA9PQ0K
LQkgICAgYXRtZWxfcHdtLT5yZWdzLT5wZXJpb2RfdXBkKSB7DQorCWlmIChhdG1lbF9wd20tPmRh
dGEtPnJlZ3MuZHV0eV91cGQgPT0NCisJICAgIGF0bWVsX3B3bS0+ZGF0YS0+cmVncy5wZXJpb2Rf
dXBkKSB7DQogCQl2YWwgPSBhdG1lbF9wd21fY2hfcmVhZGwoYXRtZWxfcHdtLCBwd20tPmh3cHdt
LCBQV01fQ01SKTsNCiAJCXZhbCAmPSB+UFdNX0NNUl9VUERfQ0RUWTsNCiAJCWF0bWVsX3B3bV9j
aF93cml0ZWwoYXRtZWxfcHdtLCBwd20tPmh3cHdtLCBQV01fQ01SLCB2YWwpOw0KIAl9DQogDQog
CWF0bWVsX3B3bV9jaF93cml0ZWwoYXRtZWxfcHdtLCBwd20tPmh3cHdtLA0KLQkJCSAgICBhdG1l
bF9wd20tPnJlZ3MtPmR1dHlfdXBkLCBjZHR5KTsNCisJCQkgICAgYXRtZWxfcHdtLT5kYXRhLT5y
ZWdzLmR1dHlfdXBkLCBjZHR5KTsNCiB9DQogDQogc3RhdGljIHZvaWQgYXRtZWxfcHdtX3NldF9j
cHJkX2NkdHkoc3RydWN0IHB3bV9jaGlwICpjaGlwLA0KQEAgLTE2OCw5ICsxNzIsOSBAQCBzdGF0
aWMgdm9pZCBhdG1lbF9wd21fc2V0X2NwcmRfY2R0eShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsDQog
CXN0cnVjdCBhdG1lbF9wd21fY2hpcCAqYXRtZWxfcHdtID0gdG9fYXRtZWxfcHdtX2NoaXAoY2hp
cCk7DQogDQogCWF0bWVsX3B3bV9jaF93cml0ZWwoYXRtZWxfcHdtLCBwd20tPmh3cHdtLA0KLQkJ
CSAgICBhdG1lbF9wd20tPnJlZ3MtPmR1dHksIGNkdHkpOw0KKwkJCSAgICBhdG1lbF9wd20tPmRh
dGEtPnJlZ3MuZHV0eSwgY2R0eSk7DQogCWF0bWVsX3B3bV9jaF93cml0ZWwoYXRtZWxfcHdtLCBw
d20tPmh3cHdtLA0KLQkJCSAgICBhdG1lbF9wd20tPnJlZ3MtPnBlcmlvZCwgY3ByZCk7DQorCQkJ
ICAgIGF0bWVsX3B3bS0+ZGF0YS0+cmVncy5wZXJpb2QsIGNwcmQpOw0KIH0NCiANCiBzdGF0aWMg
dm9pZCBhdG1lbF9wd21fZGlzYWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21f
ZGV2aWNlICpwd20sDQpAQCAtMjI1LDcgKzIyOSw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfcHdtX2Fw
cGx5KHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJCSAg
ICBjc3RhdGUucG9sYXJpdHkgPT0gc3RhdGUtPnBvbGFyaXR5ICYmDQogCQkgICAgY3N0YXRlLnBl
cmlvZCA9PSBzdGF0ZS0+cGVyaW9kKSB7DQogCQkJY3ByZCA9IGF0bWVsX3B3bV9jaF9yZWFkbChh
dG1lbF9wd20sIHB3bS0+aHdwd20sDQotCQkJCQkJICBhdG1lbF9wd20tPnJlZ3MtPnBlcmlvZCk7
DQorCQkJCQkJICBhdG1lbF9wd20tPmRhdGEtPnJlZ3MucGVyaW9kKTsNCiAJCQlhdG1lbF9wd21f
Y2FsY3VsYXRlX2NkdHkoc3RhdGUsIGNwcmQsICZjZHR5KTsNCiAJCQlhdG1lbF9wd21fdXBkYXRl
X2NkdHkoY2hpcCwgcHdtLCBjZHR5KTsNCiAJCQlyZXR1cm4gMDsNCkBAIC0yNzcsMjcgKzI4MSwz
MSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHB3bV9vcHMgYXRtZWxfcHdtX29wcyA9IHsNCiAJLm93
bmVyID0gVEhJU19NT0RVTEUsDQogfTsNCiANCi1zdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX3B3
bV9yZWdpc3RlcnMgYXRtZWxfcHdtX3JlZ3NfdjEgPSB7DQotCS5wZXJpb2QJCT0gUFdNVjFfQ1BS
RCwNCi0JLnBlcmlvZF91cGQJPSBQV01WMV9DVVBELA0KLQkuZHV0eQkJPSBQV01WMV9DRFRZLA0K
LQkuZHV0eV91cGQJPSBQV01WMV9DVVBELA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXRtZWxfcHdt
X2RhdGEgYXRtZWxfcHdtX2RhdGFfdjEgPSB7DQorCS5yZWdzID0gew0KKwkJLnBlcmlvZAkJPSBQ
V01WMV9DUFJELA0KKwkJLnBlcmlvZF91cGQJPSBQV01WMV9DVVBELA0KKwkJLmR1dHkJCT0gUFdN
VjFfQ0RUWSwNCisJCS5kdXR5X3VwZAk9IFBXTVYxX0NVUEQsDQorCX0sDQogfTsNCiANCi1zdGF0
aWMgY29uc3Qgc3RydWN0IGF0bWVsX3B3bV9yZWdpc3RlcnMgYXRtZWxfcHdtX3JlZ3NfdjIgPSB7
DQotCS5wZXJpb2QJCT0gUFdNVjJfQ1BSRCwNCi0JLnBlcmlvZF91cGQJPSBQV01WMl9DUFJEVVBE
LA0KLQkuZHV0eQkJPSBQV01WMl9DRFRZLA0KLQkuZHV0eV91cGQJPSBQV01WMl9DRFRZVVBELA0K
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXRtZWxfcHdtX2RhdGEgYXRtZWxfcHdtX2RhdGFfdjIgPSB7
DQorCS5yZWdzID0gew0KKwkJLnBlcmlvZAkJPSBQV01WMl9DUFJELA0KKwkJLnBlcmlvZF91cGQJ
PSBQV01WMl9DUFJEVVBELA0KKwkJLmR1dHkJCT0gUFdNVjJfQ0RUWSwNCisJCS5kdXR5X3VwZAk9
IFBXTVYyX0NEVFlVUEQsDQorCX0sDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRm
b3JtX2RldmljZV9pZCBhdG1lbF9wd21fZGV2dHlwZXNbXSA9IHsNCiAJew0KIAkJLm5hbWUgPSAi
YXQ5MXNhbTlybC1wd20iLA0KLQkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSZhdG1l
bF9wd21fcmVnc192MSwNCisJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkmYXRtZWxf
cHdtX2RhdGFfdjEsDQogCX0sIHsNCiAJCS5uYW1lID0gInNhbWE1ZDMtcHdtIiwNCi0JCS5kcml2
ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkmYXRtZWxfcHdtX3JlZ3NfdjIsDQorCQkuZHJpdmVy
X2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpJmF0bWVsX3B3bV9kYXRhX3YyLA0KIAl9LCB7DQogCQkv
KiBzZW50aW5lbCAqLw0KIAl9LA0KQEAgLTMwNywyMCArMzE1LDIwIEBAIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUocGxhdGZvcm0sIGF0bWVsX3B3bV9kZXZ0eXBlcyk7DQogc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgYXRtZWxfcHdtX2R0X2lkc1tdID0gew0KIAl7DQogCQkuY29tcGF0aWJs
ZSA9ICJhdG1lbCxhdDkxc2FtOXJsLXB3bSIsDQotCQkuZGF0YSA9ICZhdG1lbF9wd21fcmVnc192
MSwNCisJCS5kYXRhID0gJmF0bWVsX3B3bV9kYXRhX3YxLA0KIAl9LCB7DQogCQkuY29tcGF0aWJs
ZSA9ICJhdG1lbCxzYW1hNWQzLXB3bSIsDQotCQkuZGF0YSA9ICZhdG1lbF9wd21fcmVnc192MiwN
CisJCS5kYXRhID0gJmF0bWVsX3B3bV9kYXRhX3YyLA0KIAl9LCB7DQogCQkuY29tcGF0aWJsZSA9
ICJhdG1lbCxzYW1hNWQyLXB3bSIsDQotCQkuZGF0YSA9ICZhdG1lbF9wd21fcmVnc192MiwNCisJ
CS5kYXRhID0gJmF0bWVsX3B3bV9kYXRhX3YyLA0KIAl9LCB7DQogCQkvKiBzZW50aW5lbCAqLw0K
IAl9LA0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYXRtZWxfcHdtX2R0X2lkcyk7DQog
DQotc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgYXRtZWxfcHdtX3JlZ2lzdGVycyAqDQorc3Rh
dGljIGlubGluZSBjb25zdCBzdHJ1Y3QgYXRtZWxfcHdtX2RhdGEgKg0KIGF0bWVsX3B3bV9nZXRf
ZHJpdmVyX2RhdGEoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCWNvbnN0IHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgKmlkOw0KQEAgLTMzMCwxOCArMzM4LDE4IEBAIGF0bWVs
X3B3bV9nZXRfZHJpdmVyX2RhdGEoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJ
aWQgPSBwbGF0Zm9ybV9nZXRfZGV2aWNlX2lkKHBkZXYpOw0KIA0KLQlyZXR1cm4gKHN0cnVjdCBh
dG1lbF9wd21fcmVnaXN0ZXJzICopaWQtPmRyaXZlcl9kYXRhOw0KKwlyZXR1cm4gKHN0cnVjdCBh
dG1lbF9wd21fZGF0YSAqKWlkLT5kcml2ZXJfZGF0YTsNCiB9DQogDQogc3RhdGljIGludCBhdG1l
bF9wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQotCWNvbnN0IHN0
cnVjdCBhdG1lbF9wd21fcmVnaXN0ZXJzICpyZWdzOw0KKwljb25zdCBzdHJ1Y3QgYXRtZWxfcHdt
X2RhdGEgKmRhdGE7DQogCXN0cnVjdCBhdG1lbF9wd21fY2hpcCAqYXRtZWxfcHdtOw0KIAlzdHJ1
Y3QgcmVzb3VyY2UgKnJlczsNCiAJaW50IHJldDsNCiANCi0JcmVncyA9IGF0bWVsX3B3bV9nZXRf
ZHJpdmVyX2RhdGEocGRldik7DQotCWlmICghcmVncykNCisJZGF0YSA9IGF0bWVsX3B3bV9nZXRf
ZHJpdmVyX2RhdGEocGRldik7DQorCWlmICghZGF0YSkNCiAJCXJldHVybiAtRU5PREVWOw0KIA0K
IAlhdG1lbF9wd20gPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCphdG1lbF9wd20p
LCBHRlBfS0VSTkVMKTsNCkBAIC0zNzMsNyArMzgxLDcgQEAgc3RhdGljIGludCBhdG1lbF9wd21f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJYXRtZWxfcHdtLT5jaGlw
LmJhc2UgPSAtMTsNCiAJYXRtZWxfcHdtLT5jaGlwLm5wd20gPSA0Ow0KLQlhdG1lbF9wd20tPnJl
Z3MgPSByZWdzOw0KKwlhdG1lbF9wd20tPmRhdGEgPSBkYXRhOw0KIAlhdG1lbF9wd20tPnVwZGF0
ZWRfcHdtcyA9IDA7DQogCW11dGV4X2luaXQoJmF0bWVsX3B3bS0+aXNyX2xvY2spOw0KIA0KLS0g
DQoyLjcuNA0KDQo=
