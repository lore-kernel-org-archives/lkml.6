Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC029C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850052083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pyCoRTUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850052083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeGaOaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:30:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732084AbeGaOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:30:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6VC4LIs143099
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=2MXB3iVkA8QFA8HxEUSDNwnHF8DeFIVsXeAJGBk8AFs=;
 b=pyCoRTUnEkfExszTViZg8nPZh/yeXhR/H/ui9hdg2qoxh4yASUC6OTjxklUFSoE/dbQw
 Ju4Yg1KQdjZ7M8MdyVuqJoJFcub1HtilnfPN03SNEKlmlFx0DPoj+Vu00elsiR/cTaFL
 UUSG/R0I4+AJrZ9e9c8kDGnLWD2NaNh9NOiTeiZJAQamgpe9/bRONjE+JCzar4i9mvLd
 Im8zOVGGoJm8TCMYdAtoTxYmpDUB2gbv7WLQU+BT0P76D/2/sx+YMvneqgbDl8OcCXMl
 ritRa5sUWUO+Yxm1PyCJcGMVJlB1r9ltyxdLUmIxGo7jS+r7qm/ZpXH0PkFl5mPkVVCL Vg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kgfwt0udq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:49:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6VCnmqV031032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:49:49 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6VCnm1g016095
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:49:48 GMT
Received: from mail-oi0-f50.google.com (/209.85.218.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 05:49:48 -0700
Received: by mail-oi0-f50.google.com with SMTP id v8-v6so27655881oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 05:49:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlGlCETGS/3Z4PoQC1H9lsz/Z/hCvT6gJs0QNRocOHVc16t9iBPc
        pqLkq3AhyVPSc0PyzaMLezVcexT32zGGVBgGjMs=
X-Google-Smtp-Source: AAOMgpeBB0rxS5qTXptZgzJkyqHlDGiOHe7fnNyJBY8BDUQXEoYqZbzXzMsKV0jrPw+LaAulhvelP9XW2o8Tt60uTnM=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr20785817oig.221.1533041387799;
 Tue, 31 Jul 2018 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180731124504.27582-1-osalvador@techadventures.net>
In-Reply-To: <20180731124504.27582-1-osalvador@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 31 Jul 2018 08:49:11 -0400
X-Gmail-Original-Message-ID: <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
Message-ID: <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

Have you looked into replacing __paginginit via __meminit ? What is
the reason to keep both?

Thank you,
Pavel
On Tue, Jul 31, 2018 at 8:45 AM <osalvador@techadventures.net> wrote:
>
> From: Oscar Salvador <osalvador@suse.de>
>
> __pagininit macro is being used to mark functions for:
>
> a) Functions that we do not need to keep once the system is fully
>    initialized with regard to memory.
> b) Functions that will be needed for the memory-hotplug code,
>    and because of that we need to keep them after initialization.
>
> Right now, the condition to choose between one or the other is based on
> CONFIG_SPARSEMEM, but I think that this should be changed to be based
> on CONFIG_MEMORY_HOTPLUG.
>
> The reason behind this is that it can very well be that we have CONFIG_SPARSEMEM
> enabled, but not CONFIG_MEMORY_HOTPLUG, and thus, we will not need the
> functions marked as __paginginit to stay around, since no
> memory-hotplug code will call them.
>
> Although the amount of freed bytes is not that big, I think it will
> become more clear what __paginginit is used for.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/internal.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 33c22754d282..c9170b4f7699 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -392,10 +392,11 @@ static inline struct page *mem_map_next(struct page *iter,
>  /*
>   * FLATMEM and DISCONTIGMEM configurations use alloc_bootmem_node,
>   * so all functions starting at paging_init should be marked __init
> - * in those cases. SPARSEMEM, however, allows for memory hotplug,
> - * and alloc_bootmem_node is not used.
> + * in those cases.
> + * In case that MEMORY_HOTPLUG is enabled, we need to keep those
> + * functions around since they can be called when hot-adding memory.
>   */
> -#ifdef CONFIG_SPARSEMEM
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  #define __paginginit __meminit
>  #else
>  #define __paginginit __init
> --
> 2.13.6
>
