Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A6AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6598520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWhndZSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6598520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeKFAJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:09:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43943 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKFAJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:09:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id j202-v6so7635331oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iNOzczXvG5jmLP4rTNcXo8UKLDct2fQ31X/kaS317Y=;
        b=lWhndZSFFZB7YIbZDhaOoUz/V7AebaD2ATwpuAjnUsjOG9ehKVdOV2CfSclFSrqC41
         WI3I8Otl5BTXIQ2bhFouAXeTwfcsbuaZsHYHL5h4QfW7B6ZWFx/bxIDRp7ZCoVxaJoT2
         iMdlMArSZNffSnlu+lYYJocXAh4G2fg8MQ2D0plEJyfFLudJ8+M/AtsL0zl+y1jCdKs/
         U/2FXioxM/Y04EKWnveO6+L2Fe2dFcD5PMTOsg8gxNVT7uNLU7Xnv+9RzKzR/Do9Ttmo
         wIi1RZ46s2Uu4njgkPSuZ+vmWQHs2LgK8Mm6OsUVFTyEpvbQPI03YAEtPsazV/nvUDJV
         +WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iNOzczXvG5jmLP4rTNcXo8UKLDct2fQ31X/kaS317Y=;
        b=pH//S9o14mec7Mp0QHGwflmc87rtgDV/isF3yQuswVc5WWGN19r14TmM+xx95pVU4K
         ixsQyt0/icjXnAWSkz+FV+E0tIruKCrloG2gj3AbTLlwXbUShSQZmBkWRytOKmBNtmxl
         2TMXidMCLzFU9It7I7PLLerPRylJ/FXaHEuVnZU2ZpcMFoRB3H0dTXKn2vfD2zExkINe
         rznafvmsohwYfAR1Qzq3OX9o9/p5IyJRBjKeZbrrU75LRuBxr4Xu/sg2EvJZJkHF5GUA
         gsWEg9pUvfVMOjSJeIZfP7EFSabKQif//OthcCSL24hZE5dItShuy+mTUapTvYh89fYf
         ZcNg==
X-Gm-Message-State: AGRZ1gInFXu8dhTMw2r/mG1IK3wGFqMz1AL50Yz6shEOLQd8bRkB9ojY
        s/q8BQ0ZxIHHar4T2deWOmkoVWLqTAEwhJhhBKs=
X-Google-Smtp-Source: AJdET5c2tFA/4meyjXHnmmySDFRY1gQN5Cl0ubn3ytiobv87PoyXP9X9IhsnZYRtQC3qfTFn7kFXTm2ZJzEUk55S6BI=
X-Received: by 2002:a54:458c:: with SMTP id z12-v6mr13181335oib.297.1541429391299;
 Mon, 05 Nov 2018 06:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20181024142456.10084-1-svendev@arcx.com> <20181025091836.GV10650@smile.fi.intel.com>
In-Reply-To: <20181025091836.GV10650@smile.fi.intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 5 Nov 2018 09:49:40 -0500
Message-ID: <CAGngYiUZ851Mm8Ja8y2Z9QdPLqgi1fkGrgdSjphC4tJ4X7g9Ow@mail.gmail.com>
Subject: Re: [PATCH anybus v1 0/4] Support HMS Profinet Card over Anybus
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your feedback, I appreciate it !

On Thu, Oct 25, 2018 at 5:19 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

>
> I highly recommend to look at my recent (for few month?) reviews -- they are
> almost repeating each other.
>
> Also check what we have under lib/ (hint: read linux/kernel.h for inline and
> exported function helpers).

Would you be able, in a few words, to describe which of your reviews I
should concentrate on? Or which /lib files are of interest?
I've looked through your reviews and in the /lib directory, but other
than refcount_t, nothing jumped out at me.
