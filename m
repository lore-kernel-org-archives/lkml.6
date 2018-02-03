Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681337-2-16799968449577084826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681336; b=QmR5FpycMfya5ZZZtc8tpcDT8fAJEu5fG5jasT5vBbM7Cvo
    R+zE629ujaRWZLQPovPeG1el37l8Rmf2rW/z6lzcOQJHlzJhTgTu+CXqkQxIYxgl
    qssyalAe7/5QoXpiE7wCnZqtD61Pji0Yo/XY4JHfknOCs/Skyl+mIWBsRTFDj3rb
    mEoBY0SgNmXinFbeyPPLChGzjvnOQq/kgyldCp+jiy5zB0eV/A9hoCDIBvfmldtA
    TG5g4f6biYq/0azp6+WrydJgKSPwlnsBvy325NXs8w89WUKMn+uLwwtsTe2j3pt6
    5N/cvirNALjr709SbplEXqGIS7KR4AhneBHFQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517681336; bh=0X9s4HWjkKT08qK6PlLIVKkFUu/3wEpkuDaSiU
    8Ixvs=; b=p/mHvWV/T/36jEUn18wdP3gUdC/fkeP4YT179eSVFqRej/4T9XbcM9
    yUm7udPVCA0ZrAftJ8VsXDDnaOMC2WBx6AKVjU8yXbgI8q3r7MixxkiAFFn08pCc
    LmOiGSAcrMR6vnqya2c1RB5azY0HxxlNae2uBmewwaXaPL1ySpuwZSVPo/wrv1IN
    yPAfx+RSh7pyBeMeuX4cJfx1gPq5utCZR78FOEJQIpWvK/PTfxn5N78ViR9fyomn
    r9cxJM+aVSI9qzbI9Y3Nu4K2Mb0HwlYnan92MDs2dzj2XdJDkWoDa0PtTwLMeWdF
    K5+dTFQ9qhoF/jNYwnHEhCqUHnd29NGQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cPXfcp8T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cPXfcp8T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeBCSIu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:50 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753585AbeBCSHa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 17/24] loop: fix concurrent
 lo_open/lo_release
Thread-Topic: [PATCH AUTOSEL for 3.18 17/24] loop: fix concurrent
 lo_open/lo_release
Thread-Index: AQHTnRmGtrmZ787RnkaDIGkslV/HhA==
Date: Sat, 3 Feb 2018 18:05:07 +0000
Message-ID: <20180203180444.10801-17-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:I+JAhXWNIgJ1lP4X+ModIHlMTHYiDVFllvrvot7QV9V5Vzq4Yr3BskSRkWsUf8mgXOCZzoxYRnO+fKNclH5BmcLwkXZO9tOEoQ9Oq9xdAr9byjWhxwpUrr8b9S6z+xpPQGVZUeejcOjVgiFWEYOh8F/hv3uU9WaDdUNwBTQntgETMXubrY/Qb+ufM76brwgb25mRKxmlH/hfIzdsYtXcsfRbXXaGNbRQIW6JifKBql9bPObItetd0m187MWlvPJ2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c249abee-a0cf-4a46-d0ea-08d56b30e21c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB09936493487AB8839EAE8113FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(110027731352094)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(55674003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: P6NTMC1+1NPfDFPrWbwXjmKcU201kNwQkxIKDBhrjRKUpjzDkrYtGiAqJxv7K/WoM4KY/2gPm4p35v4RIY9vkg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <260CB4F69B225A45A14DF3E00D623B89@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c249abee-a0cf-4a46-d0ea-08d56b30e21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:07.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KDQpb
IFVwc3RyZWFtIGNvbW1pdCBhZTY2NTAxNjNjNjZhN2VmZjFhY2Q2ZWI4YjBmNzUyZGNmYThlYmE1
IF0NCg0K6IyD6b6Z6aOeIHJlcG9ydHMgdGhhdCBLQVNBTiBjYW4gcmVwb3J0IGEgdXNlLWFmdGVy
LWZyZWUgaW4gX19sb2NrX2FjcXVpcmUuDQpUaGUgcmVhc29uIGlzIGR1ZSB0byBpbnN1ZmZpY2ll
bnQgc2VyaWFsaXphdGlvbiBpbiBsb19yZWxlYXNlKCksIHdoaWNoDQp3aWxsIGNvbnRpbnVlIHRv
IHVzZSB0aGUgbG9vcCBkZXZpY2UgZXZlbiBhZnRlciBpdCBoYXMgZGVjcmVtZW50ZWQgdGhlDQps
b19yZWZjbnQgdG8gemVyby4NCg0KSW4gdGhlIG1lYW50aW1lLCBhbm90aGVyIHByb2Nlc3MgY2Fu
IGNvbWUgaW4sIG9wZW4gdGhlIGxvb3AgZGV2aWNlDQphZ2FpbiBhcyBpdCBpcyBiZWluZyBzaHV0
IGRvd24uIENvbmZ1c2lvbiBlbnN1ZXMuDQoNClJlcG9ydGVkLWJ5OiDojIPpvpnpo54gPGxvbmc3
NTczQDEyNi5jb20+DQpTaWduZWQtb2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGlu
dXgtZm91bmRhdGlvbi5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJu
ZWwuZGs+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jv
c29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2Jsb2NrL2xvb3AuYyB8IDEwICsrKysrKysrLS0NCiAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ibG9jay9sb29wLmMgYi9kcml2ZXJzL2Jsb2NrL2xvb3AuYw0KaW5kZXgg
NmNiMWJlYjQ3YzI1Li45NDM4NWI5NjlmNjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Jsb2NrL2xv
b3AuYw0KKysrIGIvZHJpdmVycy9ibG9jay9sb29wLmMNCkBAIC0xNTEyLDkgKzE1MTIsOCBAQCBv
dXQ6DQogCXJldHVybiBlcnI7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIGxvX3JlbGVhc2Uoc3RydWN0
IGdlbmRpc2sgKmRpc2ssIGZtb2RlX3QgbW9kZSkNCitzdGF0aWMgdm9pZCBfX2xvX3JlbGVhc2Uo
c3RydWN0IGxvb3BfZGV2aWNlICpsbykNCiB7DQotCXN0cnVjdCBsb29wX2RldmljZSAqbG8gPSBk
aXNrLT5wcml2YXRlX2RhdGE7DQogCWludCBlcnI7DQogDQogCW11dGV4X2xvY2soJmxvLT5sb19j
dGxfbXV0ZXgpOw0KQEAgLTE1NDIsNiArMTU0MSwxMyBAQCBvdXQ6DQogCW11dGV4X3VubG9jaygm
bG8tPmxvX2N0bF9tdXRleCk7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIGxvX3JlbGVhc2Uoc3RydWN0
IGdlbmRpc2sgKmRpc2ssIGZtb2RlX3QgbW9kZSkNCit7DQorCW11dGV4X2xvY2soJmxvb3BfaW5k
ZXhfbXV0ZXgpOw0KKwlfX2xvX3JlbGVhc2UoZGlzay0+cHJpdmF0ZV9kYXRhKTsNCisJbXV0ZXhf
dW5sb2NrKCZsb29wX2luZGV4X211dGV4KTsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBi
bG9ja19kZXZpY2Vfb3BlcmF0aW9ucyBsb19mb3BzID0gew0KIAkub3duZXIgPQlUSElTX01PRFVM
RSwNCiAJLm9wZW4gPQkJbG9fb3BlbiwNCi0tIA0KMi4xMS4wDQo=
