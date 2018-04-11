Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx48JhmHMN4jT414p+0Wse+FkBkwiCAl+RryHT2vfjVxrFNdIRbVqc69bSv/O6eNs3NZHS6JE
ARC-Seal: i=1; a=rsa-sha256; t=1523464979; cv=none;
        d=google.com; s=arc-20160816;
        b=euTiM/bPLk0PMErtLj1QeoByBmPYnmB9q/warLnvxal3EuR1z7xJP6owV+L5SWMS65
         tWC/CNzcNUqDV+mgesEbm2xfwMKbwjS01PDHkLlNe+s2HRckjnO00W8Ku/cKHaWujmMb
         pmf07fa3LogMj4vklp1Wa9bHWGM6Yl0BdYi9vZ1zrarxUOyvpVjYnj+FwUqX7KSzu8qy
         fZwCQbxyR9Bh83S0V6wjp3+nQcYChb7ya8Fo274F49NAafCblzlr39swtDWtTiQPhapq
         aPZKGgr1ccJou5nixHAWc3THOxjB7m5hxD4ufYYx0HCj9B6teuLfYTAqbJIFmNgcwMWL
         gAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=696TFYNytnCr8zqQ/YoCMD55t124WlFQEXs4FKEaS9w=;
        b=OEJGSt6EWwvv/1+JIeDefnkZymqK8a6g6lZ4h0NdCppcSer0jShYbkPmxVeHLb2maa
         bGnHDYsDDyk7TQcUaMs+3UIBTEPEdCV0RQa/yUhFrO1ZkaFu2LeuHKFRyJnKDHATaAgQ
         AIHFk/IKqOu42KWGjQxAT/XyPo/zIAGaOGK44WaTuQa4qCxQVUzWWC+sQasIzKI23dG+
         shWPnEDtalVKpFbtHuqiENuV6IkWYs285h6R7iu5RbK4bi86cPxcyc5G5yZSBbX+v0dt
         5xsa1sp/UkM7qDFfTkyKox33YMLCArK0eAKo0Y1yuDKgQk/xVpDT4YJ5IaOC6fayhw6q
         LlNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=L77WqyKb;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=gnQHw/Yc;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=L77WqyKb;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=gnQHw/Yc;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,437,1517846400";
   d="scan'208";a="76402166"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>
CC: "nborisov@suse.com" <nborisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Topic: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Thread-Index: AQHTzlpM3bNaKsvglEqiCkNE5lEW0KP5AjIAgAJcawCAAEUegIAAAmyAgAAE1ACAAAFugIAAAXEAgAAdtwA=
Date: Wed, 11 Apr 2018 16:42:55 +0000
Message-ID: <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <20180411144616.GI793541@devbig577.frc2.facebook.com>
	 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
	 <20180411145632.GK793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180411145632.GK793541@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0622;7:L/kcyarMarKeptwqCWSNRcb35Yp5vt+zJq1+bFaSfTcz1YSY9YMg+XVbPobjwW6y3va+FWsadhEqey4e94HrbQNosbCoZT4hvFtHwq3X3HQGOi0S3i1S1RUgMCq+wdV6tpW+yOiKR6XT9CgUjExomd5iyWmdHtMk2m7IUKD9Vq3vq3JvKVpiPHn7ud7EmThAqzn9MEQTUjwBR5SlVZPlRpEarPPLB0IRXiq/8foYVxr7HRZWmpeKrNsCc26EvwJ/;20:0T+DuUA9olue6jrvN/qASggCb7scsHCUHFra15pBg6aAHI8Yy5ZPNRY8IsmtWX4qJtc8wN6BkkaHFI8nOX3ms70tWtE3ErVzrk0KzWuEmzNpWY9X/QUty7FeUcK6kvOuuriDwmG39+bi9OWely7SkGmuuHCC35rumnqvfYnNPaA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0622;
x-ms-traffictypediagnostic: MWHPR04MB0622:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0622A3353C55A6877C87DE0098BD0@MWHPR04MB0622.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0622;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0622;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(39380400002)(51444003)(377424004)(199004)(189003)(8936002)(97736004)(8676002)(72206003)(59450400001)(6512007)(26005)(6506007)(81156014)(81166006)(476003)(478600001)(39060400002)(6436002)(11346002)(2616005)(446003)(99286004)(6246003)(2900100001)(102836004)(186003)(2501003)(25786009)(6486002)(5250100002)(105586002)(486006)(118296001)(3280700002)(3660700001)(86362001)(53936002)(2201001)(6116002)(3846002)(66066001)(14454004)(36756003)(7736002)(54906003)(4326008)(316002)(68736007)(106356001)(93886005)(305945005)(110136005)(5660300001)(2906002)(229853002)(76176011)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0622;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lG+SG77hnVxqajK2MbLIjXxUxvtOl8/voSvGoKPe9tayjnyqdw331zOmkZBGg+H67Dhm8C85U8vLjs1ZZP9RiL0xKOpet+rigIRPf+FoQo4C+dy+Q01n7xC4jNTh44f5J9f7cS8EHBfC6k33URvCMg488uy484pnSAX3uBHdX8KkTDLoiNFLgOnFA+A3VMGFZef93Yfy7knPJL1jYCjfPcGwiSxwiCx4Ot+kCmIdDVTdahhRs9KO4/T1O3d/ZJQZUCdPeMlEIqWLH9ADIwl4BMN9SkjIkblPCEPW+THXIXRCgF1hjO247WSlimyamFUiJfPPKY7Zg80rlC6FwjzvqZBeCSweWLxZ5Fb/Mmy+XntOp+Tq+tNIj3Evu/1E29OJHIVwjsE1BOseqftDi6FSdZ9ry7hKbf1KkBrFLN5DDUM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABFB67869469B84595ABF223371B0B39@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e7a388e2-85fe-4a94-8347-08d59fcb4688
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a388e2-85fe-4a94-8347-08d59fcb4688
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 16:42:55.1291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0622
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597468814168391925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDA3OjU2IC0wNzAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IEFu
ZCBsb29raW5nIGF0IHRoZSBjaGFuZ2UsIGl0IGxvb2tzIGxpa2UgdGhlIHJpZ2h0IHRoaW5nIHdl
IHNob3VsZA0KPiBoYXZlIGRvbmUgaXMgY2FjaGluZyBAbG9jayBvbiB0aGUgcHJpbnRfYmxrZyBz
aWRlIGFuZCB3aGVuIHN3aXRjaGluZw0KPiBsb2NrcyBtYWtlIHN1cmUgYm90aCBsb2NrcyBhcmUg
aGVsZC4gIElPVywgZG8gdGhlIGZvbGxvd2luZyBpbg0KPiBibGtfY2xlYW51cF9xdWV1ZSgpDQo+
IA0KPiAJc3Bpbl9sb2NrX2lycShsb2NrKTsNCj4gCWlmIChxLT5xdWV1ZV9sb2NrICE9ICZxLT5f
X3F1ZXVlX2xvY2spIHsNCj4gCQlzcGluX2xvY2soJnEtPl9fcXVldWVfbG9jayk7DQo+IAkJcS0+
cXVldWVfbG9jayA9ICZxLT5fX3F1ZXVlX2xvY2s7DQo+IAkJc3Bpbl91bmxvY2soJnEtPl9fcXVl
dWVfbG9jayk7DQo+IAl9DQo+IAlzcGluX3VubG9ja19pcnEobG9jayk7DQo+IA0KPiBPdGhlcndp
c2UsIHRoZXJlIGNhbiBiZSB0d28gbG9jayBob2xkZXJzIHRoaW5raW5nIHRoZXkgaGF2ZSBleGNs
dXNpdmUNCj4gYWNjZXNzIHRvIHRoZSByZXF1ZXN0X3F1ZXVlLg0KDQpJIHRoaW5rIHRoYXQncyBh
IGJhZCBpZGVhLiBBIGJsb2NrIGRyaXZlciBpcyBhbGxvd2VkIHRvIGRlc3Ryb3kgdGhlDQpzcGlu
bG9jayBpdCBhc3NvY2lhdGVkIHdpdGggdGhlIHJlcXVlc3QgcXVldWUgYXMgc29vbiBhcyBibGtf
Y2xlYW51cF9xdWV1ZSgpDQpoYXMgZmluaXNoZWQuIElmIHRoZSBibG9jayBjZ3JvdXAgY29udHJv
bGxlciB3b3VsZCBjYWNoZSBhIHBvaW50ZXIgdG8gdGhlDQpibG9jayBkcml2ZXIgc3BpbmxvY2sg
dGhlbiB0aGF0IGNvdWxkIGNhdXNlIHRoZSBjZ3JvdXAgY29kZSB0byBhdHRlbXB0IHRvDQpsb2Nr
IGEgc3BpbmxvY2sgYWZ0ZXIgaXQgaGFzIGJlZW4gZGVzdHJveWVkLiBJIGRvbid0IHRoaW5rIHdl
IG5lZWQgdGhhdCBraW5kDQpvZiByYWNlIGNvbmRpdGlvbnMuDQoNCkJhcnQuDQoNCg0KDQo=
