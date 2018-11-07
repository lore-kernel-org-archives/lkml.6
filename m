Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE986C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B19820882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CZ41PTAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B19820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbeKHAZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:25:03 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:52630 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeKHAZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:25:03 -0500
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="22950669"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Nov 2018 07:54:22 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 7 Nov 2018 07:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GomDs2l28IfhnuhM2uAkPIe1elnfb57qoestV5359KY=;
 b=CZ41PTAoKgukOsO+w2BVZ7RTvo/Oat5atpAauhHj0eNncHXVYqB5L4np600WAIXvDQUo4GXjrpoxT0F9o6WSiEjiBQ/qT3g+HAuQT3w3FnpLuGFDkYpYB/n0bfXg507B2nvLRESTajKYmvG8GAqWrFrfZRlizQqKfMKfIO5hag8=
Received: from BLUPR11MB0740.namprd11.prod.outlook.com (10.163.216.18) by
 BLUPR11MB0820.namprd11.prod.outlook.com (10.163.217.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 14:54:17 +0000
Received: from BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::2dca:81f7:b419:fdf2]) by BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::2dca:81f7:b419:fdf2%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 14:54:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <sre@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Thread-Topic: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Thread-Index: AQHUdPi2R8S5SO7XUE65Fo0kFeM8lg==
Date:   Wed, 7 Nov 2018 14:54:17 +0000
Message-ID: <6719a808-e704-3c63-f592-3b90d44ccbfe@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
 <20181106210933.GU24212@piout.net>
In-Reply-To: <20181106210933.GU24212@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P193CA0020.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::30) To BLUPR11MB0740.namprd11.prod.outlook.com
 (2a01:111:e400:594c::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR11MB0820;6:exGZxqetHUWn5oHBFYT8iaOcVph1PLj2NOc7Nk++wfUf3bDNzNw7VQBuWjEDQM+Lh6+pEpAqr11phBPscscCi4ryz3wWuN0fWN3l4/ngClim3YBGL6CoPxwRLVdNvdYcbydFDbFeYjMPBiLp7/gLNaLY5fSHSclyXrNzcZdCtvm3JROLdarPYRDC9BZmQlc8Kiodsty6ymSfv0+XI6SDX/Ns+WZRfJH6GnZEkrrfTHrfPWB9krzMnxcH40Zi0bZIFiMz60aYhSLK0hmCMbNZvWUcSejG5KYB0h6vNh0e6YAuVjB2IAnfJO9Ch0krJ5ENnzk2euh4IFH0O/+4f+CX+JqYh4qmApoFyqFCU4zvGZsdJuGDPyPcVrXNr8tleGkoYdiOAsoHl83xhKEjxvooRvIJr+hslkNOKKIY/9E46Bipzpu0+V2KwbtpvJBHTG6N7rhO+yUExt9Vq1Vriafidw==;5:k+Ie9q1grID7kEqgHqf6nGybz+7SCRQyyfGz2hznF8drJpoR2iwvn38bbSQtawyYEat8ZSRfxETtVjjgT9KLmohU13M04E2P/mJOUIWVV8tIgnIVUnrKNJA1oNqb4+GHfcZYqEfYoww2ntg96cOk2lb5lt1mM3itN1rZ6ipJgl4=;7:SQwiS/tK9RU3sB7BuHaGX4sqm++xEQN9xCS2g8hC2tSa6QLF7XKa6W7TK0KCH2rB+G4/cFnw0m5fsgNgeLpbjPWIY7DEBS0CeONWnQr2wDRouTJQFyca3bsGPVxxEdKLSD1FPyz5MRmDdSPbmO2cZA==
x-ms-office365-filtering-correlation-id: 374c5313-ad86-41bf-d757-08d644c0e3ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BLUPR11MB0820;
x-ms-traffictypediagnostic: BLUPR11MB0820:
x-microsoft-antispam-prvs: <BLUPR11MB082023137BF26AED6B81201C87C40@BLUPR11MB0820.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BLUPR11MB0820;BCL:0;PCL:0;RULEID:;SRVR:BLUPR11MB0820;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(52314003)(199004)(189003)(6486002)(4326008)(86362001)(11346002)(6436002)(97736004)(68736007)(6512007)(3846002)(6116002)(53936002)(71190400001)(71200400001)(26005)(102836004)(478600001)(31696002)(186003)(486006)(6506007)(476003)(386003)(66066001)(2616005)(446003)(256004)(36756003)(53546011)(52116002)(14454004)(81166006)(81156014)(72206003)(8676002)(2906002)(99286004)(31686004)(25786009)(8936002)(6916009)(106356001)(229853002)(76176011)(7736002)(2900100001)(305945005)(54906003)(316002)(6246003)(5660300001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR11MB0820;H:BLUPR11MB0740.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hqK0aJNtINhLSEGrBzRpKRz5RFUcW1fPBSwyP3JHdtSjQALoJ2/EciMebIZlPOdvCEi3CgzAm2CBGuLU4PLKbuHWA5A46xntmlN+wpkSePJhh24qPI2b5nL2GzeKg9VBfBxVBxuWkHOqE8kqftPW+E8o+zngYGUd8QXlwH9BSt72FMSrzE3BOhUlJf6PxmBH3OlUAzJ3ktNRzeDAp4UUMtdnpNY8fFG01ojtYD3RsRg9yxSKECBmOp0OyuAnUUFV0FCaQtrvuG7OSXROjekgVl+yzoHBRRgUYvicCgq56Lf2RGbhxulSUCz81Rl0WAsBoaETmWzlHzHWLSTUPuzoUMH3Mn7wwfQIErvpaq1a8Uc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F515C802F08F479FF0623A84C3C590@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 374c5313-ad86-41bf-d757-08d644c0e3ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 14:54:17.2888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR11MB0820
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQpPbiAwNi4xMS4yMDE4IDIzOjA5LCBBbGV4YW5kcmUgQmVsbG9uaSB3
cm90ZToNCj4gSGkgQ2xhdWRpdSwNCj4gDQo+IE9uIDA1LzExLzIwMTggMTE6MTQ6MjYrMDAwMCwg
Q2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+ICBzdGF0aWMgaW50IF9faW5p
dCBhdDkxX3Bvd2Vyb2ZmX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiBA
QCAtMTU0LDE2ICsxNjAsMjIgQEAgc3RhdGljIGludCBfX2luaXQgYXQ5MV9wb3dlcm9mZl9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gIAl1MzIgZGRyX3R5cGU7DQo+PiAg
CWludCByZXQ7DQo+PiAgDQo+PiArCWF0OTFfc2hkd2MgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRl
diwgc2l6ZW9mKCphdDkxX3NoZHdjKSwgR0ZQX0tFUk5FTCk7DQo+PiArCWlmICghYXQ5MV9zaGR3
YykNCj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4gKw0KPiANCj4gSXMgdGhlcmUgYW55IHJlYWwg
YmVuZWZpdCB0aGF0IHdpbGwgb2Zmc2V0IHRoZSB0aW1lIGxvc3QgZm9yIHRoYXQNCj4gYWxsb2Nh
dGlvbiBhdCBib290IHRpbWU/DQoNCk5vLCBJIGhhdmVuJ3QgcnVuIGJlbmNobWFya3Mgb24gdGhp
cy4gSSBvbmx5IHdhbnRlZCB0byBoYXZlIHRoZW0gZ3JvdXBlZCBpbg0Kb25lIHN0cnVjdHVyZS4g
UGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIHNvbWUgdGVzdHMgaW4gbWluZC4NCg0KPiAN
Cj4gSSB1bmRlcnN0YW5kIHlvdSBhcmUgdGhlbiB0ZXN0aW5nIGF0OTFfc2hkd2MgdG8ga25vdyB3
aGV0aGVyIHRoZSBkcml2ZXINCj4gYWxyZWFkeSBwcm9iZWQgb25jZS4gQnV0LCB0aGUgZHJpdmVy
IHdpbGwgbmV2ZXIgcHJvYmUgdHdpY2UgYXMgdGhlcmUgaXMNCj4gb25seSBvbmUgc2h1dGRvd24g
Y29udHJvbGxlciBvbiB0aGUgU29DIGFuZCBhbnl3YXksIElmIGl0IHdhcyB0byBwcm9iZQ0KPiB0
d2ljZSwgaXQgd2lsbCBzdGlsbCB3b3JrIGFzIGV4cGVjdGVkLg0KDQpJIGhhZCBpbiBtaW5kIHRo
ZSBzY2VuYXJpbyB3aGVyZSB0aGUgZHJpdmVyIHdvdWxkIGJlIGNvbXBpbGVkIGFzIG1vZHVsZS4g
SQ0Ka25vdyBpbnNtb2QgYWxyZWFkeSBkb2VzIHRoaXMgY2hlY2tpbmcuIEknbSBvayB0byByZW1v
dmUgdGhpcyBjaGVja2luZy4gSQ0Kd2lsbCBkbyBpdCBpbiBuZXh0IHZlcnNpb24uIFdpdGggdGhp
cyBJIHdpbGwgYWxzbyByZW1vdmUgZGV2bV9remFsbG9jKCkgb2YNCmF0OTFfc2hkd2MuDQoNClRo
YW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+IA0K
