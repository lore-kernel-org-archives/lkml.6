Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485111-2-8082322829385384565
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
    t=1520485110; b=J77+YKVe2tHq8XDfR8eBmXKS8PsWdzBPQ686X26EMetmlVY
    O2l+ksVpOJopVi9voq7zpJuA+hZUzD4UCzBryC80Ne9hUKmV2vbwOKFtNiGkshq0
    4BEIidzQKaCZTu0AXVQVfYUp1lDyWhGIn5Dn0EV5wBRlV+sfPq4MvNWWr9ZWu15Q
    14Ku3GPu4sHCE4dbqVfGsY4xhutVhbFTjZVFRcIJeI4+5Pz4jCtboZSUoLgySdJD
    VJyIG7isl3CUQnP83lO5a8ud6H79O9ePmdE+Vm0tfc5hWDfxrSk4u3Y3mPWJVByo
    R0dHPjTE6DWNOPwGPN7P12NYL0wDqeeXKuWx7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520485110; bh=M+pDL+iQWTzjvzATlu9d5ioFGTHQgZxKZJLhHs
    /rZFE=; b=weUHFDoFgEbbh0nP8TglpvAQV7eS8ZHdV/Pri8cbovu5I9iEey5vRJ
    rQdKKRmG0fn6NAGj1peuQ5VbpBJpCIbNnCy6Rm9qrAfpjNdqUBBaYpMbu0x6l01r
    IMuhJBsGWiO3pq9JyiH24BWG0lZoWgfNTVkDH0VkqXxm27wRJ9uTGrQ606LvLLLs
    zwNX9GxHqWrOgPMhyt/lJqNe8MEP9r5Ux6WkFQ5+TD8cuNZZVLt+rpDBnKEs6qXZ
    eruyGNAvB1YI2C2uY9SGEnCuDToTiI+65qeRXemU1jiYQY39BGTqGr+b3122rBwG
    +Fy6NIOvHjFi0WQx1u7GWKyXWgJEbevQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DuhLONV4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DuhLONV4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935225AbeCHE61 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:27 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:17968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965083AbeCHE6Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 19/67] qmi_wwan: set FLAG_SEND_ZLP to avoid
 network initiated disconnect
Thread-Topic: [PATCH AUTOSEL for 4.14 19/67] qmi_wwan: set FLAG_SEND_ZLP to
 avoid network initiated disconnect
Thread-Index: AQHTtpn7gak/AQpWtkujp0KSLok7RA==
Date: Thu, 8 Mar 2018 04:57:39 +0000
Message-ID: <20180308045641.7814-19-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;7:H6rj4JCkrwPqLgNcDQSriX4rbIZuN1UssRbUMoCoIRHTxtOY95cb8IEvRWRntxgM/hdmBJboAJXmupwqWfQfl1CA6aXCfqA8NFl1ZZgenuRk25bWS+OM1oRnaZJ5SctPpFzllL/iG3jdz413rojXnsEzFKqafMbocbMO/7DVn8opw8f/nWvzWBvg22OyVz1mpzw0fpRbWYwF2HBQgl5UQ8CLl723hzdTq1O/P1bOsxOtXL22U387mqv3V894iV2o;20:ll66ZOdTzxl1dRP363ZeKT/ffzaxFmDsN68PaUg7n26EaU1pzeAcZUaG7cgQE/HzDR2DEVe2LJAqY0CocKx2+6G1amoVQntRpVbLVqSGMv66gZlRnB4guvopfXY8nzMbU4fuNlZoW/wVrzgEjpDLzKk/a0bMIoNnApvxphlnMkg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09086192-02fc-4c99-640d-08d584b13257
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808DD94E360A79DA5E51CAAFBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(575784001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: N2wAGNclAfwoXhho1WlWDqEKUMXeo/xa3OGFVYALc96/ALk6wdns5d4ofnq0YYX/lHbAdinnxHn/G5a/rgovHL1dB+jcysegCmpcNs6/fglebCbIXt45uJM7GS0rosDd81fx/fpmLN+a50sr7vgu0W1LzA4aVO6Ln2L8nhtdUBjf1a5XFdrWqt4keZSOEVAa+Z/fYo6bsYgmXBFtzYIVDwZjZA2tM+RtnaBxdCl5JDPg3QlkX5YAFeBosDMm7SD9aNkkinZPob4YFqqEW27ISgfgELg9bkpqEiVEgJjcR9T7tSDD72nIcVwwSrq5hBBh1r7YyfdWBGD2psN/3T8DKQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED1FFDC41C90FB4BB72CD3BC63738AA3@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09086192-02fc-4c99-640d-08d584b13257
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:39.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
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
Yi9xbWlfd3dhbi5jIGIvZHJpdmVycy9uZXQvdXNiL3FtaV93d2FuLmMNCmluZGV4IDhkOWYwMmI3
YTcxZi4uMjI0YmYzMjNmNzk5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvdXNiL3FtaV93d2Fu
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
