Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC22C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A67217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BXC5GFwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAWQlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:41:08 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:36172 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAWQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:41:07 -0500
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="scan'208";a="26793349"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Jan 2019 09:41:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 23 Jan 2019 09:41:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MTR2WYTFYsBPfcjchEwMOVrEzXMuntxUh0hA599uck=;
 b=BXC5GFwCNY9OlasKPqN0gVFzRd6eczSSIoOg1BQEJph5rTPcqiRyMajwFEk/xvXyd2cvJc4mHi1IO4u09BFqhKn+fLlhPrFT9qw/nkrhu9w3NK6vdJfTIhnDFR5LDbm6wuCl9u6ckgHN/5O1TKvRvKBQ2KpK2OnlI5xovF1NeMs=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.173.16.10) by
 CY4PR11MB1367.namprd11.prod.outlook.com (10.173.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Wed, 23 Jan 2019 16:41:05 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::2cb0:2ec7:14d7:c503]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::2cb0:2ec7:14d7:c503%10]) with mapi id 15.20.1537.031; Wed, 23 Jan
 2019 16:41:05 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Thread-Topic: [PATCH v2] dmaengine: at_xdmac: Fix wrongfull report of a
 channel as in use
Thread-Index: AQHUszlq09QahfETH0Of1PoFTE5waKW9DnmA
Date:   Wed, 23 Jan 2019 16:41:05 +0000
Message-ID: <42d281c0-e44e-0b59-825d-3fcca8f523d5@microchip.com>
References: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::27) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:2d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR11MB1367;6:lkgQ+dM21Z6kCZkVSoKGpZAqW1jySwnSQPwiFZ2u7Qu7lPIvGMwI0LYCqv7XX/Y+hsL66y7MAFiRM25fiq2/6GSWLnlRl4m+UjwY4l/Kx+h8xEEWlkJ1Gu6MichnwXISAp7dQeM/7WiUsmYOvUwZ+QgYxpOvNOa+7uUtdWUjepsK1LjSM2JmPFt0peOMd/I9/OE7JyTubXdlKmnBigN5+//qpb4JUE8xRASdfdj02Eh7HfBBhNg7yEge+Ld53QdJqD6Dc0ksl+0KOZjKMBuWFm8YyJni/j8ku+Xf8rv6IKhVblzGqWVKudj5pl5C9TEyff9Btqa7EVp0msL/xi0C1jhBi+MZT3gdTWm/lHk4g8H66lPv9y6inSXEWV7go4ynzicZ6s+QttODZy4VQyrqUvQl8HrUWSJhyswBGO3wg9EAdKU5O1/A4nJwcy6oj4SvwKLgjTPrrFKr3tbxOiIReA==;5:5qS4V9/PInYff9YF8yKyTByFXfJjnNepfn6YG8g5zMDIbgTghPj2Ns6htOPW1qHlM/chsBqFpDxTtTHsvQsifoYT2vpxNvBJ3PFeLznmlLcF5/vGaLNJDw48UbM0GeToMWHolRLyNsRMrSkrcjJbUOeLMcVSHKLHRLZo1iJ1O05gEbM04TkxXtj7rO7DZeC367JjwdHuGWgrttehl5LGvw==;7:CTGcQZPk77tUQaoNIjcaODo59RwwISqO8wd1FgMCxJfb3hwfyx1LIzBZAk9fPHy6dQta4c7PBt8FxUMR/Fd/kKTBTXnpnhWNNA0bq2ohqgyudg6YPkombYMH3xB4PD0yAVJqDWXk9c/govyd40/TYw==
x-ms-office365-filtering-correlation-id: 5ac1f5d3-0d8c-48e6-ea38-08d681519175
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1367;
x-ms-traffictypediagnostic: CY4PR11MB1367:
x-microsoft-antispam-prvs: <CY4PR11MB136793861931BAC998A535E5E7990@CY4PR11MB1367.namprd11.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(366004)(376002)(189003)(199004)(478600001)(2616005)(256004)(52116002)(486006)(99286004)(31686004)(106356001)(105586002)(81156014)(4326008)(25786009)(2501003)(72206003)(476003)(76176011)(14444005)(26005)(6436002)(8676002)(81166006)(186003)(386003)(66066001)(102836004)(53546011)(6506007)(229853002)(6486002)(316002)(446003)(110136005)(11346002)(54906003)(68736007)(6512007)(8936002)(71190400001)(7736002)(2906002)(97736004)(305945005)(71200400001)(6246003)(3846002)(36756003)(6116002)(86362001)(53936002)(31696002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1367;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rLUJF4v9vOdN18RAH0rqmvh+W1MwQQxtlY7KH/sRi+Qpz6KAOyIzPOzakF8xAfOcC5ewl0CSX02yZKs83Iln0CPjCpwjtaeC1l+MyZbdR41Y6yxaBCwzeQp0/D+SHcU+nu2KNE4JrMTHyWYzYpja+iVJtOLZSmEaDgfB+8dQpBHppiavm7LIZ7v+OTl5TpEPdLZY6NxFfEFhQYfcBIWzAXyM+a/jSRgbYBjvyN3vwTfCW3/2ipn449ZyuxMsUmf0yvNb2CEBY9K/yLS3DAKklRdorPv8ECIOYpni/Uc5wZ3KHncpGl+7Fazbt6qWSV+X2jXsVMmeJv77VCq+Tlx17FPZLzI7UG8nEsvX5V5aG9kAeIA6Z5ISBJ/ygJ8xNV0Zx/tKgLrs0hrFkh9bocw3tntm+GHSPxMxgZCernE5y14=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C8B610914F9D145A1ECA19267A84FF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac1f5d3-0d8c-48e6-ea38-08d681519175
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 16:41:04.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1367
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDEuMjAxOSAxODozMywgQ29kcmluIENpdWJvdGFyaXUgLSBNMTk5NDAgd3JvdGU6DQo+
IEZyb206IENvZHJpbiBDaXVib3Rhcml1IDxjb2RyaW4uY2l1Ym90YXJpdUBtaWNyb2NoaXAuY29t
Pg0KPiANCj4gYXRjaGFuLT5zdGF0dXMgdmFyaWFibGUgaXMgdXNlZCB0byBzdG9yZSB0d28gZGlm
ZmVyZW50IGluZm9ybWF0aW9uOg0KPiAgIC0gcGFzcyBjaGFubmVsIGludGVycnVwdHMgc3RhdHVz
IGZyb20gaW50ZXJydXB0IGhhbmRsZXIgdG8gdGFza2xldDsNCj4gICAtIGNoYW5uZWwgaW5mb3Jt
YXRpb24gbGlrZSB3aGV0aGVyIGl0IGlzIGN5Y2xpYyBvciBwYXVzZWQ7DQo+IA0KPiBUaGlzIGNh
dXNlcyBhIGJ1ZyB3aGVuIGRldmljZV90ZXJtaW5hdGVfYWxsKCkgaXMgY2FsbGVkLA0KPiAoQVRf
WERNQUNfQ0hBTl9JU19DWUNMSUMgY2xlYXJlZCBvbiBhdGNoYW4tPnN0YXR1cykgYW5kIHRoZW4g
YSBsYXRlIEVuZA0KPiBvZiBCbG9jayBpbnRlcnJ1cHQgYXJyaXZlcyAoQVRfWERNQUNfQ0lTX0JJ
UyksIHdoaWNoIHNldHMgYml0IDAgb2YNCj4gYXRjaGFuLT5zdGF0dXMuIEJpdCAwIGlzIGFsc28g
dXNlZCBmb3IgQVRfWERNQUNfQ0hBTl9JU19DWUNMSUMsIHNvIHdoZW4NCj4gYSBuZXcgZGVzY3Jp
cHRvciBmb3IgYSBjeWNsaWMgdHJhbnNmZXIgaXMgY3JlYXRlZCwgdGhlIGRyaXZlciByZXBvcnRz
DQo+IHRoZSBjaGFubmVsIGFzIGluIHVzZToNCj4gDQo+IGlmICh0ZXN0X2FuZF9zZXRfYml0KEFU
X1hETUFDX0NIQU5fSVNfQ1lDTElDLCAmYXRjaGFuLT5zdGF0dXMpKSB7DQo+IAlkZXZfZXJyKGNo
YW4yZGV2KGNoYW4pLCAiY2hhbm5lbCBjdXJyZW50bHkgdXNlZFxuIik7DQo+IAlyZXR1cm4gTlVM
TDsNCj4gfQ0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgYnVnIGJ5IGFkZGluZyBhIGRpZmZl
cmVudCBzdHJ1Y3QgbWVtYmVyIHRvIGtlZXANCj4gdGhlIGludGVycnVwdHMgc3RhdHVzIHNlcGFy
YXRlZCBmcm9tIHRoZSBjaGFubmVsIHN0YXR1cyBiaXRzLg0KPiANCj4gRml4ZXM6IGUxZjdjOWVl
ZTcwNyAoImRtYWVuZ2luZTogYXRfeGRtYWM6IGNyZWF0aW9uIG9mIHRoZSBhdG1lbCBlWHRlbmRl
ZCBETUEgQ29udHJvbGxlciBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90
YXJpdSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCj4gQWNrZWQtYnk6IEx1ZG92
aWMgRGVzcm9jaGVzIDxsdWRvdmljLmRlc3JvY2hlc0BtaWNyb2NoaXAuY29tPg0KPiAtLS0NCg0K
Rm9yZ290IHRvIGFkZDoNCg0KQ2hhbmdlcyBpbiB2MjoNCiAgLSBjaGFuZ2VkIGNvbW1pdCBtZXNz
YWdlOw0KDQpJZiB5b3UgbmVlZCB2MyBmb3IgdGhpcyBsZXQgbWUga25vdy4NCg0KQmVzdCByZWdh
cmRzLA0KQ29kcmluDQoNCg==
