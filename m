Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA752083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA752083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757315AbeFSObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:31:38 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:18153 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756864AbeFSObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:31:36 -0400
X-Greylist: delayed 60832 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 10:31:35 EDT
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 23F34AC;
        Tue, 19 Jun 2018 14:31:35 +0000 (UTC)
Received: from G9W8673.americas.hpqcorp.net (16.220.49.32) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 19 Jun 2018 14:31:31 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8673.americas.hpqcorp.net (2002:10dc:3120::10dc:3120) with Microsoft SMTP
 Server (TLS) id 15.0.1178.4; Tue, 19 Jun 2018 14:31:30 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1178.4 via Frontend Transport; Tue, 19 Jun 2018 14:31:31 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB0450.NAMPRD84.PROD.OUTLOOK.COM (10.169.3.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Tue, 19 Jun 2018 14:31:29 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4477:7ee3:af68:8f51]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4477:7ee3:af68:8f51%8]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 14:31:28 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     'Dan Williams' <dan.j.williams@intel.com>
CC:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Li, Juston" <juston.li@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Thread-Topic: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Thread-Index: AQHRnzuRoA+GWvSx3Uq4ciaXUj5K6aRrLxmAgAAKm4CAAAH8gIAADVAAgAAUTACAARAbUA==
Date:   Tue, 19 Jun 2018 14:31:28 +0000
Message-ID: <AT5PR8401MB1169ECE7D26644D39DB735D5AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
 <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com>
 <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
 <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4goV+VR15qpio-wqDpDS3nXsfYEbTSk1Ws6DPp6ECKcRQ@mail.gmail.com>
In-Reply-To: <CAPcyv4goV+VR15qpio-wqDpDS3nXsfYEbTSk1Ws6DPp6ECKcRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0450;7:MDBU8Osjuj8t9dR4CToCLSiU7GF/35ABRlua/1z6ObegR8wCN+pO2d6T7/OZVRtU5LIj4pOVwEzN+n0d29Hn/h84RSIPx/gRtb34U17YifCvsToHvnSrwnVyTvNyWzcRywDGHv1z59R4lGazd8pAsM02EPocK7BG+6wmpmjiSN1IIf+54INInp2UBr7lJKyaWHNude4/JekcAA/lTwfJGz0y7fF6wZWvQWvp1hu16CFCdBg6vXPHJRmhmKhZ68ll
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(189003)(199004)(40224003)(13464003)(11346002)(105586002)(446003)(2900100001)(33656002)(93886005)(476003)(8936002)(106356001)(9686003)(486006)(55016002)(15650500001)(478600001)(6436002)(3660700001)(74316002)(305945005)(3280700002)(229853002)(2906002)(14454004)(7736002)(66066001)(5250100002)(26005)(8676002)(186003)(97736004)(54906003)(81156014)(81166006)(99286004)(4326008)(53546011)(59450400001)(6506007)(7696005)(102836004)(6916009)(76176011)(6246003)(5660300001)(86362001)(68736007)(53936002)(6116002)(3846002)(25786009)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0450;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: de7d38fd-97f2-4e79-cd43-08d5d5f1585a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0450;
x-ms-traffictypediagnostic: AT5PR8401MB0450:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-microsoft-antispam-prvs: <AT5PR8401MB04501664286E0B9C72FE168DAB700@AT5PR8401MB0450.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(162533806227266)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0450;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0450;
x-forefront-prvs: 07083FF734
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wXGRddQtA2l07lPPumkKvBoTnOi98pm9mRusrGkjE0+jz4XrH1u7M0CD0B41fUoqHuy1wEXLZeAWG2MhrgDXdnBfZfbDjxaZZ815p9KaPyuYF9WcsE/NdZagKJ8Rrir/kuDSexZMzQVpmWIm9sHLXw9Zu3P3cYCQTO7dy0Ub1NqTCHeGLb84uGeScJLpdXpeztw2Vb1O/yLWqAzzWqLVVnNjgQRryf5rLE8x9cujAAqqS4I5lyawCU4jyfUuaoS7uqrooCTiN4/agFgv9QcQN7os3DogdmZC5358d0C07qd0jmAy69aGSRxuTmvbDPpB8urdCFWBVOy19yf1daxnSA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de7d38fd-97f2-4e79-cd43-08d5d5f1585a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 14:31:28.7567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0450
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIFtt
YWlsdG86ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tXQ0KPiBTZW50OiBNb25kYXksIEp1bmUgMTgs
IDIwMTggNDo0NyBQTQ0KPiBUbzogRWxsaW90dCwgUm9iZXJ0IChQZXJzaXN0ZW50IE1lbW9yeSkg
PGVsbGlvdHRAaHBlLmNvbT4NCj4gQ2M6IEthbmksIFRvc2hpIDx0b3NoaS5rYW5pQGhwZS5jb20+
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbnZkaW1tQGxpc3RzLjAx
Lm9yZzsgTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IExpLCBKdXN0b24N
Cj4gPGp1c3Rvbi5saUBpbnRlbC5jb20+OyByandAcmp3eXNvY2tpLm5ldDsgbGludXgtYWNwaUB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIGFjcGkvbmZpdDog
VXBkYXRlIG5maXQgZHJpdmVyIHRvIGNvbXBseSB3aXRoDQo+IEFDUEkgNi4xDQoNCg0KPiBMZXQn
cyB0YWtlIHNvbWV0aGluZyBzaW1wbGUgbGlrZSBWZW5kb3IgSUQuIFdoYXQgaXMgdGhlIFZlbmRv
ciBJRCBmb3INCj4gdGhlc2UgRElNTXMgYW5kIHdoYXQgZG9lcyBMaW51eCBwcmludCBpbiBzeXNm
cz8NCg0KSGVyZSBhcmUgc29tZSBleGFtcGxlcyAoa2VybmVsIDQuMTcpOg0KDQokIGNkIC9zeXMv
YnVzL25kL2RldmljZXMvbm1lbTAvbmZpdA0KJCBncmVwIC1zIC4gKg0KZGV2aWNlOjB4MzE0ZQ0K
ZHNtX21hc2s6MHgzYzc2DQpmYW1pbHk6MQ0KZmxhZ3M6c21hcnRfbm90aWZ5DQpmb3JtYXQ6MHgw
MTAxDQpmb3JtYXRzOjENCmhhbmRsZToweDENCmlkOjgwMmMtMGYtMTYxMi0xMjJmODI1NQlbU1BE
IGJ5dGVzIDMyMC0zMjgsIGluIHRoYXQgb3JkZXIgbGVmdC10by1yaWdodF0NCnBoeXNfaWQ6MHgx
Ng0KcmV2X2lkOjB4MzEwMA0Kc2VyaWFsOjB4MTIyZjgyNTUNCnN1YnN5c3RlbV9kZXZpY2U6MHgz
MTQxDQpzdWJzeXN0ZW1fcmV2X2lkOjB4MDEwMA0Kc3Vic3lzdGVtX3ZlbmRvcjoweDgwMzQJW0N5
cHJlc3MgU2VtaWNvbmR1Y3Rvcl0NCnZlbmRvcjoweDgwMmMJCVtNaWNyb25dDQoNCiQgY2QgL3N5
cy9idXMvbmQvZGV2aWNlcy9ubWVtMS9uZml0DQokIGdyZXAgLXMgLiAqDQpkZXZpY2U6MHgzMTRl
DQpkc21fbWFzazoweDNjNzYNCmZhbWlseToxDQpmbGFnczpzbWFydF9ub3RpZnkNCmZvcm1hdDow
eDAxMDENCmZvcm1hdHM6MQ0KaGFuZGxlOjB4Mg0KaWQ6ODAyYy0wZi0xNjEyLTEyMmY3ZjVlDQpw
aHlzX2lkOjB4MTUNCnJldl9pZDoweDMxMDANCnNlcmlhbDoweDEyMmY3ZjVlDQpzdWJzeXN0ZW1f
ZGV2aWNlOjB4MzE0MQ0Kc3Vic3lzdGVtX3Jldl9pZDoweDAxMDANCnN1YnN5c3RlbV92ZW5kb3I6
MHg4MDM0DQp2ZW5kb3I6MHg4MDJjDQoNClNvbWUgY29ycmVzcG9uZGluZyBpbmZvcm1hdGlvbiBm
b3IgdGhvc2UgTlZESU1NLU5zIGFzIHJlcG9ydGVkIGJ5IGRtaWRlY29kZToNCg0KSGFuZGxlIDB4
MDBBOCwgRE1JIHR5cGUgMjM3LCA5IGJ5dGVzDQpPRU0tc3BlY2lmaWMgVHlwZQ0KICAgICAgICBI
ZWFkZXIgYW5kIERhdGE6DQogICAgICAgICAgICAgICAgRUQgMDkgQTggMDAgMTYgMDAgMDEgMDIg
MDMNCiAgICAgICAgU3RyaW5nczoNCiAgICAgICAgICAgICAgICBNaWNyb24JCVtNb2R1bGUgbWFu
dWZhY3R1cmVyXQ0KICAgICAgICAgICAgICAgIDE4QVNGMUc3MlhGMTJHMVkxMUFBCVtNb2R1bGUg
cGFydCBudW1iZXJdDQogICAgICAgICAgICAgICAgMTIyRjgyNTUJW01vZHVsZSBzZXJpYWwgbnVt
YmVyXQ0KDQpIYW5kbGUgMHgwMEE3LCBETUkgdHlwZSAyMzcsIDkgYnl0ZXMNCk9FTS1zcGVjaWZp
YyBUeXBlDQogICAgICAgIEhlYWRlciBhbmQgRGF0YToNCiAgICAgICAgICAgICAgICBFRCAwOSBB
NyAwMCAxNSAwMCAwMSAwMiAwMw0KICAgICAgICBTdHJpbmdzOg0KICAgICAgICAgICAgICAgIE1p
Y3Jvbg0KICAgICAgICAgICAgICAgIDE4QVNGMUc3MlhGMTJHMVkxMUFBDQogICAgICAgICAgICAg
ICAgMTIyRjdGNUUNCg0K
