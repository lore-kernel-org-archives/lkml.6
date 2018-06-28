Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B61D25DD7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TV34qsfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B61D25DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932991AbeF1DPY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:15:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33882 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932577AbeF1DPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:15:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5S3Da3F130162
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=4PexRsgmYxaXT06mG9CE6yW84FDrnUz0NxjnxEhm5jQ=;
 b=TV34qsfj4V2Dqpld2RmH3AS0DxT/PJmIZqjMy/1M7k6+m56CWHaZg26MqB+YNLH+haNp
 TgR738hiBmQxJSuuff6ayux79q7tmclZX7mbWMFYVE/o2klflcFXvu+CYMXpeMem+FVF
 zxInd5x3itrTXvW01/2FuxCLRCbQSWTV7xFKuzZY0yGFSMI1D7EAJqqC4//ZXBkJSF31
 NwFdBnXZIXC4Q8CXeie9XXEAg6BjzjfHx3iSxNl+mjiehRStHCqHolCJCSx4LLPg6td6
 L6ChAw10ZaZHpaiGVH3jT0H/uR/jXxA/YzfykNva4R6f714qKjwuamJZSHS0WDSoyIZ7 5A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmtywxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:15:22 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5S3FLDX007642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:15:21 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5S3FLvs020024
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:15:21 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 20:15:21 -0700
Received: by mail-oi0-f51.google.com with SMTP id f79-v6so3816143oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 20:15:20 -0700 (PDT)
X-Gm-Message-State: APt69E04Y2Mm8BRRlBD+S9PITM2jjtBdWaouBg0FPyLM+9rxHYtwNmrr
        2KnjUX7ZOQQTmzPddmaeusxiEW9Z+EsdAv/CXvw=
X-Google-Smtp-Source: AAOMgpeE8gn1w8kbjsEAg54W2/Td9EMvfNgK5+PWM3O2zokzaTiJXarkq5Hq9AmYg0m2P/Vq37+QXtTqUyGTQO992D4=
X-Received: by 2002:aca:3243:: with SMTP id y64-v6mr5086597oiy.136.1530155720695;
 Wed, 27 Jun 2018 20:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180627013116.12411-1-bhe@redhat.com> <20180627013116.12411-4-bhe@redhat.com>
In-Reply-To: <20180627013116.12411-4-bhe@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 27 Jun 2018 23:14:44 -0400
X-Gmail-Original-Message-ID: <CAGM2reb=2fmgJQzfPGJ_bCG-317-dsFfoG8vSr9LuYit4AVsyQ@mail.gmail.com>
Message-ID: <CAGM2reb=2fmgJQzfPGJ_bCG-317-dsFfoG8vSr9LuYit4AVsyQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm/sparse: Add a new parameter 'data_unit_size'
 for alloc_usemap_and_memmap
To:     bhe@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honestly, I do not like this new agrument, but it will do for now. I
could not think of a better way without rewriting everything.

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

However, I will submit a series of patches to cleanup sparse.c and
completely remove large and confusing temporary buffers: map_map, and
usemap_map. In those patches, I will remove alloc_usemap_and_memmap().
On Tue, Jun 26, 2018 at 9:31 PM Baoquan He <bhe@redhat.com> wrote:
>
> alloc_usemap_and_memmap() is passing in a "void *" that points to
> usemap_map or memmap_map. In next patch we will change both of the
> map allocation from taking 'NR_MEM_SECTIONS' as the length to taking
> 'nr_present_sections' as the length. After that, the passed in 'void*'
> needs to update as things get consumed. But, it knows only the
> quantity of objects consumed and not the type.  This effectively
> tells it enough about the type to let it update the pointer as
> objects are consumed.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 71ad53da2cd1..b2848cc6e32a 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -489,10 +489,12 @@ void __weak __meminit vmemmap_populate_print_last(void)
>  /**
>   *  alloc_usemap_and_memmap - memory alloction for pageblock flags and vmemmap
>   *  @map: usemap_map for pageblock flags or mmap_map for vmemmap
> + *  @unit_size: size of map unit
>   */
>  static void __init alloc_usemap_and_memmap(void (*alloc_func)
>                                         (void *, unsigned long, unsigned long,
> -                                       unsigned long, int), void *data)
> +                                       unsigned long, int), void *data,
> +                                       int data_unit_size)
>  {
>         unsigned long pnum;
>         unsigned long map_count;
> @@ -569,7 +571,8 @@ void __init sparse_init(void)
>         if (!usemap_map)
>                 panic("can not allocate usemap_map\n");
>         alloc_usemap_and_memmap(sparse_early_usemaps_alloc_node,
> -                                                       (void *)usemap_map);
> +                               (void *)usemap_map,
> +                               sizeof(usemap_map[0]));
>
>  #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
>         size2 = sizeof(struct page *) * NR_MEM_SECTIONS;
> @@ -577,7 +580,8 @@ void __init sparse_init(void)
>         if (!map_map)
>                 panic("can not allocate map_map\n");
>         alloc_usemap_and_memmap(sparse_early_mem_maps_alloc_node,
> -                                                       (void *)map_map);
> +                               (void *)map_map,
> +                               sizeof(map_map[0]));
>  #endif
>
>         for_each_present_section_nr(0, pnum) {
> --
> 2.13.6
>
