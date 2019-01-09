Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E621C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8FD2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVp4PWdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfAIPTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:19:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38142 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbfAIPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:19:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so5917621lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaOt2YPYx8I6ERYlSZZamEEQqXDJxdmbZ8uQFGMIFxQ=;
        b=dVp4PWdAmOKFQ72bTn3URRj7OYUebk3xb0V2jOiVz8tKtQ85ZcG9PDV6qMbz2CbsEG
         am1oGpO2yyd/BpX8E6nAiO/QPVUyMnT03A5W5izMIvMoFchGmn6GniUzyck7/fDIB2wn
         8z5bMZ+khSyTLi5PTKhI46EoTeyJ+aJt6W9aVwuhB/ZEW8rxVgCNZHjtl2dEBiP3XzR+
         bYWwDluhxOS4+moHB534TMtxlpAxxqNp9H4XFrqflMsQYp34ju9aBpphVVi8h54YMqO3
         UTLQzmxWLcTAocFFqVUqDfTPxI8vfaETVrc9/fbwNY50uDGgrD7g297IK5ap1sn8fAME
         JQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaOt2YPYx8I6ERYlSZZamEEQqXDJxdmbZ8uQFGMIFxQ=;
        b=eiIV19vUWf93Q4b7CMl4BZhjgIv5tMMLG/Bi+zq/Jq4JYyuAzhWgvkhl2fQWwYTZB1
         bW+Mbffxfa7hW4HDaSA8j8agwOFRRNjRtXA/VmThoTsSJfc2q9WZRs9dpI4piRPm0wJn
         c5HzCyPfwiQ4gs9hqwRXVWCCcM2WGoENQQNJcAnvKXpd3iKLySyauvCFLoJimikmIRtu
         mxOkaHC0vmNViSaVf1CYG6Vcbu7E6VWQUtP/+R3ip2T28lgoMi2QzOBQb5UMw9y/EswS
         kB1derET7YvDvb6nC8lvoieY3U4OQsJI2aJgk5/Qsiqoe+iuc59v/1koEIwpi5EdA75V
         DS5w==
X-Gm-Message-State: AJcUukfTpHSCnFe+UCyzcZndziQrqZ7d0wk7r4u6Eqq+ONgLeJ/aD3qh
        rgV1CHnajFq1doFCiZforVvsk/QaEX6tkm7SQJl5C1Ch
X-Google-Smtp-Source: ALg8bN5htIFbADW4Xir9NrBFpjSGGyKwTer506KZweTR6KoXMGn5Xac91l7xWpXVdUZuoGwCOwn/rTjOqhEzmMYH0Ys=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr3865390lfb.72.1547047180008;
 Wed, 09 Jan 2019 07:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20190109152209.GA13599@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190109152209.GA13599@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 9 Jan 2019 20:53:31 +0530
Message-ID: <CAFqt6zbRA9AKvTy0riSFoUGNyqTVi_7WUPAkpySS1Sj28r+R5Q@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/fault.c: Convert to use vm_fault_t
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 8:48 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_fault_t type for last argument of do_sigbus().
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

kbuild reported a warning during testing of final vm_fault_t patch integrated
in mm tree.

[auto build test WARNING on linus/master]
[also build test WARNING on v5.0-rc1 next-20190109]
[if your patch is applied to the wrong git tree, please drop us a note
to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Souptick-Joarder/mm-Create-the-new-vm_fault_t-type/20190109-154216

This patch has fixed the warning.

> ---
>  arch/x86/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 2ff25ad..dea3725 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1031,7 +1031,7 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>
>  static void
>  do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
> -         unsigned int fault)
> +         vm_fault_t fault)
>  {
>         struct task_struct *tsk = current;
>
> --
> 1.9.1
>
