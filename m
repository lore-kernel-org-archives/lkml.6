Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124504-2-17285464188523724533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124504; b=l5vIpdjqH96zO8D7V4EiKL2Cixb+IZMNYaewk9ykSCEe5r1
    VrNysC7qr4vjTZwl2g3qfPLRNweHF/IOuCooLehbehPM/p/xBgmuS7v2YQbiJInd
    u795bppA3crmrt22+3LtwSo5a23UUKZgsAtuuQ/zeE8c23jQL1H89PvYiBqEQbhK
    32guMd9ScHu5khB/oiPTh22l/lphlkQEwRLnIe2m1xxBk/EWLhYLUTCDB+R/wJGH
    DFKT2Wbk+IuU2Ktk+2mQf8Nsot61TPNdTdqunVUG33rCVtOBC1HUbrn8603UA1y+
    oCEuqL0uml2epKrlywe7J3TvLvxdtynoW3u5ivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520124504; bh=DhvhKzV9yN0i5QmZjVVS1edyPjE3V1EIhwxwEg
    uwngI=; b=TjRbzdmjODQXXBafdll/FAuvEMaDLEjTaobGequDQ+7Rd6s4WOvT/s
    iK8TIE7cPevmzXV3/Exj3ShYoElyLxtg+g1UJyo2LOqoSTXh9LysVqnKDY4lpsMn
    90uWJKf/jSfiF3kSsx7ckmdgdlGbVEf64uQlUg7qy+QddSyfvBwK0Dkr4XqqT+dN
    YzZmTYMXm9wgfYpGE4VTRxJC3os+FhAeMGjnD4vJkzKK/4ClPlxHpq+EIzbQxX6d
    4HRMFMI9eK80lVr19/tYx+G5OoVNhUyJQVnmhI/e5wzKN1QfVKGak3SNdmp0B5Mw
    XbdbPznZz7YETKn2lFs/TCW7UNhJyumw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eiCMJrP1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eiCMJrP1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeCDArT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:47:19 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:48208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932334AbeCCWYt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 023/102] crypto: keywrap - Add missing ULL
 suffixes for 64-bit constants
Thread-Topic: [PATCH AUTOSEL for 4.15 023/102] crypto: keywrap - Add missing
 ULL suffixes for 64-bit constants
Thread-Index: AQHTsz5hD3E3OiYDikC6dsnChhZAxw==
Date: Sat, 3 Mar 2018 22:24:22 +0000
Message-ID: <20180303222318.26006-23-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:PKh4wDDG3Qo7Z2pPaHiRt2/WtoAnhmL9YYxgC1ffSaEqstmXFNKPZu8vo+4kqKb59RMrkcfXwHgQKPI0EkT0R6oMFieWmLbWoBlX5xadA2JeppOdGMmc9IQcM5pyiuUhhRnysCz64mP2HkjCCgsaH9jIG4FBtCNKnRCIyr1huQG9tpUEqn8sT1yBoWwRGh46gmSzGwvuQhJ218BqCFw/MaXvgJm2gSFd/e6MwzMVKSQ0niWl4hJ9tCldxNsdV6jj
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be9c8a52-e306-4f03-3f5a-08d581559258
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970914033DA5522242FEEB3FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uP/nmXPVj7+D/m/PyVSBQq28LT823To5vauKN1OLDkHA4LyO3TcZ/f6/hVKn+dB30+8tCjh44N6aojtH++xBrGJof9ZNf/tfrPWaDqfGPCbD1B1fPMA3/SQrKbJBKQK/Puvvc/tvpI6gJKcAiScmWn1PXwC4eG5WKJrblapZJkk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8036B346682A354FBA650EE5F093A8CE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9c8a52-e306-4f03-3f5a-08d581559258
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:22.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KWyBVcHN0
cmVhbSBjb21taXQgYzk2ODMyNzZkZDg5OTA2Y2E5YjY1Njk2ZDA5MTA0ZDU0MjE3MTQyMSBdDQoN
Ck9uIDMyLWJpdCAoZS5nLiB3aXRoIG02OGstbGludXgtZ251LWdjYy00LjEpOg0KDQogICAgY3J5
cHRvL2tleXdyYXAuYzogSW4gZnVuY3Rpb24g4oCYY3J5cHRvX2t3X2RlY3J5cHTigJk6DQogICAg
Y3J5cHRvL2tleXdyYXAuYzoxOTE6IHdhcm5pbmc6IGludGVnZXIgY29uc3RhbnQgaXMgdG9vIGxh
cmdlIGZvciDigJhsb25n4oCZIHR5cGUNCiAgICBjcnlwdG8va2V5d3JhcC5jOiBJbiBmdW5jdGlv
biDigJhjcnlwdG9fa3dfZW5jcnlwdOKAmToNCiAgICBjcnlwdG8va2V5d3JhcC5jOjIyNDogd2Fy
bmluZzogaW50ZWdlciBjb25zdGFudCBpcyB0b28gbGFyZ2UgZm9yIOKAmGxvbmfigJkgdHlwZQ0K
DQpGaXhlczogOWU0OTQ1MWQ3YTE1MzY1ZCAoImNyeXB0bzoga2V5d3JhcCAtIHNpbXBsaWZ5IGNv
ZGUiKQ0KU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NClJldmlld2VkLWJ5OiBTdGVwaGFuIE11ZWxsZXIgPHNtdWVsbGVyQGNocm9ub3guZGU+
DQpTaWduZWQtb2ZmLWJ5OiBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+
DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5j
b20+DQotLS0NCiBjcnlwdG8va2V5d3JhcC5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2NyeXB0by9rZXl3
cmFwLmMgYi9jcnlwdG8va2V5d3JhcC5jDQppbmRleCA3NDRlMzUxMzRjNDUuLmVjNWM2YTA4N2M5
MCAxMDA2NDQNCi0tLSBhL2NyeXB0by9rZXl3cmFwLmMNCisrKyBiL2NyeXB0by9rZXl3cmFwLmMN
CkBAIC0xODgsNyArMTg4LDcgQEAgc3RhdGljIGludCBjcnlwdG9fa3dfZGVjcnlwdChzdHJ1Y3Qg
YmxrY2lwaGVyX2Rlc2MgKmRlc2MsDQogCX0NCiANCiAJLyogUGVyZm9ybSBhdXRoZW50aWNhdGlv
biBjaGVjayAqLw0KLQlpZiAoYmxvY2suQSAhPSBjcHVfdG9fYmU2NCgweGE2YTZhNmE2YTZhNmE2
YTYpKQ0KKwlpZiAoYmxvY2suQSAhPSBjcHVfdG9fYmU2NCgweGE2YTZhNmE2YTZhNmE2YTZVTEwp
KQ0KIAkJcmV0ID0gLUVCQURNU0c7DQogDQogCW1lbXplcm9fZXhwbGljaXQoJmJsb2NrLCBzaXpl
b2Yoc3RydWN0IGNyeXB0b19rd19ibG9jaykpOw0KQEAgLTIyMSw3ICsyMjEsNyBAQCBzdGF0aWMg
aW50IGNyeXB0b19rd19lbmNyeXB0KHN0cnVjdCBibGtjaXBoZXJfZGVzYyAqZGVzYywNCiAJICog
UGxhY2UgdGhlIHByZWRlZmluZWQgSVYgaW50byBibG9jayBBIC0tIGZvciBlbmNyeXB0LCB0aGUg
Y2FsbGVyDQogCSAqIGRvZXMgbm90IG5lZWQgdG8gcHJvdmlkZSBhbiBJViwgYnV0IGhlIG5lZWRz
IHRvIGZldGNoIHRoZSBmaW5hbCBJVi4NCiAJICovDQotCWJsb2NrLkEgPSBjcHVfdG9fYmU2NCgw
eGE2YTZhNmE2YTZhNmE2YTYpOw0KKwlibG9jay5BID0gY3B1X3RvX2JlNjQoMHhhNmE2YTZhNmE2
YTZhNmE2VUxMKTsNCiANCiAJLyoNCiAJICogc3JjIHNjYXR0ZXJsaXN0IGlzIHJlYWQtb25seS4g
ZHN0IHNjYXR0ZXJsaXN0IGlzIHIvdy4gRHVyaW5nIHRoZQ0KLS0gDQoyLjE0LjENCg==
