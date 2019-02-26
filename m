Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC747C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862D0218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LZn4oHCc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GwUYiNxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfBZXuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:50:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfBZXuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:50:13 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QNo4xI014586;
        Tue, 26 Feb 2019 15:50:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UxNseYtvy3qCAyi0iYKcxOmE4pf/t1SNeHCMaX7CDzo=;
 b=LZn4oHCcbVQ6T0AHcSNrwF7lR8R+d1WrsOJbKg3Z+QW5tf7iZP4O7sY4sb3Sn0xq8eWE
 Rs7GwKqTT6gQ5nx1r5ANYKVl54YlgRPhtG6J/4nhg84JYG6l7IPldJ0C3wlA9W6QodU3
 v97fMUZ6tYoLiy+GYyeT7trPWnkzs8DXRnE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qwefkg6nc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 26 Feb 2019 15:50:10 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 26 Feb 2019 15:50:00 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 26 Feb 2019 15:50:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxNseYtvy3qCAyi0iYKcxOmE4pf/t1SNeHCMaX7CDzo=;
 b=GwUYiNxHv7ORUf8Wi0Jym1hIBi3GjjLVMVUjxQVao0v2DCb8p7k6/3wtQFz1BNqcw1mmVEVpe4fNNZooVaZIEw0bV/H0ADjNOZqcMcuGv+2j9Jflx6w3NsJw6wYja5t2jEHFMo4BAlYQk5Mxm8Yrh8/7WZ/HzLENsOcb+Yc3sA8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2375.namprd15.prod.outlook.com (52.135.198.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 23:49:57 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 23:49:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "up@kvack.org" <up@kvack.org>, "the@kvack.org" <the@kvack.org>,
        "LRU@kvack.org" <LRU@kvack.org>,
        "counts@kvack.org" <counts@kvack.org>,
        "tracking@kvack.org" <tracking@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: your mail
Thread-Topic: your mail
Thread-Index: AQHUzUcWDtH4mHJ4O0uyGF7XBp7tPqXywWGA
Date:   Tue, 26 Feb 2019 23:49:57 +0000
Message-ID: <20190226234950.GA19099@tower.DHCP.thefacebook.com>
References: <20190225201635.4648-1-hannes@cmpxchg.org>
In-Reply-To: <20190225201635.4648-1-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:104:1::17) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:a769]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd5201c6-67da-48ed-16a7-08d69c451cf3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2375;
x-ms-traffictypediagnostic: BYAPR15MB2375:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2375;20:jOxA6uZUj6yEwHDlMXA4c2ziLhjW0XLXl3GjrSR/ooJt156nOBBvJxGpbBxbVgT6Z2h6zVnQosFLsPsCrBMoMOlBD07S2ZhorIK9Cplk/PEd69AjI2w4gdm0TgtFhvk7uUqjMY/8KJ/pVplLsCuaNQG0RREIKFZS1oU4APm8s2s=
x-microsoft-antispam-prvs: <BYAPR15MB23752279E0323F92E113896BBE7B0@BYAPR15MB2375.namprd15.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39860400002)(52314003)(189003)(199004)(8676002)(81156014)(81166006)(186003)(46003)(8936002)(2501003)(486006)(305945005)(7736002)(33656002)(52116002)(53936002)(102836004)(76176011)(446003)(478600001)(11346002)(476003)(14454004)(68736007)(97736004)(105586002)(6506007)(386003)(106356001)(7416002)(25786009)(9686003)(6512007)(86362001)(6246003)(256004)(6116002)(6486002)(99286004)(229853002)(2201001)(5660300002)(4326008)(1076003)(316002)(2906002)(7116003)(221733001)(6436002)(71190400001)(71200400001)(54906003)(110136005)(3480700005)(111123002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2375;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8en2ZygQCyFMTgMIWqn0+8YSfGz91T0Ce3PcLbWIu4NqebuclEYHehT2gr3UPGtgShGcWqgwPt4zI8554/5w2hySpN/BGEA50/dZpQqjo6pK8w5t5rN/WSw06TNeyDVPYdBf62vpvCmQbj1P4KNiH6AjJuwKV6mvey5k89BFulfEF3iB9lSHNk+tNruwLIGfJpI5Woq0XeGTY6DrJDIvGkD1l6je/hip7gc3WvwUyTm2bpaQjn1mWCHvydelxATHU8wqcoULjD3NuoR3ajBivatGcy3PbaAWJwcBZN6WV3EUMvPvMg0mqJvVK4+WJDQupLnnkcV0Gb9i2/ByMt1O2GnmF68HW8L7d7ZPvZqd46Gj3No0fSkpCGYoYdRci0WmNb2mbvM9IQ5GYHmw244wIKpyQb3uviObsGjq9Y8Wj14=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09E3E0D2F7346B45B659EA0BC27E7BB7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5201c6-67da-48ed-16a7-08d69c451cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 23:49:56.5128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2375
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 03:16:29PM -0500, Johannes Weiner wrote:
> [resending, rebased on top of latest mmots]
>=20
> The memcg LRU stats usage is currently a bit messy. Memcg has private
> per-zone counters because reclaim needs zone granularity sometimes,
> but we also have plenty of users that need to awkwardly sum them up to
> node or memcg granularity. Meanwhile the canonical per-memcg vmstats
> do not track the LRU counts (NR_INACTIVE_ANON etc.) as you'd expect.
>=20
> This series enables LRU count tracking in the per-memcg vmstats array
> such that lruvec_page_state() and memcg_page_state() work on the enum
> node_stat_item items for the LRU counters. Then it converts all the
> callers that don't specifically need per-zone numbers over to that.

The updated version looks very good* to me!
Please, feel free to use:
Reviewed-by: Roman Gushchin <guro@fb.com>

Looking through the patchset, I have a feeling that we're sometimes
gathering too much data. Perhaps we don't need the whole set
of counters to be per-cpu on both memcg- and memcg-per-node levels.
Merging them can save quite a lot of space. Anyway, it's a separate
topic.

* except "to" and "subject" of the cover letter

Thanks!
