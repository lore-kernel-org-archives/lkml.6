Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9713DC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC1C2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QldTefMp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GUx/PJH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC1C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJ0Ae6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:34:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53828 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbeJ0Ae6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:34:58 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9QFsJpY025886;
        Fri, 26 Oct 2018 08:57:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XdyeQ5c0SUT/x2batDuoW6QY2uQ6/XHycbJO97IxDVo=;
 b=QldTefMp+3OAW66ONP6rGG2fXHatNEHQTHYiGUnCrAQB7unCrb4owUc5CHLIS8GJHOwj
 hatEDjebgsTyMQEWIwjxCnev+M/U4twMM4M9w37u4bDfzotKTTTfiATuWBplHWh2dbj2
 P7fZ2gETEAvolA2g1n92dYHgemfSb8y7LtY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nc2uurn2j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Oct 2018 08:57:02 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 26 Oct 2018 08:57:00 -0700
Received: from PRN-CHUB10.TheFacebook.com (2620:10d:c081:35::19) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 26 Oct 2018 08:57:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 26 Oct 2018 08:57:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdyeQ5c0SUT/x2batDuoW6QY2uQ6/XHycbJO97IxDVo=;
 b=GUx/PJH1wWGt4W6eVwgM+AHCMG1O1rqmOJcZ6J0bESfjOZrOyD7f7Btp7StNG3tfyNj3cbxWh4X4zIVUGJklEun80SoUvPNvThVHH+EF9+/LYOq4/5SM8rYyeFt/5uajC9VFNVcvk2fCKW1GA5vrCZRHmx40n7PsR1PFf5FwQi4=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0342.namprd15.prod.outlook.com (10.163.109.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 15:56:56 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Fri, 26 Oct 2018
 15:56:56 +0000
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
Thread-Index: AQHUau+GsFRIu7vNQ0mBGnFYa9WgU6UxPgGAgAB1JQA=
Date:   Fri, 26 Oct 2018 15:56:55 +0000
Message-ID: <20181026155652.GA7647@tower.DHCP.thefacebook.com>
References: <20181023164302.20436-1-guro@fb.com>
 <20181026085735.GZ18839@dhcp22.suse.cz>
In-Reply-To: <20181026085735.GZ18839@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:300:117::23) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:4473]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0342;20:WePtgON9dFB1Y48s484W8xRAgAvozNkr7pNWKJhpqZ9g+WrnFwyAqiR+DtntGdNja1a+ULYEqE0524lMb7StotmwFDImqmKehZbjE6SbsEfwUzQtMvnLQaHtpb4+sZ4FnW+bBcoGmBbXGcf36cuvNdtO/yDi+oMs0E/zevYIV9w=
x-ms-office365-filtering-correlation-id: b39f77dc-999c-4eb4-5adf-08d63b5ba74c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0342;
x-ms-traffictypediagnostic: BY2PR15MB0342:
x-microsoft-antispam-prvs: <BY2PR15MB0342CB83AA4537AB26DADDA8BEF00@BY2PR15MB0342.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0342;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0342;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(39860400002)(396003)(376002)(199004)(189003)(76176011)(9686003)(386003)(2900100001)(54906003)(86362001)(6506007)(5250100002)(105586002)(106356001)(316002)(6512007)(11346002)(33896004)(25786009)(6436002)(446003)(39060400002)(102836004)(229853002)(6246003)(99286004)(486006)(97736004)(52116002)(476003)(53936002)(186003)(4326008)(46003)(7736002)(2906002)(14454004)(305945005)(5660300001)(478600001)(33656002)(8936002)(71190400001)(71200400001)(1076002)(6916009)(81166006)(6116002)(6486002)(81156014)(5024004)(8676002)(68736007)(256004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0342;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hMXHNlv2gUw8XfxKBoVA0Jxt9RWHZxyUMJf7kttoPtpHcEiXi3mkSOZMZwtmrrn7WGYsxJBpYsqercGbXncAkQ38KTicGlrq4c1sHcdjvkE/o+GBZDZq5p6osZ3hBTMfu4idxpdp8S2pRGJd9uSKeoqwcBEpOqEtRCX69DAH8I3ncXwkZP+mHJ2Tf6VMcpdDV3w+Sa/3SV7xhc0beD0bfQOObz1Dygc+BXoYJQqeKo1WgwyiDH7BDjtPg4MbKE3kMB5US0gosgK4Ae7hLeUnwx+VaF0On4Cle5NaGFkchJNTZD7MfJESdAi9tofkQYAZl7ncfeIYo0P6FqT0QqxBTq1YVykzjLAj1zFejaKlBFw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F06829E07D1E6740BB7B73B6C40FC021@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b39f77dc-999c-4eb4-5adf-08d63b5ba74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 15:56:55.9053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0342
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

Spock wrote this earlier to me directly. I believe I can quote it here:

"Patch applied, looks good so far. System behaves like it was with
pre-4.18.15 kernels.
Also tried to add some user-level tests to the geneic background activity, =
like
- stat'ing a bunch of files
- streamed read several large files at once on ext4 and XFS
- random reads on the whole collection with a read size of 16K

I will be monitoring while fragmentation stacks up and report back if
something bad happens."

Spock, please let me know if you have any new results.

Thanks!
