Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC21C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22A21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bu1jbjdH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NxUcCoGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbfA3SDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:03:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727100AbfA3SDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:03:50 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UHu4D5008075;
        Wed, 30 Jan 2019 10:01:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=n9pGXSwzli54Ey+ugud3KlzFjKYSE+5ROFPNzsoBn3s=;
 b=bu1jbjdHE0iNkgSqGccTOuGDVu+UNt/D5xQ7r4Q2JJLQd/rbWsx3wJ1stBQnjCOTmjfu
 Sbztk1ibsVAj9Z4ZrzbRyI/hBcFLA/cXK8XK615oebqHyM5AO0fl6FGKTQiqGEcp19iI
 M4QarfZMO5JMnvin1EV0SeL1feM+nClKGY0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qbev9gfbw-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Jan 2019 10:01:25 -0800
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 30 Jan 2019 10:01:25 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 30 Jan 2019 10:01:24 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 30 Jan 2019 10:01:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9pGXSwzli54Ey+ugud3KlzFjKYSE+5ROFPNzsoBn3s=;
 b=NxUcCoGXJScuNNrL5uj2Y8s7zXN8bJcyaK+Ro/qy8jQwhlo3QnpfnVgvo3Ewa6edS2SU5uoOITbQz89V4YwWr+GiEVVJHAUhUjrpAVHedNDpqZic6bFVglzgaZmIJ5PumrTUgaao+1OhAOX9YF3RmO/K/U5H2kF4RYwJOQqShLI=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1158.namprd15.prod.outlook.com (10.172.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 18:01:23 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b9cb:6dd8:d8bf:45c6]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b9cb:6dd8:d8bf:45c6%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 18:01:23 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
Thread-Topic: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
Thread-Index: AQHUs3B0EbHO5x+TOEGVuHnYyNp6D6XHMHEAgABuKgA=
Date:   Wed, 30 Jan 2019 18:01:22 +0000
Message-ID: <B6DFDA82-F72C-4979-B988-05C292E61228@fb.com>
References: <20190123230733.1821501-1-vijaykhemka@fb.com>
 <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
In-Reply-To: <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:b38d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1158;20:G58b57xKUg4uLO7z5wuz7nRQcVhgPUHjE8X6hVPjgNfWav4/D1ZC99DytfC1YFqYW8DRwnYWugkZmWHubv+lq3MzxnYBn6bZCYb1z1glkV4wFD3zRxiIrnYLvSi3y7+h/ED3fFRnPQ455/hWCTPx63AGgC3R/c9PufaKchFMMKE=
x-ms-office365-filtering-correlation-id: db3f4cac-2581-43e0-325d-08d686dcf219
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1158;
x-ms-traffictypediagnostic: CY4PR15MB1158:
x-microsoft-antispam-prvs: <CY4PR15MB1158DD2D9DCAB0C81C8FEA39DD900@CY4PR15MB1158.namprd15.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(47680400002)(189003)(199004)(8936002)(54906003)(33656002)(11346002)(8676002)(486006)(186003)(2616005)(99286004)(446003)(82746002)(46003)(476003)(97736004)(36756003)(83716004)(71200400001)(68736007)(6486002)(71190400001)(81166006)(316002)(81156014)(6116002)(478600001)(2906002)(7736002)(4326008)(6246003)(305945005)(4744005)(25786009)(6512007)(86362001)(76176011)(6506007)(256004)(105586002)(229853002)(106356001)(6436002)(53936002)(102836004)(6916009)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1158;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lgLMxTA9pktZ8NSV5+T2ZXrWNtABVMW12DD5oyb4T0w7NQKdhgDwY8qmDkif6i+mRMuL50LGRzR3W/lDqMGblS4fQ2s7ZgfSwh900+lK4GdX+JUH5+AGL/Hc4Z+IUKYxeIRl0HvKX0B/k8vCXw4MrS3oqfkf+NL2JlYEZkT96ld1AYevF2wUn9y26qH3pw81169/04NeZ8TZbQwWWqWnUHlzLMi4H9Ck4aHB+6B6ZEoUU7SCxWM4l3Xxcq1wjpQ2Z6CVENmTVThma9u1GarN8DsRKCQmGaZlG3ziQJt3OG2xA6WTlk38SIwCBPIEssz8D7meDp+5/iIXk18MDiTbYtbEI1nFnousKiP5lWGCcMWbLNdqARu585n3eLdBehVeZG0y1W0izncM19R5TRntrrUz4SwCDOZsYKWreyGYGdo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B81C1623D3FD0743B3F483C07522169D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db3f4cac-2581-43e0-325d-08d686dcf219
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 18:01:23.0367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1158
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEvMjkvMTksIDc6MjcgUE0sICJKb2VsIFN0YW5sZXkiIDxqb2VsQGptcy5pZC5h
dT4gd3JvdGU6DQoNCiAgICBPbiBUaHUsIDI0IEphbiAyMDE5IGF0IDEwOjA3LCBWaWpheSBLaGVt
a2EgPHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQogICAgDQogICAgPiBpbmRleCA3M2U1OGE4
MjE2MTMuLmQ2MGRiYjAxOWY4MiAxMDA2NDQNCiAgICA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cw0KICAgID4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQogICAgDQogICAgPg0K
ICAgID4gKyZwZWNpMCB7DQogICAgPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICt9
Ow0KICAgIA0KICAgIEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSBhbiB1cHN0cmVhbSB0cmVlIHRoYXQg
Y29udGFpbnMgYSBub2RlIGNhbGxlZA0KICAgIHBlY2kwLiBUaGVyZWZvcmUgdGhpcyBkb2VzIG5v
dCBidWlsZC4NCiAgICANCiAgICBJIGhhdmUgZHJvcHBlZCB0aGlzIGh1bmsgZnJvbSB5b3VyIHBh
dGNoLiBQbGVhc2UgbWFrZSBzdXJlIHlvdSB0ZXN0DQogICAgYmVmb3JlIHNlbmRpbmcgcGF0Y2hl
cy4NClRoYW5rcyBKb2VsLCBJIHdpbGwgYmUgY2FyZWZ1bC4NCiAgICANCiAgICBDaGVlcnMsDQog
ICAgDQogICAgSm9lbA0KICAgIA0KDQo=
