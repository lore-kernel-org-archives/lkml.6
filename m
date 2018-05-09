Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934234AbeEIMY5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:24:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:53017 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932318AbeEIMY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:24:56 -0400
Date: Wed, 9 May 2018 14:24:54 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, tiantao6@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: fd3e45436660 ("ACPI / NUMA: ia64: Parse all entries of SRAT
 memory affinity table")
Message-ID: <20180509122454.GR32366@dhcp22.suse.cz>
References: <20180411104832.GF23400@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411104832.GF23400@dhcp22.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-04-18 12:48:32, Michal Hocko wrote:
> Hi,
> my attention was brought to the %subj commit and either I am missing
> something or the patch is quite dubious. What is it actually trying to
> fix? If a BIOS/FW provides more memblocks than the limit then we would
> get misleading numa topology (numactl -H output) but is the situation
> much better with it applied? Numa init code will refuse to init more
> memblocks than the limit and falls back to dummy_numa_init (AFAICS)
> which will break the topology again and numactl -H will have a
> misleading output anyway.
> 
> So why is the patch an improvement at all?

ping? I would be tempted to simply revert the patch as a wrong fix.
-- 
Michal Hocko
SUSE Labs
