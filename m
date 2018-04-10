Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeDJJJW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:09:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47853 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753348AbeDJJJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:09:19 -0400
Date: Tue, 10 Apr 2018 11:09:17 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: adobriyan@gmail.com, willy@infradead.org, mguzik@redhat.com,
        gorcunov@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180410090917.GZ21835@dhcp22.suse.cz>
References: <1523310774-40300-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523310774-40300-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-04-18 05:52:54, Yang Shi wrote:
[...]
> So, introduce a new spinlock in mm_struct to protect the concurrent
> access to arg_start|end, env_start|end and others except start_brk and
> brk, which are still protected by mmap_sem to avoid concurrent access
> from do_brk().

Is there any fundamental problem with brk using the same lock?
-- 
Michal Hocko
SUSE Labs
