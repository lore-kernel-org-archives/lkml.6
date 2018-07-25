Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD92C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426B820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yoBD49va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426B820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbeGYClK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:41:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40960 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388509AbeGYClK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:41:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6P1TtGB160626
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=8hYh5etpKcEg7NMOaeycEwPtf5BmORaV3snvuFH9OTA=;
 b=yoBD49va20d9iv9WTGUMV7G+oqSrAJQ+MA6h9nTYaWPGccsGOBC1uKww9Hur1i5YhbFA
 9P/DlhgUDCc58UPkMub9r20k/pIHc/hduPG/ZsejU8xJKocuKxYD9jPeqtf4b+jPuzh2
 pJGOdCN1rLlr6vARyQHUWifbutncoi++oTpSsNGOu46G/h+ATr1LDoND5fVR+qScICsE
 lgCS35Pa6w3iwuV1/L/z2+v8cqIJX++3lj3nPYrNgGKNFyDPOkXhhHiJzwhHO3hhcNYV
 Rh4ujkcYq5MWoT2I8AuvzO8+PTjYGtQOAAEmna66em3psUZ9n87onDI19w7190KkbwAU pA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kbv8t3e6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:31:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6P1VtoC014857
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:31:55 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6P1VtH6006707
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:31:55 GMT
Received: from mail-oi0-f50.google.com (/209.85.218.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 18:31:54 -0700
Received: by mail-oi0-f50.google.com with SMTP id b15-v6so11005600oib.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 18:31:54 -0700 (PDT)
X-Gm-Message-State: AOUpUlHnz0paemgh6Rc3UU7jwRlpQdgVVhOqatq9kfHX4yp/vU78Xwry
        Qsx0WQpw7+Ag4/+fbC4kWpf6q5nsOSJMle48/kQ=
X-Google-Smtp-Source: AAOMgpd/SERYFuOdpqoszsLFBeejNB7CZO1LjoXjXM8lKCVs4sZOEtoZlXnyiYm66cFI4ig9ZEpokYw8s4qwPjk0+/0=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr1338488oia.229.1532482314647;
 Tue, 24 Jul 2018 18:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
 <20180724235520.10200-4-pasha.tatashin@oracle.com> <20180724181800.3f25fdf8bcf0d8fd05ea1f43@linux-foundation.org>
In-Reply-To: <20180724181800.3f25fdf8bcf0d8fd05ea1f43@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 24 Jul 2018 21:31:18 -0400
X-Gmail-Original-Message-ID: <CAGM2reaV09L0EVXa=3Ja4sjcEVCjXq0=iCxkruYLgqsxJaAo7g@mail.gmail.com>
Message-ID: <CAGM2reaV09L0EVXa=3Ja4sjcEVCjXq0=iCxkruYLgqsxJaAo7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: move mirrored memory specific code outside of memmap_init_zone
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 24 Jul 2018 19:55:20 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
>
> > memmap_init_zone, is getting complex, because it is called from different
> > contexts: hotplug, and during boot, and also because it must handle some
> > architecture quirks. One of them is mirroed memory.
> >
> > Move the code that decides whether to skip mirrored memory outside of
> > memmap_init_zone, into a separate function.
>
> Conflicts a bit with the page_alloc.c hunk from
> http://ozlabs.org/~akpm/mmots/broken-out/mm-page_alloc-remain-memblock_next_valid_pfn-on-arm-arm64.patch.  Please check my fixup:

The merge looks good to me. Thank you.

>
> void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                 unsigned long start_pfn, enum memmap_context context,
>                 struct vmem_altmap *altmap)
> {
>         unsigned long pfn, end_pfn = start_pfn + size;
>         struct page *page;
>
>         if (highest_memmap_pfn < end_pfn - 1)
>                 highest_memmap_pfn = end_pfn - 1;
>
>         /*
>          * Honor reservation requested by the driver for this ZONE_DEVICE
>          * memory
>          */
>         if (altmap && start_pfn == altmap->base_pfn)
>                 start_pfn += altmap->reserve;
>
>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>                 /*
>                  * There can be holes in boot-time mem_map[]s handed to this
>                  * function.  They do not exist on hotplugged memory.
>                  */
>                 if (context == MEMMAP_EARLY) {
>                         if (!early_pfn_valid(pfn)) {
>                                 pfn = next_valid_pfn(pfn) - 1;

I wish we did not have to do next_valid_pfn(pfn) - 1, and instead
could do something like:
for (pfn = start_pfn; pfn < end_pfn; pfn = next_valid_pfn(pfn))

Of course the performance of next_valid_pfn() should be optimized on
arm for the common case where next valid pfn is pfn++.

Pavel
