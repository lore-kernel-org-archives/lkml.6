Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121012-2-12496546598407216106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121011; b=n/KIoayriwaqVm+E+Y1tvV54u/70i9EOL70JrDmDUHrMQj1
    c/GiG0dsI7Zd/A0mJAKfLIfT44VTvJ9kB4YQOKcQ9uVn1wP+XUksTqkrDNOAilbe
    7UXFSm3q9JCYrGzZFZ9LyXywtIDdPBp5uMNQ93NAGWZiX0SE3FRdwb6IFH9/DT3S
    UUvXyASCCrvHCoY+CS2jLGjbkTBzwrHncpa0jPkkAeaMSyRJ9FDShPdZ63cWM12i
    Hj0UXozAPEk4/RhBWdNRsqcUgVnGr9IkM7oSlHzlpBnhebt44w5HnTfPrDzmGms3
    zJrRSA4tNzKiGgQv6fo5+0WAjuiprO9No5XwEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520121011; bh=TpJRWHtP/jfcugUdnnygLyKLXWIUekCRsUxRXY
    2vfLo=; b=hUjpQ1huQK0grnpimaebDgM6JPANfn4vtwfoIT7ogbo+zFXQLKIBe0
    MjbX2gKj1AzptD3sOPV2ZlVwwr5nSZn6cgAV8Nx8L35P0bT3sHKBl7dRC73twQq7
    TOkTrS86tInVSl/ZEf46a8YWzkvqewQgBmBV8fIrw7aJc4EKjR9LwQZdXH10c+6o
    K1iCg8JtBSj4e1q5NG3BJ4G/Rcq4sLgelGoIaLO8JnZC3jDPfaZ7B/0Vsc6eN/PB
    KWsoZUMwCj5fJzyUiyFZxiOY4syEEDawKngVP8xdhgeBkX0XSmDFzqQY1eCDNtfj
    P+vefkqfRF8+RuHzG1TBSqjovJ8l585A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mB/xX+lb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mB/xX+lb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934030AbeCCWdX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:23 -0500
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:9794
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933993AbeCCWdS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        =?utf-8?B?THVpcyBDbGF1ZGlvIEdvbsOnYWx2ZXM=?= <lclaudio@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 084/219] perf trace: Handle unpaired
 raw_syscalls:sys_exit event
Thread-Topic: [PATCH AUTOSEL for 4.9 084/219] perf trace: Handle unpaired
 raw_syscalls:sys_exit event
Thread-Index: AQHTsz79VfgfdG197EiZk2lD1yKfVw==
Date: Sat, 3 Mar 2018 22:28:44 +0000
Message-ID: <20180303222716.26640-84-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:YJOZl9qKas92tR6PmbrwZP5gY3GAZPSAeiGWzqqoLGUi4j0lqR+PAhoii+CZh/e9OsnqwqR4gPRTmeLx0/v7VbhCPUPkuZkSresI0WiAZgm0CL+gIJnGiJzcP0FqfWUMFJ2gI9wR3M0lLlgYRu7Yb8dpevPh4Tso5UaVinNT7rCNwkYl91+WwaFVzuqxlBVG8XtggQiwa11ViPkV+BhtbVptvH9NqBKnhlHDr9EVnguO5+3MvuO1oOMhO9+GBSs4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49000cfb-761c-405c-a967-08d58156be61
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10979E0BD919455470E72DC2FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(84791874153150)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(39060400002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(966005)(478600001)(186003)(110136005)(26005)(316002)(2906002)(6306002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ma99oOSaHc7qmBr2KMrGBdwda+aC8/KjEJkDHCUKDDjj/swkOA4LAY+vCSfos5OLG+m4lBIJBJQvEXnoZWMw541Fl1GgVO6xdfLCKNh/brUy1lE8jgWFqQL/HUCciTvmjSbntxu0bFrZOVEGi+t425MV3HE0eYKXTtX6UsvsIk4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D60EBAC4F7B074F9BA59F5568909A32@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49000cfb-761c-405c-a967-08d58156be61
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:44.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQHJlZGhhdC5jb20+DQoNClsgVXBz
dHJlYW0gY29tbWl0IGZkMmIyOTc1MTQ5ZjVmNzA5OTY5MzAyN2NlY2U4MWIxNjg0Mjk2NGEgXQ0K
DQpXaGljaCBtYXkgaGFwcGVuIHdoZW4gd2Ugc3RhcnQgYSB0cmFjaW5nIHNlc3Npb24gYW5kIGEg
dGhyZWFkIGlzIHdhaXRpbmcNCmZvciBzb21ldGhpbmcgbGlrZSAicG9sbCIgdG8gcmV0dXJuLCBp
biB3aGljaCBjYXNlIHdlIGJldHRlciBwcmludCAiPyINCmJvdGggZm9yIHRoZSBzeXNjYWxsIGVu
dHJ5IHRpbWVzdGFtcCBhbmQgZm9yIHRoZSBkdXJhdGlvbi4NCg0KRS5nLjoNCg0KVHJhY2luZyBl
eGlzdGluZyBtdXR0IHNlc3Npb246DQoNCiAgIyBwZXJmIHRyYWNlIC1wIGBwaWRvZiBtdXR0YA0K
ICAgICAgICAgID8gKCAgICAgPyAgICk6IG11dHQvMTcxMzUgIC4uLiBbY29udGludWVkXTogcG9s
bCgpKSA9IDENCiAgICAgIDAuMDI3ICggMC4wMTMgbXMpOiBtdXR0LzE3MTM1IHJlYWQoYnVmOiAw
eDdmZmNiM2M0MmNlZiwgY291bnQ6IDEpID0gMQ0KICAgICAgMC4wNDcgKCAwLjAwOCBtcyk6IG11
dHQvMTcxMzUgcG9sbCh1ZmRzOiAweDdmZmNiM2M0MmM1MCwgbmZkczogMSwgdGltZW91dF9tc2Vj
czogMTAwMCkgPSAxDQogICAgICAwLjA1OSAoIDAuMDA4IG1zKTogbXV0dC8xNzEzNSByZWFkKGJ1
ZjogMHg3ZmZjYjNjNDJjZWYsIGNvdW50OiAxKSA9IDENCiAgPFNOSVA+DQoNCkJlZm9yZSBpdCB3
b3VsZCBwcmludCBhIGxhcmdlIG51bWJlciBiZWNhdXNlIHdlJ2QgZG86DQoNCiAgdHRyYWNlLT5l
bnRyeV90aW1lIC0gdHJhY2UtPmJhc2VfdGltZQ0KDQpBbmQgZW50cnlfdGltZSB3b3VsZCBiZSAw
LCB3aGlsZSBiYXNlX3RpbWUgd291bGQgYmUgdGhlIHRpbWVzdGFtcCBmb3INCnRoZSBmaXJzdCBl
dmVudCAncGVyZiB0cmFjZScgcmVhZHMsIG9vcHMuDQoNCkNjOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCkNjOiBEYXZpZCBBaGVybiA8ZHNhaGVybkBnbWFpbC5jb20+
DQpDYzogSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPg0KQ2M6IEx1aXMgQ2xhdWRpbyBHb27D
p2FsdmVzIDxsY2xhdWRpb0ByZWRoYXQuY29tPg0KQ2M6IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdA
a2VybmVsLm9yZz4NCkNjOiBXYW5nIE5hbiA8d2FuZ25hbjBAaHVhd2VpLmNvbT4NCkxpbms6IGh0
dHA6Ly9sa21sLmtlcm5lbC5vcmcvbi90aXAtd2JjYjkzb2Z2YTJxZGpkNWx0bjVlZXFxQGdpdC5r
ZXJuZWwub3JnDQpTaWduZWQtb2ZmLWJ5OiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVA
cmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5A
bWljcm9zb2Z0LmNvbT4NCi0tLQ0KIHRvb2xzL3BlcmYvYnVpbHRpbi10cmFjZS5jIHwgNDMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAzNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMv
cGVyZi9idWlsdGluLXRyYWNlLmMgYi90b29scy9wZXJmL2J1aWx0aW4tdHJhY2UuYw0KaW5kZXgg
MjFmOGE4MTc5N2EwLi40YzU5NmJhMzEwY2IgMTAwNjQ0DQotLS0gYS90b29scy9wZXJmL2J1aWx0
aW4tdHJhY2UuYw0KKysrIGIvdG9vbHMvcGVyZi9idWlsdGluLXRyYWNlLmMNCkBAIC04MjIsMTIg
KzgyMiwyMSBAQCBzdHJ1Y3Qgc3lzY2FsbCB7DQogCXZvaWQJCSAgICAqKmFyZ19wYXJtOw0KIH07
DQogDQotc3RhdGljIHNpemVfdCBmcHJpbnRmX2R1cmF0aW9uKHVuc2lnbmVkIGxvbmcgdCwgRklM
RSAqZnApDQorLyoNCisgKiBXZSBuZWVkIHRvIGhhdmUgdGhpcyAnY2FsY3VsYXRlZCcgYm9vbGVh
biBiZWNhdXNlIGluIHNvbWUgY2FzZXMgd2UgcmVhbGx5DQorICogZG9uJ3Qga25vdyB3aGF0IGlz
IHRoZSBkdXJhdGlvbiBvZiBhIHN5c2NhbGwsIGZvciBpbnN0YW5jZSwgd2hlbiB3ZSBzdGFydA0K
KyAqIGEgc2Vzc2lvbiBhbmQgc29tZSB0aHJlYWRzIGFyZSB3YWl0aW5nIGZvciBhIHN5c2NhbGwg
dG8gZmluaXNoLCBzYXkgJ3BvbGwnLA0KKyAqIGluIHdoaWNoIGNhc2UgYWxsIHdlIGNhbiBkbyBp
cyB0byBwcmludCAiKCA/ICkgZm9yIGR1cmF0aW9uIGFuZCBmb3IgdGhlDQorICogc3RhcnQgdGlt
ZXN0YW1wLg0KKyAqLw0KK3N0YXRpYyBzaXplX3QgZnByaW50Zl9kdXJhdGlvbih1bnNpZ25lZCBs
b25nIHQsIGJvb2wgY2FsY3VsYXRlZCwgRklMRSAqZnApDQogew0KIAlkb3VibGUgZHVyYXRpb24g
PSAoZG91YmxlKXQgLyBOU0VDX1BFUl9NU0VDOw0KIAlzaXplX3QgcHJpbnRlZCA9IGZwcmludGYo
ZnAsICIoIik7DQogDQotCWlmIChkdXJhdGlvbiA+PSAxLjApDQorCWlmICghY2FsY3VsYXRlZCkN
CisJCXByaW50ZWQgKz0gZnByaW50ZihmcCwgIiAgICAgPyAgICIpOw0KKwllbHNlIGlmIChkdXJh
dGlvbiA+PSAxLjApDQogCQlwcmludGVkICs9IGNvbG9yX2ZwcmludGYoZnAsIFBFUkZfQ09MT1Jf
UkVELCAiJTYuM2YgbXMiLCBkdXJhdGlvbik7DQogCWVsc2UgaWYgKGR1cmF0aW9uID49IDAuMDEp
DQogCQlwcmludGVkICs9IGNvbG9yX2ZwcmludGYoZnAsIFBFUkZfQ09MT1JfWUVMTE9XLCAiJTYu
M2YgbXMiLCBkdXJhdGlvbik7DQpAQCAtMTAzMCwxMyArMTAzOSwyNyBAQCBzdGF0aWMgYm9vbCB0
cmFjZV9fZmlsdGVyX2R1cmF0aW9uKHN0cnVjdCB0cmFjZSAqdHJhY2UsIGRvdWJsZSB0KQ0KIAly
ZXR1cm4gdCA8ICh0cmFjZS0+ZHVyYXRpb25fZmlsdGVyICogTlNFQ19QRVJfTVNFQyk7DQogfQ0K
IA0KLXN0YXRpYyBzaXplX3QgdHJhY2VfX2ZwcmludGZfdHN0YW1wKHN0cnVjdCB0cmFjZSAqdHJh
Y2UsIHU2NCB0c3RhbXAsIEZJTEUgKmZwKQ0KK3N0YXRpYyBzaXplX3QgX190cmFjZV9fZnByaW50
Zl90c3RhbXAoc3RydWN0IHRyYWNlICp0cmFjZSwgdTY0IHRzdGFtcCwgRklMRSAqZnApDQogew0K
IAlkb3VibGUgdHMgPSAoZG91YmxlKSh0c3RhbXAgLSB0cmFjZS0+YmFzZV90aW1lKSAvIE5TRUNf
UEVSX01TRUM7DQogDQogCXJldHVybiBmcHJpbnRmKGZwLCAiJTEwLjNmICIsIHRzKTsNCiB9DQog
DQorLyoNCisgKiBXZSdyZSBoYW5kbGluZyB0c3RhbXA9MCBhcyBhbiB1bmRlZmluZWQgdHN0YW1w
LCBpLmUuIGxpa2Ugd2hlbiB3ZSBhcmUNCisgKiB1c2luZyB0dHJhY2UtPmVudHJ5X3RpbWUgZm9y
IGEgdGhyZWFkIHRoYXQgcmVjZWl2ZXMgYSBzeXNfZXhpdCB3aXRob3V0DQorICogZmlyc3QgaGF2
aW5nIHJlY2VpdmVkIGEgc3lzX2VudGVyICgicG9sbCIgaXNzdWVkIGJlZm9yZSB0cmFjaW5nIHNl
c3Npb24NCisgKiBzdGFydHMsIGxvc3Qgc3lzX2VudGVyIGV4aXQgZHVlIHRvIHJpbmcgYnVmZmVy
IG92ZXJmbG93KS4NCisgKi8NCitzdGF0aWMgc2l6ZV90IHRyYWNlX19mcHJpbnRmX3RzdGFtcChz
dHJ1Y3QgdHJhY2UgKnRyYWNlLCB1NjQgdHN0YW1wLCBGSUxFICpmcCkNCit7DQorCWlmICh0c3Rh
bXAgPiAwKQ0KKwkJcmV0dXJuIF9fdHJhY2VfX2ZwcmludGZfdHN0YW1wKHRyYWNlLCB0c3RhbXAs
IGZwKTsNCisNCisJcmV0dXJuIGZwcmludGYoZnAsICIgICAgICAgICA/ICIpOw0KK30NCisNCiBz
dGF0aWMgYm9vbCBkb25lID0gZmFsc2U7DQogc3RhdGljIGJvb2wgaW50ZXJydXB0ZWQgPSBmYWxz
ZTsNCiANCkBAIC0xMDQ3LDEwICsxMDcwLDEwIEBAIHN0YXRpYyB2b2lkIHNpZ19oYW5kbGVyKGlu
dCBzaWcpDQogfQ0KIA0KIHN0YXRpYyBzaXplX3QgdHJhY2VfX2ZwcmludGZfZW50cnlfaGVhZChz
dHJ1Y3QgdHJhY2UgKnRyYWNlLCBzdHJ1Y3QgdGhyZWFkICp0aHJlYWQsDQotCQkJCQl1NjQgZHVy
YXRpb24sIHU2NCB0c3RhbXAsIEZJTEUgKmZwKQ0KKwkJCQkJdTY0IGR1cmF0aW9uLCBib29sIGR1
cmF0aW9uX2NhbGN1bGF0ZWQsIHU2NCB0c3RhbXAsIEZJTEUgKmZwKQ0KIHsNCiAJc2l6ZV90IHBy
aW50ZWQgPSB0cmFjZV9fZnByaW50Zl90c3RhbXAodHJhY2UsIHRzdGFtcCwgZnApOw0KLQlwcmlu
dGVkICs9IGZwcmludGZfZHVyYXRpb24oZHVyYXRpb24sIGZwKTsNCisJcHJpbnRlZCArPSBmcHJp
bnRmX2R1cmF0aW9uKGR1cmF0aW9uLCBkdXJhdGlvbl9jYWxjdWxhdGVkLCBmcCk7DQogDQogCWlm
ICh0cmFjZS0+bXVsdGlwbGVfdGhyZWFkcykgew0KIAkJaWYgKHRyYWNlLT5zaG93X2NvbW0pDQpA
QCAtMTQ1Miw3ICsxNDc1LDcgQEAgc3RhdGljIGludCB0cmFjZV9fcHJpbnRmX2ludGVycnVwdGVk
X2VudHJ5KHN0cnVjdCB0cmFjZSAqdHJhY2UsIHN0cnVjdCBwZXJmX3NhbXANCiANCiAJZHVyYXRp
b24gPSBzYW1wbGUtPnRpbWUgLSB0dHJhY2UtPmVudHJ5X3RpbWU7DQogDQotCXByaW50ZWQgID0g
dHJhY2VfX2ZwcmludGZfZW50cnlfaGVhZCh0cmFjZSwgdHJhY2UtPmN1cnJlbnQsIGR1cmF0aW9u
LCB0dHJhY2UtPmVudHJ5X3RpbWUsIHRyYWNlLT5vdXRwdXQpOw0KKwlwcmludGVkICA9IHRyYWNl
X19mcHJpbnRmX2VudHJ5X2hlYWQodHJhY2UsIHRyYWNlLT5jdXJyZW50LCBkdXJhdGlvbiwgdHJ1
ZSwgdHRyYWNlLT5lbnRyeV90aW1lLCB0cmFjZS0+b3V0cHV0KTsNCiAJcHJpbnRlZCArPSBmcHJp
bnRmKHRyYWNlLT5vdXRwdXQsICIlLTcwcykgLi4uXG4iLCB0dHJhY2UtPmVudHJ5X3N0cik7DQog
CXR0cmFjZS0+ZW50cnlfcGVuZGluZyA9IGZhbHNlOw0KIA0KQEAgLTE0OTksNyArMTUyMiw3IEBA
IHN0YXRpYyBpbnQgdHJhY2VfX3N5c19lbnRlcihzdHJ1Y3QgdHJhY2UgKnRyYWNlLCBzdHJ1Y3Qg
cGVyZl9ldnNlbCAqZXZzZWwsDQogDQogCWlmIChzYy0+aXNfZXhpdCkgew0KIAkJaWYgKCEodHJh
Y2UtPmR1cmF0aW9uX2ZpbHRlciB8fCB0cmFjZS0+c3VtbWFyeV9vbmx5IHx8IHRyYWNlLT5taW5f
c3RhY2spKSB7DQotCQkJdHJhY2VfX2ZwcmludGZfZW50cnlfaGVhZCh0cmFjZSwgdGhyZWFkLCAx
LCB0dHJhY2UtPmVudHJ5X3RpbWUsIHRyYWNlLT5vdXRwdXQpOw0KKwkJCXRyYWNlX19mcHJpbnRm
X2VudHJ5X2hlYWQodHJhY2UsIHRocmVhZCwgMCwgZmFsc2UsIHR0cmFjZS0+ZW50cnlfdGltZSwg
dHJhY2UtPm91dHB1dCk7DQogCQkJZnByaW50Zih0cmFjZS0+b3V0cHV0LCAiJS03MHMpXG4iLCB0
dHJhY2UtPmVudHJ5X3N0cik7DQogCQl9DQogCX0gZWxzZSB7DQpAQCAtMTU0Nyw2ICsxNTcwLDcg
QEAgc3RhdGljIGludCB0cmFjZV9fc3lzX2V4aXQoc3RydWN0IHRyYWNlICp0cmFjZSwgc3RydWN0
IHBlcmZfZXZzZWwgKmV2c2VsLA0KIHsNCiAJbG9uZyByZXQ7DQogCXU2NCBkdXJhdGlvbiA9IDA7
DQorCWJvb2wgZHVyYXRpb25fY2FsY3VsYXRlZCA9IGZhbHNlOw0KIAlzdHJ1Y3QgdGhyZWFkICp0
aHJlYWQ7DQogCWludCBpZCA9IHBlcmZfZXZzZWxfX3NjX3RwX3VpbnQoZXZzZWwsIGlkLCBzYW1w
bGUpLCBlcnIgPSAtMSwgY2FsbGNoYWluX3JldCA9IDA7DQogCXN0cnVjdCBzeXNjYWxsICpzYyA9
IHRyYWNlX19zeXNjYWxsX2luZm8odHJhY2UsIGV2c2VsLCBpZCk7DQpAQCAtMTU3Nyw2ICsxNjAx
LDcgQEAgc3RhdGljIGludCB0cmFjZV9fc3lzX2V4aXQoc3RydWN0IHRyYWNlICp0cmFjZSwgc3Ry
dWN0IHBlcmZfZXZzZWwgKmV2c2VsLA0KIAkJZHVyYXRpb24gPSBzYW1wbGUtPnRpbWUgLSB0dHJh
Y2UtPmVudHJ5X3RpbWU7DQogCQlpZiAodHJhY2VfX2ZpbHRlcl9kdXJhdGlvbih0cmFjZSwgZHVy
YXRpb24pKQ0KIAkJCWdvdG8gb3V0Ow0KKwkJZHVyYXRpb25fY2FsY3VsYXRlZCA9IHRydWU7DQog
CX0gZWxzZSBpZiAodHJhY2UtPmR1cmF0aW9uX2ZpbHRlcikNCiAJCWdvdG8gb3V0Ow0KIA0KQEAg
LTE1OTIsNyArMTYxNyw3IEBAIHN0YXRpYyBpbnQgdHJhY2VfX3N5c19leGl0KHN0cnVjdCB0cmFj
ZSAqdHJhY2UsIHN0cnVjdCBwZXJmX2V2c2VsICpldnNlbCwNCiAJaWYgKHRyYWNlLT5zdW1tYXJ5
X29ubHkpDQogCQlnb3RvIG91dDsNCiANCi0JdHJhY2VfX2ZwcmludGZfZW50cnlfaGVhZCh0cmFj
ZSwgdGhyZWFkLCBkdXJhdGlvbiwgdHRyYWNlLT5lbnRyeV90aW1lLCB0cmFjZS0+b3V0cHV0KTsN
CisJdHJhY2VfX2ZwcmludGZfZW50cnlfaGVhZCh0cmFjZSwgdGhyZWFkLCBkdXJhdGlvbiwgZHVy
YXRpb25fY2FsY3VsYXRlZCwgdHRyYWNlLT5lbnRyeV90aW1lLCB0cmFjZS0+b3V0cHV0KTsNCiAN
CiAJaWYgKHR0cmFjZS0+ZW50cnlfcGVuZGluZykgew0KIAkJZnByaW50Zih0cmFjZS0+b3V0cHV0
LCAiJS03MHMiLCB0dHJhY2UtPmVudHJ5X3N0cik7DQpAQCAtMTg1NSw3ICsxODgwLDcgQEAgc3Rh
dGljIGludCB0cmFjZV9fcGdmYXVsdChzdHJ1Y3QgdHJhY2UgKnRyYWNlLA0KIAl0aHJlYWRfX2Zp
bmRfYWRkcl9sb2NhdGlvbih0aHJlYWQsIHNhbXBsZS0+Y3B1bW9kZSwgTUFQX19GVU5DVElPTiwN
CiAJCQkgICAgICBzYW1wbGUtPmlwLCAmYWwpOw0KIA0KLQl0cmFjZV9fZnByaW50Zl9lbnRyeV9o
ZWFkKHRyYWNlLCB0aHJlYWQsIDAsIHNhbXBsZS0+dGltZSwgdHJhY2UtPm91dHB1dCk7DQorCXRy
YWNlX19mcHJpbnRmX2VudHJ5X2hlYWQodHJhY2UsIHRocmVhZCwgMCwgdHJ1ZSwgc2FtcGxlLT50
aW1lLCB0cmFjZS0+b3V0cHV0KTsNCiANCiAJZnByaW50Zih0cmFjZS0+b3V0cHV0LCAiJXNmYXVs
dCBbIiwNCiAJCWV2c2VsLT5hdHRyLmNvbmZpZyA9PSBQRVJGX0NPVU5UX1NXX1BBR0VfRkFVTFRT
X01BSiA/DQotLSANCjIuMTQuMQ0K
