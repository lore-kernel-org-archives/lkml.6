Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nc7aEhwqGVvwEwAAmS7hNA
	; Thu, 07 Jun 2018 12:50:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D0370608B8; Thu,  7 Jun 2018 12:50:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQnYl+EJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1C00860115;
	Thu,  7 Jun 2018 12:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C00860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeFGMur (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:50:47 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34777 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeFGMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:50:45 -0400
Received: by mail-qt0-f195.google.com with SMTP id d3-v6so9685084qto.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7nVqFb/XGkOYOFLq7NQuJ8H+Pvy2hn2RBflzl1QI8H4=;
        b=HQnYl+EJfOthUrEPxbzCD5dHAY+2IA0ItrQb0d4VkrK0PU56norwUd4siBmndRL7mi
         J6If6qUemhnOrrnby+LTD7wfrW7SaXqWbHanSZU2RTfiZOC5vaVKp/rQhY4B+ZPbeZpq
         s+wF2euOkV6dVGBaIrauAO07ZRzN03aaV9WlwD9NQSaw03T0c2Ni+69xR8suHThfseR9
         udaw1XIYi/2iliLCfwh7XPfT7HyOBknv63ysDMPZ6mYIS0/yY2shLmArqokZh4m08PVC
         LxkhZOGgOMl6HugazA6yndY8uUtPcJFyyykXgy6Omt6TdiThIb6k22Vdk51tYw1MY+Vn
         8gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7nVqFb/XGkOYOFLq7NQuJ8H+Pvy2hn2RBflzl1QI8H4=;
        b=TRdlnr5Gee+wR5BSG91UliQM+fqIfN4xKmtaYehKrHqayL9thYVEqhlKWfdklmiGML
         BN3haGGGxjGoiIf+x9cCiPKwvscR/fo9DlYcrUF1O7iwfUxr2/uQDC6JAaQGEdGT0KhW
         87nYU4mDKf+r8vxUiO5U4SE6ao0GaqSoAsEsFvO85hwVnM0ztqMER6LMgTzShC6Rsowl
         QBFrVxKjvZFJy7iib6MShVUqQoWV/Z9iz/iPO4uanb9yptkjHeTQT0PwLh/CJUbalN+0
         6mlmMLGr1rwDb0llb2rOmGEs3nicsCxPCnJCQdCq+UJbgF9DMCKHxXHleeQmEzC22hat
         Gu7g==
X-Gm-Message-State: APt69E0Go8IWr4UTzDB6UA9rTIdmyXPFgxTKnNmmO1pWhgJ+Wx4rTuIE
        IZYUBd3oyaXodg04VnsLje8t71s9mHxbVHi5OSo=
X-Google-Smtp-Source: ADUXVKKCZNWvTAOozEq/sh2dIYftFB/jh3h8IpGDcRp1Zvg3izfcOmZnMC+eKnlaFv0vX4McGY8wnkSPWMsXbP9NeSs=
X-Received: by 2002:ac8:70d8:: with SMTP id g24-v6mr1600633qtp.192.1528375845257;
 Thu, 07 Jun 2018 05:50:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4716:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 05:50:24 -0700 (PDT)
In-Reply-To: <20180606201556.GA10832@ziepe.ca>
References: <20180606201556.GA10832@ziepe.ca>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 7 Jun 2018 14:50:24 +0200
Message-ID: <CANiq72nSQyAxK7JF62CgQEERg3XhxsECWj-E14HU8fwZ8U0ROg@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Set IndentWrappedFunctionNames false
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 10:15 PM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> The true option causes this indenting for functions:
>
> static struct something_very_very_long *
>     function(void *arg)
> {
>
> While a quick survey suggests that the usual Linux fallback is the GNU
> style:
>
> static struct something_very_very_long *
> function(void *arg)
> {
>
> Eg as seen in:
>
>  kernel/cpu.c
>  kernel/fork.c
>
> and other places.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  .clang-format | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks for making this Miguel!

You're welcome! It is great to see people already using it. :-)

>
> I've been using clang-format for years with the kernel and noticed it
> was performing just a little different than I would have expected.
>
> AFAIK the above describes the more common choice in the code base?

Could be -- I took a look at several places and to the official
guidelines; but I am sure I may have missed some things :-) For some
options where I was unsure, I ran it through several "popular"/common
folders and see which one generated a smaller git diff -- maybe you
can try that and see what you get (also, it would be great if you can
try some others outside kernel/*).

>
> Not sure who's tree this is supposed to go through.. Andrew I guess?

It went through Andre the first time. In any case, I think it is fine
to send it through any one.

Cheers,
Miguel

>
> diff --git a/.clang-format b/.clang-format
> index faffc0d5af4eeb..1d5da22e0ba50c 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -382,7 +382,7 @@ IncludeIsMainRegex: '(Test)?$'
>  IndentCaseLabels: false
>  #IndentPPDirectives: None # Unknown to clang-format-5.0
>  IndentWidth: 8
> -IndentWrappedFunctionNames: true
> +IndentWrappedFunctionNames: false
>  JavaScriptQuotes: Leave
>  JavaScriptWrapImports: true
>  KeepEmptyLinesAtTheStartOfBlocks: false
> --
> 2.17.0
>
