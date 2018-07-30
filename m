Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9896C13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C38620873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsWikqKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C38620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeG3KNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:13:02 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45851 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeG3KNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:13:02 -0400
Received: by mail-ua0-f195.google.com with SMTP id k8-v6so7288840uaq.12;
        Mon, 30 Jul 2018 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P2gVVxdURswQxw31PkBYCbFdJWB7vxW0RRFSuek+10w=;
        b=gsWikqKH5IX4C+WN1I9L9FSy42A4XL6SJW5GgkTbILiM8jgGqsSyfe8kuBZr6Lhd3I
         Egl1Rm2brZNGItaZMZZq2/aIaCZeBfpE7Bdy7bJNZDLc8fCvZt1U8iToM7rCqGG/JPcK
         yzL9ZWD7glZ2mxyjRigoLP3dssfJi+rdSviFEnPQ9PsjjfhK2DyyjnNxnhHRRDR/iSqj
         tD/STeHVcM8fgUsr9vSUkaVf21Fc9Zpb+SrhoMiR15Ym/qy74fdvEA9AkNGcJ5Z+peZB
         XUBHlJSKml+aILvcKK+9VsDAqWTescQbEu3E3nRqP83iRN46T35RyLOWrxk5xlb9ceeS
         lrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P2gVVxdURswQxw31PkBYCbFdJWB7vxW0RRFSuek+10w=;
        b=PzAjMuvHAKz7yC8wJlKvwBxM7xhGPEBrGxyetOrn5NQPLplOOQNQNqxMpouWHL+p2D
         ZqB3QqFTCUV4zZn+mH+kfHJ9ndSFK6pizaw1X6OIPDK75HVdk8voko56VK9gkScriwrH
         2ooNXT8nCzIGz9JY3zRf9dpTAULTblI006+3jEoTn0M9hrLmA7ojK9ed27Yj3iOtsxId
         QdJ05QvGMZNWYwpuV2ECjx8g+VcaUSmMXhldDG+LziiGAcw47/QZsQ0yd6gXqb9o7gN3
         pFJ42m+p8lUB8BSztyOwSaORDmDmiMjRSoGAE0uYmva90JQC3iWU/qc/AiR7dQIEo1+D
         hqMw==
X-Gm-Message-State: AOUpUlE6o0GQImeKL+XGL7swk36sHJQYpnJSssh1azgcfSiZctis1KJC
        kMV4CxgUC5J/13su77L8JFNAHZWCaaGgqawMKzQ=
X-Google-Smtp-Source: AAOMgpeagnqbY+Is5Itedm3EpIn9FWVlilKcGH+081nWgRhVD3GZR4yH5z22In1ErmrK/BN3Uaqy6RP1r/a+LatBCMw=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr11240659ual.141.1532939947824;
 Mon, 30 Jul 2018 01:39:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 01:39:07
 -0700 (PDT)
In-Reply-To: <002901d427c6$6b9a4ff0$42ceefd0$@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
 <1532624495.2283.197.camel@impinj.com> <002901d427c6$6b9a4ff0$42ceefd0$@socionext.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Jul 2018 11:39:07 +0300
Message-ID: <CAHp75VdrpOkonozNRUCzchsNHbgV=djecVDr0-fRiYAa4iDE0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        =?UTF-8?B?SGF5YXNoaSwgS3VuaWhpa28v5p6XIOmCpuW9pg==?= 
        <hayashi.kunihiko@socionext.com>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        =?UTF-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= 
        <yamada.masahiro@socionext.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 8:30 AM, Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:
> Hello Trent and Andy,

>> > > +       ckrat = roundup(ckrat, 2);
>> >
>> > ckrat += ckrat & 1;
>>
>> Either way, the compiler produces the same code:
>>
>>  add r0, r0, #1
>>  bic r0, r0, #1
>>
>> I.e., ckrat = (ckrat + 1) & ~1, one "add" and one "and".
>>
>> Might as well use the macro so it's clear. There is also round_up(x,y), which I believe is intended to be used
>> only with power of 2 values of y.
>
> I confirmed round_up() macro.
> This macro is optimized to power of 2 argument,
> and it matches to this case and clear.
>
> I will replace to round_up() macro.

Good!


-- 
With Best Regards,
Andy Shevchenko
