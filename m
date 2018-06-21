Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34266C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BCC20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VMVJWBi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BCC20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeFUCDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:03:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35490 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754186AbeFUCDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:03:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L2041D033761
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=bPDabLFm/GD1lN7nSnmXAAMn5M+wEK6RlHiUeWSevoE=;
 b=VMVJWBi5KGmybqUU23mC/e/MjKSlc43zfRbnpb5MZ4k+PQnzojI7zSaAscTjqsb3FAmr
 yLdCFdG+RB2rlDeBuIIO1fnDy5ctyT1AogWFndkN+dKCI9V2qPNsQ5U6X3j4POY4onFW
 1crjajgOsU+yL1yNO0HRFmGyS2m1mtQAWixRabZaS8/WRCn0t/cy42nQ5FJlLoriqni0
 vgIAkRpWkYw4qAOesR67VtBzO6UEKWocKMNhtaqkMVBTBWQyfUEqJiMh2D0HXgtA2u8L
 Pbbbd1Xozja/SHWqcTde9BP9txxpA+vZLLJbR4jiN8C44nYhxtJd6EiI8FhxQ5bg8PBF vw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jmtgwxu2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:03:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5L23lHX031304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:03:47 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5L23ln6025936
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:03:47 GMT
Received: from mail-ot0-f171.google.com (/74.125.82.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 19:03:47 -0700
Received: by mail-ot0-f171.google.com with SMTP id q17-v6so1781727otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 19:03:47 -0700 (PDT)
X-Gm-Message-State: APt69E1k/9DPxEJu2i4yI8zrteZs6GutlaWuDm5lRJJPfrjcmdbsZx57
        BlzULUoKtK17erdvwuxqX5nrdd6oMLH8c9+SgvY=
X-Google-Smtp-Source: ADUXVKLPl3HzJJpUDTmxGsnzYo3fDlW4K3oWlEcWFwIUwkAfOSIBRpxxKNBygUNGuR4xh4Xu2lW27ieddo0qeZUxoKw=
X-Received: by 2002:a9d:2010:: with SMTP id n16-v6mr13551535ota.275.1529546627039;
 Wed, 20 Jun 2018 19:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180601125321.30652-1-osalvador@techadventures.net> <20180601125321.30652-3-osalvador@techadventures.net>
In-Reply-To: <20180601125321.30652-3-osalvador@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 20 Jun 2018 22:03:11 -0400
X-Gmail-Original-Message-ID: <CAGM2rebO04-AqvZNFLtZ=JVOieY_qr=e=k9G3yS4g+-cO96wrA@mail.gmail.com>
Message-ID: <CAGM2rebO04-AqvZNFLtZ=JVOieY_qr=e=k9G3yS4g+-cO96wrA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/memory_hotplug: Call register_mem_sect_under_node
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=926
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 8:54 AM <osalvador@techadventures.net> wrote:
>
> From: Oscar Salvador <osalvador@suse.de>
>
> When hotpluging memory, it is possible that two calls are being made
> to register_mem_sect_under_node().
> One comes from __add_section()->hotplug_memory_register()
> and the other from add_memory_resource()->link_mem_sections() if
> we had to register a new node.
>
> In case we had to register a new node, hotplug_memory_register()
> will only handle/allocate the memory_block's since
> register_mem_sect_under_node() will return right away because the
> node it is not online yet.

Indeed.

>
> I think it is better if we leave hotplug_memory_register() to
> handle/allocate only memory_block's and make link_mem_sections()
> to call register_mem_sect_under_node().

Agree, this makes the code simpler.

Please remove:
> +register_fail:
> +       /*
> +        * If sysfs file of new node can't create, cpu on the node
> +        * can't be hot-added. There is no rollback way now.
> +        * So, check by BUG_ON() to catch it reluctantly..
> +        */
> +       BUG_ON(ret);

Merge the above comment with:
> +               /* we online node here. we can't roll back from here. */

And replace all:
> +       if (ret)
> +               goto register_fail;

With:
BUG_ON(ret);

With the above addressed:

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
