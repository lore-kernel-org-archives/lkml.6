Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122348-2-11360622474759905846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES caenro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122347; b=W7qb6aLApUMQPSurWxkyrF+oP+EArXFDYAC9de7G3Cq63jZ
    YzvHuJuY88IJtnckGCyS4H+RNaFm/sEgFYmsy+3AKbD6u09ZMwBjMIM17i76MlkB
    uoi+qZyf8CkMaE4DDYvSRn+MzcDFnVKJx5ZXeno5ArbP189Irf7DttrbTIzT0bZs
    /kdyZ/wf/H8ShpNwCoVM3aeRbgC/wM2HTLvewQel292BiDyPbgqqMHPOSkYJC0uH
    5onkECdVegwE/FkmepvwSFzEQx1dCH+RkDDZM86Ds6HQhw67Dl6cl3WwDj7EjoY7
    iqZEGem/+tUm9QtfuNVkHaZPYcOvhnekLJjkQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520122347; bh=erQh4GvZGSN7yWpdShY+Ni1hn/t5QCDGOoRjAX
    8eg1U=; b=J9rxp2BbW4kwlAoS+XxTDuU0UVYsX/eS+cyGBLc8Zv6yiBAyCKrAvP
    Egqq3oKpq+e5z0DK2273qvZ+U8KwOANrBeNFyQVEwhJW9/gIkU5wrQRyPXl6Nuka
    RRPispiYlcXxEaiNCzpSGbSDNQMGNU2FmHNjsK88xkObzkY66UjUs10MxnogKp8P
    Gfu2Se5vocqXbF28MzYAVYeY66pjJntBoZv1NY4nrK0OpGrD6A3vbH+9vcEMN2RZ
    kq39pKnmGCbjpetQvodOyVRUc3qXXl8cj/sO4jyUHQJisculvldeB1prjLLPdY11
    JZZ+PSfv7bdzCed597y5QfBtJHoMeojQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sx+bVpOr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sx+bVpOr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933401AbeCDAMV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:12:21 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932968AbeCCWaw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 75/84] crypto: caam/qi - use correct print
 specifier for size_t
Thread-Topic: [PATCH AUTOSEL for 4.14 75/84] crypto: caam/qi - use correct
 print specifier for size_t
Thread-Index: AQHTsz61UFEsYtLez0OLahw7K76gIA==
Date: Sat, 3 Mar 2018 22:26:44 +0000
Message-ID: <20180303222518.26271-75-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:4G36RTACfwa4ioCRKwaW90Oei/MwRdpVHaawSMY9BljPNQOs77hcmdNHAQRV+yMtdGsV86w805/WzwSUC0CPpVzuoglUHRnGweVolzAfXAcpj1kropaN1er9196Z2oYhkKtlc82a8S66lrNCL1uwLkx7LVx7IjK1XBqvVuAYlwA1k9Lio3soHaJgAkMT9s4UknBfOPdQobs0MENIs6xpON1/lh5EdzesiRaAxPISePogwTXrGOQgdguyL+M7fQyL7TY8IG3kC1DsClme0LQ6Vj6Vd7waOchj+GbViE3o2aHHKhjMH3o5Igc+TSYEUk+9dpMRCPg3hB2CG5whTNIwRuaCLvA9kcBWgPNzUnKTE7zzZ4pfFvVn1hhypL/Xjf6Y;5:6F+1sEqN057ctlhDGp9MP+bZ4haoLEJpUrYkG3OAdaaNjKkIy+wNsIlVzxuVTydONIM0g7lufDgwwgL4fWdwxlHAaq2AOV/0tbuw78QKulUGTEW4+OSauULMvu/X0HBjHbmeeSpt/RcEMWK/xCr+9GDHyM2O0t7UFB+AAACpMeo=;24:ozOIRT1XyE5aheRD1fGonIN+sKfhTwVXFu6XEjuxEpObOlxxVq6fPOCotqIaeWlaVUd18jarLVJ4jAVnvOX5mjjuoBMJBfoOrAqvoQmmW0E=;7:nMIr2ihM9xZ4bb/Wn7kqbvhFdzVV5GHOmRIgpwbFQ6VTAVIbroevEItSuHr1wH7mhCqmW6iLHo8p/E649S3n8VJ1oWsH7sSXeX9dAnCHWP6ppHb+EJ7h5NLZnJ6KcV3AMPElSGD/xd7BFEAyl+OtE3bxu/8atinhO/zB7CRHTr/T3rf0Ka8uLR22PFlmcO8x8jKgqoFNY6lXE5FoauQRf7Gi49qfmyXS+Ngtwj/+lhPjRRW7CDDZSUqfWcbG8d6d
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfa43e57-815f-4ae7-374b-08d581566a4f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115F0B99A1ED663B6B7067EFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(8656006)(22452003)(86362001)(22906009)(217873001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HHtQhUwDfPtyjQHFyyz5yPUqyH7s+tkEq4TSVwp6V1w30S59GxZraBE6Aio9m+sqUGbqhOzWfgyPYlJVA9kGYbt6OOLLfXA1od2V2SIPQcadqiqUVY7GSJcxpPjEwLa9mPmzQt6DxXIRKRrMAprcNyzrLZuMjRoY6iZugGQfdW8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D82BB75C94D045489CC4139A3C86638F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa43e57-815f-4ae7-374b-08d581566a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:44.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSG9yaWEgR2VhbnTEgyA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IDlkYjA5ZTNiYWQ2NTM5M2RjMjNiMDI3OWJlYjdmMzc1NGQ3NzA2NWMgXQ0KDQpGaXgg
YmVsb3cgd2FybmluZ3Mgb24gQVJNdjcgYnkgdXNpbmcgJXp1IGZvciBwcmludGluZyBzaXplX3Qg
dmFsdWVzOg0KDQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYzogSW4gZnVuY3Rpb24g
YWVhZF9lZGVzY19hbGxvYzoNCmRyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5jOjQxNzox
Nzogd2FybmluZzogZm9ybWF0ICVsdSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUgbG9uZyB1bnNp
Z25lZCBpbnQsIGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIHVuc2lnbmVkIGludCBbLVdmb3JtYXQ9
XQ0KICAgc2l6ZW9mKHN0cnVjdCBxbV9zZ19lbnRyeSkpDQogICAgICAgICAgICAgICAgIF4NCmRy
aXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5jOjY3MjoxNjogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvIENBQU1fUUlfTUFYX0FFQURfU0cNCiAgICBxbV9zZ19lbnRzLCBDQUFNX1FJX01B
WF9BRUFEX1NHKTsNCiAgICAgICAgICAgICAgICBeDQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1h
bGdfcWkuYzogSW4gZnVuY3Rpb24gYWJsa2NpcGhlcl9lZGVzY19hbGxvYzoNCmRyaXZlcnMvY3J5
cHRvL2NhYW0vY2FhbWFsZ19xaS5jOjQ0MDoxNzogd2FybmluZzogZm9ybWF0ICVsdSBleHBlY3Rz
IGFyZ3VtZW50IG9mIHR5cGUgbG9uZyB1bnNpZ25lZCBpbnQsIGJ1dCBhcmd1bWVudCA0IGhhcyB0
eXBlIHVuc2lnbmVkIGludCBbLVdmb3JtYXQ9XQ0KICAgc2l6ZW9mKHN0cnVjdCBxbV9zZ19lbnRy
eSkpDQogICAgICAgICAgICAgICAgIF4NCmRyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5j
OjkwOToxNjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIENBQU1fUUlfTUFYX0FCTEtDSVBI
RVJfU0cNCiAgICBxbV9zZ19lbnRzLCBDQUFNX1FJX01BWF9BQkxLQ0lQSEVSX1NHKTsNCiAgICAg
ICAgICAgICAgICBeDQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYzogSW4gZnVuY3Rp
b24gYWJsa2NpcGhlcl9naXZfZWRlc2NfYWxsb2M6DQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1h
bGdfcWkuYzo0NDA6MTc6IHdhcm5pbmc6IGZvcm1hdCAlbHUgZXhwZWN0cyBhcmd1bWVudCBvZiB0
eXBlIGxvbmcgdW5zaWduZWQgaW50LCBidXQgYXJndW1lbnQgNCBoYXMgdHlwZSB1bnNpZ25lZCBp
bnQgWy1XZm9ybWF0PV0NCiAgIHNpemVvZihzdHJ1Y3QgcW1fc2dfZW50cnkpKQ0KICAgICAgICAg
ICAgICAgICBeDQpkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYzoxMDYyOjE2OiBub3Rl
OiBpbiBleHBhbnNpb24gb2YgbWFjcm8gQ0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRw0KICAgIHFt
X3NnX2VudHMsIENBQU1fUUlfTUFYX0FCTEtDSVBIRVJfU0cpOw0KICAgICAgICAgICAgICAgIF4N
Cg0KRml4ZXM6IGViOWJhMzdkYzE1YSAoImNyeXB0bzogY2FhbS9xaSAtIGhhbmRsZSBsYXJnZSBu
dW1iZXIgb2YgUy9HcyBjYXNlIikNClNpZ25lZC1vZmYtYnk6IEhvcmlhIEdlYW50xIMgPGhvcmlh
LmdlYW50YUBueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogSGVyYmVydCBYdSA8aGVyYmVydEBnb25k
b3IuYXBhbmEub3JnLmF1Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5s
ZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9jcnlwdG8vY2FhbS9jYWFtYWxnX3Fp
LmMgfCA2ICsrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYyBi
L2RyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5jDQppbmRleCAyZWVmYzRhMjZiYzIuLmI2
NDhlMzE2NzNmOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbWFsZ19xaS5j
DQorKysgYi9kcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1hbGdfcWkuYw0KQEAgLTY2OCw3ICs2Njgs
NyBAQCBzdGF0aWMgc3RydWN0IGFlYWRfZWRlc2MgKmFlYWRfZWRlc2NfYWxsb2Moc3RydWN0IGFl
YWRfcmVxdWVzdCAqcmVxLA0KIAlxbV9zZ19lbnRzID0gMSArICEhaXZzaXplICsgbWFwcGVkX3Ny
Y19uZW50cyArDQogCQkgICAgIChtYXBwZWRfZHN0X25lbnRzID4gMSA/IG1hcHBlZF9kc3RfbmVu
dHMgOiAwKTsNCiAJaWYgKHVubGlrZWx5KHFtX3NnX2VudHMgPiBDQUFNX1FJX01BWF9BRUFEX1NH
KSkgew0KLQkJZGV2X2VycihxaWRldiwgIkluc3VmZmljaWVudCBTL0cgZW50cmllczogJWQgPiAl
bHVcbiIsDQorCQlkZXZfZXJyKHFpZGV2LCAiSW5zdWZmaWNpZW50IFMvRyBlbnRyaWVzOiAlZCA+
ICV6dVxuIiwNCiAJCQlxbV9zZ19lbnRzLCBDQUFNX1FJX01BWF9BRUFEX1NHKTsNCiAJCWNhYW1f
dW5tYXAocWlkZXYsIHJlcS0+c3JjLCByZXEtPmRzdCwgc3JjX25lbnRzLCBkc3RfbmVudHMsDQog
CQkJICAgaXZfZG1hLCBpdnNpemUsIG9wX3R5cGUsIDAsIDApOw0KQEAgLTkwNSw3ICs5MDUsNyBA
QCBzdGF0aWMgc3RydWN0IGFibGtjaXBoZXJfZWRlc2MgKmFibGtjaXBoZXJfZWRlc2NfYWxsb2Mo
c3RydWN0IGFibGtjaXBoZXJfcmVxdWVzdA0KIA0KIAlxbV9zZ19lbnRzICs9IG1hcHBlZF9kc3Rf
bmVudHMgPiAxID8gbWFwcGVkX2RzdF9uZW50cyA6IDA7DQogCWlmICh1bmxpa2VseShxbV9zZ19l
bnRzID4gQ0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRykpIHsNCi0JCWRldl9lcnIocWlkZXYsICJJ
bnN1ZmZpY2llbnQgUy9HIGVudHJpZXM6ICVkID4gJWx1XG4iLA0KKwkJZGV2X2VycihxaWRldiwg
Ikluc3VmZmljaWVudCBTL0cgZW50cmllczogJWQgPiAlenVcbiIsDQogCQkJcW1fc2dfZW50cywg
Q0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRyk7DQogCQljYWFtX3VubWFwKHFpZGV2LCByZXEtPnNy
YywgcmVxLT5kc3QsIHNyY19uZW50cywgZHN0X25lbnRzLA0KIAkJCSAgIGl2X2RtYSwgaXZzaXpl
LCBvcF90eXBlLCAwLCAwKTsNCkBAIC0xMDU4LDcgKzEwNTgsNyBAQCBzdGF0aWMgc3RydWN0IGFi
bGtjaXBoZXJfZWRlc2MgKmFibGtjaXBoZXJfZ2l2X2VkZXNjX2FsbG9jKA0KIAl9DQogDQogCWlm
ICh1bmxpa2VseShxbV9zZ19lbnRzID4gQ0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRykpIHsNCi0J
CWRldl9lcnIocWlkZXYsICJJbnN1ZmZpY2llbnQgUy9HIGVudHJpZXM6ICVkID4gJWx1XG4iLA0K
KwkJZGV2X2VycihxaWRldiwgIkluc3VmZmljaWVudCBTL0cgZW50cmllczogJWQgPiAlenVcbiIs
DQogCQkJcW1fc2dfZW50cywgQ0FBTV9RSV9NQVhfQUJMS0NJUEhFUl9TRyk7DQogCQljYWFtX3Vu
bWFwKHFpZGV2LCByZXEtPnNyYywgcmVxLT5kc3QsIHNyY19uZW50cywgZHN0X25lbnRzLA0KIAkJ
CSAgIGl2X2RtYSwgaXZzaXplLCBHSVZFTkNSWVBULCAwLCAwKTsNCi0tIA0KMi4xNC4xDQo=
