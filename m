Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF966C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EDF218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O5Uc0SHv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="d0ZbJS9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfAaS56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:57:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47696 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728423AbfAaS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:57:20 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VIge19022537;
        Thu, 31 Jan 2019 10:57:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cke/T9d/Uqfv5dx0aSJXNdu8ya9pwW2jwTIkpWzXXZU=;
 b=O5Uc0SHvIkVCmegJ0/MppVPr64SqAV9IkI2rYnMOb6PM1DxdYGefrumN9P1mTvxD0uUU
 Gzs+QATRJA7FtyEbr89ZPllUAvH1OrrEHreBc488756qkH6XrggNtGvGNP5NP/y8i0uP
 aL2rmirHn4EdDZ5MQOZLkxXg/2CUPwCxnAA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qc60v06kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 31 Jan 2019 10:57:12 -0800
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 31 Jan 2019 10:57:12 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 31 Jan 2019 10:57:11 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 31 Jan 2019 10:57:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cke/T9d/Uqfv5dx0aSJXNdu8ya9pwW2jwTIkpWzXXZU=;
 b=d0ZbJS9vNRBemCwwAXbmXnHmN8dG+lbbmkqUua7dr3FTVo4tnd+xtvHbwfQYgmkiewji6j30xj0fot6PAOyYE44c5q6XMW/ShYqbYvR1bAR6NqhPHkhbPNHs7DYBEsU33kS66igAqJ3Qd02gs2VVuz7+xG7xUi8xFJx7w18GOzg=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2469.namprd15.prod.outlook.com (52.135.200.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.22; Thu, 31 Jan 2019 18:57:10 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 18:57:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached
 pages"
Thread-Topic: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached
 pages"
Thread-Index: AQHUuFKyWLaITMbS90mKhttYYyCJLqXHu+eAgADdi4CAAH9ygIAAo/qA
Date:   Thu, 31 Jan 2019 18:57:10 +0000
Message-ID: <20190131185704.GA8755@castle.DHCP.thefacebook.com>
References: <20190130041707.27750-1-david@fromorbit.com>
 <20190130041707.27750-2-david@fromorbit.com>
 <25EAF93D-BC63-4409-AF21-F45B2DDF5D66@fb.com> <20190131013403.GI4205@dastard>
 <20190131091011.GP18811@dhcp22.suse.cz>
In-Reply-To: <20190131091011.GP18811@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:104:3::11) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:759f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2469;20:PLZPhlFnUp8oGJMVqXlFmt4bjAg8aNpn9M6D9iXai9lOY2nu7MBvBiQd98rinXRxd6I1pGMt/L0Mag+xXpUkiVqGMLObKjee8K8i3DoMAGDNUK+aAi8PexxnkVMMLhU8QPJFpDbyZi0kh9xDjMQ60DxEffGJYVWWbVpCWzFdWyM=
x-ms-office365-filtering-correlation-id: eb8b7e68-0957-4be1-cfa5-08d687ade77b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2469;
x-ms-traffictypediagnostic: BYAPR15MB2469:
x-microsoft-antispam-prvs: <BYAPR15MB24690F57158304E6CE436798BE910@BYAPR15MB2469.namprd15.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(51444003)(68736007)(53546011)(386003)(54906003)(76176011)(316002)(478600001)(966005)(81166006)(8676002)(102836004)(46003)(81156014)(99286004)(33896004)(6506007)(52116002)(33656002)(86362001)(305945005)(6116002)(14454004)(5024004)(11346002)(446003)(486006)(476003)(7736002)(4326008)(1076003)(53936002)(6306002)(39060400002)(71190400001)(105586002)(6916009)(93886005)(71200400001)(229853002)(6246003)(25786009)(2906002)(106356001)(8936002)(256004)(97736004)(186003)(6486002)(6436002)(9686003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2469;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7ukCcWW89t+lxrN4WnmxAD+lkCjVulP1A1aX1rA5U5HPQOdTyCzoZWFJxKKjAGsfmf94YAMko9SF0Ma4srXWE/rxv6MXXdKOpSWZpMYx7+BjZzMAwGfVkh+1QP7/3cP3cgVaAdiqfnSRhSgld3c0pRpKGFrKotJygp3jCjklryoFFJLTDaWiS6I04GUnVNevTcPSi2RnQCE3LbCe8AzzoxGX8fVqLx0BvNrwEsAh5dQSsJC+AMzpHHWWaWFlEqeNbBTYMSYQ3c72JOWT452Axn6UDsP0DISh49bUmB06grdgNm5HATZkmfbW6Sk5U+lH3WH29SRnMILsHM031KmO+uMyn8L0jl5djj7mJ0939U7yDugD90aQyvIZNC5BAoSMuIMUFRGp3U3/83eHm/9QERdlMXRXFkJjQyNywP4/5vk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E840709697C48B40B7F55D8803373219@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8b7e68-0957-4be1-cfa5-08d687ade77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 18:57:09.3960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2469
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 10:10:11AM +0100, Michal Hocko wrote:
> On Thu 31-01-19 12:34:03, Dave Chinner wrote:
> > On Wed, Jan 30, 2019 at 12:21:07PM +0000, Chris Mason wrote:
> > >=20
> > >=20
> > > On 29 Jan 2019, at 23:17, Dave Chinner wrote:
> > >=20
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > >
> > > > This reverts commit a76cf1a474d7dbcd9336b5f5afb0162baa142cf0.
> > > >
> > > > This change causes serious changes to page cache and inode cache
> > > > behaviour and balance, resulting in major performance regressions
> > > > when combining worklaods such as large file copies and kernel
> > > > compiles.
> > > >
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D202441
> > >=20
> > > I'm a little confused by the latest comment in the bz:
> > >=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D202441#c24
> >=20
> > Which says the first patch that changed the shrinker behaviour is
> > the underlying cause of the regression.
> >=20
> > > Are these reverts sufficient?
> >=20
> > I think so.
> >=20
> > > Roman beat me to suggesting Rik's followup.  We hit a different probl=
em=20
> > > in prod with small slabs, and have a lot of instrumentation on Rik's=
=20
> > > code helping.
> >=20
> > I think that's just another nasty, expedient hack that doesn't solve
> > the underlying problem. Solving the underlying problem does not
> > require changing core reclaim algorithms and upsetting a page
> > reclaim/shrinker balance that has been stable and worked well for
> > just about everyone for years.
>=20
> I tend to agree with Dave here. Slab pressure balancing is quite subtle
> and easy to get wrong. If we want to plug the problem with offline
> memcgs then the fix should be targeted at that problem. So maybe we want
> to emulate high pressure on offline memcgs only. There might be other
> issues to resolve for small caches but let's start with something more
> targeted first please.

First, the path proposed by Dave is not regression-safe too. A slab object
can be used by other cgroups as well, so creating an artificial pressure on
the dying cgroup might perfectly affect the rest of the system. We do repar=
ent
slab lists on offlining, so there is even no easy way to iterate over them.
Also, creating an artifical pressure will create unnecessary CPU load.

So I'd really prefer to make the "natural" memory pressure to be applied
in a way, that doesn't leave any stalled objects behind.

Second, the code around slab pressure is not "worked well for years": as I =
can
see the latest major change was made about a year ago by Josef Bacik
(9092c71bb724 "mm: use sc->priority for slab shrink targets").

The existing balance, even if it works perfectly for some cases, isn't some=
thing
set in stone. We're really under-scanning small cgroups, and I strongly bel=
ieve
that what Rik is proposing is a right thing to do. If we don't scan objects
in small cgroups unless we have really strong memory pressure, we're basica=
lly
wasting memory.

And it really makes no sense to reclaim inodes with tons of attached pageca=
che
as easy as "empty" inodes. At the end, all we need is to free some memory, =
and
treating a sub-page object equal to many thousands page object is just stra=
nge.
If it's simple "wrong" and I do miss something, please, explain. Maybe we n=
eed
something more complicated than in my patch, but saying that existing code =
is
just perfect and can't be touched at all makes no sense to me.

So, assuming all this, can we, please, first check if Rik's patch is addres=
sing
the regression?

Thanks!
