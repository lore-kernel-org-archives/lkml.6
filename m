Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx4+0mqNzh4eoIki6C0356zem9/Goh+he2vWaiH8VYbxbucnqSOZ7n4Uqo1gGFnoMMvNc9dFF
ARC-Seal: i=1; a=rsa-sha256; t=1523462096; cv=none;
        d=google.com; s=arc-20160816;
        b=gxDCRJw6LPkkt9lXms6/U4qs447rZpmPxYxveqs+VFJ2la3itMqIj0R5rPjEbnsHUb
         PXsnpXG8SlB/LJZB4XX8q7i1C9jyMuZF64pLafeUNMYTj2cdq4FylROFCbcf4kkxAfYz
         Fif0vGiZjPb96dp+M+vs0TG6t5VCE+6G2yWFIXlo+o5jr8hQVYYVzxQ9WV85SdeSW/iD
         MyNyB99GTlW66YmP0bJ5trYA2CnM0QIyfwYgDq9SLvRVGwwuCZe/v6CbY29STJnDhe5X
         1zfxI3YgLYIJOnKY0U4IJKQVihThSse1FaL4u4jF/i6AFfaIRoaOKNfr7udR+j2kcbCs
         u7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=xtmysjgnh4ng8iyS+iLaEUdB5uZSYiIwfNNQnCpSuX4=;
        b=j070B4dafUNItx5jTah8Aol3Ygg2z7pEUlZDEQCBydxJ54y4wJiIALVZf6v5SrQjIc
         Uw9p5VS5g7qpLByAtp+f5HO95Q81MStqdpupQZ8vR/tdruw3YDaUW2j60+ENe2uEO/ig
         2WGMkvmiyNmOO6HVydZPEPfc7MeeYRjE0ycqXlj7s1J5GZ8XYdibseBunTfqh95BZnhw
         tuGYwVnfy99/7p1u6lGWP6+D2P1h59xOjmWe1VrVNSfYW8eBOYa21UsNzotNEoOLsxIn
         Jg4CqrVbyamNRc3uk2R877gMO88DkzwhdYthLK+dNVBvagHoPoXTEfksqG7bbvAhrLrQ
         7Y+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=l/cod5yh;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=Wp+xCN23;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.153.141 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=l/cod5yh;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=Wp+xCN23;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.153.141 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,436,1517846400";
   d="scan'208";a="76469313"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@fb.com" <shli@fb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Topic: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Index: AQHTzlpM3bNaKsvglEqiCkNE5lEW0KP5AjIAgAJcawCAAEUegIAAAmyAgAAX/wA=
Date: Wed, 11 Apr 2018 15:54:53 +0000
Message-ID: <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
In-Reply-To: <20180411142859.GB2322@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1118;7:OX8/bsfxCTlNR5tpZb17OnCx3/EmIF4N46eSewYn70GVjfhAyajcgdWfTOByo5H9OBs5oNjb2k6zHAT1DpDfVKiAecOzDT1MQxrP8tRW4NyuLUxx9bt+3Sny9Wb1zwBDp7x8D3lENbEtdsdCjwQ7+OLpqWX3+e3nZb7ajShs35LZaJtE70N8uTZ3CTnNGEhXYIVNYlL8idgyyFkRFqfhu34SrhpQI2eREhInOAsV862IJov5OO0hf65Wpqr+VqMH;20:Uzrb4AgAsb8WfX6BOhVvfd9y9vx+eeNi27da2DGYTW8cyphyGzhhFjUNZe7fVX2vIY0uwrvZkXDQDIl6XOK2kwH5FA0eDxe7jTInu3LwqdLP9piSdvPAKLWcPQZQfQo/1KA2y5gxb5sxjwHx3bD1JOm/dNIH6+Iy5AfYjIxYfVI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1118;
x-ms-traffictypediagnostic: MWHPR04MB1118:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1118A6DBF69CC0F3F406F59198BD0@MWHPR04MB1118.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB1118;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1118;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(346002)(39380400002)(51234002)(51444003)(199004)(377424004)(189003)(486006)(97736004)(8936002)(86362001)(6486002)(39060400002)(81156014)(81166006)(3660700001)(8676002)(3280700002)(2906002)(2900100001)(14454004)(229853002)(2501003)(118296001)(53936002)(4326008)(6246003)(66066001)(105586002)(6436002)(6512007)(5250100002)(25786009)(36756003)(478600001)(72206003)(106356001)(5660300001)(6116002)(7736002)(26005)(99286004)(305945005)(446003)(2616005)(476003)(68736007)(11346002)(93886005)(316002)(54906003)(102836004)(186003)(76176011)(110136005)(3846002)(6506007)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1118;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: saoQz61BfuZFOTdKKW5owTq7BqPagMs7cOtAhiJyMhV2NYifoiatCGwn1D9Om7wClieadjKf3ZiZFTMFMO7g8p0XJKznc9He7IsGvn00y7EBeajZdmC48xRlU2u5F6ZPswrfkB+KJCZN8BiuCbPCPWuhnZOD9TkFkjHVxv2IerOvBaZX+27FE0xLF+mp4CWusH1PqeBwQNeL5umabYqZHa8ChRl59VgKDyisY8PN4xaVXPP1jk2NQ1vZUEssDDJCihY9a4G8BATwM+f8TGyZZ/1iCekmLpgBIebH5nb5mqfXgkPPUpXsltFn7+uhai9WktVofUU2oqHX8ux17RMRtG9yxxKoM0CNviqt4YJWMvUfepT4QsXToDRyXzWDjJtlSidZhhsKw9ig73nM9Dz294hylyq3bIpDxGcLklO3XHQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA193BF2440E614AA1ED7FD1441BDB18@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e9462535-7123-40d0-2443-08d59fc490d4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9462535-7123-40d0-2443-08d59fc490d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 15:54:53.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1118
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597465791054942317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDE2OjI4ICswMjAwLCBBbGV4YW5kcnUgTW9pc2Ugd3JvdGU6
DQo+IFsgICAgMC43NjY2NjZdIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlIGF0IDAwMDAwMDAwMDAwMDAxYjQNCj4gWyAgICAwLjc2MzM1MF0gS2Vy
bmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEF0dGVtcHRlZCB0byBraWxsIGluaXQhIGV4aXRjb2Rl
PTB4MDAwMDAwMDkNCj4gWyAgICAwLjc2MzM1MF0NCj4gWyAgICAwLjc2NjY2Nl0gUEdEIDAgUDRE
IDANCj4gWyAgICAwLjc2NjY2Nl0gT29wczogMDAwMCBbIzJdIFBSRUVNUFQgU01QDQo+IFsgICAg
MC43NjY2NjZdIENQVTogMCBQSUQ6IDYgQ29tbToga3dvcmtlci91MTI6MCBUYWludGVkOiBHICAg
ICAgRCAgICAgICAgICA0LjE2LjAtQVJDSCsgIzgxDQo+IFsgICAgMC43NjY2NjZdIEhhcmR3YXJl
IG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTEu
MC0yMDE3MTExMF8xMDAwMTUtYW5hdG9sIDA0LzAxLzIwJA0KPiBbICAgIDAuNzY2NjY2XSBXb3Jr
cXVldWU6IG52bWUtcmVzZXQtd3EgbnZtZV9yZXNldF93b3JrDQo+IFsgICAgMC43NjY2NjZdIFJJ
UDogMDAxMDpibGtfcXVldWVfZmxhZ19zZXQrMHhmLzB4NDANCj4gWyAgICAwLjc2NjY2Nl0gUlNQ
OiAwMDAwOmZmZmZjOTAwMDAxYmZjYjAgRUZMQUdTOiAwMDAxMDI0Ng0KPiBbICAgIDAuNzY2NjY2
XSBSQVg6IGZmZmY4ODAwM2I2OTgwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDAw
MDAwMDAwMDAwMA0KPiBbICAgIDAuNzY2NjY2XSBSRFg6IGZmZmY4ODAwM2I2OTgwMDAgUlNJOiBm
ZmZmZmZmZmZmZmZmZmY0IFJESTogMDAwMDAwMDAwMDAwMDAxYw0KPiBbICAgIDAuNzY2NjY2XSBS
QlA6IGZmZmZjOTAwMDAxYmZjYzAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAw
MDAwMDAwMA0KPiBbICAgIDAuNzY2NjY2XSBSMTA6IGZmZmZlYTAwMDBlYWE5ODAgUjExOiBmZmZm
ZmZmZjgxNGUwOTcwIFIxMjogMDAwMDAwMDAwMDAwMDAxYw0KPiBbICAgIDAuNzY2NjY2XSBSMTM6
IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogZmZmZjg4MDAzYWFk
ODAxMA0KPiBbICAgIDAuNzY2NjY2XSBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZm
Zjg4MDAzZTQwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+IFsgICAgMC43NjY2
NjZdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4g
WyAgICAwLjc2NjY2Nl0gQ1IyOiAwMDAwMDAwMDAwMDAwMWI0IENSMzogMDAwMDAwMDAwMjIwOTAw
MSBDUjQ6IDAwMDAwMDAwMDAwNjA2ZjANCj4gWyAgICAwLjc2NjY2Nl0gQ2FsbCBUcmFjZToNCj4g
WyAgICAwLjc2NjY2Nl0gIGJsa19tcV9xdWllc2NlX3F1ZXVlKzB4MjMvMHg4MA0KPiBbICAgIDAu
NzY2NjY2XSAgbnZtZV9kZXZfZGlzYWJsZSsweDM0Zi8weDQ4MA0KPiBbICAgIDAuNzY2NjY2XSAg
PyBudm1lX2lycSsweDUwLzB4NTANCj4gWyAgICAwLjc2NjY2Nl0gID8gZGV2X3dhcm4rMHg2NC8w
eDgwDQo+IFsgICAgMC43NjY2NjZdICBudm1lX3Jlc2V0X3dvcmsrMHgxM2RlLzB4MTU3MA0KPiBb
ICAgIDAuNzY2NjY2XSAgPyBfX3N3aXRjaF90b19hc20rMHgzNC8weDcwDQo+IFsgICAgMC43NjY2
NjZdICA/IF9fc3dpdGNoX3RvX2FzbSsweDQwLzB4NzANCj4gWyAgICAwLjc2NjY2Nl0gID8gX3Jh
d19zcGluX3VubG9ja19pcnErMHgxNS8weDMwDQo+IFsgICAgMC43NjY2NjZdICA/IGZpbmlzaF90
YXNrX3N3aXRjaCsweDE1Ni8weDIxMA0KPiBbICAgIDAuNzY2NjY2XSAgcHJvY2Vzc19vbmVfd29y
aysweDIwYy8weDNkMA0KPiBbICAgIDAuNzY2NjY2XSAgd29ya2VyX3RocmVhZCsweDIxNi8weDQw
MA0KPiBbICAgIDAuNzY2NjY2XSAga3RocmVhZCsweDEyNS8weDEzMA0KPiBbICAgIDAuNzY2NjY2
XSAgPyBwcm9jZXNzX29uZV93b3JrKzB4M2QwLzB4M2QwDQo+IFsgICAgMC43NjY2NjZdICA/IF9f
a3RocmVhZF9iaW5kX21hc2srMHg2MC8weDYwDQo+IFsgICAgMC43NjY2NjZdICByZXRfZnJvbV9m
b3JrKzB4M2EvMHg1MA0KDQpIZWxsbyBBbGV4YW5kcnUsDQoNCldoYXQgbWFkZSB5b3UgbG9vayBh
dCBjZ3JvdXBzPyBJbiB0aGUgYWJvdmUgcmVnaXN0ZXIgZHVtcCBJIHNlZSB0aGF0ICVyYnggPT0g
TlVMTC4NCkkgdGhpbmsgdGhhdCBtZWFucyB0aGF0IHRoZSBxdWV1ZSBwb2ludGVyIGFyZ3VtZW50
IG9mIGJsa19xdWV1ZV9mbGFnX3NldCgpIGlzIE5VTEwuDQpUaGUgTlZNZSBpbml0aWF0b3IgZHJp
dmVyIHNob3VsZCBuZXZlciBwYXNzIGEgTlVMTCBwb2ludGVyIHRvIGJsa19tcV9xdWllc2NlX3F1
ZXVlKCkuDQpQbGVhc2UgYXNrIHRoZSBOVk1lIGRyaXZlciBtYWludGFpbmVycyBmb3IgdGhlaXIg
b3BpbmlvbiBvbiB0aGUgbGludXgtbnZtZSBtYWlsaW5nDQpsaXN0Lg0KDQpUaGFua3MsDQoNCkJh
cnQuDQoNCg0KDQo=
