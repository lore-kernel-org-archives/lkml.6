Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA92C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D147A20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Bqd/XiwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfAIAqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:46:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45060 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAIAqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:46:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so5222654ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtTT53Z4RiPetJJelUtKNLzl3kIY5mvjgwGyfEY6q5g=;
        b=Bqd/XiwS8IopsT72fnCioVA0Rp3sH0NgGHI/dN3V9z1ndmqCf1/O1XBz2RgqO5qfRE
         ubIdjusVLpk/GPngxp/C7U2zWGovfEVb45Z3Vzg5AUrW1nKL1sheyTFzamADI9VQaMw8
         gqlGRVINM0fuw9N6PeOZ6Mnp3CbQjA77xsyNGklpehXSYxS625aRGHXxnqUSxfv3xCaO
         fyZc3BRGydKPjPJ0ZwQL0fDhkl4Ty9ej6WV9m0zevBRHjn8h1K43Em2CMMmJtdZ9EOB/
         OTdBgVBKXWinmtGPdv4g4mCBo3oVRXgY2ovWaCkY9Cc5Z67mw9GbYjkMIsCWOqaqUj7d
         yZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtTT53Z4RiPetJJelUtKNLzl3kIY5mvjgwGyfEY6q5g=;
        b=IVWBHurGAN2QqbkNulqTYO8i9F39GnvCa1fUr3QIeZozJ8mPVgR9FnzAfcIAPqkXtp
         mGHohpcxHItpSUPRGSw89Is+m7SJqaiD8fkBSYf+scu5/9eXNgixYEES4650hiHqa6jn
         2AltTWSNqz8TlWWOASJP0GdPmreizEIm4vvzGxKZB/XXo2BvPu3LYFwK0aO/+Ytyo6vs
         G/O1JckTokxWIQZGX98Cb6ITe7+cP7jpW02Clx6RccS33/MYUP8ogJcrs6VY/LmIWb8R
         pZnMp3JqgVS9Ry0N8HURuie18ywerD3Vjfq6hXpU7Ntd5VCpa+y3bTvGURJrdtE8sygM
         AQ5Q==
X-Gm-Message-State: AJcUukcOjH6cyfNYd9fwPsBYLlrhX/+Gm/mfA925Iwco8Wi5qi5HWMF9
        E5o7yl9TNcZ2so6v9ZKhTeJR3B4vRmSoNdr4mo+Orw==
X-Google-Smtp-Source: ALg8bN5Ei5hNaopJXX/7AqEuZ0y5PnxuZd3NqxqbL4GH4nhYNQOaw7zxrTFhrTXqvd3q3/vSnLd/sRVUGe6Jys9HNzI=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr2645637oti.367.1546994789198;
 Tue, 08 Jan 2019 16:46:29 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
 <CAPcyv4iZZEM3D8vta_sge7a4iMgPZ5a1AnunXa4DKUaWauZk1g@mail.gmail.com>
 <CAGXu5j+z_yRPgE0HO=Sjo_VwwDDPJ+VLxbxwKgbb2cUAB5jmwg@mail.gmail.com>
 <CAPcyv4jhFGMzBrWHS_9q0Fe2MersRXz31VG3H2dJfujx1CJGhQ@mail.gmail.com>
 <CAGXu5jKrhvUduv_XUYF94YM=bBfPGNkPrZ_EkvRKB0pDY_6uOw@mail.gmail.com> <CAPcyv4jQ1Og_mEVjb77xdM263MugzK7_yrR_zi498JFrOrhSrg@mail.gmail.com>
In-Reply-To: <CAPcyv4jQ1Og_mEVjb77xdM263MugzK7_yrR_zi498JFrOrhSrg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jan 2019 16:46:17 -0800
Message-ID: <CAPcyv4if2YwyYSn9XLKHQXX2oe+nX2idvNx79M2s1j4FMftkBg@mail.gmail.com>
Subject: Re: nvdimm crash at boot
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 4:02 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Jan 8, 2019 at 3:55 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jan 8, 2019 at 3:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Tue, Jan 8, 2019 at 3:34 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Tue, Jan 8, 2019 at 3:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > Ah, thanks for the report! The key difference is that you don't define
> > > > > a "label area", so the driver bails out early and never initializes
> > > > > the security state.
> > > > >
> > > > > This should fix it up.
> > > > >
> > > > > diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> > > > > index 4890310df874..636cdb06ee17 100644
> > > > > --- a/drivers/nvdimm/dimm_devs.c
> > > > > +++ b/drivers/nvdimm/dimm_devs.c
> > > > > @@ -514,7 +514,7 @@ static umode_t nvdimm_visible(struct kobject
> > > > > *kobj, struct attribute *a, int n)
> > > > >
> > > > >         if (a != &dev_attr_security.attr)
> > > > >                 return a->mode;
> > > > > -       if (nvdimm->sec.state < 0)
> > > > > +       if (!nvdimm->sec.ops || nvdimm->sec.state < 0)
> > > > >                 return 0;
> > > > >         /* Are there any state mutation ops? */
> > > > >         if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
> > > >
> > > > Okay, cool. I wasn't sure if that test needed a deeper check. :)
> > > >
> > > > Fixes: 37833fb7989a9 ("acpi/nfit, libnvdimm: Add freeze security
> > > > support to Intel nvdimm")
> > > > Tested-by: Kees Cook <keescook@chromium.org>
> > > >
> > >
> > > Actually, looking closer this should have been avoided by the fact
> > > that __nvdimm_create() initializes the security state early and that
> > > nvdimm->sec.state should have saved us.
> > >
> > > I'll dig a bit deeper with your qemu config.
> >
> > Maybe something goes weird with pstore stealing the region?
>
> No, pstore is off the hook. I was just able to reproduce locally and
> I'm not doing anything with pstore.

Huh, this fixes it:

diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 5440f11b0907..7315977b64da 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -160,6 +160,7 @@ static inline struct nd_blk_region_desc *to_blk_region_desc(
 }

 enum nvdimm_security_state {
+       NVDIMM_SECURITY_ERROR = -1,
        NVDIMM_SECURITY_DISABLED,
        NVDIMM_SECURITY_UNLOCKED,
        NVDIMM_SECURITY_LOCKED,

Apparently I was wrong to think an enum was a signed int without
actually making a signed value a possibility. I would have a expected
the compiler to give me a "statement has no effect" for testing for a
negative value against an effectively unsigned quantity.
