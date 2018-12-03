Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FB920848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FB920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbeLCFsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:48:25 -0500
Received: from mail-eopbgr720073.outbound.protection.outlook.com ([40.107.72.73]:27568
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbeLCFsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bE93gDTgOuROcJAvSdtnLp5vlTpi9226L1pEy6Jh5U=;
 b=OfUoP2FxzgrvXzDcw/oKoMbiveeSsPiRGWOWaM448kmq46PnYzgbQ49kFi96QV8cws16i9PuyIvgM15HZB9teQYgXzt7ByePHRXGyp3KNyzMupY2y9rwPhMBNGsBTg2HKHv+ZRJ4iJMmsi8I8nOFkeWAz3trd/4JYgfjgB286cs=
Received: from MW2PR07MB4042.namprd07.prod.outlook.com (52.132.179.25) by
 MW2PR07MB4075.namprd07.prod.outlook.com (52.132.179.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Mon, 3 Dec 2018 05:48:19 +0000
Received: from MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::142a:233e:11c3:4c4f]) by MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::142a:233e:11c3:4c4f%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 05:48:18 +0000
From:   "Rangankar, Manish" <Manish.Rangankar@cavium.com>
To:     Thomas Meyer <thomas@m3y3r.de>,
        Dept-Eng QLogic Storage Upstream 
        <QLogic-Storage-Upstream@cavium.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: qla4xxx: NULL check before some freeing functions
 is not needed.
Thread-Topic: [PATCH] scsi: qla4xxx: NULL check before some freeing functions
 is not needed.
Thread-Index: AQHUioFbd34D3PMMF06jbupx7I6UuaVsglAg
Date:   Mon, 3 Dec 2018 05:48:18 +0000
Message-ID: <MW2PR07MB40423AF3041595F2DC4840F2E3AE0@MW2PR07MB4042.namprd07.prod.outlook.com>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
 <1543760930052-1104447559-14-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930052-1104447559-14-diffsplit-thomas@m3y3r.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Manish.Rangankar@cavium.com; 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB4075;6:ndkVcw09HphvJdCkCcfW6+ZNFHe6knKyy6rSaVCtft2eHZd7dqU17YhGvdTWssj/n8B8NZR59c7T91XbwMieYr7R+8d6627CvtgakDX0ICOtXR2XEDosCw+g9ZuCr0JUeq8EzsuMBKe0MFc+bma5Bi+JWUbtbdemlrdi7b2z8w11j5DCmpY4EmmLM3bfSiEBMaoL2mHGctafRHzGmIi3Lsym9LPktxyPlsxXkkGh6zi0lMVy4fzUSS3z7qWCNd5dS1XUCuXehT6qoSriXKun5CwHC6M9fvOqbiVZLmRgtA5SNAcg11pyAiy9yRHLISgxLwl4jbytfaD1dkj19K5JUQ7B2PiHDRVB1hcoD8kiQ+LOkgw3l0gB3nsRrKAYjQsztFLYjCqNXwjTDFsrBH6719VEm3Ldbi1GSLJ4N0bkaomDXACO6HMx+9RuIZjRuOzTPYfRxXS0vU8Zx2iw3vFOsA==;5:FFS7KgZAEAeKl5chT6zlys35MACIjz8RhtX8BnFq0liK/t6cvtFmCPL141zfB8BQAwkeryHJQRRgGosL06mykp0a5MnUVhyZAVZQIkKItHVSOORt1sgQ4ZaPnxoeMZT8GT9+mtYJLoSAhKzlj9+cN4CMIczjkiUruJfqedMC7Ek=;7:NaSGRu/xXVsLwlEpFOGMq2Ebjg6rPn5jItQ+ZZ1OnTzrqfRyjnV9p1SnwDGU5uO5DwS9iizfFZfj2+nsYm4zMo1cdi74iYfyju0vd1lpdTQfz3G0eEv59+1Xt+x9JttXhBuc2Mn3TmUiBPgtr0jjMQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 28b87ece-dc95-4f20-8582-08d658e2ed6d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB4075;
x-ms-traffictypediagnostic: MW2PR07MB4075:
x-microsoft-antispam-prvs: <MW2PR07MB407586260768E81A19FC818FE3AE0@MW2PR07MB4075.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MW2PR07MB4075;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB4075;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(13464003)(68736007)(33656002)(7736002)(6116002)(6246003)(478600001)(72206003)(97736004)(99286004)(3846002)(74316002)(2501003)(476003)(86362001)(14454004)(486006)(5660300001)(446003)(53936002)(11346002)(6436002)(9686003)(53546011)(71190400001)(71200400001)(110136005)(229853002)(102836004)(186003)(66066001)(25786009)(14444005)(256004)(81166006)(81156014)(8936002)(2201001)(8676002)(76176011)(316002)(305945005)(7696005)(55016002)(106356001)(26005)(105586002)(2906002)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB4075;H:MW2PR07MB4042.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r0RGFpkgS1T4Aj35F527/pCuYSTItt7SlV3dM0YFLRCNPhQP7BMubAeWdk9Yiw0Uu7dxZ9Kxog002kqu26GhbT5CpGUW/rt+D1cVIzx33hBg6Mpaz5fgopThOHWlheqtLpcLjw5NQULpDW5f1PoRV9oHWj5bv3Bhv07pLJmBMQ/YK/S8mq1e9cPonHAVbPOsovaFMTNhQU8CpzJT/NDjPWZvV0e7wPhkIqjlDhrkxxRjqxJH8wjgvAUc8vH789nAQp76bU+7enFegYQFZTAFj5n2MxBvU1t5HhudZzOdwd/CcV5naK8YBkYIx5fXFsZ3CtqZF37iBe9ocrBsMd+cFvuFT4qMwzgNXJLYXl9QJG0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b87ece-dc95-4f20-8582-08d658e2ed6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 05:48:18.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRob21hcyBNZXllciA8dGhv
bWFzQG0zeTNyLmRlPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDMsIDIwMTggMjoyMiBBTQ0K
PiBUbzogRGVwdC1FbmcgUUxvZ2ljIFN0b3JhZ2UgVXBzdHJlYW0gPFFMb2dpYy1TdG9yYWdlLQ0K
PiBVcHN0cmVhbUBjYXZpdW0uY29tPjsgamVqYkBsaW51eC52bmV0LmlibS5jb207DQo+IG1hcnRp
bi5wZXRlcnNlbkBvcmFjbGUuY29tOyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBzY3NpOiBxbGE0
eHh4OiBOVUxMIGNoZWNrIGJlZm9yZSBzb21lIGZyZWVpbmcgZnVuY3Rpb25zIGlzIG5vdA0KPiBu
ZWVkZWQuDQo+IA0KPiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gTlVMTCBjaGVjayBiZWZvcmUgc29t
ZSBmcmVlaW5nIGZ1bmN0aW9ucyBpcyBub3QgbmVlZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VGhvbWFzIE1leWVyIDx0aG9tYXNAbTN5M3IuZGU+DQo+IC0tLQ0KPiANCj4gZGlmZiAtdSAtcCBh
L2RyaXZlcnMvc2NzaS9xbGE0eHh4L3FsNF9vcy5jIGIvZHJpdmVycy9zY3NpL3FsYTR4eHgvcWw0
X29zLmMNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3FsYTR4eHgvcWw0X29zLmMNCj4gKysrIGIvZHJp
dmVycy9zY3NpL3FsYTR4eHgvcWw0X29zLmMNCj4gQEAgLTQxNjAsMjAgKzQxNjAsMTcgQEAgc3Rh
dGljIHZvaWQgcWxhNHh4eF9tZW1fZnJlZShzdHJ1Y3Qgc2NzaQ0KPiAgICAgICAgIGhhLT5md19k
dW1wX3NpemUgPSAwOw0KPiANCj4gICAgICAgICAvKiBGcmVlIHNyYiBwb29sLiAqLw0KPiAtICAg
ICAgIGlmIChoYS0+c3JiX21lbXBvb2wpDQo+IC0gICAgICAgICAgICAgICBtZW1wb29sX2Rlc3Ry
b3koaGEtPnNyYl9tZW1wb29sKTsNCj4gKyAgICAgICBtZW1wb29sX2Rlc3Ryb3koaGEtPnNyYl9t
ZW1wb29sKTsNCj4gDQo+ICAgICAgICAgaGEtPnNyYl9tZW1wb29sID0gTlVMTDsNCj4gDQo+IC0g
ICAgICAgaWYgKGhhLT5jaGFwX2RtYV9wb29sKQ0KPiAtICAgICAgICAgICAgICAgZG1hX3Bvb2xf
ZGVzdHJveShoYS0+Y2hhcF9kbWFfcG9vbCk7DQo+ICsgICAgICAgZG1hX3Bvb2xfZGVzdHJveSho
YS0+Y2hhcF9kbWFfcG9vbCk7DQo+IA0KPiAgICAgICAgIGlmIChoYS0+Y2hhcF9saXN0KQ0KPiAg
ICAgICAgICAgICAgICAgdmZyZWUoaGEtPmNoYXBfbGlzdCk7DQo+ICAgICAgICAgaGEtPmNoYXBf
bGlzdCA9IE5VTEw7DQo+IA0KPiAtICAgICAgIGlmIChoYS0+ZndfZGRiX2RtYV9wb29sKQ0KPiAt
ICAgICAgICAgICAgICAgZG1hX3Bvb2xfZGVzdHJveShoYS0+ZndfZGRiX2RtYV9wb29sKTsNCj4g
KyAgICAgICBkbWFfcG9vbF9kZXN0cm95KGhhLT5md19kZGJfZG1hX3Bvb2wpOw0KPiANCj4gICAg
ICAgICAvKiByZWxlYXNlIGlvIHNwYWNlIHJlZ2lzdGVycyAgKi8NCj4gICAgICAgICBpZiAoaXNf
cWxhODAyMihoYSkpIHsNCg0KVGhhbmtzDQpBY2tlZC1ieTogTWFuaXNoIFJhbmdhbmthciA8TWFu
aXNoLlJhbmdhbmthckBjYXZpdW0uY29tPg0K
