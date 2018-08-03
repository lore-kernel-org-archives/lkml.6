Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1AD217A6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aGEiA+M8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1AD217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbeHCTzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:55:17 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:54176
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727566AbeHCTzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8+Yk6gZHZMw4yspNYVJ+uD6AaoTZk3Uscio51UDifs=;
 b=aGEiA+M8LAtFmUd2ZjkKgt2eKj6YCxiC9XDIh2ZEdx6jrTgl4RqIHmP6HCP1MTmSEzKi0CFEmNkHPKPLNafT9emGVg7wML23RRmCU62waI8nsnZP104+z/XOCWiX61yk6O0Tc2S2xpSd09y56XrB9/sSC5d3RQGN0rF8g6DdubE=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1721.namprd02.prod.outlook.com (10.162.165.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 17:57:50 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::9469:3f99:3931:2f92]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::9469:3f99:3931:2f92%3]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 17:57:50 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Michal Simek <michals@xilinx.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
Thread-Topic: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
Thread-Index: AQHUCL3wiHDzR04mOkK+ceCYxENFWqSGeWsAgA2HXQCADI7DgIAOBT9Q
Date:   Fri, 3 Aug 2018 17:57:49 +0000
Message-ID: <CY1PR02MB2138E8037930136463F8555FB8230@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-11-git-send-email-jollys@xilinx.com>
 <153111401693.143105.16925315512459949259@swboyd.mtv.corp.google.com>
 <SN1PR02MB37589FF7DBAFBD0C070F690EB85C0@SN1PR02MB3758.namprd02.prod.outlook.com>
 <153254813376.48062.5902552373363371978@swboyd.mtv.corp.google.com>
In-Reply-To: <153254813376.48062.5902552373363371978@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1721;6:IRHYkoNoxgBSKgBaVU87DqfcvPEhxq2BUJFCFQ32Jmz2QSyNZ9+wEj5gs/rF43cx/7S3W9ENMIXsDdsNTpGsEfNI8XpCLk00/ZxZcDtlsAUEe+Sq9fkGEV+IhXFpuqWTKp1O+sp1EukEZ5OjI+xetuMivZnwfoR2ghkqDxeflbb6xq/7JcpfOoN/QkjmiTwnrH0RDjModZe8NJE2musJxxxcvpDHqp5qoBcnXa/dIaaH0DmPecNcc/JfQz04E9vb+FAT0g2RmrQT9dfegxu8rRkZ4aGl9UMAg6ZPXq8VyigItSNp/EyFM80Nxua+vDuBD98MERq1cjawLrd9B5nWr4H/CSCyd8TOxqtkjCWCvBtw6g8iVntZqJhoNZTG0esgpWZO6kptcax8lSX0qgkORzC9M5ujSWJMvJyUp/ob7ZGeyWNAF7/Fglr2wN+1jpRkL2JmIQ4x15qnUMiXzIjg8Q==;5:K5ujRPfA0oWoH0rHlvq+hbhUb20w5ISh5ctQK9KwzO0VH9OAlt2E0LS0ElMz7hTYluN3fOXDHcYsWnWsGuzUkLSN0QbxuZ5uuwAwITA0ueGCgDrfWg5CSi/3oB0PK4SXYY09Dcqe6ZRVsx/F/AqurrfbIj/Snbv0NQKIYmmrVOA=;7:cUIa5ysJ/oVgpN4K0Jnel2kHmQXIEpKaBRiqL71xYTO/S5pfu76yEjGzgDFZkJC2P/yqlZ6mv9AYcZQ5sTBRaGjZJd7wixc/v9peEQQGhak/rMyD6SvrJkafufPWO1wQwpHVXJOKvb4uHqJMIaY3nmKzP3+deZnME/NPG0aIe17fhJApDg3mAe6ATAD/EHS7ie4o5ciOJ8Ne1ODvyK4mb7GaI1KXxYqW1rZBCv3hnm3lEhnSHM9+6UJxuorIy3hD
x-ms-office365-filtering-correlation-id: 0f8b7cef-d787-44b6-3f4b-08d5f96aa0a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1721;
x-ms-traffictypediagnostic: CY1PR02MB1721:
x-microsoft-antispam-prvs: <CY1PR02MB17218A24AC0AC0F3110E55BCB8230@CY1PR02MB1721.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1721;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1721;
x-forefront-prvs: 0753EA505A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(51914003)(189003)(199004)(13464003)(4326008)(76176011)(446003)(476003)(53936002)(99286004)(486006)(6436002)(8676002)(7696005)(66066001)(6506007)(105586002)(106356001)(5660300001)(8936002)(2501003)(6636002)(5250100002)(11346002)(7416002)(2900100001)(305945005)(229853002)(316002)(7736002)(74316002)(33656002)(25786009)(478600001)(39060400002)(55016002)(102836004)(14444005)(86362001)(2906002)(2201001)(186003)(54906003)(256004)(3846002)(93886005)(53546011)(81156014)(14454004)(110136005)(9686003)(6246003)(6116002)(72206003)(81166006)(68736007)(97736004)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1721;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nvU1WE+RdNYDgVRthhxKjmxM9f2+FjD5PdA9m+xlsQO+rOCfyh3P6da/j41jok6t5qGnVpjMfCIfPnqC1BgWUP1x3vWq7VW6qe5T8nDepPC6dmkLrlc0JU1H7+39AONc6GMw9sfCLYWqPK5LAzmlpwgUqTNwRp2cinj5vcTWo6+WtbOi5wgfxItsEj8zpI7rwfgqqH9hcBBVSbwmQdbhwwcyOTvrIBRCHrBEL9PYtjuLY/9ylMpdup7sJ4xZUNzW/z9LrWDRxqIpIKPHRT8b7hxVi+Q9SUQMjfUyPatANjUHcPOIQUlKm3eLSsACUQHuqVpWBI2UrhNxhnReBo8ZYtw5JghLOd2HNwRqPC83wwM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8b7cef-d787-44b6-3f4b-08d5f96aa0a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 17:57:49.9483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1
bHkgMjUsIDIwMTggMTI6NDkgUE0NCj4gVG86IGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc7IGRt
aXRyeS50b3Jva2hvdkBnbWFpbC5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBo
a2FsbHdlaXQxQGdtYWlsLmNvbTsNCj4ga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyBsaW51eC1jbGtA
dmdlci5rZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbWF0dEBjb2RlYmx1ZXBy
aW50LmNvLnVrOyBtaW5nb0BrZXJuZWwub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4g
cm9iaCtkdEBrZXJuZWwub3JnOyBzYm95ZEBjb2RlYXVyb3JhLm9yZzsgc3VkZWVwLmhvbGxhQGFy
bS5jb207IEpvbGx5DQo+IFNoYWggPEpPTExZU0B4aWxpbnguY29tPjsgTWljaGFsIFNpbWVrIDxt
aWNoYWxzQHhpbGlueC5jb20+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgVGVq
YXMgUGF0ZWwgPFRFSkFTUEB4aWxpbnguY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsgU2h1YmhyYWp5b3RpIERhdHRh
DQo+IDxzaHViaHJhakB4aWxpbnguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjkgMTAvMTBdIGRyaXZlcnM6IGNsazogQWRk
IFp5bnFNUCBjbG9jayBkcml2ZXINCj4gDQo+IFF1b3RpbmcgSm9sbHkgU2hhaCAoMjAxOC0wNy0x
NyAxMzowOTowMSkNCj4gPiBIaSBTdGVwaGVuLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2
aWV3LA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
U3RlcGhlbiBCb3lkIFttYWlsdG86c2JveWRAa2VybmVsLm9yZ10NCj4gPiA+IFNlbnQ6IFN1bmRh
eSwgSnVseSAwOCwgMjAxOCAxMDoyNyBQTQ0KPiA+ID4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4
aWxpbnguY29tPjsgYXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZzsNCj4gPiA+IGRtaXRyeS50b3Jv
a2hvdkBnbWFpbC5jb207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiA+ID4gaGthbGx3
ZWl0MUBnbWFpbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gPiA+IGxpbnV4LWNsa0B2
Z2VyLmtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiA+ID4gbWF0dEBjb2RlYmx1
ZXByaW50LmNvLnVrOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+ID4gPiBt
aW5nb0BrZXJuZWwub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gPiA+IHJvYmgrZHRA
a2VybmVsLm9yZzsgc2JveWRAY29kZWF1cm9yYS5vcmc7IHN1ZGVlcC5ob2xsYUBhcm0uY29tDQo+
ID4gPiBDYzogUmFqYW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+Ow0KPiA+ID4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEpvbGx5IFNoYWgNCj4gPiA+IDxK
T0xMWVNAeGlsaW54LmNvbT47IFRlamFzIFBhdGVsIDxURUpBU1BAeGlsaW54LmNvbT47IFNodWJo
cmFqeW90aQ0KPiA+ID4gRGF0dGEgPHNodWJocmFqQHhpbGlueC5jb20+OyBKb2xseSBTaGFoIDxK
T0xMWVNAeGlsaW54LmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMTAvMTBdIGRy
aXZlcnM6IGNsazogQWRkIFp5bnFNUCBjbG9jayBkcml2ZXINCj4gPiA+DQo+ID4gPiA+ICsvKioN
Cj4gPiA+ID4gKyAqIHp5bnFtcF9wbV9jbG9ja19nZXRfcGFyZW50cygpIC0gR2V0IHRoZSBmaXJz
dCAzIHBhcmVudHMgb2YNCj4gPiA+ID4gK2Nsb2NrIGZvciBnaXZlbg0KPiA+ID4gaWQNCj4gPiA+
ID4gKyAqIEBjbG9ja19pZDogIENsb2NrIElEDQo+ID4gPiA+ICsgKiBAaW5kZXg6ICAgICBQYXJl
bnQgaW5kZXgNCj4gPiA+ID4gKyAqIEBwYXJlbnRzOiAgIDMgcGFyZW50cyBvZiB0aGUgZ2l2ZW4g
Y2xvY2sNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGlzIHVzZWQgdG8g
Z2V0IDMgcGFyZW50cyBmb3IgdGhlIGNsb2NrIHNwZWNpZmllZA0KPiA+ID4gPiArYnkNCj4gPiA+
ID4gKyAqIGdpdmVuIGNsb2NrIElELg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFRoaXMgQVBJ
IHdpbGwgcmV0dXJuIDMgcGFyZW50cyB3aXRoIGEgc2luZ2xlIHJlc3BvbnNlLiBUbyBnZXQNCj4g
PiA+ID4gKyAqIG90aGVyIHBhcmVudHMsIG1hc3RlciBzaG91bGQgY2FsbCBzYW1lIEFQSSBpbiBs
b29wIHdpdGggbmV3DQo+ID4gPiA+ICsgKiBwYXJlbnQgaW5kZXggdGlsbCBlcnJvciBpcyByZXR1
cm5lZC4gRS5nIEZpcnN0IGNhbGwgc2hvdWxkDQo+ID4gPiA+ICtoYXZlDQo+ID4gPiA+ICsgKiBp
bmRleCAwIHdoaWNoIHdpbGwgcmV0dXJuIHBhcmVudHMgMCwxIGFuZCAyLiBOZXh0IGNhbGwsIGlu
ZGV4DQo+ID4gPiA+ICsgKiBzaG91bGQgYmUgMyB3aGljaCB3aWxsIHJldHVybiBwYXJlbnQgMyw0
IGFuZCA1IGFuZCBzbyBvbi4NCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBSZXR1cm46IFJldHVy
bnMgc3RhdHVzLCBlaXRoZXIgc3VjY2VzcyBvciBlcnJvcityZWFzb24gICovDQo+ID4gPiA+ICtz
dGF0aWMgaW50IHp5bnFtcF9wbV9jbG9ja19nZXRfcGFyZW50cyh1MzIgY2xvY2tfaWQsIHUzMiBp
bmRleCwNCj4gPiA+ID4gK3UzMg0KPiA+ID4gKnBhcmVudHMpDQo+ID4gPiA+ICt7DQo+ID4gPiA+
ICsgICAgICAgc3RydWN0IHp5bnFtcF9wbV9xdWVyeV9kYXRhIHFkYXRhID0gezB9Ow0KPiA+ID4g
PiArICAgICAgIHUzMiByZXRfcGF5bG9hZFtQQVlMT0FEX0FSR19DTlRdOw0KPiA+ID4NCj4gPiA+
IFdoYXQncyB0aGUgZW5kaWFubmVzcyBvZiB0aGlzIHBheWxvYWQ/IElzIGl0IGxpdHRsZSBlbmRp
YW4/IE9yIGRvDQo+ID4gPiB0aGUgZWVtaV9vcHMgY29udmVydCB0byBDUFUgbmF0aXZlIGVuZGlh
bm5lc3M/DQo+ID4NCj4gPiBJdHMgbGl0dGxlIGVuZGlhbg0KPiANCj4gSXMgaXQgQ1BVIG5hdGl2
ZT8gVGhpcyBtaWdodCBuZWVkIHRvIGJlIG1hcmtlZCBhcyBfX2xlMzIgZm9yIHByb3BlciBlbmRp
YW5lc3MNCj4gY29kZS4NCj4gDQoNCkZpeGVkIGluIHYxMSBzZXJpZXMocG9zdGVkIHRvZGF5KS4N
Cg0KPiA+DQo+ID4gPiA+ICsNCj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogenlucW1wX2Nsb2Nr
X2luaXQoKSAtIEluaXRpYWxpemUgenlucW1wIGNsb2Nrcw0KPiA+ID4gPiArICoNCj4gPiA+ID4g
KyAqIFJldHVybjogMCBvbiBzdWNjZXNzIGVsc2UgZXJyb3IgY29kZSAgKi8gc3RhdGljIGludCBf
X2luaXQNCj4gPiA+ID4gK3p5bnFtcF9jbG9ja19pbml0KHZvaWQpIHsNCj4gPiA+ID4gKyAgICAg
ICBpbnQgcmV0Ow0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKyAgICAgICBucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEws
IE5VTEwsICJ4bG54LHp5bnFtcCIpOw0KPiA+ID4gPiArICAgICAgIGlmICghbnApDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsNCj4gPiA+ID4gKyAgICAgICBvZl9ub2Rl
X3B1dChucCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBucCA9IG9mX2ZpbmRfY29tcGF0
aWJsZV9ub2RlKE5VTEwsIE5VTEwsDQo+ID4gPiA+ICsgInhsbngsenlucW1wLWNsayIpOw0KPiA+
ID4NCj4gPiA+IFdoeSBjYW4ndCB0aGlzIGJlIGEgcGxhdGZvcm0gZGV2aWNlIGRyaXZlcj8NCj4g
Pg0KPiA+IFBsYXRmb3JtIGRyaXZlciBtYXkgcHJvYmUgbGF0ZXIoYW4gYWN0dWFsbHkgcHJvYmlu
ZyBsYXRlciBpbiBvdXIgY2FzZSkuIFRoaXMgd2lsbA0KPiByZXN1bHRzIGluIGNsb2NrIGdldCBm
YWlsdXJlIGluIGNsb2NrIGNvbnN1bWVyIHBlcmlwaGVyYWxzLiBTbyBjbG9jayByZWdpc3RyYXRp
b24NCj4gbmVlZHMgdG8gYmUgZG9uZSBlYXJsaWVyLg0KPiANCj4gVGhhdCdzIGZpbmUgdGhvdWdo
PyBJZiBhIGNsa19nZXQoKSBmYWlscyBiZWNhdXNlIHRoZSBwcm92aWRlciBpc24ndCByZWdpc3Rl
cmVkIHlldA0KPiB0aGUgY29uc3VtZXIgd2lsbCBzZWUgLUVQUk9CRV9ERUZFUiBhbmQgdHJ5IGFn
YWluIGxhdGVyLg0KDQpZb3UgYXJlIHJpZ2h0LiBSZXBsYWNlZCBpbml0IHdpdGggcGxhdGZvcm0g
ZHJpdmVyIHByb2JlIGluIHYxMSBzZXJpZXMocG9zdGVkIHRvZGF5KS4NCg0KVGhhbmtzLA0KSm9s
bHkgU2hhaA0KDQoNCg==
