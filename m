Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243186-2-12432715277648844816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243185; b=ap/m13Q5rU2ykoswr7Nl/0+cTU1B5pd6rFqL4439W2uKyEtZ+o
    /rmBVHVaDzd5Vls1N3U91ol34m+DhHzlAV93Yf85RCxebVQ7mPMqf32kGtN6p3xM
    0lYVCkBK5h2cDI+kbxMEYA6YU2XCj/aHWUc593PZjVUP1TZIp9zf9qHPWPfvpkfl
    iI50D6LAGpMK+wT3w07E3zYWC3M78j32Cpco4Wv6Mn2GWveUgzjWdIVMY/n8drMD
    I/8sbjPXim63axPqQpJ59nxUXOZiTm1A3z2LdeSEaNZ2/XPCOoxdxM5pVieWreHh
    EVAzcxjqpahW3BadXGmZJGye420P7FIvtyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523243185; bh=XsT08T4kpCsUmh8zkywSaZdnoorwQoX5JUS+l7BZpl0=; b=
    p0NZGrf8aKHptUm0U5qJ8yCbj6dZEOLp0/nKW3Bc2dwFnWKYA0Emi3EzuooiOObc
    MV18u9cINJDxZj6XAL+n5KdGCGANpt48PmnY+IABw6od0lorxXWpEDrXhV5t5kbS
    1NYmq7V3PA+SVcIDBrB2E72t+iGFg8tyPaKWSVEVoRVam9livZNCNqJBpn2E4I87
    kFx4F/oKYmHFH4vAEfB7NW8jFx+HjVcgnOuSY3uMuXENjZh6gOZwv8xjKGNf6yIL
    cPz+5ljBWveynaE0rZ+oEKtWRXB6wTjLvin3CqkOzxLB6BTtZGH5acTCw+5OmG2C
    cK/Lut1xe6jX1mhkPuMCjg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i/pwYQ1A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i/pwYQ1A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLqEez2UPJJwzzlSRWNrVfGenn8Cf7y8o9benP/YEiZuVAVIMGdKJz4I5Uyjr0PtKUX4NMrp1xIbmhziz4s692Jd+6T+9pw43e6g4mXVMt/QINYhP+yf
    u8lCe1/lF5c+w+gnKFI+ImrVosPIMlQmELkGhvGVfXWxrzkyskknTrZjrSre5Ag4XmDbLh+czK+c0wzdoxkx6rmFvEUvoL/ruiNt2iDKkFLV13TuHlaXIxjK
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=IGERox2zBV1zzKJ-FZYA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeDIDFy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:05:54 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754108AbeDIAYj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 094/161] x86/kvm/vmx: do not use vm-exit
 instruction length for fast MMIO when running nested
Thread-Topic: [PATCH AUTOSEL for 4.14 094/161] x86/kvm/vmx: do not use vm-exit
 instruction length for fast MMIO when running nested
Thread-Index: AQHTz5imeUJmSRFSmkeTlGp1aemtwg==
Date: Mon, 9 Apr 2018 00:21:05 +0000
Message-ID: <20180409001936.162706-94-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:vF3HlcOlDAgtckiqzmcX1ZUNGfks9qlLnbph0tlm7I7VtKYf+QZyDxYo2Tcp8t5y/amcD2BYakCmjysW/ZQFpzOIB6z8fgd96ZRFMZ80yVxvapyYh9Rtj4gz8RVAulEpjBI9OioXXRoCCZsKWe8Xq0qXiVy7GxVL7TU5Fz+aDkRmFMys4xoWvz7pYl1egUCc1ejT9l0vomHDM7/VT1z2dQ8ab0T8AjQLnCiP71mssKdfI1VBC7eyVSgFR8+jTaXa;20:brUMBKWF20Bum0D5KtYrO/aDA0FP+eY6qf3rUZq4JG7pUCu1rlCa611IiK9XHtT7NP6XFe5yeQ2NSZI/wGju9FsxbtGBSo7YMKF5DTOxaY3vO/jOr8bhbGK9B37rQic7DjNmSivy1xvGGsroBv64tGk7BEc7Dwk6nv3lY5HJEew=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12ad9e5c-9ca6-4c1d-ed53-08d59db045c2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984D7A131AFE321728E38CFFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(575784001)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fHT5hDg5QZaIidgMaObV6LlEbIuMiM4RiPYMCs3fi/AVYYOw+gypn5NL9feSExkTwzK5FnU+K5KJoFo5ddyATi6C9owNJKFLEIR83aPhjpaxuzGCQRZKRa2ms5XuOtj3QnQ8cZEMmHDDJHE0P+bCuilwHdY67cK0K0S8+4oNix8c70EhlyPW6vtH361M2bfsOJEmjef7Wr2VQSpHAnH5zgCbN0t89+lrWrgrNQn/GbGHYU+BnGIqkAzWziQFyulNUqCznIZpIJ5SvYy5iZP1iptA/gPayC1NnjdAf1+JoCu/nnh48h49Idd/zMbGb8KyAtO7KHrNcyHEaaJzquCPtf8NZQYgw6QenD9TT87eE4QkMj83rSHaQ+d0/JU3IfD5VNd2oIP66xF24/SizmV6eAEaRXpzd0h8sT+CvR76H8M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED90D78AE6698C49BC46030842DB2729@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ad9e5c-9ca6-4c1d-ed53-08d59db045c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:05.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVml0YWx5IEt1em5ldHNvdiA8dmt1em5ldHNAcmVkaGF0LmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgZDM5MWYxMjA3MDY3MjY4MjYxYWRkMDQ4NWYwZjM0NTAzNTM5YzViMCBdDQoNCkkg
d2FzIGludmVzdGlnYXRpbmcgYW4gaXNzdWUgd2l0aCBzZWFiaW9zID49IDEuMTAgd2hpY2ggc3Rv
cHBlZCB3b3JraW5nDQpmb3IgbmVzdGVkIEtWTSBvbiBIeXBlci1WLiBUaGUgcHJvYmxlbSBhcHBl
YXJzIHRvIGJlIGluDQpoYW5kbGVfZXB0X3Zpb2xhdGlvbigpIGZ1bmN0aW9uOiB3aGVuIHdlIGRv
IGZhc3QgbW1pbyB3ZSBuZWVkIHRvIHNraXANCnRoZSBpbnN0cnVjdGlvbiBzbyB3ZSBkbyBrdm1f
c2tpcF9lbXVsYXRlZF9pbnN0cnVjdGlvbigpLiBUaGlzLCBob3dldmVyLA0KZGVwZW5kcyBvbiBW
TV9FWElUX0lOU1RSVUNUSU9OX0xFTiBmaWVsZCBiZWluZyBzZXQgY29ycmVjdGx5IGluIFZNQ1Mu
DQpIb3dldmVyLCB0aGlzIGlzIG5vdCB0aGUgY2FzZS4NCg0KSW50ZWwncyBtYW51YWwgZG9lc24n
dCBtYW5kYXRlIFZNX0VYSVRfSU5TVFJVQ1RJT05fTEVOIHRvIGJlIHNldCB3aGVuDQpFUFQgTUlT
Q09ORklHIG9jY3Vycy4gV2hpbGUgb24gcmVhbCBoYXJkd2FyZSBpdCB3YXMgb2JzZXJ2ZWQgdG8g
YmUgc2V0LA0Kc29tZSBoeXBlcnZpc29ycyBmb2xsb3cgdGhlIHNwZWMgYW5kIGRvbid0IHNldCBp
dDsgd2UgZW5kIHVwIGFkdmFuY2luZw0KSVAgd2l0aCBzb21lIHJhbmRvbSB2YWx1ZS4NCg0KSSBj
aGVja2VkIHdpdGggTWljcm9zb2Z0IGFuZCB0aGV5IGNvbmZpcm1lZCB0aGV5IGRvbid0IGZpbGwN
ClZNX0VYSVRfSU5TVFJVQ1RJT05fTEVOIG9uIEVQVCBNSVNDT05GSUcuDQoNCkZpeCB0aGUgaXNz
dWUgYnkgZG9pbmcgaW5zdHJ1Y3Rpb24gc2tpcCB0aHJvdWdoIGVtdWxhdG9yIHdoZW4gcnVubmlu
Zw0KbmVzdGVkLg0KDQpGaXhlczogNjhjM2I0ZDE2NzZkODcwZjA0NTNjMzFkNWE1MmU3ZTY1Yzc0
NDhhZQ0KU3VnZ2VzdGVkLWJ5OiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJAcmVkaGF0LmNvbT4N
ClN1Z2dlc3RlZC1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NClNpZ25l
ZC1vZmYtYnk6IFZpdGFseSBLdXpuZXRzb3YgPHZrdXpuZXRzQHJlZGhhdC5jb20+DQpBY2tlZC1i
eTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFJh
ZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEg
TGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogYXJjaC94ODYva3Zt
L3ZteC5jIHwgMTYgKysrKysrKysrKysrKysrLQ0KIGFyY2gveDg2L2t2bS94ODYuYyB8ICAzICsr
LQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXguYyBiL2FyY2gveDg2L2t2bS92bXguYw0KaW5k
ZXggYWU0ODAzYjIxM2QwLi5iZGQ4NGNlNDQ5MWUgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0v
dm14LmMNCisrKyBiL2FyY2gveDg2L2t2bS92bXguYw0KQEAgLTY3NjUsNyArNjc2NSwyMSBAQCBz
dGF0aWMgaW50IGhhbmRsZV9lcHRfbWlzY29uZmlnKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiAJ
aWYgKCFpc19ndWVzdF9tb2RlKHZjcHUpICYmDQogCSAgICAha3ZtX2lvX2J1c193cml0ZSh2Y3B1
LCBLVk1fRkFTVF9NTUlPX0JVUywgZ3BhLCAwLCBOVUxMKSkgew0KIAkJdHJhY2Vfa3ZtX2Zhc3Rf
bW1pbyhncGEpOw0KLQkJcmV0dXJuIGt2bV9za2lwX2VtdWxhdGVkX2luc3RydWN0aW9uKHZjcHUp
Ow0KKwkJLyoNCisJCSAqIERvaW5nIGt2bV9za2lwX2VtdWxhdGVkX2luc3RydWN0aW9uKCkgZGVw
ZW5kcyBvbiB1bmRlZmluZWQNCisJCSAqIGJlaGF2aW9yOiBJbnRlbCdzIG1hbnVhbCBkb2Vzbid0
IG1hbmRhdGUNCisJCSAqIFZNX0VYSVRfSU5TVFJVQ1RJT05fTEVOIHRvIGJlIHNldCBpbiBWTUNT
IHdoZW4gRVBUIE1JU0NPTkZJRw0KKwkJICogb2NjdXJzIGFuZCB3aGlsZSBvbiByZWFsIGhhcmR3
YXJlIGl0IHdhcyBvYnNlcnZlZCB0byBiZSBzZXQsDQorCQkgKiBvdGhlciBoeXBlcnZpc29ycyAo
bmFtZWx5IEh5cGVyLVYpIGRvbid0IHNldCBpdCwgd2UgZW5kIHVwDQorCQkgKiBhZHZhbmNpbmcg
SVAgd2l0aCBzb21lIHJhbmRvbSB2YWx1ZS4gRGlzYWJsZSBmYXN0IG1taW8gd2hlbg0KKwkJICog
cnVubmluZyBuZXN0ZWQgYW5kIGtlZXAgaXQgZm9yIHJlYWwgaGFyZHdhcmUgaW4gaG9wZSB0aGF0
DQorCQkgKiBWTV9FWElUX0lOU1RSVUNUSU9OX0xFTiB3aWxsIGFsd2F5cyBiZSBzZXQgY29ycmVj
dGx5Lg0KKwkJICovDQorCQlpZiAoIXN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0hZUEVSVklT
T1IpKQ0KKwkJCXJldHVybiBrdm1fc2tpcF9lbXVsYXRlZF9pbnN0cnVjdGlvbih2Y3B1KTsNCisJ
CWVsc2UNCisJCQlyZXR1cm4geDg2X2VtdWxhdGVfaW5zdHJ1Y3Rpb24odmNwdSwgZ3BhLCBFTVVM
VFlQRV9TS0lQLA0KKwkJCQkJCSAgICAgICBOVUxMLCAwKSA9PSBFTVVMQVRFX0RPTkU7DQogCX0N
CiANCiAJcmV0ID0ga3ZtX21tdV9wYWdlX2ZhdWx0KHZjcHUsIGdwYSwgUEZFUlJfUlNWRF9NQVNL
LCBOVUxMLCAwKTsNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9hcmNoL3g4Ni9r
dm0veDg2LmMNCmluZGV4IGQ3NzI4YmNkOWEzYy4uM2IyYzNhYTJjZDA3IDEwMDY0NA0KLS0tIGEv
YXJjaC94ODYva3ZtL3g4Ni5jDQorKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCkBAIC01Njk5LDcg
KzU2OTksOCBAQCBpbnQgeDg2X2VtdWxhdGVfaW5zdHJ1Y3Rpb24oc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LA0KIAkJICogaGFuZGxlIHdhdGNocG9pbnRzIHlldCwgdGhvc2Ugd291bGQgYmUgaGFuZGxl
ZCBpbg0KIAkJICogdGhlIGVtdWxhdGVfb3BzLg0KIAkJICovDQotCQlpZiAoa3ZtX3ZjcHVfY2hl
Y2tfYnJlYWtwb2ludCh2Y3B1LCAmcikpDQorCQlpZiAoIShlbXVsYXRpb25fdHlwZSAmIEVNVUxU
WVBFX1NLSVApICYmDQorCQkgICAga3ZtX3ZjcHVfY2hlY2tfYnJlYWtwb2ludCh2Y3B1LCAmcikp
DQogCQkJcmV0dXJuIHI7DQogDQogCQljdHh0LT5pbnRlcnJ1cHRpYmlsaXR5ID0gMDsNCi0tIA0K
Mi4xNS4xDQo=
