Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2373960-1518213697-2-9273802797555473908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518213697; b=Je7Zh0ypzX3le5qBoecrNhk6fPUdkD365BSUmSHQNsfmJUq
    hoRHnMB84bva8mFO51j1lyODROfqMrgD1HJ6dXkZSoubPJv8QrSwupVKqqcb7OvN
    Gwk0Gs7wfzpNNUfug3imLW1ZUU2OLfm5xtdRvVrmfwNynHBY53t69tJ2RsSZ3XGQ
    ZzeU46UsePDlBn9ea+P9D+XjbbiUD4Acsjs2ebpnKwMNKd40iKJn7PC7HmG1cLkc
    sCjm7v3ISlAmt7zEBYNeojWy+mOx9fwXVKI3vl8+kRM8Ai/6vI9z8wOgqtD3YCOx
    1dxqsykIAGAtNn4biv0es7X8YePM8McYpbqSxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518213697; bh=Tp7PzciY3lrNKVYUlDki9MkMlRHpPMlG0hqxe/
    s2BkU=; b=kjO9BHYnyXf58zDe7XNiEuj2s+EEc0RH08WPrKEhder60eS9A2EmHw
    7Oyp+0/s9aIBdXwlAHC37Y+lIkU3mT+gh41Lo32VyzWDyahHBMBgTdf/1bgxrxss
    XDVpw/OX83wyxeI8Ye9AQOugKO4qi+3MYEHWsD4xqTw1rJW3ZN1iYkH1TxfZAFbB
    UFy77q7qPswg7h8R84mbxBMOxje+M0/lEsxGcrk8h3W61WiYz/WgexBUleoFp3GC
    6oKVWaXFdCqLsHDj22cAn/+g1FXjPzetry5cOSkCjgrjNdemF2BqASpjsqN+6/WI
    pIH+JVRdQWmo3zsICDZ61S4tqXGgBodQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Qd01IboD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KzGOAzhR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Qd01IboD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KzGOAzhR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbeBIWBf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 17:01:35 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43025 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeBIWBf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 17:01:35 -0500
X-Google-Smtp-Source: AH8x227CeKPmWwrdRltnEk3ImQfRoeLeW6iXm4v8UhaavA+pqlwXmLz8YKJ472WTawsXeQuGlEQQsd7fKuND99wFnZo=
MIME-Version: 1.0
In-Reply-To: <20180209133934.472824776@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org> <20180209133934.472824776@linuxfoundation.org>
From: Kees Cook <keescook@google.com>
Date: Fri, 9 Feb 2018 14:01:32 -0800
Message-ID: <CAGXu5jJ2K3SziXQsy-w5VOu9-V3H79w0OFQQFFnZiezUyc53Vg@mail.gmail.com>
Subject: Re: [PATCH 4.9 46/92] x86/alternative: Print unadorned pointers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Paul Turner <pjt@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartmann <gregkh@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 5:39 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Borislav Petkov <bp@suse.de>
>
> (cherry picked from commit 0e6c16c652cadaffd25a6bb326ec10da5bcec6b4)
>
> After commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers are being hashed when printed. However, this makes the alternative
> debug output completely useless. Switch to %px in order to see the
> unadorned kernel pointers.

This missed a "Fixes:" tag so probably missed automated checking on
how far back to port this. It shouldn't go back beyond 4.15 (where
ad67b74d2469 first appeared).

-Kees

>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: riel@redhat.com
> Cc: ak@linux.intel.com
> Cc: peterz@infradead.org
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: jikos@kernel.org
> Cc: luto@amacapital.net
> Cc: dave.hansen@intel.com
> Cc: torvalds@linux-foundation.org
> Cc: keescook@google.com
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: tim.c.chen@linux.intel.com
> Cc: gregkh@linux-foundation.org
> Cc: pjt@google.com
> Link: https://lkml.kernel.org/r/20180126121139.31959-2-bp@alien8.de
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/kernel/alternative.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -298,7 +298,7 @@ recompute_jump(struct alt_instr *a, u8 *
>         tgt_rip  = next_rip + o_dspl;
>         n_dspl = tgt_rip - orig_insn;
>
> -       DPRINTK("target RIP: %p, new_displ: 0x%x", tgt_rip, n_dspl);
> +       DPRINTK("target RIP: %px, new_displ: 0x%x", tgt_rip, n_dspl);
>
>         if (tgt_rip - orig_insn >= 0) {
>                 if (n_dspl - 2 <= 127)
> @@ -352,7 +352,7 @@ static void __init_or_module optimize_no
>         sync_core();
>         local_irq_restore(flags);
>
> -       DUMP_BYTES(instr, a->instrlen, "%p: [%d:%d) optimized NOPs: ",
> +       DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
>                    instr, a->instrlen - a->padlen, a->padlen);
>  }
>
> @@ -370,7 +370,7 @@ void __init_or_module apply_alternatives
>         u8 *instr, *replacement;
>         u8 insnbuf[MAX_PATCH_LEN];
>
> -       DPRINTK("alt table %p -> %p", start, end);
> +       DPRINTK("alt table %px, -> %px", start, end);
>         /*
>          * The scan order should be from start to end. A later scanned
>          * alternative code can overwrite previously scanned alternative code.
> @@ -394,14 +394,14 @@ void __init_or_module apply_alternatives
>                         continue;
>                 }
>
> -               DPRINTK("feat: %d*32+%d, old: (%p, len: %d), repl: (%p, len: %d), pad: %d",
> +               DPRINTK("feat: %d*32+%d, old: (%px len: %d), repl: (%px, len: %d), pad: %d",
>                         a->cpuid >> 5,
>                         a->cpuid & 0x1f,
>                         instr, a->instrlen,
>                         replacement, a->replacementlen, a->padlen);
>
> -               DUMP_BYTES(instr, a->instrlen, "%p: old_insn: ", instr);
> -               DUMP_BYTES(replacement, a->replacementlen, "%p: rpl_insn: ", replacement);
> +               DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
> +               DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
>
>                 memcpy(insnbuf, replacement, a->replacementlen);
>                 insnbuf_sz = a->replacementlen;
> @@ -422,7 +422,7 @@ void __init_or_module apply_alternatives
>                                  a->instrlen - a->replacementlen);
>                         insnbuf_sz += a->instrlen - a->replacementlen;
>                 }
> -               DUMP_BYTES(insnbuf, insnbuf_sz, "%p: final_insn: ", instr);
> +               DUMP_BYTES(insnbuf, insnbuf_sz, "%px: final_insn: ", instr);
>
>                 text_poke_early(instr, insnbuf, insnbuf_sz);
>         }
>
>



-- 
Kees Cook
Pixel Security
