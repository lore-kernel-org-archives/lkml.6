Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427B9ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B632156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="VsIHpR11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B632156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391511AbeIVDpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:45:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44525 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVDpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:45:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so14139219wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhAqwxmSlvwG5D/FFRX9XGwLh3Nq4ZzZcJPLMSHQzHU=;
        b=VsIHpR11yxEiA8P5Ig4Mjdm90VlXlmRduW11Tw7lJqy/psKFHiVjNcih3ETniS/hye
         srqCf2GNzu9jFzblwMvOcBGWRLo3l7Pg8UOQSM4lkjOSZ0ODQnhUXR3Z6Zd4Yzg/ghjS
         XgOjk2xKtty7fKZJxQ7dGpRkh9yBT6lj/KE7a9WRLIqMuzvBPSW9O+3GKMNHG85SCNYK
         2mQPVPjBnYR82XTdalGUVgIycNJspixj23nvI6EVykRaeHwSKL2WDwK9nHWnfyQlSAg+
         6w+Ln7wcVpA/FKgLEl29J++8R2qhET5rIL82NVHg62o4ymQ0qTPpKcgtSGliaqb7zd2J
         9bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhAqwxmSlvwG5D/FFRX9XGwLh3Nq4ZzZcJPLMSHQzHU=;
        b=H2wfCV0OgjZ72T9cA/p1F+CjAxoh6Oczm0m7BKSIvBttkLnD0Lqj+H4HFAu3q6a0pG
         7tNzn26oGqEyjSkaFDynFXQlKNZIWz52lqOTeujH1raiQ8GrfHSVjRZffCA+B15Agn7W
         Cm6Dkwan1m6Ugl4UOP6+HsHAoPmQqOJORD3peB2SKOf+BYhMCsI3OFoiFMY+VeQUUzKT
         X2MNzQWefn22Wxr6H9/OQZO9lieXBuzrwmaW8svvaNyzbioa9NgPMzV2kmFgzL98mdBy
         G5rx8DnYKqdd6WEC2DzKplrBqrLGM/AoDpu/6my/906FvjkWfufiWm76dkVPK3hHBXK1
         lIQw==
X-Gm-Message-State: APzg51AprMrIMm4qnwM0bV+cTMnfm0ESEiZIeW9TAEZ/92XRLfQRZWDw
        tu9U/LZGVgZEL9gMeVqpHOKpl7Vibkjp+zDsgHbClw==
X-Google-Smtp-Source: ANB0VdZrqGiVRgGMLA8kh/syWelX7sqm9YQnkChbW+IGx02ky3gLm0KFFvU6hGA1UwvfPfSkE1fjYYnHkjYRpZLw8Aw=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr39964315wrh.148.1537566895717;
 Fri, 21 Sep 2018 14:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180921212041.13096-1-tedheadster@gmail.com> <20180921212041.13096-3-tedheadster@gmail.com>
In-Reply-To: <20180921212041.13096-3-tedheadster@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 21 Sep 2018 14:54:43 -0700
Message-ID: <CALCETrWnkR30m9OpakorHyLJX0RK4kQWA4xyyRVCGunO5dm-EQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/cpu: Change query logic so cpuid is enabled
 before testing
To:     Matthew Whitehead <tedheadster@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 2:21 PM Matthew Whitehead <tedheadster@gmail.com> wrote:
>
> Presently we check for cpuid to be enabled first. If it is not already
> enabled, then we next call identify_cpu_without_cpuid() and clear
> X86_FEATURE_CPUID.
>
> Unfortunately, identify_cpu_without_cpuid() is the function where cpuid
> becomes _enabled_ on Cyrix 6x86/6x86L cpus. So we must reverse the
> calling sequence so that cpuid is first enabled, and then check a second
> time to see if the feature has now been activated.
>
> Reviewed-by: Andy Lutomirski <luto@amacapital.net>

How about Suggested-and-reviewed-by: Andy Lutomirski <luto@kernel.org> instead?

(No need to resubmit for just that.  Ingo or Thomas, if you like
these, can you just make that substitution?)

> Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
> ---
>  arch/x86/kernel/cpu/common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index eb4cb3efd20e..60c7c5ce7e55 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1040,6 +1040,9 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>         memset(&c->x86_capability, 0, sizeof c->x86_capability);
>         c->extended_cpuid_level = 0;
>
> +       if (!have_cpuid_p())
> +               identify_cpu_without_cpuid(c);
> +
>         /* cyrix could have cpuid enabled via c_identify()*/
>         if (have_cpuid_p()) {
>                 cpu_detect(c);
> @@ -1057,7 +1060,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>                 if (this_cpu->c_bsp_init)
>                         this_cpu->c_bsp_init(c);
>         } else {
> -               identify_cpu_without_cpuid(c);
>                 setup_clear_cpu_cap(X86_FEATURE_CPUID);
>         }
>
> --
> 2.16.4
>


-- 
Andy Lutomirski
AMA Capital Management, LLC
