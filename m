Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B10EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4612081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mnM2iE6a";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hcSVbOne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4612081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeKCErn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:47:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54026 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726051AbeKCErn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:47:43 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2JZ1HK002062;
        Fri, 2 Nov 2018 12:38:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=N9Dp2eOl8eCan2QEUva8IP9EmOMRCkpvCqtvLs7T32U=;
 b=mnM2iE6acQ6RaK/atrjkQKyvn5Gu1U593LehkC2VZWzR4E0k8+d46IFwjKJ6abi6htl0
 JN4aqXv3saxqI7CMiHszO6JNrr5zrps9wEp6hn7RsieYl6J9z0FEbpS/c17M5Co2xzIN
 g+7LvX9tk2tJiK1mvfDjN7zRnDrEsy6+wBg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ngtc90j97-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Nov 2018 12:38:48 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 2 Nov 2018 12:38:41 -0700
Received: from PRN-CHUB05.TheFacebook.com (2620:10d:c081:35::14) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 2 Nov 2018 12:38:41 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 2 Nov 2018 12:38:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9Dp2eOl8eCan2QEUva8IP9EmOMRCkpvCqtvLs7T32U=;
 b=hcSVbOnen0QsGQkde6zFzfGiFy9SP/G6bjLS6p0CxGRuWKOIUSncRTyMUGBTtXFLtFMo5CXDq1Y2GsgErmzWK0nPHymSpmCFMvOSflvJYskuzIrAqV0HTdkRF/OPohz/nURsr/KVpU3nX13joUvtd9C1AOMVKRLDtc37XFgaf2o=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0728.namprd15.prod.outlook.com (10.164.170.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 2 Nov 2018 19:38:35 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 19:38:35 +0000
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
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVc///mGwAgACTWwCAAFjogIAADIgAgAB8LwD//41GgIAAfX+A//+UKoCAAHungIAAHsQA
Date:   Fri, 2 Nov 2018 19:38:35 +0000
Message-ID: <20181102193827.GA18024@castle.DHCP.thefacebook.com>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102073009.GP23921@dhcp22.suse.cz>
 <20181102154844.GA17619@tower.DHCP.thefacebook.com>
 <20181102161314.GF28039@dhcp22.suse.cz>
 <20181102162237.GB17619@tower.DHCP.thefacebook.com>
 <20181102165147.GG28039@dhcp22.suse.cz>
 <20181102172547.GA19042@tower.DHCP.thefacebook.com>
 <20181102174823.GI28039@dhcp22.suse.cz>
In-Reply-To: <20181102174823.GI28039@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0057.namprd02.prod.outlook.com
 (2603:10b6:301:73::34) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:a49]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0728;20:ZHGi024nVnEj3ViX5D9lQJbuWA7zl6fJkNSy9XOn8xAez7enel9uQABa/3XUqRvlGnuEM3gc1E27Jw1qPOe2dU2qeQQ75poyd4OweNZlJP4mB/D3Akhv54ExshwjKYhISlnH7YLmOqr81TBy8ve8i56+TtugjIZdK4RvC1RryqQ=
x-ms-office365-filtering-correlation-id: a287286c-b2f1-4033-14e3-08d640fac769
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0728;
x-ms-traffictypediagnostic: BY2PR15MB0728:
x-microsoft-antispam-prvs: <BY2PR15MB0728076A160C76D8FC2BCA51BECF0@BY2PR15MB0728.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3231382)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0728;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0728;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(86362001)(4326008)(81166006)(81156014)(478600001)(106356001)(54906003)(46003)(6916009)(8676002)(105586002)(229853002)(476003)(8936002)(11346002)(14454004)(446003)(186003)(7416002)(6512007)(9686003)(486006)(53936002)(52116002)(71190400001)(5660300001)(25786009)(2900100001)(6246003)(76176011)(71200400001)(6436002)(6506007)(386003)(68736007)(2906002)(7736002)(93886005)(6486002)(102836004)(305945005)(99286004)(97736004)(1076002)(33656002)(256004)(33896004)(39060400002)(6116002)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0728;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sbvunmiyZoi2m3VJpFE9K3h1VNEw3DKULE9j6x8/zUFHp/PTiZgjhi8gxP2OG1lhT/CGCGrEq/+6rJabSsH8gSCadJk0McnuxLBcH8GZt+1dHu5vkB6y/zLATSjMDc3WHD3pmVg1RDWJCVDTRhZwZ9B4qia/KQ1OwImXxqHU493EfIL1byFfxfaR1gHFH2oFl1YpeInEMpRajdoKJq+hsavepMdkAEoIyjSTAXiQ0OEtVl5YpSG/tDep3tqw+3kVF2vZDqAiQytK2KopmAn75/FjK1D5XGfZglfh03IAvvGvHha5BDlo+Q5ZrJGNVpA7KPkjhWkyUSvIBcUgdG0gF1Fsjh9RywTRR76bsAGjuHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <91355EADA23A1D47A4B5ABA6759992D0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a287286c-b2f1-4033-14e3-08d640fac769
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 19:38:35.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 06:48:23PM +0100, Michal Hocko wrote:
> On Fri 02-11-18 17:25:58, Roman Gushchin wrote:
> > On Fri, Nov 02, 2018 at 05:51:47PM +0100, Michal Hocko wrote:
> > > On Fri 02-11-18 16:22:41, Roman Gushchin wrote:
> [...]
> > > > 2) We do forget to scan the last page in the LRU list. So if we end=
ed up with
> > > > 1-page long LRU, it can stay there basically forever.
> > >=20
> > > Why=20
> > > 		/*
> > > 		 * If the cgroup's already been deleted, make sure to
> > > 		 * scrape out the remaining cache.
> > > 		 */
> > > 		if (!scan && !mem_cgroup_online(memcg))
> > > 			scan =3D min(size, SWAP_CLUSTER_MAX);
> > >=20
> > > in get_scan_count doesn't work for that case?
> >=20
> > No, it doesn't. Let's look at the whole picture:
> >=20
> > 		size =3D lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
> > 		scan =3D size >> sc->priority;
> > 		/*
> > 		 * If the cgroup's already been deleted, make sure to
> > 		 * scrape out the remaining cache.
> > 		 */
> > 		if (!scan && !mem_cgroup_online(memcg))
> > 			scan =3D min(size, SWAP_CLUSTER_MAX);
> >=20
> > If size =3D=3D 1, scan =3D=3D 0 =3D> scan =3D min(1, 32) =3D=3D 1.
> > And after proportional adjustment we'll have 0.
>=20
> My friday brain hurst when looking at this but if it doesn't work as
> advertized then it should be fixed. I do not see any of your patches to
> touch this logic so how come it would work after them applied?

This part works as expected. But the following
	scan =3D div64_u64(scan * fraction[file], denominator);
reliable turns 1 page to scan to 0 pages to scan.

And this is the issue which my patches do address.

Thanks!
