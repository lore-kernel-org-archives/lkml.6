Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B56C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FED125BA6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O0Ai8OLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FED125BA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeF1DMP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:12:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47336 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeF1DMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:12:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5S38ib6114540
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=iBWHzlbbpRytL0EaAyMctXEsSJ2EInu3/nZSqDgBDEc=;
 b=O0Ai8OLVyAq371KuVyKKCuF7+U6GEW6TdJQT7N3rtwNnlNdmJaUneOSDaDQk50VyxadF
 i2+6EsM0Tb6LzfbzUfoRTMj0UI+6H/e/vaLP8xlHcJoDRZBp7gt2VspFVaNEtDaV7+Nr
 C+ChBOADmXcF44SXPP6x5S0IZ8OYSa/ohiuZLiZGMwxS335ZHbl1IsldghhPmDI1paOk
 aXiHbRAWjPeceet9lScv8ut9zcCELdOcgDRSWsvMl+asJ85aVDMMLZSLFwt8XPRN2q2Z
 rUELBaoi73Y1IJtEB9E8wnZPrMS9VzdRQUGDj1U8/DgTyCaHtswEkzS+jdVRu/jJJiIH fw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jukmtyqhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:12:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5S3CCie010749
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:12:12 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5S3CBH4029077
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:12:12 GMT
Received: from mail-oi0-f41.google.com (/209.85.218.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 20:12:11 -0700
Received: by mail-oi0-f41.google.com with SMTP id r16-v6so3313877oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 20:12:11 -0700 (PDT)
X-Gm-Message-State: APt69E2E+lC1PCg5s70ouo+xnUZu7YpB6YPcUi0s7dQ2z4ktd/VIHaeq
        JpwuRu8bw69X6K9SQp6/+cJiM5NO6Nwp/rIPvPQ=
X-Google-Smtp-Source: AAOMgpeRO/4hWwg5SPkSCIFBhcrptbz+Elgx6RZHdXUtMAm0iVS6nTuchD4ohkuaHw3aGrgBEmfd4aC5evpv5iqYZEs=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr5043469oig.339.1530155531435;
 Wed, 27 Jun 2018 20:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180627013116.12411-1-bhe@redhat.com> <20180627013116.12411-3-bhe@redhat.com>
 <20180627095439.GA5924@techadventures.net> <20180627225945.GD8970@localhost.localdomain>
In-Reply-To: <20180627225945.GD8970@localhost.localdomain>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 27 Jun 2018 23:11:35 -0400
X-Gmail-Original-Message-ID: <CAGM2reaS=KsD1OTxO9OYGdVuVyQb72ew=XQus2sJ-zAUbTAvpQ@mail.gmail.com>
Message-ID: <CAGM2reaS=KsD1OTxO9OYGdVuVyQb72ew=XQus2sJ-zAUbTAvpQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm/sparsemem: Defer the ms->section_mem_map clearing
To:     bhe@redhat.com
Cc:     osalvador@techadventures.net, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once you remove the ms mentioned by Oscar:
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
On Wed, Jun 27, 2018 at 6:59 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 06/27/18 at 11:54am, Oscar Salvador wrote:
> > On Wed, Jun 27, 2018 at 09:31:14AM +0800, Baoquan He wrote:
> > > In sparse_init(), if CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y, system
> > > will allocate one continuous memory chunk for mem maps on one node and
> > > populate the relevant page tables to map memory section one by one. If
> > > fail to populate for a certain mem section, print warning and its
> > > ->section_mem_map will be cleared to cancel the marking of being present.
> > > Like this, the number of mem sections marked as present could become
> > > less during sparse_init() execution.
> > >
> > > Here just defer the ms->section_mem_map clearing if failed to populate
> > > its page tables until the last for_each_present_section_nr() loop. This
> > > is in preparation for later optimizing the mem map allocation.
> > >
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  mm/sparse-vmemmap.c |  1 -
> > >  mm/sparse.c         | 12 ++++++++----
> > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > > index bd0276d5f66b..640e68f8324b 100644
> > > --- a/mm/sparse-vmemmap.c
> > > +++ b/mm/sparse-vmemmap.c
> > > @@ -303,7 +303,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
> > >             ms = __nr_to_section(pnum);
> > >             pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
> > >                    __func__);
> > > -           ms->section_mem_map = 0;
> >
> > Since we are deferring the clearing of section_mem_map, I guess we do not need
> >
> > struct mem_section *ms;
> > ms = __nr_to_section(pnum);
> >
> > anymore, right?
>
> Right, good catch, thanks.
>
> I will post a new round to fix this.
>
> >
> > >     }
> > >
> > >     if (vmemmap_buf_start) {
> > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > index 6314303130b0..71ad53da2cd1 100644
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -451,7 +451,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
> > >             ms = __nr_to_section(pnum);
> > >             pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
> > >                    __func__);
> > > -           ms->section_mem_map = 0;
> >
> > The same goes here.
> >
> >
> >
> > --
> > Oscar Salvador
> > SUSE L3
>
