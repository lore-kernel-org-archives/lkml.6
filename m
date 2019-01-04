Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B4CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DBD2070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdVOXDvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfADFNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:13:16 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40174 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfADFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:13:16 -0500
Received: by mail-io1-f66.google.com with SMTP id k2so6140142iog.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 21:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJ2dWvAZd/j8GEN5ilzz4Y3VeLyFvf8wQ3f62J8BmXY=;
        b=EdVOXDvvPQVK2SUCY2OPKbnukYgilg3mJABHRTDu7rY9zgvWzBCbxDMcmTmdcR8T3+
         J65uhzyg84dOHNqhAZiQTwxYVTLU7g2txtkHxgqZndKQpZ8z9gNt+gqne6OtlbGN7AP1
         RntvzBNXj1h0jFL/EYQF/dtmD4o4DhMQA2nZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJ2dWvAZd/j8GEN5ilzz4Y3VeLyFvf8wQ3f62J8BmXY=;
        b=RVQk54wDkK2aF9MURrXXl9T+KiMB9RdUc/IEh89U5lNG/qK4qRIjzhywzvVDO0zUen
         3E46X+JDlj49CH9cCe3B1rV0gdseWj5p4qA3X0WAdv2Rx1MGBbEpvfAZcU7reZR61Fy1
         67L4fgSWtBe1V9PTI0aI5odTyd9Zeffp4JgJW8zjZhnteQDVC9ulJ7FX7HMCXQ5ZVhSB
         +OIOx6W+sXNmCNAop92enoOD6gyqVxcoXCzPywmgH3ED5FiAKG9zUV7Abb1BvBICysA+
         kSGqQfIwYCApmt50WqcPGG+qNgImSN2xItPjqMxsKQ80hMoSH2oZRRC1v5wLlXWWv1+5
         QPzA==
X-Gm-Message-State: AJcUukcSOfjKP+1iymVp/pEqdHf4OUD8RfOOLGtZB/bcTiGX0m8eb7iR
        adPLEYsSwI2glQSTm8ynJ8xCtYK0psT1tqtdhY7KKw==
X-Google-Smtp-Source: ALg8bN4TMXdIS6rjVGsr70Bmxx0JzEyg3BCcmqSt3aFWAwKDf/PZPYxyGKz83Fx/IZm6kO/Jzz8UJSDfApRSWZwHCEc=
X-Received: by 2002:a6b:8f8d:: with SMTP id r135mr35229193iod.5.1546578795486;
 Thu, 03 Jan 2019 21:13:15 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-3-git-send-email-firoz.khan@linaro.org> <CAMo8Bf+qK=k33boeNOeL69sLC3e-M07QK9ErhYm-byuQ2UnVnw@mail.gmail.com>
In-Reply-To: <CAMo8Bf+qK=k33boeNOeL69sLC3e-M07QK9ErhYm-byuQ2UnVnw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 4 Jan 2019 10:43:04 +0530
Message-ID: <CALxhOnhgAEeEFhL2fgjDSCBMJo7dF5jiuGKCXjWYjMJmHefMgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] xtensa: generate uapi header and syscall table header files
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

Thanks for your feedback.

On Fri, 4 Jan 2019 at 04:14, Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > +quiet_cmd_sysnr = SYSNR  $@
> > +      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'         \
> > +                 '$(sysnr_abis_$(basetarget))'                 \
> > +                 '$(sysnr_pfx_$(basetarget))'                  \
> > +                 '$(sysnr_offset_$(basetarget))'
> > +
>
> This patch seems to do more than it says in the description.
> Perhaps adding cmd_sysnr needs a separate patch with its
> own description?

This build rule is unused now as I was tried to implement
something else. Hopefully I'll remove the the above change
in my v2.

Thanks
Firoz
