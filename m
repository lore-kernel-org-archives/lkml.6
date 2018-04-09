Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241249-3-12054138992460716427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241248; b=nI4Vhh6tp2lRK0w9+DOB8px6YGO88RFUIV2toe/MItcZtm/51I
    hEZ0Rc1WDMG0SjrNrxFax/9HVFp1ednqGuF/igxPdQHZR1YxPwt7gcg49tbU/BbI
    8+d/TXM05tIvv5voJhHyTfYb/XzyVBI917Y7MuEnSmcuhQZUhUInWjR3GbwnhWvP
    ATyKA8i8pXqpHmWFKqetR4fcbk/80hz9G2u88cI1I1WN+qtYjDkDbSVt+QL8/1cj
    URXhbYrq+gPyQ/lrfRtm5vIqO34E0OYpD23IJipEaG/mILojUsB5AOiDSyaA2o8f
    +u8VVcKOXJOIZgy25GrhvJPmisWNxXQTsgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523241248; bh=4qPsg1b7HXx+vs8Zubt0TNAsf9ELpNdCWlkpG7ji5kk=; b=
    Zme1zIEDaYZOWn7CXAOCtfFKWZ3qFIP85TQf4GyVwn76BFkS5j3U+7S6DrYJdwRa
    Qiu4PiCeTN0AxWsdXlQMlHwmmHfAllOyV1qL95qgOjOoZqvUIsBAqkiA4HY3pYQj
    sVdSKnfmOiz1WZ7tWljEknI05JiQBpgjG8HswWRyJwdHHFSUVPZ/AthscZypczCG
    2N/fZAn8tUMWVbvtMHhIu+vcrKjrbf6zoduQWW9VhPdX0q866kxU7zEpx+ssJFUE
    SjU2RBJX18eqkt/HRErz91iysrQBO/DYDOpAh6VUd867CHNlPAkf6eIlp5nV9drd
    0sImkmdaGo3rQI1sZOfjjA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WU3x4Oy+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WU3x4Oy+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPWeNVcTPpNHwzyp9ZWORZbmLAt62DnvbJENr/2pvKvJ8xlGQ4CSR30t2RjSUTnHOK3O0QDvgFtTwgvV1lUfZr/ETkvNziAjLhpaYqzPc1tGj1K0yf42
    ijxT1jVsPdZ2D3Uo0X4UtFG05RncLKP9HPejwEz7wRL1Ude5Ntvu9tWox3g8tF8jef8m5hWgKAQhb+PRDFewak0X25AjKZ0rQJbTG+9L7AQlHT5pjqIDiTib
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=m0tBMhXdVeQUApxK_1UA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756199AbeDICdx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:33:53 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:15008
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755818AbeDIA2J (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jonas Gorski <jonas.gorski@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 062/293] leds: bcm6328: fix signal source
 assignment for leds 4 to 7
Thread-Topic: [PATCH AUTOSEL for 4.9 062/293] leds: bcm6328: fix signal source
 assignment for leds 4 to 7
Thread-Index: AQHTz5kCY8xA1aACSUmGG66PN/8xnQ==
Date: Mon, 9 Apr 2018 00:23:40 +0000
Message-ID: <20180409002239.163177-62-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:TqM/JUItu45m+E1HzC23AeCQ5zvstSpy5847kgWO2Nu75gKp2RcXXr+r/4cugKIGmoZ/W5yycGPIckDnM8zn0iH1eSnl9m9sUkg9P1yv5OTXGDYoOscvdoWjBVeQDxIO4Pwx6fVUjbgBtKK330Iu9eh/szCQ2KLiefwk2TEq5g36NugnYlj1GeTFeuaztXWRTgyrZSP0i4pDtAqsXA5cFOF+E+V1W5od7OlFxZwSsfqKGJRWUttMHYkmNw89ivII;20:S7k5pzogY7KqjxO1XGUlcx8S8dAn2vzOOkAJwfFqY7c1c2pjLaC96P8i/4Kg8qd1D5fUpEzC41bLOnawpgQeCcsWrEAz+I0tY6uDxJ6sUACI5eJHQLfiYGGIvOLLdrV60Ut5fdJ6RACWTCEnnUcCHq0dT/YZjcB97T60va05W8w=
X-MS-Office365-Filtering-Correlation-Id: 596fd314-9a80-4849-d451-08d59db0c3e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08712C454AF49440BE98E169FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(39060400002)(4326008)(86362001)(575784001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7jBxd9Xfz8b8Ny+e41bLQBzbFRRg8/mfjgfJPsfjAGN4IyC6QDmsZ2a7Iqtvyod7V8EMYEcaYlebSNrgFmc/LBrGfFy0ZrhYKurZKAFEikuOZnMVD7bigWiFNFrT1Zkx99Yok4dh1qAON3IdebzExQzya1VizqjJii/lLh9I1n7HiG58j8yzAoutX1pNw45UPm8VGUMF4wcnfpxWiVHM8E6Ey2PszZLE4+zmbAn4QLXWDjtrWf9ghSL2N6SgnbhKay+jKhNsOnRCH4Is+F6kWq+2R75yqNmEJ0mtVv5XHtXTzZimv8JduNuDBXW0R6utXtG9vgziIyS8kOVHfB2wROQmKGdg5vzT1hGVS7POaLV1og1jOGIWgoHcauZtu5LzbdCUQ48dZQ5uMGAqm34b79okmLmAoI8OvtkEYJVwjiA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <57D793498259124EA8B2C1F960517C93@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596fd314-9a80-4849-d451-08d59db0c3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:40.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSm9uYXMgR29yc2tpIDxqb25hcy5nb3Jza2lAZ21haWwuY29tPg0KDQpbIFVwc3RyZWFt
IGNvbW1pdCA0ZjAyYjUwZWNlMTFkY2Y3NTI2M2ZiN2E0Y2ZlOGE1ZGYxY2ZhYmVhIF0NCg0KRWFj
aCBuaWJibGUgcmVwcmVzZW50cyA0IExFRHMsIGFuZCBpbiBjYXNlIG9mIHRoZSBoaWdoZXIgcmVn
aXN0ZXIsIGJpdCAwDQpyZXByZXNlbnRzIExFRCA0LCBzbyB3ZSBuZWVkIHRvIHVzZSBtb2R1bHVz
IGZvciB0aGUgTEVEIG51bWJlciBhcyB3ZWxsLg0KDQpGaXhlczogZmQ3YjAyNWEyMzhkMGE1NDQw
YmZhMjZjNTg1ZWI3ODA5N2JmNDhkYyAoImxlZHM6IGFkZCBCQ002MzI4IExFRCBkcml2ZXIiKQ0K
U2lnbmVkLW9mZi1ieTogSm9uYXMgR29yc2tpIDxqb25hcy5nb3Jza2lAZ21haWwuY29tPg0KQWNr
ZWQtYnk6IMOBbHZhcm8gRmVybsOhbmRleiBSb2phcyA8bm9sdGFyaUBnbWFpbC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBKYWNlayBBbmFzemV3c2tpIDxqYWNlay5hbmFzemV3c2tpQGdtYWlsLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbGVkcy9sZWRzLWJjbTYzMjguYyB8IDQgKystLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2xlZHMvbGVkcy1iY202MzI4LmMgYi9kcml2ZXJzL2xlZHMvbGVkcy1iY202MzI4LmMN
CmluZGV4IDE1NDgyNTkyOTdjMS4uMmNmZDkzODllZTk2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9s
ZWRzL2xlZHMtYmNtNjMyOC5jDQorKysgYi9kcml2ZXJzL2xlZHMvbGVkcy1iY202MzI4LmMNCkBA
IC0yNDIsNyArMjQyLDcgQEAgc3RhdGljIGludCBiY202MzI4X2h3bGVkKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IGRldmljZV9ub2RlICpuYywgdTMyIHJlZywNCiANCiAJCXNwaW5fbG9ja19p
cnFzYXZlKGxvY2ssIGZsYWdzKTsNCiAJCXZhbCA9IGJjbTYzMjhfbGVkX3JlYWQoYWRkcik7DQot
CQl2YWwgfD0gKEJJVChyZWcpIDw8ICgoKHNlbCAlIDQpICogNCkgKyAxNikpOw0KKwkJdmFsIHw9
IChCSVQocmVnICUgNCkgPDwgKCgoc2VsICUgNCkgKiA0KSArIDE2KSk7DQogCQliY202MzI4X2xl
ZF93cml0ZShhZGRyLCB2YWwpOw0KIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZShsb2NrLCBmbGFn
cyk7DQogCX0NCkBAIC0yNjksNyArMjY5LDcgQEAgc3RhdGljIGludCBiY202MzI4X2h3bGVkKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9ub2RlICpuYywgdTMyIHJlZywNCiANCiAJ
CXNwaW5fbG9ja19pcnFzYXZlKGxvY2ssIGZsYWdzKTsNCiAJCXZhbCA9IGJjbTYzMjhfbGVkX3Jl
YWQoYWRkcik7DQotCQl2YWwgfD0gKEJJVChyZWcpIDw8ICgoc2VsICUgNCkgKiA0KSk7DQorCQl2
YWwgfD0gKEJJVChyZWcgJSA0KSA8PCAoKHNlbCAlIDQpICogNCkpOw0KIAkJYmNtNjMyOF9sZWRf
d3JpdGUoYWRkciwgdmFsKTsNCiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUobG9jaywgZmxhZ3Mp
Ow0KIAl9DQotLSANCjIuMTUuMQ0K
