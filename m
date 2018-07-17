Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D07ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F7320858
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Xjfx5vXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F7320858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbeGQPNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:13:08 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:37397 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731524AbeGQPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:13:07 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 17 Jul 2018 23:40:06 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id A21D585AB4;
        Tue, 17 Jul 2018 23:40:06 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,365,1526310000"; 
   d="scan'208";a="287117108"
Received: from mail-ty1jpn01lp0178.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.178])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2018 23:40:06 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBlr87JK3NbfR7P2SRvutm1QZfreA56+zBbxX5bOQLc=;
 b=Xjfx5vXxtPugKAuEM7DjBj6ObCo1oUphS+N97ZmgE/5Ibm5XH1LQL+0XfSk5Eo4W6WRu8KHLQqNcCzcl9xo0Ho6blHdOl9ytGlLWByL6X8SVFm2f3G9qguqHxHanyU7s8SDLxq/Bsx4lE3ntfGiRHAW4aX35PNfTRRkndHeOzcw=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 14:40:03 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333%2]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 14:40:03 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Horman <horms@verge.net.au>
CC:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Topic: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Index: AQHUHONXv++x9VJe70Gk9EuuSmoVI6STU7qAgAAEdoCAAAK7oIAAHWMAgAAEvbA=
Date:   Tue, 17 Jul 2018 14:40:03 +0000
Message-ID: <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
         <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
         <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
In-Reply-To: <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1770;7:YYmgsSJvRhwdGinHZ8akHUu7bi9M5QVaKxqmzSsmx2wPwdGeuYkpn1LLSQ3FrBIYmI8Og5b8mjgCCobfLR4o8dcBUIri5Q8Li+9nFHLciogKDVM5EUG2K/WH8Mpf3ZI6iURvIbBJl64VPWkh80EujLkMN3cXn6EEJz09Bxjkicf9lX5w2cLYFdcVW3t3g2XkCG00Hm0N3PXUDaKzA3ZSfKfNOK+k6B2C3Srgi8HK989elVkPXK2EBx6GrSOEwLaL;20:K7SLiBmLmve3ZYZkpJ2oyHKblzS8ZWxHu8uBNRptJ7ri1oixgkEA2pexoLy94ruERPAVugB4RjYo3qfmJAg9PIFzhTTwaJP570TJErD+M4AxlDt2F+Env3mBUJvZozdgZsq6PLuQzmYfYLGa5cM44RmoBp40kTYpf85Abk8jLv0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3664dbc0-03a8-4620-755e-08d5ebf32eca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1770;
x-ms-traffictypediagnostic: TY1PR01MB1770:
x-microsoft-antispam-prvs: <TY1PR01MB17700095786F716C39C02B70F55C0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1770;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1770;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(105586002)(316002)(44832011)(33656002)(110136005)(97736004)(74316002)(186003)(76176011)(476003)(11346002)(102836004)(26005)(53546011)(486006)(2900100001)(305945005)(54906003)(14454004)(106356001)(7736002)(5660300001)(478600001)(6506007)(8676002)(229853002)(68736007)(6436002)(55016002)(6246003)(6116002)(3846002)(99286004)(256004)(9686003)(5250100002)(81156014)(86362001)(2906002)(93886005)(7696005)(446003)(81166006)(53936002)(4326008)(25786009)(66066001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1770;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c+FsBAh85JEUF1atbV1OqFjkfVmkc1i7i+o/z4P/WGjU44soPLq60to3SU15+gwNTg2Pp11lyoGg2P6Phb0qknKv37IjJs2iSpWnGSk/yEW1ingentumHGLsERYZkdqDNQBLC2K+qpUWdGlbRD8M80DnOKqxpuUq8MzzKol3xVtmwfeqhLAsw4wHhadxHECVsLDsWOVgBds6ZhHFJ+qedf8QGowzGR1185wSudgVuCghHDYgXWhATkelUjMCAgNdUFzSSkqweyCe3TQ3U52qPTwxCNubrjHOOLs7H9TYgwwdd51Un863X4iMuDUJlSeo7Kj3Tkaj0CfBGGWda3DnxcgyPA3b0rvU+KaQCn7N4ns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3664dbc0-03a8-4620-755e-08d5ebf32eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 14:40:03.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KT24gMTcgSnVseSAyMDE4IDE1OjE5LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIFR1ZSwgMjAxOC0wNy0xNyBhdCAxMjo0MiArMDAwMCwgUGhpbCBFZHdvcnRoeSB3cm90
ZToNCj4gDQo+ID4gPiBXaGlsZSB5b3VyIHBvaW50IHNvdW5kcyB2YWxpZCAoZG9uJ3QgcmVtZW1i
ZXIgaG93IGNsa19nZXQoKSBpcw0KPiA+ID4gaW1wbGVtZW50ZWQpLCBOVUxMIGlzIGFsc28gT0sg
dG8gaGF2ZS4NCj4gPg0KPiA+IE9rIGFzIGluIHRoZXJlIGlzIG5vIGJ1cyBjbG9jaywgcmlnaHQ/
DQo+ID4gU28gaXQgc2hvdWxkIGJlOg0KPiA+ICBpZiAoIUlTX0VSUl9PUl9OVUxMIChkZXYtPmJ1
c2NsaykpDQo+IA0KPiBOb3BlLCBOVUxMIGlzIG5vIGVycm9yIGNhc2UgZm9yIG9wdGlvbmFsIGNs
b2NrLg0KSSBtdXN0IGJlIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUuLi4NCkkgYWdyZWUgdGhhdCBO
VUxMIGZvciBhbiBvcHRpb25hbCBjbG9jayBpcyBub3QgYW4gZXJyb3IuIEhvd2V2ZXIsIHRoZSAN
CmNvZGUgYWJvdmUgaXMgbm93Og0KKwlpZiAocHJlcGFyZSkgew0KKwkJLyogT3B0aW9uYWwgYnVz
IGNsb2NrICovDQorCQlpZiAoIUlTX0VSUl9PUl9OVUxMKGRldi0+YnVzY2xrKSkgew0KKwkJCXJl
dCA9IGNsa19wcmVwYXJlX2VuYWJsZShkZXYtPmJ1c2Nsayk7DQorCQkJaWYgKHJldCkNCisJCQkJ
cmV0dXJuIHJldDsNCisJCX0NCisNCiAJCXJldHVybiBjbGtfcHJlcGFyZV9lbmFibGUoZGV2LT5j
bGspOw0KKwl9DQoNClNvLCBpZiB5b3UgaGF2ZSBhIHZhbGlkIGJ1c2NsaywgaXQgZ2V0cyBlbmFi
bGVkLCBvdGhlcndpc2UgaXQgaXMNCmxlZnQgYWxvbmUuDQoNClRoYW5rcw0KUGhpbA0K
