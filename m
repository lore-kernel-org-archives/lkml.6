Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14C6C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8177F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a4P7ivAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8177F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeIGFQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:26 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:26290
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729757AbeIGFQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vge4aNCM0no2JUe1nfDuXK3DKZZ6iNY8zErus3b4Ino=;
 b=a4P7ivAMmccwBOYMBn5YNxdMv4HSZ5+jhLKveSz53Y9SdN5R3QstQhsHqol9E1trvaVV+a/K+3nPrqtMFn1qikPwpCBCCiUHZjpPay3pU8gbAcbsbH//GuK07EWLQ9vtz/SGCJdfcqKPJqEmxaQWZ9wRRcdOEcPdJ1aUniVE5cc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 15/67] kbuild: add .DELETE_ON_ERROR special
 target
Thread-Topic: [PATCH AUTOSEL 4.14 15/67] kbuild: add .DELETE_ON_ERROR special
 target
Thread-Index: AQHURkL1yBMmIR6aU0aijc+iggujkA==
Date:   Fri, 7 Sep 2018 00:37:30 +0000
Message-ID: <20180907003716.57737-15-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:SreIZdmGViEO64kJiXNnGxBda88Z+bwhAw4tNT4ufltGEE07c6i2Gza/2EfmUVrhmX0SSvnbOYqH7mNwsdgw6UrYYe5vXPZxbxZG7d8HNsBRt0dT5wcAGIUVzDa4e3KvfLrflPIYMTfWb+2qze9zb9GCIJSAoGQ0XkepSgvMtDgBhPPKtywGVWzIA8f87NZ4YGAOzj5BpEFn8o/mWci8oBag0Q/HS5zlEGovwykREQ52Hw9au/Ai3oM2WGsBbr03lH+pde0RalPkgjKIp+CsX3zFUFlegUT15MwMyAkMqoRE6qldJj0xWDsXCQKY6/CyLj2tu6NK8O24Nb90cQSfEMwv5wohklxjEsevbz/pNGOfjSlpBlE9IHYgKnlpHtbRvxZt/FiOikhA30yYlMbgQmrrtU0t3o8of1WvjVrz1xi5or1VMFBNDT/t3MpyLZJaiUmo8kiHP/JMWldVixclgw==;5:OfndktiK9+IyNiDCsltACMPVxHbTInuL1GIX1uyjGn1Nc0F8u1vUK+dufS9PSHVyxEBSxB/piz+9frrP9ORZPHxBlHs5LHTd+fkGwoSwPBOGqwXubcKM65wBTC/05XwZ7LR+Eg1k6FIDI184GU09tJ2iSdPyR6TOPOtrMWjMILY=;7:4sWmcfRmk13vb+1raVwI24xrZKWg0Sv+WeyCgWCij9U6QN0rAkRyn9ibJF/0aLuv42AW5m1HezF7/QAJf7gjbumrebLUmd4QlP6+qlvbO6uJSfHAt90KE7JEiutd8O7HEw9gYW2wGLRIDaNTBxZO+ew8U5AqpLUOfHxCaKLSmBuayD0jK6pftpW8qnAjSZdHkliE5nlG/FN/3CpAr0pi8zaZmcuJr52MtACqQt4h6SU1Q7mR3j0DvoZhzQd9JYdX
x-ms-office365-filtering-correlation-id: fb354d66-7d5b-438a-426d-08d6145a3462
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075763849EBBBBD92CC4482EFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: inb31+1gCr6T0/yfSnj9j99YFD9Kc4J7zsewMjvNd21zcxjIPONyIAZVSCepugPc+Lm0SzVeYwZgFQWLAXBSK9rmF7jiCKAFKXkc/3ZqRJb+d/+wSbCn26kKw+v+TSW7FRLNJQWc2JknZIXZ/7f2F3gnOW28Yb1Z2WcG1uCkC0KiZO0IdXkNlszWFtURvDfvTMuSVegEUbboHDUlrvtJCZdGZlCaP1h7mKqOT7J1vgxFm+K090EBZz95YM4mSJyMfvaqXFWDlWJGfbV1eHJzfLusFJxpkpFtxwr9SSDGgJI8s6y66VVTUJYvbABJh4A5+yoGfluQqu6vELTRbcg2kKlx+C7wGPa2scF4RZn0g/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <87A3D0C830FDBC4AA97A90851D89C8EF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb354d66-7d5b-438a-426d-08d6145a3462
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:30.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
ZC5pbmNsdWRlDQppbmRleCBmY2JiZWNmOTIzOTUuLmEwYWQ4N2U4NjlmOSAxMDA2NDQNCi0tLSBh
L3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUNCisrKyBiL3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUNCkBA
IC00MDMsMyArNDAzLDYgQEAgZW5kaWYNCiBlbmRlZg0KICMNCiAjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjDQorDQorIyBkZWxldGUgcGFydGlhbGx5IHVwZGF0ZWQgKGkuZS4gY29ycnVwdGVkKSBmaWxl
cyBvbiBlcnJvcg0KKy5ERUxFVEVfT05fRVJST1I6DQotLSANCjIuMTcuMQ0K
