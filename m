Return-Path: <prvs=6401ab460=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx48rOZ28M3Elqcm1qPczBZBkADdg2Olbn28Uvhh8YsX6FJQvaW0oyuM5g8U/MEjc3mKnZ1iK
ARC-Seal: i=1; a=rsa-sha256; t=1524171411; cv=none;
        d=google.com; s=arc-20160816;
        b=tluP+lMfp0JvfTOZy4SDIw3ok5ZPUnbambk9nNhXre+u+3C4MOd5UDPduExPOB/P2A
         9be0RW1NiyiIKlJBguCcQ+XG+xXUbCyo/54kLPAxN7L2UfqCdtzspOV0nqKW4syBBBJC
         4P15OozLAqYb6UOZ3XwEh+zCp1s095jK/RH8Dz3nvPXiPOIxs/drMRRg2l69d+LtH3xP
         q4EdBwruw8zBlgAnl2Imwbu9BlO48Pd8H+9axkZWSHGR6KPZ7SgXgivgzskQHKycEFYO
         q7bmwQffVir7ZieZAVt7dCXhBdfQ8EYg0q6TGxiLdkjEv5MCNcE6UbzU+91pycQ4Kt99
         EVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=FmZGM/tW8izlt75J31VH4BgV5oDjDl851oY0Op44DZA=;
        b=KjfQ3MR4SB1SrgBrTCzTvhJS5IH9fxCUbhh3gfb7KztlLwp9lEDIV4P8jCDLZcu4G6
         Dn2UuzwsVSECnKNCuMdlzzguirk8WBQl9WjzXE1b0pkmhR1VR3ZZnOlXI0GRPBmI3+uy
         2X9mnAM1+XmlVMr5Q/LnSSAhEJz+Jy0XUMXCAHGa4AstoA0zSWJpjcGx9vhjFP4MaKGC
         gMpNVTj/KEWQStJzBV5k+2/LhH1BRG3e9JeN4iRmev8wG0A1Fv/kSwKDCVb0FfHEl6zm
         Mli1kow5Vg8TrpF8e098yIXgwYMUQMMopMnVqKXyCtzUuWwNBgMn0DaRGA3J4+BbYnR3
         kf6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=a7WYXxiV;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=YqVIAqg4;
       spf=pass (google.com: domain of prvs=6401ab460=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=6401ab460=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=a7WYXxiV;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=YqVIAqg4;
       spf=pass (google.com: domain of prvs=6401ab460=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=6401ab460=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,469,1517846400";
   d="scan'208";a="77031434"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "maier@linux.ibm.com" <maier@linux.ibm.com>, "osandov@osandov.com"
	<osandov@osandov.com>
CC: "lizefan@huawei.com" <lizefan@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "mingo@redhat.com" <mingo@redhat.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"lizf@cn.fujitsu.com" <lizf@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] tracing/events: block: dev_t via driver core for plug
 and unplug events
Thread-Topic: [PATCH 2/2] tracing/events: block: dev_t via driver core for
 plug and unplug events
Thread-Index: AQHT0yiPxIrlV00jKkaZpH/PINtV0KQBghkAgAIY4ICABObUgIAAGbwA
Date: Thu, 19 Apr 2018 20:56:47 +0000
Message-ID: <8624e2bec853f0bb195966ab54bc42bf15eda0ec.camel@wdc.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
	 <20180413130719.22921-3-maier@linux.ibm.com>
	 <20180415083154.GA12254@kroah.com>
	 <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
	 <20180419192341.GC20941@vader>
In-Reply-To: <20180419192341.GC20941@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0432;7:8h+c2EDjjPN/HwBF5Bv70Tv1Wi+Xt6boqFVejWY3R0pBJG0qki+RNWSeCmANauT8dtq4P72RjVyIczRT+wUPTAvKS83IYn0r5zqzcqjZ8iKR1SPmCapMX9Jl0Kc0rw14ovgSFxF6iwFZ1besn3ZSkEsinQFKQjMzm2wmI4W1TebSKPWttSpL6kyCtpiEph+3U/tdfae9PJ7DJaaiMlzBILg/0jdZsZx3gG1tUjpkn9p6PznBnbA6pz+Oq85M+NJi;20:m4V7+fBCABNdhj+nxbVO1mZHiNVpD8EELOwm0+sFPoBtPcE4WOUsPd/nrU3cclLiI6pciBQZwOw4KH1FtMXIKzcEYl1qorMnH3dvnSeU3r6jKzjRvlmjaMtaf790uCzuLepFcE2mPzail4Jc01DIYCPV/eAN0MzE32LRBf3mBRw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0432;
x-ms-traffictypediagnostic: MWHPR04MB0432:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB04321A625B29526973FE14C998B50@MWHPR04MB0432.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501386)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0432;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0432;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(39380400002)(39860400002)(377424004)(51444003)(2906002)(72206003)(229853002)(478600001)(6486002)(53936002)(6512007)(6436002)(6246003)(118296001)(2900100001)(36756003)(66066001)(3846002)(6116002)(25786009)(6506007)(54906003)(59450400001)(102836004)(186003)(7736002)(76176011)(110136005)(26005)(8676002)(5660300001)(3280700002)(81166006)(3660700001)(11346002)(446003)(7416002)(93886005)(316002)(86362001)(2501003)(305945005)(8936002)(2616005)(476003)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0432;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: 2IOnzEJaePMtAlnUIG00NYl08o04wI8p0O6Jy4C+2HIKwgWN1MnQVHIJ7VxWVZ3Zh54Tvk84QAB+3cSK+rq02Te1s/jCLj1GO3mf1CGQnnBZDHvzX6dOlJz00KWIWCIkjkEtm5HyV9d3kOGWuywCEPAxvoHyp0OH+R/jJegAebLdevo3899cjwWMOsx8mZtS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF35187DD8873741ACDC632A1E1B3D33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7ab41f6b-7d02-461e-78a4-08d5a6381136
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab41f6b-7d02-461e-78a4-08d5a6381136
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 20:56:47.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0432
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636500726736984?=
X-GMAIL-MSGID: =?utf-8?q?1598209561734822597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTE5IGF0IDEyOjI0IC0wNzAwLCBPbWFyIFNhbmRvdmFsIHdyb3RlOg0K
PiBXZSBxdWllc2NlIGFuZCBmcmVlemUgdGhlIHF1ZXVlIGJlZm9yZSB0ZWFyaW5nIGl0IGRvd24s
IHNvIGl0IHdvbid0IGJlDQo+IE5VTEwgd2hpbGUgd2UncmUgc3RpbGwgZG9pbmcgSS9PLiBDYydp
bmcgQmFydCBpbiBjYXNlIEknbSBseWluZyB0byB5b3UsDQo+IHRob3VnaCA7KQ0KDQpibGtfY2xl
YW51cF9xdWV1ZSgpIHdhaXRzIHVudGlsIGFsbCBJL08gcmVxdWVzdHMgaGF2ZSBmaW5pc2hlZC4g
U2luY2UgdGhlDQpibG9jayBsYXllciB0cmFjaW5nIGNvZGUgaXMgdHJpZ2dlcmVkIGZyb20gaW5z
aWRlIHRoZSBjb2RlIHRoYXQgcHJvY2Vzc2VzIGENCnJlcXVlc3QgaXQgaXMgc2FmZSB0byBhY2Nl
c3MgdGhlIHJlcXVlc3QgcG9pbnRlciBmcm9tIGluc2lkZSB0aGUgdHJhY2luZyBjb2RlLg0KQnV0
IEkgdGhpbmsgdGhlIHF1ZXN0aW9uIHdhcyBhYm91dCB0aGUgcGFyZW50IG9mIHRoZSByZXF1ZXN0
IHF1ZXVlIGtvYmoNCmluc3RlYWQgb2YgYWJvdXQgdGhlIHJlcXVlc3QgcXVldWUgcG9pbnRlciwg
dGhlIGRldmljZSBzdHJ1Y3R1cmUgdGhhdCBpcw0KZW1iZWRkZWQgaW4gc3RydWN0IGdlbmRpc2s/
IEkgdGhpbmsgdGhhdCBwYXJlbnQgY2FuIGRpc2FwcGVhciBhdCBhbnkgdGltZS4NCk1vc3QgYmxv
Y2sgZHJpdmVycyBjYWxsIGRlbF9nZW5kaXNrKCkgYmVmb3JlIHRoZXkgY2FsbCBibGtfY2xlYW51
cF9xdWV1ZSgpLg0KVW5sZXNzIEknbSBvdmVybG9va2luZyBzb21ldGhpbmcgSSB0aGluayB0aGUg
cmVxdWVzdCBxdWV1ZSB3aWxsIG5lZWQgdG8NCm9idGFpbiBhIHJlZmVyZW5jZSB0byB0aGUgZ2Vu
ZGlzayBkZXZpY2UgZnJvbSBpbnNpZGUgYmxrX3JlZ2lzdGVyX3F1ZXVlKCkNCmFuZCBkcm9wIHRo
YXQgcmVmZXJlbmNlIGZyb20gaW5zaWRlIGJsa19jbGVhbnVwX3F1ZXVlKCkgdG8gbWFrZSBpdCBz
YWZlIGZvcg0KdGhlIHRyYWNpbmcgY29kZSB0byBhY2Nlc3Mgc3RydWN0IGdlbmRpc2suDQoNCkJh
cnQuDQoNCg0KDQo=
