Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA6DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF672089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HbITagNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF672089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbeG0QrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:47:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42366 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbeG0QrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:47:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6RFNmVs189449
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=skjkf7aBTKKGznsfdEOfw+7smWCmmo9dqnyYpDI2CGE=;
 b=HbITagNgR+Lnlrhr1QhSBkOzhVyOkA9nhAYYpqyk0P9BqT0pNotQpzfdWvoZdhBAjsxq
 75+6J1c+JNMsfVYUtpYFfKY3+GqIOkhX60W0zm4ltRNJfTZqbUVGM/67GpwCQgQxeGsZ
 KL2D8QVpz0Mo4dkaBxbf8iDx7lyZyYiwj2kjnTNQcY72/nmk6pY5Ve7bw+0sNe9KhINO
 /qVgbiArd3uJU3+1elrHFaA4nRX3gROVADU9DpFI8pPk4Dg+Y6HM3e0xVSL1b6Js5M2+
 zVc3IJw4AlOaOGk8fdUcIkwuowwb1ERyZQVXBaHk6o9MPlrpYKjo+yWkfzLjHlDV6jGL /w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2kbtbd7tu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:24:53 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6RFOqNT017390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:24:52 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6RFOqMc019146
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:24:52 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Jul 2018 08:24:52 -0700
Received: by mail-oi0-f44.google.com with SMTP id n21-v6so9727589oig.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 08:24:51 -0700 (PDT)
X-Gm-Message-State: AOUpUlENUnjxiE4KC8sXs9kyrPFnjuOZR2laA4czV5PC7Tc1x1uO1rXd
        Y0qYhXXuJG10R0mDhUM8NvELtovbvvc5iMGUSkQ=
X-Google-Smtp-Source: AAOMgpcLkU8040I9ZT5Jj2wWim+QJBPYa2bAM4ScJoiI3FcXh3hHJL49WDrYLN97ib0CyUpH+kxgXLn1w6KE2Oep5CI=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr7352457oiy.191.1532705091387;
 Fri, 27 Jul 2018 08:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180727140325.11881-1-osalvador@techadventures.net> <20180727140325.11881-5-osalvador@techadventures.net>
In-Reply-To: <20180727140325.11881-5-osalvador@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 27 Jul 2018 11:24:15 -0400
X-Gmail-Original-Message-ID: <CAGM2reY-uUTBYUY9XhhQqm6CRWjFsH0fxJ1H7D3+-0Lbyy8HTg@mail.gmail.com>
Message-ID: <CAGM2reY-uUTBYUY9XhhQqm6CRWjFsH0fxJ1H7D3+-0Lbyy8HTg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm/page_alloc: Introduce free_area_init_core_hotplug
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8966 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807270157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

>  static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)

Remove __ref from this function and add it to
free_area_init_core_hotplug() instead, as that is the only function
from a different section. This will reduce the scope of ref, and no
need to place reset_node_managed_pages() into a different section as
it is compiled only when CONFIG_MEMORY_HOTPLUG=y

> +#ifdef CONFIG_MEMORY_HOTPLUG
> +void __paginginit free_area_init_core_hotplug(int nid)
> +{
> +       enum zone_type j;
> +       pg_data_t *pgdat = NODE_DATA(nid);
> +
> +       pgdat_init_internals(pgdat);
> +       for (j = 0; j < MAX_NR_ZONES; j++) {
> +               struct zone *zone = pgdat->node_zones + j;
> +               zone_init_internals(zone, j, nid, 0);
> +       }
> +}

Style: I would write the for() loop above like this:

        for (i = 0; i < MAX_NR_ZONES; i++)
                zone_init_internals(&pgdat->node_zones[i], i, nid, 0);

Other than this all good:
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Thank you,
Pavel
