Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05012150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er9aRegw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05012150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbeIUMJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:09:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44154 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389203AbeIUMJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:09:42 -0400
Received: by mail-io1-f68.google.com with SMTP id u12-v6so6080263ioc.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 23:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqD6tvziAHO4l+uho2tSoyVA5WboBKE5p4GmgLjNAdM=;
        b=Er9aRegwUvS+mkXe4g/rO/RkBw+6vt4JxpVui4fb42e6aDwn191HqTW4zOX77zH7cH
         sL0UF/0/b/dhPQwgwcEwRAJ/0wd8bz+4EekiP60y21mhZyhXR7heAzOMUeKStzMuXo0j
         5dXBGGZ3DdxbDEXESlFtb7bXzgHAZpGK+G9avGlcptA+fzs8g8ngNKzU2VMdcgHbyxYH
         cRSevpZC8P+eWd9PaGTXzEHjHLMT7CcUpkxs62qiWwpoIBtHzQiwQfzt75rtOhajX95i
         K6kfxr3fhKVsqURdgDH3VTp1AKtfBPMmXONO5w95QOAxib0IKiEdMZeto6SJshAwTbu8
         /jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqD6tvziAHO4l+uho2tSoyVA5WboBKE5p4GmgLjNAdM=;
        b=mr+bdQw/9zLEdNVAZWE8paQM11o4xqaBIfAiYl0KFQm7Cs2MUT1V2SWHRLZbAIzfU4
         2fvbgjAMu35fUtvoLKcyRu1E3gWeuEcd6NlRVxI2j+BBHTLGbXeerebNsyb5I4d5JNTg
         kFLpTZmAz4LFJyMFFYyKMn1lGdFTOjTads4Y/UHiNOIslBZUjjPZ890dMwxYkmpRAcv8
         KypC270/PKUz8qbp8SRu6JQAW8u3d4x7H05ImJpCTmGLP18ZQf0ls9rKfQnHDlXSJrmD
         qH3AWVmfCBcyKpIcUBx7GkzkxPns0Ya5fIHmGF00nGylPQhir2fmNIiPVAkmPyCiovTe
         AyqQ==
X-Gm-Message-State: APzg51BFrcjXV8LXR76iNp7V+KYryOit7dfSgWMkv8JF+iORfHpmOdKP
        +hxAcswkx/n3O8gFt5hGdZtH09Kf60TgOt6VwOA=
X-Google-Smtp-Source: ANB0VdaM5g1afACD9//W+jpFczZdXXmgjjmsM0njIiYIecRU0C3R5IMx3H4SEVo2daNmgmv1I1x/rbQ8XwTBv0m4qrA=
X-Received: by 2002:a6b:bf86:: with SMTP id p128-v6mr34925935iof.156.1537510940189;
 Thu, 20 Sep 2018 23:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180919221331.2511558-1-taoren@fb.com> <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
 <84F9ED20-0964-462E-B389-39B107A232D3@fb.com> <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
In-Reply-To: <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
From:   Lei YU <mine260309@gmail.com>
Date:   Fri, 21 Sep 2018 14:22:01 +0800
Message-ID: <CAARXrtmpUn3DKguiQSubZvCM3sJ--QxtzoYVoEvC-81udH7BLA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
To:     Joel Stanley <joel@jms.id.au>
Cc:     taoren@fb.com, cov@fb.com, Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        daniel.lezcano@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Make sense. I actually booted up kernel on qemu-palmetto (ast2400) but I'm doubting if test is valid because it depends on how qemu emulates the hardware. It would be great if someone can help to verify the patch on physical ast2400.
>
> I gave this a spin on the ast2400. It looked okay, but I was wondering
> if you could share you test case so I can run the same test?

Tested on Palmetto (OpenPOWER P8 with AST2400), and it does show the fix is
working on AST2400 as well.
Without the patch, usleep(100) takes tens of milliseconds randomly;
With the patch, usleep(100) takes about 600~700 microseconds stably.

Tested-by: Lei YU <mine260309@gmail.com>
