Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8352175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPYMirz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfBGVGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:06:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41119 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfBGVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:06:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so1363623wrs.8;
        Thu, 07 Feb 2019 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIVQxxyENsqR7Mxp2YAE9mA1VKC1sGADqMLriCfABxo=;
        b=sPYMirz4oJo/Fo+kx22uYiGRY3Ft2aTuoq5wRRKGwW1Feg8A1WwrDOGAI2A/w8hHgw
         Z4XU/8YbJXGXlDVh/3GXKNue0vUGhjRdEtdj2n7VXxb64r7LFXq5JE/uQKrp9O8IoMt9
         n319u71sexnNPTcpHMydlKodXJ0fypSyPi0bwluaq+u73lNLhXSLTPFg/xJ6KatgjKLA
         bJoOWAA3wyynB0QKOrPpluPCJfTgBmG+qPnMw1DzOenstRmx2fGkZETqcFCcEeWCSBHr
         sVWVKlDk+9gR97jKdqNgY+xpGyDya8Xuspt8CcSbVN9kfby+LVOSrV2Juj+0kojcRT0/
         JguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIVQxxyENsqR7Mxp2YAE9mA1VKC1sGADqMLriCfABxo=;
        b=P2l6YiWkv9kAkwJQOUmb3QZmzjfjdw3pATe9mCa92/CPkjiH9DupMRq1MmtSJhoM65
         9IbDpnzIjf3C1vrWD3gWsU2/3r1tEfzWr+pLfW82kw89IM5XXgNLRXAlDY9sX3pXBxKL
         oxgHvrKcpw2Megunh++F46dqLBvPGKpbS6ZcFn6PztMDljD5KE+jhIflFj4EBjEGstK0
         p9zknvNbJ2zhCGfcZ5ksLhykXBmgaII9+l2urRQiiONlC5OCZTHpOId8Qpjecty+futD
         S4kBQsKv8Gw4uBHzoHWlm2+C3/xkuv8SQjG5jUkOm0YfDwj1vzS2SWUNeo70s5Lwgann
         JECQ==
X-Gm-Message-State: AHQUAubH3juCQR25vD1ki8t8hQphveNU/+ElAw9JfA54tp+xezCmQ9qj
        kLLkmcJm4YFjKLeQfw/PiPsEtYvn0jwCVrOJV4E=
X-Google-Smtp-Source: AHgI3IaL0nkXPJi7Ghbj1poom2PmCoWnLIXcfVKDYQk/tWJOns3nBPPShsEQEN0c4rlJomYegsqjvqSJH0ZxCE1g/Og=
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr13470602wrx.79.1549573607380;
 Thu, 07 Feb 2019 13:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20190207000349.7816-1-andrew.smirnov@gmail.com> <1ecb0604-3e27-810e-9fae-18d9d1bf7ff9@linux.intel.com>
In-Reply-To: <1ecb0604-3e27-810e-9fae-18d9d1bf7ff9@linux.intel.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 7 Feb 2019 13:06:36 -0800
Message-ID: <CAHQ1cqE-GeW_03edN4u_-RsZ9bm2_S07foY3obYreHp-Efpbdg@mail.gmail.com>
Subject: Re: [PATCH] xhci: Use ffs() to find page size in xhci_mem_init()
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 1:00 AM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 07.02.2019 02:03, Andrey Smirnov wrote:
> > Get page size order using ffs() instead of open coding it with a loop.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Mathias Nyman <mathias.nyman@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   drivers/usb/host/xhci-mem.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > index 36a3eb8849f1..44b43c3d819f 100644
> > --- a/drivers/usb/host/xhci-mem.c
> > +++ b/drivers/usb/host/xhci-mem.c
> > @@ -2362,11 +2362,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
> >       page_size = readl(&xhci->op_regs->page_size);
> >       xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> >                       "Supported page size register = 0x%x", page_size);
> > -     for (i = 0; i < 16; i++) {
> > -             if ((0x1 & page_size) != 0)
> > -                     break;
> > -             page_size = page_size >> 1;
> > -     }
> > +     i = ffs(page_size);
> >       if (i < 16)
> >               xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> >                       "Supported page size of %iK", (1 << (i+12)) / 1024);
>
> Hi
>
> using ffs() is a welcome change, but it will give different a result than the loop.
>
> *old loop
>    valid page_size value if i < 16
> *ffs()
>    valid page_size value if i >= 1 and i < 17
>

My bad, sorry about that, was using __fls() in the version I tested,
but then switched it to ffs() at the last minute and forgot to double
check. Will update in v2.

Thanks,
Andrey Smirnov
