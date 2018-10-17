Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0501DECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A916F2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZqjgepPs";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Xgzi/kYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A916F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeJRCzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:55:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbeJRCzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:55:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9HIoor1006374;
        Wed, 17 Oct 2018 11:57:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HXhRIXiQzjyF/7lvK56Fv8lMPfW0tQHjKedBOgO2iJA=;
 b=ZqjgepPsqTjMcyCBX0LA9mdSY+Cpc4YYSDlbibUSq+S9T/dTM5+GvVKlKk4+VDKIgWkS
 eAXrY1xfPsTRTUjCQPOVZtyCjnZIdPwQoRrVtJEaY1JDOgNtgvEX/FjcmYmRsLZb0Iw+
 8zfCltUibMdVxTf2LWAhT7+F9Jmp7QY/O4g= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n67yfgr0b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Oct 2018 11:57:29 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 17 Oct 2018 11:57:27 -0700
Received: from FRC-CHUB05.TheFacebook.com (2620:10d:c021:18::24) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 17 Oct 2018 11:57:27 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 17 Oct 2018 14:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXhRIXiQzjyF/7lvK56Fv8lMPfW0tQHjKedBOgO2iJA=;
 b=Xgzi/kYZIKwfkcz76xz+Y68+1hNYfrSJuuMSC6m797sJjdf5Dq/JMLq2v5FXJGIDJIivsdD4A05pXRuJp7YiDQJiCmAnwFW4YiOM/9kAaysQZNqNLlAG6GxHw9FfCGHBXMOzk48yxdmXw+AcJC0J1Jj0d+IRIi2WW/0DVfhibpk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1198.namprd15.prod.outlook.com (10.175.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Wed, 17 Oct 2018 18:57:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%8]) with mapi id 15.20.1228.027; Wed, 17 Oct 2018
 18:57:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Thread-Topic: [RFC][PATCH] perf: Rewrite core context handling
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUf754AgAATMgCAAOOBAIABVJuAgAEXCYCAAF4KAIAACjKAgAAUdwCAAAbFAA==
Date:   Wed, 17 Oct 2018 18:57:25 +0000
Message-ID: <26D16201-2CEE-4D4A-B2FD-8F472B48A273@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
 <AF0FCD08-E014-4D29-B023-EA780056DBB5@fb.com>
 <FE66AE20-9785-4CF7-8D8D-CF2A9C696923@fb.com>
 <20181017110651.GI3121@hirez.programming.kicks-ass.net>
 <82000D4A-0A1B-4A8B-904C-24640215D2BD@fb.com>
 <20181017171955.GQ3121@hirez.programming.kicks-ass.net>
 <20181017183310.GB2603@hirez.programming.kicks-ass.net>
In-Reply-To: <20181017183310.GB2603@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::5:7715]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1198;20:klJCxZ9GIxSrgCtOIAn+qTQP86u1YY2k8V570VAOxezYMKfagEbuAGu2RvS5cIM1iI9epQXptYSV2XpyA/0xfVSVV6CLF38vw9QubJbysyc760vwqWCuBUHwevfjp9WeROy7+xMxAOz3nrZw/pi1Eco6om56tiC6+jG4iY0dJr0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8c639f59-03ff-4e3d-cf3d-08d6346260cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1198;
x-ms-traffictypediagnostic: MWHPR15MB1198:
x-microsoft-antispam-prvs: <MWHPR15MB119886D61FBC7BB6977C5E67B3FF0@MWHPR15MB1198.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1198;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1198;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(6916009)(46003)(82746002)(2900100001)(186003)(50226002)(6346003)(36756003)(76176011)(446003)(11346002)(33656002)(476003)(7416002)(81156014)(2616005)(102836004)(5660300001)(81166006)(8676002)(6506007)(53546011)(486006)(6116002)(6486002)(8936002)(229853002)(99286004)(6436002)(305945005)(105586002)(106356001)(7736002)(54906003)(53936002)(57306001)(83716004)(71200400001)(68736007)(71190400001)(6512007)(14454004)(316002)(93886005)(256004)(478600001)(97736004)(6246003)(86362001)(2906002)(5250100002)(25786009)(14444005)(5024004)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1198;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HTFBms2xSBZx5hK3EakzApnF+tgcOMVlwLdaL3aXyJKA9Ff74UNJIjkrmsVFdfjAy0ZMtirEWBt4qRF9UxgCuN2I9QZaG4emHr3Pw+6u4Eq9tcxZT5PWGMnXp5yjynAvDR6D4PedAekbYXMAh764WtEqFWVOAaEAtqf1P0XBmhCRpbmvd4o0W3LZtb2ldbW0vI5ChOPkkU4mh/xl/ObEBKs5q260AsxKwphyTd8JoxznKbQdhwG2bSw32IsC64PO8dHZq3I8cKShf9nbD7Z1kfwO4sppKnCVZVLRkeIG6C5dmzDg/e7QU1rkxSwaaH2diswjszDdXtY/EB7+nbLtOW/mA28FCSRp4BUD07Vk59g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E748E1C605DD684AB35C3A4276BF477C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c639f59-03ff-4e3d-cf3d-08d6346260cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 18:57:25.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1198
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2018, at 11:33 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Wed, Oct 17, 2018 at 07:19:55PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 17, 2018 at 04:43:27PM +0000, Song Liu wrote:
>>=20
>>>> That makes task and cpu contexts wildly different, which will complica=
te
>>>> matters I feel.
>>>>=20
>>>=20
>>> I think we only need different logic when adding events to the task/cpu=
=20
>>> contexts. The ctx_sched_in() and ctx_sched_out() will need some extra
>>> logic to filter out events that are not being scheduled (don't schedule
>>> events on PMU-a when rotating PMU-b). This logic will be the same for=20
>>> task and cpu context. The difference is, the CPU context will not have
>>> such events, because we never added such event to CPU context.=20
>>>=20
>>> Does this make sense? I could try draft a RFC to see how difficult it i=
s.=20
>>=20
>> I'm not sure it saves much, if we have multiple per-cpu contexts we get
>> to re-introduce the active_ctx_list and loose the simplification for the
>> online status.
>>=20
>> Plus that fundamental assymetry -- which would bother my OCD forever
>> more :-)
>=20
> Worse, the whole syscall that installs the events will come apart. The
> locking for the two cases is different :/

I agree... I didn't get into details of locking. I just consider these all
as part of "adding event to context".=20

I believe this patch should give close to the optimal performance. However,=
=20
I do feel it makes the logic more complicate. Before this patch, perf_cpu_c=
ontext
and perf_event_context don't need to know much about multiple PMUs. With
this patch, the two extra *_pmu_context are necessary for performance (and
maybe also for correctness).=20

If we take first a baby step, how about adding more perf_event_ctx to=20
task_struct->perf_event_ctxp? We need one sw perf_event_ctx and a few hw=20
perf_event_ctx (one for each hw PMU). (I haven't checked whether it is OK
to allocate these when attaching events). (And I guess you don't really=20
like this..)

On the other hand, this patch makes it possible to create groups of events
from different hw PMUs. I guess that will be useful.=20

Thanks,
Song=
