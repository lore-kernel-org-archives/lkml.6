Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E701C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370762146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="IpIIW+dU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370762146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeLDIvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:51:25 -0500
Received: from mail-eopbgr720046.outbound.protection.outlook.com ([40.107.72.46]:51376
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbeLDIvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyKF9Yrfr9fKJFCgFkMlQOWjBTpJksF5cjWwdfIMD7A=;
 b=IpIIW+dUprz6Fh+eTDnRXn0G6caD2hCR8gP86kxdaPHlbZu8JC+VFGlkMY6V03inCUR7o50O0Nnerps/G9nWnIIAEe9T8++e4F+Y+rduyXUsZdUDQe1iGWTNvHYJS4WtgOyYpwLxEmhOOzJe7OoJKtBUaYFGrz12KqzB8KjG+tw=
Received: from CY1PR05MB2761.namprd05.prod.outlook.com (10.167.18.19) by
 CY1PR05MB2314.namprd05.prod.outlook.com (10.166.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.13; Tue, 4 Dec 2018 08:51:22 +0000
Received: from CY1PR05MB2761.namprd05.prod.outlook.com
 ([fe80::19ed:e9d6:fd83:8956]) by CY1PR05MB2761.namprd05.prod.outlook.com
 ([fe80::19ed:e9d6:fd83:8956%2]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 08:51:22 +0000
From:   Tzvetomir Stoyanov <tstoyanov@vmware.com>
To:     "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kernel-team@lge.com" <kernel-team@lge.com>
Subject: Re: [PATCH 2/9] tools/lib/traceevent: Added support for pkg-config
Thread-Topic: [PATCH 2/9] tools/lib/traceevent: Added support for pkg-config
Thread-Index: AQHUiMPoUvfyaLV3tk6snd2KikksoKVuNYSAgAAV7AA=
Date:   Tue, 4 Dec 2018 08:51:21 +0000
Message-ID: <CACqStoe63Tufkx_yHz_Tfp_h2DAbCwqa=ahWmYVYtTUQt=qYUA@mail.gmail.com>
References: <20181130154403.150474900@goodmis.org>
 <20181130154647.022471992@goodmis.org> <20181204073235.GB16733@sejong>
In-Reply-To: <20181204073235.GB16733@sejong>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:203:91::23) To CY1PR05MB2761.namprd05.prod.outlook.com
 (2a01:111:e400:c63a::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tstoyanov@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [209.85.128.43]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR05MB2314;20:BAh+4NjP6tsvUS8HsS0lOmx1rwXwrvNcFHVygOf0tAqd58mP8QbG6X5A7D5MdkpV5G2dcJ/wX7WD7ceaMf2DoW5KwahcOB6KyaX1RrnfXGoCXB8nydC+OSUDTeOHNN4hHtwyOacXiUdVnuYDGgWXNOaYHkDhD10DkgI6/KQKV5Q=
x-ms-office365-filtering-correlation-id: 3e62c16e-eee6-4b07-b5ea-08d659c5a99a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR05MB2314;
x-ms-traffictypediagnostic: CY1PR05MB2314:
x-microsoft-antispam-prvs: <CY1PR05MB231474B3DFA1A50A387F812FDCAF0@CY1PR05MB2314.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY1PR05MB2314;BCL:0;PCL:0;RULEID:;SRVR:CY1PR05MB2314;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(50944005)(11346002)(105586002)(6486002)(4326008)(575784001)(5660300001)(97736004)(26005)(6512007)(6306002)(2351001)(68736007)(186003)(6506007)(6116002)(3846002)(53936002)(98316002)(386003)(81166006)(81156014)(53546011)(1730700003)(102836004)(8676002)(2501003)(61266001)(6436002)(446003)(86362001)(2906002)(229853002)(486006)(106356001)(9686003)(66066001)(25786009)(476003)(6246003)(498394004)(71190400001)(71200400001)(45080400002)(61726006)(14454004)(33896004)(6862004)(5640700003)(14444005)(256004)(76176011)(305945005)(7736002)(8936002)(316002)(966005)(54906003)(52116002)(478600001)(55446002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR05MB2314;H:CY1PR05MB2761.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jXgNgWcp1es1UiBtBV0EOsYKYU9NK31EXRBqUHB9q8u6g2azJqsrMIJ1GCIXRqKIJ+9SJVMS/ZTjl5HDb0qaUaeOUolAgZK9zF8a/aVxE/bdUnAKyT6fcdfwgOqD0eYhXG69rNzgAoJRNILEhEQLjW3ua3Kzzo1+5irJW6gTWXs+NiZm1cO50cLgvTINuoaMJ3lIt4Jv15G27Z4J8eZTl3L7LJvEMwHQ+8WScQzrDLThyt1xcKNfNUkH4gMVhbE/oFITCf48manf9uN8WivoeuehIZ8l1YZKboVlWnVJA/LpGCeSA6Q6dOHP9tl8gKVZDwszF/FurlIFZRz22LAr0n4mzfHu5oOC5VOJZJMQFiE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD13AA5F0AA57242BD0FDDFB119E517E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e62c16e-eee6-4b07-b5ea-08d659c5a99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 08:51:21.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR05MB2314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmFtaHl1bmcsDQoNCk9uIFR1ZSwgRGVjIDQsIDIwMTggYXQgOTozMiBBTSBOYW1oeXVuZyBL
aW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+IHdyb3RlOg0KPg0KPiBIaSBTdGV2ZSwNCj4NCj4gT24g
RnJpLCBOb3YgMzAsIDIwMTggYXQgMTA6NDQ6MDVBTSAtMDUwMCwgU3RldmVuIFJvc3RlZHQgd3Jv
dGU6DQo+ID4gRnJvbTogVHp2ZXRvbWlyIFN0b3lhbm92IDx0c3RveWFub3ZAdm13YXJlLmNvbT4N
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBpbnRlZ3JhdGlvbiB3aXRoIHBrZy1jb25m
aWcgZnJhbWV3b3JrLg0KPiA+IHBrZy1jb25maWcgY2FuIGJlIHVzZWQgYnkgdGhlIGxpYnJhcnkg
dXNlcnMgdG8gZGV0ZXJtaW5lDQo+ID4gcmVxdWlyZWQgQ0ZMQUdTIGFuZCBMREZMQUdTIGluIG9y
ZGVyIHRvIHVzZSB0aGUgbGlicmFyeQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVHp2ZXRvbWly
IFN0b3lhbm92IDx0c3RveWFub3ZAdm13YXJlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGV2
ZW4gUm9zdGVkdCAoVk13YXJlKSA8cm9zdGVkdEBnb29kbWlzLm9yZz4NCj4gPiAtLS0NCj4NCj4g
W1NOSVBdDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi90cmFjZWV2ZW50L2xpYnRyYWNlZXZl
bnQucGMudGVtcGxhdGUgYi90b29scy9saWIvdHJhY2VldmVudC9saWJ0cmFjZWV2ZW50LnBjLnRl
bXBsYXRlDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjQyZTRkNmNiNmI5ZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi90b29scy9saWIvdHJh
Y2VldmVudC9saWJ0cmFjZWV2ZW50LnBjLnRlbXBsYXRlDQo+ID4gQEAgLTAsMCArMSwxMCBAQA0K
PiA+ICtwcmVmaXg9SU5TVEFMTF9QUkVGSVgNCj4gPiArbGliZGlyPSR7cHJlZml4fS9saWI2NA0K
Pg0KPiBEb24ndCB3ZSBjYXJlIDMyLWJpdCBzeXN0ZW1zIGFueW1vcmU/IDopDQo+DQoNCkl0IGlz
IG15IGZhdWx0LCBnb2luZyB0byBzdWJtaXQgYSBwYXRjaCB0byBwYXJhbWV0ZXJpemVkIGl0Lg0K
DQo+IFRoYW5rcywNCj4gTmFtaHl1bmcNCj4NCj4NCj4gPiAraW5jbHVkZWRpcj0ke3ByZWZpeH0v
aW5jbHVkZS90cmFjZWV2ZW50DQo+ID4gKw0KPiA+ICtOYW1lOiBsaWJ0cmFjZWV2ZW50DQo+ID4g
K1VSTDogaHR0cHM6Ly9uYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZnaXQua2VybmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVs
JTJGZ2l0JTJGdG9ydmFsZHMlMkZsaW51eC5naXQmYW1wO2RhdGE9MDIlN0MwMSU3Q3RzdG95YW5v
diU0MHZtd2FyZS5jb20lN0NiZjg2MzgxNDE4ZGE0NmY3NzEyMTA4ZDY1OWJhYWEyMCU3Q2IzOTEz
OGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3QzAlN0M2MzY3OTUwNTU2MDgwMTIwNDYm
YW1wO3NkYXRhPXI2aVhTZmZDckV6TzBoUmhwaUljdGRQMmpjZmJFU2FKeE9aVnJITG5BZnclM0Qm
YW1wO3Jlc2VydmVkPTANCj4gPiArRGVzY3JpcHRpb246IExpbnV4IGtlcm5lbCB0cmFjZSBldmVu
dCBsaWJyYXJ5DQo+ID4gK1ZlcnNpb246IExJQl9WRVJTSU9ODQo+ID4gK0NmbGFnczogLUkke2lu
Y2x1ZGVkaXJ9DQo+ID4gK0xpYnM6IC1MJHtsaWJkaXJ9IC1sdHJhY2VldmVudA0KPiA+IC0tDQo+
ID4gMi4xOS4xDQo+ID4NCj4gPg0KDQotLSANClR6dmV0b21pciAoQ2VjbykgU3RveWFub3YNClZN
d2FyZSBPcGVuIFNvdXJjZSBUZWNobm9sb2d5IENlbnRlcg0K
