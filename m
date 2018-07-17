Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28432ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6832146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="K3xJcxsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6832146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbeGQNor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:44:47 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:14917 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731548AbeGQNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:44:47 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 17 Jul 2018 22:12:08 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id B911584E54;
        Tue, 17 Jul 2018 22:12:08 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,365,1526310000"; 
   d="scan'208";a="287112913"
Received: from mail-os2jpn01lp0146.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.146])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2018 22:12:08 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkP+iSdpEjm7gV1jYmLD9Dfll7nE65X6cGP8HWJaXV0=;
 b=K3xJcxsQ7KejyxJ3uDs9S7ZvHmPnJdzO/6aVd4tWnDDz39BuHvZLRCx46DnXmKWSqvjO0kRdH8ffl29Ws6Gn+TDBhnKzbM41B2vr9Unef6hAIuAVd5cokTB9a83HKWCOAH+MKNhwtGAwuWYVkN1igOGYF2Rxix9D4zlXsvWUS2c=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1801.jpnprd01.prod.outlook.com (52.133.164.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 13:12:06 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333%2]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 13:12:06 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Horman <horms@verge.net.au>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Topic: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Index: AQHUHONXv++x9VJe70Gk9EuuSmoVI6STU7qAgAAEdoCAAAK7oIAAB/kAgAACkTA=
Date:   Tue, 17 Jul 2018 13:12:05 +0000
Message-ID: <TY1PR01MB1769EA2ACCC9EC9D0F2DC00EF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
 <20180717120737.bipotpki3yhn6klf@verge.net.au>
 <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
 <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdX8Q4wJtQ==PW0HrQpWS=CY1zPuasJPQCuQwhN0PzVfpQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX8Q4wJtQ==PW0HrQpWS=CY1zPuasJPQCuQwhN0PzVfpQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1801;7:rhU5VIGSREvuOJzGTG4Mf0Ms6uB9g7zRwQ2ZtkGVAFG9kL+O48fdoyGyIFk8y6ilQQDpVrE/DlF60MSK1GhBGn+XrqIqBLzWw2u7a5AcP860RWtnLabcgpRjmg5FoH0DH4IaJoNHQkcQSpeyCEZKppVvgQqqs0laqKPXyj5YY/TmCy3cgHk57Byt6KRDyTE1sG9TE7UW5c2i/5M4qd6ZLfGqsJpm66r8vzgWgEpxgwVIQ0u+mBvMJPcnfLaSmjI5;20:pg20SEBqOp0nTxmsXF5CGSZDdVF/7D5rqi3qkaVKyBhxxqMAbyMHx/RMEDw51UN2TIRTZvzz1UTYs0tJPCBlA5kVxQNvPCSpojouvlrEu2GIBmCX2LS1x4MuGNDpjH41eHaiY7l+hee1BHzVqOLKqSgsjdOcW7aWf+F8LXqksWU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2c7a6a90-1517-4f17-e707-08d5ebe6e523
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1801;
x-ms-traffictypediagnostic: TY1PR01MB1801:
x-microsoft-antispam-prvs: <TY1PR01MB180102A647432C454E24856CF55C0@TY1PR01MB1801.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1801;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1801;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(316002)(44832011)(11346002)(446003)(53936002)(6246003)(6506007)(53546011)(102836004)(93886005)(25786009)(476003)(9686003)(55016002)(4326008)(76176011)(26005)(486006)(6436002)(7696005)(186003)(14444005)(256004)(5250100002)(14454004)(478600001)(99286004)(54906003)(7736002)(97736004)(229853002)(2900100001)(74316002)(68736007)(6916009)(2906002)(105586002)(5660300001)(106356001)(8936002)(3846002)(6116002)(8676002)(81156014)(81166006)(86362001)(33656002)(66066001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1801;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ih99GnP4rQZcwsVQHsp+fWKtPB1PJpttY1hCFnSHmn4mA6osI5SdVaxuW8JSIL3UpKmxk1xPNAt8hwrU1bjdCCeE4ySgO7oN3CNFupS0BdWRQbeZwQ/lmVt/BJI8rsfNi8/crLWQx/FDwJvASHDcABHxfRnETGppjGY+etbkhil2fPYJvocc5iHzUPz/TEW9WOpW7iZVnqrx/sEtDsx4hvQJoHACuXMpFkjnUfL1Q+aVe5nQb/MG5cSAwtXuBfpFYo960KhYNHvnV7hN6aVO9PzBeUS+dqA5jNbR9zeeIh+H1JIVcLvQoS9X2My8K6GAlnGx5ASf0WeR+kswpnwcVaxk/YTHOfZTROFjOIE29yE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7a6a90-1517-4f17-e707-08d5ebe6e523
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 13:12:06.0102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDE3IEp1bHkgMjAxOCAxNDowMiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KPiBPbiBUdWUsIEp1bCAxNywgMjAxOCBhdCAyOjQyIFBNIFBoaWwgRWR3b3J0aHkgd3Jv
dGU6DQo+ID4gT24gMTcgSnVseSAyMDE4IDEzOjI0LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+
ID4gPiBPbiBUdWUsIDIwMTgtMDctMTcgYXQgMTQ6MDcgKzAyMDAsIFNpbW9uIEhvcm1hbiB3cm90
ZToNCj4gPiA+ID4gT24gTW9uLCBKdWwgMTYsIDIwMTggYXQgMDk6NTk6MTNBTSArMDEwMCwgUGhp
bCBFZHdvcnRoeSB3cm90ZToNCj4gPiA+ID4gPiBUaGUgU3lub3BzeXMgSTJDIENvbnRyb2xsZXIg
aGFzIGEgYnVzIGNsb2NrLCBidXQgdHlwaWNhbGx5IFNvQ3MNCj4gPiA+ID4gPiBoaWRlIHRoaXMg
YXdheS4NCj4gPiA+ID4gPiBIb3dldmVyLCBvbiBzb21lIFNvQ3MgeW91IG5lZWQgdG8gZXhwbGlj
aXR5IGVuYWJsZSB0aGUgYnVzIGNsb2NrDQo+ID4gPiA+ID4gaW4gb3JkZXIgdG8gYWNjZXNzIHRo
ZSByZWdpc3RlcnMuDQo+ID4gPiA+ID4gVGhlcmVmb3JlLCBlbmFibGUgYW4gb3B0aW9uYWwgYnVz
IGNsb2NrIHNwZWNpZmllZCBieSBEVC4NCj4gPiA+DQo+ID4gPiA+ID4gKyAgICAgICAgIC8qIE9w
dGlvbmFsIGJ1cyBjbG9jayAqLw0KPiA+ID4gPiA+ICsgICAgICAgICBpZiAoIUlTX0VSUihkZXYt
PmJ1c2NsaykpIHsNCj4gPiA+ID4NCj4gPiA+ID4gSSBzdXNwZWN0IHRoYXQgZXJyb3IgdmFsdWVz
IHN0b3JlZCBpbiBkZXYtPmJ1c2NsaywgIG90aGVyIHRoYW4NCj4gPiA+ID4gLUVOT0VOVCwgc2hv
dWxkIGJlIHRyZWF0ZWQgYXMgZXJyb3JzLg0KPiA+IElTX0VSUiBjYXRjaGVzIGFsbCBlcnJvcnMg
YW5kIGlzIHRoZSBjb3JyZWN0IHdheSB0byBjaGVjayB0aGUgdmFsdWUNCj4gPiByZXR1cm5lZCBi
eSBkZXZtX2Nsa19nZXQuDQo+IA0KPiBXaGF0IGlmIGl0IHJldHVybnMgLUVQUk9CRV9ERUZFUiwg
d2hpY2ggbWVhbnMgdGhlIGNsb2NrIGlzIHJlZmVyZW5jZWQsIGFuZA0KPiB0aHVzIG5vdCBvcHRp
b25hbCwgYnV0IG5vdCB5ZXQgcmVhZHk/DQo+IEZvciBvcHRpb25hbCBjbG9ja3MsIGFsbCBlcnJv
cnMgYnV0IC1FTk9FTlQgc2hvdWxkIGJlIHByb3BhZ2F0ZWQgdXAuDQpHb29kIHBvaW50IQ0KDQpU
aGFua3MNClBoaWwNCg==
