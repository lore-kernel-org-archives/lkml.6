Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B279C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1212422407
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1212422407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030583AbeGBLi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:38:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030567AbeGBLiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:38:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9DADAF3D;
        Mon,  2 Jul 2018 11:38:53 +0000 (UTC)
Date:   Mon, 2 Jul 2018 13:38:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     hejianet@gmail.com, linux@armlinux.org.uk,
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
        james.morse@arm.com, ard.biesheuvel@linaro.org,
        steve.capper@arm.com, tglx@linutronix.de, mingo@redhat.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, Johannes Weiner <hannes@cmpxchg.org>,
        kemi.wang@intel.com, ptesarik@suse.com, yasu.isimatu@gmail.com,
        aryabinin@virtuozzo.com, nborisov@suse.com,
        Wei Yang <richard.weiyang@gmail.com>, jia.he@hxt-semitech.com
Subject: Re: [PATCH v9 2/6] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm/arm64
Message-ID: <20180702113851.GI19043@dhcp22.suse.cz>
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
 <1530239363-2356-3-git-send-email-hejianet@gmail.com>
 <CAGM2reYn3ZbdjhcZze8Zt1eLNSdWghy0KwEXfd5xW+1Ba_SMbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reYn3ZbdjhcZze8Zt1eLNSdWghy0KwEXfd5xW+1Ba_SMbw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-06-18 14:13:08, Pavel Tatashin wrote:
> > +++ b/include/linux/early_pfn.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2018 HXT-semitech Corp. */
> > +#ifndef __EARLY_PFN_H
> > +#define __EARLY_PFN_H
> > +#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> > +ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
> > +{
> > +       struct memblock_type *type = &memblock.memory;
> 
> Why put it in a header file and not in some C file? In my opinion it
> is confusing to have non-line functions in header files. Basically,
> you can include this header file in exactly one C file without
> breaking compilation.

It is not confusing. It is outright broken.

-- 
Michal Hocko
SUSE Labs
