Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C782CC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA5E2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAs7IsTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA5E2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeJUBbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 21:31:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54979 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeJUBbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 21:31:13 -0400
Received: by mail-it1-f196.google.com with SMTP id l191-v6so7676363ita.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VZpahs2I0uHzvO9G0wpyOJ99KVKfUU4v1SJEQTM8x1E=;
        b=cAs7IsTBkExOaHxu1RuEUi6vwNsZowP/4q7OWRtpZwCJDssZhrXpDpL5lTpfw6LRXG
         comsRYA7lX+FNWeHERZY1es/mLqABNGuwftZ0b+Suh7WVRtNObOPCfF1w7UlLeFvB0MY
         EEvr7TIK/B/OuDrmFvIelqaJNsZbLEOkyqvn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VZpahs2I0uHzvO9G0wpyOJ99KVKfUU4v1SJEQTM8x1E=;
        b=oRu+HvqzDRc+2UFhjDzWQquTTGJfdPXZjr0cZN4iiQiaXLPvSxaW6Ze1pY+aKONsfS
         NvlkDIkCUi6oJidjWNGSchll6TC0iM5KVQt5nqiI5WPZpbUcS430AJaRbgTCaXF4fVL4
         axFticHTd9+NmGIVZBDFfqA2fpN7yi66AVneaZNl+dvQWLQslUpFqH4QgSrUXwcMImFL
         SzV78gCHCG7XCBfVfFucJNwxe6UIllyxm5yO9ZNp9/q5lG0pvY5MzMXNq22cTr7h8JKE
         ydcy4i20pRIUV/jBkxq3G0L+iiWU6k+iv2AvvoS7z25eSRKQa7tS8gvbOvKnaTqxswHY
         dSVg==
X-Gm-Message-State: ABuFfoi0wIJn+IKZWm8yH4dLF5TkigdK2KtfBejhW8k5lOk0cCXP4wqt
        XOBUIyrekDTWV20cM01OhYq/a82uSJYrQA9JO0Li/A==
X-Google-Smtp-Source: ACcGV61F/T2IpwJYXcxRiXIyE3hLm5uB53+7Hqj3OX1sTjKViPpeNedJ6Hn8Tu2GsktstEKhVZlzcox0kvxWrfhw1So=
X-Received: by 2002:a02:4f02:: with SMTP id c2-v6mr8150820jab.2.1540056004694;
 Sat, 20 Oct 2018 10:20:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Sat, 20 Oct 2018 10:20:03
 -0700 (PDT)
In-Reply-To: <20181019204723.3903-1-rick.p.edgecombe@intel.com>
References: <20181019204723.3903-1-rick.p.edgecombe@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 20 Oct 2018 19:20:03 +0200
Message-ID: <CAKv+Gu_AgPv2o4=U0-7pnpgtSufEobnta8oKhhGfCdCxM82B5Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/3] Rlimit for module space
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Jann Horn <jannh@google.com>, kristen@linux.intel.com,
        Dave Hansen <dave.hansen@intel.com>, arjan@linux.intel.com,
        deneen.t.dock@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

On 19 October 2018 at 22:47, Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
> If BPF JIT is on, there is no effective limit to prevent filling the entire
> module space with JITed e/BPF filters.

Why do BPF filters use the module space, and does this reason apply to
all architectures?

On arm64, we already support loading plain modules far away from the
core kernel (i.e. out of range for ordinary relative jump/calll
instructions), and so I'd expect BPF to be able to deal with this
already as well. So for arm64, I wonder why an ordinary vmalloc_exec()
wouldn't be more appropriate.

So before refactoring the module alloc/free routines to accommodate
BPF, I'd like to take one step back and assess whether it wouldn't be
more appropriate to have a separate bpf_alloc/free API, which could be
totally separate from module alloc/free if the arch permits it.


> For classic BPF filters attached with
> setsockopt SO_ATTACH_FILTER, there is no memlock rlimit check to limit the
> number of insertions like there is for the bpf syscall.
>
> This patch adds a per user rlimit for module space, as well as a system wide
> limit for BPF JIT. In a previously reviewed patchset, Jann Horn pointed out the
> problem that in some cases a user can get access to 65536 UIDs, so the effective
> limit cannot be set low enough to stop an attacker and be useful for the general
> case. A discussed alternative solution was a system wide limit for BPF JIT
> filters. This much more simply resolves the problem of exhaustion and
> de-randomizing in the case of non-CONFIG_BPF_JIT_ALWAYS_ON. If
> CONFIG_BPF_JIT_ALWAYS_ON is on however, BPF insertions will fail if another user
> exhausts the BPF JIT limit. In this case a per user limit is still needed. If
> the subuid facility is disabled for normal users, this should still be ok
> because the higher limit will not be able to be worked around that way.
>
> The new BPF JIT limit can be set like this:
> echo 5000000 > /proc/sys/net/core/bpf_jit_limit
>
> So I *think* this patchset should resolve that issue except for the
> configuration of CONFIG_BPF_JIT_ALWAYS_ON and subuid allowed for normal users.
> Better module space KASLR is another way to resolve the de-randomizing issue,
> and so then you would just be left with the BPF DOS in that configuration.
>
> Jann also pointed out how, with purposely fragmenting the module space, you
> could make the effective module space blockage area much larger. This is also
> somewhat un-resolved. The impact would depend on how big of a space you are
> trying to allocate. The limit has been lowered on x86_64 so that at least
> typical sized BPF filters cannot be blocked.
>
> If anyone with more experience with subuid/user namespaces has any suggestions
> I'd be glad to hear. On an Ubuntu machine it didn't seem like a un-privileged
> user could do this. I am going to keep working on this and see if I can find a
> better solution.
>
> Changes since v2:
>  - System wide BPF JIT limit (discussion with Jann Horn)
>  - Holding reference to user correctly (Jann)
>  - Having arch versions of modulde_alloc (Dave Hansen, Jessica Yu)
>  - Shrinking of default limits, to help prevent the limit being worked around
>    with fragmentation (Jann)
>
> Changes since v1:
>  - Plug in for non-x86
>  - Arch specific default values
>
>
> Rick Edgecombe (3):
>   modules: Create arch versions of module alloc/free
>   modules: Create rlimit for module space
>   bpf: Add system wide BPF JIT limit
>
>  arch/arm/kernel/module.c                |   2 +-
>  arch/arm64/kernel/module.c              |   2 +-
>  arch/mips/kernel/module.c               |   2 +-
>  arch/nds32/kernel/module.c              |   2 +-
>  arch/nios2/kernel/module.c              |   4 +-
>  arch/parisc/kernel/module.c             |   2 +-
>  arch/s390/kernel/module.c               |   2 +-
>  arch/sparc/kernel/module.c              |   2 +-
>  arch/unicore32/kernel/module.c          |   2 +-
>  arch/x86/include/asm/pgtable_32_types.h |   3 +
>  arch/x86/include/asm/pgtable_64_types.h |   2 +
>  arch/x86/kernel/module.c                |   2 +-
>  fs/proc/base.c                          |   1 +
>  include/asm-generic/resource.h          |   8 ++
>  include/linux/bpf.h                     |   7 ++
>  include/linux/filter.h                  |   1 +
>  include/linux/sched/user.h              |   4 +
>  include/uapi/asm-generic/resource.h     |   3 +-
>  kernel/bpf/core.c                       |  22 +++-
>  kernel/bpf/inode.c                      |  16 +++
>  kernel/module.c                         | 152 +++++++++++++++++++++++-
>  net/core/sysctl_net_core.c              |   7 ++
>  22 files changed, 233 insertions(+), 15 deletions(-)
>
> --
> 2.17.1
>
