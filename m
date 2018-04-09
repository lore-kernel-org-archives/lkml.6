Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240484-2-1087593270921916611
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
    1523240483; b=uYV24KIfs2ojNVP7O3rYUm/fCWT95DjVb2h46r5AE5NynKiGxA
    nNrTVVq2qNHsbUqVvTHOuF2gc5XeEQBr31e6q536cehG9s/FTnjll1h4edtgg615
    wG9a1zh+DjqsGzEQ+X+mA29xNFQUeGtY1xjVEPRguc319xLzshyJB4uXJYR6E/oF
    CGW6GIlLAb+SomhVVPVWY1q8EIK3606L8Nr1ZG34kl4DclOlGMfbeUz0ynj26dEr
    P0krPZ8ACMFLA2ekGfc7lKpEdrRyuvvz1HhxFYLLTbUg8rT3a6qwsABKBEH71/8Q
    7bvqyD3ZdvFiFyNMvupzJL0OMR9DYET7/5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523240483; bh=CO2pCOiH3/W99lvzkwVaOCOVeGLojeC/dbcPMFoDhHs=; b=
    Tkt5cviCvvbqfmIRirmY5ej56EVAMcuGB22sr+MiYA8bZI5DWxD5KXiX1yEYVweA
    L3mNwNunm+AUoC4cJ/uJndJ7CEkBP3WPmQw9vkFyv3HD0F+D6d8nMJ3v8dSLKQ10
    sH1hNpwDWgg6NdqxzbvEe5szXIyGR7tKhxCyPLGpmN7BY4KBn47zJiUP7n2usFfh
    WYlyJBKm43fKwJnQSdExffMZuoF+MggmD0HYEF7iCGZj4DK2IgKRtoW2y9QzF0pi
    umHUjVSb6ZnKhbwMDUfslQxgG+ooGme7Y3t5o/IQMp3SI60itvzM5YtAV1NFhxpu
    MIXfb6TfN+ZvYf0VCpPXFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S937KSpo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S937KSpo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA9cGYWVpxEKJRlFBjCibls7qbNcgGTsuzHEedHTJlxNDGsjbPLuDJpCO+22M/BS4abd3dO/CKgsou5d96x6wISDiYkRERNuSRkJLEmOyZMqGmzpK+k4
    N6kseyr/fEh0gNoPjjt41mGFzjYy8ShJTmewk1q0O4S4lTH1JPihIfs+y/ttuHYjMurnlUgQQMb6WdDFNRjoG3KOgbI4ndhq08z9gesJHw2jixcmLABcNWLk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=3Ch9cZZwAAAA:8 a=8AirrxEcAAAA:8 a=yMhMjlubAAAA:8
    a=OX_5Z3w97m8VyYvk8n0A:9 a=QEXdDO2ut3YA:10 a=qaWmjqwTrqMQxh53mpKG:22
    a=ST-jHhOKWsTCqRlWije3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756118AbeDICUi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:20:38 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755143AbeDIA3p (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 117/293] i2c: imx: Use correct function to
 write to register
Thread-Topic: [PATCH AUTOSEL for 4.9 117/293] i2c: imx: Use correct function
 to write to register
Thread-Index: AQHTz5kcV9STnLMKSUOkjwjMtkzMhA==
Date: Mon, 9 Apr 2018 00:24:24 +0000
Message-ID: <20180409002239.163177-117-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:MXM7jlcvIhiAEcf0kZsrwuiJM0yRJra5FvG7AriaGDvLWUXRDWXVRh6j5BA0ay0p55sUDWCoPCf/yi9b9kegFWE/k0XWcjMiHnGT4thnkZRlVpwkLX5KKyIkCJSD83QS/7H8+6u+Liq6dvqt82gKw9YtTTsVg9W06WwLkWZDSyeoAy/S7JYKI0pbBeh2hUTxhLnx3mX4CVT2l2tBIM/abUIimLDYQqyINBq8RKVQZPTi3zuX/Lq4JCNLfkIbG5Vc;20:Xoip9RlEFGs+GtGw97/SJbF3V9IBKiLh3nNEnWmLa4cx2YrGTTEy7Jffsf4j8yzJmz8seiXqtQQXR3/eIYWqAZ7iAkMCgq5p7WsL5vj2aefde/FemEV41V/+NyOKkT6+XznzNIGAuT1WfeHGtDbBBZAzZEmjfFoyUEsYXNOPnlA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebb975f8-8025-410f-fde9-08d59db0fc0c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10326488110686BFBD6C0A20FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: gQXURugsYwmHje9WfububVXuOYRaXLOv0Q2TPxF6lTkkoi7Tru9SdVaelAyoiCiJqwgCyKXywtIJ+8yo53/dgqMTT24ui3iR1VQRsFlcFcWCM/pwMwtEUEve28/1Ocj5w8Vp2ccp20O6QZyxn6QTGgXeSDFUmYHnQudGf4pQIJ0M9YXZ5gSROv1M4vfIAZg5wZad16ozDgISydKlSjohwRI7+D41um79rn9cor7sRBx5d/UvrDImYml1WLvPx2+LDXUNS7AhSpF1yFMgf8q7N2muqYPMT+4NZeR0TjfPaqwqUoNTCiU4fGxO5PQr7q5DNj1Tsk43qwhmOECqc+z8zhaMNB960GbpmeX+aAh5i231eUfM36B36BiInrln8ixDjnASN2vD6vKHFvdAh4UO3HJohxPY/B1xQc0hR/F7dNA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C928ED72E05B8A43854A13702CFEE7A0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb975f8-8025-410f-fde9-08d59db0fc0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:24.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
aTJjL2J1c3Nlcy9pMmMtaW14LmMNCmluZGV4IDQ3ZmMxZjFhY2ZmNy4uNmQ3NjRkNzg0MzdlIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYw0KKysrIGIvZHJpdmVycy9p
MmMvYnVzc2VzL2kyYy1pbXguYw0KQEAgLTczNCw5ICs3MzQsOSBAQCBzdGF0aWMgaW50IGkyY19p
bXhfZG1hX3JlYWQoc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14LA0KIAkJICogdGhlIGZp
cnN0IHJlYWQgb3BlcmF0aW9uLCBvdGhlcndpc2UgdGhlIGZpcnN0IHJlYWQgY29zdA0KIAkJICog
b25lIGV4dHJhIGNsb2NrIGN5Y2xlLg0KIAkJICovDQotCQl0ZW1wID0gcmVhZGIoaTJjX2lteC0+
YmFzZSArIElNWF9JMkNfSTJDUik7DQorCQl0ZW1wID0gaW14X2kyY19yZWFkX3JlZyhpMmNfaW14
LCBJTVhfSTJDX0kyQ1IpOw0KIAkJdGVtcCB8PSBJMkNSX01UWDsNCi0JCXdyaXRlYih0ZW1wLCBp
MmNfaW14LT5iYXNlICsgSU1YX0kyQ19JMkNSKTsNCisJCWlteF9pMmNfd3JpdGVfcmVnKHRlbXAs
IGkyY19pbXgsIElNWF9JMkNfSTJDUik7DQogCX0NCiAJbXNncy0+YnVmW21zZ3MtPmxlbi0xXSA9
IGlteF9pMmNfcmVhZF9yZWcoaTJjX2lteCwgSU1YX0kyQ19JMkRSKTsNCiANCkBAIC04NTcsOSAr
ODU3LDkgQEAgc3RhdGljIGludCBpMmNfaW14X3JlYWQoc3RydWN0IGlteF9pMmNfc3RydWN0ICpp
MmNfaW14LCBzdHJ1Y3QgaTJjX21zZyAqbXNncywgYm8NCiAJCQkJICogdGhlIGZpcnN0IHJlYWQg
b3BlcmF0aW9uLCBvdGhlcndpc2UgdGhlIGZpcnN0IHJlYWQgY29zdA0KIAkJCQkgKiBvbmUgZXh0
cmEgY2xvY2sgY3ljbGUuDQogCQkJCSAqLw0KLQkJCQl0ZW1wID0gcmVhZGIoaTJjX2lteC0+YmFz
ZSArIElNWF9JMkNfSTJDUik7DQorCQkJCXRlbXAgPSBpbXhfaTJjX3JlYWRfcmVnKGkyY19pbXgs
IElNWF9JMkNfSTJDUik7DQogCQkJCXRlbXAgfD0gSTJDUl9NVFg7DQotCQkJCXdyaXRlYih0ZW1w
LCBpMmNfaW14LT5iYXNlICsgSU1YX0kyQ19JMkNSKTsNCisJCQkJaW14X2kyY193cml0ZV9yZWco
dGVtcCwgaTJjX2lteCwgSU1YX0kyQ19JMkNSKTsNCiAJCQl9DQogCQl9IGVsc2UgaWYgKGkgPT0g
KG1zZ3MtPmxlbiAtIDIpKSB7DQogCQkJZGV2X2RiZygmaTJjX2lteC0+YWRhcHRlci5kZXYsDQot
LSANCjIuMTUuMQ0K
