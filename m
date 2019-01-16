Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF98C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2642205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b1LYM7O3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QEwq3JfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404405AbfAPONO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:13:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59218 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733044AbfAPONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:13:14 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0GECNpV008263;
        Wed, 16 Jan 2019 06:12:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=F8EQ1EI8r8AliG/BaO9Il4QcqHmXnXtj1s6oqNP+ELA=;
 b=b1LYM7O3dtzbiDCVeERyvHNlPvVUbD4NHbpbkl22FSoUjIWzH0BbrLA9Vwj12bIFN7g2
 abRfSh5aypzl5WjkxxmVCf6suqrwbx6cPevLpnKEFS7FsvJ0sZQchtKOs/MVeZIBDuKB
 FdKV2tWLQXJ2Sk1NQ+cJFZ9B3LDmbf4+Pzg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q22uggjnc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Jan 2019 06:12:44 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 16 Jan 2019 06:12:40 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 16 Jan 2019 06:12:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8EQ1EI8r8AliG/BaO9Il4QcqHmXnXtj1s6oqNP+ELA=;
 b=QEwq3JfNLU9gycnMhGnCjku82MkvwV5hseNyDRc4mJRrUf34UI1hKB7g4Sng8PhJ6qQJBjdOfx01E2rumfDL2fdb6oiT3dXTsj3RPMULqWyDMrS141R8ZU1LZp04cDsNgkCDs0OUHUajfcaLiJt3mvX6LSguemlw0YdssjciSsM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1663.namprd15.prod.outlook.com (10.175.141.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 14:12:38 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 14:12:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "dsahern@gmail.com" <dsahern@gmail.com>
Subject: Re: [PATCH v9 perf, bpf-next 5/9] perf util: handle
 PERF_RECORD_KSYMBOL
Thread-Topic: [PATCH v9 perf, bpf-next 5/9] perf util: handle
 PERF_RECORD_KSYMBOL
Thread-Index: AQHUrTCjaMw6huQPEU+jSSsvZCShv6Wx7VYAgAADWAA=
Date:   Wed, 16 Jan 2019 14:12:37 +0000
Message-ID: <C7F34FF8-43E0-4AFB-BA12-34C89B7FEE36@fb.com>
References: <20190116001410.3522226-1-songliubraving@fb.com>
 <20190116001410.3522226-6-songliubraving@fb.com>
 <20190116140038.GB2243@kernel.org>
In-Reply-To: <20190116140038.GB2243@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:2ea9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1663;20:HCOLgCsOniXuYy98tqezykh0A61tkudI+rkpNUDcw4igXYOPvQDMECDAdgzkGRalnsQjYoEGJ+GJ3302qD6JSoFxzHYy6Z/952GcKIPoD4l4nca20uqemsopPgwD+oNT+sJnb0y3bDQDQSqu7/dUiGpjcTvT5PDUVw69e93aAhQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 12b6d39e-cfde-462c-4b3a-08d67bbcab93
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1663;
x-ms-traffictypediagnostic: MWHPR15MB1663:
x-microsoft-antispam-prvs: <MWHPR15MB1663363438AECFED5A455807B3820@MWHPR15MB1663.namprd15.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(54906003)(4326008)(7736002)(316002)(6916009)(71190400001)(30864003)(4744004)(46003)(5660300001)(102836004)(186003)(53546011)(39060400002)(6506007)(6486002)(71200400001)(57306001)(53936002)(8676002)(6246003)(229853002)(11346002)(68736007)(305945005)(82746002)(81166006)(50226002)(446003)(476003)(2616005)(6436002)(99286004)(6512007)(81156014)(2906002)(8936002)(83716004)(14444005)(256004)(6116002)(25786009)(36756003)(97736004)(86362001)(106356001)(76176011)(478600001)(33656002)(105586002)(14454004)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1663;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L+vkKFI+PaBxDNLbobvYVn/vZmpCFRj32SpEbgEwc1Av6vQ1TkGWbVBN+mh7qbgyh49wXj0yQUfCmxJKRW2ywoqCj8/ekCxWVKjFui3z2YCJNR/xncPb1v9U2/OjsZa0pHVVC5oyKESZBYrWtAJf5t7vdO+5u5tBKiNtZy3jNoeNx/yJaX8CKZ3Jj7adwdC7FNl3k30wtNmOsFE/QDn5zfKSYKKjTOhuKe2YYLgYGJWIzBCdMpD2gJBis4Qo2F2tXRf5vJlGMmGJHchA6Gc+i47b5RcSiEqODJSedSdalswxiqxBbFgFPEEaYwRlHy1givGvMwGmqzrEivex9elrQ3EX+zY6CUpOs923oA+95Ud0+fqLgbxrcjv3oES0rKWUr/EnuAok9XW2wzlbm9bu72Sxy28ucqNtA4Ad88WLcZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CED8BDD5AA552D458663CF0BE6391D06@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b6d39e-cfde-462c-4b3a-08d67bbcab93
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 14:12:38.0006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1663
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 16, 2019, at 6:00 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Tue, Jan 15, 2019 at 04:14:06PM -0800, Song Liu escreveu:
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
>> tools/perf/util/evsel.c   | 12 ++++++++-
>> tools/perf/util/evsel.h   |  1 +
>> tools/perf/util/machine.c | 57 +++++++++++++++++++++++++++++++++++++++
>> tools/perf/util/machine.h |  3 +++
>> tools/perf/util/session.c |  4 +++
>> tools/perf/util/tool.h    |  4 ++-
>> 8 files changed, 120 insertions(+), 2 deletions(-)
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
>> index dbc0466db368..a2c75aace409 100644
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
>> @@ -1930,7 +1934,13 @@ int perf_evsel__open(struct perf_evsel *evsel, st=
ruct cpu_map *cpus,
>> 	 * Must probe features in the order they were added to the
>> 	 * perf_event_attr interface.
>> 	 */
>> -	if (!perf_missing_features.write_backward && evsel->attr.write_backwar=
d) {
>> +	if (!perf_missing_features.ksymbol &&
>> +		   evsel->attr.ksymbol) {
>> +		perf_missing_features.ksymbol =3D true;
>> +		pr_debug2("switching off ksymbol\n");
>> +		goto fallback_missing_features;
>> +	} else if (!perf_missing_features.write_backward &&
>> +		   evsel->attr.write_backward) {
>=20
> Please keep the existing coding style, i.e. no need to change this line
> into two:
>=20
> 	if (!perf_missing_features.write_backward && evsel->attr.write_backward)=
 {
>=20
> Just add the '} else' in front of it, ditto for the new line.
>=20
> I'm not that strict about it, perhaps I should, to avoid my upstreamers
> to block things due to this ;-)
>=20
> And also this is not the only issue I found with this specific patch,
> see below for one more functional issue.
>=20
> I saw no issues in the previous patches (don't recall right now if there
> where coding style minor issues), so in your next patchset version you
> may add my:
>=20
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20

Thanks Arnaldo!

Just to be sure, did you mean to add Reviewed-by to patch 1/9 through 5/9?

> To those.
>=20
>> 		perf_missing_features.write_backward =3D true;
>> 		pr_debug2("switching off write_backward\n");
>> 		goto out_close;
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 82a289ce8b0c..4a8c3e7f4808 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -168,6 +168,7 @@ struct perf_missing_features {
>> 	bool lbr_flags;
>> 	bool write_backward;
>> 	bool group_read;
>> +	bool ksymbol;
>> };
>>=20
>> extern struct perf_missing_features perf_missing_features;
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index 143f7057d581..c8f6daac9d2d 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -681,6 +681,61 @@ int machine__process_switch_event(struct machine *m=
achine __maybe_unused,
>> 	return 0;
>> }
>>=20
>> +static int machine__process_ksymbol_register(
>> +	struct machine *machine,
>> +	union perf_event *event,
>> +	struct perf_sample *sample __maybe_unused)
>> +{
>> +	struct symbol *sym;
>> +	struct map *map;
>> +
>> +	map =3D map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
>> +	if (!map) {
>> +		map =3D dso__new_map("bpf_prog");
>=20
> Humm, why not use event->ksymbol_event.name as the name of the map as
> well? Otherwise we may end up thinking its all the same map "bpf_prog",
> when we have lots.

I will fix this in next version.=20

Song

>=20
>> +		if (!map)
>> +			return -ENOMEM;
>> +
>> +		map->start =3D event->ksymbol_event.addr;
>> +		map->pgoff =3D map->start;
>> +		map->end =3D map->start + event->ksymbol_event.len;
>> +		map_groups__insert(&machine->kmaps, map);
>> +	}
>> +
>> +	sym =3D symbol__new(event->ksymbol_event.addr, event->ksymbol_event.le=
n,
>> +			  0, 0, event->ksymbol_event.name);
>> +	if (!sym)
>> +		return -ENOMEM;
>> +	dso__insert_symbol(map->dso, sym);
>> +	return 0;
>> +}
>> +
>> +static int machine__process_ksymbol_unregister(
>> +	struct machine *machine,
>> +	union perf_event *event,
>> +	struct perf_sample *sample __maybe_unused)
>=20
> Please follow the existing style, the above should be:
>=20
> static int machine__process_ksymbol_unregister(struct machine *machine,
> 					       union perf_event *event,
> 					       struct perf_sample *sample __maybe_unused)
>=20
>> +{
>> +	struct map *map;
>> +
>> +	map =3D map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
>> +	if (map)
>> +		map_groups__remove(&machine->kmaps, map);
>> +
>> +	return 0;
>> +}
>> +
>> +int machine__process_ksymbol(struct machine *machine __maybe_unused,
>> +			     union perf_event *event,
>> +			     struct perf_sample *sample)
>=20
> This one follows the existing style, great.
>=20
>> +{
>> +	if (dump_trace)
>> +		perf_event__fprintf_ksymbol(event, stdout);
>> +
>> +	if (event->ksymbol_event.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
>> +		return machine__process_ksymbol_unregister(machine, event,
>> +							   sample);
>> +	return machine__process_ksymbol_register(machine, event, sample);
>> +}
>> +
>> static void dso__adjust_kmod_long_name(struct dso *dso, const char *file=
name)
>> {
>> 	const char *dup_filename;
>> @@ -1812,6 +1867,8 @@ int machine__process_event(struct machine *machine=
, union perf_event *event,
>> 	case PERF_RECORD_SWITCH:
>> 	case PERF_RECORD_SWITCH_CPU_WIDE:
>> 		ret =3D machine__process_switch_event(machine, event); break;
>> +	case PERF_RECORD_KSYMBOL:
>> +		ret =3D machine__process_ksymbol(machine, event, sample); break;
>> 	default:
>> 		ret =3D -1;
>> 		break;
>> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
>> index a5d1da60f751..4ecd380ce1b4 100644
>> --- a/tools/perf/util/machine.h
>> +++ b/tools/perf/util/machine.h
>> @@ -130,6 +130,9 @@ int machine__process_mmap_event(struct machine *mach=
ine, union perf_event *event
>> 				struct perf_sample *sample);
>> int machine__process_mmap2_event(struct machine *machine, union perf_eve=
nt *event,
>> 				 struct perf_sample *sample);
>> +int machine__process_ksymbol(struct machine *machine,
>> +			     union perf_event *event,
>> +			     struct perf_sample *sample);
>> int machine__process_event(struct machine *machine, union perf_event *ev=
ent,
>> 				struct perf_sample *sample);
>>=20
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 5456c84c7dd1..2efa75bb0c0a 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -376,6 +376,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool=
)
>> 		tool->itrace_start =3D perf_event__process_itrace_start;
>> 	if (tool->context_switch =3D=3D NULL)
>> 		tool->context_switch =3D perf_event__process_switch;
>> +	if (tool->ksymbol =3D=3D NULL)
>> +		tool->ksymbol =3D perf_event__process_ksymbol;
>> 	if (tool->read =3D=3D NULL)
>> 		tool->read =3D process_event_sample_stub;
>> 	if (tool->throttle =3D=3D NULL)
>> @@ -1305,6 +1307,8 @@ static int machines__deliver_event(struct machines=
 *machines,
>> 	case PERF_RECORD_SWITCH:
>> 	case PERF_RECORD_SWITCH_CPU_WIDE:
>> 		return tool->context_switch(tool, event, sample, machine);
>> +	case PERF_RECORD_KSYMBOL:
>> +		return tool->ksymbol(tool, event, sample, machine);
>> 	default:
>> 		++evlist->stats.nr_unknown_events;
>> 		return -1;
>> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
>> index 56e4ca54020a..9c81ca2f3cf7 100644
>> --- a/tools/perf/util/tool.h
>> +++ b/tools/perf/util/tool.h
>> @@ -53,7 +53,9 @@ struct perf_tool {
>> 			itrace_start,
>> 			context_switch,
>> 			throttle,
>> -			unthrottle;
>> +			unthrottle,
>> +			ksymbol;
>> +
>> 	event_attr_op	attr;
>> 	event_attr_op	event_update;
>> 	event_op2	tracing_data;
>> --=20
>> 2.17.1
>=20
> --=20
>=20
> - Arnaldo

