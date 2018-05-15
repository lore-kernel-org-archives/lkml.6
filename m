Return-Path: <decui@microsoft.com>
X-Google-Smtp-Source: AB8JxZqSTvUNUq57BYdKAN4hFdrNaMywM/e53cHYTuyGmgjfhR/N5fz/f8SQujp/ahABb2iA5Mu+
ARC-Seal: i=1; a=rsa-sha256; t=1526353358; cv=none;
        d=google.com; s=arc-20160816;
        b=yMpTmiwZ9JNW2elHwwEf5VGDMJm2pkhuY8fAbkIb5UOYBFzvmecWyN4pYzicUMuT2K
         kr0FKSVA3uHCtBQyUMqZd6+yQO0EP4Q+wz6ppQgez6aiQeoaaaiAQPqeZiCQHq8OsTsj
         3swQVbuQDEIHjZ12Y6SBwAlI+DQn9hdAopWmd0wzCHBwl39lDE2PTrrPjXG8QLdhF8Kd
         Zvyyh/tg0u5xXpgKEa9Me7xEKlshlxwEvbYBHdcjV/n0Y/hP9Qc84HpufSOX5xVIK7+G
         toOLvTf5957T3exJWSEjgo9Z1DCMmWVflAlgzJhHl0UA+pilDpMTb4V6Mtgs8+MCIJfg
         BJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=iN9rYq7j4M8TDTlmhNZLJrcYnEB4wxcKw2NYxIFsgFw=;
        b=FCGfSazJpOTRRxVKdDFBfEEKEOCEg76iWIEdFSI4NkmGH46qCWN64cg/6U6ngQkDeb
         zFr2InqFa4GL2v7QrrrFSuDw+7RiXNywdwotqzdq2Sh6aX0B1SqCCM+tgQHjVryYnGtZ
         PpwvrZ3qLPSbxdRKkCTbBQCuW36MHf2MElc+a5a7ZnKBpO4XAvuClJVz9mlomgtjiwa5
         x/g41vejXyLXPv1uZkaJM+sRToV8JKAiWlOJAwYsyeQnzZxytHevILLo0oxEUEtZLUMq
         i/o/UUQAkD3ByQrpbKur1sZ7kloAyq/wDw0aT/l9ymK6l/L+o4AJyNMqN/MZgRHV1u4y
         9yEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=ApOau1WU;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.125.94 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=ApOau1WU;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.125.94 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Dexuan Cui <decui@microsoft.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rakib Mullick
	<rakib.mullick@gmail.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: RE: for_each_cpu() is buggy for UP kernel?
Thread-Topic: for_each_cpu() is buggy for UP kernel?
Thread-Index: AQHT6/knJa5WstrYJkq8AbGhuJkM9A==
Date: Tue, 15 May 2018 03:02:27 +0000
Message-ID: <SG2P15301MB0015F23FF0E44BE991E8C38EBF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <CA+55aFx5_qcUHBQ50RfOnH+pS=jqA_Wg2YYCcm=fTXRFJjs3rg@mail.gmail.com>
In-Reply-To: <CA+55aFx5_qcUHBQ50RfOnH+pS=jqA_Wg2YYCcm=fTXRFJjs3rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-15T03:02:25.5807930Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:1::7a8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0014;7:PCdIRpVt65okjxdjFEp+fNtot6Z3jYhnfdqKzqq7vXWa3ptkJQ8CHU8pgqzWwi/Oar+44oDgu7UEzlEdIV+3sJfIgubqnD9ns/PW5vHw3oF6Zzn0ZVxoPP3p6m69WieIoiGjQjfvMuqwE91r73ro/PeAAu4TAkUTBaFC2urhC0CXWpnjcmFJ6a/0SmTxZxXNzHzWGV3biCi0KkeQLIRxgxYFUvNIP0RlI37VEk9mDiHPtrHmulQrNYTJNZ8uDnNJ;20:M2hXeFlPNgtyPbvjSTMf9mPs880xFHD1ziSSKI9taoyQuQi6Pd9fexNppmu9kgeqtJcDTASq2SyH3n3p3qGJv/sRQRxfkaah7enGuI3ooruzQVSv/GrPztnxEj8bLhU8sUWGJB74/BuQkS2Hy2E4YNHd185YCmbuJDVgn8aqR6U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0014;
x-ms-traffictypediagnostic: SG2P15301MB0014:
x-microsoft-antispam-prvs: <SG2P15301MB001475D9A234FDF9C6C6E2F9BF930@SG2P15301MB0014.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(148717330147763);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SG2P15301MB0014;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0014;
x-forefront-prvs: 0673F5BE31
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(189003)(199004)(4326008)(3660700001)(53936002)(39060400002)(6246003)(7696005)(105586002)(106356001)(446003)(11346002)(7736002)(86362001)(9686003)(55016002)(81156014)(486006)(86612001)(54906003)(3280700002)(5660300001)(76176011)(99286004)(68736007)(22452003)(74316002)(2906002)(8990500004)(6436002)(14454004)(229853002)(478600001)(25786009)(102836004)(305945005)(81166006)(316002)(6916009)(476003)(46003)(8936002)(8676002)(10090500001)(6116002)(6506007)(5250100002)(59450400001)(2900100001)(10290500003)(97736004)(33656002)(53546011)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0014;H:SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Ns3glH7hQ1f28ekCTuNwGOS/qsARV7FmCDhbDwtkM0mPs5IbGP3vCFdbgkwu3kK9P3o76X5ix3ms92v5MCZq8Zm0AyQ+5wMJgsCePwrjx/tBeOmYriHhGBui+NrhmK5Mtw8ZUZEu7DLpWfkiy1AI9XRgexnO+yvmHwZTU2YgW+xBeIhH+597Kv6OIU70B5vY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f352fb30-bc03-43d4-0d7f-08d5ba104ac2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f352fb30-bc03-43d4-0d7f-08d5ba104ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 03:02:27.4033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0014
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599966610262155638?=
X-GMAIL-MSGID: =?utf-8?q?1600497498995164783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
IFNlbnQ6IFN1bmRheSwgTWF5IDEzLCAyMDE4IDExOjIyDQo+IE9uIFR1ZSwgTWF5IDgsIDIwMTgg
YXQgMTE6MjQgUE0gRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+IA0K
PiA+IFNob3VsZCB3ZSBmaXggdGhlIGZvcl9lYWNoX2NwdSgpIGluIGluY2x1ZGUvbGludXgvY3B1
bWFzay5oIGZvciBVUD8NCj4gDQo+IEFzIFRob21hcyBwb2ludHMgb3V0LCB0aGlzIGhhcyBjb21l
IHVwIGJlZm9yZS4NCj4gDQo+IE9uZSBvZiB0aGUgaXNzdWVzIGlzIGhpc3RvcmljYWwgLSB3ZSB0
cmllZCB2ZXJ5IGhhcmQgdG8gbWFrZSB0aGUgU01QIGNvZGUNCj4gbm90IGNhdXNlIGNvZGUgZ2Vu
ZXJhdGlvbiBwcm9ibGVtcyBmb3IgVVAsIGFuZCBwYXJ0IG9mIHRoYXQgd2FzIGp1c3QgdGhhdA0K
PiBhbGwgdGhlc2UgbG9vcHMgd2VyZSBsaXRlcmFsbHkgZGVzaWduZWQgdG8gZW50aXJlbHkgZ28g
YXdheSB1bmRlciBVUC4gSXQNCj4gc3RpbGwgKmxvb2tzKiBzeW50YWN0aWNhbGx5IGxpa2UgYSBs
b29wLCBidXQgYW4gb3B0aW1pemluZyBjb21waWxlciB3aWxsDQo+IHNlZSB0aGF0IHRoZXJlJ3Mg
bm90aGluZyB0aGVyZSwgYW5kICJmb3JfZWFjaF9jcHUoLi4uKSB4IiBlc3NlbnRpYWxseSBqdXN0
DQo+IHR1cm5zIGludG8gIngiIG9uIFVQLiAgQW4gZW1wdHkgbWFzayBzaW1wbHkgZ2VuZXJhbGx5
IGRvZXNuJ3QgbWFrZSBzZW5zZSwNCj4gc2luY2Ugb3BuIFVQIHlvdSBhbHNvIGRvbid0IGhhdmUg
YW55IG1hc2tpbmcgb2YgQ1BVIG9wcywgc28gdGhlIG1hc2sgaXMNCj4gaWdub3JlZCwgYW5kIHRo
YXQgaGVscHMgdGhlIGNvZGUgZ2VuZXJhdGlvbiBpbW1lbnNlbHkuDQo+IA0KPiBJZiB5b3UgaGF2
ZSB0byBsb2FkIGFuZCB0ZXN0IHRoZSBtYXNrLCB5b3UgaW1tZWRpYXRlbHkgbG9zZSBvdXQgYmFk
bHkgaW4NCj4gY29kZSBnZW5lcmF0aW9uLg0KVGhhbmsgeW91IGFsbCBmb3IgdGhlIGluc2lnaHRz
IGFuZCB0aGUgZGV0YWlsZWQgYmFja2dyb3VuZCBpbnRyb2R1Y3Rpb24hDQogDQo+IFNvIGhvbmVz
dGx5LCBJJ2QgcmVhbGx5IHByZWZlciB0byBrZWVwIG91ciBjdXJyZW50IGJlaGF2aW9yLiBQZXJo
YXBzIHdpdGggYQ0KPiBkZWJ1ZyBvcHRpb24gdGhhdCBhY3R1YWxseSB0ZXN0cyAob24gU01QIC0g
YmVjYXVzZSB0aGF0J3Mgd2hhdCBldmVyeQ0KPiBkZXZlbG9wZXIgaXMgYWN0dWFsbHkgX3VzaW5n
XyB0aGVzZSBkYXlzKSB0aGF0IHRoZSBtYXNrIGlzbid0IGVtcHR5LiBCdXQNCj4gSSdtIG5vdCBz
dXJlIHRoYXQgd291bGQgZmluZCB0aGlzIGNhc2UsIHNpbmNlIHByZXN1bWFibHkgb24gU01QIGl0
IG1pZ2h0DQo+IG5ldmVyIGJlIGVtcHR5Lg0KSSBhZ3JlZS4NCg0KPiBOb3csIHRoZXJlIGlzIGxp
a2VseSBhIGZhaXJseSBnb29kIGFyZ3VtZW50IHRoYXQgVVAgaXMgZ2V0dGluZyBfc29fDQo+IHVu
aW50ZXJlc3RpbmcgdGhhdCB3ZSBzaG91bGRuJ3QgZXZlbiB3b3JyeSBhYm91dCBjb2RlIGdlbmVy
YXRpb24uIEJ1dCB0aGUNCj4gY291bnRlci1hcmd1bWVudCB0byB0aGF0IGlzIHRoYXQgaWYgcGVv
cGxlIGFyZSB1c2luZyBVUCBpbiB0aGlzIGRheSBhbmQNCj4gYWdlLCB0aGV5IHByb2JhYmx5IGFy
ZSB1c2luZyBzb21lIHJlYWxseSBjcmFwcHkgaGFyZHdhcmUgdGhhdCBuZWVkcyBhbGwgdGhlDQo+
IGhlbHAgaXQgY2FuIGdldC4NCkZXSVcsIEkgaGFwcGVuZWQgdG8gZmluZCB0aGlzIGlzc3VlIGlu
IGEgU01QIHZpcnR1YWwgbWFjaGluZSwgYnV0IHRoZSBrZXJuZWwNCmZyb20gYSBjdXN0b21lciB3
YXMgYnVpbHQgd2l0aCBDT05GSUdfU01QIGRpc2FibGVkLiBBZnRlciBzcGVuZGluZyAxIGRheQ0K
ZGVidWdnaW5nIHRoZSBzdHJhbmdlIGJvb3QtdXAgZGVsYXksIHdoaWNoIHdhcyBjYXVzZWQgYnkg
dGhlIHVuZXhwZWN0ZWQNClBJVCBpbnRlcnJ1cHQgc3Rvcm0sIEkgZmluYWxseSB0cmFja2VkIGl0
IGRvd24gdG8gdGhlIFVQIHZlcnNpb24gb2YgZm9yX2VhY2hfY3B1KCkuDQoNClRoZSBmdW5jdGlv
biBleHBvc2luZyB0aGUgaXNzdWUgaXMga2VybmVsL3RpbWUvdGljay1icm9hZGNhc3QuYzoNCnRp
Y2tfaGFuZGxlX29uZXNob3RfYnJvYWRjYXN0KCkuDQoNCklmIHlvdSdyZSBPSyB3aXRoIHRoZSBi
ZWxvdyBmaXggKG5vdCB0ZXN0ZWQgeWV0KSwgSSdsbCBzdWJtaXQgYSBwYXRjaCBmb3IgaXQ6DQoN
Ci0tLSBhL2tlcm5lbC90aW1lL3RpY2stYnJvYWRjYXN0LmMNCisrKyBiL2tlcm5lbC90aW1lL3Rp
Y2stYnJvYWRjYXN0LmMNCkBAIC02MTYsNiArNjE2LDEwIEBAIHN0YXRpYyB2b2lkIHRpY2tfaGFu
ZGxlX29uZXNob3RfYnJvYWRjYXN0KHN0cnVjdCBjbG9ja19ldmVudF9kZXZpY2UgKmRldikNCiAg
ICAgICAgbm93ID0ga3RpbWVfZ2V0KCk7DQogICAgICAgIC8qIEZpbmQgYWxsIGV4cGlyZWQgZXZl
bnRzICovDQogICAgICAgIGZvcl9lYWNoX2NwdShjcHUsIHRpY2tfYnJvYWRjYXN0X29uZXNob3Rf
bWFzaykgew0KKyNpZm5kZWYgQ09ORklHX1NNUA0KKyAgICAgICAgICAgICAgIGlmIChjcHVtYXNr
X2VtcHR5KHRpY2tfYnJvYWRjYXN0X29uZXNob3RfbWFzaykpDQorICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsNCisjZW5kaWYNCiAgICAgICAgICAgICAgICB0ZCA9ICZwZXJfY3B1KHRpY2tf
Y3B1X2RldmljZSwgY3B1KTsNCiAgICAgICAgICAgICAgICBpZiAodGQtPmV2dGRldi0+bmV4dF9l
dmVudCA8PSBub3cpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIGNwdW1hc2tfc2V0X2NwdShj
cHUsIHRtcG1hc2spOyANCg0KPiBBdCBsZWFzdCBmb3Igbm93LCBJJ2QgcmF0aGVyIGhhdmUgdGhp
cyBpbmNvbnNpc3RlbmN5LCBiZWNhdXNlIGl0IHJlYWxseQ0KPiBtYWtlcyBhIHN1cnByaXNpbmds
eSAqYmlnKiBkaWZmZXJlbmNlIGluIGNvZGUgZ2VuZXJhdGlvbi4gIEZyb20gdGhlIGxpdHRsZQ0K
PiB0ZXN0IEkganVzdCBkaWQsIGFkZGluZyB0aGF0IG1hc2sgdGVzdGluZyB0byBhICpzaW5nbGUq
IGNhc2Ugb2YNCj4gZm9yX2VhY2hfY3B1KCkgYWRkZWQgMjAgaW5zdHJ1Y3Rpb25zLiAgSSBkaWRu
J3QgbG9vayBhdCBleGFjdGx5IHdoeSB0aGF0DQo+IGhhcHBlbmVkIChiZWNhdXNlIHRoZSBjb2Rl
IGdlbmVyYXRpb24gd2FzIHNvIHJhZGljYWxseSBkaWZmZXJlbnQpLCBidXQgaXQNCj4gd2FzIHZl
cnkgbm90aWNlYWJsZS4gSSB1c2VkIHlvdXIgbWFjcm8gcmVwbGFjZW1lbnQgaW4ga2VybmVsL3Rh
c2tzdGF0cy5jIGluDQo+IGNhc2UgeW91IHdhbnQgdG8gdHJ5IHRvIGRpZyBpbnRvIHdoYXQgaGFw
cGVuZWQsIGJ1dCBJJ20gbm90IHN1cnByaXNlZC4gSXQNCj4gcmVhbGx5IHR1cm5zIGFuIHVuY29u
ZGl0aW9uYWwgdHJpdmlhbCBsb29wIGludG8gYSBtdWNoIG1vcmUgY29tcGxleCB0aGluZw0KPiB0
aGF0IG5lZWRzIHRvIGxvb2sgYXQgYW5kIHRlc3QgYSB2YWx1ZSB0aGF0IHdlIGRpZG4ndCBjYXJl
IGFib3V0IGJlZm9yZS4NCkkgYWdyZWUuDQoNCiANCj4gTWF5YmUgd2Ugc2hvdWxkIGludHJvZHVj
ZSBhICJmb3JfZWFjaF9jcHVfbWF5YmVfZW1wdHkoKSIgaGVscGVyIGZvcg0KPiBjYXNlcyAgbGlr
ZSB0aGlzPw0KPiAgICAgICAgICAgICAgICAgICAgIExpbnVzDQpTb3VuZHMgbGlrZSBhIGdvb2Qg
aWRlYS4NCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
