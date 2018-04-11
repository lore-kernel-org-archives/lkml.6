Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx499V0DeiGIDVAFOJXrhIzl8BgvJjViOVvKI9ibX8oqftBlWuNU9b5oxATaBr8ObWrEeDB5N
ARC-Seal: i=1; a=rsa-sha256; t=1523478189; cv=none;
        d=google.com; s=arc-20160816;
        b=tsmuOWaF/OUG4nrCdniJqCthIGRVBm5IYRxCPRjhIG8Xwkpr4prsMzTTgtoYxwPVZd
         DtuJw4f5TdQ4WJi8bZsKbEwXxPMEOc7GiQy+NyYpp+RwNgJRrE4e14AOxtKshaI1595U
         z3P9Zlivs7jvfayU8JIOi2/Cg8Bo/k5X+HoHOt367YHrtgFR5L3dKQ3lGJq+sm3hwJ2T
         89pNLRklZoKr804ijqu61VAeGZjOBda45C6X+INfE2SPi93n1TegODlIlRlQC03UrQ48
         Fi2bou4gfgK3hh02Ry+Jd7oFUTnB1DzVc2lxJaaNFSk86+8VDZHJmgQgTaeqKIMzz/gb
         hQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=U0TpuanB+Mc9SxOSQJqsR3bQEwnYWfI3wl61tYQuwW8=;
        b=zdc7LhCLtSRiU0yd85NQQOmrONwXi8KRdNMVlxJy9851uLQX6GrOtj245qM8B0ixWA
         r4E76cJRQ+ysVghadS66NWEfVvzLd68i/n6DyJ0k/Af8Kutm1Uh2vVkLh8xKJQ/yRyFL
         vGSq7KHxCHeADgPfasrLmraVYc3MUqn3x8Ml3Xgeos2Ri8ttzLtdYI9bwoZH+8cd94MJ
         99/pLAWtCpwh9zhAOBBFbdTp6EtuNg7Myfph4Bod3YKYpYsZAu+OtBFUuFYo0CawjcNS
         vzgsQOkDfzgsWszOO4+1vZ2wfyNLobSUDgcB7lUjmoRNhMCvSlBSg4+vOSyD46n/ehUz
         tJJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Qqr3eRdx;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=I8p3/TPN;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Qqr3eRdx;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=I8p3/TPN;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,437,1517846400";
   d="scan'208";a="178823160"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@fb.com" <shli@fb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Topic: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Index: AQHTzlpM3bNaKsvglEqiCkNE5lEW0KP5AjIAgAJcawCAAEUegIAAAmyAgAAX/wCAADPagIAAD1uAgAAAcgCAAAD2gIAAAKWAgAAFAQA=
Date: Wed, 11 Apr 2018 20:23:05 +0000
Message-ID: <f9527dc23ae63e4a58e3fabda0320c8bce7714ae.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
	 <20180411190027.GA21274@gmail.com>
	 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
	 <20180411195700.GP793541@devbig577.frc2.facebook.com>
	 <6e2d8be78572fef5fe8f2e0e7ecbdea5839dc198.camel@wdc.com>
	 <20180411200245.GQ793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180411200245.GQ793541@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0671;7:qBxbDgSHVm9QQsEsrJ64eX5wIzsheqyTR78+/uXWq5hgW6Zl84GWVJ4Vuif6fNwxqkCrQqM4BHAr169Xx/YEq5Wy5SwCoKUlxvG4W/dEwfKjtg2M6si0v0I4rK9k8+rfYDXpaAWXF/jIaKs/6aQe8ky0MEal3HYHr0c9WGCRbEuyapNyEJm7IX2K4p0Di6E75wSijPJrG7jRqVaQAI6leuAJ0p8uDxPJbdstAf9Itu7MZLJ4i9Ew9QS9vy26dC5R;20:TcLaKILNfBXS/BVk3rCcqRcPBaaKfknSv4EdBKlo89uLzlfgCDAv4BJava7gzJOFSY46nFSSfiDooGKuPyK/VlkEs2fjOCxZXYhzZhGbIu+v2vZKrPJbfv3YxoQx49GiE9nFcuqS6reLSUKxVreQ8r4q+g3ona2k6z1HMpRW5bU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0671;
x-ms-traffictypediagnostic: MWHPR04MB0671:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0671049EC1DFBAD55EB8BD8D98BD0@MWHPR04MB0671.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0671;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0671;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(366004)(396003)(39860400002)(376002)(377424004)(199004)(189003)(446003)(2501003)(14454004)(6512007)(476003)(54906003)(99286004)(11346002)(72206003)(486006)(3660700001)(53936002)(39060400002)(6486002)(53546011)(86362001)(2906002)(102836004)(93886005)(66066001)(68736007)(2616005)(186003)(316002)(2900100001)(6246003)(6436002)(26005)(6506007)(5640700003)(8676002)(478600001)(5250100002)(36756003)(1730700003)(81156014)(6916009)(229853002)(4326008)(81166006)(106356001)(5660300001)(25786009)(97736004)(6116002)(2351001)(3846002)(3280700002)(59450400001)(76176011)(8936002)(105586002)(7736002)(7416002)(118296001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0671;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DAXLwHR5cH5SQtv61ykcWCzB35E5tMa30Z7R1sKPjx5Rlk4Ud5LAxC10BA0vXuIWRIWkJvDA3D0CE9p30Xuofv0cFJMfPOFdQvEyL9sxKx8T6wJXF58M9W/1cyxLlbQ6FsgGebrQ116XB8JyDzqnk/kuutSDgZGh7lDV98m/Y2ZNUZu0r5ui5FmOSNW7J1q4VPG0wXTYkVkUjrFErhtXgHHQP2GcdnDBUBIQXLiLhdWm5eyBLbHua1C51AqXzGigRi3rO/IrrIRfvr6+o7YffgtrR8zjr1gOKT8f61Rw81DnszrqrbbYq1JswIwlkbhbr4LcLqF8L+SdVKEwk/pbU8neExacHX+hHVSHGwzexX8ESWcQ/e+ZJE5MtFLjGxaZx/v1mmglHpKtjfQhxug9NTgN1McRq7zmXNtUQvPQrZs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4577B4AEF6FA0744AC4C0FC3CAFB6AE7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 670e5d7f-d428-4233-be35-08d59fea0849
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670e5d7f-d428-4233-be35-08d59fea0849
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 20:23:05.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0671
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597482666059235026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDEzOjAyIC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBXZWQsIEFwciAxMSwgMjAxOCBhdCAwODowMDoyOVBNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDE4LTA0LTExIGF0IDEyOjU3IC0wNzAwLCB0akBrZXJu
ZWwub3JnIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBBcHIgMTEsIDIwMTggYXQgMDE6NTU6MjVQTSAt
MDYwMCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+ID4gPiBPbiAwNC8xMS8xOCAxMzowMCwg
QWxleGFuZHJ1IE1vaXNlIHdyb3RlOg0KPiA+ID4gPiA+IEJ1dCB0aGUgcm9vdCBjYXVzZSBvZiBp
dCBpcyBpbiBibGtjZ19pbml0X3F1ZXVlKCkgd2hlbiBibGtnX2NyZWF0ZSgpIHJldHVybnMNCj4g
PiA+ID4gPiBhbiBFUlIgcHRyLCBiZWNhdXNlIGl0IHRyaWVzIHRvIGluc2VydCBpbnRvIGEgcG9w
dWxhdGVkIGluZGV4IGludG8gYmxrY2ctPmJsa2dfdHJlZSwNCj4gPiA+ID4gPiB0aGUgZW50cnkg
dGhhdCB3ZSBmYWlsIHRvIHJlbW92ZSBhdCBfX2Jsa19yZWxlYXNlX3F1ZXVlKCkuDQo+ID4gPiA+
IA0KPiA+ID4gPiBIZWxsbyBBbGV4LA0KPiA+ID4gPiANCj4gPiA+ID4gSGFkIHlvdSBjb25zaWRl
cmVkIHNvbWV0aGluZyBsaWtlIHRoZSB1bnRlc3RlZCBwYXRjaCBiZWxvdz8NCj4gPiA+IA0KPiA+
ID4gQnV0IHF1ZXVlIGluaXQgc2hvdWxkbid0IGZhaWwgaGVyZSwgcmlnaHQ/DQo+ID4gDQo+ID4g
SGVsbG8gVGVqdW4sDQo+ID4gDQo+ID4gWW91ciBxdWVzdGlvbiBpcyBub3QgZW50aXJlbHkgY2xl
YXIgdG8gbWUuIEFyZSB5b3UgcmVmZXJyaW5nIHRvIHRoZSBhdG9taWMNCj4gPiBhbGxvY2F0aW9u
cyBpbiBibGtnX2NyZWF0ZSgpIG9yIGFyZSB5b3UgcGVyaGFwcyByZWZlcnJpbmcgdG8gc29tZXRo
aW5nIGVsc2U/DQo+IA0KPiBIbW0uLiBtYXliZSBJJ20gY29uZnVzZWQgYnV0IEkgdGhvdWdodCB0
aGF0IHRoZSBmYWN0IHRoYXQNCj4gYmxrY2dfaW5pdF9xdWV1ZSgpIGZhaWxzIGl0c2VsZiBpcyBh
bHJlYWR5IGEgYnVnLCB3aGljaCBoYXBwZW5zDQo+IGJlY2F1c2UgYSBwcmV2aW91c2x5IGRlc3Ry
b3llZCBxdWV1ZSBsZWZ0IGJlaGluZCBibGtncy4NCg0KSGVsbG8gVGVqdW4sDQoNCkkgaGFkIG1p
c3NlZCB0aGUgc3RhcnQgb2YgdGhpcyB0aHJlYWQgc28gSSB3YXMgbm90IGF3YXJlIG9mIHdoaWNo
IHByb2JsZW0gQWxleA0Kd2FzIHRyeWluZyB0byBzb2x2ZS4gSW4gdGhlIGRlc2NyaXB0aW9uIG9m
IHYxIG9mIHRoaXMgcGF0Y2ggSSByZWFkIHRoYXQgQWxleA0KdGhpbmtzIHRoYXQgaGUgcmFuIGlu
dG8gYSBzY2VuYXJpbyBpbiB3aGljaCBibGtfcXVldWVfYWxsb2Nfbm9kZSgpIGFzc2lnbnMgYQ0K
cS0+aWQgdGhhdCBpcyBzdGlsbCBpbiB1c2UgYnkgYW5vdGhlciByZXF1ZXN0IHF1ZXVlPyBUaGF0
J3Mgd2VpcmQuIFRoZSBmb2xsb3dpbmcNCmNvZGUgc3RpbGwgb2NjdXJzIGluIF9fYmxrX3JlbGVh
c2VfcXVldWUoKToNCg0KCWlkYV9zaW1wbGVfcmVtb3ZlKCZibGtfcXVldWVfaWRhLCBxLT5pZCk7
DQoNCkl0J3Mgbm90IGNsZWFyIHRvIG1lIGhvdyB0aGF0IHJlbW92ZSBjYWxsIGNvdWxkIGhhcHBl
biAqYmVmb3JlKiBxLT5pZCBpcyByZW1vdmVkDQpmcm9tIHRoZSBibGtjZyByYWRpeCB0cmVlLg0K
DQpCYXJ0Lg0KDQoNCg0K
