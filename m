Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8FEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86BE20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slmExzFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86BE20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJZBnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:43:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35375 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeJZBnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:43:01 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so2711168itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZYi+EgnoFVRMV/WJxW/n1ofzzda+MhmlkHTFsWOPWUg=;
        b=slmExzFpNjHmGoboh0UhDs1k6p160FvM9iztNN+xGmm4sslkC3+wVWuEyXOXx6cz/C
         M8IZRSjJzFHAVzJRoSA6fGeVTNth/5qd4EsP25bZEFp1sXbf6NTlVs6aZ3FJ6WK3VFGy
         F4wgAd4Ysg9/vt8F74VeU/geH8WCo1onohTdQ4oBxCPkg3Ucou0+9MmwLgla0wQVMw7F
         9QSX9iaqbSpSiGPDXBNdYDOnKkES/+jeuZLiB0dVMyNvLc8jpPuUv7331SzufxYrIihx
         1a/M5DpxCvg8ciovsrgGLdZZwx+gdYQA1px25Z75sp4T/6DSibdzLekOHj3Q0bxJrPYt
         of0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZYi+EgnoFVRMV/WJxW/n1ofzzda+MhmlkHTFsWOPWUg=;
        b=bbIJNSXowiBSNRjL+zmJzQSWCZ31cNQBUGykbbOK+yEyw0LrLJCC0dLIPjEiDQp+eM
         f8JeuHFmqnbQzrnk9xTNhN5IozKKSUnk4KUwCfdmtVwXu2Wlpt6F4TxoK/aTAX+JkshX
         bYSbSBV1bj5DUUoUdgtyNpLY2TTq086BPF84W7fPPzlDkgyqjoO+26kz+t5SsKs5O8R3
         6ztFpOFBEsT6JyiictL38sZJx8A2EeJoeikB7cdZ8AM16zH2KUVo6IfXdmKgXEGiIWVQ
         XFkHvRVjaa7rLxyQ0hQctUa4F8tbPe1wdoXUpOMCBNvT8Cx7kE0t8leWTAy6ALlP4XC5
         v3oA==
X-Gm-Message-State: AGRZ1gIV7moar/jROTqS5e+DtDVx5GpacIaARyMf+CUr7fzsjpq2wr3d
        MvFTSR7O29Wd5h6d2Ix1Bz1Ot12iY3+20ZCh
X-Google-Smtp-Source: AJdET5cLHOP9onKugiIxN7WIVXS/GNiHfXGZCvny0Ch68rHo0qdDflF9NXsjAHqd0PXWhIuUkssT3w==
X-Received: by 2002:a02:8c8b:: with SMTP id f11-v6mr50415jak.37.1540487360089;
        Thu, 25 Oct 2018 10:09:20 -0700 (PDT)
Received: from vorpal.bld.corp.google.com ([2620:15c:183:0:d68b:e645:8da4:bbe1])
        by smtp.gmail.com with ESMTPSA id w134-v6sm827219itc.12.2018.10.25.10.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 10:09:19 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:09:17 -0600
From:   Benjamin Gordon <bmgordon@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
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
Subject: Re: [PATCH] proc: use ns_capable instead of capable for timerslack_ns
Message-ID: <20181025170916.GA170325@vorpal.bld.corp.google.com>
References: <20181017224738.193598-1-bmgordon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017224738.193598-1-bmgordon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 04:47:38PM -0600, bmgordon@google.com wrote:
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
>  		return -ESRCH;
>  
>  	if (p != current) {
> -		if (!capable(CAP_SYS_NICE)) {
> +		if (!ns_capable(file->f_cred->user_ns, CAP_SYS_NICE)) {
>  			count = -EPERM;
>  			goto out;
>  		}
> @@ -2393,7 +2393,7 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
>  
>  	if (p != current) {
>  
> -		if (!capable(CAP_SYS_NICE)) {
> +		if (!ns_capable(seq_user_ns(m), CAP_SYS_NICE)) {
>  			err = -EPERM;
>  			goto out;
>  		}
> -- 
> 2.19.1.331.ge82ca0e54c-goog
> 

Friendly ping.  Does anybody have time to take a look at this?

Thanks,
Benjamin
