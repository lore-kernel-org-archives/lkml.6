Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELv5o8X7LihFv4zjAHV0RUH1J6o0SGr4dkKVMrCvfvDz5VK4EPfBrD3o6HhQBa6rJ1Ba60ir
ARC-Seal: i=1; a=rsa-sha256; t=1520116208; cv=none;
        d=google.com; s=arc-20160816;
        b=hO8aQWshcd//BMlZZHii+v88impp9HChqRFKEARRvGOpWPPV9N6eQz0c1IsW8cooi5
         /CoYYtIZVqUjmaQTmZfM0x5AyQMZS07SvU2VWfSFb/NWjpPQJdoJl3IOTD2bcTYUiCaw
         Edwi4Op+hL+YOOx9xevcgivWzIdq+r5OKwxc0vyDCYN3UFomCLnK3sMssH+B+qf0zeoX
         4j4TXMhEuQ0ZyoAo+WrWpu0Aef/RXiCGj5ep29Zh6PYcpntOXHuKBmczopI8TQl50efQ
         XRbJvFOsW9SQvQv3k7XITHwSWgAyuTAGfNmgHxn4TRH/BcKzQ6KhrEvMwD1EMMSXDVXm
         xbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=UhhNu1j3AEdeaw8YtqPRC8L/aITCrznW2O0h3cR9dkM=;
        b=lvoSg8wvUPtuTgbTK6hrjSFWUa3fb9hSCcLLL7zBT4d61avjN0VaFGEVMnceVu1MEJ
         43sONXAncS/xME3G6M1MFQ3v5HlzbOLJPFHjTo7/SrelO7vPJh6iRoFh+QZBeIaSUdER
         wOodZ+/hVbdYGMWBtXqurZKBBLBHoK1AwFH74NvCBOHkuMVBqiegofEXXgyy1Km/lLfH
         KhltIRz3hS//Se+6OE77OaP282qOV3Prk5lIhxSorUzBP10eUsxbV9nj3/MZ8jtGj5QU
         5eaZORw0L0wxSrsUtVQDGg9DKdCCx60CW22DWbIrm4+tCjD5XVGbwBOfNIO2w4FGUqFq
         9u4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=SFThrE+D;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.125 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=SFThrE+D;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.125 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Julien BOIBESSOT <julien.boibessot@armadeus.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 55/84] tools/usbip: fixes build with musl
 libc toolchain
Thread-Topic: [PATCH AUTOSEL for 4.14 55/84] tools/usbip: fixes build with
 musl libc toolchain
Thread-Index: AQHTsz6ujXKdi9z1uEyfFeynm4vejQ==
Date: Sat, 3 Mar 2018 22:26:32 +0000
Message-ID: <20180303222518.26271-55-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:y0z+q2q9TPaBDsamkNVVvMm/VEBmcL/dcEIPztFFK1u3GCh5q1K/gbr+OyOurmSVQSHfE2eqBcfyslKAeYR0id8WFuazJ3b26HaubdvCr0VaCLMXMSGjXMQoa2nHDbgaC1MNeUWux82rM1GYan8C9DJAExHhU6ofeN5KzpyhUffw6Pi8sdldlpCb/TFZhoauziV00pP6cw3vVNAnuoE11TYIwpdohLg0bjXADbcLdeMLXpHDX/Bw4mqIkkHbDYow
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6754b18b-02b4-4e25-ac4a-08d58156512e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106520DEDF4288903E870649FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: akwQKLc0833eyH7TIq9yFl/0Ruta68U3qk6v5aAn15D1lTabC8Zsaw5rrwhygVIVqbOgCj3pOXyPUBh6bLS0EsXuRKbJKnxz4qwme0TEmsjhwEFEViA7VrfVU4stNdq8KSOUnEEX444ACNq+bf7irj5cXp0Zuae9twGTYctpL1k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDDF50766661F945A904F96550CE07C7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6754b18b-02b4-4e25-ac4a-08d58156512e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:32.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957177068415875?=
X-GMAIL-MSGID: =?utf-8?q?1593957374005444858?=
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
YmlwL3NyYy91c2JpcGQuYw0KaW5kZXggMDA5YWZiNGEzYWFlLi5jNmRhZDJhMTNjODAgMTAwNjQ0
DQotLS0gYS90b29scy91c2IvdXNiaXAvc3JjL3VzYmlwZC5jDQorKysgYi90b29scy91c2IvdXNi
aXAvc3JjL3VzYmlwZC5jDQpAQCAtNDU2LDcgKzQ1Niw3IEBAIHN0YXRpYyB2b2lkIHNldF9zaWdu
YWwodm9pZCkNCiAJc2lnYWN0aW9uKFNJR1RFUk0sICZhY3QsIE5VTEwpOw0KIAlzaWdhY3Rpb24o
U0lHSU5ULCAmYWN0LCBOVUxMKTsNCiAJYWN0LnNhX2hhbmRsZXIgPSBTSUdfSUdOOw0KLQlzaWdh
Y3Rpb24oU0lHQ0xELCAmYWN0LCBOVUxMKTsNCisJc2lnYWN0aW9uKFNJR0NITEQsICZhY3QsIE5V
TEwpOw0KIH0NCiANCiBzdGF0aWMgY29uc3QgY2hhciAqcGlkX2ZpbGU7DQotLSANCjIuMTQuMQ0K
