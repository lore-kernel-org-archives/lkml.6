Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4DB2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZHp0VNAq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Mav3XKjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4DB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389639AbeKTEH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:07:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47454 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388182AbeKTEH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:07:29 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAJHdC05003516;
        Mon, 19 Nov 2018 09:42:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0GH69XRohz9tDKf3ZKzTGh11HkwB0aZ27psb4gvcZD8=;
 b=ZHp0VNAqUARrnkgKqV1Bbgpx+3UPxw4oDDq76mQvL6LHpbHjSOS4xNfvbFw34/p4Yyjt
 JMZjF9RkfE4W0jClhZI72lM5iTmq6mWX5p/mfYUTS6zRyKv4gpt99NJ3dCyRrig53IdC
 cauounKoscAbUYYlX/UFoYJ8QMAXfTkBVKo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nv1bdr3jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Nov 2018 09:42:53 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 19 Nov 2018 09:42:52 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 19 Nov 2018 09:42:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GH69XRohz9tDKf3ZKzTGh11HkwB0aZ27psb4gvcZD8=;
 b=Mav3XKjrZa4nDgjupgahMoRFnACn43LCyEt3yDQpynoDTR7zn3wKhyhKTWlzoNVeQLXsUkidFef+3F8uDECayC9YVpiqk1Z3gl3NuElkJcx9T/av0gtf01Old5O/isEwVrCJ3Rb8a8IraWaYUHPo1iZeE05dn2EfG8wKqiD7+mc=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0902.namprd15.prod.outlook.com (10.164.171.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Mon, 19 Nov 2018 17:42:48 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6%3]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 17:42:48 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] cgroup: document cgroup v2 freezer interface
Thread-Topic: [PATCH v3 7/7] cgroup: document cgroup v2 freezer interface
Thread-Index: AQHUfg3osi2+SpTKhEuptY/JKLcjIqVTm6gAgAPGyQA=
Date:   Mon, 19 Nov 2018 17:42:48 +0000
Message-ID: <20181119174241.GA7273@tower.DHCP.thefacebook.com>
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-8-guro@fb.com> <20181117080227.GA22672@rapoport-lnx>
In-Reply-To: <20181117080227.GA22672@rapoport-lnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:301:15::14) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:5c93]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0902;20:eT0t4dBO3PrMEgThCSp1hKLdn5KbEXIqZzDl8OSpP66igO1nm1PqYKBjFPDa5wAs20S7kPByJio+o6g+/NVyPXwsopQBTZNYB2ufY24ad1c3cwGg33SEJWZVLhSuHcAIUWS5KB8Wmo1ms115TIdvnwmwlTGSU2zF8ipS0l9I9rs=
x-ms-office365-filtering-correlation-id: b8ed28e2-54d5-4a66-4109-08d64e466bef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0902;
x-ms-traffictypediagnostic: BY2PR15MB0902:
x-microsoft-antispam-prvs: <BY2PR15MB0902284622D823060B6720C2BED80@BY2PR15MB0902.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231415)(11241501184)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0902;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0902;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39860400002)(189003)(199004)(51914003)(54906003)(97736004)(486006)(14454004)(6512007)(9686003)(53936002)(86362001)(575784001)(68736007)(33656002)(11346002)(71200400001)(71190400001)(6916009)(446003)(229853002)(476003)(256004)(14444005)(76176011)(6486002)(6436002)(7736002)(478600001)(5660300001)(6246003)(2906002)(46003)(52116002)(99286004)(386003)(305945005)(102836004)(33896004)(6506007)(316002)(8936002)(4326008)(81166006)(81156014)(2900100001)(8676002)(186003)(106356001)(105586002)(6116002)(25786009)(1076002)(39060400002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0902;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1B9iGRq8Mqc4usF1oh06GUZWBGLwSokS8Dq3iEtFtaxhsjuUBzm5WhB4djb4XTPAM0aInEuQXK1/BVX1yH5QrS6WFuA6sixpuSxbV6wXLVTCI4Mc55KAJpqyVtqde+QUo9R0uiZAq2BWBPxSAeWjB+eROfPeNGjrVFxpLpa9pVXCTL6ynaf7q3H00G1LLgbLPIdqs9SORo+HJmmgJIpelRzuT7YQikz1ZTdTIF68bawObUqRh5g6HNAjeWQiIwy4B4KP1ptqvrCiegVLjWxdVNbTbj0Rk967x3BnQXi4mX7rDmqUkvvv5Cz0MALJj0vrB14cS0cfWSNrVmdbRIna4RPP6zwiuT+mIZ+STOz83Z8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E0C6B5BD81F3242BFB23BFB36F079BD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ed28e2-54d5-4a66-4109-08d64e466bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 17:42:48.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0902
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 12:02:28AM -0800, Mike Rapoport wrote:
> Hi,
>=20
> On Fri, Nov 16, 2018 at 04:38:30PM -0800, Roman Gushchin wrote:
> > Describe cgroup v2 freezer interface in the cgroup v2 admin guide.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: linux-doc@vger.kernel.org
> > Cc: kernel-team@fb.com
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 26 +++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 184193bcb262..a065c0bed88c 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -862,6 +862,8 @@ All cgroup core files are prefixed with "cgroup."
> >  	  populated
> >  		1 if the cgroup or its descendants contains any live
> >  		processes; otherwise, 0.
> > +	  frozen
> > +		1 if the cgroup is frozen; otherwise, 0.
> >=20
> >    cgroup.max.descendants
> >  	A read-write single value files.  The default is "max".
> > @@ -895,6 +897,30 @@ All cgroup core files are prefixed with "cgroup."
> >  		A dying cgroup can consume system resources not exceeding
> >  		limits, which were active at the moment of cgroup deletion.
> >=20
> > +  cgroup.freeze
> > +	A read-write single value file which exists on non-root cgroups.
> > +	Allowed values are "0" and "1". The default is "0".
> > +
> > +	Writing "1" to the file causes freezing of the cgroup and all
> > +	descendant cgroups. This means that all belonging processes will
> > +	be stopped and will not run until the cgroup will be explicitly
> > +	unfrozen. Freezing of the cgroup may take some time; when the process
>=20
> "when the process is complete" sounds somewhat ambiguous, it's unclear
> whether freezing is complete or the process that's being frozen is
> complete.
>=20
> Maybe "when this action is completed"?
>=20
> > +	is complete, the "frozen" value in the cgroup.events control file
> > +	will be updated and the corresponding notification will be issued.
>=20
> Can you please clarify how exactly cgroup.events would be updated?
>=20
> > +	Cgroup can be frozen either by its own settings, either by settings
>=20
>       ^ A cgroup ... and maybe there are more "a" and "the" that should b=
e
> fixed, it's hard for me to tell.
>=20
> Also, I believe "either ..., or ..." sounds better than "either ...,
> either ..."
>=20
> > +	of any ancestor cgroups. If any of ancestor cgroups is frozen, the
> > +	cgroup will remain frozen.
> > +
> > +	Processes in the frozen cgroup can be killed by a fatal signal.
> > +	They also can enter and leave a frozen cgroup: either by an explicit
> > +	move by a user, either if freezing of the cgroup races with fork().
>=20
> ditto
>=20
> > +	If a cgroup is moved to a frozen cgroup, it stops. If a process is
>=20
>             ^ process?
>=20
> > +	moving out of a frozen cgroup, it becomes running.
>=20
>        ^ moved

Hello, Mike!

Thanks for the review! I agree with all comments above; fixes queued for v4=
.

>=20
> > +	Frozen status of a cgroup doesn't affect any cgroup tree operations:
> > +	it's possible to delete a frozen (and empty) cgroup, as well as
> > +	create new sub-cgroups.
>=20
> Maybe it's also worth adding that freezing a process has no effect on its
> memory consumption, at least directly.

Hm, isn't it the expected behavior?

In any case, I assume that cgroup.freeze knob description is not the best p=
lace
for a such explanations. Maybe it's better to add a standalone paragraph wi=
th
the description of the frozen process state, what's expected to work, what'=
s
not, etc. I'd return to this question a bit later, when we'll agree on the =
user
interface and the implementation.

Thanks!
