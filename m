Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELvsXn3zogzojAOR356OBFX/AopvCgt3ZuUrJfFEj+HLiLAVFT4DM2tFYm/Lgalsg/WjcBWH
ARC-Seal: i=1; a=rsa-sha256; t=1520311324; cv=none;
        d=google.com; s=arc-20160816;
        b=JQjAhcT9YGwA/rBA2CmSQ9drxNq4dH49YMs/hWV82iiJ5lraTqWjdt8dvBWZSDjS2l
         UqvdcSbz+Di7LS4UHqkUaessaz4H4K3/7TKFZpYhqprsIGJNrerwqV5wsoG8Uz042TTC
         cSYcblU1Hj8awlX05ITlabnJYfyhZoHxKf0nUr6AutJinYk+IK/P2RXovPs7/oGUpA4f
         aDt51C/DhCirL5Yv1hM4dNEX1hv4BQpeStk9Uc1Jjuy0DZyIBx174157ANNX1gFlUbX7
         H0XZMqPyXJ5SIcY6a8NayZi/Ds+w9sVojYzYdLb4H1123bAXVrBnusqkOCYiXUO2i8E9
         5s6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=YBdKx4Wksn++Wr+Xxh3Wi7LIrcFcTx5JfKrfl0HjOPQ=;
        b=AEh1PTGf6NgGGH3GrsEf4p6FqqLoRG97VDLlKSINazpkBrENeXJnhQS4tUD4nSyN76
         x/L1rctEVuaHxwNjyYF7rLRA5DGxrYAerO7rZhTeNGsKWDfgjrQoHSprCS4RloFjNcyu
         Bd/hBft4gezAvEwIUPGbq7bzUahNqW1ZHBrB/iytzK/pEJaCYbMHZOCCfTwRTKOhHWe8
         uN7pcqRXJwFVhB2A6iysVoro5eTyeDAeSVWjxrdNGS5ZhQiLWjL6iVZXZtfncETZeApu
         cX8YO6xxdU/+x5Hde0aCN+PI+56jfcTg7EdKHAsP6sR+U7tMu33bRz9+dgGiZp4pALGn
         HtpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=WnSLI7cD;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.43 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=WnSLI7cD;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.43 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
CC: "will.deacon@arm.com" <will.deacon@arm.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>, Leo Li
	<leoyang.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
	<laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 5/6] dma-mapping: support fsl-mc bus
Thread-Topic: [PATCH 5/6] dma-mapping: support fsl-mc bus
Thread-Index: AQHTtI6BgJXbveMvYUyck0ElBntke6PBvnMAgAALQwCAAC/OAIAAA3AAgAChi7A=
Date: Tue, 6 Mar 2018 04:41:56 +0000
Message-ID: <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
 <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
In-Reply-To: <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2218;7:YS5p6FxTp5qMfFMcXVyLWYp9tK16FzWQnDfALQRDcb0YNxShj5Y0OU8ZaWPtImkC+PMv30hu4NmT3tXYdKhWUqnsxYRiOOvmKo7ohwNc9Rmiw4c3E3wFRYPxmqoheQoPYowcghHN928YoTEe/+8f2VBNTvxbV/jKjF3SrQIbPQv+WsmrGMa7opYj2Mgher7vMQA39vz5zrARoKKJg6n9sgGIhmR+kNCYBk1GDwcQS9vNdRVVq3cJEl5jg6Cmfdet
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(39380400002)(396003)(189003)(199004)(102836004)(99286004)(5250100002)(81156014)(6436002)(110136005)(55236004)(3660700001)(59450400001)(186003)(6506007)(53546011)(54906003)(316002)(7736002)(81166006)(105586002)(7416002)(86362001)(39060400002)(97736004)(478600001)(8676002)(2900100001)(106356001)(9686003)(33656002)(6246003)(93886005)(2906002)(2950100002)(26005)(8936002)(6116002)(3846002)(74316002)(66066001)(25786009)(305945005)(55016002)(68736007)(7696005)(229853002)(76176011)(4326008)(5660300001)(3280700002)(53936002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2218;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c12c7eac-8ad3-4962-7f7f-08d5831c9782
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2218;
x-ms-traffictypediagnostic: HE1PR0401MB2218:
x-microsoft-antispam-prvs: <HE1PR0401MB22187192461FDD687B2996D1E6D90@HE1PR0401MB2218.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2218;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2218;
x-forefront-prvs: 06036BD506
x-microsoft-antispam-message-info: 1bpLnVaTGwZa1nGs4h8plShgH1U6eBaABR0hHJoNfFFoxa6oL4sPNZ9IN2FqkLUIs2NkCCsgCzGK7IcwLThtKX5h1uaezeEE7y3Iqokbx9qohBI7aGCX2Z29wP9T+XTQrt2R+GzgBlzZTMevVh5za9XOTsy8hcTqXteMC9LaLwqt9hr2tdDc44032xTWwJxTIltN/DVewaUETtgAn7KQPiwyXcTL/R4N1pN4Pp+GJV3lWLqci2nkmIqxFNxW53HYnHlZkGGEuwdc5WfeiJu6uQpKPzWSjBrPtQ1axzrJVUuDu1BJYA9TVblRBFgKiIhxY4gwahtKe0DqZJqLi5URlg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12c7eac-8ad3-4962-7f7f-08d5831c9782
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 04:41:56.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2218
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594161967258079410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCj4gRnJvbTogUm9iaW4gTXVycGh5IFttYWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+
IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDA2LCAyMDE4IDA6MjINCj4gDQo+IE9uIDA1LzAzLzE4IDE4
OjM5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiBPbiBNb24sIE1hciAwNSwgMjAxOCBh
dCAwMzo0ODozMlBNICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+ID4+IFVuZm9ydHVuYXRl
bHkgZm9yIHVzLCBmc2wtbWMgaXMgY29uY2VwdHVhbGx5IHJhdGhlciBsaWtlIFBDSSBpbiB0aGF0
IGl0J3MNCj4gPj4gc29mdHdhcmUtZGlzY292ZXJhYmxlIGFuZCB0aGUgb25seSB0aGluZyBkZXNj
cmliZWQgaW4gRFQgaXMgdGhlIGJ1cyAiaG9zdCIsDQo+ID4+IHRodXMgd2UgbmVlZCB0aGUgc2Ft
ZSBzb3J0IG9mIHRoaW5nIGFzIGZvciBQQ0kgdG8gbWFwIGZyb20gdGhlIGNoaWxkDQo+ID4+IGRl
dmljZXMgYmFjayB0byB0aGUgYnVzIHJvb3QgaW4gb3JkZXIgdG8gZmluZCB0aGUgYXBwcm9wcmlh
dGUgZmlybXdhcmUNCj4gPj4gbm9kZS4gV29yc2UgdGhhbiBQQ0ksIHRob3VnaCwgd2Ugd291bGRu
J3QgZXZlbiBoYXZlIHRoZSBvcHRpb24gb2YNCj4gPj4gZGVzY3JpYmluZyBjaGlsZCBkZXZpY2Vz
IHN0YXRpY2FsbHkgaW4gZmlybXdhcmUgYXQgYWxsLCBzaW5jZSBpdCdzIGFjdHVhbGx5DQo+ID4+
IG9uZSBvZiB0aGVzZSBydW50aW1lLWNvbmZpZ3VyYWJsZSAiYnVpbGQgeW91ciBvd24gbmV0d29y
ayBhY2NlbGVyYXRvciINCj4gPj4gaGFyZHdhcmUgcG9vbHMgd2hlcmUgdXNlcnNwYWNlIGdldHMg
dG8gY3JlYXRlIGFuZCBkZXN0cm95ICJkZXZpY2VzIiBhcyBpdA0KPiA+PiBsaWtlcy4NCj4gPg0K
PiA+IEkgcmVhbGx5IGhhdGUgdGhlIFBDSSBzcGVjaWFsIGNhc2UganVzdCBhcyBtdWNoLiAgTWF5
YmUgd2UganVzdA0KPiA+IG5lZWQgYSBkbWFfY29uZmlndXJlIG1ldGhvZCBvbiB0aGUgYnVzLCBh
bmQgbW92ZSBQQ0kgYXMgd2VsbCBhcyBmc2wtbWMNCj4gPiB0byBpdC4NCj4gDQo+IEhtbSwgb24g
cmVmbGVjdGlvbiwgMTAwJSBhY2sgdG8gdGhhdCBpZGVhLiBJdCB3b3VsZCBuZWF0bHkgc3VwZXJz
ZWRlDQo+IGJ1cy0+Zm9yY2VfZG1hICphbmQqIG1lYW4gdGhhdCB3ZSBkb24ndCBoYXZlIHRvIGVm
ZmVjdGl2ZWx5IHB1bGwgcGNpLmgNCj4gaW50byBldmVyeXRoaW5nLCB3aGljaCBJJ3ZlIG5ldmVy
IGxpa2VkLiBJbiBoaW5kc2lnaHQgZG1hX2NvbmZpZ3VyZSgpDQo+IGRvZXMgZmVlbCBsaWtlIGl0
J3MgZ3Jvd24gaW50byB0aGlzIG9kZCBjaG9rZSBwb2ludCB3aGVyZSB3ZSBtdW5nZQ0KPiBldmVy
eXRoaW5nIGluIGp1c3QgZm9yIGl0IHRvIGF3a3dhcmRseSB1bnBpY2sgdGhpbmdzIGFnYWluLg0K
PiANCj4gUm9iaW4uDQoNCisxIHRvIHRoZSBpZGVhLg0KDQpTb3JyeSBmb3IgYXNraW5nIGEgdHJp
dmlhbCBxdWVzdGlvbiAtIGxvb2tpbmcgaW50byBkbWFfY29uZmlndXJlKCkgSSBzZWUgdGhhdA0K
UENJIGlzIHVzZWQgaW4gdGhlIHN0YXJ0IGFuZCB0aGUgZW5kIG9mIHRoZSBBUEkuDQpJbiB0aGUg
ZW5kIHBhcnQgcGNpX3B1dF9ob3N0X2JyaWRnZV9kZXZpY2UoKSBpcyBjYWxsZWQuDQpTbyBhcmUg
dHdvIGJ1cyBjYWxsYmFja3Mgc29tZXRoaW5nIGxpa2UgJ2RtYV9jb25maWdfc3RhcnQnICYgJ2Rt
YV9jb25maWdfZW5kJw0Kd2lsbCBiZSByZXF1aXJlZCB3aGVyZSB0aGUgZm9ybWVyIG9uZSB3aWxs
IHJldHVybiAiZG1hX2RldiI/DQoNClJlZ2FyZHMsDQpOaXB1bg0K
