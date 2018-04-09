Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523243083-2-5962406400082437365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243082; b=HqAJw4xfAfNfb7YYP4sot5z7wA6TGUrGjW76k3PDo41RQr1UMw
    VgMNJ7EbXfozJlubfagWwUC+jvfRnYgWWh29CuIKa++p1RbwKxcbE40ewBytqMs4
    6Y2O0MEIJJQontEhXHh2+eX36qP0Zp8IBCMvXqTXnJZNdO/HNbdEYxdvZ1YSptYa
    LwWGnt5wOdVPIQwj7ubZI5ksDCn8LHjfgQzRuIT5vnLPIF4jRy0drqko2Dib34kt
    YmJKJmQQeStlEcg9nU4C7DIllT1pRA0qoeB88x3ps9oGw9G9Fu0J7NCUnKoLypwi
    4w5Jl11atBI7YXNEKQ1YE71KwtlL2V+MGiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523243082; bh=R7YcmNcBEE1eoioD9W5aH+6Ulz86mk8Un9KohY4v7RE=; b=
    pLva1sj7bCvdTqFIBW630KTIo5FVrSBHijVNkZgK5+zrms5l8yo52mcKamcyqOxZ
    fQqroJ37LnuA7QpGegNQDB/7Ca4MRJfhbrytSvpF6D4wcfnrw3WK1IGKjuwzKtIC
    LKBx6Z0rtwb7TeoV2iQuVPKS606JxHpMWEVB/N7Gz9YsQztB0osRtyNp5tSgyFHW
    PGApb3Uoig0bkKBZDbNsZiTH9DjbrQ8LePlO179ShX7Tq/Day5KE7VE/NbQIzPyD
    Mor50IYVhQobeRBXv+bWZ8yv3Id0+aGHihfnjzEtzEOCToFRO1v+Fy7/Vk2AvW7A
    OsrmoG5TEHysw63S2dHFAg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UM3cRCU0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UM3cRCU0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKftpuCfleNu60/fpbi0hTrs2y8S5OnT2w0nVsxaVgkjJCBDp8coCCKSg5jsWGViQDTC/ucLuUlbyx34Cw0KuYXYiAE/bstdCWU/qhCUnP/PDTQDPFt1
    moEUWYyP6yN5TIO4JSab6yWQD/JDkBJNi+1PU9rnbL3JjmFx8sHKHCDRqoqiJz7JJtMrFOFOVnDP6SM7jy1h+Sw4cvQewjccMLTvyYKgAoq6nIXRvLraT7f2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=V4zo2IF0AAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
    a=QyXUC8HyAAAA:8 a=iox4zFpeAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=XXkejBGJcyV2RgbEolUA:9 a=QEXdDO2ut3YA:10 a=94qaw2vPIUMA:10
    a=kcQYkljjMzlkGLXDm-6B:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeDIDEi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:04:38 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:23328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932106AbeDIAYt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yang Shi <yang.s@alibaba-inc.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 103/161] mm: thp: use down_read_trylock() in
 khugepaged to avoid long block
Thread-Topic: [PATCH AUTOSEL for 4.14 103/161] mm: thp: use
 down_read_trylock() in khugepaged to avoid long block
Thread-Index: AQHTz5isbFqLiJDs40uiRzNoOTvXYg==
Date: Mon, 9 Apr 2018 00:21:16 +0000
Message-ID: <20180409001936.162706-103-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:YG2bNKiG3y2WNaRhjyJicX8V+DIyp/8q4x2mMkgTL6BFeUBRvfLPTUWsQ/501bWORsncAiIV83ldPTB1no8M9IiPL5EWy5JP13yPBGjYLvHDc7I2rGFVGxGcuSsHzaJawNTcXcktlWGOwmk7lyix76IUFwjjvWrPGU1m+A5bpRL+2+QgoO4LmGrjGsKfMVLGk0zBSt1kXCwopkkd0oWO5W3OTd0Vju4kVJfeLbCjlld75KzOho6RKAD6PS4KW4Wt;20:vUHvzy9NMbQVf4tVs5NiucXBu4/wpUbV/3k3Oj3gYeNdqUK8XKlS/lBIJX2fE3reuP/61Vl95c5IgziuTqfcU1wXWLZnqvSzH3fLpVrT2czlA55xIHYpG9fyp6pihtP6fHDZygD6afYHQI9JzzV2CLBbNBvaT0p8oqsD59U8VBc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2bb3ac5f-4559-4dae-7575-08d59db04afc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983096B00B4A9CAC73086C1FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(966005)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6306002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hrYVL9+b7Vob9eAmO5OJ2/5C28osYJimrK2+rHfNRLOdYCszTjdJcAzgvfSffmuFoozMrr1G8QUNLtj6tU/bbiiQqAWnV2X3IMlRSut9N2GM2aMpHCDJhEANO6BRjCXqWVKQDxLXIAD7gCf5dLWICtHWHa+8N3HdRKVSeZmMRH4tnzkkjfglCG603t+uoaR/6YGiW0BToj3rrednLNLJYz014uETJHpdG+1BCTYEaAxs0FaNx1xm45/FxQGTfZY04PmlsnFluvfyTjeJibjtj1eG7oSLgqS+cjofpEFHtNkorvjE/q1dBWCUZertZ1EPyiaGoEjwe9M2DnefbbNdRGlydLzfCy82zTgvKI7P6dMrldqWmgXG/6+mq63fNTR7s2lYLV/zq2CGcrfZCxIzD2NEBcKZphaPX4tYgYw3zlo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A88818975C9B240905BA9927DAFAC37@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb3ac5f-4559-4dae-7575-08d59db04afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:16.2844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogWWFuZyBTaGkgPHlhbmcuc0BhbGliYWJhLWluYy5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IDNiNDU0YWQzNTA0M2RmYmQzYjVkMmJiOTJiMDk5MWQ2MzQyYWZiNDQgXQ0KDQpJbiB0aGUg
Y3VycmVudCBkZXNpZ24sIGtodWdlcGFnZWQgbmVlZHMgdG8gYWNxdWlyZSBtbWFwX3NlbSBiZWZv
cmUNCnNjYW5uaW5nIGFuIG1tLiAgQnV0IGluIHNvbWUgY29ybmVyIGNhc2VzLCBraHVnZXBhZ2Vk
IG1heSBzY2FuIGEgcHJvY2Vzcw0Kd2hpY2ggaXMgbW9kaWZ5aW5nIGl0cyBtZW1vcnkgbWFwcGlu
Zywgc28ga2h1Z2VwYWdlZCBibG9ja3MgaW4NCnVuaW50ZXJydXB0aWJsZSBzdGF0ZS4gIEJ1dCB0
aGUgcHJvY2VzcyBtaWdodCBob2xkIHRoZSBtbWFwX3NlbSBmb3IgYQ0KbG9uZyB0aW1lIHdoZW4g
bW9kaWZ5aW5nIGEgaHVnZSBtZW1vcnkgc3BhY2UgYW5kIGl0IG1heSB0cmlnZ2VyIHRoZQ0KYmVs
b3cga2h1Z2VwYWdlZCBodW5nIGlzc3VlOg0KDQogIElORk86IHRhc2sga2h1Z2VwYWdlZDoyNzAg
YmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMCBzZWNvbmRzLg0KICBUYWludGVkOiBHIEUgNC45LjY1
LTAwNi5hbGkzMDAwLmFsaW9zNy54ODZfNjQgIzENCiAgImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJu
ZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBtZXNzYWdlLg0KICBraHVn
ZXBhZ2VkIEQgMCAyNzAgMiAweDAwMDAwMDAwwqANCiAgZmZmZjg4M2YzZGVhZTRjMCAwMDAwMDAw
MDAwMDAwMDAwIGZmZmY4ODNmNjEwNTk2YzAgZmZmZjg4M2Y3ZDM1OTQ0MA0KICBmZmZmODgzZjYz
ODE4MDAwIGZmZmZjOTAwMTlhZGZjNzggZmZmZmZmZmY4MTcwNzlhNSBkNjdlNWFhOGMxODYwYTY0
DQogIDAwMDAwMDAwMDAwMDAyNDYgZmZmZjg4M2Y3ZDM1OTQ0MCBmZmZmYzkwMDE5YWRmYzg4IGZm
ZmY4ODNmNjEwNTk2YzANCiAgQ2FsbCBUcmFjZToNCiAgICBzY2hlZHVsZSsweDM2LzB4ODANCiAg
ICByd3NlbV9kb3duX3JlYWRfZmFpbGVkKzB4ZjAvMHgxNTANCiAgICBjYWxsX3J3c2VtX2Rvd25f
cmVhZF9mYWlsZWQrMHgxOC8weDMwDQogICAgZG93bl9yZWFkKzB4MjAvMHg0MA0KICAgIGtodWdl
cGFnZWQrMHg0NzYvMHgxMWQwDQogICAga3RocmVhZCsweGU2LzB4MTAwDQogICAgcmV0X2Zyb21f
Zm9yaysweDI1LzB4MzANCg0KU28gaXQgc291bmRzIHBvaW50bGVzcyB0byBqdXN0IGJsb2NrIGto
dWdlcGFnZWQgd2FpdGluZyBmb3IgdGhlDQpzZW1hcGhvcmUgc28gcmVwbGFjZSBkb3duX3JlYWQo
KSB3aXRoIGRvd25fcmVhZF90cnlsb2NrKCkgdG8gbW92ZSB0bw0Kc2NhbiB0aGUgbmV4dCBtbSBx
dWlja2x5IGluc3RlYWQgb2YganVzdCBibG9ja2luZyBvbiB0aGUgc2VtYXBob3JlIHNvDQp0aGF0
IG90aGVyIHByb2Nlc3NlcyBjYW4gZ2V0IG1vcmUgY2hhbmNlcyB0byBpbnN0YWxsIFRIUC4gIFRo
ZW4NCmtodWdlcGFnZWQgY2FuIGNvbWUgYmFjayB0byBzY2FuIHRoZSBza2lwcGVkIG1tIHdoZW4g
aXQgaGFzIGZpbmlzaGVkIHRoZQ0KY3VycmVudCByb3VuZCBmdWxsX3NjYW4uDQoNCkFuZCBpdCBh
cHBlYXJzIHRoYXQgdGhlIGNoYW5nZSBjYW4gaW1wcm92ZSBraHVnZXBhZ2VkIGVmZmljaWVuY3kg
YQ0KbGl0dGxlIGJpdC4NCg0KQmVsb3cgaXMgdGhlIHRlc3QgcmVzdWx0IHdoZW4gcnVubmluZyBM
VFAgb24gYSAyNCBjb3JlcyA0R0IgbWVtb3J5IDINCm5vZGVzIE5VTUEgVk06DQoNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaXN0aW5lICAgICAgICAgIHcvIHRyeWxvY2sN
CiAgZnVsbF9zY2FuICAgICAgICAgICAgICAgICAgICAgICAgIDE5NyAgICAgICAgICAgICAgIDE4
Nw0KICBwYWdlc19jb2xsYXBzZWQgICAgICAgICAgICAgICAgICAgMjEgICAgICAgICAgICAgICAg
MjYNCiAgdGhwX2ZhdWx0X2FsbG9jICAgICAgICAgICAgICAgICAgIDQwODE4ICAgICAgICAgICAg
IDQ0NDY2DQogIHRocF9mYXVsdF9mYWxsYmFjayAgICAgICAgICAgICAgICAxODQxMyAgICAgICAg
ICAgICAxNjY3OQ0KICB0aHBfY29sbGFwc2VfYWxsb2MgICAgICAgICAgICAgICAgMjEgICAgICAg
ICAgICAgICAgMTUwDQogIHRocF9jb2xsYXBzZV9hbGxvY19mYWlsZWQgICAgICAgICAxNCAgICAg
ICAgICAgICAgICAxNg0KICB0aHBfZmlsZV9hbGxvYyAgICAgICAgICAgICAgICAgICAgMzY5ICAg
ICAgICAgICAgICAgMzY5DQoNCltha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOiBjb2Rpbmctc3R5
bGUgZml4ZXNdDQpbYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzogdHdlYWsgY29tbWVudF0NClth
cm5kQGFybmRiLmRlOiBhdm9pZCB1bmluaXRpYWxpemVkIHZhcmlhYmxlIHVzZV0NCiAgTGluazog
aHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzIwMTcxMjE1MTI1MTI5LjI5NDg2MzQtMS1hcm5kQGFy
bmRiLmRlDQpMaW5rOiBodHRwOi8vbGttbC5rZXJuZWwub3JnL3IvMTUxMzI4MTIwMy01NDg3OC0x
LWdpdC1zZW5kLWVtYWlsLXlhbmcuc0BhbGliYWJhLWluYy5jb20NClNpZ25lZC1vZmYtYnk6IFlh
bmcgU2hpIDx5YW5nLnNAYWxpYmFiYS1pbmMuY29tPg0KQWNrZWQtYnk6IEtpcmlsbCBBLiBTaHV0
ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCkFja2VkLWJ5OiBNaWNoYWwg
SG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4NCkNjOiBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5j
b20+DQpDYzogQW5kcmVhIEFyY2FuZ2VsaSA8YWFyY2FuZ2VAcmVkaGF0LmNvbT4NClNpZ25lZC1v
ZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQpTaWduZWQtb2ZmLWJ5OiBBbmRy
ZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KU2lnbmVkLW9mZi1ieTogTGlu
dXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogbW0v
a2h1Z2VwYWdlZC5jIHwgMTIgKysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL21tL2todWdlcGFnZWQuYyBi
L21tL2todWdlcGFnZWQuYw0KaW5kZXggMmZlMjY2MzRlMWEyLi4yOTIyMTYwMmQ4MDIgMTAwNjQ0
DQotLS0gYS9tbS9raHVnZXBhZ2VkLmMNCisrKyBiL21tL2todWdlcGFnZWQuYw0KQEAgLTE2Nzks
MTAgKzE2NzksMTQgQEAgc3RhdGljIHVuc2lnbmVkIGludCBraHVnZXBhZ2VkX3NjYW5fbW1fc2xv
dCh1bnNpZ25lZCBpbnQgcGFnZXMsDQogCXNwaW5fdW5sb2NrKCZraHVnZXBhZ2VkX21tX2xvY2sp
Ow0KIA0KIAltbSA9IG1tX3Nsb3QtPm1tOw0KLQlkb3duX3JlYWQoJm1tLT5tbWFwX3NlbSk7DQot
CWlmICh1bmxpa2VseShraHVnZXBhZ2VkX3Rlc3RfZXhpdChtbSkpKQ0KLQkJdm1hID0gTlVMTDsN
Ci0JZWxzZQ0KKwkvKg0KKwkgKiBEb24ndCB3YWl0IGZvciBzZW1hcGhvcmUgKHRvIGF2b2lkIGxv
bmcgd2FpdCB0aW1lcykuICBKdXN0IG1vdmUgdG8NCisJICogdGhlIG5leHQgbW0gb24gdGhlIGxp
c3QuDQorCSAqLw0KKwl2bWEgPSBOVUxMOw0KKwlpZiAodW5saWtlbHkoIWRvd25fcmVhZF90cnls
b2NrKCZtbS0+bW1hcF9zZW0pKSkNCisJCWdvdG8gYnJlYWtvdXRlcmxvb3BfbW1hcF9zZW07DQor
CWlmIChsaWtlbHkoIWtodWdlcGFnZWRfdGVzdF9leGl0KG1tKSkpDQogCQl2bWEgPSBmaW5kX3Zt
YShtbSwga2h1Z2VwYWdlZF9zY2FuLmFkZHJlc3MpOw0KIA0KIAlwcm9ncmVzcysrOw0KLS0gDQoy
LjE1LjENCg==
