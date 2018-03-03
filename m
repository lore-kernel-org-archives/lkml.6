Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtI5S32UNiddk6RrRzT9XLz/26KaVXSftiz7e3ahOFD/ln5uBMHD8W9mCm8WDj1FGcDWb1h
ARC-Seal: i=1; a=rsa-sha256; t=1520115884; cv=none;
        d=google.com; s=arc-20160816;
        b=fcE7y0SAhMiIIfBLoFfo1niMcSxjBrAT2HnA7EIUxwafr2l1YHoo/34z0kcvNfrKii
         579ey3/Mr42zSOKc0SVi9fda41A5j/UPVXdcezzt5tYVMvCHxLdkXdzNBdjOsBJBybGw
         S8KvRuM0e6PfOMux7ar+GU9FkGFqwuLoH1SWflGAJEmuvHeMXWZQG4T0w2MEjkl8vrFY
         E6Oabag+38NzTbnPTYyXeaWRzNGAGIx4h0wurVjMCQxsZ4cCu188InKFuLRQU7clHSGi
         pdsrHe1gsrJaJpH8YTt/pHmgi37z+3r5xLxvK0QiDkTBVueQBu80f6N2bMtth/li8Qpn
         aHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Vk+BA1BGUi1eXJidfdCpbZ3oasjdcM/jjVl7RrI9YUo=;
        b=yeV8L47OfrCHNzoofh/cggpouGd+g+tIjOXH3GYQ77PQO1NR8qOf1bRDPpT8kDrXKZ
         9ZEDDmO+iTbmM0o6PPsvDxkpKepYkJdwGUK4BVwcOoopkCiD/yUhFKYTI6iWT5zZ8S7/
         W+bA6HQJXUsRJW773cJX56+Ts/T2DD4XEuqum1KCAc9qow4SMPAkvojSh/3iTcKlHpf4
         1IL2W+DFOLN5ze3T0W1IOgoSXhqbGxhRM5buVyXKf7gt+I2OAP+X1Ji/5u1YmPdVBkkh
         pIy09GjqpapJLHrr2Z3qr+FFAv4vCgHPMeVuqMKvgBwsnpm8IMTrVbUOXj2jkO0nJCXT
         lXZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LJZAuZc5;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LJZAuZc5;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha
 Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 017/102] USB: ledtrig-usbport: fix of-node
 leak
Thread-Topic: [PATCH AUTOSEL for 4.15 017/102] USB: ledtrig-usbport: fix
 of-node leak
Thread-Index: AQHTsz5f3xDwpl9zXUu5LqbruIUdWQ==
Date: Sat, 3 Mar 2018 22:24:19 +0000
Message-ID: <20180303222318.26006-17-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:Q7wrjLyYGthm3WzKr4ry87HNjJs/SMwLFJCuPuWohov7O7jG+/fdz7mdBy8rjxMhkj1mPONUntLOXvNNXZgAt58cY3t4jQApIaN38HJl57yeunSA753Qx8/HYjMIzaEjisC6egvL1XvyIGTnjNiAoKte2ZrUkQ1rn5LeHXAoXmDB9vhweovMf7xg2Zh0Q9eF901GbxLXyZPJOBCrjupiAnQYAn1XGjjQTVa7l2u4ibcYTd+LeGy2+FaYCkGmCDVL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b92d640-b104-4e5a-d220-08d581558fe2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB089078D94A122DC6003DECB7FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(59450400001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: QVHbCLak9vurcR8/QIZAr1YmeykR2VID5XSQgv3HfzJdPT3DwgPW5dDGncn5DdAA9vh8Eq4+aBBg1CpJE/HIN7lVNBtXmhKlg+gPpEVREP4QriGU7fxsvQu8V7MCrXRJPI2JEHCrak1XWf2LqPgXBmJ44cIpVr4fZ2DTRRlKgqw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCFC43C77A01784988E3BA0C4296E791@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b92d640-b104-4e5a-d220-08d581558fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:19.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957034021312284?=
X-GMAIL-MSGID: =?utf-8?q?1593957034021312284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3JnPg0KDQpbIFVwc3RyZWFtIGNvbW1p
dCAwMzMxMGExNTQ4NGFiNmE4ZjZkOTFiYmY3ZmU0ODZiMTcyNzVjMDlhIF0NCg0KVGhpcyBjb2Rl
IGxvb2tzIHVwIGEgVVNCIGRldmljZSBub2RlIGZyb20gYSBnaXZlbiBwYXJlbnQgVVNCIGRldmlj
ZSBidXQNCm5ldmVyIGRyb3BwZWQgaXRzIHJlZmVyZW5jZSB0byB0aGUgcmV0dXJuZWQgbm9kZS4N
Cg0KQXMgb25seSB0aGUgYWRkcmVzcyBvZiB0aGUgbm9kZSBpcyB1c2VkIGZvciBhIGxhdGVyIG1h
dGNoaW5nLCB0aGUNCnJlZmVyZW5jZSBjYW4gYmUgZHJvcHBlZCBpbW1lZGlhdGVseS4NCg0KTm90
ZSB0aGF0IHRoaXMgdHJpZ2dlciBpbXBsZW1lbnRhdGlvbiBjb25mdXNlcyB0aGUgZGVzY3JpcHRp
b24gb2YgdGhlDQpVU0IgZGV2aWNlIGNvbm5lY3RlZCB0byBhIHBvcnQgd2l0aCB0aGUgcG9ydCBp
dHNlbGYgKHdoaWNoIGRvZXMgbm90IGhhdmUNCmEgZGV2aWNlLXRyZWUgcmVwcmVzZW50YXRpb24p
Lg0KDQpGaXhlczogNGYwNGMyMTBkMDMxICgidXNiOiBjb3JlOiByZWFkIFVTQiBwb3J0cyBmcm9t
IERUIGluIHRoZSB1c2Jwb3J0IExFRCB0cmlnZ2VyIGRyaXZlciIpDQpDYzogUmFmYcWCIE1pxYJl
Y2tpIDxyYWZhbEBtaWxlY2tpLnBsPg0KU2lnbmVkLW9mZi1ieTogSm9oYW4gSG92b2xkIDxqb2hh
bkBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5k
ZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL2NvcmUvbGVkdHJpZy11
c2Jwb3J0LmMgfCA4ICsrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY29yZS9sZWR0cmlnLXVz
YnBvcnQuYyBiL2RyaXZlcnMvdXNiL2NvcmUvbGVkdHJpZy11c2Jwb3J0LmMNCmluZGV4IDlkYmI0
MjljZDQ3MS4uZjFmZGU1MTY1MDY4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvY29yZS9sZWR0
cmlnLXVzYnBvcnQuYw0KKysrIGIvZHJpdmVycy91c2IvY29yZS9sZWR0cmlnLXVzYnBvcnQuYw0K
QEAgLTEzNywxMSArMTM3LDE3IEBAIHN0YXRpYyBib29sIHVzYnBvcnRfdHJpZ19wb3J0X29ic2Vy
dmVkKHN0cnVjdCB1c2Jwb3J0X3RyaWdfZGF0YSAqdXNicG9ydF9kYXRhLA0KIAlpZiAoIWxlZF9u
cCkNCiAJCXJldHVybiBmYWxzZTsNCiANCi0JLyogR2V0IG5vZGUgb2YgcG9ydCBiZWluZyBhZGRl
ZCAqLw0KKwkvKg0KKwkgKiBHZXQgbm9kZSBvZiBwb3J0IGJlaW5nIGFkZGVkDQorCSAqDQorCSAq
IEZJWE1FOiBUaGlzIGlzIHJlYWxseSB0aGUgZGV2aWNlIG5vZGUgb2YgdGhlIGNvbm5lY3RlZCBk
ZXZpY2UNCisJICovDQogCXBvcnRfbnAgPSB1c2Jfb2ZfZ2V0X2NoaWxkX25vZGUodXNiX2Rldi0+
ZGV2Lm9mX25vZGUsIHBvcnQxKTsNCiAJaWYgKCFwb3J0X25wKQ0KIAkJcmV0dXJuIGZhbHNlOw0K
IA0KKwlvZl9ub2RlX3B1dChwb3J0X25wKTsNCisNCiAJLyogQW1vdW50IG9mIHRyaWdnZXIgc291
cmNlcyBmb3IgdGhpcyBMRUQgKi8NCiAJY291bnQgPSBvZl9jb3VudF9waGFuZGxlX3dpdGhfYXJn
cyhsZWRfbnAsICJ0cmlnZ2VyLXNvdXJjZXMiLA0KIAkJCQkJICAgIiN0cmlnZ2VyLXNvdXJjZS1j
ZWxscyIpOw0KLS0gDQoyLjE0LjENCg==
