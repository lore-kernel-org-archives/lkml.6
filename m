Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76307ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EDA20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv90TAN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EDA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJZCsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:48:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34694 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJZCsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:48:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so10315322wrt.1;
        Thu, 25 Oct 2018 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zek3ExevJkyED5ZqBW92iwlwpZx1bnCaOUOmCfJ19SE=;
        b=Fv90TAN0PnfvbwtOSbKPN3Moh4mXU/OSf+kL9X1b2mRxTgPZHp+OnZZQ7rD64NFpsT
         DMTCehDi9GBsgCbxx4DAB2ALOVOcV8Qnro/39i9Dy1r4jINkZfzTmrjk/bfLm8P5JLaL
         btgQXw58I8GOEowtCTxae+zlFuiOJutFYuzsBM+UM9mrFK4csF+9wGTwMG5FxzyRwMPE
         a6VJOcgpQEfoQb5oLDlMrl+SN6vrf/Sia0fmnmaV3pqfNOW1JAo8Q9hBbU3aVrTMhe1G
         6OIp6uSO1m0ye7EkPkrlyFLxXzlACoy6o3fBqwVLifRa3XkxBAqut7X4mFqK5qeqP99B
         Uhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zek3ExevJkyED5ZqBW92iwlwpZx1bnCaOUOmCfJ19SE=;
        b=Bw7FJv42U3C8mcet+9zqlJqdiw8wib7cA/FmtLkjk3HSqSI8eszDLd53SStrRMCkIv
         xmBiwDYX/oeN1JW9TTlaCQIE9ioSJt2Oi/waLPq3Eb1TNVVGVkdsVqP+3+dPkGO6rtIv
         hRBeRD8KK5n+TNkSrtf7EOMt6RbZw+JTXO387nk4d96WGkOG4i5jaUqtc7LT/O+ts0ez
         cnL0kGwxBY3h6S1mBHstdsyn+ek/SsDpu4q/4Ki+pGXWcOSdMTxwdyAwSZOas8Q71kNQ
         i2J95sqmzcHUJHS7/JWUT3bp7gFHzh8PWqym7uxaFHZNYsjIZONzx2rXJD1mn6O+Fchh
         r3wQ==
X-Gm-Message-State: AGRZ1gLcBLksLPDVCXSsd2CsXhVhnreyVFMy3+Ul1XryL8fF4jWmD4nC
        CNKEPlLIYg4SXzzPKxdZ9oM=
X-Google-Smtp-Source: AJdET5dgX+B7rD244EpqmOWjAIX5gDdZ5HvkpbWfyJrEMUUph7/ALBIGxkCgp2TQMZQIvfQ7KIB/DQ==
X-Received: by 2002:a05:6000:1cb:: with SMTP id t11mr254159wrx.146.1540491261044;
        Thu, 25 Oct 2018 11:14:21 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y138-v6sm1065858wmd.2.2018.10.25.11.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:14:20 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:14:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Remove __aligned attribute on
 zynqmp_dma_desc_ll
Message-ID: <20181025181418.GA28946@flashbox>
References: <20181025180525.28378-1-natechancellor@gmail.com>
 <CAKwvOdn6juo_gfbEBmL2hanOuwbth2gE6bv9_O3AjWsM-WmsWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn6juo_gfbEBmL2hanOuwbth2gE6bv9_O3AjWsM-WmsWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:11:22AM -0700, Nick Desaulniers wrote:
> On Thu, Oct 25, 2018 at 11:06 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
> > ignored, place it after "struct" to apply attribute to type declaration
> > [-Wignored-attributes]
> > }; __aligned(64)
> >    ^
> > ./include/linux/compiler_types.h:200:38: note: expanded from macro
> > '__aligned'
> > #define __aligned(x)            __attribute__((aligned(x)))
> >                                                ^
> > 1 warning generated.
> >
> > As Nick pointed out in the previous version of this patch, the author
> > likely intended for this struct to be 8-byte (64-bit) aligned, not
> > 64-byte, which is the default. Remove the hanging __aligned attribute.
> 
> Here was the v1 discussion, for reference.
> https://lkml.org/lkml/2018/9/12/4
> 
> Thanks for sending the update Nathan.  One thing I recommend doing is
> including the version in the [PATCH] subject line, ie. [PATCH v2].
> `git format-patch` can do this automatically for you, ex.
> $ git format-patch -v2 HEAD~
> 
> >
> > Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Then below this line, you can include the notes about v1 -> v2
> changes. (interdiff notes to the reviewers that get discarded from the
> commit message).  I think I've seen you use the versioning before, so
> sorry if I'm restating something you already know.
> 

No, that's fine, I completely forgot all the versioning for this patch
as I was rushing, sorry about that!

> Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 

Thanks for the review!
Nathan

> >  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> > index c74a88b65039..73de6a6179fc 100644
> > --- a/drivers/dma/xilinx/zynqmp_dma.c
> > +++ b/drivers/dma/xilinx/zynqmp_dma.c
> > @@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
> >         u32 ctrl;
> >         u64 nxtdscraddr;
> >         u64 rsvd;
> > -}; __aligned(64)
> > +};
> >
> >  /**
> >   * struct zynqmp_dma_desc_sw - Per Transaction structure
> > --
> > 2.19.1
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
