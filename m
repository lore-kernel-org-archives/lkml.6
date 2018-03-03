Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtoYu77g2tdxgRg6b+8MM8A83HYwAqc4RdDuQAFe7fV8RLjx7V+6J+YTHk/RkpmiOwZZ5Vz
ARC-Seal: i=1; a=rsa-sha256; t=1520116848; cv=none;
        d=google.com; s=arc-20160816;
        b=cySs/4hyfxH3CHvwOY0D54gBUs7TTpybXbA+8Hbnw8tHKcVd9+EwQoYBhptdvBLdpk
         TP2IVZKoxw2POJFLtniRYI+eOZlXHt6y/edrlLbLOMFdziKNQ9BEA7M0p/YhTr0mPggh
         /gHjO/V6AN/LeiLgm8QQOhpWV/y4MzdmnWLxzSX+hoHPRSjf6aRdAYrXgWmzkyhbJ9Dm
         Q671svTouHyrfZAogBMAoupQ88Ml0L6Co7Rmk+vYeT7g6g8hGtSYbYokaZegTCk8w9q9
         Lf29EKNGvlGZB6+1ErFvLp8g4R9jtR2Ds2Hj0n2Qj2q9bS7xUO6XRh5HLXWFyegq1ypX
         iK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=O9U5/VFlQ14BbZ0aQpJBe1KuocVHVINXNDFhtK2vuOI=;
        b=A3AhRLV2y2Z6Pce+FbGT8YNeFuSyByJwvk7nPPjvSua+hjtLkUajGkdx03SrE1dKqz
         aJnMt2IgghFecs/1mBa2TXb+ZJ/lrfOUL2OtU59mt2qL2CWro1vtSMx+opi1Uw33W2Hq
         wwvjhSX4xq5/XlGb7d45fyaQ1quvdu0Cwy1JDe4B/LH+/XSKLKj+KeiXI5Z9QZce0Z6T
         MBfBkJgRwTgc6U3w/Nu0a+LOWPEdWjzK4PV91EJ9zWi9t+qEtTjhRJmR0Ndak5Q/TUlS
         rSrvbMq8a1YZNxGf0Ey1k7DVg5BSAUev1RH+bQNwpaDcoHLEsZRyR/WvwuZH1r2Lxwfj
         kZPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=EYDbHK+9;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.118 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=EYDbHK+9;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.118 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Julien BOIBESSOT <julien.boibessot@armadeus.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 101/115] tools/usbip: fixes build with musl
 libc toolchain
Thread-Topic: [PATCH AUTOSEL for 4.4 101/115] tools/usbip: fixes build with
 musl libc toolchain
Thread-Index: AQHTsz9r0tzIxORcW0iNl1m2VgM2vg==
Date: Sat, 3 Mar 2018 22:31:49 +0000
Message-ID: <20180303223010.27106-101-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:v34fVIgPh9RZzTJ5CctqwM5pBYpxHu/fvehuhs/29/rkdj15SMb9otw1HZbf1/I+0j3+acAGGoP9HfoJrZj17PvNWW9Zl4z6D4J591DmmslneQj84mxnjYtTN/biatBKSP9viAjtx6b4awZMitwgltP4KQpuUZdXK/jOY5ZbbGr6cMoYBCGh0RAbYghjacoN7/te80txxMbHzWmzTQKd08VXfL8ZGBFkwmpUYpBitjvEsp+ZgneuGP8uV6WrrIIy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36b30732-ff59-4780-c2b7-08d58157ceaf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0939F591484DC2E02C611E2CFBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OZg8/dIkxJ5PVnq6ruJ7wCEhvJkjMRWFMqrKNWoDQxEqiwT/5xyUoiSm5Y91sAoYoVgPJZfjorUEL2apIxu1WsW32t7mSyx183CPeMT8Hww/PQ9G9yQ/C2TFoA81kZCd6JXbThvGjILf2OwymJoNB1112n3C+P9H5TuPQY5QUNo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E22F58DF5032024CAA45B4895E23A76B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b30732-ff59-4780-c2b7-08d58157ceaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:49.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957177068415875?=
X-GMAIL-MSGID: =?utf-8?q?1593958045010495691?=
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
YmlwL3NyYy91c2JpcGQuYw0KaW5kZXggMmE3Y2QyYjhkOTY2Li44YzViMGZhYmEyMjkgMTAwNjQ0
DQotLS0gYS90b29scy91c2IvdXNiaXAvc3JjL3VzYmlwZC5jDQorKysgYi90b29scy91c2IvdXNi
aXAvc3JjL3VzYmlwZC5jDQpAQCAtNDUxLDcgKzQ1MSw3IEBAIHN0YXRpYyB2b2lkIHNldF9zaWdu
YWwodm9pZCkNCiAJc2lnYWN0aW9uKFNJR1RFUk0sICZhY3QsIE5VTEwpOw0KIAlzaWdhY3Rpb24o
U0lHSU5ULCAmYWN0LCBOVUxMKTsNCiAJYWN0LnNhX2hhbmRsZXIgPSBTSUdfSUdOOw0KLQlzaWdh
Y3Rpb24oU0lHQ0xELCAmYWN0LCBOVUxMKTsNCisJc2lnYWN0aW9uKFNJR0NITEQsICZhY3QsIE5V
TEwpOw0KIH0NCiANCiBzdGF0aWMgY29uc3QgY2hhciAqcGlkX2ZpbGU7DQotLSANCjIuMTQuMQ0K
