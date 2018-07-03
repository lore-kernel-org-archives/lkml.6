Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91D4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ABE23C6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ABE23C6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeGCH2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:28:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754571AbeGCH2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:28:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5654FAE06;
        Tue,  3 Jul 2018 07:28:37 +0000 (UTC)
Date:   Tue, 3 Jul 2018 09:28:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jia He <hejianet@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>, richard.weiyang@gmail.com
Subject: Re: [PATCH v9 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
Message-ID: <20180703072835.GE16767@dhcp22.suse.cz>
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
 <20180702114037.GJ19043@dhcp22.suse.cz>
 <779be6bf-db64-9175-f4c0-2baa0ea6defd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779be6bf-db64-9175-f4c0-2baa0ea6defd@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 10:11:11, Jia He wrote:
> On 7/2/2018 7:40 PM, Michal Hocko Wrote:
[...]
> > So this is 13ms saving when booting 96G machine. Is this really worth
> > the additional code? Are there any other benefits?
> Sorry, Michal
> I missed one thing.
> This 13ms optimization is merely the result of my patch 3~6
> Patch 1 is originated by Paul Burton in commit b92df1de5d289.
> In its description,
> ===
> James said "I have tested this patch on a virtual model of a Samurai CPU
>     with a sparse memory map.  The kernel boot time drops from 109 to
>     62 seconds. "
> ===

Those numbers should be in the changelog.
-- 
Michal Hocko
SUSE Labs
