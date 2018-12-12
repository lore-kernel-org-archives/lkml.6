Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF10C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030BC20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rD6pDltm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CUUifuGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030BC20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeLLS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:59:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726235AbeLLS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:59:03 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBCIrhow015216;
        Wed, 12 Dec 2018 10:58:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=AElBzaFwHuVQNvUsu7K37Vw5Iw0ENBtWizQfSmxeUIQ=;
 b=rD6pDltmN+Dlgv+eCOUtLn9fEDMzB0C5yvjs/JZYUydYK8gGLQUffTZZOxsvv8NMi4yw
 vaqs2IULlLmoQuWfsW0kaHU5/gAIzA9C/xxgZlRFxfeHIbI7xL185cHAnDiVaH4pPHXR
 CYiATRM0W+TikXIb3h1MhFbuHRmqg9CHn08= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pb7p5033u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Dec 2018 10:58:25 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 12 Dec 2018 10:58:19 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 12 Dec 2018 10:58:18 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 12 Dec 2018 10:58:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AElBzaFwHuVQNvUsu7K37Vw5Iw0ENBtWizQfSmxeUIQ=;
 b=CUUifuGukMbw81EFmfil1V+KedBFVh7+m5t/Tg+xyyKX6U1WbXaA9YX+wf1Duav3qp/jtrAs7X5tvqKYPS9VHY1bpCn85B6FPYxGA4q3psga/JYVFf18IB8BF3iMr5xtz8uaQZqFngFOIxL7Z7EteeRns2MC2Xioiv2AH3qcKfc=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 18:58:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a165:7ace:d8a:de65]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a165:7ace:d8a:de65%8]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 18:58:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUkan/BrxKv3p0HEGwaC6e4kWgY6V7FkWAgABBOQCAAA/SgIAAB6sAgAAG9IA=
Date:   Wed, 12 Dec 2018 18:58:14 +0000
Message-ID: <97086ED8-F27C-4501-97A4-6A3C697405AC@fb.com>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
 <20181212133320.75d5cad8@gandalf.local.home>
In-Reply-To: <20181212133320.75d5cad8@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::5:37be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1216;20:7bnA8ODWd858IEBS5/gDNMW9pH3yva86g1gOho9YLHHE/U5TfvfXsGPnT1VSgNZHEeNLYZ3hmcn07AL+DZfKEgK7f1dXIRMndXzpxsYHp3+BlgVhzk9hEDqym7LiaySt+4aTOPlmTim50j7dGyHYC178xxLOuKfHL4oyPKI/iQs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3f5a5120-567b-40a4-e904-08d66063c539
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1216;
x-ms-traffictypediagnostic: MWHPR15MB1216:
x-microsoft-antispam-prvs: <MWHPR15MB121624142CEC9BF7B0319043B3A70@MWHPR15MB1216.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1216;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1216;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(14444005)(76176011)(5660300001)(256004)(71200400001)(71190400001)(53546011)(6506007)(102836004)(186003)(8676002)(81166006)(8936002)(46003)(93886005)(4326008)(36756003)(50226002)(81156014)(57306001)(82746002)(99286004)(305945005)(486006)(68736007)(6486002)(6436002)(446003)(11346002)(7736002)(83716004)(2616005)(476003)(478600001)(86362001)(229853002)(2906002)(105586002)(106356001)(6512007)(25786009)(33656002)(6916009)(54906003)(14454004)(316002)(6246003)(53936002)(97736004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1216;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TuosJL4htWnVz1Xn3jDgGe6zvJkQWy2/0YfivSe8WJH9Dg37ov2hpLt9o88DPP9lU1DtIWxi0lScglU7GpZyPypXX0NWQ36udUVtGU0xPKRgt33lZu0tKxx6iz/nWkjnn8aIcD8MwKp2gq0lt/kLkDjxqVB+7U03HrV92iEU4eMW6cF+c3q1bxfZPiQFtQ1hUWvm2qT7Qa0xqurlKAjRS4Dr9KZClID9AJtaWxve2xqsDOe/hvO6euo52ssOI6BUAzSN9LBxs201m+jRjS7BejogFJDL32aGNhTh+lJpkmV7kbujWgRsCC3O0KPTvYnk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <951F0025B548E74D953CA68FE5A26614@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5a5120-567b-40a4-e904-08d66063c539
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:58:14.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2018, at 10:33 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Wed, 12 Dec 2018 19:05:53 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
>>>> And while this tracks the bpf kallsyms, it does not do all kallsyms.
>>>>=20
>>>> .... Oooh, I see the problem, everybody is doing their own custom
>>>> kallsym_{add,del}() thing, instead of having that in generic code :-(
>>>>=20
>>>> This, for example, doesn't track module load/unload nor ftrace
>>>> trampolines, even though both affect kallsyms. =20
>>>=20
>>> I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload.=20
>>> That could be separate sets of patches.  =20
>>=20
>> So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
>> bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
>> and also have ftrace use that.
>>=20
>> Because currently the ftrace stuff is otherwise invisible.
>>=20
>> A generic kallsym register/unregister for any JIT.
>=20
> That's if it needs to look up the symbols that were recorded when init
> was unloaded.
>=20
> The ftrace kallsyms is used to save the function names of init code
> that was freed, but may have been recorded. With out the ftrace
> kallsyms the functions traced at init time would just show up as hex
> addresses (not very useful).
>=20
> I'm not sure how BPF would need those symbols unless they were executed
> during init (module or core) and needed to see what the symbols use to
> be).
>=20
> -- Steve

Currently, BPF programs are not executed during init.=20

Thanks,
Song
