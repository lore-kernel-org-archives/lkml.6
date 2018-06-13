Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80E46C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B669208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="neKfUrMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B669208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935964AbeFMVHk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:07:40 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:60470
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935850AbeFMVHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqRrtUKq3e698+ZX+DtY3q3ANvtHBse0UMjEklO5JOk=;
 b=neKfUrMo9XUoGdTT2vF5dtAr2QR/ThCGEV+Hja3Dn/KrMTkCfh9JnVJiq7HfSkI7PUMif1p3iKbUA79hrJt0B+tl0er5JlKBXUxp6WHHiJmDF2Sd4Ei96yxJaxmBGwYhTxY9SlAJXXRglBvMAJA91lmOguJ0h9dmNQ60EH8icGo=
Received: from HE1PR0802MB2412.eurprd08.prod.outlook.com (10.175.33.150) by
 HE1PR0802MB2138.eurprd08.prod.outlook.com (10.172.126.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Wed, 13 Jun 2018 21:07:34 +0000
Received: from HE1PR0802MB2412.eurprd08.prod.outlook.com
 ([fe80::b5dc:3495:d7f9:b686]) by HE1PR0802MB2412.eurprd08.prod.outlook.com
 ([fe80::b5dc:3495:d7f9:b686%8]) with mapi id 15.20.0841.021; Wed, 13 Jun 2018
 21:07:34 +0000
From:   Matt Sealey <Matt.Sealey@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
CC:     Rob Herring <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
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
Thread-Index: AQHT+arYmPkMSE9u6k6dSv01/4gsi6RdKfkAgADZT4CAADNm5YAADK2AgAAaNZCAACEuAIAAKpaAgAAJWGA=
Date:   Wed, 13 Jun 2018 21:07:33 +0000
Message-ID: <HE1PR0802MB24121F0EEF8D7D643BC391A1EE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
 <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com>
 <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
In-Reply-To: <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sealey@arm.com; 
x-originating-ip: [217.140.111.135]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0802MB2138;7:otVOjlRgUfupKSj1qR5MyJ/GPyi60ErzPr4/Q91+urcINwbacNhS8G7/ahdNBee4i/iaGwJTda08AH7T5w70LVX7HWFcRfcEXH6D8LTKerZwREDsP6bEUzeYUfdD7kQBE5M6K31uthvRPQkwg6QV9PJcXqYP+W7sB7FihZnidxTSKRmYF3HoSEdlGs0U4J3eUK1598+0jipgan+21KKaWnBNeTjm2ceyXdBdRDvihgO7sO33uLpbLfuZZgrkonvz
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a335eac9-f511-4e28-97e8-08d5d171aefc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0802MB2138;
x-ms-traffictypediagnostic: HE1PR0802MB2138:
x-microsoft-antispam-prvs: <HE1PR0802MB213823DE32A60EAC0C64912AEE7E0@HE1PR0802MB2138.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0802MB2138;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0802MB2138;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39380400002)(396003)(376002)(39860400002)(40434004)(13464003)(199004)(189003)(6116002)(39060400002)(99286004)(102836004)(7736002)(5660300001)(3846002)(5250100002)(74316002)(97736004)(6436002)(305945005)(4326008)(6246003)(26005)(55016002)(68736007)(14454004)(9686003)(8676002)(53936002)(81166006)(81156014)(86362001)(186003)(6636002)(446003)(2906002)(229853002)(7696005)(59450400001)(105586002)(8936002)(66066001)(486006)(3660700001)(11346002)(476003)(33656002)(2900100001)(316002)(6506007)(76176011)(54906003)(93886005)(478600001)(72206003)(106356001)(25786009)(3280700002)(5890100001)(110136005)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2138;H:HE1PR0802MB2412.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z9LEm4SY1H0l1TfBjzEZw3dzkPxdMu6HbEUEadV+s3oMVR/AiYuMO5rZhJzREgazSxK+L+95OrGiCBdqQKK+FP30cXRsFZs0JhYFagtDTT0qxRVXDONwlInPjYqDFlCh6AMvmzkw/Uv9QlKGtIO8tXlY4hi6mLEvsEp+ETcEqT6zTMges0koavrHGpr71zyZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a335eac9-f511-4e28-97e8-08d5d171aefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 21:07:33.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0aGlldSBQb2lyaWVy
IDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4NCj4NCj4gPiBTbywgaWYgdGhlIHN1Z2dlc3Rp
b24gaXMgdG8gdXNlIGFuIGV4aXN0aW5nIHByb3BlcnR5ICJ1bml0IiwgSSBhbSBmaW5lDQo+ID4g
d2l0aCBpdCwgaWYgcGVvcGxlIGFncmVlIHRvIGl0Lg0KPg0KPiBJZiB3ZSdyZSBnb2luZyB0byBo
YXZlIHNvbWV0aGluZyBzaGFycGx5IGRpZmZlcmVudCB0aGFuIEFDUEkgSSBwcmVmZXINCj4gUm9i
J3MgaWRlYS4NCg0KV2hhdCBhcmUgeW91IHRyeWluZyB0byBzYXkgYWJvdXQgYmVpbmcgc2hhcnBs
eSBkaWZmZXJlbnQgdGhhbiBBQ1BJPw0KDQpUYSwNCk1hdHQNCg0KDQpJTVBPUlRBTlQgTk9USUNF
OiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25m
aWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBp
bnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBh
bmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2Ug
aXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBh
bnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
