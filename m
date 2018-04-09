Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237224-2-4873269483766722733
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
    1523237223; b=EAmN2Z7wJEi6TpzqYmLZMHq3FHwE5XVt/fp77Lstdl/hyPd9yk
    Q58xCtAmcWr3AyUljZ+idb9mi4WBwYlMJhEYsX3cJJcobPTu/7ZO+RW0D1rXusm6
    4AAzo08gCu7qHOCjKKYWfUmXHwOb69lG9Lf2AhddbVTJddSquLzf1LpJtfNJZm8L
    YGLzcPpVTySlwGvuDGF2XZ1PFadUgHnWrnCkJdtSnkIRutRJnubqy+JUnrQUQpe3
    M2Cl2yVpXzpC7wHxSWQS8I+ZKHW3BQmRuho9oaIqRMwpITWr317DGpH5lTXTnOv3
    vEDd1tpj0af0tBBQPELPDt4s5I3OghVMTmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523237223; bh=ESMJ6Oy+IRWnPha/WfTOoIBnjTt+ymZsxoxD4twEwUA=; b=
    cRL7Tdj9JuQTWN3HY0i6uztlJzRSlSmiwK9tBZmgPOc+jWGx+uURTzMc4cpwjeuU
    vPP/l1UZb6sKNxguNzTrc2HH6+c2A9IrfascKz0P0yJRMeIav1vqchUeVfJnshXy
    l6wXdRCuRjo1Gv493yuIIWw+xPDGehAPd7wPtNTbh7+dHo1W5mXIqAw2s1xrU29S
    day5AZy8LM0SrHV+J4+g4qCeh2ukBAa++sQkYdUa3cOZbUWDRi82F4L0VDabr2Ym
    f9436ptfTavbQMbPoWBTK1RQdRS+Q83JABZPbCpKMinxzpN0SF6bNW+d2HM4wI1O
    J2t95VdULgfEfhnnvFLwZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DqdN3wS1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DqdN3wS1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGg5/69ST22nZj8sqt0FKyKCE3OtIACpzOWT/2Qr6AcyYx4bSvVzA3F05usHCx8//FTtcCrfv3h8Hr+fi1shNIG6Oy4y0w4yLPTw+XjWPBWWU2npWh+m
    5Xz9LBaHiTftopL6I4YlBEHm5GejWMEu5MCdcSXu9710SHuQq4iJEHlchgH5XINGqEC0adB5u5Aj81LAxt4qbxGUe+bV3WXlgF8Y7yHeh9MNkbr1acgyxyv0
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=3Ch9cZZwAAAA:8 a=8AirrxEcAAAA:8 a=yMhMjlubAAAA:8
    a=OX_5Z3w97m8VyYvk8n0A:9 a=QEXdDO2ut3YA:10 a=qaWmjqwTrqMQxh53mpKG:22
    a=ST-jHhOKWsTCqRlWije3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeDIB0q (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:26:46 -0400
Received: from mail-sn1nam02on0107.outbound.protection.outlook.com ([104.47.36.107]:45025
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754568AbeDIAgq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 062/162] i2c: imx: Use correct function to
 write to register
Thread-Topic: [PATCH AUTOSEL for 4.4 062/162] i2c: imx: Use correct function
 to write to register
Thread-Index: AQHTz5mtf69fqW0jMEuwfOCDK42XlQ==
Date: Mon, 9 Apr 2018 00:28:27 +0000
Message-ID: <20180409002738.163941-62-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:LJLWY+2UUrGTKUV69Vn2q3OfYLVccZRvMgQ7KYCbSWwURrvtq/PhIkimqsazJEGq2eYw0QupHMdXLarCentNFM3ubpysrzRcWo7bfrpe8lKCDBkqYWZEGuNqBM0EZBO7rr12Mw6jm2eARfCCXDJKOx444fShjWd//hUe2R5veBjoJsjquILwEGNlFYIHU1n+MKJnCuosZUkfO0kaPhAnXHXPM/Sd+5jcSDAQxwYPuosE78dzSZzi7rk2rk7AC0yT;20:S1KFxOPA6VS46MHs06ZN4BD3l+S6oEPe2mxboKjsaxNhWuGZwQcnMNrFuO/7nEbmCu+O0f8hNXrkCJkPJaUmg9dFGBmGSE0Rl3mMZnMGnneyQeftxOEuw8di9ZyxG0Wa97yQiszva5GLdFvuO0KdLmy5spCM5by1/Ngn21lA3Ko=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 953c0477-cdc8-4c47-fa9f-08d59db1f8a8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08852AF70E77F925727C03F6FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(575784001)(3846002)(6116002)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jEukBVb+0ZWzdZlXi5UXLdD1eNZZfNKMMCPxUvc5PG3AjHZjmoKXRbW99GIBOLkAPqYcLEXMop7/Po62b3wfWL/VkDt9RMdq9YNN0KdoibSKKchd9IvWBkYqWkpTaDZnpmutElzEohOjERNNf4YQ0RxyBljEhNt944Qa7+KS3aE4kdQXTGxzmVFIw5Zr43T/d/YyS8AklitRzXM9DCzHwL6uO2vyz5r7IuchXzAedaYhXDV/mEDifopimXTOjQ4IIjXFnt5jDZ/Uc/sfbfr/AGJrWvYZk9TasY3UPCeSTDOjz1FU73Xa0l+C132uRkthxXQYcX/2E1mBWB9kE6BsbNhy/wf5gswunU9YIOx4Tws+BYzJu+ojtW67Aoq79L2jpLW2+PoYHJxpReKwa1RgaOx99+QE49XQK3zC0oaumUM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7901A8B8E65EC945AD9EDF63D447AB45@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953c0477-cdc8-4c47-fa9f-08d59db1f8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:27.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTWljaGFpbCBHZW9yZ2lvcyBFdGFpcmlkaXMgPG0uZXRhaXJpZGlzQGJlY2staXBjLmNv
bT4NCg0KWyBVcHN0cmVhbSBjb21taXQgNmM3ODJhNWVhNTZhNzk5NjU4ZTIxM2E3OGRjMTQ1NTI2
NDkzOGFmYSBdDQoNClRoZSBpMmMtaW14IGRyaXZlciBpbmNvcnJlY3RseSB1c2VzIHJlYWRiKCkv
d3JpdGViKCkgdG8gcmVhZCBhbmQNCndyaXRlIHRvIHRoZSBhcHByb3ByaWF0ZSByZWdpc3RlcnMg
d2hlbiBwZXJmb3JtaW5nIGEgcmVwZWF0ZWQgc3RhcnQuDQpUaGUgYXBwcm9wcmlhdGUgaW14X2ky
Y19yZWFkX3JlZygpL2lteF9pMmNfd3JpdGVfcmVnKCkgZnVuY3Rpb25zDQpzaG91bGQgYmUgdXNl
ZCBpbnN0ZWFkLiBQZXJmb3JtaW5nIGEgcmVwZWF0ZWQgc3RhcnQgcmVzdWx0cyBpbg0KYSBrZXJu
ZWwgcGFuaWMuIFRoZSBwbGF0Zm9ybSBpcyBpbXguDQoNClNpZ25lZC1vZmYtYnk6IE1pY2hhaWwg
RyBFdGFpcmlkaXMgPG0uZXRhaXJpZGlzQGJlY2staXBjLmNvbT4NCkZpeGVzOiBjZTFhNzg4NDBm
ZjcgKCJpMmM6IGlteDogYWRkIERNQSBzdXBwb3J0IGZvciBmcmVlc2NhbGUgaTJjIGRyaXZlciIp
DQpGaXhlczogMDU0YjYyZDlmMjVjICgiaTJjOiBpbXg6IGZpeCB0aGUgaTJjIGJ1cyBoYW5nIGlz
c3VlIHdoZW4gZG8gcmVwZWF0IHJlc3RhcnQiKQ0KQWNrZWQtYnk6IEZ1Z2FuZyBEdWFuIDxmdWdh
bmcuZHVhbkBueHAuY29tPg0KQWNrZWQtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1r
b2VuaWdAcGVuZ3V0cm9uaXguZGU+DQpTaWduZWQtb2ZmLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYUB0
aGUtZHJlYW1zLmRlPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZp
bkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYyB8IDgg
KysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYyBiL2RyaXZlcnMv
aTJjL2J1c3Nlcy9pMmMtaW14LmMNCmluZGV4IGQ0ZDg1MzY4MGFlNC4uYzAxMWU1M2MwYjRkIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYw0KKysrIGIvZHJpdmVycy9p
MmMvYnVzc2VzL2kyYy1pbXguYw0KQEAgLTc0Niw5ICs3NDYsOSBAQCBzdGF0aWMgaW50IGkyY19p
bXhfZG1hX3JlYWQoc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14LA0KIAkJICogdGhlIGZp
cnN0IHJlYWQgb3BlcmF0aW9uLCBvdGhlcndpc2UgdGhlIGZpcnN0IHJlYWQgY29zdA0KIAkJICog
b25lIGV4dHJhIGNsb2NrIGN5Y2xlLg0KIAkJICovDQotCQl0ZW1wID0gcmVhZGIoaTJjX2lteC0+
YmFzZSArIElNWF9JMkNfSTJDUik7DQorCQl0ZW1wID0gaW14X2kyY19yZWFkX3JlZyhpMmNfaW14
LCBJTVhfSTJDX0kyQ1IpOw0KIAkJdGVtcCB8PSBJMkNSX01UWDsNCi0JCXdyaXRlYih0ZW1wLCBp
MmNfaW14LT5iYXNlICsgSU1YX0kyQ19JMkNSKTsNCisJCWlteF9pMmNfd3JpdGVfcmVnKHRlbXAs
IGkyY19pbXgsIElNWF9JMkNfSTJDUik7DQogCX0NCiAJbXNncy0+YnVmW21zZ3MtPmxlbi0xXSA9
IGlteF9pMmNfcmVhZF9yZWcoaTJjX2lteCwgSU1YX0kyQ19JMkRSKTsNCiANCkBAIC04NjksOSAr
ODY5LDkgQEAgc3RhdGljIGludCBpMmNfaW14X3JlYWQoc3RydWN0IGlteF9pMmNfc3RydWN0ICpp
MmNfaW14LCBzdHJ1Y3QgaTJjX21zZyAqbXNncywgYm8NCiAJCQkJICogdGhlIGZpcnN0IHJlYWQg
b3BlcmF0aW9uLCBvdGhlcndpc2UgdGhlIGZpcnN0IHJlYWQgY29zdA0KIAkJCQkgKiBvbmUgZXh0
cmEgY2xvY2sgY3ljbGUuDQogCQkJCSAqLw0KLQkJCQl0ZW1wID0gcmVhZGIoaTJjX2lteC0+YmFz
ZSArIElNWF9JMkNfSTJDUik7DQorCQkJCXRlbXAgPSBpbXhfaTJjX3JlYWRfcmVnKGkyY19pbXgs
IElNWF9JMkNfSTJDUik7DQogCQkJCXRlbXAgfD0gSTJDUl9NVFg7DQotCQkJCXdyaXRlYih0ZW1w
LCBpMmNfaW14LT5iYXNlICsgSU1YX0kyQ19JMkNSKTsNCisJCQkJaW14X2kyY193cml0ZV9yZWco
dGVtcCwgaTJjX2lteCwgSU1YX0kyQ19JMkNSKTsNCiAJCQl9DQogCQl9IGVsc2UgaWYgKGkgPT0g
KG1zZ3MtPmxlbiAtIDIpKSB7DQogCQkJZGV2X2RiZygmaTJjX2lteC0+YWRhcHRlci5kZXYsDQot
LSANCjIuMTUuMQ0K
