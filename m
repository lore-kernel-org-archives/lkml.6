Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC955C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E092146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="spe9u7FF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfBTKUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:20:50 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:60038 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBTKUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:20:49 -0500
X-IronPort-AV: E=Sophos;i="5.58,390,1544511600"; 
   d="scan'208";a="26993849"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 03:20:33 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 03:20:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhvdK+nH6s+2IcrGT6mwajxyhVA30VoPB7BQuVV164o=;
 b=spe9u7FFYoZi0q/t+RCs/KumMgCfYyiufARyqVYSgtZ4jw9ejesA0UZ40d+hPTdaUsNSTXosX9z63fOMk9vPgwTJhJPqZPcurrAgs2NOAfx+sSzFIwRyz4BvI5hCZQxs9gXYeUZ1+9nEHh6lKSvun8atsz+7fjKoS2UH8NcbHaw=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1360.namprd11.prod.outlook.com (10.169.235.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 20 Feb 2019 10:20:28 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 10:20:28 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>
CC:     <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Thread-Topic: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Thread-Index: AQHUyQXmTxM0lGKi0EWSxBvx5w6KNw==
Date:   Wed, 20 Feb 2019 10:20:28 +0000
Message-ID: <c0688a84-bd8e-1874-6fab-727bb6bd657e@microchip.com>
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::28) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c953a26f-a962-4fa6-55b4-08d6971d092f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1360;
x-ms-traffictypediagnostic: MWHPR11MB1360:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMzYwOzIzOnJ3OEcyK0NIQllnelNMMGJLdkFNNVQ2Wjha?=
 =?utf-8?B?bWFLR1ZwNVRWN2V1eklVVnZ6Y2xvMWdIMVVhdkw3OUxBYUtBbE80QmtuVldD?=
 =?utf-8?B?cDl4RlNvNHl0M2VyUHlPYVVwVzI5blQwZDBCR2N3dVI5NkwwQzZUMVl6RnRn?=
 =?utf-8?B?dVhSNTRQVk4yNHd3S0ZEaGtwRTI5ZngzN04rWEo2TnpGTWJkL1kreFYybFlO?=
 =?utf-8?B?YkUzUDVFOExnR2lvUmRtTUxKd0RTbWRnSmdVWlVnZHV4Qk5IcEVCS2JZQ044?=
 =?utf-8?B?ZjRxeGtwa1VSL01icG1KeUhGemoxU3BVZ1RXa1pjTzBicWlKRTlLdHpqbjRT?=
 =?utf-8?B?TS9Qc0p6RUR1QTZsdThsYlRKUkZqR3ZKejdiZjRLd2NnMGNoanZuTGFJU3A4?=
 =?utf-8?B?ZENDbFFpUUZwVnoybUhTaGErUnFrRXNFemdlT0MyK1ZINzRPaTllb25MaXZu?=
 =?utf-8?B?dlVNSUdBRUNEcHIra2J2OWdMcU1BbUpZRzBvemZFWVBidFpneXUwbGt2K0tP?=
 =?utf-8?B?MTc4aHJIL01yYXpQR2o4eTQrTmdzVW9TVnAwUlBkOW9odWFzb2txZ3RpbzNw?=
 =?utf-8?B?OUJHZS92b3c2UWY5L0ZvT1ZBTkNhamcyajlWN2lKUEVhWEdkT1lsTkpHZG5Q?=
 =?utf-8?B?d2RUS1BiOVJLSXR5d083MmFwTTE3ei9jSjBVZ050a3hWYTJ1SitTdkFjTzdF?=
 =?utf-8?B?NlFuK2VldFl6djdDZjluQmxVeUxCZHBjclc3ems5SVgzbWUyVmFMVXp4M2VN?=
 =?utf-8?B?c0E4S3hWMFc3b2ZORjd0Qnh4SmxIRFVqeUFDWmF1QjBZK0lrQVFjRVpUNmNo?=
 =?utf-8?B?VllGKzFUQ29JMy9JNlpZN3FUcVBVcEZpNE5RRmJzcjV2U1FKNmtVaEdIV2p5?=
 =?utf-8?B?dlNzdHloc1JNRjZPV0U5NzB4eE5Dc1lqZk1sQWRCdzVjUXJCUFhQUWJLZHQv?=
 =?utf-8?B?cGs3K1Uxenl1RlFKWkFNNzdILy9jc2U1dlFKZTVMdm15RzFrbkM3dXpzaXRP?=
 =?utf-8?B?eUhOekxCSU5iblJ4YXJoU2FRMVhsU1o0K2JrT2N1K09LWXZVSk1PdlRTUDRW?=
 =?utf-8?B?bFdEVGNtcGgydnhyNDcxSllmT0w2MTE3MG5xb1RVVXlYT3R0U1pCM1VMb3o1?=
 =?utf-8?B?NDJ4dG9rWlVQaU4ydVpEMU5iYVl0S21PblVxYXBSWDZqU1FTQ3ZkTWpkSWZR?=
 =?utf-8?B?aTFpS3l2QjJuSkg5dmhCY0JoNU9FK0pMZVl3VnU4amtOcXlIOTcvMVZWNFdL?=
 =?utf-8?B?dDl5Q05zZzBRSmdXS2JGeDlnT1ZOd1BHZ3VDN25MNmZvVEJJS2ZhemVYRzd3?=
 =?utf-8?B?YkVGd2o4TWdQeFdXMGpPekxPK0NUVmV0aUZEVkt6TnZjRmdDOTBxOXpPK0hV?=
 =?utf-8?B?b0JFc245eVRXVTZEVG90UW55TVJObTFZMFV2M2hNemhIbW53RkhkZGpCQmdL?=
 =?utf-8?B?eEl1eHh5ZDdVMW9aSjlRWkw2K2R0S0lGbmN4ZVNHaWN3VUwrdDIvRmZreG5v?=
 =?utf-8?B?R2l2VHVWRVZGOU55YzRVMjMrT3ZwNXhOYVRocUxGNnIveFNQL01ObjVpSjhu?=
 =?utf-8?B?TDc2T2Vqa2h4a3RDczFhTnhNUzU2YkpiTkZCV1NFbXVkZHpwVFUrNXNpUUtJ?=
 =?utf-8?B?NEtQbUl3SFZCMnBOdThOT3l0OXNYbHBQZFM1anJnb2tqY0dYaER5cnZXWDBS?=
 =?utf-8?B?Tm9zc2twVitjYlRYTFVFaFZDb1MraVlGU2M0eWRSZlNtT1JEMi9lQlNMb3Ni?=
 =?utf-8?B?SXNvUlZSNDQxc0RZaWNVdz09?=
x-microsoft-antispam-prvs: <MWHPR11MB1360BD542E7C85173EE1F7FFE07D0@MWHPR11MB1360.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(478600001)(53936002)(6436002)(6116002)(486006)(3846002)(256004)(11346002)(446003)(110136005)(14454004)(26005)(2906002)(316002)(97736004)(476003)(5660300002)(2616005)(71190400001)(71200400001)(72206003)(186003)(6512007)(6486002)(229853002)(31696002)(25786009)(105586002)(86362001)(106356001)(31686004)(6506007)(102836004)(66066001)(6246003)(68736007)(4326008)(386003)(53546011)(52116002)(54906003)(81156014)(81166006)(8676002)(305945005)(7736002)(99286004)(76176011)(8936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1360;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: awh6bJ7RP6957gnTG6AWrnG5RDsUXR4enLU621sBohv3KaHDNqQLv5aa9LDSL2u/NVfvxpcCnLYZJzEw20gdhItHF2f/8Tjxt7ZYzW9NSWQO/9VemLHLuVcDfhNrv32DR6m8JqI160V0lOjV6rIzsFJ1TW/24Dme0wTY3j/o420MN38jCk/rsrHkrhRAo3TESh4uQxMYvfWMs+6ywgsb1mPSZ3fqvPSgQzx4CijXz6iAp2I8Ejzx9Afs8p/fgsBHTv1moVOmGqzfxVmSYiWTnsbIqSfkQ00NrEJ8ewvnY1jKuGiEnvI2xQscejAQnu2j8MEaWbfY6ho4WbiyZFzhYZAEHrLn9HnpC4+yYpUkScMmxl996jpyUfSAu4x+UvpHWio7egfNzoFdgcWP9b6yHHJjFNqgP6WFtXCbsRCm9H8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D2B0D762DF95C4E8B71AF7D7E5E5CCC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c953a26f-a962-4fa6-55b4-08d6971d092f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 10:20:26.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1360
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDIvMjAxOSBhdCAxNzo1MSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IG5jaygp
IGxvb2tzIGF0IHRoZSBsYXN0IGlkIGluIGFuIGFycmF5IGFuZCB1bmZvcnR1bmF0ZWx5LA0KPiBh
dDkxc2FtOXgzNV9wZXJpcGhjayBoYXMgYSBzZW50aW5lbCwgaGVuY2UgdGhlIGlkIGlzIDAgYW5k
IHRoZSBjYWxjdWxhdGVkDQoNCldlbGwsIHRoZSBsb2dpYyBmb3IgYWxsIG90aGVyIFNvQyBjbGsg
ZmlsZXMgaXMgdG8gbm90IGhhdmUgc3VjaCBhIA0Kc2VudGluZWwgYW5kIGRlYWwgZGlmZmVyZW50
bHkgd2l0aCB0aGlzIHR5cGUgb2YgYXJyYXk6IHdoeSBub3QgbW9kaWZ5IA0KdGhpcyBmaWxlIHRv
IG1hdGNoIHdpdGggb3RoZXJzPw0KDQoNCj4gbnVtYmVyIG9mIHBlcmlwaGVyYWwgY2xvY2tzIGlz
IDEgaW5zdGVhZCBvZiBhIG1heGltdW0gb2YgMzEuDQo+IA0KPiBGaXhlczogMWVhYmRjMmY5ZGQ4
ICgiY2xrOiBhdDkxOiBhZGQgYXQ5MXNhbTl4NSBQTUNzIGRyaXZlciIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4g
LS0tDQo+ICAgZHJpdmVycy9jbGsvYXQ5MS9hdDkxc2FtOXg1LmMgfCAzICstLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05eDUuYyBiL2RyaXZlcnMvY2xrL2F0OTEvYXQ5
MXNhbTl4NS5jDQo+IGluZGV4IDJmZTIyNWE2OTdkZi4uZDM3ZTdlZDllYjkwIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05eDUuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9h
dDkxL2F0OTFzYW05eDUuYw0KPiBAQCAtMTQ0LDggKzE0NCw3IEBAIHN0YXRpYyB2b2lkIF9faW5p
dCBhdDkxc2FtOXg1X3BtY19zZXR1cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiAgIAkJcmV0
dXJuOw0KPiAgIA0KPiAgIAlhdDkxc2FtOXg1X3BtYyA9IHBtY19kYXRhX2FsbG9jYXRlKFBNQ19N
QUlOICsgMSwNCj4gLQkJCQkJICAgbmNrKGF0OTFzYW05eDVfc3lzdGVtY2spLA0KPiAtCQkJCQkg
ICBuY2soYXQ5MXNhbTl4MzVfcGVyaXBoY2spLCAwKTsNCj4gKwkJCQkJICAgbmNrKGF0OTFzYW05
eDVfc3lzdGVtY2spLCAzMSwgMCk7DQoNCkkgd291bGQgcHJlZmVyIGxpa2UgaXQncyBkb25lIG9u
IG90aGVyIFNvQyBjbGsgZmlsZXMuDQoNCj4gICAJaWYgKCFhdDkxc2FtOXg1X3BtYykNCj4gICAJ
CXJldHVybjsNCj4gICANCj4gDQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
