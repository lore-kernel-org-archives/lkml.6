Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E907C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E192177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BxEKdeUW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TaLH+5WQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfAILd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:33:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56304 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730111AbfAILdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:33:25 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x09BT4c9031466;
        Wed, 9 Jan 2019 03:32:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BIy/HlUGIH7kTqlFsP7idCHe2XZZdw3QxnCt74Xj7mM=;
 b=BxEKdeUWIO94pKYx2Fqt3cmS9yb9Re79iNU7opYdlOkljrAXFTgQ0QwF5Xf0Lp/S+8ji
 PHryi9hADxY0JQmAS83eulKQ7Qd4ciIXb4EVvMjTHuGfNVVmRtR3RBcyw5svXpcKs0jU
 AQM/QpT9gNTXa9nb1Mp7wyzh2Sa1BQtmEwc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pwem388ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Jan 2019 03:32:53 -0800
Received: from frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 9 Jan 2019 03:32:53 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 9 Jan 2019 03:32:52 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 9 Jan 2019 03:32:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIy/HlUGIH7kTqlFsP7idCHe2XZZdw3QxnCt74Xj7mM=;
 b=TaLH+5WQJT/F7YLKN+9f7gB8ST2V2G8Vep9l/XYOCE6wqwNhUbnKCH67waIBVjhcNfE0FKU5BxCp02R86GqljmGDRCykB2B0QjUnf0goVfDgaP7V9pJ2FFBxue68NrSQyeFBm2QAr75X3rykBCCeurljmE9DmNSZFgE7btL2noQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1919.namprd15.prod.outlook.com (10.174.100.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Wed, 9 Jan 2019 11:32:50 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%6]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 11:32:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUmJHygB8CuOaEkU2QMQ4A40UscaWl0lUAgAAIHwCAAAktAIAARhkAgACuXQCAABTegA==
Date:   Wed, 9 Jan 2019 11:32:50 +0000
Message-ID: <924AE46C-B2B9-4E17-A6FC-C678FEADC03B@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
 <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
 <20190108194310.GD1900@hirez.programming.kicks-ass.net>
 <A0C713E9-6ACE-4235-87C2-2653A8F22F7B@fb.com>
 <20190109101808.GG1900@hirez.programming.kicks-ass.net>
In-Reply-To: <20190109101808.GG1900@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:d46d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1919;20:FLzj4g/M8D4n5PCdoSAmcESuJNshUtxNvYyM+LHfSJ0NAIwHleiki95Fai8AVzNdqRRrlc3C7Y1EcVbvcUndyibZsxbY6c0k7VJ6T7NEutgdZt6tmhQGNTW46kG3n6BrRyKgHUHabyqhLMYmWYiBaxaAaX/VmK3UP6r1UHvAd4A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a6c97c7e-a832-4ded-bd22-08d676263008
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1919;
x-ms-traffictypediagnostic: MWHPR15MB1919:
x-microsoft-antispam-prvs: <MWHPR15MB19199478E2E60C91B9E1309FB38B0@MWHPR15MB1919.namprd15.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(229853002)(53546011)(53936002)(186003)(6506007)(105586002)(106356001)(76176011)(14454004)(6116002)(102836004)(8676002)(81166006)(81156014)(6436002)(8936002)(93886005)(36756003)(50226002)(486006)(82746002)(14444005)(256004)(86362001)(71190400001)(71200400001)(7736002)(478600001)(83716004)(97736004)(68736007)(33656002)(6486002)(57306001)(25786009)(305945005)(4326008)(6246003)(2906002)(11346002)(446003)(54906003)(6512007)(476003)(2616005)(46003)(316002)(99286004)(6916009)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1919;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QWQFZC6OD8f+2OqPcHe06877Rwokfs9MaTNtyq/zAaJ1/FLXmOWSlbhyQMLHBABAN+i9csfMWDlsKFSUzta3n9Up9p2yGl1xiNRAKXgaJgZdjaoTKiQzRQgwih9rQ0pj1zlBAib5YHGxKbEsXy1Xok/5cKZ7kufTSlXQbdIhL03/HUGV2yLm8AhFjxeIDx5uVw0N9aXl4r4r4CYWFE+8XPc7ztIJC1Gvy8PSz3HVr6cg3EpLNYH9MZ7fHT4Y2wlu/rPRO58wtAyPDr9uYp+QKBSs9wyPvqufbCme45G1F8fItLPNtVuSPfYCwGL1PoVY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78FE5089A7206549B9DE1DAFC2F85355@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c97c7e-a832-4ded-bd22-08d676263008
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 11:32:50.3945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1919
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 9, 2019, at 2:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Jan 08, 2019 at 11:54:04PM +0000, Song Liu wrote:
>=20
>> I think Intel PT case is at instruction granularity (instead of ksymbol
>> granularity)?=20
>=20
> Yes.
>=20
>> If this is true, modules, BPF, and PT could still share
>> the ksymbol record for basic profiling. And advanced use cases like=20
>> annotation will depend on user space to record BPF_EVENT (and equivalent
>> for other cases) timely. But at least, the ksymbol is already there.=20
>>=20
>> Does this make sense? =20
>=20
> I'm not sure I follow; the idea was that on ksym events we copy out the
> instructions using kcore. The ksym event already has addr+len.

I was thinking about modifying the text in-place scenario. In this case,=20
we can use something like

struct perf_record_text_modify {
    u64 addr;
    u_big_enough old_instr;
    u_big_enough new_instr;
    timestamp ;
};

It is a fixed size record, and we don't need process it immediately=20
in user space. At the end of perf run, a series of these events will=20
help us reconstruct exact text at any time.=20

>=20
> All we need is some means of ensuring the symbol is still there by the
> time we see the event and do the copy.
>=20
> I think we can do this with a new ioctl() on /proc/kcore itself:
>=20
> - when we have kcore open, we queue all text-free operations on list-1.
>=20
> - when we close kcore, we drain all (text-free) list-* and perform the
>   pending frees immediately.
>=20
> - on ioctl(KCORE_QC) we perform the pending free of list-3 and advance
>   list-2 to list-3 and list-1 to list-2.
>=20
> Perf would then open kcore at the start of the record, make a complete
> copy and keep the FD open. At the end of every buffer process, we issue
> KCORE_QC IFF we observed a ksym unreg in that buffer.

Does this mean we need to scan every buffer before writing it to perf.data=
=20
during perf-record?=20

Also, if we need ksym unreg here, I guess it is NOT really modifying text=20
in-place, but creating new version and swap? Then can we include something=
=20
like this in perf.data:

struct perf_record_text_modify {
    u64 old_addr;
    u64 new_addr;
    u32 old_len; /* up to MAX_SIZE */
    u32 new_len; /* up to MAX_SIZE */
    u8 old_text[MAX_SIZE];
    u8 new_text[MAX_SIZE];
    timestamp ;
};

In this way, this record is embedded in perf.data, and doesn't require
extra processing during perf-record (only at the end of perf-record).=20
This would work for text modifying case, as modifying text is simply
old-text to new-text.
=20
Similar solution would not work for BPF case, as bpf_prog_info is=20
getting a lot more members in the near future.=20

Does this make sense...?

Thanks,
Song

