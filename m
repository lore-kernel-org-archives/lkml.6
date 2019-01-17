Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B80FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G/nC8s1T";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YRGEkEYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfAQNtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:49:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbfAQNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:49:55 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HDlhwl000578;
        Thu, 17 Jan 2019 05:49:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FZ3Ud8FgY20ID+whupDYN3MmFdsOqAgDUYDgSDhF68w=;
 b=G/nC8s1T6qfvBl3se2bPsAhSP4FlSucqlvqOj34e3i6fhmU3qc53BTMoL7ym8bv/vUZ3
 ZQPKvvZK1dCeKvOJw73eWxYq/K0GlpwOBqzdIXuVwzw2X/qKae1uupb5o6OQ4AGP6Baw
 9ky2HKiKeOFxlD4NCXLlfYiP8nux7AHlWKo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q2ttyg0ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Jan 2019 05:49:22 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 17 Jan 2019 05:49:21 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 17 Jan 2019 05:49:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 17 Jan 2019 05:49:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ3Ud8FgY20ID+whupDYN3MmFdsOqAgDUYDgSDhF68w=;
 b=YRGEkEYYVZQbqoZ/k844rz82UnwiGMAgNJOMvfLK3mmHtEw0qvZBjDzW4NiBsnIIHTZDhpiga5DDMdaSbiCHrPJbrsGlFzmze4E9a4ajwWVAaN6KuuOU1t0n4DXTzLX1Bu++tkKXaf/eHZQeJLxdSqvgooCQ6ZSfJ5IKbFD6+so=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1198.namprd15.prod.outlook.com (10.175.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 13:49:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 13:49:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "dsahern@gmail.com" <dsahern@gmail.com>
Subject: Re: [PATCH v10 perf, bpf-next 3/9] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v10 perf, bpf-next 3/9] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUrbjDUgyWFsoaF06T/QPKIRgBIqWzcGsAgAALBQA=
Date:   Thu, 17 Jan 2019 13:49:19 +0000
Message-ID: <AF388120-70CD-4590-803B-F8F303334726@fb.com>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-4-songliubraving@fb.com>
 <20190117130952.GG10486@hirez.programming.kicks-ass.net>
In-Reply-To: <20190117130952.GG10486@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:4cc3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1198;20:dbqcHJWuzVJNvtSNwfmFteiLsd7ki3fueDwa9kmRPXJTDjgXpmy+13GEAaPi+K6WHxXAhXVHSXJW7LadhwhLjNHo9gukS7jauTSeB6sgO51+HuRgnuTTJDHpZ361AVNf1Du+opl7uqIsYroXmi2DgWvcRcuMMBDKRs8IjBjWjWE=
x-ms-office365-filtering-correlation-id: 5981949c-e0c9-4b07-bb31-08d67c829465
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1198;
x-ms-traffictypediagnostic: MWHPR15MB1198:
x-microsoft-antispam-prvs: <MWHPR15MB1198F642750C64DE2E595290B3830@MWHPR15MB1198.namprd15.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(52314003)(229853002)(57306001)(36756003)(50226002)(53936002)(6512007)(86362001)(99286004)(46003)(76176011)(316002)(2906002)(81156014)(11346002)(8676002)(486006)(476003)(2616005)(256004)(105586002)(446003)(6506007)(81166006)(53546011)(6246003)(6346003)(25786009)(8936002)(39060400002)(102836004)(54906003)(82746002)(7736002)(186003)(305945005)(6116002)(71190400001)(83716004)(106356001)(4326008)(68736007)(6916009)(5660300001)(478600001)(14454004)(33656002)(71200400001)(6486002)(6436002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1198;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v4Z3uDxmp1UOnPD5tXgxgVNXfCltFIU2O5ka+UCEPC4viTdvbaS0GAhXsz+lu0k5iqbXer5RM/VvUXZFOnx3h/C+6hCnW/LMkFh1zzWZrGSd9XAglaYELJV5ekxXB33zj/O6huhSJ0f7NOEUD6VPggif+vru5mMR5olyUKAEc34W/yktrZjTp+XomoYH8kpAA/7eGUCXA9ItP6h2sO2M8wVmNRN6qd2qaKfn0xkrit8S8NnuId+pFlS9xg7EQOFq7gLAvB90Wvul2cKi6ZC9QuTqFaA5CcZm/IioR6MiAnBrRUhp6JpCqIsKz7ZeROuHHWfCsdaoK739yVHqpm9+apDgHrBlq6qpchogb+oDQ4nXQnkyrLSXb/cTPmwTPmeM8rjmDo3QLVERVHQ7Mhw+cgeNNk0oalWKGKLfCEKV+mM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1493CF3AF99B9E45BB36BB2B6C88E26B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5981949c-e0c9-4b07-bb31-08d67c829465
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 13:49:19.5180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1198
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Peter!

> On Jan 17, 2019, at 5:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Jan 16, 2019 at 08:29:25AM -0800, Song Liu wrote:
>> +	/*
>> +	 * Record bpf events:
>> +	 *  enum perf_bpf_event_type {
>> +	 *	PERF_BPF_EVENT_UNKNOWN		=3D 0,
>> +	 *	PERF_BPF_EVENT_PROG_LOAD	=3D 1,
>> +	 *	PERF_BPF_EVENT_PROG_UNLOAD	=3D 2,
>> +	 *  };
>> +	 *
>> +	 * struct {
>> +	 *	struct perf_event_header	header;
>> +	 *	u16				type;
>> +	 *	u16				flags;
>> +	 *	u32				id;
>> +	 *	u8				tag[BPF_TAG_SIZE];
>=20
> This does forever fix BPF_TAG_SIZE; is that intentional? We could easily
> make that a variable length field like with the other event. Or is that
> value already part of the eBPF ABI?

Yes, BPF_TAG_SIZE is already part of eBPF ABI.=20

Song

>=20
>> +	 *	struct sample_id		sample_id;
>> +	 * };
>> +	 */
>> +	PERF_RECORD_BPF_EVENT			=3D 18,
>> @@ -7744,6 +7747,121 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr,=
 u32 len, bool unregister,
>> 	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
>> }
>>=20
>> +struct perf_bpf_event {
>> +	struct bpf_prog	*prog;
>> +	struct {
>> +		struct perf_event_header        header;
>> +		u16				type;
>> +		u16				flags;
>> +		u32				id;
>> +		u8				tag[BPF_TAG_SIZE];
>> +	} event_id;
>> +};
>=20
>> +static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
>> +					 enum perf_bpf_event_type type)
>> +{
>> +	bool unregister =3D type =3D=3D PERF_BPF_EVENT_PROG_UNLOAD;
>> +	int i;
>> +
>> +	if (prog->aux->func_cnt =3D=3D 0) {
>> +		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
>> +				   (u64)(unsigned long)prog->bpf_func,
>> +				   prog->jited_len, unregister,
>> +				   perf_event_bpf_get_name, prog);
>> +	} else {
>> +		for (i =3D 0; i < prog->aux->func_cnt; i++) {
>> +			struct bpf_prog *subprog =3D prog->aux->func[i];
>> +
>> +			perf_event_ksymbol(
>> +				PERF_RECORD_KSYMBOL_TYPE_BPF,
>> +				(u64)(unsigned long)subprog->bpf_func,
>> +				subprog->jited_len, unregister,
>> +				perf_event_bpf_get_name, subprog);
>> +		}
>> +	}
>> +}
>=20
> I still think this is a weird place to do this.. :-) See them patches I
> just send.
>=20
>> +void perf_event_bpf_event(struct bpf_prog *prog,
>> +			  enum perf_bpf_event_type type,
>> +			  u16 flags)
>> +{
>> +	struct perf_bpf_event bpf_event;
>> +
>> +	if (type <=3D PERF_BPF_EVENT_UNKNOWN ||
>> +	    type >=3D PERF_BPF_EVENT_MAX)
>> +		return;
>> +
>> +	switch (type) {
>> +	case PERF_BPF_EVENT_PROG_LOAD:
>> +	case PERF_BPF_EVENT_PROG_UNLOAD:
>> +		if (atomic_read(&nr_ksymbol_events))
>> +			perf_event_bpf_emit_ksymbols(prog, type);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (!atomic_read(&nr_bpf_events))
>> +		return;
>> +
>> +	bpf_event =3D (struct perf_bpf_event){
>> +		.prog =3D prog,
>> +		.event_id =3D {
>> +			.header =3D {
>> +				.type =3D PERF_RECORD_BPF_EVENT,
>> +				.size =3D sizeof(bpf_event.event_id),
>> +			},
>> +			.type =3D type,
>> +			.flags =3D flags,
>> +			.id =3D prog->aux->id,
>> +		},
>> +	};
>=20
> 	BUILD_BUG_ON(BPF_TAG_SIZE % sizeof(u64));
>=20
>> +	memcpy(bpf_event.event_id.tag, prog->tag, BPF_TAG_SIZE);
>> +	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
>> +}
>=20
> Anyway, small nits only:
>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradeaed.org>

