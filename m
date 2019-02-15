Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E39C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D865A222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cmZxqbej";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QeNPkisz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404036AbfBOS7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:59:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46932 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390758AbfBOS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:59:46 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FIo3bN015401;
        Fri, 15 Feb 2019 10:59:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3vYpzszNYilDxNi4NUY8mTPEoyyoUxsDcdXMxuwvsAU=;
 b=cmZxqbej+C0h02pxENjfvLQoekMMdVJEGOfnU/I1Z+umroWLTTDRVmWCLNLiI6ykYH2E
 stN4W5FrUcAUkiSFSL2nkAhhKTjhNS0GElUFDzzsVFjuq7eDZ1BHMZu3TKZuHt74rGI2
 75xnK3aoG2cM870gj5ycZcK4qbbhqCKnGiY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qp2jgr46k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 10:59:17 -0800
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 10:59:16 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 10:59:16 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 10:59:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vYpzszNYilDxNi4NUY8mTPEoyyoUxsDcdXMxuwvsAU=;
 b=QeNPkisz+XYc6oeCT7TpFx+DZ2msOI0wwPii7auHwx8MhdtxFI6RkWzGCGR3xkj4AlKLkpb2xlGxznHNpUemfejHnrqRFVfDwRgUMZq6gc+sCHiGBF2YXQh9nbdGdML0lYvjQkRRNUB4B6ISmj2tE0j1//69adVCREiwIWz9ujY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1629.namprd15.prod.outlook.com (10.175.135.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 18:59:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9%8]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 18:59:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Thread-Topic: [PATCH v2 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Thread-Index: AQHUxMGQlShe9E029kWf9/H0QeuOj6Xg626AgAAx0ACAAARLAIAAAh+AgAAJLICAAAq9gA==
Date:   Fri, 15 Feb 2019 18:59:14 +0000
Message-ID: <F6877640-F6A6-4F2D-B756-0092D7B1237F@fb.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-7-songliubraving@fb.com>
 <20190215142643.GC5784@redhat.com>
 <164D19ED-EA72-4A56-8259-FCF13894B183@fb.com>
 <20190215174022.GF31177@kernel.org>
 <847940EC-6E2A-4985-AE19-27758C301B5D@fb.com>
 <20190215182047.GL31177@kernel.org>
In-Reply-To: <20190215182047.GL31177@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:e850]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4572d16f-f5ac-40ce-2941-08d69377adc3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1629;
x-ms-traffictypediagnostic: MWHPR15MB1629:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1629;20:txTKj/vV9sSrmUkCflVVYT0GlygTQ8WX/+VafBluObp9qY0OFtCJ+HUPppR5oMyfA01h2Uj4LdR1FAI75oWrDeLk+nhoXgUw00DpVFMhV6o1+qFJhi244dPkhA9h3dJASMMMpLHZ9g9hYH0scvpbnxzLQ5SGh7t4YDoVwTA2Yiw=
x-microsoft-antispam-prvs: <MWHPR15MB1629F64B52E7D162DB72FCEDB3600@MWHPR15MB1629.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(229853002)(53546011)(6506007)(6512007)(82746002)(102836004)(6346003)(476003)(2616005)(486006)(53936002)(186003)(6246003)(46003)(11346002)(99286004)(446003)(106356001)(6916009)(25786009)(256004)(76176011)(105586002)(86362001)(36756003)(97736004)(54906003)(2906002)(57306001)(33656002)(6486002)(305945005)(7736002)(316002)(6116002)(478600001)(81156014)(81166006)(8936002)(71200400001)(83716004)(93886005)(4326008)(71190400001)(6436002)(50226002)(8676002)(14454004)(68736007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1629;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yGup50D/QuaCc+VhpVChssWYpMJA1hf8aCKCuyQt8SoWtQmoDp817x11/S9NynqvA+6Xr14O2zOXG3iEDymwM5vep3Y2wVO+zFv70AB2Y5CVLWtCN16uaRn9HO3OruLVUYlG5M7IRM2cmqqfzsrA5r1mAVwoe2+lCGMG8/th9g4Xr1wFiDYC87owbVXyQQS9k+PP/+1yZjD9hYZjgZ7IE5DkOpyl+TbgukkZmlTSxqjilbORQAr6dma70x9tD50TMgYq0ZSM6qtVJHhAUbsd6B86hMqma+I5ebMBa6RaIJ+b9LkbzbOglkXo2aFcWm2kw9EPASH3quT8a37sp1fzAkwFoSqtYs8shk/IzhsVf8yBKgB8OEuTZYWkA2+8+A1gpoDU+/yi8LKs32AxJTPtWvRcpZNyYfV51l6A0+79Y9s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F543B53B4445A243AC564E79EDE092A8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4572d16f-f5ac-40ce-2941-08d69377adc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:59:14.4032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1629
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 10:20 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Fri, Feb 15, 2019 at 05:47:58PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Feb 15, 2019, at 9:40 AM, Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
>>>=20
>>> Em Fri, Feb 15, 2019 at 05:25:01PM +0000, Song Liu escreveu:
>>>>> On Feb 15, 2019, at 6:26 AM, Arnaldo Carvalho de Melo <acme@redhat.co=
m> wrote:
>>>>> Em Thu, Feb 14, 2019 at 04:00:09PM -0800, Song Liu escreveu:
>>>>>> This patch enables perf-record to save btf information as headers to
>>>>>> perf.data A new header type HEADER_BTF is introduced for this data.
>>>=20
>>>>> 	Wouldn't it be better for this HEADER_BTF to be introduced
>>>>> already as an user space event, Song, see:
>>>=20
>>>>> tools/perf/util/event.h
>>>=20
>>>>> and:
>>>=20
>>>>> tools/perf/util/event.c
>>>=20
>>>>> perf_event__synthesize_cpu_map()
>>>=20
>>>> BTF would be short living for short living BPF programs. I guess=20
>>>> saving them as header is easier than merging them with samples.=20
>>>=20
>>>> What's the benefit of saving them as user space events?
>>>=20
>>> When we work with pipe mode, i.e.:
>>>=20
>>> 	perf record -o - | perf report -i -
>>>=20
>>> and other combinations (with 'perf script', 'perf inject', etc), we nee=
d
>>> a way to pass the headers to the other side, and the way was via user
>>> space events.
>>>=20
>>> This is something Stephane and Jiri have been discussing recently,
>>> probably they have more justifications, Stephane, Jiri?
>>>=20
>>> - Arnaldo
>>=20
>> I see. In this case, we will need some synchronization between main
>> thread and the polling thread, as they are both writing to the same
>> pipe.=20
>=20
> So, the whole context is that we need to have 'perf record' to start a
> thread per CPU and then read the already per-cpu mmap buffers in the
> matching thread, with the right affinity, numa settings to have the
> record phase not cause contention, etc, so it ends up dumping one stream
> per CPU in a separate file in a 'perf.data' directory instead of a
> perf.data file.
>=20
> Jiri is working on that, so, if you dump one more stream into that
> directory, it would, at post processing time, be ordered together with
> the other stream, the per-cpu ones.
>=20
> - Arnaldo

I see. This solution looks great.=20

For this set, how about I keep this part as-is (at least for v3)? In=20
this case, it will goes to the header file after Jiri's change. Once=20
Jiri's work is done, I will move them into per-cpu files.=20

Thanks,
Song

