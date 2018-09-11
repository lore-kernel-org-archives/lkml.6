Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7783A20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq1WjBy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7783A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeILEuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:50:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeILEuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:50:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so45234wro.11;
        Tue, 11 Sep 2018 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UgOnB6Tr/gNkyIuF0E0+LG/GZOxPkYPUj0FErEjsrPI=;
        b=sq1WjBy7xwHDrD8cPUL4WBIUUFuSDg8/NvZ121I8UEMfKUH61m4Dy+lekzwYZsFWnU
         ahRiUCqfwmu4qeSDKioRh1tU8239L4h4xzcbbmuVdlhYwM0cweiCEFIIyvCWGmbCeGZS
         6LgZYQMI2NQV+sOwhVmzGJ8OD93QOm+8UfyJAhWGZnqbfJpqOTlqSpEKAczllWUCLo6G
         XFn/N+YOffs7WsZ7Z84oPPrJVDhoeIM/fxEuCWS82sFDVyQ+ZyQtWJ6DNeKPB22AG12k
         5vSQxkWFc2A7YkX7KWdeinFfmUh9NUFG/HAWqBA5ZJTPJ30xt3EKevyjmebTzo1ctO1V
         822g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UgOnB6Tr/gNkyIuF0E0+LG/GZOxPkYPUj0FErEjsrPI=;
        b=C/0ZFsTc0P/o5+bW2tfC3Ak2e0ceLm21tNeieQjqVMtw705xnL6Q0p9M1v0XUenswE
         q/nf42syyghijGCE1gkQ88QFyRw9qzywTEymygHZ0HAbkg489norxGEH/OPRPtszrLTm
         3KcsLXzF2qQJSSCZ09i9saQRlRZdRmJuUejhCBNxtXisXRBzqqYW6LJjc6dE6sa3N1ar
         WVxdE9JtYTEgDsfpp6+K1UNfOHg7I2xJ6iDEzd3z2aKZMWL1L/boKfyOLZUE6C4VSfq+
         8TGeqRY20e436ckE4rOTOD23VCk1nC5jWHD1ofu6IQWpMooysbFfpSO+OoXo14kE77lN
         kdLA==
X-Gm-Message-State: APzg51BYxSUO4JvI/lFZ0+DXr8BAdp3qEi3AnJKEQUpA600O1GuYb0PW
        wKGOYIFgvDCLI/QtP7Qf0us=
X-Google-Smtp-Source: ANB0VdbwiUxbLq42l22Sc+na/GDFpi5mKhqRcDVMS2URYVd0vRXz0tsR7tJ+vbAo0TeOxlDHGs9T7g==
X-Received: by 2002:a5d:494c:: with SMTP id r12-v6mr20244752wrs.244.1536709702443;
        Tue, 11 Sep 2018 16:48:22 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x15-v6sm17852698wrt.53.2018.09.11.16.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 16:48:21 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:48:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix __aligned attribute on
 zynqmp_dma_desc_ll
Message-ID: <20180911234820.GA12913@flashbox>
References: <20180911230533.31873-1-natechancellor@gmail.com>
 <CAKwvOd=KaX4+3J4WGOcWBAfhHEyytXKKCLHFdCuDAr5McQ-g=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=KaX4+3J4WGOcWBAfhHEyytXKKCLHFdCuDAr5McQ-g=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:37:48PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 11, 2018 at 4:06 PM Nathan Chancellor
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
> > Place __aligned before the semicolon.
> >
> > Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> > index c74a88b65039..dc19d67cb8c1 100644
> > --- a/drivers/dma/xilinx/zynqmp_dma.c
> > +++ b/drivers/dma/xilinx/zynqmp_dma.c
> > @@ -163,7 +163,7 @@ struct zynqmp_dma_desc_ll {
> >         u32 ctrl;
> >         u64 nxtdscraddr;
> >         u64 rsvd;
> > -}; __aligned(64)
> > +} __aligned(64);
> 
> Thanks for this patch Nathan.  Thinking more about this...the integer
> passed to __attribute__((aligned(x))) should be in terms of bytes.  64
> bytes seems kind of high.  Maybe they meant 64 *bits* thus 8 *bytes*
> which already the default alignment of the struct:
> https://godbolt.org/z/7vW6E3
> 
> In which case, the correct fix is to remove the `__aligned(64);`
> outright.  Since that doesn't change anything (thanks to clang's
> helpful -Wignored-attributes), such a patch would be "No Functional
> Change" (does not change the status quo).  Still, it might be good for
> the maintainer to remark if 64 *byte* alignment was intentional (I
> would think not, but I don't have the datasheet for this piece of
> hardware in front of me; never say never) before sending such a patch.
> 
> If the 64 *byte* (512 bit) alignment was intentional (again, which I
> doubt), then this patch is good to go, but that would then be a
> functional change and should be tested by someone with hardware.
> 

Thanks for the review Nick. If that is indeed the case, I will spin up a v2.

> 
> >
> >  /**
> >   * struct zynqmp_dma_desc_sw - Per Transaction structure
> > --
> > 2.18.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
