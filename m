Return-Path: <kernel-hardening-return-12345-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu/KLxHLxn5ZKvfcsYuQ2y9zE7wEZl05SATY1utdt6X/s6EKbWVOmHrsvCzo+ZWYFGhQbTC
ARC-Seal: i=1; a=rsa-sha256; t=1520636051; cv=none;
        d=google.com; s=arc-20160816;
        b=0sqs63dDX+DXn4ftrrr4jJttDCEHBZHr/ziJRQ1Mf2RJLjuIxxpZ9p9hwTqD9LLHgF
         Efnuc7zX0RFVUGx7wZqptB6hute6vrGvUe5O/lF2Lbcou/UZMYhfsl3rldTgiU9egp+d
         lqGW6YQrrgnCfTeD88yTobcqSPb1lIixWW7Q4ZRYdHMmGJAlnt7mQOFXtWbfbWox3HK2
         hy+W36UL2fUDMdP2Y/SRCCjp9RbT8tXo0O0xT4yZPd+SG2yw8zp/3Vxu/fDgapfzQgOW
         TTf5+rg/f9aLqlO+7wvqzkVH/aIUGs7NDdqZBPgq6Zpz+cWiYq1nkkD16aUGTUPeE0JF
         bFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=pf79hTg4XJuvWu7L35x/Gg76Dkin6zdtzGUlj15KR18=;
        b=vXiqt+GGAdQRRwMFbAZ5psTToC9xNh92ljR545SO0d9LEZrf+F3sH3dlKp2jjVH/zq
         /3HPccQHiDp9tUuxINgOdmb8Jg1B0NCPVraDMnGuILyE0LeWTxYNEPrH3rhJgCkwvLjb
         FIi+SAOY5aojAfmzgqDap7w0TNwea91oWcQfl9LvyqphiR3uE72NG3nI7JvsX9/+R3DC
         FZJdonQ8BRmNXynxGE3UDH/F4YF6Si8L2MGY84BKo2PT/m0DuTFMLNZBLmwcaoQ1PPyl
         OoGI8Sawp3e2KtR2ndE/DYFNtx2RfX+j2PZ91lJNsPB1T6ND481wsvysoRSVo5UyA3+r
         S7BA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=LmBsVsRY;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=lMq07zHt;
       spf=pass (google.com: domain of kernel-hardening-return-12345-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12345-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=LmBsVsRY;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=lMq07zHt;
       spf=pass (google.com: domain of kernel-hardening-return-12345-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12345-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,447,1515427200";
   d="scan'208";a="73855298"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>, "steve@sk2.org"
	<steve@sk2.org>, "hare@suse.com" <hare@suse.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] scsi: resolve COMMAND_SIZE at compile time
Thread-Topic: [PATCH] scsi: resolve COMMAND_SIZE at compile time
Thread-Index: AQHTt/a++gGYLFA/xEyD9ZESx+8zoqPIgTGA
Date: Fri, 9 Mar 2018 22:47:12 +0000
Message-ID: <1520635631.2907.16.camel@wdc.com>
References: <20180309232933.14e39858@heffalump.sk2.org>
	 <20180309223355.21222-1-steve@sk2.org>
In-Reply-To: <20180309223355.21222-1-steve@sk2.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0366;7:tY/MAs+pBXBQHx561vk0LEHhuTHaiCZlganLFOYncj4NmGIC7Zan64WqRTKJXzaMvmiI6vcvUHiE5cTPdh2sLb4l9sukht+8sNdEbFNrqoe4pPsfczUwTl/FGx6ceTY4ehxgTNwh424/ESL9lgLWIZnZYxAoaiSTQldJT6fVLhcisT6rF/ssXwF0WxEKwEcoFyvFmw/d3hxd4CWZdDi9oNbezWERTVaBHr5Ftx3hiV9bmrjZ2PWsG20Qp3MzfvId;20:eKquqhSDhUWziZ8qkjfg/q0Lmrwjhe+8fVxwXiumfXQJr26q90l/ad8sDtMr3ZvrWfpH3tMod11JJyIpNjgX3e5QsI1ghhSOkSQSmmQvgTC8N2g7bbIZ9+7nU1Io/qy7HrA23MCW6emquWh/LXrVUm6JveWc/KVjgpt4Ng79Ekg=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d193a54-4e48-4ea6-fbea-08d5860fb314
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0366;
x-ms-traffictypediagnostic: MWHPR04MB0366:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB03664BF6F6D0BFF6064A219698DE0@MWHPR04MB0366.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0366;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0366;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(39860400002)(346002)(366004)(377424004)(189003)(199004)(2900100001)(7736002)(68736007)(6116002)(86362001)(97736004)(2201001)(103116003)(3846002)(305945005)(8676002)(81156014)(72206003)(81166006)(26005)(3660700001)(6436002)(102836004)(59450400001)(6506007)(8936002)(478600001)(6486002)(186003)(106356001)(76176011)(54906003)(6246003)(110136005)(2906002)(99286004)(105586002)(3280700002)(5660300001)(25786009)(53936002)(6512007)(316002)(2950100002)(2501003)(66066001)(36756003)(4326008)(5250100002)(14454004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0366;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xkVP2DIB4xwe7YRChpPQcOZUIqLAqzZUVltI/cvB7yks20RLZFAB0P9c4LCd405sJECFS3j6tc06SCdPm6rPcxQgB4WAkj9tBWH3i9wDTW57GgPS0Qw3Fqfl3spfWue8mJg4EloZap6kcURul5w8kt7VUiZzOHyZHDYUVjonzDEgE12J4CFisyxgj3sYH/B1VpUpVpeSa/a+eXUjRppp5vupJQ7cGILkrX7XTHkWpMabG9YkQbLFMxp0RifwzN8xFdAxWxqvctEd5lcziXixNsQqKTsHOJTb16y4QXgrwnq2DMJF06sqHNlpfJWsA20amwJIOGzKHT3LIhmh+y+EAw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <965C3C37A5D2914BB97304BF9154AC16@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d193a54-4e48-4ea6-fbea-08d5860fb314
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 22:47:12.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0366
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501214170730131?=
X-GMAIL-MSGID: =?utf-8?q?1594502468112176075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCAyMDE4LTAzLTA5IGF0IDIzOjMzICswMTAwLCBTdGVwaGVuIEtpdHQgd3JvdGU6DQo+
ICsvKg0KPiArICogU0NTSSBjb21tYW5kIHNpemVzIGFyZSBhcyBmb2xsb3dzLCBpbiBieXRlcywg
Zm9yIGZpeGVkIHNpemUgY29tbWFuZHMsIHBlcg0KPiArICogZ3JvdXA6IDYsIDEwLCAxMCwgMTIs
IDE2LCAxMiwgMTAsIDEwLiBUaGUgdG9wIHRocmVlIGJpdHMgb2YgYW4gb3Bjb2RlDQo+ICsgKiBk
ZXRlcm1pbmUgaXRzIGdyb3VwLg0KPiArICogVGhlIHNpemUgdGFibGUgaXMgZW5jb2RlZCBpbnRv
IGEgMzItYml0IHZhbHVlIGJ5IHN1YnRyYWN0aW5nIGVhY2ggdmFsdWUNCj4gKyAqIGZyb20gMTYs
IHJlc3VsdGluZyBpbiBhIHZhbHVlIG9mIDE3MTU0ODgzNjINCj4gKyAqICg2IDw8IDI4ICsgNiA8
PCAyNCArIDQgPDwgMjAgKyAwIDw8IDE2ICsgNCA8PCAxMiArIDYgPDwgOCArIDYgPDwgNCArIDEw
KS4NCj4gKyAqIENvbW1hbmQgZ3JvdXAgMyBpcyByZXNlcnZlZCBhbmQgc2hvdWxkIG5ldmVyIGJl
IHVzZWQuDQo+ICsgKi8NCj4gKyNkZWZpbmUgQ09NTUFORF9TSVpFKG9wY29kZSkgXA0KPiArCSgx
NiAtICgxNSAmICgxNzE1NDg4MzYyID4+ICg0ICogKCgob3Bjb2RlKSA+PiA1KSAmIDcpKSkpKQ0K
DQpUbyBtZSB0aGlzIHNlZW1zIGhhcmQgdG8gcmVhZCBhbmQgaGFyZCB0byB2ZXJpZnkuIENvdWxk
IHRoaXMgaGF2ZSBiZWVuIHdyaXR0ZW4NCmFzIGEgY29tYmluYXRpb24gb2YgdGVybmFyeSBleHBy
ZXNzaW9ucywgZS5nLiB1c2luZyBhIGdjYyBzdGF0ZW1lbnQgZXhwcmVzc2lvbg0KdG8gZW5zdXJl
IHRoYXQgb3Bjb2RlIGlzIGV2YWx1YXRlZCBvbmNlPw0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0K
