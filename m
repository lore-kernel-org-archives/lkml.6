Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30F1C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E0720671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Txwzqio5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E0720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbeGSSD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:03:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54283 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731442AbeGSSD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:03:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so6991831wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bi7qXTqIqqOkMu9MhQdvDqN1g+dFA1suX1IF7EWLlCM=;
        b=Txwzqio5JQAEMgkp3ymWi+zXijyogF19bJllgIUBjr7vCp1GR/WSISIVKqrPH9AfMo
         j05wJp/j8/O0RUvI7dsanUXSjXoErR1QoFcJG8iaz8C1TjMVI9RHGysz6pZFpTSFxnJE
         mcyJnxnjSoVoHYoommSjYVGvnIqaQ74+A+HW20HrD0khhP9wEBhVx1kV139NxqbCZ2pe
         zFw4ZbWk29vlWf5b/oROfmy8OePA+h8AXRrCfVz0qs1EuSKfOCi/Jd48w8gGezwEyVF5
         rESS3l2bQMy+duKA6/I1KP6KU++A+hQ1IMsOPyj6LG7iBHYt7Duef6X9OUc1tnizAAg1
         8RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bi7qXTqIqqOkMu9MhQdvDqN1g+dFA1suX1IF7EWLlCM=;
        b=br9uqPhM69OjOUEXdG+N3Pxa5eztadyewXuebTGsBqfPAW/Pi/+kmM+inDK90IGS10
         E7btNyIJUsvsQEfotPyAmA9qpvf2j8k5p7aDp42V9PuBKqDMaMUhAzAROntz42/9E0JL
         cQx14sL2WZQFUPogYPCDOSMNEeFt9KmxcqRFcrIyV+T0w2V+Rh33UHDoXWQnWp/3iT55
         yWQs5CbuZudIevbwpCA2k6eHhBrNlbhGkyU/YmifQoHZPf5P1jKFYuCvJ+G+IZhZJjNR
         N4hBzF8rDaNVqfA1pKTCjGXHeMcuZKhQ/tijVL96vn/TEkTskppUI7cOwD9JNCJw+ws0
         H3Fw==
X-Gm-Message-State: AOUpUlEn/Cvg0q27h6NWq4QsXV0dPh/KiPQDkjT0D1M3zDhFh4SxFm+S
        39FdtcmlAyJ/+8INkczC6q+qUFvJ+sQzMzONUhFB7Q==
X-Google-Smtp-Source: AAOMgpd8aiQzbAGgvXx22JGBfSj1CxsAjNU71eyVleFMv+2nxUlyaOK832mvwdUzAvPVmqCrMWK491Gt4FWNxAaBwh8=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr4460000wmd.46.1532020759529;
 Thu, 19 Jul 2018 10:19:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 10:18:58
 -0700 (PDT)
In-Reply-To: <CF849A07-B7CE-4DE9-8246-53AC5A53A705@surriel.com>
References: <20180716190337.26133-1-riel@surriel.com> <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com> <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
 <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com> <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
 <CF849A07-B7CE-4DE9-8246-53AC5A53A705@surriel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 19 Jul 2018 10:18:58 -0700
Message-ID: <CALCETrXhkcMyMo_-dmrQ3M+VJqLS_me5TKA688bdsQo5m1ddzg@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
To:     Rik van Riel <riel@surriel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:15 AM, Rik van Riel <riel@surriel.com> wrote:
>
>
> Given that CPUs in lazy TLB mode stay part of the mm_cpumask,
> that WARN_ON seems misplaced. You are right though, that the
> mm_cpumask alone should provide enough information for us to
> avoid a need for both tsk->active_mm and the refcounting.
>

If you do this extra shootdown after freeing pagetables, it would be
odd if mm_cpumask() wasn't empty.  But you're right, the warn is
probably silly.  And if you move it into arch_exit_mmap(), the warn is
definitely wrong.

>
> Does all that make sense?  Basically, as I understand it, the
> expensive atomic ops you're seeing are all pointless because they're
> enabling an optimization that hasn't actually worked for a long time,
> if ever.
>
>
> Our benchmark results suggest that lazy TLB mode works, and makes
> a measurable performance difference. Getting rid of the atomic ops
> should make it a little better, though :)
>

I'm not saying lazy mode is useless.  I'm saying that active_mm isn't
needed for x86's lazy mode :)
