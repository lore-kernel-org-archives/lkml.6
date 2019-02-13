Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E33C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B55D21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PmzZyaVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392651AbfBMQXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:23:41 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:63806 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBMQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:23:40 -0500
X-IronPort-AV: E=Sophos;i="5.58,366,1544511600"; 
   d="scan'208";a="23798536"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Feb 2019 09:23:39 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 09:23:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35uzC3gz42JppQzcOlU7tTVi8bHkbWaC7ADT7Bj81mc=;
 b=PmzZyaVGoTZP/P/ApDMf0cEvMhnocdfYE29l/Mqz9Jg+CV0CFeAgb60cUZRbsSCNgczKFYL1VY3yHPxzVC9NhPPkOv5NHlv7ysYN87deszuxMlYZqcqbzx2kKNqVBLkp9s/KBwbHeTvjvmWN+FnitKlwI6BYONOg57ixU3CqyVU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1572.namprd11.prod.outlook.com (10.172.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 16:23:37 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 16:23:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <palmer@sifive.com>, <marek.vasut@gmail.com>
CC:     <wesley@sifive.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <paul.walmsley@sifive.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH v2 1/2] spi-nor: add support for ISSI's block unlocking
 scheme
Thread-Topic: [PATCH v2 1/2] spi-nor: add support for ISSI's block unlocking
 scheme
Thread-Index: AQHUu8mGKUlY2FcutUatqhzCBwYMZaXd+VWA
Date:   Wed, 13 Feb 2019 16:23:37 +0000
Message-ID: <35446d76-5712-c51f-e1ab-f81a53b1a4aa@microchip.com>
References: <20180807194059.26348-1-palmer@sifive.com>
 <20180807194059.26348-2-palmer@sifive.com>
In-Reply-To: <20180807194059.26348-2-palmer@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32aac2d6-7b19-4e25-362c-08d691cf9b2e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1572;
x-ms-traffictypediagnostic: BN6PR11MB1572:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIxNTcyOzIzOm9mTnlWOWlHWmtSbHNSRjFnR1VmM1lVbUJr?=
 =?utf-8?B?YXJCUXZ3dlJISlkwOUhzTyt5K0Y5b2lTbkg1dG9zOUxSdVU5VTh4SHJZanN1?=
 =?utf-8?B?RUZ5aGdBQU91S0RQRWQrajl4MlREdUVEd01kQ2Rnckp0Z2I2SEtqbVM5ZWdy?=
 =?utf-8?B?Y3FRVlFjWCt6OVpjRk5iaS9CeStoUElaTkFhOS9DNzlVckQ2S21lWWF4Rk1t?=
 =?utf-8?B?cHlRVmxVWVM4WEdOTUJVdk9NSmFheWxJQnJ2NWhNWFRnT3REcWpUWWRKcm9B?=
 =?utf-8?B?ZFQ4UUlKSXRRSVQ0Q0pUb0JrYW1oWi9rblJzcXZFZ2syeW0zZ0J0cUwyQjlL?=
 =?utf-8?B?bDNqYWh5Tmc4VkJVQ2dMM0UwK2NaL1F5cVNsRFQrOFhYT0o2cWtlM3ZIRUtt?=
 =?utf-8?B?b0xjVFZEd3M1Sm5qVjd0L1dGNzE5Wmx5SXVMUDNVL0JGUWNFSDE5eC93bnlW?=
 =?utf-8?B?OXYveVNQLzVMek5ac2IrZ2NLVmFFalJ5K2NEbG5UblBraDJGTWptSHBucTdD?=
 =?utf-8?B?ZEtxQ1lhZi9OamxIMEZkRTk1T0prVXRUajQ2VHpzblVYR2xuL1JtbURueTZn?=
 =?utf-8?B?VlhWa3lySzBmM0l1OVNoOEtNbmxoR0lzbTd1dVlwdS9DVkJRQUt6RlB4bW5N?=
 =?utf-8?B?N3EwQTFldnhHUGY3M1dWZXNpYXpYOTF2VmdQdm0wcWRXN3VBOFZjSDlmdTBW?=
 =?utf-8?B?emJWRjYwSGVCak5lejJ1ZTYrU1dlY0E5cnNKVXpvdXNPZzZVdGx6OC8wdkh0?=
 =?utf-8?B?akN1WFFGS2FOUVBzeCtMbjgrL2crSnFhazdEQ1BSeEVpWkEvOVZWRlF3V0hu?=
 =?utf-8?B?Y0wrRG9TOFZWRjV5Uld5c0ZORDJaREtyRUVoSEx3Mlk5U3lHZEp1bXpRcFVU?=
 =?utf-8?B?eDBCWU1DQWdZZ2xwa3h6V3duWlRnM2VpZXZubWdoc1Jadzc2YkRSL1FmVk9x?=
 =?utf-8?B?VTZubGFrQWgrRkpUK3V2NXpScnZJQmFza0tYVnRVODhrdkNiRkJmYWRhSTQ3?=
 =?utf-8?B?eVpFVmd3dGU2TGpEVWJLY0JxZkJ3bG9kNXlzMWdRZUN4b3NoYk40UXRLMDhx?=
 =?utf-8?B?ekJjN2kyZ2hFM2NFb1piV1MrNWtBenBybVV2Mk12bDZQTVNkdTc3djQvaEpq?=
 =?utf-8?B?UEUyR3BMNFdBb09pd3ZTeHNMWU9uN0JpVnJrZzd0d1FEQXN2dERmUzUrVzhq?=
 =?utf-8?B?TzNvY0Q5YTNVVk1yMUNtU2o4T04wUG5tU2JMVFNpMnlHRVliZmRzOFFXRVZ6?=
 =?utf-8?B?V0x3Tm1PbmZsV2ovNjlUWGpuSzFRMlVCQ1hBRjhKTVc0Z1YvL1Vwb0NHaEFS?=
 =?utf-8?B?dUVGS1V5QnZqdWV2NGRhd01ianN6Z2VGQS84UUFyVjFBWWxscnoyNXJ2Qi9W?=
 =?utf-8?B?UFJRRllSaTZBMHZtYjg2SVY0bHdNTlF3OWlnUkt0TklsbGoycmt2c1JBaStD?=
 =?utf-8?B?QjY3SHNRL1NXOTRZeUZaLzRkczhqNzF0MVZQNEVQWkFYWlFOYndsT1k3VDlr?=
 =?utf-8?B?djhkb0xBMXFiWm1pT0IreGZXZlQrTVRKWnZLYVNxcDBwVFJ0dzJNWjN1VnZ4?=
 =?utf-8?B?VTRhS2tuUE83cmJMVXQvSDlkTlV3YlZhZkM4Y2tNRFpYZjgzeno4YmhJeVpn?=
 =?utf-8?B?OGptRkxQNmRaMGhQL2c0N2NET1psVmRRcElyelg3eW1wc0taTmdEYWg1cTNk?=
 =?utf-8?B?QWo3bTBzSCs2cHBaL1RvR002M01hRXozTDlmQ01EYXlGYzYyWURpaUJOck84?=
 =?utf-8?B?WWZaUjdjcmRudGw1RHhxQnh1clFtd2dqN29DbDg2SWJWOUdsU2EyZW9XcG55?=
 =?utf-8?B?SmtENVZoenZiZGhzbXV3STdTRnFIdGM4Tms4T2NuajhsYVRQcUdvNmZMaHJE?=
 =?utf-8?Q?FRbq26eTSWg=3D?=
x-microsoft-antispam-prvs: <BN6PR11MB1572A68A1F2A593C00B3F671F0660@BN6PR11MB1572.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(51914003)(189003)(31686004)(6436002)(305945005)(256004)(486006)(2616005)(14444005)(476003)(14454004)(11346002)(446003)(53936002)(4326008)(2906002)(7736002)(3846002)(316002)(97736004)(6486002)(110136005)(8936002)(54906003)(105586002)(229853002)(6116002)(72206003)(7416002)(66066001)(71200400001)(86362001)(71190400001)(106356001)(966005)(6246003)(53546011)(386003)(478600001)(25786009)(6306002)(68736007)(102836004)(186003)(81156014)(6512007)(99286004)(36756003)(76176011)(81166006)(2501003)(31696002)(52116002)(8676002)(26005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1572;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qW0Iz4XbeH4YmR7wKdmzAHoXz//EoVcA+msYHr6Z/brUVwK0oaUa197xmvLDpmBRpKOXwiQdcfEOcvS4NeD+Bo3dQXDnOa0JdfTKfSmucXLNnNKhBdDBGlvKnREg2KN2SI+Fr3BKXtMTF5G7F219kQX7UTQX/oxslfR+TslwiUY6HnfdqorfSjuKk7HguKkQ0ciNiWlumoDvMwI4EMLVtRchXtuOgulR4jdM1O8tOapKwY84jjmMQ1ONxjx3JEz7OLgeYyLM3pbjg5/FEvdMHGyTrhBVudTPaO9vRn3Ykbo7ArrmxUwCBgl0GLOR8gzn0TUfY0MJTrXTcdyqV0ImA1QlZkAMzHzO+LHt3nnoN4yGH/9K//ALXsDjuJwTouAuftuHtsuvLTCDXrZ2VN4SUVTZP1cxxuJb5DNvuYt7RBM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8097D68D102B9746B6C7C05FC506FC2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aac2d6-7b19-4e25-362c-08d691cf9b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:23:34.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1572
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFdlc2xleSwgUGFsbWVyLA0KDQpPbiAwOC8wNy8yMDE4IDEwOjQwIFBNLCBQYWxtZXIgRGFi
YmVsdCB3cm90ZToNCg0KRmlyc3Qgb2YgYWxsLCB0aGFua3MgZm9yIHRoZSBwYXRpZW5jZSENCg0K
PiBGcm9tOiAiV2VzbGV5IFcuIFRlcnBzdHJhIiA8d2VzbGV5QHNpZml2ZS5jb20+DQo+IA0KPiBJ
U1NJIHVzZXMgYSBub24tc3RhbmRhcmQgc2NoZW1lIHRvIGNvbnRyb2wgYmxvY2sgcHJvdGVjdGlv
biwgd2l0aCBiaXQgNQ0KPiBvZiB0aGUgc3RhdHVzIHJlZ2lzdGVyciBjb250cm9sbGluZyBhbiBh
ZGRpdGlvbmFsIGJsb2NrIHByb3RlY3Rpb24gYml0Lg0KDQpJbmRlZWQsIGlzc2kncyBibG9jayBw
cm90ZWN0aW9uIChCUDMsIEJQMiwgQlAxLCBCUDApIGJpdHMgYXJlIHVzZWQgaW4gYQ0KZGlmZmVy
ZW50IHdheSB0aGFuIGhvdyBhcmUgdXNlZCBpbiBzdG1fbG9jay91bmxvY2ssIGV2ZW4gd2l0aCB0
aGUgNGJpdCBibG9jaw0KcHJvdGVjdGlvbiBvbiBpdHMgd2F5IChzZWUgWzFdKS4NCg0KPiBUaGlz
IHBhdGNoIGRpc2FibGVzIGFsbCB0aGUgYmxvY2sgcHJvdGVjdGlvbiBiaXRzIHdoZW5ldmVyIGFu
IElTU0kgY2hpcA0KPiBpcyBzZWVuLg0KDQpJUzI1V1AyNTYncyBkYXRhc2hlZXQgc2F5cyB0aGF0
ICJUaGUgZGVmYXVsdCB2YWx1ZSBvZiB0aGUgQlAwLCBCUDEsIEJQMiwgQlAzLA0KUUUsIGFuZCBT
UldEIGJpdHMgd2VyZSBzZXQgdG8g4oCcMOKAnQ0KIGF0IGZhY3RvcnkuIiwgd2hpY2ggbWVhbnMg
dGhhdCBhbGwgbWVtb3J5IGJsb2NrcyBjb21lIHVucHJvdGVjdGVkICh1bmxvY2tlZCkgYnkNCmRl
ZmF1bHQuDQoNCkkgc2VlIHlvdXIgcGF0Y2ggYXMgYW4gZXh0cmEgc2FmZXR5IG1lYXN1cmUgZm9y
IHBlb3BsZSB0aGF0IHNvbWVob3cNCnVuZm9ydHVuYXRlbHkgc2V0IHRoZXNlIGJsb2NrIHByb3Rl
Y3Rpb24gYml0cywgc28gdGhhdCB0aGV5IG5vdCBlbmQgdXAgd2l0aA0KbG9ja2VkIGJsb2Nrcy4g
SW5zdGVhZCBvZiBhZGRpbmcgdGhpcyBleHRyYSBzYWZldHkgY2hlY2svc2V0LCBJIHdvdWxkIHN1
Z2dlc3QgdG8NCmFjdHVhbGx5IGFkZCBzdXBwb3J0IGZvciB0aGUgaXNzaSdzIGJsb2NrIHByb3Rl
Y3Rpb24gc2NoZW1lLiBJbiBhIHBlcmZlY3Qgd29ybGQsDQp0aGlzIHdvdWxkIGZpdCBpbiBhIHBl
ci1tYW51ZmFjdHVyZXIgaG9vayBhZnRlciB0aGUgcGVyLW1hbnVmYWN0dXJlciBzcGxpdCB1cA0K
Y29kZSB3aWxsIGJlIGludGVncmF0ZWQgKHNlZSBbMl0pLg0KDQo+IA0KPiBXZSBtaWdodCBhbHNv
IHdhbnQgdG8gdHJpZ2dlciBhbiBlcnJvciB3aGVuIHdyaXRpbmcgU1JfVEIgdG8gdGhlc2UNCj4g
Y2hpcHMsIGFzIGl0IGFsaWFzZXMgd2l0aCB0aGlzIGV4dHJhIHByb3RlY3Rpb24gYml0IGluIHRo
ZSBzdGF0dXMNCj4gcmVnaXN0ZXIuICBJdCBsb29rcyBsaWtlIHRoYXQncyBhbHdheXMgY29uZGl0
aW9uYWwgb24gU05PUl9GX0hBU19TUl9UQiwNCj4gc28gYXQgbGVhc3Qgd2hhdCdzIHRoZXJlIGlz
IHNhZmUuDQoNClRoaXMgcHJvYmxlbSB3aWxsIHZhbmlzaCB3aGVuIHlvdSdsbCBoYXZlIHRoZSBp
c3NpJ3MgcHJvdGVjdGlvbiBzY2hlbWUgaW1wbGVtZW50ZWQuDQoNCkNoZWVycywNCnRhDQoNClsx
XSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEwMTE4MjAvDQpbMl0gaHR0cHM6
Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LW10ZC9saXN0Lz9zZXJpZXM9ODAz
NTMNCg==
