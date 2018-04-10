Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeDJM2K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:28:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45999 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbeDJM2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:28:09 -0400
X-Google-Smtp-Source: AIpwx4+dsTnUz72+O+8E1lGe5YDic3T4rNta5hzFPGyXUETCUEhVy5NLHB060T+LNpxauBTJCpMwTA==
Date: Tue, 10 Apr 2018 15:28:04 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180410122804.GD2041@uranus.lan>
References: <1523310774-40300-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180410090917.GZ21835@dhcp22.suse.cz>
 <20180410094047.GB2041@uranus.lan>
 <20180410104215.GB21835@dhcp22.suse.cz>
 <20180410110242.GC2041@uranus.lan>
 <20180410111001.GD21835@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410111001.GD21835@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 01:10:01PM +0200, Michal Hocko wrote:
> > 
> > Because do_brk does vma manipulations, for this reason it's
> > running under down_write_killable(&mm->mmap_sem). Or you
> > mean something else?
> 
> Yes, all we need the new lock for is to get a consistent view on brk
> values. I am simply asking whether there is something fundamentally
> wrong by doing the update inside the new lock while keeping the original
> mmap_sem locking in the brk path. That would allow us to drop the
> mmap_sem lock in the proc path when looking at brk values.

Michal gimme some time. I guess  we might do so, but I need some
spare time to take more precise look into the code, hopefully today
evening. Also I've a suspicion that we've wracked check_data_rlimit
with this new lock in prctl. Need to verify it again.
