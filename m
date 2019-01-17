Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D270C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3042086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k9SiumpT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Kiz1OJBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfAQSxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:53:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44442 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbfAQSxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:53:51 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HIq77j025810;
        Thu, 17 Jan 2019 10:53:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=p3dj8iCtcfKAfEZCYa74jPml7n+suutwq/a0CXmvXes=;
 b=k9SiumpTYRy+ZUXbpigo1ru7NOHEOp1qHIl98EGd/WpB1PZvuJbVP4VEMHcYv1IzGM1b
 mG9pdmSH0GR1PLojY669P/NSfRzSypwUkCwWyqmBjp7wv0EyRROgdzoQ1oJ1O5P8ssDy
 kWw80SR53wDzVI9suijcLIGjqs4bpH5DnKQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q2v348q21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Jan 2019 10:53:35 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 17 Jan 2019 10:53:34 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 17 Jan 2019 10:53:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3dj8iCtcfKAfEZCYa74jPml7n+suutwq/a0CXmvXes=;
 b=Kiz1OJBHabbXyOGiFGqWukvnWBzdzZfr46V0Oiyt4YFCRkn0OCcn33yYjbZ2vgUOIbsSVklsTADhKyOyiclFMjjIgoIv0/PnStydqpk9lTwDq6Z7kD9+qpxM2SXul05tM4FiIMyRSjwNZ2Z8FYfFDZx+mvqQ/Y/NsFxxVNuWyZI=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1415.namprd15.prod.outlook.com (10.172.160.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Thu, 17 Jan 2019 18:53:32 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d%10]) with mapi id 15.20.1516.019; Thu, 17 Jan
 2019 18:53:32 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc ctrl for Facebook
Thread-Topic: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc ctrl for Facebook
Thread-Index: AQHUlkO6p1obtPptykC2AH1z2EHxEqWHapcAgCuHKgCAAId8gA==
Date:   Thu, 17 Jan 2019 18:53:32 +0000
Message-ID: <CA34CE5F-8AC4-425C-8A66-E79783F952CF@fb.com>
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
 <20181217200405.2904551-4-vijaykhemka@fb.com>
 <F23E6426-F6FE-4F10-A88A-D5862D5407B4@fb.com>
 <CACPK8Xfn_iNWe+iWash2MV2e+Uz_0mV9Hwz_PdgNzfYpmrLvcw@mail.gmail.com>
In-Reply-To: <CACPK8Xfn_iNWe+iWash2MV2e+Uz_0mV9Hwz_PdgNzfYpmrLvcw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:8f98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1415;20:GnPPVOPTHGcpkVZK2GyEeOhKtyGIuX+zIVIFAUcsr1s6JzX8/NXkViKMtHI/8b+JE1O2BEdnyiIYWCcv08+3wAp2AW1R5xsCQPvRAJ4d/lmliDDUBI9UjC+LiKrTLuYbvBXlWioCfb9SxzOlGhmnG5l5I2Jw0DEesSA8YE7kgXI=
x-ms-office365-filtering-correlation-id: db9899d4-50d4-4f1d-1d4a-08d67cad1419
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1415;
x-ms-traffictypediagnostic: CY4PR15MB1415:
x-microsoft-antispam-prvs: <CY4PR15MB14157842C6C9890FC93647DADD830@CY4PR15MB1415.namprd15.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(396003)(346002)(136003)(47680400002)(43544003)(199004)(189003)(83716004)(53936002)(6436002)(6506007)(53546011)(446003)(86362001)(8936002)(6486002)(97736004)(6246003)(305945005)(4744005)(76176011)(81166006)(81156014)(316002)(8676002)(106356001)(82746002)(102836004)(6916009)(71190400001)(229853002)(71200400001)(33656002)(14454004)(6512007)(7736002)(486006)(54906003)(6116002)(4326008)(186003)(68736007)(105586002)(478600001)(36756003)(256004)(14444005)(5660300001)(2906002)(93886005)(476003)(25786009)(46003)(99286004)(11346002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1415;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6+jS6mZVAOw8095FEv9yd4KosOO+rokoP6nmrVfKW+rSPP45T+xuDy7JTu+dJTNguVi8dKv4ETb+bSuR6T17cNGojxPf7OcYDiSBJiZjxoFwTummRrL+y7O0ima00rG4uOYxI/VGvOe0RnxEYuPJdoJVjrrdrpLVnX6dUejbfZfdS9l02dS1jM4uHxhhjdR/qD9uRaNe7hXd8oqOvo9eIcjPXDuvyPPuqNqaLSJmVmZwxp37323EqLwAOix1meDMCaSIk6C+bmLgK9tQmo3ExWfQg/cnMFSzYonNbizxJFJpmHJ1jDqNx0tl6/Uut/Zx4iiP+PPQ7AU3B/5iYSUT50ijAyg9sFmaZkCG2oz/y/QR7PR/vgQHUjzIHQJ+8ra+XTC8lDFgFOS7UrQhSPIahdWUAiPl0bBtB1g4gA72cPA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBB497FB0E44B540A55F6071F710C35C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db9899d4-50d4-4f1d-1d4a-08d67cad1419
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 18:53:32.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1415
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEvMTYvMTksIDY6NDkgUE0sICJKb2VsIFN0YW5sZXkiIDxqb2VsQGptcy5pZC5h
dT4gd3JvdGU6DQoNCiAgICBPbiBGcmksIDIxIERlYyAyMDE4IGF0IDA1OjA2LCBWaWpheSBLaGVt
a2EgPHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQogICAgPg0KICAgID4gT24gMTIvMTcvMTgs
IDEyOjA0IFBNLCAiVmlqYXkgS2hlbWthIiA8dmlqYXlraGVta2FAZmIuY29tPiB3cm90ZToNCiAg
ICA+DQogICAgPiAgICAgQWRkZWQgbHBjIGN0cmwgZGV2aWNlIHRvIGVuYWJsZSBMUEMgY2xvY2sg
aW4gRmFjZWJvb2sNCiAgICA+ICAgICBUaW9nYXBhc3MgZGV2aWNlIHRyZWUuDQogICAgPg0KICAg
ID4gICAgIFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0K
ICAgID4NCiAgICA+IEpvZWwsIENhbiB5b3UgcGxlYXNlIHRha2UgY2FyZSBvZiB0aGVzZSBwYXRj
aGVzIG1lcmdlLg0KICAgIA0KICAgIEkgZGlkIG5vdCBhcHBseSB0aGlzIG9uZSBhcyBJIHRoaW5r
IHRoZSBkZXNjcmlwdGlvbiB3aWxsIGNoYW5nZSBvbmNlDQogICAgd2UndmUgbWVyZ2VkIHlvdXIg
YXNwZWVkLWxwYy1jdHJsIHBhdGNoLg0KDQpZZXMgSSB3aWxsIHVwZGF0ZSBhbmQgc2VuZCBuZXcg
b25lLg0KICAgIA0KICAgIENoZWVycywNCiAgICANCiAgICBKb2VsDQogICAgDQoNCg==
