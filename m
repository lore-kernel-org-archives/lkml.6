Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12861C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAF62084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHEK1ASy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAF62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeJZCwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:52:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44590 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZCwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:52:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2-v6so1390689pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYsOYyEX5uOTdLRGv/faJtdkJEbETOC/BJ5l0oY7d30=;
        b=iHEK1ASy4NvIgKdLrRHiPrlOj9rt8ZMYD4syDyi/tmOl3Pe+UVA8V549+euxcc+P2c
         6KotTRP/S0KrkwN/Uy3wpDN70dgSCwvgduIX14tJSjDFyQ1qXwo5di9JaEB16qWzCOoV
         GheSbOsr91mvySqayoxrsy/l+2M6qFAHsyoe16NPj6vMW1aBtFa1MEwV3DzM+L8R9Lhn
         3Hg47ieFHT4k/jreq+RZWaZQO2QR7Ng1OYmwZYfa6X8CoHpH7TgTAeDpJ4fYRKP4qH8X
         gVAqqi2S6wW7uGEYJMTA6pxtMIQqCK1DL2Jw9RA2poH5BM66o0BEO2X4r8Y9Q9busvG5
         uYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYsOYyEX5uOTdLRGv/faJtdkJEbETOC/BJ5l0oY7d30=;
        b=KjvZgWDsyfVn2/TeLugT/p1mQYcu8L8oPLbsgZMMhizUvEekowIOrtEKYRdwKVA0bV
         whoGjd64PNPeh/W1JUNlqh/X8JAG49Cy9h4+ieFW9esl02sYBHOv1tAdglg9Suxh0BVl
         g2pz1CRS1JKpTG4Lnne4jKXD/ea3AFa0cxVy65k88zWXBTEevSxejGT5TIl0g2v9KUmt
         HEJBozVEB1eRgwi8gfNrzmi6EwIgkRDtfmi+/C6XMMbyZxIzi4S4cRC4FOFqyhOjlkW/
         i4YJWEV971aS1irZDTeaUQiV3Xdi6PZN/0MqeKHAFn7p0uBZ2VY6bk64hUP+eGNOs87V
         wDyg==
X-Gm-Message-State: AGRZ1gIr2drQj06uIk4SOcQ1PgwCYcCXWBHVXqJ7303jWL7ksxS28MEP
        tdSexEl/MMPjytxrhbnRLJix/vWgSELF15HOWM7Hbg==
X-Google-Smtp-Source: AJdET5dFIisGePbk/dtz/0ZBLB+tyw19oIS3D1/JRC+SRoCt92QrPytv9reOiycig9M4j/JVG+uPHrKEecHw5tOU5vA=
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr252732pfq.227.1540491496484;
 Thu, 25 Oct 2018 11:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181025180525.28378-1-natechancellor@gmail.com>
 <CAKwvOdn6juo_gfbEBmL2hanOuwbth2gE6bv9_O3AjWsM-WmsWA@mail.gmail.com> <20181025181418.GA28946@flashbox>
In-Reply-To: <20181025181418.GA28946@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Oct 2018 11:18:05 -0700
Message-ID: <CAKwvOdnpqUYkuGT_WpbNox6L5OokBw3B-mOjrnxeqhLdBG1Qng@mail.gmail.com>
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

On Thu, Oct 25, 2018 at 11:14 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Oct 25, 2018 at 11:11:22AM -0700, Nick Desaulniers wrote:
> > On Thu, Oct 25, 2018 at 11:06 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns:
> > >
> > > drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
> > > ignored, place it after "struct" to apply attribute to type declaration
> > > [-Wignored-attributes]
> > > }; __aligned(64)
> > >    ^
> > > ./include/linux/compiler_types.h:200:38: note: expanded from macro
> > > '__aligned'
> > > #define __aligned(x)            __attribute__((aligned(x)))
> > >                                                ^
> > > 1 warning generated.
> > >
> > > As Nick pointed out in the previous version of this patch, the author
> > > likely intended for this struct to be 8-byte (64-bit) aligned, not
> > > 64-byte, which is the default. Remove the hanging __aligned attribute.
> >
> > Here was the v1 discussion, for reference.
> > https://lkml.org/lkml/2018/9/12/4
> >
> > Thanks for sending the update Nathan.  One thing I recommend doing is
> > including the version in the [PATCH] subject line, ie. [PATCH v2].
> > `git format-patch` can do this automatically for you, ex.
> > $ git format-patch -v2 HEAD~
> >
> > >
> > > Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> >
> > Then below this line, you can include the notes about v1 -> v2
> > changes. (interdiff notes to the reviewers that get discarded from the
> > commit message).  I think I've seen you use the versioning before, so
> > sorry if I'm restating something you already know.
> >
>
> No, that's fine, I completely forgot all the versioning for this patch
> as I was rushing, sorry about that!

No worries.  There's a lot to juggle when sending a patch and I miss
these all the time (did I run checkpatch, did I cc the folks added to
v1 that get_maintainer did not suggest, did I ...) and the version
info of the patch gets discarded anyways once committed.

>
> > Thanks for the patch.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
>
> Thanks for the review!
> Nathan
>
> > >  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> > > index c74a88b65039..73de6a6179fc 100644
> > > --- a/drivers/dma/xilinx/zynqmp_dma.c
> > > +++ b/drivers/dma/xilinx/zynqmp_dma.c
> > > @@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
> > >         u32 ctrl;
> > >         u64 nxtdscraddr;
> > >         u64 rsvd;
> > > -}; __aligned(64)
> > > +};
> > >
> > >  /**
> > >   * struct zynqmp_dma_desc_sw - Per Transaction structure
> > > --
> > > 2.19.1
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
