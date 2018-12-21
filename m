Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5974DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF63218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mMEhpCUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbeLULR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:17:58 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:16105 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbeLULRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:17:53 -0500
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="24670754"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 21 Dec 2018 04:17:53 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 21 Dec 2018 04:18:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4mHf4dk0HFn93tmLI3qQjKNl7LUo4XHeDUOOUy6kaQ=;
 b=mMEhpCUNrfxS5ut4BZYGW9pM3+yDQ6NUwh3V4appaF4/VV0mqR6Utfb36ktbKmWKijP1QsyWpj6ALtFhmfIyKTIUboHAGvnrYdbzMW3eiVb8Ke3Q9yGv7UJhuJl9NFYF2/0s/+07gZv24WfHrMC3RYKZUa+gy9rhcEv9fYeS7LA=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1406.namprd11.prod.outlook.com (10.169.234.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Fri, 21 Dec 2018 11:17:50 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::d4e0:49b4:1b0a:8ae6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::d4e0:49b4:1b0a:8ae6%6]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 11:17:50 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <axel.lin@ingics.com>, <broonie@kernel.org>
CC:     <Andrei.Stefanescu@microchip.com>, <lgirdwood@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around
 mcp16502_suspend/resume_noirq
Thread-Topic: [PATCH] regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around
 mcp16502_suspend/resume_noirq
Thread-Index: AQHUmR7P+RCUftXxtk+md7qXXbwhgQ==
Date:   Fri, 21 Dec 2018 11:17:50 +0000
Message-ID: <3751abc0-1377-2a66-3fa9-7ceee93b7aab@microchip.com>
References: <20181220131413.21922-1-axel.lin@ingics.com>
In-Reply-To: <20181220131413.21922-1-axel.lin@ingics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::16) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1406;6:lOJJyAd+pLtl8gc1EDGGUpzGP5LdHcjxE5WkYbKs+6mpwojNratm3qXtDzoEhcK8VvmPUmslByvm+nlhwm6Doz8a1GcTYy53rmzPKW3gqPaYbAxfCOiI6W57uC9YCPehEAnHwYjQtSSHVrlYnYCd4UpI2JER7RO2+hbLlASKpGK/Hp/5JJ5IH7mGTfFMrVbqXfibMBxDgA1PdZHMWbnwwJjGXy7R8u86OYmWOG0nVNhdGXocOEsyoJdSSWLjSZg96HrPEkUnuxnt0IexkqSuk2RdvB2+33g//yS7zbllNjV0cd5pX29+bAVWvD/ZZIfVwPNCtljxjybLyOx8G6TbKoAhzolXX3NmXrzr68TP9S24FI7P+XN+4VwYqUGKifoHJCFbDI/IH3lUuikafQEBnc5xdLmz7Ms1iJ3EuZKDed5BK+zCNdNc0k27MF0vOwlkscgE2zW/eIcPd+Lv17Z92w==;5:6n5LvdY8MrXcQ8qv5CikVhhO/GO5fn90DK3ERlsomzWrqnIqu1Rmz5IaoVDXm+DueqIGLeeEY9AuCIlemSFu39r19/64Jx5RcnIR/5UgbbQOiSN2B+3PZrKGTISp50hk11ylHKCyzaAZ5PK9nrCMpZYNMUNE7hVj97wwEOq42i8=;7:OhcO4nBCs4Wg8XhVLb11DqU1tkGYZbquPIXNrrRDEZtMpDJJdX8Cta4W0Q24MSQqzYpbXFvLnzgRwmmZzsROx9nlg6HR5C1uxmF+VUTd6gkzrGlxeBinkWrS8cXEcY63L7RQzG88Z3T596YhUIGKlA==
x-ms-office365-filtering-correlation-id: 09ff3ace-44c8-4268-74ef-08d66735f169
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1406;
x-ms-traffictypediagnostic: MWHPR11MB1406:
x-microsoft-antispam-prvs: <MWHPR11MB14066CFD3BC3DBAB7D21BF38E0B80@MWHPR11MB1406.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1406;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1406;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(31696002)(305945005)(14454004)(86362001)(25786009)(106356001)(72206003)(6436002)(6246003)(8936002)(81156014)(8676002)(81166006)(478600001)(36756003)(71200400001)(71190400001)(6486002)(97736004)(2906002)(105586002)(6512007)(107886003)(186003)(3846002)(6116002)(53546011)(6506007)(386003)(229853002)(102836004)(76176011)(54906003)(5660300001)(4326008)(446003)(26005)(2616005)(53936002)(11346002)(476003)(486006)(316002)(66066001)(256004)(14444005)(52116002)(99286004)(31686004)(39060400002)(7736002)(68736007)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1406;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VCJaI2zlQDv4CBLrbvXlsRZ6Uig+t7WxgRb0IC0pRkKunUd6KYhe/HIqy9Z8LEeYh2/6pcJtYJ86eadqbcjzkbKjI1RCYZHbMEAsLPXLwQB45rvtr11cwJpB7btNiCKamXn37Qac+BbsT5Qbbc+jdz/j6JLjqI24hYCY182r3qUD7q9G30fvuEt5sSFF+B5fUvQwBs4W7h1Z8Nrz5zZwMzjYHsoCkOP7KoSxUlsUPVq4JfJu76n1Nv53dhmQHhidOMkRTRj4bU/wRFDWKvU3c87qhEZZvtC92JJ1C3DOflcCjggtyQOUFao/WsOP2p7B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <28CAA01342A08E48998ED200641EEF62@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ff3ace-44c8-4268-74ef-08d66735f169
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 11:17:50.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1406
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMTIvMjAxOCBhdCAxNDoxNCwgQXhlbCBMaW4gd3JvdGU6DQo+IG1jcDE2NTAyX3N1c3Bl
bmQvcmVzdW1lX25vaXJxIGlzIG9ubHkgdXNlZCBieSBTRVRfTk9JUlFfU1lTVEVNX1NMRUVQX1BN
X09QUw0KPiB3aGVuIENPTkZJR19QTV9TTEVFUCBpcyBkZWZpbmVkLg0KPiBTbyB1c2UgI2lmZGVm
IENPTkZJR19QTV9TTEVFUCBpbnN0ZWFkIENPTkZJR19TVVNQRU5EIGd1YXJkLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGluZ2ljcy5jb20+DQoNCkknbSBub3QgYWdh
aW5zdCB0aGlzIHBhdGNoIGFuZCBkb24ndCBrbm93IHRoZSBoYWJpdHMgYWJvdXQgdGhpcy4uLiBv
bmUgDQpyZW1hcmsgYmVsb3cuLi4NCg0KDQo+IC0tLQ0KPiBUaGlzIHBhdGNoIHJlcGxhY2VzIGJl
bG93IHBhdGNoIEkgc2VudCB0b2RheS4NCj4gcmVndWxhdG9yOiBtY3AxNjUwMjogRml4IGJ1aWxk
IGVycm9yIHdoZW4gIUNPTkZJR19TVVNQRU5EICYmIENPTkZJR19QTV9TTEVFUA0KPiBDaGFuZ2Vk
IHRoZSBzdWJqZWN0IGxpbmUgYmVjYXVzZSBhZnRlciBjb21taXQgMzA4MTQ0Y2U4ZTUxICgicmVn
dWxhdG9yOiBtY3AxNjUwMjogY29kZSBjbGVhbnVwIikNCj4gaXQncyBub3QgcmVsYXRlZCB0byBi
dWlsZCBlcnJvciBub3cuDQo+IA0KPiAgIGRyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmMgfCA3
ICsrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmMgYi9k
cml2ZXJzL3JlZ3VsYXRvci9tY3AxNjUwMi5jDQo+IGluZGV4IDgwOWE2NjQ3MzNhNC4uY2IxMWZi
MjA2ODk5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9tY3AxNjUwMi5jDQo+ICsr
KyBiL2RyaXZlcnMvcmVndWxhdG9yL21jcDE2NTAyLmMNCj4gQEAgLTQ5Nyw3ICs0OTcsNyBAQCBz
dGF0aWMgaW50IG1jcDE2NTAyX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+ICAg
CXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gLSNpZmRlZiBDT05GSUdfU1VTUEVORA0KPiArI2lm
ZGVmIENPTkZJR19QTV9TTEVFUA0KDQpXaHkgbm90IHVzZSBDT05GSUdfUE0ganVzdCBsaWtlIC4u
Lg0KDQo+ICAgc3RhdGljIGludCBtY3AxNjUwMl9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gICB7DQo+ICAgCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xp
ZW50KGRldik7DQo+IEBAIC01MTcsMTAgKzUxNyw3IEBAIHN0YXRpYyBpbnQgbWNwMTY1MDJfcmVz
dW1lX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICANCj4gICAJcmV0dXJuIDA7DQo+ICAg
fQ0KPiAtI2Vsc2UgLyogIUNPTkZJR19TVVNQRU5EICovDQo+IC0jZGVmaW5lIG1jcDE2NTAyX3N1
c3BlbmRfbm9pcnEgTlVMTA0KPiAtI2RlZmluZSBtY3AxNjUwMl9yZXN1bWVfbm9pcnEgTlVMTA0K
PiAtI2VuZGlmIC8qICFDT05GSUdfU1VTUEVORCAqLw0KPiArI2VuZGlmDQo+ICAgDQo+ICAgI2lm
ZGVmIENPTkZJR19QTQ0KDQouLi4gaGVyZS4uLi4gb3IgdW5pZnkgYm90aCBkaXJlY3RpdmVzIHRv
ICJDT05GSUdfUE1fU0xFRVAiID8NCg0KDQpPdGhlcndpc2UsIG5vIHByb2JsZW0gaW4gYWRkaW5n
IG15Og0KQWNrZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNv
bT4NCg0KKGFzIEFuZHJlaSBpcyBub3Qgd2l0aCBNaWNyb2NoaXAgYW55bW9yZSkuDQoNCg0KPiAg
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBtY3AxNjUwMl9wbV9vcHMgPSB7DQo+IA0K
DQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
