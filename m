Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A2820675
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="X0j475uL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ESvALUik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfBUHMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:12:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34656 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfBUHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:12:52 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1L7AO4Q014620;
        Wed, 20 Feb 2019 23:12:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GqHV3CbkUtr5+/4eaUJpRjOxTkPFVjU+sZ0YP6TU1gE=;
 b=X0j475uLQUi4s1meHEGIcbJRun7IUEwv3qGQdPHecsuDylDRPKD8+vdbXfv9M01DtGHn
 9D5JlsRcPPPh/P8u3yFa+W89X8M9eXrLPTt0A3KEyBmQTAezJC10uACwFMT0MPsdg/N9
 bF/bwAAlvPd95QBgdsUChC7veJLQwtrlxuc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qsmfj8e6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 23:12:28 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 20 Feb 2019 23:12:27 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 20 Feb 2019 23:12:26 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 20 Feb 2019 23:12:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqHV3CbkUtr5+/4eaUJpRjOxTkPFVjU+sZ0YP6TU1gE=;
 b=ESvALUikaOblI72UlF0HxBnSodnIXD3iDYQ9jpK1uoaSkO9vDvFwyKeUkVlegAtsEkggK1mungcqinNXKVzaFqzxDq9yzXgmOfxpfpJxzq+YhW+dz36YM4zaXi0KbbxrDEl1odmPbjQy2oiuqR3nInjaSEy/3vEOjayRey8K80Y=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1642.namprd15.prod.outlook.com (10.175.105.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 07:12:14 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560%7]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 07:12:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Subject: Re: [PATCH 15/17] perf bpf-event: Add missing new line into pr_debug
 call
Thread-Topic: [PATCH 15/17] perf bpf-event: Add missing new line into pr_debug
 call
Thread-Index: AQHUyYSlkIRmrYMHHUqfLUPhZn9bTqXp1m0A
Date:   Thu, 21 Feb 2019 07:12:13 +0000
Message-ID: <1883F478-13FB-49E8-A062-997678D94860@fb.com>
References: <20190221012549.4069-1-acme@kernel.org>
 <20190221012549.4069-16-acme@kernel.org>
In-Reply-To: <20190221012549.4069-16-acme@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:7f2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c0064a-ab3f-4859-ec89-08d697cbe7bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1642;
x-ms-traffictypediagnostic: DM5PR15MB1642:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1642;20:zUxHenYXNP4YdBRgbz791jIUKRwZqAgWDpt9lkWUZMPlMN1Y9x2C8Cio/wgM5T0FQDvG8XRrQuBAFgQ6c7TpcIdspZN6fpmwNOBGR76r3TZ+lijD3HsC1A8+QmQXeykESS9Sy8KF5Kg813aD22L7nPAZC0GQTnbyWkvlcxRfHAc=
x-microsoft-antispam-prvs: <DM5PR15MB1642618BEB1A266AC77C4BB4B37E0@DM5PR15MB1642.namprd15.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(39860400002)(346002)(396003)(189003)(199004)(76176011)(6116002)(82746002)(86362001)(97736004)(14454004)(53936002)(966005)(54906003)(316002)(106356001)(7416002)(99286004)(105586002)(6916009)(14444005)(256004)(33656002)(36756003)(57306001)(186003)(71190400001)(71200400001)(5660300002)(6506007)(2616005)(486006)(25786009)(446003)(476003)(11346002)(53546011)(6512007)(102836004)(83716004)(7736002)(8676002)(6306002)(305945005)(2906002)(46003)(6436002)(4326008)(6246003)(229853002)(478600001)(8936002)(68736007)(81166006)(6486002)(81156014)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1642;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xwhdW1wy5kFzvzNrH29eCVVagalNfhFfNZqhiwu8rMRn1wm4BKKnehe/YO5RdiEtq/kxGTAxzYCPkrebZEI0006NSFmPEUhT4aqE5sZ6F8OKCrfPddCTbyr9l5FxfO4ZPTC7wz4Sr4M9FP5CkwiYAYQrHtofcKev1X+WggU7Z5i+S6bUvP9J2/T9G1+B0+BkiqLD9TFspBVEupbgPn7goHsHNdto9Mdu0Y3YJopC0uavNSDaVPdq9FsPt0Sc32YuFowzMq1EH73r8yCJ+Lq3mqFaj1infJVvSg+yuq3YjVto377wWT6W/NyCCeqT3W37yx3GRAd/T7hPspZIBr0ebL0Xj5qqiVtRZS8PF8hBNMpoT1704mGxzsgFYeod4rHypdCC/QJq+vW/Nigow/v1EudwxR4vXpw1h+Mk5Cm3GPE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E46FE014399EDE47AC9FA03F09C18ABF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c0064a-ab3f-4859-ec89-08d697cbe7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 07:12:13.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1642
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 20, 2019, at 5:25 PM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> From: Jiri Olsa <jolsa@kernel.org>
>=20
> Add a missing new line into pr_debug call in perf_event__synthesize_bpf_e=
vents(),
> so that the error message does not screw the verbose output.
>=20
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Song Liu <songliubraving@fb.com>
> Link: http://lkml.kernel.org/r/20190220122800.864-5-jolsa@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for fixing this.

Song

> ---
> tools/perf/util/bpf-event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 62dda96b0096..028c8ec1f62a 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -233,7 +233,7 @@ int perf_event__synthesize_bpf_events(struct perf_too=
l *tool,
> 				err =3D 0;
> 				break;
> 			}
> -			pr_debug("%s: can't get next program: %s%s",
> +			pr_debug("%s: can't get next program: %s%s\n",
> 				 __func__, strerror(errno),
> 				 errno =3D=3D EINVAL ? " -- kernel too old?" : "");
> 			/* don't report error on old kernel or EPERM  */
> --=20
> 2.19.1
>=20

