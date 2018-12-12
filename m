Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546BDC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107E02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CbcHfc2I";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CFWGZiTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107E02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeLLQuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:50:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43239 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbeLLQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:50:06 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBCGi0dj009996;
        Wed, 12 Dec 2018 08:49:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0CpfMy+6RtMK3IyimsWopyuph1lCeUjcDgHRC1KEkxM=;
 b=CbcHfc2IcqNib4teeQGHLFW1/KbI4woa136DlwJUJvvi5xa0wI5oeay9h3UAdkIaBTMb
 awH+O0UxyKEW9lBZTjHx2cR03nqkZcC2uk50FLjP2mzwvG8PXupXQywlRi38ORlzCqwW
 5JF15aEcBaIA3K38e7wStMk1iHcnaB7RUgE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2pb58b07s1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Dec 2018 08:49:25 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 12 Dec 2018 08:49:22 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 12 Dec 2018 08:49:22 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 12 Dec 2018 08:49:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CpfMy+6RtMK3IyimsWopyuph1lCeUjcDgHRC1KEkxM=;
 b=CFWGZiTyk32b2SGUsmTaiSLSnFGRgrmWB0cl7+MeLsTwZevZlbKycg8dNu4ksPs+AoWjF9YEKfBpyPILxqXgyivwnwa9axusr+3ICyPUBkgZGgdISm6s/kGo6Zdn7uS/pXRYsP32M68L7ClBrlT+Kg1vdCEUgFn4tV/1z2o2u7w=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1517.namprd15.prod.outlook.com (10.173.235.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 16:49:18 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a165:7ace:d8a:de65]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a165:7ace:d8a:de65%8]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 16:49:18 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Thread-Topic: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Thread-Index: AQHUkan/BrxKv3p0HEGwaC6e4kWgY6V7AukAgABPAIA=
Date:   Wed, 12 Dec 2018 16:49:18 +0000
Message-ID: <391CEABE-8201-4CF7-8DE4-B600B32CA825@fb.com>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212120632.GY5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181212120632.GY5289@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::5:37be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1517;20:57k8EP84RH92WIOVmHOzUOXybAje+DxPcttDeUy1QLFKAAvyYiVGF98XmylZmwch+TTfUG8a2495hzCr6OzvfJaCyY2vPtOTSdvenHX4h6iTk/om6VRjG7LCcHSgoFWf8VZ/wtT9LJ0UqR/QwW0+N6ZHZe0a4bkpXi+hbVCgxv0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9c119de4-a2f9-4cdd-93c0-08d66051c23c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1517;
x-ms-traffictypediagnostic: MWHPR15MB1517:
x-microsoft-antispam-prvs: <MWHPR15MB1517859FC3A43E3A51E7B0BBB3A70@MWHPR15MB1517.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3231455)(999002)(11241501185)(944501520)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1517;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1517;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(136003)(366004)(376002)(199004)(189003)(2906002)(446003)(486006)(102836004)(6436002)(105586002)(11346002)(106356001)(57306001)(316002)(476003)(2616005)(7736002)(256004)(46003)(305945005)(186003)(6916009)(82746002)(86362001)(68736007)(478600001)(8936002)(71200400001)(6512007)(71190400001)(54906003)(6246003)(6486002)(97736004)(25786009)(36756003)(50226002)(229853002)(83716004)(14454004)(53936002)(5660300001)(33656002)(76176011)(99286004)(4326008)(53546011)(6116002)(81156014)(6506007)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1517;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XRw/11PbHn7ocBOQ8xqueS9YH6E+jvzgEviSWIXayAQO5qWKlMebOfIhBbqK4zH6/l19NMeX+ZnmpRckOYF0rozTAxalpyb6YTfgGezADxLufvHMmOgj9dhdp6cMh5e1Gb1+s9qws+0T3mYxe4X23ql+ZsuDTW2tdAmV7zLRqhuIpCddo9omFOZ2+kPWDhSo7S1B90anqiAk8O3rnFbgB6aWcoxaqkJX4rbw/Aodubq+4CkcIYQrYOtiqQmX5b1A5xnjHN7MEC8pdcas2aGjoOeZFpVkuI5ocpWLWXR9/qahBdh8mgx5vcKvx36CLIBz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E323554C3A810A4A8AC049788D8082E9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c119de4-a2f9-4cdd-93c0-08d66051c23c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 16:49:18.5179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1517
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2018, at 4:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Dec 11, 2018 at 03:33:47PM -0800, Song Liu wrote:
>> +static void perf_event_bpf_output(struct perf_event *event,
>> +				   void *data)
>> +{
>> +	struct perf_bpf_event *bpf_event =3D data;
>> +	struct perf_output_handle handle;
>> +	struct perf_sample_data sample;
>> +	char name[KSYM_NAME_LEN];
>> +	int name_len;
>> +	int ret;
>> +
>> +	if (!perf_event_bpf_match(event))
>> +		return;
>> +
>> +	/* get prog name and round up to 64 bit aligned */
>> +	bpf_get_prog_name(bpf_event->prog, name);
>> +	name_len =3D strlen(name) + 1;
>> +	while (!IS_ALIGNED(name_len, sizeof(u64)))
>> +		name[name_len++] =3D '\0';
>=20
> Does this not require something like:
>=20
> 	BUILD_BUG_ON(KSYM_NAME_LEN % sizeof(u64));

Yeah, this makes sense. I will add this in next version.=20

Thanks,
Song
