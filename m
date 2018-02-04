Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2332106-1517710667-2-1450456448810786348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517710666; b=iRBvDw/bBUObC42pIaVJ/bves16D2IG7foc68FqoASTVb5w
    oCO8ARHrsFJeKYJDhVKZRwY+tuo7ugIKAsjktrcEwRow2g+hHB5S68VH37b+coF7
    GwoSVnX2yKFyIUv1ZHaQfUewY3DFXAeybmYQG9gWFKaj/vcAeJXOUMNgxXokbSfL
    yrdY6mnSpvTft9gCAc1+4KLM1FsM8QKq18McqAWZ7zo4roIj7JSb7G0TlRPdISA+
    jBPihLbAvryHU/uQ0tCpLuMOS7NVk2x/lvP5e2mq3LUMLN2EnExnIMuD3mAhkgPW
    +6IVsDYq0HZ5EKYFFVyflZkFsj2+1YTUfhtyn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517710666; bh=1+0Pb0lN3UO4fw9AewK3PJUcm/Wv33kLY1w9qV
    J4GL0=; b=Gb8w1cr1kcpJMjyLxdWKA6ClxI9iPEUclv9fw30Qq9OQQIb++jezFD
    R/rF213S8oujB5KZbPOjNsuc0J9jGRzW8qKVWHBiMxeH0Ucb9RSqYZrLd7gwWL+8
    7k7ufn7ea8h9P/rdNwUEWy3krzKJzJFAKjNjmQtdQpzi6iOjRmlMA+pXbZ0nXGRf
    fMCPwqbY1XD0Cqmf+liLr4BUbWjfwYaKynsOR7Pbz6XMJa/3OIvDUmYxnQkWAFTs
    8qtPZBE9G2sflToX3MJx9VAY6oQVckEE5pTeLO/8Dfyo/iaavvBjeZRN8VxGIHFR
    kS4GYfjRKpW4dnTrH4TOUdRJs3zpDZvg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bb4uHXRX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bb4uHXRX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbeBDCRl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 21:17:41 -0500
Received: from mail-by2nam01on0101.outbound.protection.outlook.com ([104.47.34.101]:65024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750738AbeBDCRk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 21:17:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Eric Biggers <ebiggers3@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Lan Tianyu <tianyu.lan@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH AUTOSEL for 4.14 006/110] KVM/x86: Check input paging mode
 when cs.l is set
Thread-Topic: [PATCH AUTOSEL for 4.14 006/110] KVM/x86: Check input paging
 mode when cs.l is set
Thread-Index: AQHTnRjgClsyeRQkJEGKx4/m279SwaOTc5uAgAAO0oA=
Date: Sun, 4 Feb 2018 02:17:37 +0000
Message-ID: <20180204021730.kiv7n6ag6t4srrql@sasha-lappy>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-6-alexander.levin@microsoft.com>
 <20180204012429.GA24727@zzz.localdomain>
In-Reply-To: <20180204012429.GA24727@zzz.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;6:T+LUgnOBc+NRFhb+1m+IkwJR+cNNxWr+GONwpi29LGYzLVSFwgcaAJ56LB7onMFxjjTV1TcEuQUOVECLvxEvHPXeUYy1ZgHnBxMG1FO16uCSVI8ty4m8N1U22c8sI/NAV3+qPbIIm3uaFUWUBPXJHiGxzU2XCyGJm4Vk2iGs2ZQtOjreYp8LYwNyegk5WvXP4Y8QxW6yQoG+GNzm3fLGBlemEl05EFIiT9wdx5kG39dFcIeW/BxHa6WiC918KEgLLm97jVfM2forcgevR2hE17sMQCw+lmwFwUip4R7cNjusdqmExCUzB+RZ3ApSvpN+0UuB7hEqaXl+eZdK1fgdq2s7di5te+u9up3LIMKYupsHXLcSGsfLHqwDaRwAM1eu;5:i1eypor2zd6dq/vylEZ6of1GumAl/lfMJqQj5xRvSrYY7PBBYH33m1ivYxuEuGCLxAYC0opSUlDY+xdd3DgwJOepCE7qSI1eodurnB5CQoxihJLvcCzw9mtCwYilyopxPjiafmRxiYT/yuR8HxuOqwafbGcOIRlm8Qp3Z5sy1l4=;24:LOtKR6F4ont6j3ytAleHRxAj4MJFAbHWk3wosoKWMEFQuf5mUk7Lni5inEuv0EoS9IJx03/foJoi5/ZYRh+V2ZAysxZIvZ/N/5GMzxxOitY=;7:gsoj/aL9klsX7EDh3rDeJtGzoYJ9d3czSFSlxa/AF2LxCXGStpMdBdbbosnpYcyoDjd4d6urkaTDCpE9jAxIuF/uZr0njJ6K88gaD6Fexb6iR86v9jlo5D1Gjzw7kKAd9rVdiXtfOrfeAE3wMPpzO+a48f5LT1e+VF720++KXXGIx+6l3475ltgB88kLTyr7OyQXES6ruRVsHx0lGkpVIs3hTJH/nHALDmEQt/QLJgenNvJTmTwiyipkFq9r9SZb
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d1259c4-c995-40a8-e89f-08d56b7575c1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
x-microsoft-antispam-prvs: <DM5PR2101MB1110C773F2ED8D2840635CD5FBFF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 05739BA1B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(199004)(189003)(14454004)(86612001)(72206003)(478600001)(39060400002)(1411001)(4326008)(10090500001)(305945005)(7736002)(6116002)(3846002)(2900100001)(25786009)(1076002)(10290500003)(97736004)(22452003)(316002)(81166006)(8676002)(106356001)(5660300001)(81156014)(6916009)(68736007)(6346003)(26005)(6506007)(102836004)(186003)(2950100002)(6246003)(33896004)(66066001)(229853002)(3660700001)(76176011)(59450400001)(53936002)(6486002)(3280700002)(2906002)(575784001)(86362001)(33716001)(99286004)(9686003)(6512007)(8936002)(54906003)(6436002)(105586002)(5250100002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: y8cGYxUNL22TTgx0iZgwwKi4bos63XJoAUiGvNq8os1762hb2lOOdVmVsUrIgAWu1qWPstiS1fSvPLdQM60/Mw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C650F3D91332D54FA0A7DB2354223745@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1259c4-c995-40a8-e89f-08d56b7575c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2018 02:17:37.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gU2F0LCBGZWIgMDMsIDIwMTggYXQgMDU6MjQ6MjlQTSAtMDgwMCwgRXJpYyBCaWdnZXJzIHdy
b3RlOg0KPk9uIFNhdCwgRmViIDAzLCAyMDE4IGF0IDA2OjAwOjI5UE0gKzAwMDAsIFNhc2hhIExl
dmluIHdyb3RlOg0KPj4gRnJvbTogTGFuIFRpYW55dSA8dGlhbnl1LmxhbkBpbnRlbC5jb20+DQo+
Pg0KPj4gWyBVcHN0cmVhbSBjb21taXQgZjI5ODEwMzM1OTY1YWMxZjdiY2I1MDFlZTJhZjVmMDM5
Zjc5MjQxNiBdDQo+Pg0KPj4gUmVwb3J0ZWQgYnkgc3l6a2FsbGVyOg0KPj4gICAgIFdBUk5JTkc6
IENQVTogMCBQSUQ6IDI3OTYyIGF0IGFyY2gveDg2L2t2bS9lbXVsYXRlLmM6NTYzMSB4ODZfZW11
bGF0ZV9pbnNuKzB4NTU3LzB4MTVmMCBba3ZtXQ0KPj4gICAgIE1vZHVsZXMgbGlua2VkIGluOiBr
dm1faW50ZWwga3ZtIFtsYXN0IHVubG9hZGVkOiBrdm1dDQo+PiAgICAgQ1BVOiAwIFBJRDogMjc5
NjIgQ29tbTogc3l6LWV4ZWN1dG9yIFRhaW50ZWQ6IEcgICAgQiAgIFcgICAgICAgIDQuMTUuMC1y
YzItbmV4dC0yMDE3MTIwOCsgIzMyDQo+PiAgICAgSGFyZHdhcmUgbmFtZTogSW50ZWwgQ29ycG9y
YXRpb24gUzEyMDBTUC9TMTIwMFNQLCBCSU9TIFMxMjAwU1AuODZCLjAxLjAzLjAwMDYuMDQwNzIw
MTYxMjUzIDA0LzA3LzIwMTYNCj4+ICAgICBSSVA6IDAwMTA6eDg2X2VtdWxhdGVfaW5zbisweDU1
Ny8weDE1ZjAgW2t2bV0NCj4+ICAgICBSU1A6IDAwMTg6ZmZmZjg4MDcyMzQ0NzZkMCBFRkxBR1M6
IDAwMDEwMjgyDQo+PiAgICAgUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjg4MDcyZDAy
MzdhMCBSQ1g6IGZmZmZmZmZmYTAwNjVjNGQNCj4+ICAgICBSRFg6IDFmZmZmMTAwZTVhMDQ2Zjkg
UlNJOiAwMDAwMDAwMDAwMDAwMDAzIFJESTogZmZmZjg4MDcyZDAyMzdjOA0KPj4gICAgIFJCUDog
ZmZmZjg4MDcyMzQ0NzcyOCBSMDg6IGZmZmY4ODA3MmQwMjAwMDAgUjA5OiBmZmZmZmZmZmEwMDhk
MjQwDQo+PiAgICAgUjEwOiAwMDAwMDAwMDAwMDAwMDAyIFIxMTogZmZmZmVkMDBlN2Q4N2RiMyBS
MTI6IGZmZmY4ODA3MmQwMjM3YzgNCj4+ICAgICBSMTM6IGZmZmY4ODA3MmQwMjM4NzAgUjE0OiBm
ZmZmODgwNzJkMDIzOGMyIFIxNTogZmZmZmZmZmZhMDA4ZDA4MA0KPj4gICAgIEZTOiAgMDAwMDdm
OGE2ODY2NjcwMCgwMDAwKSBHUzpmZmZmODgwODAyMjAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAw
MDAwMDAwMDANCj4+ICAgICBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAw
MDgwMDUwMDMzDQo+PiAgICAgQ1IyOiAwMDAwMDAwMDIwMDk1MDZjIENSMzogMDAwMDAwMDcxZmVj
NDAwNSBDUjQ6IDAwMDAwMDAwMDAzNjI2ZjANCj4+ICAgICBDYWxsIFRyYWNlOg0KPj4gICAgICB4
ODZfZW11bGF0ZV9pbnN0cnVjdGlvbisweDNiYy8weGI3MCBba3ZtXQ0KPj4gICAgICA/IHJlZXhl
Y3V0ZV9pbnN0cnVjdGlvbi5wYXJ0LjE2MisweDEzMC8weDEzMCBba3ZtXQ0KPj4gICAgICB2bXhf
aGFuZGxlX2V4aXQrMHg0NmQvMHgxNGYwIFtrdm1faW50ZWxdDQo+PiAgICAgID8gdHJhY2VfZXZl
bnRfcmF3X2V2ZW50X2t2bV9lbnRyeSsweGU3LzB4MTUwIFtrdm1dDQo+PiAgICAgID8gaGFuZGxl
X3ZtZnVuYysweDJmMC8weDJmMCBba3ZtX2ludGVsXQ0KPj4gICAgICA/IHdhaXRfbGFwaWNfZXhw
aXJlKzB4MjUvMHgyNzAgW2t2bV0NCj4+ICAgICAgdmNwdV9lbnRlcl9ndWVzdCsweDcyMC8weDFl
ZjAgW2t2bV0NCj4+ICAgICAgLi4uDQo+Pg0KPj4gV2hlbiBDUy5MIGlzIHNldCwgdmNwdSBzaG91
bGQgcnVuIGluIHRoZSA2NCBiaXQgcGFnaW5nIG1vZGUuDQo+PiBDdXJyZW50IGt2bSBzZXRfc3Jl
Z3MgZnVuY3Rpb24gZG9lc24ndCBoYXZlIHN1Y2ggY2hlY2sgd2hlbg0KPj4gdXNlcnNwYWNlIGlu
cHV0cyBzcmVnIHZhbHVlcy4gVGhpcyB3aWxsIGxlYWQgdW5leHBlY3RlZCBiZWhhdmlvci4NCj4+
IFRoaXMgcGF0Y2ggaXMgdG8gYWRkIGNoZWNrcyBmb3IgQ1MuTCwgRUZFUi5MTUUsIEVGRVIuTE1B
IGFuZA0KPj4gQ1I0LlBBRSB3aGVuIGdldCBTUkVHIGlucHV0cyBmcm9tIHVzZXJzcGFjZSBpbiBv
cmRlciB0byBhdm9pZA0KPj4gdW5leHBlY3RlZCBiZWhhdmlvci4NCj4+DQo+PiBTdWdnZXN0ZWQt
Ynk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+PiBSZXBvcnRlZC1ieTog
RG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPj4gQ2M6IFBhb2xvIEJvbnppbmkg
PHBib256aW5pQHJlZGhhdC5jb20+DQo+PiBDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJl
ZGhhdC5jb20+DQo+PiBDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPj4g
Q2M6IEppbSBNYXR0c29uIDxqbWF0dHNvbkBnb29nbGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
VGlhbnl1IExhbiA8dGlhbnl1LmxhbkBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYW9s
byBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogU2FzaGEg
TGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KPj4gLS0tDQo+PiAgYXJjaC94
ODYva3ZtL3g4Ni5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
dm0veDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCj4+IGluZGV4IDhjMjgwMjNhNDNiMS4uYWQw
ZjE4MTA3Yzc0IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQo+PiArKysgYi9h
cmNoL3g4Ni9rdm0veDg2LmMNCj4+IEBAIC03NDczLDYgKzc0NzMsMjkgQEAgaW50IGt2bV90YXNr
X3N3aXRjaChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHUxNiB0c3Nfc2VsZWN0b3IsIGludCBpZHRf
aW5kZXgsDQo+PiAgfQ0KPj4gIEVYUE9SVF9TWU1CT0xfR1BMKGt2bV90YXNrX3N3aXRjaCk7DQo+
Pg0KPj4gK2ludCBrdm1fdmFsaWRfc3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qg
a3ZtX3NyZWdzICpzcmVncykNCj4+ICt7DQo+PiArCWlmICgoc3JlZ3MtPmVmZXIgJiBFRkVSX0xN
RSkgJiYgKHNyZWdzLT5jcjAgJiBYODZfQ1IwX1BHX0JJVCkpIHsNCj4+ICsJCS8qDQo+PiArCQkg
KiBXaGVuIEVGRVIuTE1FIGFuZCBDUjAuUEcgYXJlIHNldCwgdGhlIHByb2Nlc3NvciBpcyBpbg0K
Pj4gKwkJICogNjQtYml0IG1vZGUgKHRob3VnaCBtYXliZSBpbiBhIDMyLWJpdCBjb2RlIHNlZ21l
bnQpLg0KPj4gKwkJICogQ1I0LlBBRSBhbmQgRUZFUi5MTUEgbXVzdCBiZSBzZXQuDQo+PiArCQkg
Ki8NCj4+ICsJCWlmICghKHNyZWdzLT5jcjQgJiBYODZfQ1I0X1BBRV9CSVQpDQo+PiArCQkgICAg
fHwgIShzcmVncy0+ZWZlciAmIEVGRVJfTE1BKSkNCj4+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4+
ICsJfSBlbHNlIHsNCj4+ICsJCS8qDQo+PiArCQkgKiBOb3QgaW4gNjQtYml0IG1vZGU6IEVGRVIu
TE1BIGlzIGNsZWFyIGFuZCB0aGUgY29kZQ0KPj4gKwkJICogc2VnbWVudCBjYW5ub3QgYmUgNjQt
Yml0Lg0KPj4gKwkJICovDQo+PiArCQlpZiAoc3JlZ3MtPmVmZXIgJiBFRkVSX0xNQSB8fCBzcmVn
cy0+Y3MubCkNCj4+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlyZXR1
cm4gMDsNCj4+ICt9DQo+DQo+VGhpcyBjb21taXQgaXMgYnJva2VuIGFuZCB0aGVyZSB3YXMgYSBm
aXggZm9yIGl0IG1lcmdlZDogMzdiOTU5NTFjNTggKCJLVk0veDg2Og0KPkZpeCB3cm9uZyBtYWNy
byByZWZlcmVuY2VzIG9mIFg4Nl9DUjBfUEdfQklUIGFuZCBYODZfQ1I0X1BBRV9CSVQgaW4NCj5r
dm1fdmFsaWRfc3JlZ3MoKSIpLiAgU2hvdWxkbid0IHlvdXIgc2NyaXB0IGhhdmUgcGlja2VkIHRo
YXQgdXAgdG9vPw0KDQpJdCBzaG91bGQgaGF2ZSwgeWVzLiBJIHRyaWVkIHRvIGZpZ3VyZSBvdXQg
d2h5IGl0IGRpZG4ndCBhbmQgaXQgbG9va3MNCmxpa2UgdGhlICJGaXhlczoiIGxpbmUgaXMgYSBi
aXQgbWVzc2VkIHVwIGluIHRoYXQgY29tbWl0LCBhbmQgbXkgc2NyaXB0DQpkaWRuJ3QgcGFyc2Ug
aXQgcmlnaHQ6DQoNCglGaXhlczogZjI5ODEwMzM1OTY1YShLVk0veDg2OiBDaGVjayBpbnB1dCBw
YWdpbmcgbW9kZSB3aGVuIGNzLmwNCmlzIHNldCkNCg0KLS0gDQoNClRoYW5rcywNClNhc2hh
