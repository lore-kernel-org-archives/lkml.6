Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244871-2-14974925494030322100
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
    1523244871; b=Sei2SvwfRSCRD1IgynkvK/zcK6VEjs8ECrjYrkKVXH33Fds37F
    pd9yuIE0Z2EcuD3ahsYpU/9Q+9MlLc5PbP4QV5gV2LAHxaDLjE2VNOmGdLXW32bj
    +2G8q/reJr8iH6LmikgeSOgPOMt/zPqvg33kNcXUOIiJoCNWnp/dfl7VwHn5EEBB
    weaxOkVdB88rU0WOvmZjuRpjJWd9ah924mXV3QggburvXxtWkutcONFcUf255g0A
    /ToT2aLfh2+pxUpv5hAypyKSLJshYuvLQuSlRwQJu4sIYD9DKBjXxenC9ROCpeVI
    Ns3N9OHgS9TaKQf+TfmLC4PddTz4udEmO5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523244871; bh=DLnJkldkPTLuSSisbTqAmE90PECW5clR3/6MShNjVC4=; b=
    ADmv8HteuSkh5FMObxoZejzgFaZXiDpuFzrHGQ6CLEwyFT6Bt4p3NyF/qeDVeucP
    WFxLqQHoAwmDoNpkPoo9Uq2qgeLyULRgeoiK2xYaAYSERZQ396TRAUVEiJ4gfL7a
    hhgW+5fz8ZGRq5o0F8DS5Uk6+aDR4ol9/sMrRJCa4MxhJ6Y+eaKPPgcrz+ZZY9DV
    ek92FEaF6v+LwmX+7xt2srL1QarOIjjgG4y06kc11NC4RuqKvUYLzuR8ge43sVfh
    ITFm1VFzJQ+rL+fQqTOoI6bCVEYA9BBpqLA1LLMpEyO1qFLSX7OBXVA+H4QFu7o4
    nq7SnOzDiERU2YVwBRJ2kA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=deHkUAcR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=deHkUAcR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOzNjPGUQ4dp4unHs7N592trxIdIOsjROgD+EEjk+tm8HGKcUpjKd9452Wty19Y4rJQmnMjFvFx5RheTI3HcwFZ2N46q/yPcHWkhsiiPKTHco00k1HGb
    2aN9Ud89/CrTW7Beam12sr0F9II1noEKBxD8kcQ7EwIcu3EMNxsruV/xIsxN8zgoYdd08zQR1RTJtz/QZyPtYAkl/RLAkQ9CwugT/mzDMLJE9x3VlCSY0Qau
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=pGLkceISAAAA:8 a=uTJJjIG0AAAA:8
    a=yMhMjlubAAAA:8 a=mJvvO5_NA61q33EmRIAA:9 a=QEXdDO2ut3YA:10
    a=kRpfLKi8w9umh8uBmg1i:22 a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbeDIAVR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:17 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:12752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754384AbeDIAVK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Hua Rui <huarui.dev@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 161/189] bcache: fix for allocator and
 register thread race
Thread-Topic: [PATCH AUTOSEL for 4.15 161/189] bcache: fix for allocator and
 register thread race
Thread-Index: AQHTz5hZYYH8ZdzDbk+37Gk9Al7r4A==
Date: Mon, 9 Apr 2018 00:18:57 +0000
Message-ID: <20180409001637.162453-161-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:YIRKwx57HcWa5Cd8rdBSCrOmCvsAqb48eIs8vrnd4dmOMRO+ebZTcqDFHYj6nhd876S1iqTuyi8zGU1FuRnrtv+lXcySKTrMqLjnbkLyMWKdP/s56kHEOb8qzY9Mq7RoM0bW/cB6q7IDDVpZJ6xqXDl3nyMbDxpONEJINBrwlwPDkuw7U35DsE8VnjuPI73bstn0KzVSE5R/mD91oPHhh9sxfvco8+zoE0PVozNH7U/8qoe8LIeoVp4jKuFlg9Sd;20:MiTJPgE5EtHB/lzBuYtW6brxJS+LNwCKu5D9ur2xu2AQlHHuDw57K26qkWs3HQmJYtjXopn7QDgXscWONg9sCFIxRhADTOPD4ccHAWPY7rDC/3MpBhO5juZFrM73YtxaaAKh28Bf7/Y/But0Ch/2IiHbQgOpCXW1E1Iq78h9rXY=
X-MS-Office365-Filtering-Correlation-Id: 8899fa71-4ca6-4eb9-7d0e-08d59dafc878
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092007E194FE91BB22D05E10FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(39060400002)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dFtvTAGwV9BDOWaTBhxGaermHuwaHPSbs/H3SxlovFu5XbuEqkeR1xWDgeRtbeweYa5vGuA9jJSeA9qYEpt0PYnbN+qUehTogd6LAJOp/hovThYIlpZ15XN434OYN834BLw7dFkv8t6MH8gna3/HD/UpJq5QacfdK+6HpIrt1Ynpf6MJTUR889cIt30hwf2k4DN8uWlTrhcrj8zQPW5GM3hhrTEQJ60e2/mL+cOD86M7B6XLgZyEvu6xBtZkEF5dICnhuDllGSuvQz0aOOYxNaNojd8504tDezVdLCQFIaB0+w0/bjCCHQWbpgL8AjsRuDJYl6ji8/dYlG5hXg6YFubu88kIqnL06xfK+H4EJw/BRJWfofh72/ScYKu0a9gwX6pb1nJR1trDwu9RV2JJp/qAVCa1H4dhT5m21TK5YDY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A17A37825BB85D4F8AF2467E42DBC16A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8899fa71-4ca6-4eb9-7d0e-08d59dafc878
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:57.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
aGUvYnRyZWUuYw0KaW5kZXggODFlOGRjM2RiZTVlLi40NTU2MWYyOGU1OGEgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21kL2JjYWNoZS9idHJlZS5jDQorKysgYi9kcml2ZXJzL21kL2JjYWNoZS9idHJl
ZS5jDQpAQCAtMTg3MSwxNCArMTg3MSwxNyBAQCB2b2lkIGJjaF9pbml0aWFsX2djX2ZpbmlzaChz
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
ZXJzL21kL2JjYWNoZS9zdXBlci5jDQppbmRleCAxNGJkYWYxY2VmMmMuLmE3ZmNjNTFkNDRlOSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbWQvYmNhY2hlL3N1cGVyLmMNCisrKyBiL2RyaXZlcnMvbWQv
YmNhY2hlL3N1cGVyLmMNCkBAIC0xODMzLDYgKzE4MzMsNyBAQCB2b2lkIGJjaF9jYWNoZV9yZWxl
YXNlKHN0cnVjdCBrb2JqZWN0ICprb2JqKQ0KIHN0YXRpYyBpbnQgY2FjaGVfYWxsb2Moc3RydWN0
IGNhY2hlICpjYSkNCiB7DQogCXNpemVfdCBmcmVlOw0KKwlzaXplX3QgYnRyZWVfYnVja2V0czsN
CiAJc3RydWN0IGJ1Y2tldCAqYjsNCiANCiAJX19tb2R1bGVfZ2V0KFRISVNfTU9EVUxFKTsNCkBA
IC0xODQwLDkgKzE4NDEsMTkgQEAgc3RhdGljIGludCBjYWNoZV9hbGxvYyhzdHJ1Y3QgY2FjaGUg
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
