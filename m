Return-Path: <kernel-hardening-return-12346-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvJGX9NfWKqwGy2LgngvBWeLMlNlxq1CHsDU9BkV/oIkpjmScFcTnTmI5lG+pjbuDmzs9Xj
ARC-Seal: i=1; a=rsa-sha256; t=1520636059; cv=none;
        d=google.com; s=arc-20160816;
        b=Ua86C10uKPzwpbcpYxDjuJWn4wCgmLEtLG3rP9i5EZFvAW2fdPYGbJq54JWtTnGsev
         CasV1VUS71IF/n3y6Z0/NdPZelBrt27uucRK+1CAJdbbWnVutSnSmMdOzIS8mufW8Wng
         CwqZ28G4dT2zLwWsZj0lZJWP5HpWH5lsrHJqqMNMrxb+2OS7RDYlSo3UkFnqwSEwi6B5
         2nAKK4WNmFa4Vd6kZOkY1Eh8kMFTTPNLtWQodcGtEJip/3s4RU5GBNO7yE22mIIYg6da
         1RIAdNClonK6ON486Noc3fRY80Hu6X5UXc51MVwlH/D7n2eiQfrMbz+cwvpRv2EkyBKP
         N4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=/emMQn+U+LRfGvFr/FtdEaJIm8W9mGzFU9Hzpf5oUz0=;
        b=dwAsEi0psJ58u4yfrlXAer93GE88yKUQxQW1UWQ1Xk2yYxr3bUyXksfb0J3shLGwpK
         Wr1MS58EGQn/GXjZ1byZOg6eh/YVqPIFN6nLyS0s6Xm7POLVwHV7GIkiElgIqxANGi+9
         ybarMIrKVjULlOpkKHHWG+iMlf68qdM61DIubuRwlV6CoFbWJPXXubiIu/nzdDAHAFYP
         GwDCrGcXfy8k59O5ogxXvKAzGJF58vS55Kj1kvmWZ2UsZ4SbROygepwu6SX7pbyMmH+n
         Vpn0iGJ2yDzmbIXDQPFwLG6q0HIz+jJlsPZ9UTG1V1h03Y9hd9QoeA9kDC/qVfl9aFFs
         em1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=kARDRER/;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=VnwT2KrQ;
       spf=pass (google.com: domain of kernel-hardening-return-12346-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12346-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=kARDRER/;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=VnwT2KrQ;
       spf=pass (google.com: domain of kernel-hardening-return-12346-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12346-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,447,1515427200";
   d="scan'208";a="73164898"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>, "steve@sk2.org"
	<steve@sk2.org>, "hare@suse.com" <hare@suse.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] device_handler: remove VLAs
Thread-Topic: [PATCH] device_handler: remove VLAs
Thread-Index: AQHTt/aUex+QuA3suUC1+a/4cQR5DqPIgXUA
Date: Fri, 9 Mar 2018 22:48:10 +0000
Message-ID: <1520635688.2907.17.camel@wdc.com>
References: <20180309232933.14e39858@heffalump.sk2.org>
	 <20180309223211.20473-1-steve@sk2.org>
In-Reply-To: <20180309223211.20473-1-steve@sk2.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0367;7:wN1udtrlfFny/Qstexh3PB4I7hEpmhNQ2gXUpVbcDdTmoboRMB4YBGDjla7BiKqFdM5+VoO4AoDmcgMNG/6GaVevMxv8XlZK7IryYrlBdP4LErcVJk3x9CxqegUhBq56hEJQ3yjpIYzaYSZqzLoG8BivQYzofR+jPv6za2BmiM825l9Pf5i2X3nQYexa/ht2EftyDuS6LSVyEV6e+3acjie3lQZXsgPlEzWUODVnL8C4jtGxWKK2FjyWKb42Gnd3;20:72p68VX0yevbBr2YtUDXwk/e/MNDXOC3c0gEORXzvHkIvXAblOE8k+5FVWOYU7oJ2Patans+e+g+ewJWKEq7hhnljvXLTcRdPeIt8Fvxeh56+ADqoR+5qWw8o3whqda3+Ap+iGDF+/7GXeIOFEPpvJquzFfXwnfKl+oV3cLrE0E=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa4c8953-b3cf-41d5-cfe0-08d5860fd53b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0367;
x-ms-traffictypediagnostic: MWHPR04MB0367:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0367BB969E2AE77EBE7F093398DE0@MWHPR04MB0367.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR04MB0367;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0367;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(39860400002)(366004)(396003)(189003)(377424004)(199004)(76176011)(6486002)(2501003)(3280700002)(54906003)(316002)(110136005)(5660300001)(105586002)(14454004)(478600001)(6116002)(2201001)(72206003)(6436002)(99286004)(25786009)(3846002)(86362001)(229853002)(36756003)(6512007)(2900100001)(97736004)(7736002)(8936002)(106356001)(8676002)(68736007)(4326008)(66066001)(2950100002)(102836004)(81156014)(6246003)(26005)(186003)(6506007)(2906002)(5250100002)(103116003)(3660700001)(305945005)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0367;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: VmWao9h39ccUpu7ELNGSWa0Ip7WsYXzd3B47owFXNAKKEwiRjCghkAO2+bCRpegyJYGcmGQNqhQWvRAm09Jhr+jfaGSi0WQ16PIrGSkYXe3THfS6rZyBtt9FjtrOrIltduqGWIuwDJt/KKCBq7lUI64TS2LpAIx/9VyjQHKzEREAMGn8kkUlNyP3AIoo02WBr95SU2Xn9Gy6pPB6fm/J/6Nilzml5gr+j3WzKBp58jdA471rbuq3W1aEEpF2cShydXaDjbmEci52Qf66umN7LAwWhkuWVRlKAamDmIGlSppe8AfVi4hChhgbJY28jJtuwgGmGbDT6rW0Gl9xklEx/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <78D4180CAEC9A24CB77CFAFBA3697411@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4c8953-b3cf-41d5-cfe0-08d5860fd53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 22:48:10.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0367
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501121445271854?=
X-GMAIL-MSGID: =?utf-8?q?1594502476023064994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCAyMDE4LTAzLTA5IGF0IDIzOjMyICswMTAwLCBTdGVwaGVuIEtpdHQgd3JvdGU6DQo+
IEluIHByZXBhcmF0aW9uIHRvIGVuYWJsaW5nIC1XdmxhLCByZW1vdmUgVkxBcyBhbmQgcmVwbGFj
ZSB0aGVtIHdpdGgNCj4gZml4ZWQtbGVuZ3RoIGFycmF5cyBpbnN0ZWFkLg0KPiANCj4gc2NzaV9k
aF97YWx1YSxlbWMscmRhY30gdXNlIHZhcmlhYmxlLWxlbmd0aCBhcnJheSBkZWNsYXJhdGlvbnMg
dG8NCj4gc3RvcmUgY29tbWFuZCBibG9ja3MsIHdpdGggdGhlIGFwcHJvcHJpYXRlIHNpemUgYXMg
ZGV0ZXJtaW5lZCBieQ0KPiBDT01NQU5EX1NJWkUuIFRoaXMgcGF0Y2ggcmVwbGFjZXMgdGhlc2Ug
d2l0aCBmaXhlZC1zaXplZCBhcnJheXMgdXNpbmcNCj4gTUFYX0NPTU1BTkRfU0laRSwgc28gdGhh
dCB0aGUgYXJyYXkgc2l6ZSBjYW4gYmUgZGV0ZXJtaW5lZCBhdCBjb21waWxlDQo+IHRpbWUuDQoN
CklmIENPTU1BTkRfU0laRSgpIGlzIGV2YWx1YXRlZCBhdCBjb21waWxlIHRpbWUsIGRvIHdlIHN0
aWxsIG5lZWQgdGhpcyBwYXRjaD8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg==
