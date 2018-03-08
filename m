Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488440-2-8480504188605802376
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488439; b=weD/S6D3jr+KwLV6l9npormV9XXPz/EckFMu7IYIfEaSlJF
    ZvubdgHgem/yifqKZ0sWUNZWa9ReL3dPnfKyHYe4Sgr4sO3xXKnJqYe7hy2MvsAK
    Lix2PCkuGFiJE93DRWXaz8DIm8MuvR1OteZRNLISx5XCBxZwoEyYRvkbFVy3Umhq
    gDx4/KhBDCdct4sHdLU+BlDZumVcOBMLnvwvR5ZlrRSimkJxsYaRphXsN16+GIy8
    uiR4fKnmNrKgEUGu6zyx33MxD4vtN5wXdgo6/qU7//7gvEhs4nm51tZWsM6OXfSs
    rGGWSHq+23soQbm+zq2wYYhg+WZtdtZaJt/2ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520488439; bh=QHh1KYnab6XpXLYbK1kEvuyjlKz5QgkEC3mQm5
    wx3fw=; b=EETzADkJhc3KtN7q74cYDowZyvUG03Ppqb8UKtijjUli30Ib6O0Fpg
    hk32e+J2F1AyFqIBhABncbV2R/SHLW/7Yj8EdW4FI5ZgF8Z1FCgOeDhXaM2zUoPI
    AAUcBSrO7MCdhgPX82ZrlGkXRTVKQwEIMDKmEDNoGAc/zMf4Yx5y4ghPmxXCSjd8
    28aoukjAEBWMT+IKTM/X9TTAebfYTROszhMiBS6Vc7rZ8yGcwxPDiO09DBBjeP3S
    ezCmU1saGGGnJmFuxnEDODs1BX31ufjNz4obohVxez6jVcoacvfiH/+ct6HUkqK7
    MsRx6mkM/fM+7+uggBbDnG/wek7GyqwA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eF/Lef3T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eF/Lef3T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966111AbeCHFEE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:04 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:60007
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966087AbeCHFEA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 162/190] qmi_wwan: set FLAG_SEND_ZLP to avoid
 network initiated disconnect
Thread-Topic: [PATCH AUTOSEL for 4.9 162/190] qmi_wwan: set FLAG_SEND_ZLP to
 avoid network initiated disconnect
Thread-Index: AQHTtppSK2eCp0QEg0mFqVWVy8wPfg==
Date: Thu, 8 Mar 2018 05:00:04 +0000
Message-ID: <20180308045810.8041-162-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:HZ0WoXC8v3v9JYhPtw/z/9bF1DyhKXqVrVVpaKijRyLB32pvyOt31GOJNYSlItvptDJDOVoypPQkE9+HSgJZTWQxGvXZUmc0SMK7GjSXgPM23BdWA88n+FjlX8Pzq/RevaiX2BMda1j47/DmP7lStVOKzIxhVFEGnRZp3DXPR1d6Ym5WZmJVvXOVT0H//03zcumIbRXG2yt2whZGZTe0DCfILe7dEzIMoi0kLFHCFerrX1j1RI3baZLfzOt5HYrl;20:fICHchUx7+fX/jV+8YrNoqKcI/l+xzvIsccswFf04VgkRwKXH3izaSbwsGlkIKofZ/B8LxL4wYxx9iLPrpSIF2mbNdFqFxvFPW/yyiq5KeljTfxh7h45GAZVhHoV2CQ1Nu8HQF1+jO/Z5FO0cxCZZrKEaL+wBbWyHPyN2xmOvCc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ee32e02-277a-49c6-d763-08d584b20083
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08725751E8E26BD9646939DAFBDF0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(5660300001)(186003)(5250100002)(26005)(316002)(1076002)(4326008)(2501003)(2906002)(25786009)(76176011)(99286004)(6436002)(6486002)(6116002)(36756003)(3846002)(575784001)(22452003)(3280700002)(6666003)(2950100002)(86362001)(97736004)(8676002)(10090500001)(305945005)(2900100001)(66066001)(102836004)(68736007)(3660700001)(14454004)(7736002)(53936002)(6512007)(86612001)(110136005)(54906003)(6506007)(106356001)(478600001)(107886003)(105586002)(81156014)(81166006)(72206003)(8936002)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: l2KkgRzNA4y6GX8GtyNwIcj8N8S+iVHhsRLdd74KzuJLA7jIWW6lGoSvGUqhQZv5vYc0h4P9sDTbNCD71dxJggMnQXSeUtojVHpdniGraeB8elStnqmnYpm2vB/c1DCMS/YkVKYCLC7ZU19kHdK+ZffeVOR8+41thsol0uz7R41rhr3KAZYDUGhUSnYbGREjo6nijl9bKgKjY+8cW/LsVdpN1Ralq9BC0Q9469C4UPBI10MmjEa1ek6BhpgoeM3gT7P3Kr8a2qu+EB4xjozpgIl9EXxJf+MPFujwgBovftZU94wGkfd4MOEaxkUivlk8fFgRJQJCKdkcgnzvOACEYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A48584F8B1AC424E87990B4D7158A69E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee32e02-277a-49c6-d763-08d584b20083
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:04.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQmrDuHJuIE1vcmsgPGJqb3JuQG1vcmsubm8+DQoNClsgVXBzdHJlYW0gY29tbWl0IDI0
NWQyMTE5MGFlYzU0N2MwZGU2NGY3MGMwZTZkZTg3MWMxODVhMjQgXQ0KDQpJdCBoYXMgYmVlbiBy
ZXBvcnRlZCB0aGF0IHRoZSBkdW1teSBieXRlIHdlIGFkZCB0byBhdm9pZA0KWkxQcyBjYW4gYmUg
Zm9yd2FyZGVkIGJ5IHRoZSBtb2RlbSB0byB0aGUgUEdXL0dHU04sIGFuZCB0aGF0DQpzb21lIG9w
ZXJhdG9ycyB3aWxsIGRyb3AgdGhlIGNvbm5lY3Rpb24gaWYgdGhpcyBoYXBwZW5zLg0KDQpJbiB0
aGVvcnksIFFNSSBkZXZpY2VzIGFyZSBiYXNlZCBvbiBDREMgRUNNIGFuZCBzaG91bGQgYXMgc3Vj
aA0KYm90aCBzdXBwb3J0IFpMUHMgYW5kIHNpbGVudGx5IGlnbm9yZSB0aGUgZHVtbXkgYnl0ZS4g
IFRoZSBsYXR0ZXINCmFzc3VtcHRpb24gZmFpbGVkLiAgTGV0J3MgdGVzdCBvdXQgdGhlIGZpcnN0
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBCasO4cm4gTW9yayA8Ympvcm5AbW9yay5ubz4NClNpZ25lZC1v
ZmYtYnk6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4NClNpZ25lZC1vZmYt
Ynk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRy
aXZlcnMvbmV0L3VzYi9xbWlfd3dhbi5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Vz
Yi9xbWlfd3dhbi5jIGIvZHJpdmVycy9uZXQvdXNiL3FtaV93d2FuLmMNCmluZGV4IGUxZTVlODQz
ODQ1Ny4uY2RmMDAxMDJmZWNiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvdXNiL3FtaV93d2Fu
LmMNCisrKyBiL2RyaXZlcnMvbmV0L3VzYi9xbWlfd3dhbi5jDQpAQCAtNTMxLDcgKzUzMSw3IEBA
IHN0YXRpYyBpbnQgcW1pX3d3YW5fcmVzdW1lKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmKQ0K
IA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJpdmVyX2luZm8JcW1pX3d3YW5faW5mbyA9IHsNCiAJ
LmRlc2NyaXB0aW9uCT0gIldXQU4vUU1JIGRldmljZSIsDQotCS5mbGFncwkJPSBGTEFHX1dXQU4s
DQorCS5mbGFncwkJPSBGTEFHX1dXQU4gfCBGTEFHX1NFTkRfWkxQLA0KIAkuYmluZAkJPSBxbWlf
d3dhbl9iaW5kLA0KIAkudW5iaW5kCQk9IHFtaV93d2FuX3VuYmluZCwNCiAJLm1hbmFnZV9wb3dl
cgk9IHFtaV93d2FuX21hbmFnZV9wb3dlciwNCkBAIC01NDAsNyArNTQwLDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBkcml2ZXJfaW5mbwlxbWlfd3dhbl9pbmZvID0gew0KIA0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZHJpdmVyX2luZm8JcW1pX3d3YW5faW5mb19xdWlya19kdHIgPSB7DQogCS5kZXNj
cmlwdGlvbgk9ICJXV0FOL1FNSSBkZXZpY2UiLA0KLQkuZmxhZ3MJCT0gRkxBR19XV0FOLA0KKwku
ZmxhZ3MJCT0gRkxBR19XV0FOIHwgRkxBR19TRU5EX1pMUCwNCiAJLmJpbmQJCT0gcW1pX3d3YW5f
YmluZCwNCiAJLnVuYmluZAkJPSBxbWlfd3dhbl91bmJpbmQsDQogCS5tYW5hZ2VfcG93ZXIJPSBx
bWlfd3dhbl9tYW5hZ2VfcG93ZXIsDQotLSANCjIuMTQuMQ0K
