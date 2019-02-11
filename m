Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEFCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF20218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VxDwgM+Y";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="L1N6jA1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBKUa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:30:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55308 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfBKUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:30:58 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BKTPpj008319;
        Mon, 11 Feb 2019 12:30:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FUvbzbBPrA4GM+8nSqBEBKfuHroOuTRAns+mvTtZqNk=;
 b=VxDwgM+YrGJkggZMIr5Aqe/jtyh1orLFCbor8WX4jQx7rQdYMSKxNzJIXQm7SqBvrzFZ
 4bg1I6xy+4UH1H9/+UEDkhsCJb/iZgmGgMBWnWBYKLIRoCWRJdrW9O2n2p9IYeE9aknW
 IedXaCYkDMYZ5IKfhpZCHbuVtHR3Hz8h+8I= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qkfb785rt-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 12:30:45 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 11 Feb 2019 12:30:25 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 11 Feb 2019 12:30:25 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 11 Feb 2019 12:30:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUvbzbBPrA4GM+8nSqBEBKfuHroOuTRAns+mvTtZqNk=;
 b=L1N6jA1CcPXZ02EHTJlvFG8ah0A/E9UbdTuXvGHO8unojn3VhSY1HufhDYUB/CPlWG1GdkZq5LUYHPW6E7Euz7zCVxipHr/tv7vxaBDi26lmZP+YvLF4HKmbm2rXyMMg12WLhatxSrJyCLG2dzZpxmur2cSormFyxAU2elggyyU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 20:30:22 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 20:30:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Stephane Eranian <eranian@google.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Thread-Topic: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Thread-Index: AQHUwjtlRyzpVjG3JkKhkHGKKI1AuqXa++yAgAAQ1YA=
Date:   Mon, 11 Feb 2019 20:30:22 +0000
Message-ID: <90265D59-C5B9-4AD2-B5EA-0ADC9BEF7C79@fb.com>
References: <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava>
 <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org>
 <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava>
 <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava> <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185510.GF3269@kernel.org>
 <CABPqkBTOM2gLvv89ywkpWDKniS2L37XhKPjNLtR8WCY3VuYXzw@mail.gmail.com>
In-Reply-To: <CABPqkBTOM2gLvv89ywkpWDKniS2L37XhKPjNLtR8WCY3VuYXzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::5:758]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1790;20:q/klSQkYEBqdS49KvAgQuKDZMZCEP2aV1XfluUNWRx9dMe5n9Uo1yvfQhMQMsTooFWzR7h/v+rAXnXdjSXoJ2d1fyxPJOeuTqZxiFFf7W33jVTrEqUihttKXLKm3vk+BvDs+7C/Piemg5ORkSPrj5EF/zfPUG6pVh/AVnymaXrE=
x-ms-office365-filtering-correlation-id: 30614848-31de-411f-69bb-08d6905fbf2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1790;
x-ms-traffictypediagnostic: MWHPR15MB1790:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB17909885318F54D2C66DC5BFB3640@MWHPR15MB1790.namprd15.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(53936002)(33656002)(6436002)(6306002)(25786009)(71190400001)(54906003)(14454004)(6246003)(4326008)(106356001)(86362001)(6512007)(478600001)(99286004)(966005)(71200400001)(105586002)(76176011)(83716004)(6486002)(6116002)(2616005)(11346002)(93886005)(57306001)(7416002)(446003)(476003)(46003)(486006)(6916009)(97736004)(2906002)(186003)(305945005)(256004)(68736007)(14444005)(229853002)(316002)(8936002)(50226002)(81156014)(102836004)(81166006)(8676002)(36756003)(7736002)(6506007)(53546011)(82746002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1790;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CNgjLqjl/Ze9k5ZODnkBq7Vb0p/ECKQMvE74nliulrNdqsZi+3wubfTzbqQ2scv2uTGQSJjdQ6gisokZY/qNRvi6yQkylCXr6NIm2nXrZuu3T/NT9q9M/h8E45Rq9h4F4bN9SDmqDNGW6dCzi3pMcnYZBUIcYmpm+gwazTvZV8qcNGPWyLNDJejSnWcU9lxWNgbcJKxVZvPN4NFxBbOhYYab1dW1kbo8QEAm8DPR1z6zhDwIz/OsRrV1mYO4zoNh7eLl+2xTJIAMsHV6kj0s5GdfaKhSRjkcPoKNMxBTbujUG8PYLjQ4zLvbT7qvo/QSH0JGA7nOg7XaaWCA+LYr+KKRRWyfHdkiPcPC5yKbdTXvPm/qflNMxeSPID8PL6PuwcthdW0zVj4eBvFtmY9VM8/BAuAe0B7Yk8Mg6FNq1xY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8420259236415E44B8AD523B42318266@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30614848-31de-411f-69bb-08d6905fbf2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 20:30:22.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1790
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 11, 2019, at 11:30 AM, Stephane Eranian <eranian@google.com> wrote=
:
>=20
> Arnaldo,
>=20
> On Mon, Feb 11, 2019 at 10:55 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>=20
>> Em Mon, Feb 11, 2019 at 10:34:16AM -0800, Stephane Eranian escreveu:
>>> Jiri,
>>>=20
>>> On Mon, Feb 11, 2019 at 2:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
>>>>=20
>>>> On Tue, Feb 05, 2019 at 02:37:27PM +0100, Jiri Olsa wrote:
>>>>> On Mon, Feb 04, 2019 at 02:44:37PM -0800, Stephane Eranian wrote:
>>>>>> Jiri,
>>>>>>=20
>>>>>> While you're looking at the output format, I think it would be good
>>>>>> time to simplify the code handling perf.data file.
>>>>>> Today, perf record can emit in two formats: file mode or pipe mode.
>>>>>> This adds complexity in the code and
>>>>>> is error prone as the file mode path is tested more than the pipe mo=
de
>>>>>> path. We have run into multiple issues with
>>>>>> the pipe mode in recent years. There is no real reason why we need t=
o
>>>>>> maintain two formats. If I recall, the pipe format
>>>>>> was introduced because on pipes you cannot lseek to update the heade=
rs
>>>>>> and therefore some of the information present as tables
>>>>>> updated on the fly needed to be generated as pseudo records by the
>>>>>> tool. I believe that the pipe format covers all the needs and could
>>>>>> supersede the file mode format. That would simplify code in perf
>>>>>> record and eliminate the risk of errors when new headers
>>>>>> are introduced.
>>>>>=20
>>>>> yep, I think we have almost all the features covered for pipe mode,
>>>>> and we have all necessary events to describe events features
>>>>>=20
>>>>> so with some effort we could switch off the superfluos file header
>>>>> and use only events to describe events ;-) make sense, I'll check
>>>>> on it
>>>>=20
>>>> so following features are not synthesized:
>>>>=20
>>>>        FEAT_OPN(TRACING_DATA,  tracing_data,   false),
>>>>        FEAT_OPN(BUILD_ID,      build_id,       false),
>>>>        FEAT_OPN(BRANCH_STACK,  branch_stack,   false),
>>>>        FEAT_OPN(AUXTRACE,      auxtrace,       false),
>>>>        FEAT_OPN(STAT,          stat,           false),
>>>>        FEAT_OPN(CACHE,         cache,          true),
>>>>=20
>>> What do you need for BRANCH_STACK?
>>>=20
>>>> I think all could be added and worked around with exception
>>>> of BUILD_ID, which we store at the end (after processing
>>>> all data) and we need it early in the report phase
>>>>=20
>>> Buildids are injected after the fact via perf inject when in pipe mode.
>>>=20
>>>> maybe it's time to re-think that buildid -> mmap event
>>>> association again, because it's pain in current implementation
>>>> as well
>>>>=20
>>> Sure, but what do you propose?
>>=20
>> this keeps resurfacing, the idea is to have the building go together
>> with the PERF_RECORD_MMAP3 event, i.e. as part of setting up an
>> executable mapping the loader would get the buildid and ask the kernel
>> to keep it aroung, then when a PERF_RECORD_MMAP needs to be issued, it
>> can include the build id, so tooling will not need to get it.
>>=20
> And how would the dynamic loader (ld.so) communicate the buildid to the k=
ernel?
> How would that work for statically linked binaries.
> I think you're say the kernel would parse the ELF header looking for
> that note section
> and extract the buildid from there. Is that what you are proposing?

We have kernel parses ELF header for BUILD-ID in BPF side. You can=20
find the code in stack_map_get_build_id_offset() and functions called
by it.=20

>=20
>> Alternatively, we would have a separate thread to process
>> PERF_RECORD_MMAP events, and as soon as it gets one from the kernel,
>> augment it straight away with the build-id it reads from the ELF file,
>> i.e. no need to have the kernel provide it, do it just like we do with
>> PERF_RECORD_BPF_EVENT, which reminds me Song probably already posted
>> thise bits...
>>=20
> But that would not work in pipe mode, wouldn't it?
> Unless that thread intercepts everything pushed to the pipe looking
> for MMAP records.

For PERF_RECORD_BPF_EVENT, I am adding a separate thread, which only
listen to PERF_RECORD_BPF_EVENT with watermark of 1. This means,=20
each PERF_RECORD_BPF_EVENT is sent to two ring buffers. One of them
got written to the pipe, the other is only processed by the listening
thread. Please see https://patchwork.ozlabs.org/patch/1039091/ for=20
details.=20

Thanks,
Song

>=20
>>>> looks like bpf code is actualy getting build ids and storing
>>>> it for the callchains in kernel.. we can check if we can do
>>>> something similar for mmap events
>>>>=20
>>>> jirka
>>=20
>> --
>>=20
>> - Arnaldo

