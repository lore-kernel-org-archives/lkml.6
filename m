Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B09C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A48620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="J+pJ1/8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A48620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeLCF5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:57:49 -0500
Received: from mail-eopbgr800047.outbound.protection.outlook.com ([40.107.80.47]:44304
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbeLCF5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwDk/si1nAhxtdo/G2mxSOmYTr7sQZhTa6UHSJaMkbo=;
 b=J+pJ1/8arxgFfn9FFyY5hAIONUIJB9bxXsJS5ciqPuoKE3USgDyvHeTXDSkmg/JheyLYPSHejqRooZOhvkdd9iuiZv86Ue6i2eL158rRUhXtPeGGjAoGO07Da0IU1/dlNo7R5OZhXzWkCyscQ8FQgswL+CZnUJicqCdj76Jn0nw=
Received: from MW2PR07MB4042.namprd07.prod.outlook.com (52.132.179.25) by
 MW2PR07MB3884.namprd07.prod.outlook.com (52.132.178.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 05:57:42 +0000
Received: from MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::142a:233e:11c3:4c4f]) by MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::142a:233e:11c3:4c4f%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 05:57:42 +0000
From:   "Rangankar, Manish" <Manish.Rangankar@cavium.com>
To:     Thomas Meyer <thomas@m3y3r.de>,
        Dept-Eng QLogic Storage Upstream 
        <QLogic-Storage-Upstream@cavium.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: qedf: NULL check before some freeing functions is
 not needed.
Thread-Topic: [PATCH] scsi: qedf: NULL check before some freeing functions is
 not needed.
Thread-Index: AQHUioFaEfcUnyHEhkGgkXi0R2Id1KVshQxg
Date:   Mon, 3 Dec 2018 05:57:42 +0000
Message-ID: <MW2PR07MB4042B569F3E1BD643DE67022E3AE0@MW2PR07MB4042.namprd07.prod.outlook.com>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
 <1543760930052-271366275-12-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930052-271366275-12-diffsplit-thomas@m3y3r.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Manish.Rangankar@cavium.com; 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB3884;6:HigFqR0FC16IPZV2eDC715mRY2MkLu81gkola9/hQ5XMdPCGQKLLyfoDw0QI9KLW3LYkeaAsP/uh81tIqPNs7ZTC7OoXqhC5DQfHpqFtT1CPBiZGblY4DiX1Pw2PoX3m9GWfFuJXwbT9NE9JVwXjVIi0evOuHUADCMUrEe+vRu5NATEDgFMkmgqJFX2xqHXsLKAsU83T82NFvLjYgSkH/4q0n9yAxUBZKDTpEyZYFbHZ5Hzxorwlwnmnwa9/Ji3aTBoQ2ul/776G+09ioWkXmylEIl9d7c0Qso/Agq/h6xhhm1EE7x2R4r6h3z1oY9bPSAg1/Y8FX5VdMDZuxFhoWhi5wbaqXjv1Nzhu2wVYzFwZT9+a84XTsuV/slXclgbkoMIfhgyfSWp/lCVoAG5dF3AEvv96x0jqChB9iRcv3/FPwZ01vywLJzAGKTADMR3gbCoc01mUe7O7h3fv9S4Sfw==;5:YK/msO86cXMMOLcahv6ElINfnBxVBb3aotXT8hHlXfvex3RRoUvBFAejopiAWOYNCVkNy+Kb53rGq9QQFbtAo05eswEeFd+3Y3WM8sJUwdaF/lFh6wdCsr4GMapcSuO9GyT3BZYSq3KPYuNwr4GxtsnMu9jc0674eyqBcmnF2u0=;7:kN0Jq5b/eACFVNDC6yd0GauNmJ84FSeOrjJwLlj55Zv7zRRymhtNbw1NfkEQJL3R1m+MQLLxG90M+u+NTWlmbWgn7M9vCQpSumCNhg3ZOb2UHNzzSgXpORmgOtNy3ytxSU7sdta2BvSO4ECTOyf1mg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9ce54105-1d72-4392-7789-08d658e43d59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB3884;
x-ms-traffictypediagnostic: MW2PR07MB3884:
x-microsoft-antispam-prvs: <MW2PR07MB3884BD9CDD0F53BCE99B214EE3AE0@MW2PR07MB3884.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MW2PR07MB3884;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB3884;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(13464003)(3846002)(68736007)(486006)(186003)(256004)(229853002)(2201001)(14444005)(86362001)(14454004)(106356001)(7696005)(105586002)(76176011)(6436002)(446003)(11346002)(476003)(2501003)(26005)(53936002)(97736004)(72206003)(316002)(102836004)(99286004)(71200400001)(6506007)(53546011)(7736002)(9686003)(55016002)(33656002)(110136005)(478600001)(74316002)(6246003)(81156014)(2906002)(8936002)(71190400001)(81166006)(305945005)(66066001)(8676002)(25786009)(6116002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB3884;H:MW2PR07MB4042.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oao0+FDWt+50IcdsXb8jkxEAbINjK6WFakMoCbpucku9eHFK+S2p6McU8hGuddpnRNOOyr3fuaLYH4L4kQiH3zWQ9NyJipE8IOvKKFWdiIa+xqpwyq6QJtPAOZ/LMbMAtP53/geQvOO+oupxK0HYNaxVvePbgb8o7/sMj2QQDwVOit6CnrzbhnGfC6+sQbE0Ir+FAzFBO0xGX8agxBV0UUA+sBdUGtwdiZ0vIss/3eRFzGIV0+0jzUnHz3jeR95Lawl0abJG0fEq4qxzP9cvrcM89BlDgGldTc/OmO7Kp8IL+WHU4Lb1ijI1MU1DTwD3r2JsnYc4BdfS3lFk3lq6tjPhn7GniWrhPpXIBsnJNaI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce54105-1d72-4392-7789-08d658e43d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 05:57:42.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRob21hcyBNZXllciA8dGhv
bWFzQG0zeTNyLmRlPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDMsIDIwMTggMjoyMiBBTQ0K
PiBUbzogRGVwdC1FbmcgUUxvZ2ljIFN0b3JhZ2UgVXBzdHJlYW0gPFFMb2dpYy1TdG9yYWdlLQ0K
PiBVcHN0cmVhbUBjYXZpdW0uY29tPjsgamVqYkBsaW51eC52bmV0LmlibS5jb207DQo+IG1hcnRp
bi5wZXRlcnNlbkBvcmFjbGUuY29tOyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBzY3NpOiBxZWRm
OiBOVUxMIGNoZWNrIGJlZm9yZSBzb21lIGZyZWVpbmcgZnVuY3Rpb25zIGlzIG5vdA0KPiBuZWVk
ZWQuDQo+IA0KPiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gTlVMTCBjaGVjayBiZWZvcmUgc29tZSBm
cmVlaW5nIGZ1bmN0aW9ucyBpcyBub3QgbmVlZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGhv
bWFzIE1leWVyIDx0aG9tYXNAbTN5M3IuZGU+DQo+IC0tLQ0KPiANCj4gZGlmZiAtdSAtcCBhL2Ry
aXZlcnMvc2NzaS9xZWRmL3FlZGZfbWFpbi5jIGIvZHJpdmVycy9zY3NpL3FlZGYvcWVkZl9tYWlu
LmMNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3FlZGYvcWVkZl9tYWluLmMNCj4gKysrIGIvZHJpdmVy
cy9zY3NpL3FlZGYvcWVkZl9tYWluLmMNCj4gQEAgLTI5MzUsOCArMjkzNSw3IEBAIHN0YXRpYyB2
b2lkIHFlZGZfZnJlZV9mY29lX3BmX3BhcmFtKHN0cnUNCj4gDQo+ICAgICAgICAgcWVkZl9mcmVl
X2dsb2JhbF9xdWV1ZXMocWVkZik7DQo+IA0KPiAtICAgICAgIGlmIChxZWRmLT5nbG9iYWxfcXVl
dWVzKQ0KPiAtICAgICAgICAgICAgICAga2ZyZWUocWVkZi0+Z2xvYmFsX3F1ZXVlcyk7DQo+ICsg
ICAgICAga2ZyZWUocWVkZi0+Z2xvYmFsX3F1ZXVlcyk7DQo+ICB9DQo+IA0KPiAgLyoNCg0KVGhh
bmtzDQpBY2tlZC1ieTogTWFuaXNoIFJhbmdhbmthciA8TWFuaXNoLlJhbmdhbmthckBjYXZpdW0u
Y29tPg0K
