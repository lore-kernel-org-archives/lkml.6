Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D4EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B0F222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nvTpPMBd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MzX8Xjeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfBLWh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:37:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56864 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbfBLWh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:37:26 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CMVrsh016248;
        Tue, 12 Feb 2019 14:37:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vyd2Riu5JqEoe7zptWm5DHJeuaWaP9W9OsNnxF5qA9g=;
 b=nvTpPMBd441OpWXSVHEuN+gCvhYxXW6TOXcN3Og5Rfbvrjp7R31GYhU2icoLb0JwV4KL
 vTgHXJJkhtw+33KHnRjgqCmgRYA+cupW6ZqEzvDhTXi4OuZYq25n/XUbHShz8sJnpYQp
 gsgG0KK/aMw/qtvy9xNVECfqFHHFuCwJR8A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qm3yx0mg6-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Feb 2019 14:37:12 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 12 Feb 2019 14:36:14 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 12 Feb 2019 14:36:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyd2Riu5JqEoe7zptWm5DHJeuaWaP9W9OsNnxF5qA9g=;
 b=MzX8XjeoSS/mOJWXaH+tcs5d5NM2LgsZwSsVs9nrzR0QIqcspSVPD85QFPLC1qYQJ54UslgR1ybh2NcexpAWRulj8NduZ3bL0I2dPhXmqpfS+d9GWgulx+e5+c1LqK/nePrNd8UWC8o1fQxR1MBioExNHLEfpq+i6KIr3OwdaaQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2581.namprd15.prod.outlook.com (20.179.155.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Tue, 12 Feb 2019 22:36:12 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1601.016; Tue, 12 Feb 2019
 22:36:12 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guroan@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] vmalloc enhancements
Thread-Topic: [PATCH v2 0/3] vmalloc enhancements
Thread-Index: AQHUwvxltqRw0KKPyU2GUxvyv29fa6XcgNAAgAAd04CAACIUgA==
Date:   Tue, 12 Feb 2019 22:36:12 +0000
Message-ID: <20190212223605.GA15979@tower.DHCP.thefacebook.com>
References: <20190212175648.28738-1-guro@fb.com>
 <20190212184724.GA18339@cmpxchg.org>
 <20190212123409.7ed5c34d68466dbd8b7013a3@linux-foundation.org>
In-Reply-To: <20190212123409.7ed5c34d68466dbd8b7013a3@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:300:12a::32) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:81f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85195b05-3eaa-47cb-8b92-08d6913a7da5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2581;
x-ms-traffictypediagnostic: BYAPR15MB2581:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2581;20:dQf1VwJzz55wY9i0VOAgTSJnFMZpXBfS3mzqH7JtHlHsnaDUJhZokiEtLVnmrU0QVWe23AxJLi+BXKrPGmccuhd98UF/GzTLTtbscFjvB6n3a4bZpHot/zv+x3esv0FCE0IBN4tAcTvsP8+E7WtRybeMBtdX5tj7/Yo4rGo2inc=
x-microsoft-antispam-prvs: <BYAPR15MB2581454574BF07E1548EEE0CBE650@BYAPR15MB2581.namprd15.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(25786009)(478600001)(305945005)(102836004)(9686003)(105586002)(71200400001)(71190400001)(54906003)(11346002)(6506007)(386003)(14454004)(52116002)(53936002)(76176011)(486006)(1076003)(46003)(86362001)(33656002)(97736004)(6512007)(81156014)(8676002)(81166006)(256004)(446003)(7736002)(14444005)(6116002)(68736007)(229853002)(4326008)(186003)(6246003)(106356001)(8936002)(316002)(476003)(33896004)(2906002)(6436002)(99286004)(6916009)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2581;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aa8ahCiJ6DmxEsk4LSePdQie/shft7jIHQRdfJlKb+6oA7gZc/jzoXSyXo2HEcmpRw1YS5uwzF3iIFxuid4qYnEIl99LJGS0z5wr/SAQQ273xmgNJerJQNArNPExJylY8I0PG0Kx0HvOCXfWzjvgapDreWjqGWq9WAqFj9ig0g7f1HarXH4DwXMCutF5/JPkzfziTo4ze6uWie85BZRtATljK1e+lflR1mld7on2zRIMvfTbC2a+sroBA3w9my1Z/dGdsDPGVFQeVFPTwJuk+J9gnLyUtlwIizT1CNKvDuJ17heYgS8JEvVM/vm+kVbwEJpChwayMSGNEaORJvP/Sm404Q/ARuuRAykutvpf/iIZTP+ek9u4mK3VDz0QhWBM8Gt3yt2F7aHpafbSCxpF1P5fVKkgJrbgiMpv1smsbMY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6518C4C42851354B946B2D8F8245DF97@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85195b05-3eaa-47cb-8b92-08d6913a7da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 22:36:11.6712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2581
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:34:09PM -0800, Andrew Morton wrote:
> On Tue, 12 Feb 2019 13:47:24 -0500 Johannes Weiner <hannes@cmpxchg.org> w=
rote:
>=20
> > On Tue, Feb 12, 2019 at 09:56:45AM -0800, Roman Gushchin wrote:
> > > The patchset contains few changes to the vmalloc code, which are
> > > leading to some performance gains and code simplification.
> > >=20
> > > Also, it exports a number of pages, used by vmalloc(),
> > > in /proc/meminfo.
> > >=20
> > > Patch (1) removes some redundancy on __vunmap().
> > > Patch (2) separates memory allocation and data initialization
> > >   in alloc_vmap_area()
> > > Patch (3) adds vmalloc counter to /proc/meminfo.
> > >=20
> > > v2->v1:
> > >   - rebased on top of current mm tree
> > >   - switch from atomic to percpu vmalloc page counter
> >=20
> > I don't understand what prompted this change to percpu counters.

I *think*, I see some performance difference, but it's barely measurable
in my setup. Also as I remember, Matthew was asking why not percpu here.
So if everybody prefers a global atomic, I'm fine with either.

> >=20
> > All writers already write vmap_area_lock and vmap_area_list, so it's
> > not really saving much. The for_each_possible_cpu() for /proc/meminfo
> > on the other hand is troublesome.
>=20
> percpu_counters would fit here.  They have probably-unneeded locking
> but I expect that will be acceptable.
>=20
> And they address the issues with for_each_possible_cpu() avoidance, CPU
> hotplug and transient negative values.

Not sure, because percpu_counters are based on dynamic percpu allocations,
which are using vmalloc under the hood.

Thanks!
