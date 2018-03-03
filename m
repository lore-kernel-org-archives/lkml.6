Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116829-2-2846289866287888601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116828; b=E46oEplqb0RWaSOZy+PMBK/ctCFWJFs2Lacu9ZIDOTcWIWC
    cfCp6JTOl2VwRIbQzYNRwkSrmJalTSI3bj9W7a2mL5hzE+kPwdg29XAxbYvR0Q4D
    9nT1XWxxiFpZYr+Fzpr87CO3qsZ+BDh2eqWtwAgr8t3DhyVDeJ0NmyZZB+AxhuXK
    7n1Qu9t/ARjfhBAVNXEfsoeKvW5KzhQAoY1VxBwuNN5jNzXyvkIusFRBRszfIglb
    oO+1BKoSk5R8D0aXowiqbqHnUnX3Of9udh/TEWYBO2ChkdZq54OQKIUf8UfCnLig
    5Tou3hlQ4sYdKHI7un0HOa7vDKxX+RsKHRjsqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520116828; bh=5vbS+CzZUsjEwxMoAOFl4vE9xx6VVRg3r8bKYJ
    A3QBY=; b=MiX3DiaOBKRA0opRJeuhDPBw5WBa+XdNsiXM7BD0QVXexlfpOWoa0n
    yxRhqczYvPDCAAQYjqkxPnlypkLYroeSzFXGyt90dwCji2Y5yoiFHAUFcihR1SJs
    m1/NfTB1GEFh4peOPOtIrBfaX3SantUq3ZZnENl8D3RIswqks/5oenZb8qjAc0r8
    aiQwgv3/XJBhGHf3A1NHNYrIIyckoN800Fw+T5CeAssCK/2U6FRtmPjxKY8ZiD1t
    rFyk+3cJ7IBXtxXDuTRoJdkOp7q8TlNy1sXzxDlmgFW6hJPXPXeHvCY+zhGhOhjB
    XoXBzgxBaBMxHOq6rNuwflCMP7HxsrEg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aIXEhnBP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aIXEhnBP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeCCWkV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:21 -0500
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:13952
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935201AbeCCWkM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Shashank Sharma <shashank.sharma@intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 085/115] video/hdmi: Allow "empty" HDMI
 infoframes
Thread-Topic: [PATCH AUTOSEL for 4.4 085/115] video/hdmi: Allow "empty" HDMI
 infoframes
Thread-Index: AQHTsz9mJwL7U06ymECXS+0qy6vIBA==
Date: Sat, 3 Mar 2018 22:31:40 +0000
Message-ID: <20180303223010.27106-85-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:Q7o/MHkxCxuUA36xqwL+hb0tD34V8c8Hh9iEXQF7uomnzKUSavUAxV2Z2/zQKR2+4sm3RFLHuZpfT6DcjCY+TfYcIZChsD+dmlfpJtS5IvjP1KKBuLa2B0NjMKyDNrgiG3oZqN/pJAc4iZzi9nfrR4Klsg3moO66/3iBLeVU8NslUPOUZFT+Lbc2f6YVGqC1lGjNdEZLOcRKWILXpvn+cxxHlImSBr+RAmtdluevVBB4gk6iKSPrsb7ATrDrCJFO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6dd7cc95-dd88-42b8-cf96-08d58157b87b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093979FB4292185E714441B4FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(95692535739014)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(966005)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(39060400002)(4326008)(6436002)(107886003)(10090500001)(6512007)(6306002)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(6666003)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: SFBrEgVTPVNiL1Q8nYj9PqznBsMXndM/XqEvfqqJX+2coBmAgT8L4JznOvEEYY6of8wJS/0F9lTLhXf0Oqn8q/GeuQ7eM8RBWoBz2vlp7In/De5h/DWAt0MqyUcdUJvyFw+NDIJUSeT/l6ZtDTR9iiY2Dj0FudDFzqf0twF/qNY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <65183F90CC9D2E43A569566A2F1B7FD4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd7cc95-dd88-42b8-cf96-08d58157b87b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:40.7301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4NCg0K
WyBVcHN0cmVhbSBjb21taXQgNTkzZjRiMTlhMDk0YzQ0MjZiZDFlMWUzY2JhYjg3YTQ4YmQxM2M3
MSBdDQoNCkhETUkgMi4wIEFwcGVuZGl4IEYgc3VnZ2VzdCB0aGF0IHdlIHNob3VsZCBrZWVwIHNl
bmRpbmcgdGhlIGluZm9mcmFtZQ0Kd2hlbiBzd2l0Y2hpbmcgZnJvbSAzRCB0byAyRCBtb2RlLCBl
dmVuIGlmIHRoZSBpbmZvZnJhbWUgaXNuJ3Qgc3RyaWN0bHkNCm5lY2Vzc2FyeSAoaWUuIG5vdCBu
ZWVkZWQgdG8gdHJhbnNtaXQgdGhlIFZJQyBvciBzdGVyZW8gaW5mb3JtYXRpb24pLg0KVGhpcyBp
cyBhIHdvcmthcm91bmQgYWdhaW5zdCBzb21lIHNpbmtzIHRoYXQgZmFpbCB0byByZWFsaXplIHRo
YXQgdGhleQ0Kc2hvdWxkIHN3aXRjaCBmcm9tIDNEIHRvIDJEIG1vZGUgd2hlbiB0aGUgc291cmNl
IHN0b3AgdHJhbnNtaXR0aW5nDQp0aGUgaW5mb2ZyYW1lLg0KDQp2MjogSGFuZGxlIHVucGFjaygp
IGFzIHdlbGwNCiAgICBQdWxsIHRoZSBsZW5ndGggY2FsY3VsYXRpb24gaW50byBhIGhlbHBlcg0K
DQpDYzogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAaW50ZWwuY29tPg0KQ2M6IEFu
ZHJ6ZWogSGFqZGEgPGEuaGFqZGFAc2Ftc3VuZy5jb20+DQpDYzogVGhpZXJyeSBSZWRpbmcgPHRo
aWVycnkucmVkaW5nQGdtYWlsLmNvbT4NCkNjOiBIYW5zIFZlcmt1aWwgPGhhbnMudmVya3VpbEBj
aXNjby5jb20+DQpDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnDQpSZXZpZXdlZC1ieTog
QW5kcnplaiBIYWpkYSA8YS5oYWpkYUBzYW1zdW5nLmNvbT4gI3YxDQpTaWduZWQtb2ZmLWJ5OiBW
aWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPg0KTGluazogaHR0
cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoL21zZ2lkLzIwMTcxMTEzMTcwNDI3
LjQxNTAtMi12aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbQ0KUmV2aWV3ZWQtYnk6IFNoYXNo
YW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGludGVsLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNh
c2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMv
dmlkZW8vaGRtaS5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDIwIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9oZG1pLmMgYi9kcml2ZXJzL3Zp
ZGVvL2hkbWkuYw0KaW5kZXggMTYyNjg5MjI3YTIzLi5iNzM1MjBhYWY2OTcgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3ZpZGVvL2hkbWkuYw0KKysrIGIvZHJpdmVycy92aWRlby9oZG1pLmMNCkBAIC0z
MjEsNiArMzIxLDE3IEBAIGludCBoZG1pX3ZlbmRvcl9pbmZvZnJhbWVfaW5pdChzdHJ1Y3QgaGRt
aV92ZW5kb3JfaW5mb2ZyYW1lICpmcmFtZSkNCiB9DQogRVhQT1JUX1NZTUJPTChoZG1pX3ZlbmRv
cl9pbmZvZnJhbWVfaW5pdCk7DQogDQorc3RhdGljIGludCBoZG1pX3ZlbmRvcl9pbmZvZnJhbWVf
bGVuZ3RoKGNvbnN0IHN0cnVjdCBoZG1pX3ZlbmRvcl9pbmZvZnJhbWUgKmZyYW1lKQ0KK3sNCisJ
LyogZm9yIHNpZGUgYnkgc2lkZSAoaGFsZikgd2UgYWxzbyBuZWVkIHRvIHByb3ZpZGUgM0RfRXh0
X0RhdGEgKi8NCisJaWYgKGZyYW1lLT5zM2Rfc3RydWN0ID49IEhETUlfM0RfU1RSVUNUVVJFX1NJ
REVfQllfU0lERV9IQUxGKQ0KKwkJcmV0dXJuIDY7DQorCWVsc2UgaWYgKGZyYW1lLT52aWMgIT0g
MCB8fCBmcmFtZS0+czNkX3N0cnVjdCAhPSBIRE1JXzNEX1NUUlVDVFVSRV9JTlZBTElEKQ0KKwkJ
cmV0dXJuIDU7DQorCWVsc2UNCisJCXJldHVybiA0Ow0KK30NCisNCiAvKioNCiAgKiBoZG1pX3Zl
bmRvcl9pbmZvZnJhbWVfcGFjaygpIC0gd3JpdGUgYSBIRE1JIHZlbmRvciBpbmZvZnJhbWUgdG8g
YmluYXJ5IGJ1ZmZlcg0KICAqIEBmcmFtZTogSERNSSBpbmZvZnJhbWUNCkBAIC0zNDEsMTkgKzM1
MiwxMSBAQCBzc2l6ZV90IGhkbWlfdmVuZG9yX2luZm9mcmFtZV9wYWNrKHN0cnVjdCBoZG1pX3Zl
bmRvcl9pbmZvZnJhbWUgKmZyYW1lLA0KIAl1OCAqcHRyID0gYnVmZmVyOw0KIAlzaXplX3QgbGVu
Z3RoOw0KIA0KLQkvKiBlbXB0eSBpbmZvIGZyYW1lICovDQotCWlmIChmcmFtZS0+dmljID09IDAg
JiYgZnJhbWUtPnMzZF9zdHJ1Y3QgPT0gSERNSV8zRF9TVFJVQ1RVUkVfSU5WQUxJRCkNCi0JCXJl
dHVybiAtRUlOVkFMOw0KLQ0KIAkvKiBvbmx5IG9uZSBvZiB0aG9zZSBjYW4gYmUgc3VwcGxpZWQg
Ki8NCiAJaWYgKGZyYW1lLT52aWMgIT0gMCAmJiBmcmFtZS0+czNkX3N0cnVjdCAhPSBIRE1JXzNE
X1NUUlVDVFVSRV9JTlZBTElEKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQotCS8qIGZvciBzaWRl
IGJ5IHNpZGUgKGhhbGYpIHdlIGFsc28gbmVlZCB0byBwcm92aWRlIDNEX0V4dF9EYXRhICovDQot
CWlmIChmcmFtZS0+czNkX3N0cnVjdCA+PSBIRE1JXzNEX1NUUlVDVFVSRV9TSURFX0JZX1NJREVf
SEFMRikNCi0JCWZyYW1lLT5sZW5ndGggPSA2Ow0KLQllbHNlDQotCQlmcmFtZS0+bGVuZ3RoID0g
NTsNCisJZnJhbWUtPmxlbmd0aCA9IGhkbWlfdmVuZG9yX2luZm9mcmFtZV9sZW5ndGgoZnJhbWUp
Ow0KIA0KIAlsZW5ndGggPSBIRE1JX0lORk9GUkFNRV9IRUFERVJfU0laRSArIGZyYW1lLT5sZW5n
dGg7DQogDQpAQCAtMzcyLDE0ICszNzUsMTYgQEAgc3NpemVfdCBoZG1pX3ZlbmRvcl9pbmZvZnJh
bWVfcGFjayhzdHJ1Y3QgaGRtaV92ZW5kb3JfaW5mb2ZyYW1lICpmcmFtZSwNCiAJcHRyWzVdID0g
MHgwYzsNCiAJcHRyWzZdID0gMHgwMDsNCiANCi0JaWYgKGZyYW1lLT52aWMpIHsNCi0JCXB0cls3
XSA9IDB4MSA8PCA1OwkvKiB2aWRlbyBmb3JtYXQgKi8NCi0JCXB0cls4XSA9IGZyYW1lLT52aWM7
DQotCX0gZWxzZSB7DQorCWlmIChmcmFtZS0+czNkX3N0cnVjdCAhPSBIRE1JXzNEX1NUUlVDVFVS
RV9JTlZBTElEKSB7DQogCQlwdHJbN10gPSAweDIgPDwgNTsJLyogdmlkZW8gZm9ybWF0ICovDQog
CQlwdHJbOF0gPSAoZnJhbWUtPnMzZF9zdHJ1Y3QgJiAweGYpIDw8IDQ7DQogCQlpZiAoZnJhbWUt
PnMzZF9zdHJ1Y3QgPj0gSERNSV8zRF9TVFJVQ1RVUkVfU0lERV9CWV9TSURFX0hBTEYpDQogCQkJ
cHRyWzldID0gKGZyYW1lLT5zM2RfZXh0X2RhdGEgJiAweGYpIDw8IDQ7DQorCX0gZWxzZSBpZiAo
ZnJhbWUtPnZpYykgew0KKwkJcHRyWzddID0gMHgxIDw8IDU7CS8qIHZpZGVvIGZvcm1hdCAqLw0K
KwkJcHRyWzhdID0gZnJhbWUtPnZpYzsNCisJfSBlbHNlIHsNCisJCXB0cls3XSA9IDB4MCA8PCA1
OwkvKiB2aWRlbyBmb3JtYXQgKi8NCiAJfQ0KIA0KIAloZG1pX2luZm9mcmFtZV9zZXRfY2hlY2tz
dW0oYnVmZmVyLCBsZW5ndGgpOw0KQEAgLTExNjEsNyArMTE2Niw3IEBAIGhkbWlfdmVuZG9yX2Fu
eV9pbmZvZnJhbWVfdW5wYWNrKHVuaW9uIGhkbWlfdmVuZG9yX2FueV9pbmZvZnJhbWUgKmZyYW1l
LA0KIA0KIAlpZiAocHRyWzBdICE9IEhETUlfSU5GT0ZSQU1FX1RZUEVfVkVORE9SIHx8DQogCSAg
ICBwdHJbMV0gIT0gMSB8fA0KLQkgICAgKHB0clsyXSAhPSA1ICYmIHB0clsyXSAhPSA2KSkNCisJ
ICAgIChwdHJbMl0gIT0gNCAmJiBwdHJbMl0gIT0gNSAmJiBwdHJbMl0gIT0gNikpDQogCQlyZXR1
cm4gLUVJTlZBTDsNCiANCiAJbGVuZ3RoID0gcHRyWzJdOw0KQEAgLTExODksMTYgKzExOTQsMjIg
QEAgaGRtaV92ZW5kb3JfYW55X2luZm9mcmFtZV91bnBhY2sodW5pb24gaGRtaV92ZW5kb3JfYW55
X2luZm9mcmFtZSAqZnJhbWUsDQogDQogCWh2Zi0+bGVuZ3RoID0gbGVuZ3RoOw0KIA0KLQlpZiAo
aGRtaV92aWRlb19mb3JtYXQgPT0gMHgxKSB7DQotCQlodmYtPnZpYyA9IHB0cls0XTsNCi0JfSBl
bHNlIGlmIChoZG1pX3ZpZGVvX2Zvcm1hdCA9PSAweDIpIHsNCisJaWYgKGhkbWlfdmlkZW9fZm9y
bWF0ID09IDB4Mikgew0KKwkJaWYgKGxlbmd0aCAhPSA1ICYmIGxlbmd0aCAhPSA2KQ0KKwkJCXJl
dHVybiAtRUlOVkFMOw0KIAkJaHZmLT5zM2Rfc3RydWN0ID0gcHRyWzRdID4+IDQ7DQogCQlpZiAo
aHZmLT5zM2Rfc3RydWN0ID49IEhETUlfM0RfU1RSVUNUVVJFX1NJREVfQllfU0lERV9IQUxGKSB7
DQotCQkJaWYgKGxlbmd0aCA9PSA2KQ0KLQkJCQlodmYtPnMzZF9leHRfZGF0YSA9IHB0cls1XSA+
PiA0Ow0KLQkJCWVsc2UNCisJCQlpZiAobGVuZ3RoICE9IDYpDQogCQkJCXJldHVybiAtRUlOVkFM
Ow0KKwkJCWh2Zi0+czNkX2V4dF9kYXRhID0gcHRyWzVdID4+IDQ7DQogCQl9DQorCX0gZWxzZSBp
ZiAoaGRtaV92aWRlb19mb3JtYXQgPT0gMHgxKSB7DQorCQlpZiAobGVuZ3RoICE9IDUpDQorCQkJ
cmV0dXJuIC1FSU5WQUw7DQorCQlodmYtPnZpYyA9IHB0cls0XTsNCisJfSBlbHNlIHsNCisJCWlm
IChsZW5ndGggIT0gNCkNCisJCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KIA0KIAlyZXR1cm4gMDsN
Ci0tIA0KMi4xNC4xDQo=
