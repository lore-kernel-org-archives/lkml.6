Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeFEUqb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:46:31 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35195 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeFEUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:46:26 -0400
X-Google-Smtp-Source: ADUXVKKoMArEpKk2mcV7tayljRmHsU4A/z6gNdDBbamdUAetPJNl6mC8E3gPqnVDmjM5f33EbprJvg==
Date: Tue, 5 Jun 2018 13:46:22 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/13] memcontrol: schedule throttling if we are congested
Message-ID: <20180605204622.GK1351649@devbig577.frc2.facebook.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
 <20180605132948.1664-8-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605132948.1664-8-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:29:42AM -0400, Josef Bacik wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> Memory allocations can induce swapping via kswapd or direct reclaim.  If
> we are having IO done for us by kswapd and don't actually go into direct
> reclaim we may never get scheduled for throttling.  So instead check to
> see if our cgroup is congested, and if so schedule the throttling.
> Before we return to user space the throttling stuff will only throttle
> if we actually required it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
