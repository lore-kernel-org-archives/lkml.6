Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF372190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oSxweqvG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ClIyf1Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfBOROL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:14:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36302 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfBOROL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:14:11 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FH89KZ003859;
        Fri, 15 Feb 2019 09:13:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=heNyk4sgRKxeKSGeM3rqExMUtGuNWqJOl8rlBhytMgs=;
 b=oSxweqvGDSQPZrH4eE2KAk/p42zb/Vv9TMHGrENzeRlXLBXwWd1IxvsFIViOOKb/TP+z
 Yo/0WT+TgTMOPeLZnhDXKTqjK1fX1tS0KlMCPeQ3VxWU+IxyHkNL1PSQr7wjPgvF2Hhz
 K8L9ocXXY09jE6V4xDD5CgSTYXIe6spG6uw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qp0txg5xw-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 09:13:41 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:13:17 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:13:16 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 09:13:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heNyk4sgRKxeKSGeM3rqExMUtGuNWqJOl8rlBhytMgs=;
 b=ClIyf1Ukt/K4mRiYfEytirrDq9f+++EXqZrGsVBNoIcifyBdQPWXR4trXCcw+vRaealWT/BF+Un4xINyS3hYT3U2qg819Y5wzsB265XoEQwmKw6ejsp4ahikiumy/G9e3fJRqUpGb3dquzpAzogt2dXix7hdlB/1lOiYY0Etv80=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1823.namprd15.prod.outlook.com (10.174.255.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Fri, 15 Feb 2019 17:13:01 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9%8]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 17:13:01 +0000
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
Subject: Re: [PATCH v2 perf,bpf 11/11] perf, bpf: save information about short
 living bpf programs
Thread-Topic: [PATCH v2 perf,bpf 11/11] perf, bpf: save information about
 short living bpf programs
Thread-Index: AQHUxMGajwOXFyznb0+c5ufOc/HDYKXg76MAgAAqQQA=
Date:   Fri, 15 Feb 2019 17:13:01 +0000
Message-ID: <62DB92A4-F708-4E89-B668-4EAFD0FA6731@fb.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000045.2592135-1-songliubraving@fb.com>
 <20190215000045.2592135-2-songliubraving@fb.com>
 <20190215144146.GF5784@redhat.com>
In-Reply-To: <20190215144146.GF5784@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:e850]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca850a3e-a6f4-4a27-d84c-08d69368d71a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1823;
x-ms-traffictypediagnostic: MWHPR15MB1823:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1823;20:t9wLGyWJ7THhFsscYAjJ881cV75zv4IHdNXO6Gwpspp5r1Egbw+cSpg37vX/lq/aV3JtwpVVaSSahN2/IVuO2p3Ett2tau4BXFtlcRDxCXAX41v0PQwzOlnN7FDKdFEkq9Q9aVEPQeujRHdkpSGWtfmCuQicg4a6oEsqxB2LJwQ=
x-microsoft-antispam-prvs: <MWHPR15MB18231BC177CD2309B29691A9B3600@MWHPR15MB1823.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(81166006)(81156014)(30864003)(86362001)(82746002)(305945005)(8676002)(476003)(93886005)(102836004)(2906002)(83716004)(54906003)(229853002)(76176011)(2616005)(6346003)(11346002)(7736002)(316002)(446003)(99286004)(33656002)(105586002)(97736004)(106356001)(71200400001)(6506007)(14454004)(4326008)(53546011)(6512007)(478600001)(25786009)(486006)(71190400001)(46003)(68736007)(6436002)(6246003)(6486002)(36756003)(50226002)(53936002)(6116002)(186003)(57306001)(14444005)(6916009)(8936002)(256004)(142933001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1823;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aZEUSIRs08ttCsAGkdneZ2FMTGYYsCjHD9rHc3mMKq/PACi+vAEGyE7QpiiyeOeBosyYIJpv5am/ux1wNIn/XNoVAWN8MnaWAEB4rRZWqPTSkVBPld+4/uSo8RxRxCNqAgBVN+5WddTj/qUZf53AIwt37isaH0AeHsu1g42D6sq/qTSzzh3ABQqFL09Ee4eQLh5Nu8AG4yABCPpQ9MqGXAdHGvmNtaenwIAXs7XlagYTVOnl3axb9577UbVE4NE+Cud1kO2+yMfwLxznIy2E8p9udQmk4y/ph/kgbJ0CNQooQSGDR3z/a0SVCKOklZ8B1qDcB8UCu6tEnjq0Ij4V9d0iTwyNHZs7rI+VKh9kNl5NFXaUX9hV36zYvuF0UevSVXzlDRVgTBvbScWBDE8pdMKTBnJ1smOUEY5u2UilJkg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <03660C06A6C50E42BFEE75DBDD3B48BD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca850a3e-a6f4-4a27-d84c-08d69368d71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:13:01.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1823
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 6:41 AM, Arnaldo Carvalho de Melo <acme@redhat.com> w=
rote:
>=20
> Em Thu, Feb 14, 2019 at 04:00:45PM -0800, Song Liu escreveu:
>> To annotate bpf programs in perf, it is necessary to save information in
>> bpf_prog_info and btf. For short living bpf program, it is necessary to
>> save these information before it is unloaded.
>>=20
>> This patch saves these information in a separate thread. This thread
>> creates its own evlist, that only tracks bpf events. This evlists uses
>> ring buffer with very low watermark for lower latency. When bpf load
>> events are received, this thread tries to gather information via sys_bpf
>> and save it in perf_env.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/builtin-record.c |  13 ++++
>> tools/perf/builtin-top.c    |  12 ++++
>> tools/perf/util/bpf-event.c | 129 ++++++++++++++++++++++++++++++++++++
>> tools/perf/util/bpf-event.h |  22 ++++++
>> tools/perf/util/evlist.c    |  20 ++++++
>> tools/perf/util/evlist.h    |   2 +
>> 6 files changed, 198 insertions(+)
>>=20
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 2355e0a9eda0..46abb44aaaab 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1106,6 +1106,8 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>> 	struct perf_data *data =3D &rec->data;
>> 	struct perf_session *session;
>> 	bool disabled =3D false, draining =3D false;
>> +	struct bpf_event_poll_args poll_args;
>> +	bool bpf_thread_running =3D false;
>> 	int fd;
>>=20
>> 	atexit(record__sig_exit);
>> @@ -1206,6 +1208,14 @@ static int __cmd_record(struct record *rec, int a=
rgc, const char **argv)
>> 		goto out_child;
>> 	}
>>=20
>> +	if (rec->opts.bpf_event) {
>> +		poll_args.env =3D &session->header.env;
>> +		poll_args.target =3D &rec->opts.target;
>> +		poll_args.done =3D &done;
>> +		if (bpf_event__start_polling_thread(&poll_args) =3D=3D 0)
>> +			bpf_thread_running =3D true;
>> +	}
>> +
>> 	err =3D record__synthesize(rec, false);
>> 	if (err < 0)
>> 		goto out_child;
>> @@ -1456,6 +1466,9 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>>=20
>> out_delete_session:
>> 	perf_session__delete(session);
>> +
>> +	if (bpf_thread_running)
>> +		bpf_event__stop_polling_thread(&poll_args);
>> 	return status;
>> }
>>=20
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index 5271d7211b9c..2586ee081967 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -1524,10 +1524,12 @@ int cmd_top(int argc, const char **argv)
>> 			"number of thread to run event synthesize"),
>> 	OPT_END()
>> 	};
>> +	struct bpf_event_poll_args poll_args;
>> 	const char * const top_usage[] =3D {
>> 		"perf top [<options>]",
>> 		NULL
>> 	};
>> +	bool bpf_thread_running =3D false;
>> 	int status =3D hists__init();
>>=20
>> 	if (status < 0)
>> @@ -1652,8 +1654,18 @@ int cmd_top(int argc, const char **argv)
>> 		signal(SIGWINCH, winch_sig);
>> 	}
>>=20
>> +	if (top.record_opts.bpf_event) {
>> +		poll_args.env =3D &perf_env;
>> +		poll_args.target =3D target;
>> +		poll_args.done =3D &done;
>> +		if (bpf_event__start_polling_thread(&poll_args) =3D=3D 0)
>> +			bpf_thread_running =3D true;
>> +	}
>> 	status =3D __cmd_top(&top);
>>=20
>> +	if (bpf_thread_running)
>> +		bpf_event__stop_polling_thread(&poll_args);
>> +
>> out_delete_evlist:
>> 	perf_evlist__delete(top.evlist);
>>=20
>> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
>> index 4f347d61ed96..0caf137c515b 100644
>> --- a/tools/perf/util/bpf-event.c
>> +++ b/tools/perf/util/bpf-event.c
>> @@ -8,6 +8,7 @@
>> #include "machine.h"
>> #include "env.h"
>> #include "session.h"
>> +#include "evlist.h"
>>=20
>> #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
>>=20
>> @@ -316,3 +317,131 @@ int perf_event__synthesize_bpf_events(struct perf_=
session *session,
>> 	free(event);
>> 	return err;
>> }
>> +
>> +static void perf_env_add_bpf_info(struct perf_env *env, u32 id)
>> +{
>> +	struct bpf_prog_info_linear *info_linear;
>> +	struct bpf_prog_info_node *info_node;
>> +	struct btf *btf =3D NULL;
>> +	u64 arrays;
>> +	u32 btf_id;
>> +	int fd;
>> +
>> +	fd =3D bpf_prog_get_fd_by_id(id);
>> +	if (fd < 0)
>> +		return;
>> +
>> +	arrays =3D 1UL << BPF_PROG_INFO_JITED_KSYMS;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_FUNC_INFO;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_PROG_TAGS;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_JITED_INSNS;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_LINE_INFO;
>> +	arrays |=3D 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
>> +
>> +	info_linear =3D bpf_program__get_prog_info_linear(fd, arrays);
>> +	if (IS_ERR_OR_NULL(info_linear)) {
>> +		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
>> +		goto out;
>> +	}
>> +
>> +	btf_id =3D info_linear->info.btf_id;
>> +
>> +	info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>> +	if (info_node) {
>> +		info_node->info_linear =3D info_linear;
>> +		perf_env__insert_bpf_prog_info(env, info_node);
>> +	} else
>> +		free(info_linear);
>> +
>> +	if (btf_id =3D=3D 0)
>> +		goto out;
>> +
>> +	if (btf__get_from_id(btf_id, &btf)) {
>> +		pr_debug("%s: failed to get BTF of id %u, aborting\n",
>> +			 __func__, btf_id);
>> +		goto out;
>> +	}
>> +	perf_fetch_btf(env, btf_id, btf);
>> +
>> +out:
>> +	free(btf);
>> +	close(fd);
>> +}
>> +
>> +static void *bpf_poll_thread(void *arg)
>> +{
>> +	struct bpf_event_poll_args *args =3D arg;
>> +	int i;
>> +
>> +	while (!*(args->done)) {
>> +		perf_evlist__poll(args->evlist, 1000);
>> +
>> +		for (i =3D 0; i < args->evlist->nr_mmaps; i++) {
>> +			struct perf_mmap *map =3D &args->evlist->mmap[i];
>> +			union perf_event *event;
>> +
>> +			if (perf_mmap__read_init(map))
>> +				continue;
>> +			while ((event =3D perf_mmap__read_event(map)) !=3D NULL) {
>> +				pr_debug("processing vip event of type %d\n",
>> +					 event->header.type);
>> +				switch (event->header.type) {
>> +				case PERF_RECORD_BPF_EVENT:
>> +					if (event->bpf_event.type !=3D PERF_BPF_EVENT_PROG_LOAD)
>> +						break;
>> +					perf_env_add_bpf_info(args->env, event->bpf_event.id);
>> +					break;
>> +				default:
>> +					break;
>> +				}
>> +				perf_mmap__consume(map);
>> +			}
>> +			perf_mmap__read_done(map);
>> +		}
>> +	}
>> +	return NULL;
>> +}
>> +
>> +pthread_t poll_thread;
>> +
>> +int bpf_event__start_polling_thread(struct bpf_event_poll_args *args)
>> +{
>> +	struct perf_evsel *counter;
>> +
>> +	args->evlist =3D perf_evlist__new();
>> +
>> +	if (args->evlist =3D=3D NULL)
>> +		return -1;
>> +
>> +	if (perf_evlist__create_maps(args->evlist, args->target))
> 		goto out_delete_evlist;
>> +
>> +	if (perf_evlist__add_bpf_tracker(args->evlist))
> 		goto out_delete_evlist;
>> +
>> +	evlist__for_each_entry(args->evlist, counter) {
>> +		if (perf_evsel__open(counter, args->evlist->cpus,
>> +				     args->evlist->threads) < 0)
> 			goto out_delete_evlist;
>> +	}
>> +
>> +	if (perf_evlist__mmap(args->evlist, UINT_MAX))
> 		goto out_delete_evlist;
>> +
>> +	evlist__for_each_entry(args->evlist, counter) {
>> +		if (perf_evsel__enable(counter))
> 			goto out_delete_evlist;
>> +	}
>> +
>> +	if (pthread_create(&poll_thread, NULL, bpf_poll_thread, args))
> 		goto out_delete_evlist;=09
>> +
>> +	return 0;
> out_delete_evlist:
> 	perf_evlist__delete(args->evlist);
> 	args->evlist =3D NULL;
>=20
> 	return -1;
>> +}
>> +
>> +void bpf_event__stop_polling_thread(struct bpf_event_poll_args *args)
>> +{
>> +	pthread_join(poll_thread, NULL);
>> +	perf_evlist__exit(args->evlist);
>> +}
>> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
>> index c4f0f1395ea5..61914827c1e3 100644
>> --- a/tools/perf/util/bpf-event.h
>> +++ b/tools/perf/util/bpf-event.h
>> @@ -12,12 +12,17 @@
>> #include <bpf/libbpf.h>
>> #include <linux/btf.h>
>> #include <linux/rbtree.h>
>> +#include <pthread.h>
>> +#include <api/fd/array.h>
>> #include "event.h"
>>=20
>> struct machine;
>> union perf_event;
>> +struct perf_env;
>> struct perf_sample;
>> struct record_opts;
>> +struct evlist;
>> +struct target;
>>=20
>> struct bpf_prog_info_node {
>> 	struct bpf_prog_info_linear	*info_linear;
>> @@ -31,6 +36,13 @@ struct btf_node {
>> 	char		data[];
>> };
>>=20
>> +struct bpf_event_poll_args {
>> +	struct perf_env		*env;
>> +	struct perf_evlist	*evlist;
>> +	struct target		*target;
>> +	volatile int		*done;
>> +};
>> +
>> #ifdef HAVE_LIBBPF_SUPPORT
>> int machine__process_bpf_event(struct machine *machine, union perf_event=
 *event,
>> 			       struct perf_sample *sample);
>> @@ -39,6 +51,8 @@ int perf_event__synthesize_bpf_events(struct perf_sess=
ion *session,
>> 				      perf_event__handler_t process,
>> 				      struct machine *machine,
>> 				      struct record_opts *opts);
>> +int bpf_event__start_polling_thread(struct bpf_event_poll_args *args);
>> +void bpf_event__stop_polling_thread(struct bpf_event_poll_args *args);
>> #else
>> static inline int machine__process_bpf_event(struct machine *machine __m=
aybe_unused,
>> 					     union perf_event *event __maybe_unused,
>> @@ -54,5 +68,13 @@ static inline int perf_event__synthesize_bpf_events(s=
truct perf_session *session
>> {
>> 	return 0;
>> }
>> +
>> +static inline int bpf_event__start_polling_thread(struct bpf_event_poll=
_args *args __maybe_unused)
>> +{
>> +	return 0;
>> +}
>> +void bpf_event__stop_polling_thread(struct bpf_event_poll_args *args __=
maybe_unused)
>> +{
>> +}
>> #endif // HAVE_LIBBPF_SUPPORT
>> #endif
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 8c902276d4b4..612c079579ce 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -271,6 +271,26 @@ int perf_evlist__add_dummy(struct perf_evlist *evli=
st)
>> 	return 0;
>> }
>>=20
>> +int perf_evlist__add_bpf_tracker(struct perf_evlist *evlist)
>> +{
>> +	struct perf_event_attr attr =3D {
>> +		.type	          =3D PERF_TYPE_SOFTWARE,
>> +		.config           =3D PERF_COUNT_SW_DUMMY,
>> +		.watermark        =3D 1,
>> +		.bpf_event        =3D 1,
>> +		.wakeup_watermark =3D 1,
>> +		.size	   =3D sizeof(attr), /* to capture ABI version */
>> +	};
>> +	struct perf_evsel *evsel =3D perf_evsel__new_idx(&attr,
>> +						       evlist->nr_entries);
>> +
>> +	if (evsel =3D=3D NULL)
>> +		return -ENOMEM;
>> +
>> +	perf_evlist__add(evlist, evsel);
>=20
> You could use:
>=20
> 	struct perf_evlist *evlist =3D perf_evlist__new_dummy();
> 	if (evlist !=3D NULL) {
> 		struct perf_evsel *evsel =3D=3D perf_evlist__first(evlist);
> 		evsel->attr.bpf_event =3D evsel->attr.watermark =3D evsel->attr.wakeup_=
watermark =3D 1;
> 		return 0;
> 	}
> 	return -1;

This looks cleaner. Let me fix in next version.=20

>=20
> Because in this case all you'll have in this evlist is the bpf tracker,
> right? The add_bpf_tracker would be handy if we would want to have a
> pre-existing evlist with some other events and wanted to add a bpf
> tracker, no?

I think all we need is a side-band evlist instead of the main evlist. May
be we should call it side-band evlist, and make it more generic?

Thanks,
Song

>=20
> - Arnaldo
>=20
>> +	return 0;
>> +}
>> +
>> static int perf_evlist__add_attrs(struct perf_evlist *evlist,
>> 				  struct perf_event_attr *attrs, size_t nr_attrs)
>> {
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 868294491194..a2d22715188e 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -84,6 +84,8 @@ int __perf_evlist__add_default_attrs(struct perf_evlis=
t *evlist,
>>=20
>> int perf_evlist__add_dummy(struct perf_evlist *evlist);
>>=20
>> +int perf_evlist__add_bpf_tracker(struct perf_evlist *evlist);
>> +
>> int perf_evlist__add_newtp(struct perf_evlist *evlist,
>> 			   const char *sys, const char *name, void *handler);
>>=20
>> --=20
>> 2.17.1

