Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242580-2-911811934625663027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242579; b=EjwPePgGHLGk97eS+zq2BhU6EuM93O+NSlw//Bu8Sj5cluMpgD
    fPxERPocAPMAY4xH4DHkw5b9MKMlpQlVxworpERgfEdmBdTKEspqwx+gSzvN5yyL
    q2WbLJnovdVEv/UWiEEdyPN7+HI6ES6yylGmj4vbr9YxeMP2vdq+Y2VFS1XOiLYr
    /tRHJWJgUGvIkD5B9iHKpcSo5WNT89RFYvfJjMyZd/LeGxnttCr9o16BYbIEcX6h
    bxyD7i0ihg0hxq8s/DVEZgq1lKck1QcjXPAbidZwT60hPx/wkMloBbZ454fSuQm4
    N3nRc4nCxrxQmLaVnpx1xl8RRjJvEZ/TCNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523242579; bh=f7+i6X8+RDiLFmsXDaC9scSQJKFXnkdXBodMDjvmNxk=; b=
    NxiZ+BqbojGGMYEN/eML2appS3bjvZirk/1sNe7BYVHh6D0+PTpl1hs4Q0UJU5gp
    YWpPfatDME0NbKYGmp0Oo3hxBYS1tEpPohJWxaj5CYYAor1+WwH9zwmtefpbx0bU
    UuJ2whZs17AStSw+NgVqm5F5VV6cViGdME0vwUwoouUgFssl4d9lODFCVjINl74T
    JzvLGoLsONm5kgsCgcPNdgtBfEyWmCDo9ClRXfsqPcpccNMHwmL0PkpZ9r5Qbrrg
    UTvFYHqeh1XvGlHxeqvDZB4bRmoQEI6PQhfGqUJhb+5QkBhCS2L9K6c9F0RmDDSc
    GilrxH4K5VysOy29XLn/MQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q5qXizOU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q5qXizOU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI6HeY07Q+KaDXwqmg5hg24EZv4QfW4SYhQJPkk5N+/l3P9kZSjiROAncnZZHs3hwo9m3sFXrykwr8wQLEQ5ZTbs+vc+ehHFjBPNgJ9MvQHBjZiJZH6F
    AlwCQeUr7zSgaxh+d9w8tPQqdeWSwk6JJmeX3wiY9URKHu11wIJ80N8GFpS9tHi8JGLp5Ujqd/TCgXyUeQkA82LSeCAQCNVG1QTR/40of581o+13KyDK4RHU
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=pGLkceISAAAA:8 a=uTJJjIG0AAAA:8
    a=yMhMjlubAAAA:8 a=mJvvO5_NA61q33EmRIAA:9 a=QEXdDO2ut3YA:10
    a=kRpfLKi8w9umh8uBmg1i:22 a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbeDICzn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:55:43 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:42928
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754463AbeDIAZq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Hua Rui <huarui.dev@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 137/161] bcache: fix for allocator and
 register thread race
Thread-Topic: [PATCH AUTOSEL for 4.14 137/161] bcache: fix for allocator and
 register thread race
Thread-Index: AQHTz5i+ubfTOsPJuk60JEfT9gQl5g==
Date: Mon, 9 Apr 2018 00:21:45 +0000
Message-ID: <20180409001936.162706-137-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:8CILJRgmq3tnxBTbOeIaJdSeFw71F1FZIbcnanEURjRsMuwqVueegSch8jT/Kx7vhnXeN+mia3l48SBh1WBBnBnFjsIFPXmSUKNkIoYYUQ4DcY7zQLl33LvQzyhBqL5B4dIzrL16h+MEHfp0BJ9vMlJ9rYg8MV4opbugy4iDyIpgaOljYcnDg6igA7YQSRzZGJLJ35TKCmtwkhoxxHLQ1io3ywge/b7q/QLZkClm6EWxZA7u8Xze4CESqW9G0ImT;20:OzB7fqkXQUmMKkCCgGYlIC6RHiNLZTehrYgAuv+rO6kL/MziiAHYXPF072eXhJxhqw6kAupK3D56LNw1qcSPT4U3pEvlgwPkaMIBcWjE2KGBWWnOkOHchO7NGXR+eEIia0wHskN65BrXStQK15PTvcT3JrjoqbtKHQTK2aDHOJg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad64a4b3-11b8-44cc-6508-08d59db06cf8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725B3BEB0676092EA227CBCFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(39060400002)(6486002)(81166006)(26005)(6512007)(4326008)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: js8vOSJYB8XVsYVaRNlkR/snnrpUkx4HKrCKD37O9VwczH35VzneyQDC0vTa+hzeaTLELW3MOwi8Nlp1t913xRCS+r4j0b0dwON4llBUCSoPGw707U7kuCVFL0BCEbgDRPC9c92CqCM+KIsr4tjAdU4qhwrkP0VPVT74T32NpQgse8IDu3SjkFI/6bj/CUf7tEZFxOGEEKEiZkOhTkjmfhxLwAS/0G9ADst8dLu5OrL1dusgKILImGGr0KVZM+nGBgQNHwF82viyCNDAzn4xei83ZMJeIZdNOaaX8hx7wOVYD3+OKV7d5A+OAlRBszOE4lAP6OqH0jS0pUX7861lPWPGa36NMU5Nj3LiYjWiFfzP3O3CIw0ui0M2hNG0gJp7q3Ki1iqwBA5JJKu2KKKFeEMXsOUy0lFLfZvfOwP4ZOE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A7568F2D50F344EAEDB4FBF75E44E72@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad64a4b3-11b8-44cc-6508-08d59db06cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:45.4561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
aGUvYnRyZWUuYw0KaW5kZXggMTU5OGQxZTA0OTg5Li44OWQwODhjZjk1ZDkgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21kL2JjYWNoZS9idHJlZS5jDQorKysgYi9kcml2ZXJzL21kL2JjYWNoZS9idHJl
ZS5jDQpAQCAtMTg2OCwxNCArMTg2OCwxNyBAQCB2b2lkIGJjaF9pbml0aWFsX2djX2ZpbmlzaChz
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
ZXJzL21kL2JjYWNoZS9zdXBlci5jDQppbmRleCA5NDE3MTcwZjE4MGEuLmM4Y2JiNmNjMTQwNSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbWQvYmNhY2hlL3N1cGVyLmMNCisrKyBiL2RyaXZlcnMvbWQv
YmNhY2hlL3N1cGVyLmMNCkBAIC0xODIzLDYgKzE4MjMsNyBAQCB2b2lkIGJjaF9jYWNoZV9yZWxl
YXNlKHN0cnVjdCBrb2JqZWN0ICprb2JqKQ0KIHN0YXRpYyBpbnQgY2FjaGVfYWxsb2Moc3RydWN0
IGNhY2hlICpjYSkNCiB7DQogCXNpemVfdCBmcmVlOw0KKwlzaXplX3QgYnRyZWVfYnVja2V0czsN
CiAJc3RydWN0IGJ1Y2tldCAqYjsNCiANCiAJX19tb2R1bGVfZ2V0KFRISVNfTU9EVUxFKTsNCkBA
IC0xODMwLDkgKzE4MzEsMTkgQEAgc3RhdGljIGludCBjYWNoZV9hbGxvYyhzdHJ1Y3QgY2FjaGUg
KmNhKQ0KIA0KIAliaW9faW5pdCgmY2EtPmpvdXJuYWwuYmlvLCBjYS0+am91cm5hbC5iaW8uYmlf
aW5saW5lX3ZlY3MsIDgpOw0KIA0KKwkvKg0KKwkgKiB3aGVuIGNhLT5zYi5uam91cm5hbF9idWNr
ZXRzIGlzIG5vdCB6ZXJvLCBqb3VybmFsIGV4aXN0cywNCisJICogYW5kIGluIGJjaF9qb3VybmFs
X3JlcGxheSgpLCB0cmVlIG5vZGUgbWF5IHNwbGl0LA0KKwkgKiBzbyBidWNrZXQgb2YgUkVTRVJW
RV9CVFJFRSB0eXBlIGlzIG5lZWRlZCwNCisJICogdGhlIHdvcnN0IHNpdHVhdGlvbiBpcyBhbGwg
am91cm5hbCBidWNrZXRzIGFyZSB2YWxpZCBqb3VybmFsLA0KKwkgKiBhbmQgYWxsIHRoZSBrZXlz
IG5lZWQgdG8gcmVwbGF5LA0KKwkgKiBzbyB0aGUgbnVtYmVyIG9mICBSRVNFUlZFX0JUUkVFIHR5
cGUgYnVja2V0cyBzaG91bGQgYmUgYXMgbXVjaA0KKwkgKiBhcyBqb3VybmFsIGJ1Y2tldHMNCisJ
ICovDQorCWJ0cmVlX2J1Y2tldHMgPSBjYS0+c2IubmpvdXJuYWxfYnVja2V0cyA/OiA4Ow0KIAlm
cmVlID0gcm91bmR1cF9wb3dfb2ZfdHdvKGNhLT5zYi5uYnVja2V0cykgPj4gMTA7DQogDQotCWlm
ICghaW5pdF9maWZvKCZjYS0+ZnJlZVtSRVNFUlZFX0JUUkVFXSwgOCwgR0ZQX0tFUk5FTCkgfHwN
CisJaWYgKCFpbml0X2ZpZm8oJmNhLT5mcmVlW1JFU0VSVkVfQlRSRUVdLCBidHJlZV9idWNrZXRz
LCBHRlBfS0VSTkVMKSB8fA0KIAkgICAgIWluaXRfZmlmb19leGFjdCgmY2EtPmZyZWVbUkVTRVJW
RV9QUklPXSwgcHJpb19idWNrZXRzKGNhKSwgR0ZQX0tFUk5FTCkgfHwNCiAJICAgICFpbml0X2Zp
Zm8oJmNhLT5mcmVlW1JFU0VSVkVfTU9WSU5HR0NdLCBmcmVlLCBHRlBfS0VSTkVMKSB8fA0KIAkg
ICAgIWluaXRfZmlmbygmY2EtPmZyZWVbUkVTRVJWRV9OT05FXSwgZnJlZSwgR0ZQX0tFUk5FTCkg
fHwNCi0tIA0KMi4xNS4xDQo=
