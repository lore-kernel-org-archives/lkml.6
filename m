Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A44C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A41320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lcPCrL5Y";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hVvXVTWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfAQPEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:04:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727165AbfAQPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:04:06 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HEqugV020501;
        Thu, 17 Jan 2019 07:03:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FsnndOH3S/oykv3b4Kats5oRj+J0bwwNca6VVXO8ecQ=;
 b=lcPCrL5YecDniSqBbP45k+8RXgMCFa2keCm4lXAUx7hTyz+T4bVl58qnEpxNz1gnuiw8
 KfOEeqsaw9SBW2cPGmrHDY+yGucf891juGvUgQEohDGy+29pbKhqi8FrKmlsxVng8Wes
 yVuVUtJ8zdQsPYRK86zrBj3yS73ndaEIIWE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q2tpag8sn-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Jan 2019 07:03:18 -0800
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 17 Jan 2019 07:02:51 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 17 Jan 2019 07:02:50 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 17 Jan 2019 07:02:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsnndOH3S/oykv3b4Kats5oRj+J0bwwNca6VVXO8ecQ=;
 b=hVvXVTWNBwCQ+go32qlmH12GwdVNobH8tUwlNZSk/Hn737UGRSs5lLZd3UAsm4hHK4wBdSWbPC+ws1y9ZR3TgrEIHlwqPWPlmKHtmidMxJ9jaBFy7pkYzK+Vm8ls3xbB/N4nRJvyOn1FN0QBlm6/h6Br6TfID/JQHruggPO8KAM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1840.namprd15.prod.outlook.com (10.174.255.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 15:02:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 15:02:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        David Ahern <dsahern@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Topic: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Index: AQHUrbi9c1EElErIo0qiEt/rp76sWqWzbMuAgAAfXoCAAAK5AIAAARcA
Date:   Thu, 17 Jan 2019 15:02:49 +0000
Message-ID: <541046F3-7262-44D6-A7B1-7CA36FC0539B@fb.com>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-2-songliubraving@fb.com>
 <20190117125653.GF10486@hirez.programming.kicks-ass.net>
 <A411D89E-0B62-4DE7-9D70-CD57672FD20A@fb.com>
 <20190117145854.GD5823@kernel.org>
In-Reply-To: <20190117145854.GD5823@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:4cc3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1840;20:kjdQOY9569V38h7qB7ioUSdWAaPCY84b4d3WdfKbeSNn9bW7QDENYHfvRQh/A0Vbqhwam+Yxk2+cUxtMosUO/WKvdiUgKYmtQIt+1oVeRN7fqa+WKqru7IZ6O9issLoUrZj+0bRGtwXxo0vul6yQ1yl+IBpeLUXHjyfFaUMLJ+E=
x-ms-office365-filtering-correlation-id: 761d4bc9-494f-4b77-a8e4-08d67c8cd8d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1840;
x-ms-traffictypediagnostic: MWHPR15MB1840:
x-microsoft-antispam-prvs: <MWHPR15MB18405D903928BD20865AF811B3830@MWHPR15MB1840.namprd15.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(54534003)(2906002)(316002)(6916009)(33656002)(86362001)(229853002)(6246003)(53936002)(6512007)(478600001)(5660300001)(25786009)(4326008)(54906003)(105586002)(57306001)(39060400002)(186003)(106356001)(93886005)(256004)(14444005)(5024004)(14454004)(102836004)(53546011)(6506007)(71190400001)(71200400001)(83716004)(2616005)(6116002)(305945005)(476003)(7736002)(99286004)(11346002)(446003)(68736007)(8936002)(486006)(6436002)(8676002)(46003)(76176011)(97736004)(6486002)(50226002)(81166006)(36756003)(81156014)(82746002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1840;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sd9UlgDuyOrrgE6VVResZuvAayD/zv9CNHvlANAHCsbUETFgb2Iq8RtQUgCKlONciZaBVtdLxDDJ098B9ACCk3WLG2yokkKK/PphiWvy96Brj+Tq81EkMQIO9obO1u6vuTEa3PLr2ghzzQ2nV6DpR109PRRtGew3EPQA3uBERKKnNBbNCaclWCJCCdJljMkOBbOObUjQsuKOcRjbltx3nPlv14BWl9UpLlygZV6T3B2iIooLEbIy7UBsh7cX4AfdbWiCf9rXlhPlnMkoGXqQUjVACW8HXfOwuWM5KXro6a84jN532DU4FWtQBr9UXSylMwcaMSiX6Veyqz6xqKoQGLpfQrOk1sp4RiAs/eNyoJh12X5eJgwmpEFBhnxUloEGZr7fJR4U2sFAjv0Q8+eQLP5AyYAZ/PM4ACqukKODMlw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74343170D904B142A37B5DDD149D0430@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 761d4bc9-494f-4b77-a8e4-08d67c8cd8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 15:02:49.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1840
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2019, at 6:58 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Thu, Jan 17, 2019 at 02:49:10PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Jan 17, 2019, at 4:56 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>>=20
>>> On Wed, Jan 16, 2019 at 08:29:23AM -0800, Song Liu wrote:
>>>> For better performance analysis of dynamically JITed and loaded kernel
>>>> functions, such as BPF programs, this patch introduces
>>>> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
>>>> register/unregister information to user space.
>>>>=20
>>>> The following data structure is used for PERF_RECORD_KSYMBOL.
>>>>=20
>>>>   /*
>>>>    * struct {
>>>>    *      struct perf_event_header        header;
>>>>    *      u64                             addr;
>>>>    *      u32                             len;
>>>>    *      u16                             ksym_type;
>>>>    *      u16                             flags;
>>>>    *      char                            name[];
>>>>    *      struct sample_id                sample_id;
>>>>    * };
>>>>    */
>>>=20
>>> So I've cobbled together the attached patches to see how it would work
>>> out..
>>>=20
>>> I didn't convert ftrace trampolines; because ftrace code has this
>>> uncanny ability to make my head hurt. But I don't think it should be
>>> hard, once one figures out the right structure to stick that
>>> kallsym_node thing in (ftrace_ops ?!).
>>>=20
>>> It is compiled only, so no testing what so ever (also, no changelogs).
>>>=20
>>> I didn't wire up the KSYM_TYPE thing; I'm wondering if we really need
>>> that, OTOH it really doesn't hurt having it either.
>>>=20
>>> One weird thing I noticed, wth does bpf_prog_kallsyms_add() check
>>> CAP_ADMIN ?! Surely even a non-priv JIT'ed program generates symbols,
>>> why hide those?
>>>=20
>>> Anyway; with the one nit about the get_names() thing sorted:
>>>=20
>>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>=20
>>> (thanks for sticking with this)
>>> <peterz-latch-next.patch><peterz-kallsym.patch><peterz-kallsym-bpf.patc=
h>
>>=20
>> Aha, now I get the point on perf_event_ksymbol(). Yeah this approach is=
=20
>> definitely better.=20
>>=20
>> While I run more tests with these patches, could we get current in=20
>> perf/core? This will enable the development of user space tools like
>> bcc.=20
>>=20
>> Also, I current base this set on bpf-next tree, as tip/perf/core is=20
>> 4 week old. Shall I rebase the set on Linus' tree? Or shall I wait for
>> tip/perf/core?
>=20
> So, can you post one last set, this time with PeterZ's Acked-by,
> assuming you're sorting out the get_names() thing, and I can try merging
> this into my perf/core branch, then pushing it out to Ingo, my perf/core
> starts from tip/perf/urgent, so should be new enough.
>=20
> I'd then right after testing it send a pull request to Ingo, synching
> everything.
>=20
> - Arnaldo

Thanks Arnaldo! I will send it soon.=20

Song

