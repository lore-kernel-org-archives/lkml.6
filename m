Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755695AbeCSPO6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:14:58 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:38187 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755644AbeCSPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:14:51 -0400
X-Google-Smtp-Source: AG47ELsORUrtR7GfBybR2PiQtDcm2HX+eY+WLuhT5IN7RIgIHuW/73qMz+V4pqg1X8ac9HrC/woENw==
Date: Mon, 19 Mar 2018 08:14:47 -0700
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: Allow to kill tasks doing pcpu_alloc() and
 waiting for pcpu_balance_workfn()
Message-ID: <20180319151447.GL2943022@devbig577.frc2.facebook.com>
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 01:56:31PM -0700, Andrew Morton wrote:
> > +	if (!is_atomic) {
> > +		if (gfp & __GFP_NOFAIL)
> > +			mutex_lock(&pcpu_alloc_mutex);
> > +		else if (mutex_lock_killable(&pcpu_alloc_mutex))
> > +			return NULL;
> > +	}
> 
> It would benefit from a comment explaining why we're doing this (it's
> for the oom-killer).

And, yeah, this would be great.  Kirill, can you please send a patch
to add a comment there?

Thanks.

-- 
tejun
