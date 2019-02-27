Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D10C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D367520842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VGfYNB/q";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="A55LIiVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfB0Rxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:53:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52260 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbfB0Rxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:53:36 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1RHl3ww004198;
        Wed, 27 Feb 2019 09:53:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9vOz2iBswHv2jT5MIGjsWcv++zbUfUMT7uaQ42pzWaY=;
 b=VGfYNB/qCJ5c5gzA6znGt5yUcI8Euho/sM3omxREC4OmQ4j37fGNFpjwQbuUcGPOybc6
 Kt29rLhuJVhdwpvoUi6Uq+JUxQevZbzN2S+GYkoGTpY7q7POtwLGUQMdlXRxHIPsliAQ
 currMZ299INVYz26MGI5Yy36QE3ehTdh51Y= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2qwy8mr0t0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 09:53:10 -0800
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 09:53:09 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 09:53:09 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 27 Feb 2019 09:53:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vOz2iBswHv2jT5MIGjsWcv++zbUfUMT7uaQ42pzWaY=;
 b=A55LIiVoG6Crd/n0A1nHAK5uL2Lt9umHsxHn4CF9wQZyz5RzbFNAS1+1c3eLxzVpi2Bq0TK5/R/Ht5zFvBL4Ll5Xu5DXoCxxa0Yzde8UUT6E9Zxc2D73P6LcQcZ3t6aUsKySfUSuDK6SDawgPMDAwZ6L7F104c56zMXd+aVFje8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1280.namprd15.prod.outlook.com (10.175.3.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Wed, 27 Feb 2019 17:52:52 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 17:52:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Thread-Topic: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Thread-Index: AQHUzWlKCfZJunEblEKUEZkb6eySeqXzo8KAgABL74A=
Date:   Wed, 27 Feb 2019 17:52:52 +0000
Message-ID: <2506D6CF-F0E3-4640-B385-DD0843AD2928@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-15-songliubraving@fb.com>
 <20190227132105.GC18893@krava>
In-Reply-To: <20190227132105.GC18893@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::eed9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c444bbd-85e7-4bcd-852e-08d69cdc6535
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1280;
x-ms-traffictypediagnostic: MWHPR15MB1280:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1280;20:yxl5eNS0Xo1jRe1LaffyI1OSjiUkBGCZ97X90WBi94fXrjbkS/WmBifHtAI3ft32fFyxysfoNHgLWyf6iPF/EPoWl5hbm2m9aNdOA4ci/PNTuBY+/Q1KkTznmB/vVgfQioWnDMJ74rPYCCIK/8nJ9MS7/Qraeb3UNQyJO0fCnNM=
x-microsoft-antispam-prvs: <MWHPR15MB1280F72FB916CD7A7E8BF3ABB3740@MWHPR15MB1280.namprd15.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(50226002)(478600001)(86362001)(99286004)(76176011)(54906003)(6916009)(8936002)(57306001)(11346002)(229853002)(33656002)(5660300002)(446003)(36756003)(7736002)(81156014)(81166006)(8676002)(305945005)(316002)(2616005)(106356001)(105586002)(476003)(14454004)(2906002)(486006)(46003)(53936002)(186003)(97736004)(53546011)(6506007)(71190400001)(71200400001)(83716004)(6512007)(6116002)(82746002)(102836004)(6486002)(6246003)(25786009)(6436002)(256004)(68736007)(4326008)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1280;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gf/tMFDQTmiy+xhabvNRjdfBuQe0PDj4uT/oMSWFjhgDvYWJ8i2gv6kb6+L04yFa/zvyklsc59nnEM2P5H3R1iGWhPny+uY1kNjcuy/n0oVg/P8PZ14aslk6Yb8P3D1S8rDwUqmiYebPA9U5jhPMQM5uVwg7KL+gXyBu0CCG7C2lVjd+jVYtWer8ligX+YcxL5omx4cCgxn4AaCms0njEIEJlHV1S2NhLLEi5Mfe0LOIZsdLC7g0oLeeGXOleEkasIKztPgNU2nzm7epkX2XL2j2bONrr2CnT+4nxIaR7S72Biv/H01ApKVoYQwExaaS69iVA3EGHYkLsvjoK68Wf7d0OdFHX3xd+TT2OABEiVoDiKkVL+DF28/E0uf+2W4mxHTFuLHHp14RD3o2ts4w4IaypESugtyBQj+OsZwTu44=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F8A493994E42A4883A45745A837B107@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c444bbd-85e7-4bcd-852e-08d69cdc6535
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 17:52:52.3477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1280
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Feb 25, 2019 at 04:20:18PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 8c902276d4b4..61b87c8111e6 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -19,6 +19,7 @@
>> #include "debug.h"
>> #include "units.h"
>> #include "asm/bug.h"
>> +#include "bpf-event.h"
>> #include <signal.h>
>> #include <unistd.h>
>>=20
>> @@ -1841,3 +1842,102 @@ struct perf_evsel *perf_evlist__reset_weak_group=
(struct perf_evlist *evsel_list,
>> 	}
>> 	return leader;
>> }
>> +
>> +static struct perf_evlist *sb_evlist;
>> +pthread_t poll_thread;
>=20
> so some of the things are static and some like poll_args
> you alloced on the stack.. I dont like this interface,
> could we come up with something generic? perhaps
> encapsulated in perf_evlist, like:

I picked global sb_evlist and poll_thread because there=20
should be only one sb_evlist and one thread polling it.=20
There might be multiple evsel on the sb_evlist.=20

I am not sure I understand your suggestion..

> struct perf_evlist {
> 	...
> 	struct {
> 		pthread_t	th;
> 		int		state;
> 	} thread;

This will not be used by the main perf_evlist, right?

> };
>=20
> typedef int (perf_evlist__thread_cb_t)(perf_evlist, union perf_event *eve=
nt,....)

How do we use this callback? We need a way to specify which
events to poll (mmap, bpf_event, ksymbol, etc). How do we do=20
that with the callback function?

Thanks,
Song

> perf_evlist__start_thread(perf_evlist, perf_evlist__thread_cb_t cb);
> perf_evlist__stop_thread(perf_evlist);
>=20
>=20
> jirka

