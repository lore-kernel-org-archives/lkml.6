Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9C32082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzOvnDRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9C32082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeH3Pxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:53:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:47075 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbeH3Pxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:53:36 -0400
Received: by mail-io0-f193.google.com with SMTP id y12-v6so7262527ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5pBDA/Dz9Nmkdo1SviRPEhr2NHh7W/N4XWzXx80zYUk=;
        b=FzOvnDRysuGY2/rikwJTCBNHzRoIYjIavShCW1qhSniAZyqwGIeRukBdL3UkBYpLuv
         Ttn9BjM0dy9XwBtg+SLKgRi4w3pZl/O5IBAO+LmFu+1bpR6kD96CqAtqX4Cr5n4RygkZ
         DtD/c4Xyx5jpJAWPVdMdnIXgjo/cBVGxMbMSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5pBDA/Dz9Nmkdo1SviRPEhr2NHh7W/N4XWzXx80zYUk=;
        b=KgC/9XC0BltMhTeq86QDR5GgMaLmnKL3uPzDzkIOObkGWpm5obsokOv7Q0j4l4ceSC
         B+CH+ZCC253kXsuSTlp/0F2LffD+5jsZnu9/jeEGqs8PDJfzboI1JMR9EhJvs/rM3lT9
         k0dWFifVGmsaB5lXOP/FRypATqXjxn60tdyqR7hbEnhoj2cqrJ9Hgmy+IpAgJy9Xyyi+
         CvdTHwTTZFRZntizglYtMb92HM/UK84cfnLGXZdtqFm0V//+ZZddwuWudMThsommUt6v
         LwI3SktFhGVEZT9VvVkkDm/xYu0z4LYvXvy33W2iW82bvmEK/fBPG9ddM+YhlH3UEnml
         cKAQ==
X-Gm-Message-State: APzg51B+cnPmRedb2CDNd3Js3jyetJCsOnQIybAC9m5yTVN/MOvdDaIr
        xpnVck5bqNtAaxsuZw4wOJtSCb3LeL0PyMY/OMuapg==
X-Google-Smtp-Source: ANB0VdZSaZdQfvTeYlOM3lWFI10L/O5nNzlxCeBzjECXpkdXKtJc2i1oOLJOp26OGchI0JT+tYnMn+MqWrPy1/bha34=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr8532534iou.218.1535629910076;
 Thu, 30 Aug 2018 04:51:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 04:51:49
 -0700 (PDT)
In-Reply-To: <20180829084913.fgdrigpeu3vi7vqs@ninjato>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com> <20180829084913.fgdrigpeu3vi7vqs@ninjato>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Aug 2018 13:51:49 +0200
Message-ID: <CAPDyKFq6wX9jP0c5688fWVAmnZja9OZXbECwoKbKBXuM2r5cbg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mmc: tmio: refactor CLK_CTL bit calculation
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 August 2018 at 10:49, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> +     if (divisor <= 1) {
>> +             clk_sel = 1;
>> +             clk = 0;
>> +     } else {
>> +             clk_sel = 0;
>> +             /* bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/2 */
>> +             clk = roundup_pow_of_two(divisor) >> 2;
>> +     }
>
> What about
>
>         clk_sel = (divisor <= 1);
>         clk = clk_sel ? 0 : (roundup_pow_of_two(divisor) >> 2)
>
> More concise, but I think still readable. I don't mind super much,
> though.

Right. So, may I apply Yamada-san's original patch (adding your
tested/reviewed-by tag) and the above as a code-cleanup for you to
address on top?

Kind regards
Uffe
