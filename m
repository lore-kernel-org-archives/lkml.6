Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx4+H+TcbWoi+w1UFV1Ok5Q1Kc4KX5PYiZi5XrkZeCNniTc8pLH/WJcwbx+acN5WbnSv7lnYx
ARC-Seal: i=1; a=rsa-sha256; t=1523476832; cv=none;
        d=google.com; s=arc-20160816;
        b=r00KrPvRRyK31CbHHnqO567+JIBd1wjVmUZBjXGGrx1mG0LG/Uxfd/LgBcpYTw6zuc
         xQlT3Y8UpJvUcwzuol8iQLb61oSuhsGtjr9ab/hOig771dTkrtH06vcBy6A2TqrrUqUb
         KaegI8Pz1SzkmQjRgEC+ytLW4zTXYKWAnJZRLoxjjROcJptq3GzfVCIh/UvK7xtBScFk
         77RzckUEgdSYtqfA9tT21WC8vbwYTk1v1h1TvcEYArECo01ahmMGAcuU58K13Y8jBUJS
         zw2637szZCBLF2ZlFysny2zQQ9chWMLIiQEOE5WY/VEh39cnimqKaRooHXV/i/QWyvCb
         FTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=IvT/Fy0HkmNsy3YV/9bWuNZMFe1Cts0BFSPi2r2mJqM=;
        b=we2gndTKHb0pwSN26b/NkHEveHkcZEM6JDp9cVBjlZttLB2m5HxZ4r6EBu6vmZ5+rv
         hS6lFd5PBuFfYEgHA28HdDg6x3e4eoZQDgRUm14Gi0+qhc6oEGlOgMggrtNn1LItDdTc
         6RWoESjnKS5W6Q4vYzGI3p1/ACgNStAVWaXbQv7yxfci8QdqZAg9QnGZ71eXi25lOAa3
         w3osgNseRIn1AN3bRoO4rq+Ol6E5OlugwNm7zCeY9TEwuFnf+kbcmZj/Jbgz4+2NMH2d
         5RH0QqC1bcu9ICZKXW/S6jknBbt3yUljJA2l5ghXTr2dsMugGktAJ7jf+xB8Xqt7WkQ8
         5K2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=NTVoJNGU;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=c9RbIMab;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=NTVoJNGU;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=c9RbIMab;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,437,1517846400";
   d="scan'208";a="172386517"
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
Thread-Index: AQHTzlpM3bNaKsvglEqiCkNE5lEW0KP5AjIAgAJcawCAAEUegIAAAmyAgAAX/wCAADPagIAAD1uAgAAAcgCAAAD2gA==
Date: Wed, 11 Apr 2018 20:00:29 +0000
Message-ID: <6e2d8be78572fef5fe8f2e0e7ecbdea5839dc198.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
	 <20180411190027.GA21274@gmail.com>
	 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
	 <20180411195700.GP793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180411195700.GP793541@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0447;7:R5glJDfu0T5TqyTPBI8dEOxB4lp7FmWCnFUK8qh0nT43phFAGOus0J03hqa+CHTlvG6m6EGH4rgVkTmH0dqyQd90+zQTdRyUZGcGg5Ow+ZiuRAcwPs3Fr7YCJPNPwlIUbthVaEo9DR9wElD8GPzqEXUVmkpCMLxFGTenKP+yECDeKxZy/0s8RIlXBRsc0ZnPC7x+ifj6p96Fhar2f1jytgROj6WlFU4dXEpRs8M5eVTjZ+ev3ZK19z1GbafDeQ9J;20:Qn/1MIiiVB2SelJ2VK1tehcm6OcMHty0+7VFhUtbOcqL/4fxYVotQbsUtRmB0IRr14ZKVqF4QOqNDILip7rmmYGgx9k7cyGoKOaYlMFtJNX7lCpqmieLQMYCGktaft58lIZBG3cXFOZcOky1rxDuoNg4Ax2bkwzvD9S0QQI7hfg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0447;
x-ms-traffictypediagnostic: MWHPR04MB0447:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB04479A99713A5B443B8F409F98BD0@MWHPR04MB0447.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0447;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0447;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(396003)(39860400002)(346002)(199004)(189003)(377424004)(186003)(6116002)(3846002)(53936002)(66066001)(2900100001)(39060400002)(97736004)(105586002)(5640700003)(25786009)(4326008)(72206003)(7736002)(6512007)(305945005)(7416002)(5660300001)(14454004)(2906002)(102836004)(478600001)(6246003)(6436002)(8676002)(1730700003)(36756003)(53546011)(229853002)(6506007)(11346002)(54906003)(486006)(93886005)(106356001)(446003)(3660700001)(476003)(81156014)(3280700002)(76176011)(2351001)(2616005)(2501003)(6486002)(86362001)(99286004)(8936002)(26005)(5250100002)(316002)(118296001)(68736007)(81166006)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0447;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OOWGVRsGKbGWZD9xiUNBudTs5TqCFcbD4AO5/QCmMgfmL0JKhRK6ALux5EA0/4OAPECYBlcXTe6YvVCzsKV8bzYFenXm4WOBybtGivdjew0RSa5eYWsejGwyHmsd50W0+/R5osvLGAvveNbNNVUQVQ7sdvwkvGn1+10Kx+K5tF+g9s0meiQj8cbfH2I++SiIiO010cGmHe7+rnSgX3Dql+HYwlnSmpEc8VOqwjUUDCAnPhSk68brKxt5PN/1ikPnx3fX1x32Oj/j3FHl18+KGpNVa4OeqPVBXELZRtZCeOAuYY3QvF7L25ZkxQ1JoT2V/Vsr3csWnIf2EYkKzGLIiIu8YiOld7WWfCBFIvSJdj72+VmvfhijPoXNigfx9poH/acsqKCgHdLaNLuRiKz6POT24YOXXLrPb3kMRoCFv4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2C43880CDD6D949B6FF41B815579744@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a41cabd1-4bd8-4c13-4f08-08d59fe6e01f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41cabd1-4bd8-4c13-4f08-08d59fe6e01f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 20:00:29.2673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0447
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597481242913386963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDEyOjU3IC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBXZWQsIEFwciAxMSwgMjAxOCBhdCAwMTo1NToyNVBNIC0wNjAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gT24gMDQvMTEvMTggMTM6MDAsIEFsZXhhbmRydSBNb2lzZSB3cm90ZToN
Cj4gPiA+IEJ1dCB0aGUgcm9vdCBjYXVzZSBvZiBpdCBpcyBpbiBibGtjZ19pbml0X3F1ZXVlKCkg
d2hlbiBibGtnX2NyZWF0ZSgpIHJldHVybnMNCj4gPiA+IGFuIEVSUiBwdHIsIGJlY2F1c2UgaXQg
dHJpZXMgdG8gaW5zZXJ0IGludG8gYSBwb3B1bGF0ZWQgaW5kZXggaW50byBibGtjZy0+YmxrZ190
cmVlLA0KPiA+ID4gdGhlIGVudHJ5IHRoYXQgd2UgZmFpbCB0byByZW1vdmUgYXQgX19ibGtfcmVs
ZWFzZV9xdWV1ZSgpLg0KPiA+IA0KPiA+IEhlbGxvIEFsZXgsDQo+ID4gDQo+ID4gSGFkIHlvdSBj
b25zaWRlcmVkIHNvbWV0aGluZyBsaWtlIHRoZSB1bnRlc3RlZCBwYXRjaCBiZWxvdz8NCj4gDQo+
IEJ1dCBxdWV1ZSBpbml0IHNob3VsZG4ndCBmYWlsIGhlcmUsIHJpZ2h0Pw0KDQpIZWxsbyBUZWp1
biwNCg0KWW91ciBxdWVzdGlvbiBpcyBub3QgZW50aXJlbHkgY2xlYXIgdG8gbWUuIEFyZSB5b3Ug
cmVmZXJyaW5nIHRvIHRoZSBhdG9taWMNCmFsbG9jYXRpb25zIGluIGJsa2dfY3JlYXRlKCkgb3Ig
YXJlIHlvdSBwZXJoYXBzIHJlZmVycmluZyB0byBzb21ldGhpbmcgZWxzZT8NCg0KQmFydC4NCg0K
DQo=
