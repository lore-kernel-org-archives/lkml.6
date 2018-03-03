Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120539-2-14555723850296677361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120539; b=hyzKcSdeARxL2nMGRGp3grgmxX1xR0dik9ahE3+vAWg1KYk
    46joZtqWptxxw37xOuf69Iq1WPbhS7woZMDDPQfHW4VWyXSaveOqg+RqCGfJkyje
    /uapolyFtyZ2LxGyhHHIMOZPT04gBCRZ7yOnlHxpYzkgPPmCAzYxDwKPex6Vl4Qh
    CNx8ZCY5/3c/qppHsa9H2fsMH3rL17ST4iBPec1DShrmiVyf6IUrLe+uX06qtOSu
    /gCLyL0F3cQaEvhReQ6qFYI+rrYDLEXPf9JucrUErCbVDFIt8NPNtoCdP5ooEuTs
    EcutzB1gB+UnVwEdt+hMMaCOl7UxbhzRN+zJYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520120539; bh=hvM1IemBHQ8IejEc5duuiOlpTA2Nr7KdVYDuMU
    ItZSE=; b=LDX4nlGXwOGYCW83MEiP7W5rwNclTJPQ9wf9zOgG2IG/nHLKAOENVZ
    6xKwzye+Ge9gKdkkt6aODcd2zJl0yPPH2agNCA8KutaYbcCt9erh9Z8E55EbXun+
    IMa8lfYu2vfUTZ/lUYeHSAsr/aiO2PL5MSd0/sAcnNOFyYYtOfrYXkt8+B0l0pGe
    bWr2zj61NTa4q19rbyv1kOwzYK2Etx1tUAirIqjp9RoThB+5r3oqW0ls4BFDjfir
    Urhr5DWSRhV4dt8LAkxcMwjF4etBzAm4fFeGwZOuIK5xx/YgoG/4/I3/PEXhGWr6
    kL7bucihV00ILkuesnyik9XCZv4o55Pg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UdoiAoSO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UdoiAoSO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbeCCXl4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:41:56 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:42080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934283AbeCCWe4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christopher James Halse Rogers
        <christopher.halse.rogers@canonical.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 128/219] drm/radeon: Fail fb creation from
 imported dma-bufs.
Thread-Topic: [PATCH AUTOSEL for 4.9 128/219] drm/radeon: Fail fb creation
 from imported dma-bufs.
Thread-Index: AQHTsz8MhT4OLWtbxUS1/pll+B0FiQ==
Date: Sat, 3 Mar 2018 22:29:10 +0000
Message-ID: <20180303222716.26640-128-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:gIJ6vfCq1GpCRBhUAXZczcGk28sJhGgivX6xq+G3IHviQp2Z8/upcyY0uzjXMowdCPWmKkjTPxFMJApe6AxYD5D3qPtPktWuPA/rJmwmVcu/ZCYNa7ILhZFXpn7FzBQtqKSOvrReqsk9bsuGBwLOXxcEtnSeuoJ8sIu3S83QvsZ3f6RYJ8bvoB3yE5Tss6n5uLPZTFIZJL+//efKSLhsW1MvKmVh5WZiErS+5kkcX2OLxCdjoAPD7Aa64iuaX4Oj
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c63649bb-8e0f-46e8-53d9-08d58156f84d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106855E0C91A0C5DBC4883BDFBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110)(217544274631240)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(5890100001)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(8666007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2F0YTvbwfToOKkDWRASYKH/xQHxeBqzyuJ2GDOHL1CZsfoF7QqQISaEb7nSk8UgPAb5HQuz+OgaRTV1/v5St+NxEgj4JyuyhRs2xPy2jY4K/oGegimq6bjs6f4HRrcMkse8Xvpe4vfrVFXsfEo6SOQIb//ONWnY24c9pvzmKCjY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <76BC7F9971ECB34F84D70A6447E891F1@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63649bb-8e0f-46e8-53d9-08d58156f84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:10.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQ2hyaXN0b3BoZXIgSmFtZXMgSGFsc2UgUm9nZXJzIDxjaHJpc3RvcGhlci5oYWxzZS5y
b2dlcnNAY2Fub25pY2FsLmNvbT4NCg0KWyBVcHN0cmVhbSBjb21taXQgYTI5NDA0M2IyZmJkOGRl
NjlkMTYxNDU3ZWQwYzdhNDAyNmJiZmE1YSBdDQoNCkFueSB1c2Ugb2YgdGhlIGZyYW1lYnVmZmVy
IHdpbGwgbWlncmF0ZSBpdCB0byBWUkFNLCB3aGljaCBpcyBub3Qgc2Vuc2libGUgZm9yDQphbiBp
bXBvcnRlZCBkbWEtYnVmLg0KDQp2MjogVXNlIERSTV9ERUJVR19LTVMgdG8gcHJldmVudCB1c2Vy
c3BhY2UgYWNjaWRlbnRhbGx5IHNwYW1taW5nIGRtZXNnLg0KDQpSZXZpZXdlZC1ieTogTWljaGVs
IETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0
b3BoZXIgSmFtZXMgSGFsc2UgUm9nZXJzIDxjaHJpc3RvcGhlci5oYWxzZS5yb2dlcnNAY2Fub25p
Y2FsLmNvbT4NCkNDOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIHwgNiArKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
aXNwbGF5LmMNCmluZGV4IGNkYjhjYjU2OGMxNS4uY2ExY2FmNDA1ODMyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMNCkBAIC0xMzUyLDYgKzEzNTIsMTIgQEAgcmFk
ZW9uX3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQogCQly
ZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCiAJfQ0KIA0KKwkvKiBIYW5kbGUgaXMgaW1wb3J0ZWQg
ZG1hLWJ1Ziwgc28gY2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0gZm9yIHNjYW5vdXQgKi8NCisJ
aWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgew0KKwkJRFJNX0RFQlVHX0tNUygiQ2Fubm90IGNyZWF0
ZSBmcmFtZWJ1ZmZlciBmcm9tIGltcG9ydGVkIGRtYV9idWZcbiIpOw0KKwkJcmV0dXJuIEVSUl9Q
VFIoLUVJTlZBTCk7DQorCX0NCisNCiAJcmFkZW9uX2ZiID0ga3phbGxvYyhzaXplb2YoKnJhZGVv
bl9mYiksIEdGUF9LRVJORUwpOw0KIAlpZiAocmFkZW9uX2ZiID09IE5VTEwpIHsNCiAJCWRybV9n
ZW1fb2JqZWN0X3VucmVmZXJlbmNlX3VubG9ja2VkKG9iaik7DQotLSANCjIuMTQuMQ0K
