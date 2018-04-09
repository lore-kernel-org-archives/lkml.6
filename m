Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240702-2-2543841977621733553
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
    1523240701; b=V+Sd8fSnkObrXrc/Pzf/NFTvDJeAB9GZF8FEm6vNnCav6tGCvb
    1iZ8FOs+4hBFot37xvTkzptSicXuNstpp9tOUL6zpnSPD5lC5vKayIq0upAUCVCe
    7L5PK9kdInyIvX3zbXteqz/sKla4wEvmfofnkrXDcLHeD5Z6x70S9+oM41G9lFxW
    trE75F74abydqfZmbPGeY9Ff+V3Mef0c9WBXzn9mYBf0NvrRtHMz9rR1gL3w7j4O
    2F1khIsFHAWgKw2df65du9WZDP4EZjPpq4wUKIeOpFa7ogA69OrOGMwifaJMdgpq
    ci7aP67N2jk50i72ToPMvNTQ6+MrxBeQvZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523240701; bh=Z421iTkUQUs3+nC2eZyBJPU9el9jCbRu3Ei2kIk1Vh4=; b=
    APCK51pQeRKUjiRAHy3MljV+T2VAACRrUomSsq3LnMzEZgZ1l7NSqLZRjo1RFsCs
    9i9YaqH+u9R2MILRJEXf8O3ridiAhg275kxWcp+KyUOlPOLRTMyizYpO9pg6B6yQ
    tUZgn0NzFZUgXYq2NfoSfUWf4CsRNNYu9jjKPMkyj4eKLuCEspMb/LRtaVeYGB8z
    c4L1EZ05t9fNTAxR+k3Tsv0CgAWL2tldR+RhzO2AKdy2itG68oE/s0lPVAliUN3q
    x0fyU40Jz9ZWuDG9Z62D3GQ+MZekuCxensuBa4WZ6sH+ffAm8WY8TlPDXYGfdiHr
    UrJGGH5jeBZn7kgZ1T1nZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FESI5J9W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FESI5J9W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE5dvxzy+DLdnXiRw671VRjEYtjnbRYqbJBh+pgDtZqm10BQrXjexjpl6wslpnq2hZIAQy8mrwkp400uMwiotQsHLmX+pFjHXVZAF/0r00J4GlIAz0Kz
    Jteb1hnB7P9pTdRx3Pw0otzAPOKHFoVz7Q4zkqIO866EodqlriSvcve6SQwP8qy7xTbYGaOJnIahEQV+CB56j6crhwm6r2+x7hf+wgSZPp8ICD7REieuMUAu
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=2VYn-sL6AAAA:8 a=QyXUC8HyAAAA:8 a=8AirrxEcAAAA:8
    a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=yF3n4M5MxpLdt4XdI6IA:9 a=QEXdDO2ut3YA:10
    a=BgzNFtnbkgrEfe--4AkY:22 a=ST-jHhOKWsTCqRlWije3:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeDICYp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:24:45 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:47376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754392AbeDIA3Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit@wsystem.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 100/293] mmc: sdhci-esdhc-imx: Fix DAT line
 software reset
Thread-Topic: [PATCH AUTOSEL for 4.9 100/293] mmc: sdhci-esdhc-imx: Fix DAT
 line software reset
Thread-Index: AQHTz5kV6mHDP2iidkyQTrrHV4OuOg==
Date: Mon, 9 Apr 2018 00:24:11 +0000
Message-ID: <20180409002239.163177-100-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:5KnHcy6IXt9NLLa7Lz1Z0tei3Fi8EqYTNewvmbHD8jiV8O0TAKWwGn1NapnGkhtqXEW83ojilDDqrvsks/IVgtFDyvRfyKWPP0w1g2AJVE3S2KFugCoSVVeEYj8G3mPBngsedizULHSTgRafxMtuBvjybjG72YNnwz2QLDifY971z/O5hZ9Tqzw3NTX5TZprofcBtgfoAcb+fFXsbMofvhqEA7ctNDzNyy8gwdosJJj/RIo+iAZg7A6K3K/gV0Qc;20:kOv3S8xCT1fo3XmWaqNM9UbqoTjWZkBdiw2dRYGfqv/gbPTnsmRTxB+rlwU8CPK4lbfbGSbbYEzLsLLmywbvjhp+rXNw172Mp+khz1f8+1/07UiYTxLY5y6muY78JcUf7Q46biom/c4V4EMV+ANHenOzLse88aSarH+nxPJ3UCA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: efe23a0e-6a58-4abb-4b35-08d59db0f19c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09671A190E051FAEE03C636EFBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(575784001)(86362001)(14454004)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: P+lduob2eWdh2wl3wshSLcvhmYOn8nn4a4zVKq3qmFgR0RxG+eHp9iwOQS/CpJLJhT6fWV6OVZljO8lB54dFFhZ3xWEQI/3N04+f2SDfQPlfchil5N4O2GN1NOERMei6MPH4REAB/+hSGTIZ6uMgriZijJtlMa0uykk44PMMf8KijCK89lkWP87zR4kIvzAo1kipKzbsUmXdBNpR12HTL68gTL231M8ZlNVOUjm8ngRkpsOrP5Po2wQEKz3kQPF0JfghCLH9A0e3YbQJK+o3xIDhUSscGC4v8ekyebWEIguEOJWdYG0l6AD+MBk09uUeTlT8S2d0eSLJ5CAnHXSjXDMHxG3hMRCb52jX/rRjLZ6A6OpHC1Itkq0ZUFse7syd2Xutln+PC5suNOCaO9BFcX01OZReoP7DsLG8Ieuje1k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <568F1FF39DAC56448575B1998A3A6313@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe23a0e-6a58-4abb-4b35-08d59db0f19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:11.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQmVub8OudCBUaMOpYmF1ZGVhdSA8YmVub2l0QHdzeXN0ZW0uY29tPg0KDQpbIFVwc3Ry
ZWFtIGNvbW1pdCA4MWEwYThiYzM4MGQ4NDdmYzYyNjA1YzI3MDY3YjVjMWQwMjViZWEyIF0NCg0K
T24gaS5NWDI1LCB0aGUgZVNESEMgREFUIGxpbmUgc29mdHdhcmUgcmVzZXQgKFNZU0NUTC5SU1RE
KSB1bmV4cGVjdGVkbHkNCmNsZWFycyBhdCBsZWFzdCB0aGUgZGF0YSB0cmFuc2ZlciB3aWR0aCAo
UFJPQ1RMLkRUVyksIHdoaWNoIHRoZW4gcmVzdWx0cw0KaW4gZGF0YSBDUkMgZXJyb3JzLiBUaGlz
IGJlaGF2aW9yIGlzIG5vdCBkb2N1bWVudGVkLCBidXQgaXQgaGFzIGFjdHVhbGx5DQpiZWVuIG9i
c2VydmVkLiBDb25zZXF1ZW50bHksIHRoZSBEQVQgbGluZSBzb2Z0d2FyZSByZXNldHMgdHJpZ2dl
cmVkIGJ5DQpzZGhjaS5jIGluIGNhc2Ugb2YgZXJyb3JzIGNhdXNlZCB1bnJlY292ZXJhYmxlIGVy
cm9ycy4NCg0KRml4IHRoaXMgYnkgbWFraW5nIHN1cmUgdGhhdCB0aGUgREFUIGxpbmUgc29mdHdh
cmUgcmVzZXQgZG9lcyBub3QgYWx0ZXINCnRoZSBIb3N0IENvbnRyb2wgcmVnaXN0ZXIuIFRoaXMg
YmVoYXZpb3IgYmVpbmcgdW5kb2N1bWVudGVkLCBpdCBtYXkgYWxzbw0KYmUgcHJlc2VudCBvbiBv
dGhlciBpLk1YIFNvQ3MsIHNvIGFwcGx5IHRoaXMgZml4IGZvciB0aGUgd2hvbGUgaS5NWA0KZmFt
aWx5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBCZW5vw650IFRow6liYXVkZWF1IDxiZW5vaXRAd3N5c3Rl
bS5jb20+DQpBY2tlZC1ieTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
DQpSZXZpZXdlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPg0KU2ln
bmVkLW9mZi1ieTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQpTaWduZWQt
b2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0N
CiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgNTkgKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygr
KSwgMjEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LWVzZGhjLWlteC5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KaW5kZXgg
NDQ1ZmM0N2RjM2U3Li5mNTA4MmZhYjgyNmUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLWVzZGhjLWlteC5jDQorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlt
eC5jDQpAQCAtNTc5LDcgKzU3OSw3IEBAIHN0YXRpYyB2b2lkIGVzZGhjX3dyaXRlYl9sZShzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTggdmFsLCBpbnQgcmVnKQ0KIHsNCiAJc3RydWN0IHNkaGNp
X3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KIAlzdHJ1Y3QgcGx0
Zm1faW14X2RhdGEgKmlteF9kYXRhID0gc2RoY2lfcGx0Zm1fcHJpdihwbHRmbV9ob3N0KTsNCi0J
dTMyIG5ld192YWw7DQorCXUzMiBuZXdfdmFsID0gMDsNCiAJdTMyIG1hc2s7DQogDQogCXN3aXRj
aCAocmVnKSB7DQpAQCAtNjEwLDI5ICs2MTAsNDYgQEAgc3RhdGljIHZvaWQgZXNkaGNfd3JpdGVi
X2xlKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1OCB2YWwsIGludCByZWcpDQogDQogCQllc2Ro
Y19jbHJzZXRfbGUoaG9zdCwgbWFzaywgbmV3X3ZhbCwgcmVnKTsNCiAJCXJldHVybjsNCisJY2Fz
ZSBTREhDSV9TT0ZUV0FSRV9SRVNFVDoNCisJCWlmICh2YWwgJiBTREhDSV9SRVNFVF9EQVRBKQ0K
KwkJCW5ld192YWwgPSByZWFkbChob3N0LT5pb2FkZHIgKyBTREhDSV9IT1NUX0NPTlRST0wpOw0K
KwkJYnJlYWs7DQogCX0NCiAJZXNkaGNfY2xyc2V0X2xlKGhvc3QsIDB4ZmYsIHZhbCwgcmVnKTsN
CiANCi0JLyoNCi0JICogVGhlIGVzZGhjIGhhcyBhIGRlc2lnbiB2aW9sYXRpb24gdG8gU0RIQyBz
cGVjIHdoaWNoIHRlbGxzDQotCSAqIHRoYXQgc29mdHdhcmUgcmVzZXQgc2hvdWxkIG5vdCBhZmZl
Y3QgY2FyZCBkZXRlY3Rpb24gY2lyY3VpdC4NCi0JICogQnV0IGVzZGhjIGNsZWFycyBpdHMgU1lT
Q1RMIHJlZ2lzdGVyIGJpdHMgWzAuLjJdIGR1cmluZyB0aGUNCi0JICogc29mdHdhcmUgcmVzZXQu
ICBUaGlzIHdpbGwgc3RvcCB0aG9zZSBjbG9ja3MgdGhhdCBjYXJkIGRldGVjdGlvbg0KLQkgKiBj
aXJjdWl0IHJlbGllcyBvbi4gIFRvIHdvcmsgYXJvdW5kIGl0LCB3ZSB0dXJuIHRoZSBjbG9ja3Mg
b24gYmFjaw0KLQkgKiB0byBrZWVwIGNhcmQgZGV0ZWN0aW9uIGNpcmN1aXQgZnVuY3Rpb25hbC4N
Ci0JICovDQotCWlmICgocmVnID09IFNESENJX1NPRlRXQVJFX1JFU0VUKSAmJiAodmFsICYgMSkp
IHsNCi0JCWVzZGhjX2NscnNldF9sZShob3N0LCAweDcsIDB4NywgRVNESENfU1lTVEVNX0NPTlRS
T0wpOw0KLQkJLyoNCi0JCSAqIFRoZSByZXNldCBvbiB1c2RoYyBmYWlscyB0byBjbGVhciBNSVhf
Q1RSTCByZWdpc3Rlci4NCi0JCSAqIERvIGl0IG1hbnVhbGx5IGhlcmUuDQotCQkgKi8NCi0JCWlm
IChlc2RoY19pc191c2RoYyhpbXhfZGF0YSkpIHsNCi0JCQkvKiB0aGUgdHVuaW5nIGJpdHMgc2hv
dWxkIGJlIGtlcHQgZHVyaW5nIHJlc2V0ICovDQotCQkJbmV3X3ZhbCA9IHJlYWRsKGhvc3QtPmlv
YWRkciArIEVTREhDX01JWF9DVFJMKTsNCi0JCQl3cml0ZWwobmV3X3ZhbCAmIEVTREhDX01JWF9D
VFJMX1RVTklOR19NQVNLLA0KLQkJCQkJaG9zdC0+aW9hZGRyICsgRVNESENfTUlYX0NUUkwpOw0K
LQkJCWlteF9kYXRhLT5pc19kZHIgPSAwOw0KKwlpZiAocmVnID09IFNESENJX1NPRlRXQVJFX1JF
U0VUKSB7DQorCQlpZiAodmFsICYgU0RIQ0lfUkVTRVRfQUxMKSB7DQorCQkJLyoNCisJCQkgKiBU
aGUgZXNkaGMgaGFzIGEgZGVzaWduIHZpb2xhdGlvbiB0byBTREhDIHNwZWMgd2hpY2gNCisJCQkg
KiB0ZWxscyB0aGF0IHNvZnR3YXJlIHJlc2V0IHNob3VsZCBub3QgYWZmZWN0IGNhcmQNCisJCQkg
KiBkZXRlY3Rpb24gY2lyY3VpdC4gQnV0IGVzZGhjIGNsZWFycyBpdHMgU1lTQ1RMDQorCQkJICog
cmVnaXN0ZXIgYml0cyBbMC4uMl0gZHVyaW5nIHRoZSBzb2Z0d2FyZSByZXNldC4gVGhpcw0KKwkJ
CSAqIHdpbGwgc3RvcCB0aG9zZSBjbG9ja3MgdGhhdCBjYXJkIGRldGVjdGlvbiBjaXJjdWl0DQor
CQkJICogcmVsaWVzIG9uLiBUbyB3b3JrIGFyb3VuZCBpdCwgd2UgdHVybiB0aGUgY2xvY2tzIG9u
DQorCQkJICogYmFjayB0byBrZWVwIGNhcmQgZGV0ZWN0aW9uIGNpcmN1aXQgZnVuY3Rpb25hbC4N
CisJCQkgKi8NCisJCQllc2RoY19jbHJzZXRfbGUoaG9zdCwgMHg3LCAweDcsIEVTREhDX1NZU1RF
TV9DT05UUk9MKTsNCisJCQkvKg0KKwkJCSAqIFRoZSByZXNldCBvbiB1c2RoYyBmYWlscyB0byBj
bGVhciBNSVhfQ1RSTCByZWdpc3Rlci4NCisJCQkgKiBEbyBpdCBtYW51YWxseSBoZXJlLg0KKwkJ
CSAqLw0KKwkJCWlmIChlc2RoY19pc191c2RoYyhpbXhfZGF0YSkpIHsNCisJCQkJLyoNCisJCQkJ
ICogdGhlIHR1bmluZyBiaXRzIHNob3VsZCBiZSBrZXB0IGR1cmluZyByZXNldA0KKwkJCQkgKi8N
CisJCQkJbmV3X3ZhbCA9IHJlYWRsKGhvc3QtPmlvYWRkciArIEVTREhDX01JWF9DVFJMKTsNCisJ
CQkJd3JpdGVsKG5ld192YWwgJiBFU0RIQ19NSVhfQ1RSTF9UVU5JTkdfTUFTSywNCisJCQkJCQlo
b3N0LT5pb2FkZHIgKyBFU0RIQ19NSVhfQ1RSTCk7DQorCQkJCWlteF9kYXRhLT5pc19kZHIgPSAw
Ow0KKwkJCX0NCisJCX0gZWxzZSBpZiAodmFsICYgU0RIQ0lfUkVTRVRfREFUQSkgew0KKwkJCS8q
DQorCQkJICogVGhlIGVTREhDIERBVCBsaW5lIHNvZnR3YXJlIHJlc2V0IGNsZWFycyBhdCBsZWFz
dCB0aGUNCisJCQkgKiBkYXRhIHRyYW5zZmVyIHdpZHRoIG9uIGkuTVgyNSwgc28gbWFrZSBzdXJl
IHRoYXQgdGhlDQorCQkJICogSG9zdCBDb250cm9sIHJlZ2lzdGVyIGlzIHVuYWZmZWN0ZWQuDQor
CQkJICovDQorCQkJZXNkaGNfY2xyc2V0X2xlKGhvc3QsIDB4ZmYsIG5ld192YWwsDQorCQkJCQlT
REhDSV9IT1NUX0NPTlRST0wpOw0KIAkJfQ0KIAl9DQogfQ0KLS0gDQoyLjE1LjENCg==
