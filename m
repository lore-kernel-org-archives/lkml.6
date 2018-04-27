Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758266AbeD0MNw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:13:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:36567 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757999AbeD0MNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:13:50 -0400
Subject: Re: [tip:x86/cleanups] x86/bpf: Clean up non-standard comments, to
 make the code more readable
To: peterz@infradead.org, edumazet@google.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        ast@fb.com, bp@alien8.de, hpa@zytor.com, mingo@kernel.org,
        yoshfuji@linux-ipv6.org, tglx@linutronix.de,
        linux-tip-commits@vger.kernel.org, netdev@vger.kernel.org
References: <tip-5f26c50143f58f256535bee8d93a105f36d4d2da@git.kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <44202670-ed43-366b-caf2-f72863ee7c6a@iogearbox.net>
Date: Fri, 27 Apr 2018 14:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <tip-5f26c50143f58f256535bee8d93a105f36d4d2da@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 04/27/2018 01:00 PM, tip-bot for Ingo Molnar wrote:
> Commit-ID:  5f26c50143f58f256535bee8d93a105f36d4d2da
> Gitweb:     https://git.kernel.org/tip/5f26c50143f58f256535bee8d93a105f36d4d2da
> Author:     Ingo Molnar <mingo@kernel.org>
> AuthorDate: Fri, 27 Apr 2018 11:54:40 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri, 27 Apr 2018 12:42:04 +0200
> 
> x86/bpf: Clean up non-standard comments, to make the code more readable
> 
> So by chance I looked into x86 assembly in arch/x86/net/bpf_jit_comp.c and
> noticed the weird and inconsistent comment style it mistakenly learned from
> the networking code:
> 
>  /* Multi-line comment ...
>   * ... looks like this.
>   */
> 
> Fix this to use the standard comment style specified in Documentation/CodingStyle
> and used in arch/x86/ as well:
> 
>  /*
>   * Multi-line comment ...
>   * ... looks like this.
>   */
> 
> Also, to quote Linus's ... more explicit views about this:
> 
>   http://article.gmane.org/gmane.linux.kernel.cryptoapi/21066
> 
>   > But no, the networking code picked *none* of the above sane formats.
>   > Instead, it picked these two models that are just half-arsed
>   > shit-for-brains:
>   >
>   >  (no)
>   >      /* This is disgusting drug-induced
>   >        * crap, and should die
>   >        */
>   >
>   >   (no-no-no)
>   >       /* This is also very nasty
>   >        * and visually unbalanced */
>   >
>   > Please. The networking code actually has the *worst* possible comment
>   > style. You can literally find that (no-no-no) style, which is just
>   > really horribly disgusting and worse than the otherwise fairly similar
>   > (d) in pretty much every way.
> 
> Also improve the comments and some other details while at it:
> 
>  - Don't mix same-line and previous-line comment style on otherwise
>    identical code patterns within the same function,
> 
>  - capitalize 'BPF' and x86 register names consistently,
> 
>  - capitalize sentences consistently,
> 
>  - instead of 'x64' use 'x86-64': x64 is a Microsoft specific term,
> 
>  - use more consistent punctuation,
> 
>  - use standard coding style in macros as well,
> 
>  - fix typos and a few other minor details.
> 
> Consistent coding style is not optional, at least in arch/x86/.
> 
> No change in functionality.

Thanks for the cleanup, looks fine to me!

> ( In case this commit causes conflicts with pending development code
>   I'll be glad to help resolve any conflicts! )

Any objections if we would simply route this via bpf-next tree, otherwise
this will indeed cause really ugly merge conflicts throughout the JIT with
pending work.

> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks,
Daniel
