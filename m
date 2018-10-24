Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A2ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578D02082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="i8AnnAy2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Z0m4WOxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578D02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeJYIVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:21:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbeJYIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:21:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9ONnD49012271;
        Wed, 24 Oct 2018 16:51:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=t5gogMntyoLtkzNkd8cMqyna/FAh9ZxNuEp+GcJLASw=;
 b=i8AnnAy2hADHqHCdYe+HQsHuXDFYOzOPOkxJCEo4eXLmZLrmEb9asH5mVXNf83k/KhVZ
 r/+eROJqigQzAlyFmIUqd6nX+DGKKygekIuyrVAS45NSQBYIcDrewpcgpwEp8yG6jbYi
 KrnxB5/h1gBHCFGGyxinoubkohMApIf3UCg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nayad0m4e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Oct 2018 16:51:18 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 24 Oct 2018 16:51:13 -0700
Received: from FRC-CHUB08.TheFacebook.com (2620:10d:c021:18::27) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 24 Oct 2018 16:51:13 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 24 Oct 2018 19:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5gogMntyoLtkzNkd8cMqyna/FAh9ZxNuEp+GcJLASw=;
 b=Z0m4WOxseHVpKha0Ebz4RG6nuvwLeG2c3GLVPB9VFYFW71E1Q9fkn/k9sNYxBr6dnHbEeCpjnAr+6xisdMqiVzkdbR8vMVXWUvQtRuFcDb529ul9sAPhEkJpTytCQmX7hBzmk1gUjSiDfSKsqGfCw2EQyEKvsClffOfuX+/dw2c=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0870.namprd15.prod.outlook.com (10.164.171.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Wed, 24 Oct 2018 23:51:07 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 23:51:07 +0000
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
Thread-Index: AQHUau+GsFRIu7vNQ0mBGnFYa9WgU6Uu+XwAgAAZewA=
Date:   Wed, 24 Oct 2018 23:51:07 +0000
Message-ID: <20181024235101.GB15663@castle.DHCP.thefacebook.com>
References: <20181023164302.20436-1-guro@fb.com>
 <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
In-Reply-To: <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:404:10a::33) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::1:50a3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0870;20:cA3qX0HB+fdJXRitqt2Cf8Ck/tKuqzPYwLcXdO8dyR/qQ+qgMDdLIsYMcmz7gWKePtG64VG7cYf9Yta1t7dDbPqAAkeLgCi5QziNvOckk2cTkY8nMoJp3Sm63jprWNOnUnSgoXZKNvWxaOI7NJfUO46Eig71ajA5nLf18s2lxj0=
x-ms-office365-filtering-correlation-id: 5e727fe5-fe81-421c-30c4-08d63a0b910e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0870;
x-ms-traffictypediagnostic: BY2PR15MB0870:
x-microsoft-antispam-prvs: <BY2PR15MB08704191EE2235A4AF2203A2BEF60@BY2PR15MB0870.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0870;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0870;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(39860400002)(396003)(199004)(189003)(53936002)(305945005)(8676002)(2900100001)(97736004)(7736002)(54906003)(81166006)(14454004)(8936002)(5250100002)(11346002)(476003)(478600001)(81156014)(316002)(2906002)(6486002)(4326008)(6916009)(5024004)(446003)(1076002)(9686003)(25786009)(99286004)(6116002)(6512007)(33656002)(68736007)(6246003)(76176011)(186003)(105586002)(6436002)(71200400001)(256004)(5660300001)(6506007)(106356001)(229853002)(102836004)(71190400001)(52116002)(46003)(33896004)(86362001)(386003)(486006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0870;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 60YucXapT+ncCakUS+fdbVXmRPEcdHxwjc+TGB1e3ix64pCb0QukPUEccYcwrbgOSyA7LNXPIFzsLdMyvKuItyL8f+PFucoQsmfSS7h4CCCSZn/hSOCVaSpEE3VnWC6vWJeI4Vd2LOahB4jl6qePSnDh5rYVUlS0A0durifayilfmPjRCZdu/9BnS1eZrARFyS+7hbzFocoRWqKlfj5GLIS6bt1uJAsknbNaGj0zm7y9kqoidbds/2elEKHH51bojTXsxLhKRdVPqAQV/EZdPbJrCFdt1x3JHYotbFB+m0U2VPq08p4aRsIv3Vrg0fdxS+NhgV0au8tqGjOFS0qbdLDYS8ae5tknG6m55TYOT7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79CFF4DBB7966C44A8429A0EEE6994C0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e727fe5-fe81-421c-30c4-08d63a0b910e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 23:51:07.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0870
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 03:19:50PM -0700, Andrew Morton wrote:
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
>=20
> Is this regression serious enough to warrant fixing 4.19.1?

I'd give it some testing in the mm tree (and I'll test it by myself
on our fleet), and then backport to 4.19.x.

Thanks!
