Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91840266D3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gYCo3J+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91840266D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932814AbeFZI1Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:27:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41661 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbeFZI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:27:22 -0400
Received: by mail-io0-f196.google.com with SMTP id k16-v6so12395137ioa.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BIJcebHsDqfdi2LXM6kPYp6IdvPn5oZ7MhO6RpWFR0Y=;
        b=gYCo3J+De0Pg1FoYdhgM67v0lttusTzNmevL5cdNrplrJ58cd8Tfs3X54ktTao3CZx
         dgW9CeoJFvsQUx38AmiLsYtYBvwRK+DWpGuF/XpoBvfqsdCu0w6urdC9Jtxh1VcaG0zU
         g9+gXtHBBrKw2cVnMPnd4OrIAQPowzkC3RHbRicYLrhjH0UonFWVw7++TJbI1Q941O1y
         t6suwavH+sRPz89CGRAlOTkMcB/tZQEOn6VHE2LfPfXdI1yJglTcoze2UkmE5uQMi7jp
         fD3U+VvOoqhmdE8wDFwMpJClFRCbLnKmnwiHc2Gz4KpodD8TayJkojdq4H4qo3N7OVwh
         qC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BIJcebHsDqfdi2LXM6kPYp6IdvPn5oZ7MhO6RpWFR0Y=;
        b=tcYgE7osni2T/hHuiYf4vVBXOs/wZmO4Kgy83YWKlV8ViIPFxQsW8lbgSarOTUMp60
         gbGW3rMZtYloVDXQVULeER5tlojWvoZD/C38xOHN2lEu/yLjD48SGzOJ0bXDer/dLfKG
         sltuyqhJR+kgklav8JHutrY7sFMMgal0o9EexMbPbIbpQ7w2dSb69qlkm1AlvKR8JBXQ
         uMRBzvaIIfW0opes5pW1+8YshWQCv9IwEJtTfHIOPDxwoJJqCT6CUdEVYxAGliSBaUu8
         XfdIq9/ugu6qa83Jafhn2yf0+PGhDL7w8QnQem/NtyHLbbk0A3mU9konG9F4myRERSrt
         BJ2w==
X-Gm-Message-State: APt69E2aWI0nBEBvWmcQ7djuJ0Q07FzRAKr51SxpjGNZ0PHPk1EKE70e
        djWBHygSRT7nUFclqMF0AHons5hQg2SznILm/cMC+A==
X-Google-Smtp-Source: AAOMgpfmdLKG4SjJPdpHI50H9KMrXG5OGGMCN3u4kP0A1GbDTonTHubzSvHWszjubr12oeceYrne6hya/LiL7Oxy+eU=
X-Received: by 2002:a6b:c855:: with SMTP id y82-v6mr409772iof.187.1530001641806;
 Tue, 26 Jun 2018 01:27:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 01:27:21
 -0700 (PDT)
In-Reply-To: <c8d28664-e0fb-5a02-3c5b-b78684f87648@lechnology.com>
References: <20180625152920.11549-1-brgl@bgdev.pl> <20180625152920.11549-2-brgl@bgdev.pl>
 <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com> <CAMRc=MdTdoL9qsrMAxhCTaQM7HGrAPpTVjDuHQ81Q5O-QMNcYQ@mail.gmail.com>
 <c8d28664-e0fb-5a02-3c5b-b78684f87648@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Jun 2018 10:27:21 +0200
Message-ID: <CAMRc=MfDmQxiy+jX4kW1A8vvP4xVXjKDo8VpgRZ-2AsTNik-0A@mail.gmail.com>
Subject: Re: [PATCH 1/9] clk: davinci: psc-dm365: use two lookup entries for
 the aemif clock
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-25 18:06 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/25/2018 11:01 AM, Bartosz Golaszewski wrote:
>>
>> 2018-06-25 17:53 GMT+02:00 David Lechner <david@lechnology.com>:
>>>
>>> On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
>>>>
>>>>
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> We want to be able to get the clock both from the board file by its
>>>> con_id and from the aemif driver by dev_id.
>>>
>>>
>>>
>>> What about the other SoCs? Don't they need this change as well?
>>>
>>
>> So I double checked and turns out I missed one other board that's
>> affected by this series and calls clk_get() from machine code:
>> dm644x-evm.
>>
>> I'll fix it in v2.
>
>
> The ti-aemif platform driver also does clk_get(). Don't you need
> lookups to make that work as well? For example, DA830 doesn't have
> a clock lookup for aemif at all.
>

This seems like a bug: in arch/arm/mach-davinci/aemif.c in current
mainline we do call clk_get() for 'aemif' and it's called indirectly
from board-da830-evm.c via davinci_aemif_setup().

I'll address this too in v2.

Bart
