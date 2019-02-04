Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50328C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0983621852
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IoUnGGnw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ViZJljNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfBDTd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:33:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbfBDTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:33:26 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14JP27d018166;
        Mon, 4 Feb 2019 11:33:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZahcWVDh+9CxEQma5MDd2caoGDGx8kCS+VDQsyG1FpU=;
 b=IoUnGGnw0XnQ1QAq72afSzd1+xd8yixxy5QSRcCmZy9F1X4+YnenkR01HqZSlFsJC68Z
 GQtJ/WLgeliePk4ZHcZEF0HGFZKA09yIE5s4jmPONE30dqSu2LVtyCON6Rs2PUMRndEF
 IRZowp9FuUor/u0orDa6yRwKY5gVySQCg1A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qeru4gnaq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Feb 2019 11:33:23 -0800
Received: from frc-mbx04.TheFacebook.com (192.168.155.19) by
 frc-hub03.TheFacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 4 Feb 2019 11:33:08 -0800
Received: from frc-hub06.TheFacebook.com (192.168.177.76) by
 frc-mbx04.TheFacebook.com (192.168.155.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 4 Feb 2019 11:33:07 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 4 Feb 2019 11:33:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZahcWVDh+9CxEQma5MDd2caoGDGx8kCS+VDQsyG1FpU=;
 b=ViZJljNUq63PqoagK31QmaJzwul1bKWqAThZ6D2ilQdnRVO+X5/kKW3Vewb7lbaWrWZDFehng10Eyzv/bOHJqQ+KUB06IeoaaXRwFNkRI8ZA5pbm/jy6nVx25IaBc5hL+xnm7NUEV37VlIttgOGvDD6m2udi/63ZJqxCBAgw9QA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1549.namprd15.prod.outlook.com (10.173.235.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Mon, 4 Feb 2019 19:33:06 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 19:33:06 +0000
From:   Song Liu <songliubraving@fb.com>
To:     lkml <linux-kernel@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        David Carrillo Cisneros <davidca@fb.com>
Subject: Re: [PATCH] perf utils: silent "Couldn't synthesize bpf events"
 warning for EPERM
Thread-Topic: [PATCH] perf utils: silent "Couldn't synthesize bpf events"
 warning for EPERM
Thread-Index: AQHUvMBIgIv+yk8cOESdYlbXLV8MMKXQB2WA
Date:   Mon, 4 Feb 2019 19:33:06 +0000
Message-ID: <41F4E192-ABD1-41BF-9BAE-45E78DD719B3@fb.com>
References: <20190204193140.719740-1-songliubraving@fb.com>
In-Reply-To: <20190204193140.719740-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [199.201.64.132]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1549;20:KYFknFdnUlCdBa1O9QC2eqbSdDukUUeecqaS4srIR1/zpPOcVNuJna0DlLMTLUHNCelDgnqm3tJCiTvX7s+1Q5QBvpXS6HbO25boI3Sm4BDq3abC8Ff+HovveFqU3qx7UkqVwlEgZK8NY1U6TImJli4LA6lqw7Q2rlRYqCadTUU=
x-ms-office365-filtering-correlation-id: b77ef03a-5723-46f1-d7d3-08d68ad79670
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1549;
x-ms-traffictypediagnostic: MWHPR15MB1549:
x-microsoft-antispam-prvs: <MWHPR15MB1549B3D6FA9AA0E0E4513A01B36D0@MWHPR15MB1549.namprd15.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(136003)(366004)(189003)(199004)(25786009)(476003)(86362001)(66066001)(6512007)(486006)(99286004)(6116002)(106356001)(97736004)(3846002)(105586002)(71190400001)(71200400001)(6916009)(14454004)(14444005)(36756003)(83716004)(478600001)(4326008)(229853002)(53546011)(256004)(6246003)(8676002)(82746002)(316002)(102836004)(6506007)(186003)(76176011)(54906003)(81156014)(6486002)(446003)(53936002)(2906002)(6436002)(11346002)(2616005)(50226002)(81166006)(57306001)(26005)(8936002)(305945005)(33656002)(7736002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1549;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BiTC2x1TzZKI2ilwWcNsJwIiuCL7S+L6aSMMY87i96vI/UUDSQ1cQPz/xhZEqsmMam972o8u/hZ7oZWIb4ShSeh1spB8L6d7hbXxa9BeAK6EoLkyzKKh2eE/PaqTH2lr49RbeTIQF1xZ8t8nWziiPzs8/qgdt5xUC4aYs1GgBOZTfyYWp3qaH9l2rK25UDpv/MFAvidN1/IEtfM4ME3bQLJe8B6w+rNcgdFoe6nWXZCMuBvZlnw8/X2a3VZ79MWSNrL9YqPXrTxHyXjYY99zR/f4yML9TWlRU/OvmidZJJTgVuxHV60ZDrjnwyZoS2O/IeFegREWHlEFjZnaZ4QPq1NYFPs1uN9DRJk1F4sLkk0u6+ezCpI8x2bebkjgqh3iEpCgOfEU+qWm6+XW1kWCjvHrL8Q+HPKQenq6vMixWbQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40A8602B6C79AB4F8B47D919DEB8A11F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b77ef03a-5723-46f1-d7d3-08d68ad79670
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 19:33:06.4972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1549
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 4, 2019, at 11:31 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
> Synthesizing BPF events is only supported for root. Silent warning msg
> when non-root user runs perf-record.
>=20
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Reported-by: David Carrillo-Cisneros <davidca@fb.com>
> Tested-by: David Carrillo-Cisneros <davidca@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
> tools/perf/util/bpf-event.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 796ef793f4ce..62dda96b0096 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -236,8 +236,8 @@ int perf_event__synthesize_bpf_events(struct perf_too=
l *tool,
> 			pr_debug("%s: can't get next program: %s%s",
> 				 __func__, strerror(errno),
> 				 errno =3D=3D EINVAL ? " -- kernel too old?" : "");
> -			/* don't report error on old kernel */
> -			err =3D (errno =3D=3D EINVAL) ? 0 : -1;
> +			/* don't report error on old kernel or EPERM  */
> +			err =3D (errno =3D=3D EINVAL || errno =3D=3D EPERM) ? 0 : -1;
> 			break;
> 		}
> 		fd =3D bpf_prog_get_fd_by_id(id);
> --=20
> 2.17.1
>=20

CC David. =
