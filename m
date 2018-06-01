Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeFALob (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:44:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:57605 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752025AbeFALo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:44:27 -0400
Date: Fri, 1 Jun 2018 13:44:25 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Alex Richman <alex.r@gblabs.co.uk>
Cc: linux-man@vger.kernel.org, linux-mm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: mlock() confusing 1 half of system RAM limit
Message-ID: <20180601114425.GA15686@dhcp22.suse.cz>
References: <c43ad840-dcab-b86f-bf15-ffb26b66d37b@gblabs.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c43ad840-dcab-b86f-bf15-ffb26b66d37b@gblabs.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-06-18 10:53:57, Alex Richman wrote:
> Hi,
> 
> I'm seeing a 1/2 of system RAM limit when calling mlock().  mlock(2) says:
> > ENOMEM (Linux 2.4 and earlier) the calling process tried to lock more than
> half of RAM.
> Which implies to me that the 1 half of system RAM limit should be only Linux
> 2.4 and earlier, but I'm running linux 4.4.127 and still seeing the limit.
> 
> This is on a system with 66007168 KB total memory, locking 33794621440 bytes
> works, locking 33795653632 bytes does not work.

I assume you are doing mlock on MAP_SHARED resp. on mmap of shmem
file. You are likely to hit the shmem limit. This is half of the
available memory by default.
-- 
Michal Hocko
SUSE Labs
