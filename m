Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E34C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2637820989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rqxXDOmU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LM3Rcg/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfA3F7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:59:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52952 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbfA3F7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:59:06 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0U5wLW1031484;
        Tue, 29 Jan 2019 21:58:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qacUTFCp+1uILO9XDTzOCUn5G1Ez43fF+ggbvaxfpVg=;
 b=rqxXDOmU5nTTc6tR2rcYS2wmc2Oziq5TVkOYOTpZKalREOawH+wUHTflvnfR9m+LztGn
 mvBXbZLSbEfqMXOoItFJNviyGv3BYJ03+QA62ew6bnrR+ceeQZHI1W40YfusYqamn5j0
 PDVtzKkczN+is5pyXm6Obk/vizm5/AcUEtg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qb0xugsnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Jan 2019 21:58:45 -0800
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 29 Jan 2019 21:58:45 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 29 Jan 2019 21:58:44 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 29 Jan 2019 21:58:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qacUTFCp+1uILO9XDTzOCUn5G1Ez43fF+ggbvaxfpVg=;
 b=LM3Rcg/s5mL/rxTq2YDI/L5U8Zd8ZjqXAjIMPxdHgCFTu9hxcdVS09GSfFBK8qbyngZ71FzNYYe6QWilT6fS5IksD6O1RC609chujGdiDfPEGyQdDmPJrmvQLoj6wbsyRQqp8jqrlncDw7qgJ8ROPk/6Km/wWSezZ4cmiIp2XLE=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2660.namprd15.prod.outlook.com (20.179.138.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 05:58:43 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::41b9:104d:e330:d12d]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::41b9:104d:e330:d12d%5]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 05:58:43 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Greg KH <greg@kroah.com>, Michal Hocko <mhocko@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Topic: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVc///mGwAgACTWwCAAFjogIAADIgAgAB8LwD//41GgIAAfX+A//+UKoCAAHungP//qWqAAI/9poAKbIt2AAZlvz8AAAuwAYA=
Date:   Wed, 30 Jan 2019 05:58:42 +0000
Message-ID: <20190130055834.GC2107@castle.DHCP.thefacebook.com>
References: <20181102154844.GA17619@tower.DHCP.thefacebook.com>
 <20181102161314.GF28039@dhcp22.suse.cz>
 <20181102162237.GB17619@tower.DHCP.thefacebook.com>
 <20181102165147.GG28039@dhcp22.suse.cz>
 <20181102172547.GA19042@tower.DHCP.thefacebook.com>
 <20181102174823.GI28039@dhcp22.suse.cz>
 <20181102193827.GA18024@castle.DHCP.thefacebook.com>
 <20181105092053.GC4361@dhcp22.suse.cz> <20181228105008.GB15967@kroah.com>
 <20190130002356.GQ3973@sasha-vm>
In-Reply-To: <20190130002356.GQ3973@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:a03:54::16) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:e58d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR15MB2660;20:ivn52B2lGg81h7huiwy5Fz4iBUhkMX6yrRwwyt3QtLEQ+bLBAvDqG9XxaYRnkI4K8MSR3Qc5c8DkqCpdpUGYwFLkpLgZWrAkF1SdWebkYVxS8RsMl65bUUie4rmxUcXYi4lUK5wdWNm6SphsM3J1FG1wYrIEzFxgwYRPKRxduAU=
x-ms-office365-filtering-correlation-id: f7714dc6-dc35-4041-d020-08d68677fd2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN8PR15MB2660;
x-ms-traffictypediagnostic: BN8PR15MB2660:
x-microsoft-antispam-prvs: <BN8PR15MB2660A0E7EFEB372ED93E3FE3BE900@BN8PR15MB2660.namprd15.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(93886005)(6436002)(33896004)(966005)(8936002)(11346002)(229853002)(14454004)(52116002)(102836004)(6486002)(33656002)(106356001)(6506007)(316002)(386003)(105586002)(6246003)(99286004)(54906003)(46003)(76176011)(86362001)(97736004)(53936002)(6306002)(9686003)(39060400002)(6512007)(186003)(81156014)(256004)(7416002)(25786009)(2906002)(5024004)(6116002)(446003)(1076003)(4326008)(305945005)(6916009)(478600001)(476003)(486006)(8676002)(68736007)(81166006)(71200400001)(71190400001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2660;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JSSnj+ol5PVV/6rAMm21DQW2icnhG0lQan1Z1TvsfEKjjE62jOUXfYt1BU9N3hcsT5Gl2lI6RCnLahVfIuv2jK2fJqnoZBFHaEgi8vbWfudqaJ5LURDIgvQ83isZB0e2oNd4+11WOgpisCyuOdSfiupAGW6RglBzfxHuN9FId6CCWrgKm9bOxD/czsUsb7gf9ipus7sVLH0RPywlBkcRuO5GHfMSXo0vGGXKXpogG21VM4PTBeMYny78mrmqJTZHMyjqd7Ih19Qnrm9c6nguU+yt3OPj1pSnEr35xAGlVSCI16ru8l3w45xYmRedzOzN6YjDboj64819wfbtnVhdNI7lch427RYCCOuE40gaW3xLCxT0ZfyQLLmvFDie22N8Ui97GNFM2MoaK9nxNA9iRs38MA51wiDqWqiBuLF8td8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A448C720D72766408B6E0024614816BA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f7714dc6-dc35-4041-d020-08d68677fd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 05:58:38.5656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2660
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 07:23:56PM -0500, Sasha Levin wrote:
> On Fri, Dec 28, 2018 at 11:50:08AM +0100, Greg KH wrote:
> > On Mon, Nov 05, 2018 at 10:21:23AM +0100, Michal Hocko wrote:
> > > On Fri 02-11-18 19:38:35, Roman Gushchin wrote:
> > > > On Fri, Nov 02, 2018 at 06:48:23PM +0100, Michal Hocko wrote:
> > > > > On Fri 02-11-18 17:25:58, Roman Gushchin wrote:
> > > > > > On Fri, Nov 02, 2018 at 05:51:47PM +0100, Michal Hocko wrote:
> > > > > > > On Fri 02-11-18 16:22:41, Roman Gushchin wrote:
> > > > > [...]
> > > > > > > > 2) We do forget to scan the last page in the LRU list. So i=
f we ended up with
> > > > > > > > 1-page long LRU, it can stay there basically forever.
> > > > > > >
> > > > > > > Why
> > > > > > > 		/*
> > > > > > > 		 * If the cgroup's already been deleted, make sure to
> > > > > > > 		 * scrape out the remaining cache.
> > > > > > > 		 */
> > > > > > > 		if (!scan && !mem_cgroup_online(memcg))
> > > > > > > 			scan =3D min(size, SWAP_CLUSTER_MAX);
> > > > > > >
> > > > > > > in get_scan_count doesn't work for that case?
> > > > > >
> > > > > > No, it doesn't. Let's look at the whole picture:
> > > > > >
> > > > > > 		size =3D lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
> > > > > > 		scan =3D size >> sc->priority;
> > > > > > 		/*
> > > > > > 		 * If the cgroup's already been deleted, make sure to
> > > > > > 		 * scrape out the remaining cache.
> > > > > > 		 */
> > > > > > 		if (!scan && !mem_cgroup_online(memcg))
> > > > > > 			scan =3D min(size, SWAP_CLUSTER_MAX);
> > > > > >
> > > > > > If size =3D=3D 1, scan =3D=3D 0 =3D> scan =3D min(1, 32) =3D=3D=
 1.
> > > > > > And after proportional adjustment we'll have 0.
> > > > >
> > > > > My friday brain hurst when looking at this but if it doesn't work=
 as
> > > > > advertized then it should be fixed. I do not see any of your patc=
hes to
> > > > > touch this logic so how come it would work after them applied?
> > > >
> > > > This part works as expected. But the following
> > > > 	scan =3D div64_u64(scan * fraction[file], denominator);
> > > > reliable turns 1 page to scan to 0 pages to scan.
> > >=20
> > > OK, 68600f623d69 ("mm: don't miss the last page because of round-off
> > > error") sounds like a good and safe stable backport material.
> >=20
> > Thanks for this, now queued up.
> >=20
> > greg k-h
>=20
> It seems that 172b06c32b949 ("mm: slowly shrink slabs with a relatively
> small number of objects") and a76cf1a474d ("mm: don't reclaim inodes
> with many attached pages") cause a regression reported against the 4.19
> stable tree: https://bugzilla.kernel.org/show_bug.cgi?id=3D202441 .
>=20
> Given the history and complexity of these (and other patches from that
> series) it would be nice to understand if this is something that will be
> fixed soon or should we look into reverting the series for now?

In that thread I've just suggested to give a chance to Rik's patch, which
hopefully will mitigate or easy the regression (
https://lkml.org/lkml/2019/1/28/1865 ).

Of course, we can simple revert those changes, but this will re-introduce
the memory leak, so I'd leave it as a last option.

Thanks!
