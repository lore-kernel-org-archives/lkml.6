Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755869AbeCSP1y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:27:54 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:42483 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755819AbeCSP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:27:49 -0400
X-Google-Smtp-Source: AG47ELsxD6cX5+RTTcKvkbLkdVNUWfOK7DIinIgauZSLy2p9Xgny1+1aLTGLiUYMwjIf3kZLCHvBwQ==
Date: Mon, 19 Mar 2018 08:27:46 -0700
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: make manage_workers() and pool destruction
 exclusive
Message-ID: <20180319152746.GN2943022@devbig577.frc2.facebook.com>
References: <20180319073508.3100-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319073508.3100-1-jiangshanlai@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 03:35:07PM +0800, Lai Jiangshan wrote:
> The original code allows destroying the pool when the pool
> is still active in manage_workers(). A synchronization
> mechanism between manage_workers() and pool destruction
> was added for protection.
> 
> This patch simply makes manage_workers() and pool destruction
> exclusive by getting an indirect refcount of the pool in
> manage_workers(). "indirect" means it gets a refcount of
> the first involved pwq which holds a refcount of the pool.
> This refcount can prevent the pool from being destroyed.
> 
> The original synchronization mechanism (wq_manager_wait)
> is also removed.

Hmm... idk, this is more indirect and subtle than the existing code
and it's not like the existing code was overly complicated.

Thanks.

-- 
tejun
