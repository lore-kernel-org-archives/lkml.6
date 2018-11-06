Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A266C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1863620862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVOEzNs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1863620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeKFLBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:01:33 -0500
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:43648
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbeKFLBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBwZq2w2ZemCMPntkUrC5QpwqMGtqv9Z/rpXURc4HgY=;
 b=RVOEzNs5lVhaxg7Dplb5P6n2PU4p0hgruL/zfaUu8odi5sD0fYkdekKT8WbOSN23O45HOKJ3HOTONhFc6pf2kH8LXFBh078W/CHtYjX3B2yCcPShV7pjN/hu3adcvF7vO6R+yZwjrWSYoWqexUbT8EM35TQFSoda2ub2pi460Bg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 01:38:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.028; Tue, 6 Nov 2018
 01:38:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to avoid
 resource leak
Thread-Topic: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to
 avoid resource leak
Thread-Index: AQHUdKRXRzpml7CMi0WCytiW4+vPCaVBL1QAgADJ7TA=
Date:   Tue, 6 Nov 2018 01:38:48 +0000
Message-ID: <DB3PR0402MB39161E47E47937FDB8046B6EF5CB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
 <1541379930-14538-2-git-send-email-Anson.Huang@nxp.com>
 <dea51d27-0957-f762-773f-e0e0e001045c@linaro.org>
In-Reply-To: <dea51d27-0957-f762-773f-e0e0e001045c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:KD1f2htkwytBAroLUMpXFz73v6/kG7Sr19mdB3tk2exmOMrbVcNzJ4se++jl0mT8Q9JTqn0iQm6mxZV4NsZOac316u0aoYp19q+Fxc4+O4GSSqpXstviQvdTSFJk5h8zUn8p2XguAKPOPJBVSWBf92z2o928cqC+rKwZo1pwpJEw6v1RKNXd0ecYuZuXp9tzYRv4yKh4VRvIDdvlMIHx/diA6Ou4ueSyOQ52Ssja+LUP9huLSvaYvdPBNjbRPH0y7ZwbHk6SACBGnTC7oYWaWprVY6vx7k7Rc2LSlg1LvfA3ya1AqQxHT/CNIN2c4TGNQvlGGittt8z2y3LGyzBPNCwE8ysaPHd/+u10p9Y+CZ9Y0UrShenNEyNc/llgM2ArI3TBVkdMPfxnwH4IYCinrdWJ9byDI5y4dYylJ6vkHA1D2ub9BNqSeJrUhsuKIVEdXPwwmFrBizyrOdKwFYWe3Q==;5:EAYcwAyiC8RDD6H0A0UvrEZQjHgFUEaZdJ/Cv0VyY1dFheRDNBOdjVQhxjJffi92iEQ5G9NmbyR9VMauFiQ5dlvO7KiyQiPOQuU9yMVNtmN50hVDEzlF63IWQJu9V2cqeXkuqQ5L/Wl1zKIulixUw+t5UEiJVbszhAI6f7RrOoQ=;7:p04PBH2jUkZPETIp0KASPyEzekFVOPy50nIOBZvR3RFRhSMmDeMjfWYhTD4jdqaOKeCxbdogpzfA1rzMbsYPCa8nOs3wMui2OSbCOlXM7M33TVbR740HQOG+Tyh30bayvWfidjCbW3R771VS8UeOfw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 607fa908-5dae-49bb-9359-08d6438899bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB3690AB9B3797F246B21326DAF5CB0@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(64217206974132)(185117386973197)(81227570615382)(148322886591682)(45079756050767)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(13464003)(199004)(189003)(66066001)(105586002)(8936002)(6116002)(25786009)(3846002)(5660300001)(7736002)(7696005)(102836004)(11346002)(53936002)(68736007)(74316002)(14454004)(2906002)(256004)(476003)(97736004)(2501003)(478600001)(229853002)(26005)(8676002)(33656002)(81166006)(305945005)(81156014)(2900100001)(99286004)(2201001)(86362001)(6436002)(446003)(6246003)(76176011)(486006)(53546011)(106356001)(186003)(6506007)(55016002)(9686003)(4326008)(71190400001)(71200400001)(316002)(110136005)(44832011)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ck2fzqpEV7cr6wSRJoHrJUSgA+kpye496Mgm+pL+yVekK0/nl+ri9TWqIqrPJotBvFHmZ9CK2CjCXVgROPbVmnMoXY8MscLd6h5r+MUUdbxz5EgRiu35HzKyRd/ZN0fpJWwcPbhtwqiNHDG0jmVtjGuWKaiU49o58yu3voN3ERHBFOMqNM0fR2DrM3Sa92+fhFoFHRUTY/dQZUr0nei7mCNJ56SkkuJ/USSGxxJIyql/fyJQMwE9avQQVuyhxA7oR1FAG52kjL9ssP06bgXAv0AimXaLt8ruOH1lnCKsxVDMbWYEqbRXqx7197bHOIu8LX3cMZlP968z0IDk1i3PLOlk+IhlFHi6LjTSO4+ZrPE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607fa908-5dae-49bb-9359-08d6438899bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 01:38:49.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBMZXpjYW5vIFttYWlsdG86ZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZ10NCj4gU2VudDogMjAxOOW5tDEx5pyINeaXpSAyMTozNQ0KPiBUbzog
QW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgt
aW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8yXSBjbG9ja3NvdXJjZTog
aW14LWdwdDogYWRkIG5lY2Vzc2FyeSBrZnJlZSB0byBhdm9pZA0KPiByZXNvdXJjZSBsZWFrDQo+
IA0KPiBIaSBBbnNvbiwNCj4gDQo+IE9uIDA1LzExLzIwMTggMDI6MTAsIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+IGtmcmVlIHNob3VsZCBiZSBjYWxsZWQgdG8gZnJlZSByZXNvdXJjZSBpbiBlcnJv
ciBwYXRoIGJlZm9yZSByZXR1cm4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbG9ja3NvdXJj
ZS90aW1lci1pbXgtZ3B0LmMgfCA4ICsrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jbG9ja3NvdXJjZS90aW1lci1pbXgtZ3B0LmMNCj4gPiBiL2RyaXZlcnMvY2xvY2tzb3VyY2Uv
dGltZXItaW14LWdwdC5jDQo+ID4gaW5kZXggYTNkNmNjYi4uMGY3OGIzMCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWlteC1ncHQuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvY2xvY2tzb3VyY2UvdGltZXItaW14LWdwdC5jDQo+ID4gQEAgLTQ3NywxMiArNDc3LDE2IEBA
IHN0YXRpYyBpbnQgX19pbml0IG14Y190aW1lcl9pbml0X2R0KHN0cnVjdA0KPiBkZXZpY2Vfbm9k
ZSAqbnAsICBlbnVtIGlteF9ncHRfdHlwZSB0DQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4N
Cj4gPiAgCWlteHRtLT5iYXNlID0gb2ZfaW9tYXAobnAsIDApOw0KPiA+IC0JaWYgKCFpbXh0bS0+
YmFzZSkNCj4gPiArCWlmICghaW14dG0tPmJhc2UpIHsNCj4gPiArCQlrZnJlZShpbXh0bSk7DQo+
ID4gIAkJcmV0dXJuIC1FTlhJTzsNCj4gPiArCX0NCj4gPg0KPiA+ICAJaW14dG0tPmlycSA9IGly
cV9vZl9wYXJzZV9hbmRfbWFwKG5wLCAwKTsNCj4gPiAtCWlmIChpbXh0bS0+aXJxIDw9IDApDQo+
ID4gKwlpZiAoaW14dG0tPmlycSA8PSAwKSB7DQo+ID4gKwkJa2ZyZWUoaW14dG0pOw0KPiA+ICAJ
CXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlpbXh0bS0+Y2xrX2lwZyA9IG9m
X2Nsa19nZXRfYnlfbmFtZShucCwgImlwZyIpOw0KPiANCj4gUGxlYXNlIGNvbnZlcnQgdG8gdGlt
ZXItb2YgQVBJLg0KDQpUaGlzIHBhdGNoIG1haW5seSB0byBmaXggdGhlIHBvdGVudGlhbCByZXNv
dXJjZSBsZWFrIGlzc3VlLCBmb3IgY29udmVydGluZw0KdG8gdGltZXItb2YgQVBJLCBzaG91bGQg
SSBhZGQgYW5vdGhlciBwYXRjaCBmb3IgaXQ/IFNpbmNlIGl0IGlzIGEgZGlmZmVyZW50DQpzdWJq
ZWN0Lg0KDQpUaGFua3MuDQoNCkFuc29uDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gICAtLSBEYW5p
ZWwNCj4gDQo+IA0KPiAtLQ0KPiANCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dw0KPiAubGluYXJvLm9yZyUyRiZh
bXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDYjM4OWU2DQo+IDcxZWFm
YjQ0MDAxNDgyMDhkNjQzMjM3MzgzJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUl
DQo+IDdDMCU3QzAlN0M2MzY3NzAyMTY4NzQ1NDgyOTMmYW1wO3NkYXRhPXRveW5UZXIlMkJxN0RM
Uml6d1c3SktZDQo+IHFDckE4V1FIZURtSlJ3TGpYVXU2WFklM0QmYW1wO3Jlc2VydmVkPTA+IExp
bmFyby5vcmcg4pSCIE9wZW4gc291cmNlDQo+IHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4g
Rm9sbG93IExpbmFybzoNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dw0KPiAuZmFjZWJvb2suY29tJTJGcGFnZXMl
MkZMaW5hcm8mYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwDQo+IG54cC5jb20lN0Ni
Mzg5ZTY3MWVhZmI0NDAwMTQ4MjA4ZDY0MzIzNzM4MyU3QzY4NmVhMWQzYmMyYjRjNmZhDQo+IDky
Y2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2NzcwMjE2ODc0NTQ4MjkzJmFtcDtzZGF0YT1KSk9D
bGhMDQo+IHBFUjVKTXVYSHM2NWZKRCUyRlBDMTglMkZKQkN5aVJ3M2Q0MWVpNDglM0QmYW1wO3Jl
c2VydmVkPTA+DQo+IEZhY2Vib29rIHwNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnR3aXR0DQo+IGVyLmNvbSUyRiUy
MyElMkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmMNCj4g
b20lN0NiMzg5ZTY3MWVhZmI0NDAwMTQ4MjA4ZDY0MzIzNzM4MyU3QzY4NmVhMWQzYmMyYjRjNmZh
OTJjZA0KPiA5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2NzcwMjE2ODc0NTQ4MjkzJmFtcDtzZGF0
YT1XMVFYUndnWHQNCj4gZTN3YmJqRVR1RGluVW5pSURlQThUSFclMkJzejZTU1BXbDMwJTNEJmFt
cDtyZXNlcnZlZD0wPiBUd2l0dGVyIHwNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dw0KPiAubGluYXJvLm9yZyUy
RmxpbmFyby1ibG9nJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jDQo+
IG9tJTdDYjM4OWU2NzFlYWZiNDQwMDE0ODIwOGQ2NDMyMzczODMlN0M2ODZlYTFkM2JjMmI0YzZm
YTkyY2QNCj4gOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjc3MDIxNjg3NDU0ODI5MyZhbXA7c2Rh
dGE9OUpkVk1PcGRpSQ0KPiBIZHhWckZiaURnYmxBdW5vZDlSWWt6d1lSYUhjc2d6VW8lM0QmYW1w
O3Jlc2VydmVkPTA+IEJsb2cNCg0K
