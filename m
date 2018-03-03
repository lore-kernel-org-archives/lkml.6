Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119269-2-12676212142933975640
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
    t=1520119269; b=eUtkON0py/o/vMO/mv56SoFi9l6BL+2A6MVrfBLU5nhlnPD
    zX3/181m6gZT4H/JisFk4U39bgdHkT9mmETH4XAkxhEf6hr01Epj+ZzgDVlHMxOa
    2VzS4xjbFPnDo44AE2HSV5P1lyL0TOz6tq0f82Pyt2IvUCJbUcsS8pMsxh1WYeSC
    WeIsV+xZ+Lu+0F/YablvIVB5zDzaspwAuuPmUWClaUUeKb8eMhlJIsXSyMMImKVV
    qIfBaYmCqOX31LVJPaQjSy1JThCYZxHIkJryB3IVmGIL/syuSO9BHWnxwB4/D3wS
    1+voX2qIRhH1iRtpQxeSsfxeQ10Dw1rM0i2W+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520119269; bh=4ujMfCk6yPXzldDxVFBy/9AW+CR+m7+cK27cgf
    Kp2TI=; b=TWj6gP5DMn0mJSKvHAQs9I4PD75ZEYhub81GKXz5wyDHHTGbYxweOK
    dsTkUBn7WJhiUdjncdrzu09LqACVNzljQ5/qnPYBps+zMhKW9z8jppZiDboV1mRq
    2UMYgL3XPDYmW0fmquMACvFGlW7upnZfttY0lyNuA+0vcfI4RVDpJYgT56Fr54d3
    ortwG8ndYh7ryB2DV0zW/ctr1+7zrsGZJG2n+/2914TTr2vpEByuoep8OOGO+vHG
    G0TZoqsR8lLbx8KqAgZ/udd0l/i3x2ivqck1r2fhJ1zk5shiVNyDW0AWdaKduvkS
    r9b5QkLojQeLIcw4Xb//juyiXUwMz2iQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NIJzxePo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NIJzxePo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeCCXUw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:20:52 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934782AbeCCWh5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VmFsdHRlcmkgSGVpa2tpbMOk?= <rnd@nic.fi>,
        Tomasz Kramkowski <tk@the-tk.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 005/115] HID: reject input outside logical
 range only if null state is set
Thread-Topic: [PATCH AUTOSEL for 4.4 005/115] HID: reject input outside
 logical range only if null state is set
Thread-Index: AQHTsz9ItrjyAlUbGUO5XbW/+tjTmw==
Date: Sat, 3 Mar 2018 22:30:50 +0000
Message-ID: <20180303223010.27106-5-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:cBsJYZmSYAFkKQrXhwtn7IcOjdrW7SsJr8vTXVedRoE2GTHKnxsOE5HW2cTO2R8ArZiaiZ8kt8QdVn+cCCs0oNtXDxcE0bFC3Fxk5T5Ze6JwP7KSjNBf6a3PFXpwS3eDelxPIuzglJtN5kgyxVWz8eVtLywQGAxG6UlXhnyCyK9NQ0b+yz3BNhSpsospz4eayij1qJTvujYZ+4wu+85MVyDk57FA/p+j2McGBte+7+fA/hxJiFPs0kQUv8BWSmOQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18079d3f-7e12-47d8-7449-08d581576764
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11003FEFCF8D6042F1C4E52BFBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(966005)(66066001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(6306002)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: WVpEoUOnV5ckhPileuvLdm+O/QITZX2ZX9udyJv7gGGDhPsshK/eeaadEE0YuTcS5GtWCTqWr6MG9JOnmKEkpBTAR4UycQ+uyVu7HIyDQ69SZodfp30DPI16era/GoYSHr4G/kpklT5RUPrIhQ0+MOjecFr1o5v3XMdc2wzga7U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F88CE65E8B2F1C438649FF2D0E91233F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18079d3f-7e12-47d8-7449-08d581576764
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:50.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
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
aGlkLWlucHV0LmMgYi9kcml2ZXJzL2hpZC9oaWQtaW5wdXQuYw0KaW5kZXggMmJhNmJmNjliN2Qw
Li4zM2QzZGViMzI4ODggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2hpZC9oaWQtaW5wdXQuYw0KKysr
IGIvZHJpdmVycy9oaWQvaGlkLWlucHV0LmMNCkBAIC0xMTM1LDYgKzExMzUsNyBAQCB2b2lkIGhp
ZGlucHV0X2hpZF9ldmVudChzdHJ1Y3QgaGlkX2RldmljZSAqaGlkLCBzdHJ1Y3QgaGlkX2ZpZWxk
ICpmaWVsZCwgc3RydWN0DQogCSAqIGRvbid0IHNwZWNpZnkgbG9naWNhbCBtaW4gYW5kIG1heC4N
CiAJICovDQogCWlmICgoZmllbGQtPmZsYWdzICYgSElEX01BSU5fSVRFTV9WQVJJQUJMRSkgJiYN
CisJICAgIChmaWVsZC0+ZmxhZ3MgJiBISURfTUFJTl9JVEVNX05VTExfU1RBVEUpICYmDQogCSAg
ICAoZmllbGQtPmxvZ2ljYWxfbWluaW11bSA8IGZpZWxkLT5sb2dpY2FsX21heGltdW0pICYmDQog
CSAgICAodmFsdWUgPCBmaWVsZC0+bG9naWNhbF9taW5pbXVtIHx8DQogCSAgICAgdmFsdWUgPiBm
aWVsZC0+bG9naWNhbF9tYXhpbXVtKSkgew0KLS0gDQoyLjE0LjENCg==
