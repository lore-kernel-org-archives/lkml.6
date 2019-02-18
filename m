Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A12EC10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5BF218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mN7zAin8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfBRGMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:12:15 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:48819
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfBRGMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMXo+Mq1YJoMpr8sdX7SztR5/Av6FO/miJ3193kxtZ0=;
 b=mN7zAin8Z/iWw0YrZT9+gbAB4cgjeZSsNF686ehPefzRK4hgomargGplU8iUU19Fpcb3Ct+yb9MxXTKWKLx2BfLnUgvEcstllM1gFmJd5wTQov15Wbt3rryvHcksG25ufNZ3hgxgsYiee8PJWJ8xVnf4NldWGqBkUZixkcRqdQg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3849.eurprd04.prod.outlook.com (52.134.71.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:11:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:11:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 0/4] Add i.MX8QXP system controller watchdog support
Thread-Topic: [PATCH V2 0/4] Add i.MX8QXP system controller watchdog support
Thread-Index: AQHUxy3SjzHfKLwYjUOtmItPpKm1yKXlA9AAgAAOxaA=
Date:   Mon, 18 Feb 2019 06:11:50 +0000
Message-ID: <DB3PR0402MB3916CB0E548CB6294DCFF7EFF5630@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
 <02ea476f-d055-ac12-d1b6-c6caffb14614@roeck-us.net>
In-Reply-To: <02ea476f-d055-ac12-d1b6-c6caffb14614@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1c1b3e2-c99f-4b18-47ea-08d69567f8f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3849;
x-ms-traffictypediagnostic: DB3PR0402MB3849:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM4NDk7MjM6K1VkMTFGcm9QN2dlMVJDVUp0K0RwMXZw?=
 =?utf-8?B?RHRVWWtpelp2bVVJNkRCMmhlU1Q1am0wRkc4ZkFNcWZhdFN2NkNuL2dlV0NQ?=
 =?utf-8?B?QlRtZFFwWlJka2tYcmNSZDhxNmQxLzN6S25lZ3NVRGFLUUlSSDlLVytiZ2xo?=
 =?utf-8?B?dkFvanNRRUdqWUtwQlZjQm5WM2Zxczd5Um5EOG4zTENZblZjWFpxVzIzeFVG?=
 =?utf-8?B?aWtwK3A3dGFCYklTNnIyOXdtQm5rdE1HZkQ4M2NFM0xWRVR0YjBNVHd0dXdR?=
 =?utf-8?B?VDROR1hLRlgxT0FsOXU5UWhHTHpBMk1zeXVzYzJyYTU3NkdMcEVpWlNDVmlT?=
 =?utf-8?B?Q09BamRTci9CcXBwdDhMaTJJcytoampIV0swckQzbTBDRXZYNlhyM2VyMm0y?=
 =?utf-8?B?cWR0cGpxMmkxY3VyZklBcEc4MTlsc1RFdmw2Q2ZUSlgvWnZiaDB3VFFEc0FF?=
 =?utf-8?B?MzJnNXc5dENUblNEZldhWUJla0JqOHdVRS9mMEo1ZVVWV1RJalpwemJ2N2Nt?=
 =?utf-8?B?MXJyc2NRM2R0bzhMMmdIV1FPT3g0Q1puWUZzTDBmYmpzRmVBdXc2N0Q3WWVO?=
 =?utf-8?B?RHlrWk1XaGVkYzgzd1ZqaXVYNyttRHYxVFQ1Y3FDbG1qRC9DZDZydXZBbFB5?=
 =?utf-8?B?SlRjVTlrUzBXOU1kVHd2TlJvRTZrenJJN2RqUWxaWWZiZFRWRWpLQkxPM3lN?=
 =?utf-8?B?RHhTL2llYnlXcmZoeFJOcGU4cS9RZDRkL2tTaDVyb2sxR2p0QmhLU2FuMVE5?=
 =?utf-8?B?aEJYZjB5Nm0xSGMxSmdqTHRkaXJpVXc0L2JCaHh0OE5RNC9UQXNveWYxZWN5?=
 =?utf-8?B?cXpWVWxxSUpLdkdFcmJwc1ovSndPU0tLSG03OXgxKzZWYXVLUm9yaVlaeWZp?=
 =?utf-8?B?aVNXa2UvaEdDVlB5ZndYK2JUMEpyb3hsM0lleGttTDVvUzJDK085S01YMHJy?=
 =?utf-8?B?TVZiZUdwVTl2eHlqN3ZFVmFGNXBmNUw0aTN3ck1ocHNHS2FoTUdWSVU2OTZO?=
 =?utf-8?B?UUwzUFpNZEc0VDA2K0d2bUhTMGwrNkZSYnc1empGT3c4S3U1SnhqckZBandY?=
 =?utf-8?B?Y0xEdWlWUitJckFtMGJXNlVXeUF5MkllYXdNdnhwemtuVFdHTUdMTWdobGpm?=
 =?utf-8?B?a0I3Q2s4YXd0MFRvcmpjaFd6VUJpSEEvMDZuRWtCWkVSMFh4UnFCeExHR2Zq?=
 =?utf-8?B?NlhwVUNDRy9rbDZrOThRTHhndmxDUy9MTkZQOTZFZW03MFE4cnUzQUd5UW9O?=
 =?utf-8?B?QW54ajA3bk5rK0xXNm1zaitEVGV2VitZeDZHbjFIYXhjeEVqcjRQSjFNa203?=
 =?utf-8?B?Qmd3RSsrRkxzMC93R3hxZVMxUXIzM0dXQVZ4d2ZoenY1ZENvYjAzUithVTkz?=
 =?utf-8?B?Rjg3bjRueUp1b2hGK3JvZGZhZGJHRk4vOFh3bTRkdXUrL2dTWk1ITlY1cTJt?=
 =?utf-8?B?ODdZSEZhZmtudU5iYUQxdUZBMDQzZDQvSzhhaW9CWmJhYmplUGJmVHg2eXBt?=
 =?utf-8?B?NHcwdFVrcFNJSmN2d1VqS0ppSndvdWg5WFhLZnpnZ3B6V0JQVTNjMUdOMkZy?=
 =?utf-8?B?V2JxMUdiOXQ2a3YzSTJIMGprQzdXdWpycmNhemlEazF0V0kzYTZWYUl4M2hO?=
 =?utf-8?B?Y3NPeVJNNDZzQVd6a1NyTFZVaVRJUm9OeENvMXBEQmFhMjk0dGUzcHpoV3dK?=
 =?utf-8?B?M21vS2syeDNickxseEMzc1ZoSmkxejE5cnF3cCtqOXVpVCtITExoMWQ5NFZn?=
 =?utf-8?B?Z3YxS0NJZjJJK3hqWnJDMlhCcnU1WGNJWEZMb1FFd1ZuSVZCd09OMGNTUjJW?=
 =?utf-8?B?L3NkWEZ2K2FRamlSRzNvdGhxaFg3UWZWbWxPWEFtZEc5YlFGUXRIMlFITUQ4?=
 =?utf-8?B?UkU3SmMyc2lGSjh0N1NWUS9wRVVMNkpkQTlRSGpja1IvSWV5djRrQUxOd2RR?=
 =?utf-8?B?UUlJcjRjMUpBTDU1RmxoMDlYVkY3Q2ptS3dQYzZkb2syTjVxVWRHSzBNZnhT?=
 =?utf-8?Q?hXPAQJwi?=
x-microsoft-antispam-prvs: <DB3PR0402MB384980187A1E791D604B9639F5630@DB3PR0402MB3849.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(54534003)(13464003)(25786009)(3846002)(6116002)(478600001)(4326008)(2501003)(14454004)(74316002)(229853002)(305945005)(5660300002)(2906002)(316002)(966005)(106356001)(68736007)(110136005)(7736002)(105586002)(45080400002)(7696005)(76176011)(99286004)(102836004)(26005)(256004)(81156014)(446003)(11346002)(6506007)(6246003)(53546011)(14444005)(186003)(55016002)(53936002)(44832011)(476003)(33656002)(486006)(71200400001)(97736004)(66066001)(71190400001)(8676002)(9686003)(8936002)(6306002)(2201001)(6436002)(81166006)(86362001)(7416002)(921003)(15866825006)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3849;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oPsg4wL1PfaYuHqw/EFFP2l9qWHv5LnewIc8A2tnElx4MUtFZWMZvy925uFjihoKVFJzy9yyWmgVPSDbMKa0S/VRBMkrFkGxBwQ5dOAwzc5FGY9h2VJ2dbEQXUUd9Tqlm2/l47Wfd+vUp7xzrSem3RMNKR6xQBqrD4uloFtt/iKK+1NPFxhnSXR2KumsGlqBMwf/pQaOer3vm4goK4R/XpfpnBPte0UMVdEDEA7n4fAELWMSoaDyFBt9vHR/FJ0A6YkFhnyxTt1Rl+fUAroMHNi6B7oCXcEBYcR/vSoJ0ZxV80s+za9zX8EESGz1lyLEMdUupTLQ3k43L5f0oBZw9bPQy+auxTCZ1VDwCuTu28I3+M2Qujc8F638BtLsQMh9vg9OJlEs9TUjb8N+BnrtW8Y6SueLScZtwKQaJ7Ympt4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c1b3e2-c99f-4b18-47ea-08d69567f8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:11:50.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1ZW50ZXINCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIFttYWlsdG86Z3JvZWNrN0Bn
bWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVyDQo+IFJvZWNrDQo+IFNlbnQ6IDIwMTnlubQy
5pyIMTjml6UgMTM6MTYNCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsg
cm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRl
YWNvbkBhcm0uY29tOyB3aW1AbGludXgtd2F0Y2hkb2cub3JnOyBBaXNoZW5nIERvbmcNCj4gPGFp
c2hlbmcuZG9uZ0BueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgRGFuaWVsIEJhbHV0
YQ0KPiA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgQW5keSBHcm9zcyA8YW5keS5ncm9zc0BsaW5h
cm8ub3JnPjsNCj4gaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IGhlaWtvQHNudGVjaC5kZTsg
YXJuZEBhcm5kYi5kZTsNCj4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGphZ2FuQGFtYXJ1
bGFzb2x1dGlvbnMuY29tOw0KPiBlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOyBtYXJjLncu
Z29uemFsZXpAZnJlZS5mcjsgb2xvZkBsaXhvbS5uZXQ7DQo+IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjIgMC80XSBBZGQgaS5NWDhRWFAgc3lzdGVtIGNvbnRyb2xsZXIgd2F0Y2hkb2cNCj4gc3Vw
cG9ydA0KPiANCj4gT24gMi8xNy8xOSA2OjAxIFBNLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBp
Lk1YOFFYUCBpcyBhbiBBUk12OCBDb3J0ZXgtQTM1IFNvQyB3aXRoIGEgQ29ydGV4LU00IHN5c3Rl
bSBjb250cm9sbGVyDQo+ID4gaW5zaWRlLCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgbWFuYWdlcyBv
dmVyYWxsIHBvd2VyLCBjbG9jaywgc2VjdXJlIFJUQw0KPiA+IGFuZCB3YXRjaGRvZyBldGMuLCBz
byBMaW51eCBrZXJuZWwgcnVubmluZyBvbiBBMzUgbmVlZHMgdG8gY29tbXVuaWNhdGUNCj4gPiB3
aXRoIHN5c3RlbSBjb250cm9sbGVyIGZvciB3YXRjaGRvZyBvcGVyYXRpb24sIHRoaXMgc3lzdGVt
IGNvbnRyb2xsZXINCj4gPiB3YXRjaGRvZyB3aWxsIGNhbGwgU01DIHRvIHRyYXAgdG8gRUwzIHNl
Y3VyZSB3b3JsZA0KPiA+IEFSTS1UcnVzdGVkLUZpcm13YXJlIGFuZCB0aGVuIGl0IHdpbGwgcmVx
dWVzdCBzeXN0ZW0gY29udHJvbGxlciB0byBkbyB0aGUNCj4gd2F0Y2hkb2cgb3BlcmF0aW9uIHZp
YSBJUEMuDQo+ID4NCj4gPg0KPiBBbmQgeW91IGV4cGVjdCBJJ2xsIHNwZW5kIHRoZSB0aW1lIGNv
bXBhcmluZyB0aGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoIHNlcmllcw0KPiBhZ2FpbnN0IHZlcnNp
b24gMSBhbmQgZmlndXJlIG91dCBteXNlbGYgd2hhdCBleGFjdGx5IGNoYW5nZWQgPw0KPiANCj4g
R3VlbnRlcg0KDQpTb3JyeSwgSSBwbGFubmVkIHRvIHJlcGx5IHlvdXIgcmV2aWV3IG1haWwgYnV0
IGZvcmdvdCwgSSBhZGRyZXNzZWQgYWxsIHlvdXIgY29tbWVudHMNCmluIFYyIHBhdGNoIHNldCwg
SSB3aWxsIGFkZCB0aGUgY2hhbmdlIGxvZyBpbiBWMiB3YXRjaGRvZyBkcml2ZXIgcGF0Y2ggYW5k
IHJlc2VuZC4NCg0KQW5zb24uDQoNCj4gDQo+IEJlbG93IGFyZSB0aGUgcGF0Y2ggZGVwZW5kZW5j
eToNCj4gPg0KPiA+IFRoZSBkdC1iaW5kaW5nIGFuZCBpbXg4cXhwLmR0c2kgcGF0Y2ggYXJlIGJh
c2VkIG9uIG15IHRoZXJtYWwgcGF0Y2gNCj4gc2VyaWVzIGFzIGJlbG93Og0KPiA+DQo+IGh0dHBz
Oi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZwYXQNCj4gPg0KPiBjaHdvcmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTA4MDA2OTklMkYm
YW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc28NCj4gbi5odWFuZw0KPiA+ICU0MG54cC5jb20lN0M2MzBl
NmM1ZDdlZDA0YTkxMmY3NzA4ZDY5NTYwM2NiMiU3QzY4NmVhMWQzYmMyYjQNCj4gYzZmYTkyY2Q5
DQo+ID4NCj4gOWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODYwNjM3OTAzOTg0MjY4JmFtcDtzZGF0
YT1hMjVxSnMlMkZiNGUNCj4gMmE5RXk3N1UNCj4gPiBnVE5LQUdDUThJV1JjVUtiNEcwbEslMkJr
amMlM0QmYW1wO3Jlc2VydmVkPTANCj4gPg0KPiA+IEFuc29uIEh1YW5nICg0KToNCj4gPiAgICBk
dC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZCB3YXRjaGRvZyBiaW5kaW5nDQo+ID4gICAgd2F0Y2hk
b2c6IGlteF9zYzogQWRkIGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgd2F0Y2hkb2cgc3VwcG9ydA0K
PiA+ICAgIGFybTY0OiBkZWZjb25maWc6IGFkZCBzdXBwb3J0IGZvciBpLk1YIHN5c3RlbSBjb250
cm9sbGVyIHdhdGNoZG9nDQo+ID4gICAgYXJtNjQ6IGR0czogZnJlZXNjYWxlOiBpbXg4cXhwOiBh
ZGQgd2F0Y2hkb2cgc3VwcG9ydA0KPiA+DQo+ID4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICB8ICAxMCArDQo+ID4gICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgICAgICAgICB8ICAgNCArDQo+ID4gICBhcmNoL2Fy
bTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4g
ICBkcml2ZXJzL3dhdGNoZG9nL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
MyArKw0KPiA+ICAgZHJpdmVycy93YXRjaGRvZy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiA+ICAgZHJpdmVycy93YXRjaGRvZy9pbXhfc2Nfd2R0LmMgICAgICAg
ICAgICAgICAgICAgICAgfCAyMTANCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICA2IGZp
bGVzIGNoYW5nZWQsIDIzOSBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy93YXRjaGRvZy9pbXhfc2Nfd2R0LmMNCj4gPg0KDQo=
