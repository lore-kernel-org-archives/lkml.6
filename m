Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E889C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E421020837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jltMV2kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E421020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeIBRWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:19 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:51200
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728881AbeIBRWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCknxfXGcbqiaalTiAl759L5JRr4exDfQaOwjtuQOAU=;
 b=jltMV2khtVjrUUTelDUVa+8dL1LriYfybIOSPJnIJHcCzlSMkeMvrOqskiXh8LnPXvMxyXWEh7q4x7L/H+kxXp280N6owGrSNvlx5EL7Yl82HqMVCK9RP/w5E8qZ6gHGSpZef88GEhOMVu7PyCg/0nPgmwg+61IOHUxtfQVzJPM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 05/89] Bluetooth: h5: Fix missing dependency on
 BT_HCIUART_SERDEV
Thread-Topic: [PATCH AUTOSEL 4.14 05/89] Bluetooth: h5: Fix missing dependency
 on BT_HCIUART_SERDEV
Thread-Index: AQHUQr263l9GKNiNaUeBBARcQkFppg==
Date:   Sun, 2 Sep 2018 13:06:15 +0000
Message-ID: <20180902064918.183387-5-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:qzsuMxIQsrw6M07n3kMYolmv5NTeJl/1nIQA4c59PQwvhQcg3ZNjwKb3JLXqUIlz3tTfYYNh43n1p9jZl99Ma+oGKpAucODS5QOwMErVlHAMkLOimwE5Ncb3z6VhFUOsU1ANGPQPpGhLMmwmHARdY34LtoWIULIfuRHsDaqtF4uu9Ib7wcCVu+qlWEjzz8Cx54UEToge4/dHR8S5FLJoew8Qht/jYFqT3f8mhxSfSayCNEqnnK4grf6jWwrS7niP4FmOWVgPKUky5ud7bkYMmbknFqwma+AG/Pzkc/Yh4vd8gkPjFuruNTs5kpIcE7iqFHGt5VaaAY+euzDumLT1tKrPT0WE3CnHE2VEAF7sfWBbilucGgG00U78B9ZU2RFNoFxqsHmOwSStiYaYcm6E6PWKObBPoYn9/U2pXvKdULlPk6xuj0iUmsnVmO+7Nn7WOM37otrGdRMANYTX8joCZA==;5:APnAENA1j86SdNC4lYcDtofgEuY3Ou4s6696hBpFcP0m2MPM2kOWUGOiuNcYDb9R4bGXoVTT6E0VdxiT57Z5PnbzYWpAKrVG36tejUN+oh+PiIK48r5wIGxDKqPGDUfEC6+XQFyTV/758tExapxO/0ij8zEz2ram8q0VHCWfYb4=;7:RGGNBG9slK6kUIdtD8hcNKXRzgef2960kJz5eOrnKxQtCz8GClLBQqIh9wOBkgONnuli9Ny8YXuJoUSWGaBo+8qTfY3YHnDV3JEj5Pe+GDE/7NcKI2usy1ohI684sFSV1Hh9F+LEFBogDBl/ab7DxaAOVg8UcoIr1iYA0XuycuPPaVsxPIi8fniCe+21Gir1HKAMgdJK0KcXqhPbV7SC3YTSWOU/B9gfjbXY8wHy6KKIWfFpTnorH+Cp1OXEmDFx
x-ms-office365-filtering-correlation-id: 674ecb75-c15f-459b-d024-08d610d4e145
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822BDEF736731B376CC1061FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZZjXhGTDoEQQbw5EoeIEhM6EPpjovsTNKe3fc8/UYxzfwc/Z2ZH4vR1VIKevtmS8y6ayqP6xpydGBQ12YxJSoMmk6V8XAoegBbhGaiogdTnqC42r4g3fDviHu6//YTVxCh7G1b070a9Wa0aZHEyVwUUmhHCkEfsacP2ORLsqC2pc36V6lQ2JQoMhdwR03CEvOYnl1W+LCrf4qWTbdsYZl7otJbaU25KAtDNeIG0k/FNwUNRvRJa0zhHoTpSPO8X6I2WyamxD75GUtHbCpKw2sPbCMlNY/3WOtR1IhJteWUboiLcIMpUnxnQIvUOFJ+LUvnl3F3WcXOvIi+/JSRrSN3he3DEQ3NpeqDIHZn6baMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E36B9FB5A60074DAF527973CB2C3BA5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674ecb75-c15f-459b-d024-08d610d4e145
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:15.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9oYW4gSGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BpbnRlbC5jb20+DQoNClsgVXBzdHJl
YW0gY29tbWl0IDZjMzcxMWVjNjRmZDIzYTlhYmM4YWFmNTlhOTQyOTU2OWE2MjgyZGYgXQ0KDQpU
aGlzIGRyaXZlciB3YXMgcmVjZW50bHkgdXBkYXRlZCB0byB1c2Ugc2VyZGV2LCBzbyBhZGQgdGhl
IGFwcHJvcHJpYXRlDQpkZXBlbmRlbmN5LiBXaXRob3V0IHRoaXMgb25lIGNhbiBnZXQgY29tcGls
ZXIgd2FybmluZ3MgbGlrZSB0aGlzIGlmDQpDT05GSUdfU0VSSUFMX0RFVl9CVVMgaXMgbm90IGVu
YWJsZWQ6DQoNCiAgQ0MgW01dICBkcml2ZXJzL2JsdWV0b290aC9oY2lfaDUubw0KZHJpdmVycy9i
bHVldG9vdGgvaGNpX2g1LmM6OTM0OjM2OiB3YXJuaW5nOiDigJhoNV9zZXJkZXZfZHJpdmVy4oCZ
IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC12YXJpYWJsZV0NCiBzdGF0aWMgc3RydWN0
IHNlcmRldl9kZXZpY2VfZHJpdmVyIGg1X3NlcmRldl9kcml2ZXIgPSB7DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+DQoNClNpZ25lZC1vZmYtYnk6
IEpvaGFuIEhlZGJlcmcgPGpvaGFuLmhlZGJlcmdAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTog
TWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KU2lnbmVkLW9mZi1ieTogU2Fz
aGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9i
bHVldG9vdGgvS2NvbmZpZyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvS2NvbmZpZyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL0tjb25maWcNCmluZGV4IGIzM2M4ZDZlYjhjNy4uNTAwZDRkNjMyZTQ4IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ibHVldG9vdGgvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9ibHVldG9vdGgvS2Nv
bmZpZw0KQEAgLTE0Niw2ICsxNDYsNyBAQCBjb25maWcgQlRfSENJVUFSVF9MTA0KIGNvbmZpZyBC
VF9IQ0lVQVJUXzNXSVJFDQogCWJvb2wgIlRocmVlLXdpcmUgVUFSVCAoSDUpIHByb3RvY29sIHN1
cHBvcnQiDQogCWRlcGVuZHMgb24gQlRfSENJVUFSVA0KKwlkZXBlbmRzIG9uIEJUX0hDSVVBUlRf
U0VSREVWDQogCWhlbHANCiAJICBUaGUgSENJIFRocmVlLXdpcmUgVUFSVCBUcmFuc3BvcnQgTGF5
ZXIgbWFrZXMgaXQgcG9zc2libGUgdG8NCiAJICB1c2VyIHRoZSBCbHVldG9vdGggSENJIG92ZXIg
YSBzZXJpYWwgcG9ydCBpbnRlcmZhY2UuIFRoZSBIQ0kNCi0tIA0KMi4xNy4xDQo=
