Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeCVPDG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48691 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeCVPDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:03:04 -0400
Date: Thu, 22 Mar 2018 16:00:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Andiry Xu <jix024@eng.ucsd.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        andy.rudoff@intel.com, coughlan@redhat.com, swanson@cs.ucsd.edu,
        david@fromorbit.com, jack@suse.com, swhiteho@redhat.com,
        miklos@szeredi.hu, andiry.xu@gmail.com, Andiry Xu <jix024@cs.ucsd.edu>
Subject: Re: [RFC v2 83/83] Sysfs support.
Message-ID: <20180322150037.GD6955@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Andiry Xu <jix024@eng.ucsd.edu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        andy.rudoff@intel.com, coughlan@redhat.com, swanson@cs.ucsd.edu,
        david@fromorbit.com, jack@suse.com, swhiteho@redhat.com,
        miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-84-git-send-email-jix024@eng.ucsd.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520705944-6723-84-git-send-email-jix024@eng.ucsd.edu>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 10:19:04AM -0800, Andiry Xu wrote:
> From: Andiry Xu <jix024@cs.ucsd.edu>
> 
> Sysfs support allows user to get/post information of running NOVA instance.
> After mount, NOVA creates four entries under proc directory
> /proc/fs/nova/pmem#/:
> 
> timing_stats	IO_stats	allocator	gc
> 
> Show NOVA file operation timing statistics:
> cat /proc/fs/NOVA/pmem#/timing_stats
> 
> Clear timing statistics:
> echo 1 > /proc/fs/NOVA/pmem#/timing_stats
> 
> Show NOVA I/O statistics:
> cat /proc/fs/NOVA/pmem#/IO_stats
> 
> Clear I/O statistics:
> echo 1 > /proc/fs/NOVA/pmem#/IO_stats
> 
> Show NOVA allocator information:
> cat /proc/fs/NOVA/pmem#/allocator
> 
> Manual garbage collection:
> echo #inode_number > /proc/fs/NOVA/pmem#/gc

IIRC no new entries should be added to /proc, /sys is supposed to be
used. I can't find it documented though, so you'd better check with
sysfs people.
