Return-Path: <prvs=6124e0dd9=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AG47ELvngZPv1lfFYkFPvHFoiUDCQKz2pEzPaucKe6nc0JvgwBsYSIGr5BcKPQ9I8X8p09OXkkhr
ARC-Seal: i=1; a=rsa-sha256; t=1521728137; cv=none;
        d=google.com; s=arc-20160816;
        b=revjAIRxkSUMzsPPNmT0d2uspl5a0k9kvKyIV5JiIVWIFsQPeJ5/UiaGfv0x84plfL
         lPTFZtRgif/PEyUfUILaCQJGF++NfQ0nrq6cNYaiNdfNkxVRJSpBAOFHRuBcorU8o3Yy
         io5zAhYuaT5R6d/cBQTgcnW/mi51BHpv5HSmR7aLFHn9HAARdKJn3Er3i0M4cfQFoROq
         OlJgM3F9Yf4uvDpRiil4ljq23umYGCJs5z+eHsrn+f8+EyONls+Fs3nFqmCViPw/Ukf+
         i5zmzcWh3Fy0AqjfjoWsdl6MTJWafqhppzQ02ICPuvuuZW+7w2nr79dS08Rcg2yCSEko
         FqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=faYVB/ySPxxpa+YudiApMwBgFiFi2Dh9gMFo4aVflD0=;
        b=pOBlQYYQ8c0xxVDBMuBOUH+n+5dQ7OBzcbqGFnZ1s/4t0KsT2aaCrdm2xnApfu5NuU
         Yp3bdzMcnD3XLMStBmLzs0QinA11ziVsTbO8iOWS/KtL7OS/EpbJtbfLkj0d0GVL+e9j
         b90fwwxfvlE25Q0ku2VNizkJnTj/3MCEfqsyj7StN8ggHIZndRBAfpEYfogv3+SVkCRo
         5FX36oGIQcVraUmpCcrLBwNIe0mVhNW2R3giBHeK34AGiK6RYAkkcFa0XDx0wqp1gV12
         RbfdWS/tWAEWfl9um5MzaZupyHPVoPXGqaoUe1+yYYmZ1loBtRCIRqN/Xjcqjpqs+U3m
         SiOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=WABPoDum;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=L+TXsrTp;
       spf=pass (google.com: domain of prvs=6124e0dd9=bart.vanassche@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=6124e0dd9=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=WABPoDum;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=L+TXsrTp;
       spf=pass (google.com: domain of prvs=6124e0dd9=bart.vanassche@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=6124e0dd9=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,345,1517846400";
   d="scan'208";a="74257911"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: Ohad Sharabi <Ohad.Sharabi@wdc.com>, "jejb@linux.vnet.ibm.com"
	<jejb@linux.vnet.ibm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Stanislav Nijnikov
	<Stanislav.Nijnikov@wdc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: Re: [PATCH v2] scsi: ufs: add trace event for ufs upiu
Thread-Topic: [PATCH v2] scsi: ufs: add trace event for ufs upiu
Thread-Index: AQHTwdQlIez90vp46E6BkQ3R1fdF+qPcTNKA
Date: Thu, 22 Mar 2018 14:15:34 +0000
Message-ID: <562b08c355de2fe594b0a236172f43289154a6e7.camel@wdc.com>
References: <1521719439-2251-1-git-send-email-ohad.sharabi@sandisk.com>
In-Reply-To: <1521719439-2251-1-git-send-email-ohad.sharabi@sandisk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0897;7:IPs3BCgSWZRYnyQxG1ejIHOpNxHPoJerbhA7TtwTfZWZuPjXpdw/r1N7c7ktRIVNcp0l8nhF26p97JPbPfrU6bdRiiBWyPibfxqGPrYWwGhDnI7zZpHbagKtE7YdoOrkHDU0yZ/s1tQuavuve7hGOe6P45v51NNR8d9Hm341xV5ezZWI1IaHI/6VeFX9ptVFZK1DDaRiF0pquy15fNrYLuQyorcrlMLfKH7J/a6zVT1Hi1rnhLWqHlxOqGNlxGEL;20:C3RuSd9hB01CBSUlZW9l49qMUdrX6cED6W5Vjj0/Z6pf6JHeKjXCdB8xD3EY0HZ2sNAp0PwfzUQvNhwpKFZJoekog3/xbxXK9z5bwIXpd2dF+VamzX6DclvFMG99OvvkvGE2cq4Aoe9RzWt/Evuq+AJ+3qkbGQfHg+mv3oRdHZ0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3d271c2-ced5-4ff5-7268-08d58fff60fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0897;
x-ms-traffictypediagnostic: MWHPR04MB0897:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0897CA60F5CD31D6A2355D5A98A90@MWHPR04MB0897.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0897;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0897;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(377424004)(199004)(189003)(102836004)(6246003)(4326008)(97736004)(316002)(5250100002)(6506007)(105586002)(6486002)(106356001)(68736007)(99286004)(2950100002)(2201001)(446003)(36756003)(2900100001)(6116002)(3846002)(26005)(76176011)(3660700001)(2906002)(86362001)(25786009)(53936002)(305945005)(110136005)(54906003)(478600001)(7736002)(229853002)(5660300001)(2501003)(72206003)(66066001)(14454004)(6512007)(8676002)(3280700002)(81166006)(118296001)(6436002)(8936002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0897;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hNaSkwNBPBmMrmtDvpexuDi3gsYszu6yXU88xaPhI8pifgIG9irRVNsEHpv91bBBVbxdGSh/a6WBmVNYv6QU4JaecVxEFqFcAF8bP7WibfE4Yd056JQSrHNtlpYxaFr4cW8LKmcMK9J+UIOt/CXgeSdKx3AaDSyw3NoA4Z2883HvArhFth6gwglqOiJZP1eLaLtU7pXKuPkirIwoQhQ3qkoaepzLr7r2JQTPwIDnndX8NdWdWXSE8PROOqZhSrl2ibneDaGFn41HUno8nrHkj4pReoB1fz0GSV2MhHBPmF8Inwd17yKqpuYEcAICj8yqtWAoHqaCh5O1OmaKGZ8Muw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EE5CF9BD7C0F042AAEA7D18E66581B8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d271c2-ced5-4ff5-7268-08d58fff60fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 14:15:34.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0897
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595638490486239521?=
X-GMAIL-MSGID: =?utf-8?q?1595647603674082626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTIyIGF0IDEzOjUwICswMjAwLCBPaGFkIFNoYXJhYmkgd3JvdGU6DQo+
ICtzdGF0aWMgdm9pZCB1ZnNoY2RfYWRkX2NtZF91cGl1X3RyYWNlKHN0cnVjdCB1ZnNfaGJhICpo
YmEsIHVuc2lnbmVkIGludCB0YWcsDQo+ICsJCWNvbnN0IGNoYXIgKnN0cikNCj4gK3sNCj4gKwlz
dHJ1Y3QgdXRwX3VwaXVfcmVxICpycSA9IGhiYS0+bHJiW3RhZ10udWNkX3JlcV9wdHI7DQo+ICsN
Cj4gKwl0cmFjZV91ZnNoY2RfdXBpdShkZXZfbmFtZShoYmEtPmRldiksIHN0ciwgKHU4ICopJnJx
LT5oZWFkZXIsDQo+ICsJCQkodTggKikmcnEtPnNjLmNkYik7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyB2b2lkIHVmc2hjZF9hZGRfcXVlcnlfdXBpdV90cmFjZShzdHJ1Y3QgdWZzX2hiYSAqaGJhLCB1
bnNpZ25lZCBpbnQgdGFnLA0KPiArCQljb25zdCBjaGFyICpzdHIpDQo+ICt7DQo+ICsJc3RydWN0
IHV0cF91cGl1X3JlcSAqcnEgPSBoYmEtPmxyYlt0YWddLnVjZF9yZXFfcHRyOw0KPiArDQo+ICsJ
dHJhY2VfdWZzaGNkX3VwaXUoZGV2X25hbWUoaGJhLT5kZXYpLCBzdHIsICh1OCAqKSZycS0+aGVh
ZGVyLA0KPiArCQkJKHU4ICopJnJxLT5xcik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHVm
c2hjZF9hZGRfdG1fdXBpdV90cmFjZShzdHJ1Y3QgdWZzX2hiYSAqaGJhLCB1bnNpZ25lZCBpbnQg
dGFnLA0KPiArCQljb25zdCBjaGFyICpzdHIpDQo+ICt7DQo+ICsJc3RydWN0IHV0cF90YXNrX3Jl
cV9kZXNjICpkZXNjcDsNCj4gKwlzdHJ1Y3QgdXRwX3VwaXVfdGFza19yZXEgKnRhc2tfcmVxOw0K
PiArCWludCBvZmYgPSAoaW50KXRhZyAtIGhiYS0+bnV0cnM7DQo+ICsNCj4gKwlkZXNjcCA9ICZo
YmEtPnV0bXJkbF9iYXNlX2FkZHJbb2ZmXTsNCj4gKwl0YXNrX3JlcSA9IChzdHJ1Y3QgdXRwX3Vw
aXVfdGFza19yZXEgKilkZXNjcC0+dGFza19yZXFfdXBpdTsNCj4gKwl0cmFjZV91ZnNoY2RfdXBp
dShkZXZfbmFtZShoYmEtPmRldiksIHN0ciwgKHU4ICopJnRhc2tfcmVxLT5oZWFkZXIsDQo+ICsJ
CQkodTggKikmdGFza19yZXEtPmlucHV0X3BhcmFtMSk7DQo+ICt9DQoNCkNhbiB0aGUgdHJhY2Vf
dWZzaGNkX3VwaXUoKSBkZWZpbml0aW9uIGJlIGNoYW5nZWQgc3VjaCB0aGF0IHRoZSB0aGlyZCBh
bmQNCmZvdXJ0aCBhcmd1bWVudCBhcmUgZGVjbGFyZWQgYXMgJ3ZvaWQgKicgc3VjaCB0aGF0IHRo
ZSB1Z2x5ICcodTggKiknIGNhc3RzDQpjYW4gYmUgbGVmdCBvdXQgZnJvbSB0aGUgY2FsbGVycz8N
Cg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg==
