Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237608-2-705446962661287792
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
    1523237608; b=ADMrOUMtDpHTDNJHLht82xUKouVKvZdtI8gzF5C/4qW+UQeAEe
    YSMiUYJNKHjQd1BGZgdeh+lC5kpreMh/LlYKAFlcLdRxbH91a9XkLgpPjeG0BKyg
    oMuo8zQbvd6i9OU0HNcOLjj2BjSTE0rZa5X0+ScBsg8VqWR7JuoFeIRc3H2bTVuJ
    amfm3DdRvkv7NSusYUD5rIlN0dBW/cZ2MfBC9ctdTowcNrN2g8qtMbv3xvZlOK1g
    MruPsiWfVlbwof0a3UZp0eUVlkuL5rVn1H52jn7OC5OTNwYX3WwuuD3Unw7u+OVr
    m/jMQcJcGOaDEz9GlvQB0LhN59fRXB7ib/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523237608; bh=GVNh3dqWelT7rKNnUw3PlszI8rXrnv4ZBkykfy/TEUE=; b=
    YfdhtGR/PZSxCXp92z9Ml+wSklewUBpXwRTlXnYEmej60H6V9gj+p5vO1EuAp2Tp
    CMb/ROXq1Umud/yDESeA+YJ8JAyjbopMTte/9Y1PD8KhhCQFBf3QjBauGpQlbF1T
    gphRAep01YioW4f7hR0xbcUe+/4QxtC/1nWDDx2mNuDr2ugP1qKumrlvYV/SNGG/
    j8GmWxBEtL7gzrl3YaHKYKESvsnpkUy/dEvJxGz47gAgbA8kxcz/PYSJC/0ktTex
    ag2OMbPVDdsMM0jjua8fex0D8QXhQ6CwSlf5LigVDomigT0h77mAgE97rlFSDqYC
    t6C352J8ukOHPP3E3Xa13Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JlKx7Tzu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JlKx7Tzu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPh/SfpWfzNqUwFAz5PgvlKUKJRUSBkqNmOaO/x0+dzyR0Z81CeHvMeKqSCsC3FKibTmg77TwI261QTZ89FI2o0LB2GChZThRV3VzMZpst9NLAxJb603
    5TqtzGlmh9I9pKw/aO0cmYyy7xwOAr2VVYQEs75KScyOW9VM4yxo9PtfTA3kfXd+foTvhoxantEAZQtC9EkPKWGtNLmNvLtuQd4YYOMslqyRNcS4Jbg4k7uq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=m0tBMhXdVeQUApxK_1UA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756139AbeDIBd1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:33:27 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:45331
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755964AbeDIAfo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jonas Gorski <jonas.gorski@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 032/162] leds: bcm6328: fix signal source
 assignment for leds 4 to 7
Thread-Topic: [PATCH AUTOSEL for 4.4 032/162] leds: bcm6328: fix signal source
 assignment for leds 4 to 7
Thread-Index: AQHTz5mgW5zPixPYr0CX/UEXFVP74g==
Date: Mon, 9 Apr 2018 00:28:05 +0000
Message-ID: <20180409002738.163941-32-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:CpaCjDB+4Uw6wbYaocA8eATi2vhq7jNELwsir39uLBFf7KQJs5rgKvry+gXY5E+JN2HezwMjC45vpUbVwldFvyxLPtVcSebu59/fxdnhyWX9GwAZfly6KavGDumMOJKfatL+W23YKP10a3lrd9kSN2IUAWVhRLO4tFu3vosO8Z7QiLtY1OxrmVmGF4qqQyS2di6zwPkb7xuWRN5QfC5Tpne7y6LgzbcnhhuOBs/iq99n0zVuv1CSpU92WPeE5ydA;20:hKp5YdIHvizwiG5JKHxJDZTqu2MZS74GqxyZPDjqwsUfEtJ20hlRyacSR+NIwy2v3ZUB6dI/MmSeTffF4+joGEYbVfoyDsFYz/P14xLTtnwkYHWFWKX8cBYnLhKloR2rMWSrZ8PcCn3BNcK4L/05LTXdFDwGGcNdHUFhorJHjnk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b058365d-2070-403c-90cb-08d59db1d3b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07250FC595118C6DBF1FF3F1FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(39060400002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mmP9oPuiU3AXfq7OUAwJvSUV2giXJNmC9QHzv10WHUBt4wHXcwt0usYwOMNElcijaOnXqWwN2r4v6tPWRQncRjESnu8lMnXAAdYR53SU2wtSL9K6If09TQjIhetaCtGYKXOGWVIAu5joH5sqEkXqu1IylQ0AHQxv5WHW/gn7MVNRD3PE++/Vk6gDPfQx870nK4MfIMmnZsu4w5I0bVaSeB1wWmyVoMBFCEPDygnverWovVo/QbOcrIa0rgYTn4PQY+j4oXr0/uVOHdtbmFlVnYfnXKrtavOdU9ZS65urpHi9jUcYmbIeWUPiUippgtGydR1WmSLbqSoTsxH/vnsaQTFZQOYS+DXoR28i01A2I6lTwT5aXZlofH78seNxKpXeblZROmAVpFjGrg83lUMWDF81gDNj7OhM6Phf4wH9H2M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA47AAB8C2AE63489E1299F6E09E9ABA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b058365d-2070-403c-90cb-08d59db1d3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:05.7080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
CmluZGV4IGM3ZWE1YzYyNjMzMS4uODMzY2NkMTY3ZDQ0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9s
ZWRzL2xlZHMtYmNtNjMyOC5jDQorKysgYi9kcml2ZXJzL2xlZHMvbGVkcy1iY202MzI4LmMNCkBA
IC0yMjQsNyArMjI0LDcgQEAgc3RhdGljIGludCBiY202MzI4X2h3bGVkKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IGRldmljZV9ub2RlICpuYywgdTMyIHJlZywNCiANCiAJCXNwaW5fbG9ja19p
cnFzYXZlKGxvY2ssIGZsYWdzKTsNCiAJCXZhbCA9IGJjbTYzMjhfbGVkX3JlYWQoYWRkcik7DQot
CQl2YWwgfD0gKEJJVChyZWcpIDw8ICgoKHNlbCAlIDQpICogNCkgKyAxNikpOw0KKwkJdmFsIHw9
IChCSVQocmVnICUgNCkgPDwgKCgoc2VsICUgNCkgKiA0KSArIDE2KSk7DQogCQliY202MzI4X2xl
ZF93cml0ZShhZGRyLCB2YWwpOw0KIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZShsb2NrLCBmbGFn
cyk7DQogCX0NCkBAIC0yNTEsNyArMjUxLDcgQEAgc3RhdGljIGludCBiY202MzI4X2h3bGVkKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9ub2RlICpuYywgdTMyIHJlZywNCiANCiAJ
CXNwaW5fbG9ja19pcnFzYXZlKGxvY2ssIGZsYWdzKTsNCiAJCXZhbCA9IGJjbTYzMjhfbGVkX3Jl
YWQoYWRkcik7DQotCQl2YWwgfD0gKEJJVChyZWcpIDw8ICgoc2VsICUgNCkgKiA0KSk7DQorCQl2
YWwgfD0gKEJJVChyZWcgJSA0KSA8PCAoKHNlbCAlIDQpICogNCkpOw0KIAkJYmNtNjMyOF9sZWRf
d3JpdGUoYWRkciwgdmFsKTsNCiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUobG9jaywgZmxhZ3Mp
Ow0KIAl9DQotLSANCjIuMTUuMQ0K
