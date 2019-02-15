Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067A021929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="B+V7skIx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iW0Pmw4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfBORZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:25:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbfBORZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:25:33 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1FHP8vc023528;
        Fri, 15 Feb 2019 09:25:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Yw0ogFt8PnDfZyFIAE8NYksddAZYMPFv5Z98b+beD24=;
 b=B+V7skIx4Q0zWNIWpUeZlPAOkyTMj4CTlKS5Zl8ELTcXdI65ikXYFxlhZeD5GPJ6X/V6
 KtWIm7RgvJRYvYZWrq+YYxcRahMizy9gWjv3iFMEGWGk9vXMypUX0vPojrcf++iwA44B
 xAXjnU8tAKVzP7asPdtYQHb+VaCdOPrqIEc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2qp1r9g0dv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 09:25:05 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:25:04 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 09:25:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw0ogFt8PnDfZyFIAE8NYksddAZYMPFv5Z98b+beD24=;
 b=iW0Pmw4k7lvsfrTqajwt+v5P/KEfrNhIKvUwg3k/AmncudoVQYh1I+VZCznfjFAnZY2Q1zCduoPu4tepiTCzjYNfWd61WNbBGl57cw+sn8nUlXrHVqMz92CuMoBtTIfL7fFmun7j+cZMmCu2jpWB8HXNO+cIfKUz4mgGhBtmuuk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1390.namprd15.prod.outlook.com (10.173.234.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 17:25:01 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9%8]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 17:25:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Jiri Olsa <jolsa@kernel.org>, Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Thread-Topic: [PATCH v2 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Thread-Index: AQHUxMGQlShe9E029kWf9/H0QeuOj6Xg626AgAAx0AA=
Date:   Fri, 15 Feb 2019 17:25:01 +0000
Message-ID: <164D19ED-EA72-4A56-8259-FCF13894B183@fb.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-7-songliubraving@fb.com>
 <20190215142643.GC5784@redhat.com>
In-Reply-To: <20190215142643.GC5784@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:e850]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53698d56-c5b3-4e2e-79e0-08d6936a8470
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1390;
x-ms-traffictypediagnostic: MWHPR15MB1390:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1390;20:EJmOQE8W5ZI2tdgi8ouu4ysvIM11peCD0UzO16BIwYZ5804vfYYHcWCO5sWfhiKuYPLdxMugvyh+t5MLAjyYJ+adWTRjwz45FMBHo98fdD+L7Zf3Ia8r1sBFYgM/YuU+JbjXHZmhvBYWBnbFd1xKDEGdwgdlo2Dx/CE43B8l5R4=
x-microsoft-antispam-prvs: <MWHPR15MB1390ED094E3F54E0C6D04E3FB3600@MWHPR15MB1390.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(346002)(136003)(396003)(39860400002)(189003)(199004)(6246003)(57306001)(186003)(102836004)(14444005)(256004)(106356001)(105586002)(53546011)(6506007)(83716004)(71190400001)(76176011)(53936002)(6916009)(36756003)(99286004)(6512007)(6436002)(25786009)(86362001)(6486002)(6116002)(229853002)(4326008)(33656002)(305945005)(7736002)(81166006)(97736004)(82746002)(478600001)(54906003)(71200400001)(14454004)(2906002)(68736007)(11346002)(486006)(46003)(446003)(476003)(93886005)(8936002)(50226002)(316002)(81156014)(8676002)(2616005)(142933001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1390;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nLXLLCTc8t/aArxpr04JIEVBzm5etRq47pwYAYFHTr8zP+a+ZjtqUTAyjAe+OJOMKeMwS0eojXRXrnOsRSo25dFBB7aQaNhUlgi9Ciy8Bp7PWuJECEagZvnoZMV0rfueFjmKQcnMbL1cPnxWrsvIwbNVaNavG/NW/a24GRKfSxJ7Re1wL1P5KrBh4NIUzj/xAqLY/x6ZHhIzhgou412rGten40gg41dJT4ozm6AAL80A4fO57XDJSHEVCWxlFusGsD7yWDQI5MFEQ/0VthuQdOKDE/WjPnizVgIuLT+NV+9/xiIhpJf4kQwhPhSK5euJTnGX1qWZPDSCc91IG8xe5ZW8/Op2SM7Wl8mVCHZGtf05NivWVCIIshkrIvqykwd7qA8V6/W0uBy6CbdLFipaTPRw2dIGnuy0qbx/DTi8gl4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D55CEC35F3438C4B8AFD17F1746CCC19@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53698d56-c5b3-4e2e-79e0-08d6936a8470
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:25:01.5792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 6:26 AM, Arnaldo Carvalho de Melo <acme@redhat.com> w=
rote:
>=20
> Em Thu, Feb 14, 2019 at 04:00:09PM -0800, Song Liu escreveu:
>> This patch enables perf-record to save btf information as headers to
>> perf.data A new header type HEADER_BTF is introduced for this data.
>=20
> Jiri,
>=20
> 	Wouldn't it be better for this HEADER_BTF to be introduced
> already as an user space event, Song, see:
>=20
>  tools/perf/util/event.h
>=20
> and:
>=20
>  tools/perf/util/event.c
>=20
> perf_event__synthesize_cpu_map()
>=20
> - Arnaldo
>=20

BTF would be short living for short living BPF programs. I guess=20
saving them as header is easier than merging them with samples.=20

What's the benefit of saving them as user space events?

Thanks,
Song


>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/util/header.c | 99 +++++++++++++++++++++++++++++++++++++++-
>> tools/perf/util/header.h |  1 +
>> 2 files changed, 99 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 2ae76a9d06f6..3f1562afe8e5 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -1125,6 +1125,45 @@ static int write_bpf_prog_info(struct feat_fd *ff=
,
>> 	return ret;
>> }
>>=20
>> +static int write_btf(struct feat_fd *ff,
>> +		     struct perf_evlist *evlist __maybe_unused)
>> +{
>> +	struct perf_env *env =3D &ff->ph->env;
>> +	struct rb_root *root;
>> +	struct rb_node *next;
>> +	u32 count =3D 0;
>> +	int ret;
>> +
>> +	down_read(&env->bpf_info_lock);
>> +
>> +	root =3D &env->btfs;
>> +	next =3D rb_first(root);
>> +	while (next) {
>> +		++count;
>> +		next =3D rb_next(next);
>> +	}
>> +
>> +	ret =3D do_write(ff, &count, sizeof(count));
>> +
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	next =3D rb_first(root);
>> +	while (next) {
>> +		struct btf_node *node;
>> +
>> +		node =3D rb_entry(next, struct btf_node, rb_node);
>> +		next =3D rb_next(&node->rb_node);
>> +		ret =3D do_write(ff, node,
>> +			       sizeof(struct btf_node) + node->data_size);
>> +		if (ret < 0)
>> +			goto out;
>> +	}
>> +out:
>> +	up_read(&env->bpf_info_lock);
>> +	return ret;
>> +}
>> +
>> static int cpu_cache_level__sort(const void *a, const void *b)
>> {
>> 	struct cpu_cache_level *cache_a =3D (struct cpu_cache_level *)a;
>> @@ -1628,6 +1667,28 @@ static void print_bpf_prog_info(struct feat_fd *f=
f, FILE *fp)
>> 	up_read(&env->bpf_info_lock);
>> }
>>=20
>> +static void print_btf(struct feat_fd *ff, FILE *fp)
>> +{
>> +	struct perf_env *env =3D &ff->ph->env;
>> +	struct rb_root *root;
>> +	struct rb_node *next;
>> +
>> +	down_read(&env->bpf_info_lock);
>> +
>> +	root =3D &env->btfs;
>> +	next =3D rb_first(root);
>> +
>> +	while (next) {
>> +		struct btf_node *node;
>> +
>> +		node =3D rb_entry(next, struct btf_node, rb_node);
>> +		next =3D rb_next(&node->rb_node);
>> +		fprintf(fp, "# bpf_prog_info of id %u\n", node->id);
>> +	}
>> +
>> +	up_read(&env->bpf_info_lock);
>> +}
>> +
>> static void free_event_desc(struct perf_evsel *events)
>> {
>> 	struct perf_evsel *evsel;
>> @@ -2723,6 +2784,41 @@ static int process_bpf_prog_info(struct feat_fd *=
ff,
>> 	return err;
>> }
>>=20
>> +static int process_btf(struct feat_fd *ff, void *data __maybe_unused)
>> +{
>> +	struct perf_env *env =3D &ff->ph->env;
>> +	u32 count, i;
>> +
>> +	if (do_read_u32(ff, &count))
>> +		return -1;
>> +
>> +	down_write(&env->bpf_info_lock);
>> +
>> +	for (i =3D 0; i < count; ++i) {
>> +		struct btf_node btf_node;
>> +		struct btf_node *node;
>> +
>> +		if (__do_read(ff, &btf_node, sizeof(struct btf_node)))
>> +			return -1;
>> +
>> +		node =3D malloc(sizeof(struct btf_node) + btf_node.data_size);
>> +		if (!node)
>> +			return -1;
>> +
>> +		node->id =3D btf_node.id;
>> +		node->data_size =3D btf_node.data_size;
>> +
>> +		if (__do_read(ff, node->data, btf_node.data_size)) {
>> +			free(node);
>> +			return -1;
>> +		}
>> +		perf_env__insert_btf(env, node);
>> +	}
>> +
>> +	up_write(&env->bpf_info_lock);
>> +	return 0;
>> +}
>> +
>> struct feature_ops {
>> 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
>> 	void (*print)(struct feat_fd *ff, FILE *fp);
>> @@ -2783,7 +2879,8 @@ static const struct feature_ops feat_ops[HEADER_LA=
ST_FEATURE] =3D {
>> 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
>> 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
>> 	FEAT_OPR(CLOCKID,       clockid,        false),
>> -	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
>> +	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
>> +	FEAT_OPR(BTF,           btf,            false)
>> };
>>=20
>> struct header_print_data {
>> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
>> index 0785c91b4c3a..ba51d8e43c53 100644
>> --- a/tools/perf/util/header.h
>> +++ b/tools/perf/util/header.h
>> @@ -40,6 +40,7 @@ enum {
>> 	HEADER_MEM_TOPOLOGY,
>> 	HEADER_CLOCKID,
>> 	HEADER_BPF_PROG_INFO,
>> +	HEADER_BTF,
>> 	HEADER_LAST_FEATURE,
>> 	HEADER_FEAT_BITS	=3D 256,
>> };
>> --=20
>> 2.17.1

