Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32D9222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j0+nDEZI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f/Gg5HPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391797AbfBNRDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:03:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387465AbfBNRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:03:51 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1EH1S5b030428;
        Thu, 14 Feb 2019 09:03:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=h5JQnlqf35P+DmD3LRgadO9ncPtKCT41z+Oi2kowoSc=;
 b=j0+nDEZIysrZkgUgy4MnwBfaQ0GC2Mw5h7vbFRqNkeymwpY5wKq9SScwBGwjfpWS2MMD
 ikDbqNCMjI5pw9CsuBFxQUkiTenHB/uUOif1t57uYQF5ASIXnTTnI2Ke5gTYqEBpGC5E
 pok4bPkHjlqWl14qwF8u2W1mfUonkgSceuQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2qnan88cw3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 09:03:23 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 14 Feb 2019 09:03:06 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 14 Feb 2019 09:03:06 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 14 Feb 2019 09:03:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5JQnlqf35P+DmD3LRgadO9ncPtKCT41z+Oi2kowoSc=;
 b=f/Gg5HPiF6ZoAIn9V+Cr2XNk4ChjlPXuiA5ZY71i/0AhgVVAJJUnVhHe4rwCmHs2Cw0VwR2uBOImtOv8gqWE0gRL20TLXyDtW8jg1k+lApq2vqa5mRyGj/WkzsXXh4jEZTXic2d3nRhlTOMkIIcnWKyxxwwZ+Qd2SQliuCu/0rY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1152.namprd15.prod.outlook.com (10.175.2.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 17:03:03 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 17:03:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>
Subject: Re: [PATCH 5/9] perf, bpf: save bpf_prog_info in a rbtree in perf_env
Thread-Topic: [PATCH 5/9] perf, bpf: save bpf_prog_info in a rbtree in
 perf_env
Thread-Index: AQHUwBU1jGfep/2GK02JoCQpTe8pjaXfQrqAgABLZQA=
Date:   Thu, 14 Feb 2019 17:03:03 +0000
Message-ID: <2446DEFA-3CD3-4D3A-BE73-C29037F00C5C@fb.com>
References: <20190209011705.2160185-1-songliubraving@fb.com>
 <20190209011705.2160185-6-songliubraving@fb.com>
 <20190214123311.GA7465@krava>
In-Reply-To: <20190214123311.GA7465@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:dadd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5103c2ae-87f4-4df0-752e-08d6929e484a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1152;
x-ms-traffictypediagnostic: MWHPR15MB1152:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1152;20:+rNVm4xbaSzkyI10mZRWAt9/mnWlNJHtsca1fN4HGj2Jx/72mwq8DaGcGR5aj57BCIx057ufdR23QLwi6HA6HTn9l0GdzMExCufgeeBdntF/ihs1LbHlCK8hEi/wGnMHfYuEF+CzwBCITEif0I/D8q+x+IHRmc43bYgno6JhdsU=
x-microsoft-antispam-prvs: <MWHPR15MB1152EA7D06B4C665D3072092B3670@MWHPR15MB1152.namprd15.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(186003)(102836004)(229853002)(106356001)(68736007)(76176011)(2616005)(11346002)(6116002)(46003)(36756003)(8936002)(33656002)(446003)(105586002)(476003)(316002)(6916009)(83716004)(97736004)(54906003)(82746002)(25786009)(6506007)(86362001)(256004)(71200400001)(305945005)(6436002)(478600001)(2906002)(71190400001)(53546011)(53936002)(8676002)(6486002)(7736002)(57306001)(81166006)(6246003)(6512007)(486006)(14454004)(4326008)(81156014)(4744005)(99286004)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1152;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Z1bFb5Vh3L/rlc6H5Qxp4d5B+N/V39mP+RaV1F5mndayqnw9TPEV69qhSy8kHZtZSuLI3FhNiF+x5R7+H/5y15Kud59h4Ghfx4P9lBN/daGGqfe+kKvIugYaIvueYA0JFTAIBn4F7VhOZ6PFbudrE/calk0hX4n3W3pK8ktnwtsV7S69ivFfQDdVaN+YY13frfPrJRZ4VfA2lGhRNAePieKk5LvwfUJtPDriqNwDri/PEF6NR8zZdQbDPLrZCpFR44cLmRfI2rmVEDNGrMnFOjxCpDNc1OCS8AUr/zqeAgJHqoUBZGYuMF07YCjF31CPs9XgN/F75c9nJV3yPnYBn3Jvz5xux5FdnJe0ay8cwqeQnYLNkuSs8xYm7HDj89VKpnzcmMVgsnltGKqMTDeRKEcS1I1CGv9F1Q2PabI1XE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41A96F683E9E294C920421373B62FE6D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5103c2ae-87f4-4df0-752e-08d6929e484a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 17:03:03.2909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1152
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 14, 2019, at 4:33 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Feb 08, 2019 at 05:17:01PM -0800, Song Liu wrote:
>> bpf_prog_info contains information necessary to annotate bpf programs.
>> This patch saves bpf_prog_info for bpf programs loaded in the system.
>>=20
>> perf-record saves bpf_prog_info information as headers to perf.data.
>> A new header type HEADER_BPF_PROG_INFO is introduced for this data.
>=20
> please move those 2 changes into separate patches then

Do you mean one patch to save data in rbtree, then a separate patch=20
to save data in perf.data file?

Thanks,
Song

>=20
> it's hard to make comments when I don't see the rest of
> the patches on the list please resend the patchset
>=20
> thanks,
> jirka

