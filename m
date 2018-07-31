Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BB820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIyVzwIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BB820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeGaS2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:28:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35271 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeGaS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:28:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so9373399pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2EpX24G/SQkG9Ws7k9jxaRzLTQZ9I5sjHhN3PDknWU=;
        b=DIyVzwIrHO1ERjoaB+LwlwvMzDoGdevxOt26Ymqj/8yNHZbK5Sz5nr3Cb6PRYAG9rb
         jvRQ7jnL6PEQP8J9UBFpd+uiMFQTdPSf9mER6KZAvxRTvwYO5m3/bAenlYXbGe2Q3BAQ
         S028NGo4zMB5AseoaQA/T0y3Zm544xPGZiO5Ou/YDpwkSewr3FTbg0h4eu1w9pn4V8+W
         xyj07UHCLroeQHhfQRCNHH3B3ljXqS2j1XXatM6Fu9i7DBLYAKq7YU88/FWJaypVWhSB
         M77stNFJyMC43HlLgnoJeK7y8Ucbi+PKrs+4sZQGAqBy4OTn/QghkfDrFBqI8h9L7xG9
         z/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2EpX24G/SQkG9Ws7k9jxaRzLTQZ9I5sjHhN3PDknWU=;
        b=NSAp/VzDImSRKtEnP54EZZ9dbiE73ExZYRdVmzzvcBvfOyl5CZrRnfwsGOWcwy/aLz
         6LobMURqj6kTeTzSzM08i+N+0E9wB3L0yPVD7FmRC8Ukv/6+OoLuxbLyufboZsJWNvPd
         EOfjY9TGItMhykvcZgZ0tBl2lrXklS6rDt5i2/itLQlV7xl03XI6IrkqchJVdeMENg5X
         hL+Y8egsB2rkRgKyoRBnHkT1KNFrbOUjtR7XiFM2gFMCTM5V2tvXlWyJUro0c+sd7Myw
         /MjF2NNGY6pGEetyhWRlOQ5zFrHFz0PU0wWia/vQq8RXDCs67+7UgAq7p/Iwtlmv4nFc
         lGEA==
X-Gm-Message-State: AOUpUlH5ZxnE7KtXeVGOWqD3kVpu/aftvdL79NPKnJs0OlmYFL3TG2rc
        wiLq4C1+5ICn0SyptWrc9yEMbgwpq2cZI9Z+dFSVMw==
X-Google-Smtp-Source: AAOMgpcyVennc5WEAQ+QAOrbL8d9t7Rg6h+x4mUwth4yIIIQgpIl4SIzaOJmHlEZ85uUdZmjlTcAStiGX9P5P76sFKU=
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr20914688pge.75.1533055627321;
 Tue, 31 Jul 2018 09:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180730170622.99349-1-ndesaulniers@google.com> <201807311449.6TXkRCfh%fengguang.wu@intel.com>
In-Reply-To: <201807311449.6TXkRCfh%fengguang.wu@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Jul 2018 09:46:56 -0700
Message-ID: <CAKwvOdnUjqaVsf7o9=FYraLrrTjKdW8tMihYab_MnhBiOfrNkg@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
To:     lkp@intel.com
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>, ghackmann@android.com,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        rdunlap@infradead.org, neilb@suse.com,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is the v1 of this patch, also reported by Nathan
Chancellor? Hard to tell as the github link is dead.  Does 0-day
delete its branches if there's a v2?
On Mon, Jul 30, 2018 at 11:50 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.18-rc7 next-20180727]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Nick-Desaulniers/kernel-h-Disable-Wreturn-stack-address-for-_THIS_IP_/20180731-135818
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/spinlock.h:58:0,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:6,
>                     from include/linux/slab.h:15,
>                     from include/linux/crypto.h:24,
>                     from arch/x86/kernel/asm-offsets.c:9:
>    include/linux/bottom_half.h: In function 'local_bh_disable':
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h: In function 'local_bh_enable':
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    In file included from include/linux/mmzone.h:8:0,
>                     from include/linux/gfp.h:6,
>                     from include/linux/slab.h:15,
>                     from include/linux/crypto.h:24,
>                     from arch/x86/kernel/asm-offsets.c:9:
>    include/linux/spinlock.h: In function 'spin_lock_bh':
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_lock_bh(&lock->rlock);
>
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_unlock_bh':
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_unlock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_trylock_bh':
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      return raw_spin_trylock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> --
>    In file included from include/linux/rcupdate.h:41:0,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from kernel//sched/sched.h:5,
>                     from kernel//sched/core.c:8:
>    include/linux/bottom_half.h: In function 'local_bh_disable':
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h: In function 'local_bh_enable':
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    In file included from include/linux/seqlock.h:36:0,
>                     from include/linux/time.h:6,
>                     from include/linux/ktime.h:24,
>                     from include/linux/rcutiny.h:28,
>                     from include/linux/rcupdate.h:210,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from kernel//sched/sched.h:5,
>                     from kernel//sched/core.c:8:
>    include/linux/spinlock.h: In function 'spin_lock_bh':
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_lock_bh(&lock->rlock);
>
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_unlock_bh':
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_unlock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_trylock_bh':
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      return raw_spin_trylock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel//sched/core.c: In function 'prepare_lock_switch':
> >> kernel//sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
>
> >> kernel//sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> kernel//sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel//sched/core.c: In function 'finish_lock_switch':
>    kernel//sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
>
>    kernel//sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel//sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> --
>    In file included from include/linux/spinlock.h:58:0,
>                     from include/linux/irq.h:14,
>                     from arch/x86/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:9,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/kernel_stat.h:9,
>                     from kernel//time/timer.c:22:
>    include/linux/bottom_half.h: In function 'local_bh_disable':
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h: In function 'local_bh_enable':
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    In file included from include/linux/irq.h:14:0,
>                     from arch/x86/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:9,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/kernel_stat.h:9,
>                     from kernel//time/timer.c:22:
>    include/linux/spinlock.h: In function 'spin_lock_bh':
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_lock_bh(&lock->rlock);
>
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_unlock_bh':
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_unlock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_trylock_bh':
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      return raw_spin_trylock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel//time/timer.c: In function 'call_timer_fn':
> >> kernel//time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      lock_map_acquire(&lockdep_map);
>
> >> kernel//time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> kernel//time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> --
>    In file included from include/linux/rcupdate.h:41:0,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from kernel///sched/sched.h:5,
>                     from kernel///sched/core.c:8:
>    include/linux/bottom_half.h: In function 'local_bh_disable':
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h: In function 'local_bh_enable':
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    In file included from include/linux/seqlock.h:36:0,
>                     from include/linux/time.h:6,
>                     from include/linux/ktime.h:24,
>                     from include/linux/rcutiny.h:28,
>                     from include/linux/rcupdate.h:210,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from kernel///sched/sched.h:5,
>                     from kernel///sched/core.c:8:
>    include/linux/spinlock.h: In function 'spin_lock_bh':
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_lock_bh(&lock->rlock);
>
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_unlock_bh':
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_unlock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_trylock_bh':
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      return raw_spin_trylock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel///sched/core.c: In function 'prepare_lock_switch':
>    kernel///sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
>
>    kernel///sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel///sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel///sched/core.c: In function 'finish_lock_switch':
>    kernel///sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
>
>    kernel///sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel///sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> --
>    In file included from include/linux/spinlock.h:58:0,
>                     from include/linux/irq.h:14,
>                     from arch/x86/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:9,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/kernel_stat.h:9,
>                     from kernel///time/timer.c:22:
>    include/linux/bottom_half.h: In function 'local_bh_disable':
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h: In function 'local_bh_enable':
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    In file included from include/linux/irq.h:14:0,
>                     from arch/x86/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:9,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/kernel_stat.h:9,
>                     from kernel///time/timer.c:22:
>    include/linux/spinlock.h: In function 'spin_lock_bh':
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_lock_bh(&lock->rlock);
>
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
> >> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_unlock_bh':
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      raw_spin_unlock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h: In function 'spin_trylock_bh':
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      return raw_spin_trylock_bh(&lock->rlock);
>
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel///time/timer.c: In function 'call_timer_fn':
>    kernel///time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>      lock_map_acquire(&lockdep_map);
>
>    kernel///time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>    kernel///time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>
> vim +19 include/linux/bottom_half.h
>
> 0bd3a173 Peter Zijlstra 2013-11-19  16
> 0bd3a173 Peter Zijlstra 2013-11-19  17  static inline void local_bh_disable(void)
> 0bd3a173 Peter Zijlstra 2013-11-19  18  {
> 0bd3a173 Peter Zijlstra 2013-11-19 @19          __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> 0bd3a173 Peter Zijlstra 2013-11-19  20  }
> 0bd3a173 Peter Zijlstra 2013-11-19  21
>
> :::::: The code at line 19 was first introduced by commit
> :::::: 0bd3a173d711857fc9f583eb5825386cc08f3948 sched/preempt, locking: Rework local_bh_{dis,en}able()
>
> :::::: TO: Peter Zijlstra <peterz@infradead.org>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Thanks,
~Nick Desaulniers
