Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970620AbeCSS5i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:57:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46760 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965820AbeCSS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:57:33 -0400
X-Google-Smtp-Source: AG47ELsxH3fgn5lD6FcKbuMwRmOl7iq1QbVvDGxm2/tb5yI+ABWtBNLwzOrZEsQ/P/nkS8c1tkKBmw==
Date: Mon, 19 Mar 2018 11:57:32 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] x86/unwind: Make CONFIG_UNWINDER_ORC=y the default
 in kconfig for 64-bit
Message-ID: <20180319185732.GD37438@google.com>
References: <20171013052544.euk7yawni47lhmdq@gmail.com>
 <9b1237bbe7244ed9cdf8db2dcb1253e37e1c341e.1507924831.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b1237bbe7244ed9cdf8db2dcb1253e37e1c341e.1507924831.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

El Fri, Oct 13, 2017 at 03:02:01PM -0500 Josh Poimboeuf ha dit:

> The ORC unwinder has been stable in testing so far.  Give it much wider
> testing by making it the default in kconfig for x86_64.  It's not yet
> supported for 32-bit, so leave frame pointers as the default there.
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---

Building an upstream kernel with clang results in plenty of objtool
warnings like these:

drivers/gpu/drm/i915/dvo_ch7017.o: warning: objtool: ch7017_get_hw_state()+0x80: return with modified stack frame
  CC      drivers/gpu/drm/i915/i915_oa_cflgt2.o
...
  CC      drivers/gpu/drm/i915/intel_lpe_audio.o
drivers/gpu/drm/i915/i915_gpu_error.o: warning: objtool: i915_error_printf()+0x6c: return with modified stack frame
drivers/gpu/drm/i915/intel_display.o: warning: objtool: pipe_config_err()+0xa6: return with modified stack frame

Bisecting shows that the warnings are generated since the ORC unwinder
was made the default. Not sure if the issue is on the unwinder side
or clang.

Any ideas on what could be the problems?

Thanks

Matthias
