Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeBUFrd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:47:33 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36399 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUFrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:47:31 -0500
X-Google-Smtp-Source: AH8x224eu0Y0BgQU4xmbWXs0t631aR+rZhztoDu+nUhFJub57J14ApWELdqI4AWbQ5zSV+oDFhwzew==
Message-ID: <1519192048.55655.35.camel@gmail.com>
Subject: Re: [PATCH] netlink: put module reference if dump start fails
From: Eric Dumazet <eric.dumazet@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, davem@davemloft.net,
        johannes.berg@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 20 Feb 2018 21:47:28 -0800
In-Reply-To: <20180221034159.14685-1-Jason@zx2c4.com>
References: <20180221034159.14685-1-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-21 at 04:41 +0100, Jason A. Donenfeld wrote:
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

When was the bug added ? This would help a lot stable teams ...

Thanks.
