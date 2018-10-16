Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F961C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D33A21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NrY9v+SJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BU4OAveP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D33A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJQCTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:19:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55978 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbeJQCTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:19:01 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9GIJx5U029572;
        Tue, 16 Oct 2018 11:24:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/k12idHZtLr1oSERykMa9KiuKmLbBWHvQoAyVPLA6kQ=;
 b=NrY9v+SJudBgeu222Wsx72mN6SZaS7IjwoVQrCDRirffZ7SiTyC+dPPlh2c6bGdXtRyS
 a16KvS/iOfAyfC4pa5l7vPsBSKOLs4NB64jRH6Qj7eWGUn0Nc7tV4fOLJx/vhdPL+T2w
 mPPXueN36iDO9FKmbJnsLTTD1WvGOv8nUZM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n5myp007j-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Oct 2018 11:24:45 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 16 Oct 2018 11:24:25 -0700
Received: from FRC-CHUB07.TheFacebook.com (2620:10d:c021:18::26) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 16 Oct 2018 11:24:25 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 16 Oct 2018 14:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k12idHZtLr1oSERykMa9KiuKmLbBWHvQoAyVPLA6kQ=;
 b=BU4OAvePBSwYSxl9YV0UwoeXkT++K5z5LsSnrkPdakVBQiG08gGU2ik8npaCo57eoB05axxAO/TZjecZPDjvxYQq7lgWUuiedDXBCDOAyVoOn8ZkJ/2cyf9Mn0Ypdbgju1eEUmaWYa3QmWKIlqbfoBAxi60dc5N9U2y/nFCTEdU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1502.namprd15.prod.outlook.com (10.173.235.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Tue, 16 Oct 2018 18:24:23 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%8]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 18:24:23 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "eranian@google.com" <eranian@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Thread-Topic: [RFC][PATCH] perf: Rewrite core context handling
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUZrRIAgAAbn4CAANwqgIAAu/qAgAF8bACABM0pAIAAcKMAgAAa34CAAAPyAA==
Date:   Tue, 16 Oct 2018 18:24:23 +0000
Message-ID: <2228A2BE-E34C-4D8D-9271-8EE8A5C83121@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
 <70079805-1CAE-4CAA-813A-F8DDB929F22B@fb.com>
 <20181012095001.GG9867@hirez.programming.kicks-ass.net>
 <E4F81A5E-C371-429D-AFEC-6F4B32971F09@fb.com>
 <20181016095056.GE4030@hirez.programming.kicks-ass.net>
 <9865C981-0E8C-4419-AE8C-638DCD40D74E@fb.com>
 <20181016181015.GD3121@hirez.programming.kicks-ass.net>
In-Reply-To: <20181016181015.GD3121@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::4:9180]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1502;20:tNnFEL7dEE6s/hTiC2b8IIAYiMye4RTQFaXXMRkCuQ9ODWJJCZk8oZ65AJtRtfIIkApvEnpAwR0zyVz9Kb5qBvPDXTDnMI6UnzDEg9HLQj7wWnCP/88hLNDJ9dGgp9xLwbNee1Z7Ia+ZkZoesMB3XHMVe5BP58iuJUWbk189+9I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9ed09b0b-033d-47a5-574b-08d6339498e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1502;
x-ms-traffictypediagnostic: MWHPR15MB1502:
x-microsoft-antispam-prvs: <MWHPR15MB1502157B762BA0C3EBB50BBFB3FE0@MWHPR15MB1502.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991070);SRVR:MWHPR15MB1502;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1502;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(396003)(376002)(199004)(189003)(5250100002)(82746002)(33656002)(6506007)(54906003)(57306001)(229853002)(186003)(2900100001)(105586002)(106356001)(14454004)(486006)(53546011)(2616005)(76176011)(71200400001)(71190400001)(7416002)(99286004)(446003)(11346002)(46003)(83716004)(86362001)(476003)(102836004)(5660300001)(4326008)(68736007)(53936002)(6436002)(81156014)(50226002)(81166006)(6486002)(6916009)(8676002)(8936002)(6512007)(7736002)(6116002)(305945005)(256004)(14444005)(2906002)(478600001)(93886005)(97736004)(6246003)(316002)(25786009)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1502;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d5YKKLzpxa16UJ0iKWZykS+Xwy5ogzDQ7sG4P+DLlnjAmRQhgteUozzrnuTgmSWswfxHUApeNGj4CLrqT58e+PXjf9NZ/HT07YYGjVBjB1pJ9WgnQZZF4VOf4odbqUbBhPBMkOIFURWyNwbIxcrOQGW2GYmKJs590yu5aXFQ2sit2amDTHDWeFxGZXbZhuKzCSFHK3zOHcT/FhA4GX56R2gmEKWR7U2lEd2GwGJzf2WyJJ5oJRCx91aZxuSQiceNJHZpPScxkiAbXsI9+B8Z+z/ohZTqf337ed1TFOlxO8yr/GJreAQ3dwsaemlCYzxgEXOYueDgZX7MiEVA+93UWraDiqh6nJR3pJkI3V01M2M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7A8EAC3E8E8574AA193BAED864DD514@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed09b0b-033d-47a5-574b-08d6339498e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 18:24:23.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1502
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 16, 2018, at 11:10 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Tue, Oct 16, 2018 at 04:34:05PM +0000, Song Liu wrote:
>>>> 3. perf_event_pmu_context owns RB tree of events. Since we don't=20
>>>>  need rotation across multiple hardware PMUs, the rotation is=20
>>>>  within same perf_event_pmu_context. =20
>>>=20
>>> By keeping the RB trees in perf_event_context, we get bigger trees,
>>> which is more efficient (log(n+m) < log(n) + log(m))
>>>=20
>>> Also, specifically, it means we only need a single merge sort /
>>> iteration to schedule in a full context, instead of (again) doing 'n' o=
f
>>> them.
>>>=20
>>> Also, given a context and a pmu, it is cheaper for finding the relevant
>>> events; this is needed for big.little for instance. Something the
>>> proposed patch doesn't fully flesh out.
>>=20
>> Would it be faster if we add a perf_event_pmu_context pointer to the=20
>> perf_event?=20
>=20
> +       pmu_ctx =3D find_get_pmu_context(pmu, ctx, event);
> +       if (IS_ERR(pmu_ctx)) {
> +               err =3D PTR_ERR(pmu_ctx);
> +               goto err_locked;
> +       }
> +       event->pmu_ctx =3D pmu_ctx;
>=20
> Like that?

Aha, we already have it. I misunderstood this one. Please ignore that.

Thanks,
Song
