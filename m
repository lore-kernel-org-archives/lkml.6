Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233695-2-2558689524916002731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233694; b=UR5ZfgRbMTtTdAgi+q9pIGWL9TZ9oZMKalTjU0v3tWKWMQ/6QQ
    kecO2pDEUyM//lUPOLAIo4rBzOCp7X+mQQYfqzOsQvvV77NbKYLsTSSSgMFcEz0z
    wocbTJrH3kVFCjbgGCP1Yld7USr0PNbRxEM0fCMpuKW4WpwO+5awb9QkR/mZdXdD
    sH+mtaUXc6YaFO54EFVZfo9KB+KyHE8KmX9bCZk4lO0Y3QKroyPRxuHPsCBazIu3
    iiHdpSX+f3Lk5xfURNCcjIVOUSq+QQpgzu6UhGbo3Peq5Oa3DrGmBL17fLuyGEJD
    3sAl1apbSHD5hpJf1Du0J+j7lqoD3MSNIHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523233694; bh=RHQbGbPz1HcQ35XmNMdY5ws1SzMLX1re9Rl1BdFOUgM=; b=
    SlRuLtHw3VN+uwlQw3rmtxyhZ1o0OCLWFe0MKhvNKN73cMAmBYiih95utmp0V0Ii
    dql+ihntttt5abUjM7Min9ASmZ/HKy0l3VnqQzml/SgtgAzZA3sL9pntsCxOQeH6
    6x5HT1ESgfl5A8yXlPPmp1w9IbCRvFZ0HQunjT9IUPuJrRjZp46A/ipBpoJ2V0L1
    g5UeKK7Bbv6SUBq5fafh2r7TEYGP+X+WAlabv+caMCmYBshlcuXQV+fw54Id8AMt
    aFChJ1mILifGeWXO6HTAyLwMX9iyi+6MZ96h9xxfD4af7j27xPZ0NJD3fBlxnuoq
    qKegUdbL2www591A1TsGyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W1ji7YEq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W1ji7YEq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPOhTc01TQk4gvPbVnIzBiMasEz+oqY4cU0b9DkbmSwpkvyHFib9/ABefRfEXWOJLBORL5ESWglEfz3DxNaIB++x23ZKJQT4gsYqDa7SiWgm5PHeprDd
    vRBDLrhe8wbkLTNTc0iQswCxQ28ewURyvbT2hOJTYJAO4nnW1fhMqZ/4gokJOMjuSSwXQxl+sVY/dvd0TvyNelZBI8HWt1F9XPBjll+R9UWMHvziF2W/u6a4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=EqdPLkY1AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=c9LJUD5P9b49lab5o-oA:9 a=CPSBYo6li2zp6erR:21
    a=CJImAz3WB0RoXbvh:21 a=QEXdDO2ut3YA:10 a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755746AbeDIA2L (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:11 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:15008
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755817AbeDIA2I (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?= <jprvita@gmail.com>,
        =?utf-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 061/293] platform/x86: acer-wmi: Detect RF
 Button capability
Thread-Topic: [PATCH AUTOSEL for 4.9 061/293] platform/x86: acer-wmi: Detect
 RF Button capability
Thread-Index: AQHTz5kBCbxzv7XA4USeoMFzAddNSA==
Date: Mon, 9 Apr 2018 00:23:39 +0000
Message-ID: <20180409002239.163177-61-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:gXwRmbj9PQwmrlWDllwuPg2xjDTqQsywWqxkUXkE5rgp+I+RkhgYzIS8JjT1UxZC1wS68T1DA0AjIVNgi00ubMeqdKc58ae8V8QTc4DPeZ5i+JrUN/oAd50JbHS3p/kILDz0ZywWSb4+8P466GLZWtYeffqvpY9s8421in3wkJV5PIeyo+m8vsl1vzM7NtY/iuv0qsmyVBmVf8hwRrns1KBM0aVYHkbgJ72frjJfiGkMKzsHDBJeEjc/3UcZAsIr;20:XaifnxnMpVVoUivxwtO15+CiJgXD2fsrLssUcLv9vzmNlq2hBOJ0G7BFHifEUUo3FVDQ1q+F2gHmrZEumNyTlSrFTSIT0bXDJPVCLuCsIk02DijaASHR+vLRWc61B9ZYIslzHbGHetSMwHIz7iuV7+EV49z71R8rGUAPD93Ip3U=
X-MS-Office365-Filtering-Correlation-Id: 7dbcd109-4ca7-4901-9fd4-08d59db0c34b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08719EFDADF194DD8EF5E7BAFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(39060400002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6nF1pmw5QfD0yDriCY3e0o/JGwRacX7NWi9JznOariDK7Yce4FNTgKdSp0rO9eZg2HpK5OWFyS28R3HYsLPv5pmtatTLuQOIFPKRseT60ihzStEu+bvlZSIvsHFyFS/Qo/UDRUx4/X8daNjPxn09hoFm/phUEhssSZGWOLbHoMAfq82m8qP7pn6M0G3A90hikHl/5Enmq4IEGJKYLtFvpdw83qJ3cSdvY7nQQ5lml1JPEfce5TrJ7yJkJKAqlo+mSXUk7Uov8DDIvbS2uxEJS4ziSn7Krfzn9r9tHqgSJ/lAt0j7P6Y7iu6OZhXHIMNqzKZN0ANzhNXx9V985kT8UeIr4rsacb/GVaMZahSH39ayhCTZV+u0CgAtEimzI6c1IhswIi0ZORNeCHScwZKZNJx4Z9NpEqKzNbXsfDLGClc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D0E6BC55723E54893119BC296ECD0A2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbcd109-4ca7-4901-9fd4-08d59db0c34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:39.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSm/Do28gUGF1bG8gUmVjaGkgVml0YSA8anBydml0YUBnbWFpbC5jb20+DQoNClsgVXBz
dHJlYW0gY29tbWl0IDNlMmJjNWM1YjMyNzRlYzc0MDJmYWJiZmJhNTU3ZWE1ODA4NDk4NWUgXQ0K
DQpJZiBhIG1hY2hpbmUgcmVwb3J0cyBhIFJGIEJ1dHRvbiBpbiB0aGUgY29tbXVuaWNhdGlvbiBi
dXR0b24gZGV2aWNlDQpiaXRtYXAsIHdlIG5lZWQgdG8gcmVtb3ZlIGl0IGJlZm9yZSBjYWxsaW5n
IEdldCBEZXZpY2UgU3RhdHVzIG90aGVyd2lzZQ0KaXQgd2lsbCByZXR1cm4gdGhlICJVbmRlZmlu
ZWQgZGV2aWNlIiAoMHhFMikgZXJyb3IgY29kZS4NCg0KQWx0aG91Z2ggdGhpcyBtYXkgYmUgYSBC
SU9TIGJ1Zywgd2UgZG9uJ3QgcmVhbGx5IG5lZWQgdG8gZ2V0IG9yIHNldCB0aGUNClJGIEJ1dHRv
biBzdGF0dXMuIFRoZSBzdGF0dXMgaW5kaWNhdG9yIExFRCBlbWJlZGRlZCBpbiB0aGUgYnV0dG9u
IGlzDQpjb250cm9sbGVkIGJ5IGZpcm13YXJlIGxvZ2ljLCBkZXBlbmRpbmcgb24gdGhlIHN0YXR1
cyBvZiB0aGUgd2lyZWxlc3MNCnJhZGlvcyBwcmVzZW50IG9uIHRoZSBtYWNoaW5lIChXaUZpIHx8
IFdXQU4pLg0KDQpUaGlzIGNvbW1pdCBmaXhlcyB0aGUgd2lyZWxlc3Mgc3RhdHVzIGluZGljYXRv
ciBMRUQgb24gdGhlIEFjZXINClRyYXZlbE1hdGUgUDY0OC1HMi1NRywgYW5kIGNsZWFucyB0aGUg
Zm9sbG93aW5nIG1lc3NhZ2UgZnJvbSB0aGUga2VybmVsDQpsb2c6ICJHZXQgQ3VycmVudCBEZXZp
Y2UgU3RhdHVzIGZhaWxlZDogMHhlMiAtIDB4MCIuDQoNClNpZ25lZC1vZmYtYnk6IEpvw6NvIFBh
dWxvIFJlY2hpIFZpdGEgPGpwcnZpdGFAZW5kbGVzc20uY29tPg0KUmV2aWV3ZWQtYnk6ICJMZWUs
IENodW4tWWkiIDxqb2V5bGkua2VybmVsQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFuZHkg
U2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KU2lnbmVkLW9m
Zi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQog
ZHJpdmVycy9wbGF0Zm9ybS94ODYvYWNlci13bWkuYyB8IDcgKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2FjZXItd21pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hY2VyLXdtaS5jDQppbmRleCBjMjli
OWI2MTFhYjIuLjI2OGJjOWViMWM2YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2FjZXItd21pLmMNCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FjZXItd21pLmMNCkBAIC0x
NDgsNiArMTQ4LDggQEAgc3RydWN0IGV2ZW50X3JldHVybl92YWx1ZSB7DQogI2RlZmluZSBBQ0VS
X1dNSUQzX0dEU19USFJFRUcJCSgxPDw2KQkvKiAzRyAqLw0KICNkZWZpbmUgQUNFUl9XTUlEM19H
RFNfV0lNQVgJCSgxPDw3KQkvKiBXaU1BWCAqLw0KICNkZWZpbmUgQUNFUl9XTUlEM19HRFNfQkxV
RVRPT1RICSgxPDwxMSkJLyogQlQgKi8NCisjZGVmaW5lIEFDRVJfV01JRDNfR0RTX1JGQlROCQko
MTw8MTQpCS8qIFJGIEJ1dHRvbiAqLw0KKw0KICNkZWZpbmUgQUNFUl9XTUlEM19HRFNfVE9VQ0hQ
QUQJCSgxPDwxKQkvKiBUb3VjaHBhZCAqLw0KIA0KIHN0cnVjdCBsbV9pbnB1dF9wYXJhbXMgew0K
QEAgLTIwNSw2ICsyMDcsNyBAQCBzdHJ1Y3QgaG90a2V5X2Z1bmN0aW9uX3R5cGVfYWEgew0KICNk
ZWZpbmUgQUNFUl9DQVBfQlJJR0hUTkVTUwkJKDE8PDMpDQogI2RlZmluZSBBQ0VSX0NBUF9USFJF
RUcJCQkoMTw8NCkNCiAjZGVmaW5lIEFDRVJfQ0FQX0FDQ0VMCQkJKDE8PDUpDQorI2RlZmluZSBB
Q0VSX0NBUF9SRkJUTgkJCSgxPDw2KQ0KICNkZWZpbmUgQUNFUl9DQVBfQU5ZCQkJKDB4RkZGRkZG
RkYpDQogDQogLyoNCkBAIC0xMjQ4LDYgKzEyNTEsMTAgQEAgc3RhdGljIHZvaWQgX19pbml0IHR5
cGVfYWFfZG1pX2RlY29kZShjb25zdCBzdHJ1Y3QgZG1pX2hlYWRlciAqaGVhZGVyLCB2b2lkICpk
KQ0KIAkJaW50ZXJmYWNlLT5jYXBhYmlsaXR5IHw9IEFDRVJfQ0FQX1RIUkVFRzsNCiAJaWYgKHR5
cGVfYWEtPmNvbW11bl9mdW5jX2JpdG1hcCAmIEFDRVJfV01JRDNfR0RTX0JMVUVUT09USCkNCiAJ
CWludGVyZmFjZS0+Y2FwYWJpbGl0eSB8PSBBQ0VSX0NBUF9CTFVFVE9PVEg7DQorCWlmICh0eXBl
X2FhLT5jb21tdW5fZnVuY19iaXRtYXAgJiBBQ0VSX1dNSUQzX0dEU19SRkJUTikgew0KKwkJaW50
ZXJmYWNlLT5jYXBhYmlsaXR5IHw9IEFDRVJfQ0FQX1JGQlROOw0KKwkJY29tbXVuX2Z1bmNfYml0
bWFwICY9IH5BQ0VSX1dNSUQzX0dEU19SRkJUTjsNCisJfQ0KIA0KIAljb21tdW5fZm5fa2V5X251
bWJlciA9IHR5cGVfYWEtPmNvbW11bl9mbl9rZXlfbnVtYmVyOw0KIH0NCi0tIA0KMi4xNS4xDQo=
