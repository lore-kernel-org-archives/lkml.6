Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A59C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F42D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gXbdcbHK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="URpL+1T7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F42D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeLKRSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:18:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbeLKRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:17:59 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBHGpLk015917;
        Tue, 11 Dec 2018 09:17:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Xw3f8sqRdetK9CHaSXiF6tlXpbNlay5WVcrCBgHH2W4=;
 b=gXbdcbHK3vZW4zwCygffDBVNCynvhoRsm9EhqwSNWgvNS8lBLvLQ1+c6rzPkkwkxkY1A
 Qdp53fTvpNOA6pF3nUdJF4eKn0qWgoZoXkebdrdXwoYU1XDWF+1xt+Wr08O7hSdkBjrP
 HKrtwkXEsAcrDCAEb8hppvEJkJcVqNnlDs0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2paengrsg6-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 09:17:36 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 11 Dec 2018 09:16:18 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 11 Dec 2018 09:16:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw3f8sqRdetK9CHaSXiF6tlXpbNlay5WVcrCBgHH2W4=;
 b=URpL+1T7kj/rv2m/NpO/+wnom/t7KjxgdEPuRcJbzHxkBGCGuzziAP0skDuZZ+xFrx3I7Of/oinm3NYOBzbx8ythOeGogVkkcusqfvUKB6GubOvUc03DTS7dvZBsvrC40tn4MYsThnCRvGBnvqe3jhsIkKALxhHGrg+cm8daqf0=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1549.namprd15.prod.outlook.com (10.173.235.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 17:16:12 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::14db:7315:30f7:10d7]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::14db:7315:30f7:10d7%7]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 17:16:12 +0000
From:   Martin Lau <kafai@fb.com>
To:     Roman Gushchin <guroan@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: add bpffs pretty print for cgroup
 local storage maps
Thread-Topic: [PATCH v2 bpf-next 2/3] bpf: add bpffs pretty print for cgroup
 local storage maps
Thread-Index: AQHUkOIfbqTqLnFamUS/HRDkHABfdaV5yKcA
Date:   Tue, 11 Dec 2018 17:16:12 +0000
Message-ID: <20181211171610.z4cym255ai42acip@kafai-mbp.dhcp.thefacebook.com>
References: <20181210234302.31327-1-guro@fb.com>
 <20181210234302.31327-3-guro@fb.com>
In-Reply-To: <20181210234302.31327-3-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0001.namprd17.prod.outlook.com
 (2603:10b6:301:14::11) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:a71b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1549;20:bCX0hJeYpd+gKlOO5qXQH4RRk9wyBCCowrq5IjBERV3YXrnYEcnFFJ13bVFbtR3Eg41glKwpoSlDzvQnYMKBHx1oXFmgeI7KMZzO/yAA8M5Nvi4uuAO23jxFLEs9AzqulLzY+xTM+Ldrns+jJWelP4QQPJK17DCvMbYFHxM5cJo=
x-ms-office365-filtering-correlation-id: ffccb6ee-d14b-4f1e-108a-08d65f8c5966
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1549;
x-ms-traffictypediagnostic: MWHPR15MB1549:
x-microsoft-antispam-prvs: <MWHPR15MB15491BFAC2BEF3172A97FCF9D5A60@MWHPR15MB1549.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(11241501185)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1549;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1549;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(6116002)(39060400002)(53936002)(4326008)(6512007)(99286004)(9686003)(52116002)(76176011)(2906002)(14454004)(6916009)(6246003)(1411001)(102836004)(186003)(105586002)(33896004)(97736004)(316002)(54906003)(6506007)(5660300001)(86362001)(386003)(8936002)(25786009)(71200400001)(478600001)(486006)(8676002)(68736007)(476003)(106356001)(7736002)(305945005)(46003)(71190400001)(1076002)(81156014)(81166006)(229853002)(11346002)(14444005)(6436002)(256004)(6486002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1549;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 28buIiKSAJlgJe+GzcDriTIVm2il4obsUeEcdbJOZZKj0m8mW1w4+9i6kO82s5C/2L7cP0pHcMC3t0SVR36Cc8PVjDgGmuUNympROFoYwJn5ZH0fmt11ogWk/dr7h7lW9qfXjhCUQgVrN7OEcvgkaWZ98OGxSr19gu+zw2tpyaKDR8FfebZfeIfx+SNEJtgYq+wlSkc9uXa7lRMs3jXgtnFSx+CckWSUxdUHPqDZT4JihCImkzhpwIjNFd4wF5SrtkpPg+58aQ05uDwdwR4IOp47/zLiUWeaT3Cf0IgNGViwfVLryDiNWO6kjVjR7AJk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50FA535EC658A147AE425247066E6726@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ffccb6ee-d14b-4f1e-108a-08d65f8c5966
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 17:16:12.6768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1549
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 03:43:01PM -0800, Roman Gushchin wrote:
> Implement bpffs pretty printing for cgroup local storage maps
> (both shared and per-cpu).
> Output example (captured for tools/testing/selftests/bpf/netcnt_prog.c):
>=20
> Shared:
>   $ cat /sys/fs/bpf/map_2
>   # WARNING!! The output is for debug purpose only
>   # WARNING!! The output format will change
>   {4294968594,1}: {9999,1039896}
>=20
> Per-cpu:
>   $ cat /sys/fs/bpf/map_1
>   # WARNING!! The output is for debug purpose only
>   # WARNING!! The output format will change
>   {4294968594,1}: {
>   	cpu0: {0,0,0,0,0}
>   	cpu1: {0,0,0,0,0}
>   	cpu2: {1,104,0,0,0}
>   	cpu3: {0,0,0,0,0}
>   }
Acked-by: Martin KaFai Lau <kafai@fb.com>
