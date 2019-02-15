Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC44C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477132086C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gVK688lm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BwFydWqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfBORFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:05:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45044 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfBORFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:05:02 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FH4HVf021781;
        Fri, 15 Feb 2019 09:04:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=p0JnZpTtYsCXb56JXsUHH2M8KB0Ub8+v05VJhhQTbhc=;
 b=gVK688lmCWqFCuxc6EnJXmc6wFuhI/V55YJm4ESyjTNj78PXmuMXF90Auv7KOxlMdv16
 M/DMeYnnbij+jK1uDGBBf7f+s+fP+0wJGrPSlc1mOSvPu2NlA81EyqPVEnIken7wKR+K
 qNkoc5dA1TYmA6GKR3RQZW6P1fdjOmUms/o= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qnymkge03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 09:04:30 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:04:20 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 09:04:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0JnZpTtYsCXb56JXsUHH2M8KB0Ub8+v05VJhhQTbhc=;
 b=BwFydWqnKlbkJDYkXRqMCuF1yQOQXPonVCMmYpK+UKvgZ4CHihgySBMTGI6QZqcVF6rmPYpgX/Q5HM54vfYfYFdP2zbJ81gawp2+Wkt76Jg26EqmkP2XvorQOty+dIQrywDCZIuJUXF5B+g1ObFw3F412U6T214FJ0hHvDiTctA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1901.namprd15.prod.outlook.com (10.174.100.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 17:04:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9%8]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 17:04:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Topic: [PATCH v2 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Index: AQHUxMGKE71SOf+v40WQO+KMDc6QG6Xg6heAgAAtWYA=
Date:   Fri, 15 Feb 2019 17:04:14 +0000
Message-ID: <1481E259-29EB-4E54-BB5D-A8446612DAD8@fb.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-4-songliubraving@fb.com>
 <20190215142154.GB5784@redhat.com>
In-Reply-To: <20190215142154.GB5784@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:e850]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ec13bd9-a784-4f7c-cdee-08d693679cd9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1901;
x-ms-traffictypediagnostic: MWHPR15MB1901:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1901;20:e50yeWP4wfB9kJzelawTHh2pcpCAAlTojOrkgUG6HMshgb5GIWS0I84pscK+AGn5ufirEzgHeowksPsTqKkZcKDf8O8ACFZLUhmJ8a7v8WQXgc8Bdh6dLTlJj4aEKTDI4s2VrCwRaYkiY3QWG34d8Hc+Rhl2DsZnWAw9HiOyhLk=
x-microsoft-antispam-prvs: <MWHPR15MB19019E2EC8055585212B4327B3600@MWHPR15MB1901.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(6436002)(53546011)(6512007)(36756003)(97736004)(8676002)(53936002)(8936002)(105586002)(106356001)(81156014)(81166006)(229853002)(305945005)(86362001)(54906003)(93886005)(82746002)(7736002)(71190400001)(71200400001)(83716004)(30864003)(6246003)(316002)(50226002)(4326008)(6916009)(99286004)(486006)(2616005)(6116002)(476003)(76176011)(11346002)(446003)(478600001)(2906002)(25786009)(6506007)(6486002)(46003)(33656002)(57306001)(256004)(14444005)(68736007)(186003)(14454004)(102836004)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1901;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sR0zRqDb+VSoK6jxfN4FAP0kLRJCtXR1qZc7TuoOQyKWx79XDApWXNB8sm99vJ8GjRaR4WqSV859qt663dy6p2xoc87MasuAV1ZdM+KLvHwFkJiUhblWxwdVFTtnNza8LsVQYy6LLgjknZySSZuFdwKqTBQ5FZXKvbK1ae8hT+qHdZX5m6FCwBAfr4pZQ932LczVxYUyuE9CWfJdim7DfqdyUKk3iyutMO5OYXvIy0bfLyc926gexOif7nCahOQXtOJvLPVz35bpBa63YXZGY5aNGxfFVaZcXt/nIEvoDJYTOk7wdcCme9ArzQjoyN1SgdFr/owz6ikR3gJ/8xVTv9AKrlcMDW+SaXu6ibxyunKNjo59iOjJ+bgybV6Fnr/MOCHW88daCKRwraIELmBi2QohqV3VOT1Qv4mqq9JvxXw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E88E95DEDD0A14AADA74087ADC9234A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec13bd9-a784-4f7c-cdee-08d693679cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:04:14.0907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1901
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 6:21 AM, Arnaldo Carvalho de Melo <acme@redhat.com> w=
rote:
>=20
> Em Thu, Feb 14, 2019 at 04:00:06PM -0800, Song Liu escreveu:
>> bpf_prog_info contains information necessary to annotate bpf programs.
>> This patch saves bpf_prog_info for bpf programs loaded in the system.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/builtin-record.c |  2 +-
>> tools/perf/builtin-top.c    |  2 +-
>> tools/perf/util/bpf-event.c | 39 +++++++++++++----
>> tools/perf/util/bpf-event.h | 15 +++++--
>> tools/perf/util/env.c       | 83 +++++++++++++++++++++++++++++++++++++
>> tools/perf/util/env.h       | 14 +++++++
>> 6 files changed, 142 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 88ea11d57c6f..2355e0a9eda0 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1083,7 +1083,7 @@ static int record__synthesize(struct record *rec, =
bool tail)
>> 		return err;
>> 	}
>>=20
>> -	err =3D perf_event__synthesize_bpf_events(tool, process_synthesized_ev=
ent,
>> +	err =3D perf_event__synthesize_bpf_events(session, process_synthesized=
_event,
>> 						machine, opts);
>> 	if (err < 0)
>> 		pr_warning("Couldn't synthesize bpf events.\n");
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index 5a486d4de56e..27d8d42e0a4d 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -1216,7 +1216,7 @@ static int __cmd_top(struct perf_top *top)
>>=20
>> 	init_process_thread(top);
>>=20
>> -	ret =3D perf_event__synthesize_bpf_events(&top->tool, perf_event__proc=
ess,
>> +	ret =3D perf_event__synthesize_bpf_events(top->session, perf_event__pr=
ocess,
>> 						&top->session->machines.host,
>> 						&top->record_opts);
>> 	if (ret < 0)
>> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
>> index e6dfb95029e5..ead599bc4f4e 100644
>> --- a/tools/perf/util/bpf-event.c
>> +++ b/tools/perf/util/bpf-event.c
>> @@ -1,15 +1,13 @@
>> // SPDX-License-Identifier: GPL-2.0
>> #include <errno.h>
>> #include <stdlib.h>
>> -#include <bpf/bpf.h>
>> -#include <bpf/btf.h>
>> -#include <bpf/libbpf.h>
>> -#include <linux/btf.h>
>=20
> I think you need these here, since in this C file you will use the
> definitions for these structs, see further comments below.
>=20
>> #include <linux/err.h>
>> #include "bpf-event.h"
>> #include "debug.h"
>> #include "symbol.h"
>> #include "machine.h"
>> +#include "env.h"
>> +#include "session.h"
>>=20
>> #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
>>=20
>> @@ -42,7 +40,7 @@ int machine__process_bpf_event(struct machine *machine=
 __maybe_unused,
>>  *   -1 for failures;
>>  *   -2 for lack of kernel support.
>>  */
>> -static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>> +static int perf_event__synthesize_one_bpf_prog(struct perf_session *ses=
sion,
>> 					       perf_event__handler_t process,
>> 					       struct machine *machine,
>> 					       int fd,
>> @@ -52,17 +50,29 @@ static int perf_event__synthesize_one_bpf_prog(struc=
t perf_tool *tool,
>> 	struct ksymbol_event *ksymbol_event =3D &event->ksymbol_event;
>> 	struct bpf_event *bpf_event =3D &event->bpf_event;
>> 	struct bpf_prog_info_linear *info_linear;
>> +	struct perf_tool *tool =3D session->tool;
>> +	struct bpf_prog_info_node *info_node;
>> 	struct bpf_prog_info *info;
>> 	struct btf *btf =3D NULL;
>> 	bool has_btf =3D false;
>> +	struct perf_env *env;
>> 	u32 sub_prog_cnt, i;
>> 	int err =3D 0;
>> 	u64 arrays;
>>=20
>> +	/*
>> +	 * for perf-record and perf-report use header.env;
>> +	 * otherwise, use global perf_env.
>> +	 */
>> +	env =3D session->data ? &session->header.env : &perf_env;
>> +
>> 	arrays =3D 1UL << BPF_PROG_INFO_JITED_KSYMS;
>> 	arrays |=3D 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
>> 	arrays |=3D 1UL << BPF_PROG_INFO_FUNC_INFO;
>> 	arrays |=3D 1UL << BPF_PROG_INFO_PROG_TAGS;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_JITED_INSNS;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_LINE_INFO;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
>>=20
>> 	info_linear =3D bpf_program__get_prog_info_linear(fd, arrays);
>> 	if (IS_ERR_OR_NULL(info_linear)) {
>> @@ -151,8 +161,8 @@ static int perf_event__synthesize_one_bpf_prog(struc=
t perf_tool *tool,
>> 						     machine, process);
>> 	}
>>=20
>> -	/* Synthesize PERF_RECORD_BPF_EVENT */
>> 	if (opts->bpf_event) {
>> +		/* Synthesize PERF_RECORD_BPF_EVENT */
>> 		*bpf_event =3D (struct bpf_event){
>> 			.header =3D {
>> 				.type =3D PERF_RECORD_BPF_EVENT,
>> @@ -165,6 +175,19 @@ static int perf_event__synthesize_one_bpf_prog(stru=
ct perf_tool *tool,
>> 		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
>> 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
>> 		event->header.size +=3D machine->id_hdr_size;
>> +
>> +		/* save bpf_prog_info to env */
>> +		info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>> +		if (info_node) {
>> +			info_node->info_linear =3D info_linear;
>> +			perf_env__insert_bpf_prog_info(env, info_node);
>> +			info_linear =3D NULL;
>> +		}
>> +
>> +		/*
>> +		 * process after saving bpf_prog_info to env, so that
>> +		 * required information is ready for look up
>> +		 */
>> 		err =3D perf_tool__process_synth_event(tool, event,
>> 						     machine, process);
>> 	}
>> @@ -175,7 +198,7 @@ static int perf_event__synthesize_one_bpf_prog(struc=
t perf_tool *tool,
>> 	return err ? -1 : 0;
>> }
>>=20
>> -int perf_event__synthesize_bpf_events(struct perf_tool *tool,
>> +int perf_event__synthesize_bpf_events(struct perf_session *session,
>> 				      perf_event__handler_t process,
>> 				      struct machine *machine,
>> 				      struct record_opts *opts)
>> @@ -209,7 +232,7 @@ int perf_event__synthesize_bpf_events(struct perf_to=
ol *tool,
>> 			continue;
>> 		}
>>=20
>> -		err =3D perf_event__synthesize_one_bpf_prog(tool, process,
>> +		err =3D perf_event__synthesize_one_bpf_prog(session, process,
>> 							  machine, fd,
>> 							  event, opts);
>> 		close(fd);
>> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
>> index 7890067e1a37..11e6730b6105 100644
>> --- a/tools/perf/util/bpf-event.h
>> +++ b/tools/perf/util/bpf-event.h
>> @@ -3,19 +3,28 @@
>> #define __PERF_BPF_EVENT_H
>>=20
>> #include <linux/compiler.h>
>> +#include <bpf/bpf.h>
>> +#include <bpf/btf.h>
>> +#include <bpf/libbpf.h>
>> +#include <linux/btf.h>
>=20
> Are you sure you'll need all of these headers here? Perhaps just some
> forward declarations will do?
>=20
> In fact the only bpf or btf structure here seems to be
> bpf_prog_info_linear, which needs ust a forward declaration.
>=20
> Avoiding these includes reduces the build time, and since the build-test
> target does many builds and I want to build this in many containers, we
> should try to reduce the build time by using just what is needed in each
> header and C file. Also during development it helps with not rebuilding
> tons of things when something unrelated changes in a header, etc.

I see. I will fix this in next version.=20

>=20
> - Arnaldo
>=20
>> +#include <linux/rbtree.h>
>> #include "event.h"
>>=20
>> struct machine;
>> union perf_event;
>> struct perf_sample;
>> -struct perf_tool;
>> struct record_opts;
>>=20
>> +struct bpf_prog_info_node {
>> +	struct bpf_prog_info_linear	*info_linear;
>> +	struct rb_node			rb_node;
>> +};
>> +
>> #ifdef HAVE_LIBBPF_SUPPORT
>> int machine__process_bpf_event(struct machine *machine, union perf_event=
 *event,
>> 			       struct perf_sample *sample);
>>=20
>> -int perf_event__synthesize_bpf_events(struct perf_tool *tool,
>> +int perf_event__synthesize_bpf_events(struct perf_session *session,
>> 				      perf_event__handler_t process,
>> 				      struct machine *machine,
>> 				      struct record_opts *opts);
>> @@ -27,7 +36,7 @@ static inline int machine__process_bpf_event(struct ma=
chine *machine __maybe_unu
>> 	return 0;
>> }
>>=20
>> -static inline int perf_event__synthesize_bpf_events(struct perf_tool *t=
ool __maybe_unused,
>> +static inline int perf_event__synthesize_bpf_events(struct perf_session=
 *session __maybe_unused,
>> 						    perf_event__handler_t process __maybe_unused,
>> 						    struct machine *machine __maybe_unused,
>> 						    struct record_opts *opts __maybe_unused)
>> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
>> index 4c23779e271a..665b6fe3c7b2 100644
>> --- a/tools/perf/util/env.c
>> +++ b/tools/perf/util/env.c
>> @@ -8,10 +8,86 @@
>>=20
>> struct perf_env perf_env;
>>=20
>> +void perf_env__insert_bpf_prog_info(struct perf_env *env,
>> +				    struct bpf_prog_info_node *info_node)
>> +{
>> +	__u32 prog_id =3D info_node->info_linear->info.id;
>> +	struct bpf_prog_info_node *node;
>> +	struct rb_node *parent =3D NULL;
>> +	struct rb_node **p;
>> +
>> +	down_write(&env->bpf_info_lock);
>> +	p =3D &env->bpf_prog_infos.rb_node;
>> +
>> +	while (*p !=3D NULL) {
>> +		parent =3D *p;
>> +		node =3D rb_entry(parent, struct bpf_prog_info_node, rb_node);
>> +		if (prog_id < node->info_linear->info.id) {
>> +			p =3D &(*p)->rb_left;
>> +		} else if (prog_id > node->info_linear->info.id) {
>> +			p =3D &(*p)->rb_right;
>> +		} else {
>> +			pr_debug("duplicated bpf prog info %u\n", prog_id);
>> +			up_write(&env->bpf_info_lock);
>> +			return;
>> +		}
>> +	}
>> +
>> +	rb_link_node(&info_node->rb_node, parent, p);
>> +	rb_insert_color(&info_node->rb_node, &env->bpf_prog_infos);
>> +	up_write(&env->bpf_info_lock);
>> +}
>> +
>> +struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env=
 *env,
>> +							__u32 prog_id)
>> +{
>> +	struct bpf_prog_info_node *node =3D NULL;
>> +	struct rb_node *n;
>> +
>> +	down_read(&env->bpf_info_lock);
>> +	n =3D env->bpf_prog_infos.rb_node;
>> +
>> +	while (n) {
>> +		node =3D rb_entry(n, struct bpf_prog_info_node, rb_node);
>> +		if (prog_id < node->info_linear->info.id)
>> +			n =3D n->rb_left;
>> +		else if (prog_id > node->info_linear->info.id)
>> +			n =3D n->rb_right;
>> +		else
>> +			break;
>> +	}
>> +
>> +	up_read(&env->bpf_info_lock);
>> +	return node;
>> +}
>> +
>> +/* purge data in bpf_prog_infos tree */
>> +static void purge_bpf_info(struct perf_env *env)
>> +{
>> +	struct rb_root *root;
>> +	struct rb_node *next;
>> +
>> +	down_write(&env->bpf_info_lock);
>> +
>> +	root =3D &env->bpf_prog_infos;
>> +	next =3D rb_first(root);
>> +
>> +	while (next) {
>> +		struct bpf_prog_info_node *node;
>> +
>> +		node =3D rb_entry(next, struct bpf_prog_info_node, rb_node);
>> +		next =3D rb_next(&node->rb_node);
>> +		rb_erase_init(&node->rb_node, root);
>> +		free(node);
>> +	}
>> +	up_write(&env->bpf_info_lock);
>> +}
>> +
>> void perf_env__exit(struct perf_env *env)
>> {
>> 	int i;
>>=20
>> +	purge_bpf_info(env);
>> 	zfree(&env->hostname);
>> 	zfree(&env->os_release);
>> 	zfree(&env->version);
>> @@ -38,6 +114,12 @@ void perf_env__exit(struct perf_env *env)
>> 	zfree(&env->memory_nodes);
>> }
>>=20
>> +static void init_bpf_rb_trees(struct perf_env *env)
>> +{
>> +	env->bpf_prog_infos =3D RB_ROOT;
>> +	init_rwsem(&env->bpf_info_lock);
>> +}
>> +
>> int perf_env__set_cmdline(struct perf_env *env, int argc, const char *ar=
gv[])
>> {
>> 	int i;
>> @@ -59,6 +141,7 @@ int perf_env__set_cmdline(struct perf_env *env, int a=
rgc, const char *argv[])
>>=20
>> 	env->nr_cmdline =3D argc;
>>=20
>> +	init_bpf_rb_trees(env);
>> 	return 0;
>> out_free:
>> 	zfree(&env->cmdline_argv);
>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>> index d01b8355f4ca..a6d25e91bc98 100644
>> --- a/tools/perf/util/env.h
>> +++ b/tools/perf/util/env.h
>> @@ -3,7 +3,10 @@
>> #define __PERF_ENV_H
>>=20
>> #include <linux/types.h>
>> +#include <linux/rbtree.h>
>> #include "cpumap.h"
>> +#include "rwsem.h"
>=20
> You don't need the following header, just use a forward declaration for
> the sole struct you use with a pointer:
>=20
> struct bpf_prog_info_node;
>=20
>> +#include "bpf-event.h"
>>=20
>> struct cpu_topology_map {
>> 	int	socket_id;
>> @@ -64,6 +67,13 @@ struct perf_env {
>> 	struct memory_node	*memory_nodes;
>> 	unsigned long long	 memory_bsize;
>> 	u64                     clockid_res_ns;
>> +
>> +	/*
>> +	 * bpf_info_lock protects bpf rbtrees. This is needed because the
>> +	 * trees are accessed by different threads in perf-top
>> +	 */
>> +	struct rw_semaphore	bpf_info_lock;
>> +	struct rb_root		bpf_prog_infos;
>=20
> Please group this into a structure, i.e.:
>=20
> 	struct {
> 		struct rw_semaphore lock;
> 		struct rb_root	    infos;
> 	} bpf_progs;

Will fix this in next version.=20

>=20
>> };
>>=20
>> extern struct perf_env perf_env;
>> @@ -80,4 +90,8 @@ const char *perf_env__arch(struct perf_env *env);
>> const char *perf_env__raw_arch(struct perf_env *env);
>> int perf_env__nr_cpus_avail(struct perf_env *env);
>>=20
>> +void perf_env__insert_bpf_prog_info(struct perf_env *env,
>> +				    struct bpf_prog_info_node *info_node);
>> +struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env=
 *env,
>> +							__u32 prog_id);
>> #endif /* __PERF_ENV_H */
>> --=20
>> 2.17.1

