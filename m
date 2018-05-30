Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbeE3Ptk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:49:40 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36105 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeE3Pth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:49:37 -0400
X-Google-Smtp-Source: ADUXVKLBWcLvFQigKnRXftrQJ2NKahBU6c0ykpRqaaHdJmz5CR/UIjL6BB4QJufbnrSD+GZIGR1xPw==
Date: Wed, 30 May 2018 08:49:33 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 01/13] block: add bi_blkg to the bio for cgroups
Message-ID: <20180530154933.GI1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529211724.4531-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 05:17:12PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Currently io.low uses a bi_cg_private to stash its private data for the
> blkg, however other blkcg policies may want to use this as well.  Since
> we can get the private data out of the blkg, move this to bi_blkg in the
> bio and make it generic, then we can use bio_associate_blkg() to attach
> the blkg to the bio.
> 
> Theoretically we could simply replace the bi_css with this since we can
> get to all the same information from the blkg, however you have to
> lookup the blkg, so for example wbc_init_bio() would have to lookup and
> possibly allocate the blkg for the css it was trying to attach to the
> bio.  This could be problematic and result in us either not attaching
> the css at all to the bio, or falling back to the root blkcg if we are
> unable to allocate the corresponding blkg.
> 
> So for now do this, and in the future if possible we could just replace
> the bi_css with bi_blkg and update the helpers to do the correct
> translation.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
