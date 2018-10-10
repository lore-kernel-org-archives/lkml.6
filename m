Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F25C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6933721479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCrY5ctr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6933721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJJOhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:37:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39294 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:37:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so2071619pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JvjmEnQo5V0LqlPpEvTB8hjKWKaSDSBbvp0DdV6f1K4=;
        b=KCrY5ctrMmBrDkdV0e9+s/CI7X9cLOoWbtOWz8amfarhjUPyTZNqFj6+LR79D/3hWP
         3yv+DvhsyriNkjW3XFNHQUZrHMVrtAMcASC0p7mNLoFlfMUMozmE32imWRlXjq0onvaR
         71IOEY8bR6NbiPegiCv50/Lhqt5YosO6v7rFOmREjdQ2qHxnSBGdgul5qFQPtUh25e8F
         WEzSRi/9V71dEWGJ4OQbrTPMYOwJZq8d3mGaDGRJ1Sg4ImVNv+c5e3TT+e0txBufYEqB
         jJXfhPLKHJDBoM9WLx+9Ie9KOvWo+ZrMsBYu4FoCFZC16b4Zb2H3qSI66eSTmlXvAiWt
         0+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JvjmEnQo5V0LqlPpEvTB8hjKWKaSDSBbvp0DdV6f1K4=;
        b=ZzTsH1waJLZeozIVOC3lxLi57WUnUDUUGMGbonK7QaqOxjQC3k3ScRQam0+MPKmtw/
         Ax6eZCfJVEKnyLZl+X9Ovq9UH0FSGW1TUdF3cJ7fJaT6p65tC2Ejp9EF+MEOwvJPtIsY
         KBoO/i2ewK+i43Oy9X87hUazSvhIyqPnT2LDD3fgHz4OiejMUrDqYjo3KNQ0xiUcDlx5
         5bw3xpJ5uwsv9BFwXAqa6W8EOBbpYwn7clgJYt+ez87wqEWEUdhqg74dtfsmr5lDMfj6
         xjeCxz8bG2O4GcOK155qJKroWaS9PpwRDllY9UTapy5Hbf5PWe3lBnCIge+BDJp7KOkv
         KRwA==
X-Gm-Message-State: ABuFfohUrDCEpC9ARdv1HYBBX1XeRzv5TlIFvYlLcxGeSnk7+iZAxMbw
        2A1PjZfUWsy5omXnx9r98e8=
X-Google-Smtp-Source: ACcGV606P+Mx3aodfMn6CWEdDKzAku3axrlHyLg5+/HPRuxT3SxGreT1MCf+okAnaAhScYHDqrFEnA==
X-Received: by 2002:a62:6506:: with SMTP id z6-v6mr18922104pfb.20.1539155789552;
        Wed, 10 Oct 2018 00:16:29 -0700 (PDT)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id z26-v6sm19108462pfh.77.2018.10.10.00.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 00:16:29 -0700 (PDT)
Date:   Wed, 10 Oct 2018 00:16:26 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org, dvyukov@google.com,
        andreyknvl@google.com, w@1wt.eu, avagin@openvz.org
Subject: Re: [PATCH] ptrace: zero out siginfo_t in ptrace_peek_siginfo()
Message-ID: <20181010071626.GA2351@gmail.com>
References: <20180926151725.63120-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180926151725.63120-1-glider@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:17:25PM +0200, Alexander Potapenko wrote:
> KMSAN reported the following infoleak:
> 
> ==================================================================
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0x15d/0x1f0
> ...
> Call Trace:
>  __dump_stack lib/dump_stack.c:77
>  dump_stack+0x2f5/0x430 lib/dump_stack.c:113
>  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:917
>  kmsan_internal_check_memory+0x17e/0x1f0 mm/kmsan/kmsan.c:981
>  kmsan_copy_to_user+0x79/0xc0 mm/kmsan/kmsan_hooks.c:482
>  _copy_to_user+0x15d/0x1f0 lib/usercopy.c:31
>  copy_to_user ./include/linux/uaccess.h:183
>  copy_siginfo_to_user+0x81/0x130 kernel/signal.c:2897
>  ptrace_peek_siginfo kernel/ptrace.c:741
>  ptrace_request+0x2278/0x2680 kernel/ptrace.c:912
>  arch_ptrace+0xbdd/0x11a0 arch/x86/kernel/ptrace.c:877
>  __do_sys_ptrace kernel/ptrace.c:1145
>  __se_sys_ptrace+0x422/0x920 kernel/ptrace.c:1110
>  __x64_sys_ptrace+0x56/0x70 kernel/ptrace.c:1110
>  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7 arch/x86/entry/entry_64.S:240
> ...
> Local variable description: ----info.i@ptrace_request
> Variable was created at:
>  ptrace_peek_siginfo kernel/ptrace.c:712
>  ptrace_request+0xdf/0x2680 kernel/ptrace.c:912
>  arch_ptrace+0xbdd/0x11a0 arch/x86/kernel/ptrace.c:877
> 
> Bytes 16-127 of 128 are uninitialized
> Memory access starts at ffff88007af6fc90
> ==================================================================
> 
> when calling ptrace(PTRACE_PEEKSIGINFO) for a traceable child process
> with args = {-1, 0, 1}.
> 
> Initialize the |info| structure to avoid leaking stack data.


"info" is filled up by copy_siginfo(), which overwrites everything.

static inline void copy_siginfo(struct siginfo *to, const struct siginfo *from)
{
        memcpy(to, from, sizeof(*to));
}


so here is another problem. We handle arg.off incorrectly. The right fix
should look something like this:

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..e336434a6f71 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -710,7 +710,7 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 
        for (i = 0; i < arg.nr; ) {
                siginfo_t info;
-               s32 off = arg.off + i;
+               u64 off = arg.off + i;
 
                spin_lock_irq(&child->sighand->siglock);
                list_for_each_entry(q, &pending->list, list) {
@@ -721,7 +721,7 @@ static int ptrace_peek_siginfo(struct task_struct *child,
                }
                spin_unlock_irq(&child->sighand->siglock);
 
-               if (off >= 0) /* beyond the end of the list */
+               if (off + 1 != 0) /* beyond the end of the list */
                        break;
 
 #ifdef CONFIG_COMPAT


> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reported-by: syzbot+69c3bd9869b32e394c48@syzkaller.appspotmail.com
> Fixes: 84c751bd4aebb ("ptrace: add ability to retrieve signals without
> removing from a queue (v4)")
> Cc: Andrey Vagin <avagin@openvz.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Willy Tarreau <w@1wt.eu>
> ---
>  kernel/ptrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 21fec73d45d4..92c3855c2b9c 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -712,6 +712,7 @@ static int ptrace_peek_siginfo(struct task_struct *child,
>  		siginfo_t info;
>  		s32 off = arg.off + i;
>  
> +		memset(&info, 0, sizeof(info));
>  		spin_lock_irq(&child->sighand->siglock);
>  		list_for_each_entry(q, &pending->list, list) {
>  			if (!off--) {
> -- 
> 2.19.0.605.g01d371f741-goog
> 
