Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00503C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A7C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eAhXRzYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfBZNfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:35:36 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:11440
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfBZNfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35JsWmNZIqCxAq1srSOTy5QDMK6YLUaqaHqWfWJwALk=;
 b=eAhXRzYGBKQlcB/oWTn/ic4MFTfGjU1n5aMg9EsRx025bAjNObEt/awU3FEzUCVZAvAzPF5p/qCPlvZ++oiGUFuSmKwr0Pw84+HWYf4zgOoH/Ie7vP3Yy6t/OiKDk4v+wZ6swIq7izo7NY3CZzeQ99Rosru162DuMffRaURE24w=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4381.eurprd04.prod.outlook.com (20.177.55.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 13:34:52 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 13:34:52 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "abelvesa@linux.com" <abelvesa@linux.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHUzcGB6LodUxnT8UyD0+K7eGuy3qXyFIYA
Date:   Tue, 26 Feb 2019 13:34:52 +0000
Message-ID: <dff8a3aa9dd6501280300654f085f07c87d4cd23.camel@nxp.com>
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a36cbff-6105-4c40-2e68-08d69bef2ff1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4381;
x-ms-traffictypediagnostic: VI1PR04MB4381:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0MzgxOzIzOitVWkU1OGVXY0ZyZWhBelkxd2x3QkdzWVpw?=
 =?utf-8?B?TVF2R2pJSXJITGlTQTM1UVpzOVVXazliZHB2cDdNc1piTFovdEw5M2J3d0Vq?=
 =?utf-8?B?eE1FWUxGRTZxbS85MUhYaXBnVWNQK2RzOFBGT2dTV3dwb2FjVWtlbkJBSFFY?=
 =?utf-8?B?a0tHcTlmVDBPQ3lLa280VVBTeE9adjJWVkladnN6RXJYT1NqUTNSeHo4MFNp?=
 =?utf-8?B?WWlMUWQwM0FqS3Ryc09zRzFoRTBYdmZUOTVrR09STXIwdE5jS0ViNVZzdCtv?=
 =?utf-8?B?aGFkTHY2d2cyR2tUZDA4L0J3UnZGTXJUQUV2ZjVFbVRZcXJTRGpaYjFzMVBO?=
 =?utf-8?B?Wk1yaThmNU5DRC9KeEluajZwc0hIWURacmQ3MXNIaVRGdDl0d0ZWRHNVRGQ2?=
 =?utf-8?B?b2lCMzhaUitKc3VpNkl0SGErVHE2MDdXejV0Tk1zVEdqckUrbXhEMjlVUWdS?=
 =?utf-8?B?RHNBcEtZVXA3cVZ1endTbVN2QWpXRzlxL3ZGNHd4UnRWQi9waW1EM292Y2x0?=
 =?utf-8?B?eW5DNGt5alQ2ZlFMRTBlb3E5K3NXeG8rRUc1bEd2N0VKeUFsemlkUWlJM0cy?=
 =?utf-8?B?YVlwcTFyTGJhWWl5VGkxMVBTY2x0QnNUaSt4L1lQK0ZOU3V0MERuNit6Z1Rm?=
 =?utf-8?B?ai9tK1JlOUV6RTB2RWh5TEIrbFRSYWJxd3dzaEVaalAvZ0g2MGI4WWRjdFZJ?=
 =?utf-8?B?a1VoSUtVeFppcVpLTDhUdHJlSzZRU3E1Znoxa0tFTUhQN2R6TFE3cG5VNjZR?=
 =?utf-8?B?Uk04Wk5XSjNPZHFpSm03Qkw4YTY4bEZ6Z0NxTmhKbW5naFFSb29KcGNCTHNS?=
 =?utf-8?B?MVRYNU5ERExPa3k1VDRXYVllbE1tNzhxSU9IQ3MzZWFLYVRYSWtMejU2bzdH?=
 =?utf-8?B?eFBIQTRDUzBxYkYwVjhtVjU0L2t0aEk1OE1sOWNkaDUzRjlPYVRaeC9odHJi?=
 =?utf-8?B?N3ZWWDZmajE4bVNtSTBuSHcrWXhTclFNQ1J5SjgvZ0I4dUc5dkdNMmRKcEpl?=
 =?utf-8?B?TVh2UzM5ZzY2N21yN3V0eXRMNDBpeWlIMjcrUWZ1MXhXckZ2NzFBNk1wY05i?=
 =?utf-8?B?V2ZMQUJlNzVESmJsajZyWnlyMzErc2ZKZk83Nmo5TEFRQTNSNFltSmoxYzVS?=
 =?utf-8?B?enhpWHl2WTdObWF6TzJ5aVVlcUMyMGVBSlNYQ1UvYVFkT3VPaFhYS2Fzam1B?=
 =?utf-8?B?NUswM3I4aXpKNzJFV1RTWll1cXlIVkRkclR2UlFpQ3BaTStLWHl2YUk2eDJO?=
 =?utf-8?B?SE8rMVhIYVdtWUFNRjZSWCtxUTNhK1hYQ3JNa2NVWnZXQ0lGbldZbFIwb096?=
 =?utf-8?B?S0ZyK29tRzZtTjJ3anI3SWQyYXdZYXFlYS9hUTlPQnZwM01SQUFkUVl6YnQ0?=
 =?utf-8?B?NzcrQXBaaUt3YzMxQlZGZzIzNGp6cHAzRXpNdXlIT2l1bEN6TFlQVEowUklX?=
 =?utf-8?B?VUg2UERWU0ZaT3ZhRW5CbFlIaldOOUsxOTZEVDYyR1l1cW5zNk9yQkgxaHZk?=
 =?utf-8?B?Q3ZJMG9PMisrZkNnNUJRSmxWbmpqVXFQNVh5TnVXSGY2amR4L2Y4MHExMzFy?=
 =?utf-8?B?VEh5MjNkeEhmWCtLMmRWUmJOR25Ja1hqWFZZc25tcFJTVEtNb0tXMG81My8z?=
 =?utf-8?B?SkNvSklvdTBVcURhQnBSa0dXMTlKSTZiU2x5UFNSN09oV1VGWEl3NE9JNXFE?=
 =?utf-8?B?elVVZXMyQVkwL3FScHQxeFhSK3BCMEVFcmZlVHB1eTJxNmJpRmxuZGY0bmo2?=
 =?utf-8?Q?7sqO0768h9jGignnd8XdRHDHrW0UX9SMcilZw=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB43814CB3DD1A709B89E073A2EE7B0@VI1PR04MB4381.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(2501003)(8936002)(50226002)(186003)(486006)(305945005)(7736002)(81166006)(478600001)(102836004)(53936002)(76176011)(446003)(44832011)(118296001)(26005)(66066001)(11346002)(81156014)(8676002)(476003)(2616005)(106356001)(14454004)(105586002)(6506007)(97736004)(68736007)(36756003)(25786009)(6512007)(256004)(86362001)(6116002)(6636002)(99286004)(6486002)(4326008)(229853002)(316002)(2906002)(5660300002)(6246003)(6436002)(71190400001)(71200400001)(3846002)(54906003)(110136005)(99106002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4381;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OB0LZZnf31dlZqn88uoEjE6/DcILqsme+KV5v7M0eI/9JvNd1qHG6nFykOZ1NR6nCc1ztoVi7wQI7zWb65uc+qJxFz9QkevbJDT2FL9xzHY/zbCSSSF+XDTFq870fCBDrG1mQ7h3PjycOaNNi2hxNdFpS+Rk2UmI0nq/mRu7fIg7+Qfn2Py1mzQ18Heqdjws0qbJZwJwzuFAMFJYdAR9wkViFCmGldy4LFNbnUPO30AeLKk2x2CGB23kR9xh3NhL3GCaFnBj8TmVWa4OgW7FTjzpmF7B5sf41PUIah/Q4Ww3x5UFnDNIuNR82KzhchnMEB+9vkIyK06pTLcaccwBy6qvxXk0OKcAnWx06WfEaJSEF5BvMqcwnQL1YV8xYBCT1z8fhxTSwWC+ysF2jhYtyTuEmScqkuUfOW00B1hxIRE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7637D2E33C5F6348BE2132B33F3242D6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a36cbff-6105-4c40-2e68-08d69bef2ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 13:34:52.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTI2IGF0IDEwOjUzICswMDAwLCBBYmVsIFZlc2Egd3JvdGU6DQo+IEFk
ZCBnZW5lcmljIGkuTVg4IFNvQyBkcml2ZXIgYWxvbmcgd2l0aCB0aGUgaS5NWDhNUSBTb0Mgc3Bl
Y2lmaWMgY29kZS4NCj4gRm9yIG5vdywgb25seSBpLk1YOE1RIHJldmlzaW9uIEIxIGlzIHN1cHBv
cnRlZC4gRm9yIGFueSBvdGhlciwgaS5NWDhNUQ0KPiByZXZpc2lvbiBpdCB3aWxsIHByaW50ICd1
bmtub3duJy4NCj4gDQo+ICsJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxM
LCAiZnNsLGlteDhtcS1vY290cCIpOw0KPiArCWlmICghbnApDQo+ICsJCWdvdG8gb3V0Ow0KPiAr
DQo+ICsJb2NvdHBfYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsNCj4gKwlXQVJOX09OKCFvY290cF9i
YXNlKTsNCj4gKw0KPiArCW1hZ2ljID0gcmVhZGxfcmVsYXhlZChvY290cF9iYXNlICsgSU1YOE1R
X1NXX0lORk9fQjEpOw0KPiArCWlmIChtYWdpYyA9PSBJTVg4TVFfU1dfTUFHSUNfQjEpDQo+ICsJ
CXJldiA9IFJFVl9CMTsNCg0KVHVybnMgb3V0IHRoYXQgaW14OG1xIHZlcnNpb24gZGV0ZXJtaW5h
dGlvbiBpcyB1bmlxdWVseSBtZXNzeS4gSSB0aGluaw0Kd2Ugc2hvdWxkIHRyeSB0byBwcmludCB0
aGUgcmV2aXNpb24gbnVtYmVyIGV2ZW4gZm9yIG9sZGVyIGNoaXBzIHNvIHRoYXQNCndlIGtub3cg
aG93IG9sZCB0aGV5IGFyZSwgYnV0IHRoaXMgY29kZSBjYW4gYmUgZW5oYW5jZWQgaW4gbGF0ZXIN
CnBhdGNoZXMuDQoNCkluIHRoZSB2ZW5kb3IgdHJlZSB3ZSBoYW5kbGUgdGhpcyB3aXRoIGEgU0lQ
IGNhbGwgdG8gQVRGLCBpdCdzIG5vdA0KY2xlYXIgd2h5IHdlIHNob3VsZG4ndCBqdXN0IHVwc3Ry
ZWFtIHRoYXQgKGluIGJvdGggQVRGIGFuZCBMaW51eCkuDQoNCkFsc28sIHRoZXJlIGFyZSBzb21l
IGlteCBzb2MgcmV2aXNpb24gZGVjbGFyYXRpb25zIGluDQppbmNsdWRlL3NvYy9pbXgvcmV2aXNp
b24uaC4gVGhvc2UgYXJlIGltcGxlbWVudGVkIGluIGFyY2gvYXJtL21hY2gtaW14DQpmb3Igb2xk
ZXIgY2hpcHMsIHdvdWxkIGl0IG1ha2Ugc2Vuc2UgZm9yIHNvYy1pbXg4IHRvIGRlZmluZQ0KaW14
X2dldF9zb2NfcmV2aXNpb24/DQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA0K
