Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26E8C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7390A21470
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qzD50RKJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QwkUVxz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7390A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJMQI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:08:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34204 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbeJMQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:08:59 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9D8Uh6J015486;
        Sat, 13 Oct 2018 01:32:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1C9j3Ilix00BUfHun6uNIoDq4LVBtT1OmTh51lBey48=;
 b=qzD50RKJPc+nyR5u2VdnH63AozwHnzScgCQ0w4zn+oS7h5DoXJuyGHujFa1MLhsXMO4c
 Yx+Jv4OdZ7ES0v4tWOMqGva6xrk4Zhhvx+Fbg23yAThlnGNnGlUiGbCRcAyX2TVPtu0N
 sC4MpJ1uOPY2EdesD6E3W/Huc1Z0v0stTOY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n3485937d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 13 Oct 2018 01:32:02 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Sat, 13 Oct 2018 01:31:59 -0700
Received: from FRC-CHUB12.TheFacebook.com (2620:10d:c021:18::31) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Sat, 13 Oct 2018 01:31:59 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Sat, 13 Oct 2018 04:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C9j3Ilix00BUfHun6uNIoDq4LVBtT1OmTh51lBey48=;
 b=QwkUVxz6KlfhFuTVw5vpWz4kA1cRs6UhTRMz1h3Uwl0Z2uoBTeKqBW6U9uWuKU5Iha9I8r52GRGZ9RmLSNewLKfqYaT9MeUHtWEMWJYgKmzwnuFBClPOvyRMp3qDPDwS0qk26KB0wzhTtPtKJGr46ki9H0S9MXAcozLBZ/OSTE4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1406.namprd15.prod.outlook.com (10.173.234.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Sat, 13 Oct 2018 08:31:37 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%8]) with mapi id 15.20.1228.020; Sat, 13 Oct 2018
 08:31:37 +0000
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
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUZrRIAgAAbn4CAANwqgIAAu/qAgAF8bAA=
Date:   Sat, 13 Oct 2018 08:31:37 +0000
Message-ID: <E4F81A5E-C371-429D-AFEC-6F4B32971F09@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
 <70079805-1CAE-4CAA-813A-F8DDB929F22B@fb.com>
 <20181012095001.GG9867@hirez.programming.kicks-ass.net>
In-Reply-To: <20181012095001.GG9867@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:180::1:32c9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1406;20:RWZ8ZNlVC2B6TpLV4psb8htXVSwPJ8VRTjCCTyYEUaE1ot0USd4onZ/XjtTVRdxbLa5MSawoet4oUPGsTbdNXdf6b/ShCQB+o0w6w4zXiaeVLZuOSLGEpRhv3U/whWf5Zl/Fo8h+cFbigT6xPVBVbyHK2HD59I+NG1rC24I5D1s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c503643c-be53-4ca3-9396-08d630e64adb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1406;
x-ms-traffictypediagnostic: MWHPR15MB1406:
x-microsoft-antispam-prvs: <MWHPR15MB1406FDB788142D0A62DD8777B3E30@MWHPR15MB1406.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:MWHPR15MB1406;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1406;
x-forefront-prvs: 082465FB26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(102836004)(106356001)(53936002)(186003)(6506007)(76176011)(53546011)(7736002)(6436002)(478600001)(57306001)(6486002)(6116002)(86362001)(36756003)(4326008)(25786009)(97736004)(5660300001)(105586002)(54906003)(6512007)(5250100002)(99286004)(68736007)(46003)(71190400001)(71200400001)(7416002)(93886005)(83716004)(229853002)(2616005)(82746002)(81166006)(81156014)(50226002)(316002)(486006)(2906002)(6916009)(476003)(11346002)(256004)(14444005)(2900100001)(8936002)(305945005)(446003)(14454004)(6246003)(8676002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1406;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6Y2zFMdue/dplpO7ePV7psGzaPg14JHP/KchAQ8MnQxRFe7O7iWojcRQ4yC3aInthNAg9t9wvOwW6HkHrOKg9Yb+KnUWmYNKnVnNtwIFCo+XMSUs/VwK0SuGA9/X2YsArfVozCbNOqkQjwuek9NlMdQlmrSWjPlJw/5JOK95guylQEx7ho+AriaSy+/oDcsZKZEBlIdHiDl5Jk793H+/o3uBpTjJvalQnN7sNc8CUT3SLu+V2jji7nZJN80cx3PSqx/DLbp/oGxyq6wmpOSfwW76BMr06gyFTeSAM1J3/Yf0TLWB719t79xtElMMYhqae/ynccDsfetD/1AVFu67KfUxy2cRJpEBDBaDio0bR/4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2807E429505FF14B8FCF2D35B7E5CDE4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c503643c-be53-4ca3-9396-08d630e64adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2018 08:31:37.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1406
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-13_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 12, 2018, at 2:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>=20
> Can we please not top-post?
>=20
> On Thu, Oct 11, 2018 at 10:37:14PM +0000, Song Liu wrote:
>> Thanks Peter! These are really really helpful.=20
>>=20
>> I am trying to think through the case of a group of two events on two=20
>> separate hardware PMUs. In current implementation, this will not trigger
>> move_group,
>=20
> Right, currently this is disallowed (or should be, I'll need to double
> check the code).
>=20
>> so they will not be able to rotate together? And actually,=20
>> they may not be able to run at all? Maybe this case is never supported?=
=20
>=20
> Indeed, we do not allow mixing events of different PMUs, with the
> explicit exception of software events. Since software events must always
> schedule, they're allowed to be fitted into any group.
>=20
>> On the other hand, would something like this work:
>>=20
>>    perf_cpu_context <-[1:2]-> perf_event_context <-[1:n]-> perf_event=20
>>              |                                                |
>>              `----[1:n]---->     pmu    <----- [1:n]----------'=20
>>=20

After reading the code more, I think my idea in the figure above is=20
similar to this patch. The "pmu" in the figure is actually =20
perf_cpu_pmu_context. And I was thinking about something similar to=20
current pmu (not in the figure above).=20

I spent about two hours right here try to explain my idea. I ended=20
up delete everything I typed and agree almost all your design=20
decisions.=20

I just realized that, if we don't allow group of events on two=20
different hardware PMUs, the design of this patch works very well.=20
Rotation of multiple PMUs at the same time is not necessary.=20

The only suggestion I have right now is on which struct owns which
data:

1. perf_cpu_context owns two perf_event_context: ctx and *task_ctx.=20
   This is the same as right now.=20
2. perf_event_context owns multiple perf_event_pmu_context:=20
   One perf_event_pmu_context for software groups;
   One perf_event_pmu_context for each hardware PMU.
3. perf_event_pmu_context owns RB tree of events. Since we don't=20
   need rotation across multiple hardware PMUs, the rotation is=20
   within same perf_event_pmu_context. =20
4. perf_cpu_context owns multiple perf_cpu_pmu_context:
   One perf_cpu_pmu_context for each hardware PMU.
   perf_cpu_pmu_context is tot needed for software only groups(?).
5. perf_cpu_pmu_context has two pointers of perf_event_pmu_context.


The following diff (on top of this patch) shows the idea above.=20
I don't think it changes any mechanism. But it feels simpler to me.=20

Thanks,
Song

diff --git i/include/linux/perf_event.h w/include/linux/perf_event.h
index 462315239f8f..b15e679d4802 100644
--- i/include/linux/perf_event.h
+++ w/include/linux/perf_event.h
@@ -762,10 +762,7 @@ struct perf_event_context {
        struct mutex                    mutex;

        struct list_head                pmu_ctx_list;
-
-       struct perf_event_groups        pinned_groups;
-       struct perf_event_groups        flexible_groups;
-       struct list_head                event_list;
+       struct perf_event_pmu_context   sw_ctx;

        int                             nr_events;
        int                             nr_active;
@@ -806,7 +803,7 @@ struct perf_event_context {
 #define PERF_NR_CONTEXTS       4

 struct perf_cpu_pmu_context {
-       struct perf_event_pmu_context   epc;
+       struct perf_event_pmu_context   *epc;  /* I am still debating this =
one */
        struct perf_event_pmu_context   *task_epc;

        struct list_head                sched_cb_entry;
@@ -827,6 +824,7 @@ struct perf_cpu_pmu_context {
 struct perf_cpu_context {
        struct perf_event_context       ctx;
        struct perf_event_context       *task_ctx;
+       struct list_head                list_of_perf_cpu_pmu_context; /* ma=
y be removed? */

 #ifdef CONFIG_CGROUP_PERF
        struct perf_cgroup              *cgrp;
@@ -834,6 +832,10 @@ struct perf_cpu_context {
 #endif

        int                             online;
+
+       struct perf_event_groups        pinned_groups;
+       struct perf_event_groups        flexible_groups;
+       struct list_head                event_list;
 };

 struct perf_output_handle {


