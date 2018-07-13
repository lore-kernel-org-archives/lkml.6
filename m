Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CFBECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97912124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="agaIcbbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97912124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeGMIvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:51:15 -0400
Received: from mail-sn1nam02on0105.outbound.protection.outlook.com ([104.47.36.105]:57083
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeGMIvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8GZX7lAKc/bm1I1ousKhENwb25E/yY/mFQJ+K1uyqk=;
 b=agaIcbbEmYx05+PU+lOLnz/prDudpXCOqhB66oTsaABPxBpONjzgd8P9ubQQujdot/yTfnC5mCtBniZ2bNdO5hMOoG+8b9wwgZqIguxtBeXxEhxSdyVL2/FIx8Y2XhGub4yw1wRURVNgpeWIfQuSgFoynNNdeQqNO5VNojKl2zs=
Received: from CY1PR02MB1120.namprd02.prod.outlook.com (10.163.15.146) by
 CY1PR02MB1197.namprd02.prod.outlook.com (10.163.16.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Fri, 13 Jul 2018 08:37:35 +0000
Received: from CY1PR02MB1120.namprd02.prod.outlook.com
 ([fe80::89ac:5d60:3713:9ba2]) by CY1PR02MB1120.namprd02.prod.outlook.com
 ([fe80::89ac:5d60:3713:9ba2%4]) with mapi id 15.20.0952.017; Fri, 13 Jul 2018
 08:37:35 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ben Whitten <ben.whitten@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
Subject: RE: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module
 and DVK
Thread-Topic: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module
 and DVK
Thread-Index: AQHUBK62KLwSSbe270qAF8A3mcrIRKSMTHqAgACykjA=
Date:   Fri, 13 Jul 2018 08:37:35 +0000
Message-ID: <CY1PR02MB11204031D35B61A5CD6B5940E7580@CY1PR02MB1120.namprd02.prod.outlook.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
 <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
 <20180712215435.GL16084@piout.net>
In-Reply-To: <20180712215435.GL16084@piout.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [109.174.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1197;7:Sawp+mJkD1jRO6l1qCRWan4ePwI+c1FXzUoIHK2H0WNWubtdUQtlzyPtJv9bMQu4UMqX3OOzPcoGPKPsOtiTobXEJAsfbJu4XyD4GB75puKW2yOPA4/YEYSLcRhaAwiwjJxp/Y7o1r5Z8pAfKpBLSvrY/QC+iGmECMLh6+LOqBDnqnFWkD8IF+Rud85wU6SFNp1RRKEbEL608h4FFRZNd+P+eWS9L3iEhLczfrDnP+v/jGq64T43FxrmvoZIt3W5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 843872ca-8d5d-46e1-a3af-08d5e89be248
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1197;
x-ms-traffictypediagnostic: CY1PR02MB1197:
x-microsoft-antispam-prvs: <CY1PR02MB11976408EDA6EDD2CC276D5CE7580@CY1PR02MB1197.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1197;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1197;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(39060400002)(7736002)(5250100002)(102836004)(186003)(6246003)(66066001)(54906003)(33656002)(74316002)(316002)(53936002)(2900100001)(110136005)(305945005)(26005)(2906002)(105586002)(106356001)(55016002)(6116002)(6436002)(3846002)(81156014)(81166006)(7696005)(8676002)(76176011)(9686003)(14454004)(97736004)(256004)(5660300001)(478600001)(229853002)(8936002)(68736007)(72206003)(99286004)(6506007)(4326008)(86362001)(11346002)(486006)(25786009)(476003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR02MB1197;H:CY1PR02MB1120.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vDeey8GDrwIGsg4QNYnYHePXgNXk2GBcP5J84iROZlgmbLEKJVtVCjVaY1b9+1GPIFpOZsHVWTgChthSTGQ3W7MT9/kPkOkDSY3zkggO/jeF30x1V0bQ6YJ2Uba+9gKk6XBDXeQ5bTDcKOqOXnzgHo8zKWWA6YhJnEbHU9cu2n7oed2zpratcgb4dL3CWptYEdw1H+8oM25ojLW8pBPrbFTD7/ci770DkrcwR/KcoQdyYXNg0XFJO9cpcDwpgZ8sbybpycVklsIiCYDZShc8oAtLpzKBfS81jVK3hdJ692igiAIJnzlzz31Z1IfWhi2HYhGQskAZz68d52dopiEBSUnJvPDloJiFt1X0q2Rt+aQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843872ca-8d5d-46e1-a3af-08d5e89be248
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 08:37:35.5373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDQvNl0gYXJtOiBkdHM6IGFkZCBzdXBwb3J0IGZvciBM
YWlyZA0KPiBXQjUwTiBjcHUgbW9kdWxlIGFuZCBEVksNCj4gDQo+IEhpLA0KPiANCj4gSSd2ZSBu
b3cgYXBwbGllZCB0aGUgd2hvbGUgc2VyaWVzIGFmdGVyIGZpeGluZyB0d28gc21hbGwNCj4gd2hp
dGVzcGFjZQ0KPiBpc3N1ZXMuDQoNClRoYW5rcyENCg0KPiBPbiAxNS8wNi8yMDE4IDE0OjQwOjUz
KzAxMDAsIEJlbiBXaGl0dGVuIHdyb3RlOg0KPiA+ICsmdXNhcnQxX2NsayB7DQo+ID4gKwlhdG1l
bCxjbGstb3V0cHV0LXJhbmdlID0gPDAgMTMyMDAwMDAwPjsNCj4gPiArfTsNCj4gPiArDQo+IA0K
PiBCdXQgdGhpcyBpcyBub3QgYWN0dWFsbHkgYWxsb3dlZCBieSB0aGUgaGFyZHdhcmUgKHdlbGws
IGl0IGlzDQo+IGJ1dCBpdA0KPiB3aWxsIGxlYWQgdG8gaXNzdWVzKSBhbmQgd2lsbCBiZSByZW1v
dmVkIG9uY2UgdGhlIGNsb2NrDQo+IGJpbmRpbmcgaXMNCj4gcmV3b3JrZWQuDQoNCk9mIGNvdXJz
ZSBubyBwcm9ibGVtLCB0aGFua3MgYWdhaW4uDQoNCkJlbg0K
