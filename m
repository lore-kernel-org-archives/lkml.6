Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642BE25C57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B9zzFigq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642BE25C57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeGBMHe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:07:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeGBMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:07:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62C3NLw090803
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 12:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=k6IMlN6kSA3EdE1GG/Cy5vYvNOnH6bSXOx0dQD3bIYM=;
 b=B9zzFigqB4p4lN+bg25HqqlNjD7xmUKJtSCFTiqe6sVobf8SQrXczesLSByR9vG/nEBp
 jvBroNOhoCRKmRvTEYZqgObfn3VgdbiQsHG+ijunu6IvYwdkvMinDNk6cEBS8MD2yvTd
 4sNbJADr8hlqKMeFA2BRJEHqB276NlXPNCDPT6e0u1qr0gig1RVqYMSRn6F2fw36ICLd
 PRAb8mnzQZiY9jcGyT7XaxyKYk5xC6Brv3BRwb9ksMroL2wm7MS51rA1aRyOhDWgG6pH
 MD0fj9/zYqeYAoAf7vqzWRwxLZezCdkbtr/Q9GZz26guDa7DUk93dGsDs9wkvTg4gM/4 sA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jx19sm83t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:07:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w62C7RZi000967
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 12:07:28 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w62C7R35002512
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 12:07:27 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 05:07:27 -0700
Received: by mail-oi0-f53.google.com with SMTP id i12-v6so11478705oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:07:27 -0700 (PDT)
X-Gm-Message-State: APt69E3mgO+/XLXh1S3HlXmltpxXfIzKkaID9//TmiijjchL4/14kb7Y
        ++FcV8YcJkgQi1ssY0AKcWFP3gpEgK3fQZpqDVo=
X-Google-Smtp-Source: AAOMgpdJ2LmAXcmPzEIaRcJPjmK7+4eQH+0MH6T+QAPrq0+PM3C8tFXuo0nVU+S5sI+KFIgIBD6vbKtWHF/0gKI8VGU=
X-Received: by 2002:aca:3243:: with SMTP id y64-v6mr16474037oiy.136.1530533247003;
 Mon, 02 Jul 2018 05:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com> <20180702114037.GJ19043@dhcp22.suse.cz>
In-Reply-To: <20180702114037.GJ19043@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 08:06:50 -0400
X-Gmail-Original-Message-ID: <CAGM2reaPhcWNhNW+i7kCysUr2tEMBour-GO_hkr4N-SrEvcx0w@mail.gmail.com>
Message-ID: <CAGM2reaPhcWNhNW+i7kCysUr2tEMBour-GO_hkr4N-SrEvcx0w@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
To:     mhocko@kernel.org
Cc:     Jia He <hejianet@gmail.com>, linux@armlinux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>, will.deacon@arm.com,
        mark.rutland@arm.com, hpa@zytor.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>, neelx@redhat.com,
        erosca@de.adit-jv.com, Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        james.morse@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        steve.capper@arm.com, tglx@linutronix.de, mingo@redhat.com,
        gregkh@linuxfoundation.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kemi.wang@intel.com,
        =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <ptesarik@suse.com>,
        yasu.isimatu@gmail.com, aryabinin@virtuozzo.com, nborisov@suse.com,
        Wei Yang <richard.weiyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=3 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=3 mlxscore=3 mlxlogscore=155
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 7:40 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 29-06-18 10:29:17, Jia He wrote:
> > Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> > where possible") tried to optimize the loop in memmap_init_zone(). But
> > there is still some room for improvement.
>
> It would be great to shortly describe those optimization from high level
> POV.
>
> >
> > Patch 1 introduce new config to make codes more generic
> > Patch 2 remain the memblock_next_valid_pfn on arm and arm64
> > Patch 3 optimizes the memblock_next_valid_pfn()
> > Patch 4~6 optimizes the early_pfn_valid()
> >
> > As for the performance improvement, after this set, I can see the time
> > overhead of memmap_init() is reduced from 27956us to 13537us in my
> > armv8a server(QDF2400 with 96G memory, pagesize 64k).
>
> So this is 13ms saving when booting 96G machine. Is this really worth
> the additional code? Are there any other benefits?

While 0.0144s for 96G is definitely small, I think the time is
proportional to the number of pages since memmap_init() loops through
all the pages. If base pages were changed to 4K, I bet the time would
increase 16 times: 0.23s on given machine, in other words around 2s
per 1T of memory.

I agree, a high level description of optimization is needed, and also
an explanation of why it would not work on other arches that support
memblock.

Pavel
