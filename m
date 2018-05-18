Return-Path: <prvs=669193e76=Adam.Manzanares@wdc.com>
X-Google-Smtp-Source: AB8JxZr+yIoQQmjfLfox2LTSv5oVJkFdpXCgur63ZzJTiTmLWFQOfJNW3MpYFfSYcR4P5AkOqHFr
ARC-Seal: i=1; a=rsa-sha256; t=1526655790; cv=none;
        d=google.com; s=arc-20160816;
        b=af0hwyCsXjRXqELySpRt0QbSzZ+n2z/OMrt29aQL42pj7vnTDj095x2Pvqyms+Z+vB
         ihBL8PGP5vVRncTRJL8bYvvyzVE80C7aunhl699cwA8Ge+MPH4h7ZD0QUCB+AYHC615l
         VZE+UGFJRO381iLBWPMTD8FQ8A43qF14xWpiOSsakerrWZjAdQoyWPkGltoKHzYAxOgZ
         yJsC88A42UD6LssZ5DXK/zOIoGVw5+xwcxwxYcFq+WroS5p8Rx7u5p8r3ItvpwjOC9ii
         WmpeWQbR/sNULG0G/+eyqyuD2+Z+WC8T9VaTuXRb7HouMf6FcI2qrLq7hj8OllMqhVtD
         lqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=TUorNFipuZ1l4oWCNeRdYDuX6p5m2ApQW6aDACLYPgs=;
        b=RpkAjp+4EIK/CHmPvu6wlXNySurGRtR2joFDzazxWCZdnEiCL1xtBzTA2M9fs+cV6M
         W0KYyVkinclGVYl1VmD5XeDTSKJJlOxF5FAckA+puaUeb2MfYdB0bBU5habrUm4MYD8+
         1pIien8I5FXFmAsRPUtXWGyOUExm0+h87QkIqGcWvOI+ndom4fBoXv9C+9UL+rljgSYW
         z1yZw4qGVvE6MVJ0L8BBGw2FCC8hgMoU7WUuDHk0HzqVxU5FxKYRmkmUhPeJnLpHjimj
         Z/kPq/ceagPJcZrnlc2QyYw87tgcS5sHUSBwMTQRpBTEDq6Up5rq3Zr5xGfegVdLnWV0
         e4xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=aRbqql23;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=UkqAMo/U;
       spf=pass (google.com: domain of prvs=669193e76=adam.manzanares@wdc.com designates 216.71.153.141 as permitted sender) smtp.mailfrom=prvs=669193e76=Adam.Manzanares@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=aRbqql23;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=UkqAMo/U;
       spf=pass (google.com: domain of prvs=669193e76=adam.manzanares@wdc.com designates 216.71.153.141 as permitted sender) smtp.mailfrom=prvs=669193e76=Adam.Manzanares@wdc.com
X-IronPort-AV: E=Sophos;i="5.49,415,1520870400";
   d="scan'208";a="79948827"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "bcrl@kvack.org" <bcrl@kvack.org>
CC: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "rgoldwyn@suse.com"
	<rgoldwyn@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] AIO add per-command iopriority
Thread-Topic: [PATCH v4 0/3] AIO add per-command iopriority
Thread-Index: AQHT7h8GSATNDOGHhUO5YMjXyn2ZLaQ0xzcAgADPM4A=
Date: Fri, 18 May 2018 15:03:06 +0000
Message-ID: <e1062b8f-20e9-8f13-6bb7-d522193c895f@wdc.com>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <3ec960cf-e14c-6ff6-3356-186136f43df7@kernel.dk>
In-Reply-To: <3ec960cf-e14c-6ff6-3356-186136f43df7@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0635;7:OtIQ7QTi9oTxzBA5rqbVtutirrHqEH6/0JJa19HLSnNPmP+cTban7rSjazBU3gLgFJHazHd8me9T3iPNrIFkkU5fuu81+p08xyVFP8u3iyEQPdGc4q1g9e3zK7iS0R1tNF81m/MhBo2/0MRr/7lb/HG7OCdi0i9OJOCSQJ8JYuR+8ofwvnXPIUQ0gZYyMIAgy0mL1FUc3nUCDpLa99IHARrGpqy5A3JJie3tWWJWXnQo0K1PQi4+8qg0mrg/OSV/;20:/hsnMlb//6kD60VmR9drNQhyK0hd98T9KuvAsv7lVjU2WUpEOokrA6x4eFgL9QWDmam0c/7yTNzhJMtSGfVPXjFZCObHowrWnxgAMP8FB6n7Zy+m3qUqBy7emSWk7gG6466UE+SUwsLWusckykGI0AzF9cVqQHDXUAGWXY44nPI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0635;
x-ms-traffictypediagnostic: DM5PR04MB0635:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB06351C08B5425072624DB9FEF0900@DM5PR04MB0635.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB0635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0635;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(396003)(366004)(346002)(199004)(189003)(6246003)(6306002)(106356001)(105586002)(53936002)(66066001)(76176011)(99286004)(14454004)(4326008)(305945005)(966005)(72206003)(2616005)(68736007)(53546011)(11346002)(476003)(7736002)(486006)(446003)(6512007)(6116002)(3846002)(102836004)(478600001)(6506007)(31686004)(81166006)(186003)(59450400001)(26005)(8676002)(8936002)(81156014)(5250100002)(86362001)(2501003)(36756003)(97736004)(31696002)(3660700001)(6436002)(54906003)(110136005)(3280700002)(316002)(2906002)(2201001)(229853002)(6486002)(7416002)(25786009)(2900100001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0635;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: om+eVKnXBGLqCfJ6TWYgfaCkWyJeFDu73cZ4kmDMEwVzixsPUK2dR+eAK+IcvXgb7nfiup2Jwi7TBKVunUZNj7Ws9xXEpnHyHEWkf/b8DX+eCQF/fApU9dwoYyvDl2Ii0Xwo7aGwfZe/dz39Zv59rO81g7l9yh/Fa42vOFsgIGYu/Qmwfk4GPierD6A7NVuT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D523657124DBC34796DD94E0BBBC349E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aab36e2b-951f-429a-f3e7-08d5bcd07637
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab36e2b-951f-429a-f3e7-08d5bcd07637
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 15:03:06.3672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0635
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600745117774475570?=
X-GMAIL-MSGID: =?utf-8?q?1600814622019637896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvMTcvMTggNzo0MSBQTSwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gNS8xNy8xOCAy
OjM4IFBNLCBhZGFtLm1hbnphbmFyZXNAd2RjLmNvbSB3cm90ZToNCj4+IEZyb206IEFkYW0gTWFu
emFuYXJlcyA8YWRhbS5tYW56YW5hcmVzQHdkYy5jb20+DQo+Pg0KPj4gVGhpcyBpcyB0aGUgcGVy
LUkvTyBlcXVpdmFsZW50IG9mIHRoZSBpb3ByaW9fc2V0IHN5c3RlbSBjYWxsLg0KPj4gU2VlIHRo
ZSBmb2xsb3dpbmcgbGluayBmb3IgcGVyZm9ybWFuY2UgaW1wbGljYXRpb25zIG9uIGEgU0FUQSBI
REQ6DQo+PiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNi8xMi82LzQ5NQ0KPj4NCj4+IEZpcnN0
IHBhdGNoIGZhY3RvcnMgaW9wcmlvX2NoZWNrX2NhcCBmdW5jdGlvbiBvdXQgb2YgaW9wcmlvX3Nl
dCBzeXN0ZW0gY2FsbCB0bw0KPj4gYWxzbyBiZSB1c2VkIGJ5IHRoZSBhaW8gaW9wcmlvIGludGVy
ZmFjZS4NCj4+DQo+PiBTZWNvbmQgcGF0Y2ggY29udmVydHMga2lvY2Iga2lfaGludCBmaWVsZCB0
byBhIHUxNiB0byBhdm9pZCBraW9jYiBibG9hdC4NCj4+DQo+PiBUaGlyZCBwYXRjaCBwYXNzZXMg
aW9wcmlvIGhpbnQgZnJvbSBhaW8gaW9jYiB0byBraW9jYiBhbmQgZW5hYmxlcyBibG9ja19kZXYN
Cj4+IHVzYWdlIG9mIHRoZSBwZXIgSS9PIGlvcHJpbyBmZWF0dXJlLg0KPj4NCj4+IHYyOiBtZXJn
ZSBwYXRjaGVzDQo+PiAgICAgIHVzZSBJT0NCX0ZMQUdfSU9QUklPDQo+PiAgICAgIHZhbGlkYXRl
IGludGVuZGVkIHVzZSB3aXRoIElPQ0JfSU9QUklPDQo+PiAgICAgIGFkZCBsaW51eC1hcGkgYW5k
IGxpbnV4LWJsb2NrIHRvIGNjDQo+Pg0KPj4gdjM6IGFkZCBpb3ByaW9fY2hlY2tfY2FwIGZ1bmN0
aW9uDQo+PiAgICAgIGNvbnZlcnQga2lvY2Iga2lfaGludCB0byB1MTYNCj4+ICAgICAgdXNlIGlv
cHJpb19jaGVja19jYXAgd2hlbiBhZGRpbmcgaW9wcmlvIHRvIGtpb2NiIGluIGFpby5jDQo+Pg0K
Pj4gdjQ6IGhhbmRsZSBJT0NCX0lPUFJJTyBpbiBhaW9fcHJlcF9ydw0KPj4gICAgICBub3RlIHBh
dGNoIDMgZGVwZW5kcyBvbiBwYXRjaCAxIGluIGNvbW1pdCBtc2cNCj4+DQo+PiBBZGFtIE1hbnph
bmFyZXMgKDMpOg0KPj4gICAgYmxvY2s6IGFkZCBpb3ByaW9fY2hlY2tfY2FwIGZ1bmN0aW9uDQo+
PiAgICBmczogQ29udmVydCBraW9jYiByd19oaW50IGZyb20gZW51bSB0byB1MTYNCj4+ICAgIGZz
OiBBZGQgYWlvIGlvcHJpb3JpdHkgc3VwcG9ydCBmb3IgYmxvY2tfZGV2DQo+Pg0KPj4gICBibG9j
ay9pb3ByaW8uYyAgICAgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4g
ICBmcy9haW8uYyAgICAgICAgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKw0KPj4g
ICBmcy9ibG9ja19kZXYuYyAgICAgICAgICAgICAgIHwgIDIgKysNCj4+ICAgaW5jbHVkZS9saW51
eC9mcy5oICAgICAgICAgICB8IDE3ICsrKysrKysrKysrKysrKy0tDQo+PiAgIGluY2x1ZGUvbGlu
dXgvaW9wcmlvLmggICAgICAgfCAgMiArKw0KPj4gICBpbmNsdWRlL3VhcGkvbGludXgvYWlvX2Fi
aS5oIHwgIDEgKw0KPj4gICA2IGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pDQo+IA0KPiBUaGlzIGxvb2tzIGZpbmUgdG8gbWUgbm93LiBJIGNhbiBwaWNrIHVw
ICMxIGZvciA0LjE4IC0gYW5kIDIrMyBhcyB3ZWxsLA0KPiB1bmxlc3Mgc29tZW9uZSBlbHNlIHdh
bnRzIHRvIHRha2UgdGhlbS4NCg0KR3JlYXQsIHRoYW5rcyBKZW5zLg0KDQo+IA==
