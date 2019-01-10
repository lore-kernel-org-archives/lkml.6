Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AC0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C33D20874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RbmEyvCX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KtXL2Xsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAJSlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:41:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42380 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbfAJSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:41:32 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0AIdVVE001665;
        Thu, 10 Jan 2019 10:41:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=s+PnoQIeIstxPsTuTKg3LHSPYsI3Sbd3C6uNutgYL2k=;
 b=RbmEyvCXXen8podgDwCyyreRjsGY1vmvLvnrqdnMa3rbprYr5RMaqi2Kks8tszpNNkt6
 BVNRH2AZt4KrmRZazxVebauKkDjWUSwqvySqGH+gwI224zQaR7jjJ1y/lxmIlsn3aVmc
 EG9kSdOhwd8C4wLDc9nN7lqaTAwn6eWHOZw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2px8yrgnnn-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Jan 2019 10:41:01 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 10 Jan 2019 10:40:40 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 10 Jan 2019 10:40:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+PnoQIeIstxPsTuTKg3LHSPYsI3Sbd3C6uNutgYL2k=;
 b=KtXL2XsaZDduex/DqN9Wybkhr1H7iYzLs0MMQXaWYCLsLtUjZtQWFEgF155ahV3BdL+dduYlta8Un1HlxCxCaKffBfwbZ8tqwq/wbH7mllDK+ky/07UkUJN/TfnOF74YY0gORLUZD6gm6kFJVys7vLKrFEdb0m2FcFcXJ9vV6uQ=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1466.namprd15.prod.outlook.com (10.173.225.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 18:40:37 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::1909:9d4c:715b:faa0]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::1909:9d4c:715b:faa0%5]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 18:40:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Topic: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Index: AQHUqFCaPbT+UGXQnkaaX1wm9KrpVKWo0rKAgAAEoAA=
Date:   Thu, 10 Jan 2019 18:40:37 +0000
Message-ID: <064FBBA4-A0D0-4335-BCE7-902724CE2988@fb.com>
References: <20190109192111.130995-1-songliubraving@fb.com>
 <20190109192111.130995-2-songliubraving@fb.com>
 <20190110182403.GN22483@kernel.org>
In-Reply-To: <20190110182403.GN22483@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:3651]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1466;20:yE2FF5Qyphmc9+YpCKAxFhI6JJlV8C9x2cO4wX+2DlWtPkduI5cdqoAGkAEFcXZAGZWDdN+B2RIOBH4W5mRsYrX1Cf5+t4Cd8BMOOCXGtncXE3RG4XCrsFX7J71mX/rPiTHcj1K6FazbnhMO0wGXuF3MyQ+trAg1Y4tEYeKLxKQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0d7a0e55-eb22-4227-01f9-08d6772b1d0f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1466;
x-ms-traffictypediagnostic: DM5PR15MB1466:
x-microsoft-antispam-prvs: <DM5PR15MB146602D24851BFF74C3281B4B3840@DM5PR15MB1466.namprd15.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39860400002)(396003)(346002)(199004)(189003)(25786009)(53936002)(229853002)(4326008)(106356001)(57306001)(105586002)(6486002)(82746002)(5024004)(14444005)(76176011)(6246003)(6436002)(6512007)(36756003)(478600001)(68736007)(256004)(8676002)(83716004)(81156014)(81166006)(71190400001)(71200400001)(305945005)(7736002)(86362001)(14454004)(6116002)(186003)(476003)(6916009)(11346002)(486006)(2616005)(446003)(102836004)(6506007)(5660300001)(53546011)(46003)(54906003)(99286004)(316002)(50226002)(33656002)(8936002)(2906002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1466;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TnBuUNAoyH3suKWC3d256gBqAnW+DLPvt2E61Z+QT6E45cPBcHK2wPUx/vFW5+1pQTcGWO/w51AD63/Tpp0NgrPL2HX7G5P3vjopCvm+UVI4nrXy7nhCut4iEkZkd8Z+ltsZK8DM9WpfOMWO3bI2qh1dHcxojl8vFm6+uThN2cPVSm7MF5hEApQwEeBOhvjN/p+C3vywY9yldQQvlZZ8PcxND00FazbrBbaGL6Sy1GOVFUFev2bfKuIw87oANxdLNHZQ9im0xrkt1wpuV/b5Bcf2OLm4Wz60nMNPMQgqgiLHwPXPqpu8gvDM1ww4XFAy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC059966D551CC45951A70BE1503DDA1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7a0e55-eb22-4227-01f9-08d6772b1d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:40:37.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1466
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 10, 2019, at 10:24 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Wed, Jan 09, 2019 at 11:21:05AM -0800, Song Liu escreveu:
>> For better performance analysis of dynamically JITed and loaded kernel
>> functions, such as BPF programs, this patch introduces
>> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
>> register/unregister information to user space.
>>=20
>> The following data structure is used for PERF_RECORD_KSYMBOL.
>>=20
>>    /*
>>     * struct {
>>     *      struct perf_event_header        header;
>>     *      u64                             addr;
>>     *      u32                             len;
>>     *      u16                             ksym_type;
>>     *      u16                             flags;
>>     *      char                            name[];
>>     *      struct sample_id                sample_id;
>>     * };
>>     */
>=20
> So, I couldn't find where this gets used, the intention here is just to
> add the interfaces and afterwards is that you will wire this up? I would
> like to test the whole shebang to see it working.
>=20
> - Arnaldo

I guess you meant PERF_RECORD_BPF_EVENT not being used?=20

PERF_RECORD_KSYMBOL is used by BPF in 3/7 and 5/7. I tested=20
PERF_RECORD_BPF_EVENT with dump_trace. As we separate RECORD_KSYMBOL from
RECORD_BPF_EVENT, user space won't use BPF_EVENT until annotation support. =
=20

Thanks,
Song

>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> include/linux/perf_event.h      | 13 +++++
>> include/uapi/linux/perf_event.h | 26 ++++++++-
>> kernel/events/core.c            | 98 ++++++++++++++++++++++++++++++++-
>> 3 files changed, 135 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 1d5c551a5add..6b5f08db5ef3 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1113,6 +1113,13 @@ static inline void perf_event_task_sched_out(stru=
ct task_struct *prev,
>> }
>>=20
>> extern void perf_event_mmap(struct vm_area_struct *vma);
>> +
>> +/* callback function to generate ksymbol name */
>> +typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *d=
ata);
>> +extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
>> +			       bool unregister,
>> +			       perf_ksymbol_get_name_f get_name, void *data);
>> +
>> extern struct perf_guest_info_callbacks *perf_guest_cbs;
>> extern int perf_register_guest_info_callbacks(struct perf_guest_info_cal=
lbacks *callbacks);
>> extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_c=
allbacks *callbacks);
>> @@ -1333,6 +1340,12 @@ static inline int perf_unregister_guest_info_call=
backs
>> (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
>>=20
>> static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
>> +
>> +typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *d=
ata);
>> +static inline void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
>> +				      bool unregister,
>> +				      perf_ksymbol_get_name_f get_name,
>> +				      void *data) 			{ }
>> static inline void perf_event_exec(void)				{ }
>> static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{=
 }
>> static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_e=
vent.h
>> index 9de8780ac8d9..68c4da0227c5 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -372,7 +372,8 @@ struct perf_event_attr {
>> 				context_switch :  1, /* context switch data */
>> 				write_backward :  1, /* Write ring buffer from end to beginning */
>> 				namespaces     :  1, /* include namespaces data */
>> -				__reserved_1   : 35;
>> +				ksymbol        :  1, /* include ksymbol events */
>> +				__reserved_1   : 34;
>>=20
>> 	union {
>> 		__u32		wakeup_events;	  /* wakeup every n events */
>> @@ -965,9 +966,32 @@ enum perf_event_type {
>> 	 */
>> 	PERF_RECORD_NAMESPACES			=3D 16,
>>=20
>> +	/*
>> +	 * Record ksymbol register/unregister events:
>> +	 *
>> +	 * struct {
>> +	 *	struct perf_event_header	header;
>> +	 *	u64				addr;
>> +	 *	u32				len;
>> +	 *	u16				ksym_type;
>> +	 *	u16				flags;
>> +	 *	char				name[];
>> +	 *	struct sample_id		sample_id;
>> +	 * };
>> +	 */
>> +	PERF_RECORD_KSYMBOL			=3D 17,
>> +
>> 	PERF_RECORD_MAX,			/* non-ABI */
>> };
>>=20
>> +enum perf_record_ksymbol_type {
>> +	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	=3D 0,
>> +	PERF_RECORD_KSYMBOL_TYPE_BPF		=3D 1,
>> +	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
>> +};
>> +
>> +#define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
>> +
>> #define PERF_MAX_STACK_DEPTH		127
>> #define PERF_MAX_CONTEXTS_PER_STACK	  8
>>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 3cd13a30f732..ef27f2776999 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -385,6 +385,7 @@ static atomic_t nr_namespaces_events __read_mostly;
>> static atomic_t nr_task_events __read_mostly;
>> static atomic_t nr_freq_events __read_mostly;
>> static atomic_t nr_switch_events __read_mostly;
>> +static atomic_t nr_ksymbol_events __read_mostly;
>>=20
>> static LIST_HEAD(pmus);
>> static DEFINE_MUTEX(pmus_lock);
>> @@ -4235,7 +4236,7 @@ static bool is_sb_event(struct perf_event *event)
>>=20
>> 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
>> 	    attr->comm || attr->comm_exec ||
>> -	    attr->task ||
>> +	    attr->task || attr->ksymbol ||
>> 	    attr->context_switch)
>> 		return true;
>> 	return false;
>> @@ -4305,6 +4306,8 @@ static void unaccount_event(struct perf_event *eve=
nt)
>> 		dec =3D true;
>> 	if (has_branch_stack(event))
>> 		dec =3D true;
>> +	if (event->attr.ksymbol)
>> +		atomic_dec(&nr_ksymbol_events);
>>=20
>> 	if (dec) {
>> 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
>> @@ -7650,6 +7653,97 @@ static void perf_log_throttle(struct perf_event *=
event, int enable)
>> 	perf_output_end(&handle);
>> }
>>=20
>> +/*
>> + * ksymbol register/unregister tracking
>> + */
>> +
>> +struct perf_ksymbol_event {
>> +	const char	*name;
>> +	int		name_len;
>> +	struct {
>> +		struct perf_event_header        header;
>> +		u64				addr;
>> +		u32				len;
>> +		u16				ksym_type;
>> +		u16				flags;
>> +	} event_id;
>> +};
>> +
>> +static int perf_event_ksymbol_match(struct perf_event *event)
>> +{
>> +	return event->attr.ksymbol;
>> +}
>> +
>> +static void perf_event_ksymbol_output(struct perf_event *event, void *d=
ata)
>> +{
>> +	struct perf_ksymbol_event *ksymbol_event =3D data;
>> +	struct perf_output_handle handle;
>> +	struct perf_sample_data sample;
>> +	int ret;
>> +
>> +	if (!perf_event_ksymbol_match(event))
>> +		return;
>> +
>> +	perf_event_header__init_id(&ksymbol_event->event_id.header,
>> +				   &sample, event);
>> +	ret =3D perf_output_begin(&handle, event,
>> +				ksymbol_event->event_id.header.size);
>> +	if (ret)
>> +		return;
>> +
>> +	perf_output_put(&handle, ksymbol_event->event_id);
>> +	__output_copy(&handle, ksymbol_event->name, ksymbol_event->name_len);
>> +	perf_event__output_id_sample(event, &handle, &sample);
>> +
>> +	perf_output_end(&handle);
>> +}
>> +
>> +void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregist=
er,
>> +			perf_ksymbol_get_name_f get_name, void *data)
>> +{
>> +	struct perf_ksymbol_event ksymbol_event;
>> +	char name[KSYM_NAME_LEN];
>> +	u16 flags =3D 0;
>> +	int name_len;
>> +
>> +	if (!atomic_read(&nr_ksymbol_events))
>> +		return;
>> +
>> +	if (ksym_type >=3D PERF_RECORD_KSYMBOL_TYPE_MAX ||
>> +	    ksym_type =3D=3D PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
>> +		goto err;
>> +
>> +	get_name(name, KSYM_NAME_LEN, data);
>> +	name_len =3D strlen(name) + 1;
>> +	while (!IS_ALIGNED(name_len, sizeof(u64)))
>> +		name[name_len++] =3D '\0';
>> +	BUILD_BUG_ON(KSYM_NAME_LEN % sizeof(u64));
>> +
>> +	if (unregister)
>> +		flags |=3D PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER;
>> +
>> +	ksymbol_event =3D (struct perf_ksymbol_event){
>> +		.name =3D name,
>> +		.name_len =3D name_len,
>> +		.event_id =3D {
>> +			.header =3D {
>> +				.type =3D PERF_RECORD_KSYMBOL,
>> +				.size =3D sizeof(ksymbol_event.event_id) +
>> +					name_len,
>> +			},
>> +			.addr =3D addr,
>> +			.len =3D len,
>> +			.ksym_type =3D ksym_type,
>> +			.flags =3D flags,
>> +		},
>> +	};
>> +
>> +	perf_iterate_sb(perf_event_ksymbol_output, &ksymbol_event, NULL);
>> +	return;
>> +err:
>> +	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
>> +}
>> +
>> void perf_event_itrace_started(struct perf_event *event)
>> {
>> 	event->attach_state |=3D PERF_ATTACH_ITRACE;
>> @@ -9900,6 +9994,8 @@ static void account_event(struct perf_event *event=
)
>> 		inc =3D true;
>> 	if (is_cgroup_event(event))
>> 		inc =3D true;
>> +	if (event->attr.ksymbol)
>> +		atomic_inc(&nr_ksymbol_events);
>>=20
>> 	if (inc) {
>> 		/*
>> --=20
>> 2.17.1
>=20
> --=20
>=20
> - Arnaldo

