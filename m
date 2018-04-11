Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeDKKsi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:48:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:39602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752896AbeDKKse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:48:34 -0400
Date: Wed, 11 Apr 2018 12:48:32 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, tiantao6@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: fd3e45436660 ("ACPI / NUMA: ia64: Parse all entries of SRAT memory
 affinity table")
Message-ID: <20180411104832.GF23400@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
my attention was brought to the %subj commit and either I am missing
something or the patch is quite dubious. What is it actually trying to
fix? If a BIOS/FW provides more memblocks than the limit then we would
get misleading numa topology (numactl -H output) but is the situation
much better with it applied? Numa init code will refuse to init more
memblocks than the limit and falls back to dummy_numa_init (AFAICS)
which will break the topology again and numactl -H will have a
misleading output anyway.

So why is the patch an improvement at all?
-- 
Michal Hocko
SUSE Labs
