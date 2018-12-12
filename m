Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3043CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EB020811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gvoBnguz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YIXoXh3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EB020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeLLS4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:56:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbeLLS4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:56:55 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBCItrQJ002619;
        Wed, 12 Dec 2018 10:56:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OYiYgZgyYrWh+ry+9U/SRMMgUejj74SnzIBvl+94vAc=;
 b=gvoBnguzT+o289SHLkD6D9b+O94lJCfBO5ymvRz89OkCIKqlp/wQR6jSe0xGrACDI9Gc
 ut22kYe4q9/dmutYqav07Ab2EH0tw/qUAPQN2rj6hSs/GdgsZPsdvhU2BjvuTLpdQ4kk
 Rsob02bKKCLNY6EVwxVgWIoM8KOaG3eSeEI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pb56v8qf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Dec 2018 10:56:15 -0800
Received: from frc-mbx08.TheFacebook.com (2620:10d:c0a1:f82::32) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 12 Dec 2018 10:56:14 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx08.TheFacebook.com (2620:10d:c0a1:f82::32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 12 Dec 2018 10:56:13 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 12 Dec 2018 10:56:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYiYgZgyYrWh+ry+9U/SRMMgUejj74SnzIBvl+94vAc=;
 b=YIXoXh3HIajEho4kzNRU++BK+IIROmu4RV32weQXDRO5cEXVQqU8T+9rLGKmNCFlHGWa5EGrkdDRLAHyjOF6FL4e/lHjKjh7ip/yJmuE7QMbVwczGoHYtGELuQWJ8nf6isCOxQBuK9MijjECzoX54Z1ppbBD29v4IOylwASuOZo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1424.namprd15.prod.outlook.com (10.173.234.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Wed, 12 Dec 2018 18:56:11 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a165:7ace:d8a:de65]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a165:7ace:d8a:de65%8]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 18:56:11 +0000
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
Thread-Index: AQHUkan/BrxKv3p0HEGwaC6e4kWgY6V7FkWAgABBOQCAAA/SgIAADgwA
Date:   Wed, 12 Dec 2018 18:56:11 +0000
Message-ID: <3D79DAF3-0746-41A2-B902-E1D99F098AF9@fb.com>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181212180553.GC5289@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::5:37be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1424;20:YIch4yC9I/IcuqfCjVrlTIictt36hgg8+8Cu+RQ4toJdmj+rAiQfkelcE2S8LMw3IwSNAnkfBi1J/Z7TCel/J10LAoxEDUl6vv8MFXMVvhOihfttC4FcOjBGRufZWWkUi2lYlE+oYNgQkYivkPH8z3qj+AkFukf7J6EDhVpXM6w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7279d590-631a-48c6-cc90-08d660637bdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1424;
x-ms-traffictypediagnostic: MWHPR15MB1424:
x-microsoft-antispam-prvs: <MWHPR15MB1424D09933D1734657048074B3A70@MWHPR15MB1424.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(93006095)(93001095)(3231455)(999002)(11241501185)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1424;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1424;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(199004)(189003)(8676002)(7736002)(256004)(106356001)(33656002)(6246003)(186003)(82746002)(50226002)(5660300001)(81156014)(81166006)(105586002)(305945005)(6116002)(11346002)(76176011)(46003)(6512007)(102836004)(6506007)(478600001)(99286004)(6436002)(446003)(53546011)(476003)(316002)(83716004)(71190400001)(86362001)(97736004)(57306001)(54906003)(486006)(2616005)(53936002)(14454004)(14444005)(6916009)(6486002)(36756003)(71200400001)(229853002)(25786009)(68736007)(93886005)(8936002)(2906002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1424;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q5SjsnF8jSteJzigw0wkS9XAgID5GcY5GzJWj2pgDoqXzTiYs1+wQey3wb01CpUYQUMe3a6giZoW3vHsnmEp4QaoCyEXe3O/W4BG/HafANIkeao23aHkgqke7y89ld+/CD45iTD7BUbvVaraAmT91CIM6O4rylf2CnCR17RNgGHHFFNp9lCGmUxdJ9jeObYslqaSfxeuZSajkfvg9xqGfHTFII4gVSzYyakEWZm0Vew+IoSjYcmNJAKvVJ+TkHS3GXqxO/41gSVWg/MyPiEOSF1RAQvSC9HK7noG14T0i7ziAETT1gVv6VSiPCitgUNC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8AC75F9A89DD5445B6197C1E11CA21EC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7279d590-631a-48c6-cc90-08d660637bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:56:11.3503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1424
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2018, at 10:05 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
>>> And while this tracks the bpf kallsyms, it does not do all kallsyms.
>>>=20
>>> .... Oooh, I see the problem, everybody is doing their own custom
>>> kallsym_{add,del}() thing, instead of having that in generic code :-(
>>>=20
>>> This, for example, doesn't track module load/unload nor ftrace
>>> trampolines, even though both affect kallsyms.
>>=20
>> I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload.=20
>> That could be separate sets of patches.=20
>=20
> So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
> bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
> and also have ftrace use that.
>=20
> Because currently the ftrace stuff is otherwise invisible.
>=20
> A generic kallsym register/unregister for any JIT.

I guess this is _not_ a requirement for this patchset? BPF program has
special data (id, sub_id, tag) that we need PERF_RECORD_BPF_EVENT. So=20
this patchset should be orthogonal to the generic kallsym framework?

Thanks,
Song
