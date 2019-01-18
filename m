Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42810C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE2620855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfARILF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:11:05 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41950 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfARILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:11:05 -0500
Received: by mail-vs1-f67.google.com with SMTP id t17so7905439vsc.8;
        Fri, 18 Jan 2019 00:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoxm7V0jSf/tbVbH3zjkoV0175u7GUKmn0S24E5HAlM=;
        b=CQ2Ov6PAnMO46TLOGqAiFIV0ZNWY0FQNDw4L9GFimPeH39pOwD56rAFU0OWrab5Fdo
         EAVOyOnu1NGbXdQhAQzjCfOU5Xfm6xc/U0HUTCI9XFF9v6uOS2wqcLf/9tuBudImUjur
         2Ynl7cboK1CzbalN9XleACDfUwimtrE+IJRLzrqswgI8it6vDOP/0JS5AC7378Uh3eNv
         ISuw2dRI5vmYBF2t4Ua4jrQsVQg6b+Fm+5KMaUrWhGX1ITj/4CCl/mHrhROvzgQDrac7
         eW/vmU9L4n69NLhNKHAOAQpp/5ETJid3mgCZWNVnjsv+qLf0Mcsbzw6mdjdOIvO5IBQz
         AexQ==
X-Gm-Message-State: AJcUukeZl8ZJN39YKVijm26De0ecMAAZLJP4QxjA13yLva7BftU1IDRa
        AtqwFZjkfUCdgith3sOZBUI0d+i88zXrEjjDUig=
X-Google-Smtp-Source: ALg8bN5YG4c4l4Y5nJxIGKIeaQqieiEo95cOcLAb+jsjGEhQ9PrbIpJDMOt838miBqan+e54NsT7x9qF0emq2OxgWmY=
X-Received: by 2002:a67:f43:: with SMTP id 64mr7303685vsp.166.1547799064061;
 Fri, 18 Jan 2019 00:11:04 -0800 (PST)
MIME-Version: 1.0
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com> <dc043bfe-7a56-9810-1e5e-802f8b6beee2@gmail.com>
In-Reply-To: <dc043bfe-7a56-9810-1e5e-802f8b6beee2@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Jan 2019 09:10:52 +0100
Message-ID: <CAMuHMdWwvY=4NgoJmjfpOnetNwxPWqCsH-k-y5FqrbRif_PB7g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, Jan 18, 2019 at 9:08 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 1/18/19 9:03 AM, Geert Uytterhoeven wrote:
> > On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

> >> +Example:
> >> +
> >> +       rpc: rpc@ee200000 {
> >> +               compatible = "renesas,rcar-gen3-rpc";
> >
> > compatible = "renesas,r8a7795-rpc," renesas,rcar-gen3-rpc";
>
> Without the extra comma after r8a7795-rpc, of course ;-)

Let's move it after the closing double quotes. Would that be OK for you? ^-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
