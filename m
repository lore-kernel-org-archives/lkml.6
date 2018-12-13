Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACA7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71AD2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CsdjFiGI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JPwGwETZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71AD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbeLMQIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:08:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728059AbeLMQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:08:41 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBDG5LkH011930;
        Thu, 13 Dec 2018 08:07:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=PC9EfKN/ObKmr1o33zsl3h4+ClegvGjpyofJvJpJVKM=;
 b=CsdjFiGIxAARPnSRmDdBVJJ1XEbdQklQcOiMLwQoL0M3+VR7HtOuSS1/EtnnFtqvJhSX
 tdqqzFqzoXZhKTF1hKaCCSUTas9ZH48bq6tHDYCMHA/ew2vnHn7zq2E0AWFOZNhS6ei+
 3R/BX7iUHKs5m3GH1nNTJSNOoTkMjf6draU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pbq91gn8r-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Dec 2018 08:07:51 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 13 Dec 2018 08:07:36 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 13 Dec 2018 08:07:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC9EfKN/ObKmr1o33zsl3h4+ClegvGjpyofJvJpJVKM=;
 b=JPwGwETZUAPUPGyCArld/RTAQj53P1/cREmLrdI+bK25L/Eeug5SvLQdEbv8ZPubZc7OA+VzFv87P9nw2rfnkonMvzfU6sCtaSdqErcENfViWmAUxxTbODqVJ0LXp1+beR6c+MM/vjdNb3ypoAeRsWTpaNzZQtoYnZWWSDcat1M=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1497.namprd15.prod.outlook.com (10.173.225.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 13 Dec 2018 16:07:24 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::2d27:7549:4f23:c230]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::2d27:7549:4f23:c230%6]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 16:07:24 +0000
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
Thread-Index: AQHUkan/BrxKv3p0HEGwaC6e4kWgY6V7FkWAgABBOQCAAA/SgIAADgwAgAFXkoCAAAubgA==
Date:   Thu, 13 Dec 2018 16:07:23 +0000
Message-ID: <0EA5B36C-0A7A-442D-B1EF-E7C2E63109F2@fb.com>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
 <3D79DAF3-0746-41A2-B902-E1D99F098AF9@fb.com>
 <20181213152551.GL5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181213152551.GL5289@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:c293]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1497;20:Hauw0QVSLpPiK15xxSRzvAJBJi+lB3NRCpsswjJT6iti+24Ej8/qPcn1zWnwsESh/38nrovMwr2oMVKj8Q/nOGiVG50U8V7ySESKdafcr3DZiIoGkY/IK93WYtgJCGyYSSvBjNdu0SUGPikWxFw6676fXMVbaGGbQYjqngmXd/4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 02de36d1-3b53-4601-6569-08d6611511dd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1497;
x-ms-traffictypediagnostic: DM5PR15MB1497:
x-microsoft-antispam-prvs: <DM5PR15MB1497124AFDB0300153B89370B3A00@DM5PR15MB1497.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR15MB1497;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1497;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(14454004)(7736002)(229853002)(6486002)(2906002)(8676002)(46003)(93886005)(256004)(14444005)(36756003)(105586002)(6436002)(106356001)(5660300001)(8936002)(6116002)(57306001)(81156014)(305945005)(6916009)(81166006)(50226002)(83716004)(4326008)(71200400001)(71190400001)(99286004)(11346002)(446003)(102836004)(53546011)(2616005)(6506007)(486006)(476003)(6246003)(316002)(186003)(25786009)(54906003)(86362001)(478600001)(33656002)(76176011)(82746002)(97736004)(6512007)(53936002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1497;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SSl+zQ6rP9eL03qiBjUdUNnrEosGh3QIibcDlkPTWudhaedoqi4A9Shbtzj+ydyOrlc6uZYGkYkGkNaHGjtjFHDVqm3QiZ6JOBrcAzyLuejA9i/m8FFWhv11W1fwY8RhTDBCNJoGWYGaSbA85121TQekQgri5Y7oXVQty/766MzWoGIXraepMZW8W8DStLwElVv832V4rt/WQP2M6tFJE680RQdg+SE10PepTL5mf8sTiO7Ynm1u0fg1kLfGVAcVKWuO3L3enLYppvB5YwH1mjqMVOea2vw0KO0gAWupWgY+jl7HXXv5NDpVORWIq6Sf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DB6563A5E014245A5D293F6AC2611EB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02de36d1-3b53-4601-6569-08d6611511dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 16:07:23.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1497
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 13, 2018, at 7:25 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Dec 12, 2018 at 06:56:11PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Dec 12, 2018, at 10:05 AM, Peter Zijlstra <peterz@infradead.org> wro=
te:
>>>=20
>>> On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
>>>>> And while this tracks the bpf kallsyms, it does not do all kallsyms.
>>>>>=20
>>>>> .... Oooh, I see the problem, everybody is doing their own custom
>>>>> kallsym_{add,del}() thing, instead of having that in generic code :-(
>>>>>=20
>>>>> This, for example, doesn't track module load/unload nor ftrace
>>>>> trampolines, even though both affect kallsyms.
>>>>=20
>>>> I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload.=
=20
>>>> That could be separate sets of patches.=20
>>>=20
>>> So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
>>> bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
>>> and also have ftrace use that.
>>>=20
>>> Because currently the ftrace stuff is otherwise invisible.
>>>=20
>>> A generic kallsym register/unregister for any JIT.
>>=20
>> I guess this is _not_ a requirement for this patchset? BPF program has
>> special data (id, sub_id, tag) that we need PERF_RECORD_BPF_EVENT. So=20
>> this patchset should be orthogonal to the generic kallsym framework?
>=20
> Well, it is a question of ABI. I don't like mixing the kallsym updates
> with the BPF updates.

I have been always thinking the two is one update: "mapping this BPF=20
program to this ksym".=20

On the other hand, if we really want to separate the two. I guess we=20
need two PERF_RECORD_*:

       /*
        * PERF_RECORD_KSYM_ADD/DEL or MMAP3/MUNMAP3
        *
        * struct {
        *      struct perf_event_header header;
        *      u64                             addr;
        *      u64                             len;
        *      char                            name[];
        *      struct sample_id                sample_id;
        * };
        */

and

       /*
        * PERF_RECORD_BPF_EVENT
        *
        * struct {
        *      struct perf_event_header header;
        *      u32                             type;
        *      u32                             flags;
        *      u32                             id; // prog_id or other id
        *      u32                             sub_id; // subprog id
        *
        *      // for bpf_prog types, bpf prog or subprog
        *      u8                              tag[BPF_TAG_SIZE];
        *      struct sample_id                sample_id;
        * };
        */

In this case, PERF_RECORD_BPF_EVENT is only needed when user want
annotation. When annotation is needed, kernel will generate both
record for each BPF program load/unload. Then, user space will do=20
some work to match the two.=20

Personally, I think this is not as clean as current version. But
it would work.=20

Would you recommend we go on this direction?=20

Thanks,
Song



