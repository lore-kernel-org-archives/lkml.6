Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A58C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC49217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZBpn1fYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfBRPSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:18:35 -0500
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:40928
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729971AbfBRPSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvfzH4zAM2afzGQdD7A0MmyGxKJpuN3kZvGS3JIwSo4=;
 b=ZBpn1fYH6wTc5E8OXaU3HX/MNDsYSeXowNo+t9dQCCo+r24fm81nQOjJqh9I447wG40G7bu9TMKZE2fJ8h3Fs4gN68cChD0i5FHPJUkMT98oqxL96bUu9NtkxxzaU2MWwewRQXKskGqaV6Mz1hf+ZW8n6A7ShfAGPq5UXDwkJOg=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3398.eurprd04.prod.outlook.com (52.133.19.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 15:17:51 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 15:17:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4] dt-bindings: timer: gpt: update binding doc
Thread-Topic: [PATCH V4] dt-bindings: timer: gpt: update binding doc
Thread-Index: AQHUn1po6Cv6jEkmxkOQOg/6Eu+hiaWqO8UAgDu/dSA=
Date:   Mon, 18 Feb 2019 15:17:50 +0000
Message-ID: <AM6PR0402MB39111964EB06DF1D0447BB1BF5630@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1546076081-23196-1-git-send-email-Anson.Huang@nxp.com>
 <20190111145214.GA15957@bogus>
In-Reply-To: <20190111145214.GA15957@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01ce10a3-5f9c-4630-3971-08d695b43f82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3398;
x-ms-traffictypediagnostic: AM6PR0402MB3398:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTZQUjA0MDJNQjMzOTg7MjM6ZGJ1clFRak5BVXNSQU5lNENHcXc3R3Fh?=
 =?gb2312?B?ajdGaDczMkxBT0czV29Ueis1bTBaWG5TOU1sOUw2bnlURUQ2Ymo3bGlnWXhu?=
 =?gb2312?B?UEk1MEhhZUNOUTRNTW9YRnFrUHRHUFVYM1RwS3lDMm84Q2lhVGVDclFIOC82?=
 =?gb2312?B?dGdTb3dobU1CQWVIYTRWdE55TU82YW5Bd2tmeFVTWE1hbGM5UG5qN2xGZGtz?=
 =?gb2312?B?R3QxRktheFgwbnZ5TTlER0xmQmVwamRKNU1MRVFLVTRVOHZjQzZXRms4aFMv?=
 =?gb2312?B?NGtUUzFNZDFrV1BoVTluMnRHQWo4U1Y0eVpPaVE1aGdGT0RZSldBMUZEQlRl?=
 =?gb2312?B?MVpFanhIaWRhQ3dEUXAzOVdRelZKN3lQRVdoL1FnOEFEbDBNNE4xaWNhdm9x?=
 =?gb2312?B?QS9RY1VTcjFXaGNSTFVaUWpCTGlYUlpDWUE2Q085Q2ZxcEJ0RlgwNjhOb0FF?=
 =?gb2312?B?VGhFTUlBcm9GV2pGMlBrYytXaU00TDRmcGRBTHQ3QU1hWjhHcGY2VFB6T3VV?=
 =?gb2312?B?S2ZhdXpUUmRlSHNuYkRSYm91bXRtbW42OUxUbks5WUFham11bFRPb0tWTGZl?=
 =?gb2312?B?VEY3SGFrYUNLMk9KTk5mUmNJd1RSMzk2bGhVYUNadHFSeXF5a2RDZ091QUFa?=
 =?gb2312?B?Z2twb0VLVjNUU0V2T1NSYXUzZytjK0NvMmx3TWQxcFptNStoNmhKTW9HY2l1?=
 =?gb2312?B?OTBBbU56T3hYbW1VVTREMTA5K3VCa0ZsUXZpRjU5bG5vZVNCUS9ZeXRCMlNI?=
 =?gb2312?B?R2F1QWdHNlZFUWJBeTBTc2FpQjdHUlpvTnhEaG82Q0RuL1A5a0dOOW55RFJQ?=
 =?gb2312?B?c1ptK3IrOGNNOEdLTUxOZjFTUC9KYlg2VWd3ZlZPM2RyR25wNXNKSDhNeGk2?=
 =?gb2312?B?aGtHMU9MUHhUNm50NDVKZzlhTVZTU3pUay82TjEwdEFKODhQdVRPN2VQMTlw?=
 =?gb2312?B?OTk1MmNwZHkycE9KeGhNYnZNZVp3SmpDTlRqUGx0Y2g1d1pHK0tqR2hQbGZK?=
 =?gb2312?B?OEphSDd4cFBSVENwWEdHNktLRUtXNEl0ZnUvK2NRODFYclMvY2ZGMklMcDhu?=
 =?gb2312?B?NWx1cVVrNmZJUVFDQTVEZ3ZibkF5QVltWEJJcFBKM0kxc2NMSTlsalRlTjhy?=
 =?gb2312?B?RXVwMVUyNW9FQURQZ1Y3WEhqZnYySzBOQWlNQkREYmwvbjZzWXoxczMvSU44?=
 =?gb2312?B?UjFIVkhSaUFLTG1QemRlQ1VjdGVpWi9JeHkvMytWMDFCbmlIeUFaTzdzdE1i?=
 =?gb2312?B?Y3VrUDQxdmZrUCtyalFyNmhLN0xMT1FjS05hUjBnZTk1N05DbTJVV1g2NlNp?=
 =?gb2312?B?SHlXMDVkV1dsU2V3OTVHZE1HSDVLWEtCKzhoVmtwQzNuazNtajYrYTRuTlo0?=
 =?gb2312?B?Y3hNK3ZmS0daS3gyZFI1Yy9YVnppTTVjUjdLYlordGtlVnJCNjJyajhKTEFs?=
 =?gb2312?B?QkFnbFVPY3FhOTRxbUpDeVM5bndZSzBMamcxOTZKUndDN3JINUJ3ODRlWHF2?=
 =?gb2312?B?d3NYUW5GcUlWTXpvMHpoaXluVExpVnRCRDVZY1VDOXcxSTVWT0IyV2doeDNN?=
 =?gb2312?B?YnlPV0hGcGZUNkZheWFQOGttSk1Hd3pwUDB5MTMvMXlZd2I3UVZYbmwxRXAv?=
 =?gb2312?B?aXV6cFRNOVJGMVI1OGFIeUJ6TzA5a0hnWnZvTGlDc3BsUkp1aUZGWVlIMkFT?=
 =?gb2312?B?aVFPeDdEdWc1dTh3RXBnaVY3TXBlL01heTBMd3JZL1M1L2crTHllNkw4blBK?=
 =?gb2312?B?K2djVkk2dERZcXh0d3p3MW5SQW1TcUtZY0R2dW9iVU9QT2x5VWZtbFdQbEZT?=
 =?gb2312?Q?DZuAs15UruLGEu1?=
x-microsoft-antispam-prvs: <AM6PR0402MB33988F593EE3A3CA6575EB46F5630@AM6PR0402MB3398.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(54534003)(13464003)(86362001)(106356001)(26005)(5660300002)(71200400001)(44832011)(186003)(97736004)(102836004)(6506007)(53546011)(11346002)(4326008)(476003)(446003)(66066001)(486006)(6116002)(6916009)(71190400001)(4744005)(229853002)(99286004)(55016002)(54906003)(81166006)(81156014)(8936002)(478600001)(14454004)(8676002)(7736002)(74316002)(105586002)(316002)(3846002)(9686003)(256004)(14444005)(6436002)(68736007)(2906002)(305945005)(7696005)(6246003)(15650500001)(25786009)(53936002)(33656002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3398;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G5EXA/ByjSFdJTeeKc02M2/T/jVIv/HPYc1AZcrEnb9LjOsePsfU3TzmluL2wItQZ7qU3JZQEOssegdghljY3JRNPDxsMfLWjUikOExYFypUiYSarpMObOxF8pLapDY4M2dINj7ThJXiboQhmX0+vRUBQMbMA+JxPVvkj71w+8cUCDE1pR/ER9s51xdXCseEg/PR2rEfuBhYk9F1dDq1vFKc5GelBawRjmpAenJGsXIGfK64AuN/I8ER7kzKDDNyJqg5w07swdi3da11AJ5ykqSx66ufgu0VFzNJjcnMmbYXScpEekwupHwPygFteEzYb4Fb0nCSrJaxfPEibeJkYVqBeBIRNjyugbacbl1wY6FBkoHcGzE4hyRVN4MPMtc4ovLxW6G1xg4L1K2sJbo1zso+gk9lRDiVX1GsG0oQtnA=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ce10a3-5f9c-4630-3971-08d695b43f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 15:17:51.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDE5xOox1MIxMcjVIDIyOjUyDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IHRnbHhAbGlu
dXRyb25peC5kZTsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0XSBkdC1iaW5kaW5nczog
dGltZXI6IGdwdDogdXBkYXRlIGJpbmRpbmcgZG9jDQo+IA0KPiBPbiBTYXQsIERlYyAyOSwgMjAx
OCBhdCAwOTozOTozNEFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBUaGUgaS5NWCBH
UFQgdGltZXIgZHJpdmVyIGJpbmRpbmcgZG9jIGlzIG91dCBvZiBkYXRlLCB1cGRhdGUgaXQNCj4g
PiBhY2NvcmRpbmcgdG8gY3VycmVudCBHUFQgdGltZXIgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
Q2hhbmdlTG9nIHNpbmNlIFYzOg0KPiA+IAliZSBtb3JlIHNwZWNpZmljIGFib3V0IHRoZSBiYWNr
d2FyZHMgY29tcGF0aWJsZSBvZiBlYWNoIFNvQzsNCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3MvdGltZXIvZnNsLGlteGdwdC50eHQgICAgICAgfCAzOSArKysrKysrKysrKysr
KysrKystLQ0KPiAtLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCj4gDQo+IFRoaXMgbm93IHNlZW1zIGluIGxpbmUgd2l0aCBteSA5KyB5ZWFy
IG9sZCBtZW1vcnkgb2YgdGhlIGxpbmVhZ2Ugb2YgdGhpcw0KPiBibG9jay4gOikNCj4gDQo+IFJl
dmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiANCj4gUm9iDQoNCkRv
IHlvdSBrbm93IHdobyB3aWxsIHBpY2stdXAgdGhpcyBwYXRjaD8NCg0KQW5zb24NCg==
