Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id R7daA8N5GVu5NgAAmS7hNA
	; Thu, 07 Jun 2018 18:30:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7D7E46089E; Thu,  7 Jun 2018 18:30:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="lR3V+z4j"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 01892606DD;
	Thu,  7 Jun 2018 18:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01892606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934816AbeFGSav (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:30:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41296 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934029AbeFGSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:30:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so10821442wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xnph+iwODaBv+j1M/71rmM3V/nDkco59DU49LbjrrVw=;
        b=lR3V+z4jD2BoN4BVdmWEVL7YujvxSHMLyMZ2l48yNJLiP7U0M3N5NeFjUyUYFpsiRL
         z+qdxNgyHzBK8xgG5eUySvyrxCN71rai6QoeYGDumkxXWxT/jMooO3xsBYaUoKgstt0m
         FG5qts4XFXCy+ots+BiJkOmeTTYhCTDvm/aZSn1SA6n8xpbfKW2za/nfAmxMHDkN4RK1
         y+PT6JpEXWeZ1FWqwdAcic2oSJnPo1BynC131R6Ics0QINzC3sI1wc9I28QscsiWDCQa
         kvhP0/+2Ne+jSp296dD8jDZsbY56yA4oUZ05uF1DQloZjs2i7qWGdd9hOzf48Aom8YgY
         n87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xnph+iwODaBv+j1M/71rmM3V/nDkco59DU49LbjrrVw=;
        b=tp8+7gPgTRl9CjS9uAz3NCS+tFsbm36LtmlDv0nhTyZuCtDWjsIsaFQORA0Xibc1D4
         3ITcBzSHJPL+goFcMLSxb9COhz/Hudhoo4sMm/zhPQXd3HFviFVkws7lrHtauiXpgb81
         /B6adBl7T3oW7f/tLmBpg8NSR2aRDq2vzf6qFOUfG/xWXI+BgTDi0M9QC26lBcyW+g9d
         eGrZV0bM0IwKhCL3KaduNBkloSZJ0o+DL//4fhx2XRfqivrAM4a4fYagjKrLSq4vORun
         aXYBC3Z5TFRlZ1LmrJmmnjh3WGwku1121DmRbW1PzBeg9AZW3mIQaCnSwPR2poA8lTqc
         VNvw==
X-Gm-Message-State: APt69E3Pb18XNs7bKFBqXbqe6AHR8mtbZSM8IagizyKDGLjrkmUhPLXF
        E02r3MWYGesAyJoiMEUiKrWrCybBw01sI6vOQPC8UQ==
X-Google-Smtp-Source: ADUXVKJCbxbVdrF53pAKvr0fvMZ7XV3JHcXGcM1d3Ug96hWMeyfdLGe0NdbtqoEgMFiTXlNbHbvd14A7OtklKm7FASM=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr2511770wrd.67.1528396245554;
 Thu, 07 Jun 2018 11:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-4-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-4-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 7 Jun 2018 11:30:34 -0700
Message-ID: <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] x86/cet: Signal handling for shadow stack
To: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Set and restore shadow stack pointer for signals.

How does this interact with siglongjmp()?

This patch makes me extremely nervous due to the possibility of ABI
issues and CRIU breakage.

> diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
> index 844d60eb1882..6c8997a0156a 100644
> --- a/arch/x86/include/uapi/asm/sigcontext.h
> +++ b/arch/x86/include/uapi/asm/sigcontext.h
> @@ -230,6 +230,7 @@ struct sigcontext_32 {
>         __u32                           fpstate; /* Zero when no FPU/extended context */
>         __u32                           oldmask;
>         __u32                           cr2;
> +       __u32                           ssp;
>  };
>
>  /*
> @@ -262,6 +263,7 @@ struct sigcontext_64 {
>         __u64                           trapno;
>         __u64                           oldmask;
>         __u64                           cr2;
> +       __u64                           ssp;
>
>         /*
>          * fpstate is really (struct _fpstate *) or (struct _xstate *)
> @@ -320,6 +322,7 @@ struct sigcontext {
>         struct _fpstate __user          *fpstate;
>         __u32                           oldmask;
>         __u32                           cr2;
> +       __u32                           ssp;

Is it actually okay to modify these structures like this?  They're
part of the user ABI, and I don't know whether any user code relies on
the size being constant.

> +int cet_push_shstk(int ia32, unsigned long ssp, unsigned long val)
> +{
> +       if (val >= TASK_SIZE)
> +               return -EINVAL;

TASK_SIZE_MAX.  But I'm a bit unsure why you need this check at all.

> +int cet_restore_signal(unsigned long ssp)
> +{
> +       if (!current->thread.cet.shstk_enabled)
> +               return 0;
> +       return cet_set_shstk_ptr(ssp);
> +}

This will blow up if the shadow stack enabled state changes in a
signal handler.  Maybe we don't care.
