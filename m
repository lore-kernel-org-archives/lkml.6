Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81FC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EE220837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lTzW6mz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EE220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeFUCgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:36:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52682 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754434AbeFUCf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:35:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L2ZEBU014707
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=6yh9hYRQplYwLF5Kh8HhMHyQexzr8imPOOm+IsSPxIw=;
 b=lTzW6mz1tsyfz0o74YXBP+i7//aakeX5oLjnXniV2b4+l3hG5Q5Y1trxhvSsMGczR/kH
 5QzkRKz7VnV1z3PTc3amIip/32s2sXLsd81vdvngJqxybIGs80OPAGuNza99Uosfwgme
 dvoXX/X9OYfoxY3iRjCnd3azR+SftabaR8oOBeodr58WyS9k+x0gkpfePeN6nAOYoSzM
 gruZhZecOBQrlOo1bPoNk72kCtr0wUhxeqf0CGR4MnXXIQqYHU8nrtz7Eyc4v7OHSM3k
 3mTlOeMoEPRvLvO/KDoa9A5WcoqMmKgwG0eUDT1KkZJUJcE3E9EDF04SAN4+Wcv3mI03 /w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jmu6xxuer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:35:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5L2ZvWT010326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:35:57 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5L2ZvRJ008632
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:35:57 GMT
Received: from mail-ot0-f180.google.com (/74.125.82.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 19:35:57 -0700
Received: by mail-ot0-f180.google.com with SMTP id c15-v6so1851370otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 19:35:57 -0700 (PDT)
X-Gm-Message-State: APt69E3Kp1e9w2c8tKPtRnAl8b6mPrLBTYhpnn8s9jFl7bgf/AXWcbKB
        XbgUl8FiXQo/i+FiH2v2MCiU0Klsr9oqfMmNaNQ=
X-Google-Smtp-Source: ADUXVKIuhkDkLtice03hgoMqcqN9IeBQRBHhH4yFqmo9XzlBEsWKyRPCQiGAfIP98xpSaYj8rN2PX1HD3bTPFo+77Jo=
X-Received: by 2002:a9d:72dd:: with SMTP id d29-v6mr15471124otk.345.1529548554366;
 Wed, 20 Jun 2018 19:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180601125321.30652-1-osalvador@techadventures.net> <20180601125321.30652-4-osalvador@techadventures.net>
In-Reply-To: <20180601125321.30652-4-osalvador@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 20 Jun 2018 22:35:18 -0400
X-Gmail-Original-Message-ID: <CAGM2reb6p-ffZ6-JDc5vqMkyDNDn9siWjEy9LnVJ1BtTKYhegA@mail.gmail.com>
Message-ID: <CAGM2reb6p-ffZ6-JDc5vqMkyDNDn9siWjEy9LnVJ1BtTKYhegA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/memory_hotplug: Get rid of link_mem_sections
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=626
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
> link_mem_sections() and walk_memory_range() share most of the code,
> so we can use walk_memory_range() with a callback to register_mem_sect_under_node()
> instead of using link_mem_sections().

Yes, their logic is indeed identical, so it is good to replace some
code with walk_memory_range().

>
> To control whether the node id must be check, two new functions has been added:
>
> register_mem_sect_under_node_nocheck_node()
> and
> register_mem_sect_under_node_check_node()

I do not like this, please see if my suggestion is better:

1. Revert all the changes outside of  link_mem_sections()
2. Remove check_nid argument from register_mem_sect_under_node
and link_mem_sections.
3. In register_mem_sect_under_node
Replace:

if (check_nid) {
}

With:
if (system_state == SYSTEM_BOOTING) {
}

4. Change register_mem_sect_under_node() prototype to match callback
of walk_memory_range()
5. Call walk_memory_range(... register_mem_sect_under_node ...) from
link_mem_sections

Thank you,
Pavel
