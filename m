Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3C12083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="d3uAjRCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3C12083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeIGF2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:28:13 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbeIGFSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbNSoKidFIHCUHMnDGke3lolfFYikLnVW/3KcFpATaw=;
 b=d3uAjRCRXnwBHnzGwJQUknMtd/PukAa1XQU31hF/Sbb7E8PBFpq3aj4qeQ/dO9KucJbUWCXP2mFTsELK6UzGyT8ynU1S5HLt82uBECjDTT18CXcT5D76GsdGkBWpixWU5VD4PhwemLCFAMx9NIrOakgbZaDPBR9om8IC9O3EdVQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 09/43] kbuild: add .DELETE_ON_ERROR special target
Thread-Topic: [PATCH AUTOSEL 4.9 09/43] kbuild: add .DELETE_ON_ERROR special
 target
Thread-Index: AQHURkMWAkSSYRDh1k2WMn7gKdVKRA==
Date:   Fri, 7 Sep 2018 00:38:24 +0000
Message-ID: <20180907003816.57852-9-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:cDWnEN/YyJ4CvXqZGfzXp2PzsUIy4S30fbsCA0QvtpqdKs+jO2MdL50Dgiox7tBM6+maody9EomblOE9PODEkLw8I4gNJbUlDw+2t6RNWwRaFdKRqemNDkEucu6M4bTm/uGmiVlVHKSibpg7qN68Y0nZ3Sjas5SGiBcUNKWFpHf3hFEXY3CH0eh8AiCpdgMT+K4mrv0EKs/JGehFmfOudeeu764TRFd985rMw6VCA+JLVskgE0C3TNBNiUgKoEYFbNQb9ED9pm+wzZWrZXOessO0kukXrADb4YtT8Zo1XHFrdWARmoqGJn/dqRPJV61ZKbP/owdf1/5cR5T5iY9xeLC6rain71pHhhIChdx2jfHs6Hx1rDnGmp34T37hYxnkvi6HL2jgC/Yu4VrhX372w9NPhcmB08331GQPJ/GI/8DxKbS3TVm+qzvrLCFosWiQH7M7etRZWBj1haQDAEkXtw==;5:i+CbIru4OPhrD2BV4pPycSOCAVzXa73/HKu7xH14YmGZKGth/evvY/3XSaLqDk0W1DcYgsCb5Bxh6dG6fsNdregcO7U4ADy7hkFLj8Hi3nOxI5aiBtCiXzqJGOlRhhgyORNiLZWuMiAlUVJ5R6Yt0On1N9/szLFwvJdWUrlf2dw=;7:sX0Ce2MMF7vUgBuFNCYkNRYk+Qp/mA9EV936MJPo4YyPU9OkJqykKOWYX2y8djHxO4rJis9/+FlMSFS2ihWIYpy+9Ey7pqAiCxZV98EjYcdCjxL9u3kT0hG43gUXlfqeq7LGE2p1hL2E8PrZyRD6cmMiMrEInALfNqIAIHAanu8corPafxFiN5ufNbJD0zQWJcelNlyUq2k1UxoJJXFCB59lC+P6zPXCiwPKC+xI620u8t7TRzuB9N7b+6+ZHUGT
x-ms-office365-filtering-correlation-id: 8c8bd02c-cfb4-4b0c-f70e-08d6145a8933
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB0149CE6A92FF16A4FE0FB985FB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5eaHBr3VUrC0rxqfxU5ZW98W/2SYMesH9s2Q3nlPTn9VVAR0jKtoetavtum44KDK1YJh3onERcoWXi4Dq5WsbhIxi9vsB0uAM01oQDN9Sl7PE4ql47YWlIfvWsPrVGIHy79y34McL3zpLCvgT2wCjLObkV47E+2my188BB5of6uuUmpRPUI0VsQOcn3a1dOK6I2BtNjOkG/6pTpKeQpeN5kMidxHK4e4tlu06iMJLOPSEUZS3O/USUi2gBPzz7HRy6rSWKsLrvKtuwtr7fSZD8APthjBVKNROLbVnAAjLgNQMSKPS0af9cn0WIqVRitxX7zjrWHthoZG4Pxr+sMsZ0B4/1NZoGFpqbcmJ/UU3p4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <609ED9A4CC1A1B4C8A78CA261EDA279F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8bd02c-cfb4-4b0c-f70e-08d6145a8933
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:24.9716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
ZC5pbmNsdWRlDQppbmRleCA2Mzc3NDMwN2E3NTEuLjhmODk2NTYwOGVlMyAxMDA2NDQNCi0tLSBh
L3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUNCisrKyBiL3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUNCkBA
IC0zOTQsMyArMzk0LDYgQEAgZW5kaWYNCiBlbmRlZg0KICMNCiAjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjDQorDQorIyBkZWxldGUgcGFydGlhbGx5IHVwZGF0ZWQgKGkuZS4gY29ycnVwdGVkKSBmaWxl
cyBvbiBlcnJvcg0KKy5ERUxFVEVfT05fRVJST1I6DQotLSANCjIuMTcuMQ0K
