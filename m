Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E120AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6521121104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eOAM5kEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6521121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeK2S6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:58:09 -0500
Received: from mail-bgr052101136095.outbound.protection.outlook.com ([52.101.136.95]:6296
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbeK2S6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6rAwz3KjWrp9vPPOsaso1yh6g8aBvGNX/i1wyd0pRI=;
 b=eOAM5kEiKUh6yqdeLePTI39rLkMy+8m+vkLad/Z1FV8IuQ0IOmo0ssBMSFrb8F+/Ef0oiRskZUJ2LTdqLqfZ4u9VF3FCYEbceHXrY1oji8DpVnHAZPvvp76NzD5ShHdTr/Faure63bUzfXPMwpCSm3mP8MzFx5aoUoke3YUREe8=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB3965.eurprd08.prod.outlook.com (20.178.125.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Thu, 29 Nov 2018 07:52:12 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 07:52:12 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Topic: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Index: AQHUhZ9iirF501eLF0yD2vJWccWjqaVirXKAgADsioCAAJCpgIAAQ0+AgACTaACAACoWAIABOioA
Date:   Thu, 29 Nov 2018 07:52:12 +0000
Message-ID: <20181129075208.GA9010@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-2-vkuznets@redhat.com>
 <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com>
 <20181127184835.GA5147@rkaganip.lan>
 <8A215F49-BB8F-4E93-AC62-EC33B4734F24@gmail.com>
 <87a7ltjxnz.fsf@vitty.brq.redhat.com>
 <alpine.DEB.2.21.1811281404230.1532@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811281404230.1532@nanos.tec.linutronix.de>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?utf-8?B?Um9tYW4gS2FnYW4gPHJrYWdhbkB2aXJ0dW96em8uY29tPiwJVGhvbWFzIEds?=
 =?utf-8?B?ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+LAlWaXRhbHkgS3V6bmV0c292?=
 =?utf-8?B?IDx2a3V6bmV0c0ByZWRoYXQuY29tPiwJTmFkYXYgQW1pdCA8bmFkYXYuYW1p?=
 =?utf-8?B?dEBnbWFpbC5jb20+LAkiSy4gWS4gU3Jpbml2YXNhbiIgPGt5c0BtaWNyb3Nv?=
 =?utf-8?B?ZnQuY29tPiwJSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNv?=
 =?utf-8?B?bT4sCVN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29t?=
 =?utf-8?B?PiwJIk1pY2hhZWwgS2VsbGV5IChFT1NHKSIgPE1pY2hhZWwuSC5LZWxsZXlA?=
 =?utf-8?B?bWljcm9zb2Z0LmNvbT4sCSJrdm1Admdlci5rZXJuZWwub3JnIiA8a3ZtQHZn?=
 =?utf-8?B?ZXIua2VybmVsLm9yZz4sCVBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhh?=
 =?utf-8?B?dC5jb20+LAlSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJAcmVkaGF0LmNvbT4s?=
 =?utf-8?B?CSJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiA8bGludXgta2VybmVs?=
 =?utf-8?B?QHZnZXIua2VybmVsLm9yZz4sCSJ4ODZAa2VybmVsLm9yZyIgPHg4NkBrZXJu?=
 =?utf-8?Q?el.org>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0207.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::31) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3965;7:2Xij4Ue2JoG3dOcnJUYtVLqC1P1BHfwujqXb29joxqtPhAUqS3t/wbF6maumzX8tY/orjQ4pVvPsblRs7gqdbI8Re0Fzk7W3ISi1t67yt6ZudugCo7LAP7ZciTkQwr5VSkiLiEFyByMH6DEakiDAPg==;20:TnC1yg15IzCHX/V3XwhuRFXXQMpNNRTaOla0Txy15KuMK3sO7Zi0ux/K8jA2X4l4qgv7l2hjIlq8bvKGwS0HWgZtLr7GVKSdU3kAgpDcqZTSmpo+SfnOEM1KCpBPFqUSA0KIfJhfnflWWRDcv8VChC92APIPxw4fGa5H/n9qA44=
x-ms-office365-filtering-correlation-id: d80f1842-bc0c-4137-d58d-08d655cf9266
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3965;
x-ms-traffictypediagnostic: VI1PR08MB3965:|VI1PR08MB3965:
x-microsoft-antispam-prvs: <VI1PR08MB396574D95243DA614A7B8149C9D20@VI1PR08MB3965.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231453)(999002)(944501447)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3965;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3965;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(366004)(136003)(396003)(346002)(376002)(39850400004)(189003)(199004)(6506007)(6486002)(26005)(6512007)(68736007)(386003)(81166006)(76176011)(8676002)(81156014)(99286004)(71200400001)(71190400001)(102836004)(316002)(6346003)(58126008)(93886005)(6916009)(486006)(66066001)(256004)(478600001)(446003)(54906003)(476003)(33896004)(8936002)(6436002)(11346002)(52116002)(229853002)(33656002)(86362001)(25786009)(106356001)(105586002)(186003)(14454004)(1076002)(2906002)(5660300001)(305945005)(7736002)(4326008)(53936002)(97736004)(3846002)(7416002)(39060400002)(6246003)(9686003)(36756003)(6116002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3965;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-microsoft-antispam-message-info: vsyRGCGaQgHXWzYhVA/P97sRzAQt4W8supGxq90pc8BqiKIfFcBHOx5czWinucV+XVF4XUefdI/a4BdXPVLTgcNeBa+5/wcANKFinEQJHRPZNLlijN7RCj2dsehoyisL6FvSfSr1NQCIDkzuTWpPr1s4Hl4xM1dLHDDTNpqeWwcnqjKFfMVXc/wNixJcJqUAYRWZPFP+SYNZwbr6NpZsP2nF9BvecE60gUdJ/PoKgFPBXJMcL6aeW8jAMnZwywWH1bwCZKnC2JmXsOl3qR44giqj36ZERRpVZhX28eA5k7dEk813M3owa2ueo642+CycBOOS7VBO/I5Swcfj5DUZN85hxrCR+XwCx8lt21J1FlEr3Uc9S4cqw2DgPiUmRtwxy1kyy1f1ktecrj7PN6dbjMNg3j46WumjxuGh0WEZN+rIZJc+AxzHM90n15w58fzqJXQ+oJteEMZAZ9hPDokzbzB06F2ONlTjoKwmng+GRigkOveMvopKxx0dleyw+91/WL+0W6n6xvvx8d383qb8Ni4F2UUFhCmfd8jnfSChwg4=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFFA39AFB8D5684190106F04BE36AF9F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80f1842-bc0c-4137-d58d-08d655cf9266
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 07:52:12.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3965
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBOb3YgMjgsIDIwMTggYXQgMDI6MDc6NDJQTSArMDEwMCwgVGhvbWFzIEdsZWl4bmVy
IHdyb3RlOg0KPiBPbiBXZWQsIDI4IE5vdiAyMDE4LCBWaXRhbHkgS3V6bmV0c292IHdyb3RlOg0K
PiANCj4gPiBOYWRhdiBBbWl0IDxuYWRhdi5hbWl0QGdtYWlsLmNvbT4gd3JpdGVzOg0KPiA+IA0K
PiA+ID4NCj4gPiA+IE9uIGEgZGlmZmVyZW50IG5vdGU6IGhvdyBjb21lIGFsbCBvZiB0aGUgaHlw
ZXItdiBzdHJ1Y3RzIGFyZSBub3QgbWFya2VkDQo+ID4gPiB3aXRoIHRoZSDigJxwYWNrZWQiIGF0
dHJpYnV0ZT8NCj4gPiANCj4gPiAicGFja2VkIiBzaG91bGQgbm90IGJlIG5lZWRlZCB3aXRoIHBy
b3BlciBwYWRkaW5nOyBJIHZhZ3VlbHkgcmVtZW1iZXINCj4gPiBzb21lb25lIChmcm9tIHg4NkA/
KSBhcmd1aW5nIF9hZ2FpbnN0XyAicGFja2VkIi4NCj4gDQo+IFBhY2tlZCBuZWVkcyB0byBiZSB1
c2VkLCB3aGVuIGRlc2NyaWJpbmcgZml4ZWQgZm9ybWF0IGRhdGEgc3RydWN0dXJlcyBpbg0KPiBo
YXJkd2FyZSBvciBvdGhlciBBQklzLCBzbyB0aGUgY29tcGlsZXIgY2Fubm90IHB1dCBhbGlnbm1l
bnQgaG9sZXMgaW50bw0KPiB0aGVtLg0KPiANCj4gVXNpbmcgcGFja2VkIGZvciBnZW5lcmljIGRh
dGEgc3RydWN0dXJlcyBtaWdodCByZXN1bHQgaW4gc3Vib3B0aW1hbCBsYXlvdXRzDQo+IGFuZCBw
cmV2ZW50cyBsYXlvdXQgcmFuZG9taXphdGlvbi4NCg0KU29ycnkgZm9yIG15IGlsbGl0ZXJhY3ks
IEkgZGlkbid0IHdhdGNoIHRoaXMgZmllbGQgY2xvc2VseSBzbyBJIGhhZCB0bw0KZ29vZ2xlIGFi
b3V0IGxheW91dCByYW5kb21pemF0aW9uLiAgSXMgbXkgdW5kZXJzdGFuZGluZyBjb3JyZWN0IHRo
YXQgb25lDQpjYW4ndCByZWx5IGFueSBtb3JlIG9uIHRoZSBjb21waWxlciB0byBuYXR1cmFsbHkg
YWxpZ24gdGhlIHN0cnVjdA0KbWVtYmVycyB3aXRoIG1pbmltYWwgcGFkZGluZz8gIE15IGxpZmUg
d2lsbCBuZXZlciBiZSB0aGUgc2FtZS4uLg0KDQpSb21hbi4NCg==
