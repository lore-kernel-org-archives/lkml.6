Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486955-2-11331332475250718349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486955; b=P1hdUlt7UFCeCm61XD4glGu/lBfZNQAFelqZUiCKotJgg4k
    W2A8ceGU8ewr+aSBx/wJZVlif5zqTodNzQCcyRx8RvsjsGrY34TWPkA47bGh/U4z
    A1PgNu10Ca1hDImdn8BmaD2jJuYXC4wsLuOWPuJX2rqhNH6x3JJkgAB5XH45Agvi
    Q22BFiByw1VzOUQLzLSMakuFfsmo1tB3GzbkSEIdePyTr6w6f7GIeI2yNsthBTBA
    CWTMIFqojlLk/uaxQtNT+4XFU3aMmavEtSwPKQwj4RU4ccBekAnaQ6RxUzZF3dt4
    DcMZ0ashMF7GJsDiXHTe0ORHz0GvebKQxMJhMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520486955; bh=dn5qfcnEXrF/q8xSTBcnD4dKNPZrXAQw5dKA8v
    ibJi8=; b=kEP6eAXw3oTSh7i3U/4587bE1LUUrB6egGNZmGKIR4+mRBPlhG6vst
    4cPF2DD5uTvMyoOjocNLLqbGLJr5G/z9FDQjEJ+TfFfPgHBI7J1EbRsx2sYYt2ro
    dt7dv83gCAM/bM2mr3a2s88FTH9Yy7W3xG3It894oiOe5dd7lotJqML8uyFvrRva
    /FAef/d3PeslD9qCN+mL6axqo3r5D55FGjZnP+amFt13TZV0jvPAJIckuZwPH3v9
    bN0puzDiIvGtp3bqvyqb8ol6MwEru0+x5d0SOKy1pL6Nc6wQYPdoSZEzRgbksY6K
    sr+V/Yzxg/buMiFP1kpGW3ja8Ywy/UEg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lsZ6NSEw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lsZ6NSEw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbeCHFHA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:00 -0500
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:24832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755361AbeCHFG6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergei Trofimovich <slyfox@gentoo.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        H J Lu <hjl.tools@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 069/101] ia64: fix module loading for gcc-5.4
Thread-Topic: [PATCH AUTOSEL for 4.4 069/101] ia64: fix module loading for
 gcc-5.4
Thread-Index: AQHTtpqXOkMhNhwHRkW2LNsNReHpgA==
Date: Thu, 8 Mar 2018 05:02:00 +0000
Message-ID: <20180308050023.8548-69-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:AZPKItT8PUWQsQB5wcEy1WQHme5R28WEKCTl4fcfKoAMgNhcaBwc2FZkMLOsndwWMl9IHshZ41rpImnZJWMFidSCyCce1Dbc+8PgeQcei6HsJhqnp5RZg5Pg72502x1Fpj/tCYFpmioXJnSca4ruEJjECl2eBlDSLZ27XadHt1dDURWVCXiHUb10eEAa/RL/SURf5A64vaeK5LIIv47hPTtlcVjR47eae9B18p/Y9w7GkpfqiwHRsR1M555042Av;20:owBMrLUqmoxEUcY+RWEh3p85xN3TZLxFMmS6GKNoVpSTxufII1c836vsmVIp7JG1HAM429UfmrymkEcdesR8D2hhUsLrFIdZNCe8ryIvD0O7vpTit1tckuzK9MDjH0GXZgovLazDfr0694oHY7U8GMZWd4rfljL/2mqUM1r9yGY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e31997b-7ed5-4408-a667-08d584b26986
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077EA371A694C6676437C41FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(22074186197030)(89211679590171)(85827821059158)(183786458502308)(42262312472803)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(6506007)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(6306002)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(39060400002)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(966005)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: giBhP9tkRtgjIRq8+uVuCEgxYlyAXe9p8H/EjPPPRxFm4HoQgXS3PGcCH4DxOp0QBHr3bFxP2wDq0PIo0gK2ZBGeBXw+MbOD5Cj/JSLX2Bv3eLmjQSyoDjAgBE5KaejpAhE+h0ODv1Q/DF5YieREWmd9j4l3E6HTMzvsyCE5MFr5f3FNKO/0o6N/KpQzyOYDTfzozCbBp38M96EHAtTpqgf9dzurIyRkQfjbfu6cbY6SpUy6XkptUBZi90SnheTQKzqo1yO6pnS8QZZxKcAhmpVClfQrwSFbZc2RLLdYKHWJr7g7d7JTmgrNNttgNJnbCUUjc8Mj5x+vem5WICczGw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <32884D66A1754241866B5EC54031D7A2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e31997b-7ed5-4408-a667-08d584b26986
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:00.9169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogU2VyZ2VpIFRyb2ZpbW92aWNoIDxzbHlmb3hAZ2VudG9vLm9yZz4NCg0KWyBVcHN0cmVh
bSBjb21taXQgYTI1ZmI4NTA4YzFiODBkY2U3NDJkYmVhYTRkNzVhMWU5ZjJjNTYxNyBdDQoNClN0
YXJ0aW5nIGZyb20gZ2NjLTUuNCsgZ2NjIGdlbmVyYXRlcyBNTFggaW5zdHJ1Y3Rpb25zIGluIG1v
cmUgY2FzZXMgdG8NCnJlZmVyIGxvY2FsIHN5bWJvbHM6DQoNCiAgICBodHRwczovL2djYy5nbnUu
b3JnL1BSNjA0NjUNCg0KVGhhdCBjYXVzZWQgaWE2NCBtb2R1bGUgbG9hZGVyIHRvIGNob2tlIG9u
IHN1Y2ggaW5zdHJ1Y3Rpb25zOg0KDQogICAgZnVzZTogaW52YWxpZCBzbG90IG51bWJlciAxIGZv
ciBJTU02NA0KDQpUaGUgTGludXgga2VybmVsIHVzZWQgdG8gaGFuZGxlIG9ubHkgY2FzZSB3aGVy
ZSByZWxvY2F0aW9uIHBvaW50ZWQgdG8NCnNsb3Q9MiBpbnN0cnVjdGlvbiBpbiB0aGUgYnVuZGxl
LiAgVGhhdCBsaW1pdGF0aW9uIHdhcyBmaXhlZCBpbiBsaW51eCBieQ0KY29tbWl0IDljMTg0YTA3
M2JmZCAoIltJQTY0XSBGaXggMi42IGtlcm5lbCBmb3IgdGhlIG5ldyBpYTY0IGFzc2VtYmxlciIp
DQpTZWUNCg0KICAgIGh0dHA6Ly9zb3VyY2VzLnJlZGhhdC5jb20vYnVnemlsbGEvc2hvd19idWcu
Y2dpP2lkPTE0MzMNCg0KVGhpcyBjaGFuZ2UgbGlmdHMgdGhlIHNsb3Q9MiByZXN0cmljdGlvbiBm
cm9tIHRoZSBrZXJuZWwgbW9kdWxlIGxvYWRlci4NCg0KVGVzdGVkIG9uICdmdXNlJyBhbmQgJ2J0
cmZzJyBrZXJuZWwgbW9kdWxlcy4NCg0KQ2M6IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJz
LnNvdXJjZWZvcmdlLm5ldD4NCkNjOiBIIEogTHUgPGhqbC50b29sc0BnbWFpbC5jb20+DQpDYzog
RmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRlbC5jb20+DQpDYzogQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCkJ1ZzogaHR0cHM6Ly9idWdzLmdlbnRvby5vcmcvNjAx
MDE0DQpUZXN0ZWQtYnk6IMOJbWVyaWMgTUFTQ0hJTk8gPGVtZXJpYy5tYXNjaGlub0BnbWFpbC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBTZXJnZWkgVHJvZmltb3ZpY2ggPHNseWZveEBnZW50b28ub3Jn
Pg0KU2lnbmVkLW9mZi1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KU2lnbmVk
LW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
Pg0KLS0tDQogYXJjaC9pYTY0L2tlcm5lbC9tb2R1bGUuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNo
L2lhNjQva2VybmVsL21vZHVsZS5jIGIvYXJjaC9pYTY0L2tlcm5lbC9tb2R1bGUuYw0KaW5kZXgg
YjE1OTMzYzMxYjJmLi4zNmIyYzk0YThlYjUgMTAwNjQ0DQotLS0gYS9hcmNoL2lhNjQva2VybmVs
L21vZHVsZS5jDQorKysgYi9hcmNoL2lhNjQva2VybmVsL21vZHVsZS5jDQpAQCAtMTUzLDcgKzE1
Myw3IEBAIHNsb3QgKGNvbnN0IHN0cnVjdCBpbnNuICppbnNuKQ0KIHN0YXRpYyBpbnQNCiBhcHBs
eV9pbW02NCAoc3RydWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgaW5zbiAqaW5zbiwgdWludDY0X3Qg
dmFsKQ0KIHsNCi0JaWYgKHNsb3QoaW5zbikgIT0gMikgew0KKwlpZiAoc2xvdChpbnNuKSAhPSAx
ICYmIHNsb3QoaW5zbikgIT0gMikgew0KIAkJcHJpbnRrKEtFUk5fRVJSICIlczogaW52YWxpZCBz
bG90IG51bWJlciAlZCBmb3IgSU1NNjRcbiIsDQogCQkgICAgICAgbW9kLT5uYW1lLCBzbG90KGlu
c24pKTsNCiAJCXJldHVybiAwOw0KQEAgLTE2NSw3ICsxNjUsNyBAQCBhcHBseV9pbW02NCAoc3Ry
dWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgaW5zbiAqaW5zbiwgdWludDY0X3QgdmFsKQ0KIHN0YXRp
YyBpbnQNCiBhcHBseV9pbW02MCAoc3RydWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgaW5zbiAqaW5z
biwgdWludDY0X3QgdmFsKQ0KIHsNCi0JaWYgKHNsb3QoaW5zbikgIT0gMikgew0KKwlpZiAoc2xv
dChpbnNuKSAhPSAxICYmIHNsb3QoaW5zbikgIT0gMikgew0KIAkJcHJpbnRrKEtFUk5fRVJSICIl
czogaW52YWxpZCBzbG90IG51bWJlciAlZCBmb3IgSU1NNjBcbiIsDQogCQkgICAgICAgbW9kLT5u
YW1lLCBzbG90KGluc24pKTsNCiAJCXJldHVybiAwOw0KLS0gDQoyLjE0LjENCg==
