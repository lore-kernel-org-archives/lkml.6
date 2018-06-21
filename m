Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D13C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8994B21718
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="qgi5Ghpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8994B21718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933581AbeFUQwX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:52:23 -0400
Received: from mail-sn1nam01on0109.outbound.protection.outlook.com ([104.47.32.109]:30240
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933409AbeFUQwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOUvLMtSPOcyu/V6YpeGvRjtViOcUpm/RnWhRk05VCI=;
 b=qgi5GhpcB+ZZAUXApEcybTVBbuJynxK3v/0ceroZoKBPDhwp3pSaJjetwzY2NdjqsDq7E7avZe5Xo3BOTbpNstDZPZNCzqe805T+ZFpON4QslT9vTQs+L+SdQOk1cENAnI0hIUMwyHdokaa/f5P0bn9B67DH2xptzUnuF/GQysA=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2383.namprd13.prod.outlook.com (52.135.94.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.16; Thu, 21 Jun 2018 16:52:17 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::ec6d:477b:8073:fbb0]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::ec6d:477b:8073:fbb0%6]) with mapi id 15.20.0906.013; Thu, 21 Jun 2018
 16:52:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 4.18
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 4.18
Thread-Index: AQHUCYA2zgOMTYbCSUmja63qJkET6g==
Date:   Thu, 21 Jun 2018 16:52:17 +0000
Message-ID: <8d9108335a1528f8609bce75bd5c18874a382b1b.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.245.47]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2383;7:miu8z+eo6mC0qGwa/yHkrCVMGiiPPZXvgrCwp+OFTcWUaeqs6b+X9XrHR6DtFz4y88wk27IW45DsG/Uls87b5kqgPrTPRNvPf7TPD+PD4vBqCvLgBIyt66a3YDefLLv88DKv5Unc9xaBMPZJ798TlyqBalcdlt9wmvBftRUtamEGbAswnJyDjvjYSTkqV6oJFtmzbgJM88Se4zwjckipUvHGt3spWjBAx2YUXp/LDrdUozdI8B2XMqJ0+ZFlGlPz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3132813a-90fd-4b02-b15e-08d5d7975902
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2383;
x-ms-traffictypediagnostic: SN6PR13MB2383:
x-microsoft-antispam-prvs: <SN6PR13MB23836FCD17543929FD22CED3B8760@SN6PR13MB2383.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(5213294742642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR13MB2383;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2383;
x-forefront-prvs: 07106EF9B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(346002)(39380400002)(376002)(396003)(199004)(189003)(66066001)(97736004)(3846002)(2501003)(2906002)(5660300001)(186003)(6116002)(5250100002)(118296001)(99286004)(486006)(6916009)(305945005)(102836004)(8936002)(7736002)(2900100001)(2616005)(2351001)(316002)(476003)(26005)(4326008)(478600001)(1730700003)(81156014)(8676002)(81166006)(105586002)(36756003)(6486002)(6436002)(53936002)(5640700003)(6512007)(86362001)(3660700001)(54906003)(68736007)(3280700002)(106356001)(6506007)(25786009)(14454004)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2383;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h0tgJMFWl3vCg7aRVuLN2T7yJIm3bOiEdGgq0aIncJ9j2NaTA7PZg6guF7S/URIwYylJj6X0wPckMdTxWJiTKYu/rUgn12bUJ9kgn97bEGSqMYade7G5Hr12E4lH4gNveTYi7KHN/deQkdZ/oc+iAA0TYG+Ecmedl9L2pFGd8W4Q7ctqAZx8FkmBBFIcptV5AB86LIBthlqCZUz04kGFtiuQIgdYELlhBSsfPmSAWr6hG7ZwaYESw42cfQU/fQEvM0Uaw5ylm+djzy0ZzcvqENQl804YBbtf1STPGXj6LB4j1fr4IIWI762UpqjtlegyRX68q9odFBXmzzpXo5kHcA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B2CD105F4C38C4080F83E262A043590@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3132813a-90fd-4b02-b15e-08d5d7975902
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2018 16:52:17.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgOTNiN2Y3YWQy
MDE4ZDIwMzc1NTliMWQwODkyNDE3ODY0Yzc4YjM3MToNCg0KICBza2lwIExBWU9VVFJFVFVSTiBp
ZiBsYXlvdXQgaXMgaW52YWxpZCAoMjAxOC0wNi0xMiAwODo0ODowNCAtMDQwMCkNCg0KYXJlIGF2
YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5m
cy5vcmcvcHJvamVjdHMvdHJvbmRteS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci00LjE4LTIN
Cg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDdiMGRmOTJhYzEyMTQ4MDk4MzkxYmY1
M2YzNDk0YWYxNzgxMmYyNjQ6DQoNCiAgcE5GUy9mbGV4ZmlsZXM6IFByb2Nlc3Mgd3JpdGViYWNr
IHJlc2VuZHMgZnJvbSBuZnNpb2QgY29udGV4dCBhcyB3ZWxsICgyMDE4LTA2LTE5IDA5OjI1OjI3
IC0wNDAwKQ0KDQpDaGVlcnMsDQogIFRyb25kDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk5GUyBjbGllbnQgYnVnZml4
ZXMgZm9yIExpbnV4IDQuMTgNCg0KSGlnaHRsaWdodHMgaW5jbHVkZToNCg0KQnVnZml4ZXM6DQot
IEZpeCBhbiByY3UgZGVhZGxvY2sgaW4gbmZzX2RlbGVnYXRpb25fZmluZF9pbm9kZSgpDQotIEZp
eCBORlN2NCBkZWFkbG9ja3MgZHVlIHRvIG5vdCBmcmVlaW5nIHRoZSBzZXNzaW9uIHNsb3QgaW4g
bGF5b3V0Z2V0DQotIERvbid0IHNlbmQgbGF5b3V0cmV0dXJuIGlmIHRoZSBsYXlvdXQgaXMgYWxy
ZWFkeSBpbnZhbGlkDQotIFByZXZlbnQgZHVwbGljYXRlIFhJRCBhbGxvY2F0aW9uDQotIGZsZXhm
aWxlczogRG9uJ3QgdGllIHVwIGFsbCB0aGUgcnBjaW9kIHRocmVhZHMgaW4gcmVzZW5kcw0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQpBbm5hIFNjaHVtYWtlciAoMSk6DQogICAgICBORlM6IEZpeCBhbiByY3UgZGVhZGxv
Y2sgaW4gbmZzX2RlbGVnYXRpb25fZmluZF9pbm9kZSgpDQoNCkNodWNrIExldmVyICgxKToNCiAg
ICAgIHN1bnJwYzogUHJldmVudCBkdXBsaWNhdGUgWElEIGFsbG9jYXRpb24NCg0KVHJvbmQgTXlr
bGVidXN0ICg0KToNCiAgICAgIHBORlM6IEFsd2F5cyBmcmVlIHRoZSBzZXNzaW9uIHNsb3Qgb24g
ZXJyb3IgaW4gbmZzNF9sYXlvdXRnZXRfaGFuZGxlX2V4Y2VwdGlvbg0KICAgICAgcE5GUzogRG9u
J3Qgc2VuZCBsYXlvdXRyZXR1cm4gaWYgdGhlIGxheW91dCBpcyBhbHJlYWR5IGludmFsaWQNCiAg
ICAgIHBORlMvZmxleGZpbGVzOiBEb24ndCB0aWUgdXAgYWxsIHRoZSBycGNpb2QgdGhyZWFkcyBp
biByZXNlbmRzDQogICAgICBwTkZTL2ZsZXhmaWxlczogUHJvY2VzcyB3cml0ZWJhY2sgcmVzZW5k
cyBmcm9tIG5mc2lvZCBjb250ZXh0IGFzIHdlbGwNCg0KIGZzL25mcy9kZWxlZ2F0aW9uLmMgICAg
ICAgICAgICAgICAgICAgIHwgIDQgKysrLQ0KIGZzL25mcy9mbGV4ZmlsZWxheW91dC9mbGV4Zmls
ZWxheW91dC5jIHwgMjEgKysrKysrKysrKysrKysrKy0tLS0tDQogZnMvbmZzL25mczRwcm9jLmMg
ICAgICAgICAgICAgICAgICAgICAgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0NCiBmcy9uZnMvcG5mcy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrKysrDQog
aW5jbHVkZS9saW51eC9uZnNfeGRyLmggICAgICAgICAgICAgICAgfCAgMiArKw0KIG5ldC9zdW5y
cGMveHBydC5jICAgICAgICAgICAgICAgICAgICAgIHwgMTAgKysrKysrKy0tLQ0KIDYgZmlsZXMg
Y2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQo=
