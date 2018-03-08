Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486225-2-18102391493904386880
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
    t=1520486224; b=HgJo5WphWX6ILTslrjGQLUJZ7XOrbagrXK2uvVPk31MyU4Y
    NzDnsTgt0JbJbsQGbOsvSynK8aYvfUbTkMedswkqhU0o+zXP2SpaitF2onPW4v7V
    0ueKl4CelCGEHwFW9/E3S8l1FWJVdf/itTuznz/BRnsqbr6L6ftnbhVKUwewsox1
    Jgfd+xRu374iDJkQtseU8aTkKXfPrjcrTsTo+dbkucrXYSsI9q61kYBgQw1bhxvi
    IITR3p6BLbobqfiWrKPqgaKQpdvS1u75J8het884Nc8v/L22N+eZFGOsfRIDPI/L
    o17mhfQQrrJTEs4Dz6U5TkwH8Mq2WtMRn66ldzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520486224; bh=dykBgtnvXKPTods6mbTc4TVauKKF/XIWqsz+kY
    dOTso=; b=cX7OIABWTFWCwH4Odc98lE2b3Ob2faQPtnk/PozqVFhLptJwOtcBZd
    mKekz+hOzvN36ROuP8NNugSHJzQjce9Tft2WIeoesknwtMX/1oCJ5CVGJo/Vw0SD
    G9Z1MsSam1IXYHSh++6wJqKK/WDix/0l5j8NXHRYbIw0DP8OxKELfsAIVy+N3388
    xIFR9WKjYr0cxrrESnF1Z1PimKZSOrJ97UkwshQIFU56/DJA5no0Cx4RpiBmPUqG
    +Mbl81mlt0aNMHVz4WwZ7wknRCstuUQy1deAEFxvH3zJ1OPGjupRAJaj4x55SBRC
    ZLjdBR9yTdjlzLqmwyGK15ICyv5I6twg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IWdpmb28 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IWdpmb28 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeCHFQs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:16:48 -0500
Received: from mail-cys01nam02on0137.outbound.protection.outlook.com ([104.47.37.137]:8100
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751971AbeCHFLh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:37 -0500
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
Subject: [PATCH AUTOSEL for 3.18 40/53] ia64: fix module loading for gcc-5.4
Thread-Topic: [PATCH AUTOSEL for 3.18 40/53] ia64: fix module loading for
 gcc-5.4
Thread-Index: AQHTtprJAtEYu9iEBkiSYFm8DSMUfA==
Date: Thu, 8 Mar 2018 05:03:24 +0000
Message-ID: <20180308050230.8876-40-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:iZKPGTdGwtbM0Rzabg4eH3NhyCLGnTlxuhbcPltfPbaX55Pm/lfM/v2CXq8JmQ+JzvtSXIuB0KSRQfKStjXUwndKQj2N0rMI1akmukpU8BJ7O2I+Zra8rqabmRSXXT3uvrdDzzMy1iwctk1ZDpk83MdXb9KwKTFKj3mbWx7Vm6cX4ACNZd0ZC9AuBt+t4ZolqyvH1qUQfyJ6ffaQ3y1l6j2ezmp4lhyeFP7iGscrmfgiCXV4tPBVpWvbnTZRhTQV;20:sKxxgJghi/i5ymcpbPB4MaAn6HATgpooOHjKessNy/mDMUlDAEwqCtzUi5GoxPfVQnTgxQ7Nu6EmqYU7ofq0TLiaiUk8DTGUFoVnOBZrkAx9BKyDE86dh9lcCPenNx1JftYCEafK4UBHebvAtZvFHesHKgfaJwmgMAHWEXPmMPM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3324b34-234a-404f-7b43-08d584b30f6f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10304757B7410774A2D4B32EFBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(22074186197030)(89211679590171)(85827821059158)(183786458502308)(42262312472803)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(39060400002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(6306002)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(966005)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +Z1Z6ooctdSeC+d3PQeKGjFupeXFR+zF0Qo0jmsRa1Z8R+noWFWfbTHyLfiX2JETJqLNn/FuQWxxmI46Rsfu9i2n2oNDVuYJeTrT3eiS0jiAR4FIDerj4OVM/cAZRksII/ADyni3WOFxHBLI6m5hG44t/nTFLGZs1UcbBvtxbA2v0ZbHGj0rK3Z+Z17lEbVkfiT4m4GAXI81Nnh17yA0iL/04weG5CNxPMUDfct4iUlkJW5EkDlMUdgMfN9MIBDOWTPCF8FXp3/AFOv3DX7RjNJR96lv48uWEBTk2hE6RHEhKjY+OcjAQ4KXWH8SEK8MHcTHbegicbrUBAmKwhFXqA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF84606BEFA3D04DBE468DD62CB29974@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3324b34-234a-404f-7b43-08d584b30f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:24.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
MjQ2MDNiZTI0YzE0Li42N2YwOWI5M2RhYjcgMTAwNjQ0DQotLS0gYS9hcmNoL2lhNjQva2VybmVs
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
