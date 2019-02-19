Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06577C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEF621773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VvxJxgY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfBSQVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:21:24 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:34116 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:21:23 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="26536915"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 09:21:19 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 09:20:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGqL6FeLaQ2cmJ7huUwXshhLLY15qor0L5OcC0hM3tY=;
 b=VvxJxgY5VlIOc5tG5ozV9gm0BZQa0pwPpNuAwuRPZdB48kUVMU9aeTYumFqb8ptGqlLLvSh+Mw0NHUU5FAhOEhR4QTFSKNcbF4W/kxcybqjTr7/Ap1hqwzB0z7RkxzxFkvX0ND6yqUOqKD+1oUlgoX8Gx2LfDlOaLF6s/K38Ntc=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1975.namprd11.prod.outlook.com (10.175.61.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 16:20:41 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%8]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 16:20:41 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <dannenberg@ti.com>, <m-stecklein@ti.com>, <afd@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: pcm186x: fix wrong usage of
 DECLARE_TLV_DB_LINEAR()
Thread-Topic: [PATCH 1/2] ASoC: codecs: pcm186x: fix wrong usage of
 DECLARE_TLV_DB_LINEAR()
Thread-Index: AQHUyG5ckbI47UgWGkCR6aNSYU4cPKXnTTcA
Date:   Tue, 19 Feb 2019 16:20:41 +0000
Message-ID: <4de1b52b-70dc-7767-ba16-2d785d36a4c2@microchip.com>
References: <20190219161518.1331-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190219161518.1331-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f50c3776-811a-412a-b0e7-08d696863120
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1975;
x-ms-traffictypediagnostic: CY4PR11MB1975:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjExTUIxOTc1OzIzOkp2N2pRWS9oUjBJQWIzM2ZEVGNQYmJFMkdP?=
 =?utf-8?B?YmJYQVJoRUIvOXhjajkvUlNTT0xBcFQ2dWE0OHZzUXVpbzFzVXIxeWFWdVBZ?=
 =?utf-8?B?K3g4TFdyM3M4UDFtWVNtY1RtU2ZEZURleXhOMzFrR2w1MXh6U243dENvQ1hI?=
 =?utf-8?B?ODh2bmhXWVpxT1p4YlczeVFQUW1wU1psdUxMQTBVQlc3NGM1MFprbTJUb1Ns?=
 =?utf-8?B?blhFT2hsMGFJUHpvdGpZdkd3bU9NY011akU1L1Vaa0trZXNmQmt4VFllSHNN?=
 =?utf-8?B?dVlMVWZKWXVQUy9qcXFKalBobTNac3gyU3gyTjc2dlcrVkdOUmdEUW8waldk?=
 =?utf-8?B?MkhSQjdObm9FK3l4MmgxMTRvNEluTGhGdXdnSnNnUzVjRFdLSjhmUFNubUl3?=
 =?utf-8?B?TlNIY2xxRnRlenRzV0VSakRZQ0Q4eGNqTldyZ1A4U00zcVA0NC9jMHpqR1VD?=
 =?utf-8?B?R1FHUW5IbkF0WTE2Q3lZWGFNTTZFZ3p5YVVvQkFQV3RtalArQ3RLM2hINU1T?=
 =?utf-8?B?KzI4SGxnR3l2VGFieEZJZjFGZEFlU0I0aXVBOFgwVVJZZFpjOUFXU0VURzR5?=
 =?utf-8?B?OTdZaEZYN1k2bVhxU0c3NXYvalhuc1NJNTMvM0pYdDVRUEgySjVnT2JHaFhm?=
 =?utf-8?B?aTRtdHhGTEZqWU85NGM1VU5tazZHd2xOWC9jeGw2bW16eEZQUkhiNmo0dEZr?=
 =?utf-8?B?bkZLRktRWFpaV1ZnWGJGQjJVTEVrRDF6U2lIdlpaSXlxa0VGd2hsSThCTmJh?=
 =?utf-8?B?TXdLZTJVdlN0WTZidEU2ME9PWis0K2RqZVVQL2RJZEZTRnFmclBLL2twRW51?=
 =?utf-8?B?cUY0ZWVRSzRPeVhFbDBJd0Y3Qmt3L0JYa3c1cmIwMG5NcEhza0pBandPYk9h?=
 =?utf-8?B?cnZnM3kzalMxaTkyU2hYQzVQY2Uza0p4SHlYT1RtMVpSaDg5VDFPNUNJcEQv?=
 =?utf-8?B?VVZSbE5lZWZFemU3NnlLQSttclFYWEpmTDdqOXZyK2VRMWFKYkF6TmF1c0pI?=
 =?utf-8?B?VU5YZVczUGYyREdiZStMUldBVElWN2xZTzVieGwvTm1uVEVYOG1QREl2NEgv?=
 =?utf-8?B?SGRQY1l6RThKVU5MVytBZ0dqZ3lieXF0K2QxOVArNU9nZkFNOXFvNGs5VWxC?=
 =?utf-8?B?TS9sYkFzS0tiT3EwSkw5TEp2V1h4djhYR2FBa3o4WDBHWlVuTGQ5OE1UMHln?=
 =?utf-8?B?TGZFMENjZXAxVTJRb1VoSm1naVZ6eVR4UWMwdWo0by9tMGNMem5HUkhEMXBa?=
 =?utf-8?B?aEpCeC9YSUFoUldNTWk0a2NCZndpbzR1UzB0UlM2Z1FoaW1yclQ4Q3FFdVF4?=
 =?utf-8?B?Z2pJN0xnbTZVZWhJLzlWN3B2ZXF5am9IRHVVRDFCZXNMbWx6S0QxSkRtaWVz?=
 =?utf-8?B?bW4xY1drd3ovSEx5NVpQdm1mVks0VlQvYzlqT2xZY3VNM0xGVjVUOExQRkdV?=
 =?utf-8?B?M0Fna20wS1h6ZE1pVFpCOW1YY3JtY3UxYlljNy8xcVdiV2hHOTIyejNSZWlm?=
 =?utf-8?B?TjNhM29ob3gzbkV1VzNYc090TkxwT2FXNjkzT1hmblZ6ZzdJeXBBK3o4RFFZ?=
 =?utf-8?B?MkYrOUF1WkU0VzFhZFRyQTlSSWlFYmtPQXN3OXIxYnY0Sy9lU3FoVktqdFNy?=
 =?utf-8?B?U0RockFtcWJRT3lKOEhteUwrMk81U0g1LzU2RVI2OW9PTnR6Y2dKL1lOSzcr?=
 =?utf-8?B?V3d3M3ZXY3lzeE5pNlBZclQ1Z1hMdm5NL3lMazhYNmJSMndlOGRjUXpMaEJv?=
 =?utf-8?B?VXRTN0MwdTd5WG1xRit3a3RRb0VxMDhlLzc0MExlVTZTT2FBaFZLeXFtRjg4?=
 =?utf-8?Q?uViXNhc6QrVUx?=
x-microsoft-antispam-prvs: <CY4PR11MB1975169435D9BA75D3431D7BE77C0@CY4PR11MB1975.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(186003)(486006)(14454004)(2616005)(11346002)(2906002)(68736007)(476003)(26005)(446003)(71200400001)(71190400001)(99286004)(52116002)(102836004)(97736004)(386003)(6506007)(6116002)(76176011)(53546011)(3846002)(2501003)(86362001)(478600001)(256004)(36756003)(110136005)(31686004)(81166006)(106356001)(6486002)(8676002)(53936002)(229853002)(316002)(81156014)(6436002)(8936002)(25786009)(6246003)(6346003)(4326008)(7736002)(305945005)(66066001)(72206003)(54906003)(31696002)(6512007)(105586002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1975;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K0zvuKO3vKGfhNO6dzPRsYUGJlLqGuBmXHOCOmJCzkWhLZ+yceoaLn/Zn3G9BXfysLsdA8GE3+XFywyR83dVuZPR/X0fVXGwUMc0mMhYgj56OR7/KcON0sEkgYwIwziHIhS6WeiOJ7J+LM2ulWXDqgHAhBqGRqj8t5ChrrgSkoLIcAtn0/BQif5VK77W+n1ovt0NjxcadyO1lj0UMkl4DIfEzcacs7KHLfEar0gpYymZH57i8dHanv+7RdeK+kiSN7i/5xuhuJ0qow6rLPWazQwddd/DDuZb7gN7TaxohS+W4NNN9ekkzEW663r3NSjvHBAjqPh7yTi7yLa0OoK83yuxfgrazCgm4lXMAyLrQlKDq2j7A9J4IXu8Mxnf2ZJX67Q7WGt1SLX1iLKLzGjjHJxzJT61hEDKoaTBHWKJwy8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FDC35D96D134E43A98C54742F680002@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f50c3776-811a-412a-b0e7-08d696863120
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 16:20:39.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1975
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDIuMjAxOSAxODoxNSwgQ29kcmluIENpdWJvdGFyaXUgLSBNMTk5NDAgd3JvdGU6DQo+
IEZyb206IENvZHJpbiBDaXVib3Rhcml1IDxjb2RyaW4uY2l1Ym90YXJpdUBtaWNyb2NoaXAuY29t
Pg0KPiANCj4gQWNjb3JkaW5nIHRvIERTLCB0aGUgZ2FpbiBpcyBiZXR3ZWVuIC0xMiBkQiBhbmQg
NDAgZEIsIHdpdGggYSAwLjUgZEIgc3RlcC4NCj4gVGVzdGVkIG9uIHBjbTE4NjMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9j
aGlwLmNvbT4NCj4gLS0tDQo+ICAgc291bmQvc29jL2NvZGVjcy9wY20xODZ4LmMgfCAzICstLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3BjbTE4NnguYyBiL3NvdW5kL3NvYy9jb2Rl
Y3MvcGNtMTg2eC5jDQo+IGluZGV4IDgwOWI3ZTlmMDNjYS4uNzk0NzI3OTI0M2Y5IDEwMDY0NA0K
PiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL3BjbTE4NnguYw0KPiArKysgYi9zb3VuZC9zb2MvY29k
ZWNzL3BjbTE4NnguYw0KPiBAQCAtNiw3ICs2LDYgQEANCj4gICAgKglBbmRyZWFzIERhbm5lbmJl
cmcgPGRhbm5lbmJlcmdAdGkuY29tPg0KPiAgICAqCUFuZHJldyBGLiBEYXZpcyA8YWZkQHRpLmNv
bT4NCj4gICAgKi8NCj4gLQ0KPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gICAjaW5j
bHVkZSA8bGludXgvbW9kdWxlcGFyYW0uaD4NCj4gICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0K
PiBAQCAtNDIsNyArNDEsNyBAQCBzdHJ1Y3QgcGNtMTg2eF9wcml2IHsNCj4gICAJYm9vbCBpc19t
YXN0ZXJfbW9kZTsNCj4gICB9Ow0KPiAgIA0KPiAtc3RhdGljIGNvbnN0IERFQ0xBUkVfVExWX0RC
X1NDQUxFKHBjbTE4NnhfcGdhX3RsdiwgLTEyMDAsIDQwMDAsIDUwKTsNCj4gK3N0YXRpYyBjb25z
dCBERUNMQVJFX1RMVl9EQl9TQ0FMRShwY20xODZ4X3BnYV90bHYsIC0xMjAwLCA1MCwgMCk7DQo+
ICAgDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IHBjbTE4NjNfc25k
X2NvbnRyb2xzW10gPSB7DQo+ICAgCVNPQ19ET1VCTEVfUl9TX1RMVigiQURDIENhcHR1cmUgVm9s
dW1lIiwgUENNMTg2WF9QR0FfVkFMX0NIMV9MLA0KPiANCg0KdGhlIHRpdGxlIGlzIHdyb25nLCB0
aGVyZSBpcyBubyBERUNMQVJFX1RMVl9EQl9MSU5FQVIoKXByZXNlbnQuIFdpbGwgDQpzZW5kIHYy
Lg0KDQpCZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCg==
