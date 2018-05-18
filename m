Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4114809-1526657369-2-1788662762914653545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526657368; b=dBl9jvezCgX6Jgofdb/6I4KM7Wpy2SuxZYm4J9YVeaGHruTu26
    SX4Mz3xSJ+INLkSYmzxOiBrn1GNjXFut327Vq1SB0C+unacpmjkMwOYdW8Q3If4s
    ekTnS4cFi7+kxB8jRcIVHnbyEG/1q6sIM7T8IUBLOJnIx7Gu1P0rHlMn6WDsHKzR
    PyisqqEs2oGEnOQZuK2uP15rr/E2v9+uI5UlmEgj9NijLfO7U2xG3DKfASI57vAN
    Xx8uqZmLtwsDfOnuM0E7q5O0g2OxLkX5GMnb+hTLAaMD/0FdC0InM7yG/59A3VAd
    Hu+i7T7JvIVGlaNfQu864cXI/uGsBPTdb4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1526657368; bh=j2A58X3hd2pduSUFhtSNxZRZ+UZi7BCXwKHoP6wD5Ec=; b=
    hbT5kTqraeIGX15A/v7d6FgrJjHRDbGzOcTGBEW17mP4NbPxNfjoOdgmifKq1V3r
    5FNlG2HjRz7CrVhLesEhfa4S/UVqwI2/QfDFfsFM5nTOZA90T2oc5kJwoFYv+kBs
    Hjh8q5VMC561Cbq0LeBoKVkaV/k+mcwE72rSRQE86tcH8+XJltK5D1a/Erb6hWUd
    Lx9E4e0NLhj1TRA/VMULFW72d9N4/nA74r929ulsuJfZoQwbgH4AxzyWxYrWI7eL
    Kruj82zb6anCvdmWGf9c+2qnbhCmLPQUs1RduhFwrMLGAG5FuzFUtjOwBrxag4q9
    1O1qnCxNyO1VohAln3KcKg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=sharedspace.onmicrosoft.com
    header.i=@sharedspace.onmicrosoft.com header.b=jxUu1KG/ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=fcf7IJba x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=sharedspace.onmicrosoft.com
      header.i=@sharedspace.onmicrosoft.com header.b=jxUu1KG/ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=fcf7IJba x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGVKVLe14Wk3BLvx8O4q37wJtPQ+xEXp9kALyThNVmBITrYJuyuUTsJH6lH8e3/XVPT+qUW2Dv9M/ptQC8lcPteLcC9FQG2YmOJT+mMyxk11aEVXhM+F
    2Ujac1MpZ+PI/ShGHNF5un3MaiTUg38ahOYER5ZfLzH6CZ3itw6R+MjznUtRghafECQlOGR00HmHuNZt7xnDaHa5dNx7TYYs+KgTMUXKWkWcbIuT9M5c8QEe
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=tqvQ7scyrbkA:10 a=gQly3nRc2LQA:10
    a=wwSihFc02yEA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=X0ROFhD97x8A:10 a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=xu9sVtsIf5J5ZlZKci8A:9
    a=QEXdDO2ut3YA:10 a=ic4oXV6auKO-Q6VfiSZ6:22 a=xVlTc564ipvMDusKsbsT:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeERP3Z (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 11:29:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20446 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbeERP3X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 May 2018 11:29:23 -0400
X-IronPort-AV: E=Sophos;i="5.49,415,1520870400";
   d="scan'208";a="175142940"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bcrl@kvack.org" <bcrl@kvack.org>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rgoldwyn@suse.com" <rgoldwyn@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
Thread-Topic: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
Thread-Index: AQHT7h8HZ2EK9VUEMke9xQtgYlZJXKQ1mXyAgAAEQwA=
Date: Fri, 18 May 2018 15:29:21 +0000
Message-ID: <c2055f86-08f8-582f-7055-23f272f057c4@wdc.com>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-4-adam.manzanares@wdc.com>
 <51cbf2e9-1ff9-b9e7-fb68-055a64d54da5@kernel.dk>
In-Reply-To: <51cbf2e9-1ff9-b9e7-fb68-055a64d54da5@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0938;7:adtjJZCMnTmboh1JTusgCKWQuP+P3vsX/rg0ulm+lnSDzDgctil3QvZ3vN8GfpBbhRuAegfjR8Vgh2ujorh5+jERAlaV1x1+wKO5ZO5I/bdY3PqK0LshoQQhOzQ96kO/acFPTrHDfjMvfRgG1UNdmFkjSb/pHsYQMqYkUAIqlKjPKbZ9LsRroFy4rvhNCoXRX/l1UFVPwFpxCTNHCS9nM3UGy9kvT0+erENXSwP47/bs3QLMpM5p52Ol4TW31OyG;20:c5gCstE26XBHT08uNqOqUfWfBX2FET1umFdSby1OlKP/DVz4wPQdHjjVMRfxubsEIk4B0WBfFRZ7bkT/A4EbrTSLnpe7Mg6rR6Le6YBbZEj8DoH8MYuddhZyIUKOuj2+8HTjl7EehmxrIn2WWAt5ZrmZGYDI6y8cnkKcnkOoNbo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0938;
x-ms-traffictypediagnostic: DM5PR04MB0938:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB0938260F05E935E4D80B684CF0900@DM5PR04MB0938.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB0938;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0938;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(366004)(39860400002)(376002)(52314003)(189003)(199004)(305945005)(68736007)(229853002)(31696002)(6506007)(86362001)(6486002)(59450400001)(53546011)(105586002)(2900100001)(476003)(102836004)(2201001)(54906003)(110136005)(5660300001)(26005)(478600001)(316002)(186003)(486006)(6246003)(6512007)(76176011)(5250100002)(99286004)(2616005)(14454004)(6436002)(53936002)(7736002)(31686004)(81166006)(2501003)(81156014)(3660700001)(72206003)(8676002)(36756003)(8936002)(11346002)(97736004)(446003)(25786009)(106356001)(7416002)(3846002)(66066001)(2906002)(4326008)(6116002)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0938;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pAPCHfft1jWMDF0Hhm9FUMJSjKGWTSg9ekQxp4kQZZ4B9imofnK7pcHekTHw/5OY9I6/mmUZHS1Jfm4OIgg4+tI3G4CH7RSjmBadMhJgabbqkeyWC+jTofP+5/RuExVPFqV+RS43zNC4iqfAxnjhhdL0zxujucLkKouT0lunQHmR6apl0JbvEwo6IutFG/3q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <771CC1CDFD8CCF41B6F8F04E18BDB6A4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1dc2e6cb-c51c-461c-73ed-08d5bcd420fd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc2e6cb-c51c-461c-73ed-08d5bcd420fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 15:29:21.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0938
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvMTgvMTggODoxNCBBTSwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gNS8xNy8xOCAy
OjM4IFBNLCBhZGFtLm1hbnphbmFyZXNAd2RjLmNvbSB3cm90ZToNCj4+IEZyb206IEFkYW0gTWFu
emFuYXJlcyA8YWRhbS5tYW56YW5hcmVzQHdkYy5jb20+DQo+Pg0KPj4gVGhpcyBpcyB0aGUgcGVy
LUkvTyBlcXVpdmFsZW50IG9mIHRoZSBpb3ByaW9fc2V0IHN5c3RlbSBjYWxsLg0KPj4NCj4+IFdo
ZW4gSU9DQl9GTEFHX0lPUFJJTyBpcyBzZXQgb24gdGhlIGlvY2IgYWlvX2ZsYWdzIGZpZWxkLCB0
aGVuIHdlIHNldCB0aGUNCj4+IG5ld2x5IGFkZGVkIGtpb2NiIGtpX2lvcHJpbyBmaWVsZCB0byB0
aGUgdmFsdWUgaW4gdGhlIGlvY2IgYWlvX3JlcXByaW8gZmllbGQuDQo+Pg0KPj4gV2hlbiBhIGJp
byBpcyBjcmVhdGVkIGZvciBhbiBhaW8gcmVxdWVzdCBieSB0aGUgYmxvY2sgZGV2IHdlIHNldCB0
aGUgcHJpb3JpdHkNCj4+IHZhbHVlIG9mIHRoZSBiaW8gdG8gdGhlIHVzZXIgc3VwcGxpZWQgdmFs
dWUuDQo+Pg0KPj4gVGhpcyBwYXRjaCBkZXBlbmRzIG9uIGJsb2NrOiBhZGQgaW9wcmlvX2NoZWNr
X2NhcCBmdW5jdGlvbg0KPiANCj4gQWN0dWFsbHksIG9uZSBjb21tZW50IG9uIHRoaXMgb25lOg0K
PiANCj4+IGRpZmYgLS1naXQgYS9mcy9haW8uYyBiL2ZzL2Fpby5jDQo+PiBpbmRleCBmM2VhZTVk
NTc3MWIuLmZmMzEwN2FhODJkNSAxMDA2NDQNCj4+IC0tLSBhL2ZzL2Fpby5jDQo+PiArKysgYi9m
cy9haW8uYw0KPj4gQEAgLTE0NTEsNiArMTQ1MSwyMiBAQCBzdGF0aWMgaW50IGFpb19wcmVwX3J3
KHN0cnVjdCBraW9jYiAqcmVxLCBzdHJ1Y3QgaW9jYiAqaW9jYikNCj4+ICAgCWlmIChpb2NiLT5h
aW9fZmxhZ3MgJiBJT0NCX0ZMQUdfUkVTRkQpDQo+PiAgIAkJcmVxLT5raV9mbGFncyB8PSBJT0NC
X0VWRU5URkQ7DQo+PiAgIAlyZXEtPmtpX2hpbnQgPSBmaWxlX3dyaXRlX2hpbnQocmVxLT5raV9m
aWxwKTsNCj4+ICsJaWYgKGlvY2ItPmFpb19mbGFncyAmIElPQ0JfRkxBR19JT1BSSU8pIHsNCj4+
ICsJCS8qDQo+PiArCQkgKiBJZiB0aGUgSU9DQl9GTEFHX0lPUFJJTyBmbGFnIG9mIGFpb19mbGFn
cyBpcyBzZXQsIHRoZW4NCj4+ICsJCSAqIGFpb19yZXFwcmlvIGlzIGludGVycHJldGVkIGFzIGFu
IEkvTyBzY2hlZHVsaW5nDQo+PiArCQkgKiBjbGFzcyBhbmQgcHJpb3JpdHkuDQo+PiArCQkgKi8N
Cj4+ICsJCXJldCA9IGlvcHJpb19jaGVja19jYXAoaW9jYi0+YWlvX3JlcXByaW8pOw0KPj4gKwkJ
aWYgKHJldCkgew0KPj4gKwkJCXByX2RlYnVnKCJhaW8gaW9wcmlvIGNoZWNrIGNhcCBlcnJvclxu
Iik7DQo+PiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+PiArCQl9DQo+PiArDQo+PiArCQlyZXEtPmtp
X2lvcHJpbyA9IGlvY2ItPmFpb19yZXFwcmlvOw0KPj4gKwkJcmVxLT5raV9mbGFncyB8PSBJT0NC
X0lPUFJJTzsNCj4+ICsJfQ0KPiANCj4gRG8gd2UgcmVhbGx5IG5lZWQgSU9DQl9JT1BSSU8/IEFs
bCB6ZXJvZXMgaXMgbm8gcHJpb3JpdHkgc2V0IGFueXdheSwNCj4gc28gd2Ugc2hvdWxkIGJlIGFi
bGUgdG8gZ2V0IGJ5IHdpdGgganVzdCBzZXR0aW5nIC0+a2lfaW9wcmlvIHRvIGVpdGhlcg0KPiB0
aGUgcHJpb3JpdHksIG9yIDAuDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL2Jsb2NrX2Rldi5jIGIv
ZnMvYmxvY2tfZGV2LmMNCj4+IGluZGV4IDdlYzkyMGUyNzA2NS4uOTcwYmVmNzljYWE2IDEwMDY0
NA0KPj4gLS0tIGEvZnMvYmxvY2tfZGV2LmMNCj4+ICsrKyBiL2ZzL2Jsb2NrX2Rldi5jDQo+PiBA
QCAtMzU1LDYgKzM1NSw4IEBAIF9fYmxrZGV2X2RpcmVjdF9JTyhzdHJ1Y3Qga2lvY2IgKmlvY2Is
IHN0cnVjdCBpb3ZfaXRlciAqaXRlciwgaW50IG5yX3BhZ2VzKQ0KPj4gICAJCWJpby0+Ymlfd3Jp
dGVfaGludCA9IGlvY2ItPmtpX2hpbnQ7DQo+PiAgIAkJYmlvLT5iaV9wcml2YXRlID0gZGlvOw0K
Pj4gICAJCWJpby0+YmlfZW5kX2lvID0gYmxrZGV2X2Jpb19lbmRfaW87DQo+PiArCQlpZiAoaW9j
Yi0+a2lfZmxhZ3MgJiBJT0NCX0lPUFJJTykNCj4+ICsJCQliaW8tPmJpX2lvcHJpbyA9IGlvY2It
PmtpX2lvcHJpbzsNCj4gDQo+IEFuZCB0aGVuIHRoaXMgYXNzaWdubWVudCBjYW4ganVzdCBoYXBw
ZW4gdW5jb25kaXRpb25hbGx5Lg0KDQpUaGF0IGlzIGEgY2xlYW5lciB3YXkgb2YgZ3VhcmFudGVl
aW5nIHRoZSBpb3ByaW8gc2V0IG9uIHRoZSBraW9jYiBpcyANCm9ubHkgc2V0IHdoZW4gdGhlIHVz
ZXIgaW50ZW5kcyB0byB1c2UgdGhlIGlvcHJpbyBmcm9tIHRoZSBpb2NiLg0KDQpJJ2xsIHJlc2Vu
ZCB0aGUgc2VyaWVzLg0KDQoNCj4g
