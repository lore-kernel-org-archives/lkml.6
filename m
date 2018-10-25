Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2244ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DBC2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2R7sD3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DBC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJZByC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:54:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44950 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeJZByC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:54:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so10132563wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1bJs3q1wp8WqpHBYXRCtRsUapjWa79UF45pDkektjFM=;
        b=D2R7sD3j91f2Ca5iUU4T8nVOL5FlvnHfzOcMpW8Bjrm3nF7iPO6x+2TMGukTXawDKR
         Xq4JsJdjHhjFInDFcNlJg/15npPZeIsR2lOw0JjD1OY/Hp28TuCMOSrbTeQ5fHRnyLi8
         2zO3SKxWPxY+x1PJ18DjtNXRH9QhyChQBr4A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1bJs3q1wp8WqpHBYXRCtRsUapjWa79UF45pDkektjFM=;
        b=HC+Wxf5iKpxi8Axqq4rHElWkiM63ITaYJzjQzFzEyL9XkqwRUraWvAu/astn5EbkBP
         lwhoZUPV9583xJKG/0t4boj66o48NLBJ+y/Rex+EMkhjYZcNzs07CaNzlLm8wr0muf/r
         db/CZAsSjUUmSw/r477iErppZjZyyonRGpZFySctC++mqQxNRUfSmCncCXxB2MRaCMwx
         mN6Z4/W2K8vnzqVrJICM5C5G7YBV4uTXm+io7iq0Pi/DRSWDiW76kHn1zAuN8WrMO8bm
         RwMDkQaJUWp9hjbgvuEnN3IJFymhj/JRDat/wgpkjgrDl0ZQ8u18VAE/VxggdRERWVRB
         G88g==
X-Gm-Message-State: AGRZ1gJABtlZZS9RT8GkSMPrl5zCio4nG+3tEJBOKDOAM+U+h6gq1kWb
        9aPpZz2/ENXxaDkj9jCb29nj/lcFX5IIbtWgPK4xDw==
X-Google-Smtp-Source: AJdET5dfBHPB5FPqT5RvRWYd3NGWr1FOe6jvPdBb9cS9JzXGAFpA3lH7CRBBbP4TXniCzevm2K1k8rBKq8M/8qFOjCY=
X-Received: by 2002:a5d:4f0d:: with SMTP id c13-v6mr2790323wru.50.1540488019347;
 Thu, 25 Oct 2018 10:20:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 10:20:18
 -0700 (PDT)
In-Reply-To: <20181017224738.193598-1-bmgordon@google.com>
References: <20181017224738.193598-1-bmgordon@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 25 Oct 2018 10:20:18 -0700
Message-ID: <CALAqxLVUYEKXs2ATieTd-3Zs4AbhSPpeGQS=PMiSGbXGkx_JAA@mail.gmail.com>
Subject: Re: [PATCH] proc: use ns_capable instead of capable for timerslack_ns
To:     bmgordon@google.com
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Oren Laadan <orenl@cellrox.com>,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Rom Lemarchand <romlem@android.com>,
        Todd Kjos <tkjos@google.com>, Colin Cross <ccross@android.com>,
        Nick Kralevich <nnk@google.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Elliott Hughes <enh@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 3:47 PM,  <bmgordon@google.com> wrote:
> From: Benjamin Gordon <bmgordon@google.com>
>
> Access to timerslack_ns is controlled by a process having CAP_SYS_NICE
> in its effective capability set, but the current check looks in the root
> namespace instead of the process' user namespace.  Since a process is
> allowed to do other activities controlled by CAP_SYS_NICE inside a
> namespace, it should also be able to adjust timerslack_ns.
>
> Signed-off-by: Benjamin Gordon <bmgordon@google.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Oren Laadan <orenl@cellrox.com>
> Cc: Ruchi Kandoi <kandoiruchi@google.com>
> Cc: Rom Lemarchand <romlem@android.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Nick Kralevich <nnk@google.com>
> Cc: Dmitry Shmidt <dimitrysh@google.com>
> Cc: Elliott Hughes <enh@google.com>
> Cc: Android Kernel Team <kernel-team@android.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  fs/proc/base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 7e9f07bf260d..4b50937dff80 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2356,7 +2356,7 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>                 return -ESRCH;
>
>         if (p != current) {
> -               if (!capable(CAP_SYS_NICE)) {
> +               if (!ns_capable(file->f_cred->user_ns, CAP_SYS_NICE)) {
>                         count = -EPERM;
>                         goto out;
>                 }
> @@ -2393,7 +2393,7 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
>
>         if (p != current) {
>
> -               if (!capable(CAP_SYS_NICE)) {
> +               if (!ns_capable(seq_user_ns(m), CAP_SYS_NICE)) {
>                         err = -EPERM;
>                         goto out;
>                 }

Looks reasonable to me.
Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
