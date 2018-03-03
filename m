Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvKo4oZbq7AIVFHF6cmlo74Q/D88Bg1ezypnx3XhRqfZujHvdKstLCB3c1QYso3raUji/ux
ARC-Seal: i=1; a=rsa-sha256; t=1520116622; cv=none;
        d=google.com; s=arc-20160816;
        b=ObmeXO7TqkX8Up6AJI+bk7vBTkl/+akoVmAA0NGYxe9xBsUGybgAsQsa9Pw7vD2W+j
         9Eau8ZdnWXHHrMjeImf3C3zwWDEyJXA0oGp38CpxJWce9479Jpg+3rohmr3us3IsiJtF
         T0qrTffrkxBk6rYdA9ex0oabPn1Hsq+rIWXOxSSyeESIetnKeKawm75KFVaRMezC0rEa
         CFMkO6tPxnAe2+q/KJPbsjOFOZINyxDTgCAaZokQEfmkp1CHcdzFmUhI0oW1enFi9glX
         laHPC04UoO8SK/5J5OpimEKIjFMMqeHKhPgehyyEoRtulBjpcvYkGYgPYkTGqccbdTwC
         mnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=cFeB1TrgMtZngp0wwDtx1od604UigPepXX0cJiGvXIY=;
        b=sKSt0g2csCqxOso9lj9UsNR5RYBNGekTEm++rYzAdwrkBQ2kClRkRJ0fkEL3j11smR
         H/8sW7x3bqelUWpCpCvl9UGELzydQZVcVE4QCkx/iFleaCPiZ2Dc2WOz6kFPi31f6Wu5
         n6Sa9vu71mshCrq5Qz84qV5o3V3mI89lPS5AqgutMGbW98ev4brMNvoYjOvp7Ar9W5nd
         9D3j9Wqc3vlh41QQTNXznXRhxXfvEBOz40/GQx5YVByGdFjLQbNj/wc6Ju13ZT47TTfX
         Kby0K9zUug1pgZzhSwv5fnQ/y25F4uSVxzLDWQCpemQ4H8dKQWRtYz6B70sc775e11vb
         mnDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=cDJmMp9g;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.117 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=cDJmMp9g;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.117 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Julien BOIBESSOT <julien.boibessot@armadeus.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 201/219] tools/usbip: fixes build with musl
 libc toolchain
Thread-Topic: [PATCH AUTOSEL for 4.9 201/219] tools/usbip: fixes build with
 musl libc toolchain
Thread-Index: AQHTsz8m3KFIkTbWO0WqkWkpyimITQ==
Date: Sat, 3 Mar 2018 22:29:53 +0000
Message-ID: <20180303222716.26640-201-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:PHyOUFXci/KjjFyDu+o1+F90v4Dc9QwlEv+ZJqzxgf/ie+CdzxMt3UJSb50B1g6HB+aKbjqN32LPsF90B58VFC9QS0wuKPPgmbmifKxpYiD45OzD4+tqH8hWxoJiWl0FMfTgNINkQVk9FBX0VLNzZiV4LxjKgE/ijtGJblyIjRVd5GyzT058VDdcWVMxm7EbGegAnfq78znGnM4Ym/Otx+CqFysFxo5cD2eQuU23+0iw6VrkIQvVwWRRauWQiHXO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce0c7997-f08a-4cc8-bf25-08d581574354
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB096924F87B013A04CECE6F04FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Pi4vHy3jdpsKi0L1VJUp2oBZDTGi1xP6lRgmCJmIRbaVXXTZEnNAV/j3UsnDu9NWS89PKtFtMd0dTKdabI0NPiNGByNsF5lBwF47FiTkymkHQiG4wB+MEV43+ehoD1LP4s038VWuZzkiQozTo3c1c06JAmRT9+O0Toyc4mxJxgo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8D94EF0EA66D74283F156C9F87A7816@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0c7997-f08a-4cc8-bf25-08d581574354
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:53.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957177068415875?=
X-GMAIL-MSGID: =?utf-8?q?1593957807027698161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSnVsaWVuIEJPSUJFU1NPVCA8anVsaWVuLmJvaWJlc3NvdEBhcm1hZGV1cy5jb20+DQoN
ClsgVXBzdHJlYW0gY29tbWl0IDc3YmU0Yzg3OGM3MmU0MTFhZDIyYWY5NmI2ZjgxZGQ0NWMyNjQ1
MGEgXQ0KDQpJbmRlZWQgbXVzbCBkb2Vzbid0IGRlZmluZSBvbGQgU0lHQ0xEIHNpZ25hbCBuYW1l
IGJ1dCBvbmx5IG5ldyBvbmUgU0lHQ0hMRC4NClNJR0NITEQgaXMgdGhlIG5ldyBQT1NJWCBuYW1l
IGZvciB0aGF0IHNpZ25hbCBzbyBpdCBkb2Vzbid0IGNoYW5nZQ0KYW55dGhpbmcgb24gb3RoZXIg
bGliY3MuDQoNClRoaXMgZml4ZXMgdGhpcyBraW5kIG9mIGJ1aWxkIGVycm9yOg0KDQp1c2JpcGQu
YzogSW4gZnVuY3Rpb24g4oCYc2V0X3NpZ25hbOKAmToNCnVzYmlwZC5jOjQ1OToxMjogZXJyb3I6
ICdTSUdDTEQnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0KICBzaWdh
Y3Rpb24oU0lHQ0xELCAmYWN0LCBOVUxMKTsNCiAgICAgICAgICAgIF5+fn5+fg0KdXNiaXBkLmM6
NDU5OjEyOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5
IG9uY2UNCglmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluDQpNYWtlZmlsZTo0MDc6IHJl
Y2lwZSBmb3IgdGFyZ2V0ICd1c2JpcGQubycgZmFpbGVkDQptYWtlWzNdOiAqKiogW3VzYmlwZC5v
XSBFcnJvciAxDQoNClNpZ25lZC1vZmYtYnk6IEp1bGllbiBCT0lCRVNTT1QgPGp1bGllbi5ib2li
ZXNzb3RAYXJtYWRldXMuY29tPg0KQWNrZWQtYnk6IFNodWFoIEtoYW4gPHNodWFoa2hAb3NnLnNh
bXN1bmcuY29tPg0KU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIu
bGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIHRvb2xzL3VzYi91c2JpcC9zcmMvdXNiaXBkLmMg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS90b29scy91c2IvdXNiaXAvc3JjL3VzYmlwZC5jIGIvdG9vbHMvdXNiL3Vz
YmlwL3NyYy91c2JpcGQuYw0KaW5kZXggYTA5NzJkZWE5ZTZjLi4xOTM1NTY1MDc5NTcgMTAwNjQ0
DQotLS0gYS90b29scy91c2IvdXNiaXAvc3JjL3VzYmlwZC5jDQorKysgYi90b29scy91c2IvdXNi
aXAvc3JjL3VzYmlwZC5jDQpAQCAtNDYzLDcgKzQ2Myw3IEBAIHN0YXRpYyB2b2lkIHNldF9zaWdu
YWwodm9pZCkNCiAJc2lnYWN0aW9uKFNJR1RFUk0sICZhY3QsIE5VTEwpOw0KIAlzaWdhY3Rpb24o
U0lHSU5ULCAmYWN0LCBOVUxMKTsNCiAJYWN0LnNhX2hhbmRsZXIgPSBTSUdfSUdOOw0KLQlzaWdh
Y3Rpb24oU0lHQ0xELCAmYWN0LCBOVUxMKTsNCisJc2lnYWN0aW9uKFNJR0NITEQsICZhY3QsIE5V
TEwpOw0KIH0NCiANCiBzdGF0aWMgY29uc3QgY2hhciAqcGlkX2ZpbGU7DQotLSANCjIuMTQuMQ0K
