Return-Path: <prvs=564c18bbf=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AH8x227rkp2qNa1npP045hkTgYF3Je1IiRTAWDcgxr4AwdNqH/CcsiCpzHn8+6dcrtV0URp1CGN3
ARC-Seal: i=1; a=rsa-sha256; t=1517589123; cv=none;
        d=google.com; s=arc-20160816;
        b=vXQM2tgauKDSBS4mMkFncosjGXv9Ti6HdgOOxj7XREcHRpF1f5fIpGu752mTt3HK6h
         dNUfwxN+KR8/l1tvTt/LaxAOYNhUBEu7a5XAYhxkFvqRE6MEiGXftBPMl2H5ci2x8rCy
         +APrN8ezrGojxNMcgKSlS1bLyQbSKwlAQDUG7llLkt2i8AWgXnKlPnYNEUcu1f6qcTZj
         SMdIzmeli0dRoLSg8CNvzB7uw0QkqSr3AAG0ZDZlt1IMyGz6oIV1I4q5Sq06di0R97X8
         tofzcrK/uQAv/XP6OshBWofV2qGl9jqcb2O86vBpkoG1EET6f8VMrHhGTLBT8wAE4zLv
         qvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=uSoj73OgnuezkSFdZ680cGRw+EwBqisnuGd5A84gRKw=;
        b=Eh+ODNdDGO3cTu/lH+g/Bx2jSx3viY9SGosZJccCt9YSq2dZemvGbYUneOtjXJFMpJ
         CG4yq4BhVGxBRLQnHjPTwSsjdF5n94PZX9msGi5Kn+VcWigghBGb4oVwSzxe7585DoCd
         g2bb0t8vCBV4Gidqsp6h3dun1hBpct55KXZUOq53WwogZnXWiXtqgml8m4fMUsHPX6SI
         RSfn+4dLDwuLEjiuj9o3dgvDRL8CUfN2lV8V+MkVcjOqLZ8XyZgwOtAjp04En0Tqkdgw
         ege4DlG+YWAaUMA1CGQjsEXCUC3pUbU7hW1DG6SK0YsA3YqqhDStQ/AOf0QdTx6grJvX
         Gi7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Vl9nfmI3;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=MO/wnPN+;
       spf=pass (google.com: domain of prvs=564c18bbf=bart.vanassche@wdc.com designates 216.71.153.141 as permitted sender) smtp.mailfrom=prvs=564c18bbf=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Vl9nfmI3;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=MO/wnPN+;
       spf=pass (google.com: domain of prvs=564c18bbf=bart.vanassche@wdc.com designates 216.71.153.141 as permitted sender) smtp.mailfrom=prvs=564c18bbf=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,448,1511798400";
   d="scan'208";a="71006887"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>, Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
Subject: Re: [PATCH v4 02/10] ufs: sysfs: device descriptor
Thread-Topic: [PATCH v4 02/10] ufs: sysfs: device descriptor
Thread-Index: AQHTm3hGoRqnZ3BUQkShg0Hz0gO6oqOQQcqAgABzEYCAAJrmgA==
Date: Fri, 2 Feb 2018 16:32:00 +0000
Message-ID: <1517589119.2675.19.camel@wdc.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
	 <1517501746-19075-3-git-send-email-stanislav.nijnikov@wdc.com>
	 <1517531145.2746.26.camel@wdc.com> <20180202071735.GC9314@kroah.com>
In-Reply-To: <20180202071735.GC9314@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1648;7:cRKlSGKf8KAxq52l9HEQVKR/0YNy1Hrc5/idHrLI8N8eQ30gFfbhqgN7VOT232VtKjRXcZxuT8MwrDuhAeI5Tz0NoJPkAbHvLQ6f4iJMrlVCSqi9Jh4ciui4c3yrAVOqBsR4BzxeKnlloBYACcV5uqLLug6Wv1+r7a4KUvQuHV0yUNmZA/5i6Qh9P0JorLZe0uPGNnTdEVDWu8z6j7OSqVHf5a1+HoYf3sgwvawDJlmlZXV89Lbn30nVdOa7EIpI;20:sfMkjJ0dBHixWRjC30n/ZiUkNrx5E5OZ2mFY+sjmzEXAlfM1y/iGXVuAuTUxS6GF6AyvfbG1qNFA0pRArjKE/FmVyKFXnAA9MFCU5T9V2INt2zElES8PKjbJsEnUDiRMVmvesnAff8D57Rh143EIpwTSEP6q+ljYfCvIj+HutR8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1febaaa0-8642-4b2e-f3fc-08d56a5a7c3d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1648;
x-ms-traffictypediagnostic: CY1PR0401MB1648:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB164886094184AC3F9CC8844198F90@CY1PR0401MB1648.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR0401MB1648;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1648;
x-forefront-prvs: 05715BE7FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(376002)(366004)(39380400002)(377424004)(199004)(189003)(36756003)(478600001)(6506007)(5640700003)(25786009)(6436002)(1730700003)(561944003)(3280700002)(53936002)(3660700001)(5660300001)(8936002)(103116003)(81166006)(81156014)(4326008)(105586002)(6486002)(8676002)(14454004)(97736004)(229853002)(59450400001)(2950100002)(26005)(76176011)(106356001)(2900100001)(6512007)(2351001)(68736007)(186003)(2501003)(77096007)(102836004)(305945005)(7520500002)(54906003)(66066001)(6246003)(316002)(6916009)(93886005)(86362001)(2906002)(3846002)(72206003)(6116002)(99286004)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1648;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wGhezLtStLwYAxxtmJ74DmGLrfe5cMN7c+FuN9co56PEVuNgtZ0WWi1X3wRGmeiRGjrteH7xLEAA3lZKywCiLA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <84507CBB51C93B40A4B001D7EBBF9F5F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1febaaa0-8642-4b2e-f3fc-08d56a5a7c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2018 16:32:00.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1648
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215920431432185?=
X-GMAIL-MSGID: =?utf-8?q?1591307532844788205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCAyMDE4LTAyLTAyIGF0IDA4OjE3ICswMTAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gRnJpLCBGZWIgMDIsIDIwMTggYXQgMTI6MjU6NDZBTSArMDAwMCwg
QmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAxOC0wMi0wMSBhdCAxODoxNSAr
MDIwMCwgU3RhbmlzbGF2IE5pam5pa292IHdyb3RlOg0KPiA+ID4gK2VudW0gdWZzX2Rlc2NfcGFy
YW1fc2l6ZSB7DQo+ID4gPiArCVVGU19QQVJBTV9CWVRFX1NJWkUJPSAxLA0KPiA+ID4gKwlVRlNf
UEFSQU1fV09SRF9TSVpFCT0gMiwNCj4gPiA+ICsJVUZTX1BBUkFNX0RXT1JEX1NJWkUJPSA0LA0K
PiA+ID4gKwlVRlNfUEFSQU1fUVdPUkRfU0laRQk9IDgsDQo+ID4gPiArfTsNCj4gPiANCj4gPiBQ
bGVhc2UgZG8gbm90IGNvcHkgYmFkIG5hbWluZyBjaG9pY2VzIGZyb20gdGhlIFdpbmRvd3Mga2Vy
bmVsIGludG8gdGhlIExpbnV4DQo+ID4ga2VybmVsLiBVc2luZyBuYW1lcyBsaWtlIFdPUkQgLyBE
V09SRCAvIFFXT1JEIGlzIG11Y2ggbGVzcyByZWFkYWJsZSB0aGFuIHVzaW5nDQo+ID4gdGhlIG51
bWVyaWMgY29uc3RhbnRzIDIsIDQsIDguIEhlbmNlIG15IHByb3Bvc2FsIHRvIGxlYXZlIG91dCB0
aGUgYWJvdmUgZW51bQ0KPiA+IGNvbXBsZXRlbHkuDQo+IA0KPiBBcmUgeW91IHN1cmUgdGhvc2Ug
ZG8gbm90IGNvbWUgZnJvbSB0aGUgc3BlYyBpdHNlbGY/ICBJdCdzIGJlZW4gYSB3aGlsZQ0KPiBz
aW5jZSBJIGxhc3QgcmVhZCBpdCwgYnV0IGZvciBzb21lIHJlYXNvbiBJIHJlbWVtYmVyIHRob3Nl
IHR5cGVzIG9mDQo+IG5hbWVzIGJlaW5nIGluIHRoZXJlLiAgQnV0IEkgbWlnaHQgYmUgY29uZnVz
aW5nIHNwZWNzIGhlcmUuDQoNCkhlbGxvIEdyZWcsDQoNClRoYXQncyBhIGdvb2QgcXVlc3Rpb24u
IEhvd2V2ZXIsIGEgcXVpY2sgc2VhcmNoIG9uIHRoZSBJbnRlcm5ldCBmb3IgdGhlIHNlYXJjaA0K
cGhyYXNlICJVbml2ZXJzYWwgRmxhc2ggU3RvcmFnZSIgInF3b3JkIiBkaWQgbm90IHlpZWxkIGFu
eSByZXN1bHRzIGFib3V0IFVGUyBpbg0KdGhlIGZpcnN0IHRlbiBzZWFyY2ggaGl0cy4gQW5kIEkg
aGF2ZW4ndCBmb3VuZCBhbnkgcmVmZXJlbmNlcyB0byB0aGUgRFdPUkQgLw0KUVdPUkQgdGVybWlu
b2xvZ3kgaW4gdGhlICJVTklWRVJTQUwgRkxBU0ggU1RPUkFHRSBIT1NUIENPTlRST0xMRVIgSU5U
RVJGQUNFDQooVUZTSENJKSwgVU5JRklFRCBNRU1PUlkgRVhURU5TSU9OLCBWZXJzaW9uIDEuMSIg
ZG9jdW1lbnQgZWl0aGVyLiBNYXliZSB0aGF0DQptZWFucyB0aGF0IEkgd2FzIGxvb2tpbmcgYXQg
dGhlIHdyb25nIGRvY3VtZW50Pw0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
