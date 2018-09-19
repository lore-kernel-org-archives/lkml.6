Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C86BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C5F208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjgitdaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C5F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeISXjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:39:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44554 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeISXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:39:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so3020692plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iodWH16tNXBIZSVULTjGMB7maj/1WWXhG4oq/jTWICs=;
        b=HjgitdaNCaKi5JhvfAGLRlxflTw+u0hYBPOSUGxkFRn7Mz4NbO6BE+IFcFj/WK4NsR
         HemQ3j5awn9WXbQ1wvT60j38Ic5NrRNTqHmug8jNCj5eSmLUgU8ePVAC99/4D3AD3rIC
         izKL4vZOwA3fB8pVezCaWQwO3Jhs9qTZFJ/0zwaVPBk8LhglDZMRSpILX4r90qEwdwg8
         87CD3TvPycLd7LvX2tT2UyiuGuvz7PTAvTS3R4TifiSxnMqob9Wyoi2a4XlgMCZACs8G
         cUulc0W8cQf6AQONVhPZaguxA9YDwrJhcE3I9sgW/uqzW918gmcj38N4Yk3fDMMGHyrn
         xvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iodWH16tNXBIZSVULTjGMB7maj/1WWXhG4oq/jTWICs=;
        b=XkVZaMHtJ9p+8/WxdClhYyoqUZKzqwEe1JSRvRYDybpupFqw02VZLHrrA9btVTlqlh
         Ko+FAzn9ZQRvj8bOD6PL9L7e8mPDGTHH+kakBrxWbQD6Z/HjzomEHW50/tGYHMepj4xl
         f60bpDvBRm71Ov58Pu3LrTldCxSSwMyHHOpuuBwQJokmoIqca+nBf4paLCRUHgXBipsy
         NZ+gVZReIvAvfI5NSq/C6sphdBR2Er2fO/LypS140TwSK12hpW858eprwZZNAPlT1Wlg
         zAkajkYtq+K2Glf0Cx3N/T7ma8XWrNw5RrboYXxw/IJQluIIhLkCO+D1P/qpY06U7bxW
         KI8A==
X-Gm-Message-State: APzg51CfJjOeodNXrO3waqQBudjOS0u8035kHUrKe5+4Rri6Bxn3dsyl
        ngBqpQaFAV+7Q7EmUelQg/VvfjgpfYuCGSl0aM1RgQ==
X-Google-Smtp-Source: ANB0VdbRZBH8vyEFg2MWngQc5u7r7Exs7aCudkLvWnOzGowSakkN0tqgdllyCInX9fZLfkrn3t+iK8OC7jNkM0fHLHk=
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr35320706plf.320.1537380002454;
 Wed, 19 Sep 2018 11:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180919003147.55692-1-mka@chromium.org>
In-Reply-To: <20180919003147.55692-1-mka@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Sep 2018 10:59:51 -0700
Message-ID: <CAKwvOd=X1K4Gm0GyoDpmPTrTPQ_6+Nvzg9J8y4gdy-R=67_72A@mail.gmail.com>
Subject: Re: [PATCH] sysrq: Use panic() to force a crash
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        saiprakash.ranjan@codeaurora.org,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        manojgupta@chromium.org, ani@arista.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 5:32 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> sysrq_handle_crash() currently forces a crash by dereferencing a
> NULL pointer, which is undefined behavior in C. Just call panic()
> instead, which is simpler and doesn't depend on compiler specific
> handling of the undefined behavior.
>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Not sure if it is strictly needed to release the RCU read lock now
> that panic() is invoked directly (I couldn't repro the warning
> without rcu_read_unlock()), but since this is a forced crash it
> seems good practice to keep doing it.
>
> The commit that added rcu_read_unlock() and the comment is:
>
> commit 984cf355aeaa8f2eda3861b50d0e8d3e3f77e83b
> Author: Ani Sinha <ani@arista.com>
> Date:   Thu Dec 17 17:15:10 2015 -0800
>
>     sysrq: Fix warning in sysrq generated crash.
>
>     Commit 984d74a72076a1 ("sysrq: rcu-ify __handle_sysrq") replaced
>     spin_lock_irqsave() calls with rcu_read_lock() calls in sysrq. Since
>     rcu_read_lock() does not disable preemption, faulthandler_disabled() in
>     __do_page_fault() in x86/fault.c returns false. When the code later calls
>     might_sleep() in the pagefault handler, we get the following warning:
>
>     BUG: sleeping function called from invalid context at ../arch/x86/mm/fault.c:1187
>     in_atomic(): 0, irqs_disabled(): 0, pid: 4706, name: bash
>     Preemption disabled at:[<ffffffff81484339>] printk+0x48/0x4a
>
>     To fix this, we release the RCU read lock before we crash.
>
>     Tested this patch on linux 3.18 by booting off one of our boards.
> ---
>  drivers/tty/sysrq.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 06ed20dd01ba..d779a51499a0 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -134,17 +134,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
>
>  static void sysrq_handle_crash(int key)
>  {
> -       char *killer = NULL;
> -
> -       /* we need to release the RCU read lock here,
> -        * otherwise we get an annoying
> -        * 'BUG: sleeping function called from invalid context'
> -        * complaint from the kernel before the panic.
> -        */
> +       /* release the RCU read lock before crashing */

The comment probably could have stayed as is; folks will have to get
context from git blame on the line immediately below now; while you
added context in the patch file, it's below the line so wont be part
of the commit message.

>         rcu_read_unlock();
> -       panic_on_oops = 1;      /* force panic */
> -       wmb();
> -       *killer = 1;
> +
> +       panic("sysrq triggered crash\n");

Otherwise this part looks good. Maybe GKH can apply just this part
rather than a v2 (if we even care about git blame on comments)?
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>  }
>  static struct sysrq_key_op sysrq_crash_op = {
>         .handler        = sysrq_handle_crash,
> --
> 2.19.0.397.gdd90340f6a-goog
>


-- 
Thanks,
~Nick Desaulniers
