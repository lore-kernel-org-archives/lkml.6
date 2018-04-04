Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDH5O convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:57:14 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:49209 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750908AbeDDH5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:57:13 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Xidong Wang <wangxidong_97@163.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1522827474-5120-1-git-send-email-wangxidong_97@163.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, "Xidong Wang" <wangxidong_97@163.com>
References: <1522827474-5120-1-git-send-email-wangxidong_97@163.com>
Message-ID: <152282857443.25182.14236056855796176035@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH 1/1] drm/i915: Do not use kfree() to free kmem_cache_alloc()
 return value
Date: Wed, 04 Apr 2018 08:56:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xidong Wang (2018-04-04 08:37:54)
> In eb_lookup_vmas(), the return value of kmem_cache_alloc() is freed
> with kfree(). I think the expected paired function is kmem_cahce_free().
> 
> Signed-off-by: Xidong Wang <wangxidong_97@163.com>

That is indeed what it should be doing,

Fixes: d1b48c1e7184 ("drm/i915: Replace execbuf vma ht with an idr")
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v4.14+
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
