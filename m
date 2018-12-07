Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABB0C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8FF2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ja3peewy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="a+WqVVre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8FF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeLGVXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:23:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38852 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbeLGVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:23:04 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB7KxpfM008203;
        Fri, 7 Dec 2018 13:22:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qlgCOQjetaa7TmL1kRJpTqSSwq5WhOzfOpA8tLR0Nck=;
 b=Ja3peewyiwWDRP0cKTRFGHsvWmosIk6fNK2DA5dhncQN0WNszeL6CeQjLYMYW70s/PGc
 U5WeSBfMB8SiUmHtsViFPYHYJJgtkV4mPCoCDpel3aysO3litHmkr25zStCm9uP4zqte
 yM5iVSjgC/+AcX451VMdv2akMdRQdrXQZYo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p7xpngd15-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 07 Dec 2018 13:22:45 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 7 Dec 2018 13:22:18 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 7 Dec 2018 13:22:17 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 7 Dec 2018 13:22:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlgCOQjetaa7TmL1kRJpTqSSwq5WhOzfOpA8tLR0Nck=;
 b=a+WqVVreX3+uHbDr2RPHf6GAFrZPoQxPaNoZmuVLwvOgQqdNDwiEdIWyAH2sGytGzPjQ/gEeFRA8ZsW5QKiLdoSe60+ujXHU4focwnhYkmIkfpANxBQb8sMDyyvfzdJxcHB+voJkPA7glzF27m23RSbcqZkOe4rBJ8ehYGrvMm8=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1680.namprd15.prod.outlook.com (10.175.141.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 21:22:16 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::e41d:eb0b:4f66:3d71]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::e41d:eb0b:4f66:3d71%10]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 21:22:16 +0000
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
Thread-Index: AQHUW2On9LNQ+pmvkkW+1bSF6wxqO6UUS5aAgCzmeQCAAIgDgP//fJCAgDEge4CAAOhYgIAAUy8A
Date:   Fri, 7 Dec 2018 21:22:15 +0000
Message-ID: <B46CD44C-2A40-4074-BA89-E34ECF95CE36@fb.com>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
 <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
 <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
 <7284BEA6-FAE9-4293-94E0-FC29304AA36D@fb.com>
 <48A12A26-5AF0-483C-85D4-428F00038D7A@fb.com>
 <47d85e8e-bf01-11a7-9c02-6d934d911178@linaro.org>
In-Reply-To: <47d85e8e-bf01-11a7-9c02-6d934d911178@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.0.180812
x-originating-ip: [2620:10d:c090:200::6:8266]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1680;20:pIr/Dbjb01JGvkWiSpdaOTloHlGaHazGsSykOxCsMex8IJyNmTuLXDjo/PYHvqOo6JsAg8xIom3EIKZc/x0SLshMMnAXUZDUpGeFtcRXWAPdCUQg6ZU1ArZp62ZJb1zd0H8EO7ZfM3Xg8aUQl6MDNb4io+HnD0pZpIisqL8WYCU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7a7e3cf0-f25e-489d-068c-08d65c8a0fd8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1680;
x-ms-traffictypediagnostic: MWHPR15MB1680:
x-microsoft-antispam-prvs: <MWHPR15MB16805318493E9F391C84CCB2B2AA0@MWHPR15MB1680.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(11241501185)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1680;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1680;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(446003)(11346002)(2616005)(476003)(14454004)(25786009)(4326008)(486006)(8676002)(58126008)(82746002)(6436002)(316002)(110136005)(53546011)(102836004)(53936002)(6506007)(186003)(39060400002)(6512007)(93886005)(33656002)(46003)(6246003)(99286004)(229853002)(8936002)(478600001)(6486002)(54906003)(36756003)(81166006)(81156014)(76176011)(83716004)(345774005)(71200400001)(71190400001)(68736007)(86362001)(305945005)(97736004)(14444005)(256004)(7736002)(2906002)(6116002)(106356001)(105586002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1680;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G18cbaCZYKUZES0tqlcvA0tG6om5A1ZEJBWbUGfKLcDhEmorHkvHHTdTvfuCmKASD0Suv7NxGfRHl2voBDD1R1Uoi1u5sIMNExZ5bHtoH2MOBalOq77x8Ams1ww18vOMvphs4sDcVDuQ13lC1gfykx/Z9oFfo7JV2vIZXHhJf3CPdd2EDUH21ibSP9dg+bnaqXrjvZMrncgbpcS0UPq0QrONQUUuAjxdSHInyM1ZlMf4DV3gfLtmAn1Qy9BUl9kEoRNj2yOXKmFp0gNWzRRbrKI0qDls9WpxQTjmniidjHGB2PxK2z7kUAGfIVd9rGWP9dXaoZ/Zp/pl8OgPtFh2U8/mdTCRcLuvzQ+l1lFkEXE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <291826BA32E2E04B8B80222DBB858EB4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e3cf0-f25e-489d-068c-08d65c8a0fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 21:22:15.8860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1680
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-07_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvNi8xOCwgMTE6MDQgUE0sICJEYW5pZWwgTGV6Y2FubyIgPGRhbmllbC5sZXpjYW5vQGxp
bmFyby5vcmc+IHdyb3RlOg0KPg0KPiBPbiAwNy8xMi8yMDE4IDAyOjEzLCBUYW8gUmVuIHdyb3Rl
Og0KPj4gTm90IHN1cmUgaWYgSSBtaXNzZWQgYW55IGVtYWlscyBmcm9tIHlvdSwgYnV0IGxvb2tz
IGxpa2UgdGhlIHBhdGNoIGlzIG5vdCBpbmNsdWRlZCBpbiB5b3VyIHRyZWU/IEFyZSB3ZSBwbGFu
bmluZyB0byBpbmNsdWRlIHRoZSBwYXRjaCBpbiA0LjIxIG1lcmdlIHdpbmRvdz8NCj4NCj4gWWVz
LCBJIGhhdmUgaXQgaW4gdGhlIHRyZWUuIEkgdXBkYXRlZCB0aGUgbmV4dCBicmFuY2guDQoNCkdv
dCBpdC4gVGhhbmsgeW91IGZvciB0aGUgY29uZmlybWF0aW9uLCBEYW5pZWwuDQoNClRoYW5rcywN
ClRhbyBSZW4NCg0K
