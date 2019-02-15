Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA917C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEA92192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Nt380AmX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Moy8nvPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfBOSOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:14:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50360 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727239AbfBOSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:14:23 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FI3BNF025363;
        Fri, 15 Feb 2019 10:13:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1h7cdVlNUqxQMl/1i/brRokzReC8O7mm8alBLq6FEc0=;
 b=Nt380AmX4VZDvLdLLkC6TIxgo6RDeZOBQqOFpq23ENkFkORk4svvPDrxCgg6zakIBN1d
 JmIIkaqIs91/3xZXaiinGQVGCnzvCRL/sNq2kmOMWMX9tAf0s8l7th06N0T0BVJq5ErJ
 +JBX/ywl3JoVrPMMHHTVj5CKWFztCVDq9EM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qp1qrr679-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 10:13:55 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 10:13:55 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 15 Feb 2019 10:13:55 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 15 Feb 2019 10:13:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h7cdVlNUqxQMl/1i/brRokzReC8O7mm8alBLq6FEc0=;
 b=Moy8nvPZ6Km+yUTuSHtN1RZQbhOO99APtz0kMB4muJ6sMGzDq9yuzRf8Gia2jX9a5Jum+heZBim3wFegDfrbZ0zWHuiRzF/KKgu0OCdTwsCnYlPbmXB0TuoMMEgvAqOz8j5uT7taloSxPMF9GwyBmouvsvN77HuSMUiAXY3fZQg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1118.namprd15.prod.outlook.com (10.175.2.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 15 Feb 2019 18:13:35 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::258f:f2c4:7d47:bb9%8]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 18:13:35 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 11/11] perf, bpf: save information about short
 living bpf programs
Thread-Topic: [PATCH v2 perf,bpf 11/11] perf, bpf: save information about
 short living bpf programs
Thread-Index: AQHUxMGajwOXFyznb0+c5ufOc/HDYKXg76MAgAAqQQCAAA+4AIAAATQA
Date:   Fri, 15 Feb 2019 18:13:35 +0000
Message-ID: <D4559155-4993-4319-81C9-AC4ADDDAE3B6@fb.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000045.2592135-1-songliubraving@fb.com>
 <20190215000045.2592135-2-songliubraving@fb.com>
 <20190215144146.GF5784@redhat.com>
 <62DB92A4-F708-4E89-B668-4EAFD0FA6731@fb.com>
 <20190215180916.GJ5784@redhat.com>
In-Reply-To: <20190215180916.GJ5784@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:e850]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79ffc562-0dab-4999-7c19-08d693714d23
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1118;
x-ms-traffictypediagnostic: MWHPR15MB1118:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1118;20:C+iyIEg0nAjiq6xhle39PJBdJKLZKw8WvVqWadBPoAhfjJCW3UZcKgft9h5/JRIV/BNwZaua+faR1wnW9oZ/6LoAlarGHkocxuAxlNF77r7pJfEL+mOuvM8I7HzfYvI5zTvGkU0NcEfsrmCGxfK8VxUG2RTLVgOJDZpVAt3GuqU=
x-microsoft-antispam-prvs: <MWHPR15MB1118A2E00FF9B74432E033FFB3600@MWHPR15MB1118.namprd15.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(8676002)(86362001)(446003)(6916009)(102836004)(14444005)(8936002)(11346002)(105586002)(53546011)(50226002)(81156014)(81166006)(106356001)(14454004)(486006)(46003)(6506007)(478600001)(6116002)(476003)(186003)(99286004)(6512007)(2616005)(6436002)(76176011)(6246003)(305945005)(229853002)(57306001)(6486002)(53936002)(33656002)(97736004)(316002)(36756003)(256004)(4326008)(25786009)(93886005)(54906003)(68736007)(71200400001)(71190400001)(83716004)(82746002)(7736002)(2906002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1118;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A1E7g5cphk1oYbkZuuAE35M35djRcNVTEpM2VZJWKvUr5c6lSrYEi4L/sMxlIiCguFDmiKrZy8ycR3IRE/IgE3dzN8ay7Ll8GkCxyF99NLuTJLUQu1T5Co0Bqy5AQX6Nnc6I7qhWKvBl+aLkOisr0bpcsV2VK4IXOqfxIpB8M1rrtTiRCr2rGRNAJMTSMR4jMtJx38B3eStOFBiaOkinbSNRfEZrcME929EbTuUAEpMVPOCRVsvuSnlKzD1L5r0Tym+WvSR2on71dT42Jaeam9LV7cX23WKr1MIQ1Xf3CgYiXVesIXgif+gsnlVXUHRGpHW677R3yKTMfV+OKS/VAspd11nFUsAWN5ruhjLDxbHfSdftQKGzF/hJKjJrfzPbx/f7YRNZwEgK+PDAheO9L+Ba0jx4IrQtu06+0SJtFuY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <726C01BF7D22614DAEB6063002F86803@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ffc562-0dab-4999-7c19-08d693714d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:13:35.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1118
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 10:09 AM, Arnaldo Carvalho de Melo <acme@redhat.com> =
wrote:
>=20
> Em Fri, Feb 15, 2019 at 05:13:01PM +0000, Song Liu escreveu:
>>> On Feb 15, 2019, at 6:41 AM, Arnaldo Carvalho de Melo <acme@redhat.com>=
 wrote:
>>> Em Thu, Feb 14, 2019 at 04:00:45PM -0800, Song Liu escreveu:
>>>> +pthread_t poll_thread;
>>>> +
>>>> +int bpf_event__start_polling_thread(struct bpf_event_poll_args *args)
>>>> +{
>>>> +	struct perf_evsel *counter;
>>>> +
>>>> +	args->evlist =3D perf_evlist__new();
>>>> +
>>>> +	if (args->evlist =3D=3D NULL)
>>>> +		return -1;
>>>> +
>>>> +	if (perf_evlist__create_maps(args->evlist, args->target))
>>> 		goto out_delete_evlist;
>>>> +
>>>> +	if (perf_evlist__add_bpf_tracker(args->evlist))
>>> 		goto out_delete_evlist;
>>>> +
>>>> +	evlist__for_each_entry(args->evlist, counter) {
>>>> +		if (perf_evsel__open(counter, args->evlist->cpus,
>>>> +				     args->evlist->threads) < 0)
>>> 			goto out_delete_evlist;
>>>> +	}
>>>> +
>>>> +	if (perf_evlist__mmap(args->evlist, UINT_MAX))
>>> 		goto out_delete_evlist;
>>>> +
>>>> +	evlist__for_each_entry(args->evlist, counter) {
>>>> +		if (perf_evsel__enable(counter))
>>> 			goto out_delete_evlist;
>>>> +	}
>>>> +
>>>> +	if (pthread_create(&poll_thread, NULL, bpf_poll_thread, args))
>>> 		goto out_delete_evlist;=09
>>>> +
>>>> +	return 0;
>>> out_delete_evlist:
>>> 	perf_evlist__delete(args->evlist);
>>> 	args->evlist =3D NULL;
>=20
> Have you seen the error handling suggestion above?

Yes! I will include these changes, as always. :)

>=20
>>>> +int perf_evlist__add_bpf_tracker(struct perf_evlist *evlist)
>>>> +{
>>>> +	struct perf_event_attr attr =3D {
>>>> +		.type	          =3D PERF_TYPE_SOFTWARE,
>>>> +		.config           =3D PERF_COUNT_SW_DUMMY,
>>>> +		.watermark        =3D 1,
>>>> +		.bpf_event        =3D 1,
>>>> +		.wakeup_watermark =3D 1,
>>>> +		.size	   =3D sizeof(attr), /* to capture ABI version */
>>>> +	};
>>>> +	struct perf_evsel *evsel =3D perf_evsel__new_idx(&attr,
>>>> +						       evlist->nr_entries);
>>>> +
>>>> +	if (evsel =3D=3D NULL)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	perf_evlist__add(evlist, evsel);
>=20
>>> You could use:
>=20
>>> 	struct perf_evlist *evlist =3D perf_evlist__new_dummy();
>>> 	if (evlist !=3D NULL) {
>>> 		struct perf_evsel *evsel =3D=3D perf_evlist__first(evlist);
>>> 		evsel->attr.bpf_event =3D evsel->attr.watermark =3D evsel->attr.wakeu=
p_watermark =3D 1;
>>> 		return 0;
>>> 	}
>>> 	return -1;
>=20
>> This looks cleaner. Let me fix in next version.=20
>=20
>>> Because in this case all you'll have in this evlist is the bpf tracker,
>>> right? The add_bpf_tracker would be handy if we would want to have a
>>> pre-existing evlist with some other events and wanted to add a bpf
>>> tracker, no?
>=20
>> I think all we need is a side-band evlist instead of the main evlist. Ma=
y
>> be we should call it side-band evlist, and make it more generic?
>=20
> Sure, you could for instance have something like:
>=20
> 	struct perf_event_attr attr =3D {
> 		.watermark        =3D 1,
> 		.bpf_event        =3D 1,
> 		.wakeup_watermark =3D 1,
> 	}
> 	struct perf_evlist *evlist =3D perf_evlist__new_side_band(&attr);
>=20
>=20
> And the other details will be set by it, i.e. the .config
>=20
> 	.type	          =3D PERF_TYPE_SOFTWARE,
> 	.config           =3D PERF_COUNT_SW_DUMMY,
> 	.size	   =3D sizeof(attr), /* to capture ABI version */
>=20
> And the idx arg.
>=20
> - Arnaldo

This looks good. Let me revise the patch in that direction.

Thanks,
Song

