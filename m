Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3533720850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dKqc7zp3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="d33js0Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3533720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeLGBOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:14:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32774 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbeLGBNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:13:23 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB715Rh4018438;
        Thu, 6 Dec 2018 17:13:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=K8KihOQ47gB4D1VU7CENQPL7BJSBhEblUvkf0rbzpVc=;
 b=dKqc7zp3UnugBxBdwNIQYFs4F8Lzttt/qeFXArlj51UlA1L99eV+bOfdOZSTro4QJznV
 PNGswHVWLjwRWdQT0hdN9DLGZkIRrlVjP5jx87/RPh1jbG8Z2iVEg1ea7aK3T2v21k1I
 16AhXAySjwNw0m0ZyH3Shul0saDFlSROsR8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p7d2y0bmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Dec 2018 17:13:07 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 6 Dec 2018 17:13:07 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 6 Dec 2018 17:13:06 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 6 Dec 2018 17:13:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8KihOQ47gB4D1VU7CENQPL7BJSBhEblUvkf0rbzpVc=;
 b=d33js0RlZCksZlncXUvCaNqPsP+KWTlOrhbERN5sCAc8JCjndbZB2egAP1tbPFIrVwjlLgNVFEHrYrQ054K1ZMlIFbsXnz5mVIr+AyTdcyDZ1Xdg9aHsmUTCj8ejVdcYWr99wsreufGFKzKK7FOdqAIbDNx8y2w/xeTfTD2DwxY=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1645.namprd15.prod.outlook.com (10.175.135.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 01:13:04 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::e41d:eb0b:4f66:3d71]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::e41d:eb0b:4f66:3d71%10]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 01:13:04 +0000
From:   Tao Ren <taoren@fb.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Topic: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Index: AQHUW2On9LNQ+pmvkkW+1bSF6wxqO6UUS5aAgCzmeQCAAIgDgP//fJCAgDEge4A=
Date:   Fri, 7 Dec 2018 01:13:04 +0000
Message-ID: <48A12A26-5AF0-483C-85D4-428F00038D7A@fb.com>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
 <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
 <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
 <7284BEA6-FAE9-4293-94E0-FC29304AA36D@fb.com>
In-Reply-To: <7284BEA6-FAE9-4293-94E0-FC29304AA36D@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.0.180812
x-originating-ip: [2620:10d:c090:180::1:2d25]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1645;20:PnZnlMqj2FO+OY7q2KwLWy0/5IXRKU67Wy3MCKdMWySEtqcjxHlMdjRk0KKjyTGhuYWjn2ZgNbReOnAN+5LIcSwdpJbA+EUKRbhRhoq0Liz2YvO3EW6tWlrlamWuLlTaBP3J8hb9e+sWWqdM22agpMrGnS819ue5J8Nai1ComP8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 34a73710-b7e5-4d5f-e872-08d65be123f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1645;
x-ms-traffictypediagnostic: MWHPR15MB1645:
x-microsoft-antispam-prvs: <MWHPR15MB16455977F848BD2E3CAB5563B2AA0@MWHPR15MB1645.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(11241501185)(944501520)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1645;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1645;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(33656002)(25786009)(316002)(93886005)(58126008)(105586002)(46003)(36756003)(110136005)(54906003)(97736004)(99286004)(71200400001)(6506007)(486006)(2616005)(68736007)(476003)(11346002)(256004)(446003)(229853002)(6486002)(76176011)(14444005)(4326008)(53936002)(6246003)(6512007)(39060400002)(82746002)(53546011)(14454004)(305945005)(81156014)(86362001)(7736002)(106356001)(186003)(8936002)(5660300001)(102836004)(81166006)(6116002)(6436002)(2906002)(478600001)(83716004)(71190400001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1645;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1JuRQWuE118TkSeWEr6GKZVj55trE7A1ivKSezokEBotBAi/mjISws7U1K7r6dq1pTqA4vP/roYoeea2pRno4Dq/IPi46GIrPMyEmg2lnHFe0k0RdkVKFeFu4EsooYjeh5aAIIDhovQVkAKfuCc6YAd1LNd07+0wDpXSLail2QXKpJCkKEWywzKIn3wDMljRsFLn3DomlXfToWQfjL7OZRg3JuFnWrRSsrqx7KLeoOCku72bo8gQXzfpnWyZ8Lusw2tbrSaZ6fDqMlgfGsQ+0DprkBhpUSmtr+WWGvR88/CVDz6yaEfayqr9BJVJOXYHk/irOnbr4V6lIWm1J5HDNA9cb4TBKAuyrLQQ748ixxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F4E3366782902439F7D1328853FC331@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a73710-b7e5-4d5f-e872-08d65be123f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 01:13:04.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1645
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNS8xOCwgMTE6MDAgQU0sICJUYW8gUmVuIiA8dGFvcmVuQGZiLmNvbT4gd3JvdGU6DQoN
Cj4gT24gMTEvNS8xOCwgMTA6NTEgQU0sICJEYW5pZWwgTGV6Y2FubyIgPGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc+IHdyb3RlOg0KPj4gT2ggcmlnaHQsIHNvcnJ5LiBTaG91bGQgaXQgZ28gdG8g
c3RhYmxlIGFsc28gPyBJcyB0aGVyZSBhIEZpeGVzIHRhZyBpdCBjYW4gYXBwbHkgPw0KPj4NCj4g
UGVyc29uYWxseSBJIGRvbid0IHRoaW5rIGl0IG5lZWRzIHRvIGdvIHRvIHN0YWJsZSwgYmVjYXVz
ZSBJIGRvbid0IHNlZSBhbnkgZnVuY3Rpb25hbCBmYWlsdXJlcyBjYXVzZWQgYnkgdGhpcyBpbnZh
bGlkIHJlZ2lzdGVyIGFjY2Vzcy4NCg0KSGkgRGFuaWVsLA0KDQpOb3Qgc3VyZSBpZiBJIG1pc3Nl
ZCBhbnkgZW1haWxzIGZyb20geW91LCBidXQgbG9va3MgbGlrZSB0aGUgcGF0Y2ggaXMgbm90IGlu
Y2x1ZGVkIGluIHlvdXIgdHJlZT8gQXJlIHdlIHBsYW5uaW5nIHRvIGluY2x1ZGUgdGhlIHBhdGNo
IGluIDQuMjEgbWVyZ2Ugd2luZG93Pw0KDQpUaGFua3MsDQoNClRhbyBSZW4NCg0K
