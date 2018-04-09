Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234649-2-5962373243768491030
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623, URIBL_SBL_A 0.1, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234649; b=HBFswU92OFNf571Ze94WE4KEh1TWn5CpLftwP0gO18E2VU8NjH
    YbV7RJPcw8+EWMuKKrLy3m+6R7cjWz4V+ZN9vt3zxwOuwGTkfZ6+xvfiZ12pHdZz
    6cL41sY1Lm2LBfvCzbO/4DZCgRhNxFUJgAT/AVTCzBmFna/iCD07EaDO1anVZWAg
    SsegxkhiRqzpoe2I2RnLGAft3xpz3Jl/toKiHRVIAF9KysMZpW7qF6m5K36dkd54
    v7d3fpwounDR5iMY00vlrhOF0WEl9XPR78z4AcFr15GV3UWS59QbaxcwwHVWerfA
    m049JB4SnUhwIAaFkXb09RXLxO0/mF/BefkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523234649; bh=6w2Vbfm5wEmeiDbSn5b5orj0E0rfkilkZtoPl49PAEU=; b=
    FYPGl5rdeOyyij8pSnPWUytJH1iFrn5yeZP15oFO0xBb/uHqi+SPxgiJbEHOOGSS
    KTi/DUs3hRNNnI0ndfnJyxuf7q2fYs+8XdYyn8tZnFiYecyWzAUoW6DMDUhXvcvP
    jjs/LCh3rYgatQBrhpirB92hvR105Jl7z+gNSq0x7745KNezTGmj7/JmTF3eBPrS
    2/QE6bPhy0WaxIkKHUmmuIz0GOFOj4oqGh3eAed+qEm3S0oU3gADkxLiXxXJbhgd
    Xa8CYoVKUJJLe43KXMBk88gGJqCR1tfiZUglwSJYzONRsYk1PK20bK8k8jbX1kci
    llASFf+5V48r9gBYGjPwEA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ip9PRjZu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ip9PRjZu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEgWjf6K4RzTciopmg4EVwE09BJG55JTyqsyaKw07r0aV9GZojPS4skCxiDqnXyZdVIx0MsF+sztk640GMrwyjybKdowICg1Emc4SdADkz4Pqr4NstAV
    4xJ/tjkweCWI2xzkZjCLqpLDSmgWhCO11JMkkgGPkKwpkfNjGlC/J5OM4BAO2UMnw12gauQo2LBZ6gSdccy17TgL8pqcBxRJ8O9sjH5ub3HiKEMo5VivQPdl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=pGLkceISAAAA:8 a=uTJJjIG0AAAA:8
    a=yMhMjlubAAAA:8 a=mJvvO5_NA61q33EmRIAA:9 a=QEXdDO2ut3YA:10
    a=kRpfLKi8w9umh8uBmg1i:22 a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756843AbeDIAoF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:44:05 -0400
Received: from mail-sn1nam02on0120.outbound.protection.outlook.com ([104.47.36.120]:45955
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756786AbeDIAme (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Hua Rui <huarui.dev@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 097/101] bcache: fix for allocator and
 register thread race
Thread-Topic: [PATCH AUTOSEL for 3.18 097/101] bcache: fix for allocator and
 register thread race
Thread-Index: AQHTz5uN9M2laAp6tEytVNFZ3Wr/iA==
Date: Mon, 9 Apr 2018 00:41:53 +0000
Message-ID: <20180409004042.164920-47-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:e+1C8uVLT8SkXpuVfu93fUoWitfUolS3FOa0tPKHqbaixXQhHwNc/U5f1LpALuuJ7nQPV7E3t91M28GNN502Nu4C42IHMtaBAW1bdEifV6I0yIXotD2T0HHo0rD0JtjSbisBMauPnpjiCdsD20oqxDoJsB4cWMGxUPRcs7b5WXmF9xPCEnL8IBSPXwUCT4ipzkyomxfk3QKgKWpteVgRU5nXt5lxF+CrHYs0v9O4YYNOpsxwkpbshGG6DoFTlaPx;20:+lUi5inUtLkbeQ/gyEo1z9wTgqFjzShaDstmSOLwDH6vKPTb/sPFjT7FiOeK0qoynvtffAmCpzqmBcGE+i+odGU0fZHLkNzui/nADDRQWXS654mAZZaXN3mzaGN5uKXSjsZOb5+Jo5mIrdze6uItVtJwI709gqWhjgDw4lxglBU=
X-MS-Office365-Filtering-Correlation-Id: 8b591c90-a7e0-4499-8fbb-08d59db2c484
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10300911DC2405237B3A651EFBBF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(39860400002)(376002)(189003)(199004)(7736002)(5250100002)(53936002)(66066001)(97736004)(99286004)(6506007)(68736007)(186003)(26005)(22452003)(86362001)(11346002)(6486002)(486006)(305945005)(59450400001)(316002)(3280700002)(110136005)(76176011)(476003)(102836004)(6666003)(446003)(3660700001)(5660300001)(2616005)(8936002)(8676002)(6512007)(81156014)(81166006)(2906002)(36756003)(6436002)(14454004)(86612001)(10090500001)(54906003)(39060400002)(2501003)(105586002)(25786009)(4326008)(478600001)(10290500003)(1076002)(3846002)(72206003)(6116002)(106356001)(107886003)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: IWsxH9jZULFXy4YXFxjRLQr6tC0aaWQDqVLxJV8Ulbfc+W8Dmb2/wVnlCYNENro8WCZGqfJ++gbGlnockAmjHyqcXJ5aMgrhA2TRuZSZiR40gz+JENHwv+q+bL752V4nsK9dPqVw2qIGeiWwwrtaphykiudGL+RV16aPFomnXF0wIDP6CZEkMMDUKpWiQJULdDvoWu00TMfO9fKvNTTU0AhaetDh12cUkMddA6LWzeNkyTGhP3cI4i+UrRdSoPwFhaU6NG1+vDQXaGt/Kog4+ZJgZvCzTV0zbD6U44K4O+z5OW81Z8D5uTogWalwu1nckmylaZiuvloqM9SoNQDWmS+U0tub+JOdWRoT1hldf4+dUWucTiAUhqnQcJ9fi/qcD79+IV+vkztBfZtkqG5Wp1py7Z5Y8oy1EiFvYCZ25A0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C67296026D56A842A54CB8968A0D8CB2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b591c90-a7e0-4499-8fbb-08d59db2c484
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:53.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVGFuZyBKdW5odWkgPHRhbmcuanVuaHVpQHp0ZS5jb20uY24+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IDY4MjgxMWIzY2UxYTVhNGUyMGQ3MDA5MzlhOTA0MmYwMWRiYzY2YzQgXQ0KDQpBZnRl
ciBsb25nIHRpbWUgcnVubmluZyBvZiByYW5kb20gc21hbGwgSU8gd3JpdGluZywNCkkgcmVib290
IHRoZSBtYWNoaW5lLCBhbmQgYWZ0ZXIgdGhlIG1hY2hpbmUgcG93ZXIgb24sDQpJIGZvdW5kIGJj
YWNoZSBnb3Qgc3R1Y2ssIHRoZSBzdGFjayBpczoNCltyb290QGNlcGgxNTMgfl0jIGNhdCAvcHJv
Yy8yNTEwL3Rhc2svKi9zdGFjaw0KWzxmZmZmZmZmZmEwNmIyNDU1Pl0gY2xvc3VyZV9zeW5jKzB4
MjUvMHg5MCBbYmNhY2hlXQ0KWzxmZmZmZmZmZmEwNmI2YmU4Pl0gYmNoX2pvdXJuYWwrMHgxMTgv
MHgyYjAgW2JjYWNoZV0NCls8ZmZmZmZmZmZhMDZiNmRjNz5dIGJjaF9qb3VybmFsX21ldGErMHg0
Ny8weDcwIFtiY2FjaGVdDQpbPGZmZmZmZmZmYTA2YmU4Zjc+XSBiY2hfcHJpb193cml0ZSsweDIz
Ny8weDM0MCBbYmNhY2hlXQ0KWzxmZmZmZmZmZmEwNmE4MDE4Pl0gYmNoX2FsbG9jYXRvcl90aHJl
YWQrMHgzYzgvMHgzZDAgW2JjYWNoZV0NCls8ZmZmZmZmZmY4MTBhNjMxZj5dIGt0aHJlYWQrMHhj
Zi8weGUwDQpbPGZmZmZmZmZmODE2NGMzMTg+XSByZXRfZnJvbV9mb3JrKzB4NTgvMHg5MA0KWzxm
ZmZmZmZmZmZmZmZmZmZmPl0gMHhmZmZmZmZmZmZmZmZmZmZmDQpbcm9vdEBjZXBoMTUzIH5dIyBj
YXQgL3Byb2MvMjAzOC90YXNrLyovc3RhY2sNCls8ZmZmZmZmZmZhMDZiMWFiZD5dIF9fYmNoX2J0
cmVlX21hcF9ub2RlcysweDEyZC8weDE1MCBbYmNhY2hlXQ0KWzxmZmZmZmZmZmEwNmIxYmQxPl0g
YmNoX2J0cmVlX2luc2VydCsweGYxLzB4MTcwIFtiY2FjaGVdDQpbPGZmZmZmZmZmYTA2YjYzN2Y+
XSBiY2hfam91cm5hbF9yZXBsYXkrMHgxM2YvMHgyMzAgW2JjYWNoZV0NCls8ZmZmZmZmZmZhMDZj
NzVmZT5dIHJ1bl9jYWNoZV9zZXQrMHg3OWEvMHg3YzIgW2JjYWNoZV0NCls8ZmZmZmZmZmZhMDZj
MGNmOD5dIHJlZ2lzdGVyX2JjYWNoZSsweGQ0OC8weDEzMTAgW2JjYWNoZV0NCls8ZmZmZmZmZmY4
MTJmNzAyZj5dIGtvYmpfYXR0cl9zdG9yZSsweGYvMHgyMA0KWzxmZmZmZmZmZjgxMjViMjE2Pl0g
c3lzZnNfd3JpdGVfZmlsZSsweGM2LzB4MTQwDQpbPGZmZmZmZmZmODExZGZiZmQ+XSB2ZnNfd3Jp
dGUrMHhiZC8weDFlMA0KWzxmZmZmZmZmZjgxMWUwNjlmPl0gU3lTX3dyaXRlKzB4N2YvMHhlMA0K
WzxmZmZmZmZmZjgxNjRjM2M5Pl0gc3lzdGVtX2NhbGxfZmFzdHBhdGgrMHgxNi8weDENClRoZSBz
dGFjayBzaG93cyB0aGUgcmVnaXN0ZXIgdGhyZWFkIGFuZCBhbGxvY2F0b3IgdGhyZWFkDQp3ZXJl
IGdldHRpbmcgc3R1Y2sgd2hlbiByZWdpc3RlcmluZyBjYWNoZSBkZXZpY2UuDQoNCkkgcmVib290
IHRoZSBtYWNoaW5lIHNldmVyYWwgdGltZXMsIHRoZSBpc3N1ZSBhbHdheXMNCmV4c2l0IGluIHRo
aXMgbWFjaGluZS4NCg0KSSBkZWJ1ZyB0aGUgY29kZSwgYW5kIGZvdW5kIHRoZSBjYWxsIHRyYWNl
IGFzIGJlbGxvdzoNCnJlZ2lzdGVyX2JjYWNoZSgpDQogICA9PT5ydW5fY2FjaGVfc2V0KCkNCiAg
ICAgID09PmJjaF9qb3VybmFsX3JlcGxheSgpDQogICAgICAgICA9PT5iY2hfYnRyZWVfaW5zZXJ0
KCkNCiAgICAgICAgICAgID09Pl9fYmNoX2J0cmVlX21hcF9ub2RlcygpDQogICAgICAgICAgICAg
ICA9PT5idHJlZV9pbnNlcnRfZm4oKQ0KICAgICAgICAgICAgICAgICAgPT0+YnRyZWVfc3BsaXQo
KSAvL25vZGUgbmVlZCBzcGxpdA0KICAgICAgICAgICAgICAgICAgICAgPT0+YnRyZWVfY2hlY2tf
cmVzZXJ2ZSgpDQpJbiBidHJlZV9jaGVja19yZXNlcnZlKCksIEl0IHdpbGwgY2hlY2sgaWYgdGhl
cmUgaXMgZW5vdWdoIGJ1Y2tldHMNCm9mIFJFU0VSVkVfQlRSRUUgdHlwZSwgc2luY2UgYWxsb2Nh
dG9yIHRocmVhZCBkaWQgbm90IHdvcmsgeWV0LCBzbw0Kbm8gYnVja2V0cyBvZiBSRVNFUlZFX0JU
UkVFIHR5cGUgYWxsb2NhdGVkLCBzbyB0aGUgcmVnaXN0ZXIgdGhyZWFkDQp3YWl0cyBvbiBjLT5i
dHJlZV9jYWNoZV93YWl0LCBhbmQgZ29lcyB0byBzbGVlcC4NCg0KVGhlbiB0aGUgYWxsb2NhdG9y
IHRocmVhZCBpbml0aWFsaXplZCwgdGhlIGNhbGwgdHJhY2UgaXMgYmVsbG93Og0KYmNoX2FsbG9j
YXRvcl90aHJlYWQoKQ0KPT0+YmNoX3ByaW9fd3JpdGUoKQ0KICAgPT0+YmNoX2pvdXJuYWxfbWV0
YSgpDQogICAgICA9PT5iY2hfam91cm5hbCgpDQogICAgICAgICA9PT5qb3VybmFsX3dhaXRfZm9y
X3dyaXRlKCkNCkluIGpvdXJuYWxfd2FpdF9mb3Jfd3JpdGUoKSwgSXQgd2lsbCBjaGVjayBpZiBq
b3VybmFsIGlzIGZ1bGwgYnkNCmpvdXJuYWxfZnVsbCgpLCBidXQgdGhlIGxvbmcgdGltZSByYW5k
b20gc21hbGwgSU8gd3JpdGluZw0KY2F1c2VzIHRoZSBleGhhdXN0aW9uIG9mIGpvdXJuYWwgYnVj
a2V0cyhqb3VybmFsLmJsb2Nrc19mcmVlPTApLA0KSW4gb3JkZXIgdG8gcmVsZWFzZSB0aGUgam91
cm5hbCBidWNrZXRzLA0KdGhlIGFsbG9jYXRvciBjYWxscyBidHJlZV9mbHVzaF93cml0ZSgpIHRv
IGZsdXNoIGtleXMgdG8NCmJ0cmVlIG5vZGVzLCBhbmQgd2FpdHMgb24gYy0+am91cm5hbC53YWl0
IHVudGlsIGJ0cmVlIG5vZGVzIHdyaXRpbmcNCm92ZXIgb3IgdGhlcmUgaGFzIGFscmVhZHkgc29t
ZSBqb3VybmFsIGJ1Y2tldHMgc3BhY2UsIHRoZW4gdGhlDQphbGxvY2F0b3IgdGhyZWFkIGdvZXMg
dG8gc2xlZXAuIGJ1dCBpbiBidHJlZV9mbHVzaF93cml0ZSgpLCBzaW5jZQ0KYmNoX2pvdXJuYWxf
cmVwbGF5KCkgaXMgbm90IGZpbmlzaGVkLCBzbyBubyBidHJlZSBub2RlcyBoYXZlIGpvdXJuYWwN
Cihjb25kaXRpb24gImlmIChidHJlZV9jdXJyZW50X3dyaXRlKGIpLT5qb3VybmFsKSIgbmV2ZXIg
c2F0aXNmaWVkKSwNCnNvIHdlIGdvdCBubyBidHJlZSBub2RlIHRvIGZsdXNoLCBubyBqb3VybmFs
IGJ1Y2tldCByZWxlYXNlZCwNCmFuZCBhbGxvY2F0b3Igc2xlZXAgYWxsIHRoZSB0aW1lcy4NCg0K
VGhyb3VnaCB0aGUgYWJvdmUgYW5hbHlzaXMsIHdlIGNhbiBzZWUgdGhhdDoNCjEpIFJlZ2lzdGVy
IHRocmVhZCB3YWl0IGZvciBhbGxvY2F0b3IgdGhyZWFkIHRvIGFsbG9jYXRlIGJ1Y2tldHMgb2YN
CiAgIFJFU0VSVkVfQlRSRUUgdHlwZTsNCjIpIEFsbG9jdG9yIHRocmVhZCB3YWl0IGZvciByZWdp
c3RlciB0aHJlYWQgdG8gcmVwbGF5IGpvdXJuYWwsIHNvIGl0DQogICBjYW4gZmx1c2ggYnRyZWUg
bm9kZXMgYW5kIGdldCBqb3VybmFsIGJ1Y2tldC4NCiAgIHRoZW4gdGhleSBhcmUgYWxsIGdvdCBz
dHVjayBieSB3YWl0aW5nIGZvciBlYWNoIG90aGVyLg0KDQpIdWEgUnVpIHByb3ZpZGVkIGEgcGF0
Y2ggZm9yIG1lLCBieSBhbGxvY2F0aW5nIHNvbWUgYnVja2V0cyBvZg0KUkVTRVJWRV9CVFJFRSB0
eXBlIGluIGFkdmFuY2UsIHNvIHRoZSByZWdpc3RlciB0aHJlYWQgY2FuIGdldCBidWNrZXQNCndo
ZW4gYnRyZWUgbm9kZSBzcGxpdHRpbmcgYW5kIG5vIG5lZWQgdG8gd2FpdGluZyBmb3IgdGhlIGFs
bG9jYXRvcg0KdGhyZWFkLiBJIHRlc3RlZCBpdCwgaXQgaGFzIGVmZmVjdCwgYW5kIHJlZ2lzdGVy
IHRocmVhZCBydW4gYSBzdGVwDQpmb3J3YXJkLCBidXQgZmluYWxseSBhcmUgc3RpbGwgZ290IHN0
dWNrLCB0aGUgcmVhc29uIGlzIG9ubHkgOCBidWNrZXQNCm9mIFJFU0VSVkVfQlRSRUUgdHlwZSB3
ZXJlIGFsbG9jYXRlZCwgYW5kIGluIGJjaF9qb3VybmFsX3JlcGxheSgpLA0KYWZ0ZXIgMiBidHJl
ZSBub2RlcyBzcGxpdHRpbmcsIG9ubHkgNCBidWNrZXQgb2YgUkVTRVJWRV9CVFJFRSB0eXBlIGxl
ZnQsDQp0aGVuIGJ0cmVlX2NoZWNrX3Jlc2VydmUoKSBpcyBub3Qgc2F0aXNmaWVkIGFueW1vcmUs
IHNvIGl0IGdvZXMgdG8gc2xlZXANCmFnYWluLCBhbmQgaW4gdGhlIHNhbWUgdGltZSwgYWxsb2N0
b3IgdGhyZWFkIGRpZCBub3QgZmx1c2ggZW5vdWdoIGJ0cmVlDQpub2RlcyB0byByZWxlYXNlIGEg
am91cm5hbCBidWNrZXQsIHNvIHRoZXkgYWxsIGdvdCBzdHVjayBhZ2Fpbi4NCg0KU28gd2UgbmVl
ZCB0byBhbGxvY2F0ZSBtb3JlIGJ1Y2tldHMgb2YgUkVTRVJWRV9CVFJFRSB0eXBlIGluIGFkdmFu
Y2UsDQpidXQgaG93IG11Y2ggaXMgZW5vdWdoPyAgQnkgZXhwZXJpZW5jZSBhbmQgdGVzdCwgSSB0
aGluayBpdCBzaG91bGQgYmUNCmFzIG11Y2ggYXMgam91cm5hbCBidWNrZXRzLiBUaGVuIEkgbW9k
aWZ5IHRoZSBjb2RlIGFzIHRoaXMgcGF0Y2gsDQphbmQgdGVzdCBpbiB0aGUgbWFjaGluZSwgYW5k
IGl0IHdvcmtzLg0KDQpUaGlzIHBhdGNoIG1vZGlmaWVkIGJhc2Ugb24gSHVhIFJ1aeKAmXMgcGF0
Y2gsIGFuZCBhbGxvY2F0ZSBtb3JlIGJ1Y2tldHMNCm9mIFJFU0VSVkVfQlRSRUUgdHlwZSBpbiBh
ZHZhbmNlIHRvIGF2b2lkIHJlZ2lzdGVyIHRocmVhZCBhbmQgYWxsb2NhdGUNCnRocmVhZCBnb2lu
ZyB0byB3YWl0IGZvciBlYWNoIG90aGVyLg0KDQpbcGF0Y2ggdjJdIGNhLT5zYi5uam91cm5hbF9i
dWNrZXRzIHdvdWxkIGJlIDAgaW4gdGhlIGZpcnN0IHRpbWUgYWZ0ZXINCmNhY2hlIGNyZWF0aW9u
LCBhbmQgbm8gam91cm5hbCBleGlzdHMsIHNvIGp1c3QgOCBidHJlZSBidWNrZXRzIGlzIE9LLg0K
DQpTaWduZWQtb2ZmLWJ5OiBIdWEgUnVpIDxodWFydWkuZGV2QGdtYWlsLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IFRhbmcgSnVuaHVpIDx0YW5nLmp1bmh1aUB6dGUuY29tLmNuPg0KUmV2aWV3ZWQtYnk6
IE1pY2hhZWwgTHlsZSA8bWx5bGVAbHlsZS5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVy
LmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL21kL2JjYWNoZS9idHJlZS5jIHwg
IDkgKysrKysrLS0tDQogZHJpdmVycy9tZC9iY2FjaGUvc3VwZXIuYyB8IDEzICsrKysrKysrKysr
Ky0NCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2JjYWNoZS9idHJlZS5jIGIvZHJpdmVycy9tZC9iY2Fj
aGUvYnRyZWUuYw0KaW5kZXggZTUzY2U1ZTJhMjhhLi41YThjNDAxN2JlNjYgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21kL2JjYWNoZS9idHJlZS5jDQorKysgYi9kcml2ZXJzL21kL2JjYWNoZS9idHJl
ZS5jDQpAQCAtMTg2OSwxNCArMTg2OSwxNyBAQCB2b2lkIGJjaF9pbml0aWFsX2djX2ZpbmlzaChz
dHJ1Y3QgY2FjaGVfc2V0ICpjKQ0KIAkgKi8NCiAJZm9yX2VhY2hfY2FjaGUoY2EsIGMsIGkpIHsN
CiAJCWZvcl9lYWNoX2J1Y2tldChiLCBjYSkgew0KLQkJCWlmIChmaWZvX2Z1bGwoJmNhLT5mcmVl
W1JFU0VSVkVfUFJJT10pKQ0KKwkJCWlmIChmaWZvX2Z1bGwoJmNhLT5mcmVlW1JFU0VSVkVfUFJJ
T10pICYmDQorCQkJICAgIGZpZm9fZnVsbCgmY2EtPmZyZWVbUkVTRVJWRV9CVFJFRV0pKQ0KIAkJ
CQlicmVhazsNCiANCiAJCQlpZiAoYmNoX2Nhbl9pbnZhbGlkYXRlX2J1Y2tldChjYSwgYikgJiYN
CiAJCQkgICAgIUdDX01BUksoYikpIHsNCiAJCQkJX19iY2hfaW52YWxpZGF0ZV9vbmVfYnVja2V0
KGNhLCBiKTsNCi0JCQkJZmlmb19wdXNoKCZjYS0+ZnJlZVtSRVNFUlZFX1BSSU9dLA0KLQkJCQkJ
ICBiIC0gY2EtPmJ1Y2tldHMpOw0KKwkJCQlpZiAoIWZpZm9fcHVzaCgmY2EtPmZyZWVbUkVTRVJW
RV9QUklPXSwNCisJCQkJICAgYiAtIGNhLT5idWNrZXRzKSkNCisJCQkJCWZpZm9fcHVzaCgmY2Et
PmZyZWVbUkVTRVJWRV9CVFJFRV0sDQorCQkJCQkJICBiIC0gY2EtPmJ1Y2tldHMpOw0KIAkJCX0N
CiAJCX0NCiAJfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvYmNhY2hlL3N1cGVyLmMgYi9kcml2
ZXJzL21kL2JjYWNoZS9zdXBlci5jDQppbmRleCA5YzU2Y2Y3MTRiMjIuLmJjZTEyMzhhN2QxMCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbWQvYmNhY2hlL3N1cGVyLmMNCisrKyBiL2RyaXZlcnMvbWQv
YmNhY2hlL3N1cGVyLmMNCkBAIC0xODQyLDYgKzE4NDIsNyBAQCB2b2lkIGJjaF9jYWNoZV9yZWxl
YXNlKHN0cnVjdCBrb2JqZWN0ICprb2JqKQ0KIHN0YXRpYyBpbnQgY2FjaGVfYWxsb2Moc3RydWN0
IGNhY2hlX3NiICpzYiwgc3RydWN0IGNhY2hlICpjYSkNCiB7DQogCXNpemVfdCBmcmVlOw0KKwlz
aXplX3QgYnRyZWVfYnVja2V0czsNCiAJc3RydWN0IGJ1Y2tldCAqYjsNCiANCiAJX19tb2R1bGVf
Z2V0KFRISVNfTU9EVUxFKTsNCkBAIC0xODUxLDkgKzE4NTIsMTkgQEAgc3RhdGljIGludCBjYWNo
ZV9hbGxvYyhzdHJ1Y3QgY2FjaGVfc2IgKnNiLCBzdHJ1Y3QgY2FjaGUgKmNhKQ0KIAljYS0+am91
cm5hbC5iaW8uYmlfbWF4X3ZlY3MgPSA4Ow0KIAljYS0+am91cm5hbC5iaW8uYmlfaW9fdmVjID0g
Y2EtPmpvdXJuYWwuYmlvLmJpX2lubGluZV92ZWNzOw0KIA0KKwkvKg0KKwkgKiB3aGVuIGNhLT5z
Yi5uam91cm5hbF9idWNrZXRzIGlzIG5vdCB6ZXJvLCBqb3VybmFsIGV4aXN0cywNCisJICogYW5k
IGluIGJjaF9qb3VybmFsX3JlcGxheSgpLCB0cmVlIG5vZGUgbWF5IHNwbGl0LA0KKwkgKiBzbyBi
dWNrZXQgb2YgUkVTRVJWRV9CVFJFRSB0eXBlIGlzIG5lZWRlZCwNCisJICogdGhlIHdvcnN0IHNp
dHVhdGlvbiBpcyBhbGwgam91cm5hbCBidWNrZXRzIGFyZSB2YWxpZCBqb3VybmFsLA0KKwkgKiBh
bmQgYWxsIHRoZSBrZXlzIG5lZWQgdG8gcmVwbGF5LA0KKwkgKiBzbyB0aGUgbnVtYmVyIG9mICBS
RVNFUlZFX0JUUkVFIHR5cGUgYnVja2V0cyBzaG91bGQgYmUgYXMgbXVjaA0KKwkgKiBhcyBqb3Vy
bmFsIGJ1Y2tldHMNCisJICovDQorCWJ0cmVlX2J1Y2tldHMgPSBjYS0+c2IubmpvdXJuYWxfYnVj
a2V0cyA/OiA4Ow0KIAlmcmVlID0gcm91bmR1cF9wb3dfb2ZfdHdvKGNhLT5zYi5uYnVja2V0cykg
Pj4gMTA7DQogDQotCWlmICghaW5pdF9maWZvKCZjYS0+ZnJlZVtSRVNFUlZFX0JUUkVFXSwgOCwg
R0ZQX0tFUk5FTCkgfHwNCisJaWYgKCFpbml0X2ZpZm8oJmNhLT5mcmVlW1JFU0VSVkVfQlRSRUVd
LCBidHJlZV9idWNrZXRzLCBHRlBfS0VSTkVMKSB8fA0KIAkgICAgIWluaXRfZmlmb19leGFjdCgm
Y2EtPmZyZWVbUkVTRVJWRV9QUklPXSwgcHJpb19idWNrZXRzKGNhKSwgR0ZQX0tFUk5FTCkgfHwN
CiAJICAgICFpbml0X2ZpZm8oJmNhLT5mcmVlW1JFU0VSVkVfTU9WSU5HR0NdLCBmcmVlLCBHRlBf
S0VSTkVMKSB8fA0KIAkgICAgIWluaXRfZmlmbygmY2EtPmZyZWVbUkVTRVJWRV9OT05FXSwgZnJl
ZSwgR0ZQX0tFUk5FTCkgfHwNCi0tIA0KMi4xNS4xDQo=
