Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4611A21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="krsRwCIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfBSJRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:17:47 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:47213 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfBSJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:17:47 -0500
X-IronPort-AV: E=Sophos;i="5.58,387,1544511600"; 
   d="scan'208";a="24881806"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 02:17:46 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 02:17:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF/cZJA+noV/VgOqQqn7GVYxuPexDJ0GlRMK0UQ8gGo=;
 b=krsRwCIj1Uk6qNLEWkhSbDRW4MpBBkMSIZdnEs1av5tjUuODzERF6ZFYZiGGuopA5uXeckY4ERH0lsuhiNk/BR0vyP3HDJjFzmWo1A/EgiWCtI11Gw5NflB5r/Eyl0+8qr+YASRUhMfmIF9mMFtPsFdWwkYXPKZG9QQftnG70cM=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1352.namprd11.prod.outlook.com (10.169.254.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 09:17:43 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 09:17:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Thread-Topic: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Thread-Index: AQHUxF7XgscBW81rJUmiAtq1msPxS6XmFrOAgADIdYA=
Date:   Tue, 19 Feb 2019 09:17:43 +0000
Message-ID: <c00fb195-1688-6ac4-a606-5e08509a2c39@microchip.com>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
 <20190218212007.GW10129@piout.net>
In-Reply-To: <20190218212007.GW10129@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0322.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::22) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190219111735557
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67e4f86d-2b75-47f5-eac8-08d6964b1a93
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1352;
x-ms-traffictypediagnostic: CY4PR11MB1352:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjExTUIxMzUyOzIzOnBsa09SR1Q5OGZTT1JudGNyZkRIOFk4MDV1?=
 =?utf-8?B?NEJxQUg2Ulh2akFFN2UyWWxvSjZNWVBlbWNVN3FRTmc5ODArR2NhUHBWYWxT?=
 =?utf-8?B?VkpQbW0xYVJ6N1ZER3BqU3pXT1FCYVFVL2FCcXZObDRIWXpQa01DL0tEZU9p?=
 =?utf-8?B?S0tWZk5wVXEwSDdCUkI2eXhKYTdjT2FaT0tVSFlmdkNMVEM2L3djM2pveTlw?=
 =?utf-8?B?NFRYUUFVelZmUWhHTG9GbG85T0lVVWt1OWJPVHp6K1A1Q05TSDY3WUJIUTFv?=
 =?utf-8?B?OHRxYlFJZi9ZeTYzQjFNclpYeVlUazFHSHhnVWdXTXV3QmJrWmN5ellyYmtz?=
 =?utf-8?B?RHlYakdjRkVwSktnRDZNeVNvZ3BUSXpjSU9vMFgzVVFvMmNvQk0wTHRldm9N?=
 =?utf-8?B?UFJLczVuQjM5UTgra0hnNzE2SHhGWjhMeGkycDhTZTNRSW1KYjdjcy93a2ds?=
 =?utf-8?B?LzRpd28zZmRXdHE4V3ZNaVNPT3JaYWZJODFYaUo1aWRwYWNBeGxlajc3M0JP?=
 =?utf-8?B?NVhwNmJ0dTlYK2V2aVFrdGg1K2dzSTdlejU5bVBldVV1TGRKMmIxa2VBQjNW?=
 =?utf-8?B?NmxmMkhkZzRtYXQ4VlppVEJBcXBGV0FWV0h6amlqWkMzbTNBdnhjVkxBdGF1?=
 =?utf-8?B?MEpETzVNRDA4SUVYckpMejdFbjVoRWMwNjZXSUhmRm9YdnFxeFQzaS95bWNi?=
 =?utf-8?B?S1l0UWx0TGVuQVlZSkFIbmw5MU1iZzVkNlQ5WEdIZEhMUm50dy93NnVPQmtI?=
 =?utf-8?B?S0xFUjRSOXd6TTA2bC8zQ0ZTdTV3TFN5SjgvQ3Q0a3RveUJ6eklCbGYyWW5l?=
 =?utf-8?B?clFZbWlUOEhLM1FKeGx5c21zWTBWMDZEcm15QVhvQm11bkprNDdxaGoxNmhX?=
 =?utf-8?B?VktxaVVKbHpGWlQ5N2ZlVlFEaExtcndhL0k3aVJJYS9Ram9GUWlHcHBQMGlS?=
 =?utf-8?B?ZzUxemlab3BkZUlFS3ZDRDJjOU5UcEhGZWtqYlZIQVlyWUc4bSsyeG1pU0Ji?=
 =?utf-8?B?YVdjVVhnMG9tb25UUGlRNUoxL1REbjgyYWx1dytaUXZZV1FUdWlwSXJCalVW?=
 =?utf-8?B?YU0yTndpWDhqWGNIWEV4OEttUFVWdE5rRDBKQ2pDbTZEN3orclpQVzdBd1VX?=
 =?utf-8?B?QVVBdkVQWXgwUmxIWTdqWjJxdEJtWjMxcUsvc3hXNVhOaGxCQUsrUVpWZ2lX?=
 =?utf-8?B?N3l0YmRJU29raWREdXZIQ2RZZ3J2QU9JMk9PTFRodUlxYTlLN2ZjbDdhb214?=
 =?utf-8?B?cHJDRXZBQmRqeHFhVnZ4WTdURTR0Q3NtWkF2N1VUa2I1dnBSbWVVdTRRMlVw?=
 =?utf-8?B?b2hsWnZhNjlqZFB4SnRGQU1jdk9nSXpZSVJOM0NDYkg1aTQ3ZXphT1pyeGU4?=
 =?utf-8?B?NTgrN3diWWhYZVdlRUFpY2xnckN3dnhac0JxRzRERTBzVTkzTnVzQkNNczV1?=
 =?utf-8?B?TzBEcU1ybjNoNk5TN1plM3FKT01TdFJHODhQeGhrbDdNNGVDZnpHcE9qUjgv?=
 =?utf-8?B?SWtqcUdHWWRiQmxXOVY5Q3BaalllS1poc1hOUEE3QWc5V3hDTlJMNEJBM2dE?=
 =?utf-8?B?dTJnb2RiK2Q5VVpRVTdrR3g4azlnK09rekx4WDB5OFEvVXNrbHR5Ni9ydWc2?=
 =?utf-8?B?dnF6bk5hRjRmNkwycWJIMDg4aXU3bzNlQUxKWG52VGh1Um1WQjkrTTZRa0ZC?=
 =?utf-8?B?OW1tWDNHcFJmY2NDNlV0eE1DcjcyMldNNkZHYm9XSlVnbzYyRXJORmM5QWFV?=
 =?utf-8?B?djdkN29CbUxvdWZzL3pDdz09?=
x-microsoft-antispam-prvs: <CY4PR11MB1352F0ACC91AB348496F0E49877C0@CY4PR11MB1352.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(11346002)(446003)(2616005)(7736002)(476003)(102836004)(52116002)(486006)(76176011)(99286004)(26005)(6506007)(53546011)(186003)(305945005)(386003)(6916009)(2906002)(81166006)(81156014)(31686004)(105586002)(8676002)(36756003)(8936002)(106356001)(86362001)(31696002)(256004)(6436002)(6486002)(25786009)(6246003)(71190400001)(4326008)(72206003)(71200400001)(6512007)(5660300002)(316002)(53936002)(6116002)(14454004)(478600001)(3846002)(97736004)(68736007)(66066001)(54906003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1352;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qoe2uhly3uFK6jbHFC9Vkehgeh8QE+MYrGhfStssOiyXpUIHMBJo6RSvfGvPUd36uDTy6QXZUYJ8+MiY6tFLTL0j24ekhU7iHDyDXxRS8WYayMI6kEU+pkfInCeoSyhCWfAOkkMkLT5Kk4Pv00xlOMBg0TxH2lpjmk1NP1pbVF7VGWt/5LzevEEqqno4pB7blVsC2EV2LKr6n1bKBf5mYn1eJMLjgZFvMZSwwNNFA/b/B8TJgZXvjtffFm6WE+mWF6q/S3gwxOQj0ApC7gdYxHEXhBOvo8supKd1cgKwTow4vRM0h6wtTT+P/tafztisvpGeOLx2+pYpUmPMgLrbyufFmenwKUFv+i1IQ1VbMS90BkzStOgrgT2JXOULKlJKKbwfwDLtsTzzbozeFhPNFXXFNTHOM+tEtxXL1wPmaCw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <295E9E7462964B43873190813069E9E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e4f86d-2b75-47f5-eac8-08d6964b1a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 09:17:40.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1352
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE4LjAyLjIwMTkgMjM6MjAsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBPbiAx
NC8wMi8yMDE5IDEyOjE0OjMyKzAwMDAsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCj4+DQo+PiBBZGQgc3VwcG9ydCBmb3IgU0FNOVg2MC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0K
Pj4gIGRyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMgYi9kcml2ZXJzL2Nsay9hdDkxL3Nja2Mu
Yw0KPj4gaW5kZXggYjcxNjNkM2EyMjY5Li5iMzA3NWM1MWQyNjAgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL2Nsay9hdDkxL3Nja2MuYw0KPj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMN
Cj4+IEBAIC00NTksNiArNDU5LDM2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvZl9hdDkxc2FtOXg1
X3Nja2Nfc2V0dXAoc3RydWN0IGRldmljZV9ub2RlICpucCkNCj4+ICBDTEtfT0ZfREVDTEFSRShh
dDkxc2FtOXg1X2Nsa19zY2tjLCAiYXRtZWwsYXQ5MXNhbTl4NS1zY2tjIiwNCj4+ICAJICAgICAg
IG9mX2F0OTFzYW05eDVfc2NrY19zZXR1cCk7DQo+PiAgDQo+PiArc3RhdGljIGNvbnN0IHN0cnVj
dCBjbGtfc2xvd19vZmZzZXRzIGF0OTFzYW05eDYwX29mZnNldHMgPSB7DQo+PiArCS5jcl9yY2Vu
ID0gQVQ5MV9TQ0tDX09GRlNFVF9JTlZBTElELA0KPj4gKwkuY3Jfb3NjMzJlbiA9IDEsDQo+PiAr
CS5jcl9vc2MzMmJ5cCA9IDIsDQo+PiArCS5jcl9vc2NzZWwgPSAyNCwNCj4+ICt9Ow0KPj4gKw0K
Pj4gK3N0YXRpYyB2b2lkIF9faW5pdCBvZl9hdDkxc2FtOXg2MF9zY2tjX3NldHVwKHN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbnApDQo+PiArew0KPj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNoaWxkbnA7
DQo+PiArCXZvaWQgKCpjbGtfc2V0dXApKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIHZvaWQgX19p
b21lbSAqaW8sDQo+PiArCQkJICBjb25zdCBzdHJ1Y3QgY2xrX3Nsb3dfb2Zmc2V0cyAqb2Zmc2V0
cyk7DQo+PiArCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKmNsa19pZDsNCj4+ICsJdm9pZCBf
X2lvbWVtICpyZWdiYXNlID0gb2ZfaW9tYXAobnAsIDApOw0KPj4gKw0KPj4gKwlpZiAoIXJlZ2Jh
c2UpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCWZvcl9lYWNoX2NoaWxkX29mX25vZGUobnAs
IGNoaWxkbnApIHsNCj4+ICsJCWNsa19pZCA9IG9mX21hdGNoX25vZGUoc2NrY19jbGtfaWRzLCBj
aGlsZG5wKTsNCj4+ICsJCWlmICghY2xrX2lkKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4gKwkJY2xr
X3NldHVwID0gY2xrX2lkLT5kYXRhOw0KPj4gKwkJY2xrX3NldHVwKGNoaWxkbnAsIHJlZ2Jhc2Us
ICZhdDkxc2FtOXg2MF9vZmZzZXRzKTsNCj4+ICsJfQ0KPiANCj4gWW91IGFjdHVhbGx5IG5lZWQg
dG8gaGF2ZSBuZXcgYmluZGluZ3MuIFRoZSBzYW05eDYwIHJlZ2lzdHJhdGlvbiBzaG91bGQNCj4g
bG9vayBtb3JlIGxpa2UgdGhlIHNhbWE1ZDQgcmVnaXN0cmF0aW9uLiBJIGhhdmUgYSByZXdvcmsg
Zm9yIHRoZSBzYW05eDUNCj4gc2NrYyB0aGF0IEkgd2lsbCBzZW5kIHRoaXMgd2VlayB0byBoYXZl
IGEgcHJvcGVyIGJpbmRpbmcgKGkuZTogbm8NCj4gY2hpbGRyZW4pLg0KDQpEb2VzIHRoaXMgbWVh
bnMgdGhhdCB0aGlzIHdvdWxkIGFsc28gc29sdmUgdGhlIHByb2JsZW0gSSB0cmllZCB0byBhZGRy
ZXNzDQp3aXRoIHRoaXMgcGF0Y2g/DQoNCj4gDQo+IEhvd2V2ZXIsIHRoZXJlIGlzIGEgZnVuZGFt
ZW50YWwgY2hhbmdlIGluIHRoZSBzYW05eDYwLCBwcmV2aW91c2x5LCB0aGUNCj4gc2NrYyBoYWQg
b25seSBvbmUgb3V0cHV0IGNsb2NrLiB0aGUgc2FtOXg2MCBoYXMgYm90aCB0ZF9zbGNrIGFuZA0K
PiBtZF9zbGNrLiBCb3RoIG5lZWQgdG8gYmUgYWNjZXNzaWJsZSBiZWNhdXNlIHRoZXkgYXJlIGlu
cHV0IHRvIHRoZSBQTUMuDQoNCkkgd2FzIGd1aWRlZCBieSB0aGUgZmFjdCB0aGF0IG1kX3NsY2sg
aXMgZ2VuZXJhdGVkIGJ5IHRoZSBhbHdheXMgb24gc2xvdyBSQw0Kb3NjaWxsYXRvciAocGFydCBv
ZiBzbG93IGNsb2NrIGNvbnRyb2xsZXIpIGFuZCBzaW5jZSB0aGVyZSBpcyBubyBjb250cm9sDQpm
b3IgaXQgb24gc2xvdyBjbG9jayBjb250cm9sbGVyIHRoZXJlIGlzIG5vIG5lZWQgdG8gYmUgZGVz
Y3JpYmVkIGJ5IHRoaXMNCmRyaXZlci4NCg0KPiANCj4gVGhpcyBtZWFucyB5b3Ugd2lsbCBoYXZl
IHRvIHJlZ2lzdGVyIHRoZSBzY2tjIHdpdGggb2ZfY2xrX2h3X29uZWNlbGxfZ2V0DQo+IGFzIHRo
ZSBnZXQgY2FsbGJhY2suDQoNCk9rLCBJJ2xsIGxvb2sgaW50byBpdC4NCg0KPiANCj4gV2UgY291
bGQgc3RpbGwgZGVjaWRlIHRvIGRvIHRoZSBzYW1lIHdpdGggc2FtOXg1IGV2ZW4gaWYgaXQgaGFz
IG9ubHkgb25lDQo+IG91dHB1dCBjbG9jay4NCj4gDQo=
