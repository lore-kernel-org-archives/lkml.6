Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520489071-2-13201312038496366805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489070; b=mcSdZ4Tm6as31zHs9E1cymkoaymeYk6tsKZ/Gn0qSmnxE9f
    8kefDhI+MrPMz5gjjzr0xKiz+KfdxuEM5mwY2/vmZGHO64ai9ZHJ1A7+0fHLVSAP
    tGMR0HLUgArEmEGcmuAf57KVSI2qB15zwuPBlKIfv4NuvVY9PKf51x8wv1aYT2Bj
    iioNgwTTTjyrB7EY58EhRU00+xkVzIMY1QInSkXOp0XXlYv8GcQuIxLnUsaLNpLg
    Gmeq1CSbtq40RbFXM3EGsAnkBKs9i5/i168t7P5BYj6VD3KqAihVyRUWSBf/Z/12
    ZZ5eWc2I3xPsD3QRqFmlSns1z08yjtcBAZXupVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520489070; bh=AfNx6r/58u05gIb/kGS7quMPWOaYnwbvp6phJH
    76DzA=; b=rW2sZCeFPqC/r9tby8e1jdAcuupwQYf25rUP/HRhgyxsbqYV+9Coy/
    Iho0KhFO+h6qQY9m5hnOsLApfAsjiAsP7mDitu2V+jup+vGuppU85zL7QddtvGW5
    U4YyryjxvYkXYHc22MhDMqi5Ps6/UdzcfMMD16L17SPQf0x0SoWiYBQUSAxam+sR
    vGqg/EMRa/QXw3fyWw+uT46hhjMUFuuiX/c5u8wBhLcKELuYVrtSgohyQQQBdFtE
    gX1tgBY9AG9BV3iYmizyYNMPDV70NpJfdLZH6pPESrhR3VxagYOO/TDA3gxwg0m1
    /iALHdbdj+Pgz0H+skr6s8Gl+19v/GFg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YH9vQj5Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YH9vQj5Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935444AbeCHGD7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:03:59 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965830AbeCHFCZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chunming Zhou <David1.Zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 117/190] drm/amdgpu: fix gpu reset crash
Thread-Topic: [PATCH AUTOSEL for 4.9 117/190] drm/amdgpu: fix gpu reset crash
Thread-Index: AQHTtppFqoGwygnr7UCi+I4dgT558w==
Date: Thu, 8 Mar 2018 04:59:43 +0000
Message-ID: <20180308045810.8041-117-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:9SspPxIGvC/EclD7lBo47a25j2oFWi0r5tgAGXd/nDidJMSMaqkW3Ec0yMNWJmnSJGWLLnOlEAWzPcjQlYsPVtAGNcfBFttIRFWpqkX0y1jWLxPoV1AWPSSKGxABgnnuBWzgqsW/L/UWVpTw+pJxIjI4n8NCPGqVo3HUtU/gtABQHK7XWycJjbWUEAl5RFztfbgHFiBZdXj8y9NyDeKKj9Y80EhLzSyA/h3cEscEIAPI6bt5woxqhlZV8YWWLuIu;20:ABVT2gi6FkjOE6wnLwHbSzB/xK3iNm6c3eMJ2FpUnDE2H810cykB9pblFRl1xkQgEGuuSjuT1STl285irXeEylqgCtQJPABanxlcSuzM8jjX4LTmIw9EnkAxsp6kpuYeoyK6FUjif5xZOfb9DU5Az//hTRCb9ZnvWQyDDG3G2IE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9baff3b3-830a-4f84-5cef-08d584b1c4c8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10636E88F769CECEB506869BFBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(39860400002)(366004)(199004)(189003)(51234002)(107886003)(3660700001)(105586002)(81166006)(14454004)(6666003)(72206003)(22452003)(2950100002)(478600001)(97736004)(5660300001)(86612001)(6506007)(305945005)(8936002)(7736002)(316002)(66066001)(10090500001)(8676002)(53936002)(81156014)(6436002)(110136005)(3280700002)(102836004)(25786009)(2501003)(26005)(54906003)(5250100002)(99286004)(8666007)(36756003)(6512007)(2900100001)(186003)(68736007)(1076002)(106356001)(4326008)(10290500003)(86362001)(2906002)(6486002)(76176011)(6116002)(3846002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: UHPgPp3s8ve39hDDISKhl/9aKwSBWXgLdOCmF6ocOidM+DvJmrLcvczcMasq2WujJnrMBP/8kSBlXHny5VBqqC0awViX6oTLAr0uGhSM5hfDGUmOXW2xGgvQjkqPJmm7+lzGBcdxIvksBSdzwPkQ2qQ/XdWLrixhsYqUEINYtV+uYa+WfphGSdGXewvUAUx2XOuBV+3bqu+yjG28yZE4OL5zzViqUSgsSJMAMEm/R63pvgxcc7s90GgQ69v5Oo7vGwcQae8gbPIlg9vGmyqzkbRiZ88Iz1gyNmzmylWMHGUyKDqgiU19bTzN4tb3ieCLay53436Mep+pYLNLiAQG2A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <96703607BE24FE439219FE957DD7D25C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baff3b3-830a-4f84-5cef-08d584b1c4c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:43.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4NCg0KWyBVcHN0cmVhbSBj
b21taXQgNTE2ODc3NTliZTkzZmJjNTUzZjI3MjdlODZiZTI1YzM4MTI2YmE5MyBdDQoNClsgIDQx
My42ODc0MzldIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVm
ZXJlbmNlIGF0IDAwMDAwMDAwMDAwMDA1NDgNClsgIDQxMy42ODc0NzldIElQOiBbPGZmZmZmZmZm
ODEwOWIxNzU+XSB0b19saXZlX2t0aHJlYWQrMHg1LzB4NjANClsgIDQxMy42ODc1MDddIFBHRCAx
ZWZkMTIwNjcNClsgIDQxMy42ODc1MTldIFBVRCAxZWZkMTEwNjcNClsgIDQxMy42ODc1MzFdIFBN
RCAwDQoNClsgIDQxMy42ODc1NDNdIE9vcHM6IDAwMDAgWyMxXSBTTVANClsgIDQxMy42ODc1NTdd
IE1vZHVsZXMgbGlua2VkIGluOiBhbWRncHUoT0UpIHR0bShPRSkgZHJtX2ttc19oZWxwZXIoRSkg
ZHJtKEUpIGkyY19hbGdvX2JpdChFKSBmYl9zeXNfZm9wcyhFKSBzeXNjb3B5YXJlYShFKSBzeXNm
aWxscmVjdChFKSBzeXNpbWdibHQoRSkgcnBjc2VjX2dzc19rcmI1KEUpIG5mc3Y0KEUpIG5mcyhF
KSBmc2NhY2hlKEUpIHNuZF9oZGFfY29kZWNfcmVhbHRlayhFKSBzbmRfaGRhX2NvZGVjX2dlbmVy
aWMoRSkgc25kX2hkYV9jb2RlY19oZG1pKEUpIHNuZF9oZGFfaW50ZWwoRSkgZWVlcGNfd21pKEUp
IHNuZF9oZGFfY29kZWMoRSkgYXN1c193bWkoRSkgc25kX2hkYV9jb3JlKEUpIHNwYXJzZV9rZXlt
YXAoRSkgc25kX2h3ZGVwKEUpIHZpZGVvKEUpIHNuZF9wY20oRSkgc25kX3NlcV9taWRpKEUpIGpv
eWRldihFKSBzbmRfc2VxX21pZGlfZXZlbnQoRSkgc25kX3Jhd21pZGkoRSkgc25kX3NlcShFKSBz
bmRfc2VxX2RldmljZShFKSBzbmRfdGltZXIoRSkga3ZtKEUpIGlycWJ5cGFzcyhFKSBjcmN0MTBk
aWZfcGNsbXVsKEUpIHNuZChFKSBjcmMzMl9wY2xtdWwoRSkgZ2hhc2hfY2xtdWxuaV9pbnRlbChF
KSBzb3VuZGNvcmUoRSkgYWVzbmlfaW50ZWwoRSkgYWVzX3g4Nl82NChFKSBscncoRSkgZ2YxMjht
dWwoRSkgZ2x1ZV9oZWxwZXIoRSkgYWJsa19oZWxwZXIoRSkgY3J5cHRkKEUpIHNocGNocChFKSBz
ZXJpb19yYXcoRSkgaTJjX3BpaXg0KEUpIDgyNTBfZHcoRSkgaTJjX2Rlc2lnbndhcmVfcGxhdGZv
cm0oRSkgaTJjX2Rlc2lnbndhcmVfY29yZShFKSBtYWNfaGlkKEUpIGJpbmZtdF9taXNjKEUpDQpb
ICA0MTMuNjg3ODk0XSAgcGFycG9ydF9wYyhFKSBwcGRldihFKSBscChFKSBwYXJwb3J0KEUpIG5m
c2QoRSkgYXV0aF9ycGNnc3MoRSkgbmZzX2FjbChFKSBsb2NrZChFKSBncmFjZShFKSBzdW5ycGMo
RSkgYXV0b2ZzNChFKSBoaWRfZ2VuZXJpYyhFKSB1c2JoaWQoRSkgaGlkKEUpIHBzbW91c2UoRSkg
YWhjaShFKSByODE2OShFKSBtaWkoRSkgbGliYWhjaShFKSB3bWkoRSkNClsgIDQxMy42ODc5ODld
IENQVTogMTMgUElEOiAxMTM0IENvbW06IGt3b3JrZXIvMTM6MiBUYWludGVkOiBHICAgICAgICAg
ICBPRSAgIDQuOS4wLWN1c3RvbSAjNA0KWyAgNDEzLjY4ODAxOV0gSGFyZHdhcmUgbmFtZTogU3lz
dGVtIG1hbnVmYWN0dXJlciBTeXN0ZW0gUHJvZHVjdCBOYW1lL1BSSU1FIEIzNTAtUExVUywgQklP
UyAwNjA2IDA0LzA2LzIwMTcNClsgIDQxMy42ODgwODldIFdvcmtxdWV1ZTogZXZlbnRzIGFtZF9z
Y2hlZF9qb2JfdGltZWRvdXQgW2FtZGdwdV0NClsgIDQxMy42ODgxMTZdIHRhc2s6IGZmZmY4ODAy
MGY5NjU3YzAgdGFzay5zdGFjazogZmZmZmM5MDAwMWE4ODAwMA0KWyAgNDEzLjY4ODEzOV0gUklQ
OiAwMDEwOls8ZmZmZmZmZmY4MTA5YjE3NT5dICBbPGZmZmZmZmZmODEwOWIxNzU+XSB0b19saXZl
X2t0aHJlYWQrMHg1LzB4NjANClsgIDQxMy42ODgxNzFdIFJTUDogMDAxODpmZmZmYzkwMDAxYThi
ZDYwICBFRkxBR1M6IDAwMDEwMjgyDQpbICA0MTMuNjg4MTkxXSBSQVg6IGZmZmY4ODAyMGYwMDcz
ZjggUkJYOiBmZmZmODgwMjBmMDAwMDAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgNDEzLjY4
ODIxN10gUkRYOiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogZmZmZjg4MDIwZjk2NzBjMCBSREk6IDAw
MDAwMDAwMDAwMDAwMDANClsgIDQxMy42ODgyNDNdIFJCUDogZmZmZmM5MDAwMWE4YmQ3OCBSMDg6
IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAxMDAwDQpbICA0MTMuNjg4MjY5XSBS
MTA6IDAwMDAwMDYwNTFiMTFhODIgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjogMDAwMDAwMDAw
MDAwMDAwMA0KWyAgNDEzLjY4ODI5NV0gUjEzOiBmZmZmODgwMjBmMDAyNzcwIFIxNDogZmZmZjg4
MDIwZjAwNDgzOCBSMTU6IGZmZmY4ODAxYjIzYzJjNjANClsgIDQxMy42ODgzMjFdIEZTOiAgMDAw
MDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODgwMjFlZjQwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDANClsgIDQxMy42ODgzNTJdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBD
UjA6IDAwMDAwMDAwODAwNTAwMzMNClsgIDQxMy42ODgzNzNdIENSMjogMDAwMDAwMDAwMDAwMDU0
OCBDUjM6IDAwMDAwMDAxZWZkMGYwMDAgQ1I0OiAwMDAwMDAwMDAwMzQwNmUwDQpbICA0MTMuNjg4
Mzk5XSBTdGFjazoNClsgIDQxMy42ODg0MDddICBmZmZmZmZmZjgxMDliMzA0IGZmZmY4ODAyMGYw
MDAwMDAgMDAwMDAwMDAwMDAwMDA3MCBmZmZmYzkwMDAxYThiZGYwDQpbICA0MTMuNjg4NDM5XSAg
ZmZmZmZmZmZhMDVjZTI5ZCBmZmZmZmZmZmEwNTJmZWI3IGZmZmZmZmZmYTA3YjU4MjAgZmZmZmM5
MDAwMWE4YmRhMA0KWyAgNDEzLjY4ODQ3MF0gIGZmZmZmZmZmMDAwMDAwMTggZmZmZjg4MDFiYjg4
ZjA2MCAwMDAwMDAwMDAxYThiZGI4IGZmZmY4ODAyMWVmNTkyODANClsgIDQxMy42ODg1MDJdIENh
bGwgVHJhY2U6DQpbICA0MTMuNjg4NTE0XSAgWzxmZmZmZmZmZjgxMDliMzA0Pl0gPyBrdGhyZWFk
X3BhcmsrMHgxNC8weDYwDQpbICA0MTMuNjg4NTU1XSAgWzxmZmZmZmZmZmEwNWNlMjlkPl0gYW1k
Z3B1X2dwdV9yZXNldCsweDdkLzB4NjcwIFthbWRncHVdDQpbICA0MTMuNjg4NTg5XSAgWzxmZmZm
ZmZmZmEwNTJmZWI3Pl0gPyBkcm1fcHJpbnRrKzB4OTcvMHhhMCBbZHJtXQ0KWyAgNDEzLjY4ODY0
M10gIFs8ZmZmZmZmZmZhMDY5ODEzNj5dIGFtZGdwdV9qb2JfdGltZWRvdXQrMHg0Ni8weDUwIFth
bWRncHVdDQpbICA0MTMuNjg4NzAwXSAgWzxmZmZmZmZmZmEwNjk2OWU3Pl0gYW1kX3NjaGVkX2pv
Yl90aW1lZG91dCsweDE3LzB4MjAgW2FtZGdwdV0NClsgIDQxMy42ODg3MjddICBbPGZmZmZmZmZm
ODEwOTU0OTM+XSBwcm9jZXNzX29uZV93b3JrKzB4MTUzLzB4M2YwDQpbICA0MTMuNjg4NzUxXSAg
WzxmZmZmZmZmZjgxMDk1YzViPl0gd29ya2VyX3RocmVhZCsweDEyYi8weDRiMA0KWyAgNDEzLjY4
ODc3M10gIFs8ZmZmZmZmZmY4MTAwMzkyZT5dID8gZG9fc3lzY2FsbF82NCsweDZlLzB4MTgwDQpb
ICA0MTMuNjg4Nzk1XSAgWzxmZmZmZmZmZjgxMDk1YjMwPl0gPyByZXNjdWVyX3RocmVhZCsweDM1
MC8weDM1MA0KWyAgNDEzLjY4ODgxOF0gIFs8ZmZmZmZmZmY4MTAwMzkyZT5dID8gZG9fc3lzY2Fs
bF82NCsweDZlLzB4MTgwDQpbICA0MTMuNjg4ODM5XSAgWzxmZmZmZmZmZjgxMDliNDIzPl0ga3Ro
cmVhZCsweGQzLzB4ZjANClsgIDQxMy42ODg4NThdICBbPGZmZmZmZmZmODEwOWIzNTA+XSA/IGt0
aHJlYWRfcGFyaysweDYwLzB4NjANClsgIDQxMy42ODg4ODFdICBbPGZmZmZmZmZmODE3ZTFlZTU+
XSByZXRfZnJvbV9mb3JrKzB4MjUvMHgzMA0KWyAgNDEzLjY4ODkwMV0gQ29kZTogMjUgNDAgZDMg
MDAgMDAgNDggOGIgODAgNDggMDUgMDAgMDAgNDggODkgZTUgNWQgNDggOGIgNDAgYzggNDggYzEg
ZTggMDIgODMgZTAgMDEgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgMGYgMWYgNDQg
MDAgMDAgPDQ4PiA4YiBiNyA0OCAwNSAwMCAwMCA1NSA0OCA4OSBlNSA0OCA4NSBmNiA3NCAzMSA4
YiA5NyBmOCAxOCAwMA0KWyAgNDEzLjY4OTA0NV0gUklQICBbPGZmZmZmZmZmODEwOWIxNzU+XSB0
b19saXZlX2t0aHJlYWQrMHg1LzB4NjANClsgIDQxMy42ODkwNjRdICBSU1AgPGZmZmZjOTAwMDFh
OGJkNjA+DQpbICA0MTMuNjg5MDc2XSBDUjI6IDAwMDAwMDAwMDAwMDA1NDgNClsgIDQxMy42OTc5
ODVdIC0tLVsgZW5kIHRyYWNlIDBhMzE0YTY0ODIxZjg0ZTkgXS0tLQ0KDQpUaGUgcm9vdCBjYXVz
ZSBpcyBzb21lIHJpbmcgZG9lc24ndCBoYXZlIHNjaGVkdWxlciwgbGlrZSBLSVEgcmluZw0KDQpS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0K
U2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0t
LQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDcgKysrKy0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCmluZGV4IDUwZjE4ZjY2
NmQ2Ny4uZDBjM2U1NmVjZTc0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCkBAIC0yMjM3LDcgKzIyMzcsNyBAQCBpbnQgYW1kZ3B1X2dwdV9yZXNldChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhf
UklOR1M7ICsraSkgew0KIAkJc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3Nb
aV07DQogDQotCQlpZiAoIXJpbmcpDQorCQlpZiAoIXJpbmcgfHwgIXJpbmctPnNjaGVkLnRocmVh
ZCkNCiAJCQljb250aW51ZTsNCiAJCWt0aHJlYWRfcGFyayhyaW5nLT5zY2hlZC50aHJlYWQpOw0K
IAkJYW1kX3NjaGVkX2h3X2pvYl9yZXNldCgmcmluZy0+c2NoZWQpOw0KQEAgLTIzMjYsNyArMjMy
Niw4IEBAIGludCBhbWRncHVfZ3B1X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
IAkJfQ0KIAkJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7ICsraSkgew0KIAkJCXN0
cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IGFkZXYtPnJpbmdzW2ldOw0KLQkJCWlmICghcmluZykN
CisNCisJCQlpZiAoIXJpbmcgfHwgIXJpbmctPnNjaGVkLnRocmVhZCkNCiAJCQkJY29udGludWU7
DQogDQogCQkJYW1kX3NjaGVkX2pvYl9yZWNvdmVyeSgmcmluZy0+c2NoZWQpOw0KQEAgLTIzMzUs
NyArMjMzNiw3IEBAIGludCBhbWRncHVfZ3B1X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KIAl9IGVsc2Ugew0KIAkJZGV2X2VycihhZGV2LT5kZXYsICJhc2ljIHJlc3VtZSBmYWls
ZWQgKCVkKS5cbiIsIHIpOw0KIAkJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7ICsr
aSkgew0KLQkJCWlmIChhZGV2LT5yaW5nc1tpXSkgew0KKwkJCWlmIChhZGV2LT5yaW5nc1tpXSAm
JiBhZGV2LT5yaW5nc1tpXS0+c2NoZWQudGhyZWFkKSB7DQogCQkJCWt0aHJlYWRfdW5wYXJrKGFk
ZXYtPnJpbmdzW2ldLT5zY2hlZC50aHJlYWQpOw0KIAkJCX0NCiAJCX0NCi0tIA0KMi4xNC4xDQo=
