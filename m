Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbeFAIiV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbeFAIiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:38:17 -0400
Date: Fri, 1 Jun 2018 10:37:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>,
        Amir Shehata <amir.shehata@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH v2 08/25] staging: lustre: libcfs: NUMA support
Message-ID: <20180601083754.GE19242@kroah.com>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
 <1527603725-30560-9-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527603725-30560-9-git-send-email-jsimmons@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:21:48AM -0400, James Simmons wrote:
> From: Amir Shehata <amir.shehata@intel.com>
> 
> This patch adds NUMA node support.

Really?  It looks like you just added an empty data structure pointer
that doesn't really do anything at all.

Where are you reading the host memory NUMA information from?

And why would a filesystem care about this type of thing?  Are you
going to now mirror what the scheduler does with regards to NUMA
topology issues?  How are you going to handle things when the topology
changes?  What systems did you test this on?  What performance
improvements were seen?  What downsides are there with all of this?

I need a whole lot more information here...

> NUMA node information is stored
> in the CPT table. A NUMA node mask is maintained for the entire
> table as well as for each CPT to track the NUMA nodes related to
> each of the CPTs. Add new function cfs_cpt_of_node() which returns
> the CPT of a particular NUMA node.

This doesn't really seem to match up with the code changes from what I
can tell...

thanks,

greg k-h
