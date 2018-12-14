Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5FB208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DrwMNVOC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NNRRo8KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbeLNV6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:58:30 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56788 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730987AbeLNV6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:58:30 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBELvSus008224;
        Fri, 14 Dec 2018 13:57:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=h/DScmKHnQ0tHXnmkOFx+tNgVsHO7n8i6Yxpl7bM0+U=;
 b=DrwMNVOCZlyfAhvKzHF73NkJ2bkIdUGa9Xz3JEzzKIy+Ls6qy1c2RnPFjMj2ZyUy8dSa
 PPE4mAwhPyPI/P9dCbbbVlmpRtZIrmDJjgdYTxbVzPr4nK97NL8daQmSJeWdIl8pbAa2
 fS/afRgfQlBWPL92EDLSBup5e4V2eOB4cdU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2pckmwr79h-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 13:57:38 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 13:57:21 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 13:57:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 14 Dec 2018 13:57:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/DScmKHnQ0tHXnmkOFx+tNgVsHO7n8i6Yxpl7bM0+U=;
 b=NNRRo8KO1KfOs8pPTr1Fsv3eU1lIQ4C0R9GpgjkJ5bpM49p7VDpHoWC7BdMKlmlYpIB7QJvLHULSrgeSkp0ZpRiHyLlH0EGqihVAv0+1bv2U7a1NOnfDzsflvmYNsq3iMTxkWLaVT7AsHRswp2PRXWMdSdg03H0Q70b38fYluHI=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3512.namprd15.prod.outlook.com (20.179.60.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 21:57:19 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 21:57:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Joe Perches <joe@perches.com>, Roman Gushchin <guroan@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [RFC 2/4] mm: separate memory allocation and actual work in
 alloc_vmap_area()
Thread-Topic: [RFC 2/4] mm: separate memory allocation and actual work in
 alloc_vmap_area()
Thread-Index: AQHUk9fzDSxUUU4eTEmN2i0i66X5W6V+ibUAgAAYaoCAAAEwAIAAJPOA
Date:   Fri, 14 Dec 2018 21:57:19 +0000
Message-ID: <20181214215713.GA27488@tower.DHCP.thefacebook.com>
References: <20181214180720.32040-1-guro@fb.com>
 <20181214180720.32040-3-guro@fb.com>
 <20181214181322.GC10600@bombadil.infradead.org>
 <0192c1984f42ad0a33e4c9aca04df90c97ebf412.camel@perches.com>
 <20181214194500.GF10600@bombadil.infradead.org>
In-Reply-To: <20181214194500.GF10600@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:300:4b::27) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:3282]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3512;20:wEJdKAKMcDJl0jTYXXN1q3tKld09zaUmHxtEKjafQpy5HpoUgfEZ2QhfJ8GcvBiT+4KsxT1uQj5gQ+tNJN4gwU2ziACbNaiteyPjCf0HhMboO5dN4teqDuDcs/ihB0KXrhPpWipqmI3wp8U7nLqFj8LPmaGBBT7xBurLSsR8Wyc=
x-ms-office365-filtering-correlation-id: 92219e0a-7e0c-46a1-cbab-08d6620f1e52
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3512;
x-ms-traffictypediagnostic: BYAPR15MB3512:
x-microsoft-antispam-prvs: <BYAPR15MB35129190624CD8D5E0BEFEC2BEA10@BYAPR15MB3512.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB3512;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB3512;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(305945005)(105586002)(7736002)(6916009)(478600001)(2906002)(6116002)(6486002)(14454004)(229853002)(256004)(6436002)(1076002)(11346002)(6506007)(46003)(186003)(33896004)(4326008)(386003)(102836004)(486006)(6246003)(53936002)(68736007)(25786009)(446003)(9686003)(6512007)(86362001)(5660300001)(52116002)(99286004)(39060400002)(76176011)(8936002)(54906003)(316002)(8676002)(33656002)(93886005)(81166006)(71190400001)(71200400001)(81156014)(106356001)(4001150100001)(476003)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3512;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0Z1G/hhkmdLM5n/CIpMtQ0ZFuxpfSNrguTk76gwtq6mHeonW11QG6O+uWYwMv4I4Z2c2PLApxlgCSxSDVZQm79G+l1ITfsQw2sfYhPWkwNyFwfvqiFEXZktkZFNDwH//XaAsvZCCcLclawn/EEDtsUlwQMmTWkaYfLzKDon/OpajWffsFei8rz8rSdbOSKcUbrr23BDzPOYH3JGxVyfrqwoCrmtZjUKT33hqNJiMgHmzeSfE0P6sx6/bOGjuffEKVvxYFiZbJ1fPgaoh3o55CVod0+U9Hq8DHyZRCNayfywqvIeBudnTrBvmj8G8nigV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B16C1316E2CD244C86578D5E121C40FD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92219e0a-7e0c-46a1-cbab-08d6620f1e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 21:57:19.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:45:00AM -0800, Matthew Wilcox wrote:
> On Fri, Dec 14, 2018 at 11:40:45AM -0800, Joe Perches wrote:
> > On Fri, 2018-12-14 at 10:13 -0800, Matthew Wilcox wrote:
> > > On Fri, Dec 14, 2018 at 10:07:18AM -0800, Roman Gushchin wrote:
> > > > +/*
> > > > + * Allocate a region of KVA of the specified size and alignment, w=
ithin the
> > > > + * vstart and vend.
> > > > + */
> > > > +static struct vmap_area *alloc_vmap_area(unsigned long size,
> > > > +					 unsigned long align,
> > > > +					 unsigned long vstart,
> > > > +					 unsigned long vend,
> > > > +					 int node, gfp_t gfp_mask)
> > > > +{
> > > > +	struct vmap_area *va;
> > > > +	int ret;
> > > > +
> > > > +	va =3D kmalloc_node(sizeof(struct vmap_area),
> > > > +			gfp_mask & GFP_RECLAIM_MASK, node);
> > > > +	if (unlikely(!va))
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	ret =3D init_vmap_area(va, size, align, vstart, vend, node, gfp_m=
ask);
> > > > +	if (ret) {
> > > > +		kfree(va);
> > > > +		return ERR_PTR(ret);
> > > > +	}
> > > > +
> > > > +	return va;
> > > >  }
> > > > =20
> > > > +
> > >=20
> > > Another spurious blank line?
> >=20
> > I don't think so.
> >=20
> > I think it is the better style to separate
> > the error return from the normal return.
>=20
> Umm ... this blank line changed the file from having one blank line
> after the function to having two blank lines after the function.
>=20

Yes, it's an odd free line (here and above), will remove them in v2.
Thanks!
