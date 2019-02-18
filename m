Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A581C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14301217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FI9a0eXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390652AbfBRQ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:57:48 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:49931 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390589AbfBRQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:57:48 -0500
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; 
   d="scan'208";a="27909268"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 09:57:46 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 09:57:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=damPiT/3s2KQ9GhWYRW8XN/kpaYaVYpj33A2rGq364E=;
 b=FI9a0eXpPGht1M4A8OjPqk/tGPecgQPumWF+0XSZ5kg+2xXmSNtfnEGHlVn5QauODrfFiaYYVlqV+LPKEhwNdiP2rFkljtUHVkWEX+qMLHtz/mGIY8V9JXUioCqSdLM8G42+zzcD2eIQrgurHSd1HNDPoTuHRKZMgBQZN/OTruU=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1544.namprd11.prod.outlook.com (10.172.70.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 16:57:44 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 16:57:44 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] ASoC: codecs: ad193x: Several fixes and imprevements
Thread-Topic: [PATCH 0/5] ASoC: codecs: ad193x: Several fixes and imprevements
Thread-Index: AQHUx6sR0kKMfbXl6Uy5zdhSxOJ4LQ==
Date:   Mon, 18 Feb 2019 16:57:44 +0000
Message-ID: <165c7445-4023-5069-313e-8c8f8c0475f4@microchip.com>
References: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::18) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a555501-9312-4e77-b949-08d695c2338a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1544;
x-ms-traffictypediagnostic: CY4PR11MB1544:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjExTUIxNTQ0OzIzOloxSnREYzBCbWZmcnowckFxRXQ5bkpYa29y?=
 =?utf-8?B?dy81NWt6UDA0OHYzaG51bG9qelBYWmduelNMWmY0TEpQbElxNlhDRE5jbjJO?=
 =?utf-8?B?YkV0aFBuNCs2M08vWFJSY01YOXN1YVdRRDZKUUxwNWExZXErQk5iK0JLcXFH?=
 =?utf-8?B?QjNFNkJ2SFU2Q0ZYeUJzMmlPbDlkSDQ4aGhFcVBoYTdmRi83UmZVNGl5dnBm?=
 =?utf-8?B?QTkxbElyNU9VSHNkMmxsN0pHUHlLdVhFbFA1YllLc0d4ckdXNkNpY3cvTVpQ?=
 =?utf-8?B?ajB2dG9yQ3RNR3VxdG9pOHVYRjNIcFYvKzV3UGVDMVFvRlV2ZkVUSWFleFNy?=
 =?utf-8?B?cHROMkE1ZDlkek1kdkIrWk8wdWN3SkRxMjlwdlYxSEhJK2hQMml1bWpGN3lP?=
 =?utf-8?B?V0RMVnd4WjNUQUFIelBZUFA2eGFDS09UNUZZRWNqSzdLd3N0VGFMeGNjV1Q2?=
 =?utf-8?B?bmFxWXhlSjFHNzhwQWJtSktBZFlkN253bU16WjYrM1pjdU5OOXhEL0drMlA2?=
 =?utf-8?B?VnBGS25RNjFvWlBhUDBURzNlVFFDL1ZKZm54NGRXUkNMamtnc0N1Uzl5NHc3?=
 =?utf-8?B?TThSYzFLNkFRbnpSV1dpcXF2VkZLZzY2K2N5Y1BLcUdPeVQzYzRTRTN5Rzg3?=
 =?utf-8?B?V3lsdktNSGtxN2JLWnNhcHZxZDlqU0VrUm9SYWZaaWhiR2pteWEwVWFjY005?=
 =?utf-8?B?akJWY2J1NkM3d3duMTRVQ1FTbmxrMjljb3JjTkJpVzZwYi9BUmIzeG9Qa2N3?=
 =?utf-8?B?RDJxYXVPeGNFK09EN1ZsN01PVWE1U2txRXhkMXh2bURRc0pWU0Z2cWJCd3A1?=
 =?utf-8?B?cWcvb1huaC9mbEhKNUY4L09sT014YTcvUjdsZlFEL1A0M3ZyNmoxRWRUT2xR?=
 =?utf-8?B?WFVUTWg5bkVTNG5oejZnTVJkM0lLNytWQ0lmdFBTcWdqZHZTVEFKVkQxaDZm?=
 =?utf-8?B?bnZLclEwVzVEaitiQ2krbDZ1Vlhla0tNa1Y2RW1tZ3pqaDBnd0JMRldCb1RJ?=
 =?utf-8?B?R3hHRUJsQWg3ajRZNnBSQTVTZXI1N1JuUTJQSG1aK2JOZTJ3UWlJRHBRNTEz?=
 =?utf-8?B?aXlpUHZCeEpSZFhFL0ZuakRMTFNZVyt4Q0RPR2t6ajVZRHlxUSs1TlFvSHJZ?=
 =?utf-8?B?OS9pU1pybkxzblRmY0VmTzB2NjZheW84RTNleGE4U2MxV29jNXduWm10Ymd5?=
 =?utf-8?B?NHJiSGt3N0o4bUdGMUkzUDFrbGpEckh6eHU1VGV6SmpYcEJXaTV2L3VZWWx1?=
 =?utf-8?B?ODBLUTFVaEFPSDQreDU4STMzT01MaGRBNmN5RlMzWENCZVNKcWIreld0UDFH?=
 =?utf-8?B?bkdPK3h4U2hOcll0djJkMTYzUzNGVlgvWUUwbW9oem05b2lpazRkNXNzeTVE?=
 =?utf-8?B?ampsZ0xrK3lWVHM2bS9kMXNkelA0THBBeFFuUmc2VlpGL2Q2cTBZRVdtaWlh?=
 =?utf-8?B?dHFSYjRsU2M4YTdSbXJiTC95MmdWWXFMNG9MUmRSMStsODd5VWdRUVJiZXA0?=
 =?utf-8?B?TXZWazlldVc1YWMxb0xCTG9iZEViRTU4OXpYU1VpNGh4VFZzVXkwLy9FT1Q0?=
 =?utf-8?B?d3hXWEM5QzN1c3dpRXJ1NDU3NUFHYUZXenl2TTdYWUZhSW1xckZNOEpMU0VO?=
 =?utf-8?B?TnI4dDcrY3NDdThndmtHV080T3FQMGh5UmhaaUdJWGJvaWxZOW4yMkNRRllG?=
 =?utf-8?B?djVwY05KV0dxZHpwZXRuMXE0bGRmR0l1TjlBOEVkYlYxR1B5MW94VlZ5MGxq?=
 =?utf-8?B?ZExZeC93SzgrTU1oL2o0cjY4ZXdEUHdNZzhYQnlCVDRCZXUvdEdmM0hnWUI3?=
 =?utf-8?Q?HreAPqCePLCZt?=
x-microsoft-antispam-prvs: <CY4PR11MB1544DA62AF718ED0E257C754E7630@CY4PR11MB1544.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(396003)(136003)(189003)(199004)(2906002)(97736004)(52116002)(105586002)(5660300002)(31686004)(66066001)(86362001)(14454004)(6246003)(26005)(36756003)(186003)(2201001)(76176011)(99286004)(6506007)(53546011)(386003)(102836004)(478600001)(256004)(2616005)(6436002)(25786009)(72206003)(54906003)(6486002)(6512007)(2501003)(316002)(446003)(8936002)(486006)(6116002)(4326008)(8676002)(71190400001)(68736007)(476003)(229853002)(11346002)(3846002)(305945005)(31696002)(106356001)(71200400001)(81166006)(81156014)(7736002)(53936002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1544;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mTLY3d19nUbVV5/S+yIZ8mrM/5jxsxehAorAKGPQc6r1cpEX4vYG4S4FyZrnV1zVMuQMfybKvOjXCJ8u5urPU9htZ2P3Wl1PXKutuiZ9Ad1Iv7jJO7xoAdgba+ru7alZ0YA2qU3req9kY7oCUsKCKKi/K3vFhpbDTi5J3PvcslLrksk7jxlRLNua67AzJT7TLvY1gm1oEBnuWbyG88KbsJ6kFpyrkJ3FkTZKmoB5NOtuNqjbX7SycHeohMGSFL7ePPiinTrs/OrWy9SP47alWlhopiRxFmysgn0YlFZNVwR6DTBFwAyR8Pbyoe/slJL2UtkNc+Gm+rfqFt1AJHq9dyWN9c0TV6hNkXEJjXblWfja4g7HO/cdJxhjgy1EsEniZp9ufsRQmGtl6OfRoqW25sTxaW9q/ErW2TQBhu/VC4k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AC5BFC5BC1AAD46B4553033B17F9AC9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a555501-9312-4e77-b949-08d695c2338a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:57:42.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1544
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDIuMjAxOSAxODoxMCwgQ29kcmluIENpdWJvdGFyaXUgLSBNMTk5NDAgd3JvdGU6DQo+
IEZyb206IENvZHJpbiBDaXVib3Rhcml1IDxjb2RyaW4uY2l1Ym90YXJpdUBtaWNyb2NoaXAuY29t
Pg0KPiANCj4gVGhpcyBwYXRjaCBzZXQgY29udGFpbnMgc29tZSBjaGFuZ2VzIEkgbmVlZGVkIHRv
IG1ha2UgSTJTIGFuZCBURE0NCj4gKERTUF9BKSBmb3JtYXRzIHdvcmsuIEkgdGVzdGVkIG9ubHkg
d2l0aCBhZDE5MzYsIGJ1dCB0aGUgcGF0Y2hlcw0KDQphY3R1YWxseSwgaXQncyBhZDE5MzQuIFNv
cnJ5IGFib3V0IHRoYXQuDQoNCkJlc3QgcmVnYXJkcywNCkNvZHJpbg0KDQo+IHNob3VsZCB3b3Jr
IGZpbmUgZm9yIGFsbCB0aGUgY29kZWNzIHRoYXQgdXNlIHRoaXMgZHJpdmVyLiBBbHRob3VnaCBJ
DQo+IGNoZWNrZWQgdGhlIERTIGZvciBhbGwgb2YgdGhlbSAoSSBob3BlKSB0byBhc3N1cmUgdGhh
dCB0aGUgcGF0Y2hlcw0KPiBhcHBseSwgSSB3b3VsZCByZWFsbHkgYXBwcmVjaWF0ZSBpZiBzb21l
b25lIGVsc2UgY2FuIHRlc3QgdGhlbSBvbg0KPiBhbm90aGVyIGNvZGVjLg0KPiANCj4gQ29kcmlu
IENpdWJvdGFyaXUgKDUpOg0KPiAgICBBU29DOiBjb2RlY3M6IGFkMTkzeDogUmVtb3ZlIGNhcHR1
cmUgc3VwcG9ydCBmb3IgY29kZWNzIHdpdGhvdXQgQURDDQo+ICAgIEFTb0M6IGNvZGVjczogYWQx
OTN4OiBTZXQgY29uc3RyYWludCB0byBhbHdheXMgaGF2ZSAzMiBzYW1wbGUgYml0cw0KPiAgICBB
U29DOiBjb2RlY3M6IGFkMTkzeDogRml4IGZyYW1lIHBvbGFyaXR5IGZvciBEU1BfQSBmb3JtYXQN
Cj4gICAgQVNvQzogY29kZWNzOiBhZDE5M3g6IEFkZCBydW50aW1lIHN1cHBvcnQgZm9yIERTUF9B
IGFuZCBJMlMgbW9kZXMNCj4gICAgQVNvQzogY29kZWNzOiBhZDE5M3g6IEFkZCBzdXBwb3J0IHRv
IGRpc2FibGUgb24tY2hpcCBQTEwNCj4gDQo+ICAgc291bmQvc29jL2NvZGVjcy9hZDE5M3guYyB8
IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgIHNvdW5kL3Nv
Yy9jb2RlY3MvYWQxOTN4LmggfCAgOCArKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgODAgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQoNCg==
