Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36EB2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eBQDh6x9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36EB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeIBRqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:46:16 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeIBRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlT8QqfrfbH5warZYxkBlHHGBXV6zD/3LD/KAgsQb2I=;
 b=eBQDh6x9u35+rktJw60kIanrezWFZ5DEfLAzCADG2VCDaFJUrh2P9zol0x2/JFE6VqJSUBXW5nSaV+zkXp5sF3OfvPuxGgkK69wReOKqG9MqnMWLaSdQ6CxwsAtW8jkitNrItIEmJqmiifuuSyzFAyy8UC+taOtYGtM3eWA60jc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 099/131] media: rcar-csi2: update stream start
 for V3M
Thread-Topic: [PATCH AUTOSEL 4.18 099/131] media: rcar-csi2: update stream
 start for V3M
Thread-Index: AQHUQr2SORuYNnaunkqgoBmi7SqSiQ==
Date:   Sun, 2 Sep 2018 13:05:08 +0000
Message-ID: <20180902064601.183036-99-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:k6f+Q8W5aKjgJldDgBrVM+1AIoTX3Dd/oDModSveUF1mLedIWZqfi+zzEfcguH/EZrvVHzGfRhbWulWw0MHOmSqZnYZuZExqYktoJJjcgHUNOaZq94xHZy644GMaOGz/GoQtijTrzmEv4iqQtZpKNBxSFGhVsQreHmIOdLURqzZxrca/CX83mCk5DsLBdHBC3vuxUQtCqZIoPWRexptUAL+JmOjowJTwU/RzFp0L4YqzwKMsfBF0PkY8XFoWEthDBlvCxXRZ/MX93y/MsOE78znjgH4FuV8EME6lCCu9475pnRblWyrcyd0yIrqFHLE1W6Mc/ixx9WPu7/mkT82UB1w2ciPYMfOlZO9Vk7nFVk7pgkJJlf/ZuaYi4f54mcVN+pLqNaxleKU5SyXvDsao/bzKYCMJi4bZ6mkaPNhSb+LghsDSkzD0ZMNNtnB2mjSvNVsvUsN5uSgEiz7afDy86g==;5:IOgf41E2cX/B6iDSTlKKqXBF1XF0HXz8ybfbl9s/BnAe+FZHf0p4MYmigZ28Z+a01Cc5o3poUpEfGLDOEyUtwGYfuUrK5OC1SOWceSuA+YkgRlPoExUkGS5CeazUsfA+LiCkl8tnbjnFsyFPQptrG5P9mmUXQDyDq+KcRBuTOBw=;7:rxzJyYSBkPm16/c8c4XXWtXJieaKQRGIm+9ViWWN0K5ndNqYwZAiwKvKsElAnqDtQa/RsL89b2oQXV24ZllDAxXLdDFL/EWyICteN1AF3kG8K4r5bM+pLDfY8weWJ3vllh3PkzLiGcvK8zB6WotFvV8H7CycutQa8z/3yewZQ0kCB1KUL+km1HXA2insecY5LNq3g5taU6V0MwY2QWDWVBAuq8W8xSmM+JhJw2nh99I0oPMuuI34Zt77kTlHVkYe
x-ms-office365-filtering-correlation-id: 9c361647-2e2c-4b2d-e65d-08d610d4c513
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184B76D8020C566B9EA0EF4FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(15650500001)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W1o4e2W9S0Fc+nTNcdAeCw8nGkAmywQpOgw7QrTgJbL9KfHpBx8hVr3rJc5lXq6jIBjgHCATUK3unDJ0DvSOaWHS4C+0ziTBDAWCnfNIZkM365I9ETQSn+aW7ba/TqugMz/qNzSIO/Ytl51pd5pxx4g2EZNhVSFv4/moQHtPavh8TPPt6jDddeE6JQgT7uHn6YbXjikmb5p9xu3AstUP7OvTmUdtBfZOiwx4euuxYnZKASSQYBKQJDJY02FR3ex7jSnphOa+f+8A6RjI7YaRtlJGvp14WzjfaRPtJJnxDHkocu/EaisUbR/YD6shcaxE0+uV/XDpUka4H7RLj5rtnUjA7lhN1g/QI+fY4EOpW+w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C035C85969EE5B4E8C12D149AF5959D8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c361647-2e2c-4b2d-e65d-08d610d4c513
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:08.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmlrbGFzIFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmQrcmVuZXNhc0ByYWduYXRl
Y2guc2U+DQoNClsgVXBzdHJlYW0gY29tbWl0IDQwNzBmYzlhZGU1MmY3ZDBhZDEzOTdmZTc0ZjU2
NGFlOTVlNjhhNGYgXQ0KDQpMYXRlc3QgZXJyYXRhIGRvY3VtZW50IHVwZGF0ZXMgdGhlIHN0YXJ0
IHByb2NlZHVyZSBmb3IgVjNNLiBUaGlzIGNoYW5nZQ0KaW4gYWRkaXRpb24gdG8gYWRoZXJpbmcg
dG8gdGhlIGRhdGFzaGVldCB1cGRhdGUgZml4ZXMgY2FwdHVyZSBvbiBlYXJseQ0KcmV2aXNpb25z
IG9mIFYzTS4NCg0KU2lnbmVkLW9mZi1ieTogTmlrbGFzIFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rl
cmx1bmQrcmVuZXNhc0ByYWduYXRlY2guc2U+DQpSZXZpZXdlZC1ieTogTGF1cmVudCBQaW5jaGFy
dCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KU2lnbmVkLW9mZi1ieTogSGFu
cyBWZXJrdWlsIDxoYW5zLnZlcmt1aWxAY2lzY28uY29tPg0KU2lnbmVkLW9mZi1ieTogTWF1cm8g
Q2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK3NhbXN1bmdAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYt
Ynk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRy
aXZlcnMvbWVkaWEvcGxhdGZvcm0vcmNhci12aW4vcmNhci1jc2kyLmMgfCAyMCArKysrKysrKysr
KysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9yY2FyLXZpbi9yY2Fy
LWNzaTIuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcmNhci12aW4vcmNhci1jc2kyLmMNCmlu
ZGV4IGRhZWY3MmQ0MTBhMy4uZGM1YWU4MDI1ODMyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9yY2FyLXZpbi9yY2FyLWNzaTIuYw0KKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9yY2FyLXZpbi9yY2FyLWNzaTIuYw0KQEAgLTMzOSw2ICszMzksNyBAQCBlbnVtIHJjYXJf
Y3NpMl9wYWRzIHsNCiANCiBzdHJ1Y3QgcmNhcl9jc2kyX2luZm8gew0KIAlpbnQgKCppbml0X3Bo
dHcpKHN0cnVjdCByY2FyX2NzaTIgKnByaXYsIHVuc2lnbmVkIGludCBtYnBzKTsNCisJaW50ICgq
Y29uZmlybV9zdGFydCkoc3RydWN0IHJjYXJfY3NpMiAqcHJpdik7DQogCWNvbnN0IHN0cnVjdCBy
Y3NpMl9tYnBzX3JlZyAqaHNmcmVxcmFuZ2U7DQogCXVuc2lnbmVkIGludCBjc2kwY2xrZnJlcXJh
bmdlOw0KIAlib29sIGNsZWFyX3VscHM7DQpAQCAtNTQ1LDYgKzU0NiwxMyBAQCBzdGF0aWMgaW50
IHJjc2kyX3N0YXJ0KHN0cnVjdCByY2FyX2NzaTIgKnByaXYpDQogCWlmIChyZXQpDQogCQlyZXR1
cm4gcmV0Ow0KIA0KKwkvKiBDb25maXJtIHN0YXJ0ICovDQorCWlmIChwcml2LT5pbmZvLT5jb25m
aXJtX3N0YXJ0KSB7DQorCQlyZXQgPSBwcml2LT5pbmZvLT5jb25maXJtX3N0YXJ0KHByaXYpOw0K
KwkJaWYgKHJldCkNCisJCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQogCS8qIENsZWFyIFVsdHJhIExv
dyBQb3dlciBpbnRlcnJ1cHQuICovDQogCWlmIChwcml2LT5pbmZvLT5jbGVhcl91bHBzKQ0KIAkJ
cmNzaTJfd3JpdGUocHJpdiwgSU5UU1RBVEVfUkVHLA0KQEAgLTg4MCw2ICs4ODgsMTEgQEAgc3Rh
dGljIGludCByY3NpMl9pbml0X3BodHdfaDNfdjNoX20zbihzdHJ1Y3QgcmNhcl9jc2kyICpwcml2
LCB1bnNpZ25lZCBpbnQgbWJwcykNCiB9DQogDQogc3RhdGljIGludCByY3NpMl9pbml0X3BodHdf
djNtX2UzKHN0cnVjdCByY2FyX2NzaTIgKnByaXYsIHVuc2lnbmVkIGludCBtYnBzKQ0KK3sNCisJ
cmV0dXJuIHJjc2kyX3BodHdfd3JpdGVfbWJwcyhwcml2LCBtYnBzLCBwaHR3X21icHNfdjNtX2Uz
LCAweDQ0KTsNCit9DQorDQorc3RhdGljIGludCByY3NpMl9jb25maXJtX3N0YXJ0X3YzbV9lMyhz
dHJ1Y3QgcmNhcl9jc2kyICpwcml2KQ0KIHsNCiAJc3RhdGljIGNvbnN0IHN0cnVjdCBwaHR3X3Zh
bHVlIHN0ZXAxW10gPSB7DQogCQl7IC5kYXRhID0gMHhlZCwgLmNvZGUgPSAweDM0IH0sDQpAQCAt
ODkwLDEyICs5MDMsNiBAQCBzdGF0aWMgaW50IHJjc2kyX2luaXRfcGh0d192M21fZTMoc3RydWN0
IHJjYXJfY3NpMiAqcHJpdiwgdW5zaWduZWQgaW50IG1icHMpDQogCQl7IC8qIHNlbnRpbmVsICov
IH0sDQogCX07DQogDQotCWludCByZXQ7DQotDQotCXJldCA9IHJjc2kyX3BodHdfd3JpdGVfbWJw
cyhwcml2LCBtYnBzLCBwaHR3X21icHNfdjNtX2UzLCAweDQ0KTsNCi0JaWYgKHJldCkNCi0JCXJl
dHVybiByZXQ7DQotDQogCXJldHVybiByY3NpMl9waHR3X3dyaXRlX2FycmF5KHByaXYsIHN0ZXAx
KTsNCiB9DQogDQpAQCAtOTQ5LDYgKzk1Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmNhcl9j
c2kyX2luZm8gcmNhcl9jc2kyX2luZm9fcjhhNzc5NjUgPSB7DQogDQogc3RhdGljIGNvbnN0IHN0
cnVjdCByY2FyX2NzaTJfaW5mbyByY2FyX2NzaTJfaW5mb19yOGE3Nzk3MCA9IHsNCiAJLmluaXRf
cGh0dyA9IHJjc2kyX2luaXRfcGh0d192M21fZTMsDQorCS5jb25maXJtX3N0YXJ0ID0gcmNzaTJf
Y29uZmlybV9zdGFydF92M21fZTMsDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCByY2FyX2NzaTJfb2ZfdGFibGVbXSA9IHsNCi0tIA0KMi4xNy4xDQo=
