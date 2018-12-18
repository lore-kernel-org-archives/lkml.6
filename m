Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E32C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28AE217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hepYaHzO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JsVQnX+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeLRB2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:28:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60628 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbeLRB2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:28:18 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBI1P8fe011693;
        Mon, 17 Dec 2018 17:28:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=i6kq1toTi6Y41x7q39A4sqXlgAtPkMKJQMjTBCP+N6Q=;
 b=hepYaHzORr2FDww3zU+VucCd/U1Fyfv2YJp3aPasZh0EBnz+IMZbs2WuDo69jZJBzetq
 QfZT7hUzbr74aPaPWiiGYaGbj5c6tFf4HGa4STRIorWRVeRuPMW39cl3KnJNav+pyHnf
 HHGQbu0KKClc09M0QpE/vNvdP9nhN+PXTcc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pen15gcx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Dec 2018 17:28:10 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 17 Dec 2018 17:28:08 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 17 Dec 2018 17:28:08 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 17 Dec 2018 17:28:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6kq1toTi6Y41x7q39A4sqXlgAtPkMKJQMjTBCP+N6Q=;
 b=JsVQnX+/mbdy1LJqzsRZlb9jInufmrZb8Mk1V3q/ABQEOHyqRZbDISNBeuyl0bsi+zv/3h+oO6GaJW/h5g6Cm5uN5hSE8+L9Y5AAMIUXVarXrT2Z+5GeKx8nDlOLyxdUT8cgPgiYY1dWYGfRtH9wFneLYbOaIG/oMc7M06BlgXg=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3381.namprd15.prod.outlook.com (20.179.59.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 18 Dec 2018 01:28:04 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5%3]) with mapi id 15.20.1425.021; Tue, 18 Dec 2018
 01:28:04 +0000
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
Thread-Index: AQHUjmmlQwOP1yU/lEmjwwDF9MnbZKV5v7oA//+fV4CAAgoKAIAIW+QA
Date:   Tue, 18 Dec 2018 01:28:04 +0000
Message-ID: <20181218012800.GA29563@tower.DHCP.thefacebook.com>
References: <20181207201531.1665-1-guro@fb.com>
 <20181207201531.1665-5-guro@fb.com> <20181211162632.GB8504@redhat.com>
 <20181211184033.GA8971@tower.DHCP.thefacebook.com>
 <20181212174902.GA30309@redhat.com>
In-Reply-To: <20181212174902.GA30309@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:301:2::12) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:5e5f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3381;20:mULJQ6BSOJL/wWxedCBAM7LOlto4/m46Eud1VIDpQ2mhwUJcztLjfvv8N2ZK2uQaIlGSH53McUaBcnk4YA/7LcoUHQUZlwRwBnIycOZsbIoxpz/Pp0IR5nd5E5mVmTaTQLKxLl3pqpfdLVwFvPjqn3njEkBI/KurYdSIk154ejw=
x-ms-office365-filtering-correlation-id: 4f3a6cf1-ff67-461b-f3cb-08d664880eab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3381;
x-ms-traffictypediagnostic: BYAPR15MB3381:
x-microsoft-antispam-prvs: <BYAPR15MB3381A4BACF44A4A703C0C40BBEBD0@BYAPR15MB3381.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB3381;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB3381;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(8936002)(68736007)(14444005)(33656002)(6512007)(33896004)(6916009)(5024004)(76176011)(305945005)(52116002)(9686003)(316002)(93886005)(1076003)(345774005)(25786009)(5660300001)(2906002)(99286004)(6436002)(446003)(6116002)(4326008)(386003)(229853002)(105586002)(71200400001)(39060400002)(186003)(7736002)(106356001)(46003)(86362001)(256004)(478600001)(6486002)(8676002)(476003)(14454004)(486006)(11346002)(54906003)(6246003)(53936002)(6506007)(81156014)(97736004)(102836004)(81166006)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3381;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jrJeq7RFga4owXLNyBOchelC7sMD9QyiUywG6H4sR69ZSRFcItUD7IgIMwcibZooPIWfQ4am8MLjHObyKvWbm/ETe3jo6KP9Ced/KFEkittfKbWfBa39XowNxCOMKNe2n/DDLUJsR+3bul3wrEyc3ENrckK+9mjPbK5f895lcxJaSuomOP9dLkIexd0laLyCWn/uocEpNr7irBNdUJQBj5NdGYyB5HlasMqEd9H7wOZ+CvOJql22tD28FkBXf+/c8i3CINXQfYbiqAIRqLByzl8CN/o62kV/GCoRXECWU4RMi4Qn1uPMKdJk0kkcFJWt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6CF8A95676590942A875E1FEB3ABDA1C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3a6cf1-ff67-461b-f3cb-08d664880eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 01:28:04.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3381
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:49:02PM +0100, Oleg Nesterov wrote:
> On 12/11, Roman Gushchin wrote:
> >
> > On Tue, Dec 11, 2018 at 05:26:32PM +0100, Oleg Nesterov wrote:
> > > On 12/07, Roman Gushchin wrote:
> > > >
> > > > Cgroup v2 freezer tries to put tasks into a state similar to jobctl
> > > > stop. This means that tasks can be killed, ptraced (using
> > > > PTRACE_SEIZE*), and interrupted. It is possible to attach to
> > > > a frozen task, get some information (e.g. read registers) and detac=
h.
> > >
> > > I fail to understand how this all supposed to work.
> > >
> > > > @@ -368,6 +369,8 @@ static inline int signal_pending_state(long sta=
te, struct task_struct *p)
> > > >  		return 0;
> > > >  	if (!signal_pending(p))
> > > >  		return 0;
> > > > +	if (unlikely(cgroup_task_frozen(p) && p->jobctl =3D=3D JOBCTL_TRA=
P_FREEZE))
> > > > +		return __fatal_signal_pending(p);
> > >
> > > I think I will never agree with this change ;) and I don't think it a=
ctually helps.
> >
> > See below.
> >
> > >
> > > > +void cgroup_enter_frozen(void)
> > > > +{
> > > > +	if (!current->frozen) {
> > > > +		spin_lock_irq(&css_set_lock);
> > > > +		current->frozen =3D true;
> > > > +		cgroup_inc_frozen_cnt(task_dfl_cgroup(current), false, true);
> > > > +		spin_unlock_irq(&css_set_lock);
> > > > +	}
> > > > +
> > > > +	__set_current_state(TASK_INTERRUPTIBLE);
> > > > +	schedule();
> > >
> > > So once again, suppose it races with PTRACE_INTERRUPT, or SIGSTOP, or=
 something
> > > else which should be handled by get_signal() before do_freezer_trap()=
.
> > >
> > > If (say) PTRACE_INTERRUPT comes before schedule it will be lost. Othe=
rwise
> > > the frozen task will react. This can't be right. Or I am totally conf=
used.
> >
> > Why?
> > PTRACE_INTERRUPT will set JOBCTL_TRAP_STOP, so signal_pending_state()
> > will return true, schedule() will return immediately, and we'll handle =
the trap.
>=20
> OK, I misread the JOBCTL_TRAP_FREEZE check as "jobctl & JOBCTL_TRAP_FREEZ=
E".
>=20
> But p->jobctl =3D=3D JOBCTL_TRAP_FREEZE doesn't look right too. For examp=
le,
> JOBCTL_STOP_DEQUEUED can be set. You probably need something like
>=20
> 	jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE) =3D=3D JOBCTL_TRAP_F=
REEZE
>=20
> And you need a barrier in between, iow you need set_current_state(TASK_IN=
TERRUPTIBLE).
>=20
> But this doesn't really matter. I don't think you need to modify signal_p=
ending_state()
> and penalize schedule(). You can do something like
>=20
> 	spin_lock_irq(sigllock);
> 	if (jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE) =3D=3D JOBCTL_TR=
AP_FREEZE &&
> 	    !__fatal_signal_pending())
> 	{
> 		__set_current_state(TASK_INTERRUPTIBLE);
> 		clear_thread_flag(TIF_SIGPENDING);
> 	}
> 	spin_unlock_irq(siglock);
>=20
> 	schedule();
> 	// recalc_sigpending() is not needed
>=20
> in cgroup_enter_frozen() with the same effect. Which looks equally ugly a=
nd
> suboptimal, but at least this doesn't touch the sched code.

Gotcha. Will follow this approach in v6.

>=20
> > > and btw.... what about suspend? try_to_freeze_tasks() will obviously =
fail
> > > if there is a ->frozen thread?
> >
> > I have to think a bit more here, but something like this will probably =
work:
> >
> > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > index b162b74611e4..590ac4d10b02 100644
> > --- a/kernel/freezer.c
> > +++ b/kernel/freezer.c
> > @@ -134,7 +134,7 @@ bool freeze_task(struct task_struct *p)
> >                 return false;
> >
> >         spin_lock_irqsave(&freezer_lock, flags);
> > -       if (!freezing(p) || frozen(p)) {
> > +       if (!freezing(p) || frozen(p) || cgroup_task_frozen()) {
> >                 spin_unlock_irqrestore(&freezer_lock, flags);
> >                 return false;
> >         }
> >
> > --
> >
> > If the task is already frozen by the cgroup freezer, we don't have to d=
o
> > anything additionally.
>=20
> I don't think so. A cgroup_task_frozen() task can be killed after
> try_to_freeze_tasks() succeeds, and the exiting task can close files,
> do IO, etc. Or it can be thawed by cgroup_freeze_task(false).
>=20
> In short, if try_to_freeze_tasks() succeeds, the caller has all rights
> to assume that nobody can escape from __refrigerator().

But this is what we do with stopped and ptraced tasks, isn't it?
We do use freezable_schedule() and the system freezer just ignores such tas=
ks.
I believe that cgroup v2 freezer should follow the same path.

>=20
> And what about TASK_STOPPED/TASK_TRACED tasks? They can not be frozen
> or thawed, right? This doesn't look good, and this differs from the
> current freezer controller...

Good question!

It looks like cgroup v1 freezer just ignores them treating as already froze=
n,
which doesn't look nice.

I'd say s/signal_wake_up(task, 0)/signal_wake_up(task, 1) in
cgroup_freeze_task() will do the job of moving them into the frozen state.
The question is how to get them back into the stopped state, if cgroup is
unfrozen. At this point there are no more signs, that the task has been
previously frozen. I've no better idea, than to introduce another
per-task bit/flag. If you have any better ideas, please, share.

Thank you for the review!
