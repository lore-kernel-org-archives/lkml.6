Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF33C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749762183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="GOgFufrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBTKwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:52:32 -0500
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:21694 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfBTKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:52:32 -0500
Received: from pps.filterd (m0111313.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KAonZD027638;
        Wed, 20 Feb 2019 11:52:23 +0100
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53])
        by mx08-00287e01.pphosted.com with ESMTP id 2qp9tgmfm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 11:52:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aLPNVShwGA3khsYHunkp4c5+53UJHTQDK1pKzAazew=;
 b=GOgFufrKRFKymYnf29y3HaRgrIB2OWdS71kFnEhqN53kRGKSAHWY6f9ik2eDAICdGSZbJW1hQ0uorqxlZCDvKxcjlvdu+0p3GJ8AUfelZnc1WSOLH7CrSrobX0L6owLcYOy76UD1gt/HakUNFgRFdz9QQTskjIH2kKYsp4eQCQo=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB2973.eurprd04.prod.outlook.com (10.170.228.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Wed, 20 Feb 2019 10:52:17 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045%4]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 10:52:17 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erwan Velu <erwanaliasr1@gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Report if CPU doesn't report boost technologies
Thread-Topic: [PATCH] cpufreq: Report if CPU doesn't report boost technologies
Thread-Index: AQHUyQSU2+jyhhtXBUKIcEGI18/7rKXof42AgAADGQA=
Date:   Wed, 20 Feb 2019 10:52:17 +0000
Message-ID: <1d9ff7a8-5f05-6554-d019-9665536aea84@criteo.com>
References: <20190220101017.19587-1-e.velu@criteo.com>
 <CAJZ5v0i5BVFRKsCVxDwG90vBAuS3QYB=-GkC0pbGLy5DWDXuMg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i5BVFRKsCVxDwG90vBAuS3QYB=-GkC0pbGLy5DWDXuMg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::29) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60d52d8f-fd85-436b-824b-08d697217b0b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2973;
x-ms-traffictypediagnostic: VI1PR04MB2973:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIyOTczOzIzOjQzMUxreE85UVJDa3ZjVXBNOFNOMEdjQy9K?=
 =?utf-8?B?eWFOQVNCNm9FY1U5RHg1dzdGYThpSFdzRUl0SmE0Vld0aEQ1ZWVJYldwejJn?=
 =?utf-8?B?TGdScUk2TUpjY0ZTTERwREZyb2xBdUVMWUQvQ3VYTGo5WW5FSUhNcmdYZ3do?=
 =?utf-8?B?bVR1L1JaT1pZRUJLdXErV0FDMEFoeFF1SXM4YkN4a01MQkptNTJrR2RhS3pP?=
 =?utf-8?B?d0srZmwxbTdsYTg4TFZzZ2dQYUxsT0s2Q2ZkM0NPWGZ4WWFYMWpBNFNFZXRL?=
 =?utf-8?B?ejFrTjVMSkdyZWk3aVRLd0pKZE1MR3hhU3N3aXY2TGYyMGRzMG5YSmpxYnVS?=
 =?utf-8?B?NWxuVVFndmlPVi9YTmt0UjVsaUg5akNDbUxndWpKcFFKZ3ArVU9tZTdublZF?=
 =?utf-8?B?WmRCNk0xYW5hOW9uNmphVUpaYzJxY1hLM2h1ZWRpamxnUm5DSkVpUHZyVHpV?=
 =?utf-8?B?L2xDdnJEVnlWazdtNW5iWDR4aHlkWU00d3pGdVp0UGFqdUVSa1lvUEx2NVQx?=
 =?utf-8?B?MExpQjBzZGdQams4Z0U0ekxHZVMzL1BGZDgzUmlWaEZJeDJ0cEJNcUZPYllN?=
 =?utf-8?B?OS9pYUVoYjZhUjlFT0VSMDRLMU1LYWFGdlgzdGFWakJyWFNqOHBsd3JlNkhY?=
 =?utf-8?B?T1NjOUVzWkNKNTdvVFNqTGVhYk41VXNYV1JYZDVYSXlRdWJHQ21aaDhNbFR3?=
 =?utf-8?B?cFF0eVc0TFE1VSs0bnB0VG1iSFduREFuTFk1QmZ4K0w1K2wvUFdjV1ZVMjlp?=
 =?utf-8?B?VFFlM0pTVERRbXlMaHdJK3B5M2s0QmwwYkVNN24zajZZVVRlUDV4ckxNUVoz?=
 =?utf-8?B?eEpENkcyN1FsT2N5cmJ0SWt3aGtZNUM3OS9EcEU4Y1pkSVFYaldxUU9JcVdD?=
 =?utf-8?B?cVJYdlRhUjI5ZnJHMmQ5TnMvaExzV0VSODJxNUU5ck51VTNBVzN3ekY5TWFG?=
 =?utf-8?B?d3pJQWlOTkwrOGNVb0xreUJ3anE2WUNxWkQwQVF3clYxcDJIQTl0VnFsWXNL?=
 =?utf-8?B?NDI1T2YvTXB5SXFTemFUS1dJSDJUQUxLekdiblltWjR2ai9pcU9lbkpNRHV2?=
 =?utf-8?B?bmZYS0FzaGNJR3Zrc25NLzVkNktLWlJGd212TzI2bmRhZ3RucCtuTVZ4M094?=
 =?utf-8?B?T2ZuUmtTVnVncERUQjBJc0dDK0FWRFhJWjcxb2ZUbFdKZ0lnaVdrZUVTVDli?=
 =?utf-8?B?d2NOR3EyMWdvb2hxWi9tUE9WenNucUtyY1dIQXB4Uys1OXpsVjhOM0FRUW5K?=
 =?utf-8?B?SHhyNVZZS1pxUTFoQlJ5UitLcDFxYzdHZk83REtibUVSTFkzRTdUb3I2My9u?=
 =?utf-8?B?a2FEaE9wditjZWpXejFxY3ZnTHBsZzdiRk81eVFoSlZya2dZVkJNUDhLN0R6?=
 =?utf-8?B?cFlLdE91SVN6R1RQSHVhSGhmaXV2QTgzRndYbU1YU0JqN0RWUnl3SXdEMUZO?=
 =?utf-8?B?T3dpQ3J4QVZzREE0NXQ1V09QNDNXeDVlWWtLbk5jZXNTenZqWDhLb0lBSFVD?=
 =?utf-8?B?MUZoK2xtbUxzZGpqVE5lK3dzeHprN0N6RTNhV0JkNm4zRlA3akZZWkxockxC?=
 =?utf-8?B?SU5WY0ptNytTaTVkWmI1cEV5U0U1eDB6ZmJkMjhONFVCSGlTbWRiMk1HeThz?=
 =?utf-8?B?SUZxNGZsMnQwV1pmNnM3eHhaOGVHVGMvR2cvYVIrQ1pFSFh4bHVIVkczWW5R?=
 =?utf-8?B?ZjZ0RUZoL2lHc0toQVFyZDJ6bk9taGtXak9DRnlQcGM1b0dTWlZtR1BjKzVN?=
 =?utf-8?B?eTF5U2RudWxwWDZ1L0FuQT09?=
x-microsoft-antispam-prvs: <VI1PR04MB2973C162FC1B7D959D0D0D38F27D0@VI1PR04MB2973.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(4326008)(6512007)(36756003)(25786009)(14454004)(2906002)(105586002)(6436002)(229853002)(6486002)(31686004)(53936002)(6246003)(6116002)(3846002)(446003)(66574012)(486006)(7736002)(99286004)(110136005)(11346002)(476003)(2616005)(71200400001)(97736004)(102836004)(386003)(54906003)(316002)(256004)(305945005)(81166006)(8676002)(478600001)(68736007)(66066001)(31696002)(81156014)(8936002)(26005)(186003)(106356001)(52116002)(76176011)(86362001)(71190400001)(6506007)(53546011)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB2973;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +hwSOMwkdplaD/mrecJbSsA66aAdLnDWjISqm6PbrXAbOVoIqaAq+3ausnXMZnXoDlWsZeEEk001sCZpdjL1NvSzIyy8MLAltwg6t450zkuRviDYDmoJKN2/0w7zJ0/bc1/V//exF7DFtV4tTalhpkakqNN5pJF9dI8clqvpLFj2Uf42lAPizxc1ff4XDt2qcWUlFYeZ52pAZPsBBAVF1g0jgxwhVExD16PgpI0BIjKnBawgTKw/de7xdd+qLPfi8El+8DR7QHWeK8aAS4bsS0sQ7gjMpUDtP46YAqSLfvdW1vSw5m+DI+b3iwCHXXSgPZc1vvZejdFCgms8cRYcIAafE0kKHVbNdWuGhcKAZH3Xsf/BOtsvX4T4OCRpnbS2dnzcSQ3PWaxNfAH4iXB9sQqBcO8d720Nhcf8QBPkFZs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE710AE54F65B5489681AB953382DA7E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d52d8f-fd85-436b-824b-08d697217b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 10:52:17.0748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAyMC8wMi8yMDE5IMOgIDExOjQxLCBSYWZhZWwgSi4gV3lzb2NraSBhIMOpY3JpdMKgOg0K
PiBPbiBXZWQsIEZlYiAyMCwgMjAxOSBhdCAxMToxMSBBTSBFcndhbiBWZWx1IDxlcndhbmFsaWFz
cjFAZ21haWwuY29tPiB3cm90ZToNCj4+IFRoZXJlIGlzIHNvbWUgcmFyZSBjYXNlcyB3aGVyZSBD
UEIgKGFuZCBwb3NzaWJseSBJREEpIGFyZSBtaXNzaW5nIG9uIHByb2Nlc3NvcnMuDQo+PiBUaGlz
IGlzIHRoZSBjYXNlIGZpeGVkIGJ5IGNvbW1pdCBmN2YzZGMwMGY2MTIgKCJ4ODYvY3B1L0FNRDog
Rml4IGVycmF0dW0gMTA3NiAoQ1BCIGJpdCkiKSBhbmQgZm9sbG93aW5nLg0KPj4NCj4+IEluIHN1
Y2ggY29udGV4dCwgdGhlIGJvb3N0IHN0YXR1cyBpc24ndCByZXBvcnRlZCBieSAvc3lzL2Rldmlj
ZXMvc3lzdGVtL2NwdS9jcHVmcmVxL2Jvb3N0Lg0KPiBTbyBJJ20gbm90IHJlYWxseSBzdXJlIHdo
eSB0aGUgZXh0cmEgbWVzc2FnZSBpcyBuZWVkZWQuICBJdCBsb29rcyBsaWtlDQo+IHRoaXMgbWVz
c2FnZSB3aWxsIGFsd2F5cyBiZSBwcmludGVkICh3aXRoIGRlYnVnIG91dHB1dCBlbmFibGVkKSBp
ZiB0aGUNCj4gY3VycmVudCBjcHVmcmVxIGRyaXZlciBpcyBhY3BpLWNwdWZyZXEgYW5kIHRoZSBi
b29zdCBhdHRyaWJ1dGUgaXMgbm90DQo+IHByZXNlbnQgaW4gc3lzZnMsIHdoaWNoIG9ubHkgaXMg
dGhlIGNhc2UgaWYgQ1BCL0lEQSBhcmVuJ3QgdGhlcmUuDQo+DQo+IERvZXMgaXQgcHJvdmlkZSBh
bnkgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiwgdGhlbj8NCg0KV2hlbiB5b3Uga25vdyBhbmQgcmVh
ZCB0aGUgY29kZSwgeWVzIHRoaXMgcGF0Y2ggaXMgdG9vIG9idmlvdXMuDQoNCkFzIGEgdXNlciB3
aGVuIEkgd2FzIHRyb3VibGVzaG9vdGluZyB3aHkgdGhlIGJvb3N0IGVudHJ5IHdhcyBfbm90XyAN
CnBvcHVsYXRlZCBvbiBvbmUgQ1BVIGFuZCB3YXMgcG9wdWxhdGVkIG9uIGFub3RoZXIuDQoNClJ1
bm5pbmcgYWNwaS1jcHVmcmVxIHdpdGggZHluZGJnLCBJIHdvdWxkIGhhdmUgZm91bmQgdXNlZnVs
IHRvIGdldCB0aGF0IA0KaGludC4NCg0KU28gdGhhdCBjb3VsZCBoZWxwcyB1c2VycyB0aGF0IG5l
dmVyIHJlYWQgdGhhdCBwYXJ0IG9mIHRoZSBjb2RlIGFuZCANCndoaWNoIGFyZSB0cmlja2VkIGlu
dG8gdGhhdCBjb25maWd1cmF0aW9uLg0KDQpFcndhbiwNCg0KDQo=
