Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517680906-2-9368852314847202347
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680905; b=R2rdaZzRHja7rWYcWbYDdz4Oq3VbyyD8YnUOfjiHirAXQAh
    xggwl1yfWisy7dTncW6V5BfANHg4+kq2vUq1D0LbDEHliRD33Cv/FJJf7B7XjaOR
    i7GU5aDDzurT52rICDcpu3ZDWYFIns1aHK/qhHDxBkJvuiWSmS56z7LQFcULLRjW
    e92qshsB3Gw1RK4NHUOGrV51S4S33uWN9uw7HLvwPw2FQlZvzwSAEWzAxSlWpBjn
    5Z6IsKqJkFwtojEFy9DZR5wAiwtT9fZqYFO+IK7oAqs4PXU1x/t7WPLLQFjdH6sb
    8XNuQKUNc8kqzbKGTMSiw3cjo/aWU0UQDf5FLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517680905; bh=9WWf/3easkQGQJAHMgse4cO/WB5cU7QuC1NbjS
    IBZWE=; b=kv2clf8DYJfWPWHv/wH3hXDuTvr1v8Fwzmt1FqSKAxCfg0gtjZWDwg
    sbTJ6tWOUAUeRDKE2qnzHmO71wPBRBTh9wmXGfJoU6DTx+5mXTRP6xTm5stLKfpN
    NFCdSdKojGNnI253ZTAWlodo06ZmWM5NpSw8wrnSqlov8I5rQo5wvgWQYlgBX93w
    qoOUoy6vsCI26fYKJUb1N3gppj/zFoW2d3uwMMCFHHth7erHiXrWjhnCvk3y5JUn
    GIElI1hQ3uHPKudVPMCL5KxIaQQDI8QKkVRWXpPMtdvn9wC5iQIB8WNi8jrs6PDX
    SDIlq2Re+SkC6U4treu2IwxdzsQGwAZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=au8wob1U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=au8wob1U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeBCSBi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:38 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752780AbeBCSAs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lan Tianyu <tianyu.lan@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jim Mattson <jmattson@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 006/110] KVM/x86: Check input paging mode
 when cs.l is set
Thread-Topic: [PATCH AUTOSEL for 4.14 006/110] KVM/x86: Check input paging
 mode when cs.l is set
Thread-Index: AQHTnRjgClsyeRQkJEGKx4/m279SwQ==
Date: Sat, 3 Feb 2018 18:00:29 +0000
Message-ID: <20180203180015.29073-6-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;6:nD92Ww7+B43kfupWLS1jN6vejImTPA2S1w8BjTBBk75bzGD0yW/POMH76L9KX0Qzs+tnOsBAK2SkHKTLBddd3L7IppMUuab46PwdAEHUlAAnlCUKNBfVpLlhTIXcBvOoDV9hnHmnhbVxrQcLBgX5miAQTyabQG0qZNIy7NoXH7356XzJTQZZNIddIA6E3wMb0AKTbfiLR0vNO4PTU7hE6wTmBXV7/6fZ98QG7Qmhlp3Jcf9E67hhNgSfJqAfiChF0tnk/OOH6lBn4ZIRXuzNqoa1rA5YlaTEMYPYs/htAngSkSlSmt2s75Hidisdq01chhsUoxY7A6I3TgCUAP9Anp9CdiCaNWMsAGZGYpLNPugECqeF7as7TMBb0jtlH+48;5:ULmcd3qUMROBrfckcpj9YXmLf4SDR9F1WJ7ywcFv5DLw0X4gtvNpVtFhf+Y7zQ94nbglYKW84OFkpOxjDFikr0o5L3cPdEMEN8D7ZCKCi2oE+7hR3OtG1YXkJxEd8DwNYjhEP/qGj3RIHW4hE5MWq5P8D50mz7xQWF6w996dGDM=;24:08Zffo57lX8tZkO1I7rXcWheyCj1xoaJsws2olYD/QjZBhh9mbH9TxiXiyxAWKAZtfEO5opb1O3WGedhBSrrUNYANB1qxsr0sw5U4XRpZ6Y=;7:MXQw9FQ0OyiWno6SmzjIJUvCrBDdIsB8e6tHbeL1aq6u+EcOqeEPqdjWoe7Tl/zryA095CChUqTyZ44IfkNtM9aIcgB+2ppwb4x/P6PqtnrOtQtKUfMaxMUDqS7vgWt6uS2QGsNW2ZVD6b8bjeiDja2v/RxBQ7vzeHoqHiqOxSHKK8qe7pOCfgac0o1NKQ7DXsxjYg5Ygl0EQpAWWnrdhv+BpArATIMOTTe/kbtmzGNb/2hMrMyJi1cZlM/2KkrV
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd4a8126-217b-4268-009b-08d56b3003cc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043B9120F618AF10ECDDC9AFBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 2do4r17OTLPMXqX+ziX9u3mQUuYC4H1uc7Bl+qgjojIQRuUO6+dFPbGhlxdGKLPu4228AmTeABkuHXbGcZO86Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <57E4A1367092B943B9EDCFEA7702B084@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4a8126-217b-4268-009b-08d56b3003cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:29.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTGFuIFRpYW55dSA8dGlhbnl1LmxhbkBpbnRlbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IGYyOTgxMDMzNTk2NWFjMWY3YmNiNTAxZWUyYWY1ZjAzOWY3OTI0MTYgXQ0KDQpSZXBvcnRl
ZCBieSBzeXprYWxsZXI6DQogICAgV0FSTklORzogQ1BVOiAwIFBJRDogMjc5NjIgYXQgYXJjaC94
ODYva3ZtL2VtdWxhdGUuYzo1NjMxIHg4Nl9lbXVsYXRlX2luc24rMHg1NTcvMHgxNWYwIFtrdm1d
DQogICAgTW9kdWxlcyBsaW5rZWQgaW46IGt2bV9pbnRlbCBrdm0gW2xhc3QgdW5sb2FkZWQ6IGt2
bV0NCiAgICBDUFU6IDAgUElEOiAyNzk2MiBDb21tOiBzeXotZXhlY3V0b3IgVGFpbnRlZDogRyAg
ICBCICAgVyAgICAgICAgNC4xNS4wLXJjMi1uZXh0LTIwMTcxMjA4KyAjMzINCiAgICBIYXJkd2Fy
ZSBuYW1lOiBJbnRlbCBDb3Jwb3JhdGlvbiBTMTIwMFNQL1MxMjAwU1AsIEJJT1MgUzEyMDBTUC44
NkIuMDEuMDMuMDAwNi4wNDA3MjAxNjEyNTMgMDQvMDcvMjAxNg0KICAgIFJJUDogMDAxMDp4ODZf
ZW11bGF0ZV9pbnNuKzB4NTU3LzB4MTVmMCBba3ZtXQ0KICAgIFJTUDogMDAxODpmZmZmODgwNzIz
NDQ3NmQwIEVGTEFHUzogMDAwMTAyODINCiAgICBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBm
ZmZmODgwNzJkMDIzN2EwIFJDWDogZmZmZmZmZmZhMDA2NWM0ZA0KICAgIFJEWDogMWZmZmYxMDBl
NWEwNDZmOSBSU0k6IDAwMDAwMDAwMDAwMDAwMDMgUkRJOiBmZmZmODgwNzJkMDIzN2M4DQogICAg
UkJQOiBmZmZmODgwNzIzNDQ3NzI4IFIwODogZmZmZjg4MDcyZDAyMDAwMCBSMDk6IGZmZmZmZmZm
YTAwOGQyNDANCiAgICBSMTA6IDAwMDAwMDAwMDAwMDAwMDIgUjExOiBmZmZmZWQwMGU3ZDg3ZGIz
IFIxMjogZmZmZjg4MDcyZDAyMzdjOA0KICAgIFIxMzogZmZmZjg4MDcyZDAyMzg3MCBSMTQ6IGZm
ZmY4ODA3MmQwMjM4YzIgUjE1OiBmZmZmZmZmZmEwMDhkMDgwDQogICAgRlM6ICAwMDAwN2Y4YTY4
NjY2NzAwKDAwMDApIEdTOmZmZmY4ODA4MDIyMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAw
MDAwMA0KICAgIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAw
MzMNCiAgICBDUjI6IDAwMDAwMDAwMjAwOTUwNmMgQ1IzOiAwMDAwMDAwNzFmZWM0MDA1IENSNDog
MDAwMDAwMDAwMDM2MjZmMA0KICAgIENhbGwgVHJhY2U6DQogICAgIHg4Nl9lbXVsYXRlX2luc3Ry
dWN0aW9uKzB4M2JjLzB4YjcwIFtrdm1dDQogICAgID8gcmVleGVjdXRlX2luc3RydWN0aW9uLnBh
cnQuMTYyKzB4MTMwLzB4MTMwIFtrdm1dDQogICAgIHZteF9oYW5kbGVfZXhpdCsweDQ2ZC8weDE0
ZjAgW2t2bV9pbnRlbF0NCiAgICAgPyB0cmFjZV9ldmVudF9yYXdfZXZlbnRfa3ZtX2VudHJ5KzB4
ZTcvMHgxNTAgW2t2bV0NCiAgICAgPyBoYW5kbGVfdm1mdW5jKzB4MmYwLzB4MmYwIFtrdm1faW50
ZWxdDQogICAgID8gd2FpdF9sYXBpY19leHBpcmUrMHgyNS8weDI3MCBba3ZtXQ0KICAgICB2Y3B1
X2VudGVyX2d1ZXN0KzB4NzIwLzB4MWVmMCBba3ZtXQ0KICAgICAuLi4NCg0KV2hlbiBDUy5MIGlz
IHNldCwgdmNwdSBzaG91bGQgcnVuIGluIHRoZSA2NCBiaXQgcGFnaW5nIG1vZGUuDQpDdXJyZW50
IGt2bSBzZXRfc3JlZ3MgZnVuY3Rpb24gZG9lc24ndCBoYXZlIHN1Y2ggY2hlY2sgd2hlbg0KdXNl
cnNwYWNlIGlucHV0cyBzcmVnIHZhbHVlcy4gVGhpcyB3aWxsIGxlYWQgdW5leHBlY3RlZCBiZWhh
dmlvci4NClRoaXMgcGF0Y2ggaXMgdG8gYWRkIGNoZWNrcyBmb3IgQ1MuTCwgRUZFUi5MTUUsIEVG
RVIuTE1BIGFuZA0KQ1I0LlBBRSB3aGVuIGdldCBTUkVHIGlucHV0cyBmcm9tIHVzZXJzcGFjZSBp
biBvcmRlciB0byBhdm9pZA0KdW5leHBlY3RlZCBiZWhhdmlvci4NCg0KU3VnZ2VzdGVkLWJ5OiBQ
YW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KUmVwb3J0ZWQtYnk6IERtaXRyeSBW
eXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUBy
ZWRoYXQuY29tPg0KQ2M6IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KQ2M6
IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCkNjOiBKaW0gTWF0dHNvbiA8am1h
dHRzb25AZ29vZ2xlLmNvbT4NClNpZ25lZC1vZmYtYnk6IFRpYW55dSBMYW4gPHRpYW55dS5sYW5A
aW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9z
b2Z0LmNvbT4NCi0tLQ0KIGFyY2gveDg2L2t2bS94ODYuYyB8IDI2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2t2bS94ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYw0KaW5kZXggOGMyODAy
M2E0M2IxLi5hZDBmMTgxMDdjNzQgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMNCisr
KyBiL2FyY2gveDg2L2t2bS94ODYuYw0KQEAgLTc0NzMsNiArNzQ3MywyOSBAQCBpbnQga3ZtX3Rh
c2tfc3dpdGNoKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTE2IHRzc19zZWxlY3RvciwgaW50IGlk
dF9pbmRleCwNCiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoa3ZtX3Rhc2tfc3dpdGNoKTsNCiANCitp
bnQga3ZtX3ZhbGlkX3NyZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGt2bV9zcmVn
cyAqc3JlZ3MpDQorew0KKwlpZiAoKHNyZWdzLT5lZmVyICYgRUZFUl9MTUUpICYmIChzcmVncy0+
Y3IwICYgWDg2X0NSMF9QR19CSVQpKSB7DQorCQkvKg0KKwkJICogV2hlbiBFRkVSLkxNRSBhbmQg
Q1IwLlBHIGFyZSBzZXQsIHRoZSBwcm9jZXNzb3IgaXMgaW4NCisJCSAqIDY0LWJpdCBtb2RlICh0
aG91Z2ggbWF5YmUgaW4gYSAzMi1iaXQgY29kZSBzZWdtZW50KS4NCisJCSAqIENSNC5QQUUgYW5k
IEVGRVIuTE1BIG11c3QgYmUgc2V0Lg0KKwkJICovDQorCQlpZiAoIShzcmVncy0+Y3I0ICYgWDg2
X0NSNF9QQUVfQklUKQ0KKwkJICAgIHx8ICEoc3JlZ3MtPmVmZXIgJiBFRkVSX0xNQSkpDQorCQkJ
cmV0dXJuIC1FSU5WQUw7DQorCX0gZWxzZSB7DQorCQkvKg0KKwkJICogTm90IGluIDY0LWJpdCBt
b2RlOiBFRkVSLkxNQSBpcyBjbGVhciBhbmQgdGhlIGNvZGUNCisJCSAqIHNlZ21lbnQgY2Fubm90
IGJlIDY0LWJpdC4NCisJCSAqLw0KKwkJaWYgKHNyZWdzLT5lZmVyICYgRUZFUl9MTUEgfHwgc3Jl
Z3MtPmNzLmwpDQorCQkJcmV0dXJuIC1FSU5WQUw7DQorCX0NCisNCisJcmV0dXJuIDA7DQorfQ0K
Kw0KIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3NldF9zcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsDQogCQkJCSAgc3RydWN0IGt2bV9zcmVncyAqc3JlZ3MpDQogew0KQEAgLTc0ODUsNiArNzUw
OCw5IEBAIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3NldF9zcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsDQogCQkJKHNyZWdzLT5jcjQgJiBYODZfQ1I0X09TWFNBVkUpKQ0KIAkJcmV0dXJuIC1F
SU5WQUw7DQogDQorCWlmIChrdm1fdmFsaWRfc3JlZ3ModmNwdSwgc3JlZ3MpKQ0KKwkJcmV0dXJu
IC1FSU5WQUw7DQorDQogCWFwaWNfYmFzZV9tc3IuZGF0YSA9IHNyZWdzLT5hcGljX2Jhc2U7DQog
CWFwaWNfYmFzZV9tc3IuaG9zdF9pbml0aWF0ZWQgPSB0cnVlOw0KIAlpZiAoa3ZtX3NldF9hcGlj
X2Jhc2UodmNwdSwgJmFwaWNfYmFzZV9tc3IpKQ0KLS0gDQoyLjExLjANCg==
