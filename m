Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E76C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF2120879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b/YYBF25";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B6FSMmNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfAJTrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:47:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728073AbfAJTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:47:09 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0AJiBY0016901;
        Thu, 10 Jan 2019 11:46:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Byx/VeZKRnMoalwZvF1avcZ53jfEUGjxJ6W0/l5EHNc=;
 b=b/YYBF25Q88PjP0TBXhbgwWtOnN1iMq3f4bHgjsNDbD+jyM+1bNDBKXg7WeD949zY4GM
 OgU749Sd1VQQf7DomIVVVBRm+gsDFF7gXqKPoEHaqFBzcX5BWgUjg7X+xhe/5zjp3qGC
 m2AcZYOUPhfuLkMnHLR7wR7MYdeOlD9XXYo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2pxar50d7d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Jan 2019 11:46:41 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 10 Jan 2019 11:45:12 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 10 Jan 2019 11:45:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Byx/VeZKRnMoalwZvF1avcZ53jfEUGjxJ6W0/l5EHNc=;
 b=B6FSMmNH7Zs5st09DpYqOmmqrHL7l1Bcq/f/TZGatp9tgTIkgWGJvsBJ+S9GwpVZoMmPG9hZ0cD/nYoZuSnEsDVn8m6tuo+CMeHllvrnt1bmnSd1VcbtEpzwSV6tyPWfDlKkl/WFvAC8b8z5+UdnhIQnUDrf0LujPyd2eOyM1u8=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1484.namprd15.prod.outlook.com (10.173.225.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 19:45:09 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::1909:9d4c:715b:faa0]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::1909:9d4c:715b:faa0%5]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 19:45:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Ahern <dsahern@gmail.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Topic: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Thread-Index: AQHUqFCaPbT+UGXQnkaaX1wm9KrpVKWo0rKAgAAEoACAAAQiAIAACcSAgAAEI4A=
Date:   Thu, 10 Jan 2019 19:45:09 +0000
Message-ID: <E220DFC6-A2E2-4B3A-B52B-3B194315D2A0@fb.com>
References: <20190109192111.130995-1-songliubraving@fb.com>
 <20190109192111.130995-2-songliubraving@fb.com>
 <20190110182403.GN22483@kernel.org>
 <064FBBA4-A0D0-4335-BCE7-902724CE2988@fb.com>
 <20190110185524.GO22483@kernel.org>
 <CCB26BF8-9FF5-4BBF-84BE-878CF0D3882A@fb.com>
In-Reply-To: <CCB26BF8-9FF5-4BBF-84BE-878CF0D3882A@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:3651]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1484;20:R7HWPxplFN0hvPz7rz+Y46qDOCGjsJVqss/vbAXY8dGMTx2ibdOgEOGakT/kp6tfCtAGKWtq7/k23prwiiN/VoramRYt8u5OQFThMvaRk8+Le9uU70L5m1ZWbml/2T1A3CKZYjFruvyOYboyKDJKb7Hb6EutpOJCjjxl2YsXYGQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5adb4b4a-31bd-4431-19ac-08d677342117
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1484;
x-ms-traffictypediagnostic: DM5PR15MB1484:
x-microsoft-antispam-prvs: <DM5PR15MB1484F15A598A773B123C9ADAB3840@DM5PR15MB1484.namprd15.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(81156014)(6436002)(8676002)(102836004)(76176011)(46003)(81166006)(8936002)(53936002)(57306001)(68736007)(39060400002)(33656002)(486006)(6246003)(6486002)(53546011)(316002)(6506007)(50226002)(99286004)(5660300001)(110136005)(54906003)(229853002)(6512007)(105586002)(305945005)(106356001)(7736002)(2906002)(93886005)(71200400001)(476003)(186003)(11346002)(97736004)(6116002)(25786009)(446003)(82746002)(71190400001)(256004)(2616005)(478600001)(4326008)(86362001)(36756003)(14454004)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1484;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QbknQzbqLEm0FurgyyDrSu3pVFBkd0/Xdp0LEQA6ExDqbFqt0NFSfba8+AddfQfElKcs6rSiL0k01LD2YzMdXJvsVvnMmJmgm1eIw7cs2H5dEGXw9W/2DF0BdzrIL1jpN+9vhnumGRLbZvKkc3T8w8Q9HLsn0sLXMuxPmvqi3J0YinfsVt/3pjJTrV+sAlCJPRNB9B+/e3KayZ8Zss45Zi7GAilG8vqNr9huTKM2w7Q7WQNZklHc8uAeGukXc+BOs2Bvzjm5sN1s01XjBCqhemI22nLqLxWYyn9oIqAcazqknSWm+QDQZ9H9h5Bh95cb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <947F72252E066746917AA9BFCD4B5F6E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adb4b4a-31bd-4431-19ac-08d677342117
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 19:45:09.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1484
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 10, 2019, at 11:30 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Jan 10, 2019, at 10:55 AM, Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
>>=20
>> Em Thu, Jan 10, 2019 at 06:40:37PM +0000, Song Liu escreveu:
>>>=20
>>>=20
>>>> On Jan 10, 2019, at 10:24 AM, Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>>>>=20
>>>> Em Wed, Jan 09, 2019 at 11:21:05AM -0800, Song Liu escreveu:
>>>>> For better performance analysis of dynamically JITed and loaded kerne=
l
>>>>> functions, such as BPF programs, this patch introduces
>>>>> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
>>>>> register/unregister information to user space.
>>>>>=20
>>>>> The following data structure is used for PERF_RECORD_KSYMBOL.
>>>>>=20
>>>>>  /*
>>>>>   * struct {
>>>>>   *      struct perf_event_header        header;
>>>>>   *      u64                             addr;
>>>>>   *      u32                             len;
>>>>>   *      u16                             ksym_type;
>>>>>   *      u16                             flags;
>>>>>   *      char                            name[];
>>>>>   *      struct sample_id                sample_id;
>>>>>   * };
>>>>>   */
>>>>=20
>>>> So, I couldn't find where this gets used, the intention here is just t=
o
>>>> add the interfaces and afterwards is that you will wire this up? I wou=
ld
>>>> like to test the whole shebang to see it working.
>>>=20
>>> I guess you meant PERF_RECORD_BPF_EVENT not being used?=20
>>>=20
>>> PERF_RECORD_KSYMBOL is used by BPF in 3/7 and 5/7. I tested=20
>>=20
>> Oops, I didn't look at 3/7, just read its cset summary line and as it
>> says:
>>=20
>> Subject: [PATCH v6 perf, bpf-next 3/7] perf, bpf: introduce PERF_RECORD_=
BPF_EVENT
>>=20
>> I didn't thought it was related, perhaps break it down into one that
>> states that it is wiring up PERF_RECORD_KSYMBOL, and at that point we
>> could just test it, getting the notifications for new kallsyms related
>> to BPF?
>=20
> Good idea! I will split it into two patches as:
>=20
> [3/8] perf, bpf: generate PERF_RECORD_KSYMBOL for BPF program=20
> [4/8] perf, bpf: introduce PERF_RECORD_BPF_EVENT
>=20
>>=20
>>> PERF_RECORD_BPF_EVENT with dump_trace. As we separate RECORD_KSYMBOL fr=
om
>>> RECORD_BPF_EVENT, user space won't use BPF_EVENT until annotation suppo=
rt. =20
>>=20
>> Right, so why not just introduce PERF_RECORD_KSYMBOL, make it be used by
>> tooling, etc, then move on to PERF_RECORD_BPF_EVENT?
>=20
> I'd like to make sure we all agree on the new ABI for RECORD_KSYMBOL and=
=20
> RECORD_BPF_EVENT. Multiple user space tools dependent on RECORD_BPF_EVENT=
,
> for example, bcc and auditing. Finalizing RECORD_BPF_EVENT will unblock t=
he=20
> development of these tools. On perf side, it will take us quite some time=
=20
> to finish annotation. Ideally, I don't want to block the development of=20
> other tools for so long.=20
>=20
> Thanks,
> Song

+ DavidA

Hi David,=20

Could you please share your feedback on PERF_RECORD_BPF_EVENT for auditing
use cases?

Thanks,
Song

