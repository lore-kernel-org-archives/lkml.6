Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F985C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D1620862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PinR+Dbv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hikMhZh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D1620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeKHD5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:57:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46096 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbeKHD5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:57:24 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7IHdUo023300;
        Wed, 7 Nov 2018 10:25:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9pw1MXtxf7Wwn8s8MTAzTqMrWo3wngO3tN8dKfnxaTQ=;
 b=PinR+Dbv0U0ITtZXwz4Q8dzN2DpbCAgW+JHoH5mR39niF3yXYAuDhyEQoht4L8huARvO
 iDpIzrOkRfyoav/7++iSiUDJ1dutDwQGGBzQylC1UjD6rt4i3arVh09gx0VWp/LmIs+h
 Ia8gKCDSIV3colJqBtBgCWTk4Z5NnOdvGKQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nm4ms84ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Nov 2018 10:25:08 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 7 Nov 2018 10:25:06 -0800
Received: from FRC-CHUB06.TheFacebook.com (2620:10d:c021:18::25) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 7 Nov 2018 10:25:06 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 7 Nov 2018 13:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pw1MXtxf7Wwn8s8MTAzTqMrWo3wngO3tN8dKfnxaTQ=;
 b=hikMhZh8zXkPOXUMhb648otiYbS23BEhz1OWrwAMI/zj8FbzNBwMoMPuj7NcZYQegET0T7rl4u77sch2uUWlSafzkgq5V2SLtF1Xm00ZScStVDFDFnsgn72thqdvFPmLaAN0gQV9HTmI6tkR8hQBAxq2e6c9ErSXcGtIjDPc9+4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1293.namprd15.prod.outlook.com (10.175.3.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Wed, 7 Nov 2018 18:25:04 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 18:25:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Topic: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Index: AQHUdhLRNu0EDS9AC0KZ+9MuHYh4daVD/w6AgACjMoA=
Date:   Wed, 7 Nov 2018 18:25:04 +0000
Message-ID: <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
 <20181107084057.GG9781@hirez.programming.kicks-ass.net>
In-Reply-To: <20181107084057.GG9781@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::5:11dd]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1293;20:aBUwanFWke3N6gu9ieQD/LHzOKIJjMegr2C/VmTnw19kVql5XRRp45JXiWqxw6LF6fSPL7KzdLQVeAqVmIrlGK8lGY2Ut31CM5kXHlZ0mYybNBQMEzAoOzOBZKjwzk34Lhn4LCaJfeHmMkN3Af45KGBY6fN2c1jHoAglt+wl3DQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6311560f-1593-4d8a-513a-08d644de569f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1293;
x-ms-traffictypediagnostic: MWHPR15MB1293:
x-microsoft-antispam-prvs: <MWHPR15MB12932DBCA35EEA2AFD7EE31DB3C40@MWHPR15MB1293.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1293;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1293;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(229853002)(50226002)(14454004)(186003)(68736007)(256004)(966005)(54906003)(446003)(305945005)(97736004)(33656002)(478600001)(86362001)(2900100001)(53546011)(106356001)(4326008)(25786009)(57306001)(99286004)(486006)(476003)(6506007)(105586002)(11346002)(2906002)(102836004)(2616005)(7736002)(316002)(46003)(76176011)(83716004)(71200400001)(71190400001)(6486002)(6436002)(6246003)(6306002)(82746002)(53936002)(6512007)(6916009)(81156014)(81166006)(6116002)(5660300001)(8676002)(36756003)(8936002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1293;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HyJxhBzkBjaVVdKONRnVzvYKYr0RdkwGOzJl1ATEV/tSm1+mB+p/xfleb3IgtKH0No10eKCFmQSwMHpuBHpUMOoa1a/UGZ5cXyJaPAp1YyGtSZ47TBqryJZtogOuVe2QHb/GU+0HL6tZMyd4MF/EMjSQ5AeXs8FGB+/rhiVRnGJVJWTIJSUKmKcuNzyR8ueUaFSuz+0YsPHsRaqMMTQDnYZz9mw7l8EHvHvjg6mZCgXFk3IKkkXHK4AsYjBbuDx1MEBdmtc8XvFVEp/YuO4YMGExTGxD13zEFYjNdyEKb42M6dW5FHq5mjij+Y5MrorFFPyxflgPqwfvo7M1dQpU4hU9PkuRcBiFbqOCKNGjvNM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC81E567302F89488710007B363C80C4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6311560f-1593-4d8a-513a-08d644de569f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 18:25:04.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1293
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 7, 2018, at 12:40 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Nov 06, 2018 at 12:52:42PM -0800, Song Liu wrote:
>> For better performance analysis of BPF programs, this patch introduces
>> PERF_RECORD_BPF_EVENT, a new perf_event_type that exposes BPF program
>> load/unload information to user space.
>>=20
>>        /*
>>         * Record different types of bpf events:
>>         *   enum perf_bpf_event_type {
>>         *      PERF_BPF_EVENT_UNKNOWN          =3D 0,
>>         *      PERF_BPF_EVENT_PROG_LOAD        =3D 1,
>>         *      PERF_BPF_EVENT_PROG_UNLOAD      =3D 2,
>>         *   };
>>         *
>>         * struct {
>>         *      struct perf_event_header header;
>>         *      u16 type;
>>         *      u16 flags;
>>         *      u32 id;  // prog_id or map_id
>>         * };
>>         */
>>        PERF_RECORD_BPF_EVENT                   =3D 17,
>>=20
>> PERF_RECORD_BPF_EVENT contains minimal information about the BPF program=
.
>> Perf utility (or other user space tools) should listen to this event and
>> fetch more details about the event via BPF syscalls
>> (BPF_PROG_GET_FD_BY_ID, BPF_OBJ_GET_INFO_BY_FD, etc.).
>=20
> Why !? You're failing to explain why it cannot provide the full
> information there.

Aha, I missed this part. I will add the following to next version. Please
let me know if anything is not clear.

Thanks,
Song



This design decision is picked for the following reasons. First, BPF=20
programs could be loaded-and-jited and/or unloaded before/during/after=20
perf-record run. Once a BPF programs is unloaded, it is impossible to=20
recover details of the program. It is impossible to provide the=20
information through a simple key (like the build ID). Second, BPF prog
annotation is under fast developments. Multiple informations will be=20
added to bpf_prog_info in the next few releases. Including all the
information of a BPF program in the perf ring buffer requires frequent=20
changes to the perf ABI, and thus makes it very difficult to manage=20
compatibility of perf utility.=20

For more information on this topic, please refer to the following=20
discussions:=20

    https://www.spinics.net/lists/netdev/msg524230.html

