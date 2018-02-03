Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683560-2-10875839622142061524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683560; b=VDXdkOxUMZt4nsEtGW1Xosb6Bq5jXIr/eCehduUx/DBEShz
    dk9Ex5Q+GnPUTq6Ze4AgRcIUJom069ZVlWj5HVWunQBlWh67i0MgiccptiSeZ9Pi
    gXgI63MeA1ns4h2wkKqxYBr5m+qAPW6oIvK1tyfCrf0Y+krGch5tNoMHk2Vvcppj
    HomQb8006vJvGZHZbXSuC+JXloKIePXZTkMHij+IHptKIomfrqWF3iy2flbdfa06
    D+GnBkc1kQ/TvTQg8RJ2OVDEn3PbXgEBtyHmlqVyBIFQZgB4qpwQI+7JgI+n4fY8
    utgvSLP0mCR67bOrrKbSieFl9kxH7iVdRJ4pkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517683560; bh=SwZTzmKxSh+BZs0hZwzayGInpIfzvqm/QU1PNs
    BMucY=; b=OFN6wtu1pmFD07BTUZ0BgKZXcEac3TrCR+bDvlbZD7vVjwq3HFVHux
    YDu8ldd4SjlwrAEAstI8AfYq0MXM1KJfOH0w0SYBSomE2OqRD/E3TYbzzYDq1SrR
    mgL/JNurhlQmFc8ZjPE0Y2Bn/YjXGi3F179GgcKZt4Htt1z7uj+QMtz9H57FM1ut
    wfpnDcqV5zz5J2uPEDlE3IKE5BWtsJY97uI7O9GfdQJvWp499lhiCXOfQMVRF9vC
    76jBWA1nOoCPpPtmS7co0FdzXifSd7R5js7MZpN2O9PZCS2w5PEhjBXhUDetBYYV
    dNZt+9y4SW7huo6eMeUUVNIWnJPuLBqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BT0nztcN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BT0nztcN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755332AbeBCSpx (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:53 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53867
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753089AbeBCSCX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 079/110] NET: usb: qmi_wwan: add support for
 YUGA CLM920-NC5 PID 0x9625
Thread-Topic: [PATCH AUTOSEL for 4.14 079/110] NET: usb: qmi_wwan: add support
 for YUGA CLM920-NC5 PID 0x9625
Thread-Index: AQHTnRj+r+5yksMO90+wiP3hBj62AQ==
Date: Sat, 3 Feb 2018 18:01:20 +0000
Message-ID: <20180203180015.29073-79-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:MttBaejxKdWs6udWD3KhdeFKqnCO5bjNkGlZGo2IDzMgxj+iXpyPXLuUNxLBI9hbMGxnyK9i0qjtL1Kx0neGBGKzP9DX6HLJ3FT1oxNNog1EQiCN1lLtLCe92NfcsebcKbr8saDHk9ptfV7IScplYkhqhnT+4mhk1hnAejpdXD+CZerAlptUdDo32Hl9v50YMUFqALGSC+tgUktNzUnmpoEi9Gv5SalOwDG3rCojAoeB0ueCLnbZ/7DTYO6Lwr1r
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c614dab6-76c5-435b-2249-08d56b303f88
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB104111998D7D4B18BE7889F2FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 9eWTQRarP0NFbLV6nyt+SC6Gw0Xx4dHQA+Jg9aDRvbeBLwXHvsngB0yPPnXRMtq0iNv+LBLlRV5Eed4ev5Lhjg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <80C4FF4DD607D3429AC8A0212ACCF9FF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c614dab6-76c5-435b-2249-08d56b303f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:20.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogU1ogTGluICjmnpfkuIrmmbopIDxzei5saW5AbW94YS5jb20+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IGJkMzBmZmM0MTRlNTUxOTRlZDYxNDlmYWQ2OWExNDU1NTBjYjdjMTggXQ0KDQpUaGlz
IHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgUElEIDB4OTYyNSBvZiBZVUdBIENMTTkyMC1OQzUuDQoN
CllVR0EgQ0xNOTIwLU5DNSBuZWVkcyB0byBlbmFibGUgUU1JX1dXQU5fUVVJUktfRFRSIGJlZm9y
ZSBRTUkgb3BlcmF0aW9uLg0KDQpxbWljbGkgLWQgL2Rldi9jZGMtd2RtMCAtcCAtLWRtcy1nZXQt
cmV2aXNpb24NClsvZGV2L2NkYy13ZG0wXSBEZXZpY2UgcmV2aXNpb24gcmV0cmlldmVkOg0KICAg
ICAgICBSZXZpc2lvbjogJ0NMTTkyMF9OQzUtVjEgIDEgIFtPY3QgMjMgMjAxNiAxOTowMDowMF0n
DQoNClNpZ25lZC1vZmYtYnk6IFNaIExpbiAo5p6X5LiK5pm6KSA8c3oubGluQG1veGEuY29tPg0K
QWNrZWQtYnk6IEJqw7hybiBNb3JrIDxiam9ybkBtb3JrLm5vPg0KU2lnbmVkLW9mZi1ieTogRGF2
aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEg
TGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9uZXQv
dXNiL3FtaV93d2FuLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9xbWlfd3dhbi5jIGIvZHJpdmVycy9uZXQvdXNi
L3FtaV93d2FuLmMNCmluZGV4IDNjNTk0ZGFlMzNlOC4uZTg2YzIyNzgwOTZmIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9uZXQvdXNiL3FtaV93d2FuLmMNCisrKyBiL2RyaXZlcnMvbmV0L3VzYi9xbWlf
d3dhbi5jDQpAQCAtMTEwMCw2ICsxMTAwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZGV2
aWNlX2lkIHByb2R1Y3RzW10gPSB7DQogCXtRTUlfRklYRURfSU5URigweDA1YzYsIDB4OTA4NCwg
NCl9LA0KIAl7UU1JX0ZJWEVEX0lOVEYoMHgwNWM2LCAweDkyMGQsIDApfSwNCiAJe1FNSV9GSVhF
RF9JTlRGKDB4MDVjNiwgMHg5MjBkLCA1KX0sDQorCXtRTUlfUVVJUktfU0VUX0RUUigweDA1YzYs
IDB4OTYyNSwgNCl9LAkvKiBZVUdBIENMTTkyMC1OQzUgKi8NCiAJe1FNSV9GSVhFRF9JTlRGKDB4
MDg0NiwgMHg2OGEyLCA4KX0sDQogCXtRTUlfRklYRURfSU5URigweDEyZDEsIDB4MTQwYywgMSl9
LAkvKiBIdWF3ZWkgRTE3MyAqLw0KIAl7UU1JX0ZJWEVEX0lOVEYoMHgxMmQxLCAweDE0YWMsIDEp
fSwJLyogSHVhd2VpIEUxODIwICovDQotLSANCjIuMTEuMA0K
