Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D77CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51928213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="u3X7jxCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfBYIhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:37:46 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:50620 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBYIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:37:46 -0500
X-IronPort-AV: E=Sophos;i="5.58,410,1544511600"; 
   d="scan'208";a="24401480"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Feb 2019 01:37:45 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Feb 2019 01:37:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfKjsQ58VlASQCLeHRcbOpQQ0wKpbbDv9I3FfQooGbY=;
 b=u3X7jxCoX57CMoK/tHM4sfD8my4joE/qk2kHjlFs1llp1eazfB+s7Zq+93bGfB8oUDeLtAEsez82yfTZ/5hGw+5U1wbTQzLRpm0SygjeDJC0+J0cZB/g2jnwy4d3NJfh3AoW49wje/1QSYRDofOsvDdGhbT2PjTezn/Y8S2Mzh8=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1309.namprd11.prod.outlook.com (10.169.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 08:37:44 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 08:37:43 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <axel.lin@ingics.com>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: mcp16502: Remove module version
Thread-Topic: [PATCH] regulator: mcp16502: Remove module version
Thread-Index: AQHUzAv3K4BdwxSzcE6oVu36Q0ZYXKXwMp8A
Date:   Mon, 25 Feb 2019 08:37:43 +0000
Message-ID: <a3170e86-fcf6-9f73-156d-c605890500bc@microchip.com>
References: <20190224064110.27181-1-axel.lin@ingics.com>
In-Reply-To: <20190224064110.27181-1-axel.lin@ingics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::17) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dba13b6b-1c35-4908-0cbb-08d69afc829e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1309;
x-ms-traffictypediagnostic: MWHPR11MB1309:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMzA5OzIzOmNzWW4xQmNXWXNCZXZNN3BKOFhlLzQvZWlk?=
 =?utf-8?B?Zk5GN0tzM3VkeUh0L3RKZEYwWi9DdzZsZEJJdVh2R0M2NlNKbnEvUzU5Vlpo?=
 =?utf-8?B?eVR6SFFxZ3RuSVRhakx2Tkh3bU1HWkhxUW1kaXpWd0FyZnQvOG1CUWVQMmhp?=
 =?utf-8?B?bnNKeFpoS0p6eTAyRW5Ud2RwS1Nzb0drY2toMUVtMEJsTVM5ZXcyMEtSMHhH?=
 =?utf-8?B?dUI0NGFTeGYraDNUMHVrc1F3NVlxSjBza0ZrcGFoS3ZCdW1rNGdQWS9IZVVJ?=
 =?utf-8?B?bVFYVHpucGZLRDlxc2xZNkwvUE9CK1Q0dm9GVzhBS0Vncko3aERXaVlJV2l4?=
 =?utf-8?B?VS9UL3lLMkk5KzU3RFZmOFdHbTlScjR4YXlJRE1CbDFoblUwa25hODNkRGpO?=
 =?utf-8?B?OWFzaU40MEFTWFBjL1VRVnlSMEo4d004dW5XTThzaU90aENsL1pUTHQ3TC9r?=
 =?utf-8?B?RkhmWUZETk1scXo2QkFTenUrZnNPdlRwanh1UVRJelBxcjYrMURpMm94em5P?=
 =?utf-8?B?M3NpbExydlM5RUdlclRVbWYrQTNFZm5KdjRscjlJR3gzRWVOeEptcFVuMnBU?=
 =?utf-8?B?cnRvRHJNTFRvdllTcGluQTA3L2h0MjJDWDJPSlVGcjd4dUc0OHF3R21XdWxX?=
 =?utf-8?B?RFJRdzRzaE9aT1NETmpEZHJ0VkUrZkFoSDdsU0xFU0thWEI0NTVhZ2kwaWds?=
 =?utf-8?B?cFdsUWhVc05sYmJjcGFoN1I2bGk2dVFwR0Q3YjJmTERlOU03b0lLTFBTckNo?=
 =?utf-8?B?c0xybnpxNFc3ZFFsWHp2UEp1NTFYdjVjL1ZpSitrNDRTRUxrZDN2aTNsY3pE?=
 =?utf-8?B?ZDIyMVdUYk9EUTZQbXdwM0FIcEZZcEo5OWRObHZPMFFncmlDVWhveExsOEZ2?=
 =?utf-8?B?UEpmYm0xcjBJUE4vWnBaNHgxSno1bHowMGZpeXdqaXVSQjZuWk01REVmQzFZ?=
 =?utf-8?B?T3FFeUc4MGJzWElraTlZZ2doVjlRQXovL0t2N2o0aCtlZUViQnJueGpyaUlm?=
 =?utf-8?B?QzdvZCtjVU9QUXpmTlpodnpqTy92bGFMc3E5b0hWNFlMb1BYWmxxTXZWUnBs?=
 =?utf-8?B?cVRNSzc4ODJOQlozTWFrRE5qdHZtaFVzZG9PcUlFc0FkNXlwRVFzYVpvbkVY?=
 =?utf-8?B?VU16b1V4b2pnRnVsVGV4SnN3N0w1WHE5ZlA0N2t0Qm1WclIrYnJZV25sSHhR?=
 =?utf-8?B?M3ZxdnF3OTFkeXVVdXN3UFNMRDB5Y3VyQTBlZlRUMUZNZU9FcnF5cU1jTGtJ?=
 =?utf-8?B?eEgwdnp1ZUdTaW9oWTlpdDJkcUJ6Y2l5MlNERTdUQ2JBYjNUZ25kWUxFVWJ2?=
 =?utf-8?B?RFZzZ0xIbE5Wc3pFMVFzNWhxSkVOR3N1elBBRExiTTlkYi9ORHdVc3BUblRX?=
 =?utf-8?B?eFgzc3FwRmFKQXVtM3RDcU1rQy80ZnBXdDMyRXBoUXQ5U3JJSDRQY3FrQmV1?=
 =?utf-8?B?bFNDTXBGZUpVYXMrNURrM2h3dUlVMW1BOW9yYjVSdG1rbTU2Q1g4YkFubER5?=
 =?utf-8?B?VkNqRjNQKzZtK0tFRU5uTmNIR3lYRGZjSGhlTFlNSjUvN3FFemxGM2p6S2ll?=
 =?utf-8?B?ekVlMXlsUTNJODkycFVYT3BrRFBEUW9RTm4yYlJaelcxK25vMkE1UG95YlA5?=
 =?utf-8?B?a2YycnFaNUg5STdmakVSUlZkUk1lTzE4M1IxR1AzV3ZGK1JpNjBtVzMzcWNo?=
 =?utf-8?B?cmFDZW1XYlcxZ2FrT09jV21YWExRRlVQQk5pQVh2bm5lYmExWHNEcllYOXgy?=
 =?utf-8?B?Q2tER2pGZHNrOGpueTM4eVlqZFRhMHVvYUJxNERzV05rM0hkY2dleEYyeEUx?=
 =?utf-8?Q?S86haE5El52Bb?=
x-microsoft-antispam-prvs: <MWHPR11MB1309DB8438B9E54DC46C6955E07A0@MWHPR11MB1309.namprd11.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(26005)(7736002)(106356001)(6436002)(478600001)(72206003)(76176011)(36756003)(52116002)(105586002)(99286004)(102836004)(31686004)(53546011)(2616005)(386003)(486006)(6512007)(11346002)(6246003)(446003)(6506007)(476003)(4326008)(97736004)(6116002)(316002)(54906003)(110136005)(25786009)(305945005)(3846002)(186003)(14444005)(86362001)(66066001)(31696002)(8676002)(5660300002)(71200400001)(71190400001)(229853002)(81166006)(4744005)(81156014)(6486002)(8936002)(256004)(53936002)(2906002)(14454004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1309;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vz8a2vR6MzevpFQZ8xp7O6otExbiaIzMvdl0qgPk8cWXbmtnyUdBbKq/kC4+nv8ClS0USBDmmyRbnMMzODvE05k2fzNLAGvvz0tqHnuK1rhvzaeEHPEtRkiY4wH3C4WxY7/L48iLAIoA0ohbCPAr9NWNpbPgCApvgHrem+fE53CPhPz6rpbW7cjYNvUe0Prd2n+0nvj5slqQvk/1ZyTZVuraORjigK0H4gTxYhwM4/asRhhk7MgMVd7UBc+rxiBgfVpelP6zh3nms31duZi27XIXe6NIyYkXjmNue+UQtuH46BakymtBRnqMJsfSioUN7VT0Rsv0CHRcv2LVK+VejS5yxaNvPIDZaniYIRxV9mtXgZeO1ey4GMTJDpUSFLdWmU5cfdWKk9ZIIy0sJCT2Tn/VrWe9JZYCMbfp9fKQyFQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB448A18AC6E18439A0708439DA6EF7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dba13b6b-1c35-4908-0cbb-08d69afc829e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 08:37:42.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1309
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDIvMjAxOSBhdCAwNzo0MSwgQXhlbCBMaW4gd3JvdGU6DQo+IFRoZSBtb2R1bGUgdmVy
c2lvbiBpcyB1bmxpa2VseSB0byBiZSB1cGRhdGVkLCB1c2Uga2VybmVsIHZlcnNpb24gc2hvdWxk
IGJlDQo+IGVub3VnaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBp
bmdpY3MuY29tPg0KDQpBY2tlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNy
b2NoaXAuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3JlZ3VsYXRvci9tY3AxNjUwMi5jIHwgMSAt
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3JlZ3VsYXRvci9tY3AxNjUwMi5jIGIvZHJpdmVycy9yZWd1bGF0b3IvbWNwMTY1MDIu
Yw0KPiBpbmRleCAwZmM0OTYzYmQ1YjAuLjNhODAwNGFiZTA0NCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9yZWd1bGF0b3IvbWNwMTY1MDIuYw0KPiArKysgYi9kcml2ZXJzL3JlZ3VsYXRvci9tY3Ax
NjUwMi5jDQo+IEBAIC01NDcsNyArNTQ3LDYgQEAgc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIG1j
cDE2NTAyX2RydiA9IHsNCj4gICANCj4gICBtb2R1bGVfaTJjX2RyaXZlcihtY3AxNjUwMl9kcnYp
Ow0KPiAgIA0KPiAtTU9EVUxFX1ZFUlNJT04oIjEuMCIpOw0KPiAgIE1PRFVMRV9MSUNFTlNFKCJH
UEwgdjIiKTsNCj4gICBNT0RVTEVfREVTQ1JJUFRJT04oIk1DUDE2NTAyIFBNSUMgZHJpdmVyIik7
DQo+ICAgTU9EVUxFX0FVVEhPUigiQW5kcmVpIFN0ZWZhbmVzY3UgYW5kcmVpLnN0ZWZhbmVzY3VA
bWljcm9jaGlwLmNvbSIpOw0KPiANCg0KDQotLSANCk5pY29sYXMgRmVycmUNCg==
