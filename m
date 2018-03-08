Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492849-2-12818437620216450681
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
    t=1520492848; b=HwxM55nmIidIGOLxzr2T/ngjapDrULzt35whGWCC3h0LGxw
    ZpnY0FgnFUQKLUZOE1WQjkC8grTpjg/pYf7PnKPnW/3wvk7NqyhW/U7lb7O/kB7D
    vHpnARnApxTaBJ31/EQBZS3ITr7FdrAGu/FKA43a/pcD1NuZf2nf4fNteV7RFOU3
    X7pTwAD9v7bRyhq16H6vhkYuaej1O4beKHT/XXYQBuNp+lMuMZlvq7OEVoF6ljuS
    pe0+sG1HrC5LCv37rsXqfw/h7K4HVdNEdZ2aUldXZSuIujt0NITVnz3MMtUGlvqw
    KIKzl8aXD4k9CIGKSsGj6S/gHoU4YCg9itzi3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520492848; bh=FlR5k17F7/G3nikkyN55yEpuqTg95daxflL6/+
    m2HsQ=; b=G1rrXBL/5TXf+GMROJz2LFxR6y1bRhLqJDGKJ+P4uR70md9braJlRv
    2bmRH0ysTjJW3ZTWHqbzoObnPQryRXjAEZX2zrWrQm3+I4qAqiKYKI0GVa3kDv8y
    d+Vw45sTDExyq7mFCj59at5k8dAELYwyT3W9yGSc0zdw/oWpKdGpyfvhQrvr8ji2
    pxfZ2XEmqoF/d63rRtfAFDyLCx+q/ZlDv5Rw2LCfZr2sTo1syfUlYb97KjspTeAR
    AQiYTldH74i8QqhomFYYu7dalzYJ41I28hum2UGR2EuvcRH4KEqjU+oUpKnJnTOV
    Ad5I0uKO85kwuUzS8RfooGpwSUm4Ch2w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P+fEf+OR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P+fEf+OR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935202AbeCHHHY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:07:24 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933537AbeCHE4b (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:31 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 24/78] qmi_wwan: set FLAG_SEND_ZLP to avoid
 network initiated disconnect
Thread-Topic: [PATCH AUTOSEL for 4.15 24/78] qmi_wwan: set FLAG_SEND_ZLP to
 avoid network initiated disconnect
Thread-Index: AQHTtpnHQTDqCuVSeUuiQ/rydAYeJw==
Date: Thu, 8 Mar 2018 04:56:11 +0000
Message-ID: <20180308045525.7662-24-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:WEhjrQ5FxR3sg703Nv97RNO0kFESrc8yNBr4ym34A9QFSe/VOGpDQCeO8/OhmQ/hPPuo2Ayw0aTjzL4pPWeeHqpQtd0NeXn35C9o0IC+uz8DmwQUC2ecbemjeLSXOn/wMMSPJ+K95evSuQ0qbF6H8an6sKW53WTEAoSJ2+tdcH2m+pytfLeIY/dKjCuAH2SblakSVezIPz7jSE/P2vDJPsHonWlVNhkHvDuAamm9HYZ40D271RxREzJijL8uCJcR;20:8a7jU8cfjEBvtc/fkCDi1/aQ6/4vf0N87B+XW10Ti4btnqCHch8rhzBwCIJ5W0omrqpFR+rt294laB+L1x2sgyp98CvLyvrQkmEjycOEa7zaRBXcYiZZHN4htBzvQJsgpiG+nl/KOTqEcnY+NhZ0rvun6+sW1fAMmutCwewGqWE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 578c5819-0e95-4472-d34c-08d584b0f386
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111D49B4BF091540F29CD7DFBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: KJOcAwaFG1SgGEliaO56UzMehC1PKGkZZKElirLu0fVZM7qWGHJ5jqWHEPl/TzhrnyDSaIKVKtW5/YmS3L+Tt/rl6jWtNK9B7SLaPsD4feXB5rbDClbJlv57pTI/ypOjPT+AgIzUvLGXPrbDjWnJLbesO+EMiT/sfYxwRXglAsFNMDvErGIL8ZjbqVDufPrX60VHHqpcNluVcKsWVIf2pvHfErfqHqOMYed2klwW1eNgC8GQXU0zSWqxiUyQR/2sZebOPLYjVydLFZfAsMN84lmXl83d0TZpg8a1idtAXfdGc9pdYf4/efCLJbs9mAZfdGu+N2K6US8nAoOtkwEPkw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B677C8939E64545A22AE0797BA5AE5A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578c5819-0e95-4472-d34c-08d584b0f386
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:11.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
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
Yi9xbWlfd3dhbi5jIGIvZHJpdmVycy9uZXQvdXNiL3FtaV93d2FuLmMNCmluZGV4IGU3MTE0YzM0
ZmU0Yi4uNzZhYzQ4MDk1YzI5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvdXNiL3FtaV93d2Fu
LmMNCisrKyBiL2RyaXZlcnMvbmV0L3VzYi9xbWlfd3dhbi5jDQpAQCAtODI2LDcgKzgyNiw3IEBA
IHN0YXRpYyBpbnQgcW1pX3d3YW5fcmVzdW1lKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmKQ0K
IA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJpdmVyX2luZm8JcW1pX3d3YW5faW5mbyA9IHsNCiAJ
LmRlc2NyaXB0aW9uCT0gIldXQU4vUU1JIGRldmljZSIsDQotCS5mbGFncwkJPSBGTEFHX1dXQU4s
DQorCS5mbGFncwkJPSBGTEFHX1dXQU4gfCBGTEFHX1NFTkRfWkxQLA0KIAkuYmluZAkJPSBxbWlf
d3dhbl9iaW5kLA0KIAkudW5iaW5kCQk9IHFtaV93d2FuX3VuYmluZCwNCiAJLm1hbmFnZV9wb3dl
cgk9IHFtaV93d2FuX21hbmFnZV9wb3dlciwNCkBAIC04MzUsNyArODM1LDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBkcml2ZXJfaW5mbwlxbWlfd3dhbl9pbmZvID0gew0KIA0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZHJpdmVyX2luZm8JcW1pX3d3YW5faW5mb19xdWlya19kdHIgPSB7DQogCS5kZXNj
cmlwdGlvbgk9ICJXV0FOL1FNSSBkZXZpY2UiLA0KLQkuZmxhZ3MJCT0gRkxBR19XV0FOLA0KKwku
ZmxhZ3MJCT0gRkxBR19XV0FOIHwgRkxBR19TRU5EX1pMUCwNCiAJLmJpbmQJCT0gcW1pX3d3YW5f
YmluZCwNCiAJLnVuYmluZAkJPSBxbWlfd3dhbl91bmJpbmQsDQogCS5tYW5hZ2VfcG93ZXIJPSBx
bWlfd3dhbl9tYW5hZ2VfcG93ZXIsDQotLSANCjIuMTQuMQ0K
