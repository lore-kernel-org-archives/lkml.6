Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF49C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF0020833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P76MLjYy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c6D/OqTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF0020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeKCCe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:34:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41162 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbeKCCe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:34:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wA2HNGeA006603;
        Fri, 2 Nov 2018 10:26:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=U8KpZcCoyLxwR4pJ2v8znjhGp7+oYYNp4CihftsKIMo=;
 b=P76MLjYynsSnvT1Ty5xvO+GW2I3Fg/s/lpFIKSEBlnGsqbVxRMC0QuwpO+3HDMV0HKeP
 1NkSFlhgOhvp9+d8EO1Cjv5mJamfEQxecu8kvqirtqtJ8KGN5SEVdJfg/vD8iK0GB2s7
 lZokRB1J3IDXZpy/+syt6PRF4gUVy1MYUrw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2ngscw8bkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Nov 2018 10:26:07 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 2 Nov 2018 10:26:06 -0700
Received: from FRC-CHUB12.TheFacebook.com (2620:10d:c021:18::31) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 2 Nov 2018 10:26:06 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 2 Nov 2018 13:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8KpZcCoyLxwR4pJ2v8znjhGp7+oYYNp4CihftsKIMo=;
 b=c6D/OqTvCDG+tn6jD14xcfU3uTzhZ+6bGEytSki2UokgVjCRfJrX6XF2WZ8vrNJjPMfUdgQ3Urq9seHtTsfD5ubPGpL0CfcwGVTxZO0eEE1LV27oggxyQMGwOQ0HaiNmThAP0pY+IU88DY4zGu/JIMqvXmgZ920nJf0+bNFCzuE=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0837.namprd15.prod.outlook.com (10.164.171.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Fri, 2 Nov 2018 17:25:58 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 17:25:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Dexuan Cui <decui@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Topic: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVc///mGwAgACTWwCAAFjogIAADIgAgAB8LwD//41GgIAAfX+AgAAJg4A=
Date:   Fri, 2 Nov 2018 17:25:58 +0000
Message-ID: <20181102172547.GA19042@tower.DHCP.thefacebook.com>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102073009.GP23921@dhcp22.suse.cz>
 <20181102154844.GA17619@tower.DHCP.thefacebook.com>
 <20181102161314.GF28039@dhcp22.suse.cz>
 <20181102162237.GB17619@tower.DHCP.thefacebook.com>
 <20181102165147.GG28039@dhcp22.suse.cz>
In-Reply-To: <20181102165147.GG28039@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:300:94::23) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:b8f1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0837;20:x3Gt0p+s9VTu3seIoTo3mQWMVaueIP4Zd8oMMcaOgGGMF/BO/lpB6Eq1iI18+O4ElXEcjxWhrvjsG3Uyyv3ZmVHVWkb5uFFkJt20oHMT/8sCmB/Eh+UKY0ZI/tVvPI/FK6FdN2dC66BV/YxtiDsHw7wsy4UvOsQUI5pw6spP0JM=
x-ms-office365-filtering-correlation-id: 479e3d03-7051-4904-ec18-08d640e83d68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0837;
x-ms-traffictypediagnostic: BY2PR15MB0837:
x-microsoft-antispam-prvs: <BY2PR15MB083743E1CACC52C9CE0A7F60BECF0@BY2PR15MB0837.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0837;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0837;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(52314003)(6116002)(1076002)(11346002)(446003)(476003)(93886005)(2906002)(316002)(8936002)(8676002)(81156014)(81166006)(68736007)(46003)(6506007)(386003)(33896004)(76176011)(86362001)(486006)(256004)(14444005)(102836004)(54906003)(52116002)(99286004)(186003)(25786009)(39060400002)(4326008)(9686003)(71200400001)(6512007)(53936002)(7736002)(33656002)(305945005)(7416002)(2900100001)(6436002)(6916009)(105586002)(106356001)(14454004)(71190400001)(6246003)(6486002)(478600001)(5660300001)(229853002)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0837;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zsQDBpuCnSED0VFfx3vtKBi0c1B0vUh5n+2058lyxkvoJHJe1R0LnbyrnlCynDw/mxIspTSUvxElYoE2PZtqkWoiX3MN+qSdZzvwVthrfA+cG5fc6jsHimDt3wNbI4UFMYTxbP4iR4z2lF5VEHnNHFKN1XuULrt8xRKTk9Uh0Lic4D28h+ghDuH5r6MGvSyD9lVa+o+VfNOXtQA18AMd1UgBhwfcllnko17J0yR/x02J9oydu2aI/csb822yFT3FGCK4UB76V4fbm+6pf/gFtU5/OSBY7q53eEVYTvUUaMgCbQEnnDlOke7hZ5Z6+0dg19eWxL0F6xywNu1Gb8JJZk+0lgurN+gy0RUVfJRztYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFBA2EC09ED4C44691CFA9FBFB66BF56@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 479e3d03-7051-4904-ec18-08d640e83d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 17:25:58.0998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0837
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 05:51:47PM +0100, Michal Hocko wrote:
> On Fri 02-11-18 16:22:41, Roman Gushchin wrote:
> > On Fri, Nov 02, 2018 at 05:13:14PM +0100, Michal Hocko wrote:
> > > On Fri 02-11-18 15:48:57, Roman Gushchin wrote:
> > > > On Fri, Nov 02, 2018 at 09:03:55AM +0100, Michal Hocko wrote:
> > > > > On Fri 02-11-18 02:45:42, Dexuan Cui wrote:
> > > > > [...]
> > > > > > I totally agree. I'm now just wondering if there is any tempora=
ry workaround,
> > > > > > even if that means we have to run the kernel with some features=
 disabled or
> > > > > > with a suboptimal performance?
> > > > >=20
> > > > > One way would be to disable kmem accounting (cgroup.memory=3Dnokm=
em kernel
> > > > > option). That would reduce the memory isolation because quite a l=
ot of
> > > > > memory will not be accounted for but the primary source of in-fli=
ght and
> > > > > hard to reclaim memory will be gone.
> > > >=20
> > > > In my experience disabling the kmem accounting doesn't really solve=
 the issue
> > > > (without patches), but can lower the rate of the leak.
> > >=20
> > > This is unexpected. 90cbc2508827e was introduced to address offline
> > > memcgs to be reclaim even when they are small. But maybe you mean tha=
t
> > > we still leak in an absence of the memory pressure. Or what does prev=
ent
> > > memcg from going down?
> >=20
> > There are 3 independent issues which are contributing to this leak:
> > 1) Kernel stack accounting weirdness: processes can reuse stack account=
ed to
> > different cgroups. So basically any running process can take a referenc=
e to any
> > cgroup.
>=20
> yes, but kmem accounting should rule that out, right? If not then this
> is a clear bug and easy to backport because that would mean to add a
> missing memcg_kmem_enabled check.

Yes, you're right, disabling kmem accounting should mitigate this problem.

>=20
> > 2) We do forget to scan the last page in the LRU list. So if we ended u=
p with
> > 1-page long LRU, it can stay there basically forever.
>=20
> Why=20
> 		/*
> 		 * If the cgroup's already been deleted, make sure to
> 		 * scrape out the remaining cache.
> 		 */
> 		if (!scan && !mem_cgroup_online(memcg))
> 			scan =3D min(size, SWAP_CLUSTER_MAX);
>=20
> in get_scan_count doesn't work for that case?

No, it doesn't. Let's look at the whole picture:

		size =3D lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
		scan =3D size >> sc->priority;
		/*
		 * If the cgroup's already been deleted, make sure to
		 * scrape out the remaining cache.
		 */
		if (!scan && !mem_cgroup_online(memcg))
			scan =3D min(size, SWAP_CLUSTER_MAX);

If size =3D=3D 1, scan =3D=3D 0 =3D> scan =3D min(1, 32) =3D=3D 1.
And after proportional adjustment we'll have 0.

So, disabling kmem accounting mitigates 2 other issues, but not this one.

Anyway, I'd prefer to wait a bit for test results, and backport the whole
series as a whole.

Thanks!
