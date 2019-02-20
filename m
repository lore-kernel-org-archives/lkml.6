Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B96AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBD820859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RyYN8mIQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gfzc4FcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfBTWPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:15:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56476 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfBTWPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:15:45 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KM5rtu025855;
        Wed, 20 Feb 2019 14:15:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vRyGtMiV4S9uZ2jSO/FhO78PpFAG+X+zUg/RwBzRnQQ=;
 b=RyYN8mIQeQI/lqJf4sFTKZUqlT9kfQQcf6+c/9a896T4R5tCjU5AxAc12NYLAho96FVV
 3CwbkOVtoaIFT8dWN5qt+VMTbR+ZLsvINPkWn+qHPgocI1bhZc7DlAl86TzyGwCdtkyC
 DEhT0FwD/IaJt/OSZgI5Z6hZDlP/oDVMQnQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qsec0g7vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 14:15:40 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 20 Feb 2019 14:14:47 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 20 Feb 2019 14:14:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRyGtMiV4S9uZ2jSO/FhO78PpFAG+X+zUg/RwBzRnQQ=;
 b=gfzc4FcFEY7JcwqjZR2gc3TU+bGeq5yThNgFNoDXwCgOLyh5TV5FgkKMQqrDaI8t5fak1vK13iUP1Vx21c1f73puzRoAxTzok9NPYfOhbmHVZj8r55rF/Fahc9Nk35UeB+UYwHlAar7zZdQLO0zKsBvc+Vc89hPVDIK4eRj1MsM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2693.namprd15.prod.outlook.com (20.179.156.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 20 Feb 2019 22:14:30 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1601.016; Wed, 20 Feb 2019
 22:14:30 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/7] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v8 4/7] cgroup: cgroup v2 freezer
Thread-Index: AQHUyJ7wg1JrQsLUIUOAg5ta/bqqW6Xow6MAgAB+ZwA=
Date:   Wed, 20 Feb 2019 22:14:29 +0000
Message-ID: <20190220221423.GA17163@castle.DHCP.thefacebook.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190219220252.4906-5-guro@fb.com> <20190220144202.GB9477@redhat.com>
In-Reply-To: <20190220144202.GB9477@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::31) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:6aef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22d92ab9-1f23-4e29-7dcb-08d69780c884
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2693;
x-ms-traffictypediagnostic: BYAPR15MB2693:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2693;20:YoOnJ4BW/UwIVOeSHg/GeDMExKAk74+bi8xMtg+Spu8TV7BbTLcEJu5J5yAB+8lzD1mvJ9Sl7YI7Xs4QfgoPucg1AN4Fetb13OnYAWUSttYb7TV24qs4J+ifyu6HjMEP4pydC9wjh/tZnCn9Yq1jzbJk6eNku0c9kaAX9o3RnfI=
x-microsoft-antispam-prvs: <BYAPR15MB2693372ECC9D6EE5C23F2BFABE7D0@BYAPR15MB2693.namprd15.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(376002)(366004)(346002)(189003)(199004)(6512007)(8936002)(53936002)(81166006)(305945005)(446003)(81156014)(256004)(4326008)(76176011)(6116002)(6916009)(52116002)(6246003)(97736004)(8676002)(7736002)(99286004)(14444005)(5660300002)(14454004)(229853002)(71200400001)(186003)(46003)(71190400001)(25786009)(9686003)(316002)(105586002)(102836004)(478600001)(106356001)(86362001)(2906002)(33896004)(68736007)(33656002)(6486002)(486006)(54906003)(1076003)(11346002)(476003)(386003)(6506007)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2693;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fa5B4rLI0W81dRptYKbZE0arS3eYVCwbz3rYMnC3a1QwYfXbGOzssUG2kApOIB/BWDsKmBfvUXPIjzKhW58MmYC9TMFqBbo+qmaoNL4OoamN9P4Jcy9oeyuZ3uZzYGzBDipbu8FHh8SCLeqZyRcn6H0isuYDv3f1CiTWp7Yf/szStXF3FYYcCOqmXTUgSvjihPAoiBmDo4TPRIwFBGE86vU8bBsix+7v7nXNKzoe4LvsDj+Enf05ikkbgQ4oeIP9p1gevIpGbbLGCbqIPbc9vLmfz7GAGSrR4upoqLAlkisUf15lbMd6xCVSLkhgBLfWCnwjkO1/tiGeBCUJBrA0DQaeDPIxM8YWWE35Vj/ldmsTfZQURHWD6Zx6SiiNEeQ6C0OedEIrnUiUNqYRtPbEnESHzmCGknzATL8XFdt16SU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <55A513311A1D57409936E10272BF1017@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d92ab9-1f23-4e29-7dcb-08d69780c884
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 22:14:29.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2693
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:42:02PM +0100, Oleg Nesterov wrote:
> On 02/19, Roman Gushchin wrote:
> >
> > @@ -2065,6 +2066,7 @@ static void ptrace_stop(int exit_code, int why, i=
nt clear_code, kernel_siginfo_t
> >  		preempt_disable();
> >  		read_unlock(&tasklist_lock);
> >  		preempt_enable_no_resched();
> > +		cgroup_enter_stopped();
> >  		freezable_schedule();
> >  	} else {
> >  		/*
> > @@ -2243,6 +2245,7 @@ static bool do_signal_stop(int signr)
> >  		}
> > =20
> >  		/* Now we don't run again until woken by SIGCONT or SIGKILL */
> > +		cgroup_enter_stopped();
> >  		freezable_schedule();
> >  		return true;
>=20
> Please see my reply to 0/7.

Answered in that thread.

>=20
> > @@ -2280,7 +2286,8 @@ static void do_jobctl_trap(void)
> >  		    !(signal->flags & SIGNAL_STOP_STOPPED))
> >  			signr =3D SIGTRAP;
> >  		WARN_ON_ONCE(!signr);
> > -		ptrace_do_notify(signr, signr | (PTRACE_EVENT_STOP << 8),
> > +		ptrace_do_notify(signr,
> > +				 signr | (PTRACE_EVENT_STOP << 8),
> >  				 CLD_STOPPED);
>=20
> white-space cleanup?

Sorry, a bogus change. Please, ignore it.

>=20
> > @@ -2363,7 +2419,8 @@ bool get_signal(struct ksignal *ksig)
> >  	 * we should notify the parent, prepare_signal(SIGCONT) encodes
> >  	 * the CLD_ si_code into SIGNAL_CLD_MASK bits.
> >  	 */
> > -	if (unlikely(signal->flags & SIGNAL_CLD_MASK)) {
> > +	if (unlikely(signal->flags & SIGNAL_CLD_MASK) &
> > +	    !(current->jobctl & JOBCTL_TRAP_FREEZE)) {
>=20
> Hmm, why?

If a process is going from the stopped to the frozen state, it looks like
it's better to delay parent's notification up to the moment when it will
actually run.

Thanks!
