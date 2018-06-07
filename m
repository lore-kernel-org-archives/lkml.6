Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 98soIDXgGFuSBgAAmS7hNA
	; Thu, 07 Jun 2018 07:36:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1FA246089E; Thu,  7 Jun 2018 07:36:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfpQE/Z0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7CB06607E7;
	Thu,  7 Jun 2018 07:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CB06607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbeFGHgC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:36:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40522 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbeFGHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:35:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so13076139lfc.7;
        Thu, 07 Jun 2018 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sGlBywfzfPHWozo7tv5PPQUyDSWm6NbWeIZiH22uauo=;
        b=DfpQE/Z0rozKKuJJtZHjNbDJDpDIukdglVKCwJp+Ap6J+r3BlU+wf3EN2Mu7IknTdT
         ktcGF7xymQbZ9Ycc2DHloiX/cWUgJUJyeLyFkOcY+hK9MSQFaiWEYR/gkLGK/gDC9piQ
         KDnDVE0V4OpZQOOtQuj+HTxKeJNs2lzeduz7+oZ9RNKG2+k3QkdM38fGIJIZM0zvucTZ
         xoBcTLkrJHDhipPqmsW+rOEUtUc0UnuYnidJIxF0lHLOASe7Wa0AtTWraAHRbYl0NgnT
         Lw8WggHqBv7OMVL4LoNq9QcUoUgU7xjQYwsJX1vTbcND/3IfXVpdIiqy4h2fGNT52YyW
         jtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGlBywfzfPHWozo7tv5PPQUyDSWm6NbWeIZiH22uauo=;
        b=qpNmndfJgWmRmbjkMeGh+aI/XJTw1Oh+9QrZ14qeXAuk6rHu1cE0rtX1cwGJvzAv8f
         eXtZHCV9xu2ub0q7BIGiF6X/rUYm2s5DGpOki1OiUy6OkA2LCJhmLkk7LSwYqR2dc39D
         ORav5+1I+hLT9vZXyNJS26Ym2qj8+7PRSJiHtJZZoH1K1l/OBtKFXPtdqUP8wdQ6RG5w
         3+0nL296wzKP6+mpchwQwtNZMv68RqrjqmvfgKBwANrefgPtIkvzbaFFxS4XwAoxS0B6
         FmaxBPNWFhEGfUKDLeH8Hc9jGKp7bNL4ASwe1L+lm+yC58b24CZ8VrJ1OS9HQdu5GTxh
         M4MQ==
X-Gm-Message-State: APt69E23ex0ok8+uYxOwlCLxKBINff85+02LnOPwCGIgThd38WFzrxIG
        O4vSJ5LGFyn0493mqa3qm1Q=
X-Google-Smtp-Source: ADUXVKLZHuMnQETCaBmL4SzmOj+mr8yIRerR4KeKjYHJBaSpNnrAf5WRewMqp+374LJ6DFLy8veJoQ==
X-Received: by 2002:a19:5943:: with SMTP id n64-v6mr527154lfb.107.1528356957629;
        Thu, 07 Jun 2018 00:35:57 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id a125-v6sm4288881lfb.61.2018.06.07.00.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 00:35:57 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fQpSR-0008LC-9E; Thu, 07 Jun 2018 09:35:43 +0200
Date: Thu, 7 Jun 2018 09:35:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Colin King <colin.king@canonical.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
Message-ID: <20180607073543.GP13775@localhost>
References: <20180606134338.4645-1-colin.king@canonical.com>
 <CAHp75Vd0Djw+nDN7u=-CLEfdDGA5QTsMueOb9EZLNnCDgso5fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd0Djw+nDN7u=-CLEfdDGA5QTsMueOb9EZLNnCDgso5fA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 07:02:03PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 6, 2018 at 4:43 PM, Colin King <colin.king@canonical.com> wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently saved_vals is being allocated and there is no check for
> > failed allocation (which is more likely than normal when using
> > GFP_ATOMIC).  Fix this by checking for a failed allocation and
> > propagating this error return down the the caller chain.
> >
> > Detected by CoverityScan, CID#1469841 ("Dereference null return value")
> >
> > Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> > index 9c3c00515aa0..0905ee002041 100644
> > --- a/drivers/pinctrl/pinctrl-single.c
> > +++ b/drivers/pinctrl/pinctrl-single.c
> > @@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
> >
> >         mux_bytes = pcs->width / BITS_PER_BYTE;
> >
> > -       if (!pcs->saved_vals)
> > +       if (!pcs->saved_vals) {
> >                 pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
> 
> > +               if (!pcs->saved_vals)
> > +                       return -ENOMEM;
> 
> Wouldn't make sense to move it out of the first condition?
> 
> Something like
> 
> if (!foo)
>  foo = ...malloc(...);
> if (!foo)
>  return ...

No, checking for NULL immediately after the allocation is more obvious
and easier to parse.

Johan
