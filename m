Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966060AbeCSQjt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:39:49 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44351 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935400AbeCSQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:39:43 -0400
X-Google-Smtp-Source: AG47ELsu1029VtFxmZRAu/8HGJIVeZ8i5aZFzIMqUggHBG3VSJ8w7lkC3xDh+o3+Gd6KTj+7PgI4LA==
Date: Mon, 19 Mar 2018 09:39:40 -0700
From: Tejun Heo <tj@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Allow to kill tasks doing pcpu_alloc() and
 waiting for pcpu_balance_workfn()
Message-ID: <20180319163940.GA519464@devbig577.frc2.facebook.com>
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180319151447.GL2943022@devbig577.frc2.facebook.com>
 <4e8ca27a-9c92-8f1e-fb72-88758a266cb6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e8ca27a-9c92-8f1e-fb72-88758a266cb6@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 06:32:10PM +0300, Kirill Tkhai wrote:
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> In case of memory deficit and low percpu memory pages,
> pcpu_balance_workfn() takes pcpu_alloc_mutex for a long
> time (as it makes memory allocations itself and waits
> for memory reclaim). If tasks doing pcpu_alloc() are
> choosen by OOM killer, they can't exit, because they
> are waiting for the mutex.
> 
> The patch makes pcpu_alloc() to care about killing signal
> and use mutex_lock_killable(), when it's allowed by GFP
> flags. This guarantees, a task does not miss SIGKILL
> from OOM killer.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Applied to percpu/for-4.16-fixes.

Thanks.

-- 
tejun
