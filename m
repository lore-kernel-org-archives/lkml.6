Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED91C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A2D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UfJuTBii";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FwBLizMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A2D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeLMVuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:50:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52238 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbeLMVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:50:13 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBDLdqJe019248;
        Thu, 13 Dec 2018 13:49:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=c2TYvsPXBAa8QN+10GjEq3MU0+13dMbW9vxJf2Fp8mw=;
 b=UfJuTBiipPPus+dRJbJ7hzxVnmnrME5dRBfJGCGbYKb2bZIW4h2qDruO1XetjYTLeH6h
 UXI37IRpr1JH7b2kGSQ5mIxbOS8+qZkROu7O/Rq0pXIoQoJjwzkt6NzkylVulEXcVxqC
 zFqYyjOeMhH0bV7ayIx9aYXGmWKmsx/Ljtc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pbxab897u-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Dec 2018 13:49:29 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 13 Dec 2018 13:49:00 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 13 Dec 2018 13:48:59 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 13 Dec 2018 13:48:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2TYvsPXBAa8QN+10GjEq3MU0+13dMbW9vxJf2Fp8mw=;
 b=FwBLizMbUIr9CFS3oYhNGzpXjE4e9t4Z9y8QH3H1XERl/TU3IjtR0ywYm6UOGbhXIUeZy39ybiZW6Kh2pIg3AH3f03HzqPwblDHJ46mjSeI/U+bFWozEjHM9YwA6fmbGWnrL6Y3TYiIkrpDgukSU9YjrLz9QtO5sAwdPj5PZG5E=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1739.namprd15.prod.outlook.com (10.174.109.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 21:48:58 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::2d27:7549:4f23:c230]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::2d27:7549:4f23:c230%6]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 21:48:57 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
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
Thread-Index: AQHUkan/BrxKv3p0HEGwaC6e4kWgY6V7FkWAgABBOQCAAA/SgIAAB6sAgAGVzgCAADMvgA==
Date:   Thu, 13 Dec 2018 21:48:57 +0000
Message-ID: <3FC2A5A4-9502-4B33-A944-BEB14B520E23@fb.com>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
 <20181212133320.75d5cad8@gandalf.local.home>
 <20181213184546.GM5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181213184546.GM5289@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::4:4dbf]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1739;20:9D2C5j05bTVMVarQgNOYCNxpuBKi51Ie03TlFt6zoNU4sJNEnz7ibLMm8tFbSy7H3YxsTq9dVTji6Qo5DHqJGs4LErGSpjxJ4ro4sl2EUqIH15xzN6595bLvVZW1xefE3KmneVA2Ea6xJIQPRaMbI4DcNX/9VmFGrtID9+vIqFM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8659e0b0-982d-49aa-8c57-08d66144c91f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1739;
x-ms-traffictypediagnostic: DM5PR15MB1739:
x-microsoft-antispam-prvs: <DM5PR15MB17390D1C04D5F1BE20CF5166B3A00@DM5PR15MB1739.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR15MB1739;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1739;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(102836004)(6506007)(76176011)(486006)(83716004)(54906003)(97736004)(6436002)(229853002)(53546011)(71200400001)(86362001)(316002)(68736007)(105586002)(305945005)(8936002)(71190400001)(81166006)(53936002)(11346002)(256004)(476003)(14444005)(7736002)(6486002)(2616005)(82746002)(446003)(81156014)(478600001)(99286004)(25786009)(5660300001)(8676002)(50226002)(57306001)(6512007)(186003)(2906002)(33656002)(106356001)(6246003)(36756003)(4326008)(46003)(6916009)(14454004)(6116002)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1739;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fA2lIzlojCQMgIND0dzCUemd3vF1EVAFzr0Ft3y2DYDfv5IHTFO22RAICp60wYYmWbd+1ph5sw/9ywIguxPCCGLVDbSXH0/2JVb2fNonkFM2To/Nxu2Z1YfGgGZ+lJgUPKPNKQempQUvwJWVj6vmiRqIcWsdMun4Y5MWRdjA+BmJErFvr8cIaYmQShIeo6zpyxV1ScW4aPR+LlcRUyxAdi1mtC2B7VXz33PPX6DGLa5ByjWx0Qjph8V4XY37pDmw2EQ5VN7tWslUkMCmTqjN5FUFduE0pQucSaUrDRgWK3VRKH9KyvqHmqTjpKZ9PM6W
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7AF2C57AB0B8D4E942F6A3D6EC95031@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8659e0b0-982d-49aa-8c57-08d66144c91f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 21:48:57.8311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1739
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 13, 2018, at 10:45 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Wed, Dec 12, 2018 at 01:33:20PM -0500, Steven Rostedt wrote:
>> On Wed, 12 Dec 2018 19:05:53 +0100
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>=20
>>> On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
>>>>> And while this tracks the bpf kallsyms, it does not do all kallsyms.
>>>>>=20
>>>>> .... Oooh, I see the problem, everybody is doing their own custom
>>>>> kallsym_{add,del}() thing, instead of having that in generic code :-(
>>>>>=20
>>>>> This, for example, doesn't track module load/unload nor ftrace
>>>>> trampolines, even though both affect kallsyms. =20
>>>>=20
>>>> I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload.=
=20
>>>> That could be separate sets of patches.  =20
>>>=20
>>> So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
>>> bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
>>> and also have ftrace use that.
>>>=20
>>> Because currently the ftrace stuff is otherwise invisible.
>>>=20
>>> A generic kallsym register/unregister for any JIT.
>>=20
>> That's if it needs to look up the symbols that were recorded when init
>> was unloaded.
>>=20
>> The ftrace kallsyms is used to save the function names of init code
>> that was freed, but may have been recorded. With out the ftrace
>> kallsyms the functions traced at init time would just show up as hex
>> addresses (not very useful).
>>=20
>> I'm not sure how BPF would need those symbols unless they were executed
>> during init (module or core) and needed to see what the symbols use to
>> be).
>=20
> Aah, that sounds entirely dodgy and possibly quite broken. We freed that
> init code, so BPF or your trampolines (or a tiny module) could actually
> fit in there and insert their own kallsyms, and then we have overlapping
> symbols, which would be pretty bad.
>=20
> I thought the ftrace kallsym stuff was for the trampolines, which would
> be fairly similar to what BPF is doing. And why I'm trying to get a
> generic dynamic kallsym thing sorted. There's bound the be other
> code-gen things at some point.

Hi Peter,=20

I guess you are looking for something for all ksym add/delete events, like;

      /*
       * PERF_RECORD_KSYMBOL
       *
       * struct {
       *      struct perf_event_header header;
       *      u64                             addr;
       *      u32                             len;
       *      u16                             ksym_type;
       *      u16                             flags;
       *      char                            name[];
       *      struct sample_id                sample_id;
       * };
       */

We can use ksym_type to encode BPF_EVENT, trampolines, or other type of ksy=
m.
We can use flags or header.misc to encode ksym add/delete. Is this right?

If we go this direction, shall we reserve a few more bytes in it for differ=
ent
types to use, like:

      /*
       * PERF_RECORD_KSYMBOL
       *
       * struct {
       *      struct perf_event_header header;
       *      u64                             addr;
       *      u32                             len;
       *      u16                             ksym_type;
       *      u16                             flags;
       *      u64                             data[2];
       *      char                            name[];
       *      struct sample_id                sample_id;
       * };
       */

Thanks,
Song


