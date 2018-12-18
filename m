Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C931C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C077C21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rWPvZC9N";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ew/yEjb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeLRU1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:27:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbeLRU1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:27:31 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBIKPUgA022141;
        Tue, 18 Dec 2018 12:27:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XEy3tvj3ZOieOBrka54F1q8VdxyLqmFVK1Dvngj0DtU=;
 b=rWPvZC9NSTnPQoo60EKrofnNAnA4ql9rlDe14L4wVRhtAaQ+beAbXGsyXS70q7KAK+Vx
 FicbjCgRIQQzhhfUIKABUZwrIiYQ+n8gq1PT+VAupLCruV+PoZlV/iY6Ri8RVvJ10tHP
 qg8eaPFXRtpTf7J8B3oV0tqjPSg9WqiVh5U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pf4ts0sjb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Dec 2018 12:27:23 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 18 Dec 2018 12:27:21 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 18 Dec 2018 12:27:21 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 18 Dec 2018 12:27:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEy3tvj3ZOieOBrka54F1q8VdxyLqmFVK1Dvngj0DtU=;
 b=ew/yEjb3ZxOQr462+oeuHVCRo9w2o2j1zkNd/Crl6hVt2vpb0gmR0EZSsjJz3zZBPecp6940qqavN/71Mg8THVJjWwM7lNriPRPY42lSqxr7uR/2mYrFjvzTFXyjLMJtEzSrJ/aNM59zMSTvp5d0ZQEE0GoONpWy3x/PH2kQh68=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB2937.namprd15.prod.outlook.com (20.178.230.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Tue, 18 Dec 2018 20:27:19 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::a9fb:37b7:baf8:f782]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::a9fb:37b7:baf8:f782%3]) with mapi id 15.20.1446.018; Tue, 18 Dec 2018
 20:27:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 4/7] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v5 4/7] cgroup: cgroup v2 freezer
Thread-Index: AQHUjmmlQwOP1yU/lEmjwwDF9MnbZKV5v7oA//+fV4CAAgoKAIAH1cgAgAGOAACAADZegA==
Date:   Tue, 18 Dec 2018 20:27:19 +0000
Message-ID: <20181218202701.GA12730@castle.DHCP.thefacebook.com>
References: <20181207201531.1665-1-guro@fb.com>
 <20181207201531.1665-5-guro@fb.com> <20181211162632.GB8504@redhat.com>
 <20181211184033.GA8971@tower.DHCP.thefacebook.com>
 <20181212174902.GA30309@redhat.com>
 <20181218012800.GA29563@tower.DHCP.thefacebook.com>
 <20181218171230.GA11319@redhat.com>
In-Reply-To: <20181218171230.GA11319@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0048.namprd22.prod.outlook.com
 (2603:10b6:300:69::34) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:7a48]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR15MB2937;20:jL8cCmBqvX0cKzxMThMHNf+b6xxW5yY/DfzdlxbHFKrySKSCLWnpx3Jl4JzKDR44I1I2INzZNU5EThcHxheETP4TleUGzYrlsvysmxIi8RRk3MNp9jfZVtfhIRfZsH62GHmp3Bzjir9MudNf5OspNLEQ8GH/4DMuWdobJb1t7HQ=
x-ms-office365-filtering-correlation-id: 14e5c35e-a358-4ea3-b61d-08d66527353a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2937;
x-ms-traffictypediagnostic: DM6PR15MB2937:
x-microsoft-antispam-prvs: <DM6PR15MB29379F66DAB6BDC1019036D9BEBD0@DM6PR15MB2937.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR15MB2937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2937;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(86362001)(97736004)(106356001)(105586002)(6116002)(14454004)(6246003)(53936002)(33656002)(39060400002)(478600001)(25786009)(4326008)(102836004)(76176011)(256004)(6512007)(9686003)(93886005)(11346002)(476003)(486006)(68736007)(52116002)(6506007)(386003)(446003)(6916009)(81156014)(8676002)(6436002)(33896004)(186003)(46003)(305945005)(5660300001)(54906003)(316002)(6486002)(7736002)(99286004)(81166006)(8936002)(14444005)(71200400001)(1076003)(2906002)(229853002)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2937;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9ybc7RB9lHmEJi9STMERBTroVhnOQkEo0Q9WYuapUHcHWktAx9PFE8yHM37km8EYCXM6CDRHDQawDgE1Rsx48SVUkWEHxzpqO77v0cuJNOBem4hfxgBgalBxTLnAs0UHVizpKtLzA7ivWLwRQMu8yQsbmLicjYfYz54Dyjfl2Pkv0LI3bFlL7W0QSrmMG08a1jlbNN+10YV1R13V+V9oyzzGsuK5bhzlU9RoBzrAnP54xLtlYWUFHKop4o04mCsLV91mx0FuI/5v3/Waa5Vi0CmmtiqIpG1wiueZq7mGOs69wcg0DzGw2cMvEmigtma1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FC50AD7A466F54C8135E833F88C1930@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e5c35e-a358-4ea3-b61d-08d66527353a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 20:27:19.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2937
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:12:30PM +0100, Oleg Nesterov wrote:
> On 12/18, Roman Gushchin wrote:
> >
> > On Wed, Dec 12, 2018 at 06:49:02PM +0100, Oleg Nesterov wrote:
> > > > > and btw.... what about suspend? try_to_freeze_tasks() will obviou=
sly fail
> > > > > if there is a ->frozen thread?
> > > >
> > > > I have to think a bit more here, but something like this will proba=
bly work:
> > > >
> > > > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > > > index b162b74611e4..590ac4d10b02 100644
> > > > --- a/kernel/freezer.c
> > > > +++ b/kernel/freezer.c
> > > > @@ -134,7 +134,7 @@ bool freeze_task(struct task_struct *p)
> > > >                 return false;
> > > >
> > > >         spin_lock_irqsave(&freezer_lock, flags);
> > > > -       if (!freezing(p) || frozen(p)) {
> > > > +       if (!freezing(p) || frozen(p) || cgroup_task_frozen()) {
> > > >                 spin_unlock_irqrestore(&freezer_lock, flags);
> > > >                 return false;
> > > >         }
> > > >
> > > > --
> > > >
> > > > If the task is already frozen by the cgroup freezer, we don't have =
to do
> > > > anything additionally.
> > >
> > > I don't think so. A cgroup_task_frozen() task can be killed after
> > > try_to_freeze_tasks() succeeds, and the exiting task can close files,
> > > do IO, etc. Or it can be thawed by cgroup_freeze_task(false).
> > >
> > > In short, if try_to_freeze_tasks() succeeds, the caller has all right=
s
> > > to assume that nobody can escape from __refrigerator().
> >
> > But this is what we do with stopped and ptraced tasks, isn't it?
>=20
> No,
>=20
> > We do use freezable_schedule() and the system freezer just ignores such=
 tasks.
>=20
> 	static inline void freezable_schedule(void)
> 	{
> 		freezer_do_not_count();
> 		schedule();
> 		freezer_count();
> 	}
>=20
> and note that freezer_count() calls try_to_freeze().
>=20
> IOW, the task sleeping in freezable_schedule() doesn't really differ from=
 the
> task sleeping in __refrigerator(). It is not that "the system freezer jus=
t
> ignores such tasks", it ignores them because it can safely count them as =
frozen.

Right, so the task is sleeping peacefully, and we know, that it won't get
anywhere, because we'll catch it in freezer_count(). We allow it to sleep
there, we don't force it to __refrigerator(), and we treat it as frozen.

How's that different to cgroup v2 freezer? If the task is frozen by cgroup =
v2
freezer, let it sleep there, and catch if it tries to escape. Exactly as it
works for SIGSTOP.

Am I missing something?

>=20
> > > And what about TASK_STOPPED/TASK_TRACED tasks? They can not be frozen
> > > or thawed, right? This doesn't look good, and this differs from the
> > > current freezer controller...
> >
> > Good question!
> >
> > It looks like cgroup v1 freezer just ignores them treating as already f=
rozen,
> > which doesn't look nice.
>=20
> Not sure I understand you, but see above... cgroup v1 freezer looks fine =
wrt
> stopped/traced tasks.

So, you think that v2 freezer should follow the same approach, and allow ta=
sks
sleeping on SIGSTOP, for instance, to be treated as frozen?
Hm, maybe. I have to think more here.

Thank you!
