Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245725-2-10250355346760458289
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
    1523245724; b=VveH3aLYHOBBgCi9hnHYa/QbjLNfLXt5PMwJLKBw0TKJHlYHjF
    s5hOjrAAFbhSjhnljnJtmsENVSD7sHz3/D/xguAYadSH2tigfOjtWFAQsxpMbvzC
    Re0cBPIewyPNKsR/AYmtSuA2PONVauTIgZ1pk2cxQIidun/roxParmgmUJbPZE61
    qWrWzP9bqO5IFYdEBKtMaPgiLAgwFG14Zc2nJnp5AkjQAlnu059Kg3twgwgpy2xa
    ywC2paeD7HLKdvRTw9fdyYhi22L1yZcqpuH7NNL+GdkhxaXq1zr+NMNKkXjOu7Wh
    h9WucZfh4zGadk4YHABTFWjEusmhhVyV7k5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523245724; bh=wLr6/0wG8qF+vQCjuBgCUqkqm415+5u9wnPf3iNKubo=; b=
    SE6fAD5Bl8ODBe0zKgquCdwOCaKLYJJY6sikNGeenDFFNqxGWHxQ48wUjwzSBbQ1
    xPH5fTqH8NAzEILUDvz6i3qLqeo0DI8QSR44dHyu7Hlu9dtnxgbO6FioWNfpb9el
    NA0RbL9sxu8gBskba6/r+GX+Cn6BZJuBJ5G+EiN79tcU1vmooXjSaGynuZ2VxvC0
    yC5uVNwht76VhuVAeuaA5ccZlCcJl6x9crr7LViEWjoxloK3cxx0RC7RO2vizl1m
    3uI3D6hREUQi3QHhWOcROsgJbKxfysjKrJ++DPCpt1cWILFOK+ml955huDOC1jeA
    ieOK0tzArGppqMlMk0tygg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F9cZSiqd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F9cZSiqd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFJSVZ0+uRUx8Pc2TfWTcrODQjXLCOB3qLIr1eny61dahR8ByKrC2/xZv8Cf2FRyd+CrhjCleC+tgMfoIAGT05J5qaS40b5BzKJLJVY2OCK78Pp73aR8
    phSk4iUrf2XHuyHdXoxYKmBDfdcJkjyJJLI5C/QBHaJUnNK4QuCXm2ZXy9ZmWZU2vmhH7XbExyJ4WHiFPlkl7wMhTNUNfrsSQ+1dEtDExFr1QgP2gBPC70Jp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1752392AbeDIDs3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:48:29 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:5792
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754125AbeDIAUG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yang Shi <yang.s@alibaba-inc.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 123/189] mm: thp: use down_read_trylock() in
 khugepaged to avoid long block
Thread-Topic: [PATCH AUTOSEL for 4.15 123/189] mm: thp: use
 down_read_trylock() in khugepaged to avoid long block
Thread-Index: AQHTz5hGBES3r6FwU0KoNm0YpSZ2gA==
Date: Mon, 9 Apr 2018 00:18:25 +0000
Message-ID: <20180409001637.162453-123-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:kaWJV73N58GVgQ873eD1QZ/zNXAJjfAjq68pV7iRnZicfMYiB9bNxBWYxKoqcIusGDbIsyDnGtpNtxvMi54AOVp0fdQcxrPQ2ebeUliyUk+47vbk4KiT1L6ov+Vo2TV6svnvMJuT/e+2YNCL2ZW6lg7iEHxxG2xsY6D6Je+HqUSsW1kDYzXGxR+g6zCGJXj6emiSu2UIC+XqvlX79t+icvlfwH/PnqFbCISOaqH3pqepxEu9NB7shatqKNLhjEx0;20:xgYgaxKTqLf9/UKR3OJjFrrm5RyzkAqFSmHxuQpAERjaMGizzbO8gIfv4TlvE3ThLRWCTAAi38m8zzRHw+RTtpCxFZE80BlcQoIOpyvzEVslaIuyXgP0LheSXK8IL3bpD0nk2Esm78LVFQTi4OyEYFAQT1vR2jpyXg818EsXTrM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45e8ad3f-d697-41fc-6206-08d59dafa41a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726665116AF561F5BEC59A7FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6306002)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: n898Jh2I3EOojnI/F1tWcrvoozc/pC+Ew4AZkPE748l6jLEBihGSOnCQ1WSyHEhbrMkDfSdKoPr0ke2m3b2UHpCB2R6EVsRs/9LBj4NOwzJBRzPKXdT0p3YnUDzkWL0KgKcw1DEHsIXpn1OcIFzZOEXzIIMjpGlxFR4m7tJ7gXD+Rt4R1pQyXjohSLhLHIYpazFI6XNVO4mP/QlgzcKP4e632Hn+M8IjVaHafJtwNm5ybhkEVn1ttNC5GYKk65nV4I4fcwC5uyLf9odU6YQeIpC/HcBhvBN9jyWqTmNy4MKNyfTAm5kBT0RI2kfoRjrug773Jt8nm8ZNe0mYqLK8hWSRyPbJ7QI+ShTiVWZV8wixLd0DSw7gRrjb89CsVKgVt/gjbJGHn+VWogQ6JbQZPSnrzSJV2dWN5jKIJF7AEkY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <813E8B80C860CD46BD5B35643F0A0CA6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e8ad3f-d697-41fc-6206-08d59dafa41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:25.2541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
L21tL2todWdlcGFnZWQuYw0KaW5kZXggMzMyNTViZjkxMDc0Li5jN2Q1NjI0ZTIzNzYgMTAwNjQ0
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
