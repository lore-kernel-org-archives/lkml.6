Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9964C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1C2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f3+qmivB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="De4+ANgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfBORGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:06:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40336 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbfBORGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:06:47 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FH5h7q027993;
        Fri, 15 Feb 2019 09:06:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SAolp+H95LGbk7LgrO3g6fDDsiglYEnHlTLW3H71Mp8=;
 b=f3+qmivBaNdj4xkeAwiRuqCd6PKDVSZncBxDNWRGcKYr+P5r5Cej80qgLOAjBYwhvUpS
 QC21jTmQqwqJiNoqwhWWHAPDgoLtlyg8rCdIosOiaVLum8heGeTUmJGY0NvGmDUZYmt2
 cyAkrgVgl9Bwec5B/PcOxoZ9X6iynS4yZDQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qp06689v3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 09:06:21 -0800
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:06:20 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 09:06:20 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 09:06:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAolp+H95LGbk7LgrO3g6fDDsiglYEnHlTLW3H71Mp8=;
 b=De4+ANgsvqLCSFiKb+b+2Fh/G7lgeMgJW3PNLq96AjregHoxKD0reO3dGQmJfttkuIZ5pPHk81vfuMdo/cY0HznsOu13mpYjMx8LQTnSsxQ0dMhM1Gl8k9aCD8zTfKbCNNpZkWCkvzb03FHRRFDzYdmBgXRVFSDr10zepbUaSq4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1437.namprd15.prod.outlook.com (10.173.234.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 17:06:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9%8]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 17:06:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 09/11] perf-top: add option --bpf-event
Thread-Topic: [PATCH v2 perf,bpf 09/11] perf-top: add option --bpf-event
Thread-Index: AQHUxMGMY3vvH6D4q0S2zKJjLfnL76Xg672AgAAsSAA=
Date:   Fri, 15 Feb 2019 17:06:19 +0000
Message-ID: <31C00A93-54B4-40D0-AC63-A19368AEC669@fb.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-8-songliubraving@fb.com>
 <20190215142749.GD5784@redhat.com>
In-Reply-To: <20190215142749.GD5784@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:e850]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cdf51a3-1e58-4d2c-c2b0-08d69367e777
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1437;
x-ms-traffictypediagnostic: MWHPR15MB1437:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1437;20:/krcqRxIX7dq1M9mUroLoMpR8gq6tsHL8wE1t5FQCbiIxWGo783aa88/LuzJ5kuVxDYGUk2GHtLC8lO70u4AUEapTy+H73nQX30h7S8cJGKGstKnOuR0oPPhyibhsUTxFa/f/k7+6dehUKWbMtY8P66nJ/tuLYxYpwKY6qg22bo=
x-microsoft-antispam-prvs: <MWHPR15MB1437B391D2556DACF0E9DC0CB3600@MWHPR15MB1437.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(2906002)(229853002)(305945005)(6436002)(86362001)(7736002)(6486002)(6916009)(8676002)(97736004)(256004)(82746002)(25786009)(71190400001)(76176011)(71200400001)(83716004)(6506007)(57306001)(53546011)(6246003)(105586002)(4326008)(6116002)(106356001)(99286004)(6512007)(11346002)(446003)(478600001)(186003)(36756003)(14454004)(2616005)(476003)(33656002)(486006)(46003)(68736007)(316002)(8936002)(53936002)(81166006)(81156014)(102836004)(54906003)(50226002)(93886005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1437;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: anmYDbhbLqfpChqtja9PB22z9KDdAHKDqk0N7NqXxp0lWQ8iMXO0GNaJio3S4Jb2zb+//Yzp1gzwez6tFfh254J2HED1DKJF44sU8aQwY400SBh4jBKxwpP2boy0vcWn7hGbzJOLHGbPR8AoyCA3eZElkZmHvmnDAAv+zlg5EIM+/RD2kiAoM0C/0uuqAWgcMT5PKdUC7LbBiNBx6hLVK6vWNsQMuIGFvyG8+pkXrzkbF1JUpUfdCDhFl5hFOriVEz4O5oTePTyknr9gOIPKWV7h198464HW+ChhRCsmzLzsRr/a/cj2/vpCD2HSokqcQbSEZMONGc48MI7fORBxotunQoCgv5+CRMmfNjV5wkhmdmL49/YvVcrW+6s2yvg5cnp9F4jtEBcQhw8V69FVelLQQEmIm8E67iaQof21Pus=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC85F5F4B33952488DD0CDCEAA6C3028@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdf51a3-1e58-4d2c-c2b0-08d69367e777
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:06:19.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 6:27 AM, Arnaldo Carvalho de Melo <acme@redhat.com> w=
rote:
>=20
> Em Thu, Feb 14, 2019 at 04:00:10PM -0800, Song Liu escreveu:
>> bpf events are only tracked when opts->bpf_event is enabled. This patch
>> adds command line flag to enable this for perf-top.
>=20
> Shouldn't this start as enabled and we just provide a way to disable it
> for testing purposes? Normally perf top works system wide, and then we
> want to get info about BPF events, I think.
>=20
> - Arnaldo

We can enable it by default, and add a --no-bpf-event option to disable it
for testing.=20

Thanks,
Song



>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/builtin-top.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index 27d8d42e0a4d..5271d7211b9c 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -1492,6 +1492,7 @@ int cmd_top(int argc, const char **argv)
>> 		    "Display raw encoding of assembly instructions (default)"),
>> 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>> 		    "Enable kernel symbol demangling"),
>> +	OPT_BOOLEAN(0, "bpf-event", &opts->bpf_event, "record bpf events"),
>> 	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
>> 		    "objdump binary to use for disassembly and annotations"),
>> 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler=
_style, "disassembler style",
>> --=20
>> 2.17.1

