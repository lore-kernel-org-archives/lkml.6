Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C58C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC05820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B4huhDZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC05820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbeFUCil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:38:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbeFUCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:38:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L2Y7U5013729
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=H/IJKHaYIWp2ZcugSCIGPnPhNSXHinXn4VUMQHZSd1w=;
 b=B4huhDZ6vWKh9OuvyCvwHEGRpzKDN7vd8X953Egub/0cpDIpF9Mswgad1MG4AW4/aOrK
 5L48JgkzFlL0brvsIvoH9XqffYC68somi6qqOMxFxI76RpUa9lz6PJgRw82SDZXYnuNp
 pAEtM1T+fyUiT53Hj8R0eOI078TRsDrEgPQLgzbOu+QZwBoOXr2J5clHsH0I8sUpVsfM
 KYX8HnlKyVwVZ+8IObMsHTOneeRC5HRiDDDAFlxAnVaYA37CeRWsMMad4IIdMvI2gcK4
 dRc3uoaCcwSmXIf97jb7pUnd+c+rA9o65tWR/HGueVVI/CqKPn0oscc4BpR1cxVIxAd+ Hw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jmu6xxujc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:38:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5L2ccxF018597
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:38:39 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5L2ccta022220
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:38:38 GMT
Received: from mail-ot0-f177.google.com (/74.125.82.177)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 19:38:38 -0700
Received: by mail-ot0-f177.google.com with SMTP id 101-v6so1849257oth.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 19:38:38 -0700 (PDT)
X-Gm-Message-State: APt69E1BKmsa/nR7Fq+J79WCJDju/md7yQ1i4Ux1LpJh7uEVnwNDCrmA
        w4PtMVOHj+W7c+elKWwtasL+k8bF0+VbaTWJQy4=
X-Google-Smtp-Source: ADUXVKI6CtVHrpARcN0qhNienPFzWERaG6bXQ5qR8/S6lTorgnv1vAjE4Z+ISuZPB0VdTyyNct1oU5DDm9FyiR7luqQ=
X-Received: by 2002:a9d:4e12:: with SMTP id p18-v6mr15338465otf.260.1529548718263;
 Wed, 20 Jun 2018 19:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180601125321.30652-1-osalvador@techadventures.net> <20180601125321.30652-5-osalvador@techadventures.net>
In-Reply-To: <20180601125321.30652-5-osalvador@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 20 Jun 2018 22:38:02 -0400
X-Gmail-Original-Message-ID: <CAGM2reYDLK1dE3RO3AoYNGzHX9HcozAxKvW+jzrgCThvTzjMpw@mail.gmail.com>
Message-ID: <CAGM2reYDLK1dE3RO3AoYNGzHX9HcozAxKvW+jzrgCThvTzjMpw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/memory_hotplug: Drop unnecessary checks from register_mem_sect_under_node
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 8:54 AM <osalvador@techadventures.net> wrote:
>
> From: Oscar Salvador <osalvador@suse.de>
>
> Callers of register_mem_sect_under_node() are always passing a valid
> memory_block (not NULL), so we can safely drop the check for NULL.
>
> In the same way, register_mem_sect_under_node() is only called in case
> the node is online, so we can safely remove that check as well.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

> ---
>  drivers/base/node.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 248c712e8de5..681be04351bc 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -415,12 +415,7 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
>         int ret;
>         unsigned long pfn, sect_start_pfn, sect_end_pfn;
>
> -       if (!mem_blk)
> -               return -EFAULT;
> -
>         mem_blk->nid = nid;
> -       if (!node_online(nid))
> -               return 0;
>
>         sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
>         sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
> --
> 2.13.6
>
