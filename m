Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w3v2MdFcGVvqJgAAmS7hNA
	; Thu, 07 Jun 2018 16:26:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B0C4C608BA; Thu,  7 Jun 2018 16:26:57 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2b+T3tOg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 39643601B4;
	Thu,  7 Jun 2018 16:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39643601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbeFGQ0x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753833AbeFGQ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:26:50 -0400
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com [209.85.128.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E2F208A6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528388810;
        bh=bAee33NTLeWiZFNKKO+RMmSCpWT9lSA5FeSOsnTXCW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2b+T3tOg6jTQSIW7liwuPhan3ad3E+X2BGBQAE9y9EiBCelpRNxf0T8cXwWVIVdKy
         Ww26FmVm3BpGRXmhUUoUlNN1S6txFdi/LazEq3v0EP0Sfn3MY/YIj2HGvLI34y/3ut
         hjlFN5FEVNfB0N0o7TPggltRMkFAG83wwuYK7iLc=
Received: by mail-wr0-f175.google.com with SMTP id o12-v6so10469759wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:26:50 -0700 (PDT)
X-Gm-Message-State: APt69E0QAMDfwmGVNkd3p16ElW8Ikhjf1TbuAWjO5LalfsmTCNZkZROh
        i24pYQcMp3MxTUVYLy80+e6JjRJygM4PqAws8DA7Gw==
X-Google-Smtp-Source: ADUXVKKc8U/wh8Mi6sOOCTkKREJhIanAqh6HDaVwP4kiDC3xidfbGnRtmL8OlxsS7NeH0K910b4wXUOuMcfEbeJDhBw=
X-Received: by 2002:adf:b1ca:: with SMTP id r10-v6mr2153714wra.221.1528388808481;
 Thu, 07 Jun 2018 09:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143705.3531-1-yu-cheng.yu@intel.com> <20180607143705.3531-8-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143705.3531-8-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 09:26:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
Message-ID: <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
Subject: Re: [PATCH 7/9] x86/mm: Shadow stack page fault error checking
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
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

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> If a page fault is triggered by a shadow stack access (e.g.
> call/ret) or shadow stack management instructions (e.g.
> wrussq), then bit[6] of the page fault error code is set.
>
> In access_error(), we check if a shadow stack page fault
> is within a shadow stack memory area.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 73bd8c95ac71..2b3b9170109c 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1166,6 +1166,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>                                        (error_code & X86_PF_INSTR), foreign))
>                 return 1;
>
> +       /*
> +        * Verify X86_PF_SHSTK is within a shadow stack VMA.
> +        * It is always an error if there is a shadow stack
> +        * fault outside a shadow stack VMA.
> +        */
> +       if (error_code & X86_PF_SHSTK) {
> +               if (!(vma->vm_flags & VM_SHSTK))
> +                       return 1;
> +               return 0;
> +       }
> +

What, if anything, would go wrong without this change?  It seems like
it might be purely an optimization.  If so, can you mention that in
the comment?
