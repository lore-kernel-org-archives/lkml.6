Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3205EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBFD206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qGqOW3N4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MlIhiAtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfAGTSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:18:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43890 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbfAGTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:18:48 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x07JII7Z003673;
        Mon, 7 Jan 2019 11:18:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=h3oMA5zTDkrOOnfXjjDkrgWqsXLHcbFTu56KbeW1Nzw=;
 b=qGqOW3N4Cxs37Ep8AQbd04P9z9kosEreeG7Fbxf8u/fxXGLkABCrfzqFIaSL8GLdEZDR
 HjUb+UvSUrT5+gc0TOudIGva5CUTRtA1XfOsMbKpQjxjDXLKIk7Bem+XKs7VKJdoWU0L
 tKkxf1rOYdshzqv4/HJmDhfKg7XV9peNolU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pv9hmrun0-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Jan 2019 11:18:20 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 7 Jan 2019 11:18:07 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 7 Jan 2019 11:18:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3oMA5zTDkrOOnfXjjDkrgWqsXLHcbFTu56KbeW1Nzw=;
 b=MlIhiAtU1XIF3uMDku7etZkCbyMKpcvPugN2ULLKuo5QLYGeBYZ3wZ0dyfYnNh8hAsUY8X9xgO44wXbBjF8qmP1Qpc9gpBkGGVc4ic0+vfGiJWZ3f5CwaX+soTL1j3QmqXrAt0aGFkgkjQOGxc5RZa604RnK9wKHZiaQIZOj68E=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1656.namprd15.prod.outlook.com (10.175.120.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Mon, 7 Jan 2019 19:18:06 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d%10]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 19:18:06 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [Potential Spoof] Re: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc
 ctrl for Facebook
Thread-Topic: [Potential Spoof] Re: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc
 ctrl for Facebook
Thread-Index: AQHUpr23H6EDIEv7IECCwY4fHMoqwA==
Date:   Mon, 7 Jan 2019 19:18:06 +0000
Message-ID: <87110C25-B836-4DD0-813E-41745EB909FA@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:23a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1656;20:hIy3tVel4IF0y4U3b/1OmmaI+V8a1q/0C0xc6t269LhTXpPusYWIGc1Pdb41U1d2otipK/fhBHHiq7G7mqGzRmTUyzyDgj+a3CG18Lk5Rkw0o/Fsg5agGe/dP8kjuBL56m8Xxub3qdTDC/idK6CAFIGhm44cMmd0cqqh90TJYtU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 54ac6e2e-6c72-4dfd-5152-08d674d4da68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1656;
x-ms-traffictypediagnostic: CY4PR15MB1656:
x-microsoft-antispam-prvs: <CY4PR15MB1656CAC49DF0FE2135895700DD890@CY4PR15MB1656.namprd15.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(11241501185)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1656;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1656;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(136003)(366004)(47680400002)(43544003)(189003)(199004)(99286004)(4326008)(476003)(71190400001)(71200400001)(86362001)(106356001)(82746002)(478600001)(68736007)(83716004)(25786009)(5660300001)(53936002)(7736002)(229853002)(6246003)(6512007)(256004)(2501003)(6486002)(8936002)(8676002)(6436002)(81156014)(81166006)(14454004)(6506007)(186003)(102836004)(33656002)(46003)(2616005)(2906002)(305945005)(53546011)(2201001)(6116002)(97736004)(110136005)(486006)(105586002)(36756003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1656;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: byYdueZp8y4EzuRMkGcdFeqguaHP4YzmPJGbXi+cQoISkmqLQI66Zu9mg/z/QRAqeDXcoypU8du5jCfHEkk9DVOeZ8lTmIBq9tJBE+Q+ZQeIcgZt4eXO5vcLF3pmykDbuuykXLpBSwntwFVExhZxI17eW0JaZX6U2gDQpggKiphtkocInALOosZl+9oPSEcCyjOteYAUnpeLrXbUQtLcB6dVu9k3nXXEqPWTRtAGysXCPSR12GllVmaVtevLCDhXwjlK3LCT6HeRewG7Pkec2WTcYWJb/bQE8s4wJ/DHewvQO3Nu26w1dHYFMxpKuu0a
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3CF9BDE5A2E8D49A7A02831FC01959A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac6e2e-6c72-4dfd-5152-08d674d4da68
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 19:18:06.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1656
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIG1lcmdlIHRoZXNlIHBhdGNoZXMgaW4gdXBzdHJlYW0ga2VybmVsLg0KDQpSZWdhcmRz
DQotVmlqYXkNCg0K77u/T24gMTIvMjAvMTgsIDEwOjA2IEFNLCAiTGludXgtYXNwZWVkIG9uIGJl
aGFsZiBvZiBWaWpheSBLaGVta2EiIDxsaW51eC1hc3BlZWQtYm91bmNlcyt2aWpheWtoZW1rYT1m
Yi5jb21AbGlzdHMub3psYWJzLm9yZyBvbiBiZWhhbGYgb2YgdmlqYXlraGVta2FAZmIuY29tPiB3
cm90ZToNCg0KICAgIEpvZWwsIENhbiB5b3UgcGxlYXNlIHRha2UgY2FyZSBvZiB0aGVzZSBwYXRj
aGVzIG1lcmdlLg0KICAgIA0KICAgIE9uIDEyLzE3LzE4LCAxMjowNCBQTSwgIlZpamF5IEtoZW1r
YSIgPHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQogICAgDQogICAgICAgIEFkZGVkIGxwYyBj
dHJsIGRldmljZSB0byBlbmFibGUgTFBDIGNsb2NrIGluIEZhY2Vib29rDQogICAgICAgIFRpb2dh
cGFzcyBkZXZpY2UgdHJlZS4NCiAgICAgICAgDQogICAgICAgIFNpZ25lZC1vZmYtYnk6IFZpamF5
IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAgICAgICAtLS0NCiAgICAgICAgIC4uLi9i
b290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXRpb2dhcGFzcy5kdHMgIHwgMTcgKysrKysrKysr
KysrKysrKysNCiAgICAgICAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQogICAg
ICAgIA0KICAgICAgICBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1m
YWNlYm9vay10aW9nYXBhc3MuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNl
Ym9vay10aW9nYXBhc3MuZHRzDQogICAgICAgIGluZGV4IDczZTU4YTgyMTYxMy4uZWY3ODc1YjU0
NTYyIDEwMDY0NA0KICAgICAgICAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZh
Y2Vib29rLXRpb2dhcGFzcy5kdHMNCiAgICAgICAgKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNw
ZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQogICAgICAgIEBAIC0yMiw2ICsyMiwxNyBA
QA0KICAgICAgICAgCQlyZWcgPSA8MHg4MDAwMDAwMCAweDIwMDAwMDAwPjsNCiAgICAgICAgIAl9
Ow0KICAgICAgICAgDQogICAgICAgICsJcmVzZXJ2ZWQtbWVtb3J5IHsNCiAgICAgICAgKwkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQogICAgICAgICsJCSNzaXplLWNlbGxzID0gPDE+Ow0KICAgICAg
ICArCQlyYW5nZXM7DQogICAgICAgICsNCiAgICAgICAgKwkJZmxhc2hfbWVtb3J5OiByZWdpb25A
OTgwMDAwMDAgew0KICAgICAgICArCQkJbm8tbWFwOw0KICAgICAgICArCQkJcmVnID0gPDB4OTgw
MDAwMDAgMHgwMDAwMTAwMD47IC8qIDRLICovDQogICAgICAgICsJCX07DQogICAgICAgICsJfTsN
CiAgICAgICAgKw0KICAgICAgICAgCWlpby1od21vbiB7DQogICAgICAgICAJCWNvbXBhdGlibGUg
PSAiaWlvLWh3bW9uIjsNCiAgICAgICAgIAkJaW8tY2hhbm5lbHMgPSA8JmFkYyAwPiwgPCZhZGMg
MT4sIDwmYWRjIDI+LCA8JmFkYyAzPiwNCiAgICAgICAgQEAgLTU0LDYgKzY1LDEyIEBADQogICAg
ICAgICAJfTsNCiAgICAgICAgIH07DQogICAgICAgICANCiAgICAgICAgKyZscGNfY3RybCB7DQog
ICAgICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICAgICArCW1lbW9yeS1yZWdpb24gPSA8JmZs
YXNoX21lbW9yeT47DQogICAgICAgICsJZmxhc2ggPSA8JnNwaTE+Ow0KICAgICAgICArfTsNCiAg
ICAgICAgKw0KICAgICAgICAgJnVhcnQxIHsNCiAgICAgICAgIAkvLyBIb3N0IENvbnNvbGUNCiAg
ICAgICAgIAlzdGF0dXMgPSAib2theSI7DQogICAgICAgIC0tIA0KICAgICAgICAyLjE3LjENCiAg
ICAgICAgDQogICAgICAgIA0KICAgIA0KICAgIA0KDQo=
