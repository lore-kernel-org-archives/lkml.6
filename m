Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755585AbeCSPNs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:13:48 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:37040 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755226AbeCSPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:13:47 -0400
X-Google-Smtp-Source: AG47ELs2S/9BRvIjjxFoFErF6HH7MYmW910vA6ULGQWYlZKzsYsAPn3IC9oS3QQebGh07NRthcBiPw==
Date: Mon, 19 Mar 2018 08:13:43 -0700
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: Allow to kill tasks doing pcpu_alloc() and
 waiting for pcpu_balance_workfn()
Message-ID: <20180319151343.GK2943022@devbig577.frc2.facebook.com>
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180314220909.GE2943022@devbig577.frc2.facebook.com>
 <20180314152203.c06fce436d221d34d3e4cf4a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314152203.c06fce436d221d34d3e4cf4a@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

On Wed, Mar 14, 2018 at 03:22:03PM -0700, Andrew Morton wrote:
> hm.  spose so.  Maybe.  Are there other ways?  I assume the time is
> being spent in pcpu_create_chunk()?  We could drop the mutex while
> running that stuff and take the appropriate did-we-race-with-someone
> testing after retaking it.  Or similar.

I'm not sure that'd change much.  Ultimately, isn't the choice between
being able to return NULL and waiting for more memory?  If we decide
to return NULL, it doesn't make difference where we do that from,
right?

Thanks.

-- 
tejun
