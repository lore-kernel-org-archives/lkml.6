Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELveqLM3etOwifFdXTNkajn+/vcdEKVHOZKmVFVo9+viS32yZ5yADJ9/I0BULRLariq9I+Zb
ARC-Seal: i=1; a=rsa-sha256; t=1520116502; cv=none;
        d=google.com; s=arc-20160816;
        b=xSqj8I8YX6iCgrVWancS85O4gnrmU4coFbeJqArtbzgq/F46biOFRUU4m//oaVUuYi
         cZPBgOSm1XX6VjTbM0EMFQNBeYNHMm4OkzOJ6gl9k4X3mVoDBRkBAzB8VWHmHD2MbtQP
         mpvwukWJI6JvH1E0gRSlskTJXFApAV+9yE8Sdco6kL+oKwE0NO0OquCmbwyvbOVrj88p
         JR/I9JR8+Nfy+z5Ae8tBAZ/fio6lc6JqjkkW6rFfQZGM9zD86IG/XrS2W9m1g1DvIW9p
         vLBCoJHzhkF0eeSuEakVd1GO5B/sFQcznkp+LVrl2aIMwuIYP1C5LTPQ09sqO0OPa+dg
         SJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=HFIgHfiboa/YdlBwZMtz6UmZUZnPc5M6b2etwJRANyA=;
        b=udxi4B5wSio2k6AiM78tYvKJLyD44n2GjUxchuewwWltHoMSopSsU+Wwarah/Zgztu
         kcSujXmJ40V67Xvz9UgT/ah9S96ee0hkQsYwVGAwRUgrWpeAoB/uWJNMetJgkwIWEij6
         AD7mWdF1lhSxg+ljAfFYJX38qLxK1nBC057d1dxEOp+h9t8riceq21qlsGywDqG61R54
         PI12F3ZNFrNlmlBn4C2/USJqMRROvbBKOD1SsVAYFEKBEULi431FjeNmLI73Jn0Etuyb
         m8s4zY9caVv2xgAItlNYERa4Y9YNrtNy6Hk10AjbDLujY6eVbqqDYTFd4F41kNR+mEEA
         UGBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=FKBUKDnG;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=FKBUKDnG;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 135/219] serial: imx: setup DCEDTE early and
 ensure DCD and RI irqs to be off
Thread-Topic: [PATCH AUTOSEL for 4.9 135/219] serial: imx: setup DCEDTE early
 and ensure DCD and RI irqs to be off
Thread-Index: AQHTsz8P4tqwTq4yVUeV5mfE5cnVYw==
Date: Sat, 3 Mar 2018 22:29:14 +0000
Message-ID: <20180303222716.26640-135-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:Pu/opkgr+iHCBByiorSqZ65DrVcz27rcNRvkKRH+utiMW9AflIurvnZs6HprQIlPMOQypcFA34Ghv72H5IGqztB/Zrxvhsz3IR/a7jwzh9AtFo8KmmyagSTGvA8FnQ812Jw0k5taZm8pngO32V4cvNSAFrcugNnmshnCQNuoYwjnArNP4vMdJAlbmESyeV0TLeLMPD+0vAeB6/RUOAm/pQOI+g3ch54o7CQzicIdvY25aQW+db5MxrZgVzNPO/Xg3SsRyb5GRPKXzPwxUJd2qDRjEOxfBatngMpyLiEtNoKhreNq3j071vfP9VTX/AkYVifqonY5pL11VSKeTg4Lj1U/0+fa/n4qvqkS5ge9gWs=;5:xpIcDzWE2OI5aYE309KVUU8WrZ+FgKI1CM+qpsz3MHa7udYLN7RIU5HdcHCVmp4RtuiQe3aM7U+z0ygTXZBtzxf91NG5bfpA+ERYmjHU7wtEBZhgoKOLdHQHJ1CdyD4VU+X6A/VN+xM2bEcWapfYTLW5AN0Sj3R42AxRdZLbV6Q=;24:MPh7kBZan/JaqwpA5pq7VwTv7ELXzzU+3a6QuUs0F0FHLjgcMbLWLBQFhk/7KyHBIrSlU0AUBs9iYBR+UREjy7u+WNis1RenqqViD6o548Q=;7:gS9UKZLZ/sdre8VIh3Xcx0qVoOHpX9dp4V/vaU8uNmHJFCIT3acd2X00fpwCZhmDK9CQf+Su4pvbRALDGfqiWT4DW0VeM5sPSJ/QXDVNdNthoZMGPltvkSMsrMi2j6b2qVCqQVFyZqr4urswIKqxwBFbppkK8YFlhWvyP7YYUqCDtVQ3w/mi3HdpOHlP10jHzpqxURktZfnQl80162zydq5TABXj7kSfDUWqa5u/VHSAL4G1FfHq5Fy3hD8CSAT/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd0dfee5-cc1a-4d3b-35ae-08d58156fb54
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09245F9D23E349E425F3A6DFFBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="utf-8"
Content-ID: <681C2C915AC31E4B8D81D8E9617F0EC0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0dfee5-cc1a-4d3b-35ae-08d58156fb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:14.6819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957681592050132?=
X-GMAIL-MSGID: =?utf-8?q?1593957681592050132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4N
Cg0KWyBVcHN0cmVhbSBjb21taXQgZTYxYzM4ZDg1YjczOTJlMDMzZWUwM2JjYTQ2ZjFkNjAwNjE1
NjE3NSBdDQoNCklmIHRoZSBVQVJUIGlzIG9wZXJhdGVkIGluIERURSBtb2RlIGFuZCBVQ1IzX0RD
RCBvciBVQ1IzX1JJIGFyZSAxICh3aGljaA0KaXMgdGhlIHJlc2V0IGRlZmF1bHQpIGFuZCB0aGUg
b3Bwb3NpdGUgc2lkZSBwdWxscyB0aGUgcmVzcGVjdGl2ZSBsaW5lIHRvDQppdHMgYWN0aXZlIGxl
dmVsIHRoZSBpcnEgdHJpZ2dlcnMgYWZ0ZXIgaXQgaXMgcmVxdWVzdGVkIGluIC5wcm9iZS4NCg0K
VGhlc2UgaXJxcyB3ZXJlIGFscmVhZHkgZGlzYWJsZWQgaW4gLnN0YXJ0dXAgYnV0IHRoaXMgbWln
aHQgYmUgdG9vIGxhdGUuDQoNCkFsc28gc2V0dXAgb2YgdGhlIFVGQ1JfRENFRFRFIGJpdCAoY3Vy
cmVudGx5IGRvbmUgaW4gLnNldF90ZXJtaW9zKSBpcw0KZG9uZSB2ZXJ5IGxhdGUgd2hpY2ggaXMg
Y3JpdGljYWwgYXMgaXQgYWxzbyBjb250cm9scyBkaXJlY3Rpb24gb2Ygc29tZQ0KcGlucy4NCg0K
U28gc2V0dXAgVUZDUl9EQ0VEVEUgZWFybGllciAoaW4gLnByb2JlKSBhbmQgYWxzbyBkaXNhYmxl
IHRoZSBicm9rZW4NCmlycXMgaW4gRFRFIG1vZGUgdGhlcmUgYmVmb3JlIHJlcXVlc3RpbmcgaXJx
cy4NCg0KQWNrZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KU2ln
bmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25p
eC5kZT4NClNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmlu
QG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCAzNiArKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9z
ZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCmluZGV4IDUyMWE2ZTQ1MDc1
NS4uZjU3NWEzMzk3NGZhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQor
KysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCkBAIC0xMzE2LDE5ICsxMzE2LDEwIEBAIHN0
YXRpYyBpbnQgaW14X3N0YXJ0dXAoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCiAJaWYgKCFpc19p
bXgxX3VhcnQoc3BvcnQpKSB7DQogCQl0ZW1wID0gcmVhZGwoc3BvcnQtPnBvcnQubWVtYmFzZSAr
IFVDUjMpOw0KIA0KLQkJLyoNCi0JCSAqIFRoZSBlZmZlY3Qgb2YgUkkgYW5kIERDRCBkaWZmZXJz
IGRlcGVuZGluZyBvbiB0aGUgVUZDUl9EQ0VEVEUNCi0JCSAqIGJpdC4gSW4gRENFIG1vZGUgdGhl
eSBjb250cm9sIHRoZSBvdXRwdXRzLCBpbiBEVEUgbW9kZSB0aGV5DQotCQkgKiBlbmFibGUgdGhl
IHJlc3BlY3RpdmUgaXJxcy4gQXQgbGVhc3QgdGhlIERDRCBpcnEgY2Fubm90IGJlDQotCQkgKiBj
bGVhcmVkIG9uIGkuTVgyNSBhdCBsZWFzdCwgc28gaXQncyBub3QgdXNhYmxlIGFuZCBtdXN0IGJl
DQotCQkgKiBkaXNhYmxlZC4gSSBkb24ndCBoYXZlIHRlc3QgaGFyZHdhcmUgdG8gY2hlY2sgaWYg
UkkgaGFzIHRoZQ0KLQkJICogc2FtZSBwcm9ibGVtIGJ1dCBJIGNvbnNpZGVyIHRoaXMgbGlrZWx5
IHNvIGl0J3MgZGlzYWJsZWQgZm9yDQotCQkgKiBub3csIHRvby4NCi0JCSAqLw0KLQkJdGVtcCB8
PSBJTVgyMV9VQ1IzX1JYRE1VWFNFTCB8IFVDUjNfQUROSU1QIHwNCi0JCQlVQ1IzX0RUUkRFTiB8
IFVDUjNfUkkgfCBVQ1IzX0RDRDsNCisJCXRlbXAgfD0gVUNSM19EVFJERU4gfCBVQ1IzX1JJIHwg
VUNSM19EQ0Q7DQogDQogCQlpZiAoc3BvcnQtPmR0ZV9tb2RlKQ0KKwkJCS8qIGRpc2FibGUgYnJv
a2VuIGludGVycnVwdHMgKi8NCiAJCQl0ZW1wICY9IH4oVUNSM19SSSB8IFVDUjNfRENEKTsNCiAN
CiAJCXdyaXRlbCh0ZW1wLCBzcG9ydC0+cG9ydC5tZW1iYXNlICsgVUNSMyk7DQpAQCAtMTU4Myw4
ICsxNTc0LDYgQEAgaW14X3NldF90ZXJtaW9zKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVj
dCBrdGVybWlvcyAqdGVybWlvcywNCiANCiAJdWZjciA9IHJlYWRsKHNwb3J0LT5wb3J0Lm1lbWJh
c2UgKyBVRkNSKTsNCiAJdWZjciA9ICh1ZmNyICYgKH5VRkNSX1JGRElWKSkgfCBVRkNSX1JGRElW
X1JFRyhkaXYpOw0KLQlpZiAoc3BvcnQtPmR0ZV9tb2RlKQ0KLQkJdWZjciB8PSBVRkNSX0RDRURU
RTsNCiAJd3JpdGVsKHVmY3IsIHNwb3J0LT5wb3J0Lm1lbWJhc2UgKyBVRkNSKTsNCiANCiAJd3Jp
dGVsKG51bSwgc3BvcnQtPnBvcnQubWVtYmFzZSArIFVCSVIpOw0KQEAgLTIxNDksNiArMjEzOCwy
NyBAQCBzdGF0aWMgaW50IHNlcmlhbF9pbXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAJCSBVQ1IxX1RYTVBUWUVOIHwgVUNSMV9SVFNERU4pOw0KIAl3cml0ZWxfcmVsYXhl
ZChyZWcsIHNwb3J0LT5wb3J0Lm1lbWJhc2UgKyBVQ1IxKTsNCiANCisJaWYgKCFpc19pbXgxX3Vh
cnQoc3BvcnQpICYmIHNwb3J0LT5kdGVfbW9kZSkgew0KKwkJLyoNCisJCSAqIFRoZSBEQ0VEVEUg
Yml0IGNoYW5nZXMgdGhlIGRpcmVjdGlvbiBvZiBEU1IsIERDRCwgRFRSIGFuZCBSSQ0KKwkJICog
YW5kIGluZmx1ZW5jZXMgaWYgVUNSM19SSSBhbmQgVUNSM19EQ0QgY2hhbmdlcyB0aGUgbGV2ZWwg
b2YgUkkNCisJCSAqIGFuZCBEQ0QgKHdoZW4gdGhleSBhcmUgb3V0cHV0cykgb3IgZW5hYmxlcyB0
aGUgcmVzcGVjdGl2ZQ0KKwkJICogaXJxcy4gU28gc2V0IHRoaXMgYml0IGVhcmx5LCBpLmUuIGJl
Zm9yZSByZXF1ZXN0aW5nIGlycXMuDQorCQkgKi8NCisJCXdyaXRlbChVRkNSX0RDRURURSwgc3Bv
cnQtPnBvcnQubWVtYmFzZSArIFVGQ1IpOw0KKw0KKwkJLyoNCisJCSAqIERpc2FibGUgVUNSM19S
SSBhbmQgVUNSM19EQ0QgaXJxcy4gVGhleSBhcmUgYWxzbyBub3QNCisJCSAqIGVuYWJsZWQgbGF0
ZXIgYmVjYXVzZSB0aGV5IGNhbm5vdCBiZSBjbGVhcmVkDQorCQkgKiAoY29uZmlybWVkIG9uIGku
TVgyNSkgd2hpY2ggbWFrZXMgdGhlbSB1bnVzYWJsZS4NCisJCSAqLw0KKwkJd3JpdGVsKElNWDIx
X1VDUjNfUlhETVVYU0VMIHwgVUNSM19BRE5JTVAgfCBVQ1IzX0RTUiwNCisJCSAgICAgICBzcG9y
dC0+cG9ydC5tZW1iYXNlICsgVUNSMyk7DQorDQorCX0gZWxzZSB7DQorCQl3cml0ZWwoMCwgc3Bv
cnQtPnBvcnQubWVtYmFzZSArIFVGQ1IpOw0KKwl9DQorDQogCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShzcG9ydC0+Y2xrX2lwZyk7DQogDQogCS8qDQotLSANCjIuMTQuMQ0K
