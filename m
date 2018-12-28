Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1622C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AB021741
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5F5b15t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeL1Bbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:31:36 -0500
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:64453
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbeL1Bbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oad70CdTPjtJGT2oG9Dm5ojwf2LMOe1+9hPhS8LCi4=;
 b=j5F5b15t+1+KDoDxOSHfvTTuSGL7yvHrwA6CE5LZGFRJbZeMC4EbTM+PwlQaAQ3ezSgcpbnnb4nheG0+G//ixWujle1ev7mbuhYa7BpSNS3hsdUXlEXgvh02DmXD79WkfZQZr8Yz75LloawiF9Ur/VP0ybpcbu2o0EhejXy6e80=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5053.eurprd04.prod.outlook.com (20.177.50.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 01:31:28 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c92b:a786:d2c5:fa1e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c92b:a786:d2c5:fa1e%4]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 01:31:27 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <hzpeterchen@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUmtJd+BfLe8fbYEifIrO2qZg/uqWNo02AgAGSJYCAAyRAAIABCfXQ
Date:   Fri, 28 Dec 2018 01:31:27 +0000
Message-ID: <VI1PR04MB53274270615A700AB36967F78BB70@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1545577992-4013-1-git-send-email-pawell@cadence.com>
 <1545577992-4013-6-git-send-email-pawell@cadence.com>
 <CAL411-rj0mRMfPCZOHw04q3s-9oJx7Os9Jz83bO=RgPZKLrB1g@mail.gmail.com>
 <CAL411-omVL2rwoQP6GwKZa9f_1TLBbEAkyLdxNkJZqaQu9cvsA@mail.gmail.com>
 <BYAPR07MB4709F8A00A13390235BA4BE1DDB60@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709F8A00A13390235BA4BE1DDB60@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [240e:e0:591c:f000:9ad:839e:cd6e:aea2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5053;6:MAO6inFTaBbEkcYgLuMWv/SoJqcK25CV7AQInmQuonK8DIE+g/UcRn6FPi8vb09dW6ofMfUQahJLNjHtDGoUoWD5kgi4BhH5zIkJzO1q6q0vePY1dbSd4CGhSDp3CLAAdsWrqWAsHOIqEQLb85kgAcN+YZ4WhY7I09z319/ELsnN+xuTa5emnnQQnvzl5dn7oN6ACYXKOGEHAPiq8p3OlH+I75UsFcvxJOQPLpzni3gTsTleBUR6egw1UJNnnZsijBa8x/9o8d+wfUAyfV++4jVNZz70+yRWK/kmQe6v6RHcUR5mtSVKgaw+qkStkAvxzIqJXQ+UNMW+wX2pJme/hbvS5aVAKT41DkW8ROzHW/scZYIx0BwUduYx+nkBfrr0ImDGGcLXZUUdIni09lRxpXGOX7jtvi+G/aQ9ccYULqrcRp5P/qTgg7ElH5aODG/79FFuO2dcHaawzFZ2LF5Cqw==;5:w4d0cazq6jHh1f+UYjJqAqI3P5VRGfkKJ3ggrK/KOxHwvoZCRpCLJwoUzjSzbO07OKMlBYozY1Z+3SMDml/K19E0wts3LFLR8TSBS8ZHxOCkzgfy7czU9to7fAFaUQjWlA6Hwsizw+NOlTozpbNc6YkWONGqw+qfDBsiRgUe0SA=;7:exCrRGi9xwk+/50KF5CoBaEVqt4WC2zcZYqoOa42/CpQ0+xoIlaE3HdyNAubPpM2LEYO+XLRXERcGOIGmQk+zfFt1zevGg2tIJzqKxcl5UD81rCJXRqnLf7Ubq8igNIQCaqIt9iF7hYxE2swa8NsDA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8127bd96-c753-4c36-61de-08d66c64301c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5053;
x-ms-traffictypediagnostic: VI1PR04MB5053:
x-microsoft-antispam-prvs: <VI1PR04MB5053A711152551F6447081AF8BB70@VI1PR04MB5053.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5053;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5053;
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(7416002)(229853002)(93886005)(7736002)(478600001)(25786009)(14454004)(316002)(305945005)(86362001)(33656002)(6116002)(110136005)(54906003)(2906002)(97736004)(5660300001)(8676002)(81156014)(74316002)(81166006)(39060400002)(105586002)(106356001)(6436002)(186003)(6246003)(8936002)(68736007)(53936002)(446003)(11346002)(476003)(71190400001)(46003)(44832011)(486006)(9686003)(7696005)(71200400001)(102836004)(99286004)(256004)(6506007)(14444005)(76176011)(55016002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5053;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vim00IBTqga8IWs9tK+lsYMuXRByJ4dE+uyHm7Q0b0qqh5oE3EibFGQ4iIy/8ezQFLtPuWYbRbAArYnXspoluFfRUWuMD05rm0FmKJwxq2pBAuz645vrBzZ7A/xT6mtK87IBe2s4Nx5f0gWy3mOvA8HWtTFv0++mr1ezPwARM4jn69i2z0CLjlml/HOEKwq4RG+LfcPmkhlQZ04xaAxfgJJJXT77SIOizxzS81omWjvra45rfC9yHXbZS/t2rAUwqYGmegX6fHT7kJrEtyfGIlruzmfHnrCBJFLok7PylF4ZYUZcMzrdgJRHbul5CsVt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8127bd96-c753-4c36-61de-08d66c64301c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 01:31:27.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+DQo+ID5AQCAtMjk5LDYgKzMwNiw3IEBAIGludCBjZG5zM19kcmRfaW5pdChzdHJ1Y3Qg
Y2RuczMgKmNkbnMpDQo+ID4gICAgICAgICAgICAgICAgY2Rucy0+dmVyc2lvbiAgPSBDRE5TM19D
T05UUk9MTEVSX1YwOw0KPiA+ICAgICAgICAgICAgICAgIGNkbnMtPm90Z192MV9yZWdzID0gTlVM
TDsNCj4gPiAgICAgICAgICAgICAgICBjZG5zLT5vdGdfcmVncyA9IHJlZ3M7DQo+ID4rICAgICAg
ICAgICAgICAgd3JpdGVsKDB4MSwgJmNkbnMtPm90Z192MF9yZWdzLT5zaW11bGF0ZSk7DQo+ID4g
ICAgICAgICAgICAgICAgZGV2X2luZm8oY2Rucy0+ZGV2LCAiRFJEIHZlcnNpb24gdjAgKCUwOHgp
XG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRsKCZjZG5zLT5vdGdfdjBfcmVn
cy0+dmVyc2lvbikpOw0KPiA+ICAgICAgICB9IGVsc2Ugew0KPiANCj4gSSBoYXZlIGNvbmZpcm1h
dGlvbiBmcm9tIEhXIHRlYW0gdGhhdCB0aW1lIHRoYXQgZHJpdmVyIHNob3VsZCB3YWl0IGFmdGVy
IGRlLQ0KPiBzZWxlY3RpbmcgbW9kZSBpcyAyLTNtcyBmb3Igc2ltdWxhdGUgbW9kZS4gSXQncyB0
aW1lIHdoZW4gRlNNIGlzIGluDQo+IERSRF9IX1dBSVRfVkJVU19GQUlMLg0KPiBEcml2ZXIgY2Fu
bm90IHJlLWVuYWJsZSB0aGUgaG9zdC9kZXZpY2UgbW9kZSBiZWZvcmUgdGhpcyB0aW1lIGhhcyBl
bGFwc2VkLg0KPiANCj4gMyBtcyBpcyB0aGUgbWF4aW11bSB0aW1lLiBBZGRpdGlvbmFsbHksIHlv
dSBjYW4gY29uZmlybSB0aGUgY3VycmVudCBGU00gc3RhdGUgYnkNCj4gcmVhZGluZyB0aGUgaG9z
dF9vdGdfc3RhdGUgKGJpdCA1OjMpIG9yIGRldl9vdGdfc3RhdGUgKDI6MCkgIGZyb20gT1RHU1RB
VEUNCj4gcmVnaXN0ZXIuDQo+IA0KPiBJZiBiaXQgMCBpbiBzaW11bGF0ZSByZWdpc3RlciBpcyBj
bGVhcmVkIHRoZSB0aW1lIGlzIGV4YWN0bHkgMXMuDQo+IA0KDQpUaGFua3MsIFBhd2VsLg0KDQpX
b3VsZCB5b3UgcGxlYXNlIGFkZCBiZWxvdyBjaGFuZ2VzIGluIHlvdXIgbmV4dCByZXZpc2lvbj8N
Ci0gU2V0IGJpdCAwIGluIHNpbXVsYXRlIHJlZ2lzdGVyDQotIHRpbWVvdXQgbG9naWMgZm9yIHdh
aXRpbmcgaG9zdF9vdGdfc3RhdGUgb3IgZGV2X290Z19zdGF0ZSBhdCBPVEdTVEFURQ0Kd2hlbiBz
d2l0Y2ggdG8gaG9zdCBvciBkZXZpY2UuDQoNClBldGVyDQoNCg==
