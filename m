Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A954BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589E2208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="m9zeNykC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="N+Cyk0pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589E2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeK1GZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:25:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56378 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbeK1GZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:25:22 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARJJ6EZ006432;
        Tue, 27 Nov 2018 11:25:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yM8tEgxseRWs2bIrk1zqshuuoz4wGwMZSRMKXRA00pY=;
 b=m9zeNykCE2DJtWnFgDmrr6fF6/qVbAXvasQzFJfLHrXko69YM8OVBFmEEzgOHiFom9/I
 mv1h/0myYeLO15B+NwJApbBlUKEWq+eMhNSfsQwCvvCOZxvMt9NcKwqYT+qON44RPMMG
 7W1/e503gHpNcIDuwcVJWOzlYnsgqn1RW4A= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2p1ar68b9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Nov 2018 11:25:50 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 27 Nov 2018 11:25:06 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 27 Nov 2018 11:25:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM8tEgxseRWs2bIrk1zqshuuoz4wGwMZSRMKXRA00pY=;
 b=N+Cyk0pWMrESaeNI092iWCyjxkmeK//1P5arnSo0g+j4EKytnwxYlEEjMHPwuFfI+CO83pfPyK+Y9R1zi66LICHDPNJWlTlSQD9t5n8JgCoHCP9wMTv6ZfCmdOIOzP3B8NbO9zLlq6eK5+R07nEb/OQYgBdtYNsEqRtHGTCDBXg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1837.namprd15.prod.outlook.com (10.174.255.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 19:25:03 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 19:25:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Thread-Topic: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Thread-Index: AQHUgdQ11TRJMN8CIkSD/uQZUfyfEaVbiN6AgACRn4CABhB7AIAB3ygA
Date:   Tue, 27 Nov 2018 19:25:03 +0000
Message-ID: <EDEF2248-6909-44FE-8819-3D2349DBFB73@fb.com>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181122093219.GK2131@hirez.programming.kicks-ass.net>
 <71189F83-A09F-4A03-95EC-694D37FD7675@fb.com>
 <20181126145004.GO2113@hirez.programming.kicks-ass.net>
In-Reply-To: <20181126145004.GO2113@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::6:8f0c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1837;20:P/+ih/qhDGzOuged03e95CR/ZcFWyVsSG7pEP65vJZW5e7NI7JahX2fB2ZIawjmreI7u+YDjWOy9KvZ/nFSX8EqW5ccl2nmyL+Db9CN4R9gxWEwp3neW+iZIg7zYOCQ62j1Z9+2echdEDmtocchvgFImn4f2mBwXlc52JxiPW2c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4012e2f4-c219-428e-7c0b-08d6549e07ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1837;
x-ms-traffictypediagnostic: MWHPR15MB1837:
x-microsoft-antispam-prvs: <MWHPR15MB1837FCA8589360A26E62EE31B3D00@MWHPR15MB1837.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(10201501046)(3231443)(11241501185)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1837;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1837;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(136003)(366004)(54534003)(199004)(189003)(57306001)(76176011)(71190400001)(53546011)(6506007)(25786009)(6246003)(68736007)(305945005)(186003)(36756003)(102836004)(476003)(446003)(14454004)(486006)(478600001)(11346002)(71200400001)(83716004)(46003)(6116002)(2616005)(99286004)(86362001)(6916009)(2906002)(6486002)(6512007)(50226002)(82746002)(54906003)(4326008)(14444005)(8676002)(105586002)(256004)(6436002)(97736004)(106356001)(5660300001)(229853002)(81156014)(81166006)(316002)(53936002)(7736002)(93886005)(8936002)(33656002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1837;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4UGL3TTQgPJT7Fd6b6yBeHDSSGo566OR2LfMGKNvf0ksSfub2/a5+cVgL1sxcZ4yOFwXPuPooXhnMDgLYkk95rayqvX6n616D/djCvhhpP5oBs3B6UnM+/TtDxm62Kk8xBH7ReVVEuPTUsxgTbjsOlHHSQOUPgJup0KHpyf0AAyTwthykQL7i/4dkKyPJ3OIILFKUqM57XGtKgMGCQFY7sE1SIl9ncjrg5YNBkZ3w1RiEuD/kDUhWVSfnJhNBaxhjiI1GZeoRR6b9fVCFmLUM3MT6y68uMjlbk8IIxV67DGzi+HXCLEL9gF7yojCGxCdsXhDLj9SpnG+lFZAP9UDYahjJkfD9NfiM8AvkD2jDv4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB4DFCFC9337BD49BEC8D3C7CDF23482@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4012e2f4-c219-428e-7c0b-08d6549e07ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 19:25:03.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1837
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 26, 2018, at 6:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Nov 22, 2018 at 06:13:32PM +0000, Song Liu wrote:
>> Hi Peter,
>>=20
>>> On Nov 22, 2018, at 1:32 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>>=20
>>> On Wed, Nov 21, 2018 at 11:54:57AM -0800, Song Liu wrote:
>>>> Changes RFC -> PATCH v1:
>>>>=20
>>>> 1. In perf-record, poll vip events in a separate thread;
>>>> 2. Add tag to bpf prog name;
>>>> 3. Small refactorings.
>>>>=20
>>>> Original cover letter (with minor revisions):
>>>>=20
>>>> This is to follow up Alexei's early effort to show bpf programs
>=20
>>>> In this version, PERF_RECORD_BPF_EVENT is introduced to send real time=
 BPF
>>>> load/unload events to user space. In user space, perf-record is modifi=
ed
>>>> to listen to these events (through a dedicated ring buffer) and genera=
te
>>>> detailed information about the program (struct bpf_prog_info_event). T=
hen,
>>>> perf-report translates these events into proper symbols.
>>>>=20
>>>> With this set, perf-report will show bpf program as:
>>>>=20
>>>>  18.49%     0.16%  test  [kernel.vmlinux]    [k] ksys_write
>>>>  18.01%     0.47%  test  [kernel.vmlinux]    [k] vfs_write
>>>>  17.02%     0.40%  test  bpf_prog            [k] bpf_prog_07367f7ba80d=
f72b_
>>>>  16.97%     0.10%  test  [kernel.vmlinux]    [k] __vfs_write
>>>>  16.86%     0.12%  test  [kernel.vmlinux]    [k] comm_write
>>>>  16.67%     0.39%  test  [kernel.vmlinux]    [k] bpf_probe_read
>>>>=20
>>>> Note that, the program name is still work in progress, it will be clea=
ner
>>>> with function types in BTF.
>>>>=20
>>>> Please share your comments on this.
>>>=20
>>> So I see:
>>>=20
>>> kernel/bpf/core.c:void bpf_prog_kallsyms_add(struct bpf_prog *fp)
>>>=20
>>> which should already provide basic symbol information for extant eBPF
>>> programs, right?
>>=20
>> Right, if the BPF program is still loaded when perf-report runs, symbols=
=20
>> are available.=20
>=20
> Good, that is not something that was clear. The Changelog seems to imply
> we need this new stuff in order to observe symbols.
>=20
>>> And (AFAIK) perf uses /proc/kcore for annotate on the current running
>>> kernel (if not, it really should, given alternatives, jump_labels and
>>> all other other self-modifying code).
>>>=20
>>> So this fancy new stuff is only for the case where your profile spans
>>> eBPF load/unload events (which should be relatively rare in the normal
>>> case, right), or when you want source annotated asm output (I normally
>>> don't bother with that).
>>=20
>> This patch set adds two pieces of information:
>> 1. At the beginning of perf-record, save info of existing BPF programs;
>> 2. Gather information of BPF programs load/unload during perf-record.=20
>>=20
>> (1) is all in user space. It is necessary to show symbols of BPF program
>> that are unloaded _after_ perf-record. (2) needs PERF_RECORD_BPF_EVENT=20
>> from the ring buffer. It covers BPF program loaded during perf-record=20
>> (perf record -- bpf_test).=20
>=20
> I'm saying that if you given them symbols; most people won't need any of
> that ever.
>=20
> And just tracking kallsyms is _much_ cheaper than either 1 or 2. Alexei
> was talking fairly big amounts of data per BPF prog. Dumping and saving
> that sounds like pointless overhead for 99% of the users.

If annotation is not needed, we have the option to reduce the amount of=20
data per bpf prog by not requesting JITed binaries. Would a flag to tune
this solve the concern of dumping and saving too much data?

Thanks,
Song




