Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39FC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9052083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9052083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030706AbeFSTxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:53:40 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:16090 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030666AbeFSTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:53:24 -0400
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id C0774C5;
        Tue, 19 Jun 2018 19:53:23 +0000 (UTC)
Received: from G4W9333.americas.hpqcorp.net (16.208.32.119) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 19 Jun 2018 19:53:14 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G4W9333.americas.hpqcorp.net (2002:10d0:2077::10d0:2077) with Microsoft SMTP
 Server (TLS) id 15.0.1178.4; Tue, 19 Jun 2018 19:53:13 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1178.4 via Frontend Transport; Tue, 19 Jun 2018 19:53:13 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB0514.NAMPRD84.PROD.OUTLOOK.COM (10.169.3.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Tue, 19 Jun 2018 19:53:12 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4477:7ee3:af68:8f51]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4477:7ee3:af68:8f51%8]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 19:53:11 +0000
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
Thread-Index: AQHRnzuRoA+GWvSx3Uq4ciaXUj5K6aRrLxmAgAAKm4CAAAH8gIAADVAAgAAUTACAARAbUIAAGIaAgAAjL5A=
Date:   Tue, 19 Jun 2018 19:53:11 +0000
Message-ID: <AT5PR8401MB1169CBD96EE6C152A24D9FD3AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
 <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com>
 <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
 <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4goV+VR15qpio-wqDpDS3nXsfYEbTSk1Ws6DPp6ECKcRQ@mail.gmail.com>
 <AT5PR8401MB1169ECE7D26644D39DB735D5AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4joz7OemcKvJMJVhqKEVgSMpfLbm2DRP9B=S3vRPUAGkQ@mail.gmail.com>
In-Reply-To: <CAPcyv4joz7OemcKvJMJVhqKEVgSMpfLbm2DRP9B=S3vRPUAGkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0514;7:IehwHdfPkMrW1Ikeo4txlPlcLy/Ghu1QT7KlbNJPT+/MeEG+t9Q0qZZw7cUsoANAoidclvQmGFf722zWQJBfvkyOoX5iM6F7VKW4Uor3vupA7tqjNrIvD9d7CP+bKBABU+1pvId6qSM0mJT4UxDeV1olBkxSi4pSTGbIiikoZ0sXr1EbkJy3RPaEg7x6Vwglyo39/gdL+2wWaEYtfahU/4TbF5UnovXhF22c0mpMftQQYnc8g+Jr7sKYzLP2Os+d
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(189003)(199004)(13464003)(446003)(305945005)(8676002)(81156014)(59450400001)(9686003)(11346002)(6506007)(74316002)(476003)(53936002)(186003)(55016002)(81166006)(5250100002)(53546011)(93886005)(76176011)(6246003)(8936002)(229853002)(54906003)(5660300001)(114624004)(4326008)(7696005)(68736007)(7736002)(6436002)(6916009)(99286004)(316002)(3280700002)(3660700001)(86362001)(486006)(15650500001)(25786009)(2906002)(26005)(33656002)(14454004)(106356001)(97736004)(6116002)(102836004)(478600001)(66066001)(3846002)(105586002)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0514;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ee877556-a958-4957-2df2-08d5d61e4981
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0514;
x-ms-traffictypediagnostic: AT5PR8401MB0514:
x-microsoft-antispam-prvs: <AT5PR8401MB0514A55661F953E1EFD0C2C5AB700@AT5PR8401MB0514.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(20558992708506)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0514;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0514;
x-forefront-prvs: 07083FF734
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fkszXz1Icz8nYZvYQ3HPK3ty/fzz9njdXQm1QTRdiAu+GTc3sJG4haQ9pWDg1Zu3sU3Pof/B3NM0GA9m8Naefciu83vcDp/4jC4LnKLpvCpaxH1kMWMwb8ySngbcez5JOtyn5Ip6dGRLG57up6u0qMMdpg09V8o3XsPOLqylBM6o151oEbg12F0mKoS4UGjvfT4PDgYbEeEsU+KrtZ0w7oCwNEI93X5sP59JAejW5EVkIMjsa4/SlBQ+Na2habwj4o44QcKcIRNNrXav1ByH0eRClxiCyW6HyX7OlrloenTTHNb3wEkfXqkn8S5SKNJWvADxE1cN0yqreraLddgkog==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee877556-a958-4957-2df2-08d5d61e4981
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 19:53:11.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0514
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LWtlcm5lbC0NCj4gb3duZXJAdmdlci5r
ZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgRGFuIFdpbGxpYW1zDQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bmUgMTksIDIwMTggMTA6MjkgQU0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIGFjcGkv
bmZpdDogVXBkYXRlIG5maXQgZHJpdmVyIHRvIGNvbXBseSB3aXRoDQo+IEFDUEkgNi4xDQouLi4N
Cj4gPg0KPiA+IEhlcmUgYXJlIHNvbWUgZXhhbXBsZXMgKGtlcm5lbCA0LjE3KToNCg0KTm90ZSB0
aGF0IHRoZXNlIHZhbHVlcyB3ZXJlIGFzIHJlcG9ydGVkIG9uIGEgbGl0dGxlLWVuZGlhbiBzeXN0
ZW0uDQoNCj4gT2ssIHNvIHRoZSBsb3dlc3Qgc2lnbmlmaWNhbnQgYnl0ZSBvZiB0aGUgTWljcm9u
IGlkIGlzIHN1cHBvc2VkIHRvIGJlDQo+IDB4MmMgYW5kIHRoaXMgdGV4dCByZXByZXNlbnRhdGlv
biBtYXRjaGVzIHRoYXQuIFNvIHRoZSBieXRlcyBhcmUgYmVpbmcNCj4gZW5kaWFuIHN3YXBwZWQg
d2hlbiB3cml0dGVuIHRvIHRoZSBTUEQ/DQoNClNQRCBieXRlIDMyMCBpcyAweDgwLiBUaGF0J3Mg
dGhlIGJhbmsgbnVtYmVyIGJ5dGUgKHdpdGggb2RkIHBhcml0eSkuDQpTUEQgYnl0ZSAzMjEgaXMg
MHgyYy4gVGhhdCdzIHRoZSBtYW51ZmFjdHVyZXIgY29kZSBieXRlICh3aXRoIG9kZCBwYXJpdHkp
Lg0KDQpJZiB0cmVhdGVkIGFzIGEgc2luZ2xlIDItYnl0ZSB2YWx1ZSwgdGhhdCBpczoNCiogMHg4
MDJjICgzMjgxMiBpbiBkZWNpbWFsKSBpZiBpbnRlcnByZXRlZCBhcyBiaWctZW5kaWFuIA0KKiAw
eDJjODAgKDExMzkyIGluIGRlY2ltYWwpIGlmIGludGVycHJldGVkIGFzIGxpdHRsZS1lbmRpYW4N
Cg0KUmV2aWV3aW5nIHRoZSBfc2hvdygpIGZ1bmN0aW9ucyBpbiBkcml2ZXJzL2FjcGkvbmZpdC9j
b3JlLmM6DQogIEJFIGRldmljZToweDMxNGUNCiAgTkUgZHNtX21hc2s6MHgzYzc2DQogIE5FIGZh
bWlseToxDQogIE4vQSBmbGFnczpzbWFydF9ub3RpZnkNCiAgTEUgZm9ybWF0OjB4MDEwMQ0KICBO
L0EgZm9ybWF0czoxDQogIEJFIGhhbmRsZToweDENCiAgQkUgaWQ6ODAyYy0wZi0xNjEyLTEyMmY4
MjU1IFtTUEQgYnl0ZXMgMzIwLTMyOF0NCiAgTkUgcGh5c19pZDoweDE2DQogIEJFIHJldl9pZDow
eDMxMDANCiAgQkUgc2VyaWFsOjB4MTIyZjgyNTUNCiAgQkUgc3Vic3lzdGVtX2RldmljZToweDMx
NDENCiAgQkUgc3Vic3lzdGVtX3Jldl9pZDoweDAxMDANCiAgQkUgc3Vic3lzdGVtX3ZlbmRvcjow
eDgwMzQgW0N5cHJlc3MgU2VtaWNvbmR1Y3Rvcl0NCiAgQkUgdmVuZG9yOjB4ODAyYyBbTWljcm9u
XQ0KDQooQkU9Zml4ZWQgYmlnLWVuZGlhbiwgTEU9Zml4ZWQgbGl0dGxlLWVuZGlhbiwgTkU9bmF0
aXZlLWVuZGlhbiwNCiBOL0E9bm90IGFwcGxpY2FibGUpDQoNCkJFIGFuZCBMRSB3aWxsIHByaW50
IHRoZSBzYW1lIHJlZ2FyZGxlc3Mgb2YgdGhlIGVuZGlhbm5lc3MNCm9mIHRoZSBzeXN0ZW0sIHdo
aWxlIE5FIHdpbGwgdmFyeS4NCg0KUmV2aWV3aW5nIHRoZSBORSBzeXNmcyBmaWxlczoNCg0KcGh5
c19pZDoNClRoaXMgTkZJVCBmaWVsZCByZXBvcnRzIGFuIFNNQklPUyBoYW5kbGUgKGluc3RhbmNl
IElEKSwgYSBMRSBudW1iZXINCmZyb20gMC4ubiAoMHgxMDMgb24gb25lIG9mIG15IHN5c3RlbXMp
LiAgZG1pZGVjb2RlIHNob3dzIGhhbmRsZXMNCmxpa2UgdGhpczoNCiAgSGFuZGxlIDB4MDAxNiwg
RE1JIHR5cGUgMTcsIDQwIGJ5dGVzDQogIE1lbW9yeSBEZXZpY2UNCiAgICAgICAgQXJyYXkgSGFu
ZGxlOiAweDAwMEENCg0KT24gYSBiaWctZW5kaWFuIHN5c3RlbSwgSSB0aGluayB3ZSdsbCBzZWUN
CiAgcGh5c19pZDoweDE2MDANCndoaWNoIG1lYW5zIDU2MzIgZGVjaW1hbCwgd2hpY2ggaXMgbWlz
bGVhZGluZy4gRml4ZWQgTEUgd291bGQNCmJlIGJldHRlci4NCg0KZHNtX21hc2s6DQpUaGUgY29k
ZSB0aGF0IHBhcnNlcyBfRFNNIGZ1bmN0aW9uIDAgb3V0cHV0LCBhY3BpX2NoZWNrX2RzbSgpLA0K
Y29ycmVjdGx5IGludGVycHJldHMgdGhlIGJpdG1hc2sgYXMgbGl0dGxlLWVuZGlhbiBmb3IgaW50
ZXJuYWwNCmNhbGN1bGF0aW9ucy4gIEkgdGhpbmsgYSBiaWctZW5kaWFuIHN5c3RlbSB3aWxsIHBy
aW50IA0KZHNtX21hc2s6MHg3NjNjLCB3aGljaCBpcyBjb25mdXNpbmcuIEZpeGVkIExFIHdvdWxk
IGJlIGJldHRlci4gIA0KVGhlIG92ZXJyaWRlX2RzbV9tYXNrIG1vZHVsZSBwYXJhbWV0ZXIgbmVl
ZHMgdG8gbWF0Y2guDQoNCmZhbWlseToNClRoaXMgaXMgYW4gaW50ZXJuYWwgdmFsdWUsIHNvIE5F
IGlzIGZpbmUuDQoNCg==
