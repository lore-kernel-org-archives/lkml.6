Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELull/PLoaKTMXjZ1XB6PCmU6XptyVSrSQrPMocbuh88/+JeCBlLAPwMbYmaJOnNBhXSw5lM
ARC-Seal: i=1; a=rsa-sha256; t=1520116919; cv=none;
        d=google.com; s=arc-20160816;
        b=Y9HUNFm29dYMomtpZCRSHkUDW3RjYY0jJGKfNMN4eXsUFugcnP15oQ4sxdhfeGRmjm
         orBQpuCApEkyD/wc+XSzF0asHb6asOKDMWqeGeHrRYbh43c4DsBnwvHWzrZGCgLK4ywi
         rctFMItDjxI3JN+372m0HXzC1fsjEBMofnK7bd6QlgUdzMuIxXscNY8vFiYJRSqLU2j0
         k+BMFT0UzXPTrfU00R44FW9TDoZL1+4jZVDxM268uDmcPh7tKWnntq8iw8A/9i/VO9BV
         khOuFXUN91gb5wC4mWXGi3EV1WU5RisM0T1zRPYwqkf8RcpMd06scLDL/IZlNmhxlB1l
         gjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Np3t+x3InHbmwfFAYCM/5dbIfuCJhHVk+KmFH6Up1mM=;
        b=BoownhtR5JNR2RnIQ31fANxsJvhhGr51iXBoXeu/vM5WDjTfMPNqQpoyVqz06gmPLu
         gtzmpDpr/u8uC7ExA4farp3tGiTXsdLgZ/a+rVpiRH6Aq5uxPML0hnlR8c694Xj3RmDj
         jgS8u2fA2h1J80+SzRHe3Z3IHyn315NzmrOGhxguwR22Rhb7MSHa5Kluu/i4KoSaMLeW
         jBFvPv4A5DL3Ae4FhSBChEAhtQMLoW0wk3+pcn0fexq3X4AIQIOVp1oS7dyTMOiIyy5g
         lfi422Rp8fAKjznVGywdl0pbDkxOWPi9Cx0bBHwJi+wqHiQEM52yEWaEmw1T4gehfaft
         AHQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=PnitSYxm;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.93 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=PnitSYxm;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.93 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Julien BOIBESSOT <julien.boibessot@armadeus.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 55/63] tools/usbip: fixes build with musl
 libc toolchain
Thread-Topic: [PATCH AUTOSEL for 3.18 55/63] tools/usbip: fixes build with
 musl libc toolchain
Thread-Index: AQHTsz+v8xPiU4EL90SFSy3Zf/GFVg==
Date: Sat, 3 Mar 2018 22:33:43 +0000
Message-ID: <20180303223228.27323-55-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:his8DvlvF68uFgKLj9jQH4m5mVIZv4N6UZVrHpgcf+gHhAKb0YAFlphv/HEUwVYSgW/fuYClVwe3msZ4dGg0pA5U+Rrs0mavFH1Q3uebvKqABMC8uFIh1Fq77dzhp5Qs10C/lMYaUBtpwd5SfaRhE+Ax34fRgfv4x42mSlMlCXgYgEGrjTtV3UKwyiY2HiRfUZuCGS3UZ7eUBF0Y5c7Zf6tSgckQnqVj1blor1iW1TCELt3jsCvh1O7CNEx7nh60
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99e242c9-d423-4b8f-8767-08d58157f8cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018BAB4260AB00D9974103EFBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: geB72y3Av8pZyHXJv3E2jMapOpMeIbSMMd+Zni13r035VClTAC/69bpmN93vzpbfm1PbWENh16KkMN2IdeCxoNDciJUTZLoZuZBlfbkcXK0BqFaw/CtlvuSjgbWNi7DOFv2Z5hoxtU0TvoYTXL6Chkyps0odx0IvT+gOJxEBcFc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCD93CFFA8B4B5419507495E5EA2745A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e242c9-d423-4b8f-8767-08d58157f8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:43.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957177068415875?=
X-GMAIL-MSGID: =?utf-8?q?1593958119213675554?=
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
YmlwL3NyYy91c2JpcGQuYw0KaW5kZXggMmY4N2YyZDM0OGJhLi41NjI1OTljZGM4OWQgMTAwNjQ0
DQotLS0gYS90b29scy91c2IvdXNiaXAvc3JjL3VzYmlwZC5jDQorKysgYi90b29scy91c2IvdXNi
aXAvc3JjL3VzYmlwZC5jDQpAQCAtNDUzLDcgKzQ1Myw3IEBAIHN0YXRpYyB2b2lkIHNldF9zaWdu
YWwodm9pZCkNCiAJc2lnYWN0aW9uKFNJR1RFUk0sICZhY3QsIE5VTEwpOw0KIAlzaWdhY3Rpb24o
U0lHSU5ULCAmYWN0LCBOVUxMKTsNCiAJYWN0LnNhX2hhbmRsZXIgPSBTSUdfSUdOOw0KLQlzaWdh
Y3Rpb24oU0lHQ0xELCAmYWN0LCBOVUxMKTsNCisJc2lnYWN0aW9uKFNJR0NITEQsICZhY3QsIE5V
TEwpOw0KIH0NCiANCiBzdGF0aWMgY29uc3QgY2hhciAqcGlkX2ZpbGU7DQotLSANCjIuMTQuMQ0K
