Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0870C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C4720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ABKsM+ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C4720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeIGFUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:06 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:29449
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731014AbeIGFTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMpN0ksWjWxoYWvK/oJbX40bCE+p0uPR2LMNmPHp+5w=;
 b=ABKsM+eivGV4bjOp0aTJR7epl+nnBMREFzzeftBEqSlD0fFmNVn5eYoFDRBZVnsDsjiazifCpMRwtDhRHcbIeGw1NTR+9JzJA2kR9lB0a4AghyrqOg9zKgxNy9DJimnAprVVtFGPmftSzUVKmiMlvGmzjtuDM5+SO2co6NO+JEI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 08/30] kbuild: add .DELETE_ON_ERROR special target
Thread-Topic: [PATCH AUTOSEL 4.4 08/30] kbuild: add .DELETE_ON_ERROR special
 target
Thread-Index: AQHURkMrf7oKHs+Hb0a0ho+pYx56lA==
Date:   Fri, 7 Sep 2018 00:39:01 +0000
Message-ID: <20180907003853.57942-8-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:oKn4zyQQJtQYKLqUZdqsM7UT80Goe+AO3sgfVJL54X+ftpkx3TNG5yovNcCSAK5UPC4yscbzfhTfrY9WQiMlIv3Zi6yW/7BioKkmKSSHtLTKtE1i6iYRC8HYICD0WOSjqa7ehhkXh1tsKtG1OgmNO6SGo2+lgF09Z9j1JdWEmWmYQ2hsV+737sgjLfjNZ2K63xn0Y/E9lS0hRoy1w43fPvJXz+V4cNTGQoePVVgaY06ikos+tHPP616VGYNZTwIo+NpwKRXEysJxL8m5Mb/EaCA2VTwoFE3Y59luJEG/sDYeQSBnk/t4BIfT1FVuIU3nntqktu2pFauc/i1Vdwff8YprsX0VVv2/RZxD2oBm5vYLOUul5LHoeu2TGRY6J36jvHbrQ1I6iLYOjTgtadX55iRY7ZdSgMgmR+z0TPRsyGV2zqFYYNlgl8aD1dAmSc0MeeoabtaidhsUmVKELALEWg==;5:FNwWXE8UfC1C8UwWXeiWl1MaPCiTiHADqqq4VMWbi4jGS6kFeRWvHESrVRAfCV1jq+lHjv9A8C5AFLeGNKEHN/STLyPB8oH+tEJ5U3COVEdRlBExfk+rC5xMWWIz8hvEvR8I1FqWjodnPBWBYgqJakbv2Narc3i4yxusWha7hTc=;7:Br2vjo86G4KVQXyUzCPXb72rbaCSw2KpFOvTEWBp1P3AbbSk5OZ4SlQYeYPqkNHt1lNrdTP+BfOzisTA2276GP9O9erVuhlqnRpK719lHZoQs7Q+wjo4ImQdO5SCN6X8ByBR4rnFlXL/6tV3wpUYesfEVXORNHP9rk6Mny8bTmS3wzqHUWB2MyQxBerAT3Jm0SEvYfjyXsPROKre8CogIJCmbGuCdNRgWmXYQKHU18f4UV3IA1js90o2EPd3alvO
x-ms-office365-filtering-correlation-id: f234d460-5a28-4084-cb77-08d6145aa5e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08532968F80E1D97757FFC48FB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(14444005)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(86612001)(142923001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: klFsZVU1VwVf2xyUP2fe1ZpEqKb//Xfbv5yQzc5ZHBIJCo/duooYeEFYodApmWXYre3A4oPZUHLMYWcro1yKGbLCfJSmOlI5J9Pb+ig2UVDEFt+l7ZaElRfOB56TH47SCWWSJFuvac+tVaRf+dveaNfmB8rw0oCrtq6b/L8g5hlEFpHkby+k2VNmx+C8kR1MEKvECuzoVgEsX1EhZTFvWDm//mBRr+foA07DCpt6Ra1dYQfX5aWI9jeCNC+ZpLzwyMAB0heJzi3J6LWc8lccf5dwYAuE9GmEyYU6TJ/xRvkVhratu2CRHWSZrjBgihXa6FmGWYui0uXqWFhGXYZllU2uknHqPNk6Xx/kM8txgbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2DB4215A8316540A89B6953810092EA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f234d460-5a28-4084-cb77-08d6145aa5e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:01.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4NCg0K
WyBVcHN0cmVhbSBjb21taXQgOWMyYWYxYzczNzdhOGE2ZWY4NmU1Y2FiZjgwOTc4ZjNkYmJiMjVj
MCBdDQoNCklmIE1ha2UgZ2V0cyBhIGZhdGFsIHNpZ25hbCB3aGlsZSBhIHNoZWxsIGlzIGV4ZWN1
dGluZywgaXQgbWF5IGRlbGV0ZQ0KdGhlIHRhcmdldCBmaWxlIHRoYXQgdGhlIHJlY2lwZSB3YXMg
c3VwcG9zZWQgdG8gdXBkYXRlLiAgVGhpcyBpcyBuZWVkZWQNCnRvIG1ha2Ugc3VyZSB0aGF0IGl0
IGlzIHJlbWFkZSBmcm9tIHNjcmF0Y2ggd2hlbiBNYWtlIGlzIG5leHQgcnVuOyBpZg0KTWFrZSBp
cyBpbnRlcnJ1cHRlZCBhZnRlciB0aGUgcmVjaXBlIGhhcyBiZWd1biB0byB3cml0ZSB0aGUgdGFy
Z2V0IGZpbGUsDQppdCByZXN1bHRzIGluIGFuIGluY29tcGxldGUgZmlsZSB3aG9zZSB0aW1lIHN0
YW1wIGlzIG5ld2VyIHRoYW4gdGhhdA0Kb2YgdGhlIHByZXJlcXVpc2l0ZXMgZmlsZXMuICBNYWtl
IGF1dG9tYXRpY2FsbHkgZGVsZXRlcyB0aGUgaW5jb21wbGV0ZQ0KZmlsZSBvbiBpbnRlcnJ1cHQg
dW5sZXNzIHRoZSB0YXJnZXQgaXMgbWFya2VkIC5QUkVDSU9VUy4NCg0KVGhlIHNpdHVhdGlvbiBp
cyBqdXN0IHRoZSBzYW1lIGFzIHdoZW4gdGhlIHNoZWxsIGZhaWxzIGZvciBzb21lIHJlYXNvbnMu
DQpVc3VhbGx5IHdoZW4gYSByZWNpcGUgbGluZSBmYWlscywgaWYgaXQgaGFzIGNoYW5nZWQgdGhl
IHRhcmdldCBmaWxlIGF0DQphbGwsIHRoZSBmaWxlIGlzIGNvcnJ1cHRlZCwgb3IgYXQgbGVhc3Qg
aXQgaXMgbm90IGNvbXBsZXRlbHkgdXBkYXRlZC4NCllldCB0aGUgZmlsZeKAmXMgdGltZSBzdGFt
cCBzYXlzIHRoYXQgaXQgaXMgbm93IHVwIHRvIGRhdGUsIHNvIHRoZSBuZXh0DQp0aW1lIE1ha2Ug
cnVucywgaXQgd2lsbCBub3QgdHJ5IHRvIHVwZGF0ZSB0aGF0IGZpbGUuDQoNCkhvd2V2ZXIsIE1h
a2UgZG9lcyBub3QgY2F0ZXIgdG8gZGVsZXRlIHRoZSBpbmNvbXBsZXRlIHRhcmdldCBmaWxlIGlu
DQp0aGlzIGNhc2UuICBXZSBuZWVkIHRvIGFkZCAuREVMRVRFX09OX0VSUk9SIHNvbWV3aGVyZSBp
biB0aGUgTWFrZWZpbGUNCnRvIHJlcXVlc3QgaXQuDQoNCnNjcmlwdHMvS2J1aWxkLmluY2x1ZGUg
c2VlbXMgYSBzdWl0YWJsZSBwbGFjZSB0byBhZGQgaXQgYmVjYXVzZSBpdCBpcw0KaW5jbHVkZWQg
ZnJvbSBhbG1vc3QgYWxsIHN1Yi1tYWtlcy4NCg0KUGxlYXNlIG5vdGUgLkRFTEVURV9PTl9FUlJP
UiBpcyBub3QgZWZmZWN0aXZlIGZvciBwaG9ueSB0YXJnZXRzLg0KDQpUaGUgZXh0ZXJuYWwgbW9k
dWxlIGJ1aWxkaW5nIHNob3VsZCBuZXZlciBldmVyIHRvdWNoIHRoZSBrZXJuZWwgdHJlZS4NClRo
ZSBmb2xsb3dpbmcgcmVjaXBlIGZhaWxzIGlmIGluY2x1ZGUvZ2VuZXJhdGVkL2F1dG9jb25mLmgg
aXMgbWlzc2luZy4NCkhvd2V2ZXIsIGluY2x1ZGUvY29uZmlnL2F1dG8uY29uZiBpcyBub3QgZGVs
ZXRlZCBzaW5jZSBpdCBpcyBhIHBob255DQp0YXJnZXQuDQoNCiBQSE9OWSArPSBpbmNsdWRlL2Nv
bmZpZy9hdXRvLmNvbmYNCg0KIGluY2x1ZGUvY29uZmlnL2F1dG8uY29uZjoNCiAgICAgICAgICQo
USl0ZXN0IC1lIGluY2x1ZGUvZ2VuZXJhdGVkL2F1dG9jb25mLmggLWEgLWUgJEAgfHwgKCAgICAg
ICAgICBcDQogICAgICAgICBlY2hvID4mMjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgZWNobyA+JjIgIiAgRVJST1I6IEtl
cm5lbCBjb25maWd1cmF0aW9uIGlzIGludmFsaWQuIjsgICAgICAgICAgIFwNCiAgICAgICAgIGVj
aG8gPiYyICIgICAgICAgICBpbmNsdWRlL2dlbmVyYXRlZC9hdXRvY29uZi5oIG9yICRAIGFyZSBt
aXNzaW5nLiI7XA0KICAgICAgICAgZWNobyA+JjIgIiAgICAgICAgIFJ1biAnbWFrZSBvbGRjb25m
aWcgJiYgbWFrZSBwcmVwYXJlJyBvbiBrZXJuZWwgc3JjIHRvIGZpeCBpdC4iOyBcDQogICAgICAg
ICBlY2hvID4mMiA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KICAgICAgICAgL2Jpbi9mYWxzZSkNCg0KU2lnbmVkLW9mZi1ieTogTWFzYWhp
cm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4NClNpZ25lZC1vZmYtYnk6
IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIHNjcmlw
dHMvS2J1aWxkLmluY2x1ZGUgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUgYi9zY3JpcHRzL0tidWls
ZC5pbmNsdWRlDQppbmRleCAzMWE5ODFkNjIyOWQuLjU4OTdmYzM4NTdhMCAxMDA2NDQNCi0tLSBh
L3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUNCisrKyBiL3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUNCkBA
IC0zNTksMyArMzU5LDYgQEAgZW5kaWYNCiBlbmRlZg0KICMNCiAjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjDQorDQorIyBkZWxldGUgcGFydGlhbGx5IHVwZGF0ZWQgKGkuZS4gY29ycnVwdGVkKSBmaWxl
cyBvbiBlcnJvcg0KKy5ERUxFVEVfT05fRVJST1I6DQotLSANCjIuMTcuMQ0K
