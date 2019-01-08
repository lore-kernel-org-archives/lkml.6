Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C21C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF61217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UJH2Rwy8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UzPpgkq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfAHXy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:54:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728642AbfAHXy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:54:57 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08Noxef019688;
        Tue, 8 Jan 2019 15:54:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=w87Z/q/nRYgfuGG+cEL62PpWw7lXRboD9oNZCMEi8tA=;
 b=UJH2Rwy8hwm848ArznsTe+WajJanUwWoA3nuwTEOIhZ/S1fD2Vh2VAD/VhOuNAOo/EC8
 Z0Sc7BYVgAT1QNa63I/USRGD63/x/qPV/H3wQHdroyLMH3ETm7bKvIgewohSaS4QGhD7
 rzYEGgfA/Fq1K9T5JLFSRd90Em+3gr9uIz4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pw33u0jgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 15:54:27 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 8 Jan 2019 15:54:26 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 8 Jan 2019 15:54:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w87Z/q/nRYgfuGG+cEL62PpWw7lXRboD9oNZCMEi8tA=;
 b=UzPpgkq3uh6Jd6mBVDIG6a+6HU9bMMwY7dX2paRHHMrjuoTx7xyrSw85kNjNrAObjKYkSHJD+FfA7H/1gTyCMZ2yWvZ7LqSowBuSIYQB+Sv9QZk7eYPzTt7b5wdDa6FGLq1jOGvn9i5GuSJIiH4thyAugWUxmHzbAKp8qvSTX0Y=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1375.namprd15.prod.outlook.com (10.173.234.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 23:54:05 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 23:54:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUmJHygB8CuOaEkU2QMQ4A40UscaWl0lUAgAAIHwCAAAktAIAARhkA
Date:   Tue, 8 Jan 2019 23:54:04 +0000
Message-ID: <A0C713E9-6ACE-4235-87C2-2653A8F22F7B@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
 <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
 <20190108194310.GD1900@hirez.programming.kicks-ass.net>
In-Reply-To: <20190108194310.GD1900@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::5:43fb]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1375;20:30cu2JAbd9TBMc9y6Y0KKd4f76xTWTmrg+aITwDj1X5zFbp3HRhu4tyyTBsR1/qptlTWJysSOkLvDvw3tNqkJMnXhhUejXjTUuNz8et8AJwqSaKEWBkYXmm0rj33/yWUJDp6x4PBmKagEXdFOmQ77GV2q89HRooaG176Tm55lW0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d1c36917-0d5d-4454-3069-08d675c4926a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1375;
x-ms-traffictypediagnostic: MWHPR15MB1375:
x-microsoft-antispam-prvs: <MWHPR15MB137573C9371CE49E8253A770B38A0@MWHPR15MB1375.namprd15.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(39860400002)(396003)(51444003)(199004)(189003)(57306001)(186003)(71200400001)(4326008)(71190400001)(97736004)(14454004)(305945005)(7736002)(486006)(966005)(68736007)(6916009)(86362001)(478600001)(25786009)(106356001)(99286004)(83716004)(36756003)(82746002)(256004)(14444005)(46003)(105586002)(6116002)(6506007)(53546011)(8676002)(6246003)(54906003)(76176011)(11346002)(6512007)(446003)(6306002)(2616005)(476003)(229853002)(316002)(102836004)(6436002)(5660300001)(53936002)(50226002)(81156014)(81166006)(8936002)(93886005)(33656002)(6486002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1375;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FVdssIuRbdypH5VO2f0QLuCRjITnmWtE2tUlOUsqEoGEy0wR9qugJ1IPYFFsZIYpNWCsyQPGQenjwiLQLdb+pCxBP8fq0MfN94twyG5YoABD672XlQyt6evWPKsK5XVrp1y/yVm9iDz3yvYHUE1gu08O4ZL3DDuF+InymZ5WQXYLty8tY53jbtz63iLlSlOzOuMdVTrG/tCuSynVxtCbBEqpXhz0BQRL0zYO8De18TVxYiAk6S42JMs7aUvgZPBRVQL+cEPQDK/XFpURX1x7mXQR/qvpQK7RE5JOMYoL7uZW/P/qVGOfT4wdH6t3Qegm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF65D9179275104B82DEA05E38B29559@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c36917-0d5d-4454-3069-08d675c4926a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 23:54:04.8064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1375
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 8, 2019, at 11:43 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Jan 08, 2019 at 07:10:20PM +0000, Song Liu wrote:
>>> On Jan 8, 2019, at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>> On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
>>>> @@ -986,9 +987,35 @@ enum perf_event_type {
>>>> 	 */
>>>> 	PERF_RECORD_KSYMBOL			=3D 17,
>>>>=20
>>>> +	/*
>>>> +	 * Record bpf events:
>>>> +	 *  enum perf_bpf_event_type {
>>>> +	 *	PERF_BPF_EVENT_UNKNOWN		=3D 0,
>>>> +	 *	PERF_BPF_EVENT_PROG_LOAD	=3D 1,
>>>> +	 *	PERF_BPF_EVENT_PROG_UNLOAD	=3D 2,
>>>> +	 *  };
>>>> +	 *
>>>> +	 * struct {
>>>> +	 *	struct perf_event_header	header;
>>>> +	 *	u16				type;
>>>> +	 *	u16				flags;
>>>> +	 *	u32				id;
>>>> +	 *	u8				tag[BPF_TAG_SIZE];
>>>> +	 *	struct sample_id		sample_id;
>>>> +	 * };
>>>> +	 */
>>>> +	PERF_RECORD_BPF_EVENT			=3D 18,
>>>> +
>>>=20
>>> Elsewhere today, I raised the point that by the time (however short
>>> interval) userspace gets around to reading this event, the actual
>>> program could be gone again.
>>>=20
>>> In this case the program has been with us for a very short period
>>> indeed; but it could still have generated some samples or otherwise
>>> generated trace data.
>>=20
>> Since we already have the separate KSYMBOL events, BPF_EVENT is only=20
>> required for advanced use cases, like annotation. So I guess missing=20
>> it for very-short-living programs should not be a huge problem?
>>=20
>>> It was suggested to allow pinning modules/programs to avoid this
>>> situation, but that of course has other undesirable effects, such as a
>>> trivial DoS.
>>>=20
>>> A truly horrible hack would be to include an open filedesc in the event
>>> that needs closing to release the resource, but I'm sorry for even
>>> suggesting that **shudder**.
>>>=20
>>> Do we have any sane ideas?
>>=20
>> How about we gate the open filedesc solution with an option, and limit
>> that option for root only? If this still sounds hacky, maybe we should
>> just ignore when short-living programs are missed?
>=20
> I'm afraid we might also 'need' this for the kallsym thing.
>=20
> The problem is that things like Intel PT (ARM Coresight too IIRC) encode
> a bitstream of branch-taken decisions. The only way to decode that and
> reconstruct the actual code-flow is with an exact matching text image.
>=20
> In order to have this matching text we need to be able to copy out every
> piece of dynamic text (from kcore) that has ever executed before it
> dissapears.
>=20
> Elsewhere (*), Andi suggests to have a kind of text-free fence
> interface, where userspace can call a complete. And I suppose as long we
> know there is a consumer, we also know we'll not be blocked
> indefinitely. So it would have to be slightly more complicated than
> suggested, but I think that is something we could work with.
>=20
> It would also not complicate these events.
>=20
>=20
>=20
> [*] https://lkml.kernel.org/r/20190108172721.GN6118@tassilo.jf.intel.com

I think Intel PT case is at instruction granularity (instead of ksymbol
granularity)? If this is true, modules, BPF, and PT could still share
the ksymbol record for basic profiling. And advanced use cases like=20
annotation will depend on user space to record BPF_EVENT (and equivalent
for other cases) timely. But at least, the ksymbol is already there.=20

Does this make sense? =20

Thanks,
Song=20



