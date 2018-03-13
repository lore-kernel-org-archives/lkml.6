Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbeCMQiX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:38:23 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:58318 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751999AbeCMQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:38:18 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Arnd Bergmann <arnd@arndb.de>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180313161952.552083-1-arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@arndb.de>,
        "Tvrtko Ursulin" <tvrtko.ursulin@intel.com>,
        "Michal Wajdeczko" <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180313161952.552083-1-arnd@arndb.de>
Message-ID: <152095909165.515.12940408400999492012@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] [v2] drm/i915/pmu: avoid -Wmaybe-uninitialized warning
Date: Tue, 13 Mar 2018 16:38:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2018-03-13 16:19:31)
> The conditional spinlock confuses gcc into thinking the 'flags' value
> might contain uninitialized data:
> 
> drivers/gpu/drm/i915/i915_pmu.c: In function '__i915_pmu_event_read':
> arch/x86/include/asm/paravirt_types.h:573:3: error: 'flags' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> The code is correct, but it's easy to see how the compiler gets confused
> here. This avoids the problem by pulling the lock outside of the function
> into its only caller.
> 
> Fixes: 1fe699e30113 ("drm/i915/pmu: Fix sleep under atomic in RC6 readout")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
