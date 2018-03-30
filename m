Return-Path: <toshi.kani@hpe.com>
X-Google-Smtp-Source: AIpwx4/vS6xH38uh4hR+cSAhm+WzxgFsLD8IUBJXlTIaV2laJzKYq5Fzlsp/ipAnoL7nv9oTRCd+
ARC-Seal: i=1; a=rsa-sha256; t=1522431752; cv=none;
        d=google.com; s=arc-20160816;
        b=odm0cmAYaaja+GmNrW/gkZAouDHNngO4Nj3lUSbGw9CINZB/d4FBCJql2Pe98s/eUo
         FluKoNpEfnhF+xZyHVjDORfhoX2RNsMnHDYnqYTaEW2Z4WRy8Opq2Y3WmV8sDkwQkrR8
         aAlRV/Iu6dSYuiDIWdPlj8E1jt8gCMfOJoDeY6CN69nUekYwIlKVIfA7ZsBJl7UlnEM1
         7XWNZOkXSCw/+wbdEAGPE/ObkTWIZ51+C1cQYfosojBV7Ji79/tbeDjtk4gNk7OSRDVx
         SIgwwv5zVcdYJixnHp3PBm6Q+feFKNBovBFTForHFr9sef/2Q7QV9BbS9WlIm7ANbXnD
         P+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=0RcaxddTltlveqNvPg1ea1lGA3Nv2NYXVbvE6UEzFoE=;
        b=m5Rf7iovJ19+ErS3tWtF6z5tfCPlx/n5g0KNvCooUXbIPva3pXKpbg9HpCXykAFkyA
         UTcX4bMmzqKL7Ykwhxd3HHxuv5eoAUnN/dmRLCn8EDMLmwVcaXlBygEJqTRBNrCBPx5N
         H4AP4hcdEzIkyLxF2DpQsEvql6I/hJPEOzS9/dfk8WhAJ2gTBdONsPZjb5G1il99d9zE
         WANZ1CV1/nDpWvYYAtcZwXiWobaAJ/a5aeGMQp0TOUV00gUNpX0tPwHSkmcHCOdlV84S
         SftQvG9sRNxxHAzOaY0L7x8MI1pXYXIs4OllRNJAtmGRbWA24N6DqvtKq5EvS4uuLCdy
         1+sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.241.140.78 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of toshi.kani@hpe.com designates 15.241.140.78 as permitted sender) smtp.mailfrom=toshi.kani@hpe.com
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"guohanjun@huawei.com" <guohanjun@huawei.com>, "tanxiaojun@huawei.com"
	<tanxiaojun@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
	"kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jcm@redhat.com" <jcm@redhat.com>
Subject: Re: [RFC PATCH] lib/ioremap: Avoid triggering BUG_ON when end is not
 PAGE_ALIGN
Thread-Topic: [RFC PATCH] lib/ioremap: Avoid triggering BUG_ON when end is not
 PAGE_ALIGN
Thread-Index: AQHTx+QYtn35R0vJSUez91zNgj+/lKPpDOKA
Date: Fri, 30 Mar 2018 17:41:50 +0000
Message-ID: <1522431689.2693.290.camel@hpe.com>
References: <1522385385-7074-1-git-send-email-xieyisheng1@huawei.com>
In-Reply-To: <1522385385-7074-1-git-send-email-xieyisheng1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1011;7:o3J8hzcnhBTYb2kTuacXsT/mLdAb7JM3dVDZZQsAY6LsAnF5tHFDUQRXbPgp3KU4TIEJVnTjVyGjZB2ILSsLQHEOZkh3Chh1zx6SaF/u3iDdlxrh7yevrxvrt7UvXy9Dpc+6q2GE73OLWNEviIxaGz9NSb+tAfpBqv3hkiQO9BaUD4URI9QMG61gRhPMAncORD0Befx3CafrOrtHZWdp3vOQu3JbiJs7HJ+3u8U1byNAEQy9i2tvJyU6XeqkcHKI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 732ee7f7-900a-44dc-b9c2-08d5966584f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1011;
x-ms-traffictypediagnostic: AT5PR8401MB1011:
x-microsoft-antispam-prvs: <AT5PR8401MB1011B7571DD8ADDCEE91240F82A10@AT5PR8401MB1011.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AT5PR8401MB1011;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1011;
x-forefront-prvs: 06274D1C43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(377424004)(189003)(199004)(3280700002)(68736007)(446003)(76176011)(102836004)(486005)(476003)(14454004)(3660700001)(486005)(11346002)(2616005)(106356001)(59450400001)(2900100001)(6512007)(6116002)(3846002)(53936002)(6506007)(97736004)(99286004)(66066001)(2501003)(5250100002)(6246003)(25786009)(86362001)(105586002)(478600001)(186003)(103116003)(8936002)(8676002)(229853002)(81166006)(54906003)(4326008)(36756003)(5660300001)(7416002)(7736002)(6436002)(2906002)(6486002)(305945005)(26005)(316002)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1011;H:AT5PR8401MB0385.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: io59qR3eDLgQ/8XnmW3N6ngZj6AuaKpwg7JFmvl3CEiQWpZB3sfeB/Bn2kAXkMhdLBwOFuP3QkRG8PTTu9u50J0FjIiONZzhY2mA0vxoWqqPMYvlwr9AhLmfaBM6Zyth4Iz0PWVcXkzD2vJskWc9Hky5eXeuB+sY23ecKMz03Or7IUEZWhPQsJ9GU1TVCXFyEjz7dN/WTFxUAcS8/dvSMAArFHfbKe7jbZd8qA+JJvKH8UROrGEl4qXkMklUhkvLuDC+C1bSaG7EtV9266WbfyHg3T8Jtw2GkMN+FTXJUATnK+Op0wGQmEIHki8692Dhdb2UQ6fLNnp8JyqcsbM/J+UtHnIW4GIcCLQSoLsB8orAD8z6sB8k759zyaAisuiVAtu/ocWBFGavuLNiXoajlCRxNSO82HTi/LKOkrZFtWE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <09CC2BC754EAF0498E344AEAAC336A7F@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 732ee7f7-900a-44dc-b9c2-08d5966584f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2018 17:41:50.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1011
X-OriginatorOrg: hpe.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596337453491201592?=
X-GMAIL-MSGID: =?utf-8?q?1596385396613332468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCAyMDE4LTAzLTMwIGF0IDEyOjQ5ICswODAwLCBZaXNoZW5nIFhpZSB3cm90ZToNCj4g
WmhvdSByZXBvcnRlZCBhIGJ1ZyBvbiBIaXNpbGljb24gYXJtNjQgRDA2IHBsYXRmb3JtIHdpdGgg
NjRLQiBwYWdlIHNpemU6DQogOg0KPiBUaGUgY2F1c2UgaXMgdGhlIHNpemUgb2YgUENJIElPIHJl
c291cmNlIGlzIDMyS0IsIHdoaWNoIGlzIDRLIGFsaWduZWQgYnV0DQo+IG5vdCA2NEtCIGFsaWdu
ZWQsIHNvIHdoZW4gZG8gaW9yZW1hcF9wdGVfcmFuZ2UoKSwgaXRzIGluY29taW5nIGVuZCBpcyBu
b3QNCj4gUEFHRV9BTElHTiBvbiA2NEtCIHBhZ2Ugc2l6ZSBzeXN0ZW0sIGJ1dCBpb3JlbWFwX3B0
ZV9yYW5nZSBpbmNyZWFzZSB0aGUNCj4gYWRkciBieSBQQUdFX1NJWkUsIHdoaWNoIG1ha2VzIGFk
ZHIgIT0gZW5kIHVudGlsIHRyaWdnZXIgQlVHX09OLg0KPiANCj4gVGhpcyBwYXRjaCBpbnRyb2R1
Y2VzIHB0ZV9hZGRyX2VuZChhZGRyLCBlbmQpIHRvIHJlc29sdmUgdGhpcyBwcm9ibGVtLCBqdXN0
DQo+IGFzIHdoYXQgcG1kX2FkZHJfZW5kIGRvLiBXaGVuIGVuZCBpcyBub3QgUEFHRV9BTElHTiwg
aXQgd2lsbCByZXR1cm4gZW5kDQo+IGluc3RlYWQgb2YgYWRkciArIFBBR0VfU0laRSwgdGhlcmVm
b3JlIGlvcmVtYXBfcHRlX3JhbmdlKCkgY2FuIGJyZWFrIG91dA0KPiB3aGVuIHJlYWwgZW5kIGlz
IGNvbWluZy4NCg0KaW9yZW1hcF9wdGVfcmFuZ2UoKSBhc3N1bWVzIHRoYXQgYWRkciBhbmQgZW5k
IGFyZSBhbGlnbmVkIGJ5IFBBR0VfU0laRS4gDQpXaGlsZSBzb21lIGltcHJvdmVtZW50IGNhbiBi
ZSBtYWRlIGluIHRoZSByYW5nZSBjaGVjayBhbmQgZG9jdW1lbnRhdGlvbiwNCiBJIGRvIG5vdCB0
aGluayBpdCBpcyBzYWZlIGZvciBsZXR0aW5nIHRoaXMgbGlicmFyeSBmdW5jdGlvbiB0byBtYXAN
Cm91dHNpZGUgb2YgYSByZXF1ZXN0ZWQgcmFuZ2UgYmxpbmRseS4NCg0KQ2FuIHlvdSBjaGFuZ2Ug
dGhlIGNhbGxlciBvZiBpb3JlbWFwX3BhZ2VfcmFuZ2UoKSB0byBhbGlnbiB0aGUgcmVxdWVzdA0K
YnkgUEFHRV9TSVpFIHNvIHRoYXQgdGhlIGNhbGxlciBpcyBhd2FyZSBvZiB3aGF0IGl0J3MgYXNr
aW5nIGZvcj8gDQoNClRoYW5rcywNCi1Ub3NoaQ0K
