Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469AD218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jYs5dm4o";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FuN8OPQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAYWqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:46:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45598 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfAYWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:46:34 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PMkA02005347;
        Fri, 25 Jan 2019 14:46:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0e548f/xM6yTxGVV5YO3j+3l/4KvbmR4LpDLlfY5B2U=;
 b=jYs5dm4o5rGB35p3ILKdCioq24tA/HvSG49fAWB0DemWI+3E8zgV96nEBZeq8VbCGfAu
 OjCEK/kOAcwsY2FY5qwZV6K0t43EhwF5XHZWpeU4jIojbT+VuBcmidvbNXbEIN/5QorB
 hsl6coOe2rqZC2u1vfNxdyR15zsQ+qljJRY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q8a8rr7n3-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Jan 2019 14:46:20 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 14:46:00 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 25 Jan 2019 14:46:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e548f/xM6yTxGVV5YO3j+3l/4KvbmR4LpDLlfY5B2U=;
 b=FuN8OPQ3QBicG0NVK8bPuCsd6Zgs2Ip/guk/9VM6vs5fNISXD/lHjhPM+bmM9wN500cm8yxqmQ390UmhsaSLp8SBnuLBIrUvNn8Gw4idTOEXH9uDRHA0JI4mHorGYQq+3y+aq+ZsQrfOEawM9DKUqrZgd4MjNzn1tDtcYm9ACBM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1903.namprd15.prod.outlook.com (10.174.100.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Fri, 25 Jan 2019 22:46:00 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 22:45:59 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: perf/x86/intel/uncore
Thread-Topic: perf/x86/intel/uncore
Thread-Index: AQHUtN9mTaQDMPjjHkuN91Z74fJpgaXAabGAgAACLQCAABYJAIAADcYAgAAFCgCAAAEEAA==
Date:   Fri, 25 Jan 2019 22:45:59 +0000
Message-ID: <FCF1C89B-A854-4C36-8FBC-7E7A19DA2676@fb.com>
References: <E44A3BE5-E45A-4D88-818C-02E6E6342060@fb.com>
 <2f74c906-6d13-ff18-f967-100e82343f2f@linux.intel.com>
 <5350E02A-6457-41A8-8F33-AF67BFDAEE3E@fb.com>
 <50e2eb5b-bb83-6219-d2d7-4ec832b9f5d5@linux.intel.com>
 <700FE2CF-4DA0-4B62-B0B0-A740014CD7B6@fb.com>
 <b2f5eaf7-066a-0492-a5fe-e4cc9b1161d0@linux.intel.com>
In-Reply-To: <b2f5eaf7-066a-0492-a5fe-e4cc9b1161d0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::5:4a6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1903;20:SBbuWTHolzCsoCP3iHoN6hugJ2ytbWIAEKCG+XUX1g1ZPPmenJrEjaLx7GfhVe8YNUl9OmywpQRTih7SUoEvzo93+9HlElqoBq+Btl5cTRRS9w3i98bApIOWgV2AcdrTmmpSVmy9+9nBsaDNg8STfT3qeXnkrwdtdUMqOETCVdc=
x-ms-office365-filtering-correlation-id: 4cf8b8b2-a132-4667-b498-08d68316e094
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1903;
x-ms-traffictypediagnostic: MWHPR15MB1903:
x-microsoft-antispam-prvs: <MWHPR15MB1903D4AA4BC40958FF173108B39B0@MWHPR15MB1903.namprd15.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(14454004)(97736004)(25786009)(99286004)(33656002)(102836004)(53546011)(6506007)(4326008)(478600001)(93886005)(36756003)(53936002)(6246003)(305945005)(57306001)(105586002)(446003)(186003)(316002)(476003)(7736002)(2616005)(2906002)(86362001)(6486002)(68736007)(8936002)(6436002)(106356001)(11346002)(4744005)(486006)(46003)(71190400001)(8676002)(50226002)(83716004)(81156014)(6512007)(81166006)(76176011)(82746002)(6116002)(6916009)(229853002)(256004)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1903;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 86kXpRwUWzRbpZlT6K2VOaPerpQMDsK04iJEH2pSPgVl/GeNese3ca4ehHkvgg8T+6P7HNip9VXa9K1RXJb1PWoQB+JD50zIqGdW0bW0dfj0OzUFqdZj9JYSZl798cIiXfPh3b6PLbNe5hz73pkHHCOWBQNFMiB1GTyI3E+s2qCumg/dh4JySVdxhtCmoRwNQy/Czo8YMirXGf8lSXMTf8HUyZno65ygax5oyjTXO4UIr4uxgbkGvZt+zJZczRgZrpqZHFnGZqX819Z61QVT/794SoNoQvDAWdA22S2qWYVAJ0MVsYk608O3VGE1Zd5q5gyqcIzL3cLwHJ5v0XPylL+J6UGDQ3cAwvrLh/x/auQ/yolYb91/xUpDETavtb3TxUWqG6Mt99AF7Hy4ghNaA4cqj7yNd67LaSHVci+VjVI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F066DD6737B2D5469B32264D311B34AA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf8b8b2-a132-4667-b498-08d68316e094
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 22:45:59.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1903
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 25, 2019, at 2:42 PM, Liang, Kan <kan.liang@linux.intel.com> wrote=
:
>=20
>=20
>=20
> On 1/25/2019 5:24 PM, Song Liu wrote:
>> I also noticed that uncore_pci_probe() returns at
>>         if (atomic_inc_return(&pmu->activeboxes) > 1)
>>                 return 0;
>> for bus 1-7. So we only probed bus 0 (socket 0). Is this expected behavi=
or?
>=20
> We probed all, but only need to register PMU once.
> It can be distinguished by cpumask. E.g. you may want to check "/sys/devi=
ces/uncore_imc_0/cpumask".
>=20
>=20
> Thanks,
> Kan

I see. That works:

[root@rtptest10787.snc1 /sys/bus/event_source/devices/uncore_imc_0]# cat cp=
umask
0,28,56,84,112,140,168,196

I think this solves all the problems.=20

Thanks again!
Song=
