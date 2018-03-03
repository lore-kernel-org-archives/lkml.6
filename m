Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvilY2U5ejbg9ibkQKM//ufukLRyO3mS2ikGAbK7EkM+f2kmDOKBlnh6X6SQj4rO+nGb3wR
ARC-Seal: i=1; a=rsa-sha256; t=1520116091; cv=none;
        d=google.com; s=arc-20160816;
        b=twxcM1ZpSixvID1kv42xZq69Vl386mG9JX0jpU64spTegG72ZhEhSTYBLl+9IC9On0
         LQ3yTAa17dgjSiN680TCcA0u7XiiMQcIADoGC0JCX1NAI0TsyaP1JxIvEiEQRLciqsnF
         yRS0yfWHzQtD0d3/f+eEsRWu/R5lo//nskpktoSLv9Crs4fTysaVs5HhzpzWshxbolW8
         G6Z0rWFawlBQtxdm8Pb49JvWSWQH015iJWOjJPVdGA3tW7BT7merpTv3mb6k0I8tFR7i
         jvQlyfou4iq+/OZTwsiDTJ7tcwYUGYm3z9v+myQCbPbFvjMQSPQH9G8WWR1Exe6TB/g3
         LXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=sXl1lYrrIfcf8ybd1eo+y9WoP5APUFpmIXNj3UR0+JE=;
        b=wuvO3EzLfMUmxQW9znvSY6huMhH6eZnPVrGC2CPDf9Nw2JpYH3K23CDNZ9lIYPdK2J
         IqUwcFpeAY6DnnQ4GT5LJ2fMQVmK/jtATk5QB184Or0RSSGdu1DgGQ7D0pc2CR61mF88
         VTXmDNxANHodZxPPv8JH4cI+snPHwOyY/sfaCA3oEZHOyQTJweruYp4aUnU1l4NA08qX
         xMUk2jCIHr/3qkxF2dC225MYeA0wySGmXGBcGmYpedX+sbex7d7PkvuMBTs4C745yDdc
         9MKwH0iiSpMLH7kHZ/NL+0AUla/lG7CqAhZOgrp5Ne96YE8wIqbuAxRxfduTpEKGmheP
         6CRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=X7lmC5jq;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=X7lmC5jq;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha
 Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 13/84] USB: ledtrig-usbport: fix of-node leak
Thread-Topic: [PATCH AUTOSEL for 4.14 13/84] USB: ledtrig-usbport: fix of-node
 leak
Thread-Index: AQHTsz6fxFZDokmrKkiNzAdkfHpm7g==
Date: Sat, 3 Mar 2018 22:26:07 +0000
Message-ID: <20180303222518.26271-13-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:ScTIDve8QuoacU0BmJDuShWaWwsQDckFqXJnsLwiuMXcG1+hGYNdM2h82q1X57IROG+X72mhfFZeO6JpNKI+AaHds6cCMJ1jpbc4oLYQBsD2Gv14YN22TXIfXZTIfmMb7P7QOXEz3Sp8kGrFp0PYBBIpFzbqEWOkxRD+/TKFmipX5iorlhPF/85kuMcn3mse6+i5olky9t4n/rID1fA+bSBbsCrA34J/UTzfYyDNXQw9pxsVAcTKWAUJLqbQU++b1lm1PS0/Kly2Ne+7iqt3eD5Bxrg5WULhGKaCJf19egvg1qVkn23q4PL2PYd2nmMbqGmZx7DCQxXPJjFfNm71DPKfWRElOrYxZYCb2GkrqxMynWDbQ6YF9eZ/MWEhKFC5;5:wIbVfsS69d4dEn2g1ff4aESxlP4BMaEu55sIXhy2AmWcPoVvHHgqLeavu1J5waeyL+CShKT03Ksu9X8MYz9DN7wNJ1a+Mzzco3OQ9+aU+JEEO9DWGScu2OBeZmObuo+Gb/3zmzDMdYx5DlMxpKt4Valsfl0SN+IQwKTGhneEkgI=;24:SG1sSPV3tXK67dJxpDywquMMSCw8iDADxM8MLjswkB2ZHgahjHj4Aeh1qugaKTT0EO28QW2s4eSCUd7swJPUKyeNHXun70eVC4koFzEUbpk=;7:GF3+2G0054vnSbA+iysqBsaLrNltJr2LgLfQ6xAQWnbqLVR7Gziz55LKN2aG8zMGWWHba3fKnmWzILDZbM4z/dgG0IQMBrvP+UrCNfsJAmGtkuXrN5WvZLSGqn9Kt/+bHJCqz+6iCwKceqIurJf1vh7MSUu3BbwX+lh38Du5CLdodaYxI7/D53zQ086l+BnKYOeOw9/ovjoAJN1d4dsHjmvQ002zgOE9TlxRQP5ehVaN8MyLbqwr8zQU0Kelnh+m
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5971f41a-bc86-4a8f-5906-08d581560aec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10671CD80D6DD283EE147076FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: e7d5TKLvlzRi94g6bRgaIIIUK1Ic52P5Jv1fgtzF64sbopxR/WIJlHh2lmJaZ7vuLr6iEq5xqMO7TmbvOdLQUcfZrlXmipX8/7MV+p1KYXAqai2OvUSA+3L9ZdP7mL9Ccx2BY8dTTOdTKJ0EHEZYV+f3KLCqsAqmKxkvmEbQkb8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <49B6747C329F4244AB1825A91528601F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5971f41a-bc86-4a8f-5906-08d581560aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:07.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957034021312284?=
X-GMAIL-MSGID: =?utf-8?q?1593957250999205961?=
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
YnBvcnQuYyBiL2RyaXZlcnMvdXNiL2NvcmUvbGVkdHJpZy11c2Jwb3J0LmMNCmluZGV4IDFhZjg3
Nzk0MjExMC4uMmRlMDQ0NGM5NWE4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvY29yZS9sZWR0
cmlnLXVzYnBvcnQuYw0KKysrIGIvZHJpdmVycy91c2IvY29yZS9sZWR0cmlnLXVzYnBvcnQuYw0K
QEAgLTE0MCwxMSArMTQwLDE3IEBAIHN0YXRpYyBib29sIHVzYnBvcnRfdHJpZ19wb3J0X29ic2Vy
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
