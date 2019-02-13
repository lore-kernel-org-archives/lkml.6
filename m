Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C89C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663A0222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="0+MigOc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391208AbfBMJNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:13:52 -0500
Received: from mx08-00287e01.pphosted.com ([62.209.51.156]:34962 "EHLO
        mx07-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728468AbfBMJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:13:51 -0500
X-Greylist: delayed 1402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 04:13:48 EST
Received: from pps.filterd (m0111315.ppops.net [127.0.0.1])
        by mx07-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1D8Zdqj022968;
        Wed, 13 Feb 2019 09:50:16 +0100
Received: from eur03-db5-obe.outbound.protection.outlook.com (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52])
        by mx07-00287e01.pphosted.com with ESMTP id 2qhny24u0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Feb 2019 09:50:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxfiUHpLtpat9pn5XxaDSlyINQF2Vffpjnse3569hfY=;
 b=0+MigOc8kpTx/R9nEmBuZXnSXtSNmqP5y+nFN2Dff3OtgBq4ewDbboUhk2D/VDiX2k2ObbCCKbW5Ze19XKupOUlq1lw13Imt0c1bAm+Z4kMO2WEayP9wdrQUCJFtJR6DeyVsUOnrb2h+CTt0YPPLU/iuxXBj9nxbByqpWfmZ8Rg=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB6174.eurprd04.prod.outlook.com (20.179.27.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:50:14 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045%4]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 08:50:14 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erwan Velu <erwanaliasr1@gmail.com>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Topic: [PATCH v4] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Index: AQHUwqHbuIj7d8IoTUinA77lsmPW9qXcyHUAgACkigA=
Date:   Wed, 13 Feb 2019 08:50:14 +0000
Message-ID: <a2f4128c-54cc-44b3-d615-977e9ed37d07@criteo.com>
References: <20190212070839.25981-1-e.velu@criteo.com>
 <CAJZ5v0i4PFWQ5fMZ8Rh3jgu22=Me1+ArOwVW333BWa4z54Lqbg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i4PFWQ5fMZ8Rh3jgu22=Me1+ArOwVW333BWa4z54Lqbg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0025.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::38) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [82.252.136.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d2b59d3-34c1-46d6-b244-08d691904501
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6174;
x-ms-traffictypediagnostic: VI1PR04MB6174:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI2MTc0OzIzOjJWTk96UTBUTU1zaiswQjlmL0ViUVQrNjhI?=
 =?utf-8?B?blFjNDFaZVhCOWFtK042dU5ONEtzZHBFdnBVcE9xZVUydXFEUEQ4Qng4dWpS?=
 =?utf-8?B?RUFaSlNhNW02bTBCRnpJd2JyU2tkdFR3NXRHRGJKdDlSWHU3SzRqOEc4Ynpi?=
 =?utf-8?B?MUQzYXJheUVWd2MydllEMmtMQ0txdW9YcTlNWXFrS21iUEh1NHo2SFJKaHhJ?=
 =?utf-8?B?akhlcUlQNERoQXBMZjRGNjhLSTlSQ2RQZG5TUUJVcFZpSi9XOVpiTEJBTDll?=
 =?utf-8?B?Y0gyMm11R3RJczBXZytFN05xODIrendULzFUOFB4WDVsYSthNzVLWlY2clFL?=
 =?utf-8?B?Q2N3VFZzV1NUK0hSVElMUTZ4aWJIT1pXYjJQS2dlcXBESFJ1MS9KZzNWVWdj?=
 =?utf-8?B?K3JCdkc3NHF4b2dGVUJ0Y3FEeWdBVWVnaElWSmxUaEc1YklHK2ZhNEdDOFdE?=
 =?utf-8?B?MDVMVVo4ME5JOEI4dlRsVnY5eHk4aW81enRNdk91SjVRYjFDVjEzTklPTVBZ?=
 =?utf-8?B?MktCS1lwUEZLM0ZtQ1JiOFNBZGxwZ21BeXduQ3FIMzlBc052aWoydlNtb3lC?=
 =?utf-8?B?cmFkRG9KRytLekNmcldrYVpJSlMrSTEzNGlJVUlNUjJWMWZXYmpBUXc4VTNG?=
 =?utf-8?B?RXNQSDNtdWJ1QzFmeUhTQ21HTHFXL01YNFZSL0V5cnpXc2s1N21yRmVEbzFw?=
 =?utf-8?B?NEp5UENOR1N4VHk5SnlRdjNJaERUSTRIOW40TjNlNTE3TkgrZEhVMjNBTjN3?=
 =?utf-8?B?MENvVVRYWkVuUVJXN2ozc09OWitvODBUVndUSnJxTFZuc0ZqM1M5YzkvL2ls?=
 =?utf-8?B?NmRNSVgydkE4TzhRL2c5bDV6d2tQdXIvQUR6dXJqT1F2L3pDM1RkVk5qczYy?=
 =?utf-8?B?MFcydWxzcGZXa2tWYisyQURBYjVhK1l5VHpHbXAxanZDWmU4cHJKUHF5WkM1?=
 =?utf-8?B?dlpxbGF0NHdKeS9EMVM5M2JvR2E3ei9odVZXVEozYkx4Vi8zclBoMWc5S2Fh?=
 =?utf-8?B?dXRhdE1FVHQ4UHI3bGkyWHFZUmJRdUtRaHA4TDIzMVFPbXdIL2kybXF2aCs3?=
 =?utf-8?B?VHIvY25iMTBxeHFhbWc5cW5Cc3J2YmhEeE9OTnlVQVYwL0FVZG8xOEgzcEhw?=
 =?utf-8?B?cEtDdnlKZVU2QXl4c0IyTlpMdUJ0L1MwakJBVUswWUhHajhGQnpBZVEwa3oy?=
 =?utf-8?B?ZDc2TVVuQzg4SDlNaDJZS0x6cWRUYWxBaUZKTlBwbThKcE50RXozKzYwWk1D?=
 =?utf-8?B?TzFtRUJ4SGdESkJuSUR6bEZ1Y0lVZW9YSnBSUUpJVlVYaHVLbEwyRHBzMXJJ?=
 =?utf-8?B?UXAzd2JsRGc3anRhL2hGcnNXNFFhU0haVG0vVFFxeFB2NVpjTS93ZGczQzMw?=
 =?utf-8?B?clBtMEtvUzlzSERSaVFIaHBJVWpHcnQzY1NkN3NUdmwwUVBMOWc2aHVMdjIy?=
 =?utf-8?B?dE1iRzdOVGZKSDdqdlVpeTMvZ1ZHQm9LWm1XU05iNnNkS3RaZGJJbjhERWxD?=
 =?utf-8?B?aFpxcUdNMUFEeVg5TlNsb1lPUURVMFJScnFLaXhGTmQvYjFlczFtdmFzTzhl?=
 =?utf-8?B?Y2M3Y3JrbHRNb29LTE54SUFSY2dUOEJwbDBvemMxWXl3dkdFU3BNbENRUWFN?=
 =?utf-8?B?ei9GYVJpc0FVbWNaT0lqNzQ0TzZyZnRabW52aHlSN1hiUW5MTmlwOTIwMnU4?=
 =?utf-8?B?azFlN3p6M2lwd2FMcE8yUFZpRVNjSlg5UkRocElsNUtoQ2Q5SUIxNCt4cyti?=
 =?utf-8?B?dHFlVlNSYlVrZGpHdjIyZz09?=
x-microsoft-antispam-prvs: <VI1PR04MB6174AE204D1D50ED4C9BB88CF2660@VI1PR04MB6174.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(136003)(396003)(51914003)(189003)(199004)(53936002)(186003)(486006)(4326008)(229853002)(36756003)(6506007)(386003)(81166006)(6246003)(6116002)(3846002)(8676002)(81156014)(102836004)(26005)(14444005)(256004)(8936002)(31686004)(2906002)(6486002)(6512007)(25786009)(476003)(106356001)(2616005)(6436002)(11346002)(97736004)(446003)(71190400001)(105586002)(316002)(7736002)(305945005)(68736007)(86362001)(52116002)(66066001)(76176011)(31696002)(110136005)(14454004)(71200400001)(99286004)(66574012)(54906003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB6174;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LIoQZ6teMcfhSBZZkmE+s0FmcCAA/Gy2NqSIfUDVFxInK9qkK+pQqQyGDbARQgayqUwwnPlJplDrNO4npJMi1caFao4sH5ZXQhjBjuALAHN90Jm39du3wVVQEBaSRnU5b+botfMLuV4+5HRs5PIyikML+wOFjHVff1jM0ZLz9ANaZYpZyC0VyeBHENpVXVE9L7Xazav74nXcvT482quqfDLulPjUq9q/iRZy0bnOD0EHqQrEQlr9pYhP+ysdCZX46P5twgrb8wxIE8SOST7IcfweVu4AYRYWCLVVSUdXP33KITSEjtqwEpdFUCjqaFC88iYXQz1JbUPEJzkl5dePnMmkZ2Iss0hCBxVvKiPuBXVTKHcxYQ+mSyaxYLWU71VjY0of/ke8a3e2o28g8c1O+5l8ZaGTZkqHouekWXsK/7s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B14B9071893594AAF66184801B998D8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2b59d3-34c1-46d6-b244-08d691904501
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:50:13.3427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAxMy8wMi8yMDE5IMOgIDAwOjAxLCBSYWZhZWwgSi4gV3lzb2NraSBhIMOpY3JpdMKgOg0K
Wy4uLl0NCj4gTmV3bGluZSBjaGFyYWN0ZXJzIGFyZSBtaXNzaW5nIGluIGFsbCBvZiB5b3VyIG1l
c3NhZ2VzLg0KDQpvb3BzLiBGaXhpbmcgdGhpcy4NCg0KPiAiQUNQSSBfUFNTIG5vdCBmb3VuZFxu
Ig0KDQpEb25lLg0KDQoNCj4+ICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4gICB9DQo+Pg0KPj4g
QEAgLTI0ODQsMTAgKzI0ODUsMTUgQEAgc3RhdGljIGJvb2wgX19pbml0IGludGVsX3BzdGF0ZV9u
b19hY3BpX3BjY2godm9pZCkNCj4+ICAgICAgICAgIGFjcGlfaGFuZGxlIGhhbmRsZTsNCj4+DQo+
PiAgICAgICAgICBzdGF0dXMgPSBhY3BpX2dldF9oYW5kbGUoTlVMTCwgIlxcX1NCIiwgJmhhbmRs
ZSk7DQo+PiAtICAgICAgIGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkNCj4+ICsgICAgICAgaWYg
KEFDUElfRkFJTFVSRShzdGF0dXMpKSB7DQo+PiArICAgICAgICAgICAgICAgcHJfZGVidWcoIkNh
bm5vdCBkZXRlY3QgQUNQSSBTQiIpOw0KPiBUaGlzIGlzIHZlcnkgdW5saWtlbHkgdG8gaGFwcGVu
LCBJIHdvdWxkbid0IGJvdGhlciB0byBwcmludCBhbnl0aGluZyBoZXJlLg0KDQpBcyB0aGlzIGlz
IHRlc3QgaXMgbWFkZSwgaXQgbWVhbnMgc29tZW9uZSBjb25zaWRlcmVkIHRoYXQgY2FzZSBjb3Vs
ZCBleGlzdC4NCg0KVGhhdCdzIHdoeSBhIGFkZGVkIGEgbWVzc2FnZSB0byBjYXRjaCB0aGlzIGNh
c2Ugd2hpbGUgZGVidWdnaW5nLg0KDQpJIGRvIGFncmVlIHRoYXQgaXMgbm90IHZlcnkgbGlrZWx5
Lg0KDQo+DQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4gKyAgICAgICB9DQo+
Pg0KPj4gLSAgICAgICByZXR1cm4gIWFjcGlfaGFzX21ldGhvZChoYW5kbGUsICJQQ0NIIik7DQo+
PiArICAgICAgIHN0YXR1cyA9IGFjcGlfaGFzX21ldGhvZChoYW5kbGUsICJQQ0NIIik7DQo+PiAr
ICAgICAgIGlmICghc3RhdHVzKQ0KPj4gKyAgICAgICAgICAgICAgIHByX2RlYnVnKCJDYW5ub3Qg
ZGV0ZWN0IEFDUEkgUENDSCIpOw0KPiBUaGlzIG1lc3NhZ2UgY2FuIGJlIHByaW50ZWQgYnkgdGhl
IGNhbGxlciBhbmQsIGFnYWluLCBJIHdvdWxkIHByZWZlcg0KPiBzb21ldGhpbmcgbGlrZSAiQUNQ
SSBQQ0NIIG5vdCBmb3VuZCIuDQpGaXhlZCB0b28uDQoNClsuLl0NCj4gIkFDUEkgX1BQQyBub3Qg
Zm91bmRcbiINCmZpeGVkLg0KPj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICB9DQo+Pg0K
Pj4gQEAgLTI1MzksOCArMjU0NiwxMCBAQCBzdGF0aWMgYm9vbCBfX2luaXQgaW50ZWxfcHN0YXRl
X3BsYXRmb3JtX3B3cl9tZ210X2V4aXN0cyh2b2lkKQ0KPj4gICAgICAgICAgaWQgPSB4ODZfbWF0
Y2hfY3B1KGludGVsX3BzdGF0ZV9jcHVfb29iX2lkcyk7DQo+PiAgICAgICAgICBpZiAoaWQpIHsN
Cj4+ICAgICAgICAgICAgICAgICAgcmRtc3JsKE1TUl9NSVNDX1BXUl9NR01ULCBtaXNjX3B3cik7
DQo+PiAtICAgICAgICAgICAgICAgaWYgKCBtaXNjX3B3ciAmICgxIDw8IDgpKQ0KPj4gKyAgICAg
ICAgICAgICAgIGlmIChtaXNjX3B3ciAmICgxIDw8IDgpKSB7DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICBwcl9kZWJ1ZygiTVNSX01JU0NfUFdSX01HTVQgcmVwb3J0cyBlbmFibGVkIEhXIGNv
b3JkaW5hdGlvbiIpOw0KPiBJSVJDIHRoaXMgbWVhbnMgdGhhdCB0aGUgcGxhdGZvcm0gaXMgbWFu
YWdpbmcgUC1zdGF0ZXMgb24gc3lzdGVtcw0KPiB3aXRob3V0IEhXUCwgc28gSSB3b3VsZCBwcmlu
dCBzb21ldGhpbmcgbGlrZSAiUC1zdGF0ZXMgbWFuYWdlZCBieSB0aGUNCj4gcGxhdGZvcm1cbiIu
DQoNClRoYXQncyB3aGF0IHRoZSBjYWxsZXIgcmVwb3J0cy4NCg0KSSBhZGRlZCB0aGlzIGFkZGl0
aW9uYWwgbWVzc2FnZSBiZWNhdXNlIHRoaXMgZnVuY3Rpb24gYWRkZWQgYXMgc3BlY2lhbCANCmNh
c2UgZm9yIHRoaXMgTVNSIHNldHRpbmcuDQoNCmlmIGludGVsX3BzdGF0ZV9wbGF0Zm9ybV9wd3Jf
bWdtdF9leGlzdHMoKSBpcyB0cnVlLCB0aGF0J3MgbmljZSB0byBrbm93IA0Kd2h5IHdoZW4gZGVi
dWdnaW5nLg0KDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAr
ICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAgIGlkeCA9IGFj
cGlfbWF0Y2hfcGxhdGZvcm1fbGlzdChwbGF0X2luZm8pOw0KPj4gQEAgLTI2MDYsMjIgKzI2MTUs
MjggQEAgc3RhdGljIGludCBfX2luaXQgaW50ZWxfcHN0YXRlX2luaXQodm9pZCkNCj4+ICAgICAg
ICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgfSBlbHNlIHsNCj4+ICAgICAgICAgICAgICAgICAg
aWQgPSB4ODZfbWF0Y2hfY3B1KGludGVsX3BzdGF0ZV9jcHVfaWRzKTsNCj4+IC0gICAgICAgICAg
ICAgICBpZiAoIWlkKQ0KPj4gKyAgICAgICAgICAgICAgIGlmICghaWQpIHsNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHByX3dhcm4oIkNQVSBJRCBpcyBub3QgaW4gdGhlIGxpc3Qgb2Ygc3Vw
cG9ydGVkIGRldmljZXNcbiIpOw0KPiBXaHkgbm90IHByX2RlYnVnKCk/DQo+DQo+IEFuZCBhbmFs
b2dvdXNseSBiZWxvdz8NCg0KSSdtIGNvbWluZyBmcm9tIGEgdXNlIGNhc2Ugd2hlcmUgb24gdGhl
IHNhbWUgaGFyZHdhcmUsIGNoYW5naW5nIHRoZSANCmtlcm5lbCBjaGFuZ2VkIHRoZSBwZXJmb3Jt
YW5jZSBwcm9maWxlIGFuZCBpbXBhY3RlZCB1c2VyJ3MgcGVyZm9ybWFuY2UuDQoNCkkgaGFkIHRv
IGRlYnVnIHRoaXMgY2FzZSBmcm9tIGEgcnVubmluZyBzZXJ2ZXIuDQoNCiBGcm9tIHRoZSBkbWVz
Zywgb25lIG9mIHRoZSBkaWZmZXJlbmNlIEkgc2F3IHdhcyBhYm91dCB0aGUgDQptaXNzaW5nwqAi
SW50ZWwgUC1zdGF0ZSBkcml2ZXIgaW5pdGlhbGl6aW5nIiBtZXNzYWdlLCBidXQgbm90aGluZyBl
bHNlLg0KDQpUaGUgcmVhc29uIHdoeSB0aGUgZHJpdmVyIGRpZG4ndCBlbmdhZ2VkIGl0c2VsZiB3
YXNuJ3QgZXhwbGljaXQuDQoNCkFzIENPTkZJR19YODZfSU5URUxfUFNUQVRFIGlzIHNldCB0byBZ
IGJ5IGRlZmF1bHQsIEkgd2Fzbid0IGVuYWJsZSB0byANCnJlbG9hZCBpdCBpbiBhbnkgd2F5Lg0K
DQpCeSByZWFkaW5nIHRoZSBjb2RlLCBtb3N0IG9mIHRoZSBjb2RlIHBhdGggYW5kIHJldHVybiBv
cHRpb25zIGRvZXNuJ3QgDQpoYXZlIGEgc2luZ2xlIHByXzxzb21ldGhpbmc+IGNhbGwgdG8gZXhw
bGFpbiB3aHkuDQoNClNvIEkgaGFkIHRvIHJlYnVpbGQgdGhlIGtlcm5lbCArIG15IHBhdGNoIHRv
IHVuZGVyc3RhbmQgd2hpY2ggcGF0aCB3YXMgDQp0YWtlbiBhbmQgdGhlbiBmaW5kIHRoZSByb290
IGNhdXNlIG9mIHdoeSB0aGUgcHN0YXRlIGJlaGF2aW9yIGNoYW5nZWQuDQoNCkkgd2FudGVkIHRv
IGNvbnRyaWJ1dGUgYmFjayBteSBleHBlcmllbmNlIGhlcmUgYnkgcHJvdmlkaW5nIG1lc3NhZ2Vz
IHRvIA0KZWFzZSB0aGUgdW5kZXJzdGFuZGluZyBhbmQgcG90ZW50aWFsbHkgZGVidWdnaW5nIG9m
IHRoZSBkcml2ZXIgd2l0aG91dCANCnJlY29tcGlsaW5nIGl0Lg0KDQoNClNvIHRoZSByb290IG9m
IHRoaXMgcGF0Y2ggaXMgYmVpbmcgYWJsZSB0byByZXBvcnQgdGhlIG1haW4gcmVhc29ucyBvZiAN
CndoeSB0aGUgZHJpdmVyIGRpZG4ndCBlbmdhZ2VkIGl0c2VsZiB3aXRoIGEgcHJfd2FybiAoY291
bGQgYmUgYWxzbyBhIA0KcHJfaW5mbykuDQoNCkFsbCB0aGUgbWFqb3IgYW5kIHByb2JhYmxlICJy
ZXR1cm4gLUVOT0RFViIgY2FsbHMgYmVmb3JlIHByX2luZm8oIkludGVsIA0KUC1zdGF0ZSBkcml2
ZXIgaW5pdGlhbGl6aW5nXG4iKSBkZXNlcnZlcyB0byBiZSBleHBsaWNpdCBhbmQgcmVhY2hhYmxl
IG9uIA0KZG1lc2cgZm9yIHRoZSBvcGVyYXRvcnMuDQoNCkknbSBvcGVyYXRpbmcgMzBLKyBzZXJ2
ZXJzIGFuZCBoYXZpbmcgdGhpcyBraW5kIGRpcmVjdCBpbmZvcm1hdGlvbiB3b3VsZCANCnNhdmUg
c2VyaW91cyB0aW1lIHdoZW4gZGVidWdnaW5nIHRoaXMgc2l0dWF0aW9ucy4NCg0KSWYgbXkgZXhw
ZXJpZW5jZSBpbiB0aGF0IGFyZWEgY291bGQgaGVscCBvdGhlciB1c2VycywgSSdkIGJlIGhhcHB5
Lg0KDQoNCkknbSBwb3NpdGluZyBhIHY1IHdpdGggYWxsIHRob3NlIGNoYW5nZXMuDQoNClRoYW5r
cyBmb3IgdGhlIHJldmlldy4NCg0KDQpFcndhbiwNCg0K
