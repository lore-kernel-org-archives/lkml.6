Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx49irti6hTLH5tzsHqaLNNijCrNg1mEYp8S3QNLceOIqhRuZpjXCQfNvqZ0BpTojb6/ctaLY
ARC-Seal: i=1; a=rsa-sha256; t=1523466406; cv=none;
        d=google.com; s=arc-20160816;
        b=v2NxXscbISDQcboBs6KzMnFrPzsBKUK42EaSdSiFIQ8bvKXyksfTNDzuAXWL4xn7Vq
         0ea/IDcbQUpLC1Nq9g7B1cTNaAtVgo5lk0/RR0QmHqlKqy2R6+GM99RAaigWPwG8sGuZ
         vx6zRvzoPgBJ+CvWXLM06xIzuqlfVvEVpDZ97UfoiaHgWOLOaN/gC3hcJu9B/LCHINHS
         o6/AgEe4X5XlPlQF9YT0RlUDquxHjvCLP11ySqfgAzzooJ2ffZDiTNhjcilLWyAC1Ivz
         M7UCzMF9hjRjuO97VUj3IZz9/XMrZ3eacqJeJKXy2vkl8TsUbbI270/G8WL7thi7NRHs
         3c8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=dfJaeKrEiOZzOAMdngkQYwJerQUrFVYProTVmknmd5c=;
        b=FdVP2PnKMopcJtLuVpvZCz/hhfQ1CwlCzQQVcWeUlna+Wdwire3g9Tce3B+cz93rP3
         ndljT+GokdWCb94rPsavcp2T+9/oDTO3poqzAjw8lSvHaGqQIdGHm3/M4Kfr/ed8V1FA
         pV360SlW42ZnAe2pBLKxtPhQx0I9Rd5BEZhVShmYDaY11DUm5iNylO8ia1gGPxu+8/AU
         48KmUW/0zA+ZpL/G8+GcP7M8YhbGiBG1mgBgTIknRJ8M56hHLO36QOCVzYTfqejGSmn3
         iYaV83x7wHvFTFJSvxf/3ACdBqcwg/4mi99ui08Q6pGjtcrp9OCtTLGmSrVioncEC7SM
         xaog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=GdVYLJ95;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=WC1kT9Qi;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=GdVYLJ95;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=WC1kT9Qi;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,437,1517846400";
   d="scan'208";a="76404665"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@fb.com" <shli@fb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Topic: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Index: AQHTzlpM3bNaKsvglEqiCkNE5lEW0KP5AjIAgAJcawCAAEUegIAAAmyAgAAE1ACAAAFugIAAAXEAgAAdtwCAAATdAIAAAccA
Date: Wed, 11 Apr 2018 17:06:41 +0000
Message-ID: <398bad36e2f01e37645a36d052d62136766ee88d.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <20180411144616.GI793541@devbig577.frc2.facebook.com>
	 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
	 <20180411145632.GK793541@devbig577.frc2.facebook.com>
	 <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
	 <20180411170018.GL793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180411170018.GL793541@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1135;7:wx4fDpW03w4488d0FRnFjsONapx6DGQZFAZK1QiQZWUhoYWtC5OifiunVmBixgwwulFLA1ciDgmlkhy3JE5rgKikOirsRXuY17klesHP2YgXesOt3UgC8AXtdTVR3ug0CBwsaspVNYxY2jFWzcLA7TWHeASj39Re5UVGdi/uH2tzdbFaThGVeI3ZWjXx2C6j2z+/cqQQ7PdnvMUVMDpuw+raY15zYPqgqoErN4GRGinBXl2NHP9B0IZ5AWElQ0Ae;20:s2xH7NP8XjIRQIoGPg35JuxLX5yQp70ZK849UtEe1A8jz3eBECairRDqw/AnWCJpljZR7jrzgjAFiQ757alVrh4IjXjS1qqhsqRlBjpZQm2qw97x78pm8FlpuAN4YVnPwRQciYjT0yl705yysndgsPO+6HIdJyudr8PJekDzY6A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1135;
x-ms-traffictypediagnostic: MWHPR04MB1135:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB113585972AE05636E0C6121198BD0@MWHPR04MB1135.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB1135;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1135;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(51444003)(377424004)(199004)(189003)(7416002)(59450400001)(305945005)(97736004)(7736002)(93886005)(316002)(5660300001)(39060400002)(105586002)(99286004)(66066001)(2351001)(54906003)(76176011)(36756003)(2900100001)(6246003)(118296001)(6512007)(53936002)(1730700003)(5640700003)(106356001)(5250100002)(2501003)(6436002)(6486002)(11346002)(81166006)(478600001)(14454004)(81156014)(8676002)(68736007)(2906002)(102836004)(3280700002)(6116002)(446003)(25786009)(186003)(26005)(3846002)(229853002)(4326008)(6916009)(486006)(3660700001)(6506007)(476003)(8936002)(72206003)(2616005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1135;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 71sOOhNF08Lny7r+ikDUPqvhDRWnE3DfMkRqcFwbDCjNkbCEQdaQnv6Qyagz0HybNnLhWOdMmZyJEGgoW97J9FpqVBBTM6Og9ab1tuvI1f/3/os76iAVK+4AhkO60mHQjCUXqMwxparKgOgF/9OyX19WOz7BHx/5IJizMhnuLhU4bhBJ/m95jKqpG/uYGGwlSsjrMnCRRCog1zCV0CjbpjOaRfaTg/mDYNcBMhiG3dOC+vD/RvCxV3gSp5VG5Zgde046BgJj1HjUYdKbazc5Tt9vBoZYYUunh22T6lkG2rR5t10x4RW/KF7jlePW/+5k0X1jV+Oedwmy7w1wfEb3Q0vHl9vQBcbcnMYQe7Wc9QgYxoTxh6DErOkq7k/oG2f3Yc7Ododw3TNF7BTHZi4mqA2LQzAKEstMf3VRsNRRg14=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A468F2C4C085C544A9426C8122F1B0D8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0c5c8cfe-3271-49c2-7b14-08d59fce98e6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5c8cfe-3271-49c2-7b14-08d59fce98e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 17:06:41.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1135
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597470310452585558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDEwOjAwIC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBXZWQsIEFwciAxMSwgMjAxOCBhdCAwNDo0Mjo1NVBNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDE4LTA0LTExIGF0IDA3OjU2IC0wNzAwLCBUZWp1biBI
ZW8gd3JvdGU6DQo+ID4gPiBBbmQgbG9va2luZyBhdCB0aGUgY2hhbmdlLCBpdCBsb29rcyBsaWtl
IHRoZSByaWdodCB0aGluZyB3ZSBzaG91bGQNCj4gPiA+IGhhdmUgZG9uZSBpcyBjYWNoaW5nIEBs
b2NrIG9uIHRoZSBwcmludF9ibGtnIHNpZGUgYW5kIHdoZW4gc3dpdGNoaW5nDQo+ID4gPiBsb2Nr
cyBtYWtlIHN1cmUgYm90aCBsb2NrcyBhcmUgaGVsZC4gIElPVywgZG8gdGhlIGZvbGxvd2luZyBp
bg0KPiA+ID4gYmxrX2NsZWFudXBfcXVldWUoKQ0KPiA+ID4gDQo+ID4gPiAJc3Bpbl9sb2NrX2ly
cShsb2NrKTsNCj4gPiA+IAlpZiAocS0+cXVldWVfbG9jayAhPSAmcS0+X19xdWV1ZV9sb2NrKSB7
DQo+ID4gPiAJCXNwaW5fbG9jaygmcS0+X19xdWV1ZV9sb2NrKTsNCj4gPiA+IAkJcS0+cXVldWVf
bG9jayA9ICZxLT5fX3F1ZXVlX2xvY2s7DQo+ID4gPiAJCXNwaW5fdW5sb2NrKCZxLT5fX3F1ZXVl
X2xvY2spOw0KPiA+ID4gCX0NCj4gPiA+IAlzcGluX3VubG9ja19pcnEobG9jayk7DQo+ID4gPiAN
Cj4gPiA+IE90aGVyd2lzZSwgdGhlcmUgY2FuIGJlIHR3byBsb2NrIGhvbGRlcnMgdGhpbmtpbmcg
dGhleSBoYXZlIGV4Y2x1c2l2ZQ0KPiA+ID4gYWNjZXNzIHRvIHRoZSByZXF1ZXN0X3F1ZXVlLg0K
PiA+IA0KPiA+IEkgdGhpbmsgdGhhdCdzIGEgYmFkIGlkZWEuIEEgYmxvY2sgZHJpdmVyIGlzIGFs
bG93ZWQgdG8gZGVzdHJveSB0aGUNCj4gPiBzcGlubG9jayBpdCBhc3NvY2lhdGVkIHdpdGggdGhl
IHJlcXVlc3QgcXVldWUgYXMgc29vbiBhcyBibGtfY2xlYW51cF9xdWV1ZSgpDQo+ID4gaGFzIGZp
bmlzaGVkLiBJZiB0aGUgYmxvY2sgY2dyb3VwIGNvbnRyb2xsZXIgd291bGQgY2FjaGUgYSBwb2lu
dGVyIHRvIHRoZQ0KPiA+IGJsb2NrIGRyaXZlciBzcGlubG9jayB0aGVuIHRoYXQgY291bGQgY2F1
c2UgdGhlIGNncm91cCBjb2RlIHRvIGF0dGVtcHQgdG8NCj4gPiBsb2NrIGEgc3BpbmxvY2sgYWZ0
ZXIgaXQgaGFzIGJlZW4gZGVzdHJveWVkLiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdGhhdCBraW5k
DQo+ID4gb2YgcmFjZSBjb25kaXRpb25zLg0KPiANCj4gSSBzZWUsIGJ1dCB0aGF0IHByb2JsZW0g
aXMgdGhlcmUgd2l0aCBvciB3aXRob3V0IGNhY2hpbmcgYXMgbG9uZyBhcyB3ZQ0KPiBoYXZlIHF1
ZXVfbG9jayB1c2FnZSB3aGljaCByZWFjaCBiZXlvbmQgY2xlYW51cF9xdWV1ZSwgcmlnaHQ/ICBX
aGV0aGVyDQo+IHRoYXQgdXNlciBjYWNoZXMgdGhlIGxvY2sgZm9yIG1hdGNoaW5nIHVubG9ja2lu
ZyBvciBub3QgZG9lc24ndCByZWFsbHkNCj4gY2hhbmdlIHRoZSBzaXR1YXRpb24uDQo+IA0KPiBT
aG9ydCBvZiBhZGRpbmcgcHJvdGVjdGlvbiBhcm91bmQgcXVldWVfbG9jayBzd2l0Y2hpbmcsIEkg
Y2FuJ3QgdGhpbmsNCj4gb2YgYSBzb2x1dGlvbiB0aG8uICBQcm9iYWJseSB0aGUgcmlnaHQgdGhp
bmcgdG8gZG8gaXMgYWRkaW5nIHF1ZXVlDQo+IGxvY2svdW5sb2NrIGhlbHBlcnMgd2hpY2ggYXJl
IHNhZmUgdG8gdXNlIGJleW9uZCBjbGVhbnVwX3F1ZXVlLg0KDQpIZWxsbyBUZWp1biwNCg0KQSBz
aW1wbGUgYW5kIGVmZmVjdGl2ZSBzb2x1dGlvbiBpcyB0byBkaXNzb2NpYXRlIGEgcmVxdWVzdCBx
dWV1ZSBmcm9tIHRoZQ0KYmxvY2sgY2dyb3VwIGNvbnRyb2xsZXIgYmVmb3JlIGJsa19jbGVhbnVw
X3F1ZXVlKCkgcmV0dXJucy4gVGhpcyBpcyB3aHkgY29tbWl0DQphMDYzMDU3ZDdjNzMgKCJibG9j
azogRml4IGEgcmFjZSBiZXR3ZWVuIHJlcXVlc3QgcXVldWUgcmVtb3ZhbCBhbmQgdGhlIGJsb2Nr
DQpjZ3JvdXAgY29udHJvbGxlciIpIG1vdmVkIHRoZSBibGtjZ19leGl0X3F1ZXVlKCkgY2FsbCBm
cm9tIF9fYmxrX3JlbGVhc2VfcXVldWUoKQ0KaW50byBibGtfY2xlYW51cF9xdWV1ZSgpLg0KDQpU
aGFua3MsDQoNCkJhcnQuDQoNCg0KDQoNCg==
