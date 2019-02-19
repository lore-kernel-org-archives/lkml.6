Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A38C21903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UUJ6u0ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfBSHVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:21:07 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:45888
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfBSHVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxPgXO+BPC2bRQwC/VnVWBPbyzcwgeT8JpRjwtaRq5I=;
 b=UUJ6u0kaq4pVMNTAbFXPH/8e6ond99kCjwcKNsfuSxls2aY8Zmg7jQ7fr2TWs44kyV+42gUhGDw7Ohp1gHXJPK7/c1LmdZ9rxbghuVMhWSUNDr1mTScSFDoZZkAf7Xq31A/dhbwff7dxeeR5urceVXCltevXcUoB74gLEEKbpQg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 07:20:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Tue, 19 Feb 2019
 07:20:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUvsrbmfXgtz1KZEeItOtlZ1aFAqXdPkZwgAmLQ2A=
Date:   Tue, 19 Feb 2019 07:20:58 +0000
Message-ID: <DB3PR0402MB3916C9B1A6F0E4C6352BA43CF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB39165EFE027405873E8AB4ECF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39165EFE027405873E8AB4ECF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d733010b-45b3-48e4-50d0-08d6963acb91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3692;
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM2OTI7MjM6TjBrekpBc09RWlZ6eWI2SHh5TUlJOGY3?=
 =?gb2312?B?VzBFdnBaQnBwMWZlRnp1alRKQ1F4WXhRT0xwSFZ0K1I0WE9HY043Vm5QUWx0?=
 =?gb2312?B?TWozMjNEbGUzeU12WGRpMkVDQjhiY0tvNUdrNXBzSFBldmhPaWhrTjd3eUQ0?=
 =?gb2312?B?ZlByV3UvNElEeGJBUjlhNHJlYXJWVFdhM1hOQ0NRVmRwYTZYSjNVNU42WTUx?=
 =?gb2312?B?dS9FSzdCZmRvaTllR0l1OE5uSDErMkdRazBPY1F4RUV6VHNiVDdqbVE1blRr?=
 =?gb2312?B?eEpnWXlRbzBIWWgxUmpPVlVWN2ZTcjRxTkZGdk9pV2VIRVYrSTQ3bTdsZCt3?=
 =?gb2312?B?aTNJemdkVGZDV2d3T01nSHAvcnpiZnJnNSt2OEJtd3NBaEpZd2MySWNCRW1m?=
 =?gb2312?B?K1NWUEM0M0NIYXF6aThQSWUwODVYQ3lCUmRjY2VJTStLK1hDbEF5Qkdnekt5?=
 =?gb2312?B?eHBjWjBZV2tJRmxDTm1IcGt5dEpJRVVVdEZPcTZDYkllWTRQM1NGQ1Z2VTYx?=
 =?gb2312?B?NGtxVEdabFFySlllZkE2SjlsbE85ZzVRK0hPSVhiTDZwRng1bFFiRjNDc1lt?=
 =?gb2312?B?eDBiYXlycXhqMmhhQW9XbjRuWHdEeWVBdDJ3bEtzbXRHLzhmUzdqUjBQS3Vs?=
 =?gb2312?B?emlrS3ZSdGI4RmxYTUtiVWRYZkljVE1nMGMvbEFxSUt4SVkrbmVQVVE5V0xR?=
 =?gb2312?B?N1g0MyszaEl3WEJFMFRJT2U2RlFKN21MUEt3MzhsTE5YRkxiM0RVM1RFaXQy?=
 =?gb2312?B?cG5PbGdvTlpLOVZseXVJV21qMXJPaXRCbDRYNFZGQjdqTk9Ddi8rL1dZbDhW?=
 =?gb2312?B?UlczVmxDY2VDTXVXMjNrNk5tT2ptZFNsWmVmRU9tWndEN1lQemQ0c3lDV0ln?=
 =?gb2312?B?ckZGakN6UHFySmxiOWh3SUxXcENUbDAxNkZQWDhBK2VKcS90Mm9uZ2lsVlpM?=
 =?gb2312?B?cWd0QzVOZE9abWJxRWg3YjNnZzRxUFZTakRvWlRXMldUcWh1RlUwYm9mSXgr?=
 =?gb2312?B?M3ZMdUREckxzbU1XalUveGkzVFFtR1BURkdpRU93alFMZVZTUGpiNHJMZi92?=
 =?gb2312?B?R1hodTlzOUlQc3ZjalFKQ1BUU3RBVSswNDNTWW9VQmU5UUFQOTdjRGw5aStZ?=
 =?gb2312?B?STIvR3dCbVQ2MGQxUjhVcW9Kdys0eWxGOXJCOTErMVBKQVk3SWhXNHpBQk1p?=
 =?gb2312?B?eU9vaHZpWm9SeEFhVS9ReGhqUVptVy9rMms5QytyTzBndjd2d3J3NzNBd3lw?=
 =?gb2312?B?eGYzZm5oNEM2RDlBNHJBVDBPQjRKWFl4dDFPR3ZaRkVoYzh2MDhxUjNnS0o3?=
 =?gb2312?B?R0NVaFVidlNQY1NtcnZPUWgzUVFZZ2dzOHhyNnVhV0xneGExd3gvN1dkQ0xZ?=
 =?gb2312?B?TUp5MEpZWEkyTHh0WWlJSVhBcVZyMFN5ZWhyK0FtY3lxNnZIQ0ErZGhrWGZ5?=
 =?gb2312?B?REF1dnNRUFRUK1ZvZ0gyVmJvRVNPS2VHa09IRW5IZ21nWi9DZXZaSzhjcmVD?=
 =?gb2312?B?NzF0VmcxazBocXkxUXpIOFNnR3Z3QlJldEkrSlpFU09mcEV2Nm5wZkJPLzdK?=
 =?gb2312?B?UUdvcGw0SUROc2dhd2kxUExsWXV4Yks1ZHZnQTBMN0JFRFMyYlAxYUhBK2hp?=
 =?gb2312?B?U0FPZVoxM0VFVXYzQk1zcVpuZGlVb085UVVtelFmeGJ0MnVzR2FjTDRJUXVQ?=
 =?gb2312?B?SHRBR2MrSkJNSlk3S3Nac0hteUVIdzhHL2ZZOG5McmJEK0xqZHRldDRuejB6?=
 =?gb2312?B?ejk0cmhGU2RQRjlRRmlkMy9USVBFcVBQOWNueGFYbE1yTVNQYlVsMFgxZE55?=
 =?gb2312?B?b2RMS0N1TDRGVDJuUlMzWTRkdmdOSFE1MndXN3BHZXZDSHlZMkZrOUwwUHR0?=
 =?gb2312?Q?dne+T4JAP/xjY=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3692927A63CA4DF07DCCAFCAF57C0@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(376002)(39860400002)(189003)(199004)(13464003)(54534003)(66066001)(86362001)(2201001)(8936002)(26005)(6246003)(8676002)(53936002)(25786009)(4326008)(186003)(2906002)(71200400001)(105586002)(81166006)(81156014)(71190400001)(2501003)(106356001)(6506007)(53546011)(97736004)(256004)(99286004)(102836004)(478600001)(7416002)(7696005)(74316002)(110136005)(316002)(6436002)(14454004)(33656002)(3846002)(229853002)(6116002)(305945005)(11346002)(7736002)(446003)(55016002)(9686003)(76176011)(5660300002)(486006)(68736007)(44832011)(476003)(921003)(15866825006)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vhn/5SM4TSKiplKOP+pD67cBvvYvLfLtbsu8osUQLxzUfO8h+fLIxWPPi1M3mbYCmqRoptz4540ZyP1r+fknetMnMmKwUaUE61FxeYsgu8kNvwoABWGSK9mlUOMT0nh3gIUy4Uad3mmfFN2GQOTM6DL7BX7YBapVk35/1HCT9C6icxIxXeWzHlWDb710gJlTrFm5q6pzLucYQu6dbcB2wP9vxwm/0UizwfEyJ/SZVO96NFdIwd1w01ungC1V1q1mhRnLqDVxaSuJVDo2UWBk++cGqpa4EZl1/rLE7LWXePf0+UQGOurr+skm9Ca2FKwk32g99xagqwySIgjaVyZQ9/LxxeBFTK/T0K8PeS+qa83SLlODwD6hb8yHGPVQ4mMGKmQR4Vz4QgKD1Ss+rFc4gSVOymKa1lJ+jIImV9R68SU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d733010b-45b3-48e4-50d0-08d6963acb91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 07:20:58.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nDQo+IFNlbnQ6IDIwMTnE6jLUwjEzyNUg
MTM6MzYNCj4gVG86IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNv
bTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgcnVpLnpoYW5nQGludGVsLmNvbTsNCj4gZWR1YmV6dmFs
QGdtYWlsLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nDQo+IDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IERhbmllbCBCYWx1
dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1
OyBBbmR5IEdyb3NzDQo+IDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBoZWlrb0BzbnRlY2guZGU7
IGFybmRAYXJuZGIuZGU7DQo+IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207IGphZ2FuQGFtYXJ1
bGFzb2x1dGlvbnMuY29tOw0KPiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgZW5yaWMuYmFs
bGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7IG9sb2ZAbGl4
b20ubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0N
Cj4gcG1Admdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFY2IDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1
OiBhZGQgdGhlcm1hbCBiaW5kaW5nDQo+IA0KPiBHZW50YWwgcGluZy4uLg0KPiANCj4gQmVzdCBS
ZWdhcmRzIQ0KPiBBbnNvbiBIdWFuZw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IEFuc29uIEh1YW5nDQo+ID4gU2VudDogMjAxOcTqMtTCN8jVIDE3OjUzDQo+
ID4gVG86IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7DQo+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207
IHdpbGwuZGVhY29uQGFybS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+ID4gZWR1YmV6dmFs
QGdtYWlsLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nDQo+ID4g
PGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgRGFuaWVsIEJh
bHV0YQ0KPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBob3JtcytyZW5lc2FzQHZlcmdlLm5l
dC5hdTsgQW5keSBHcm9zcw0KPiA+IDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBoZWlrb0BzbnRl
Y2guZGU7IGFybmRAYXJuZGIuZGU7DQo+ID4gbWF4aW1lLnJpcGFyZEBib290bGluLmNvbTsgamFn
YW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+ID4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7
IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207DQo+ID4gbWFyYy53LmdvbnphbGV6QGZyZWUu
ZnI7IG9sb2ZAbGl4b20ubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7DQo+ID4gbGludXgtIHBtQHZnZXIua2VybmVsLm9yZw0KPiA+IENjOiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSCBWNiAxLzRdIGR0LWJp
bmRpbmdzOiBmc2w6IHNjdTogYWRkIHRoZXJtYWwgYmluZGluZw0KPiA+DQo+ID4gTlhQIGkuTVg4
UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRlIGFzIHN5c3Rl
bQ0KPiA+IGNvbnRyb2xsZXIsIHRoZSBzeXN0ZW0gY29udHJvbGxlciBpcyBpbiBjaGFyZ2Ugb2Yg
c3lzdGVtIHBvd2VyLCBjbG9jaw0KPiA+IGFuZCB0aGVybWFsIHNlbnNvcnMgZXRjLiBtYW5hZ2Vt
ZW50LCBMaW51eCBrZXJuZWwgaGFzIHRvIGNvbW11bmljYXRlDQo+ID4gd2l0aCBzeXN0ZW0gY29u
dHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkgSVBDIHRvIGdldCB0ZW1wZXJhdHVyZQ0KPiA+
IGZyb20gdGhlcm1hbCBzZW5zb3JzLCB0aGlzIHBhdGNoIGFkZHMgYmluZGluZyBkb2MgZm9yIGku
TVggc3lzdGVtDQo+ID4gY29udHJvbGxlciB0aGVybWFsIGRyaXZlci4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IFJldmlld2Vk
LWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+IENoYW5nZUxv
ZyBzaW5jZSBWNToNCj4gPiAJLSBhZGQgImlteCxzZW5zb3ItcmVzb3VyY2UtaWQiIGluIGVhY2gg
dGhlcm1hbCB6b25lIHRvIHBhc3MgcmVzb3VyY2UNCj4gPiBJRCBmb3IgdGhlcm1hbCBkcml2ZXIu
DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNs
LHNjdS50eHQgICAgfCAyMA0KPiA+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNs
LHNjdS50eHQNCj4gPiBpbmRleCA3MmQ0ODFjLi40Yjc5NzUxIDEwMDY0NA0KPiA+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0
DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2Nh
bGUvZnNsLHNjdS50eHQNCj4gPiBAQCAtMTIyLDYgKzEyMiwyMCBAQCBSVEMgYmluZGluZ3MgYmFz
ZWQgb24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wNCj4gPiBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+
ICAtIGNvbXBhdGlibGU6IHNob3VsZCBiZSAiZnNsLGlteDhxeHAtc2MtcnRjIjsNCj4gPg0KPiA+
ICtUaGVybWFsIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQo+ID4gKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArLSBjb21wYXRpYmxlIDog
TXVzdCBiZSAiZnNsLGlteDhxeHAtc2MtdGhlcm1hbCI7DQo+ID4gKy0gdHNlbnMtbnVtIDogVG90
YWwgbnVtYmVyIG9mIHRoZXJtYWwgc2Vuc29ycyBzdXBwb3J0ZWQ7DQo+ID4gKy0gI3RoZXJtYWwt
c2Vuc29yLWNlbGxzIDogU2hvdWxkIGJlIDEuIFNlZQ0KPiA+ICsNCj4gPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC90aGVybWFsLnR4dA0KPiA+ICsJCQkgIGZvciBh
IGRlc2NyaXB0aW9uLg0KPiA+ICstIGlteCxzZW5zb3ItcmVzb3VyY2UtaWQgOiBUaGlzIHByb3Bl
cnR5IHNob3VsZCBiZSBkZWZpbmVkIGluIGVhY2gNCj4gPiArdGhlcm1hbA0KPiA+IHpvbmUNCj4g
PiArCQkJICAgb2YgdGhlcm1hbC16b25lcyBub2RlLCBpdCBwYXNzZXMgZWFjaCB0aGVybWFsDQo+
ID4gem9uZSdzDQo+ID4gKwkJCSAgIHJlc291cmNlIGlkIGZvciB0aGVybWFsIGRyaXZlciB0byBn
ZXQgdGVtcGVyYXR1cmUNCj4gPiB2aWENCj4gPiArCQkJICAgU0NVIElQQy4NCj4gPiArDQo+ID4g
IEV4YW1wbGUgKGlteDhxeHApOg0KPiA+ICAtLS0tLS0tLS0tLS0tDQo+ID4gIGxzaW9fbXUxOiBt
YWlsYm94QDVkMWMwMDAwIHsNCj4gPiBAQCAtMTY4LDYgKzE4MiwxMiBAQCBmaXJtd2FyZSB7DQo+
ID4gIAkJcnRjOiBydGMgew0KPiA+ICAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXJ0
YyI7DQo+ID4gIAkJfTsNCj4gPiArDQo+ID4gKwkJdHNlbnM6IHRoZXJtYWwtc2Vuc29yIHsNCj4g
PiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy10aGVybWFsIjsNCj4gPiArCQkJdHNl
bnMtbnVtID0gPDE+Ow0KPiA+ICsJCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MT47DQo+ID4g
KwkJfTsNCj4gPiAgCX07DQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNy40DQoNCg==
