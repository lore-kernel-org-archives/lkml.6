Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC706C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C902084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQ2rKPgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C902084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeJZCpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:45:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34881 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJZCpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:45:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so4388144pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yeql7053PeGDPp/S9NBLqc+W0O7oJUn8cU6/edngqdM=;
        b=UQ2rKPgqTMkv/hcQBN7MrFfD3IGHa0a2bMgNFdojQ8uzSQVabnOATwlNfddGEzmRAy
         S/TDDoFMMwLWiRIn/ZAYmgPsOmCRJ8uZ0o29EJk0GAuIka/332BfbM7FdXCXAAiLyEse
         1Ba66S+dfMJvemHkxRjhh/IllBL/QAJMjWFiF2TnZ9qmgyCZbJ3PHBfEkpdMQPXYmwER
         Octmu/d8SDos+oYe6M6QfeRFXwvvq83clqeGzWfNWNnnvN0cWMZgPNPOWItKtooVQECj
         znDIMW+S5MlWMOiFwEvfIpQ/0FeX26hZzGdUzX+XmSjC04y+Gv2mjvsdfuRfs7b9/YL6
         HMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yeql7053PeGDPp/S9NBLqc+W0O7oJUn8cU6/edngqdM=;
        b=W+QUsP/N59UbCVMvIP0z7IlEi9cvcb4+fQV9KY7oZPIw2OYKC+umpo4o7TA+uJQ/sG
         rkbSFwNTN+uUA28y18zHp0+wxqel+31Dz7QSa2w8QLeBtC4alJ+bdjJJPRuCzvxCdjLT
         ud+Gvv8MDCKiPrWG6gKzy2B3RxwNR9uFTc+CVucCH48P4epJR9M+r2cWr+DiOBgQBu1q
         ElRv3IylELeIXxZ90++zk8F0v7mhp9FgDl5nYklH72sK96fMDdkSWkcJWVSXiRoNh3TN
         yZIZke8DOhLpP6idR5c0FhmKBP+GyQ/jc1RyCdjuaO1hNZ0H2cYx+qkuthobe0kr/ubJ
         9vyg==
X-Gm-Message-State: AGRZ1gKWlz3BfVCsjpNwvlbWkNjvXZHiXc4/S24Sd9Z/bnABLOWSlk/I
        hCnfZhbTBqSsk5uIRV/NHvJwtbOWf11kIVTojBhkAQ==
X-Google-Smtp-Source: AJdET5cCFW2ipsDTrPVs6UO9yYwVFF1kuiEhprZ/uAeu4em5ZBK2xb4Ch7uKPMsPXCEp+ZRh3pNd5YEdGHkWRVnR0AQ=
X-Received: by 2002:aa7:88c2:: with SMTP id p2-v6mr286533pfo.32.1540491094439;
 Thu, 25 Oct 2018 11:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181025180525.28378-1-natechancellor@gmail.com>
In-Reply-To: <20181025180525.28378-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Oct 2018 11:11:22 -0700
Message-ID: <CAKwvOdn6juo_gfbEBmL2hanOuwbth2gE6bv9_O3AjWsM-WmsWA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_ll
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:06 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
> ignored, place it after "struct" to apply attribute to type declaration
> [-Wignored-attributes]
> }; __aligned(64)
>    ^
> ./include/linux/compiler_types.h:200:38: note: expanded from macro
> '__aligned'
> #define __aligned(x)            __attribute__((aligned(x)))
>                                                ^
> 1 warning generated.
>
> As Nick pointed out in the previous version of this patch, the author
> likely intended for this struct to be 8-byte (64-bit) aligned, not
> 64-byte, which is the default. Remove the hanging __aligned attribute.

Here was the v1 discussion, for reference.
https://lkml.org/lkml/2018/9/12/4

Thanks for sending the update Nathan.  One thing I recommend doing is
including the version in the [PATCH] subject line, ie. [PATCH v2].
`git format-patch` can do this automatically for you, ex.
$ git format-patch -v2 HEAD~

>
> Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Then below this line, you can include the notes about v1 -> v2
changes. (interdiff notes to the reviewers that get discarded from the
commit message).  I think I've seen you use the versioning before, so
sorry if I'm restating something you already know.

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index c74a88b65039..73de6a6179fc 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
>         u32 ctrl;
>         u64 nxtdscraddr;
>         u64 rsvd;
> -}; __aligned(64)
> +};
>
>  /**
>   * struct zynqmp_dma_desc_sw - Per Transaction structure
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
