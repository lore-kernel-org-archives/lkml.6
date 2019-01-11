Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09948C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB94218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j8cDvDWr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YIrescRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfAKTYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:24:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39622 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbfAKTYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:24:34 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0BJO7CH018524;
        Fri, 11 Jan 2019 11:24:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DBIV/lwnR2hBs8DPt77f28ZvmA4a1EYP68BIBrAlWHc=;
 b=j8cDvDWrP532QQz1XoyZoo+cVLSn28RA1KDhRkYNHzxWxVNNjTipHC1cwW1B4fS3m/t9
 /A5xxKqipF0g+baS1w/sVxI1dNPl6EyvQN5TCrdrW2Mo6NozMlnQeo/n4on4AeG8wIbn
 xCQB+E5J6bz/Luv7+ZhYdFoi9nzRrnAwNCg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2py0h705mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 11:24:07 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 11 Jan 2019 11:23:45 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 11 Jan 2019 11:23:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBIV/lwnR2hBs8DPt77f28ZvmA4a1EYP68BIBrAlWHc=;
 b=YIrescRLgeQMOPe/msGOppUnEEeWnAMYOKhlTAfFD+42n6bKc2Ar+OMmIdyTipdzyOwNS0thGSaw6kBbV4Q4IEyK+SCv+YhjdBxDZwTbelARw5ek+6pC93rqJQRhUzwDnuTknqvLVi1BpxCLSjOV/4KtNAP3ePJq3Os81awXlm8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1392.namprd15.prod.outlook.com (10.173.234.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 11 Jan 2019 19:23:43 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%3]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 19:23:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "dsahern@gmail.com" <dsahern@gmail.com>
Subject: Re: [PATCH v7 perf, bpf-next 8/8] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Thread-Topic: [PATCH v7 perf, bpf-next 8/8] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Thread-Index: AQHUqUNt/72ctoB59kK549OU404czaWqaMIAgAALCgA=
Date:   Fri, 11 Jan 2019 19:23:43 +0000
Message-ID: <491DEF9F-2974-47F4-ACCC-4F585DEC53C5@fb.com>
References: <20190111001933.4153792-1-songliubraving@fb.com>
 <20190111001933.4153792-9-songliubraving@fb.com>
 <20190111184412.GA22483@kernel.org>
In-Reply-To: <20190111184412.GA22483@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::4:440f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1392;20:Cf7dZienqJxI4ZOjHAIFjaCPQYsElskRljVaxgQP4fwf5fWNZCmugOTfXf6muJZDKAN0WKHPHg28HadZ+7IMS9kWQb9K5NventNihpwtdQPtWBlVV1oOFEAm9fkpTf6vF5S0PWBDwU2Ak4nn4tRaI4chkO72cOaxJkkcbJ7IYnY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c0b123ec-c826-4f17-7d41-08d677fa4d0d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1392;
x-ms-traffictypediagnostic: MWHPR15MB1392:
x-microsoft-antispam-prvs: <MWHPR15MB13925D3DF0C0010D1DE37E0CB3850@MWHPR15MB1392.namprd15.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(305945005)(7736002)(2616005)(446003)(476003)(82746002)(105586002)(6506007)(76176011)(53546011)(46003)(186003)(99286004)(478600001)(102836004)(68736007)(14454004)(11346002)(86362001)(106356001)(6512007)(6246003)(2906002)(4326008)(5660300001)(486006)(39060400002)(36756003)(53936002)(316002)(6116002)(6916009)(54906003)(25786009)(8676002)(33656002)(81156014)(81166006)(83716004)(6486002)(229853002)(57306001)(50226002)(8936002)(71200400001)(71190400001)(14444005)(256004)(6436002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1392;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZZnkeWkpyThL6TkvqjIMDQAf64VZPo1536kh54tcrDRuo4W/grA55SXmkMFPX6M7e2k2BNN8B29V8BzAkNT2a/eiw+qD7tpzmhrbYtOzfqxX0L3/nIrR9tRW4wx+xdC31PU7uK4bcu9OfoVru+9AB1iYboax/m8CIhxQQ+ylJAQgcHn82j7OYSG4h9ftE21VFldgZVZ2z4cYcB2dmfNTL8CzkXWLPZ0hntFhX05sKtgjed2oyloIJKnIA2uZIMknJ+/+KXudQSD1pligmddRYlRwoTSjsammIq+ycTQ87h40N61uFvPhCVgO+h8fO9/trU5nfM3UXJLdnbJz3FgdqAlmknMKIt0QgGSw3Bf6DwwaqJDhkK2o9nh6UvXogGPwM7hgAKgRX4siz8N2gze1O0yF8e7LDUSychqLC7WdxDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E72FEE684B72E44BADA875AC7E11297@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b123ec-c826-4f17-7d41-08d677fa4d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 19:23:43.6356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1392
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 11, 2019, at 10:44 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Thu, Jan 10, 2019 at 04:19:33PM -0800, Song Liu escreveu:
>> This patch synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for
>> BPF programs loaded before perf-record. This is achieved by gathering
>> information about all BPF programs via sys_bpf.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/builtin-record.c |   6 ++
>> tools/perf/util/bpf-event.c | 205 ++++++++++++++++++++++++++++++++++++
>> tools/perf/util/bpf-event.h |   5 +
>> 3 files changed, 216 insertions(+)
>>=20
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index deaf9b902094..88ea11d57c6f 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -41,6 +41,7 @@
>> #include "util/perf-hooks.h"
>> #include "util/time-utils.h"
>> #include "util/units.h"
>> +#include "util/bpf-event.h"
>> #include "asm/bug.h"
>>=20
>> #include <errno.h>
>> @@ -1082,6 +1083,11 @@ static int record__synthesize(struct record *rec,=
 bool tail)
>> 		return err;
>> 	}
>>=20
>> +	err =3D perf_event__synthesize_bpf_events(tool, process_synthesized_ev=
ent,
>> +						machine, opts);
>> +	if (err < 0)
>> +		pr_warning("Couldn't synthesize bpf events.\n");
>> +
>=20
> There should be no warnings on older systems, I build a kernel and tools
> with your changes and then, before rebooting, I tried:
>=20
> [root@quaco ~]# perf record ls
> Couldn't synthesize bpf events.
> <SNIP>
> [root@quaco ~]# uname -a
> Linux quaco 4.19.13-300.fc29.x86_64 #1 SMP Sat Dec 29 22:54:28 UTC 2018 x=
86_64 x86_64 x86_64 GNU/Linux
> [root@quaco ~]#
>=20
> At most this should be a pr_debug(), but then it should check if the
> system is bpf capable and if not only warn if the user explicitely asked
> for bpf events.

Thanks Arnaldo! I will fix it in the next version.=20

Song


