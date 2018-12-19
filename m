Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1263C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8929B21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XYRhgYJ7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RhD6at8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeLSGHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:07:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbeLSGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:07:11 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBJ64dJH022233;
        Tue, 18 Dec 2018 22:06:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dpCuwDvSIYteJAILnYoSVbg+SN2CS38TQi1NzhPsgR8=;
 b=XYRhgYJ7fHiHtKkdZTYaNhEckC4R8H+B2zxKfu8+yWuQ9buel2wEmKDv8JrOOwpguDWY
 hcUWchuFAEhH3YfbNRBguZgnHWpEYu4wVM2GXoyIpwJjYI2YseXmRd0V/EF86RRYtLBZ
 QevjGh1Et570OhwHsVFRxWADDsyjTK/qw0w= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pff9c04tx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Dec 2018 22:06:35 -0800
Received: from frc-mbx08.TheFacebook.com (2620:10d:c0a1:f82::32) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 18 Dec 2018 22:06:32 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx08.TheFacebook.com (2620:10d:c0a1:f82::32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 18 Dec 2018 22:06:32 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 18 Dec 2018 22:06:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpCuwDvSIYteJAILnYoSVbg+SN2CS38TQi1NzhPsgR8=;
 b=RhD6at8Zd5G2wkbNScI9pM8ohCpBkNn0tGi7ukxDsl5oLfZv/EhPf50LGCZ/LLyfiEkzBRazxHywH0fXLaszWAPCmanbySAag1htRotAVcbx8/QAJhpuSBJb1CPb12mQypMW4monmz4Mx2qJravCJFVUzZORQg9oNVx+juIp5fk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 06:06:28 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%5]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 06:06:28 +0000
From:   Song Liu <songliubraving@fb.com>
To:     lkml <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 perf, bpf-next 5/7] perf util: handle
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v4 perf, bpf-next 5/7] perf util: handle
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUl2CAn1petOvsgEu1DAbOrBbQnKWFkzOA
Date:   Wed, 19 Dec 2018 06:06:28 +0000
Message-ID: <B6473A67-253A-424C-9ABF-5EA404591B44@fb.com>
References: <20181219060227.1057679-1-songliubraving@fb.com>
 <20181219060227.1057679-6-songliubraving@fb.com>
In-Reply-To: <20181219060227.1057679-6-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:3225]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1216;20:npQn/jeOdXkT03QBIlBMU7IPnxSpfDOj9kNlVy+DPcr9lyVxGL9TOiP49sC9DeZiF3ENrv/h+BRnEV23nvhV7BcGrqrmAqP3lUbYhri8QrxQrAbPntvksvTDST+uEIM3SlW+gl+qgiGdk4a4hcG7ZwSCFQJUsQ+X8usdhns6ROU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b10035d6-5b34-498f-f498-08d665781dad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1216;
x-ms-traffictypediagnostic: MWHPR15MB1216:
x-microsoft-antispam-prvs: <MWHPR15MB121644F89A76D3BBC9F3FB83B3BE0@MWHPR15MB1216.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1216;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1216;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(6486002)(53546011)(6506007)(105586002)(86362001)(7736002)(102836004)(305945005)(14454004)(99286004)(11346002)(2616005)(25786009)(486006)(478600001)(2906002)(68736007)(476003)(446003)(106356001)(76176011)(6436002)(6116002)(97736004)(186003)(5660300001)(83716004)(36756003)(50226002)(4326008)(6246003)(46003)(53936002)(6512007)(71190400001)(71200400001)(8936002)(229853002)(8676002)(82746002)(4744004)(81156014)(81166006)(33656002)(110136005)(14444005)(256004)(57306001)(316002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1216;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H6tz8z15ujhWTCMOfWLKRETCeJPFFesSbZP3EhF+SQUnBfFOMb7J9CUMGMr72gsh8qbJ/RFOjTu6GaZHfNSDwR8X9dbXvkmxg5fnMLg8nyLZkP0+KCmuZT/1MiYYh/wBhSDcfHCptbSoKf5bwh0dezTPdieqnSNBPxdWA8uabiKvfLt7BDkZ+vShWG+S7MWzgTHhe2iHT6oPmIK9gqhuqANwzWvpfjO1PeeKnv4I7EEfhTPbhsJVMnNRwTKpxsjhXEOq6ljmc9lw2RQKQAq0L6z4SJ66hzm9ywLCmbyzmYaiQciTCPAu8LGkx9tusI3B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE3E21E6C59732458832C214FA7C72CE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b10035d6-5b34-498f-f498-08d665781dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 06:06:28.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this one. The other 5/7 is the right patch.=20

Thanks,
Song

> On Dec 18, 2018, at 10:02 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch handles PERF_RECORD_BPF_EVENT in perf record/report.
> Specifically, map and symbol are created for PERF_BPF_EVENT_PROG_LOAD,
> and removed for PERF_BPF_EVENT_PROG_UNLOAD.
>=20
> This patch also set perf_event_attr.bpf_event properly. The flag is
> ON by default.
>=20
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
> tools/perf/util/event.c   | 20 ++++++++++++++
> tools/perf/util/event.h   | 18 +++++++++++++
> tools/perf/util/evsel.c   |  9 +++++++
> tools/perf/util/evsel.h   |  1 +
> tools/perf/util/machine.c | 56 +++++++++++++++++++++++++++++++++++++++
> tools/perf/util/machine.h |  5 +++-
> tools/perf/util/session.c |  4 +++
> tools/perf/util/tool.h    |  4 ++-
> 8 files changed, 115 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index e9c108a6b1c3..4b47194eaa4b 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -24,6 +24,7 @@
> #include "symbol/kallsyms.h"
> #include "asm/bug.h"
> #include "stat.h"
> +#include "session.h"
>=20
> static const char *perf_event__names[] =3D {
> 	[0]					=3D "TOTAL",
> @@ -43,6 +44,7 @@ static const char *perf_event__names[] =3D {
> 	[PERF_RECORD_SWITCH]			=3D "SWITCH",
> 	[PERF_RECORD_SWITCH_CPU_WIDE]		=3D "SWITCH_CPU_WIDE",
> 	[PERF_RECORD_NAMESPACES]		=3D "NAMESPACES",
> +	[PERF_RECORD_KSYMBOL]			=3D "KSYMBOL",
> 	[PERF_RECORD_HEADER_ATTR]		=3D "ATTR",
> 	[PERF_RECORD_HEADER_EVENT_TYPE]		=3D "EVENT_TYPE",
> 	[PERF_RECORD_HEADER_TRACING_DATA]	=3D "TRACING_DATA",
> @@ -1335,6 +1337,14 @@ int perf_event__process_switch(struct perf_tool *t=
ool __maybe_unused,
> 	return machine__process_switch_event(machine, event);
> }
>=20
> +int perf_event__process_ksymbol(struct perf_tool *tool __maybe_unused,
> +				union perf_event *event,
> +				struct perf_sample *sample __maybe_unused,
> +				struct machine *machine)
> +{
> +	return machine__process_ksymbol(machine, event, sample);
> +}
> +
> size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
> {
> 	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]:=
 %c %s\n",
> @@ -1467,6 +1477,13 @@ static size_t perf_event__fprintf_lost(union perf_=
event *event, FILE *fp)
> 	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
> }
>=20
> +size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
> +{
> +	return fprintf(fp, " ksymbol event with addr %lx len %lu name %s\n",
> +		       event->ksymbol_event.addr, event->ksymbol_event.len,
> +		       event->ksymbol_event.name);
> +}
> +
> size_t perf_event__fprintf(union perf_event *event, FILE *fp)
> {
> 	size_t ret =3D fprintf(fp, "PERF_RECORD_%s",
> @@ -1502,6 +1519,9 @@ size_t perf_event__fprintf(union perf_event *event,=
 FILE *fp)
> 	case PERF_RECORD_LOST:
> 		ret +=3D perf_event__fprintf_lost(event, fp);
> 		break;
> +	case PERF_RECORD_KSYMBOL:
> +		ret +=3D perf_event__fprintf_ksymbol(event, fp);
> +		break;
> 	default:
> 		ret +=3D fprintf(fp, "\n");
> 	}
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index bfa60bcafbde..100b59f1fdec 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -5,6 +5,7 @@
> #include <limits.h>
> #include <stdio.h>
> #include <linux/kernel.h>
> +#include <linux/bpf.h>
>=20
> #include "../perf.h"
> #include "build-id.h"
> @@ -84,6 +85,17 @@ struct throttle_event {
> 	u64 stream_id;
> };
>=20
> +#ifndef KSYM_NAME_LEN
> +#define KSYM_NAME_LEN 256
> +#endif
> +
> +struct ksymbol_event {
> +	struct perf_event_header header;
> +	u64 addr;
> +	u64 len;
> +	char name[KSYM_NAME_LEN];
> +};
> +
> #define PERF_SAMPLE_MASK				\
> 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
> 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
> @@ -651,6 +663,7 @@ union perf_event {
> 	struct stat_round_event		stat_round;
> 	struct time_conv_event		time_conv;
> 	struct feature_event		feat;
> +	struct ksymbol_event		ksymbol_event;
> };
>=20
> void perf_event__print_totals(void);
> @@ -750,6 +763,10 @@ int perf_event__process_exit(struct perf_tool *tool,
> 			     union perf_event *event,
> 			     struct perf_sample *sample,
> 			     struct machine *machine);
> +int perf_event__process_ksymbol(struct perf_tool *tool,
> +				union perf_event *event,
> +				struct perf_sample *sample,
> +				struct machine *machine);
> int perf_tool__process_synth_event(struct perf_tool *tool,
> 				   union perf_event *event,
> 				   struct machine *machine,
> @@ -814,6 +831,7 @@ size_t perf_event__fprintf_switch(union perf_event *e=
vent, FILE *fp);
> size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
> size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
> size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
> +size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
> size_t perf_event__fprintf(union perf_event *event, FILE *fp);
>=20
> int kallsyms__get_function_start(const char *kallsyms_filename,
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbc0466db368..de34ce875648 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1035,6 +1035,7 @@ void perf_evsel__config(struct perf_evsel *evsel, s=
truct record_opts *opts,
> 	attr->mmap  =3D track;
> 	attr->mmap2 =3D track && !perf_missing_features.mmap2;
> 	attr->comm  =3D track;
> +	attr->ksymbol =3D track && !perf_missing_features.ksymbol;
>=20
> 	if (opts->record_namespaces)
> 		attr->namespaces  =3D track;
> @@ -1652,6 +1653,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_=
event_attr *attr,
> 	PRINT_ATTRf(context_switch, p_unsigned);
> 	PRINT_ATTRf(write_backward, p_unsigned);
> 	PRINT_ATTRf(namespaces, p_unsigned);
> +	PRINT_ATTRf(ksymbol, p_unsigned);
>=20
> 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsi=
gned);
> 	PRINT_ATTRf(bp_type, p_unsigned);
> @@ -1811,6 +1813,8 @@ int perf_evsel__open(struct perf_evsel *evsel, stru=
ct cpu_map *cpus,
> 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
> 	if (perf_missing_features.group_read && evsel->attr.inherit)
> 		evsel->attr.read_format &=3D ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
> +	if (perf_missing_features.ksymbol)
> +		evsel->attr.ksymbol =3D 0;
> retry_sample_id:
> 	if (perf_missing_features.sample_id_all)
> 		evsel->attr.sample_id_all =3D 0;
> @@ -1955,6 +1959,11 @@ int perf_evsel__open(struct perf_evsel *evsel, str=
uct cpu_map *cpus,
> 		perf_missing_features.exclude_guest =3D true;
> 		pr_debug2("switching off exclude_guest, exclude_host\n");
> 		goto fallback_missing_features;
> +	} else if (!perf_missing_features.ksymbol &&
> +		   evsel->attr.ksymbol) {
> +		perf_missing_features.ksymbol =3D true;
> +		pr_debug2("switching off ksymbol\n");
> +		goto fallback_missing_features;
> 	} else if (!perf_missing_features.sample_id_all) {
> 		perf_missing_features.sample_id_all =3D true;
> 		pr_debug2("switching off sample_id_all\n");
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 3147ca76c6fc..c647c1963f7a 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -168,6 +168,7 @@ struct perf_missing_features {
> 	bool lbr_flags;
> 	bool write_backward;
> 	bool group_read;
> +	bool ksymbol;
> };
>=20
> extern struct perf_missing_features perf_missing_features;
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 8f36ce813bc5..d29935526673 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -681,6 +681,60 @@ int machine__process_switch_event(struct machine *ma=
chine __maybe_unused,
> 	return 0;
> }
>=20
> +static int machine__process_ksymbol_register(
> +	struct machine *machine,
> +	union perf_event *event,
> +	struct perf_sample *sample __maybe_unused)
> +{
> +	struct symbol *sym;
> +	struct map *map;
> +
> +	map =3D map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
> +	if (!map) {
> +		map =3D dso__new_map("bpf_prog");
> +		if (!map)
> +			return -ENOMEM;
> +
> +		map->start =3D event->ksymbol_event.addr;
> +		map->pgoff =3D map->start;
> +		map->end =3D map->start + event->ksymbol_event.len;
> +		map_groups__insert(&machine->kmaps, map);
> +	}
> +
> +	sym =3D symbol__new(event->ksymbol_event.addr, event->ksymbol_event.len=
,
> +			  0, 0, event->ksymbol_event.name);
> +	if (!sym)
> +		return -ENOMEM;
> +	dso__insert_symbol(map->dso, sym);
> +	return 0;
> +}
> +
> +static int machine__process_ksymbol_unregister(
> +	struct machine *machine,
> +	union perf_event *event,
> +	struct perf_sample *sample __maybe_unused)
> +{
> +	struct map *map;
> +
> +	map =3D map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
> +	if (map)
> +		map_groups__remove(&machine->kmaps, map);
> +
> +	return 0;
> +}
> +
> +int machine__process_ksymbol(struct machine *machine __maybe_unused,
> +			     union perf_event *event,
> +			     struct perf_sample *sample)
> +{
> +	if (dump_trace)
> +		perf_event__fprintf_ksymbol(event, stderr);
> +
> +	if (event->header.misc & PERF_RECORD_MISC_KSYMBOL_UNREGISTER)
> +		return machine__process_ksymbol_unregister(machine, event, sample);
> +	return machine__process_ksymbol_register(machine, event, sample);
> +}
> +
> static void dso__adjust_kmod_long_name(struct dso *dso, const char *filen=
ame)
> {
> 	const char *dup_filename;
> @@ -1812,6 +1866,8 @@ int machine__process_event(struct machine *machine,=
 union perf_event *event,
> 	case PERF_RECORD_SWITCH:
> 	case PERF_RECORD_SWITCH_CPU_WIDE:
> 		ret =3D machine__process_switch_event(machine, event); break;
> +	case PERF_RECORD_KSYMBOL:
> +		ret =3D machine__process_ksymbol(machine, event, sample); break;
> 	default:
> 		ret =3D -1;
> 		break;
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index d856b85862e2..e92728fe66cd 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -127,9 +127,12 @@ int machine__process_mmap_event(struct machine *mach=
ine, union perf_event *event
> 				struct perf_sample *sample);
> int machine__process_mmap2_event(struct machine *machine, union perf_even=
t *event,
> 				 struct perf_sample *sample);
> +
> int machine__process_event(struct machine *machine, union perf_event *eve=
nt,
> 				struct perf_sample *sample);
> -
> +int machine__process_ksymbol(struct machine *machine,
> +			     union perf_event *event,
> +			     struct perf_sample *sample);
> typedef void (*machine__process_t)(struct machine *machine, void *data);
>=20
> struct machines {
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7d2c8ce6cfad..2c1976a66164 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -371,6 +371,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
> 		tool->itrace_start =3D perf_event__process_itrace_start;
> 	if (tool->context_switch =3D=3D NULL)
> 		tool->context_switch =3D perf_event__process_switch;
> +	if (tool->ksymbol =3D=3D NULL)
> +		tool->ksymbol =3D perf_event__process_ksymbol;
> 	if (tool->read =3D=3D NULL)
> 		tool->read =3D process_event_sample_stub;
> 	if (tool->throttle =3D=3D NULL)
> @@ -1300,6 +1302,8 @@ static int machines__deliver_event(struct machines =
*machines,
> 	case PERF_RECORD_SWITCH:
> 	case PERF_RECORD_SWITCH_CPU_WIDE:
> 		return tool->context_switch(tool, event, sample, machine);
> +	case PERF_RECORD_KSYMBOL:
> +		return tool->ksymbol(tool, event, sample, machine);
> 	default:
> 		++evlist->stats.nr_unknown_events;
> 		return -1;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 56e4ca54020a..9c81ca2f3cf7 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -53,7 +53,9 @@ struct perf_tool {
> 			itrace_start,
> 			context_switch,
> 			throttle,
> -			unthrottle;
> +			unthrottle,
> +			ksymbol;
> +
> 	event_attr_op	attr;
> 	event_attr_op	event_update;
> 	event_op2	tracing_data;
> --=20
> 2.17.1
>=20

