Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332F8214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFekkP2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332F8214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJJPwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:52:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35377 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJJPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:52:40 -0400
Received: by mail-it1-f196.google.com with SMTP id p64-v6so6814097itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmSZEaRV1T3eXbgC0D6JgFUlnszILPSLsr3Cbuaq2h0=;
        b=WFekkP2pbPUevZBvKpFWaarT0zIuVePV9aa2JwosDIU3095darMsb8C5hof4w6jJxk
         F95Uc54gIjgaxcAJ8KzMsiC5dY4YQ+5O0dfudSiVP77utuUu2pUchxVPZ9sxaITKLfNV
         3AyWW4/cDKROylvIkDCSeRRPeYunMlGOG0j1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmSZEaRV1T3eXbgC0D6JgFUlnszILPSLsr3Cbuaq2h0=;
        b=rELeZ/K14gGKR6THhphwadKIz4R9SIG8NF1fdVMZWqYRRYUzAmoxgBYR+bd70/MARP
         2y+UyOBVYj87XFuvpzQAabyOI32EYR7ZhVjy2nAMVVymbwK8QPeXiE3Lbw6gI0Pr31J7
         SvDUwfbDUbYXeXoj38WIh11wUfeVH6eYWp5FLuLc98n/iB+prj+ObCFTSFtkIKSs1ufh
         qUr7LcS2zAbm4YJl22sh/PmyudIyl8C+uBFIYHoUJQRfmJhJGZ8tC0NWiP4ALE6hY86U
         f6qoDW6QeY8TJwkuyqLa5ZvTnU39YcXgNCVSqNJccbIJdL+DhRyYzwU3FAKzk3iDHM+s
         50Vw==
X-Gm-Message-State: ABuFfog1BPqbig5y+jXxkg1o6ZVc8yepKvlLD7f1aPzcM43G80FdOJvf
        iFDNNCViJdUMax+NXc3EveNZfb/15qssaY5woVNpJg==
X-Google-Smtp-Source: ACcGV60DQaj5jPGPEDSoC2KG0Jq9PEO/6pan2LhWpwM3u26JKmvaxxIhqvWEqZ6c0I9jV8NUpEytL2EbaR5sojZVoT0=
X-Received: by 2002:a24:e0c8:: with SMTP id c191-v6mr7331ith.156.1539160295206;
 Wed, 10 Oct 2018 01:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com> <20181005065300.22882-3-ricardo.ribalda@gmail.com>
In-Reply-To: <20181005065300.22882-3-ricardo.ribalda@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 10:31:23 +0200
Message-ID: <CACRpkdYhXcHXSkP2DMb0hRFHnZa_iTvf8FiWiX8-fZXY95Lweg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     jhugo@codeaurora.org, timur@kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 8:53 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> Current code assumes that the direction is input if direction_input
> function is set.
> This might not be the case on GPIOs with programmable direction.
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Patch applied with the collected ACKs.

Thanks for working so hard on fixing this up.

Yours,
Linus Walleij
