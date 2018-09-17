Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C812147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JuVtUW1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C812147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeIQI1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:03 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729016AbeIQI0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deO+6twI5CMaaqBA73B44JW0DhFAn2fM/+shoQN+RvM=;
 b=JuVtUW1scd/XHyl7vqS3krcQL8CqVCocWTqn91b1rguWkvgM3bPiO8RsaeAiaGLHFzES7fnxw/WKVtLvTIuejvgOflEV/ZGTsxABx7iJuiBhd9mBX8HqHD1mQo90Y17oU+RB83XxGtH+3Gx1lMxJfr6IJlrb9vV0EN8D8ciXjmw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?= <jprvita@gmail.com>,
        =?utf-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 056/136] platform/x86: asus-wireless: Fix
 uninitialized symbol usage
Thread-Topic: [PATCH AUTOSEL 4.18 056/136] platform/x86: asus-wireless: Fix
 uninitialized symbol usage
Thread-Index: AQHUTjKhEhIdpAVH+kWPPSYvK96bTw==
Date:   Mon, 17 Sep 2018 03:00:47 +0000
Message-ID: <20180917030006.245495-56-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:0QJC45CedIgn4gVt3kH5HSDdouTJo1idn2/+l/cfDXp6CzSvhKPed9e1cHk1csvRIb3s3BzrsLG8Yme+tC4xdSyO1mGsxxlVN5NrNeTrSb2psdf9oeeLitTRuUEgGqtAYohIt0m8KbYYc1BijXM6fVsQmktMgcG+fS9yuxXoigAI3TvOqjSnbAdk+6tv4DZursihN41q8ApI7ds12kVO3nSbZNyFCcX2EbqrBlpxyNu4SkxZaytASy8D8HjC6o5Je+nr+qpcreCe/XMJ+rGeg/j8X+8FuiqwBWXv+9awHybAQOiZ1gmTsZFB8RV/I7zTN5Fcm8GHUzaG537Xlk48oN/8O+CGb8wfdWXJ4AbzmXwchnerExbXna8OU0AoDoVlEvua3wIO8x4HRVKsfHy3WaSc2PFqHZ2Z8iisyZfG4Zh6PIsTcNe8lZoDco2XB3hdbHTtzweYhYxS8/Ff0y9UPQ==;5:thacau7Z4y45zIgxd+k1vuw81e7vXlX1YpiFtLkF+RYQRehj0kNLRgd/Po1OmR7ekK6XwkaM8DOqm4HR2kkMosWHtyGAxlARHYzfIGp/fnQNG73wpLgE0Cms2EsXm7DcI0ndczYyh9iw8/rWQAorGHsWWiQMbri89vQKNh48ycM=;7:BL6Sx4cT9+wlMPDMsxKyJ0DkJYo6elLcGq7KAnai45JsFtwrNuTrX1mPzamnuDPWkIWq6HwU3hkZIbvZnet1LbMO5sXYie6+hY8EqwF1saU6WiIAGENwjAiN4tI34mkmXVhMLrVjotwALCIwf5UpDpE42r21L+8QDZhs4zYpDrqvnDhYHWUoapxVKnkRc48kTjxO6/cWNI85JHWgO0bKTbJtU+8lWiwb/3p4YM6JENmXsNNsnB8hrW/ixRhYsQuL
x-ms-office365-filtering-correlation-id: 421707bf-4e71-4e3a-ca73-08d61c49d552
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01673C835DA1409B5E65FF05FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(39060400002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(575784001)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /ewlup6/4IxrqkuRmhpdmojMHOVucDXHNcTollH5jdfVNGhLR3ZWI6ISNwzNitTbVG5hQ70lKezQoG9Hgy/vsN3fi8NyxCoxFHTmlEORvRwkc7y4CD6aYM0yCOIcY2mUK9Tr90JVnYfVjX1R/jzpEPb8vSlMnztpaUtN8rCFi9a0v/FO48PUl2A41cHLaruko38a5zdU0CHgCg4x6YJ96h18cQ1//gzj7gpTs5tN7d3tH+mRMDpiYR6qSKPtCBEeMy8/ZtIaZANVXuSP6hvQzMSruxhPIKPJSBT/pyIu2SA9TofN1g3P21VUPRsGYnVfWC4HKjZ25FEc25IHLsqAZBy43N27Zf+zlkG1EDBluhE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D8D23820DA1974AA645551119CC4C13@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421707bf-4e71-4e3a-ca73-08d61c49d552
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:47.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm/Do28gUGF1bG8gUmVjaGkgVml0YSA8anBydml0YUBnbWFpbC5jb20+DQoNClsgVXBz
dHJlYW0gY29tbWl0IGVjYTRjNGU0N2ViMDY1OGFkMjUxZjBiZmY0NjVlMjNjMDU1Mzc3ZGEgXQ0K
DQoncmV0JyB3aWxsIG5vdCBiZSBpbml0aWFsaXplZCBpZiBhY3BpX2V2YWx1YXRlX2ludGVnZXIo
KSByZXR1cm5zIHRocm91Z2gNCmFuIGVycm9yIHBhdGgsIHNvIGl0IHNob3VsZCBub3QgYmUgdXNl
ZCBpbiB0aGlzIGNhc2UuIFRoaXMgZml4ZXMgdGhlDQpmb2xsb3dpbmcgU21hdGNoIHN0YXRpYyBh
bmFseXNlciBlcnJvcjoNCg0KIGRyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd2lyZWxlc3MuYzo3
NiBhc3VzX3dpcmVsZXNzX21ldGhvZCgpIGVycm9yOg0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bmluaXRpYWxpemVkIHN5bWJvbCAncmV0Jy4N
Cg0KUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IEpvw6NvIFBhdWxvIFJlY2hpIFZpdGEgPGpwcnZpdGFAZW5kbGVzc20u
Y29tPg0KU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxl
dmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdpcmVs
ZXNzLmMgfCAyMyArKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2FzdXMtd2lyZWxlc3MuYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd2ly
ZWxlc3MuYw0KaW5kZXggNmFmZDAxMWRlOWU1Li5iOGUzNWE4ZDY1Y2YgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdpcmVsZXNzLmMNCisrKyBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L2FzdXMtd2lyZWxlc3MuYw0KQEAgLTUyLDEzICs1MiwxMiBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGFjcGlfZGV2aWNlX2lkIGRldmljZV9pZHNbXSA9IHsNCiB9Ow0KIE1PRFVMRV9ERVZJ
Q0VfVEFCTEUoYWNwaSwgZGV2aWNlX2lkcyk7DQogDQotc3RhdGljIHU2NCBhc3VzX3dpcmVsZXNz
X21ldGhvZChhY3BpX2hhbmRsZSBoYW5kbGUsIGNvbnN0IGNoYXIgKm1ldGhvZCwNCi0JCQkJaW50
IHBhcmFtKQ0KK3N0YXRpYyBhY3BpX3N0YXR1cyBhc3VzX3dpcmVsZXNzX21ldGhvZChhY3BpX2hh
bmRsZSBoYW5kbGUsIGNvbnN0IGNoYXIgKm1ldGhvZCwNCisJCQkJCWludCBwYXJhbSwgdTY0ICpy
ZXQpDQogew0KIAlzdHJ1Y3QgYWNwaV9vYmplY3RfbGlzdCBwOw0KIAl1bmlvbiBhY3BpX29iamVj
dCBvYmo7DQogCWFjcGlfc3RhdHVzIHM7DQotCXU2NCByZXQ7DQogDQogCWFjcGlfaGFuZGxlX2Rl
YnVnKGhhbmRsZSwgIkV2YWx1YXRpbmcgbWV0aG9kICVzLCBwYXJhbWV0ZXIgJSN4XG4iLA0KIAkJ
CSAgbWV0aG9kLCBwYXJhbSk7DQpAQCAtNjcsMjQgKzY2LDI3IEBAIHN0YXRpYyB1NjQgYXN1c193
aXJlbGVzc19tZXRob2QoYWNwaV9oYW5kbGUgaGFuZGxlLCBjb25zdCBjaGFyICptZXRob2QsDQog
CXAuY291bnQgPSAxOw0KIAlwLnBvaW50ZXIgPSAmb2JqOw0KIA0KLQlzID0gYWNwaV9ldmFsdWF0
ZV9pbnRlZ2VyKGhhbmRsZSwgKGFjcGlfc3RyaW5nKSBtZXRob2QsICZwLCAmcmV0KTsNCisJcyA9
IGFjcGlfZXZhbHVhdGVfaW50ZWdlcihoYW5kbGUsIChhY3BpX3N0cmluZykgbWV0aG9kLCAmcCwg
cmV0KTsNCiAJaWYgKEFDUElfRkFJTFVSRShzKSkNCiAJCWFjcGlfaGFuZGxlX2VycihoYW5kbGUs
DQogCQkJCSJGYWlsZWQgdG8gZXZhbCBtZXRob2QgJXMsIHBhcmFtICUjeCAoJWQpXG4iLA0KIAkJ
CQltZXRob2QsIHBhcmFtLCBzKTsNCi0JYWNwaV9oYW5kbGVfZGVidWcoaGFuZGxlLCAiJXMgcmV0
dXJuZWQgJSNsbHhcbiIsIG1ldGhvZCwgcmV0KTsNCi0JcmV0dXJuIHJldDsNCisJZWxzZQ0KKwkJ
YWNwaV9oYW5kbGVfZGVidWcoaGFuZGxlLCAiJXMgcmV0dXJuZWQgJSNsbHhcbiIsIG1ldGhvZCwg
KnJldCk7DQorDQorCXJldHVybiBzOw0KIH0NCiANCiBzdGF0aWMgZW51bSBsZWRfYnJpZ2h0bmVz
cyBsZWRfc3RhdGVfZ2V0KHN0cnVjdCBsZWRfY2xhc3NkZXYgKmxlZCkNCiB7DQogCXN0cnVjdCBh
c3VzX3dpcmVsZXNzX2RhdGEgKmRhdGE7DQotCWludCBzOw0KKwlhY3BpX3N0YXR1cyBzOw0KKwl1
NjQgcmV0Ow0KIA0KIAlkYXRhID0gY29udGFpbmVyX29mKGxlZCwgc3RydWN0IGFzdXNfd2lyZWxl
c3NfZGF0YSwgbGVkKTsNCiAJcyA9IGFzdXNfd2lyZWxlc3NfbWV0aG9kKGFjcGlfZGV2aWNlX2hh
bmRsZShkYXRhLT5hZGV2KSwgIkhTV0MiLA0KLQkJCQkgZGF0YS0+aHN3Y19wYXJhbXMtPnN0YXR1
cyk7DQotCWlmIChzID09IGRhdGEtPmhzd2NfcGFyYW1zLT5vbikNCisJCQkJIGRhdGEtPmhzd2Nf
cGFyYW1zLT5zdGF0dXMsICZyZXQpOw0KKwlpZiAoQUNQSV9TVUNDRVNTKHMpICYmIHJldCA9PSBk
YXRhLT5oc3djX3BhcmFtcy0+b24pDQogCQlyZXR1cm4gTEVEX0ZVTEw7DQogCXJldHVybiBMRURf
T0ZGOw0KIH0NCkBAIC05MiwxMCArOTQsMTEgQEAgc3RhdGljIGVudW0gbGVkX2JyaWdodG5lc3Mg
bGVkX3N0YXRlX2dldChzdHJ1Y3QgbGVkX2NsYXNzZGV2ICpsZWQpDQogc3RhdGljIHZvaWQgbGVk
X3N0YXRlX3VwZGF0ZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogew0KIAlzdHJ1Y3QgYXN1
c193aXJlbGVzc19kYXRhICpkYXRhOw0KKwl1NjQgcmV0Ow0KIA0KIAlkYXRhID0gY29udGFpbmVy
X29mKHdvcmssIHN0cnVjdCBhc3VzX3dpcmVsZXNzX2RhdGEsIGxlZF93b3JrKTsNCiAJYXN1c193
aXJlbGVzc19tZXRob2QoYWNwaV9kZXZpY2VfaGFuZGxlKGRhdGEtPmFkZXYpLCAiSFNXQyIsDQot
CQkJICAgICBkYXRhLT5sZWRfc3RhdGUpOw0KKwkJCSAgICAgZGF0YS0+bGVkX3N0YXRlLCAmcmV0
KTsNCiB9DQogDQogc3RhdGljIHZvaWQgbGVkX3N0YXRlX3NldChzdHJ1Y3QgbGVkX2NsYXNzZGV2
ICpsZWQsIGVudW0gbGVkX2JyaWdodG5lc3MgdmFsdWUpDQotLSANCjIuMTcuMQ0K
