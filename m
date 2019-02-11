Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3292C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A022D217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EUNWGC/n";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Fiz1OvEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfBKUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:11:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727073AbfBKUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:11:57 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BK89Qt032004;
        Mon, 11 Feb 2019 12:11:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hp5kj4KniPan/Z00sNgoOfoIAIziiAU2IVkWDQCcOpU=;
 b=EUNWGC/nnT+FvyAXVd7BWQzb1kz6fw6r01UAoEW99NVtrgI7NVxOzp7DUpJI/50Tdf/0
 fJ85wwSxJ2H3rfqUSuKWPcaNBGfG/IxYCFLfXqAA6Gpt+Qsn/3wAo2uBZfpsTOlh0umi
 s5ftfOxeEwK2NgGKVP6fYvFQFuDEwj3PZkY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qkfre812b-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 12:11:17 -0800
Received: from frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 11 Feb 2019 12:10:48 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 11 Feb 2019 12:10:46 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 11 Feb 2019 12:10:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp5kj4KniPan/Z00sNgoOfoIAIziiAU2IVkWDQCcOpU=;
 b=Fiz1OvEfuGu4RxhRGiwetc72dgzOinEK6z/6qo2KmGT31OiEIM9st1Uwy0JULyOX3TFUr1rpEO6pdxLTdMwdow4X2Q0W8DBvKVIRbcD4PTUcmuxxPjBCbnpa3QYJPX3HGGtrHangcG8iYk7RiG/2hzLAQ1/1MZGsQpdYQlweXDQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1501.namprd15.prod.outlook.com (10.173.235.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Mon, 11 Feb 2019 20:10:44 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 20:10:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 0/9] perf annotation of BPF programs
Thread-Topic: [PATCH 0/9] perf annotation of BPF programs
Thread-Index: AQHUwBU9Jupv7chiSUqbDx7XJDw8M6Xa9iEAgAAVbgA=
Date:   Mon, 11 Feb 2019 20:10:44 +0000
Message-ID: <98553D61-C358-45BA-A023-0777B40D38A3@fb.com>
References: <20190209011705.2160185-1-songliubraving@fb.com>
 <20190211185400.GA2084@redhat.com>
In-Reply-To: <20190211185400.GA2084@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::5:758]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1501;20:1Srey4c8Q14+sWgrWXKkunO5gZBY1nLGdsJNfhU02jnx/FcUzX3Mm0OKJHOSlb8UGWErmFvGUoQTQbQ/UmPqEtBiG286IN2LCHeG9D8gFiBRJwzF9FOJo8w3ME0wvzYoQl6jip0CBRSIY3WinOxYoHtQU7f5IvlmCaARmRbpJ4Y=
x-ms-office365-filtering-correlation-id: 8c17a648-c905-4b8d-27cf-08d6905d012e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1501;
x-ms-traffictypediagnostic: MWHPR15MB1501:
x-microsoft-antispam-prvs: <MWHPR15MB150141F50BA4368975667214B3640@MWHPR15MB1501.namprd15.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(305945005)(36756003)(25786009)(229853002)(86362001)(4326008)(14454004)(68736007)(53546011)(102836004)(6506007)(7736002)(7416002)(6116002)(478600001)(97736004)(53936002)(6246003)(316002)(476003)(256004)(106356001)(6916009)(186003)(11346002)(50226002)(46003)(8936002)(33656002)(54906003)(2616005)(82746002)(2906002)(57306001)(446003)(105586002)(6512007)(71200400001)(83716004)(486006)(71190400001)(99286004)(76176011)(6436002)(81166006)(8676002)(81156014)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1501;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DBjwGmDykkTD9Vl/j1m5qqiia46qz7A6vYYoNHloZXCyOxI4Z1qiylTuqOyOpmB8JGMnTVICPquVIKiuGv5PSJScVi0hJTnLIirF2giczKgHYWgO7w+9yxBFteWVjqa8lOALg2x9fzPXjpVxXOAOoIfjjkBLyP6+8jhhyCx8TntOacNn8ZMpxb4glUaYlHviOqDSshlboB/FkEFFJui0p4eOkECWwvTj1zXaxHmC5Xa6eHInYZi0J/s3VG909xmJxpMBsQ49+6ZyX6Z1pm2WxEisr9sDPbQpoWR5tqDr/9ljYv8lV0TF89CnvIijSdFbStNO/5R88qL7Jmhz31MCEe0i5KzuvLLHgA427LhHVda9le+mipKIB257irN/eZRBl5HHchPXhtoMG/F0U6rfQrR85Gc616UVx/633WGeg6g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBF7744AF40BB04BAE54D4BC2B97EAC4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c17a648-c905-4b8d-27cf-08d6905d012e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 20:10:44.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1501
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 11, 2019, at 10:54 AM, Arnaldo Carvalho de Melo <acme@redhat.com> =
wrote:
>=20
> Em Fri, Feb 08, 2019 at 05:16:56PM -0800, Song Liu escreveu:
>> This series enables annotation of BPF programs in perf.
>>=20
>> perf tool gathers information via sys_bpf and (optionally) stores them i=
n
>> perf.data as headers.
>=20
> Jiri, Stephane, this is the patchkit I mentioned in the context of doing
> away with perf.data headers and instead package everything as userspace
> PERF_RECORD_ metadata events.
>=20
> Song, please add Jiri and Namhyung in future perf patchkits, they are
> listed as perf tools reviewers in MAINTAINANERS and Jiri also is working
> on something directly related.
>=20
> Thanks,
>=20
> - Arnaldo

Thanks Arnaldo! I will keep Jiri and Namhyung in the loop.=20

Song




>> Patch 1/9 fixes a minor issue in kernel;
>> Patch 2/9 to 4/9 introduce new helper functions and use them in perf and
>>     bpftool;
>> Patch 5/9 and 6/9 saves information of bpf program in perf_env;
>> Patch 7/9 adds --bpf-event options to perf-top;
>> Patch 8/9 enables annotation of bpf programs based on information gather=
ed
>>     in 5/9 and 6/9;
>> Patch 9/9 handles information of short living BPF program that are loade=
d
>>     during perf-record or perf-top.
>>=20
>> Commands tested during developments are perf-top, perf-record, perf-repo=
rt,
>> and perf-annotate.
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Note on =
patch dependency  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> This set has dependency in both bpf-next tree and tip/perf/core. Current
>> version is developed on bpf-next tree with the following commits
>> cherry-picked from tip/perf/core:
>>=20
>> (from 1/10 to 10/10)
>> commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
>> commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linux/=
perf_event.h")
>> commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
>> commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linux/=
perf_event.h")
>> commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
>> commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
>> commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BP=
F programs")
>> commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing l=
oaded BPF programs")
>> commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf pro=
grams")
>> commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_=
EVENT")
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> Song Liu (9):
>>  perf, bpf: consider events with attr.bpf_event as side-band events
>>  bpf: libbpf: introduce bpf_program__get_prog_info_linear()
>>  bpf: bpftool: use bpf_program__get_prog_info_linear() in
>>    prog.c:do_dump()
>>  perf, bpf: synthesize bpf events with
>>    bpf_program__get_prog_info_linear()
>>  perf, bpf: save bpf_prog_info in a rbtree in perf_env
>>  perf, bpf: save btf in a rbtree in perf_env
>>  perf-top: add option --bpf-event
>>  perf, bpf: enable annotation of bpf program
>>  perf, bpf: save information about short living bpf programs
>>=20
>> kernel/events/core.c        |   3 +-
>> tools/bpf/bpftool/prog.c    | 266 ++++++---------------------
>> tools/lib/bpf/libbpf.c      | 251 ++++++++++++++++++++++++++
>> tools/lib/bpf/libbpf.h      |  63 +++++++
>> tools/lib/bpf/libbpf.map    |   3 +
>> tools/perf/Makefile.config  |   2 +-
>> tools/perf/builtin-record.c |  15 +-
>> tools/perf/builtin-top.c    |  15 +-
>> tools/perf/util/annotate.c  | 149 ++++++++++++++-
>> tools/perf/util/bpf-event.c | 351 +++++++++++++++++++++++++++---------
>> tools/perf/util/bpf-event.h |  48 ++++-
>> tools/perf/util/dso.c       |   1 +
>> tools/perf/util/dso.h       |  33 ++--
>> tools/perf/util/env.c       | 148 +++++++++++++++
>> tools/perf/util/env.h       |  12 ++
>> tools/perf/util/evlist.c    |  20 ++
>> tools/perf/util/evlist.h    |   2 +
>> tools/perf/util/header.c    | 231 +++++++++++++++++++++++-
>> tools/perf/util/header.h    |   2 +
>> tools/perf/util/symbol.c    |   1 +
>> 20 files changed, 1304 insertions(+), 312 deletions(-)
>>=20
>> --
>> 2.17.1

