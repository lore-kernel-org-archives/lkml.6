Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122115-2-10597878806631320488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122115; b=jJ7Dy7BAPewxvm9/NJZ0Vk1BV3DFp7QqKD4tLVa5FYucQme
    9ZO0mwp94zAA+1r08zgmHjICy8rJVcFuLwiQV5F65Yo2voqFU0n3E1Cn0y3m7Kdd
    JEmJgJdZ4dFahQUeb79FZ0dWQsSCWlBan1edNlIhCuzT4g0a6DvLjLjY+kK9bFE6
    VoJn37flGmd7SyEK2OlHfAnbNeFSLg3NpDlomyszaSuXCp41TsS9C8OA3p+2FHlT
    FcLYw3xeCrrSTup8GsPo0PGQXIYhqqWunE6aXtQ+cUnvdvLsYbkRDay6XSXBafVh
    ba9mfFOjPvd1Ik5XgECu3nmcUX4gNDYSAqP3lgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520122115; bh=h2tvQZDjDkEOHHEtmJSbBxmwzH9HRtNVoXxKyJ
    639oQ=; b=bKGSIlovfhTPFBIUuAbxk5D/+ECSvGp6fjU2czSBbEbfFh1MItu/pX
    f587vdmc9qfz/OXzp3yNtMKDaqMYLhXV+HacRX8DeTI8avr4gaCImmy6d0KJny1g
    T4TcoxQpPWM8qDY7nZ4BdEq2a/tiQ6EjZTeYXLNC63FXLRifDwa+i56E268Vifg9
    K1qwRZ8zxVkGHa80+sg3OaCmUTtKFzTW2IoHOIhLVOzQWLP7kVIN2AHMHid5mEK8
    hhe/tmpqL28xIbTanG4vXR20BR6rVj+9Sr1QFuM1R234ktsqWPxtWfytQQtAviK2
    3u031AOgpt/kYPEKynU1NAezzMqxZFhQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kjgq0rw6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kjgq0rw6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932772AbeCDAIX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:08:23 -0500
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933584AbeCCWbG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VmFsdHRlcmkgSGVpa2tpbMOk?= <rnd@nic.fi>,
        Tomasz Kramkowski <tk@the-tk.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 008/219] HID: reject input outside logical
 range only if null state is set
Thread-Topic: [PATCH AUTOSEL for 4.9 008/219] HID: reject input outside
 logical range only if null state is set
Thread-Index: AQHTsz7iyVaArsO+pEagZD0oYs8g4Q==
Date: Sat, 3 Mar 2018 22:27:59 +0000
Message-ID: <20180303222716.26640-8-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:2HI4uyDBToVKbdd8hFChSLGLTdpZlvvvxAeMHGAfxTJcjnYt7ZFUjQpm3P0qrKWmN2YzWSwVPSgH7GRvXbQ1mXhVWSzI0baDNPbCaGpEJMuQBbuhujrbxmIvxcZGY0Fx9fozkxlEC/SijmXL+LcRsZsJsQfSFIpuwZm4RIg7C+D/wHFQBQDf6a6VcIP2TUbZtGzeWJeL/bazkXEsY87D7N1FfyW/zHW8ULY6vTNQ31uv797wrJxnXJ1cYK+gBfaD
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a724fbe-3b25-47a7-5b91-08d58156714b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB097035C744677976C036C62CFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(966005)(7736002)(8676002)(6512007)(6306002)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 382H0fKmhH1G1HVwmr285DNweYBHr0DasHGwyEDf+mP4y2gKnVLRMSpbImLzXlz1oj/wqluqiYWrxpxPxSdgybX2VQ8zcru38VwfOB04NA0nRxozpbLxXcJgvPpAbsuUmPNHdAc5lhSDiLWiiSj9aPiHJ8ckQRE2V5owQue1IPk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED686DE5F2C4664AACD2CC9D1B7365B7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a724fbe-3b25-47a7-5b91-08d58156714b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:27:59.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVmFsdHRlcmkgSGVpa2tpbMOkIDxybmRAbmljLmZpPg0KDQpbIFVwc3RyZWFtIGNvbW1p
dCAzZjM3NTI3MDVkYmQ1MGI2NmI2NmFkN2I0ZDU0ZmUzM2QyZjc0NmVkIF0NCg0KVGhpcyBwYXRj
aCBmaXhlcyBhbiBpc3N1ZSBpbiBkcml2ZXJzL2hpZC9oaWQtaW5wdXQuYyB3aGVyZSBVU0IgSElE
DQpjb250cm9sIG51bGwgc3RhdGUgZmxhZyBpcyBub3QgY2hlY2tlZCB1cG9uIHJlamVjdGluZyBp
bnB1dHMgb3V0c2lkZQ0KbG9naWNhbCBtaW5pbXVtLW1heGltdW0gcmFuZ2UuIFRoZSBjaGVjayBz
aG91bGQgYmUgbWFkZSBhY2NvcmRpbmcgdG8gVVNCDQpISUQgc3BlY2lmaWNhdGlvbiAxLjExLCBz
ZWN0aW9uIDYuMi4yLjUsIHAuMzEuIFRoZSBmaXggd2lsbCByZXNvbHZlDQppc3N1ZXMgd2l0aCBz
b21lIGdhbWUgY29udHJvbGxlcnMsIHN1Y2ggYXM6DQpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5v
cmcvc2hvd19idWcuY2dpP2lkPTY4NjIxDQoNClt0a0B0aGUtdGsuY29tOiBzaG9ydGVuZWQgYW5k
IGZpeGVkIHNwZWxsaW5nIGluIGNvbW1pdCBtZXNzYWdlXQ0KU2lnbmVkLW9mZi1ieTogVmFsdHRl
cmkgSGVpa2tpbMOkIDxybmRAbmljLmZpPg0KU2lnbmVkLW9mZi1ieTogVG9tYXN6IEtyYW1rb3dz
a2kgPHRrQHRoZS10ay5jb20+DQpBY2tlZC1CeTogQmVuamFtaW4gVGlzc29pcmVzIDxiZW5qYW1p
bi50aXNzb2lyZXNAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IEppcmkgS29zaW5hIDxqa29z
aW5hQHN1c2UuY3o+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmlu
QG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2hpZC9oaWQtaW5wdXQuYyB8IDEgKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQv
aGlkLWlucHV0LmMgYi9kcml2ZXJzL2hpZC9oaWQtaW5wdXQuYw0KaW5kZXggZmI5YWNlMWNlZjhi
Li43NmYyNTI3ZmJjNjAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2hpZC9oaWQtaW5wdXQuYw0KKysr
IGIvZHJpdmVycy9oaWQvaGlkLWlucHV0LmMNCkBAIC0xMTU2LDYgKzExNTYsNyBAQCB2b2lkIGhp
ZGlucHV0X2hpZF9ldmVudChzdHJ1Y3QgaGlkX2RldmljZSAqaGlkLCBzdHJ1Y3QgaGlkX2ZpZWxk
ICpmaWVsZCwgc3RydWN0DQogCSAqIGRvbid0IHNwZWNpZnkgbG9naWNhbCBtaW4gYW5kIG1heC4N
CiAJICovDQogCWlmICgoZmllbGQtPmZsYWdzICYgSElEX01BSU5fSVRFTV9WQVJJQUJMRSkgJiYN
CisJICAgIChmaWVsZC0+ZmxhZ3MgJiBISURfTUFJTl9JVEVNX05VTExfU1RBVEUpICYmDQogCSAg
ICAoZmllbGQtPmxvZ2ljYWxfbWluaW11bSA8IGZpZWxkLT5sb2dpY2FsX21heGltdW0pICYmDQog
CSAgICAodmFsdWUgPCBmaWVsZC0+bG9naWNhbF9taW5pbXVtIHx8DQogCSAgICAgdmFsdWUgPiBm
aWVsZC0+bG9naWNhbF9tYXhpbXVtKSkgew0KLS0gDQoyLjE0LjENCg==
