Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1F4206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jUa8sDPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeLNSNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:13:43 -0500
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:27551
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729822AbeLNSNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I36r68iRC0VdrEEy8uo+FfYZd7G+d07ZzE69C8Q6zCY=;
 b=jUa8sDPHzGv0OV52v7dYGW2ksDXl39DD9gAPxgiAKD4BALR9Sc4ZxJ9CuuQhnCdSCmhiO9zmXGzmgyt+lddTAd3LsJgnPcyF3qob0U50gOv+oCzCtDxar5zgI5w/5zVuHXOOswHJlUDpCV/yWy6BCL0V48k9yOs6T4hYKOX7sg0=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB1166.eurprd08.prod.outlook.com (10.166.45.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 18:13:33 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b%4]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 18:13:33 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Dave P Martin <Dave.Martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Alan Hayward <Alan.Hayward@arm.com>
Subject: Re: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Topic: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Index: AQHUkYd5TQtknm9R4kqjkh+b7I8GJaV+jmIA
Date:   Fri, 14 Dec 2018 18:13:33 +0000
Message-ID: <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
References: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWXP265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::22) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB1166;6:giNZeqXKpYI610PozUq2Fp12YZPRjuTWCcoQSi05RHac7JdRZIyO1r/MX8ed1xN1rzTd2xo/ZboONxufhSgSoBi6UqqXwbohEvFjNGe3C335BVWIoMeWjthVrtpkCzJCFNvS1CGZWajKOmSwkVwx7hgG/dSTgS6G1PM+5qJYlMx1BYE2Mg+Ntam+67IWs1aSgwIYT6eHjSOBExXMPAsJWNpZ5DoFkQ32V/PRS8ZaQuzEmXRhD1fjdKE/ZIBjNz0YFbdY0kPh/Ou1hKLVHb9KI5hNi9tfahpulzhvtxVq2+EZY19fHzi/9abDkubFl8fNB+ZNoKB0a4tX3NcZdX4VSDE4+dtbF+KRsjzJR6nz8UVRI0Vw0WdEg4wgASyzqJm24NJuL7VMVoQdWrPPgxci7+ZaIsGoP7+QpwaiEdTPKWsIf1Mu2q/2sx4SKtRRCE4Vf0L0K6+Osfyd2Gaem5IRMA==;5:L9yRDQhvBTjFvArFGFoxkperyQFR1kN3weAVhyDlCGfwG1QAIIM6yDkDN6Z4t2MnK9yPTmycMCCvaeKfVmZJk2G3+pVpGqnE3Dp867iZl765jte+qefwsYnIAexmhFMpz9JuGDQq/D3+Lbwvch5JhJHR5vllmKTKJLwdvdlEKoU=;7:kIFtba4+H2L+Ie1N09f3vLqUQdSJ7y8Xa888FMT8KncwIDmrzhxmBv3Nf24VTrQtwZcusnplpBbVze9SNonFlc2z/ykQ7U1kpz1+wdlF1r4l8SYsyXIEmXdg2Gp3CtgSXbjpFCQbn3pkAL4hlD2JeQ==
x-ms-office365-filtering-correlation-id: 02535d37-92bb-46c1-7ea1-08d661efdbcf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB1166;
x-ms-traffictypediagnostic: VI1PR08MB1166:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB1166D212206CC9316022DAA9EDA10@VI1PR08MB1166.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB1166;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB1166;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39850400004)(396003)(136003)(366004)(199004)(189003)(229853002)(99286004)(256004)(66066001)(6436002)(4326008)(478600001)(2501003)(316002)(31686004)(6306002)(31696002)(71200400001)(6512007)(6116002)(71190400001)(64126003)(3846002)(86362001)(97736004)(6246003)(68736007)(53936002)(386003)(76176011)(486006)(2906002)(44832011)(52116002)(14454004)(53546011)(186003)(102836004)(6506007)(476003)(7736002)(5660300001)(26005)(65826007)(110136005)(72206003)(54906003)(6486002)(58126008)(81156014)(81166006)(305945005)(25786009)(106356001)(36756003)(446003)(11346002)(2616005)(105586002)(966005)(65956001)(8676002)(65806001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB1166;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GKag8AprYZRIVTqCYP3KGWdlvCHygZI9lMV1VKgnz+lSeTBCEnC7BObwoKWwbDhQ7OW+OIJHKOHVk5bY6kKFuDDyeg8e/gGKsDiMGQqWyXXnzJkRESUtqQGKsaiVlDmyzU+WenOIOtTnFfYQIrXc2am5R7pEoi7Y3pAoX02xNZi8H6XvGYOEV+sgDZTKbslc85bKpPkTdbwH4NfPEZNRVeq5Tzeh2xNGlF7qpftdTlvawpentU4lMkSu8pFHCL8CABGkjaLhfS7NpvgQVjlLOpR64JBDNLf+noK2l7qLkq1J7jFv3GhfFDnbcx16hqE5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <33BB7223C491A2468BFCF54FDCEA69A2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02535d37-92bb-46c1-7ea1-08d661efdbcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 18:13:33.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB1166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTIvMjAxOCAxOToyNiwgRGF2ZSBNYXJ0aW4gd3JvdGU6DQo+IFRoaXMgcGF0Y2ggcmVm
YWN0b3JzIHRoZSBVQVBJIGhlYWRlciBkZWZpbml0aW9ucyBmb3IgdGhlIEFybSBTVkUNCj4gZXh0
ZW5zaW9uIHRvIGF2b2lkIG11bHRpcGxlLWRlZmluaXRpb24gcHJvYmxlbXMgd2hlbiB1c2Vyc3Bh
Y2UgbWl4ZXMgaXRzDQo+IG93biBzaWdjb250ZXh0LmggZGVmaW5pdGlvbnMgd2l0aCB0aGUga2Vy
bmVsJ3MgcHRyYWNlLmggKHdoaWNoIGlzDQo+IGFwcGFyZW50bHkgcm91dGluZSkuDQo+IA0KPiBB
IGNvbW1vbiBiYWNrZW5kIGhlYWRlciBpcyBjcmVhdGVkIHRvIGhvbGQgY29tbW9uIGRlZmluaXRp
b25zLCBzdWl0YWJseQ0KPiBuYW1lc3BhY2VkLCBhbmQgd2l0aCBhbiBhcHByb3ByaWF0ZSBoZWFk
ZXIgZ3VhcmQuDQo+IA0KPiBTZWUgdGhlIGNvbW1pdCBtZXNzYWdlIGluIHBhdGNoIDMgZm9yIGZ1
cnRoZXIgZXhwbGFuYXRpb24gb2Ygd2h5IHRoaXMNCj4gaXMgbmVlZGVkLg0KPiANCj4gQmVjYXVz
ZSBvZiB0aGUgbm9uLXRyaXZpYWwgaGVhZGVyIGd1YXJkIGluIHRoZSBuZXcgc3ZlX2NvbnRleHQu
aCwgcGF0Y2gNCj4gMSBhZGRzIHN1cHBvcnQgdG8gaGVhZGVyc19pbnN0YWxsLnNoIHRvIG11bmdl
ICNpZiBkZWZpbmVkKF9VQVBJX0ZPTykgaW4NCj4gYSBzaW1pbGFyIHdheSB0byB0aGUgY3VycmVu
dCBoYW5kbGluZyBvZiAjaWZuZGVmIF9VQVBJX0ZPTy4NCj4gDQoNCnRoYW5rcyBmb3IgZG9pbmcg
dGhpcy4NCg0KdGhlIHBhdGNoZXMgZml4IHRoZSBnZGIgYnVpbGQgaXNzdWUgb24gbXVzbCBsaWJj
IHdpdGggYW4NCmFkZGl0aW9uYWwgZ2RiIHBhdGNoOg0KaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9t
bC9nZGItcGF0Y2hlcy8yMDE4LTEyL21zZzAwMTUyLmh0bWwNCihpbiB1c2Vyc3BhY2UgaSdkIGV4
cGVjdCB1c2VycyByZWx5aW5nIG9uIHNpZ25hbC5oIHByb3ZpZGluZw0Kd2hhdGV2ZXIgaXMgaW4g
YXNtL3NpZ2NvbnRleHQuaC4pDQoNCmkgdGhpbmsgc3ZlX2NvbnRleHQuaCBjb3VsZCBiZSBtYWRl
IHRvIHdvcmsgd2l0aCBkaXJlY3QgaW5jbHVkZSwNCmV2ZW4gaWYgdGhhdCdzIG5vdCB1c2VmdWwg
YmVjYXVzZSB0aGVyZSBpcyBubyBwdWJsaWMgYXBpIHRoZXJlLg0KKGFuZCB0aGVuIHlvdSBkb250
IG5lZWQgdGhlIGZpcnN0IHBhdGNoKQ0KDQo+IERhdmUgTWFydGluICgzKToNCj4gICBrYnVpbGQ6
IGluc3RhbGxfaGVhZGVycy5zaDogU3RyaXAgX1VBUEkgZnJvbSAjaWYtZGVmaW5lZCgpIGd1YXJk
cw0KPiAgIGFybTY0L3N2ZTogcHRyYWNlOiBGaXggU1ZFX1BUX1JFR1NfT0ZGU0VUIGRlZmluaXRp
b24NCj4gICBhcm02NC9zdmU6IERpc2VudGFuZ2xlIDx1YXBpL2FzbS9wdHJhY2UuaD4gZnJvbQ0K
PiAgICAgPHVhcGkvYXNtL3NpZ2NvbnRleHQuaD4NCj4gDQo+ICBhcmNoL2FybTY0L2luY2x1ZGUv
dWFwaS9hc20vcHRyYWNlLmggICAgICB8IDM5ICsrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgYXJj
aC9hcm02NC9pbmNsdWRlL3VhcGkvYXNtL3NpZ2NvbnRleHQuaCAgfCA1NiArKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tDQo+ICBhcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20vc3ZlX2Nv
bnRleHQuaCB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgc2NyaXB0cy9oZWFk
ZXJzX2luc3RhbGwuc2ggICAgICAgICAgICAgICAgfCAgMSArDQo+ICA0IGZpbGVzIGNoYW5nZWQs
IDk3IGluc2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvYXJtNjQvaW5jbHVkZS91YXBpL2FzbS9zdmVfY29udGV4dC5oDQo+IA0KDQo=
