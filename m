Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D262C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2551217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YG1oWRM4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PaAZJcZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfBSFwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:52:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfBSFwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:52:53 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1J5gpwX027825;
        Mon, 18 Feb 2019 21:52:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WGnuM4kK8j7TwwjFiBPyLeQGQY2HlMXji36hYHdyiW0=;
 b=YG1oWRM4A6YYESjuCoyNmphOcwUZq3otqqRo2eWxgwgdLg6EK+OiBR1M6IN5wvX+Lmu1
 lnDyH/A9wH8HTEkVHzLVpPvy1vcOepcSzG3ZIUHZvL6emRuV/WPxojyh/bAsrZNRKZcO
 r5T4U5rhnMrPi/E8rDlQOG1NnXWg00rR3CI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qr7t80hag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 21:52:25 -0800
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 18 Feb 2019 21:52:23 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 18 Feb 2019 21:52:22 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 18 Feb 2019 21:52:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGnuM4kK8j7TwwjFiBPyLeQGQY2HlMXji36hYHdyiW0=;
 b=PaAZJcZ5dbvXEfHoIFh7iP6lnVh0sgTnp6Xg1ISr1s+ijEhOm7LmB5+NQ5bXlwazFIu7I8S0uIzZFH+k1VZAvyINnwZGnkmRcu+5E15nLCGyLAkrrLqf66lSy/Ff5V9275Hrm8yxIY+x8MNBriLy2P++4QMestskJmGZuvF8M5o=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1817.namprd15.prod.outlook.com (10.174.246.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 05:52:21 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560%7]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 05:52:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Topic: [PATCH v3 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Thread-Index: AQHUxXkOtC9zjVEe5kKW+v5YXb3KDaXkn4sAgAIECoA=
Date:   Tue, 19 Feb 2019 05:52:20 +0000
Message-ID: <4784383E-1BFA-4387-8864-B1814FFEC937@fb.com>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-6-songliubraving@fb.com>
 <20190217230516.GA7443@krava>
In-Reply-To: <20190217230516.GA7443@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:7569]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42ea7c17-d640-470b-7549-08d6962e69f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1817;
x-ms-traffictypediagnostic: DM5PR15MB1817:
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1817;20:GWaSKZjLDWSu+AF03WAaIhPALfuTmA9tOugt+ajLxxAa4bbQGYOk+wKwNZJiMNlYyx7RaWES/7XEbLAWO1KzTTxDx6RdlVin3IodK5oe/IdswmSSuGgYOcn5sjvXEOTcU4ITzn+LJG4imh3Rvedm9pcYZBoYqDg/eniKUQ9JQUA=
x-microsoft-antispam-prvs: <DM5PR15MB18177E00EEFC1C3F00B276A5B37C0@DM5PR15MB1817.namprd15.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(36756003)(5660300002)(83716004)(6512007)(106356001)(86362001)(68736007)(6506007)(6436002)(256004)(478600001)(71190400001)(71200400001)(82746002)(102836004)(105586002)(6916009)(316002)(53936002)(25786009)(6246003)(305945005)(6116002)(53546011)(7736002)(4326008)(54906003)(97736004)(57306001)(50226002)(33656002)(2906002)(446003)(11346002)(6486002)(76176011)(2616005)(486006)(476003)(81166006)(8676002)(46003)(14454004)(99286004)(81156014)(229853002)(186003)(8936002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1817;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TNyeogq6aGyj8MNnQvoqgddZg3KEIcOTCpifZPOuHDHDZpjPIkmCMD3zcFr9hH4ppY+s88b/8WxlZm1hQNnT1ITsrwhc/S2VYaDzhvvCFLdRSQddARbj6R2Oao2Mp4yY/8cp2p7gu+H3G88L6kTUF2BsAbv40I0RG8MP4HdGebHAkLfWjW3pGn3KjUT1j1YQEKNwsz24iGz2PAs0wUoMBgxJ2MEPO8RQ6PyAHAvuIgcm71NgPpzX2ujuCwuxMO21pPbL3VoWKIM9kDp04vSpKvU9BvDm7r6GmUGzbMUD1/UjHqXc97wKY7AaleYaPHPkIl+vqCP8uhqoiNqjGrhcx5q2xX1Qm8nvxAmPzt7VoIl8cbpuQ8EQC+S7RxfRCKwyEU3iBhmV5zMq16EJFEv8Y29Xttn51z2Nywu5+HXSs7s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD511CFC14D2044E8B80CD2E64B46E07@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ea7c17-d640-470b-7549-08d6962e69f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 05:52:20.8153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1817
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 17, 2019, at 3:05 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Feb 15, 2019 at 01:53:48PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> 	info_linear =3D bpf_program__get_prog_info_linear(fd, arrays);
>> 	if (IS_ERR_OR_NULL(info_linear)) {
>> @@ -151,8 +165,8 @@ static int perf_event__synthesize_one_bpf_prog(struc=
t perf_tool *tool,
>> 						     machine, process);
>> 	}
>>=20
>> -	/* Synthesize PERF_RECORD_BPF_EVENT */
>> 	if (opts->bpf_event) {
>> +		/* Synthesize PERF_RECORD_BPF_EVENT */
>> 		*bpf_event =3D (struct bpf_event){
>> 			.header =3D {
>> 				.type =3D PERF_RECORD_BPF_EVENT,
>> @@ -165,6 +179,19 @@ static int perf_event__synthesize_one_bpf_prog(stru=
ct perf_tool *tool,
>> 		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
>> 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
>> 		event->header.size +=3D machine->id_hdr_size;
>> +
>> +		/* save bpf_prog_info to env */
>> +		info_node =3D malloc(sizeof(struct bpf_prog_info_node));
>> +		if (info_node) {
>> +			info_node->info_linear =3D info_linear;
>> +			perf_env__insert_bpf_prog_info(env, info_node);
>> +			info_linear =3D NULL;
>> +		}
>=20
> what if the allocation fails? we don't care?
>=20
> jirka

My original plan is to just ignore it and accept that this program
doesn't have annotation. Any suggestion on what would be a better=20
approach?

Thanks,
Song

