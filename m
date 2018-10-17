Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EDBECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B76214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QtrYuAJk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="U+nBkOMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B76214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeJRAli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:41:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727018AbeJRAli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:41:38 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w9HGfu1a007558;
        Wed, 17 Oct 2018 09:44:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=p0XZihJvwASnZrhmWpHU0KQUfmITDtGW17trozH/G2Y=;
 b=QtrYuAJkCx3Pmk3ijWGD41AhNCS/zX723vKF7zZ5jh32otQnbYwVK5MP7vmm7fP1DBve
 +he1GJ0maIFSHT+J8km3mCHCciLB51Gy01dYzJD3ISayjqDCtUbIZMEmqKeLHWgeVp0p
 J113AQLqTbpx0f+xHqtn2SClIKM9m696IPg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2n65c9s0w1-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Oct 2018 09:44:34 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 17 Oct 2018 09:43:30 -0700
Received: from FRC-CHUB04.TheFacebook.com (2620:10d:c021:18::23) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 17 Oct 2018 09:43:30 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 17 Oct 2018 12:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0XZihJvwASnZrhmWpHU0KQUfmITDtGW17trozH/G2Y=;
 b=U+nBkOMFxcujkJ1lnIgh8x4auQh3miehMjRKb4Z+3g7GFCKQtmZCSxGXTM6oHTb6HcSl9N7wR9UXL830p6a/+EFMaAyGKJnxsZb8O6sceQs5ja2lzLKEO+XBvx02hm+FX0e1C6ghr7ymOq1KUlLiB3JmsrzEqiZfqsRnATsX8go=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1887.namprd15.prod.outlook.com (10.174.100.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 17 Oct 2018 16:43:27 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%8]) with mapi id 15.20.1228.027; Wed, 17 Oct 2018
 16:43:27 +0000
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
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUf754AgAATMgCAAOOBAIABVJuAgAEXCYCAAF4KAA==
Date:   Wed, 17 Oct 2018 16:43:27 +0000
Message-ID: <82000D4A-0A1B-4A8B-904C-24640215D2BD@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
 <AF0FCD08-E014-4D29-B023-EA780056DBB5@fb.com>
 <FE66AE20-9785-4CF7-8D8D-CF2A9C696923@fb.com>
 <20181017110651.GI3121@hirez.programming.kicks-ass.net>
In-Reply-To: <20181017110651.GI3121@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::5:7715]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1887;20:8owBrtETGAuNeR8rfH9egbRnoEC2990k6bmaoGFWjcgRVJtNKw56zAFll9QLCsNo05fi54mzVyllj3gvAeYrkw2cK7ADtpm4HwdOXpYDFAm3NMKnbA3emaqBTyz6y5iJdMMJqttkxueZs0KUGOogRK80oU6Ikl7w60dqQabWXiY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e5b1b3e5-e39b-4cec-976e-08d6344fa9e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1887;
x-ms-traffictypediagnostic: MWHPR15MB1887:
x-microsoft-antispam-prvs: <MWHPR15MB1887620294A8CC9B09A7F4D5B3FF0@MWHPR15MB1887.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1887;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1887;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(54906003)(6512007)(11346002)(6436002)(2900100001)(36756003)(83716004)(6486002)(50226002)(229853002)(256004)(14444005)(478600001)(4326008)(57306001)(2616005)(6916009)(46003)(86362001)(68736007)(5660300001)(476003)(25786009)(446003)(486006)(186003)(2906002)(97736004)(106356001)(6246003)(33656002)(7736002)(76176011)(71190400001)(305945005)(7416002)(71200400001)(102836004)(14454004)(6506007)(105586002)(53546011)(81156014)(82746002)(8676002)(81166006)(6116002)(53936002)(93886005)(316002)(8936002)(99286004)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1887;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6KwbHLlaU1jsdvi3kKLV6M7IHoHCG6zQizkJRIsTIJP7vToJhzFTUQI0h69k+fZZgpdobFSI10Yob58M9VZE3dcvaI7TsgZkl3vnwlBpefOKAZ9FWMOJgne6CaTYThbwY4vsCgs4RBSaqCaDlUx8hDTmFOjclhb+jPU4YOKdBrTJ5zpni2o1vqRC3EqaQ/7rzFnAa3+RSXZbPfthI6qjE/JJ5daCm8zyoMDRpYVZMH6Znh4x0u2HYnpzrNirKbUUVCgc09lqIQKHTb+pEsy+mDtK8aL6OCqw1BX9T/BYyfMYtbN8BN/mMtY9qIfaIIBh0q0Vx9xxzHHas6sH1mAgvZyt+cmJ2UhDt2L5ce/LcX0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33A2FAC3AA7BEC40B499662CEF2BC381@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b1b3e5-e39b-4cec-976e-08d6344fa9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 16:43:27.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2018, at 4:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Oct 16, 2018 at 06:28:10PM +0000, Song Liu wrote:
>>> How about this:=20
>>>=20
>>> 1. Keep multiple perf_cpu_context per CPU, just like before this patch.=
=20
>>>=20
>>> 2. For perf_event_context, add PMU as an order for the RB tree.=20
>>>=20
>>> 3. (hw) pmu->perf_cpu_context->ctx only has events for this PMU (and sw=
=20
>>>  events moved to this context).
>>>=20
>>> 4. task->perf_event_ctxp has events for all PMUs.=20
>>>=20
>>> With this path, we keep the existing perf_cpu_context/perf_event_contex=
t
>>> logic as-is, which I think is simp=10ler than the new logic (with extra
>>> *_pmu_context). And it should also solve the problem.=20
>>>=20
>>> Does this make sense? If this doesn't look too broken, I am happy to
>>> draft RFC for it.=20
>>>=20
>>=20
>> I am not sure whether you missed this one, or found it totally insane.=20
>> Could you please share your comments on it? My gut feeling is that this=
=20
>> would be a simpler patch to solve the problem (two hw PMUs). (It might=20
>> be less efficient though).=20
>=20
> Ah, sorry, somehow this email got lost.
>=20
> That makes task and cpu contexts wildly different, which will complicate
> matters I feel.
>=20

I think we only need different logic when adding events to the task/cpu=20
contexts. The ctx_sched_in() and ctx_sched_out() will need some extra
logic to filter out events that are not being scheduled (don't schedule
events on PMU-a when rotating PMU-b). This logic will be the same for=20
task and cpu context. The difference is, the CPU context will not have
such events, because we never added such event to CPU context.=20

Does this make sense? I could try draft a RFC to see how difficult it is.=20

Thanks,
Song=
