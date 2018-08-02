Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A48C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2723721537
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc9Apsxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2723721537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeHBVqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:46:39 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37959 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHBVqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:46:39 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so5209105itb.3;
        Thu, 02 Aug 2018 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7p8mIWf/t8LtjE55u0+fpsgskGxy2peYtkHsQGFdXbs=;
        b=gc9Apsxe5TjepHnJDyt/m2ksSDqPmXKL2fPL6BCsy6ps7tjIKyKkmGUkCyyME7bNmK
         +e/1qgLrVhn1HKJMTcnGtdyON1z+Hj+RrCtkFh9r/MzXR3lPvobzxtZksBe36dkABg3D
         txDv75SoFPVfXKmR1XzmU+NAG6EGLkUGHji5Gf5pW3QgXunZWcOi6odVgyMwmcvA9tL5
         NWsx2tuIjRRpuspjScNtCbqtkIAuOOtYROHYXKC+PdC9BZuUxJQ2HSWjZAvYTUUDMsH/
         5yS9/WqtlIkIz7cQzv54mNRx5QoccpqAIcA8v8UDGllHzETfw7J0jlrEb/LSQQIHxZui
         lokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7p8mIWf/t8LtjE55u0+fpsgskGxy2peYtkHsQGFdXbs=;
        b=qevQJUSpPJiqdgmqE3M20LScAkeY1Nfv15ZWMYPcmxwvjvpGDbah1SpwX4gSs5jWE+
         qjFKsYywRVZ7hXaS8gwqfL5nU4Azxdn2fHMoAMeYIrpXilQypyA/IjXfT41ZGJ8Ftzz+
         h/M1vKDJQ7R+ZUpv41WQdh52RGj3cpfdVJn9RHF8bYSqeHmMtAnH0tHbbOPg5ETG0qdN
         p8B6e4TEf8+mhq09xEv6DnWjI2BWXmMi3npKmoCYXzp6njUQvaS9jlDab/v5PC/xLao7
         FfqmW5jhpdZqGRAIsahn3lk02936wvzri+QqxGgJ7/jTM2wKukeUB/l32gupsqeBm6tp
         kVYQ==
X-Gm-Message-State: AOUpUlGgOVwzDKIGUfY5DSQOFVG27owXINCEYecdAr7aIkhgi9Q0r+yQ
        Hc58tQOwqRsCNKaePAqR3llwB7Jrfv7xrqoF0/u9YGO4
X-Google-Smtp-Source: AAOMgpdMzAbq+vbXQGYsDMLYuhYTFj3Fe0lYFOjRCCUStEPBNPv+ETIt1Om+dXFa3+LOCk/3blmMbyoXCU/Q3ISRchs=
X-Received: by 2002:a02:943:: with SMTP id f64-v6mr919178jad.31.1533239642044;
 Thu, 02 Aug 2018 12:54:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:bc4a:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 12:53:41 -0700 (PDT)
In-Reply-To: <20180731005615.GA2911@visor>
References: <20180731005615.GA2911@visor>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Thu, 2 Aug 2018 20:53:41 +0100
Message-ID: <CAJwJo6bmFZ+2wni1d-t2hh_RqYvnN2c+NJPNyrBLp9H=StTZFg@mail.gmail.com>
Subject: Re: [PATCH RESEND] exec: don't force_sigsegv processes with a pending
 fatal signal
To:     Ivan Delalande <colona@arista.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

2018-07-31 1:56 GMT+01:00 Ivan Delalande <colona@arista.com>:
> We were seeing unexplained segfaults in coreutils processes and other
> basic utilities that we tracked down to binfmt_elf failing to load
> segments for ld.so. Digging further, the actual problem seems to occur
> when a process gets sigkilled while it is still being loaded by the
> kernel. In our case when _do_page_fault goes for a retry it will return
> early as it first checks for fatal_signal_pending(), so load_elf_interp
> also returns with error and as a result search_binary_handler will
> force_sigsegv() which is pretty confusing as nothing actually failed
> here.
>
> Fixes: 19d860a140be ("handle suicide on late failure exits in execve() in search_binary_handler()")
> Reference: https://lkml.org/lkml/2013/2/14/5
> Signed-off-by: Ivan Delalande <colona@arista.com>

+Cc: Oleg Nesterov <oleg@redhat.com>
+Cc: Andy Lutomirski <luto@kernel.org>

> ---
>  fs/exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index bdd0eacefdf5..6e8007edbb2d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1656,7 +1656,8 @@ int search_binary_handler(struct linux_binprm *bprm)
>                 if (retval < 0 && !bprm->mm) {
>                         /* we got to flush_old_exec() and failed after it */
>                         read_unlock(&binfmt_lock);
> -                       force_sigsegv(SIGSEGV, current);
> +                       if (!fatal_signal_pending(current))
> +                               force_sigsegv(SIGSEGV, current);

I would suggest to add something like:
: if (print_fatal_signals)
:         pr_info("load_binary() failed: %d\n", retval);

It was interesting to catch that it actually segfaults during loading,
probably will save someone a couple of minutes too ;-)

>                         return retval;
>                 }
>                 if (retval != -ENOEXEC || !bprm->file) {

Thanks,
             Dmitry
