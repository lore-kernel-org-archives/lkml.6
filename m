Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC229C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D2F204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PdAFoWQ6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="b1s0zErh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D2F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJQA0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:26:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbeJQA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:26:30 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9GGWKD9026879;
        Tue, 16 Oct 2018 09:34:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WTallpRffM3mz1Fl4qeyuyq9b38p0KLJOQJWGATCGs4=;
 b=PdAFoWQ6BTte3D27xBv8cC/DhGWBSM29BWkRdXPxunFwV64J/8vM7tn0tm21dq4B7Jgn
 Dohy48TJrgNNGi6Dbi6MCtwSFSaNr9qaQI/4NsWF//bgIzKD9ol/d7Ad1JIW1V+Z8waj
 8ocLEcY1apND/8ILds1BN4FpYBOT25ZhRVc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n5j1cgevr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Oct 2018 09:34:41 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 16 Oct 2018 09:34:08 -0700
Received: from PRN-CHUB03.TheFacebook.com (2620:10d:c081:35::12) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 16 Oct 2018 09:34:08 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 16 Oct 2018 09:34:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTallpRffM3mz1Fl4qeyuyq9b38p0KLJOQJWGATCGs4=;
 b=b1s0zErhHNUIbouSUNN1Zw1GIGMgbA9SK3zE91e9JxoinjChzEJRHempsrws2vlxy8/ifRO5/4BtWFMVu5a0VXh5yyt3c1Ro6JLXCUUZ1Pr09e7TKjWKQtK/5drb2jJ5M09FPqCMu902DujrxBv/PlJt/+l4PdWNaEt1pI3srAA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1296.namprd15.prod.outlook.com (10.175.3.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Tue, 16 Oct 2018 16:34:05 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%8]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 16:34:05 +0000
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
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUZrRIAgAAbn4CAANwqgIAAu/qAgAF8bACABM0pAIAAcKMA
Date:   Tue, 16 Oct 2018 16:34:05 +0000
Message-ID: <9865C981-0E8C-4419-AE8C-638DCD40D74E@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
 <70079805-1CAE-4CAA-813A-F8DDB929F22B@fb.com>
 <20181012095001.GG9867@hirez.programming.kicks-ass.net>
 <E4F81A5E-C371-429D-AFEC-6F4B32971F09@fb.com>
 <20181016095056.GE4030@hirez.programming.kicks-ass.net>
In-Reply-To: <20181016095056.GE4030@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::4:9180]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1296;20:3H8H8JMVosprlbJ35acb0MJdQ9DGSHAuw9MoTCBuZ1xHMuNknkmJx8dnSmj/Sf7f7zlKHx+rhgf0iwipMrC9vOosceDvOujHsfz+BkhBVQJBbUOOzO1StYXwJK2rjStN/zktPuquTK00HC6MmErki2JpKNiiQkdNPCN8gLsbj7I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6a0208e4-863f-4453-ab06-08d633853088
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1296;
x-ms-traffictypediagnostic: MWHPR15MB1296:
x-microsoft-antispam-prvs: <MWHPR15MB12962CC04FA1200A0CCF9B0EB3FE0@MWHPR15MB1296.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(11241501184)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:MWHPR15MB1296;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1296;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(86362001)(478600001)(5250100002)(6246003)(2900100001)(99286004)(76176011)(316002)(486006)(14454004)(8676002)(7416002)(97736004)(81156014)(6506007)(81166006)(53936002)(93886005)(54906003)(8936002)(33656002)(7736002)(57306001)(256004)(305945005)(102836004)(4326008)(6116002)(186003)(50226002)(46003)(106356001)(71200400001)(53546011)(2906002)(6486002)(6512007)(82746002)(105586002)(476003)(2616005)(25786009)(11346002)(5660300001)(83716004)(71190400001)(6916009)(229853002)(68736007)(36756003)(6436002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1296;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8o7oVDqFbxVz16nadR/u1oT6hFaK8dagWJI7cE2iUW5vknwJplVVTos5JREvU8Cg8TWyqz3yc0owAUsKtOmOyebPVTOn9qaTI2PWsQcwKvHM6PM8uj15ocbMyM1mpYwGFS62PckQJo0WU9Q1MZZD/4zgUKtbDP605uy7RXiiic4nuBrOPpQchvD1lyZC5Va6+ZhO8Im9x2zmXCbEWh5AA4U+7au7AsqkoWQ3XzaJhmGGsmKrdyt3vkvNtRtRN44lx7F8oIZWhGHSZI3x6h7F9BgR3+HsM/vGYM0/v2JtRmuX75ZwF5UEdsq4rVDE3NwYOSlJaERyRtJTbxXPTd21oW4mG0IBDDBeMxTZDUnBnMQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A641A2C667C2B14EAFBB00E70A52D4DE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0208e4-863f-4453-ab06-08d633853088
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 16:34:05.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1296
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 16, 2018, at 2:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Sat, Oct 13, 2018 at 08:31:37AM +0000, Song Liu wrote:
>=20
>> The only suggestion I have right now is on which struct owns which
>> data:
>>=20
>> 1. perf_cpu_context owns two perf_event_context: ctx and *task_ctx.=20
>>   This is the same as right now.=20
>=20
>> 2. perf_event_context owns multiple perf_event_pmu_context:=20
>>   One perf_event_pmu_context for software groups;
>>   One perf_event_pmu_context for each hardware PMU.
>=20
> It does now already, right? Through the pmu_ctx_list we can, given an
> perf_event_context, find all associated perf_event_pmu_context's.

Yes, this is very similar to right now. It is related to #4, #5 below.=20
With current patch, perf_cpu_pmu_context is more like the "owner" of
the per CPU perf_event_pmu_context. I feel it is more natural that=20
perf_cpu_context is the owner of perf_event_pmu_context, while the
perf_cpu_pmu_context doesn't own anything.=20

Again, the difference to current patch is very small.=20

>=20
>> 3. perf_event_pmu_context owns RB tree of events. Since we don't=20
>>   need rotation across multiple hardware PMUs, the rotation is=20
>>   within same perf_event_pmu_context. =20
>=20
> By keeping the RB trees in perf_event_context, we get bigger trees,
> which is more efficient (log(n+m) < log(n) + log(m))
>=20
> Also, specifically, it means we only need a single merge sort /
> iteration to schedule in a full context, instead of (again) doing 'n' of
> them.
>=20
> Also, given a context and a pmu, it is cheaper for finding the relevant
> events; this is needed for big.little for instance. Something the
> proposed patch doesn't fully flesh out.

Would it be faster if we add a perf_event_pmu_context pointer to the=20
perf_event? I think a group on hw PMU-a should never know a group on
hw PMU-b. So some separation would make things simpler.=20

Thanks,
Song
