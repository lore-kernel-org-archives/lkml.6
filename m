Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA903C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A680206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JvF5k2gG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dV9ggoC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfAIPvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:51:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45014 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731620AbfAIPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:51:38 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x09FfllT008477;
        Wed, 9 Jan 2019 07:51:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jznA5pHmja03zmkG3A5+QfY7PPJGajv9NKcjqssEM9M=;
 b=JvF5k2gGESemEmQD8x0d2/XnszJ17HFprD7CQ9lDdO4PWyzaqzJ1Nzozh3CFRTHX3nM9
 +yQ/4Y12XZNrXGPfk+4Px2RFLkHPWcCN5bDxJNCD+gsRNXNxx5UmWbhFnee6BOzuJgeB
 +HsPTl/BcPPIjDBouEhScyZ3RfuRJLWlzMc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2pwjxyg80p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Jan 2019 07:51:12 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 9 Jan 2019 07:51:11 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 9 Jan 2019 07:51:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jznA5pHmja03zmkG3A5+QfY7PPJGajv9NKcjqssEM9M=;
 b=dV9ggoC5r7rPyvd230eItIAvR5sSqijyIIx8aJj6Nh0/jsrwr6GG0DoQYcMyBd72mxfdp6hDTs+GfVZlUhUa3P4MeqK4JUeg17ZcKprZS3Cz9kML7x6N32no4PwernhepIdrG7Nqrmhx+QsK+xaANkAYhcwE+BJT9wkCaUYi07M=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1632.namprd15.prod.outlook.com (10.175.135.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 15:51:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::78be:8c1:352b:6f6e%6]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 15:51:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUmJHygB8CuOaEkU2QMQ4A40UscaWl8IGAgAAEfYCAAQspgIAANPoA
Date:   Wed, 9 Jan 2019 15:51:09 +0000
Message-ID: <4F8C7117-CC7D-47DF-9F44-FC387815CDC8@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108202915.GE30894@hirez.programming.kicks-ass.net>
 <dd3ca24b-4da5-b0b1-9d1c-e5ed3fe297d2@fb.com>
 <20190109124131.GI1900@hirez.programming.kicks-ass.net>
In-Reply-To: <20190109124131.GI1900@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:1691]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1632;20:afed6YOIh75FPY5df3kYvUZfggx/GYWcanuvzvT/89GA0bjjiPG9BWd9wkSavfKrapFEaZhyxQfxzyuCiL6/QIETHiDPcOl28931N4Fe0oBpJ3EbE+9h/NWJrLeNqcKPqxQW8s7u5rSanXq7ubrqu73Rn2Fo5csKU2QFw4WSIFE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 5a04ee83-348a-41f0-aca4-08d6764a4650
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1632;
x-ms-traffictypediagnostic: MWHPR15MB1632:
x-microsoft-antispam-prvs: <MWHPR15MB1632A6D0173C283D70C367FEB38B0@MWHPR15MB1632.namprd15.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(68736007)(71200400001)(305945005)(316002)(256004)(36756003)(229853002)(6486002)(99286004)(83716004)(14454004)(6436002)(50226002)(7736002)(81166006)(81156014)(8676002)(478600001)(54906003)(33656002)(82746002)(93886005)(5660300001)(2906002)(8936002)(11346002)(106356001)(2616005)(476003)(105586002)(446003)(97736004)(486006)(86362001)(575784001)(4326008)(186003)(25786009)(6506007)(102836004)(53546011)(76176011)(6512007)(6916009)(57306001)(53936002)(6246003)(46003)(71190400001)(6116002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1632;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XaKgnWxd+VdrSRA62V2JaHC6/PlUAnxyHvJE/L5QCEW46KKsiqHDa5ceJe7JU51u3tInV5G/hNJAybgoH0bDYinOsTZgXfi2nWLWKi6yG9AQ0tpKYuSzBFIefSLfX7GpkB6H8axpLSPaYEpHYNsr0YpJxHqEoOlty6BBCcF2btqRf201glrYJaWV4DngY30Z2eP5J3NSB8xC+B5z3hxhxvHab41Is3mhb8Ehih0P3ferOz1BG6kzgnyvJu7B3G4qX9sTmWINujWdqd8QHgFfG4pZlyIYVjyFpulI5rJ2f32t0sGoMlIZRTnm/nLCKBHG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <872BE2A739F66149A05031C3EA62E1D0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a04ee83-348a-41f0-aca4-08d6764a4650
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 15:51:09.7142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 9, 2019, at 4:41 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Jan 08, 2019 at 08:45:19PM +0000, Alexei Starovoitov wrote:
>> On 1/8/19 12:29 PM, Peter Zijlstra wrote:
>>> On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
>>>> The following example shows kernel symbols for a BPF program with 7
>>>> sub programs:
>>>>=20
>>>>     ffffffffa0257cf9 t bpf_prog_b07ccb89267cf242_F
>>>>     ffffffffa02592e1 t bpf_prog_2dcecc18072623fc_F
>>>>     ffffffffa025b0e9 t bpf_prog_bb7a405ebaec5d5c_F
>>>>     ffffffffa025dd2c t bpf_prog_a7540d4a39ec1fc7_F
>>>>     ffffffffa025fcca t bpf_prog_05762d4ade0e3737_F
>>>>     ffffffffa026108f t bpf_prog_db4bd11e35df90d4_F
>>>>     ffffffffa0263f00 t bpf_prog_89d64e4abf0f0126_F
>>>>     ffffffffa0257cf9 t bpf_prog_ae31629322c4b018__dummy_tracepoi
>>>=20
>>> We should probably specify somewhere that the name can include a
>>> '[module]' part just like normal kallsyms. Even though you don't
>>> currently use that.
>>=20
>> there is no [module] equivalent in bpf land.
>=20
> I know; although you could consider each program it's own separate
> module. But what I meant was, we should probably document the name[]
> format somewhere, maybe in the PERF_RECORD_KSYMBOL comment.
>=20
> The "symbol [module]" syntax can be used to create a DSO sort key, so
> you could simply put in "[bpf]" for all BPF generated symbols and have
> everything BPF grouped in perf-report when sorted on DSO.

In current version, I put [bpf_prog] for bpf programs DSO. We can=20
probably add something to /proc/kallsyms as well. On the other hand,=20
"bpf_prog_<tag>_XXX" also indicates this is a BPF program.=20

Thanks,
Song
