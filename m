Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D278C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD11021019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UYp3nuV3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c8xp/dmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfAVSpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:45:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48466 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbfAVSpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:45:12 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MIWZ75026884;
        Tue, 22 Jan 2019 10:42:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tKEYiWHRLjvJvu4mN6vm0SdQ9IBE5+x68MYfZ729N/I=;
 b=UYp3nuV36nAuNcAm/W1BJNM77+F8FZ6i1SlEaI2jHKW9z/mbm1lFmf+0rZNuvv7z1yrU
 RSuw11TFcGEjS8307DvLk3UJyDvUyTAHPYL/J6K6JyFPePplc9+VDB/DDrt5wUq2Lz7O
 MlE8vDrcgrqQgQfUEmQlOvqqyvameHaEBCA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q68hs82mg-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 10:42:25 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 22 Jan 2019 10:39:00 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 22 Jan 2019 10:39:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKEYiWHRLjvJvu4mN6vm0SdQ9IBE5+x68MYfZ729N/I=;
 b=c8xp/dmO4gfLnxOAtS3vAvdKQGUbGvCEcc0kY1bejrupkCdFb/qh7fq8N3Uc9rweGuiKqRS5tmGQI3ipSReJut/JfKBDMG129kAohFgECNwr73qFofe/oEF/UcH64E0evoNtv7b91WXf4scp2qTHeSJt501W37U++YRKDikRmrg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1438.namprd15.prod.outlook.com (10.173.234.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Tue, 22 Jan 2019 18:38:56 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 18:38:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Thread-Topic: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Thread-Index: AQHUrn/iSbG/DnBf4UmHa+IaoczOfaW1HE+AgAY/8gCAAAUEgIAABZmAgAAB44CAAAadgIAANxeA
Date:   Tue, 22 Jan 2019 18:38:56 +0000
Message-ID: <101BF88D-2DA4-4B54-A710-D0641C427136@fb.com>
References: <20190117161521.1341602-1-songliubraving@fb.com>
 <20190117161521.1341602-8-songliubraving@fb.com>
 <20190118144655.GM5823@kernel.org> <20190122141320.GF14973@kernel.org>
 <20190122143117.GG14973@kernel.org> <20190122145119.GF27625@krava>
 <20190122145805.GI14973@kernel.org> <20190122152145.GG27625@krava>
In-Reply-To: <20190122152145.GG27625@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::4:df87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1438;20:nYzW6BrN4us2lD1ibAYEUezgj4XheAGino8/6FrzktGrmBw1sn3gNNLtwI9NG5aJ/2VUprpMHkk4CsGKp191MmnJcEfvLfRsWEhcitwLL1DPOv5HCe1H5+45WSKNC9xEMlMdP/cyLgNgDzc4VAoge+q/Imco1/y76iuD8mMOvFU=
x-ms-office365-filtering-correlation-id: d8498a02-b65f-4b77-e23d-08d68098ddb9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1438;
x-ms-traffictypediagnostic: MWHPR15MB1438:
x-microsoft-antispam-prvs: <MWHPR15MB1438ABAF168157B199BAB9DDB3980@MWHPR15MB1438.namprd15.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(93886005)(68736007)(82746002)(6512007)(229853002)(81156014)(83716004)(316002)(8936002)(50226002)(81166006)(6436002)(71190400001)(71200400001)(54906003)(86362001)(25786009)(2906002)(4326008)(5024004)(256004)(6246003)(8676002)(7736002)(305945005)(53936002)(14454004)(478600001)(99286004)(2616005)(105586002)(33656002)(46003)(6116002)(106356001)(476003)(486006)(446003)(11346002)(57306001)(6506007)(53546011)(6486002)(97736004)(6916009)(36756003)(76176011)(186003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1438;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vxP9/ftILGzBZrmRSVXgfi1CBJoyM2KlX1T73e+zGXsJ8aBKNSirkX1dTp092RocoG2AnRt668ZbdnxH7xBHrVxxv+4pkJT2YztJaFRwmIRKgmYGdwTv84DSE2W3oYS5W6MkTcdGJSL25wBmPOklpDmTnsvuUnzoqbuqkSZa/o7ArFfL0oAEaB/1/iRqQGQhxD7MYIduntorMVIJc14q/0ctFHzmZ/dOHFsayl0DtTQyk2ZLyUnxozCvoJxk0gcBzUvd84A31eWfbr4Ee0TrY44NCgyPkAhOvSrKKXDJ6i9dISEG3QY+h7fKS36jDLHKbtgMhAnPVNQj19UarqQaXpxMuNhT7Ra9VHisdSPMIHQj9nEYs3/nryVorR++D4pOGn8zqj+trwXQYtsrgWtDB9aNCQO82G1FDCkwr6qjCRQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B95954436305E04FBD915F1213BCE2DA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8498a02-b65f-4b77-e23d-08d68098ddb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 18:38:56.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1438
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 22, 2019, at 7:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Jan 22, 2019 at 12:58:05PM -0200, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Jan 22, 2019 at 03:51:19PM +0100, Jiri Olsa escreveu:
>>> On Tue, Jan 22, 2019 at 12:31:17PM -0200, Arnaldo Carvalho de Melo wrot=
e:
>>>> Em Tue, Jan 22, 2019 at 12:13:20PM -0200, Arnaldo Carvalho de Melo esc=
reveu:
>>>>> Em Fri, Jan 18, 2019 at 11:46:55AM -0300, Arnaldo Carvalho de Melo es=
creveu:
>>>>>> Em Thu, Jan 17, 2019 at 08:15:19AM -0800, Song Liu escreveu:
>>>>>>> This patch synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT=
 for
>>>>>>> BPF programs loaded before perf-record. This is achieved by gatheri=
ng
>>>>>>> information about all BPF programs via sys_bpf.
>>>>>>=20
>>>>>> Ditto
>>>>>=20
>>>>> This is breaking 'perf sched', see below, the fix seems trivial:
>>>>>=20
>>>>> [root@quaco ~]# perf sched record -a sleep 2
>>>>> [ perf record: Woken up 1 times to write data ]
>>>>> 0x5b60 [0x138]: failed to process type: 17
>>>>> [ perf record: Captured and wrote 1.539 MB perf.data ]
>>>>> [root@quaco ~]# perf sched lat
>>>>> 0x5b60 [0x138]: failed to process type: 17
>>>>> Failed to process events, error -22
>>>>> [root@quaco ~]#
>>>>=20
>>>> So:
>>>>=20
>>>>   perf_session__process_event (event->header.type =3D 17 (PERF_RECORD_=
KSYMBOL)
>>>>     if (tool->ordered_events)
>>>>       ret =3D perf_evlist__parse_sample_timestamp(evlist, event, &time=
stamp);
>>>>       if (ret && ret !=3D -1)
>>>>            return ret;
>>>>=20
>>>> So it returns here with -EFAULT, i.e. this is failing:
>>>>=20
>>>> int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
>>>>                                        union perf_event *event,
>>>>                                        u64 *timestamp)
>>>> {
>>>>        struct perf_evsel *evsel =3D perf_evlist__event2evsel(evlist, e=
vent);
>>>>=20
>>>>        if (!evsel)
>>>>                return -EFAULT;
>>>>        return perf_evsel__parse_sample_timestamp(evsel, event, timesta=
mp);
>>>> }
>>>>=20
>>>> It isn't mapping the event ID it finds back to an evsel.. Jiri, ideas?
>>>>=20
>>>> This is happening so far only for 'perf sched', perf record with two
>>>> events works.
>>>=20
>>> I saw also perf mem failing because of this.. will check
>>=20
>> Right, seems something with the synthesizing of existing bpf progs,
>> which always there are some nowadays, for instance, on this fedora29
>> system:
>>=20
>> [root@quaco tmp]# bpftool prog
>> 13: cgroup_skb  tag 7be49e3934a125ba  gpl
>> 	loaded_at 2019-01-21T13:30:27-0200  uid 0
>> 	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
>> 14: cgroup_skb  tag 2a142ef67aaad174  gpl
>> 	loaded_at 2019-01-21T13:30:27-0200  uid 0
>> 	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
>> 15: cgroup_skb  tag 7be49e3934a125ba  gpl
>> 	loaded_at 2019-01-21T13:30:27-0200  uid 0
>> 	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
>> 16: cgroup_skb  tag 2a142ef67aaad174  gpl
>> 	loaded_at 2019-01-21T13:30:27-0200  uid 0
>> 	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
>> 17: cgroup_skb  tag 7be49e3934a125ba  gpl
>> 	loaded_at 2019-01-21T13:30:29-0200  uid 0
>> 	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
>> 18: cgroup_skb  tag 2a142ef67aaad174  gpl
>> 	loaded_at 2019-01-21T13:30:29-0200  uid 0
>> 	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
>> 21: cgroup_skb  tag 7be49e3934a125ba  gpl
>> 	loaded_at 2019-01-21T13:30:29-0200  uid 0
>> 	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
>> 22: cgroup_skb  tag 2a142ef67aaad174  gpl
>> 	loaded_at 2019-01-21T13:30:29-0200  uid 0
>> 	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
>> [root@quaco tmp]#
>>=20
>> When with a bunch of tracepoints, that is what 'perf mem', 'perf kmem',
>> 'perf sched', etc does, it ends up failing here:
>>=20
>>                    ret =3D perf_evlist__parse_sample_timestamp(evlist, e=
vent, &timestamp);
>>=20
>> So it is not passed to=20
>>=20
>>                   ret =3D perf_session__queue_event(session, event, time=
stamp, file_offset);
>>=20
>> in perf_session__process_event, this happens right when processing
>> buildids in 'perf record', and also in 'perf report', so that is
>> something badly synthesized that hits perf.data for PERF_RECORD_KSYMBOL.
>=20
> it's reproducible with simple:
>  perf record -e cycles,instructions ls
>=20
> as you said on irc, it's the machine->id_hdr_size size missing
> there's one more glitch, attached patch fixes that for me
> you can't use sizeof(struct ksymbol_event), because it includes
> the name as well.. which screws the size
>=20
> but I don't know that code that much.. might be still something
> missing
>=20
> jirka

Hi Arnaldo and Jiri,

Thanks for catching and fixing the bug.=20

I guess the following is OK?

        *bpf_event =3D (struct bpf_event){
                .header =3D {
                        .type =3D PERF_RECORD_BPF_EVENT,
                        .size =3D sizeof(struct bpf_event),
                },
                .type =3D PERF_BPF_EVENT_PROG_LOAD,
                .flags =3D 0,
                .id =3D info.id,
        };

as struct bpf_event doesn't have variable length name:

        struct bpf_event {
                struct perf_event_header header;
                u16 type;
                u16 flags;
                u32 id;

                /* for bpf_prog types */
                u8 tag[BPF_TAG_SIZE];  // prog tag
        };

Or we need similar fix?=20

Song=
