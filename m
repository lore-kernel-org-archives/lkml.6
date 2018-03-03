Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116067-2-4023248849138504205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623, URIBL_SBL_A 0.1, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116066; b=M36i0JdZbrgskAUNsXnUXwxiBZa93x0jz+hyUtF6mRitGfN
    yTHBA6NX7ImCKO+J8gsEMg10ZGGa7CyhVbbrPiC4WVGidPJgPxurdt58VEf2Lk4b
    TIPfgqhL8f2Z6eZu6rdzleZltHR52Jw6MvipggPR6PVTDbGUdOhnFGKogQBDlgnk
    sSfXDRC6RaISQb+6nNs7DOWUCcJBdurufVi/Zv9sedn8c3uKLlS3hWL46QzrByW4
    kbVhNwVzi3np7oKZbEQuJfMQ2p9TDCbNP1MGAliWzwVv3GPTGzfTjAbgXrgbLbQ7
    Gv046AHXC3bCfwo6hdtlhNvROki5XpA3LT4vQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520116066; bh=UhhNu1j3AEdeaw8YtqPRC8L/aITCrznW2O0h3c
    R9dkM=; b=PexwTW6WOot6Lgr9IDnTR1PuRE70ddEyuzF268yWbtPk2qYwvL7rgr
    xFfQ3CDJ6AsA1hmf0s/pe3gPnp1FZ4SnUxqVdcZaVElM3mpnDP8a+JJFT5nLpo5L
    QcEsH2Ik/1vw5bDilpVRdR3YKbVX4s1ejoK53kYYSeO0Pc/M5EFE0UhvWrmm4flg
    5EM7ba/wFY1lNDYTcMVQKtxtbw44VTjT7AnmPJG1ckzDraCBl+xAZmCssXeE/UyH
    jjme0351+JExnAITSsZ5BVFWEfpSPSgxdSfdMMxxSsbTskCx0bPyzWT7pe+0vNAs
    r9Ste0qglhYyNgMj3UI3QdOpPlXKHZ8w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wz93czGw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wz93czGw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932872AbeCCW1I (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:08 -0500
Received: from mail-by2nam01on0137.outbound.protection.outlook.com ([104.47.34.137]:52173
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932848AbeCCW1D (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Julien BOIBESSOT <julien.boibessot@armadeus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 071/102] tools/usbip: fixes build with musl
 libc toolchain
Thread-Topic: [PATCH AUTOSEL for 4.15 071/102] tools/usbip: fixes build with
 musl libc toolchain
Thread-Index: AQHTsz5yl2DFw3fMmk2MaEAkBhO05w==
Date: Sat, 3 Mar 2018 22:24:50 +0000
Message-ID: <20180303222318.26006-71-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:0m9u8MNNF3KmjdWxjBkFq+2UNDoukv81qrFnxTdgWLs56qYAyDInYOAS1NPK/LtbzJqOHH3dk119WooT1F2LQbE6zPk0qlXgqN+BGZOQTun+6bwE0ZDfESOfwZgKadHCyI/0LxKx1SL70tZhavn26BI5xg0V/8nxST5bjbVsny3bjFwntEbuqHO9S9iHcHnZo/eyCWzbKzoqv3P2Ulnv6Luhc2OL1X+qZ7isIdQuv7fhh9qhtchDby90GDFdEyzy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d345ac94-4f09-430d-91a0-08d58155e116
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06CB2CB436231C634522CAFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: mIs7maTozAOx5sok5paLRABrhv80ujJiztO2tCXNWAxeseWg14/s/sVcsDn+XmU4CINd0G5H0jMZLEFvzADK45HpFz6/MmsvqZNEWbVUPslUAsU9A4xszX+dvMKRKvKm8aJ6YPEgf4Cyk7xXBQhy7d2X3xtIB1/wkkUq7KIf4A0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E040A46BF03F9499D9FCB5293CFA13C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d345ac94-4f09-430d-91a0-08d58155e116
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:50.6503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSnVsaWVuIEJPSUJFU1NPVCA8anVsaWVuLmJvaWJlc3NvdEBhcm1hZGV1cy5jb20+DQoN
ClsgVXBzdHJlYW0gY29tbWl0IDc3YmU0Yzg3OGM3MmU0MTFhZDIyYWY5NmI2ZjgxZGQ0NWMyNjQ1
MGEgXQ0KDQpJbmRlZWQgbXVzbCBkb2Vzbid0IGRlZmluZSBvbGQgU0lHQ0xEIHNpZ25hbCBuYW1l
IGJ1dCBvbmx5IG5ldyBvbmUgU0lHQ0hMRC4NClNJR0NITEQgaXMgdGhlIG5ldyBQT1NJWCBuYW1l
IGZvciB0aGF0IHNpZ25hbCBzbyBpdCBkb2Vzbid0IGNoYW5nZQ0KYW55dGhpbmcgb24gb3RoZXIg
bGliY3MuDQoNClRoaXMgZml4ZXMgdGhpcyBraW5kIG9mIGJ1aWxkIGVycm9yOg0KDQp1c2JpcGQu
YzogSW4gZnVuY3Rpb24g4oCYc2V0X3NpZ25hbOKAmToNCnVzYmlwZC5jOjQ1OToxMjogZXJyb3I6
ICdTSUdDTEQnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0KICBzaWdh
Y3Rpb24oU0lHQ0xELCAmYWN0LCBOVUxMKTsNCiAgICAgICAgICAgIF5+fn5+fg0KdXNiaXBkLmM6
NDU5OjEyOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5
IG9uY2UNCglmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluDQpNYWtlZmlsZTo0MDc6IHJl
Y2lwZSBmb3IgdGFyZ2V0ICd1c2JpcGQubycgZmFpbGVkDQptYWtlWzNdOiAqKiogW3VzYmlwZC5v
XSBFcnJvciAxDQoNClNpZ25lZC1vZmYtYnk6IEp1bGllbiBCT0lCRVNTT1QgPGp1bGllbi5ib2li
ZXNzb3RAYXJtYWRldXMuY29tPg0KQWNrZWQtYnk6IFNodWFoIEtoYW4gPHNodWFoa2hAb3NnLnNh
bXN1bmcuY29tPg0KU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIu
bGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIHRvb2xzL3VzYi91c2JpcC9zcmMvdXNiaXBkLmMg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS90b29scy91c2IvdXNiaXAvc3JjL3VzYmlwZC5jIGIvdG9vbHMvdXNiL3Vz
YmlwL3NyYy91c2JpcGQuYw0KaW5kZXggMDA5YWZiNGEzYWFlLi5jNmRhZDJhMTNjODAgMTAwNjQ0
DQotLS0gYS90b29scy91c2IvdXNiaXAvc3JjL3VzYmlwZC5jDQorKysgYi90b29scy91c2IvdXNi
aXAvc3JjL3VzYmlwZC5jDQpAQCAtNDU2LDcgKzQ1Niw3IEBAIHN0YXRpYyB2b2lkIHNldF9zaWdu
YWwodm9pZCkNCiAJc2lnYWN0aW9uKFNJR1RFUk0sICZhY3QsIE5VTEwpOw0KIAlzaWdhY3Rpb24o
U0lHSU5ULCAmYWN0LCBOVUxMKTsNCiAJYWN0LnNhX2hhbmRsZXIgPSBTSUdfSUdOOw0KLQlzaWdh
Y3Rpb24oU0lHQ0xELCAmYWN0LCBOVUxMKTsNCisJc2lnYWN0aW9uKFNJR0NITEQsICZhY3QsIE5V
TEwpOw0KIH0NCiANCiBzdGF0aWMgY29uc3QgY2hhciAqcGlkX2ZpbGU7DQotLSANCjIuMTQuMQ0K
