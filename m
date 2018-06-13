Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67221C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0802E20660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WlwVDgMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0802E20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964859AbeFMPrU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:47:20 -0400
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:19088
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964778AbeFMPrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxAi5rlcUs5eme78T8tdMtKQ/qAUD4IRlBZOt8sR+FI=;
 b=WlwVDgMOzccYgIaNm5CbKhRfTir6jBbvFiRfouV+fCdAaY4QrXkBTWBb4/ddjdIWB14RLWyTrCcUFxHw+H4WVe+Chb/rrGDFC0GH9cQpInX6JhvxG1BZdww8BMj3qM2nLiEBCEd3Qcavt4tljuUZfuFmaJPDs68rSPeAWLXWmc4=
Received: from HE1PR0802MB2412.eurprd08.prod.outlook.com (10.175.33.150) by
 HE1PR0802MB2521.eurprd08.prod.outlook.com (10.175.35.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Wed, 13 Jun 2018 15:47:12 +0000
Received: from HE1PR0802MB2412.eurprd08.prod.outlook.com
 ([fe80::b5dc:3495:d7f9:b686]) by HE1PR0802MB2412.eurprd08.prod.outlook.com
 ([fe80::b5dc:3495:d7f9:b686%8]) with mapi id 15.20.0841.021; Wed, 13 Jun 2018
 15:47:12 +0000
From:   Matt Sealey <Matt.Sealey@arm.com>
To:     Suzuki Poulose <Suzuki.Poulose@arm.com>
CC:     Rob Herring <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "Mark Rutland" <Mark.Rutland@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>,
        John Horley <John.Horley@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
Thread-Topic: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
Thread-Index: AQHT+arYmPkMSE9u6k6dSv01/4gsi6RdKfkAgADZT4CAADNm5YAADK2AgAAaNZA=
Date:   Wed, 13 Jun 2018 15:47:12 +0000
Message-ID: <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
In-Reply-To: <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sealey@arm.com; 
x-originating-ip: [217.140.111.135]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0802MB2521;7:F0PdgDKNnA8EHZk96I0go/nyUOTKEy2ScKumT5F2qDcldQbqEDvx26N259uPHc6ADGkYJ09buz71E0VlI1QZjTCDGDGsd+Ulj0Iw+bv5781qqgNmDqbgqwFzaN/6tVcy6adlS/CEKx9bE4ZwKcDQJjj1XGR10Tti/HY0WEopI3Xzsn+dDDp1hlK+7jwmB5DSRdGThddJ0KAy0vCziGVfxgVAbBN50wkRwaM91wmUTzxX97aU8Pa6AAhY82oTAlu5
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10047b77-b568-482b-fe03-08d5d144ee24
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0802MB2521;
x-ms-traffictypediagnostic: HE1PR0802MB2521:
x-microsoft-antispam-prvs: <HE1PR0802MB2521091C14AA3AE65BD95119EE7E0@HE1PR0802MB2521.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0802MB2521;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0802MB2521;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(40434004)(486006)(59450400001)(14454004)(6246003)(26005)(6436002)(72206003)(478600001)(76176011)(68736007)(6636002)(476003)(11346002)(446003)(3846002)(5660300001)(6506007)(97736004)(6116002)(9686003)(102836004)(53936002)(3660700001)(54906003)(2900100001)(93886005)(3280700002)(33656002)(8676002)(2906002)(74316002)(7696005)(81156014)(5890100001)(81166006)(106356001)(99286004)(5250100002)(8936002)(66066001)(4326008)(55016002)(39060400002)(229853002)(7736002)(6862004)(316002)(305945005)(105586002)(86362001)(25786009)(217873001)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2521;H:HE1PR0802MB2412.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tsAFdIZv8ma2IMhmuFQ7XhvvHKKsrC8EUoY6m6ZPrcxWuxYeo12+dpI78Jra2hmi2Qelo5XjQQiNRwWAgZ1jexntd0bEyWIwADwQrQP0iqm2zBAbhPiYmCgx1CeVLBl5JBsncDRt4C4ITH5zxmzFKv6J5BXZMzcDxxiLjPuqUzcEdjhiS2sqwJ856M/uzYDZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10047b77-b568-482b-fe03-08d5d144ee24
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 15:47:12.4624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3V6dWtpLA0KDQo+ID4gV2h5IG5vdCB1c2Ug4oCcdW5pdOKAnT8NCj4gPg0KPiA+IEkgYmVs
aWV2ZSB3ZSBoYWQgdGhpcyBkaXNjdXNzaW9uIHllYXJzIGFnbyBhYm91dCBudW1iZXJpbmcgc2Vy
aWFsIHBvcnRzDQo+ID4gYW5kIHNkaGNpIChpLmUuIGhvdyBkbyB5b3Uga25vdyBpdOKAmXMgVUFS
VDAgb3IgVUFSVDEgZnJvbSBqdXN0IHRoZSBhZGRyZXNzPw0KPiA+IFNvbWUgU29D4oCZcyBkb27i
gJl0IGFkZHJlc3Mgc2VxdWVudGlhbGx5ICpvciogaW4gYSBmb3J3YXJkIGRpcmVjdGlvbikgLSBJ
DQo+ID4gYmVsaWV2ZSBpdOKAmXMgbm90IGV4YWN0bHkgY29kaWZpZWQgaW4gZVBBUFIsIG5vdCBh
bSBJIHN1cmUgd2hlcmUgaXQgbWF5IGJlDQo+ID4gb3RoZXJ3aXNlLCBidXQgaXQgZXhpc3RzLg0K
Pg0KPiBXZSBoYXZlIGRpZmZlcmVudCBzaXR1YXRpb24gaGVyZS4gV2UgbmVlZCB0byBrbm93ICp0
aGUgcG9ydCBudW1iZXIqIGFzDQo+IHVuZGVyc3Rvb2QgYnkgdGhlIGhhcmR3YXJlLCBzbyB0aGF0
IHdlIGNhbiBlbmFibGUgKnRoZSBzcGVjaWZpYyogcG9ydCBmb3INCj4gYSBnaXZlbiBwYXRoLg0K
DQpGb3IgdGhlIHB1cnBvc2VzIG9mIGFic3RyYWN0aW9uLCBlYWNoIHBvcnQgd2lsbCBoYXZlIHRo
ZSBwcm9wZXJ0eSBvZiBoYXZpbmcNCmEgbm9kZSB3aGljaCBpcyBwb2ludGVkIHRvIGJ5IG90aGVy
IG5vZGVzLCBhbmQgaW4gdGhlIGNhc2Ugb2YgYSB0cnVlIEFUQg0KZW5kcG9pbnQsIG5vIG90aGVy
IG5vZGVzIGJlaGluZCBpdC4NCg0KSXQgZG9lc24ndCBtYXR0ZXIgd2hhdCB0aGUgSFcgbnVtYmVy
cyBpdCBhcyBhcyBsb25nIGFzIHRoZSBkcml2ZXIgY2FuIGRlcml2ZQ0KaXQgZnJvbSB3aGF0ZXZl
ciB5b3UgcHV0IGluIHRoZSBEVC4gU28gYSBmdW5uZWwgKHdoaWNoIGlzIH44IHBvcnRzIG11eGVk
IGludG8NCm9uZSBvdXRwdXQpOg0KDQogICBmMXAwOiBwb3J0IHsNCiAgICAgIHVuaXQgPSA8MD47
DQogICAgICBlbmRwb2ludCA9IDwmZjFvdXQ+Ow0KICAgfTsNCiAgIGYxcDE6IHBvcnQgew0KICAg
ICAgdW5pdCA9IDw0PjsNCiAgICAgIGVuZHBvaW50ID0gPCZmMW91dD47DQogICB9Ow0KICAgZjFv
dXQ6IHBvcnQgew0KICAgICAgZW5kcG9pbnQgPSA8JmV0ZjE+Ow0KICAgfTsNCg0KInVuaXQiIGhl
cmUgaXMgc3BlY2lmaWMgdG8gdGhlIGRyaXZlcidzIHVuZGVyc3RhbmRpbmcgb2YgcG9ydHMgd2l0
aGluIGl0J3MNCm93biBjeWNsZSBvZiB0aGUgZ3JhcGguIEZvciBhIHJlcGxpY2F0b3IgeW91IGNh
biBpbnZlcnQgdGhlIGxvZ2ljIC0gaW5wdXQNCnBvcnRzIGRvbid0IG5lZWQgYSB1bml0LCBidXQg
dGhlIHR3byBvdXRwdXRzIGFyZSBmaWx0ZXJlZCBpbiBDb3JlU2lnaHQgbm90DQpieSBsZWcgYnV0
IGJ5IHRyYW5zaXRpbmcgQVRCIElEIGluIGdyb3VwcyBvZiAxNiBJRHMuIEluIHRoYXQgY2FzZSBt
YXliZQ0KeW91IHdvdWxkIHdhbnQgdG8gZGVzY3JpYmUgYWxsIDggcG9zc2libGUgdW5pdHMgb24g
ZWFjaCBsZWcgd2l0aCB0aGUgZmlyc3QNCklEIGl0IHdvdWxkIGZpbHRlcj8gT3IganVzdCBsaXN0
IHR1cGxlcyBvZiBmaWx0ZXIgSURzIDxpZCwgZmlyc3QsIGxhc3Q+DQoNCldobyBjYXJlcywgcmVh
bGx5LCBhcyBsb25nIGFzIHRoZSBkcml2ZXIga25vd3Mgd2hhdCBpdCBtZWFucy4NCg0KWW91IGRv
bid0IG5lZWQgdG8gbmFtZXNwYWNlIGV2ZXJ5IHByb3BlcnR5Lg0KDQo+IEFzIEkgbWVudGlvbmVk
IGFib3ZlLCB3ZSBuZWVkIHRoZSBoYXJkd2FyZSBudW1iZXJzIHRvIGVuYWJsZSB0aGUNCj4gInNw
ZWNpZmljIiBwb3J0Lg0KDQpPa2F5IGFuZCBob3cgaXMgdGhpcyBub3QgYWJsZSB0byBiZSBwcmVz
Y3JpYmVkIGluIGEgYmluZGluZyBmb3IgImFybSxjb3Jlc2lnaHQtZnVubmVsIg0KdGhhdDoNCg0K
ImlucHV0IHBvcnRzIGFyZSBudW1iZXJlZCBmcm9tIDAgdG8gTiB3aGVyZSBOIGlzIHRoZSBtYXhp
bXVtIGlucHV0IHBvcnQNCm51bWJlci4gVGhpcyBudW1iZXIgaXMgaWRlbnRpZmllZCB3aXRoIHRo
ZSAidW5pdCIgcHJvcGVydHksIHdoaWNoIGRpcmVjdGx5DQpjb3JyZXNwb25kcyB0byB0aGUgYml0
IHBvc2l0aW9uIGluIHRoZSBmdW5uZWwgQ3RybF9SZWcgcmVnaXN0ZXIsIGFuZCB0aGUNCmJpdCBw
b3NpdGlvbiBtdWx0aXBsaWVkIGJ5IDMgZm9yIGVhY2ggMy1iaXQgcHJpb3JpdHkgaW4gdGhlIGZ1
bm5lbA0KUHJpb3JpdHlfQ3RybF9SZWcsIHdpdGggTiBoYXZpbmcgYSBtYXhpbXVtIG9mIHRoZSBk
ZWZpbmVkIHJlZ2lzdGVyIGJpdGZpZWxkDQpERVZJRFtQT1JUQ09VTlRdLCBtaW51cyBvbmUsIGZv
ciB0aGF0IGNvbXBvbmVudCINCg0KT3IgYSByZXBsaWNhdG9yOg0KDQoib3V0cHV0IHBvcnRzIGFy
ZSBudW1iZXJlZCBwZXIgdGhlIENvcmVTaWdodCBBVEIgUmVwbGljYXRvciBzcGVjaWZpY2F0aW9u
LA0KdW5pdCBjb3JyZXNwb25kaW5nIHRvIHRoZSBJREZJTFRFUm4gcmVnaXN0ZXIgY29udHJvbGxp
bmcgSUQgZmlsdGVycyBmb3INCnRoYXQgbGVnLCB3aXRoIGEgbWF4aW11bSBvZiB0aGUgZGVmaW5l
ZCByZWdpc3RlciBiaXRmaWVsZCBERVZJRFtQT1JUTlVNXSwNCm1pbnVzIG9uZSINCg0KT25lIGNv
dWxkIGNsYXJpZnkgaXQsIGV2ZW4sIHdpdGggbGFiZWxzIGZvciByZWFkYWJpbGl0eSAoImxhYmVs
IiBkZWZpbml0ZWx5DQppcyBhIHdlbGwgZGVmaW5lZCBpZiBhbHNvIGNvbXBsZXRlbHkgYXJiaXRy
YXJ5IHByb3BlcnR5KS4NCg0KLi4NCg0KPiBzdGF0aWMgdm9pZCBmdW5uZWxfZW5hYmxlX2h3KHN0
cnVjdCBmdW5uZWxfZHJ2ZGF0YSAqZHJ2ZGF0YSwgaW50IHBvcnQpDQo+IHsNCj4gICAgICAgICAg
dTMyIGZ1bmN0bDsNCj4NCj4gICAgICAgICAgQ1NfVU5MT0NLKGRydmRhdGEtPmJhc2UpOw0KPg0K
PiAgICAgICAgICBmdW5jdGwgPSByZWFkbF9yZWxheGVkKGRydmRhdGEtPmJhc2UgKyBGVU5ORUxf
RlVOQ1RMKTsNCj4gICAgICAgICAgZnVuY3RsICY9IH5GVU5ORUxfSE9MRFRJTUVfTUFTSzsNCj4g
ICAgICAgICAgZnVuY3RsIHw9IEZVTk5FTF9IT0xEVElNRTsNCj4gICAgICAgICAgZnVuY3RsIHw9
ICgxIDw8IHBvcnQpOw0KPiAgICAgICAgICB3cml0ZWxfcmVsYXhlZChmdW5jdGwsIGRydmRhdGEt
PmJhc2UgKyBGVU5ORUxfRlVOQ1RMKTsNCj4gICAgICAgICAgd3JpdGVsX3JlbGF4ZWQoZHJ2ZGF0
YS0+cHJpb3JpdHksIGRydmRhdGEtPmJhc2UgKyBGVU5ORUxfUFJJQ1RMKTsNCj4NCj4gICAgICAg
ICAgQ1NfTE9DSyhkcnZkYXRhLT5iYXNlKTsNCj4gfQ0KPg0KPiBObyB3ZSBkb24ndCBuZWVkIHRv
IHBhcnNlIGl0IGluIGJvdGggd2F5cywgdXAgYW5kIGRvd24uIEJ0dywgdGhlIHRyYWNlDQo+IHBh
dGhzIGFyZSBub3Qgc3RhdGljYWxseSBjcmVhdGVkLiBUaGV5IGFyZSBkb25lIGF0IHJ1bnRpbWUs
IGFzIGNvbmZpZ3VyZWQNCj4gYnkgdGhlIHVzZXIuDQoNCllvdSBkbyByZWFsaXplIHRoaXMgaXNu
J3QgaG93IHRoZSBoYXJkd2FyZSB3b3JrcywgY29ycmVjdD8NCg0KVHJhY2UgcGF0aHMgYXJlIGZp
eGVkLCB0aGV5IG1heSBkaXZlcmdlIHdpdGggZGlmZmVyZW50IGNvbmZpZ3VyYXRpb25zLCBidXQN
CnRoZSBmdWxsIENvcmVTaWdodCB0b3BvbG9neSAoYWxsIGZ1bm5lbHMsIHJlcGxpY2F0b3JzIGFu
ZCBpbnRlcm1lZGlhcnkNCkNvbXBvbmVudHMpIGlzIGVudGlyZWx5IHVuY2hhbmdlYWJsZS4NCg0K
VGhlIERUIHNob3VsZCBwcm92aWRlIHRoZSBpbmZvcm1hdGlvbiB0byBwcm92aWRlIGEgcmVmZXJl
bmNlIGFjeWNsaWMgZGlyZWN0ZWQNCmdyYXBoIG9mIHRoZSBlbnRpcmUgdG9wb2xvZ3kgKG9yIGVu
dGlyZWx5IHJlYXNvbmFibHkgcHJvZ3JhbW1hYmxlIHRvcG9sb2d5IHdoZXJlDQphdCBhbGwgcG9z
c2libGUpIC0gaWYgYSB1c2VyIHdhbnRzIHRvIHRyYWNlIGZyb20gRVRNXzAgdGhlbiB0aGV5IG9u
bHkNCmhhdmUgcGFydGljdWxhciBwYXRocyB0byBwYXJ0aWN1bGFyIHNpbmtzLCBmb3IgaW5zdGFu
Y2UgRVRNXzAgYW5kIEVURl8wDQptYXkgYmUgb24gdGhlaXIgb3duIHBhdGgsIHNvIHlvdSBjYW5u
b3QganVzdCAiY29uZmlndXJlIGFzIGEgdXNlciINCmEgcGF0aCBmcm9tIEVUTV8xIHRvIEVURl8w
IHNpbmNlIHRoZXJlIGlzbid0IG9uZS4NCg0KV2Fsa2luZyBzYWlkIGdyYXBocyB3aXRoIHRoZSBr
bm93bGVkZ2UgdGhhdCBDb3JlU2lnaHQgc3BlY2lmaWNhbGx5IGRpc2FsbG93cw0KbG9vcGJhY2tz
IGluIEFUQiB0b3BvbG9neSBpcyBiYXNpYyBjb21wdXRlciBzY2llbmNlIHByb2JsZW0gLSBsaXRl
cmFsbHkgYQ0KbWF0dGVyIG9mIHRvcG9sb2dpY2FsIHNvcnRpbmcuIEJ1dCBsZXQncyBidWlsZCBh
IGdyYXBoIG9uY2UgYW5kIHRyYXZlcnNlIGl0IC0NCmRvbid0IGJ1aWxkIHRoZSBncmFwaCBwYXJ0
aWFsbHkgZWFjaCB0aW1lIG9yIHRyeSBhbmQgYnVpbGQgaXQgdG8gY3Jvc3MtY2hlY2sNCmV2ZXJ5
IHRpbWUuIFRoZSBwYXRocyBhcmUgd2lyZXMgaW4gdGhlIGRlc2lnbiwgbGV0cyBub3QgZmFrZSB0
byB0aGUgdXNlcg0KdGhhdCB0aGVyZSBpcyBhbnkgY29uZmlndXJhYmlsaXR5IGluIHRoYXQgb3Ig
dHJ5IGFuZCBlbmNvZGUgdGhhdCBpbiB0aGUNCkRULg0KDQo+IENvbWluZyBiYWNrIHRvIHlvdXIg
c3VnZ2VzdGlvbiBvZiAidW5pdCIsIHdoYXQgZG9lcyBpdCBpbXBseSA/DQoNCldoYXRldmVyIHRo
ZSBkcml2ZXIgbGlrZXMuIEZvciB1YXJ0IGFuZCBtbWMsIGl0IHdhcyBqdXN0IGEgc3B1cmlvdXMg
bnVtYmVyDQpidXQgaXQgY291bGQgYmUgYXBwbGllZCBhcyB0aGUgZW5kIG9mLCBzYXksIHR0eVM8
Tj4gb3IgbW1jYmxrPE4+cDMgb3IgdXNlZA0KaW4gYW55IG90aGVyIGRyaXZlci1zcGVjaWZpYyBt
YW5uZXIuIFRoZSBudW1iZXIgeW91IHB1dCBpbiBpcyB1cCB0byB5b3UsDQpidXQgdGhlIHZhbGlk
IG51bWJlcnMgd291bGQgYmUgaW4gdGhlIGJpbmRpbmcgZm9yIHRoYXQgcGFydGljdWxhciBkZXZp
Y2UuDQoNCj4gSXRzIHRvbyBnZW5lcmljIGEgdGVybSBmb3Igc29tZXRoaW5nIGFzIGNvbmNyZXRl
IGFzIGEgcG9ydCBudW1iZXIuDQoNCklzIGl0Pw0KDQpXaHkgd291bGQgeW91IG5lZWQgYSB3aG9s
ZSBvdGhlciBwcm9wZXJ0eSB0eXBlIHRvIGVuY29kZSBhIHUzMiB0aGF0DQpkZXNjcmliZXMgYW4g
YXJiaXRyYXJ5IG51bWJlciBzcGVjaWZpYyB0byB0aGF0IGhhcmR3YXJlIGRldmljZT8NCg0KVGEs
DQpNYXR0DQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwg
YW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2
aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVu
dHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUg
b3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
