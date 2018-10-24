Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3D0ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92D02082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P9sztyMb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="izC8xC4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92D02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeJYIUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:20:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56626 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbeJYIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:19:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9ONmM3N011687;
        Wed, 24 Oct 2018 16:49:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sm4ajbpa9S2cioFGfFyytaxDInFvBmrbQhT9eOUU/BA=;
 b=P9sztyMb/i1imCZ94RSCIWFK0Och69z+gIO/TH1nk/JV7ULTn4uFRiHCNadgrUUWETKG
 XBEmx4Ol5iYULPpszLvXzX7QAsUo55YRc/OsZbjEnGqvoxlu93m6e0F2FQbQsInBzUFy
 pUX260JxNGRuvVVOd4phf5VH8m6sztt6Uu4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nayad0m0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Oct 2018 16:49:22 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 24 Oct 2018 16:49:21 -0700
Received: from FRC-CHUB13.TheFacebook.com (2620:10d:c021:18::32) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 24 Oct 2018 16:49:21 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 24 Oct 2018 19:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm4ajbpa9S2cioFGfFyytaxDInFvBmrbQhT9eOUU/BA=;
 b=izC8xC4+b1Q48+1d6cg1hDuSYZcfVt2WRiLTRpnhoT4lEn+MVOmb/+AH2af8XaRGYHfWboEPKd+I0oYdPl/qc4sWZjGOuo8QZoOyqywV67+k4aioFF8vUbohF00ghksGgmxsL/hfm/CNbeXD+wh16C+qsGT6q2dLm1CmJ+YVDKo=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0343.namprd15.prod.outlook.com (10.163.109.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Wed, 24 Oct 2018 23:49:02 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 23:49:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Topic: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Index: AQHUau+GsFRIu7vNQ0mBGnFYa9WgU6Uu+TiAgAAZKIA=
Date:   Wed, 24 Oct 2018 23:49:01 +0000
Message-ID: <20181024234850.GA15663@castle.DHCP.thefacebook.com>
References: <20181023164302.20436-1-guro@fb.com>
 <20181024151853.3edd9097400b0d52edff1f16@linux-foundation.org>
In-Reply-To: <20181024151853.3edd9097400b0d52edff1f16@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:405:3a::23) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::1:50a3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0343;20:JQskcEHI/lqK+/4udEg4JgPpbVXYOvyo26SVqrOYDiOYGJEsYskqKwlC6bI+RMm4mATjica+8W0+mqGMD9DguyiwTtfO3OrSIk/mNd8OlxlTCQ+7tt86OF/IUugc5nQbOl3Lbwrc+HJiofta3mStV60USvkiy3ykh9MnH/liad8=
x-ms-office365-filtering-correlation-id: 90c4e882-e024-4760-32a6-08d63a0b45f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0343;
x-ms-traffictypediagnostic: BY2PR15MB0343:
x-microsoft-antispam-prvs: <BY2PR15MB0343FF0340295B18F1266C79BEF60@BY2PR15MB0343.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0343;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0343;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(8676002)(446003)(81166006)(68736007)(81156014)(6486002)(86362001)(8936002)(1076002)(6116002)(186003)(25786009)(14454004)(486006)(6246003)(54906003)(102836004)(14444005)(476003)(5250100002)(5024004)(256004)(71190400001)(46003)(105586002)(76176011)(2900100001)(33896004)(97736004)(7736002)(305945005)(9686003)(4326008)(6512007)(229853002)(6436002)(33656002)(2906002)(478600001)(99286004)(6506007)(316002)(106356001)(386003)(5660300001)(6916009)(71200400001)(11346002)(53936002)(52116002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0343;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4+d9jCBqt+mCHC1e2AcOSVHnMTMM7H/Nf28X/MfkUs1o/YbGGTd/YZCwp9d5dPauUyDq+VBjW4ZJ2nk7XbSotzmsv9wQgvh0upKfvlDBcuqkNOlzMB2qJtZ6M6M/nj5GnMwPKeLYKRhmTCusRe64HVJtVljzrabkYkzyDucBg9kLhRka1KjC/uJzYP6RovJWo2OH00KhkFKaTMuB687cMfKC4a/i//tMV7WJFaeHYkBpWfNzG9VCCo8SSJzH80Ab2iCl71ilQ2pCK3KudbmLulI6i0D5uc5jpwGx0YXCC9DXqH4qeJwGPvAPynCE6P+4qKH5AZi0bvLMzmxtUh6EKQC2SNCBEdum2FJ7t/6+Jog=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6212D75D74E5C145A20548F85CF0AF78@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c4e882-e024-4760-32a6-08d63a0b45f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 23:49:01.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0343
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 03:18:53PM -0700, Andrew Morton wrote:
> On Tue, 23 Oct 2018 16:43:29 +0000 Roman Gushchin <guro@fb.com> wrote:
>=20
> > Spock reported that the commit 172b06c32b94 ("mm: slowly shrink slabs
> > with a relatively small number of objects") leads to a regression on
> > his setup: periodically the majority of the pagecache is evicted
> > without an obvious reason, while before the change the amount of free
> > memory was balancing around the watermark.
> >=20
> > The reason behind is that the mentioned above change created some
> > minimal background pressure on the inode cache. The problem is that
> > if an inode is considered to be reclaimed, all belonging pagecache
> > page are stripped, no matter how many of them are there. So, if a huge
> > multi-gigabyte file is cached in the memory, and the goal is to
> > reclaim only few slab objects (unused inodes), we still can eventually
> > evict all gigabytes of the pagecache at once.
> >=20
> > The workload described by Spock has few large non-mapped files in the
> > pagecache, so it's especially noticeable.
> >=20
> > To solve the problem let's postpone the reclaim of inodes, which have
> > more than 1 attached page. Let's wait until the pagecache pages will
> > be evicted naturally by scanning the corresponding LRU lists, and only
> > then reclaim the inode structure.
> >=20
> > ...
> >
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -730,8 +730,11 @@ static enum lru_status inode_lru_isolate(struct li=
st_head *item,
> >  		return LRU_REMOVED;
> >  	}
> > =20
> > -	/* recently referenced inodes get one more pass */
> > -	if (inode->i_state & I_REFERENCED) {
> > +	/*
> > +	 * Recently referenced inodes and inodes with many attached pages
> > +	 * get one more pass.
> > +	 */
> > +	if (inode->i_state & I_REFERENCED || inode->i_data.nrpages > 1) {
> >  		inode->i_state &=3D ~I_REFERENCED;
> >  		spin_unlock(&inode->i_lock);
> >  		return LRU_ROTATE;
>=20
> hm, why "1"?
>=20
> I guess one could argue that this will encompass long symlinks, but I
> just made that up to make "1" appear more justifiable ;)=20
>=20

Well, I'm slightly aware of introducing an inode leak here, so I was thinki=
ng
about some small number of pages. It's definitely makes no sense to reclaim
several Gb of pagecache, however throwing away a couple of pages to speed u=
p
inode reuse is totally fine.
But then I realized that I don't have any justification for a number like
4 or 32, so I ended up with 1. I'm pretty open here, but not sure that swit=
ching
to 0 is much better.

Thanks!
