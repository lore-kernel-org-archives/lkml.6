Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE33FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2542080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Srr7uVwG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ipH1mnCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2542080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJ3Git (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:38:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbeJ3Git (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:38:49 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9TLiGom025238;
        Mon, 29 Oct 2018 14:48:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ln4tMTVrcc8Lggtriyob2uW0BrxlRo6VzV/kdK8C6oA=;
 b=Srr7uVwGhlQqDRLrenvsDcVOxuUdLgb67OB1UDC3Daz2yBr42SyGw+Cuf1zpLMeGNW5p
 JrZ3DXtyNh2+PYflpdNZ6/jxhx282IQv37ErSAhzHGTOs92uCzxajhtJP1z7NwPS2KwY
 GvtKnC1pzFicVDoavrc/cJ/6R09dULkBiVQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ne6x78rbb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 29 Oct 2018 14:48:08 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 29 Oct 2018 14:48:01 -0700
Received: from FRC-CHUB14.TheFacebook.com (2620:10d:c021:18::33) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 29 Oct 2018 14:48:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 29 Oct 2018 17:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln4tMTVrcc8Lggtriyob2uW0BrxlRo6VzV/kdK8C6oA=;
 b=ipH1mnCQi/pN8HtLHf0/CDUl0KADSjFpSSLb0zLgIV7hE3hXSZZJUvQB3qglSMutstt+oAHi1B/RFxJR48Oqs0BbWVWvJndidv6fnbTFck0P3mCjkep/axROos7ZRQwYuSVnipojwTqjwr56qsCY8oQlGT50dFCCIIaWZLzbHyw=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0503.namprd15.prod.outlook.com (10.163.110.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Mon, 29 Oct 2018 21:47:58 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 21:47:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
Thread-Topic: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
Thread-Index: AQHUb0zSAmWtK7c9EUKkZgGOS7uZCqU2NcCAgAA2fwD//7FgAIAAjyUAgAAWuYA=
Date:   Mon, 29 Oct 2018 21:47:58 +0000
Message-ID: <20181029214750.GA13325@tower.DHCP.thefacebook.com>
References: <1540792855.22373.34.camel@gmx.de>
 <20181029132035.GI32673@dhcp22.suse.cz> <1540830938.10478.4.camel@gmx.de>
 <20181029185412.GA15760@tower.DHCP.thefacebook.com>
 <20181029202634.GQ32673@dhcp22.suse.cz>
In-Reply-To: <20181029202634.GQ32673@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:301:39::34) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:ad5c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0503;20:cTb+E2Gc/AlMd9/k5IpdcHUMqkJhJjEtYdumhOavaSXaNc9JVtRR7ar/kqA3XevgWTiboG2/JrPXyezkHNvd1E2cTbpi/S7Nsnvb017eX9F2mNibVLyR6ZAKvPLfDnVWadplE2cll7dG4DzE3DzGn7DpOCoQkuapGpTLg1oNab4=
x-ms-office365-filtering-correlation-id: 3c307177-7fe7-42af-eb51-08d63de830be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0503;
x-ms-traffictypediagnostic: BY2PR15MB0503:
x-microsoft-antispam-prvs: <BY2PR15MB05030AD35A271415FFDDF711BEF30@BY2PR15MB0503.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0503;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0503;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(52314003)(189003)(199004)(8676002)(14444005)(97736004)(4001150100001)(1076002)(6486002)(76176011)(6436002)(386003)(6506007)(33896004)(229853002)(33656002)(8936002)(53936002)(81156014)(6916009)(102836004)(6246003)(5250100002)(6512007)(39060400002)(9686003)(4326008)(256004)(2906002)(54906003)(71200400001)(71190400001)(478600001)(81166006)(93886005)(6116002)(316002)(25786009)(52116002)(11346002)(14454004)(7736002)(5660300001)(186003)(345774005)(46003)(486006)(2900100001)(305945005)(86362001)(476003)(575784001)(106356001)(105586002)(68736007)(99286004)(446003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0503;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 29yzQPq2O+wjw5N7nLJ6NPXc2zYrYH7Udh7bZb5ZlBhuaKaeWPOc1kmqDAUiRByCI6iFog5Uq/0ZtqJeKGRl777tanPUD3DjSrCP4FwneVE9hYXWcWc1c+xLmm15P8D1oi2rk2Xv9DHlHCUmzHDxJCb/jmzWcRyL+sICJhRCi2yaVC0levkuWoGQPv2EW5UxIx4EO1kqUhvmB58IlBWuJwpKiQgjfVH2BqiiMaAshPOnH3WcK1b7ee57KnOoRK3Bm4gF2MyR7hiAE1H5ccGTCDDGV5qlFRBFy6NFT9ZM6dKLXxmYkCk19P9EcJiVDvvYKuh4mAkkGh7RSkobLusP3KKi7K3iCPHf+BD4WkLGyJ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8A0BE3FDD0A9749992B0F819F80267B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c307177-7fe7-42af-eb51-08d63de830be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 21:47:58.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 09:26:34PM +0100, Michal Hocko wrote:
> On Mon 29-10-18 18:54:19, Roman Gushchin wrote:
> > On Mon, Oct 29, 2018 at 05:35:38PM +0100, Mike Galbraith wrote:
> > > On Mon, 2018-10-29 at 14:20 +0100, Michal Hocko wrote:
> > > >=20
> > > > > [    4.420976] Code: f3 c3 0f 1f 00 0f 1f 44 00 00 48 85 ff 0f 84=
 a8 00 00 00 41 56 48 89 f8 41 55 49 89 fe 41 54 49 89 d5 55 49 89 f4 53 48=
 89 f3 <f0> 48 0f c1 1f 48 01 f3 48 39 5f 18 48 89 fd 73 17 eb 41 48 89 e8
> > > > > [    4.424162] RSP: 0018:ffffb27840c57cb0 EFLAGS: 00010202
> > > > > [    4.425236] RAX: 00000000000000f8 RBX: 0000000000000020 RCX: 0=
000000000000200
> > > > > [    4.426467] RDX: ffffb27840c57d08 RSI: 0000000000000020 RDI: 0=
0000000000000f8
> > > > > [    4.427652] RBP: 0000000000000001 R08: 0000000000000000 R09: f=
fffb278410bc000
> > > > > [    4.428883] R10: ffffb27840c57ed0 R11: 0000000000000040 R12: 0=
000000000000020
> > > > > [    4.430168] R13: ffffb27840c57d08 R14: 00000000000000f8 R15: 0=
0000000006000c0
> > > > > [    4.431411] FS:  00007f79081a3940(0000) GS:ffff92a4b7bc0000(00=
00) knlGS:0000000000000000
> > > > > [    4.432748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [    4.433836] CR2: 00000000000000f8 CR3: 00000002310ac002 CR4: 0=
0000000001606e0
> > > > > [    4.435500] Call Trace:
> > > > > [    4.436319]  try_charge+0x92/0x7b0
> > > > > [    4.437284]  ? unlazy_walk+0x4c/0xb0
> > > > > [    4.438676]  ? terminate_walk+0x91/0x100
> > > > > [    4.439984]  memcg_kmem_charge_memcg+0x28/0x80
> > > > > [    4.441059]  memcg_kmem_charge+0x88/0x1d0
> > > > > [    4.442105]  copy_process.part.37+0x23a/0x2070
> > > >=20
> > > > Could you faddr2line this please?
> > >=20
> > > homer:/usr/local/src/kernel/linux-master # ./scripts/faddr2line vmlin=
ux copy_process.part.37+0x23a
> > > copy_process.part.37+0x23a/0x2070:
> > > memcg_charge_kernel_stack at kernel/fork.c:401
> > > (inlined by) dup_task_struct at kernel/fork.c:850
> > > (inlined by) copy_process at kernel/fork.c:1750
> > >=20
> > > I bisected it this afternoon, and confirmed the result via revert.
> > >=20
> > > 9b6f7e163cd0f468d1b9696b785659d3c27c8667 is the first bad commit
> > > commit 9b6f7e163cd0f468d1b9696b785659d3c27c8667
> > > Author: Roman Gushchin <guro@fb.com>
> > > Date:   Fri Oct 26 15:03:19 2018 -0700
> > >=20
> > >     mm: rework memcg kernel stack accounting
> >=20
> >=20
> > Hi Mike!
> >=20
> > Thank you for the report!
> >=20
> > Do you see it reliable every time you boot up the machine?
> > How do you run kvm? Is there something special about your cgroup setup?
> >=20
> > I've made several attempts to reproduce the issue, but haven't got anyt=
hing
> > so far. I've used your config, and played with different cgroups setups=
.
> >=20
> > Do you know where in the page_counter_try_charge() it fails?
> >=20
> > Also, can you, please, check if the following patch mitigates the probl=
em?
>=20
> It's been a long day so I might be completely wrong but it seems that
> the task_struct is not initialized yet so tsk->mm is a complete garbage.
> I guess you want to move charging down after arch_dup_task_struct.

We take the memcg pointer from current, not from the new task.
So it's not the problem.
Anyway, I've found the problem, will send the fix in few minutes.

Thanks!
