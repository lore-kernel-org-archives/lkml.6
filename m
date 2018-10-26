Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D68C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B92B205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="R+ge6HCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B92B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJZTmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:42:13 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46478 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJZTmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:42:13 -0400
X-IronPort-AV: E=Sophos;i="5.54,427,1534834800"; 
   d="scan'208";a="23111601"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Oct 2018 04:05:33 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 26 Oct 2018 04:05:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmQVjw43B98zlMHz/cGZ8eWJIrihAQyMTO6ZSRd7eYA=;
 b=R+ge6HCJs/hvtXc8ZyPmuxzGbC+kSNBLKvWSB/D6NHpomrL0rdlLYYOrm1y0581ZWHjjSjf5ojoYd6t2nXd2rhSXLM6bzPzaTDnuEAvQABdKuSRkRloG9CtLD6Dn2r7Oopqb5/7j0MT9XjlitUQ2uEjLoNs3kHIkbtZVJPXpOvI=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0616.namprd11.prod.outlook.com (10.163.159.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Fri, 26 Oct 2018 11:05:30 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1273.021; Fri, 26 Oct 2018
 11:05:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jonas@orbital-systems.com>
CC:     <alexander.stein@systec-electronic.com>,
        <linux-kernel@vger.kernel.org>, <sre@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
Thread-Topic: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
Thread-Index: AQHUZVRe/70fNEEmkkyQnDUBwInNrg==
Date:   Fri, 26 Oct 2018 11:05:30 +0000
Message-ID: <f8ed781a-2ee7-9d0e-1220-b23ccf3fdbb2@microchip.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org>
 <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
 <2351196.3BzoFE0xYq@ws-140106>
 <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
 <11b4bcb4-8882-bdd2-c7f7-6a74d0758cbc@microchip.com>
 <CALDOjzhgqcx5XEWon9EQXEGxt9J280Z6AvuFQcBa=nh-9VA6PQ@mail.gmail.com>
In-Reply-To: <CALDOjzhgqcx5XEWon9EQXEGxt9J280Z6AvuFQcBa=nh-9VA6PQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0011.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::21) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0616;6:RjJPqzGvK3GQgvUbv3EdmgQMFn/cQTif/86TNxfogW/FHLbLHaEFaLPGGliK4l9r/wcYNedrx5Oc9ZnROviTZmF3gU/7t5CJpu71WPiyYUWneH13QwCb+8/HUxOWM9bZikrZ0PqiDHfKJGXdo67Evq6yzOBdFB85F80c4ubwhYCGBSglGtPh52kSyBfj5W69YLRFCkxQTLvAhC2Ypd0Db5A6a1fg7GMrKT82pruqk6b1mRaHQK88Yo0WmwzCNFZQGsBakL1HokZGk9XHB7itNrKZZKXi6j102XMUE5cF9tstV7+VGi1MTEyctnfpNDRrloplCkiPM10MKhOl6vFVMCyyEXQS+tnAchRsBpXsnnfn/WPV5m0K9nmcOFueuvv7RkOL/qFlBLOEVIwyq5HN2/2Cd8dILUNYzKem4Z3CrXH+pKOGRV7a09+tVL+I+3vBa7leh4U5obR2HGjAWAuOElD6PoVnHVf3D0kZGh3QifA=;5:jec7sZ9e8lJFSBqMm2MF7XkqLrE8Rtr35JT6TX5MWHQxTF65fu3m1FaQjyVJHAhvZ1Ga1mnGvp0h9v9SUhC6TI9VRpcAX5TFoDrvIj4eUH1kHQK60ziQyRlKd7vc7vLS80sC6U4q51+1K17GJzF6AKiyXVkBBJQcxzn4ZLqyEzs=;7:lddOLo7hu1GelB79NY+L/yDiNslLqr01iqbz6OYGIynPxx7UxFunKyNAJqa9Sunq1vV8KXJtU4gzamm9qZ4Ry5DP9YBBzuTXjTdl/ue4962u7a+noS8PYaT2SrOAlnWel2uY1yooAOjLTUjPsoCpvw==
x-ms-office365-filtering-correlation-id: 274b5e64-a301-477d-7f13-08d63b32f082
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0616;
x-ms-traffictypediagnostic: BY2PR11MB0616:
x-microsoft-antispam-prvs: <BY2PR11MB06167A0475185E5B604175C087F00@BY2PR11MB0616.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0616;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0616;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(186003)(316002)(15188155005)(14444005)(256004)(446003)(478600001)(25786009)(71190400001)(31686004)(486006)(71200400001)(476003)(11346002)(2616005)(31696002)(2900100001)(14454004)(4326008)(93886005)(86362001)(54906003)(106356001)(72206003)(105586002)(966005)(2906002)(5250100002)(99286004)(6916009)(36756003)(7736002)(76176011)(68736007)(305945005)(229853002)(15760500003)(81156014)(8676002)(97736004)(81166006)(6116002)(8936002)(3846002)(52116002)(66066001)(5660300001)(6436002)(16799955002)(53936002)(6512007)(6306002)(26005)(6486002)(53546011)(102836004)(6246003)(386003)(6506007)(19623215001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0616;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kHCj+qT/8Zd3pndYgevVUyfZuIQA1FBgovRkejrkOY3StSRuJo1DiAP6DIGX4R9IcLeOv8U+xWSk+9g+CK8qz1JpcxzcMl6UpnBqbpkqoY9j3Ltg5sttd2DB1vVZgoRAwuBcmeF69KYtck8GFELRxKx2HIaz4kA6kXXknsr+F2MwSfNOk6o8Hsh8/tXMa97+dKkKtsLMHK6SClO0LShDqxUtB6fp7I/Nl7GFQbsDTqzfwhbjV58O7OF24QIPAeULFM+Q3jNLGJoB1JFd2KokaKPJT8yzYONnfNGF5Igsuvw+fRvEq4ZBD3mMsJkEickn09Q1szla3vG1KVxObXU/MqBEp5YoUyBeA6JyMzO4t5Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CE50F7A6BBA94469B3C48A38106DC97@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 274b5e64-a301-477d-7f13-08d63b32f082
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 11:05:30.2593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0616
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE5LjEwLjIwMTggMTM6MzAsIEpvbmFzIERhbmllbHNzb24gd3JvdGU6DQo+IE9uIFdl
ZCwgT2N0IDE3LCAyMDE4IGF0IDM6MTAgUE0gPENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPj4NCj4+Pg0KPj4+IFdlIHRha2UgdGhlIG5vcm1hbCBwYXRoIG9mIHN5c19yZWJv
b3QgPT4ga2VybmVsX3Jlc3RhcnQgPT4gbWFjaGluZV9yZXN0YXJ0IC4uLg0KPj4+DQo+Pj4gSSBh
ZGRlZCBjb2RlIHRvIHByaW50IHRoZSBjMSByZWdpc3RlciBpbiBkaWZmZXJlbnQgcGF0aHMuIEFu
ZCBJLWNhY2hlDQo+Pj4gaXMgZW5hYmxlZC4NCj4+PiBTbyBub3cgSSBhbSByZWFsbHkgY29uZnVz
ZWQgYWJvdXQgd2h5IHRoZSBwYXRjaCB3b3JrZWQuDQo+Pg0KPj4gSnVzdCBzYXlpbmcuLi4gbWF5
YmUgeW91ciBpbnN0cnVjdGlvbnMgYWRkIHNvbWUgZGVsYXkgb24gdGhlIGV4ZWN1dGlvbiBwYXRo
DQo+PiBhbmQgdGhpcyBpcyB3aHkgaXQgaGVscHMuLi4gdHJ5IHRvIGFjY2VzcyBjcDE1IGNvLXBy
b2Nlc3NvciBmb3IgcmVhZCBhbmQNCj4+IHdyaXRlIGJhY2sgdGhlIHZhbHVlIHlvdSByZWFkIHdp
dGhvdXQgYWN0dWFsbHkgdG8gbW9kaWZ5IGl0LCB0byBzZWUgaWYgdGhpcw0KPj4gY291bGQgYmUg
dGhlIHJlYXNvbjogZS5nLjoNCj4+DQo+PiBtcmMgICAgIHAxNSwgMCwgcjAsIGMxLCBjMCwgMA0K
Pj4gb3JyICAgICByMSwgcjEsICM0MDk2ICAgICAgICAgICAvLyB3aGF0ZXZlciBpcyBpbiByMSwg
ZG9lc24ndCBtYXR0ZXINCj4+IG1jciAgICAgcDE1LCAwLCByMCwgYzEsIGMwLCAwDQo+Pg0KPiAN
Cj4gWWVzLCB0aGlzIGFsc28gc2VlbXMgdG8gd29yay4gSSBoYXZlIG92ZXIgMTAwIHJlYm9vdHMg
Y29tcGxldGVkIHdpdGggdGhpcyBjb2RlLg0KPiBTbyB3aGF0IGNvdWxkIGJlIHRoZSBpc3N1ZSBo
ZXJlPyBJdCBzZWVtIHJlbGF0ZWQgdG8gdGhlIHBvd2VyaW5nIGRvd24NCj4gb2YgdGhlIHNkcmFt
IGF0IGxlYXN0Lg0KDQpJIGRvbid0IGtub3cgd2hhdCBjb3VsZCBiZSB0aGUgaXNzdWUgaGVyZS4g
DQoNCj4gDQo+IFRoaXMgdGhyZWFkIG9uIHRoZSBBVDkxU0FNIGNvbW11bml0eSBkZWFscyB3aXRo
IHRoZSBzYW1lIGlzc3VlOg0KPiBodHRwOi8vd3d3LmF0OTEuY29tL3ZpZXd0b3BpYy5waHA/dD0y
NTgzMA0KPiBUaGVyZSB0aGUgc29sdXRpb24gcGVvcGxlIGNob3NlIHdhcyByZW1vdmluZyB0aGUg
U0RSQU0gcG93ZXJpbmcgZG93bi4NCj4gQnV0IHRoYXQgbGVhdmVzIG9uZSBvcGVuIHRvIHRoZSBj
YXVzZSBvZiB0aGUgZXJyYXRhLg0KPiANCj4gRG8geW91IGhhdmUgYW55IHRob3VnaHQgb24gaG93
IHRvIGFwcHJvYWNoIHRoaXM/DQoNCkZvciBub3csIG5vLiBJIGRpZG4ndCBkdWcgdGhpcyBpc3N1
ZS4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdQ0KDQo+IA0KPj4gVGhhbmsgeW91LA0KPj4gQ2xhdWRp
dSBCZXpuZWENCj4+DQo+IA0KPiBSZWdhcmRzDQo+IEpvbmFzDQo+IA0KPiANCj4+Pg0KPj4+PiBC
ZXN0IHJlZ2FyZHMsDQo+Pj4+IEFsZXhhbmRlcg0KPj4+DQo+Pj4gSm9uYXMNCj4+Pg0KPj4+Pg0K
Pj4+Pg0KPj4+Pg0KPj4+DQo+Pj4NCj4gDQo+IA0KPiANCg==
