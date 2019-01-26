Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906EDC282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 05:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52858218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 05:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="q6dReC3h";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GT9UVKOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfAZFhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 00:37:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49122 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfAZFhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 00:37:35 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0Q5ST0T005850;
        Fri, 25 Jan 2019 21:37:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=u5lo5jVytH7bjYGYs5Z5LVV2HbKij/7e/WINBTcJ28w=;
 b=q6dReC3hNiqTWBT53SM76yw68y6zDfOfmkt5cpDSyBD3yCNUKBdZ+ATXTyFQ4A9io/Dn
 /Sq6rOooxOOSXvgivgGFyYtEPBCB/zd+0BRqKVomSTxO1zpW/RCEaYvLBBYZyzTn647B
 mj96AfjdDq+FboVrPpBIhEMivumejelhlSU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q8g77g4qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Jan 2019 21:37:32 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 21:37:30 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 21:37:30 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 25 Jan 2019 21:37:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5lo5jVytH7bjYGYs5Z5LVV2HbKij/7e/WINBTcJ28w=;
 b=GT9UVKOWmv/GGgbcsaHLAlselCdAYudHYr7em9xnWi+DWR8BFiGhz5JIxAUqChtRIrbPB6EoCph8b8tH1TI0WNLakPoifxEGEYQt/dR0Xe3qIfMC2BcHgsEd3x3mlTREwjXC4+XLUrDMjxJXMHG03ggW09JHabKMIXvBtPJYe6w=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1727.namprd15.prod.outlook.com (10.174.254.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Sat, 26 Jan 2019 05:37:12 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::ac2f:bf87:54e:48a2]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::ac2f:bf87:54e:48a2%11]) with mapi id 15.20.1558.021; Sat, 26 Jan 2019
 05:37:12 +0000
From:   Martin Lau <kafai@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Networking Development Mailing List" <netdev@vger.kernel.org>
Subject: Re: [RFC] Loading BTF and pretty printing maps with bpftool
Thread-Topic: [RFC] Loading BTF and pretty printing maps with bpftool
Thread-Index: AQHUtJe93j57e5jzakCtPrUX5lNnDaXBCSeA
Date:   Sat, 26 Jan 2019 05:37:12 +0000
Message-ID: <20190126053705.qasjit2pk5lbblsh@kafai-mbp.dhcp.thefacebook.com>
References: <20190125102057.GB12077@kernel.org>
In-Reply-To: <20190125102057.GB12077@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0033.namprd15.prod.outlook.com
 (2603:10b6:300:ad::19) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:bec5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1727;20:YbWpy7GWCRlHGriFLLXVQ0/JW5UWLzLf6QtsHvwjuPWOsWOammNtBNnaO4NOnxS/0dyf7ysozJtfROJXutcvPsL552HvmINIVNfLJJwqzQpOXhrN/kgJDjmVUva1HZuM5mnFdNbfD4JuQQnk4eOUCpstSaIrdi+qtQ2qGzy8tis=
x-ms-office365-filtering-correlation-id: ce5b32a7-f811-4b2f-a9b4-08d68350521e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1727;
x-ms-traffictypediagnostic: MWHPR15MB1727:
x-microsoft-antispam-prvs: <MWHPR15MB1727F461E9DC2AB54F975AF8D5940@MWHPR15MB1727.namprd15.prod.outlook.com>
x-forefront-prvs: 0929F1BAED
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(6116002)(99286004)(25786009)(86362001)(316002)(229853002)(54906003)(2906002)(4326008)(33896004)(7736002)(105586002)(106356001)(97736004)(52116002)(71190400001)(1076003)(71200400001)(76176011)(305945005)(81166006)(478600001)(102836004)(68736007)(6246003)(6916009)(6506007)(46003)(386003)(6486002)(486006)(446003)(11346002)(8936002)(476003)(186003)(53936002)(6512007)(9686003)(6436002)(14454004)(39060400002)(14444005)(256004)(8676002)(81156014)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1727;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4HJ9+mV7yc+cmzT8Wct/YtK5zf2Gtoz+PzE60Wv2ahiK6/SwQGbC290P6PPFG8d0LsPMmV2l2fhWReTtOAVEMrRqUfYm2l3cKLat+uTYBDQdumD5mjnGXILh9Zb0UNO5FQS+HqHSEE7UHGpydWQhdeAi8NCBjhg37Wh5L0iIaP/OFsF5au2E95VL25a7ptSOjxYD+k+dAkN3Jbur9t9amL9WUBMtqLaUt+OF9G+uLYL3xKeWxqvKo9c63viZmbKfEPcSvqI6kMmlMnSCQKuTWFNT0dTdXzrruE4xBXcyH/JRUg62HBrauF7uAy9bfrNLHmgMtzmw5vxs8CZ0Nih8YxnkAIHFbjz0lsiroZ5jUzeZnvXIfNKoC+7ctdytUp/MJn6DrmkPQRbkxmUZZm5b5SsUZd9tPN6CH2R9s0sKoME=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1FEE53454E98E4DABC5D9227A9D59BD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5b32a7-f811-4b2f-a9b4-08d68350521e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2019 05:37:11.3492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1727
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-26_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:20:57AM +0100, Arnaldo Carvalho de Melo wrote:
>   # bpftool version
>   bpftool v5.0.0-rc3
>   #
>=20
>   # bpftool prog | tail -6
>   309: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
> 	loaded_at 2019-01-25T11:05:41+0100  uid 0
> 	xlated 528B  jited 381B  memlock 4096B  map_ids 200,199,198
>   310: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
> 	loaded_at 2019-01-25T11:05:41+0100  uid 0
> 	xlated 256B  jited 191B  memlock 4096B  map_ids 200,199
>   #
>=20
> And the maps:
>=20
>   # bpftool map | tail -6
>   198: perf_event_array  name __augmented_sys  flags 0x0
> 	key 4B  value 4B  max_entries 8  memlock 4096B
>   199: array  name syscalls  flags 0x0
> 	key 4B  value 1B  max_entries 512  memlock 8192B
>   200: hash  name pids_filtered  flags 0x0
> 	key 4B  value 1B  max_entries 64  memlock 8192B
>   #
>=20
> So, dumping the entries for those entries:
>=20
> [root@quaco ~]# egrep sleep /tmp/build/perf/arch/x86/include/generated/as=
m/syscalls_64.c
> 	[35] =3D "nanosleep",
> 	[230] =3D "clock_nanosleep",
> [root@quaco ~]#
>=20
> Looking at just the open and nanosleep:
>=20
>   # bpftool map dump id 199 | grep "value: 01"
>   key: 23 00 00 00  value: 01
>   key: e6 00 00 00  value: 01
>   #
>=20
>   # bpftool map lookup id 199 key 35
>   Error: key expected 4 bytes got 1
>   #
>=20
>   # bpftool map lookup id 199 key 35 00 00 00
>   key: 23 00 00 00  value: 01
>   # bpftool map lookup id 199 key 230 00 00 00
>   key: e6 00 00 00  value: 01
>   #=20
>=20
> I thought it was that --pretty option, so I tried:
>=20
>   # bpftool map --pretty lookup id 199 key 230 00 00 00
>   {
>     "key": ["0xe6","0x00","0x00","0x00"
>     ],
>     "value": ["0x01"
>     ]
>   }
>   #
libbpf pr_warning on failing to load BTF
or failing to create a MAP after BTF has been loaded and
____btf_map_xxx can be found.

Did you see any of them?  It seems it can load the BTF
from your email.

It may be useful to set the libbpf's __pr_debug which
should be NULL by default iirc.
