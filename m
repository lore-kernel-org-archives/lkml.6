Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680896-2-3708837473830920373
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680896; b=VQUZs2a2GPmklpkbrUucq51aGwqoITYIf9Em11t013CuwW4
    h7xPQ4rGEZhA6Uv+M+hTOV+UMudarWTidFipd3dHYCX+daiHyZrt5oITsFhHMRPk
    QcJ07+aYLIFQhz1nnyjVpO//SsCuXsUsSjMqC+KaQuxAkWV2evKJ0NSu61NriwLp
    OWT9Gk8mIpDK/bOYQs7UdOSrSYZuC2WLTuhlNKvHx/3JkUY0SlydrnPE0yhQ9lqw
    SG7IRIZXEB1H4JbMXfNIyNU6O5J7i75AkmPgmII9tue4jcRfgOw2j77SEnowxHpz
    K3FWEtjBYRlvJ74D9smq0yDNQpj+eEuPDUn0qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517680896; bh=IN958spyhdE3hG3Le8QQh9YFg2+djIAlQfgvnz
    ZhtJQ=; b=G9RxhQHqgQqKFg7fIT78l1J4KrbNmPZG8LHflL46HLSz6NIKXOkXH9
    BphU1cGhPPehdF6pPz7x7Qs4KXLjIcfpa36HV6a+B1HL0xgPwovZeOC+KlrMoVEV
    fC4eETQFvWpSd8rNw3QVpaKMiwnEDXYUVmuEKYHu6oJ5GURcnMOugKZ0emQyDYxF
    4XjGgQf2rX3PAsin8SAuYwyfshRD/fUZueP4dF5fSPMAapju/VqKXFuuD+MaCJby
    uoOL5giNM1BFgAeuXBIJE6W/0EJSBh3+FHMNBDVihJ7iS0fN3nfR4UQ93xO1f6LB
    xehM7FlwOkiGTEC4I9f5Tnb0DJ4Kjf1Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CwYKicqw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CwYKicqw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeBCSBb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:01:31 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:24890
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752788AbeBCSAv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniele Palmas <dnlplm@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 012/110] net: usb: qmi_wwan: add Telit ME910
 PID 0x1101 support
Thread-Topic: [PATCH AUTOSEL for 4.14 012/110] net: usb: qmi_wwan: add Telit
 ME910 PID 0x1101 support
Thread-Index: AQHTnRji24l7n8JPEka+N3fV8+Yf9g==
Date: Sat, 3 Feb 2018 18:00:32 +0000
Message-ID: <20180203180015.29073-12-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:sLnGHgTgqwfIo+hZ9IJXUU6jpY6BogPq8w0NaFFZ5HpXBpGaOV/biKM8mk5tcb/C5X0VifcNggWLZAq/0cF6F6Dmo3n7tYEqwsl1eIg4AKwcj1bnDW9wF9tr8c5ERNJkWRmsfl2EugoJ14VI+CIspl1znQCdb9JVzfbmeu6iNa0BeNxUAlRd/RkMQtygJLt87HERJdCf3eRHGYmcNYUnCSHIhW79339aPyDaHFmtlhyx3PGW9oJsWsgMhDauDOgg
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90c5aba5-f30a-4808-e5c5-08d56b300618
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043951A2326FCFD97460100FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(39060400002)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: wT1PY6wVXvgmHNimbf26tLw7E4ZGykIcSv962kPYC+7/ovk6n/lOH0u/aEEK8DSY2CENMUPVeuOmGh06wATj+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <30951B7FB05C16459D569149F3F4F992@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c5aba5-f30a-4808-e5c5-08d56b300618
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:32.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogRGFuaWVsZSBQYWxtYXMgPGRubHBsbUBnbWFpbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IGM2NDdjMGQ2MmM4MmViM2RkZjc4YTBkOGIzZDU4ODE5ZDlmNTUyYWEgXQ0KDQpUaGlzIHBh
dGNoIGFkZHMgc3VwcG9ydCBmb3IgVGVsaXQgTUU5MTAgUElEIDB4MTEwMS4NCg0KU2lnbmVkLW9m
Zi1ieTogRGFuaWVsZSBQYWxtYXMgPGRubHBsbUBnbWFpbC5jb20+DQpBY2tlZC1ieTogQmrDuHJu
IE1vcmsgPGJqb3JuQG1vcmsubm8+DQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVy
LmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL25ldC91c2IvcW1pX3d3YW4uYyB8
IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdXNiL3FtaV93d2FuLmMgYi9kcml2ZXJzL25ldC91c2IvcW1pX3d3YW4uYw0KaW5k
ZXggMjA5MmZlYmZjYjQyLi4zYzU5NGRhZTMzZTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC91
c2IvcW1pX3d3YW4uYw0KKysrIGIvZHJpdmVycy9uZXQvdXNiL3FtaV93d2FuLmMNCkBAIC0xMjEx
LDYgKzEyMTEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgcHJvZHVjdHNb
XSA9IHsNCiAJe1FNSV9GSVhFRF9JTlRGKDB4MjM1NywgMHg5MDAwLCA0KX0sCS8qIFRQLUxJTksg
TUEyNjAgKi8NCiAJe1FNSV9RVUlSS19TRVRfRFRSKDB4MWJjNywgMHgxMDQwLCAyKX0sCS8qIFRl
bGl0IExFOTIyQSAqLw0KIAl7UU1JX0ZJWEVEX0lOVEYoMHgxYmM3LCAweDExMDAsIDMpfSwJLyog
VGVsaXQgTUU5MTAgKi8NCisJe1FNSV9GSVhFRF9JTlRGKDB4MWJjNywgMHgxMTAxLCAzKX0sCS8q
IFRlbGl0IE1FOTEwIGR1YWwgbW9kZW0gKi8NCiAJe1FNSV9GSVhFRF9JTlRGKDB4MWJjNywgMHgx
MjAwLCA1KX0sCS8qIFRlbGl0IExFOTIwICovDQogCXtRTUlfUVVJUktfU0VUX0RUUigweDFiYzcs
IDB4MTIwMSwgMil9LAkvKiBUZWxpdCBMRTkyMCwgTEU5MjBBNCAqLw0KIAl7UU1JX0ZJWEVEX0lO
VEYoMHgxYzllLCAweDk4MDEsIDMpfSwJLyogVGVsZXdlbGwgVFctM0cgSFNQQSsgKi8NCi0tIA0K
Mi4xMS4wDQo=
