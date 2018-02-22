Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBVTEl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:04:41 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:50548 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeBVTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:04:39 -0500
Date: Thu, 22 Feb 2018 14:04:38 -0500 (EST)
Message-Id: <20180222.140438.278807705225418710.davem@davemloft.net>
To: Jason@zx2c4.com
Cc: johannes.berg@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: put module reference if dump start fails
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180221034159.14685-1-Jason@zx2c4.com>
References: <20180221034159.14685-1-Jason@zx2c4.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 21 Feb 2018 04:41:59 +0100

> Before, if cb->start() failed, the module reference would never be put,
> because cb->cb_running is intentionally false at this point. Users are
> generally annoyed by this because they can no longer unload modules that
> leak references. Also, it may be possible to tediously wrap a reference
> counter back to zero, especially since module.c still uses atomic_inc
> instead of refcount_inc.
> 
> This patch expands the error path to simply call module_put if
> cb->start() fails.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> This probably should be queued up for stable.

Applied and queued up for -stable.
