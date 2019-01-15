Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712A720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="APlT4S9L";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GeVKDflW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389548AbfAOT6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:58:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732125AbfAOT6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:58:55 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0FJrShb000630;
        Tue, 15 Jan 2019 11:58:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GRuWDRNZP7S4/AovV0z3fpcnGj5ff91Mnqzbk9Am7q8=;
 b=APlT4S9L7hJjTVQl7vbEPiizyFxMzCofOCICYLMIhApONyuDT7hB3RCiOMJWZrkKzRKQ
 1M0mhQ/Vnbc2KB9eGMUSWp2G3EmD3xmSoVaGORcc/qOC8W5oiLjWVrVKwLqHb9YZzF2F
 lz2LOFfLELswG+2xy7qbNuyGb84qpXD4SnE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q1kyp0mw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Jan 2019 11:58:26 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 15 Jan 2019 11:58:25 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 15 Jan 2019 11:58:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRuWDRNZP7S4/AovV0z3fpcnGj5ff91Mnqzbk9Am7q8=;
 b=GeVKDflWhxFMF7KDqL2Ycz935Fs8pjQwxQInF5z1BmWhgTo3SFzPyTG8rwNeMgDYWapnpc/WCYKe6SnKKMFOJTEEniH8Hvhd5fJ2tv869W/1tuWiXmZs9g1tF8lkvoe7sC8q2BqMDrP3g0UOcHzM1cZaHl9jsvHtY/s5i/9Tb4o=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1232.namprd15.prod.outlook.com (10.175.2.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Tue, 15 Jan 2019 19:58:07 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1537.018; Tue, 15 Jan 2019
 19:58:07 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "dsahern@gmail.com" <dsahern@gmail.com>
Subject: Re: [PATCH v7 perf, bpf-next 6/8] perf util: handle
 PERF_RECORD_KSYMBOL
Thread-Topic: [PATCH v7 perf, bpf-next 6/8] perf util: handle
 PERF_RECORD_KSYMBOL
Thread-Index: AQHUqUNl1AojgYTTq0eyFBkCtECvdqWwpNwAgAAh4AA=
Date:   Tue, 15 Jan 2019 19:58:07 +0000
Message-ID: <65252E81-72C1-4143-85DB-0336A7C85555@fb.com>
References: <20190111001933.4153792-1-songliubraving@fb.com>
 <20190111001933.4153792-7-songliubraving@fb.com>
 <20190115175652.GD20159@kernel.org>
In-Reply-To: <20190115175652.GD20159@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::7:7a3a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1232;20:/szXaQ91h4mZq1Sj9ZSmsdfDbu/KDUHQY+8F2urbuq8gBXejJFisu95AEUAB3kHASyXioKXVPJUbr1TzTtltPHMLskqiOg+mQdVjdzirm4sbHTzTdBnjHr8D57MZ7BOVL8LJC6HCLoigSNlOOVNHN6yk3CWxhu7dYOudnJa54k0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 69ca4e4e-b8fd-443c-b328-08d67b23c498
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1232;
x-ms-traffictypediagnostic: MWHPR15MB1232:
x-microsoft-antispam-prvs: <MWHPR15MB12322F667ACA2D3EAD5790C7B3810@MWHPR15MB1232.namprd15.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(14454004)(46003)(6506007)(82746002)(476003)(53546011)(11346002)(446003)(2616005)(486006)(478600001)(186003)(68736007)(39060400002)(97736004)(53936002)(6246003)(2906002)(33656002)(102836004)(25786009)(4326008)(5660300001)(106356001)(6916009)(86362001)(6512007)(105586002)(76176011)(50226002)(6116002)(81166006)(81156014)(8936002)(83716004)(229853002)(305945005)(57306001)(71200400001)(71190400001)(256004)(7736002)(316002)(54906003)(36756003)(8676002)(6436002)(99286004)(14444005)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1232;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o2FiIm6DDbrtj+HYvbNmFSazOTvA8iYfZzeN47csGaz99pJOBpETTEBu0kQA/IwdLhDP0Lx52/heO2bWxrEogMXv/pdKWEvUf8Qit2QilJNv0lPE6GkpjmBXVixijafwuMu9qjmIQ9PUgNRSPn5A+OT9NwT8EQFWYtEyCcKtVJ1p2U+SDH8BoeStjvVHcCz4vv4yrGTRtSlJa2+CO9iGnSPmPRjg7rX00VSRY5YeK4P+wV99RW2udja6Afa18lDGUf8meOhX0mMbBSdbyNk5qYWAe+Y1SgFf4XwUiyisitlZJlkFOo8BCfygLOZOe6aki82Nut/oL8k6+Mf0brCeex0Hbu2/70QwS5rhKwQ8ZH7fIPTiCyXZaD4gGulMpKqzUpoVv5gf1686FL185ixoNVl3f9+6/Mud4+9SyJN2DMw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B125AFCC09F394A930AFC1A9024F595@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ca4e4e-b8fd-443c-b328-08d67b23c498
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 19:58:07.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1232
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2019, at 9:56 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Thu, Jan 10, 2019 at 04:19:31PM -0800, Song Liu escreveu:
>> This patch handles PERF_RECORD_KSYMBOL in perf record/report.
>> Specifically, map and symbol are created for ksymbol register, and
>> removed for ksymbol unregister.
>>=20
>> This patch also set perf_event_attr.ksymbol properly. The flag is
>> ON by default.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/util/event.c   | 21 +++++++++++++++
>> tools/perf/util/event.h   | 20 ++++++++++++++
>> tools/perf/util/evsel.c   |  9 +++++++
>> tools/perf/util/evsel.h   |  1 +
>> tools/perf/util/machine.c | 57 +++++++++++++++++++++++++++++++++++++++
>> tools/perf/util/machine.h |  3 +++
>> tools/perf/util/session.c |  4 +++
>> tools/perf/util/tool.h    |  4 ++-
>> 8 files changed, 118 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>> index 937a5a4f71cc..3c8a6a8dd260 100644
>> --- a/tools/perf/util/event.c
>> +++ b/tools/perf/util/event.c
>> @@ -24,6 +24,7 @@
>> #include "symbol/kallsyms.h"
>> #include "asm/bug.h"
>> #include "stat.h"
>> +#include "session.h"
>>=20
>> #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
>>=20
>> @@ -45,6 +46,7 @@ static const char *perf_event__names[] =3D {
>> 	[PERF_RECORD_SWITCH]			=3D "SWITCH",
>> 	[PERF_RECORD_SWITCH_CPU_WIDE]		=3D "SWITCH_CPU_WIDE",
>> 	[PERF_RECORD_NAMESPACES]		=3D "NAMESPACES",
>> +	[PERF_RECORD_KSYMBOL]			=3D "KSYMBOL",
>> 	[PERF_RECORD_HEADER_ATTR]		=3D "ATTR",
>> 	[PERF_RECORD_HEADER_EVENT_TYPE]		=3D "EVENT_TYPE",
>> 	[PERF_RECORD_HEADER_TRACING_DATA]	=3D "TRACING_DATA",
>> @@ -1329,6 +1331,14 @@ int perf_event__process_switch(struct perf_tool *=
tool __maybe_unused,
>> 	return machine__process_switch_event(machine, event);
>> }
>>=20
>> +int perf_event__process_ksymbol(struct perf_tool *tool __maybe_unused,
>> +				union perf_event *event,
>> +				struct perf_sample *sample __maybe_unused,
>> +				struct machine *machine)
>> +{
>> +	return machine__process_ksymbol(machine, event, sample);
>> +}
>> +
>> size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
>> {
>> 	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]=
: %c %s\n",
>> @@ -1461,6 +1471,14 @@ static size_t perf_event__fprintf_lost(union perf=
_event *event, FILE *fp)
>> 	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
>> }
>>=20
>> +size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
>> +{
>> +	return fprintf(fp, " ksymbol event with addr %lx len %u type %u flags =
0x%x name %s\n",
>> +		       event->ksymbol_event.addr, event->ksymbol_event.len,
>> +		       event->ksymbol_event.ksym_type,
>> +		       event->ksymbol_event.flags, event->ksymbol_event.name);
>> +}
>> +
>> size_t perf_event__fprintf(union perf_event *event, FILE *fp)
>> {
>> 	size_t ret =3D fprintf(fp, "PERF_RECORD_%s",
>> @@ -1496,6 +1514,9 @@ size_t perf_event__fprintf(union perf_event *event=
, FILE *fp)
>> 	case PERF_RECORD_LOST:
>> 		ret +=3D perf_event__fprintf_lost(event, fp);
>> 		break;
>> +	case PERF_RECORD_KSYMBOL:
>> +		ret +=3D perf_event__fprintf_ksymbol(event, fp);
>> +		break;
>> 	default:
>> 		ret +=3D fprintf(fp, "\n");
>> 	}
>> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
>> index eb95f3384958..018322f2a13e 100644
>> --- a/tools/perf/util/event.h
>> +++ b/tools/perf/util/event.h
>> @@ -5,6 +5,7 @@
>> #include <limits.h>
>> #include <stdio.h>
>> #include <linux/kernel.h>
>> +#include <linux/bpf.h>
>>=20
>> #include "../perf.h"
>> #include "build-id.h"
>> @@ -84,6 +85,19 @@ struct throttle_event {
>> 	u64 stream_id;
>> };
>>=20
>> +#ifndef KSYM_NAME_LEN
>> +#define KSYM_NAME_LEN 256
>> +#endif
>> +
>> +struct ksymbol_event {
>> +	struct perf_event_header header;
>> +	u64 addr;
>> +	u32 len;
>> +	u16 ksym_type;
>> +	u16 flags;
>> +	char name[KSYM_NAME_LEN];
>> +};
>> +
>> #define PERF_SAMPLE_MASK				\
>> 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
>> 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
>> @@ -651,6 +665,7 @@ union perf_event {
>> 	struct stat_round_event		stat_round;
>> 	struct time_conv_event		time_conv;
>> 	struct feature_event		feat;
>> +	struct ksymbol_event		ksymbol_event;
>> };
>>=20
>> void perf_event__print_totals(void);
>> @@ -748,6 +763,10 @@ int perf_event__process_exit(struct perf_tool *tool=
,
>> 			     union perf_event *event,
>> 			     struct perf_sample *sample,
>> 			     struct machine *machine);
>> +int perf_event__process_ksymbol(struct perf_tool *tool,
>> +				union perf_event *event,
>> +				struct perf_sample *sample,
>> +				struct machine *machine);
>> int perf_tool__process_synth_event(struct perf_tool *tool,
>> 				   union perf_event *event,
>> 				   struct machine *machine,
>> @@ -811,6 +830,7 @@ size_t perf_event__fprintf_switch(union perf_event *=
event, FILE *fp);
>> size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp)=
;
>> size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
>> size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp)=
;
>> +size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
>> size_t perf_event__fprintf(union perf_event *event, FILE *fp);
>>=20
>> int kallsyms__get_function_start(const char *kallsyms_filename,
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index dbc0466db368..de34ce875648 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1035,6 +1035,7 @@ void perf_evsel__config(struct perf_evsel *evsel, =
struct record_opts *opts,
>> 	attr->mmap  =3D track;
>> 	attr->mmap2 =3D track && !perf_missing_features.mmap2;
>> 	attr->comm  =3D track;
>> +	attr->ksymbol =3D track && !perf_missing_features.ksymbol;
>>=20
>> 	if (opts->record_namespaces)
>> 		attr->namespaces  =3D track;
>> @@ -1652,6 +1653,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf=
_event_attr *attr,
>> 	PRINT_ATTRf(context_switch, p_unsigned);
>> 	PRINT_ATTRf(write_backward, p_unsigned);
>> 	PRINT_ATTRf(namespaces, p_unsigned);
>> +	PRINT_ATTRf(ksymbol, p_unsigned);
>>=20
>> 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_uns=
igned);
>> 	PRINT_ATTRf(bp_type, p_unsigned);
>> @@ -1811,6 +1813,8 @@ int perf_evsel__open(struct perf_evsel *evsel, str=
uct cpu_map *cpus,
>> 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
>> 	if (perf_missing_features.group_read && evsel->attr.inherit)
>> 		evsel->attr.read_format &=3D ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
>> +	if (perf_missing_features.ksymbol)
>> +		evsel->attr.ksymbol =3D 0;
>> retry_sample_id:
>> 	if (perf_missing_features.sample_id_all)
>> 		evsel->attr.sample_id_all =3D 0;
>> @@ -1955,6 +1959,11 @@ int perf_evsel__open(struct perf_evsel *evsel, st=
ruct cpu_map *cpus,
>> 		perf_missing_features.exclude_guest =3D true;
>> 		pr_debug2("switching off exclude_guest, exclude_host\n");
>> 		goto fallback_missing_features;
>> +	} else if (!perf_missing_features.ksymbol &&
>> +		   evsel->attr.ksymbol) {
>> +		perf_missing_features.ksymbol =3D true;
>> +		pr_debug2("switching off ksymbol\n");
>> +		goto fallback_missing_features;
>=20
>=20
> Please move this to the top, see the comment there:
>=20
> 	if (err !=3D -EINVAL || cpu > 0 || thread > 0)
> 		goto out_close;
>=20
> 	/*
> 	 * Must probe features in the order they were added to the
> 	 * perf_event_attr interface.
> 	 */
> 	if (!perf_missing_features.write_backward && evsel->attr.write_backward)=
 {
> 		perf_missing_features.write_backward =3D true;
> 		pr_debug2("switching off write_backward\n");
> 		goto out_close;
> 	} else if (!perf_missing_features.clockid_wrong && evsel->attr.use_clock=
id) {
> 		perf_missing_features.clockid_wrong =3D true;
> 		pr_debug2("switching off clockid\n");
> 		goto fallback_missing_features;
>=20
>=20
> So that when one asks for, say, attr.write_backward _and_ attr.ksymbol,
> we first disable attr.ksymbol, to try the fallback, as it was added
> after attr.write_backward.
>=20
> Think about an older kernel where attr.write_backward is present but not
> attr.ksymbol.
>=20
> Ditto for the attr.bpf_event.
>=20

Thanks Arnaldo!

I will include the fix in next version.

Song

