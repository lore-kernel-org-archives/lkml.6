Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D02C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54555206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="APuqNOau";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QFSXyyqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfB0QxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:53:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbfB0QxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:53:17 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RGieNE007116;
        Wed, 27 Feb 2019 08:52:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4iv7vl5tmqUxwKQVSMHFCSiOjqC2P4MmbARPDJynMc8=;
 b=APuqNOauRvR+8dFMWgKVizZGwVsISNT5tcpYCSO061ZbSGf10gNOUByclPU8YQMgol1S
 2apgDRC2lLVLsAEpUfZYD4TueUlRyDM3zky+0L1C+0IjmMrxuAWxb4gElzoWu+pn5Bn4
 5+r5b88VigeB/ZU8KTQiSdp8c4EJNFERdXU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qwvm2getr-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 08:52:54 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 08:52:18 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 27 Feb 2019 08:52:18 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 27 Feb 2019 08:52:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iv7vl5tmqUxwKQVSMHFCSiOjqC2P4MmbARPDJynMc8=;
 b=QFSXyyqclABXFX0C8BauPwtSDtx9tNm2yz6KvlwBn4XK1Kfcvd5HGhaeKiwubEpfL2QxOrACcnExgOlgvQfLbiW7WFbziZ4All+KaDWQyPjRM3NmDOaYnThofqf6GsVPIsppJjC9dB8AyvU7VaPPwQvWx6uzGt8MPnkWTqLfhPA=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1406.namprd15.prod.outlook.com (10.173.234.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 16:52:16 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::ac2f:bf87:54e:48a2]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::ac2f:bf87:54e:48a2%12]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:52:16 +0000
From:   Martin Lau <kafai@fb.com>
To:     zerons <sironhide0null@gmail.com>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: drop refcount if bpf_map_new_fd() fails in
 map_create()
Thread-Topic: [PATCH] bpf: drop refcount if bpf_map_new_fd() fails in
 map_create()
Thread-Index: AQHUzqnmqyu89vznqk+nelk9lxpI5KXz3D+A
Date:   Wed, 27 Feb 2019 16:52:16 +0000
Message-ID: <20190227165213.2ta3vf4sngmrpqbk@kafai-mbp.dhcp.thefacebook.com>
References: <1551278185-5219-1-git-send-email-sironhide0null@gmail.com>
In-Reply-To: <1551278185-5219-1-git-send-email-sironhide0null@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:3340]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0a94e58-a8c2-431f-2116-08d69cd3ed9a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1406;
x-ms-traffictypediagnostic: MWHPR15MB1406:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1406;20:/D24hizF+IisayNmRZFdstqonBlnR6OEVqLKazmczb8QuL0Lnb/VmHylIae/Q4IxEo8dk1EF0HHqBd/MrA8pP3wWGHAr32DePB+L6JyQJeeT7qNHOU01dw1bZbYNRNUrMofEiEJnlRsI2JvV0J5XO7nCQJlgo+ykvau8B1/k+gM=
x-microsoft-antispam-prvs: <MWHPR15MB140654CEF6CB75CBA7FCD997D5740@MWHPR15MB1406.namprd15.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(396003)(39860400002)(346002)(51914003)(199004)(189003)(102836004)(6916009)(4744005)(386003)(6506007)(14454004)(46003)(446003)(478600001)(186003)(476003)(11346002)(6246003)(6436002)(486006)(5660300002)(81166006)(81156014)(52116002)(8936002)(4326008)(25786009)(53936002)(9686003)(305945005)(1411001)(6116002)(68736007)(71200400001)(2906002)(71190400001)(6486002)(8676002)(256004)(99286004)(105586002)(229853002)(1076003)(86362001)(54906003)(76176011)(316002)(7736002)(6512007)(97736004)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1406;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iPB7S1K0gjAqculv0OOnvX/YIbvWNKN2AwsOU9m+4Sfjdsequmi+weq6vYG/VsaZZ3i4VRDiWhpb97KS9+gmWoCAMNOWu7p5gyTnGCfhFiWEYsZjvngjNDwirS5LeB5QKyS1/OI0w2e7LWXWD8mkJFDYtLVk4t6xT/NjYUIQ6DSPw1zXno6bXtGQQWQZh+ll+UjumvfiTaH0sN8pC7d333QWhrGiAlCFEllCT+dKhmfcuBEX7ZcSR/COFKuLTzeeykLxEeCLQqGyiQdhBYzyiGDFpJznd86XmPmoBNzoyW5RvyiV6g8tb7uPvc769WLG8ifrRuGajhhviPfJkv+MxH3vmj3R+Uk6QjRonwM3JqRmvvFqx3S5w6v3AlBzsE/fVFlofYB1DzrVjJBBtrNZWJLxFccxfYkgX9Hs1ZXXMn8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A410CFE8F4A824DB56570551150AF15@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a94e58-a8c2-431f-2116-08d69cd3ed9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:52:15.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1406
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:36:25PM +0800, zerons wrote:
> In bpf/syscall.c, map_create() first set map->usercnt to 1, a file descri=
ptor is
> supposed to return to userspace. When bpf_map_new_fd() fails, drop the re=
fcount.
Thanks for the patch.

Please add a Fixes tag for bug fix in the future.

Fixes: bd5f5f4ecb78 ("bpf: Add BPF_MAP_GET_FD_BY_ID")
Acked-by: Martin KaFai Lau <kafai@fb.com>
