Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF9C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814EE2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aPrCBIFu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="a+ldOd6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814EE2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJ0Aga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:36:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54310 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbeJ0Ag3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:36:29 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9QFsNxr025961;
        Fri, 26 Oct 2018 08:58:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gIJdoRS4J80M+aNZdj0bbrMq46nIA1zjtAJK7lvKD0k=;
 b=aPrCBIFu/IXjaNfys5sFQ3h8lZr9mR4Qb2zO/1EF0hG6ScIj9HbHEKHA4IepD7UFMi3s
 rwKdosgdMCTd6CDaVplEpVaPHKJoQRR+ihocx9Ik7YXHiXlClpQ/YN+fGeGyBz8d3deC
 0bE1PfNla9MMUHsCBaPSRmLGBZPVMZ70htk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nc2uurn72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Oct 2018 08:58:36 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 26 Oct 2018 08:58:34 -0700
Received: from PRN-CHUB05.TheFacebook.com (2620:10d:c081:35::14) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 26 Oct 2018 08:58:34 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 26 Oct 2018 08:58:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIJdoRS4J80M+aNZdj0bbrMq46nIA1zjtAJK7lvKD0k=;
 b=a+ldOd6o3h+Gdh+rgzQ9wiGH9X0AzkuA5ugqgGoaFsrDDknhvHno3sGFYHgPJKhD8X1zLTEESai0E6ulOMyPeD8lkR3IehMYD+yhAXhVoiYLZ9V566K2aQIgrjRiTkrGzWsi3mPRG8MCf72CVpn911aZ9g3hVe5/+VH4zBdXp1w=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0807.namprd15.prod.outlook.com (10.164.171.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 15:58:15 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Fri, 26 Oct 2018
 15:58:15 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Rik van Riel" <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "dairinin@gmail.com" <dairinin@gmail.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Topic: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Index: AQHUau+GsFRIu7vNQ0mBGnFYa9WgU6UxPgGAgAB1hAA=
Date:   Fri, 26 Oct 2018 15:58:15 +0000
Message-ID: <20181026155812.GB6019@tower.DHCP.thefacebook.com>
References: <20181023164302.20436-1-guro@fb.com>
 <20181026085735.GZ18839@dhcp22.suse.cz>
In-Reply-To: <20181026085735.GZ18839@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0032.prod.exchangelabs.com (2603:10b6:300:101::18)
 To BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:4473]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0807;20:2im5W31yUZuQW/jYd7ZTFNDl2hS214pPruWk8ntWrvPuSqzz/z8/Al6fo2rSpTv/T1Svji5frU88h2kSgGmAHtMwf5pTQ9A48yN3x0bo1vIpT4THiANbvd0X3zaVd2QzpiPodAlHFoJzU3AmrtViUZeFa8ux8GDamtjv1ByCEmQ=
x-ms-office365-filtering-correlation-id: 85bec763-36b5-4a91-861f-08d63b5bd6c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0807;
x-ms-traffictypediagnostic: BY2PR15MB0807:
x-microsoft-antispam-prvs: <BY2PR15MB08074308AE975AE6862ABA31BEF00@BY2PR15MB0807.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0807;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0807;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(39060400002)(81156014)(81166006)(99286004)(25786009)(186003)(8676002)(53936002)(68736007)(4326008)(52116002)(8936002)(6436002)(6486002)(76176011)(46003)(5660300001)(446003)(33896004)(11346002)(6506007)(229853002)(476003)(6116002)(7736002)(5024004)(256004)(305945005)(102836004)(9686003)(6512007)(386003)(486006)(86362001)(575784001)(105586002)(478600001)(106356001)(14454004)(97736004)(316002)(33656002)(6916009)(54906003)(2906002)(71190400001)(71200400001)(5250100002)(2900100001)(6246003)(1076002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0807;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t/BUSB/0ns4hfM7D0gJ7GQijZSb7QiH1B0fTK7XsrSsz7cFN8Skqq39MjovbMLZaBgN23kjHG7C0tT/wa3neC6EHjxkadVMht/xnEUTb/PaHwQedkwrtpZlkseYgLtM7m6vNTQdX425ykZ6p3a8w5Qq3G7VT5be0Y6hWLSGyHeHn93V+EPuHpOXDtmbnsGlZy7UAEkEktUd1id9D+MNJIguYHA8N19U4/HOgORJ33ZO1biLN1EMb64XpJOqAs2XFbesTyldeWv+ECFetJdGk2J+tgQq1imeLcjIPL/0h1GLzd95arPPp/bE5gl2VVVXRctKxCXLM7wBbqNRsw8A0Kl3n3gaumpc/EQKUCZDlA3c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADCAA52362A08F4A8B809D4CF4DF8141@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bec763-36b5-4a91-861f-08d63b5bd6c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 15:58:15.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0807
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:57:35AM +0200, Michal Hocko wrote:
> Spock doesn't seem to be cced here - fixed now
>=20
> On Tue 23-10-18 16:43:29, Roman Gushchin wrote:
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
>=20
> Has this actually fixed/worked around the issue?
>=20
> > Reported-by: Spock <dairinin@gmail.com>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  fs/inode.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 73432e64f874..0cd47fe0dbe5 100644
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
>=20
> The comment is just confusing. Did you mean to say s@many@any@ ?

No, here many =3D=3D more than 1.

I'm happy to fix the comment, if you have any suggestions.


Thanks!
