Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B28C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C9B20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="A3bqJQCa";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NpvNIiUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C9B20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeLLRJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:09:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46922 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbeLLRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:09:57 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBCH3649027115;
        Wed, 12 Dec 2018 09:09:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QJO/MH41lqXRg7+FpNbsXk/mYa0CxnJZUr/Y6ZXFOQM=;
 b=A3bqJQCako3j9HMMDLkKSnkSy2G2vPCUDKZtilgxrQPKMJgxLMTtbNGICIVlF8rWQXGc
 Tca37qgEFKR7SsMgbKiB1aFkBaf3BPVX4SOf3PLTmvUyo76kv40bNTRtOAy61HWNI3Ro
 CCwL75IDUYiD7YxANCiIzxWsNdl+hNRskgs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2pb4a58hs6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Dec 2018 09:09:20 -0800
Received: from frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 12 Dec 2018 09:09:20 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 12 Dec 2018 09:09:19 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 12 Dec 2018 09:09:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJO/MH41lqXRg7+FpNbsXk/mYa0CxnJZUr/Y6ZXFOQM=;
 b=NpvNIiUN05zQtaPhevK3kL64YajjyPCeaS83vaYwO09x96GaMRj3GUn7keVVvCJe+p5iiCzIzK8MxNi3Q+c05pSnn5S6RTi0hxB5HoGFwZeyPnGe4dv8ZLw90dfQ5DJ3tkdK464x0FXgbzsjvkqeht8ehGtzDleOZ0oQwISnbEU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1951.namprd15.prod.outlook.com (10.175.8.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 17:09:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a165:7ace:d8a:de65]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a165:7ace:d8a:de65%8]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 17:09:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUkan/BrxKv3p0HEGwaC6e4kWgY6V7FkWAgABBOQA=
Date:   Wed, 12 Dec 2018 17:09:17 +0000
Message-ID: <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::5:37be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1951;20:6DZu+xUljy8dNR6zmLlEXUUzFtFkrvPq7t26GJMtf18iKd112/3sokLhs1yHsfHfPx5bMKNininnF1bu5W2juia99mUVyIFgi+9Tq9PdQZuO8DnJ/RXxvW5rMcmee5TzS/LAYL5efPESG6C7+btmFRcDgr1EYXlRKiuUc7hinRs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 839ee669-a9cd-4ae3-05c1-08d660548cea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1951;
x-ms-traffictypediagnostic: MWHPR15MB1951:
x-microsoft-antispam-prvs: <MWHPR15MB1951BD6A9D8639244647E13AB3A70@MWHPR15MB1951.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3231455)(999002)(11241501185)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1951;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1951;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(82746002)(57306001)(33656002)(25786009)(575784001)(446003)(86362001)(2616005)(71200400001)(71190400001)(486006)(11346002)(83716004)(476003)(6116002)(6916009)(46003)(2906002)(102836004)(6506007)(53546011)(76176011)(256004)(186003)(14444005)(14454004)(54906003)(478600001)(99286004)(7736002)(106356001)(105586002)(316002)(6246003)(68736007)(50226002)(36756003)(305945005)(4326008)(97736004)(81166006)(81156014)(6486002)(8676002)(6436002)(229853002)(53936002)(8936002)(5660300001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1951;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XzvZUbyH2zjzS6fsESR7I72fKg4gi7ONic0a7JbV3iQXuYpebeIs9yHXX6UH/QA78VR54r5GgLVCHemBx1xmgQkbsPjxx9NRSmxATfh4Cwdiyx7yHre1Gf8K/mtBy3wrNZe/mAyO3PYhs/zuKLA7NETs0iJe6LXO8623iULgimlkzf8HfTmcYNYXYwvf3tePjLy5bgqaIjvR7cAr77ftud4dg7678jugIGSvSslMLXf1hIIlPyLa1IkbuUDS/zHxblbDJYXRGp28i2W9LNS36f8jjNBHSwdW7Wqb0hdYZJvrADe3puBj3kuujrVJSXgo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB5A9B926D22734B83D0DE961A3ECDC1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 839ee669-a9cd-4ae3-05c1-08d660548cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 17:09:17.5308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1951
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2018, at 5:15 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Dec 11, 2018 at 03:33:47PM -0800, Song Liu wrote:
>> For better performance analysis of BPF programs, this patch introduces
>> PERF_RECORD_BPF_EVENT, a new perf_event_type that exposes BPF program
>> load/unload information to user space.
>>=20
>> Each BPF program may contain up to BPF_MAX_SUBPROGS (256) sub programs.
>> The following example shows kernel symbols for a BPF program with 7
>> sub programs:
>>=20
>>    ffffffffa0257cf9 t bpf_prog_b07ccb89267cf242_F
>>    ffffffffa02592e1 t bpf_prog_2dcecc18072623fc_F
>>    ffffffffa025b0e9 t bpf_prog_bb7a405ebaec5d5c_F
>>    ffffffffa025dd2c t bpf_prog_a7540d4a39ec1fc7_F
>>    ffffffffa025fcca t bpf_prog_05762d4ade0e3737_F
>>    ffffffffa026108f t bpf_prog_db4bd11e35df90d4_F
>>    ffffffffa0263f00 t bpf_prog_89d64e4abf0f0126_F
>>    ffffffffa0257cf9 t bpf_prog_ae31629322c4b018__dummy_tracepoi
>=20
> Doesn't BPF have enough information to generate 'saner' names? Going by
> the thing below, these sub-progs are actually functions, right?

These sub programs/functions will have their descriptive names from BTF
function types (coming in 4.21). However, BTF is optional in normal cases,=
=20
when BTF is missing, they will be named as bpf_prog_<tag>_F. The main BPF
program has a name up to 16 byte long. In the example above, the last=20
program has name _dummy_tracepoint.=20

I think these sub programs are more like "programs" than "functions",=20
because each sub program occupies its own page(s).=20

>=20
>>        /*
>>         * Record different types of bpf events:
>>         *  enum perf_bpf_event_type {
>>         *     PERF_BPF_EVENT_UNKNOWN           =3D 0,
>>         *     PERF_BPF_EVENT_PROG_LOAD         =3D 1,
>>         *     PERF_BPF_EVENT_PROG_UNLOAD       =3D 2,
>>         *  };
>>         *
>>         * struct {
>>         *      struct perf_event_header header;
>>         *      u32                             type;
>>         *      u32                             flags;
>>         *      u32                             id; // prog_id or other i=
d
>>         *      u32                             sub_id; // subprog id
>>         *
>>         *      // for bpf_prog types, bpf prog or subprog
>>         *      u8                              tag[BPF_TAG_SIZE];
>>         *      u64                             addr;
>>         *      u64                             len;
>>         *      char                            name[];
>>         *      struct sample_id                sample_id;
>>         * };
>>         */
>=20
> Isn't this mixing two different things (poorly)? The kallsym update and
> the BPF load/unload ?

I would say these two things are actually two parts of the same event.=20
Fields id, sub_id, and tag provide information about which program is
mapped to this ksym. They are equivalent to "pgoff + filename" in=20
PERF_RECORD_MMAP, or "maj, min, ino, and ino_generation" in=20
PERF_RECORD_MMAP2.=20

>=20
> And while this tracks the bpf kallsyms, it does not do all kallsyms.
>=20
> .... Oooh, I see the problem, everybody is doing their own custom
> kallsym_{add,del}() thing, instead of having that in generic code :-(
>=20
> This, for example, doesn't track module load/unload nor ftrace
> trampolines, even though both affect kallsyms.

I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload.=20
That could be separate sets of patches.=20

Thanks,
Song

>=20
>> +void perf_event_bpf_event_prog(enum perf_bpf_event_type type,
>> +			       struct bpf_prog *prog)
>> +{
>> +	if (!atomic_read(&nr_bpf_events))
>> +		return;
>> +
>> +	if (type !=3D PERF_BPF_EVENT_PROG_LOAD &&
>> +	    type !=3D PERF_BPF_EVENT_PROG_UNLOAD)
>> +		return;
>> +
>> +	if (prog->aux->func_cnt =3D=3D 0) {
>> +		perf_event_bpf_event_subprog(type, prog,
>> +					     prog->aux->id, 0);
>> +	} else {
>> +		int i;
>> +
>> +		for (i =3D 0; i < prog->aux->func_cnt; i++)
>> +			perf_event_bpf_event_subprog(type, prog->aux->func[i],
>> +						     prog->aux->id, i);
>> +	}
>> +}
>=20
>=20

