Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABA1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE2821A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QXN2n28i";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LSk1ZnWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfBORsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:48:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726819AbfBORsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:48:21 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FHl7RN015692;
        Fri, 15 Feb 2019 09:48:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ICmtYJXD2Xp/kcImFmnbadBoS8VmHMTjSJ7Lpeddkxk=;
 b=QXN2n28iBue8kHJmuuXpErE42B8oaeuK4RUhdhi8E6t92mha7nBS6hgCVfWQu6gJSPim
 GwwXcdf8Ph5JuHHblSydY0wid3MVDliF9ranqI3uNtY0gvAurYbQkZdlaFD5crN3kY5D
 0HIA+TiR6bnN7BX9BDBWOA5LhRwUMvOJ+20= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2qp1q7r3ku-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 09:48:03 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:48:01 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:48:01 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 09:48:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICmtYJXD2Xp/kcImFmnbadBoS8VmHMTjSJ7Lpeddkxk=;
 b=LSk1ZnWzPVLqdpB/U1s0OH7GEnsFVb25fltZ+S4VDqVwsjUiH7K1bNb+1b4/gxiJ6bwMOWV5mfpwMk/P8YI4hsn1trTAKJz2qR/CuTwyf3+Ba3N2Azu3gFb0czXq87EEfBrARZz02mIPjFhbrktLf6RXbjnCm96JdukwyLTPU5o=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1519.namprd15.prod.outlook.com (10.173.235.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 15 Feb 2019 17:47:58 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9%8]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 17:47:58 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Thread-Topic: [PATCH v2 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Thread-Index: AQHUxMGQlShe9E029kWf9/H0QeuOj6Xg626AgAAx0ACAAARLAIAAAh+A
Date:   Fri, 15 Feb 2019 17:47:58 +0000
Message-ID: <847940EC-6E2A-4985-AE19-27758C301B5D@fb.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-7-songliubraving@fb.com>
 <20190215142643.GC5784@redhat.com>
 <164D19ED-EA72-4A56-8259-FCF13894B183@fb.com>
 <20190215174022.GF31177@kernel.org>
In-Reply-To: <20190215174022.GF31177@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:e850]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d83880da-2680-45b5-c2ae-08d6936db93f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1519;
x-ms-traffictypediagnostic: MWHPR15MB1519:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1519;20:LZiGME39JYdFxytj8bJHAXj9F880IAJOEHMV4PqriZDXxFqnTCqBuMWHF/Uyx5OgcNvq7AcY09iv8ZCwgnmGuWeDk2koT09MXELfzRpA4kykeD0+/kwEjP0+LVSh+ajWkNBh6AdFgQoxNFJ9fAXQJRZO6T6rlCUb7faPuVQ7EUs=
x-microsoft-antispam-prvs: <MWHPR15MB1519F610DF51523BE7A825C2B3600@MWHPR15MB1519.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(486006)(50226002)(478600001)(6246003)(186003)(33656002)(8676002)(6116002)(2616005)(81166006)(81156014)(11346002)(8936002)(446003)(46003)(476003)(54906003)(86362001)(305945005)(99286004)(76176011)(53936002)(105586002)(106356001)(102836004)(14454004)(93886005)(97736004)(6506007)(53546011)(7736002)(2906002)(6512007)(57306001)(316002)(4326008)(82746002)(25786009)(229853002)(36756003)(6916009)(83716004)(68736007)(71190400001)(71200400001)(6436002)(256004)(6486002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1519;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0iCJsb4E1QoS2hWr8aWlv56zHcJmlu8POwHYBKeXSy+WZbqNLgdy51LX62NgoBAgX+CMMWa5PowWYrgkj0/3grtcF5scY0f/ISZxXxBkc628sn+7zeJ4v6Y8ilCvUQqz+yiwF4fqpAVf82SdQwHBccgbCyvFsayTxU5z8wwQ2WExA0BNtbZ9NPEYImkSYhb0NKu8za+O+jwbXd8Ww4kpelxXkVNig0iCrlsNr82H+3FYIv5QcGpecykMnq4V0KhumVXhr0Xn5Q19BN3c9A6GT5Tuhzd8LGxuDZ0b2mQe7rQRJZmQNtucymAb5NMASoig1RLW7Thhnesqyt8UuzRmM8MV9zXA15lc6XQ69FeZ4m8md5oKIADG9/jKCOGNpLGp5X+FdStSScmjZal5FZLlduzCHEqxMPBjw7bzW7aI4og=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <718ACE7EF7B1CF4A96BD95DBBF6775A8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d83880da-2680-45b5-c2ae-08d6936db93f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:47:58.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 9:40 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Fri, Feb 15, 2019 at 05:25:01PM +0000, Song Liu escreveu:
>>> On Feb 15, 2019, at 6:26 AM, Arnaldo Carvalho de Melo <acme@redhat.com>=
 wrote:
>>> Em Thu, Feb 14, 2019 at 04:00:09PM -0800, Song Liu escreveu:
>>>> This patch enables perf-record to save btf information as headers to
>>>> perf.data A new header type HEADER_BTF is introduced for this data.
>=20
>>> 	Wouldn't it be better for this HEADER_BTF to be introduced
>>> already as an user space event, Song, see:
>=20
>>> tools/perf/util/event.h
>=20
>>> and:
>=20
>>> tools/perf/util/event.c
>=20
>>> perf_event__synthesize_cpu_map()
>=20
>> BTF would be short living for short living BPF programs. I guess=20
>> saving them as header is easier than merging them with samples.=20
>=20
>> What's the benefit of saving them as user space events?
>=20
> When we work with pipe mode, i.e.:
>=20
> 	perf record -o - | perf report -i -
>=20
> and other combinations (with 'perf script', 'perf inject', etc), we need
> a way to pass the headers to the other side, and the way was via user
> space events.
>=20
> This is something Stephane and Jiri have been discussing recently,
> probably they have more justifications, Stephane, Jiri?
>=20
> - Arnaldo

I see. In this case, we will need some synchronization between main
thread and the polling thread, as they are both writing to the same
pipe.=20

Thanks,
Song




