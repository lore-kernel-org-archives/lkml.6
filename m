Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8DAECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9311C20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Moxa.onmicrosoft.com header.i=@Moxa.onmicrosoft.com header.b="C2VYRVan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9311C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIQMTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:19:21 -0400
Received: from mail-sg2apc01on0070.outbound.protection.outlook.com ([104.47.125.70]:62917
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeIQMTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Moxa.onmicrosoft.com;
 s=selector1-moxa-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2at30HAKl+lYLO4GP1SCG55Yqegz7QIoBSu2umpuW/0=;
 b=C2VYRVanwoXZ8Qxt6oT5SpNN2Q2fhr0u/cOGXEAWyof0Xk/MxzjIxcx91hkbudBIfqUIgONQ97OcpQt13QHSlQE1XSD6GZCtVkS+lLpZ+OFxBZS3YqEa5/98HRXpNZKyZ3+WFWwVPZrAUc/3n2aPDu45m6yG7VG/UJG3qbu8YXc=
Received: from TY2PR0101MB2526.apcprd01.prod.exchangelabs.com (20.177.77.204)
 by TY2PR0101MB2240.apcprd01.prod.exchangelabs.com (20.177.46.86) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 06:53:13 +0000
Received: from TY2PR0101MB2526.apcprd01.prod.exchangelabs.com
 ([fe80::e8ef:5578:5339:84ee]) by
 TY2PR0101MB2526.apcprd01.prod.exchangelabs.com
 ([fe80::e8ef:5578:5339:84ee%2]) with mapi id 15.20.1101.023; Mon, 17 Sep 2018
 06:53:11 +0000
From:   =?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?= <SZ.Lin@moxa.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>,
        =?utf-8?B?V2VzIEh1YW5nICjpu4Pmt7XmsrMp?= <Wes.Huang@moxa.com>,
        =?utf-8?B?RmVybyBKRCBaaG91ICjlkajkv4rpgZQp?= <FeroJD.Zhou@moxa.com>
Subject: RE: [PATCH 2/3] ARM: dts: am335x: add support for Moxa UC-2101 open
 platform
Thread-Topic: [PATCH 2/3] ARM: dts: am335x: add support for Moxa UC-2101 open
 platform
Thread-Index: AQHUQLvVsJGIw2OCh06ccjDKkAiL+aT0HjDw
Date:   Mon, 17 Sep 2018 06:53:11 +0000
Message-ID: <TY2PR0101MB252666FF7718C84A4261682FE21E0@TY2PR0101MB2526.apcprd01.prod.exchangelabs.com>
References: <20180830040929.23357-1-sz.lin@moxa.com>
 <20180830040929.23357-3-sz.lin@moxa.com>
 <47ebc8e6-b1cb-e040-8533-06eec05b4edd@ti.com>
In-Reply-To: <47ebc8e6-b1cb-e040-8533-06eec05b4edd@ti.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=SZ.Lin@moxa.com; 
x-originating-ip: [122.146.92.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR0101MB2240;6:qUFfCe6heM2dNFouaxeTv5V0+a4M+fdM0ZW+nMRafNPVCs6nWZ80KCE6YEuC0+nuUIfPYbbZDexY+E5NB6FBoRPymFjHCd1YHwv5SopoJn4akjx1wvYM/mrjjPxxTlc21xvam5jDyCtQ4AioSuEhzVKeku3Nf+55wLiOjcjDIxbfu89xCMWXfjzJYeumCGXg7ldAEpZHEsQm7NYWonyFYVjViz2OyhazMM4wi9lxEioTsA082LOEeXRvJ8jG3q27d0LwXRbde9tiziFGL37CQizIzKH4F5+HOgN58dEVtFBNB/Sd3iJ0T7/FzDTWx0MRvms9ujCw43P2Brlwv/g46n/mdjnMp6iasQSDyOgp9nRSy9GYswNkWCUcW2+IIWppeV7YztMPi082Se3nzUHbNikFqcjZJ0VPIkkh7UOYLsWLAzJ0h4pYEpD8erGeQD4p4W0WUuOcdc5PxF57oWC4iQ==;5:5/IGqRLsmsA6JnJ69RINcUemNIeyzXFtmYdWBFS8IvuYrtARhhtw0JLs3VFbfLb29djrgKKxxP11ntICIDX4g6VXpNpzGLYrTwBYKiTlsAUsnC8mZtZwqnV3mDuqMz188JJOBEVxAj5M/SOnlxOr1jSx9CP+nU2JakCvQcbLSl4=;7:Qn4On5cYHs7yQpf/iLP1q2xGz9s0BcTtvlwquCoFOxh6VuzN3HCSBmrvoDAuYVFh478ONUIE/9XGJ3lTdZvyt6iqeIAayUN6GKQu+vyp48297fYr4xqnkHHCgkNkgfOGKOZ4OIKfw/tD9GhKi0L2Wtd5b9Qgx+fVmmqgFAdPsevpsMFpCqVgS0KE7dO4z1zGtXViVQgDWNaDKNj2UqWqLldNUZnfXWFK1E7jlzmlOUEJSAzH+dIoz3jaJQZm4mVs
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39850400004)(13464003)(51914003)(199004)(189003)(97736004)(102836004)(5660300001)(3846002)(486006)(55016002)(11346002)(6306002)(476003)(105586002)(53936002)(2501003)(9686003)(2900100001)(33656002)(446003)(186003)(6116002)(26005)(6436002)(25786009)(229853002)(14454004)(5250100002)(106356001)(7736002)(66066001)(81166006)(966005)(14444005)(305945005)(85182001)(72206003)(81156014)(8676002)(316002)(478600001)(68736007)(6246003)(4326008)(110136005)(74316002)(8936002)(86362001)(6506007)(2906002)(256004)(54906003)(76176011)(7696005)(99286004)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR0101MB2240;H:TY2PR0101MB2526.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: c58a3416-11e8-49f7-a643-08d61c6a3ba9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR0101MB2240;
x-ms-traffictypediagnostic: TY2PR0101MB2240:
x-microsoft-antispam-prvs: <TY2PR0101MB22404A99D041C6BC21FBB35EE21E0@TY2PR0101MB2240.apcprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(31051911155226);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:TY2PR0101MB2240;BCL:0;PCL:0;RULEID:;SRVR:TY2PR0101MB2240;
x-forefront-prvs: 0798146F16
received-spf: None (protection.outlook.com: moxa.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eVoqclwmpy54dbuB+d6tHlgmTtWe0MStrrRzpfuko3GS8NTVjS9cHdx0aAGe1adq/tqOKXC31Ey6lY3o+pKcgz+NVTb6EtdH4euuOjbLG5QMNJbtLQzNXZ/n441IAbdDOv51W4wtxva+u14JNburjR6kVDMtkFA8J1wsdv7TpNyAae443bRCnAQKq4/oLcF8rUCdbjBQNqej60qALKuGZJ2CTwTLVYHCnkoANmg9CFx9+xpIA32WmY9m80ydLHZoRZJpFj2jFnhCyiN5EBDr4V4tOwDyGR3gZH4QVIslBDH/JP87DTnVc8QSOX6QJvwbtapO3BGK9rLZXlB4dNhEzXZwW+V7qRfwOmPOpgV8SSs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58a3416-11e8-49f7-a643-08d61c6a3ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 06:53:11.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR0101MB2240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3J5Z29yaWkgU3Ry
YXNoa28gW21haWx0bzpncnlnb3JpaS5zdHJhc2hrb0B0aS5jb21dDQoNCjxzbmlwPg0KDQo+IA0K
PiBQbHMsIHVzZSBwaHktaGFuZGxlIGluc3RlYWQgb2YgcGh5X2lkIGhlcmUgYW5kIGluIHRoZSBu
ZXh0IHBhdGNoLg0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlciwgSSB3aWxsIHVzZSBwaHktaGFu
ZGxlIGluIG5leHQgdmVyc2lvbi4gDQoNCkZ1cnRoZXJtb3JlLCB0aGUgcHJvcGVydHkgb2YgInBo
eS1oYW5kbGUiIGRvZXNuJ3Qgd29yayBwcm9wZXJseSBpbiA0LjQueS1zdGFibGUga2VybmVsLg0K
SSd2ZSBmaXhlZCBpdCBhbmQgc2VudCB0aGUgYmFja3BvcnQgcGF0Y2hlcyB0byA0LjQueS1zdGFi
bGUgWzFdWzJdWzNdWzRdLg0KDQpbMV0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvc3Rh
YmxlL21zZzI1NjEyMS5odG1sDQpbMl0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvc3Rh
YmxlL21zZzI1NjEyNC5odG1sDQpbM10gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvc3Rh
YmxlL21zZzI1NjEzMS5odG1sDQpbNF0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvc3Rh
YmxlL21zZzI1Njc0OS5odG1sDQoNCj4gDQo+ID4gKwlwaHktbW9kZSA9ICJybWlpIjsNCj4gPiAr
fTsNCj4gPiArDQo+ID4gKyZjcHN3X2VtYWMxIHsNCj4gPiArCXN0YXR1cyA9ICJkaXNhYmxlIjsN
Cj4gPiArfTsNCj4gPg0KPiANCj4gLS0NCj4gcmVnYXJkcywNCj4gLWdyeWdvcmlpDQo=
