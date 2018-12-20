Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A42C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A118021903
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NqjK4j+Y";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HLY04jtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbeLTVoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:44:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732606AbeLTVoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:44:10 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBKLgsal002567;
        Thu, 20 Dec 2018 13:43:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0YXgXI7mcWc33l9vb73uIL6NxcZpO2O+MM8onuB+MHU=;
 b=NqjK4j+YyK8rkmDQ3gQnjRI34H5if3lCb1iEintr/diCawadDcjXPn4ZVLlS2H1FvZf1
 llW4yA90exHktqG8JdWO1RABwMYtF8sccA45SdSqhVk0dIIuBGV5h+SPi1avEQYK5oEb
 gqXSbElDWeeJ9TmPJTHQVax86Q/AfehSV1k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pgjfkg5kd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Dec 2018 13:43:59 -0800
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 20 Dec 2018 13:43:52 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 20 Dec 2018 13:43:52 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 20 Dec 2018 13:43:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YXgXI7mcWc33l9vb73uIL6NxcZpO2O+MM8onuB+MHU=;
 b=HLY04jtHPGqBSSNS2ZWxSEDCLZqhFcS0E8cZuKnztwh5oStdcI43P7nUe49oyHWqgjwB9YE6wvulFW2yxznu7oxgkzkzq2hqpfeJrsPSU14BXGX/c9PucXv8d4BwffO3St89yQbAGN5L0BbkaPRAYro1iuWhGAkDXaB4N9O7BW0=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0726.namprd15.prod.outlook.com (10.164.170.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Thu, 20 Dec 2018 21:43:48 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::c8f6:7d5:273:202c]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::c8f6:7d5:273:202c%2]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 21:43:47 +0000
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
Thread-Index: AQHUjmmlQwOP1yU/lEmjwwDF9MnbZKV5v7oA//+fV4CAAgoKAIAH1cgAgAGOAAD//7BBAIADZNsAgABbVAA=
Date:   Thu, 20 Dec 2018 21:43:47 +0000
Message-ID: <20181220214338.GA16795@tower.DHCP.thefacebook.com>
References: <20181207201531.1665-1-guro@fb.com>
 <20181207201531.1665-5-guro@fb.com> <20181211162632.GB8504@redhat.com>
 <20181211184033.GA8971@tower.DHCP.thefacebook.com>
 <20181212174902.GA30309@redhat.com>
 <20181218012800.GA29563@tower.DHCP.thefacebook.com>
 <20181218171230.GA11319@redhat.com>
 <20181218202701.GA12730@castle.DHCP.thefacebook.com>
 <20181220161649.GA31865@redhat.com>
In-Reply-To: <20181220161649.GA31865@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0024.namprd20.prod.outlook.com
 (2603:10b6:301:15::34) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:3f27]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0726;20:98gLUzcFeG92eax0FxpgFIu6e5MDo75bF3/RpPT8qwvi5h10iVbh3f/cyLXMmlAmLMl626K+dQ2MNjmrsv4f6X3LxSy3XCI1VER+EbEsWOlk42xMBGQfsDdPNVZccOCm37OAbYCu2vtp4o3GgsBts1r9bjG0VzP5WQHdZXNzzuU=
x-ms-office365-filtering-correlation-id: 217ae9ab-3d3d-4ffd-8741-08d666c4387e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0726;
x-ms-traffictypediagnostic: BY2PR15MB0726:
x-microsoft-antispam-prvs: <BY2PR15MB07268F4B1822C011C9B37AE8BEBF0@BY2PR15MB0726.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(5005026)(6040522)(2401047)(8121501046)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0726;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0726;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(71190400001)(25786009)(71200400001)(33896004)(316002)(76176011)(6116002)(386003)(6506007)(11346002)(446003)(6916009)(14444005)(33656002)(486006)(256004)(1076003)(99286004)(102836004)(14454004)(97736004)(7736002)(186003)(81156014)(6246003)(105586002)(6486002)(476003)(8676002)(81166006)(93886005)(8936002)(2906002)(53936002)(9686003)(6512007)(5660300001)(106356001)(52116002)(46003)(4326008)(478600001)(68736007)(54906003)(6436002)(39060400002)(86362001)(229853002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0726;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mKkoyCQY6UX7jlorALmssv9oea9Tz6yO4PveCyopL3xp5q8aWY8qF/Jj9RMrfa4K4SqM1PJ14QOT3ud0WgZf9a3jHNPuGTyo5Y3nJOBkrDgOxWSloNLOvPWCF3VqT53mnDgIbnR7Tx9s1G1Y781am1Atxm9Db88lhjtPeqy5yXQCRLY/NwJ+AHWNpgEjsXXuIQQ3G6zV7v8yRFJ3GkqNsKME8y439NfWm3jBP98y5EvF7hqyOpqTx4/2yAXDakexIxj+zyshiJh6v8wYTVLZVNyD81KViXs1c781HoIiRuzVinY+T/q+FhrK6HCQjTtf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <833EAB85961EEC41B965B6416EA86CDC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 217ae9ab-3d3d-4ffd-8741-08d666c4387e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 21:43:47.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0726
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:16:50PM +0100, Oleg Nesterov wrote:
> On 12/18, Roman Gushchin wrote:
> >
> > > > > > --- a/kernel/freezer.c
> > > > > > +++ b/kernel/freezer.c
> > > > > > @@ -134,7 +134,7 @@ bool freeze_task(struct task_struct *p)
> > > > > >                 return false;
> > > > > >
> > > > > >         spin_lock_irqsave(&freezer_lock, flags);
> > > > > > -       if (!freezing(p) || frozen(p)) {
> > > > > > +       if (!freezing(p) || frozen(p) || cgroup_task_frozen()) =
{
> > > > > >                 spin_unlock_irqrestore(&freezer_lock, flags);
> > > > > >                 return false;
> > > > > >         }
> > > > > >
> > > > > > --
> > > > > >
> > > > > > If the task is already frozen by the cgroup freezer, we don't h=
ave to do
> > > > > > anything additionally.
> > > > >
> > > > > I don't think so. A cgroup_task_frozen() task can be killed after
> > > > > try_to_freeze_tasks() succeeds, and the exiting task can close fi=
les,
> > > > > do IO, etc. Or it can be thawed by cgroup_freeze_task(false).
> > > > >
> > > > > In short, if try_to_freeze_tasks() succeeds, the caller has all r=
ights
> > > > > to assume that nobody can escape from __refrigerator().
> > > >
> > > > But this is what we do with stopped and ptraced tasks, isn't it?
> > >
> > > No,
> > >
> > > > We do use freezable_schedule() and the system freezer just ignores =
such tasks.
> > >
> > > 	static inline void freezable_schedule(void)
> > > 	{
> > > 		freezer_do_not_count();
> > > 		schedule();
> > > 		freezer_count();
> > > 	}
> > >
> > > and note that freezer_count() calls try_to_freeze().
> > >
> > > IOW, the task sleeping in freezable_schedule() doesn't really differ =
from the
> > > task sleeping in __refrigerator(). It is not that "the system freezer=
 just
> > > ignores such tasks", it ignores them because it can safely count them=
 as frozen.
> >
> > Right, so the task is sleeping peacefully, and we know, that it won't g=
et
> > anywhere, because we'll catch it in freezer_count(). We allow it to sle=
ep
> > there, we don't force it to __refrigerator(), and we treat it as frozen=
.
> >
> > How's that different to cgroup v2 freezer? If the task is frozen by cgr=
oup v2
> > freezer, let it sleep there, and catch if it tries to escape. Exactly a=
s it
> > works for SIGSTOP.
> >
> > Am I missing something?
>=20
> Roman, perhaps we misunderstood each other...
>=20
> I still think that the cgroup_task_frozen() check in freeze_task() you pr=
oposed
> a) is not right, and b) it is not what we do with the STOPPED/TRACED task=
s which
> call freezable_schedule(). This is what I tried to say.
>=20
> If you meant that freezer v2 can too use freezable_schedule() - I agree.

Sorry for the confusion. Yeah, what I'm saying, is that freezable_schedule(=
)
will work for v2 as well.

>=20
> > So, you think that v2 freezer should follow the same approach, and allo=
w tasks
> > sleeping on SIGSTOP, for instance, to be treated as frozen?
> > Hm, maybe. I have to think more here.
>=20
> I think this would be nice. Otherwise, say, CGRP_FREEZE can be never repo=
rted
> if I read this code correctly. And this looks "symmetrical" with the fact=
 that
> a ->frozen task reacts to SIGSTOP and it is still treated as frozen after=
 that.

Yeah, looks so. I'll try to implement this in v6.

Thanks!
