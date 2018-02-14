Return-Path: <prvs=576cf723c=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AH8x224JqVZAom4zkCV3O0tlPxf/uHSgJnt8SgPB90w0P/dghyZjq0YPnXmqFh8tOk1kLPEqJ7S/
ARC-Seal: i=1; a=rsa-sha256; t=1518624233; cv=none;
        d=google.com; s=arc-20160816;
        b=03bX3KCnuCWvoJ2//9MO9wE1TmqV9rukywoV4r3fZBupO44D//vS0DBDp4B4XXHEM1
         gjWE1rfzjL8ocZrxuAb6UJd+RBEFg2MjdME8BMNmyyomlzPKTfKONRmiek2UqLd7lXDS
         Z6CrfZpxS0qWyKsao6xtwX/tFuCxwGKjB4k3rrgBO5AGRaFwwZhNn6Jsfn/OzqS+qbX0
         v7UpPefDhToCLnjbUIskaLOYzygAKRA0Jjqezs8FmEzhfKuMGEAlwWcmYYJkiLbDSPeP
         o0hv12kM3Moobywc3Pr8InDJtHcmV8KvW8oPgRKLFqcO9Amek4smxUrwlR9XVr1oUfxo
         IoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=K3fc6sUBvBGdbhk/APXTyS2rzHLgznOWus/vyaueHHE=;
        b=nzQUrqXcamG5Ta26KVorjMvWOuE30L4tJXgu6+g3W1Grr903UicagA3VRl0XnhS7mI
         R601DGeYZN1uoXQalyH5FitfoH1xZOw/a7pvsA6P9EpDJAVppy4Xdew95d+JKIEQvWAA
         w7fb7fXf6YnwTgTDX/tOImopjctv5j5Sqd/AER0bnHtlB8RboDtJJ1cisXTvEFbkuHC8
         OJj4m8sKBjsLBSzrHOBKtG68SQS7Sd+36WS4sQVC59WlMwF6OF6s+En2oVAEXkhOEvgM
         5TIDaAfao7mJZeFTxs9/S+rv6oO2BVLkTnVVUGNwvtHZTM/nD+hmqgEiH006SLsj2l5w
         7hmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=I2EyGiaO;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=c1qjID5+;
       spf=pass (google.com: domain of prvs=576cf723c=bart.vanassche@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=576cf723c=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=I2EyGiaO;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=c1qjID5+;
       spf=pass (google.com: domain of prvs=576cf723c=bart.vanassche@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=576cf723c=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,513,1511798400";
   d="scan'208";a="167794222"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>, "jthumshirn@suse.de"
	<jthumshirn@suse.de>, "khandual@linux.vnet.ibm.com"
	<khandual@linux.vnet.ibm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] lib/scatterlist: Add SG_CHAIN and SG_EMARK macros for LSB
 encodings
Thread-Topic: [PATCH] lib/scatterlist: Add SG_CHAIN and SG_EMARK macros for
 LSB encodings
Thread-Index: AQHTpVBx38sy6hLFK0mjzDio9eCz1qOkECoA
Date: Wed, 14 Feb 2018 16:03:49 +0000
Message-ID: <1518624228.3147.4.camel@wdc.com>
References: <20180214045804.9113-1-khandual@linux.vnet.ibm.com>
In-Reply-To: <20180214045804.9113-1-khandual@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1420;7:ZpE+m5ZSfG1ECGSbHphBYtphYh+J/13CRGLiSnNxuejawdl3LcE1NUudwXzbp1CfQSPKQDo8ZctYilXPaqdRwNZlKZfOSHZSi0kOz0k4aDZHGD9Ojdc1dw1EXHYnVG3FQ4+YAgbi6oGRyFidTUOPMcp0/LykA5Vs6siBGkqB2VdWy1k5WpsGtk7GPxd3LmKbSSEV8YNLffJurmXbxWsJUk2Vaj49eGgU72pfqBdCO+e0eVPgDGXDoFvQgTEihjcm;20:lKe7tM1iBdfaO8IiDGrmigk+QQXEeb2i2WkxDp0RkriqL2TYgpp5ZGCQCHOFqKdISQaX3ePhvheQF/bh21+Ku7GS8eLmshuvo6Bdamo60BwzjXGzxjx7GrpFBA8ZHhzkxNoBpHM9GfUUPTnE4Vm37vm53zp5sWSdgu0kmO5TQwc=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e99d44a-08d9-4948-e755-08d573c48902
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1420;
x-ms-traffictypediagnostic: CY1PR0401MB1420:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1420A99AF1C323163CCABAEE98F50@CY1PR0401MB1420.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR0401MB1420;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1420;
x-forefront-prvs: 0583A86C08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(366004)(39380400002)(396003)(377424004)(189003)(199004)(68736007)(2501003)(66066001)(110136005)(105586002)(26005)(102836004)(103116003)(2906002)(7736002)(3280700002)(186003)(316002)(76176011)(77096007)(6506007)(36756003)(305945005)(2900100001)(6486002)(8676002)(478600001)(14454004)(72206003)(106356001)(25786009)(81156014)(8936002)(575784001)(97736004)(86362001)(2201001)(81166006)(229853002)(2950100002)(53936002)(5660300001)(6436002)(6116002)(6246003)(6512007)(99286004)(3846002)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1420;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cCOa3KUborpJmDjDpxPclnHuXwkRUSipCzvxYDKH2rjI5MhWuJSFV0tuCm2VwEAOly/z7ZJiCXMTbgw5WO+6Iw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DB90AFE2DB40C448D6876F09980D087@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e99d44a-08d9-4948-e755-08d573c48902
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2018 16:03:49.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1420
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592351049846277975?=
X-GMAIL-MSGID: =?utf-8?q?1592392924640113756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gV2VkLCAyMDE4LTAyLTE0IGF0IDEwOjI4ICswNTMwLCBBbnNodW1hbiBLaGFuZHVhbCB3cm90
ZToNCj4gKyNkZWZpbmUgU0dfQ0hBSU4JMHgwMQ0KPiArI2RlZmluZSBTR19FTUFSSwkweDAyDQoN
CkhlbGxvIEFuc2h1bWFuLA0KDQpBcyB5b3UgcHJvYmFibHkga25vdyBjb25zdGFudHMgdGhhdCBk
byBub3QgaGF2ZSBhIHN1ZmZpeCBhcmUgb2YgdHlwZSBpbnQuIFBsZWFzZQ0KY29uc2lkZXIgdG8g
YWRkIHN1ZmZpeCAiVUwiIHRvIHRoZXNlIGNvbnN0YW50cyB0byBhdm9pZCB0aGF0IHRoZSBjb21w
aWxlciBjb3VsZA0KdGFrZSBhbiB1bmRlc2lyZWQgZGVjaXNpb24gd2hlbiBlLmcuIGNvbnZlcnRp
bmcgflNHX0NIQUlOIGZyb20gaW50IHRvIHVuc2lnbmVkDQpsb25nLg0KDQpUaGFua3MsDQoNCkJh
cnQu
