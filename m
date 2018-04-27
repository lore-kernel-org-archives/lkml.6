Return-Path: <prvs=6487dbab9=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AB8JxZo6anA5njf5fBPqW1IIGaFZNwx2dr9/LGaN1D90igR0adpxZXjPgTt7IH1asomt97YFPyBZ
ARC-Seal: i=1; a=rsa-sha256; t=1524847119; cv=none;
        d=google.com; s=arc-20160816;
        b=bGfibab5g1PfKLw3N50gDgGl5ieF6Ubi/tiN/3Ssd5irY8Tkg2HQQyA54/xQBF26IY
         ZtRFYyNIuxDtYxQWCT56d/hY6xhVm7ryK8E5oo3z2ve4o8fv77D4eEPwWNalb4wflaZq
         F8U+X7Im6t76qJHHiCxmxp4icxGhGYsDrtd8+znN6NIRS3kuGIgg0kXFEguX/1OJ5neC
         +og0ij2B94m2+LtregjPoQkmKIHh1R1UT/Ec8aIoNOGw9wIaCLPK/uVsUVYXnfRJiOhx
         oCv2cVmL96KPtLuB9SlZ4lp8aJNt/HSdL6XIfg7/R2fOlBJttxV/yjmN3VgGYNaPLS7l
         FKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=a/QPjilt720sorQPsU+T6n1Opb8x2HyYPzcXhObzT8I=;
        b=uL6Jf7BH7OZYF+pYcLpoEYkqnVAKMji2pVAds5xiqlvAOMKJQrlGGY58EQVs2UlQog
         eWgN4j0t12TF1HDilLF2Ctw+Qck1cXgrpVaXgQvkRBItbfatVWgeEkCn9UMYcJrsnMhB
         QayetDh9mGenTtEcqiHeESXELT7ScOmu2191HBk9URA4/C+QSNbGElkOg1LKaSkvIktp
         ExA10TGR3EGU6EqGWRYY6pd7gksz1C9TBfY967PMUydbee+P1W73Su/HCXoCUJ+Kk32k
         6LEhVtI9rHMmdJ6nU0vjYtI55vSYznWFV5hUCJxI3e/EYzZDCbkgWySvJbBL/+SG5aj+
         blnA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=OaYgjwYe;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=ntJPKlp3;
       spf=pass (google.com: domain of prvs=6487dbab9=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=6487dbab9=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=OaYgjwYe;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=ntJPKlp3;
       spf=pass (google.com: domain of prvs=6487dbab9=bart.vanassche@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=6487dbab9=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.49,335,1520870400";
   d="scan'208";a="77580201"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "maier@linux.ibm.com" <maier@linux.ibm.com>, "osandov@osandov.com"
	<osandov@osandov.com>
CC: "lizefan@huawei.com" <lizefan@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] tracing/events: block: dev_t via driver core for plug
 and unplug events
Thread-Topic: [PATCH 2/2] tracing/events: block: dev_t via driver core for
 plug and unplug events
Thread-Index: AQHT0yiPxIrlV00jKkaZpH/PINtV0KQBghkAgAIY4ICABObUgIAAGbwAgAd1LoCABNUwgA==
Date: Fri, 27 Apr 2018 16:38:05 +0000
Message-ID: <9b5e43db06f6516f7c0e9cc379e0c2964000d4e1.camel@wdc.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
	 <20180413130719.22921-3-maier@linux.ibm.com>
	 <20180415083154.GA12254@kroah.com>
	 <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
	 <20180419192341.GC20941@vader>
	 <8624e2bec853f0bb195966ab54bc42bf15eda0ec.camel@wdc.com>
	 <056d8ee9-5e1d-8219-c24c-9130d6c1dcbf@linux.ibm.com>
In-Reply-To: <056d8ee9-5e1d-8219-c24c-9130d6c1dcbf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1262;7:lffUdnha3u3qXVxpcT42E78rMS4no9dFJXsOROhoyx84U+MdB041y4lYDQ8nAmtN/c5+EaBWUxHUmrOHjRoSGLH0AQS7hYUiDVmVPLSk0qiSVGGP43XM3Ie84lE5n4erXqC8wvhWZgbU07/WQ6/FDl3Bq6jjMtCALgTqQ9Z5gMDsLKCtaSSaz8p/9w1ILaKKN/8JywepheEhFCFxmSFK+p4vu3KoRcwMOTv6EZ5FASbd7ooEwiV+6fpEssmN5pXF;20:knAHqJ3nGHsVczP96X4vWF27Q2+e6Smhdko/cL+LvxALxWZQ2U6wbaPKW81hnjjDH8uSsoPneoB7fJk3lBN/6SrAaysHHQRNBDO+xjOhsgq+hYy7mzTujSI4x9HQz2xmwiR4E5BMnxMc9eqeqYkXzBBgdtvy78wuZkQ3XL9yjuE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1262;
x-ms-traffictypediagnostic: MWHPR04MB1262:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1262ADC3F42513710CF44D57988D0@MWHPR04MB1262.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB1262;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1262;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(377424004)(51444003)(72206003)(76176011)(6512007)(99286004)(93886005)(5660300001)(486006)(110136005)(54906003)(53936002)(106356001)(476003)(305945005)(66066001)(316002)(2616005)(11346002)(4326008)(229853002)(2501003)(86362001)(59450400001)(6436002)(6506007)(102836004)(186003)(6246003)(68736007)(26005)(2900100001)(5250100002)(6486002)(3846002)(25786009)(3660700001)(2906002)(8936002)(7736002)(97736004)(105586002)(3280700002)(81166006)(118296001)(6116002)(14454004)(36756003)(478600001)(81156014)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1262;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: NViUP3wzhCihFobQY5fNsIoMhBpD0c4dxPvxXS7AbL6uAvvKoBXGdsj4g59fLwLjYGWCapNOcswleUhmYDl0wmmKEW1QHJYMP3065S4dV+nm4s8CCPYqpgi7HzW8TxqHu1LsHb3eKP8hJdu80QFYBJykqXokg/Xu53mC7jHaiFod7/jShYW81TjPhFuaxBsZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7773AC4C73C4404D97501A4F0727663E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d45a9e47-6a0f-4fe3-35f3-08d5ac5d4047
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45a9e47-6a0f-4fe3-35f3-08d5ac5d4047
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 16:38:05.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1262
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636500726736984?=
X-GMAIL-MSGID: =?utf-8?q?1598918093962095302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTA0LTI0IGF0IDE2OjQ5ICswMjAwLCBTdGVmZmVuIE1haWVyIHdyb3RlOg0K
PiBUaGUgb2JqZWN0IGxpZmUgY3ljbGUgc2VlbXMgdG8gYmU6DQo+IA0KPiAoMSkgYmxrX2FsbG9j
X3F1ZXVlKCkgYWxzbyBjcmVhdGVzIGdlbmRpc2sga29iag0KDQpJIHRoaW5rIHRoaXMgaXMgYSBt
aXNpbnRlcnByZXRhdGlvbi4gYmxrX2FsbG9jX3F1ZXVlX25vZGUoKSBpbml0aWFsaXplcyB0aGUN
CnJlcXVlc3QgcXVldWUga29iaiBhcyBmb2xsb3dzOg0KDQoJa29iamVjdF9pbml0KCZxLT5rb2Jq
LCAmYmxrX3F1ZXVlX2t0eXBlKTsNCg0KcmVnaXN0ZXJfZGlzaygpIGNyZWF0ZXMgdGhlIC9zeXMv
Y2xhc3MvYmxvY2svPGRpc2s+IG5vZGUgYW5kIC9zeXMvYmxvY2svPGRpc2s+DQpsaW5rIGFzIGZv
bGxvd3M6DQoNCglpZiAoZGV2aWNlX2FkZChkZGV2KSkNCgkJcmV0dXJuOw0KCWlmICghc3lzZnNf
ZGVwcmVjYXRlZCkgew0KCQllcnIgPSBzeXNmc19jcmVhdGVfbGluayhibG9ja19kZXByLCAmZGRl
di0+a29iaiwNCgkJCQkJa29iamVjdF9uYW1lKCZkZGV2LT5rb2JqKSk7DQoJCWlmIChlcnIpIHsN
CgkJCWRldmljZV9kZWwoZGRldik7DQoJCQlyZXR1cm47DQoJCX0NCgl9DQoNCj4gKDFhKSBTQ1NJ
IGRvZXMgTFVOIHByb2JpbmcgSS9PDQo+ICAgICAgbW9zdCBvZiB0aGF0IGlzIGJsa3RyYWNlIFJX
QlMgZmllbGQgdmFsdWUgJ04nIGkuZS4gbm9uLVIvVyB3aXRoIGRldl90PT0wDQo+ICAgICAgIHNp
bmNlIHEtPmtvYmoucGFyZW50IGlzIHN0aWxsIE5VTEwgd2UgY2Fubm90IGdldCBnZW5kaXNrIGFu
ZCB0aHVzIGRldl90DQo+ICAgICAgbmVhciB0aGUgZW5kIGlzIHRoZSBmaXJzdCByZWd1bGFyIHJl
YWQgYmxvY2sgSS9PIHdpdGggZGV2X3QhPTANCj4gICAgICAgYXMgYmlvIT1OVUxMIGFuZCBiaV9k
aXNrIG9yIHJxX2Rpc2sgYXJlIG5vbi1OVUxMDQo+ICgyKSBibGtfcmVnaXN0ZXJfcXVldWUoKSBh
bHNvIGNyZWF0ZXMgcXVldWUga29iaiB3aXRoIGdlbmRpc2sgcGFyZW50DQo+ICAgICBub3cgd2Ug
Y2FuIGZvbGxvdyBxLT5rb2JqLnBhcmVudCB0byBnZW5kaXNrIHRvIGdldCBkZXZfdCwNCj4gICAg
IGUuZy4gZm9yIFJXQlMgJ04nIHN1Y2ggYXMgaW1wbGljaXQgU0NTSSB0ZXN0IHVuaXQgcmVhZHkg
b24gYmxrIGRldiBjbG9zZQ0KDQpQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhlIGRldmljZV9hZGRf
ZGlzaygpIGNhbGwgaW4gc2RfcHJvYmVfYXN5bmMoKS4gSSB0aGluaw0KdGhhdCBmdW5jdGlvbiB0
cmlnZ2VycyBhIGNhbGwgb2YgYmxrX3JlZ2lzdGVyX3F1ZXVlKCkuIFRoYXQgbGFzdCBmdW5jdGlv
bg0KYXNzb2NpYXRlcyB0aGUgcmVxdWVzdCBxdWV1ZSB3aXRoIHRoZSBnZW5kaXNrIGFzIGZvbGxv
d3M6DQoNCglyZXQgPSBrb2JqZWN0X2FkZCgmcS0+a29iaiwga29iamVjdF9nZXQoJmRldi0+a29i
aiksICIlcyIsICJxdWV1ZSIpOw0KDQo+ICgzKSBvcHRpb25hbGx5ICJyZWd1bGFyIiBJL08NCj4g
KDQpIGJsa191bnJlZ2lzdGVyX3F1ZXVlKCkgY2FsbGVkIGJ5IGRlbF9nZW5kaXNrKCkNCj4gICAg
IGRvZXMga29iamVjdF9kZWwoJnEtPmtvYmopIHdoaWNoIE5VTExpZmllcyBxLT5rb2JqLnBhcmVu
dCBhZ2Fpbg0KPiAgICAgdGhlIGxhc3QgcHV0IG9mIGdlbmRpc2sgcmVmZXJlbmNlIHJlbGVhc2Vz
IGdlbmRpc2sga29iag0KPiAoNSkgYmxrX2NsZWFudXBfcXVldWUoKQ0KPiAgICAgdGhlIGxhc3Qg
cHV0IG9mIHF1ZXVlICgvbXEpIHJlZmVyZW5jZSByZWxlYXNlcyBxdWV1ZSAoL21xKSBrb2JqDQoN
ClRoZSAvbXEgZGlyZWN0b3J5IGNvcnJlc3BvbmRzIHRvIHEtPm1xX2tvYmouIFRoZSBibG9jayBs
YXllciBjb3JlIGRyb3BzIGl0cw0KcmVmZXJlbmNlIHRvIHRoZSBxdWV1ZSBrb2JqZWN0IChxLT5r
b2JqKSBieSBjYWxsaW5nIGJsa19wdXRfcXVldWUoKSBhdCB0aGUNCmVuZCBvZiBibGtfY2xlYW51
cF9xdWV1ZSgpLg0KDQo+IFNpbmNlIEkgY2Fubm90IHByb3ZlIGl0J3MgYWx3YXlzIGxpa2UgdGhp
cywgSSBmb2xsb3dlZCBCYXJ0J3Mgc3VnZ2VzdGlvbg0KPiBhbmQgYWRkZWQgYW5vdGhlciByZWZj
b3VudCBnZXQgYXQgKDIpIGJsa19yZWdpc3Rlcl9xdWV1ZSgpLg0KPiBIb3dldmVyLCB3aGVuIEkg
d2FudCB0byBwdXQgdGhhdCBhZGRpdGlvbmFsIHJlZmNvdW50IGF0ICg1KSBibGtfY2xlYW51cF9x
dWV1ZSgpLA0KPiB3ZSBvbmx5IGdldCBhIHF1ZXVlIHBvaW50ZXIgYXJndW1lbnQgYXMgY29udGV4
dA0KPiBhbmQgcS0+a29iai5wYXJlbnQ9PU5VTEwgc2luY2UgKDQpLA0KPiBzbyBJIGRvbid0IGtu
b3cgaG93IHRvIGdldCB0byB0aGUgZ2VuZGlzayBvYmplY3QgZm9yIHRoZSByZWZjb3VudCBwdXQu
DQoNCkhhdmUgeW91IHRyaWVkIHRvIG1vZGlmeSBibGtfcmVnaXN0ZXJfcXVldWUoKSBzdWNoIHRo
YXQgaXQgc3RvcmVzIHRoZSBkaXNrDQpwb2ludGVyIGluIGEgbmV3IHN0cnVjdCByZXF1ZXN0X3F1
ZXVlIG1lbWJlcj8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg0KDQoNCg0K
