Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09233C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCE8217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2tK5aifd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfBRLBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:01:49 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:8397 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfBRLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:01:48 -0500
X-IronPort-AV: E=Sophos;i="5.58,384,1544511600"; 
   d="scan'208";a="24028652"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 04:01:47 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 04:01:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4Ex/ux9ucCNTnVpiRf+sIeftwCc+r0cZAaWUZq4y9c=;
 b=2tK5aifdHINQOX7DT2g5VQD8mH5CcxI3ueGJBrFZ3s9kvHSnD3VqrLG3aCOLDiWbk+sljssfMRHi6BJ+Um/jjq9fexAHsRLS10Sd578zDWdsEmSc6eKhsGycBACxdHtEK1H2pr3aAjMFSAk2fTro7ePUQlDAXOsl/0SzibUfStk=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1279.namprd11.prod.outlook.com (10.169.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 11:01:45 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 11:01:45 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Topic: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Index: AQHUx3lWirob8lh2MUWvI8JBjCQ6WQ==
Date:   Mon, 18 Feb 2019 11:01:45 +0000
Message-ID: <97af1d45-d74b-87d3-c934-baae80307e1d@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
 <1550143407-26109-4-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550143407-26109-4-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::28) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9adb09a7-7fbd-4e85-948c-08d6959078ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1279;
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMjc5OzIzOlR4Qi8yMzZZTG5ZUSsvNTV1RGR0eVA5NXNX?=
 =?utf-8?B?OXNRaDBLN2owTEF6Zy9qcm9zc3RpNnFaMFluVjhqYTlmZVpDMmFURzBVdG56?=
 =?utf-8?B?WE9ndUFLSXRla05PNkp2YmZ2SDU5Z0V4SEN3dUxqWGhEejVuN05MbEs2djA1?=
 =?utf-8?B?dkVFRExWbmtzdWhpdkdDM0p3dUt0N2JGVFl3YlRsTnlRSHBlQVV2RkRwZU1D?=
 =?utf-8?B?S2lwUXZHc2RFY2Nhb0VHczNtSVBxTzBZOFRvOXcrSjFxMmN3bWJ0NlRwK2Z3?=
 =?utf-8?B?RHQ3U1NnVlo4QVB4MkhYSENhRktpNm8vSmNBaTNDQ28rYTZiZ2pLRUZ3Lyty?=
 =?utf-8?B?SHBqMHU1QUxYVlpMWWJoeC9rS2xVMGFCZjJha0tXTWduckFFVFNueEtKZ3dM?=
 =?utf-8?B?SGVYOXFnYlBVL0EwSncwQmluejhQcWtLaHkvZTNaa3kwK3UvTHk2dU9ROWZv?=
 =?utf-8?B?eFNCYmZxbjlqYXBieDNlN0VQVWFrN2QyT1VBZmZDdUFEbUdIbnJueTVxd2lY?=
 =?utf-8?B?ZkZwemI0WjNOMldKR252eklwTHVkOGM1NVp6citESjFLTlZDZ1JZendhMS9E?=
 =?utf-8?B?Z25RV1NpMy9zd1RMQUZwV1dQcWtoYWxnMTdkdmRmdHNaL0VPUzZwdXJnOVo0?=
 =?utf-8?B?UGRla3piUXFBKzNoazBqYjNYM0hMSEkvZFFQUGo1Z0FvVFJzRXhJZng5SDJm?=
 =?utf-8?B?STZZNDJxak9mZS9vbVlKSDZsRnM4SlpvM0w2aVViQlJJUXNXWnluRG1hTzNw?=
 =?utf-8?B?UUdsa1U5WTZMMkNTT0JjTklKWXJKOFl6UCttTjJNWnhYZjhaaU1BZEVmaG82?=
 =?utf-8?B?NWVXeENCNHhFNlZuREdvdE5vLzZUbG9zVnpLSlhmT0YzZzZEVi8vbmdsK2xx?=
 =?utf-8?B?a1Q1QVFIOVhNT2R4WUFvRlRGUDBxUUVVVmlvMjNmdVc4V0hucDd1RFhmR0xC?=
 =?utf-8?B?bXdFY3J6K0cvQzhqMUlqcGdOd3lmT0tQQmpIU1MwRjJmQTdVSjd4RDNjZkNw?=
 =?utf-8?B?Rjk4MnNtbW02T0xFK0lIR29OQkNYMU1GNEtkVFliaEhPb2t6dGZqTnZienhW?=
 =?utf-8?B?Mmw5M1hZOG8xVFJXVHBySUZpOGorNnlDM3RMUk1US0MvRUlLbm5hSXVOZytD?=
 =?utf-8?B?WitaenFSekFZMUFybG1ZMDZ4ODk3c3NPUldwR2lNMm9CQjM3Y2lzNGJvV0pO?=
 =?utf-8?B?dFhtL1pTNlp4NlFveFZ6eEl6WUZ4REpyd0l4WklmZS9BdUJQbEhCM3dvNXpX?=
 =?utf-8?B?YUFSd05mV1psdlV4dUlzNm8yb21NRlVpOW5IRXdvVXNkbnlSd3F4QjVnU3Zn?=
 =?utf-8?B?ZWpiNHdwRXZGTGV3UmhaZkYwU1dnSWpCT2Q3MzZmRmhuRjVuZXNTRnpIamEz?=
 =?utf-8?B?bUlraUdXR2lNaHBlRnd5bzRTWitmM1J6TENIYVZ0UHR2NVpwekVYZnQrVHFU?=
 =?utf-8?B?Q0VRMHcxaXY4bHcyWml2OElteCs3Zm1JTVdNdlBpclB2N1pyT01xMU5NUldj?=
 =?utf-8?B?WVVTWVJHVklha3R2dVZ3ODFOcmwwaFhMY3IzRDQwUytXNXVNd1pIQmhEUDdT?=
 =?utf-8?B?M1JXZjVDd21YSU9aeFNvaDFvbjA2dnVwbnN0elBvcVFuQ1NaTURkSEpiNDRN?=
 =?utf-8?B?UFhFNldWSFhabDUwNDFVenY1Q2xGMXJKeGNlTzdhYUxseXdEZ0wxQnlqMXow?=
 =?utf-8?B?UlhrM20xS0ZUQUNpTWw5WVcxd25yTzByYVlCdGRiVWZRYVYwdlZVd3pwVi9K?=
 =?utf-8?B?ajROTTM2UmlienBwcjZNeVRPR0xJWjJLWlNDbTlkMjM0MENDdlJjWnlqQ2R3?=
 =?utf-8?Q?zA9AjR5kckB0a?=
x-microsoft-antispam-prvs: <MWHPR11MB1279675979B2977415E5D67AE0630@MWHPR11MB1279.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(14454004)(229853002)(6436002)(6486002)(186003)(478600001)(26005)(8936002)(81156014)(486006)(8676002)(72206003)(446003)(476003)(36756003)(2616005)(71190400001)(305945005)(5660300002)(81166006)(71200400001)(66066001)(256004)(4326008)(7736002)(11346002)(6246003)(25786009)(14444005)(3846002)(6116002)(2906002)(52116002)(99286004)(76176011)(97736004)(102836004)(316002)(53546011)(386003)(6506007)(53936002)(54906003)(68736007)(2501003)(105586002)(110136005)(6512007)(106356001)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1279;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mu0fJezj0Scqyi6ajany7+65lRvfsy/VplNpjSpRH4dBnaPVkinAdgrRJpVkpLw2cZn5NpsZHSVY4/P/t5YRel8oD8eCguwCwwerWobnqxqMPHAIWpjVRvnxFRLdU8AhZTkg0fea9SSl6o1795bp8PKBgC/d1enGBa8geGLARnJzM3gOjTKLTa5S6iW7FSoH54e/++xSe3fsmCkLCw7Ou7SvfyfkthTSvituyucVjo4oXHhAY1s3eAFih9ZewvB1sKmhdNX+tFc9v63zMi+9v1qm9X8zBlPphfCuuFDO19zY0nqPgq/8LTV2dMDXAeE2VXwIn4d+/LzCIANRPEDU5vM4efQAONfLNnrHzjVGt+NwAwKEcFfzkhuRpqi2AsFSD7DsxeIDImL0Z1RlGz0kIrcxqQ+c7CnnXx71Ov1aq+w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FB745B54B46AC43AE8FC8B39A8C0EB2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adb09a7-7fbd-4e85-948c-08d6959078ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 11:01:43.0616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDIvMjAxOSBhdCAxMjoyNCwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+
IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gQWRkIGRvY3VtZW50YXRpb24gZm9yIFNBTTlYNjAgc2h1dGRvd24gY29udHJvbGxlci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2No
aXAuY29tPg0KPiAtLS0NCj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2F0bWVsLXN5c3JlZ3MudHh0IHwgNiArKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQNCj4gaW5kZXggMTRm
MzE5ZjY5NGI3Li45NzExMDUyYzU4MDAgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQNCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dA0KPiBAQCAtODMs
NyArODMsNyBAQCBTSERXQyBTQU1BNUQyLUNvbXBhdGlibGUgU2h1dGRvd24gQ29udHJvbGxlcg0K
PiAgIDEpIHNoZHdjIG5vZGUNCj4gICANCj4gICByZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtLSBj
b21wYXRpYmxlOiBzaG91bGQgYmUgImF0bWVsLHNhbWE1ZDItc2hkd2MiLg0KPiArLSBjb21wYXRp
YmxlOiBzaG91bGQgYmUgImF0bWVsLHNhbWE1ZDItc2hkd2MiIG9yICJtaWNyb2NoaXAsc2FtOXg2
MC1zaGR3YyIuDQo+ICAgLSByZWc6IHNob3VsZCBjb250YWluIHJlZ2lzdGVycyBsb2NhdGlvbiBh
bmQgbGVuZ3RoDQo+ICAgLSBjbG9ja3M6IHBoYW5kbGUgdG8gaW5wdXQgY2xvY2suDQo+ICAgLSAj
YWRkcmVzcy1jZWxsczogc2hvdWxkIGJlIG9uZS4gVGhlIGNlbGwgaXMgdGhlIHdha2UtdXAgaW5w
dXQgaW5kZXguDQo+IEBAIC05NSw2ICs5NSwxMCBAQCBvcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiAg
ICAgbWljcm9zZWNvbmRzLiBJdCdzIHVzdWFsbHkgYSBib2FyZC1yZWxhdGVkIHByb3BlcnR5Lg0K
PiAgIC0gYXRtZWwsd2FrZXVwLXJ0Yy10aW1lcjogYm9vbGVhbiB0byBlbmFibGUgUmVhbC1UaW1l
IENsb2NrIHdha2UtdXAuDQo+ICAgDQo+ICtvcHRpb25hbCBwcm9wZXJ0aWVzIGZvciBtaWNyb2No
aXAsc2FtOXg2MC1zaGR3YzoNCg0KaXMgaXQgZm9yIHNhbTl4NjAgb25seSBvciBpcyB0aGUgb3B0
aW9uYWwgcHJvcGVydHkgImRlYm91bmNlLWRlbGF5LXVzIiANCmFwcGxpY2FibGUgdG8gdGhpcyBT
b0M/DQoNCj4gKy0gYXRtZWwsd2FrZXVwLXJ0Yy10aW1lcjogYm9vbGVhbiB0byBlbmFibGUgUmVh
bC1UaW1lIENsb2NrIHdha2UtdXAuDQo+ICstIGF0bWVsLHdha2V1cC1ydHQtdGltZXI6IGJvb2xl
YW4gdG8gZW5hYmxlIFJlYWwtdGltZSBUaW1lciBXYWtlLXVwLg0KDQpXZWxsLCBJIHdvdWxkIG1h
a2UgY2xlYXIgdGhhdCB0aGUgb25seSBhZGRpdGlvbmFsIG9wdGlvbmFsIHByb3BlcnR5IGlzIA0K
ImF0bWVsLHdha2V1cC1ydHQtdGltZXIiIHdoaWxlIHRoZSAyIG90aGVyIG9wdGlvbmFsIHByb3Bl
cnRpZXMgc3RpbGwgDQphcHBseS4uLg0KDQoNCj4gICBUaGUgbm9kZSBjb250YWlucyBjaGlsZCBu
b2RlcyBmb3IgZWFjaCB3YWtlLXVwIGlucHV0IHRoYXQgdGhlIHBsYXRmb3JtIHVzZXMuDQo+ICAg
DQo+ICAgMikgaW5wdXQgbm9kZXMNCj4gDQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
