Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234925-5-12936629795791604642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234925; b=DZRTFzrNwCDkyTqkpjDJBriAfQ8B51Sd0POfM98BkC9vU2/lnA
    lnd0+Rhai/hWR+7lVT7aFLOe3KTzvpEoMN69MawQQrIV2jvBq1basbVRAtK5sKZ/
    a9wkrxk4wD0oF6yvuglvssJlcoC+SUTDX1cDylLv60Teq/ce4ONgYCnggoKobuhr
    qhDFgXjRlKiSH8oKHtRGlZcnym3cs3qkkwYnDpwCuJaoZa3ghAlMrJQBJQADhH1n
    /4DrqjnlhQ5tY19hZb4SBre2+g8fJ6iOqJAT56lYQnDyF9hKsymXbDRfxW08fQWC
    dcQpkjpQocIkf0IthAR3zUJmbZEKn0mQK81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523234925; bh=wI0DUnIXrjy/ZEizONRDke04mRf/7s7fxUkYMQuf6qU=; b=
    KTnVk3jaEI7BzPdVR68I+eNRPAiwWB7lss9Cfx6DE+XPVynpFFUsuoQC4mYc3ovZ
    Pf6hVs+PnEKxJUNm+1DuAplRTznAcgPNKk2NTTgzvXv+WhzvllkM6mFLO2n00fm5
    l+RDFo8uspYjkaKIsQVP23eR615aMXRIoQJLotVvZKGu10HPNLAm/IMwKppPDB/c
    4jt368Er7OhM/Et6MVky+DcLrq3i5g5/7qG5zrB3qYm11LCNe+86VH7zpw3JiGA8
    6bERFcptsynoQ0y2/S88l+Nc7UxTJRfDdnCpta4OgQjjtQnDsPZlzAJuDmVAHqwT
    T52a+zuYhtEr5sPIlz25ng==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WatXwdXc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WatXwdXc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLqiPOSEST4fwXE9AxuFrSxHP8WMA4Op2AhoDuIvO0MN46894CKAdMMCbbPbDicb5g++1ZaYIuECr71bDxJ4I61IRabIq/QNxVHXbGU39CLDpQocOPN1
    fwTcD6ZHmykVuALVo4IbUgSVT9mxNfnYLEHLsie8RYVosaVwkrvh58523wNbstmEhYEMRp22CCCPAu1Gi40l+JqsT6dTys/IlKRHZsOdc4+V2BDdmuSs/w7T
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=f5JUautJF78rpD-wVU0A:9
    a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757097AbeDIAsn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:48:43 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:14462
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756345AbeDIAli (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 072/101] watchdog: sp5100_tco: Fix watchdog
 disable bit
Thread-Topic: [PATCH AUTOSEL for 3.18 072/101] watchdog: sp5100_tco: Fix
 watchdog disable bit
Thread-Index: AQHTz5uBO9F0FGkKmUudPzfbPuEdTA==
Date: Mon, 9 Apr 2018 00:41:33 +0000
Message-ID: <20180409004042.164920-22-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:Qdq8JVhHF1D0DT7f9XW2ODqa+Eznk1MhAQuKppDoN3fSoogtnbK8jj7y4UsNCYvPMaHSis+p3ZJ3zH4Ft6lYbEVUvVcUrfgGgBRN5WII1vk+pfcSq25pL67Od2l0J8LzAzGcuONkxL10njolq7mXRiACvyy9QImMF3HYhMtjQJl+M7GaF+vu6jZApQVfqEkpTecAh69AVbMZXVRV/hd2jieLIVTfe9LOKuUBKx8wdV51Wtk4n4NtnA+UlK61F9df;20:jej3nHHtwluPj+XmbD183TNMCaa9TSAoH3hHMEdKCIxzrOg/mVDrjCwuxdaI/yKG6xd2bY4Gb3A9y3hY/ajavVnsxE8ZyRfWP+EYQ2zQqWq9tR2d3bS79dzNXqhPulIl3SrboVmw/8NJ0c76mHWpGcgx+0jp8MCGjl/k9u5M8Tk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: beabcfe5-1e2a-4185-b414-08d59db2a49e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09015C6A8CC7EFFD899D7998FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(575784001)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qQV6pvcbCvy8CHlGbbLIwNJ/m6pqS+o4nYqKkAB5MRCNwAe6DzkLvS5H5l78vX5rl49tuyzyfdk0TluGObUzv96GAbHPzJQi8VGsp5VJ3AhkM5bsDmySsMtSN+kQ1ykvIl0MsYQ4bUKhPtIbDZhik5JC3BLc3bSu7qEsnuXglS1Fxu/sL8rx51s9ZDLufvOKFBjWaF0c98vooKbbhLKJIE1KUx74qTX45Olp03IGVZDksPimgk4S7IYRh0K95KAV6QfVQBnyrjqhAn9IIrZLyXo2uAJNDJhmcsEjasudzRfoFovq4gOBCHZp4cSgOaXbiI5+rb32HCjf3xjQ8Hh4cCFeRH+uVGM0PlyPsdp1fkoyL/3NEThiOIB8dnLVJCq4NhDcjJVtT+fmDjFjdUVk0/siH8saN3q3doeNy4MCPUc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <37EB837FF5E69D42AACE10686698E30E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beabcfe5-1e2a-4185-b414-08d59db2a49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:33.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCBmNTQxYzA5ZWJmYzYxNjk3YjU4NmIzOGM5ZWJhZjRiNzBkZWZiMjc4IF0NCg0KQWNjb3Jk
aW5nIHRvIGFsbCBwdWJsaXNoZWQgaW5mb3JtYXRpb24sIHRoZSB3YXRjaGRvZyBkaXNhYmxlIGJp
dCBmb3IgU0I4MDANCmNvbXBhdGlibGUgY29udHJvbGxlcnMgaXMgYml0IDEgb2YgUE0gcmVnaXN0
ZXIgMHg0OCwgbm90IGJpdCAyLiBGb3IgdGhlDQptb3N0IHBhcnQgdGhhdCBkb2Vzbid0IG1hdHRl
ciBpbiBwcmFjdGljZSwgc2luY2UgdGhlIGJpdCBoYXMgdG8gYmUgY2xlYXJlZA0KdG8gZW5hYmxl
IHdhdGNoZG9nIGFkZHJlc3MgZGVjb2RpbmcsIHdoaWNoIGlzIHRoZSBkZWZhdWx0IHNldHRpbmcs
IGJ1dCBpdA0Kc3RpbGwgbmVlZHMgdG8gYmUgZml4ZWQuDQoNCkNjOiBab2x0w6FuIELDtnN6w7Zy
bcOpbnlpIDx6Ym9zem9yQHByLmh1Pg0KU2lnbmVkLW9mZi1ieTogR3VlbnRlciBSb2VjayA8bGlu
dXhAcm9lY2stdXMubmV0Pg0KU2lnbmVkLW9mZi1ieTogV2ltIFZhbiBTZWJyb2VjayA8d2ltQGln
dWFuYS5iZT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWlj
cm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvd2F0Y2hkb2cvc3A1MTAwX3Rjby5oIHwgMiArLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy93YXRjaGRvZy9zcDUxMDBfdGNvLmggYi9kcml2ZXJzL3dhdGNoZG9nL3Nw
NTEwMF90Y28uaA0KaW5kZXggMmIyOGMwMGRhMGRmLi5kZmUyMGI4MWNlZDUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3dhdGNoZG9nL3NwNTEwMF90Y28uaA0KKysrIGIvZHJpdmVycy93YXRjaGRvZy9z
cDUxMDBfdGNvLmgNCkBAIC01NCw3ICs1NCw3IEBADQogI2RlZmluZSBTQjgwMF9QTV9XQVRDSERP
R19DT05GSUcJMHg0Qw0KIA0KICNkZWZpbmUgU0I4MDBfUENJX1dBVENIRE9HX0RFQ09ERV9FTgko
MSA8PCAwKQ0KLSNkZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAyKQ0KKyNk
ZWZpbmUgU0I4MDBfUE1fV0FUQ0hET0dfRElTQUJMRQkoMSA8PCAxKQ0KICNkZWZpbmUgU0I4MDBf
UE1fV0FUQ0hET0dfU0VDT05EX1JFUwkoMyA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlP
X0RFQ09ERV9FTgkoMSA8PCAwKQ0KICNkZWZpbmUgU0I4MDBfQUNQSV9NTUlPX1NFTAkJKDEgPDwg
MSkNCi0tIA0KMi4xNS4xDQo=
