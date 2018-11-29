Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD9DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D7620863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zk0Vu9Hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D7620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeK2UIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:08:39 -0500
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:38912
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbeK2UIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTXKAPS8AXIw/1Dum807Qsby5ESg++p9mzB2IUhyVfg=;
 b=Zk0Vu9HiZoI0vpA1oub8zAGcGKWJaeRg4BtNc6Y834HafDXJRMd5dwUwHlw4mHe5I1mDGsZI/lSa5TPXuF61ldSD+PDGxKiHer+NtGuJTv71Jwacbqmm3OSYD5hgVclLrT4FZdqK2gZloiVyh9upNUzwq2DKOpctV9YOa6UOvTQ=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3308.eurprd08.prod.outlook.com (52.134.111.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 29 Nov 2018 09:03:54 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::971:f108:751f:a081]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::971:f108:751f:a081%4]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 09:03:54 +0000
From:   Julien Thierry <Julien.Thierry@arm.com>
To:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        Will Deacon <Will.Deacon@arm.com>
CC:     "natechancellor@gmail.com" <natechancellor@gmail.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Thread-Topic: [PATCH] arm64: io: specify asm operand width for __iormb()
Thread-Index: AQHUh5rAykmq/+nCSEOkS4p2mAlMzaVmdbAA
Date:   Thu, 29 Nov 2018 09:03:54 +0000
Message-ID: <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
In-Reply-To: <20181129041912.5918-1-nick.desaulniers@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::33) To DB7PR08MB3082.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Julien.Thierry@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3308;6:c9S+hRGOfJTugMrBgFqnE0C7gS7XHttH6TbmkjixeSZp11mIVdo3asSoZNvtXhStYNXk+eDyCT/sBmmjdDqmScU6SHD1oAqDBEUHo/TjH889mJx7H1yKWlchnFTOKmoWRDdMAgTQisVlapekFbdwj+X8LWTgMKnalb+EWM8LLhB3yrXKnar+hrZMoiD1fHzyyQQCITe170c9I06RWRTBLJEg32Chk45tV29bX5BUJ9WXz1W/tRJoWHPujEVZ+enYM8/KLQNrvi2/Kf+3HOa5TV+jbYamMCupuU2S62iZ8vSUYNPCD9pFS8yxLf3cx8cL0IzpCwLY8DL/lrMYeeo0jTXld2yMWm+rnt50HEYBDfa/qR3pwiFqV3/XTp5uJId+Pht2befaf6qBlyNCX+G5ZQ5x7beYr8ug5yMyHKlauQoc+3XT12Q4+aUnxsC2Fs5zHeDgPDq8+ScaROr+Hi5kkg==;5:tgNoYsdGdlrssmNDeNiHxeEDSuiAipUxhuOS+hiwZRg4o7Vafoq0sFQsy9nSGCNmfHnNuLhAXibm06duY5PGJWxrR4RUfmsyyIQnmF+3INhzMpQBn9ZSz5SZyDkVpp8xyOemwqJZ70MCg1woV80kviL/cFRk/bhDNWcX6cm2W0U=;7:Ew1nGisp6lfSg1H0MiPJNh9k2KVoLEXj1ycGt/8NxYrVcXlR9wiNNOeXbxC+6+n1Ows6CNWJMNUG/HpHgbkOnt6/N5XZVLNysPfHJ1yfYkwTh8R7rwLyB9Yct3H2GCRQDV+kix+BMMdn2KcJCAPyHA==
x-ms-office365-filtering-correlation-id: 6a66647c-4863-4f53-5bef-08d655d996a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3308;
x-ms-traffictypediagnostic: DB7PR08MB3308:
x-microsoft-antispam-prvs: <DB7PR08MB33082CCE5CC10F56B68894369DD20@DB7PR08MB3308.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3308;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3308;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(40434004)(199004)(189003)(6486002)(52116002)(76176011)(68736007)(229853002)(386003)(53546011)(6506007)(14454004)(316002)(256004)(5024004)(14444005)(66066001)(81156014)(186003)(3846002)(6116002)(71190400001)(71200400001)(81166006)(8676002)(8936002)(26005)(6306002)(6512007)(53936002)(6246003)(6436002)(39060400002)(966005)(99286004)(72206003)(102836004)(6636002)(478600001)(36756003)(305945005)(7736002)(4326008)(44832011)(11346002)(446003)(486006)(476003)(2616005)(105586002)(31686004)(25786009)(31696002)(97736004)(5660300001)(106356001)(54906003)(110136005)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3308;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C5u+n551irOeQTikWH5XBFk0ys5jPgN8FPEk9SrfQoTbgjwFy+H3i9CJl1iK2AAzwzK/qcSDrLqjmGlG+1Bp9IAVEK2fXu5CTCuR6ZfXSsAjNuuIxSKAzALsfgEjCKnk5F0KrSYDwUI5KcGggoaiyFz7HZkrEkTDeaDLrcN631YbVYrPcM6xQfX0hvrMHx7MALqwes0r7dYM/DsW7sYkB7glEaipAvqVWrFytTFPrD7pRlOGpvppAE3MjI8OxlPh6eqFp3iQ65XRYkkbhQB100aKaAUirKKNRkfBWqX1AzRjDBwMZhiVMkLqUTPtMr6MGsN5Z8Q1IDnrB5H3BAcEyzUGHgualQafylSratAQx0k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9F25328C0A05D4DB5E20D261E0F628C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a66647c-4863-4f53-5bef-08d655d996a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 09:03:54.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI5LzExLzE4IDA0OjE5LCBOaWNrIERlc2F1bG5pZXJzIHdyb3RlOg0KPiBGaXhlcyB0
aGUgd2FybmluZyBwcm9kdWNlZCBmcm9tIENsYW5nOg0KPiAuL2luY2x1ZGUvYXNtLWdlbmVyaWMv
aW8uaDo3MTE6OTogd2FybmluZzogdmFsdWUgc2l6ZSBkb2VzIG5vdCBtYXRjaA0KPiByZWdpc3Rl
ciBzaXplIHNwZWNpZmllZCBieSB0aGUgY29uc3RyYWludCBhbmQgbW9kaWZpZXINCj4gWy1XYXNt
LW9wZXJhbmQtd2lkdGhzXQ0KPiAgICAgICAgIHJldHVybiByZWFkbChhZGRyKTsNCj4gICAgICAg
ICAgICAgICAgXg0KPiAuL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaW8uaDoxNDk6NTg6IG5vdGU6
IGV4cGFuZGVkIGZyb20gbWFjcm8gJ3JlYWRsJw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAuL2luY2x1ZGUvYXNtLWdlbmVy
aWMvaW8uaDo3MTE6OTogbm90ZTogdXNlIGNvbnN0cmFpbnQgbW9kaWZpZXIgInciDQo+IC4vYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9pby5oOjE0OTo1MDogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNy
byAncmVhZGwnDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXg0KPiAuL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaW8uaDoxMTg6MjU6IG5vdGU6IGV4
cGFuZGVkIGZyb20gbWFjcm8gJ19faW9ybWInDQo+ICAgICAgICAgYXNtIHZvbGF0aWxlKCJlb3Ig
ICAgICAgJXcwLCAlMSwgJTFcbiIgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXg0KDQpXaHkgZG9lcyB0aGUgImVvciAlMCwgJTEsICUxIiBiZWNvbWUgImVvciAldzAs
ICUxLCAlMSIgPw0KVGhlIHZhcmlhYmxlIHBhc3NlZCB0byB0aGUgaW5saW5lIGFzc2VtYmx5IGZv
ciAlMCBpcyB1bnNpZ25lZCBsb25nLCBzbw0KYWx3YXlzIDY0LWJpdHMgd2lkZSBvbiBhcm02NC4g
V2h5IGlzIGNsYW5nIHRyeWluZyB0byB1c2UgYSAzMi1iaXQNCnJlZ2lzdGVyIGZvciBpdD8NCg0K
QWx0aG91Z2ggaXQncyBub3QgcmVhbGx5IGltcG9ydGFudCBzaW5jZSBhbGwgdGhpcyBpcyBqdXN0
IGludHJvZHVjaW5nIGENCmNvbnRyb2wgZGVwZW5kZW5jeSwgSSBmaW5kIGl0IGEgYml0IG9kZC4N
Cg0KVGhhbmtzLA0KDQo+IFRob3VnaCB3ZSBkaXNhYmxlIENsYW5nJ3MgaW50ZWdyYXRlZCBhc3Nl
bWJsZXIgd2l0aCAtbm8taW50ZWdyYXRlZC1hcywNCj4gaXQgc3RpbGwgdHJpZXMgdG8gZG8gc29t
ZSB2YWxpZGF0aW9uIG9mIGFzc2VtYmxlciBjb25zdHJhaW50cy4NCj4NCj4gV2hpbGUgX19pb3Jt
YigpIGlzIHR5cGUgYWdub3N0aWMgdG8gb3BlcmFuZCB3aWR0aHMgZm9yIGFyZ3VtZW50IHYsIGl0
cw0KPiBsb25lIHVzZSBpcyB0byB6ZXJvJ2Qgb3V0IHZpYSBlb3IgKGV4Y2x1c2l2ZSBvcikuDQo+
DQo+IEZpeGVzIGNvbW1pdCA2NDYwZDMyMDE0NzEgKCJhcm02NDogaW86IEVuc3VyZSBjYWxscyB0
byBkZWxheSByb3V0aW5lcw0KPiBhcmUgb3JkZXJlZCBhZ2FpbnN0IHByaW9yIHJlYWRYKCkiKQ0K
PiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vQ2xhbmdCdWlsdExpbnV4L2NvbnRpbnVvdXMtaW50
ZWdyYXRpb24vaXNzdWVzLzc4DQo+IFN1Z2dlc3RlZC1ieTogTmF0aGFuIENoYW5jZWxsb3IgPG5h
dGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE5hdGhhbiBDaGFuY2VsbG9y
IDxuYXRlY2hhbmNlbGxvckBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE5pY2sgRGVzYXVs
bmllcnMgPG5pY2suZGVzYXVsbmllcnNAZ21haWwuY29tPg0KPiAtLS0NCj4gU2lkZSBub3RlOiBp
cyBpdCBub3QgY29ycmVjdCB0byBjaXRlIFNIQXMgZnJvbSBsaW51eC1uZXh0IGluICJGaXhlcw0K
PiBjb21taXQgLi4uIiBsaW5lcz8gSSBndWVzcyB3ZSBjYW4gZHJvcCBpdC4NCj4NCj4gTGluayB0
byByZWdyZXNzaW9uIGJ1aWxkOg0KPiBodHRwczovL3RyYXZpcy1jaS5jb20vQ2xhbmdCdWlsdExp
bnV4L2NvbnRpbnVvdXMtaW50ZWdyYXRpb24vYnVpbGRzLzkyNzk5OTM4DQo+DQo+IExpbmsgdG8g
YnVpbGQgdy8gdGhpcyBwYXRjaDoNCj4gaHR0cHM6Ly90cmF2aXMtY2kuY29tL0NsYW5nQnVpbHRM
aW51eC9jb250aW51b3VzLWludGVncmF0aW9uL2J1aWxkcy85MjkzNTkwMQ0KPg0KPg0KPiAgYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9pby5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL2lvLmggYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2lvLmgNCj4gaW5kZXggZDQy
ZDAwZDhkNWI2Li5kYmRlYmY4MTE2MmIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVk
ZS9hc20vaW8uaA0KPiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2lvLmgNCj4gQEAgLTEx
NSw3ICsxMTUsNyBAQCBzdGF0aWMgaW5saW5lIHU2NCBfX3Jhd19yZWFkcShjb25zdCB2b2xhdGls
ZSB2b2lkIF9faW9tZW0gKmFkZHIpDQo+ICAgKiBsYXRlciBpbnN0cnVjdGlvbnMuIFRoaXMgZW5z
dXJlcyB0aGF0IGEgc3Vic2VxdWVudCBjYWxsIHRvXA0KPiAgICogdWRlbGF5KCkgd2lsbCBiZSBv
cmRlcmVkIGR1ZSB0byB0aGUgSVNCIGluIGdldF9jeWNsZXMoKS5cDQo+ICAgKi9cDQo+IC1hc20g
dm9sYXRpbGUoImVvciUwLCAlMSwgJTFcbiJcDQo+ICthc20gdm9sYXRpbGUoImVvciUwLCAleDEs
ICV4MVxuIlwNCj4gICAgICAgImNibnolMCwgLiJcDQo+ICAgICAgIDogIj1yIiAodG1wKSA6ICJy
IiAodikgOiAibWVtb3J5Iik7XA0KPiAgfSkNCj4NCg0KLS0NCkp1bGllbiBUaGllcnJ5DQpJTVBP
UlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBp
bW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIg
cGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZv
cm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
