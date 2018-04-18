Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeDRJCX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:02:23 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:37968 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDRJCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:02:22 -0400
X-Google-Smtp-Source: AIpwx48nmra4krN2Nvurf19mJ7curHJaX3wNxUpzmWyLf7JnmLj8xgrTa4Ml3G2NeMmF3+7yc5OhLQ==
Date: Wed, 18 Apr 2018 12:02:17 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180418090217.GG19578@uranus.lan>
References: <1523730291-109696-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180418080555.GR17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418080555.GR17484@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 10:05:55AM +0200, Michal Hocko wrote:
> 
> Yes, looks good to me. As mentioned in other emails prctl_set_mm_map
> really deserves a comment explaining why we are doing the down_read
> 
> What about something like the following?
> "
> arg_lock protects concurent updates but we still need mmap_sem for read
> to exclude races with do_brk.
> "
> Acked-by: Michal Hocko <mhocko@suse.com>

Yes, thanks! Andrew, could you slightly update the changelog please?
