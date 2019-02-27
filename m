Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B817C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3EC2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R7JYwpb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfB0NPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:15:53 -0500
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:55793
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728652AbfB0NPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Lzb8h/qC828H7fab7EJliERXdm30x59LrySd8U9pLo=;
 b=R7JYwpb/f5kJHf1DVxzgbgCj8pu+XldiVuP/qsdw3bBntA2Z4UkfrHT76A2rgDPBSBSoTNFUrsdx+qdUJL0pocNxCLwva9aCPLlCfrRK/Ul7xRf7Eryrca8e0lHl5BWpRWKoXx99mPQLwLKjct9k2tm8mFdv92FMh4wKBItApe8=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4814.eurprd04.prod.outlook.com (20.177.48.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 13:15:45 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67%5]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 13:15:44 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "abelvesa@linux.com" <abelvesa@linux.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHUzcGB6LodUxnT8UyD0+K7eGuy3qXyFIYAgAFAXgCAAEyfAA==
Date:   Wed, 27 Feb 2019 13:15:44 +0000
Message-ID: <682cdcf278560b375ebced2eee1940b3dfc75e03.camel@nxp.com>
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
         <dff8a3aa9dd6501280300654f085f07c87d4cd23.camel@nxp.com>
         <20190227084116.42yrs26i5xlkppgl@fsr-ub1664-175>
In-Reply-To: <20190227084116.42yrs26i5xlkppgl@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b077115-5587-4a2a-db82-08d69cb5ae7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4814;
x-ms-traffictypediagnostic: VI1PR04MB4814:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0ODE0OzIzOlk4ZUNQUDVVd0tIMTkyMDUrdXIzUzF1Y2dh?=
 =?utf-8?B?c3l1T1liODVmakFyLzdBOTBySU1WZ21Yd3k5RXNvVTVDbjJ0eXFWcFBrbDlE?=
 =?utf-8?B?QzBQM2VuSmF5eEVoS0dhbDVEdUU3dUV1WmNObFB4QTBTaVRuVzdpWVZEVkY3?=
 =?utf-8?B?dytJRmtFNHBWK3RKNVdpcWFYdnZ1WExNK3Bycm9KWEdqNGRVZ3FsT1lKT3Nm?=
 =?utf-8?B?N2FLRStOK0kyZlRkbnJtV09hMDdEd05BeHNCOGVFRitaalFwcEkwZFFGdUxq?=
 =?utf-8?B?dHNxQkZTbVM4bStScXdjK0tOdlpIb1lUVnNXUnpYaElLYVp0ZkJHUjZYVVBk?=
 =?utf-8?B?cmJDeFNyR3ViRnhPdUZMczhFRGRySWRJUUxkZmZEYWwyS0s3Sis1SHVnVnZx?=
 =?utf-8?B?d2laMW1yQVNibHB5OGpZb2VtOHZodEY5bTFFRXBzN1ZrbjFwYmIydExNVmpR?=
 =?utf-8?B?cG82OTArK1BGMHJWSXBFRDRHUU04TjBuRVByZ0dQWC9TcHAySW1GbDZGMFhU?=
 =?utf-8?B?c2R6a1R4RXNhN29XSUkwTlFUck1mRWlZdDNLNVhKN21UUFNQL05qWG5SV0ht?=
 =?utf-8?B?bzlCT0FXNkg0bUVQMTdFNWZKa2JhbkR4dnowSUFtaFIwUnFuUDlsREdVWEd2?=
 =?utf-8?B?akF2eEpCaTFjVWNMcm8wK3Z6NGxFTkNlTy9oZEhrVDgvS3Q2WkV0VjhIRW9z?=
 =?utf-8?B?V0R4VGQzZTVzYVNPUTd1c0M1UG1selpKSHVnNU9YajlkY3dZdXdmbU9Tb1lP?=
 =?utf-8?B?NllRVUxodnpyb0wyRjgxeGtjNWxkcGtmaTJlcFFoV21JQnd4ekV3NmUyM1Uw?=
 =?utf-8?B?TUlLNUNJS2ZsUlh0UllrVWFxZWJmVmp4Zjk5RjdGbUlTR3VHbWxFUGdtOTBE?=
 =?utf-8?B?bE5EVFdFMjhWNXVZRlowT1JWbnN5V0xtcmVIeUI1T2VzK1p6MFUyNmljVGJk?=
 =?utf-8?B?Mm4xQU9MMWNaRlBta3UzS3g0WTQ2SHlCS0lqT0sxWDFwWVIycFczdGEzb29j?=
 =?utf-8?B?YWFXbmJyODJzc1RqNHhMUWtMY05qNStqckl4NE0zK21aRVo3enRnZWhFbGZS?=
 =?utf-8?B?Um13dTJPb3FRK016TWtxajZYTU0xU2txelVqS0hjWUwvVW1odTRwaU44SW9j?=
 =?utf-8?B?czdYSlRoTmkvakY4bTkweXZPTjVIQjc4OW10SXVUUGFSM0JwaHpZMDRLUjdw?=
 =?utf-8?B?R2E2S2pMVFAzZ09lRWlQV3Jrdi9qWFc3dytuaCsyZjU0NzNKQlBYUk9UYUlF?=
 =?utf-8?B?VklXVDdsRk9hUXdmK2N2MEw5OUJBYitvNFlYZFY2eEM3ZStIMWN3eTRhR0Yx?=
 =?utf-8?B?TkN4NFMwT3JWNmlGTGt5MU1VTC9WbFNXVm1Pc0pLeTUvTmRQeUJ1c0tBWnh1?=
 =?utf-8?B?cHpzV0lBSUEwcEd1ajgzc0pOYkRlbVZieUd5T2owUlZ6YUhKcjhUU1o4VjU3?=
 =?utf-8?B?TTdPSU9EaGpHNUxkV2ljVHI3L01nRmpRQVVYaDJEbVpLaVZWZnNWWTI0Um05?=
 =?utf-8?B?ekhpUHl0N1RjazRGMW9IdDZiWlNTeW90bUtNb0ZkZUk0RkRWMEhLSnUvamtw?=
 =?utf-8?B?cXdROGszbGhBcFNKckVCdGVqMHB6NUY5bU1ORm9IS0V5OTVraEdEYWFtK1BR?=
 =?utf-8?B?S29heXc0TXVhMm9FU3dHT2xRSWZLR1BsNm42S2lncmxKMHZGc3lFM2lyeGZR?=
 =?utf-8?B?ZmdLcVQrRGd4NnE1Um9FQXQweUJNeXZaNVZ2WHpEdUpYMFNwY2pjakI1Tzgv?=
 =?utf-8?B?WVRRM2Y2MzhqbXllRTlrUVl5QUZSOXVhUkN0RFBtaXE3djMxL0phSFR0OVd4?=
 =?utf-8?Q?QLyDqvWdKfCZZ?=
x-microsoft-antispam-prvs: <VI1PR04MB48142CE82DE2E61AEC66A136EE740@VI1PR04MB4814.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(53546011)(6506007)(44832011)(66066001)(14454004)(256004)(81156014)(81166006)(186003)(71190400001)(478600001)(71200400001)(305945005)(11346002)(446003)(26005)(476003)(2616005)(7736002)(486006)(102836004)(6116002)(106356001)(5660300002)(37006003)(105586002)(2906002)(86362001)(6486002)(50226002)(36756003)(316002)(54906003)(229853002)(6636002)(6436002)(118296001)(8676002)(8936002)(25786009)(97736004)(68736007)(3846002)(76176011)(6512007)(6246003)(53936002)(4326008)(6862004)(99286004)(41533002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4814;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tj2INe2H5UDosLIZo4r+IKW10lZelRPR5ik8bqLoOe2OpqN+aZvsFZ+igJw1oomrGCaGh7gm99GEMsQ+SweG+F0H1QrvimkOZdGAL3Jrw0p0ofmXIV6c/o7xBbMmT5pJfba/8fIudgtkVbXYFAgodeOWRAEMIBvnV3zkMWWFiVMyJEkf3V9F+FZYmKpuUTLbUdsfgzo/EGrBH5SfM3aZzH4A1HliOghDZCVthEwsguDPOLgob/CrhyEYO/svIs+5Z7nTx30qzad6sGDPrbx0P0VN2ecJS2W4WCP2ozHZBtGWp9F2cNIWCa+TNRlzq31cZDgm1+1ZQQJ83Df/dTJ6xnnXGc0iWsR4/Q38bchZwYpvMlaAyqa4MyKZRYNOZLt6T7WUAc9EliWcLsdpYvaXa7sk8XuJCd6p7k1r4MYr++M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E72B2BDD410B0B44A11C5C957BDE5156@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b077115-5587-4a2a-db82-08d69cb5ae7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 13:15:44.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTI3IGF0IDA4OjQxICswMDAwLCBBYmVsIFZlc2Egd3JvdGU6DQo+IE9u
IDE5LTAyLTI2IDEzOjM0OjUyLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gT24gVHVlLCAy
MDE5LTAyLTI2IGF0IDEwOjUzICswMDAwLCBBYmVsIFZlc2Egd3JvdGU6DQo+ID4gPiBBZGQgZ2Vu
ZXJpYyBpLk1YOCBTb0MgZHJpdmVyIGFsb25nIHdpdGggdGhlIGkuTVg4TVEgU29DIHNwZWNpZmlj
IGNvZGUuDQo+ID4gPiBGb3Igbm93LCBvbmx5IGkuTVg4TVEgcmV2aXNpb24gQjEgaXMgc3VwcG9y
dGVkLiBGb3IgYW55IG90aGVyLCBpLk1YOE1RDQo+ID4gPiByZXZpc2lvbiBpdCB3aWxsIHByaW50
ICd1bmtub3duJy4NCj4gPiA+IA0KPiA+ID4gKwlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2Rl
KE5VTEwsIE5VTEwsICJmc2wsaW14OG1xLW9jb3RwIik7DQo+ID4gPiArCWlmICghbnApDQo+ID4g
PiArCQlnb3RvIG91dDsNCj4gPiA+ICsNCj4gPiA+ICsJb2NvdHBfYmFzZSA9IG9mX2lvbWFwKG5w
LCAwKTsNCj4gPiA+ICsJV0FSTl9PTighb2NvdHBfYmFzZSk7DQo+ID4gPiArDQo+ID4gPiArCW1h
Z2ljID0gcmVhZGxfcmVsYXhlZChvY290cF9iYXNlICsgSU1YOE1RX1NXX0lORk9fQjEpOw0KPiA+
ID4gKwlpZiAobWFnaWMgPT0gSU1YOE1RX1NXX01BR0lDX0IxKQ0KPiA+ID4gKwkJcmV2ID0gUkVW
X0IxOw0KPiA+IA0KPiA+IFR1cm5zIG91dCB0aGF0IGlteDhtcSB2ZXJzaW9uIGRldGVybWluYXRp
b24gaXMgdW5pcXVlbHkgbWVzc3kuIEkgdGhpbmsNCj4gPiB3ZSBzaG91bGQgdHJ5IHRvIHByaW50
IHRoZSByZXZpc2lvbiBudW1iZXIgZXZlbiBmb3Igb2xkZXIgY2hpcHMgc28gdGhhdA0KPiA+IHdl
IGtub3cgaG93IG9sZCB0aGV5IGFyZSwgYnV0IHRoaXMgY29kZSBjYW4gYmUgZW5oYW5jZWQgaW4g
bGF0ZXINCj4gPiBwYXRjaGVzLg0KPiANCj4gRmFpciBlbm91Z2guIEkgYmVsaWV2ZSB3ZSBzaG91
bGQgc3RpY2sgdG8gQjEgb25seSBmb3Igbm93IHRob3VnaC4NCg0KWWVzLCBwZW9wbGUgd2hvIHdh
bnQgdGhlaXIgb2xkIFNPQyByZXZpc2lvbnMgdG8gYmUgYmUgZGV0ZWN0ZWQgY2FuDQpzdWJtaXQg
bGF0ZXIgcGF0Y2hlcy4NCg==
