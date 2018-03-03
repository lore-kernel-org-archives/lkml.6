Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117832-2-12482443743116425731
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
    t=1520117831; b=Zhu81XJ4IpeF/ryyxmv6sweHIK4yYv5fvhCrvd4xx9jrSXV
    lmA7n8fnGccilzgO1/850t0khILopfqDPjySXNldrfUprbgcH0n4Q3q2uJdTwcxs
    T4WLPmFwjLtcdjGQPChYWt51MMGFJ7H3Wzhoc+QhpQJCSmttYBzTn87uFqmO+8U3
    NCqOb6djey/VldPh7cYhOKVZCWOPItUTi0X/nIfM/WIzXLZCWV6OrCDQCvS90tcQ
    6pMEu1kgfxEJri+ccyfX+gc86ooo5JQrsXZa0rB0Xd8L9eCOQjCVXzGemFGBbdTT
    2mk31tJLYRJMEfqV9h1CAyi5Jm0Ynq7ch5DxrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520117831; bh=Ah+sJRchFAON3Ef+oiIeYv+CByJpKxYlR0KTph
    HA/u0=; b=BdMzx15/7OE8Waz/85E2kZAvoEVUKwsokDx2bdt8JHTnQZgEzwwliw
    VDONKr+e31QLnbU1FFy2ehvj91vy6But7ui8xj/uFdkAjjsQgF+G5kcjepoav837
    GGm2j/ILhzsUC8510a9ZanjBAbNDcVZKNUXfgN0IxOMs5lsNcTrDEupI+bPwB8G+
    /7i1we3IEVtB3M+UgJAezByWmXmI530mtHg7es5vNshbyqh52tdMeESJl/Q063hE
    OxcMyfI7x4/ass4UkpBojY7Ps5OIby5tXlviZ+ugHalEw3E8bM/ZJfpHHjPoV5uh
    LB5X1BnT+ASyUB5UxN57rBTh5JftrErQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E5sGPYrs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E5sGPYrs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934558AbeCCW45 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:56:57 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935350AbeCCWk6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VmFsdHRlcmkgSGVpa2tpbMOk?= <rnd@nic.fi>,
        Tomasz Kramkowski <tk@the-tk.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 03/63] HID: reject input outside logical
 range only if null state is set
Thread-Topic: [PATCH AUTOSEL for 3.18 03/63] HID: reject input outside logical
 range only if null state is set
Thread-Index: AQHTsz+bzB3jY/nA/U2w3lkisfxqSA==
Date: Sat, 3 Mar 2018 22:33:09 +0000
Message-ID: <20180303223228.27323-3-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:5Gs3Q/TmLqO3CfuMp6liPd4kbZlfwO//jP9b9VQk/iTVxyzHs36HVJHbSZOcGltZOATyhRsY3/Z3bRYNJzmxXFyeaibvk6YG6R7q49lkpsPCubwPw0BANcEmNB+EDwznzJlNSh6pVkVe7oT7nDTmYcGlgk4DTmZqGlNpw/zEyLDYwe1vEB6JBj/DLGN/2KAX09XYDAQC1OcgHtQvu3lD/WCJ65p58tbYvlW0B3Q08eGQpD3qxp4X9LwAPd6PF8rI
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c173c96-d510-4d03-b209-08d58157d3ad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344875E30E4C5FD6E87E953FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(966005)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6306002)(6666003)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: E4zLfMvv7RyBPSluaAptym7/WbuUlJqLY2sNXbEeZBJWnTx+L1v+uDwmDpFqOBTao+eJ5DTj/yDkqyLnkkQjzdfvYr7HeKNZZ6cWmey+ZnHJZUIuvNimIUlnNWxhhJK6LdItg94EcjB9OHNII3YZfuef/0DDKgGoZtnF8AN9bRg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6ED5F924E1DBB43A6BC8006A98117D6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c173c96-d510-4d03-b209-08d58157d3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:09.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
aGlkLWlucHV0LmMgYi9kcml2ZXJzL2hpZC9oaWQtaW5wdXQuYw0KaW5kZXggNTNkMzI1OTY4ZTQy
Li42ZDc2NmZlMmM3ZjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2hpZC9oaWQtaW5wdXQuYw0KKysr
IGIvZHJpdmVycy9oaWQvaGlkLWlucHV0LmMNCkBAIC0xMDk3LDYgKzEwOTcsNyBAQCB2b2lkIGhp
ZGlucHV0X2hpZF9ldmVudChzdHJ1Y3QgaGlkX2RldmljZSAqaGlkLCBzdHJ1Y3QgaGlkX2ZpZWxk
ICpmaWVsZCwgc3RydWN0DQogCSAqIGRvbid0IHNwZWNpZnkgbG9naWNhbCBtaW4gYW5kIG1heC4N
CiAJICovDQogCWlmICgoZmllbGQtPmZsYWdzICYgSElEX01BSU5fSVRFTV9WQVJJQUJMRSkgJiYN
CisJICAgIChmaWVsZC0+ZmxhZ3MgJiBISURfTUFJTl9JVEVNX05VTExfU1RBVEUpICYmDQogCSAg
ICAoZmllbGQtPmxvZ2ljYWxfbWluaW11bSA8IGZpZWxkLT5sb2dpY2FsX21heGltdW0pICYmDQog
CSAgICAodmFsdWUgPCBmaWVsZC0+bG9naWNhbF9taW5pbXVtIHx8DQogCSAgICAgdmFsdWUgPiBm
aWVsZC0+bG9naWNhbF9tYXhpbXVtKSkgew0KLS0gDQoyLjE0LjENCg==
