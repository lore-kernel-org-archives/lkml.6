Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956EAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B90D25DD9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FvU+rrN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B90D25DD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbeFYQJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:09:48 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41546 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeFYQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:09:46 -0400
Received: by mail-io0-f194.google.com with SMTP id k16-v6so10297812ioa.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lGePXrYEQ4ssdPntpWYzsmI0f0eBEUy9LOwwTZljdVM=;
        b=FvU+rrN+FawQNrSOYiuObL2WpWyCTydq+yV6izGb0QsX1zrbtQKxrcmXXwpDB7EtOb
         qMDTUX38UtpL0P8pfLLDnYFD75Rl1lreLVk+OkzFOZFCh31V4aMDPOmIv7Hx6+dVsk4u
         TMMzecXgFO2xdgavBYsm427/bhpB77aYKA+QMyFin1Wk9SjzBkHBFRyvoA1m0paO5CIA
         6ljuFjTs/CuPk5rEQ81FUxMPkDrjj/U8+s1+DSFl94lXiddX3+biVrwDW9yyc4v2a2AA
         /vHaycn04tc6NaGB1OJyYuSltbBi2fI0A/Fh1jq/sQwVcFCIjZhoK4yiff2tIE0ZIgRg
         s+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lGePXrYEQ4ssdPntpWYzsmI0f0eBEUy9LOwwTZljdVM=;
        b=jF3ipflZrTGwaq7eMru4BWfqDGD0d9IMPwEOO1cm6JQN/YqZpGV+hqpbHxY1seEFBP
         ZNgQV7T5HeBAT45iBcJs979m2TZ3/3NftIjiXnR3fZfOXn+c2eSAlX/ajXTOLk1tapkq
         Of0GWwti2ecVsWy72FIJ1MLZwfGhfuMQFJ2soDsCVq6pD/xoIuD19VsyMI8eAG8alKqG
         W/LY1Bu8XkARdFLhSgPL74KDZLLpFSKLD9Y+IGem4JbToB3VtTSpkcV2nQqV2eypNdcM
         NCmULxWXI5Wfq3KKIr4tvOCRWuK9TL7bqpFjKmSD0RDvH7eWkJjNsiG2tQW+n5Owe9P/
         UQHQ==
X-Gm-Message-State: APt69E2csYo0k7hKXh+yE1sVA2/nkSXrqptgZ6DFMsbO+L44lORIERTk
        5jUuAUhl4je3Zh7xKrUBcKMaxu2+3rmv7oxTsBI+dQ==
X-Google-Smtp-Source: AAOMgpeXI+EWm7ajlfxIlcf8WgIMTVf5PkMjt65ttiCrimLxD9Ks3HcBmvOWPIoFdy9xWgbARfxS+WF24plFFvncOYw=
X-Received: by 2002:a6b:6515:: with SMTP id z21-v6mr4883271iob.258.1529942986232;
 Mon, 25 Jun 2018 09:09:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 09:09:45
 -0700 (PDT)
In-Reply-To: <c8d28664-e0fb-5a02-3c5b-b78684f87648@lechnology.com>
References: <20180625152920.11549-1-brgl@bgdev.pl> <20180625152920.11549-2-brgl@bgdev.pl>
 <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com> <CAMRc=MdTdoL9qsrMAxhCTaQM7HGrAPpTVjDuHQ81Q5O-QMNcYQ@mail.gmail.com>
 <c8d28664-e0fb-5a02-3c5b-b78684f87648@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 25 Jun 2018 18:09:45 +0200
Message-ID: <CAMRc=MdsTAz7rd6W0M8gcmY0-PfNY9RGW6hxrfhECecbkm2E1g@mail.gmail.com>
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

Right, I'll check that too.

Thanks,
Bart
