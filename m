Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD1222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BzaKPX+t";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PljZ+rMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395545AbfBNRCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:02:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbfBNRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:02:34 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EGt6lS019676;
        Thu, 14 Feb 2019 09:02:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=AYUmWVaX7+CQT7kPiw3mxpWJwEdE8JL3xLoFThE8e8M=;
 b=BzaKPX+tp8MUniuL2f/YFboJ+5ryxuhc/vH0GP2JBFZgPnx/BZ1rswJQyUZyI7ttd0Ar
 YC7I4vnO1zml855zKvuGev0u+vn660hpWwuATU1b6TG7GgGNNsRSJ0LkmtgGeMiXaZug
 QLkt5SpqMAva2B1xObxMUWHHav0u0XD3Ico= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qnawrgbuq-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 09:02:03 -0800
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 14 Feb 2019 09:01:52 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 14 Feb 2019 09:01:52 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 14 Feb 2019 09:01:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYUmWVaX7+CQT7kPiw3mxpWJwEdE8JL3xLoFThE8e8M=;
 b=PljZ+rMhX9lbu05q3RRRqRklSZAik6j7PeO8j9TZVhZjao7xRtkvz07XnCHKxHlgVhY0/oRvlPq2QJm4YsLCujPO9v9tabKkH7xqRBw6jbt1nkgGSDw32TGr9LXEtXsKh7TWr1+M7M8OHK2BoR7coHiw+/Ac3VbyaevvWj1cDdE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1152.namprd15.prod.outlook.com (10.175.2.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 17:01:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 17:01:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>
Subject: Re: [PATCH 5/9] perf, bpf: save bpf_prog_info in a rbtree in perf_env
Thread-Topic: [PATCH 5/9] perf, bpf: save bpf_prog_info in a rbtree in
 perf_env
Thread-Index: AQHUwBU1jGfep/2GK02JoCQpTe8pjaXfQOUAgABM4YA=
Date:   Thu, 14 Feb 2019 17:01:48 +0000
Message-ID: <728C11EA-0862-47A8-AF0E-BEBA77FC5FF4@fb.com>
References: <20190209011705.2160185-1-songliubraving@fb.com>
 <20190209011705.2160185-6-songliubraving@fb.com>
 <20190214122638.GD26714@krava>
In-Reply-To: <20190214122638.GD26714@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:dadd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1423048-866a-4aff-515e-08d6929e1be8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1152;
x-ms-traffictypediagnostic: MWHPR15MB1152:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1152;20:IGEmN03LGsAeHsmLaE5zv2i9Aj22K6bcoPMKDYNaAkGdtAbnRmB2Qle4u5ij5Ubt1Ryjw2f0X4mjzFCNh07Y1WoyC9m0yr3LPpZHB23lWrUp+rRDdGHYXOO3ANpTN/HfrFHyZ9bTi1EgyJgKRgTUl7ebkbO7/5bP6W7gl23nUhI=
x-microsoft-antispam-prvs: <MWHPR15MB11529DBC9FD183F750D432B7B3670@MWHPR15MB1152.namprd15.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(186003)(102836004)(229853002)(106356001)(68736007)(76176011)(2616005)(11346002)(6116002)(46003)(36756003)(8936002)(33656002)(446003)(105586002)(476003)(316002)(6916009)(83716004)(97736004)(54906003)(82746002)(25786009)(6506007)(86362001)(256004)(71200400001)(305945005)(6436002)(478600001)(2906002)(71190400001)(53546011)(53936002)(14444005)(8676002)(6486002)(7736002)(57306001)(81166006)(6246003)(6512007)(486006)(14454004)(4326008)(81156014)(4744005)(99286004)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1152;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XKBsRuWWTg5xnmF+cBmepGH5D97bGy4HepKEB1AeYyB6MpHpSSiigLEyP4wUoCGfaiqjps7GvmPSZ6cc+fc9RmveHLIDiRYD5+STionB+Tpi4MFFKdEWzWMkEgC70e77PhMIzFfmkoqIwKjQRgONj1R08dL/X/lpYZF4QNu87SYdvNOBqvKYLqYl3KaGBnMdR/i79yGwobbf9tOx47nUdrXFUEjuXsgiZeLHGzXV9UPu22aozs+CaQYx63gfbJ2r8znipi9jbnSTG/lrz45FSaDh0ryx8q03L2nOYlCsAlc8D5RcIJhwQ4xKzKXqxy50QZ4R7yr3ugyYAIfydkuFuJcV/ro0N/YyFuGUxj6cbetR+aAr6Gy2dfNJb53h5j7/k6Rg/V4q2e08wSmPnr4peSg0Hifd0XINHCJbXaur9qU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D3D4E4D43B28F41879F53DF31FE0C59@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1423048-866a-4aff-515e-08d6929e1be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 17:01:48.6739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1152
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 14, 2019, at 4:26 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Feb 08, 2019 at 05:17:01PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>> index d01b8355f4ca..5894a177b7cf 100644
>> --- a/tools/perf/util/env.h
>> +++ b/tools/perf/util/env.h
>> @@ -3,7 +3,10 @@
>> #define __PERF_ENV_H
>>=20
>> #include <linux/types.h>
>> +#include <linux/rbtree.h>
>> #include "cpumap.h"
>> +#include "rwsem.h"
>> +#include "bpf-event.h"
>>=20
>> struct cpu_topology_map {
>> 	int	socket_id;
>> @@ -64,6 +67,8 @@ struct perf_env {
>> 	struct memory_node	*memory_nodes;
>> 	unsigned long long	 memory_bsize;
>> 	u64                     clockid_res_ns;
>> +	struct rw_semaphore	bpf_info_lock;
>=20
> why's the lock needed?
>=20
> jirka

It protects the retries for bpf_prog_info and btf. For perf-top,=20
we will have one thread writing to the trees, while the main=20
thread reading from them.=20

Let me add comments to clarify.=20

Thanks,
Song
