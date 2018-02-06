Return-Path: <prvs=5689bd51d=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AH8x2259pWc5ZSo693WOVp6isHxrU9RPc6cUBKHvDNi+PLHBItchu9TTU6J3i0nXQO30XGtXEDxs
ARC-Seal: i=1; a=rsa-sha256; t=1517943978; cv=none;
        d=google.com; s=arc-20160816;
        b=GKja9wEMNedvD3YBkChr/w9ZYyJgddnq9ekhlJW0HALrat0DQdUsLEdSUkw6Le27//
         n5LG9XTP4T9XOw/8+X3F7qBi/YzbwfK2Hx8QptqvaGepNco1TkCGNiwONpMBpZW0Zgdc
         UCfSLPBZSglV8Ijdn20m4BXMPM0x3cGJEE4LlT7UwD6A6Z0Od5VYun3prv3flzMARXMB
         cDHS/QPiaAAwLVrCoIfyJQnQOJawKu5Odm+IygaIJ4Blqt7mKx8x85pwiSIXc3ul0jZX
         Koq73lusK0kePOtZdkr/BPvbAD3V+tBIfQ/W5F3LYWr/1MeywOlx4vEnMyj7i4N74a5n
         nMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=FDOq7sz14jPCE7CEVGMdTpeGFtTCuNTk5QLEwfLADgo=;
        b=umJWa7C4ggWx+FOLEOm4/GVDzKBFvj9InJsmoNT/QNzRgHOsG8l2jccIEYJ6ceYVhf
         D67Iw2mPqxGjsCu/kqoqP64s3tAoikg7NZDXe3qCUHjvXS6hdnmAKjFwvxXi+9kwRPR6
         VAL5w7FX5wBq6uL99toE/TES9GrMb+zBtjmRu76/UGh6aWBJmAWF5oD22E4t9ZC4sPaB
         1iX9TBfIBYZke38uLSb+eQaMXo11YVgtZqsTOIG1m+Lnwjq87S0jLvCO030qXUTAbQcZ
         W0CEiEcAj8Pzbw7GuG39JacyjtsDlDwmW9oh00pXDzyU4R+TxlH/In1eT9sR2SPD0n2U
         opqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=cUoc4mrW;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=K14scniH;
       spf=pass (google.com: domain of prvs=5689bd51d=bart.vanassche@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=5689bd51d=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=cUoc4mrW;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=K14scniH;
       spf=pass (google.com: domain of prvs=5689bd51d=bart.vanassche@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=5689bd51d=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,469,1511798400";
   d="scan'208";a="173693852"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: Re: [PATCH v5 08/11] scsi: host template attribute groups
Thread-Topic: [PATCH v5 08/11] scsi: host template attribute groups
Thread-Index: AQHTn2UGFRtwybt4Y0mKCfUv0RVfN6OXvFCA
Date: Tue, 6 Feb 2018 19:06:12 +0000
Message-ID: <1517943971.2905.8.camel@wdc.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
	 <1517933183-30892-9-git-send-email-stanislav.nijnikov@wdc.com>
In-Reply-To: <1517933183-30892-9-git-send-email-stanislav.nijnikov@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB0924;7:nZQt/UnCOSsJHm43c49b3C7F3wNrEei6ruTi8T0qdv68Ixf4kZ8Hf4IJZa9BzhZe4XTOBr14hXlD90Ere/i+N/y0UfIW1w0vosovTitKcj/YGW/1YiK+P24wKg11g+NON7l0IIGgv5G7xgkyqlH+wNffDh+PCuCfR3+iv7nsBEAYFKflyh6uAvOHsFgrdwK446jdVGQye7jMreOmHdw1b+/Hqu8Y1IMwFNjMQg8uNKAjWpl0JVawcwQ+fIpPksTj;20:Vcz2+NQ/b3Nu0P5PChsMaEJYjmuoHSWxH4Kk15r/sql+2g+4C+IA424kDZ+ZwQffjO+knDrzKn0iT01WweoEwGTy/LGHroRwjbmRIGa7b2/uFE2/h7mX+HqBxp+ERkJauQ0qg/9LGXxXt+fFjabHeeSs5wQWw8656jJUEc6MpFk=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3f852db-7913-4806-9031-08d56d94b0b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB0924;
x-ms-traffictypediagnostic: CY1PR0401MB0924:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB09244BFF6290085DC6B0F90998FD0@CY1PR0401MB0924.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR0401MB0924;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB0924;
x-forefront-prvs: 0575F81B58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(396003)(39860400002)(346002)(51444003)(377424004)(189003)(199004)(2950100002)(8936002)(3846002)(6116002)(478600001)(110136005)(6506007)(76176011)(6486002)(2201001)(77096007)(86362001)(26005)(3280700002)(229853002)(99286004)(6512007)(68736007)(316002)(6436002)(2501003)(36756003)(102836004)(186003)(3660700001)(2900100001)(14454004)(105586002)(8676002)(97736004)(53936002)(4326008)(106356001)(103116003)(6246003)(81156014)(305945005)(81166006)(72206003)(5660300001)(6636002)(66066001)(2906002)(25786009)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB0924;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ACwMDffxDf+mTyialtvoF9hTwIg18u08v0XzQsEw1b8dwDXzQFc4ZsEMi/ihonnWV3mEomO8GTFi2/CnQh1Nqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C49288F27522E4092D9B678CCBDAFAE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f852db-7913-4806-9031-08d56d94b0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2018 19:06:12.9353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB0924
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668330658484083?=
X-GMAIL-MSGID: =?utf-8?q?1591679625061640747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTAyLTA2IGF0IDE4OjA2ICswMjAwLCBTdGFuaXNsYXYgTmlqbmlrb3Ygd3Jv
dGU6DQo+ICsJaWYgKHNkZXYtPmhvc3QtPmhvc3R0LT5zZGV2X2dyb3Vwcykgew0KPiArCQllcnJv
ciA9IHN5c2ZzX2NyZWF0ZV9ncm91cHMoJnNkZXYtPnNkZXZfZ2VuZGV2LmtvYmosDQo+ICsJCQlz
ZGV2LT5ob3N0LT5ob3N0dC0+c2Rldl9ncm91cHMpOw0KPiArCQkJaWYgKGVycm9yKQ0KPiArCQkJ
CXJldHVybiBlcnJvcjsNCj4gKwl9DQoNClBsZWFzZSBmb2xsb3cgdGhlIGluZGVudGF0aW9uIHN0
eWxlIHRoYXQgaXMgdXNlZCBlbHNld2hlcmUgaW4gdGhlIGtlcm5lbCBhbmQNCm1vdmUgdGhlIHNk
ZXYtPmhvc3QtPmhvc3R0LT5zZGV2X2dyb3VwcyBhcmd1bWVudCB0byB0aGUgcmlnaHQgc3VjaCB0
aGF0IGl0DQpzdGFydHMgb25lIHBvc2l0aW9uIHRvIHRoZSByaWdodCBvZiB0aGUgc3lzZnNfY3Jl
YXRlX2dyb3VwcygpIG9wZW5pbmcNCnBhcmVudGhlc2lzLiBQbGVhc2UgYWxzbyBpbmRlbnQgdGhl
IGlmIChlcnJvcikgc3RhdGVtZW50IGNvcnJlY3RseS4NCg0KPiBAQCAtMTMyNiw2ICsxMzMzLDEx
IEBAIHZvaWQgX19zY3NpX3JlbW92ZV9kZXZpY2Uoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2KQ0K
PiAgCWlmIChzZGV2LT5zZGV2X3N0YXRlID09IFNERVZfREVMKQ0KPiAgCQlyZXR1cm47DQo+ICAN
Cj4gKwlpZiAoc2Rldi0+aG9zdC0+aG9zdHQtPnNkZXZfZ3JvdXBzKSB7DQo+ICsJCXN5c2ZzX3Jl
bW92ZV9ncm91cHMoJnNkZXYtPnNkZXZfZ2VuZGV2LmtvYmosDQo+ICsJCQlzZGV2LT5ob3N0LT5o
b3N0dC0+c2Rldl9ncm91cHMpOw0KPiArCX0NCg0KSWYgc2Rldi0+aXNfdmlzaWJsZSBpcyBmYWxz
ZSB0aGVuIHRoZSBkZXZpY2VfYWRkKCkgY2FsbCBmb3Igc2Rldi0+c2Rldl9nZW5kZXYNCm1heSBo
YXZlIGZhaWxlZCBzbyBjYWxsaW5nIHN5c2ZzX3JlbW92ZV9ncm91cHMoKSBpcyBub3QgbmVjZXNz
YXJ5LiBQbGVhc2UgbW92ZQ0KdGhpcyBjYWxsIGRvd24gdG8ganVzdCBiZWZvcmUgdGhlIGRldmlj
ZV9kZWwoZGV2KSBzaW5jZSB0aGF0IGNhbGwgYWxzbyByZW1vdmVzDQpzeXNmcyBhdHRyaWJ1dGVz
LiBBZGRpdGlvbmFsbHksIEkgdGhpbmsgdGhhdCBjaGVja3BhdGNoIHdpbGwgY29tcGxhaW4gYWJv
dXQgdGhlDQphYm92ZSBjb2RlIGFuZCB3aWxsIHJlcG9ydCB0aGF0IGJyYWNlcyBhcmUgbm90IG5l
Y2Vzc2FyeSBmb3Igc2luZ2xlLWxpbmUNCnN0YXRlbWVudHM/DQoNClRoYW5rcywNCg0KQmFydC4N
Cg0KDQoNCg==
